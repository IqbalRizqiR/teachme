import 'dotenv/config';
import db from '../src/lib/db';

const statements = [
  `DROP INDEX IF EXISTS "Booking_slotId_key"`,
  `CREATE UNIQUE INDEX IF NOT EXISTS "Booking_slotId_active_key"
     ON "Booking"("slotId")
     WHERE "status" IN ('PENDING', 'ACCEPTED', 'PAID', 'COMPLETED')`,
  `ALTER TABLE "ProgressEntry" DROP CONSTRAINT IF EXISTS "ProgressEntry_score_check"`,
  `ALTER TABLE "ProgressEntry" ADD CONSTRAINT "ProgressEntry_score_check"
     CHECK ("score" BETWEEN 0 AND 100)`,
  `ALTER TABLE "Review" DROP CONSTRAINT IF EXISTS "Review_rating_check"`,
  `ALTER TABLE "Review" ADD CONSTRAINT "Review_rating_check"
     CHECK ("rating" BETWEEN 1 AND 5)`,
  `ALTER TABLE "Slot" DROP CONSTRAINT IF EXISTS "Slot_time_range_check"`,
  `ALTER TABLE "Slot" ADD CONSTRAINT "Slot_time_range_check"
     CHECK ("endsAt" > "startsAt")`,
  `ALTER TABLE "AvailabilityRule" DROP CONSTRAINT IF EXISTS "AvailabilityRule_range_check"`,
  `ALTER TABLE "AvailabilityRule" ADD CONSTRAINT "AvailabilityRule_range_check"
     CHECK ("weekday" BETWEEN 0 AND 6 AND "endMinute" > "startMinute")`,
  `ALTER TABLE "TutorSubject" DROP CONSTRAINT IF EXISTS "TutorSubject_price_check"`,
  `ALTER TABLE "TutorSubject" ADD CONSTRAINT "TutorSubject_price_check"
     CHECK ("priceIdr" > 0)`,
];

async function main() {
  console.log('[constraints] Applying database constraints...');
  for (const statement of statements) {
    await db.$executeRawUnsafe(statement);
    console.log('[constraints] ok:', statement.split('\n')[0].trim());
  }
  console.log('[constraints] All constraints applied.');
}

main()
  .catch((err) => {
    console.error('[constraints] FAILED:', err);
    process.exit(1);
  })
  .finally(() => db.$disconnect());