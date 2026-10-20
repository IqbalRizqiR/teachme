import { DateTime } from 'luxon';
import db from '../../lib/db';
import { notFound } from '../../lib/errors';
import type { CreateRuleBody, UpdateRuleBody, CreateExceptionBody } from './schemas';

const TZ = 'Asia/Jakarta';
const HORIZON_DAYS = 28;
const SLOT_DURATION_MINUTES = 60;

export async function getRules(tutorProfileId: string) {
  return db.availabilityRule.findMany({
    where: { tutorId: tutorProfileId },
    orderBy: [{ weekday: 'asc' }, { startMinute: 'asc' }],
  });
}

export async function createRule(tutorProfileId: string, data: CreateRuleBody) {
  const rule = await db.availabilityRule.create({
    data: {
      tutorId: tutorProfileId,
      weekday: data.weekday,
      startMinute: data.startMinute,
      endMinute: data.endMinute,
    },
  });
  await materializeSlots(tutorProfileId);
  return rule;
}

export async function updateRule(
  ruleId: string,
  tutorProfileId: string,
  data: UpdateRuleBody,
) {
  const rule = await db.availabilityRule.findFirst({
    where: { id: ruleId, tutorId: tutorProfileId },
  });
  if (!rule) throw notFound('Rule not found');

  const updated = await db.availabilityRule.update({
    where: { id: ruleId },
    data,
  });
  await materializeSlots(tutorProfileId);
  return updated;
}

export async function deleteRule(ruleId: string, tutorProfileId: string) {
  const rule = await db.availabilityRule.findFirst({
    where: { id: ruleId, tutorId: tutorProfileId },
  });
  if (!rule) throw notFound('Rule not found');

  await db.availabilityRule.delete({ where: { id: ruleId } });
  await materializeSlots(tutorProfileId);
}

export async function getExceptions(tutorProfileId: string) {
  return db.availabilityException.findMany({
    where: { tutorId: tutorProfileId },
    orderBy: { date: 'asc' },
  });
}

export async function createException(
  tutorProfileId: string,
  data: CreateExceptionBody,
) {
  const exception = await db.availabilityException.create({
    data: {
      tutorId: tutorProfileId,
      date: new Date(data.date),
      reason: data.reason,
    },
  });
  await materializeSlots(tutorProfileId);
  return exception;
}

export async function deleteException(
  exceptionId: string,
  tutorProfileId: string,
) {
  const exception = await db.availabilityException.findFirst({
    where: { id: exceptionId, tutorId: tutorProfileId },
  });
  if (!exception) throw notFound('Exception not found');

  await db.availabilityException.delete({ where: { id: exceptionId } });
  await materializeSlots(tutorProfileId);
}

export async function getTutorSlots(tutorProfileId: string) {
  return db.slot.findMany({
    where: {
      tutorId: tutorProfileId,
      startsAt: { gte: new Date() },
    },
    orderBy: { startsAt: 'asc' },
  });
}

export async function materializeSlots(tutorProfileId: string) {
  const rules = await db.availabilityRule.findMany({
    where: { tutorId: tutorProfileId },
  });

  const exceptions = await db.availabilityException.findMany({
    where: { tutorId: tutorProfileId },
  });

  const exceptionDates = new Set(
    exceptions.map((e) =>
      DateTime.fromJSDate(e.date, { zone: TZ }).toISODate(),
    ),
  );

  const now = DateTime.now().setZone(TZ);
  const startOfToday = now.startOf('day');
  const endHorizon = startOfToday.plus({ days: HORIZON_DAYS });

  const desiredSlots: { startsAt: Date; endsAt: Date }[] = [];

  for (let d = 0; d < HORIZON_DAYS; d++) {
    const day = startOfToday.plus({ days: d });
    const isoDate = day.toISODate();
    if (exceptionDates.has(isoDate)) continue;

    const weekday = day.weekday % 7;

    const matchingRules = rules.filter((r) => r.weekday === weekday);

    for (const rule of matchingRules) {
      let minute = rule.startMinute;
      while (minute + SLOT_DURATION_MINUTES <= rule.endMinute) {
        const slotStart = day.plus({ minutes: minute });
        const slotEnd = slotStart.plus({ minutes: SLOT_DURATION_MINUTES });

        if (slotStart > now) {
          desiredSlots.push({
            startsAt: slotStart.toJSDate(),
            endsAt: slotEnd.toJSDate(),
          });
        }

        minute += SLOT_DURATION_MINUTES;
      }
    }
  }

  const existingSlots = await db.slot.findMany({
    where: {
      tutorId: tutorProfileId,
      startsAt: { gte: startOfToday.toJSDate(), lt: endHorizon.toJSDate() },
    },
  });

  const desiredSet = new Set(
    desiredSlots.map((s) => s.startsAt.getTime()),
  );

  const existingMap = new Map(
    existingSlots.map((s) => [s.startsAt.getTime(), s]),
  );

  const toCreate = desiredSlots.filter(
    (s) => !existingMap.has(s.startsAt.getTime()),
  );

  const toClose = existingSlots.filter(
    (s) =>
      s.status === 'OPEN' && !desiredSet.has(s.startsAt.getTime()),
  );

  await db.$transaction([
    ...(toCreate.length > 0
      ? [
          db.slot.createMany({
            data: toCreate.map((s) => ({
              tutorId: tutorProfileId,
              startsAt: s.startsAt,
              endsAt: s.endsAt,
              status: 'OPEN' as const,
            })),
            skipDuplicates: true,
          }),
        ]
      : []),
    ...(toClose.length > 0
      ? [
          db.slot.updateMany({
            where: { id: { in: toClose.map((s) => s.id) } },
            data: { status: 'CLOSED' },
          }),
        ]
      : []),
  ]);
}
