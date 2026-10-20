# teachMe 🎓

> Find your tutor. Book a session. Watch your progress grow.

**teachMe** is a private-tutoring marketplace mobile app. Students discover tutors by subject, book a time slot, pay for the session, and track their learning progress. Tutors manage availability, accept bookings, and record scores and notes after each session.

Target users are Gen Z learners (junior high → early university) and young tutors (15–25), so the product is intentionally light, playful, and friendly.

- **Mobile:** Flutter (Android + iOS)
- **Backend:** Express (TypeScript) REST API
- **Runtime:** local only, no cloud deployment for now
- **Design system:** *Tutor Pulse* (see [`docs/DESIGN.md`](docs/DESIGN.md))

---

## Table of Contents

1. [Features](#features)
2. [Documentation](#documentation)
3. [Tech Stack](#tech-stack)
4. [Project Structure](#project-structure)
5. [Getting Started (Local)](#getting-started-local)
6. [Connecting the App to the Local API](#connecting-the-app-to-the-local-api)
7. [Environment Variables](#environment-variables)
8. [Scripts](#scripts)
9. [Roles & Demo Accounts](#roles--demo-accounts)
10. [Local Payments (Mock Gateway)](#local-payments-mock-gateway)
11. [Booking Lifecycle](#booking-lifecycle)
12. [Testing](#testing)
13. [Troubleshooting](#troubleshooting)
14. [Contributing](#contributing)

---

## Features

**Student**
- Register / log in with validation, choose the Student role
- Search tutors with filters (subject, price range, rating)
- Tutor detail: profile, subjects, reviews, available slots
- Book a slot and pay (simulated gateway locally)
- Booking history with clear status badges
- Progress screen: score chart per session, tutor notes, learning target
- Download a certificate when the target is reached
- Rate and review tutors after a completed session

**Tutor**
- Register / log in, choose the Tutor role
- Manage profile, subjects, and hourly rate
- Manage weekly availability and blocked dates (full CRUD)
- Accept or reject incoming bookings
- Input score + notes after each session
- Dashboard with stats, incoming requests, teaching history, and earnings

**Platform**
- Role-based navigation and theming (Student = coral, Tutor = teal)
- Transaction lifecycle: `PENDING → ACCEPTED → PAID → COMPLETED`
- Light and dark mode
- In-app notifications (inbox + unread badge)

## Documentation

| Document | Purpose |
|---|---|
| [`docs/PRD.md`](docs/PRD.md) | Product requirements, personas, user stories, acceptance criteria |
| [`docs/TRD.md`](docs/TRD.md) | Technical requirements, data model, API, mobile + backend requirements |
| [`docs/ARCHITECTURE.md`](docs/ARCHITECTURE.md) | System design, diagrams, flows, local topology, ADRs |
| [`docs/DESIGN.md`](docs/DESIGN.md) | Design system, tokens, Flutter theme, screen specs, copywriting |

## Tech Stack

| Layer | Choice |
|---|---|
| **Mobile framework** | Flutter (stable channel, Dart 3.x), Material 3 |
| State management | Riverpod |
| Navigation | go_router (role-based redirect guards) |
| HTTP | dio (auth + refresh interceptors) |
| Models | freezed + json_serializable |
| Secure storage | flutter_secure_storage (tokens), shared_preferences (theme) |
| Charts | fl_chart |
| Fonts | Montserrat (headline), Be Vietnam Pro (body/label) |
| i18n | flutter `gen-l10n` (ARB), Indonesian default |
| **Backend** | Node.js ≥ 20, Express, TypeScript |
| Database | PostgreSQL 16 via Prisma (runs locally in Docker Compose) |
| Validation | Zod |
| Auth | JWT access token + rotating refresh token, argon2 hashing |
| Scheduler | node-cron (in-process expiry sweeper) |
| PDF | pdfkit (certificates) |
| Uploads | Local disk (`server/storage/`) |
| Logging | pino |
| Testing | Vitest + Supertest (server); flutter_test, mocktail, integration_test (mobile) |

## Project Structure

```
teachme/
├─ mobile/                       # Flutter app
│  ├─ lib/
│  │  ├─ main.dart
│  │  ├─ app/                    # app.dart, router.dart, env.dart
│  │  ├─ core/
│  │  │  ├─ theme/               # tokens.dart, app_theme.dart
│  │  │  ├─ network/             # dio client, interceptors, api_error.dart
│  │  │  ├─ storage/             # secure token store, prefs
│  │  │  ├─ widgets/             # StatusBadge, AppButton, AnimatedProgressBar...
│  │  │  └─ l10n/                # app_id.arb, app_en.arb
│  │  └─ features/
│  │     ├─ auth/  tutors/  schedule/  booking/  payment/
│  │     ├─ progress/  review/  notifications/  profile/
│  │     │   ├─ data/            # DTOs, API client, repository impl
│  │     │   ├─ domain/          # entities, repository interfaces
│  │     │   └─ presentation/    # screens, widgets, Riverpod controllers
│  ├─ assets/                    # fonts, illustrations
│  ├─ test/  integration_test/
│  └─ pubspec.yaml
├─ server/                       # Express API
│  ├─ prisma/                    # schema.prisma, migrations, seed.ts
│  ├─ src/
│  │  ├─ app.ts  server.ts
│  │  ├─ config/env.ts
│  │  ├─ middleware/             # auth, requireRole, validate, error, rateLimit
│  │  ├─ modules/                # auth, users, tutors, schedule, booking,
│  │  │                          # payment, progress, review, notification
│  │  │   └─ <module>/           # routes, controller, service, repo, schemas
│  │  ├─ jobs/scheduler.ts       # expiry sweeper + slot materializer
│  │  └─ lib/                    # db, logger, errors, time
│  ├─ storage/                   # gitignored: avatars, certificates
│  ├─ tests/
│  ├─ .env.example
│  └─ package.json
├─ docker-compose.yml            # local PostgreSQL only
└─ docs/
```

## Getting Started (Local)

### Prerequisites
- Node.js ≥ 20 and npm
- Docker (to run PostgreSQL), or a locally installed PostgreSQL 16
- Flutter SDK (stable) with Android Studio and/or Xcode
- An Android emulator or iOS simulator (or a physical device on the same Wi-Fi)

Docker is used **only** to run PostgreSQL. The API and the app run directly on your machine. No cloud account needed.

### 1. Start the API

```bash
# from the repo root: start PostgreSQL (port 5432)
docker compose up -d db

cd server
cp .env.example .env
npm install
npx prisma migrate dev          # creates tables in the local PostgreSQL database
npm run seed                    # demo subjects, tutors, students, slots
npm run dev                     # http://localhost:3000
```

Check it: `curl http://localhost:3000/api/v1/health` → `{"status":"ok"}`.

### 2. Run the mobile app

```bash
cd mobile
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter gen-l10n
flutter run --dart-define=API_BASE_URL=http://10.0.2.2:3000/api/v1
```

Use the base URL that matches your target (next section).

### Local PostgreSQL

`docker-compose.yml` (repo root) starts a single PostgreSQL 16 container with a persistent volume:

| Setting | Value |
|---|---|
| Host / port | `localhost:5432` |
| Database | `teachme` (tests use `teachme_test`) |
| User / password | `teachme` / `teachme` (local only) |
| Volume | `teachme_pgdata` |

```bash
docker compose up -d db        # start
docker compose logs -f db      # logs
docker compose stop db         # stop (data kept)
docker compose down -v         # stop and DELETE all local data
```

Prefer a native install? Create a `teachme` database and user, then point `DATABASE_URL` at it.

## Connecting the App to the Local API

`localhost` inside an emulator points to the emulator itself, not your computer.

| Target | `API_BASE_URL` |
|---|---|
| Android emulator | `http://10.0.2.2:3000/api/v1` |
| iOS simulator | `http://localhost:3000/api/v1` |
| Physical device (same Wi-Fi) | `http://<your-computer-LAN-IP>:3000/api/v1` |

Notes:
- The server binds to `0.0.0.0` so physical devices can reach it.
- Plain HTTP is allowed **in debug builds only**: Android debug manifest sets `usesCleartextTraffic`, iOS uses an ATS exception for local networking.
- Allow the port through your computer's firewall for physical-device testing.

## Environment Variables

`server/.env`

| Variable | Default | Description |
|---|---|---|
| `NODE_ENV` | `development` | Environment |
| `PORT` | `3000` | API port |
| `HOST` | `0.0.0.0` | Bind address |
| `DATABASE_URL` | `postgresql://teachme:teachme@localhost:5432/teachme?schema=public` | PostgreSQL connection string |
| `TEST_DATABASE_URL` | `postgresql://teachme:teachme@localhost:5432/teachme_test?schema=public` | Separate database used by `npm test` |
| `JWT_ACCESS_SECRET` | — | Secret for access tokens (32+ chars) |
| `JWT_REFRESH_SECRET` | — | Secret for refresh tokens (32+ chars) |
| `ACCESS_TOKEN_TTL` | `15m` | Access token lifetime |
| `REFRESH_TOKEN_TTL` | `30d` | Refresh token lifetime |
| `PAYMENT_PROVIDER` | `mock` | `mock` for local simulation |
| `PLATFORM_FEE_PERCENT` | `10` | Commission on each session |
| `STORAGE_DIR` | `./storage` | Local uploads and certificates |

`mobile` is configured with `--dart-define` flags (`API_BASE_URL`), so no secrets live in the app.

## Scripts

**Server (`server/`)**

| Command | Description |
|---|---|
| `npm run dev` | Start with hot reload (tsx watch) |
| `npm run build` / `npm start` | Compile / run compiled output |
| `npm run lint` / `npm run typecheck` | ESLint / `tsc --noEmit` |
| `npm test` | Vitest + Supertest |
| `npm run seed` | Seed demo data |
| `npm run db:reset` | `prisma migrate reset --force` + seed (wipes local data) |
| `npx prisma studio` | Browse the database |

**Mobile (`mobile/`)**

| Command | Description |
|---|---|
| `flutter run --dart-define=API_BASE_URL=...` | Run the app |
| `dart run build_runner watch -d` | Regenerate freezed/json code |
| `flutter analyze` | Static analysis |
| `flutter test` | Unit + widget + golden tests |
| `flutter test integration_test` | End-to-end flow (needs running API + device) |

## Roles & Demo Accounts

After `npm run seed` (development only):

| Role | Email | Password |
|---|---|---|
| Student | `student@teachme.dev` | `Password123!` |
| Tutor | `tutor@teachme.dev` | `Password123!` |

Navigation, accent color, and permissions differ by role. Authorization is enforced by the API; hiding UI is never the only protection.

## Local Payments (Mock Gateway)

No real gateway is used locally. When a tutor accepts a booking:

1. The student taps **Pay now**; the API creates a `Payment` through `MockPaymentProvider`.
2. The app shows a sheet with simulated methods and a **"Simulate payment (dev)"** button.
3. The button calls a dev-only endpoint (`POST /api/v1/dev/payments/:orderId/settle`) that runs the same settlement logic a real webhook would.

The dev endpoint is disabled unless `NODE_ENV !== production`. A real gateway can later replace the mock via the `PaymentProvider` interface.

## Booking Lifecycle

```
PENDING ──(tutor accepts)──▶ ACCEPTED ──(payment settled)──▶ PAID ──(tutor grades)──▶ COMPLETED
   │                             │
   ├─(tutor rejects)─▶ REJECTED  ├─(payment window expires)─▶ EXPIRED
   └─(no response 24h)─▶ EXPIRED └─(student cancels)─▶ CANCELLED
```

Expiry is handled by an in-process scheduler that sweeps every minute. Full rules are in [`docs/TRD.md`](docs/TRD.md#5-booking-state-machine).

## Testing

```bash
# API
cd server && npm test

# App
cd mobile && flutter test
```

Critical flows covered: register/login + role guards, booking concurrency (two students, same slot), accept → pay → grade → progress → certificate.

## Troubleshooting

| Problem | Fix |
|---|---|
| App shows "Can't reach server" on Android emulator | Use `10.0.2.2`, not `localhost` |
| Physical device can't connect | Same Wi-Fi, use LAN IP, allow port 3000 in firewall |
| Cleartext HTTP blocked | Run a **debug** build; release builds require HTTPS |
| `build_runner` conflicts | `dart run build_runner build --delete-conflicting-outputs` |
| `Can't reach database server at localhost:5432` | Run `docker compose up -d db`; make sure no other PostgreSQL already uses port 5432 |
| Prisma schema changed | `npx prisma migrate dev` (or `npm run db:reset`) |
| Fonts look different | Run `flutter pub get`; confirm font assets/`google_fonts` are available |

## Contributing

- Branch from `main`: `feat/…`, `fix/…`, `docs/…`
- Conventional Commits (`feat: add slot picker`)
- PRs need passing analysis/tests and screenshots of UI changes (light + dark, both roles)
- Use design tokens/theme only; never hard-code colors or radii

## Out of Scope (for now)

Cloud deployment, CI/CD pipelines, push notifications, email delivery, real payment gateway, web/desktop targets.

## License

TBD.
