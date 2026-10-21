import { Prisma } from '@prisma/client';

export const bookingInclude = {
  slot: true,
  payment: true,
  enrollment: {
    include: {
      student: {
        include: { user: { select: { id: true, name: true } } },
      },
      tutorSubject: {
        include: {
          subject: true,
          tutor: {
            include: { user: { select: { id: true, name: true } } },
          },
        },
      },
    },
  },
} satisfies Prisma.BookingInclude;

export type BookingWithRelations = Prisma.BookingGetPayload<{
  include: typeof bookingInclude;
}>;

export interface SerializedBooking {
  id: string;
  status: string;
  priceIdr: number;
  feeIdr: number;
  note: string | null;
  rejectReason: string | null;
  respondBy: Date;
  payBy: Date | null;
  createdAt: Date;
  slot: {
    id: string;
    startsAt: Date;
    endsAt: Date;
    status: string;
  };
  tutor: { id: string; name: string } | null;
  student: { id: string; name: string } | null;
  subjectName: string | null;
  payment: {
    id: string;
    orderId: string;
    amountIdr: number;
    status: string;
    method: string | null;
    methods: string[] | null;
    reference: string | null;
  } | null;
}

export function serializeBooking(booking: BookingWithRelations): SerializedBooking {
  const { enrollment } = booking;
  const tutorSubject = enrollment.tutorSubject;

  return {
    id: booking.id,
    status: booking.status,
    priceIdr: booking.priceIdr,
    feeIdr: booking.feeIdr,
    note: booking.note,
    rejectReason: booking.rejectReason,
    respondBy: booking.respondBy,
    payBy: booking.payBy,
    createdAt: booking.createdAt,
    slot: {
      id: booking.slot.id,
      startsAt: booking.slot.startsAt,
      endsAt: booking.slot.endsAt,
      status: booking.slot.status,
    },
    tutor: tutorSubject?.tutor
      ? { id: tutorSubject.tutor.id, name: tutorSubject.tutor.user.name }
      : null,
    student: enrollment.student
      ? { id: enrollment.student.id, name: enrollment.student.user.name }
      : null,
    subjectName: tutorSubject?.subject?.name ?? null,
    payment: booking.payment
      ? {
          id: booking.payment.id,
          orderId: booking.payment.orderId,
          amountIdr: booking.payment.amountIdr,
          status: booking.payment.status,
          method: booking.payment.method,
          methods: null,
          reference: null,
        }
      : null,
  };
}