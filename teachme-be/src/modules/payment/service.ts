import db from '../../lib/db';
import { notFound, forbidden, conflict } from '../../lib/errors';
import { env } from '../../config/env';

export interface PaymentProvider {
  createCharge(input: {
    orderId: string;
    amountIdr: number;
    bookingId: string;
  }): Promise<{ orderId: string; methods: string[]; reference: string }>;
  cancel(orderId: string): Promise<void>;
}

export class MockPaymentProvider implements PaymentProvider {
  async createCharge(input: {
    orderId: string;
    amountIdr: number;
    bookingId: string;
  }) {
    return {
      orderId: input.orderId,
      methods: ['bank_transfer', 'ewallet'],
      reference: `mock-ref-${input.orderId}`,
    };
  }

  async cancel(_orderId: string) {}
}

export function getProvider(): PaymentProvider {
  return new MockPaymentProvider();
}

export async function initiatePayment(
  studentUserId: string,
  bookingId: string,
) {
  const booking = await db.booking.findUnique({
    where: { id: bookingId },
    include: {
      payment: true,
      enrollment: { include: { student: true } },
    },
  });

  if (!booking) throw notFound('Booking not found');
  if (booking.enrollment.student.userId !== studentUserId) {
    throw forbidden('Not your booking');
  }

  if (booking.status !== 'ACCEPTED') {
    throw conflict('INVALID_STATUS', 'Booking must be accepted before payment');
  }

  if (!booking.payment) {
    throw notFound('Payment record not found');
  }

  const provider = getProvider();
  const charge = await provider.createCharge({
    orderId: booking.payment.orderId,
    amountIdr: booking.payment.amountIdr,
    bookingId,
  });

  const updated = await db.payment.update({
    where: { id: booking.payment.id },
    data: { status: 'PENDING' },
  });

  return {
    id: updated.id,
    orderId: updated.orderId,
    amountIdr: updated.amountIdr,
    status: updated.status,
    method: updated.method,
    methods: charge.methods,
    reference: charge.reference,
  };
}

export async function settlePayment(orderId: string) {
  const payment = await db.payment.findUnique({
    where: { orderId },
    include: {
      booking: {
        include: {
          enrollment: {
            include: {
              student: true,
              tutorSubject: { include: { tutor: true } },
            },
          },
        },
      },
    },
  });

  if (!payment) throw notFound('Payment not found');

  if (payment.status === 'SETTLED') return payment;

  if (payment.status !== 'CREATED' && payment.status !== 'PENDING') {
    throw conflict('INVALID_STATUS', `Cannot settle payment in ${payment.status} status`);
  }

  if (payment.amountIdr !== payment.booking.priceIdr) {
    throw conflict('AMOUNT_MISMATCH', 'Payment amount does not match booking price');
  }

  const now = new Date();

  const result = await db.$transaction(async (tx) => {
    const settled = await tx.payment.update({
      where: { id: payment.id },
      data: { status: 'SETTLED', settledAt: now },
    });

    await tx.booking.update({
      where: { id: payment.bookingId },
      data: { status: 'PAID' },
    });

    await tx.slot.update({
      where: { id: payment.booking.slotId },
      data: { status: 'BOOKED' },
    });

    await tx.bookingEvent.create({
      data: {
        bookingId: payment.bookingId,
        fromState: 'ACCEPTED',
        toState: 'PAID',
        actorId: null,
        meta: { orderId, provider: payment.provider },
      },
    });

    await tx.notification.create({
      data: {
        userId: payment.booking.enrollment.student.userId,
        type: 'PAYMENT_SETTLED',
        title: 'Payment Confirmed',
        body: 'Your payment has been confirmed. Your session is booked.',
        data: { bookingId: payment.bookingId },
      },
    });

    await tx.notification.create({
      data: {
        userId: payment.booking.enrollment.tutorSubject.tutor.userId,
        type: 'PAYMENT_SETTLED',
        title: 'Payment Received',
        body: 'Payment for a booking has been confirmed.',
        data: { bookingId: payment.bookingId },
      },
    });

    return settled;
  });

  return result;
}
