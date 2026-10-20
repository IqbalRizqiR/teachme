import { BookingStatus, Prisma } from '@prisma/client';
import db from '../../lib/db';
import { notFound, forbidden, conflict } from '../../lib/errors';
import { env } from '../../config/env';
import { addDuration } from '../../lib/time';
import { assertTransition } from './state-machine';
import type {
  CreateBookingBody,
  GradeBody,
  ReviewBody,
  ListBookingsQuery,
} from './schemas';

export async function createBooking(
  studentUserId: string,
  input: CreateBookingBody,
) {
  const slot = await db.slot.findUnique({
    where: { id: input.slotId },
    include: { tutor: { include: { user: true } } },
  });

  if (!slot) throw notFound('Slot not found');
  if (slot.status !== 'OPEN') throw conflict('SLOT_UNAVAILABLE', 'Slot is not available');
  if (slot.startsAt <= new Date()) throw conflict('SLOT_UNAVAILABLE', 'Slot has already started');

  const tutorSubject = await db.tutorSubject.findUnique({
    where: { tutorId_subjectId: { tutorId: slot.tutorId, subjectId: input.subjectId } },
    include: { subject: true },
  });

  if (!tutorSubject) throw notFound('Tutor does not teach this subject');

  const studentProfile = await db.studentProfile.findUnique({
    where: { userId: studentUserId },
  });

  if (!studentProfile) throw notFound('Student profile not found');

  const priceIdr = tutorSubject.priceIdr;
  const feeIdr = Math.round(priceIdr * env.PLATFORM_FEE_PERCENT / 100);
  const now = new Date();

  const booking = await db.$transaction(async (tx) => {
    const claimed = await tx.slot.updateMany({
      where: { id: input.slotId, status: 'OPEN' },
      data: { status: 'HELD' },
    });

    if (claimed.count !== 1) throw conflict('SLOT_UNAVAILABLE', 'Slot is no longer available');

    const enrollment = await tx.enrollment.upsert({
      where: {
        studentId_tutorSubjectId: {
          studentId: studentProfile.id,
          tutorSubjectId: tutorSubject.id,
        },
      },
      create: {
        studentId: studentProfile.id,
        tutorSubjectId: tutorSubject.id,
      },
      update: {},
    });

    const created = await tx.booking.create({
      data: {
        enrollmentId: enrollment.id,
        slotId: input.slotId,
        status: 'PENDING',
        priceIdr,
        feeIdr,
        note: input.note,
        respondBy: addDuration(now, '24h'),
      },
      include: {
        slot: true,
        enrollment: {
          include: {
            tutorSubject: {
              include: { tutor: { include: { user: true } }, subject: true },
            },
          },
        },
      },
    });

    await tx.bookingEvent.create({
      data: {
        bookingId: created.id,
        fromState: null,
        toState: 'PENDING',
        actorId: studentUserId,
      },
    });

    await tx.notification.create({
      data: {
        userId: slot.tutor.userId,
        type: 'BOOKING_REQUESTED',
        title: 'New Booking Request',
        body: `You have a new booking request for ${tutorSubject.subject.name}`,
        data: { bookingId: created.id },
      },
    });

    return created;
  });

  return booking;
}

export async function acceptBooking(tutorUserId: string, bookingId: string) {
  const booking = await db.booking.findUnique({
    where: { id: bookingId },
    include: {
      enrollment: {
        include: {
          tutorSubject: { include: { tutor: { include: { user: true } } } },
          student: true,
        },
      },
    },
  });

  if (!booking) throw notFound('Booking not found');
  if (booking.enrollment.tutorSubject.tutor.userId !== tutorUserId) {
    throw forbidden('Not your booking');
  }

  assertTransition(booking.status, 'ACCEPTED');

  if (new Date() > booking.respondBy) {
    throw conflict('RESPOND_EXPIRED', 'Response deadline has passed');
  }

  const now = new Date();

  const updated = await db.$transaction(async (tx) => {
    const result = await tx.booking.update({
      where: { id: bookingId },
      data: {
        status: 'ACCEPTED',
        payBy: addDuration(now, '2h'),
      },
    });

    await tx.payment.create({
      data: {
        bookingId,
        provider: env.PAYMENT_PROVIDER,
        orderId: `TM-${bookingId}`,
        amountIdr: booking.priceIdr,
        status: 'CREATED',
      },
    });

    await tx.bookingEvent.create({
      data: {
        bookingId,
        fromState: 'PENDING',
        toState: 'ACCEPTED',
        actorId: tutorUserId,
      },
    });

    await tx.notification.create({
      data: {
        userId: booking.enrollment.student.userId,
        type: 'BOOKING_ACCEPTED',
        title: 'Booking Accepted',
        body: 'Your booking has been accepted. Please proceed with payment.',
        data: { bookingId },
      },
    });

    return result;
  });

  return updated;
}

export async function rejectBooking(
  tutorUserId: string,
  bookingId: string,
  reason?: string,
) {
  const booking = await db.booking.findUnique({
    where: { id: bookingId },
    include: {
      enrollment: {
        include: {
          tutorSubject: { include: { tutor: true } },
          student: true,
        },
      },
    },
  });

  if (!booking) throw notFound('Booking not found');
  if (booking.enrollment.tutorSubject.tutor.userId !== tutorUserId) {
    throw forbidden('Not your booking');
  }

  assertTransition(booking.status, 'REJECTED');

  await db.$transaction(async (tx) => {
    await tx.booking.update({
      where: { id: bookingId },
      data: { status: 'REJECTED', rejectReason: reason },
    });

    await tx.slot.update({
      where: { id: booking.slotId },
      data: { status: 'OPEN' },
    });

    await tx.bookingEvent.create({
      data: {
        bookingId,
        fromState: booking.status,
        toState: 'REJECTED',
        actorId: tutorUserId,
      },
    });

    await tx.notification.create({
      data: {
        userId: booking.enrollment.student.userId,
        type: 'BOOKING_REJECTED',
        title: 'Booking Rejected',
        body: reason
          ? `Your booking was rejected: ${reason}`
          : 'Your booking was rejected.',
        data: { bookingId },
      },
    });
  });
}

export async function cancelBooking(studentUserId: string, bookingId: string) {
  const booking = await db.booking.findUnique({
    where: { id: bookingId },
    include: {
      enrollment: {
        include: {
          student: true,
          tutorSubject: { include: { tutor: true } },
        },
      },
      payment: true,
    },
  });

  if (!booking) throw notFound('Booking not found');
  if (booking.enrollment.student.userId !== studentUserId) {
    throw forbidden('Not your booking');
  }

  assertTransition(booking.status, 'CANCELLED');

  await db.$transaction(async (tx) => {
    await tx.booking.update({
      where: { id: bookingId },
      data: { status: 'CANCELLED' },
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
        bookingId,
        fromState: booking.status,
        toState: 'CANCELLED',
        actorId: studentUserId,
      },
    });

    await tx.notification.create({
      data: {
        userId: booking.enrollment.tutorSubject.tutor.userId,
        type: 'BOOKING_CANCELLED',
        title: 'Booking Cancelled',
        body: 'A booking has been cancelled by the student.',
        data: { bookingId },
      },
    });
  });
}

export async function gradeBooking(
  tutorUserId: string,
  bookingId: string,
  input: GradeBody,
) {
  const booking = await db.booking.findUnique({
    where: { id: bookingId },
    include: {
      slot: true,
      enrollment: {
        include: {
          tutorSubject: { include: { tutor: true } },
          student: true,
        },
      },
    },
  });

  if (!booking) throw notFound('Booking not found');
  if (booking.enrollment.tutorSubject.tutor.userId !== tutorUserId) {
    throw forbidden('Not your booking');
  }

  if (booking.status !== 'PAID') {
    throw conflict('INVALID_STATUS', 'Booking must be in PAID status');
  }

  if (booking.slot.endsAt > new Date()) {
    throw conflict('SESSION_NOT_ENDED', 'Session has not ended yet');
  }

  assertTransition(booking.status, 'COMPLETED');

  await db.$transaction(async (tx) => {
    await tx.progressEntry.create({
      data: {
        bookingId,
        score: input.score,
        note: input.note,
      },
    });

    await tx.booking.update({
      where: { id: bookingId },
      data: { status: 'COMPLETED' },
    });

    await tx.bookingEvent.create({
      data: {
        bookingId,
        fromState: 'PAID',
        toState: 'COMPLETED',
        actorId: tutorUserId,
      },
    });

    await tx.notification.create({
      data: {
        userId: booking.enrollment.student.userId,
        type: 'SESSION_GRADED',
        title: 'Session Graded',
        body: `Your session has been graded: ${input.score}/100`,
        data: { bookingId },
      },
    });
  });

  await evaluateCertificateEligibility(booking.enrollmentId);
}

async function evaluateCertificateEligibility(enrollmentId: string) {
  const enrollment = await db.enrollment.findUnique({
    where: { id: enrollmentId },
    include: {
      certificate: true,
      bookings: {
        where: { status: 'COMPLETED' },
        include: { progress: true },
      },
    },
  });

  if (!enrollment || enrollment.certificate) return;

  const completedCount = enrollment.bookings.length;
  const minSessions = enrollment.minSessions ?? 0;
  const targetScore = enrollment.targetScore ?? 0;

  if (minSessions <= 0 || targetScore <= 0) return;
  if (completedCount < minSessions) return;

  const scores = enrollment.bookings
    .map((b) => b.progress?.score)
    .filter((s): s is number => s !== undefined && s !== null);

  if (scores.length === 0) return;

  const avgScore = scores.reduce((a, b) => a + b, 0) / scores.length;

  if (avgScore < targetScore) return;

  const code = `CERT-${enrollmentId.slice(-8).toUpperCase()}-${Date.now().toString(36).toUpperCase()}`;

  await db.certificate.create({
    data: {
      enrollmentId,
      code,
      filePath: `certificates/${enrollmentId}.pdf`,
    },
  });
}

export async function reviewBooking(
  studentUserId: string,
  bookingId: string,
  input: ReviewBody,
) {
  const booking = await db.booking.findUnique({
    where: { id: bookingId },
    include: {
      review: true,
      enrollment: {
        include: {
          student: true,
          tutorSubject: { include: { tutor: true } },
        },
      },
    },
  });

  if (!booking) throw notFound('Booking not found');
  if (booking.enrollment.student.userId !== studentUserId) {
    throw forbidden('Not your booking');
  }

  if (booking.status !== 'COMPLETED') {
    throw conflict('INVALID_STATUS', 'Booking must be completed before reviewing');
  }

  if (booking.review) {
    throw conflict('ALREADY_REVIEWED', 'You have already reviewed this booking');
  }

  const tutorId = booking.enrollment.tutorSubject.tutorId;

  await db.review.create({
    data: {
      bookingId,
      rating: input.rating,
      comment: input.comment,
    },
  });

  const agg = await db.review.aggregate({
    where: {
      booking: {
        enrollment: {
          tutorSubject: { tutorId },
        },
      },
    },
    _avg: { rating: true },
    _count: { rating: true },
  });

  await db.tutorProfile.update({
    where: { id: tutorId },
    data: {
      ratingAvg: agg._avg.rating ?? 0,
      ratingCount: agg._count.rating,
    },
  });
}

export async function listBookings(
  userId: string,
  role: string,
  filters: ListBookingsQuery,
) {
  const where: Prisma.BookingWhereInput = {};

  if (role === 'STUDENT') {
    where.enrollment = { student: { userId } };
  } else {
    where.enrollment = { tutorSubject: { tutor: { userId } } };
  }

  if (filters.status) {
    where.status = filters.status as BookingStatus;
  }

  const take = filters.limit + 1;

  const bookings = await db.booking.findMany({
    where,
    orderBy: { createdAt: 'desc' },
    take,
    ...(filters.cursor ? { cursor: { id: filters.cursor }, skip: 1 } : {}),
    include: {
      slot: true,
      enrollment: {
        include: {
          student: { include: { user: { select: { name: true, avatarPath: true } } } },
          tutorSubject: {
            include: {
              tutor: { include: { user: { select: { name: true, avatarPath: true } } } },
              subject: true,
            },
          },
        },
      },
      payment: true,
    },
  });

  const hasMore = bookings.length > filters.limit;
  const items = hasMore ? bookings.slice(0, filters.limit) : bookings;
  const nextCursor = hasMore ? items[items.length - 1].id : undefined;

  return { items, nextCursor };
}

export async function getBooking(
  userId: string,
  role: string,
  bookingId: string,
) {
  const booking = await db.booking.findUnique({
    where: { id: bookingId },
    include: {
      slot: true,
      enrollment: {
        include: {
          student: { include: { user: { select: { name: true, avatarPath: true } } } },
          tutorSubject: {
            include: {
              tutor: { include: { user: { select: { name: true, avatarPath: true } } } },
              subject: true,
            },
          },
        },
      },
      payment: true,
      progress: true,
      review: true,
      events: { orderBy: { at: 'asc' } },
    },
  });

  if (!booking) throw notFound('Booking not found');

  const isStudent = role === 'STUDENT' && booking.enrollment.student.userId === userId;
  const isTutor = role === 'TUTOR' && booking.enrollment.tutorSubject.tutor.userId === userId;

  if (!isStudent && !isTutor) throw forbidden('Not your booking');

  return booking;
}
