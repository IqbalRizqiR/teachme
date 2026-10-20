# Technical Requirements Document (TRD) — teachMe

| | |
|---|---|
| **Status** | Draft v0.3 (Flutter + Express + PostgreSQL, local-only) |
| **Related** | [PRD](PRD.md) · [Architecture](ARCHITECTURE.md) · [Design](DESIGN.md) |

---

## 1. Purpose & Scope

This document turns the PRD into concrete technical requirements for:

- a **Flutter** mobile app (`mobile/`), and
- an **Express + TypeScript** REST API (`server/`),

both running **locally**. There is no cloud deployment, container orchestration, or CI/CD pipeline in scope. Where a production concern exists (real payments, email, push), the design leaves a clean seam but ships a simple local implementation.

## 2. Technology Decisions

### 2.1 Mobile

| Concern | Decision | Rationale |
|---|---|---|
| Framework | Flutter (stable), Dart 3.x, Material 3 | One codebase for Android + iOS, rich animation support for the playful UI |
| State management | Riverpod (`flutter_riverpod`, `riverpod_annotation`) | Testable, compile-safe, scoped providers per feature |
| Navigation | `go_router` | Declarative routes, redirect guards for auth + role |
| HTTP | `dio` + interceptors | Token injection, refresh-on-401, error mapping |
| Models | `freezed` + `json_serializable` | Immutable DTOs/entities, union states |
| Secure storage | `flutter_secure_storage` | Refresh/access tokens |
| Preferences | `shared_preferences` | Theme mode, onboarding flags |
| Charts | `fl_chart` | Themeable line charts with animation |
| i18n | `flutter_localizations` + `gen-l10n` (ARB) | Indonesian default, English secondary |
| Formatting | `intl` | IDR currency, dates in device timezone |
| Files | `path_provider`, `open_filex`, `share_plus` | Download/open certificate PDF |
| Images | `image_picker`, `cached_network_image` | Avatar upload and display |
| Loading UI | `shimmer` | Skeleton states |
| Tests | `flutter_test`, `mocktail`, `golden_toolkit` (or built-in goldens), `integration_test` | Unit, widget, golden, e2e |

### 2.2 Backend

| Concern | Decision | Rationale |
|---|---|---|
| Runtime / framework | Node.js ≥ 20, Express, TypeScript (strict) | Simple, widely known, fast to scaffold |
| Database | PostgreSQL 16 (Prisma) | Relational integrity, native enums/JSON, CHECK constraints, advisory locks; runs locally via Docker Compose |
| ORM | Prisma | Typed queries, migrations, seeding |
| Validation | Zod | One schema source for request validation and types |
| Auth | `jsonwebtoken` (access) + opaque rotating refresh tokens, `argon2` | Mobile-friendly stateless access + revocable refresh |
| Security middleware | `helmet`, `cors`, `express-rate-limit` | Sensible defaults |
| Scheduler | `node-cron` | In-process sweeper; no queue infrastructure |
| PDF | `pdfkit` | Certificate generation on the server |
| Uploads | `multer` → local disk | Avatars without cloud storage |
| Logging | `pino` + `pino-http` | Structured logs with request IDs |
| Tests | Vitest + Supertest | API tests against a separate `teachme_test` PostgreSQL database |
| Dev tooling | `tsx` (watch), ESLint, Prettier | Hot reload and consistency |

### 2.3 Tooling assumptions
- Single repository (monorepo) with `mobile/`, `server/`, `docs/`.
- Docker is used for **one thing only**: running PostgreSQL via `docker compose up -d db` (a locally installed PostgreSQL 16 works too). The API and app run directly on the host with `npm run dev` and `flutter run`.

## 3. Architecture Constraints

1. **Server is the source of truth** for authorization, state transitions, pricing, and fees. The app never sends prices or computes totals authoritatively.
2. **Modular monolith** on the server: modules own their routes, services, repositories; cross-module calls go through service interfaces only.
3. **Feature-first** structure on mobile with `data / domain / presentation` layers per feature.
4. All timestamps are **ISO-8601 UTC** on the wire; the app converts to device timezone. Default tutor schedule timezone: `Asia/Jakarta`.
5. All money is **integer IDR** (no floats) on the wire and in the DB.
6. Provider seams: `PaymentProvider` (mock now), notification sink (DB inbox now), file storage (local disk now).

## 4. Data Model

### 4.1 ERD

```mermaid
erDiagram
    User ||--o| StudentProfile : has
    User ||--o| TutorProfile : has
    User ||--o{ RefreshToken : owns
    User ||--o{ Notification : receives
    TutorProfile ||--o{ TutorSubject : teaches
    Subject ||--o{ TutorSubject : "is taught as"
    TutorProfile ||--o{ AvailabilityRule : defines
    TutorProfile ||--o{ AvailabilityException : blocks
    TutorProfile ||--o{ Slot : offers
    StudentProfile ||--o{ Enrollment : starts
    TutorSubject ||--o{ Enrollment : "is target of"
    Enrollment ||--o{ Booking : contains
    Slot ||--o| Booking : "is held by"
    Booking ||--o| Payment : "paid by"
    Booking ||--o| ProgressEntry : "graded as"
    Booking ||--o| Review : "reviewed in"
    Booking ||--o{ BookingEvent : audits
    Enrollment ||--o| Certificate : earns
```

### 4.2 Prisma schema (PostgreSQL)

Native PostgreSQL enums, `Json`, and `timestamptz` are used. Money is integer IDR; `ratingAvg` is a float.

```prisma
generator client {
  provider = "prisma-client-js"
}

datasource db {
  provider = "postgresql"
  url      = env("DATABASE_URL")
}

enum Role             { STUDENT TUTOR }
enum SchoolLevel      { SMP SMA UNIVERSITY }
enum SlotStatus       { OPEN HELD BOOKED CLOSED }
enum BookingStatus    { PENDING ACCEPTED PAID COMPLETED REJECTED CANCELLED EXPIRED }
enum PaymentStatus    { CREATED PENDING SETTLED FAILED EXPIRED REFUNDED }
enum EnrollmentStatus { ACTIVE ENDED }

model User {
  id           String   @id @default(cuid())
  email        String   @unique
  passwordHash String
  name         String
  role         Role
  avatarPath   String?
  timezone     String   @default("Asia/Jakarta")
  createdAt    DateTime @default(now()) @db.Timestamptz(3)

  student        StudentProfile?
  tutor          TutorProfile?
  refreshTokens  RefreshToken[]
  notifications  Notification[]
}

model RefreshToken {
  id        String    @id @default(cuid())
  userId    String
  tokenHash String    @unique
  expiresAt DateTime  @db.Timestamptz(3)
  revokedAt DateTime? @db.Timestamptz(3)
  createdAt DateTime  @default(now()) @db.Timestamptz(3)
  user      User      @relation(fields: [userId], references: [id], onDelete: Cascade)
  @@index([userId])
}

model StudentProfile {
  id          String       @id @default(cuid())
  userId      String       @unique
  schoolLevel SchoolLevel?
  user        User         @relation(fields: [userId], references: [id], onDelete: Cascade)
  enrollments Enrollment[]
}

model TutorProfile {
  id          String   @id @default(cuid())
  userId      String   @unique
  bio         String?
  isVerified  Boolean  @default(false)
  ratingAvg   Float    @default(0)
  ratingCount Int      @default(0)
  user        User     @relation(fields: [userId], references: [id], onDelete: Cascade)
  subjects    TutorSubject[]
  rules       AvailabilityRule[]
  exceptions  AvailabilityException[]
  slots       Slot[]
}

model Subject {
  id     String @id @default(cuid())
  name   String @unique
  slug   String @unique
  tutors TutorSubject[]
}

model TutorSubject {
  id        String @id @default(cuid())
  tutorId   String
  subjectId String
  priceIdr  Int                               // per 60-minute session
  tutor     TutorProfile @relation(fields: [tutorId], references: [id], onDelete: Cascade)
  subject   Subject      @relation(fields: [subjectId], references: [id])
  enrollments Enrollment[]
  @@unique([tutorId, subjectId])
  @@index([subjectId, priceIdr])
}

model AvailabilityRule {
  id          String @id @default(cuid())
  tutorId     String
  weekday     Int                             // 0 = Sunday … 6 = Saturday
  startMinute Int                             // minutes from 00:00 (960 = 16:00)
  endMinute   Int
  tutor       TutorProfile @relation(fields: [tutorId], references: [id], onDelete: Cascade)
  @@index([tutorId, weekday])
}

model AvailabilityException {
  id      String   @id @default(cuid())
  tutorId String
  date    DateTime @db.Date                   // calendar date in tutor timezone
  reason  String?
  tutor   TutorProfile @relation(fields: [tutorId], references: [id], onDelete: Cascade)
  @@unique([tutorId, date])
}

model Slot {
  id       String     @id @default(cuid())
  tutorId  String
  startsAt DateTime   @db.Timestamptz(3)
  endsAt   DateTime   @db.Timestamptz(3)
  status   SlotStatus @default(OPEN)
  tutor    TutorProfile @relation(fields: [tutorId], references: [id], onDelete: Cascade)
  booking  Booking?
  @@unique([tutorId, startsAt])
  @@index([tutorId, status, startsAt])
}

model Enrollment {
  id             String           @id @default(cuid())
  studentId      String
  tutorSubjectId String
  targetScore    Int?                         // e.g. 80
  minSessions    Int?                         // e.g. 8
  status         EnrollmentStatus @default(ACTIVE)
  student        StudentProfile @relation(fields: [studentId], references: [id], onDelete: Cascade)
  tutorSubject   TutorSubject   @relation(fields: [tutorSubjectId], references: [id])
  bookings       Booking[]
  certificate    Certificate?
  @@unique([studentId, tutorSubjectId])
}

model Booking {
  id           String        @id @default(cuid())
  enrollmentId String
  slotId       String        @unique          // 1 slot ↔ at most 1 booking
  status       BookingStatus @default(PENDING)
  priceIdr     Int                            // snapshot at request time
  feeIdr       Int                            // platform fee snapshot
  note         String?
  rejectReason String?
  respondBy    DateTime      @db.Timestamptz(3)           // PENDING deadline (+24h)
  payBy        DateTime?     @db.Timestamptz(3)           // ACCEPTED deadline (+2h)
  gradeReminderSentAt DateTime? @db.Timestamptz(3)
  createdAt    DateTime      @default(now()) @db.Timestamptz(3)
  updatedAt    DateTime      @updatedAt @db.Timestamptz(3)
  enrollment   Enrollment    @relation(fields: [enrollmentId], references: [id])
  slot         Slot          @relation(fields: [slotId], references: [id])
  payment      Payment?
  progress     ProgressEntry?
  review       Review?
  events       BookingEvent[]
  @@index([status, respondBy])
  @@index([status, payBy])
  @@index([enrollmentId])
}

model BookingEvent {
  id        String        @id @default(cuid())
  bookingId String
  fromState BookingStatus?
  toState   BookingStatus
  actorId   String?                           // null = system
  meta      Json?
  at        DateTime      @default(now()) @db.Timestamptz(3)
  booking   Booking       @relation(fields: [bookingId], references: [id], onDelete: Cascade)
  @@index([bookingId])
}

model Payment {
  id         String        @id @default(cuid())
  bookingId  String        @unique
  provider   String                           // "mock"
  orderId    String        @unique            // idempotency key
  amountIdr  Int
  status     PaymentStatus @default(CREATED)
  method     String?
  settledAt  DateTime?     @db.Timestamptz(3)
  rawPayload Json?
  booking    Booking       @relation(fields: [bookingId], references: [id], onDelete: Cascade)
}

model ProgressEntry {
  id        String   @id @default(cuid())
  bookingId String   @unique
  score     Int                               // 0..100 (CHECK constraint)
  note      String
  createdAt DateTime @default(now()) @db.Timestamptz(3)
  booking   Booking  @relation(fields: [bookingId], references: [id], onDelete: Cascade)
}

model Review {
  id        String   @id @default(cuid())
  bookingId String   @unique
  rating    Int                               // 1..5 (CHECK constraint)
  comment   String?
  createdAt DateTime @default(now()) @db.Timestamptz(3)
  booking   Booking  @relation(fields: [bookingId], references: [id], onDelete: Cascade)
}

model Certificate {
  id           String   @id @default(cuid())
  enrollmentId String   @unique
  code         String   @unique               // public verification code
  filePath     String                         // under STORAGE_DIR/certificates
  issuedAt     DateTime @default(now()) @db.Timestamptz(3)
  enrollment   Enrollment @relation(fields: [enrollmentId], references: [id], onDelete: Cascade)
}

model Notification {
  id        String    @id @default(cuid())
  userId    String
  type      String                            // e.g. "BOOKING_ACCEPTED"
  title     String
  body      String
  data      Json?                             // { bookingId, ... }
  readAt    DateTime? @db.Timestamptz(3)
  createdAt DateTime  @default(now()) @db.Timestamptz(3)
  user      User      @relation(fields: [userId], references: [id], onDelete: Cascade)
  @@index([userId, readAt, createdAt])
}
```

### 4.3 Integrity rules

- `Booking.slotId` is unique. Slot transitions `OPEN → HELD → BOOKED` happen **inside the same Prisma interactive transaction** as the booking status change.
- **Double-booking guard:** claim the slot with a single atomic conditional update and check the count (no explicit row lock needed; PostgreSQL serializes concurrent updates on the same row):

```ts
const claimed = await tx.slot.updateMany({
  where: { id: slotId, status: "OPEN", startsAt: { gt: new Date() } },
  data: { status: "HELD" },
});
if (claimed.count !== 1) throw new AppError("SLOT_UNAVAILABLE", 409);
```

- `ProgressEntry` exists only for bookings moving `PAID → COMPLETED` (enforced in service, tested).
- `Review` only for `COMPLETED` bookings, only by the owning student, once per booking.
- Prices are **snapshotted** on the booking; later tutor price changes do not affect it.
- Every state transition inserts a `BookingEvent` in the same transaction.
- **CHECK constraints** are added by a raw-SQL step in the first migration (Prisma cannot express them): `ProgressEntry.score BETWEEN 0 AND 100`, `Review.rating BETWEEN 1 AND 5`, `Slot."endsAt" > Slot."startsAt"`, `AvailabilityRule.weekday BETWEEN 0 AND 6 AND "endMinute" > "startMinute"`, `TutorSubject."priceIdr" > 0`.

## 5. Booking State Machine

```mermaid
stateDiagram-v2
    [*] --> PENDING: student requests (slot HELD)
    PENDING --> ACCEPTED: tutor accepts (payBy = +2h)
    PENDING --> REJECTED: tutor rejects (slot → OPEN)
    PENDING --> EXPIRED: respondBy passed (slot → OPEN)
    PENDING --> CANCELLED: student cancels (slot → OPEN)
    ACCEPTED --> PAID: payment settled (slot → BOOKED)
    ACCEPTED --> EXPIRED: payBy passed (slot → OPEN)
    ACCEPTED --> CANCELLED: student cancels (slot → OPEN)
    PAID --> COMPLETED: tutor submits score + note
    COMPLETED --> [*]
    REJECTED --> [*]
    EXPIRED --> [*]
    CANCELLED --> [*]
```

| Transition | Actor | Guard | Side effects |
|---|---|---|---|
| → `PENDING` | Student | Slot claimable; no overlapping booking for the student | Slot `HELD`; get/create `Enrollment`; set `respondBy = now+24h`; notify tutor |
| `PENDING → ACCEPTED` | Tutor (owner) | Before `respondBy` | Set `payBy = now+2h`; create `Payment(CREATED)`; notify student |
| `PENDING → REJECTED` | Tutor (owner) | — | Slot `OPEN`; store reason; notify student |
| `ACCEPTED → PAID` | System (settle) | Payment amount matches; idempotent on `orderId` | Slot `BOOKED`; payment `SETTLED`; notify both |
| `* → EXPIRED` | System (sweeper) | Deadline passed, status unchanged | Slot `OPEN`; payment `EXPIRED` if any; notify both |
| `* → CANCELLED` | Student | Status `PENDING`/`ACCEPTED` | Slot `OPEN`; payment cancelled; notify tutor |
| `PAID → COMPLETED` | Tutor (owner) | `slot.endsAt` has passed | Insert `ProgressEntry`; evaluate certificate; notify student; earnings updated |

The transition logic lives in one `BookingStateMachine` class: a map of allowed `(from → to)` pairs plus guards. Services never write `status` directly.

## 6. API Specification

Base URL: `http://<host>:3000/api/v1` · JSON · `Authorization: Bearer <accessToken>` for protected routes.

### 6.1 Conventions

**Error envelope** (all non-2xx responses):

```json
{ "error": { "code": "SLOT_UNAVAILABLE", "message": "That slot was just taken.", "fields": {} } }
```

| HTTP | Typical codes |
|---|---|
| 400 | `VALIDATION_ERROR` (with `fields: { email: "…" }`) |
| 401 | `UNAUTHENTICATED`, `TOKEN_EXPIRED`, `INVALID_CREDENTIALS` |
| 403 | `FORBIDDEN` (role or ownership) |
| 404 | `NOT_FOUND` |
| 409 | `EMAIL_TAKEN`, `SLOT_UNAVAILABLE`, `INVALID_TRANSITION` |
| 429 | `RATE_LIMITED` |
| 500 | `INTERNAL` |

**Pagination:** `?limit=20&cursor=<opaque>` → `{ "items": [...], "nextCursor": "…" | null }`.

### 6.2 Endpoints

| Method | Path | Role | Description |
|---|---|---|---|
| GET | `/health` | Public | Liveness check |
| POST | `/auth/register` | Public | `{name,email,password,role}` → tokens + user |
| POST | `/auth/login` | Public | `{email,password}` → tokens + user |
| POST | `/auth/refresh` | Public | `{refreshToken}` → rotated tokens |
| POST | `/auth/logout` | Any | Revoke current refresh token |
| GET | `/me` | Any | Current user + profile |
| PATCH | `/me` | Any | Update name, timezone |
| POST | `/me/avatar` | Any | Multipart image upload |
| GET | `/subjects` | Any | List subjects |
| GET | `/tutors` | Student | Search: `q, subjectId, minPrice, maxPrice, minRating, sort, cursor, limit` |
| GET | `/tutors/:id` | Student | Profile, subjects, reviews summary |
| GET | `/tutors/:id/slots` | Student | Open slots: `from`, `to` |
| GET | `/tutors/:id/reviews` | Student | Paginated reviews |
| PUT | `/tutor/profile` | Tutor | Update bio, subjects, prices |
| GET / POST | `/tutor/availability-rules` | Tutor | List / create weekly rules |
| PATCH / DELETE | `/tutor/availability-rules/:id` | Tutor | Update / delete rule |
| GET / POST / DELETE | `/tutor/availability-exceptions` | Tutor | Blocked dates |
| GET | `/tutor/slots` | Tutor | Own slots with status (for the schedule preview) |
| POST | `/bookings` | Student | `{slotId, subjectId, note?}` |
| GET | `/bookings` | Both | Own bookings, filter `status`, paginated |
| GET | `/bookings/:id` | Both | Detail incl. payment + events (owner only) |
| POST | `/bookings/:id/accept` | Tutor | Accept |
| POST | `/bookings/:id/reject` | Tutor | `{reason?}` |
| POST | `/bookings/:id/cancel` | Student | Before payment |
| POST | `/bookings/:id/pay` | Student | Create/return payment (mock order info) |
| POST | `/bookings/:id/grade` | Tutor | `{score, note}` → `COMPLETED` |
| POST | `/bookings/:id/review` | Student | `{rating, comment?}` |
| GET | `/progress` | Student | Series per enrollment: `?enrollmentId=` |
| GET | `/enrollments` | Student | Own enrollments with progress summary |
| PATCH | `/enrollments/:id/target` | Student | `{targetScore, minSessions}` |
| GET | `/certificates/:id/download` | Student | Streams the PDF (auth required) |
| GET | `/certificates/verify/:code` | Public | JSON verification result |
| GET | `/tutor/dashboard` | Tutor | Stats + pending + upcoming + needs-grading |
| GET | `/tutor/earnings` | Tutor | Gross, fee, net, per-booking ledger |
| GET | `/notifications` | Any | Inbox, paginated |
| POST | `/notifications/:id/read` | Any | Mark as read |
| POST | `/notifications/read-all` | Any | Mark all as read |
| POST | `/dev/payments/:orderId/settle` | Dev only | Simulate gateway success (disabled in production) |

### 6.3 Example payloads

`POST /auth/login` → `200`

```json
{
  "accessToken": "eyJ…",
  "refreshToken": "r_5f2c…",
  "expiresIn": 900,
  "user": { "id": "ckx1…", "name": "Alya", "email": "alya@mail.com", "role": "STUDENT", "avatarUrl": null }
}
```

`POST /bookings` body → `201`

```json
{ "slotId": "ckslot1", "subjectId": "cksubj1", "note": "Need help with limits" }
```
```json
{
  "id": "ckbook1",
  "status": "PENDING",
  "priceIdr": 75000,
  "respondBy": "2026-10-21T09:00:00.000Z",
  "slot": { "id": "ckslot1", "startsAt": "2026-10-26T09:00:00.000Z", "endsAt": "2026-10-26T10:00:00.000Z" },
  "tutor": { "id": "cktutor1", "name": "Bima" },
  "subject": { "id": "cksubj1", "name": "Math" }
}
```

`POST /bookings/:id/grade` body

```json
{ "score": 82, "note": "Great focus on derivatives. Practice chain rule." }
```

### 6.4 Idempotency
`POST /bookings` and `POST /bookings/:id/pay` accept an optional `Idempotency-Key` header (stored for 24h). Payment settlement is idempotent on `orderId`.

## 7. Authentication & Authorization

### 7.1 Authentication
- Passwords: **argon2id**; policy ≥ 8 chars with a letter and a number (Zod, mirrored in the app form).
- **Access token:** JWT, 15 min, claims `sub`, `role`.
- **Refresh token:** random opaque value, stored **hashed** (`RefreshToken`), 30 days, **rotated on every use**; reuse of a revoked token revokes the user's whole token family.
- Mobile stores both tokens in `flutter_secure_storage`. On `401 TOKEN_EXPIRED`, the dio interceptor refreshes once (single-flight lock), retries the request, and on failure logs the user out.
- Rate limits: login/register 10 req / 15 min per IP; general 120 req / min per IP.
- Generic error on bad credentials (no user enumeration).

### 7.2 Authorization (three layers)
1. **Mobile route guard** (UX only): `go_router.redirect` sends users to the right shell by role. Never trusted for security.
2. **API role middleware:** `requireRole("STUDENT")` / `requireRole("TUTOR")` on every route group.
3. **Resource policy:** service-level ownership checks (only the booking's tutor accepts/rejects/grades; only its student pays/cancels/reviews; users read only their own bookings, notifications, progress).

| Resource | Student | Tutor |
|---|---|---|
| Tutor list / detail | Read | Read own profile |
| Availability / slots | Read open slots | CRUD own |
| Booking | Create; read, cancel, pay own | Read, accept, reject, grade own |
| Progress | Read own | Create for own paid bookings |
| Review | Create for own completed bookings | Read own |
| Earnings / dashboard | — | Read own |

## 8. Payments (Local Mock)

```ts
interface PaymentProvider {
  createCharge(input: { orderId: string; amountIdr: number; bookingId: string }): Promise<ChargeInfo>;
  cancel(orderId: string): Promise<void>;
  // real gateways also implement verifyWebhook(req)
}
```

- `PAYMENT_PROVIDER=mock` (default) selects `MockPaymentProvider`: `createCharge` returns a fake order with selectable methods (`EWALLET`, `VA`, `QRIS`) and a display reference; nothing external is called.
- `POST /bookings/:id/pay` creates or returns the `Payment` (`orderId = TM-{bookingId}-{attempt}`) and responds with the order info for the app's payment sheet.
- `POST /dev/payments/:orderId/settle` calls the **same** `PaymentService.settle(orderId)` a real webhook would: verifies amount, moves `Payment → SETTLED`, `Booking → PAID`, `Slot → BOOKED`, all in one transaction, idempotently.
- Amount is always `Booking.priceIdr`, never client-provided.
- Earnings: `feeIdr = round(priceIdr × PLATFORM_FEE_PERCENT / 100)`; tutor net = `priceIdr − feeIdr`.
- Adding a real gateway later = implement the interface + a signed webhook route; the state machine is unchanged.

## 9. Scheduling

- Tutors define **weekly rules** (weekday + start/end minutes) and **exceptions** (blocked dates).
- A `SlotMaterializer` generates 60-minute `Slot` rows for the next **28 days**: on server start, after any rule/exception change (for that tutor), and daily at 02:00.
- Materialization is **additive and safe**: it creates missing `OPEN` slots, closes `OPEN` slots no longer covered by rules, and **never touches** `HELD`/`BOOKED` slots.
- Times are computed in the tutor's timezone and stored in UTC (handle `Asia/Jakarta` as a fixed UTC+7; use `luxon` for generality).
- A student cannot hold two overlapping slots across tutors.

## 10. Background Scheduler

No queue. A single in-process `node-cron` task runs **every minute** and is **query-based** (so restarts never lose work):

| Sweep | Query | Action |
|---|---|---|
| Expire pending | `status = PENDING AND respondBy < now` | Transition to `EXPIRED`, free slot, notify both |
| Expire unpaid | `status = ACCEPTED AND payBy < now` | Transition to `EXPIRED`, cancel payment, free slot, notify both |
| Grade reminder | `status = PAID AND slot.endsAt < now − 1h` and no reminder yet | Notify tutor once |
| Slot materialize | Daily 02:00 | Roll the 28-day window |

Each sweep processes in small batches and re-checks the current status inside the transaction (idempotent). Only one scheduler instance runs locally; if more than one process ever runs, each sweep first takes `pg_try_advisory_lock` so only one instance does the work.

## 11. Progress & Certificate

- Score: integer 0–100. Note: 1–1000 chars.
- `GET /progress?enrollmentId=` returns `[{ sessionNo, date, score, note, subject, tutor }]` plus `{ targetScore, minSessions, completedSessions, average }`.
- **Eligibility (default):** `completedSessions ≥ minSessions` and `avg(last 3 scores) ≥ targetScore`, evaluated after every `COMPLETED`.
- When eligible and no certificate exists, the server generates a PDF with `pdfkit` (student, subject, tutor, period, score summary, verification code), saves it under `STORAGE_DIR/certificates/`, creates `Certificate`, and notifies the student.
- Download is **authenticated** (`GET /certificates/:id/download`); the app saves it with `path_provider` and opens it via `open_filex` / shares it with `share_plus`.
- `GET /certificates/verify/:code` returns only non-sensitive fields (student first name, subject, issue date, valid flag).

## 12. Mobile Requirements

### 12.1 Architecture
- **Layers per feature:** `presentation` (screens, widgets, Riverpod notifiers) → `domain` (entities, repository interfaces) → `data` (DTOs, API client, repository implementations).
- Riverpod providers: `authControllerProvider` (session + role), per-feature `AsyncNotifier`s, `dioProvider`, `tokenStoreProvider`, `themeModeProvider`.
- UI state uses `AsyncValue` (loading / data / error) → every list screen has skeleton, empty, and error-with-retry states.

### 12.2 Navigation & role guards
- `go_router` with a `refreshListenable` bound to auth state.
- Redirect rules: unauthenticated → `/login`; `STUDENT` → shell `/home`, `/learning`, `/profile`; `TUTOR` → shell `/dashboard`, `/schedule`, `/bookings`, `/profile`; visiting the other role's path redirects to own home.
- Role shells use `StatefulShellRoute` with a role-specific navigation bar; the shell wraps its subtree in the role theme (`buildTheme(brightness, role: …)`).

### 12.3 Networking
- Single `Dio` instance: `baseUrl` from `String.fromEnvironment('API_BASE_URL')`, 15s timeouts.
- Interceptors: (1) auth header, (2) single-flight refresh on `401 TOKEN_EXPIRED`, (3) error mapper → `ApiError(code, message, fields)`, (4) debug logging (debug builds only).
- Offline/unreachable → friendly "Can't reach server" state with retry (copy in ARB).

### 12.4 Forms & validation
- Form validation mirrors Zod rules (email format, password policy, required fields, score 0–100, time range end > start).
- Server `fields` errors map back onto the form fields; first invalid field receives focus.

### 12.5 Data freshness (no realtime)
- Pull-to-refresh on all lists.
- Booking detail and tutor dashboard **poll every 15s** while visible (`Timer` paused on app background via `WidgetsBindingObserver`).
- Notification unread count refreshes every 30s and on app resume.

### 12.6 Theming, l10n, a11y
- Theme per [DESIGN §15](DESIGN.md#15-design-tokens-flutter-implementation); `ThemeMode.system` with manual override persisted.
- Strings only from ARB (`app_id.arb`, `app_en.arb`); no hard-coded copy.
- Semantics labels for icon-only buttons, charts, and status badges; supports 200% text scale; honors reduce-motion.

### 12.7 Platform configuration
- Android: `minSdk 24`; debug manifest sets `android:usesCleartextTraffic="true"` (debug only); `INTERNET` permission.
- iOS: deployment target 14+; debug-only ATS exception for local networking (`NSAllowsLocalNetworking`).
- Permissions: photo library (avatar) requested lazily.

## 13. Backend Requirements

### 13.1 Structure
```
src/
  app.ts            # express app: middleware + routes
  server.ts         # listen + scheduler start
  config/env.ts     # Zod-validated env, fail fast
  middleware/       # requestId, auth, requireRole, validate(zod), rateLimit, errorHandler
  modules/<name>/   # routes → controller → service → repo (+ schemas.ts)
  jobs/scheduler.ts
  lib/              # db (Prisma), logger, errors (AppError), time, ids
```

### 13.2 Middleware order
`requestId → pino-http → helmet → cors → json(1mb) → rateLimit → routes → notFound → errorHandler`

### 13.3 Rules
- Controllers parse/validate with Zod and call services; **no Prisma in controllers**.
- Services own transactions, policies, and the state machine; repositories are thin.
- All errors are `AppError(code, status, message, fields?)`, mapped by one handler to the error envelope.
- Uploads: images only, ≤ 2 MB, random filenames, served from `/static/avatars/*`.

## 14. Non-Functional Requirements

| Area | Target (local) | How |
|---|---|---|
| App performance | Cold start < 3s; 60fps scroll/animation | Const widgets, `ListView.builder`, image caching, no heavy work on UI thread |
| API performance | p95 < 300ms for list endpoints | Indexes, pagination, selective `include` |
| Correctness | No double booking under concurrent requests | Conditional slot claim + unique `slotId` + test |
| Reliability | Settlement and expiry idempotent | Status re-check in transaction |
| Security | Auth, validation, rate limits, least privilege | See §15 |
| Accessibility | WCAG 2.2 AA principles | Semantics, contrast tests, 48dp targets |
| Maintainability | ≥ 80% coverage on server services; state machine 100% | Vitest, code review |
| Portability | Android 7+ (API 24), iOS 14+ | Flutter stable defaults |

## 15. Security Requirements (Local Scope)

- Secrets only in `.env` (git-ignored); `.env.example` committed without real values.
- Validate every input with Zod; reject unknown fields on mutating routes.
- Parameterized queries via Prisma only; no raw SQL with user input.
- `helmet` defaults; CORS limited to dev origins (mobile apps don't need CORS, but keep it strict).
- Tokens only in secure storage on the device; never logged.
- Dev-only routes (`/dev/*`) are mounted only when `NODE_ENV !== production`.
- Uploads validated by MIME and size; stored outside any executable path.
- Logs must not contain passwords, tokens, or refresh values.
- Before any real deployment: HTTPS, real gateway with signed webhooks, secret management, backups — tracked as future work.

## 16. Testing Strategy

| Level | Tooling | Focus |
|---|---|---|
| Server unit | Vitest | State machine guards, fee calc, eligibility rule, slot generation, time conversion |
| Server API | Vitest + Supertest + `teachme_test` PostgreSQL (`prisma migrate reset` before the suite, truncate between tests) | Auth + refresh rotation, role/ownership 403s, booking happy path, **concurrent booking** (2 requests, 1 wins), settle idempotency, sweeper expiry |
| Mobile unit | flutter_test + mocktail | Repositories, controllers, validators, interceptors (refresh single-flight) |
| Mobile widget | flutter_test | Forms, `StatusBadge`, slot picker, role-based nav |
| Golden | flutter_test goldens | Key screens in light/dark × Student/Tutor |
| E2E | `integration_test` against local API | Register → book → accept → pay (simulate) → grade → progress → certificate |
| Theme | Unit | Contrast ratios for all token pairs |

**Definition of Done:** acceptance criteria met, tests added, `npm run lint && npm test` and `flutter analyze && flutter test` green, light + dark screenshots attached, docs updated.

## 17. Local Development Workflow

1. Repo root: `docker compose up -d db`. Then `server`: `.env` → `npm install` → `prisma migrate dev` → `npm run seed` → `npm run dev`.
2. `mobile`: `flutter pub get` → `build_runner` → `gen-l10n` → `flutter run --dart-define=API_BASE_URL=…`.
3. Reset data anytime with `npm run db:reset`.
4. Seed data: ~8 subjects, ~12 tutors with rules + slots, 3 students, a few bookings in every status, progress entries, and one earned certificate for demos.
5. Optional later: GitHub Actions for lint/test only (no deploy step).

### 17.1 Local PostgreSQL (`docker-compose.yml`)

```yaml
services:
  db:
    image: postgres:16-alpine
    container_name: teachme-db
    restart: unless-stopped
    environment:
      POSTGRES_USER: teachme
      POSTGRES_PASSWORD: teachme   # local only
      POSTGRES_DB: teachme
    ports:
      - "5432:5432"
    volumes:
      - teachme_pgdata:/var/lib/postgresql/data
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U teachme -d teachme"]
      interval: 5s
      timeout: 3s
      retries: 10

volumes:
  teachme_pgdata:
```

- `DATABASE_URL=postgresql://teachme:teachme@localhost:5432/teachme?schema=public`
- `TEST_DATABASE_URL=postgresql://teachme:teachme@localhost:5432/teachme_test?schema=public` (the test setup creates this database if missing).
- Credentials are for local development only and must never be reused elsewhere.
- Backup/restore locally: `docker exec teachme-db pg_dump -U teachme teachme > backup.sql`.

## 18. Open Technical Questions

1. Final gateway and hosting choice when leaving local-only mode.
2. Refund handling and its impact on the state machine.
3. Push notifications (FCM/APNs) vs polling when going beyond local.
4. PostgreSQL hosting option (managed service vs self-hosted) when leaving local-only mode?
5. Riverpod code generation (`riverpod_generator`) vs hand-written providers?
