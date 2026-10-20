import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:teachme_mobile/core/theme/tokens.dart';
import 'package:teachme_mobile/core/widgets/app_button.dart';
import 'package:teachme_mobile/core/widgets/avatar_widget.dart';
import 'package:teachme_mobile/core/widgets/error_state.dart';
import 'package:teachme_mobile/core/widgets/skeleton_loader.dart';
import 'package:teachme_mobile/features/booking/data/booking_api.dart';
import 'package:teachme_mobile/features/booking/data/booking_dto.dart';
import 'package:teachme_mobile/features/tutors/data/tutor_api.dart';
import 'package:teachme_mobile/features/tutors/data/tutor_dto.dart';

final tutorDetailProvider = FutureProvider.family<TutorDetail, String>(
  (ref, id) => ref.watch(tutorApiProvider).getTutorDetail(id),
);

final tutorSlotsProvider = FutureProvider.family<List<SlotDto>, String>((ref, id) {
  final now = DateTime.now();
  final from = now.toUtc().toIso8601String();
  final to = now.add(const Duration(days: 14)).toUtc().toIso8601String();
  return ref.watch(tutorApiProvider).getTutorSlots(id, from, to);
});

final tutorReviewsProvider = FutureProvider.family<PaginatedReviews, String>(
  (ref, id) => ref.watch(tutorApiProvider).getTutorReviews(id),
);

class TutorDetailScreen extends ConsumerStatefulWidget {
  const TutorDetailScreen({super.key, required this.tutorId});

  final String tutorId;

  @override
  ConsumerState<TutorDetailScreen> createState() => _TutorDetailScreenState();
}

class _TutorDetailScreenState extends ConsumerState<TutorDetailScreen> {
  final NumberFormat _currency =
      NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);

  String? _selectedSubjectId;
  SlotDto? _selectedSlot;
  DateTime _selectedDate = DateTime.now();
  bool _submitting = false;

  bool _sameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  List<DateTime> get _days {
    final now = DateTime.now();
    final start = DateTime(now.year, now.month, now.day);
    return List.generate(14, (i) => start.add(Duration(days: i)));
  }

  Future<void> _submit() async {
    final slot = _selectedSlot;
    final subjectId = _selectedSubjectId;
    if (slot == null || subjectId == null) return;

    setState(() => _submitting = true);
    try {
      final booking = await ref.read(bookingApiProvider).createBooking(
            CreateBookingRequest(slotId: slot.id, subjectId: subjectId),
          );
      if (!mounted) return;
      context.push('/bookings/${booking.id}');
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal membuat pesanan. Coba lagi ya.')),
      );
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accent = theme.extension<RoleAccent>() ?? RoleAccent.student;
    final detailAsync = ref.watch(tutorDetailProvider(widget.tutorId));

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_rounded),
              onPressed: () => context.pop(),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.favorite_border_rounded),
                onPressed: () {},
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                detailAsync.value?.name ?? 'Detail Tentor',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          ...detailAsync.when(
            data: (detail) => _content(context, theme, accent, detail),
            loading: () => [_loading()],
            error: (_, _) => [
              SliverFillRemaining(
                hasScrollBody: false,
                child: ErrorState(
                  message: 'Gagal memuat detail tentor',
                  onRetry: () => ref.invalidate(tutorDetailProvider(widget.tutorId)),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: _bottomBar(context, theme, accent, detailAsync.value),
    );
  }

  List<Widget> _content(
    BuildContext context,
    ThemeData theme,
    RoleAccent accent,
    TutorDetail detail,
  ) {
    if (_selectedSubjectId == null && detail.subjects.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && _selectedSubjectId == null) {
          setState(() => _selectedSubjectId = detail.subjects.first.subjectId);
        }
      });
    }

    final slotsAsync = ref.watch(tutorSlotsProvider(widget.tutorId));
    final reviewsAsync = ref.watch(tutorReviewsProvider(widget.tutorId));

    return [
      SliverPadding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
        sliver: SliverToBoxAdapter(child: _profileCard(context, theme, accent, detail)),
      ),
      SliverPadding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
        sliver: SliverToBoxAdapter(
          child: Text(
            'Pilih Mata Pelajaran',
            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
        ),
      ),
      SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        sliver: SliverToBoxAdapter(child: _subjectChips(context, theme, accent, detail)),
      ),
      SliverPadding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
        sliver: SliverToBoxAdapter(
          child: Text(
            'Pilih Waktu Belajar',
            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
        ),
      ),
      SliverToBoxAdapter(child: _dateStrip(context, theme, accent)),
      SliverPadding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
        sliver: SliverToBoxAdapter(
          child: slotsAsync.when(
            data: (slots) => _slotPills(context, theme, accent, slots),
            loading: () => const SkeletonLoader(width: double.infinity, height: 44),
            error: (_, _) => Text(
              'Gagal memuat jadwal',
              style: theme.textTheme.bodyMedium?.copyWith(color: Brand.neutral),
            ),
          ),
        ),
      ),
      SliverPadding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
        sliver: SliverToBoxAdapter(
          child: Text(
            'Ulasan Murid',
            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
        ),
      ),
      reviewsAsync.when(
        data: (reviews) => _reviewSlivers(context, theme, accent, reviews),
        loading: () => SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          sliver: SliverList.separated(
            itemCount: 2,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (_, _) => const SkeletonLoader(width: double.infinity, height: 88),
          ),
        ),
        error: (_, _) => SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          sliver: SliverToBoxAdapter(
            child: Text(
              'Gagal memuat ulasan',
              style: theme.textTheme.bodyMedium?.copyWith(color: Brand.neutral),
            ),
          ),
        ),
      ),
      const SliverToBoxAdapter(child: SizedBox(height: 24)),
    ];
  }

  Widget _profileCard(
    BuildContext context,
    ThemeData theme,
    RoleAccent accent,
    TutorDetail detail,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AvatarWidget(
                  imageUrl: detail.avatarUrl,
                  size: 80,
                  isVerified: detail.isVerified,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        detail.name,
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.star_rounded, size: 20, color: Brand.tertiary),
                          const SizedBox(width: 4),
                          Text(
                            detail.ratingAvg > 0
                                ? detail.ratingAvg.toStringAsFixed(1)
                                : 'Baru',
                            style: theme.textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '(${detail.ratingCount} ulasan)',
                            style: theme.textTheme.bodySmall?.copyWith(color: Brand.neutral),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (detail.bio != null && detail.bio!.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text(
                detail.bio!,
                style: theme.textTheme.bodyMedium?.copyWith(color: Brand.neutral),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _subjectChips(
    BuildContext context,
    ThemeData theme,
    RoleAccent accent,
    TutorDetail detail,
  ) {
    if (detail.subjects.isEmpty) {
      return Text(
        'Belum ada mata pelajaran',
        style: theme.textTheme.bodyMedium?.copyWith(color: Brand.neutral),
      );
    }

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: detail.subjects.map((s) {
        final isSelected = _selectedSubjectId == s.subjectId;
        return ChoiceChip(
          label: Text('${s.subjectName} · ${_currency.format(s.priceIdr)}'),
          selected: isSelected,
          onSelected: (_) {
            setState(() {
              _selectedSubjectId = s.subjectId;
              _selectedSlot = null;
            });
          },
          selectedColor: accent.c100,
          backgroundColor: theme.cardTheme.color,
          labelStyle: TextStyle(
            color: isSelected ? accent.c600 : theme.colorScheme.onSurface,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Radii.full),
            side: BorderSide(color: isSelected ? accent.c600 : Colors.transparent),
          ),
        );
      }).toList(),
    );
  }

  Widget _dateStrip(BuildContext context, ThemeData theme, RoleAccent accent) {
    return SizedBox(
      height: 84,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: _days.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final day = _days[index];
          final isSelected = _sameDay(day, _selectedDate);
          return GestureDetector(
            onTap: () => setState(() {
              _selectedDate = day;
              _selectedSlot = null;
            }),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  DateFormat.E('id_ID').format(day),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: isSelected ? accent.c600 : Brand.neutral,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  width: 44,
                  height: 44,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isSelected ? accent.c600 : Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected ? accent.c600 : theme.dividerColor,
                    ),
                  ),
                  child: Text(
                    '${day.day}',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: isSelected ? Colors.white : theme.colorScheme.onSurface,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _slotPills(
    BuildContext context,
    ThemeData theme,
    RoleAccent accent,
    List<SlotDto> slots,
  ) {
    final daySlots = slots.where((s) {
      if (s.status != 'OPEN') return false;
      return _sameDay(DateTime.parse(s.startsAt).toLocal(), _selectedDate);
    }).toList();

    if (daySlots.isEmpty) {
      return Text(
        'Tidak ada slot tersedia di hari ini',
        style: theme.textTheme.bodyMedium?.copyWith(color: Brand.neutral),
      );
    }

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: daySlots.map((slot) {
        final isSelected = _selectedSlot?.id == slot.id;
        final label = DateFormat.Hm('id_ID').format(
          DateTime.parse(slot.startsAt).toLocal(),
        );
        return GestureDetector(
          onTap: () => setState(() => _selectedSlot = slot),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: isSelected ? accent.c600 : theme.cardTheme.color,
              borderRadius: BorderRadius.circular(Radii.full),
              border: Border.all(
                color: isSelected ? accent.c600 : theme.dividerColor,
              ),
            ),
            child: Text(
              label,
              style: theme.textTheme.labelLarge?.copyWith(
                color: isSelected ? Colors.white : theme.colorScheme.onSurface,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _reviewSlivers(
    BuildContext context,
    ThemeData theme,
    RoleAccent accent,
    PaginatedReviews reviews,
  ) {
    if (reviews.items.isEmpty) {
      return SliverPadding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        sliver: SliverToBoxAdapter(
          child: Text(
            'Belum ada ulasan',
            style: theme.textTheme.bodyMedium?.copyWith(color: Brand.neutral),
          ),
        ),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
      sliver: SliverList.separated(
        itemCount: reviews.items.length,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final review = reviews.items[index];
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        review.studentName,
                        style: theme.textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        DateFormat.yMMMd('id_ID').format(
                          DateTime.parse(review.createdAt).toLocal(),
                        ),
                        style: theme.textTheme.bodySmall?.copyWith(color: Brand.neutral),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: List.generate(5, (i) {
                      return Icon(
                        i < review.rating
                            ? Icons.star_rounded
                            : Icons.star_border_rounded,
                        size: 16,
                        color: Brand.tertiary,
                      );
                    }),
                  ),
                  if (review.comment != null && review.comment!.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(
                      review.comment!,
                      style: theme.textTheme.bodyMedium?.copyWith(color: Brand.neutral),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _loading() {
    return SliverPadding(
      padding: const EdgeInsets.all(20),
      sliver: SliverList.list(
        children: const [
          SkeletonLoader(width: double.infinity, height: 140),
          SizedBox(height: 20),
          SkeletonLoader(width: 200, height: 24),
          SizedBox(height: 12),
          SkeletonLoader(width: double.infinity, height: 44),
          SizedBox(height: 20),
          SkeletonLoader(width: 200, height: 24),
          SizedBox(height: 12),
          SkeletonLoader(width: double.infinity, height: 72),
        ],
      ),
    );
  }

  Widget _bottomBar(
    BuildContext context,
    ThemeData theme,
    RoleAccent accent,
    TutorDetail? detail,
  ) {
    if (detail == null) return const SizedBox.shrink();

    final subjects = detail.subjects;
    final selected = subjects.where((s) => s.subjectId == _selectedSubjectId).firstOrNull;
    final price = selected?.priceIdr ?? (subjects.isNotEmpty ? subjects.first.priceIdr : 0);
    final canSubmit = _selectedSubjectId != null && _selectedSlot != null;

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(top: BorderSide(color: theme.dividerColor)),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Total',
                    style: theme.textTheme.bodySmall?.copyWith(color: Brand.neutral),
                  ),
                  Text(
                    _currency.format(price),
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: accent.c600,
                    ),
                  ),
                ],
              ),
            ),
            AppButton(
              label: 'Pesan Sekarang',
              variant: AppButtonVariant.primary,
              isLoading: _submitting,
              onPressed: canSubmit ? _submit : null,
            ),
          ],
        ),
      ),
    );
  }
}