import { DateTime } from 'luxon';
import db from '../../lib/db';
import { notFound } from '../../lib/errors';
import { bookingInclude, serializeBooking } from '../booking/serializer';

export async function getTutorDashboard(tutorUserId: string) {
  const tutor = await db.tutorProfile.findUnique({
    where: { userId: tutorUserId },
  });
  if (!tutor) throw notFound('Tutor profile not found');

  const now = new Date();
  const startOfWeek = DateTime.now()
    .setZone('Asia/Jakarta')
    .startOf('week')
    .toJSDate();
  const startOfMonth = DateTime.now()
    .setZone('Asia/Jakarta')
    .startOf('month')
    .toJSDate();

  const enrollmentFilter = {
    enrollment: { tutorSubject: { tutorId: tutor.id } },
  };

  const [
    thisWeekSessions,
    pendingRequests,
    earningsData,
    incomingBookings,
    upcomingSessions,
    needsGrading,
  ] = await Promise.all([
    db.booking.count({
      where: {
        ...enrollmentFilter,
        status: { in: ['PAID', 'COMPLETED'] },
        slot: { startsAt: { gte: startOfWeek } },
      },
    }),
    db.booking.count({
      where: {
        ...enrollmentFilter,
        status: 'PENDING',
      },
    }),
    db.booking.findMany({
      where: {
        ...enrollmentFilter,
        status: 'COMPLETED',
        payment: { status: 'SETTLED', settledAt: { gte: startOfMonth } },
      },
      select: { priceIdr: true, feeIdr: true },
    }),
    db.booking.findMany({
      where: {
        ...enrollmentFilter,
        status: 'PENDING',
      },
      include: bookingInclude,
      orderBy: { createdAt: 'desc' },
    }),
    db.booking.findMany({
      where: {
        ...enrollmentFilter,
        status: 'PAID',
        slot: { startsAt: { gt: now } },
      },
      include: bookingInclude,
      orderBy: { slot: { startsAt: 'asc' } },
    }),
    db.booking.findMany({
      where: {
        ...enrollmentFilter,
        status: 'PAID',
        slot: { endsAt: { lt: now } },
        progress: null,
      },
      include: bookingInclude,
      orderBy: { slot: { endsAt: 'asc' } },
    }),
  ]);

  const earningsThisMonth = earningsData.reduce(
    (sum, b) => sum + (b.priceIdr - b.feeIdr),
    0,
  );

  return {
    thisWeekSessions,
    pendingRequests,
    earningsThisMonth,
    ratingAvg: tutor.ratingAvg,
    ratingCount: tutor.ratingCount,
    incomingBookings: incomingBookings.map(serializeBooking),
    upcomingSessions: upcomingSessions.map(serializeBooking),
    needsGrading: needsGrading.map(serializeBooking),
  };
}

export async function getTutorEarnings(
  tutorUserId: string,
  cursor?: string,
  limit = 20,
) {
  const tutor = await db.tutorProfile.findUnique({
    where: { userId: tutorUserId },
  });
  if (!tutor) throw notFound('Tutor profile not found');

  const take = limit + 1;

  const bookings = await db.booking.findMany({
    where: {
      enrollment: { tutorSubject: { tutorId: tutor.id } },
      status: 'COMPLETED',
    },
    orderBy: { updatedAt: 'desc' },
    take,
    ...(cursor ? { cursor: { id: cursor }, skip: 1 } : {}),
    include: {
      enrollment: {
        include: {
          student: {
            include: { user: { select: { name: true } } },
          },
          tutorSubject: {
            include: { subject: true },
          },
        },
      },
    },
  });

  const hasMore = bookings.length > limit;
  const items = hasMore ? bookings.slice(0, limit) : bookings;
  const nextCursor = hasMore ? items[items.length - 1].id : undefined;

  return {
    items: items.map((b) => ({
      id: b.id,
      gross: b.priceIdr,
      fee: b.feeIdr,
      net: b.priceIdr - b.feeIdr,
      date: b.updatedAt,
      studentName: b.enrollment.student.user.name,
      subject: b.enrollment.tutorSubject.subject.name,
    })),
    nextCursor,
  };
}
