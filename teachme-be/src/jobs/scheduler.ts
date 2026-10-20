import cron from 'node-cron';
import db from '../lib/db';
import logger from '../lib/logger';
import { createNotification } from '../modules/notification/service';

async function expirePendingBookings() {
  const now = new Date();

  const pending = await db.booking.findMany({
    where: {
      status: 'PENDING',
      respondBy: { lt: now },
    },
    include: {
      enrollment: {
        include: {
          student: { include: { user: { select: { id: true } } } },
          tutorSubject: {
            include: {
              tutor: { include: { user: { select: { id: true } } } },
            },
          },
        },
      },
    },
  });

  for (const booking of pending) {
    await db.$transaction(async (tx) => {
      const fresh = await tx.booking.findUnique({
        where: { id: booking.id },
      });
      if (!fresh || fresh.status !== 'PENDING') return;

      await tx.booking.update({
        where: { id: booking.id },
        data: { status: 'EXPIRED' },
      });

      await tx.slot.update({
        where: { id: booking.slotId },
        data: { status: 'OPEN' },
      });

      await tx.bookingEvent.create({
        data: {
          bookingId: booking.id,
          fromState: 'PENDING',
          toState: 'EXPIRED',
          meta: { reason: 'respond_timeout' },
        },
      });
    });

    const studentUserId = booking.enrollment.student.user.id;
    const tutorUserId = booking.enrollment.tutorSubject.tutor.user.id;

    await createNotification(
      studentUserId,
      'BOOKING_EXPIRED',
      'Booking Expired',
      'Your booking request has expired because the tutor did not respond in time.',
      { bookingId: booking.id },
    );

    await createNotification(
      tutorUserId,
      'BOOKING_EXPIRED',
      'Booking Expired',
      'A booking request has expired because you did not respond in time.',
      { bookingId: booking.id },
    );
  }
}

async function expireUnpaidBookings() {
  const now = new Date();

  const unpaid = await db.booking.findMany({
    where: {
      status: 'ACCEPTED',
      payBy: { lt: now },
    },
    include: {
      payment: true,
      enrollment: {
        include: {
          student: { include: { user: { select: { id: true } } } },
          tutorSubject: {
            include: {
              tutor: { include: { user: { select: { id: true } } } },
            },
          },
        },
      },
    },
  });

  for (const booking of unpaid) {
    await db.$transaction(async (tx) => {
      const fresh = await tx.booking.findUnique({
        where: { id: booking.id },
      });
      if (!fresh || fresh.status !== 'ACCEPTED') return;

      await tx.booking.update({
        where: { id: booking.id },
        data: { status: 'EXPIRED' },
      });

      await tx.slot.update({
        where: { id: booking.slotId },
        data: { status: 'OPEN' },
      });

      if (booking.payment) {
        await tx.payment.update({
          where: { id: booking.payment.id },
          data: { status: 'EXPIRED' },
        });
      }

      await tx.bookingEvent.create({
        data: {
          bookingId: booking.id,
          fromState: 'ACCEPTED',
          toState: 'EXPIRED',
          meta: { reason: 'payment_timeout' },
        },
      });
    });

    const studentUserId = booking.enrollment.student.user.id;
    const tutorUserId = booking.enrollment.tutorSubject.tutor.user.id;

    await createNotification(
      studentUserId,
      'BOOKING_EXPIRED',
      'Booking Expired',
      'Your booking has expired due to payment timeout.',
      { bookingId: booking.id },
    );

    await createNotification(
      tutorUserId,
      'BOOKING_EXPIRED',
      'Booking Expired',
      'A booking has expired because the student did not pay in time.',
      { bookingId: booking.id },
    );
  }
}

async function sendGradeReminders() {
  const now = new Date();
  const oneHourAgo = new Date(now.getTime() - 60 * 60 * 1000);

  const bookings = await db.booking.findMany({
    where: {
      status: 'PAID',
      slot: { endsAt: { lt: oneHourAgo } },
      gradeReminderSentAt: null,
      progress: null,
    },
    include: {
      enrollment: {
        include: {
          tutorSubject: {
            include: {
              tutor: { include: { user: { select: { id: true } } } },
              subject: true,
            },
          },
          student: {
            include: { user: { select: { name: true } } },
          },
        },
      },
    },
  });

  for (const booking of bookings) {
    const tutorUserId = booking.enrollment.tutorSubject.tutor.user.id;

    await createNotification(
      tutorUserId,
      'GRADE_REMINDER',
      'Grade Reminder',
      `Please grade the session with ${booking.enrollment.student.user.name} for ${booking.enrollment.tutorSubject.subject.name}.`,
      { bookingId: booking.id },
    );

    await db.booking.update({
      where: { id: booking.id },
      data: { gradeReminderSentAt: now },
    });
  }
}

export function startScheduler() {
  logger.info('Starting job scheduler');

  cron.schedule('* * * * *', async () => {
    try {
      await expirePendingBookings();
    } catch (err) {
      logger.error({ err }, 'expirePendingBookings failed');
    }

    try {
      await expireUnpaidBookings();
    } catch (err) {
      logger.error({ err }, 'expireUnpaidBookings failed');
    }

    try {
      await sendGradeReminders();
    } catch (err) {
      logger.error({ err }, 'sendGradeReminders failed');
    }
  });
}
