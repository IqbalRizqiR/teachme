import { Prisma } from '@prisma/client';
import db from '../../lib/db';
import { notFound } from '../../lib/errors';
import type { SearchTutorsQuery, UpdateProfileBody } from './schemas';

export async function searchTutors(query: SearchTutorsQuery) {
  const where: Prisma.TutorProfileWhereInput = { isVerified: true };

  if (query.q) {
    where.user = {
      name: { contains: query.q, mode: 'insensitive' },
    };
  }

  if (query.subjectId) {
    where.subjects = { some: { subjectId: query.subjectId } };
  }

  if (query.minPrice !== undefined || query.maxPrice !== undefined) {
    const priceFilter: Prisma.IntFilter = {};
    if (query.minPrice !== undefined) priceFilter.gte = query.minPrice;
    if (query.maxPrice !== undefined) priceFilter.lte = query.maxPrice;
    where.subjects = {
      ...where.subjects,
      some: {
        ...(where.subjects as Prisma.TutorSubjectListRelationFilter)?.some,
        priceIdr: priceFilter,
      },
    };
  }

  if (query.minRating !== undefined) {
    where.ratingAvg = { gte: query.minRating };
  }

  let orderBy: Prisma.TutorProfileOrderByWithRelationInput;
  switch (query.sort) {
    case 'rating':
      orderBy = { ratingAvg: 'desc' };
      break;
    case 'price_asc':
      orderBy = { subjects: { _count: 'asc' } };
      break;
    case 'price_desc':
      orderBy = { subjects: { _count: 'desc' } };
      break;
    case 'newest':
      orderBy = { user: { createdAt: 'desc' } };
      break;
    default:
      orderBy = { ratingAvg: 'desc' };
  }

  const take = query.limit + 1;

  const tutors = await db.tutorProfile.findMany({
    where,
    orderBy,
    take,
    ...(query.cursor ? { cursor: { id: query.cursor }, skip: 1 } : {}),
    include: {
      user: { select: { name: true, avatarPath: true } },
      subjects: { include: { subject: true } },
      slots: {
        where: { status: 'OPEN', startsAt: { gt: new Date() } },
        orderBy: { startsAt: 'asc' },
        take: 1,
      },
    },
  });

  const hasMore = tutors.length > query.limit;
  const items = hasMore ? tutors.slice(0, query.limit) : tutors;
  const nextCursor = hasMore ? items[items.length - 1].id : undefined;

  return {
    items: items.map((t) => ({
      id: t.id,
      name: t.user.name,
      avatarPath: t.user.avatarPath,
      bio: t.bio,
      ratingAvg: t.ratingAvg,
      ratingCount: t.ratingCount,
      subjects: t.subjects.map((s) => ({
        subjectId: s.subjectId,
        name: s.subject.name,
        priceIdr: s.priceIdr,
      })),
      nextAvailableSlot: t.slots[0]?.startsAt ?? null,
    })),
    nextCursor,
  };
}

export async function getTutorDetail(tutorId: string) {
  const tutor = await db.tutorProfile.findUnique({
    where: { id: tutorId },
    include: {
      user: { select: { name: true, avatarPath: true, email: true } },
      subjects: { include: { subject: true } },
    },
  });

  if (!tutor) throw notFound('Tutor not found');

  const reviewAgg = await db.review.aggregate({
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

  return {
    id: tutor.id,
    bio: tutor.bio,
    isVerified: tutor.isVerified,
    ratingAvg: tutor.ratingAvg,
    ratingCount: tutor.ratingCount,
    user: tutor.user,
    subjects: tutor.subjects.map((s) => ({
      id: s.id,
      subjectId: s.subjectId,
      name: s.subject.name,
      slug: s.subject.slug,
      priceIdr: s.priceIdr,
    })),
    reviewSummary: {
      avg: reviewAgg._avg.rating ?? 0,
      count: reviewAgg._count.rating,
    },
  };
}

export async function getTutorSlots(
  tutorId: string,
  from: Date,
  to: Date,
) {
  return db.slot.findMany({
    where: {
      tutorId,
      status: 'OPEN',
      startsAt: { gte: from },
      endsAt: { lte: to },
    },
    orderBy: { startsAt: 'asc' },
  });
}

export async function getTutorReviews(
  tutorId: string,
  cursor?: string,
  limit = 20,
) {
  const take = limit + 1;

  const reviews = await db.review.findMany({
    where: {
      booking: {
        enrollment: {
          tutorSubject: { tutorId },
        },
      },
    },
    orderBy: { createdAt: 'desc' },
    take,
    ...(cursor ? { cursor: { id: cursor }, skip: 1 } : {}),
    include: {
      booking: {
        include: {
          enrollment: {
            include: {
              student: {
                include: { user: { select: { name: true } } },
              },
            },
          },
        },
      },
    },
  });

  const hasMore = reviews.length > limit;
  const items = hasMore ? reviews.slice(0, limit) : reviews;
  const nextCursor = hasMore ? items[items.length - 1].id : undefined;

  return {
    items: items.map((r) => ({
      id: r.id,
      rating: r.rating,
      comment: r.comment,
      createdAt: r.createdAt,
      studentName: r.booking.enrollment.student.user.name,
    })),
    nextCursor,
  };
}

export async function updateProfile(
  userId: string,
  data: UpdateProfileBody,
) {
  const tutor = await db.tutorProfile.findUnique({
    where: { userId },
  });

  if (!tutor) throw notFound('Tutor profile not found');

  return db.$transaction(async (tx) => {
    if (data.bio !== undefined) {
      await tx.tutorProfile.update({
        where: { id: tutor.id },
        data: { bio: data.bio },
      });
    }

    if (data.subjects) {
      await tx.tutorSubject.deleteMany({ where: { tutorId: tutor.id } });
      await tx.tutorSubject.createMany({
        data: data.subjects.map((s) => ({
          tutorId: tutor.id,
          subjectId: s.subjectId,
          priceIdr: s.priceIdr,
        })),
      });
    }

    return tx.tutorProfile.findUnique({
      where: { id: tutor.id },
      include: {
        user: { select: { name: true, avatarPath: true } },
        subjects: { include: { subject: true } },
      },
    });
  });
}
