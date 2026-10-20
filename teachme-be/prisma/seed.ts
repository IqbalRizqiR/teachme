import 'dotenv/config';
import { DateTime } from 'luxon';
import db from '../src/lib/db';
import { hashPassword } from '../src/lib/security';

const TZ = 'Asia/Jakarta';
const SLOT_DURATION_MINUTES = 60;

async function main() {
  console.log('[seed] Starting...');
  console.log('[seed] Connecting to database...');
  await db.$connect();
  console.log('[seed] Connected.');

  console.log('[seed] Seeding subjects...');
  const subjects = await Promise.all(
    [
      { name: 'Matematika', slug: 'matematika' },
      { name: 'Fisika', slug: 'fisika' },
      { name: 'Kimia', slug: 'kimia' },
      { name: 'Bahasa Inggris', slug: 'bahasa-inggris' },
      { name: 'Biologi', slug: 'biologi' },
      { name: 'Sejarah', slug: 'sejarah' },
      { name: 'Informatika', slug: 'informatika' },
      { name: 'Ekonomi', slug: 'ekonomi' },
    ].map((s) =>
      db.subject.upsert({
        where: { slug: s.slug },
        update: {},
        create: s,
      }),
    ),
  );
  console.log('[seed] 8 subjects seeded.');

  const subjectMap = Object.fromEntries(subjects.map((s) => [s.slug, s.id]));

  console.log('[seed] Hashing passwords...');
  const studentPwHash = await hashPassword('Password123!');
  console.log('[seed] Student password hashed.');
  const tutorPwHash = await hashPassword('Password123!');
  console.log('[seed] Tutor password hashed.');

  console.log('[seed] Creating student user...');
  const studentUser = await db.user.upsert({
    where: { email: 'student@teachme.dev' },
    update: {},
    create: {
      email: 'student@teachme.dev',
      passwordHash: studentPwHash,
      name: 'Alya Ramadhani',
      role: 'STUDENT',
      student: { create: { schoolLevel: 'SMA' } },
    },
    include: { student: true },
  });
  console.log('[seed] Student created:', studentUser.email);

  console.log('[seed] Creating tutor 1 (Bima)...');
  const tutor1User = await db.user.upsert({
    where: { email: 'tutor@teachme.dev' },
    update: {},
    create: {
      email: 'tutor@teachme.dev',
      passwordHash: tutorPwHash,
      name: 'Bima Prasetya',
      role: 'TUTOR',
      tutor: {
        create: {
          bio: 'Mahasiswa Teknik UI semester 6 dengan pengalaman mengajar privat selama 3 tahun.',
          isVerified: true,
        },
      },
    },
    include: { tutor: true },
  });
  console.log('[seed] Tutor 1 created:', tutor1User.email);

  console.log('[seed] Creating tutor 2 (Sarah)...');
  const tutor2User = await db.user.upsert({
    where: { email: 'sarah@teachme.dev' },
    update: {},
    create: {
      email: 'sarah@teachme.dev',
      passwordHash: tutorPwHash,
      name: 'Sarah Wijaya',
      role: 'TUTOR',
      tutor: {
        create: {
          bio: 'Lulusan ITB jurusan Kimia dengan pengalaman mengajar di bimbel ternama.',
          isVerified: true,
        },
      },
    },
    include: { tutor: true },
  });
  console.log('[seed] Tutor 2 created:', tutor2User.email);

  console.log('[seed] Creating tutor 3 (Rafi)...');
  const tutor3User = await db.user.upsert({
    where: { email: 'rafi@teachme.dev' },
    update: {},
    create: {
      email: 'rafi@teachme.dev',
      passwordHash: tutorPwHash,
      name: 'Rafi Hartono',
      role: 'TUTOR',
      tutor: {
        create: {
          bio: 'Guru les berpengalaman 5 tahun di bidang Bahasa Inggris dan Ekonomi.',
          isVerified: true,
        },
      },
    },
    include: { tutor: true },
  });
  console.log('[seed] Tutor 3 created:', tutor3User.email);

  console.log('[seed] Seeding tutor subjects...');
  const tutorSubjectsData = [
    { tutorId: tutor1User.tutor!.id, subjectSlug: 'matematika', price: 75000 },
    { tutorId: tutor1User.tutor!.id, subjectSlug: 'fisika', price: 80000 },
    { tutorId: tutor2User.tutor!.id, subjectSlug: 'kimia', price: 90000 },
    { tutorId: tutor2User.tutor!.id, subjectSlug: 'biologi', price: 85000 },
    { tutorId: tutor3User.tutor!.id, subjectSlug: 'bahasa-inggris', price: 70000 },
    { tutorId: tutor3User.tutor!.id, subjectSlug: 'ekonomi', price: 65000 },
  ];

  const tutorSubjects = [];
  for (const ts of tutorSubjectsData) {
    const created = await db.tutorSubject.upsert({
      where: {
        tutorId_subjectId: {
          tutorId: ts.tutorId,
          subjectId: subjectMap[ts.subjectSlug],
        },
      },
      update: {},
      create: {
        tutorId: ts.tutorId,
        subjectId: subjectMap[ts.subjectSlug],
        priceIdr: ts.price,
      },
    });
    tutorSubjects.push(created);
  }
  console.log('[seed] 6 tutor-subjects seeded.');

  console.log('[seed] Seeding availability rules...');
  const ruleTemplates = [
    { weekday: 1, startMinute: 960, endMinute: 1200 },
    { weekday: 2, startMinute: 960, endMinute: 1200 },
    { weekday: 3, startMinute: 960, endMinute: 1200 },
    { weekday: 4, startMinute: 960, endMinute: 1200 },
    { weekday: 5, startMinute: 960, endMinute: 1200 },
  ];

  const allTutorIds = [
    tutor1User.tutor!.id,
    tutor2User.tutor!.id,
    tutor3User.tutor!.id,
  ];

  for (const tutorId of allTutorIds) {
    for (const rule of ruleTemplates) {
      await db.availabilityRule.upsert({
        where: {
          id: `seed-${tutorId}-${rule.weekday}`,
        },
        update: {},
        create: {
          id: `seed-${tutorId}-${rule.weekday}`,
          tutorId,
          weekday: rule.weekday,
          startMinute: rule.startMinute,
          endMinute: rule.endMinute,
        },
      });
    }
  }
  console.log('[seed] 15 availability rules seeded.');

  console.log('[seed] Generating slots for next 7 days...');
  const now = DateTime.now().setZone(TZ);
  const startOfToday = now.startOf('day');
  let slotCount = 0;

  for (const tutorId of allTutorIds) {
    for (let d = 0; d < 7; d++) {
      const day = startOfToday.plus({ days: d });
      const weekday = day.weekday % 7;

      const matchingRules = ruleTemplates.filter((r) => r.weekday === weekday);
      for (const rule of matchingRules) {
        let minute = rule.startMinute;
        while (minute + SLOT_DURATION_MINUTES <= rule.endMinute) {
          const slotStart = day.plus({ minutes: minute });
          const slotEnd = slotStart.plus({ minutes: SLOT_DURATION_MINUTES });

          if (slotStart > now) {
            const startsAt = slotStart.toJSDate();
            const endsAt = slotEnd.toJSDate();

            await db.slot.upsert({
              where: {
                tutorId_startsAt: { tutorId, startsAt },
              },
              update: {},
              create: {
                tutorId,
                startsAt,
                endsAt,
                status: 'OPEN',
              },
            });
            slotCount++;
          }

          minute += SLOT_DURATION_MINUTES;
        }
      }
    }
  }
  console.log(`[seed] ${slotCount} slots generated.`);

  console.log('[seed] Creating enrollment...');
  const mathTs = tutorSubjects.find(
    (ts) => ts.tutorId === tutor1User.tutor!.id && ts.subjectId === subjectMap['matematika'],
  )!;

  const enrollment = await db.enrollment.upsert({
    where: {
      studentId_tutorSubjectId: {
        studentId: studentUser.student!.id,
        tutorSubjectId: mathTs.id,
      },
    },
    update: {},
    create: {
      studentId: studentUser.student!.id,
      tutorSubjectId: mathTs.id,
      targetScore: 80,
      minSessions: 5,
    },
  });
  console.log('[seed] Enrollment created.');

  console.log('[seed] Creating sample completed booking...');
  const pastDay = startOfToday.minus({ days: 3 });
  const pastSlotStart = pastDay.set({ hour: 16 });
  const pastSlotEnd = pastSlotStart.plus({ minutes: 60 });

  const pastSlot = await db.slot.upsert({
    where: {
      tutorId_startsAt: {
        tutorId: tutor1User.tutor!.id,
        startsAt: pastSlotStart.toJSDate(),
      },
    },
    update: {},
    create: {
      tutorId: tutor1User.tutor!.id,
      startsAt: pastSlotStart.toJSDate(),
      endsAt: pastSlotEnd.toJSDate(),
      status: 'BOOKED',
    },
  });
  console.log('[seed] Past slot created.');

  const existingBooking = await db.booking.findFirst({
    where: { enrollmentId: enrollment.id, slotId: pastSlot.id },
  });

  if (!existingBooking) {
    console.log('[seed] No existing booking found, creating...');
    const booking = await db.booking.create({
      data: {
        enrollmentId: enrollment.id,
        slotId: pastSlot.id,
        status: 'COMPLETED',
        priceIdr: 75000,
        feeIdr: 7500,
        respondBy: pastSlotStart.minus({ hours: 24 }).toJSDate(),
      },
    });
    console.log('[seed] Booking created:', booking.id);

    await db.bookingEvent.create({
      data: {
        bookingId: booking.id,
        toState: 'COMPLETED',
      },
    });
    console.log('[seed] BookingEvent created.');

    await db.progressEntry.create({
      data: {
        bookingId: booking.id,
        score: 85,
        note: 'Bagus! Pemahaman aljabar sudah meningkat.',
      },
    });
    console.log('[seed] ProgressEntry created.');

    await db.review.create({
      data: {
        bookingId: booking.id,
        rating: 5,
        comment: 'Pak Bima menjelaskan dengan sangat jelas dan sabar.',
      },
    });
    console.log('[seed] Review created.');

    await db.payment.create({
      data: {
        bookingId: booking.id,
        provider: 'mock',
        orderId: `seed-${booking.id}`,
        amountIdr: 75000,
        status: 'SETTLED',
        settledAt: pastSlotEnd.toJSDate(),
      },
    });
    console.log('[seed] Payment created.');
  } else {
    console.log('[seed] Sample booking already exists, skipping.');
  }

  console.log('[seed] Seed completed successfully!');
}

main()
  .catch((err) => {
    console.error('[seed] FAILED:', err);
    process.exit(1);
  })
  .finally(async () => {
    console.log('[seed] Disconnecting...');
    await db.$disconnect();
    console.log('[seed] Done.');
  });
