# Design System & UX — teachMe ("Tutor Pulse")

| | |
|---|---|
| **Status** | Draft v0.2 (Flutter implementation) |
| **Source** | Tutor Pulse style-guide image + product design direction (Gen Z) |
| **Related** | [PRD](PRD.md) · [TRD](TRD.md) · [Architecture](ARCHITECTURE.md) |

---

## 1. Design Principles

1. **Playful, not childish.** Bold color and friendly copy, but clean structure.
2. **Light and airy.** Generous white space, card-based layout, large radii.
3. **Make progress feel alive.** Animated progress bars, badges, small celebrations.
4. **One system, two identities.** Shared components; Student (coral) and Tutor (teal) accents.
5. **Status is never ambiguous.** Booking state always visible via icon + label + color.
6. **Accessible by default.** WCAG 2.2 AA contrast, focus rings, reduced-motion support.
7. **Dark-mode friendly.** Every token has a light and dark value.

## 2. Reconciling the Style Guide with the Brief

The *Tutor Pulse* style guide defines a **purple** brand palette, while the product brief asks for **coral** (Student) and **teal** (Tutor) accents. Resolution:

| Layer | Source | Usage |
|---|---|---|
| **Brand / chrome** | Style guide: Primary purple `#8069BF`, Secondary `#7C7296`, Tertiary gold `#C9A74D`, Neutral `#79767D` | Logo, auth screens, shared surfaces, neutral buttons, tonal fills, charts' baseline, certificate |
| **Role accent** | Brief: Student coral, Tutor teal | Primary CTAs, active nav item, focus highlights, key stats, role-specific illustrations |
| **Semantic** | Standard | Status, success, warning, error |

Purple stays the **identity** of the product; the role accent is layered on top so each role instantly knows "which side" they are on.

## 3. Color System

> Values for the four key colors come from the style guide. Intermediate tones are indicative: regenerate exact ramps from the key colors (e.g. Material Theme Builder) before implementation and update the tokens file.

### 3.1 Brand palette (key colors + ramps)

| Tone | Primary (purple) | Secondary | Tertiary (gold) | Neutral |
|---|---|---|---|---|
| 10 | `#1F0A4D` | `#1C1530` | `#231B00` | `#1C1B1F` |
| 30 | `#4A3585` | `#4A4262` | `#5A4600` | `#48464C` |
| 40 | `#6A53A8` | — | — | — |
| 50 | **`#8069BF`** (key) | **`#7C7296`** (key) | `#8F7425` | **`#79767D`** (key) |
| 70 | `#B09DE8` | — | **`#C9A74D`** (key) | — |
| 80 | `#CBBDFA` | `#C9BFE2` | — | `#CAC5CC` |
| 90 | `#E7DEFF` | `#E8E0F5` | `#F5DE8F` | `#E6E1E9` |
| 95 | `#F4EEFF` | `#F5EFFC` | `#FFEFC4` | `#F4EFF4` |

### 3.2 Role accents

| Token | Student (coral) | Tutor (teal) | Notes |
|---|---|---|---|
| `accent-500` | `#FF6B57` | `#14B8A6` | Decorative fills, illustrations, chart lines |
| `accent-600` | `#CF3E2A` | `#0A8073` | **Filled buttons with white text** (≈4.8:1 contrast) |
| `accent-100` | `#FFE3DE` | `#CCF4EE` | Tonal backgrounds, selected chips |
| `accent-on` | `#FFFFFF` | `#FFFFFF` | Text/icon on `accent-600` |

> Text on `accent-500` must be dark (`#1F1A24`). Never place white text on `accent-500`.

### 3.3 Semantic & status colors

| Role | Light | Dark | Usage |
|---|---|---|---|
| `success` | `#1E8E5A` | `#5FD3A0` | Completed, confirmations |
| `warning` | `#8F7425` on `#FFEFC4` | `#F5DE8F` on `#3A2F08` | Pending |
| `error` | `#B3261E` | `#FFB4AB` | Rejected, delete, validation |
| `info` | `#6A53A8` on `#E7DEFF` | `#CBBDFA` on `#2B2146` | Accepted |
| `paid` | `#0A8073` on `#CCF4EE` | `#7FE3D6` on `#0B3A35` | Paid |

### 3.4 Surfaces & text

| Token | Light | Dark |
|---|---|---|
| `bg` | `#FDF9FF` | `#141218` |
| `surface` (cards, as in the style guide) | `#F1ECF4` | `#211F26` |
| `surface-raised` | `#FFFFFF` | `#2B2930` |
| `outline` | `#CAC5CC` | `#48464C` |
| `text-primary` | `#1C1B1F` | `#E6E1E9` |
| `text-secondary` | `#48464C` | `#CAC5CC` |
| `text-muted` | `#79767D` | `#938F99` |
| `brand` | `#4A3585` | `#CBBDFA` |

Avoid: navy-formal blues, rigid corporate greys, and large gradients. If a gradient is used (e.g. certificate or hero), limit to two adjacent tones of the same hue.

## 4. Typography

| Role | Font | Weights | Use |
|---|---|---|---|
| **Headline** | Montserrat | 600, 700, 800 | Screen titles, big numbers, hero copy |
| **Body** | Be Vietnam Pro | 400, 500 | Paragraphs, lists, inputs |
| **Label** | Be Vietnam Pro | 500, 600 | Buttons, chips, badges, nav labels |

Fallbacks: platform default sans-serif. In Flutter, load with the `google_fonts` package during development and bundle the TTFs under `assets/fonts/` so the app also works offline.

| Style | Size / Line height | Font | Weight |
|---|---|---|---|
| Display | 40 / 48 | Montserrat | 800 |
| H1 | 32 / 40 | Montserrat | 700 |
| H2 | 24 / 32 | Montserrat | 700 |
| H3 | 20 / 28 | Montserrat | 600 |
| Body L | 16 / 24 | Be Vietnam Pro | 400 |
| Body M | 14 / 20 | Be Vietnam Pro | 400 |
| Label L | 14 / 20 | Be Vietnam Pro | 600 |
| Label S | 12 / 16 | Be Vietnam Pro | 500 |

Headings are large and decisive; body text never goes below 14px; line length ≤ 70 characters.

## 5. Shape, Spacing, Elevation

| Token | Value | Notes |
|---|---|---|
| `radius-sm` | 12px | Inputs, chips |
| `radius-md` | 16px | Buttons, small cards |
| `radius-lg` | 20px | Main cards, sheets |
| `radius-full` | 999px | Pills, avatars, icon buttons, bottom nav |
| Spacing scale | 4 · 8 · 12 · 16 · 24 · 32 · 48 · 64 | 8-pt rhythm |
| Page padding | 16 (mobile) · 24 (tablet) · 32 (desktop) | |
| Elevation | Mostly flat; cards use tonal `surface` + 1px `outline`; shadow only for floating (sheet, FAB, nav) | |

No sharp corners anywhere in the UI.

## 6. Iconography & Illustration

- **Icons:** rounded, friendly line icons (Material Symbols Rounded via `material_symbols_icons`, weight 400–500, size 24). The style guide uses: home, search, person, magic wand, shapes, tag, pencil, trash.
- **Illustrations:** flat or semi-3D, blobby shapes, soft shadows; character/objects (books, pencil, trophy, stars). Used for empty states, onboarding, celebration.
- **Emoji** are welcome in copy and notifications (sparingly: max 1–2 per message).
- Never use technical or "enterprise" iconography (gears, databases) in user-facing screens.

## 7. Components

All components come in light/dark and Student/Tutor accents. Touch targets ≥ 48×48dp.

### 7.1 Buttons

| Variant | Style (from style guide) | Use |
|---|---|---|
| **Primary** | Filled with deep brand/accent color, white label | Main action per screen (Book, Pay, Accept) |
| **Secondary** | Tonal: light neutral-purple fill, dark label | Alternative action (Save draft, Filter) |
| **Inverted** | Dark neutral fill, light label | On light hero cards, emphasis |
| **Outlined** | 1px outline, transparent fill | Tertiary action (Cancel, Reject) |

Radius 12–16px, label 14/600. States: default, hover, pressed (scale 0.98), focus-visible (2px ring + 2px offset), disabled (40% opacity, no shadow), loading (spinner replaces icon, width stays).

### 7.2 Search field
Rounded 12px, tonal `surface` fill, leading search icon, placeholder "Search tutors or subjects…", clear button when filled. Sticky on the Student Home.

### 7.3 Progress bar
Thin (8px), fully rounded track; fill animates from 0 → value in 600ms (ease-out) on first view. Three semantic fills per the style guide: **primary** (overall progress), **secondary** (sessions done), **tertiary/gold** (target / streak). Always paired with a text value for accessibility.

### 7.4 Bottom navigation (mobile)
Floating pill container on a tonal surface; active item is a filled circle in the **role accent** with a white icon; inactive items are icon-only with a tooltip/label on long-press and accessible names. Wide screens (≥ 600dp, e.g. tablets) switch to a `NavigationRail`.

| Role | Items |
|---|---|
| Student | Home · Learning · Profile |
| Tutor | Dashboard · Schedule · Bookings · Profile |

### 7.5 Floating action button & icon buttons
- **FAB / edit button:** square-rounded (16px) in **tertiary gold** with a pencil icon (edit profile / edit slot).
- **Labeled action:** accent-colored rounded rectangle with icon + label ("✎ Label").
- **Circular icon buttons:** 40px circles — primary (magic wand → "Smart match"), secondary (shapes → categories), tertiary olive (tag → price), error red (trash → delete). Delete always asks for confirmation.

### 7.6 Cards
`surface` fill, `radius-lg`, padding 16–24, no heavy shadow. Hover/press lifts by 2px with a subtle shadow. Cards are the main layout primitive (tutor card, stat card, booking card, chart card).

### 7.7 Status badges (transaction states)

Rounded pill, icon + label, 12/500 text. Never rely on color alone.

| Status | Label (UI) | Icon | Color tokens |
|---|---|---|---|
| `PENDING` | Waiting ⏳ | hourglass | warning |
| `ACCEPTED` | Accepted ✅ — pay now | check-circle | info |
| `PAID` | Paid 💸 | credit-card | paid |
| `COMPLETED` | Done 🎉 | party / star | success |
| `REJECTED` | Declined | x-circle | error |
| `CANCELLED` | Cancelled | slash | text-muted |
| `EXPIRED` | Expired | clock-off | text-muted |

**Stepper:** on the booking detail, a 4-step horizontal tracker `Pending → Accepted → Paid → Completed` highlights the current step, with a bounce on change. Timestamps appear under each completed step.

### 7.8 Forms & validation
- Floating or top labels, 12px radius, 48px height.
- Validation on blur and on submit; inline message under the field in `error` color with an icon; the first invalid field is focused.
- Password field has show/hide toggle and a strength hint.
- Role selection on register uses two large **choice cards** (Student 🎒 coral / Tutor 🧑‍🏫 teal) that preview each accent.

### 7.9 Other components
Chips (subject filters), rating stars (tap target ≥ 32px, half-star display), slot pill (selected = accent fill), segmented control, bottom sheet (filters, payment), toast/snackbar, skeleton loaders, avatar with tutor "verified" tick, empty-state illustration, confirm dialog.

### 7.10 Flutter widget mapping

| Design component | Flutter implementation |
|---|---|
| Primary / Secondary / Outlined button | `FilledButton` / `FilledButton.tonal` / `OutlinedButton` (themed in `ThemeData`) |
| Inverted button | `AppButton.inverted` (custom wrapper around `FilledButton`) |
| Search field | `SearchBar` or `TextField` with `InputDecorationTheme` |
| Progress bar | `AnimatedProgressBar` (`TweenAnimationBuilder` + rounded `ClipRRect`) |
| Bottom navigation | Custom floating `AppNavBar`; `NavigationRail` on wide screens |
| FAB / edit button | `FloatingActionButton` (gold, 16dp radius) |
| Cards | `Card` (elevation 0, 20dp radius, tonal color) |
| Status badge / stepper | `StatusBadge`, `BookingStepper` (single source of truth) |
| Charts | `fl_chart` `LineChart` with accent line + gold target line |
| Bottom sheets | `showModalBottomSheet` (filters, schedule form, payment) |
| Skeletons | `shimmer` placeholders |
| Toasts | `ScaffoldMessenger` snackbars (floating, rounded) |

## 8. Motion & Microinteractions

| Moment | Behavior | Duration / easing |
|---|---|---|
| Progress bars & chart lines | Animate in on first view | 600ms ease-out |
| Status badge change | Scale-in + soft confetti dots for `COMPLETED` | 300ms spring |
| Slot selection | Pill fills with accent, slight bounce | 150ms |
| Rating tap | Stars pop sequentially | 40ms stagger |
| Certificate unlocked | Trophy bounce + gold shimmer | 800ms, once |
| Button press | `scale(0.98)` | 100ms |
| Page transitions | Fade/slide 8px | 200ms |

When `MediaQuery.disableAnimationsOf(context)` is true → disable transforms/confetti and keep instant state changes.

## 9. Copywriting & Tone

Casual, supportive, short. Emoji-friendly but not spammy. Avoid formal/bureaucratic language, blame, and jargon.

| Context | ❌ Avoid | ✅ Use (Indonesian default) | English meaning |
|---|---|---|---|
| Home heading | "Silakan pilih menu" | "Yuk, mulai belajar! 📚" | Let's start learning! |
| Empty search | "Data tidak ditemukan" | "Belum ada tentor yang cocok. Coba ubah filter ya!" | No tutors match yet. Try changing filters! |
| Booking sent | "Permintaan terkirim" | "Terkirim! Tunggu tentornya konfirmasi ya ⏳" | Sent! Wait for the tutor to confirm |
| Accepted | "Booking disetujui" | "Yay, diterima! Yuk bayar biar jadwalnya aman ✅" | Accepted! Pay to lock in your slot |
| Paid | "Pembayaran berhasil" | "Beres! Sampai ketemu di sesi les 💪" | Done! See you at the session |
| Completed | "Sesi selesai" | "Sesi kelar! Cek nilai & catatan barumu 🎉" | Session done! Check your new score |
| Rejected | "Booking ditolak" | "Yah, tentornya lagi nggak bisa. Cari jadwal lain yuk!" | Tutor can't make it. Find another slot! |
| Field error | "Input tidak valid" | "Emailnya kayaknya belum bener deh 🤔" | Email doesn't look right |
| Certificate | "Sertifikat tersedia" | "Targetmu tercapai! Sertifikatmu siap diunduh 🏆" | Target reached! Certificate ready |
| Tutor grading | "Input nilai" | "Gimana progres muridmu hari ini?" | How did your student do today? |

All strings live in Flutter `gen-l10n` ARB files (`app_id.arb` default, `app_en.arb` secondary).

## 10. Dark Mode

- Follows the system setting (`ThemeMode.system`); manual toggle in Profile, persisted locally with `shared_preferences`.
- Surfaces step up in lightness for elevation (`bg` → `surface` → `surface-raised`) rather than using shadows.
- Role accents use lighter tones in dark mode (`accent-300`) for text/icons, while filled buttons keep `accent-600` with white text.
- Illustrations use tonal variants; charts use a 20% lighter palette.
- Verify contrast for every token pair in both themes (automated in a unit test over the built `ThemeData`).

## 11. Screen Specifications

Wireframes are low-fidelity mobile layouts. Student = coral accent, Tutor = teal accent.

### 11.1 Login / Register

```
┌──────────────────────────┐
│  🎓 teachMe              │
│  Hey, welcome back!      │
│                          │
│  ┌────────┐ ┌────────┐   │  ← role choice cards (register)
│  │ 🎒     │ │ 🧑‍🏫    │   │
│  │ Student│ │ Tutor  │   │
│  └────────┘ └────────┘   │
│  [ Email              ]  │
│  [ Password        👁 ]  │
│  [   Let's go →      ]   │  Primary
│  New here? Create account│
└──────────────────────────┘
```
- Tabs/toggle: Login | Register. Register adds name + role choice.
- Validation inline; submit disabled while loading.
- Background: brand purple hero blob + playful illustration.

### 11.2 Student Home — Search & Tutor List

```
┌──────────────────────────┐
│ Hi, Alya 👋              │
│ Yuk, mulai belajar!      │
│ [🔍 Search tutors...   ] │
│ (Math)(Physics)(English)→│  subject chips
│ [Price ▾][Rating ▾][⚙]   │
│ ┌──────────────────────┐ │
│ │ 👤 Bima  ✔  ⭐4.9    │ │  Tutor card
│ │ Math · Physics       │ │
│ │ Rp75.000/hr          │ │
│ │ Next: Today 16:00 [Book]│
│ └──────────────────────┘ │
│  …                       │
│ ( 🏠 )  🔍   👤          │  bottom nav
└──────────────────────────┘
```
- States: loading skeletons, empty (illustration + tip), error (retry).
- Filters open in a bottom sheet; applied filters shown as removable chips.

### 11.3 Tutor Detail

```
┌──────────────────────────┐
│ ←                  ♡     │
│  👤 Bima  ✔ Verified      │
│  ⭐ 4.9 (128)  · 240 sessions│
│  Math · Physics          │
│  About: …                │
│  ── Pick a time ──        │
│  Mon 21  Tue 22  Wed 23  │  date strip
│  (16:00)(17:00)( 18:00 ) │  slot pills
│  ── Reviews ──            │
│  ⭐⭐⭐⭐⭐ "Super sabar!"  │
│ ┌──────────────────────┐ │
│ │ Rp75.000   [Book now]│ │  sticky bottom bar
│ └──────────────────────┘ │
└──────────────────────────┘
```
- Booking CTA disabled until a slot and subject are chosen.

### 11.4 Booking & Payment

```
Step bar: ① Details → ② Wait for tutor → ③ Pay
┌──────────────────────────┐
│ Booking summary card     │
│ Math · Mon 21, 16:00     │
│ Tutor: Bima              │
│ Note: [ optional ]       │
│ Price     Rp75.000       │
│ Total     Rp75.000       │
│ Status:  [Waiting ⏳]    │
│ [ Send request ]         │   → after acceptance: [ Pay now ]
└──────────────────────────┘
```
- After acceptance a **countdown** shows time left to pay (2h). "Pay now" opens a bottom sheet listing simulated methods (e-wallet, virtual account, QRIS) with a clearly labeled **"Simulate payment (dev)"** button; no real money moves in local mode.
- Terminal states (Declined/Expired) offer "Find another slot".

### 11.5 Student History & Progress

```
┌──────────────────────────┐
│ My Learning 📈           │
│ [Subject ▾] [Tutor ▾]    │
│ ┌──────────────────────┐ │
│ │ Score per session    │ │  line chart, accent color
│ │  ╱╲  ╱─              │ │  target line in gold
│ └──────────────────────┘ │
│ Target 80  ▓▓▓▓▓▓░░ 6/8  │  progress bars (primary/secondary/tertiary)
│ 🏆 Certificate  [Download]│  locked until target reached
│ ── History ──             │
│ Math · Mon 14 [Done 🎉]  │
│   Score 82 · "Nice work!"│
│   [Rate tutor ⭐]        │
└──────────────────────────┘
```
- Tabs: **Progress** | **History**. Filters by status in History.
- Certificate card: locked state (grey + progress to unlock), unlocked state (gold shimmer + download).

### 11.6 Tutor Dashboard

```
┌──────────────────────────┐
│ Hey Bima! 👋              │
│ ┌────────┐ ┌────────┐    │  stat cards
│ │ 6      │ │ Rp1.2M │    │
│ │ This wk│ │ Earned │    │
│ └────────┘ └────────┘    │
│ ┌────────┐ ┌────────┐    │
│ │ ⭐ 4.9 │ │ 3 new  │    │
│ └────────┘ └────────┘    │
│ ── Incoming requests ──   │
│ Alya · Math · Mon 16:00  │
│ [Waiting ⏳] [✓ Accept] [Decline]│
│ ── Upcoming sessions ──   │
│ ── Needs grading ──       │
│ Dashboard Schedule Bookings Me│
└──────────────────────────┘
```
- Accent: teal. Request cards show a response countdown. "Needs grading" is highlighted in gold.

### 11.7 Manage Schedule (CRUD)

```
┌──────────────────────────┐
│ My Schedule 🗓           │
│ [Weekly] [Exceptions]    │
│ Mon  16:00–20:00  ✎ 🗑   │
│ Tue  —            ＋     │
│ Wed  18:00–21:00  ✎ 🗑   │
│ …                        │
│                    [＋ Add]│  FAB
│ ── This week preview ──   │
│ slot pills: open/held/booked │
└──────────────────────────┘
```
- Create/edit via bottom sheet (day, start, end, repeat). Delete asks for confirmation and explains that booked slots stay.
- Legend for slot states: Open (outline), Held (gold), Booked (teal fill).

### 11.8 Input Score by Tutor

```
┌──────────────────────────┐
│ ← Grade session          │
│ Alya · Math · Mon 21     │
│ Gimana progres muridmu?  │
│ Score  [ 82 ]  slider 0–100│
│ Notes  [ multi-line … ]  │
│ Quick tags: (Focused)(Needs practice)(Great progress)│
│ [ Save & finish session ]│
└──────────────────────────┘
```
- Only available for `PAID` bookings after the slot end time.
- Success: badge flips to **Done 🎉** with confetti; toast "Nilai tersimpan!".

## 12. Role-Based Navigation Summary

| Area | Student (coral) | Tutor (teal) |
|---|---|---|
| Home route | `/home` | `/dashboard` |
| Primary nav | Home · Learning · Profile | Dashboard · Schedule · Bookings · Profile |
| Primary CTA | Book, Pay | Accept, Add slot, Save grade |
| Hero stat | Learning progress | Earnings & pending requests |
| Charts | Score trend | Sessions & earnings |

## 13. Accessibility Checklist

- Text contrast ≥ 4.5:1 (≥ 3:1 for large text and UI components) in both themes.
- Visible focus indication for keyboard/switch-access users; logical traversal order (`FocusTraversalGroup`).
- Touch targets ≥ 48×48dp.
- Status, errors, and chart meaning never rely on color alone (icon, label, pattern, or data labels).
- Charts have a text/table alternative and a `Semantics` label summarizing the trend.
- Form fields expose labels via `Semantics`; errors are announced (`liveRegion: true`).
- Respect the OS reduce-motion, dark-mode, and font-scale settings (test at 200% text scale).
- Emoji are decorative; critical info is in text.

## 14. Responsive Behavior

| Width (dp) | Layout |
|---|---|
| < 600 | Phone: single column, floating bottom nav, sticky CTA bars |
| 600–840 | Large phone landscape / small tablet: two-column card grids, `NavigationRail` |
| > 840 | Tablet: three-column dashboard grid, side-panel filters, content max width 1000dp |

Implementation: a small `Breakpoints` helper using `MediaQuery.sizeOf(context)` / `LayoutBuilder`. Phones are portrait-first; landscape must not break layouts.

## 15. Design Tokens (Flutter implementation)

`lib/core/theme/tokens.dart`

```dart
import 'package:flutter/material.dart';

enum AppRole { student, tutor }

abstract final class Brand {
  static const primary = Color(0xFF8069BF);
  static const primaryDeep = Color(0xFF4A3585);
  static const secondary = Color(0xFF7C7296);
  static const tertiary = Color(0xFFC9A74D);
  static const neutral = Color(0xFF79767D);
}

abstract final class Radii {
  static const double sm = 12, md = 16, lg = 20, full = 999;
}

@immutable
class RoleAccent extends ThemeExtension<RoleAccent> {
  const RoleAccent({required this.c500, required this.c600, required this.c100});
  final Color c500; // decorative fills, chart lines (dark text on top)
  final Color c600; // filled buttons (white text)
  final Color c100; // tonal backgrounds

  static const brand = RoleAccent(c500: Brand.primary, c600: Brand.primaryDeep, c100: Color(0xFFE7DEFF));
  static const student = RoleAccent(c500: Color(0xFFFF6B57), c600: Color(0xFFCF3E2A), c100: Color(0xFFFFE3DE));
  static const tutor = RoleAccent(c500: Color(0xFF14B8A6), c600: Color(0xFF0A8073), c100: Color(0xFFCCF4EE));

  @override
  RoleAccent copyWith({Color? c500, Color? c600, Color? c100}) =>
      RoleAccent(c500: c500 ?? this.c500, c600: c600 ?? this.c600, c100: c100 ?? this.c100);

  @override
  RoleAccent lerp(ThemeExtension<RoleAccent>? other, double t) {
    if (other is! RoleAccent) return this;
    return RoleAccent(
      c500: Color.lerp(c500, other.c500, t)!,
      c600: Color.lerp(c600, other.c600, t)!,
      c100: Color.lerp(c100, other.c100, t)!,
    );
  }
}
```

`lib/core/theme/app_theme.dart`

```dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'tokens.dart';

ThemeData buildTheme(Brightness brightness, {AppRole? role}) {
  final dark = brightness == Brightness.dark;
  final accent = switch (role) {
    AppRole.student => RoleAccent.student,
    AppRole.tutor => RoleAccent.tutor,
    null => RoleAccent.brand, // auth screens
  };

  final bg = dark ? const Color(0xFF141218) : const Color(0xFFFDF9FF);
  final surface = dark ? const Color(0xFF211F26) : const Color(0xFFF1ECF4);
  final outline = dark ? const Color(0xFF48464C) : const Color(0xFFCAC5CC);
  final text = dark ? const Color(0xFFE6E1E9) : const Color(0xFF1C1B1F);

  final scheme = ColorScheme(
    brightness: brightness,
    primary: accent.c600,
    onPrimary: Colors.white,
    secondary: Brand.secondary,
    onSecondary: Colors.white,
    tertiary: Brand.tertiary,
    onTertiary: const Color(0xFF231B00),
    error: dark ? const Color(0xFFFFB4AB) : const Color(0xFFB3261E),
    onError: dark ? const Color(0xFF690005) : Colors.white,
    surface: bg,
    onSurface: text,
    outline: outline,
  );

  TextStyle head(double size, double line, FontWeight w) =>
      GoogleFonts.montserrat(fontSize: size, height: line / size, fontWeight: w);

  final textTheme = GoogleFonts.beVietnamProTextTheme().copyWith(
    displayLarge: head(40, 48, FontWeight.w800),
    headlineLarge: head(32, 40, FontWeight.w700),
    headlineMedium: head(24, 32, FontWeight.w700),
    headlineSmall: head(20, 28, FontWeight.w600),
    labelLarge: GoogleFonts.beVietnamPro(fontSize: 14, fontWeight: FontWeight.w600),
    labelSmall: GoogleFonts.beVietnamPro(fontSize: 12, fontWeight: FontWeight.w500),
  ).apply(bodyColor: text, displayColor: text);

  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    scaffoldBackgroundColor: bg,
    textTheme: textTheme,
    extensions: [accent],
    cardTheme: CardThemeData(
      color: surface,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Radii.lg)),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: const Size(64, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Radii.md)),
        textStyle: textTheme.labelLarge,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(64, 48),
        side: BorderSide(color: outline),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Radii.md)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: surface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Radii.sm),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Radii.sm),
        borderSide: BorderSide(color: accent.c600, width: 2),
      ),
    ),
  );
}
```

**Usage**

```dart
// app.dart
MaterialApp.router(
  theme: buildTheme(Brightness.light, role: role),
  darkTheme: buildTheme(Brightness.dark, role: role),
  themeMode: themeMode, // system by default
  routerConfig: router,
);

// in a widget
final accent = Theme.of(context).extension<RoleAccent>()!;
```

`role` comes from the auth state (Riverpod): `null` before login, then `student` or `tutor`. Widgets never hard-code hex values or radii.

## 16. Design QA Checklist (per screen)

- [ ] Uses tokens/theme only (no raw `Color(0x…)`, no ad-hoc radii)
- [ ] Verified in light and dark mode, Student and Tutor accents
- [ ] Loading, empty, error, and success states designed
- [ ] Status badges use the shared `StatusBadge`
- [ ] Copy follows the tone guide and lives in ARB files
- [ ] Contrast, touch-target, and 200% text-scale checks pass
- [ ] Motion respects the reduce-motion setting
- [ ] Works at 360dp width and on a tablet
