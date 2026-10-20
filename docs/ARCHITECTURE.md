# Architecture — teachMe

| | |
|---|---|
| **Status** | Draft v0.3 (Flutter + Express + PostgreSQL, local-only) |
| **Related** | [PRD](PRD.md) · [TRD](TRD.md) · [Design](DESIGN.md) |

---

## 1. Architecture Goals

| Goal | Implication |
|---|---|
| Ship the MVP fast with a small team | Monorepo, one mobile app + one API process, no extra infrastructure |
| Run anywhere on a laptop | PostgreSQL in Docker Compose, local disk, in-process scheduler, mock payment gateway |
| Money and scheduling must be correct | Single transactional state machine, conditional slot claim, idempotent settlement |
| Two different role experiences | Role-aware shells, routing guards, and theme accents in Flutter |
| Easy to grow later | Provider seams (payment, notification, storage) and portable schema |
| Safe by default | Server-side authorization, hashed secrets, audited transitions |

## 2. System Context (C4 — Level 1)

```mermaid
flowchart LR
    Student(("Student"))
    Tutor(("Tutor"))
    APP["teachMe Mobile App<br/>Flutter"]
    API["teachMe API<br/>Express + TypeScript"]
    DB[("PostgreSQL<br/>via Prisma")]
    FS[("Local disk<br/>avatars, certificates")]
    MOCK["Mock Payment Gateway<br/>in-process"]

    Student -->|"search, book, pay, track"| APP
    Tutor -->|"schedule, accept, grade"| APP
    APP -->|"HTTPS/HTTP + JWT"| API
    API --> DB
    API --> FS
    API --> MOCK
```

## 3. Local Runtime Topology (Containers — Level 2)

```mermaid
flowchart TB
    subgraph Dev["Developer machine"]
      subgraph Device["Emulator / Simulator / Physical phone"]
        APP["Flutter app"]
      end
      subgraph Node["Node.js process"]
        EX["Express API :3000"]
        CR["node-cron scheduler"]
        PRISMA["Prisma client"]
      end
      subgraph Docker["Docker Compose"]
        SQL[("PostgreSQL 16 :5432")]
      end
      STO[("server/storage/")]
    end

    APP -->|"10.0.2.2 Android emu<br/>localhost iOS sim<br/>LAN IP physical"| EX
    EX --> PRISMA --> SQL
    CR --> PRISMA
    EX --> STO
```

- **One server process** hosts HTTP routes and the scheduler; there is no queue, cache, or message broker.
- **PostgreSQL** is the only containerized piece (`docker compose up -d db`). Booking safety relies on an atomic conditional update inside a transaction, so correctness does not depend on the deployment.
- Moving later to a hosted environment means: point `DATABASE_URL` at a managed PostgreSQL, swap the mock provider for a real gateway, and move storage to object storage. No structural change.

## 4. Mobile Architecture (Flutter)

### 4.1 Layers

```mermaid
flowchart TB
    subgraph Presentation
      SC["Screens / Widgets"]
      CT["Riverpod Notifiers<br/>AsyncValue state"]
    end
    subgraph Domain
      EN["Entities"]
      RI["Repository interfaces"]
    end
    subgraph Data
      RP["Repository implementations"]
      DT["DTOs freezed + json"]
      AC["API clients - Dio"]
    end
    subgraph Core
      NET["Dio + interceptors"]
      SEC["Secure token store"]
      TH["Theme + tokens"]
      L10["l10n ARB"]
    end

    SC --> CT --> RI
    RI -.implemented by.-> RP
    RP --> DT
    RP --> AC --> NET
    NET --> SEC
    SC --> TH
    SC --> L10
```

Rules:
1. Widgets never call Dio directly; they watch Riverpod providers.
2. Domain has no Flutter or Dio imports.
3. DTO ↔ entity mapping lives in the data layer.
4. Each feature owns its folder: `features/<name>/{data,domain,presentation}`.

### 4.2 Role-aware shells and routing

```mermaid
flowchart TD
    START["App start"] --> TOK{"Tokens in secure storage?"}
    TOK -- No --> LOGIN["/login or /register"]
    TOK -- Yes --> ME["GET /me → role"]
    ME --> ROLE{"Role"}
    LOGIN -->|"auth success"| ROLE
    ROLE -- STUDENT --> SS["Student shell<br/>coral accent<br/>Home · Learning · Profile"]
    ROLE -- TUTOR --> TS["Tutor shell<br/>teal accent<br/>Dashboard · Schedule · Bookings · Profile"]
    SS -. "visits tutor route" .-> RED1["redirect to /home"]
    TS -. "visits student route" .-> RED2["redirect to /dashboard"]
```

- The router redirect is a **UX guard**. The API enforces the same rules independently.
- Each shell wraps its subtree with `Theme(data: buildTheme(brightness, role: …))`, so every widget picks up the right accent via `RoleAccent` without conditionals.

### 4.3 Networking and session handling

```mermaid
sequenceDiagram
    participant UI as Screen
    participant R as Repository
    participant D as Dio + interceptors
    participant API as Express API
    participant S as SecureStorage

    UI->>R: loadBookings()
    R->>D: GET /bookings
    D->>S: read accessToken
    D->>API: Authorization: Bearer ...
    API-->>D: 401 TOKEN_EXPIRED
    D->>D: lock (single-flight refresh)
    D->>API: POST /auth/refresh
    API-->>D: new access + refresh
    D->>S: persist tokens
    D->>API: retry GET /bookings
    API-->>R: 200 items
    R-->>UI: AsyncData
```

If refresh fails (revoked or expired) the interceptor clears storage and the auth state flips to signed-out, which triggers the router redirect to `/login`.

## 5. Backend Architecture (Express)

### 5.1 Module view

```mermaid
flowchart LR
    subgraph Http["HTTP layer"]
      MW["Middleware<br/>requestId, auth, requireRole,<br/>validate, rateLimit, errors"]
      RT["Routes + Controllers"]
    end

    subgraph Modules["Domain modules"]
      AU["auth"]
      US["users"]
      TU["tutors"]
      SCH["schedule"]
      BK["booking"]
      PAY["payment"]
      PRG["progress"]
      RV["review"]
      NT["notification"]
    end

    subgraph Infra["Infrastructure"]
      DB[("Prisma / PostgreSQL")]
      FS[("Local storage")]
      JOB["Scheduler"]
    end

    MW --> RT --> AU & US & TU & SCH & BK & PRG & RV & NT
    BK --> SCH
    BK --> PAY
    BK --> NT
    PRG --> BK
    PRG --> NT
    RV --> BK
    PAY --> BK
    JOB --> BK
    JOB --> SCH
    Modules --> DB
    PRG --> FS
    US --> FS
```

Rules:
1. Controller → service → repository. Controllers validate (Zod) and map responses only.
2. Services own business rules, policies, and transactions.
3. Modules call each other through service functions, never each other's repositories.
4. The booking state machine is the **only** code allowed to change `Booking.status`.
5. Dependencies are one-directional (enforced with `eslint-plugin-boundaries` or a simple import-lint rule).

### 5.2 Request lifecycle

```
request → requestId → pino-http → helmet → cors → json parser → rateLimit
        → authenticate (JWT) → requireRole → validate(zod) → controller
        → service (policy + transaction) → repository (Prisma)
        → response  |  AppError → errorHandler → error envelope
```

## 6. Key Flows

### 6.1 Register and login

```mermaid
sequenceDiagram
    actor U as User
    participant A as Flutter app
    participant API as Express
    participant DB as PostgreSQL
    U->>A: fill form (role chosen)
    A->>A: client validation
    A->>API: POST /auth/register
    API->>API: Zod validate + argon2 hash
    API->>DB: insert User + profile + refresh token hash
    API-->>A: 201 tokens + user
    A->>A: store tokens, set role
    A-->>U: navigate to role shell
```

### 6.2 Booking → acceptance → payment (local mock)

```mermaid
sequenceDiagram
    actor S as Student app
    actor T as Tutor app
    participant API as Express
    participant DB as PostgreSQL
    participant PP as MockPaymentProvider

    S->>API: POST /bookings {slotId, subjectId}
    API->>DB: TX: claim slot OPEN→HELD (count must be 1)
    API->>DB: insert Booking PENDING, respondBy = +24h, event, notification
    API-->>S: 201 PENDING
    Note over T: dashboard polls every 15s and sees the request
    T->>API: POST /bookings/:id/accept
    API->>DB: TX: status ACCEPTED, payBy = +2h, Payment CREATED, notify student
    Note over S: booking detail polls and shows "Accepted - pay now"
    S->>API: POST /bookings/:id/pay
    API->>PP: createCharge(orderId, amount)
    PP-->>API: simulated order (methods, reference)
    API-->>S: order info
    S->>API: POST /dev/payments/:orderId/settle
    API->>DB: TX: Payment SETTLED, Booking PAID, Slot BOOKED, events, notify both
    API-->>S: 200 PAID
```

### 6.3 Grading → progress → certificate

```mermaid
sequenceDiagram
    actor T as Tutor app
    participant API as Express
    participant DB as PostgreSQL
    participant FS as Local storage
    actor S as Student app

    T->>API: POST /bookings/:id/grade {score, note}
    API->>API: policy: owner tutor, status PAID, slot ended
    API->>DB: TX: insert ProgressEntry, Booking COMPLETED, event
    API->>API: evaluate eligibility (avg last 3 ≥ target AND sessions ≥ min)
    alt eligible and no certificate yet
        API->>FS: pdfkit → certificates/CODE.pdf
        API->>DB: insert Certificate, notify student
    end
    API-->>T: 200 COMPLETED
    S->>API: GET /progress, GET /notifications
    API-->>S: chart series, notes, certificate link
    S->>API: GET /certificates/:id/download
    API-->>S: PDF stream → open or share
```

### 6.4 Expiry sweeper

```mermaid
flowchart LR
    TICK["node-cron every minute"] --> Q1["find PENDING with respondBy < now"]
    TICK --> Q2["find ACCEPTED with payBy < now"]
    Q1 --> TX["per booking: TX re-check status"]
    Q2 --> TX
    TX -->|"still expected"| EXP["EXPIRED: free slot, cancel payment, event, notify both"]
    TX -->|"changed meanwhile"| SKIP["no-op"]
```

## 7. Data Architecture

- **PostgreSQL** is the system of record locally; the ERD is in [TRD §4](TRD.md#4-data-model).
- **Concurrency:** `slot.updateMany({ where: { id, status: "OPEN" }, data: { status: "HELD" } })` inside an interactive transaction; `count !== 1` → `409 SLOT_UNAVAILABLE`. A unique index on `Booking.slotId` is the backstop.
- **Auditability:** `BookingEvent` rows for every transition.
- **Notifications** are rows in `Notification`; the app reads them via polling (no push).
- **Time:** UTC on the wire and in storage; conversion on the device.
- **Money:** integer IDR; prices and fees snapshotted on the booking.
- **Seed/reset:** deterministic seed script makes demos and tests repeatable.

## 8. Cross-Cutting Concerns

| Concern | Approach |
|---|---|
| **AuthN** | JWT access (15m) + rotating hashed refresh tokens; argon2id |
| **AuthZ** | Router guard (UX) → `requireRole` → ownership policies in services |
| **Validation** | Zod on the server; mirrored rules in Flutter forms; server field errors map back to inputs |
| **Errors** | `AppError` → single error envelope → `ApiError` in the app → localized message |
| **Idempotency** | Optional `Idempotency-Key`; settlement idempotent on `orderId` |
| **Logging** | pino JSON logs with `requestId`, `userId`, `bookingId` |
| **Config** | Zod-validated `env.ts` on the server; `--dart-define` in the app |
| **i18n** | ARB files, Indonesian default, English secondary |
| **Theming** | `ThemeData` + `RoleAccent` extension; light/dark; role-based accent |
| **Freshness** | Pull-to-refresh + polling (15s detail/dashboard, 30s notification count) |

## 9. Security Architecture (Local)

```mermaid
flowchart LR
    APP["Flutter app<br/>tokens in secure storage"] -->|"Bearer JWT"| API["Express<br/>helmet · rate limit · Zod"]
    API --> POL["Policies<br/>role + ownership"]
    POL --> DB[("PostgreSQL")]
    DEV["/dev/* routes<br/>non-production only"] -.-> API
```

- Trust boundary is the API: everything from the app is untrusted until validated and authorized.
- Tokens never leave secure storage and are never logged.
- Dev-only routes exist only when `NODE_ENV !== production`.
- Cleartext HTTP is allowed in **debug builds only** for local development.

## 10. Local Development Setup

| Item | Decision |
|---|---|
| Processes | 1 API (`npm run dev`) + Flutter app (`flutter run`) + PostgreSQL container |
| Database | PostgreSQL container, data in Docker volume `teachme_pgdata` (`docker-compose.yml` at repo root) |
| Files | `server/storage/` (git-ignored) |
| Reset | `npm run db:reset` |
| Device access | Android emulator `10.0.2.2`, iOS simulator `localhost`, phone via LAN IP |
| Config | `server/.env`; `--dart-define=API_BASE_URL=…` |
| Deployment | Out of scope for now |

## 11. Architecture Decision Records (summary)

| ADR | Decision | Status | Trade-off |
|---|---|---|---|
| 001 | Flutter for mobile (Android + iOS) | Accepted | One codebase and rich animation; Dart ecosystem |
| 002 | Express + TypeScript modular monolith | Accepted | Simple and fast to build; boundaries enforced by convention/lint |
| 003 | PostgreSQL + Prisma (local via Docker Compose) | Accepted | Production-grade integrity, native enums/JSON, CHECK constraints; needs Docker or a local install |
| 004 | Riverpod for state | Accepted | Testable and scoped; learning curve vs `setState`/Provider |
| 005 | `go_router` with role shells | Accepted | Declarative guards; UX-only, API still authoritative |
| 006 | JWT access + rotating refresh tokens | Accepted | Mobile-friendly; requires refresh handling and single-flight lock |
| 007 | In-process `node-cron` sweeper (query-based) | Accepted | No queue to run; single-instance only |
| 008 | Slot **hold** at request time | Accepted | Prevents double booking; tutor slot blocked until response/expiry |
| 009 | Payment only **after** acceptance | Accepted | No refunds for rejected requests; one extra step for students |
| 010 | Mock payment behind `PaymentProvider` | Accepted | Full flow testable offline; must replace before real money |
| 011 | Polling instead of push/websocket | Accepted | Simple; slight latency and battery cost |
| 012 | Role accent via `ThemeExtension` | Accepted | One widget library, two identities |
| 013 | Conditional update (not `FOR UPDATE`) for slot claim | Accepted | One atomic statement, simple to reason about; row locks remain an option for multi-row workflows |

## 12. Evolution Path

1. **Hosted environment:** managed PostgreSQL, object storage, HTTPS, secret management, CI/CD.
2. **Real payments:** Midtrans/Xendit provider + signed webhook route; refunds in the state machine.
3. **Push notifications:** FCM/APNs replacing polling; email via provider.
4. **Realtime:** WebSocket/SSE for live status badges.
5. **Search:** PostgreSQL full-text, then a dedicated engine if needed.
6. **Chat and video:** in-app messaging, then session links.
7. **More clients:** Flutter web/desktop or an admin dashboard on the same API.
