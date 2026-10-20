import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:teachme_mobile/core/theme/tokens.dart';
import 'package:teachme_mobile/core/widgets/app_button.dart';
import 'package:teachme_mobile/core/widgets/avatar_widget.dart';
import 'package:teachme_mobile/core/widgets/empty_state.dart';
import 'package:teachme_mobile/core/widgets/error_state.dart';
import 'package:teachme_mobile/core/widgets/skeleton_loader.dart';
import 'package:teachme_mobile/features/auth/presentation/auth_controller.dart';
import 'package:teachme_mobile/features/notifications/data/notification_api.dart';
import 'package:teachme_mobile/features/subjects/data/subject_api.dart';
import 'package:teachme_mobile/features/subjects/data/subject_dto.dart';
import 'package:teachme_mobile/features/tutors/data/tutor_api.dart';
import 'package:teachme_mobile/features/tutors/data/tutor_dto.dart';

final subjectsProvider = FutureProvider<List<SubjectDto>>((ref) {
  return ref.watch(subjectApiProvider).getSubjects();
});

final selectedSubjectIdProvider = StateProvider<String?>((ref) => null);

final tutorListProvider = FutureProvider<PaginatedTutors>((ref) {
  final subjectId = ref.watch(selectedSubjectIdProvider);
  return ref.watch(tutorApiProvider).searchTutors(subjectId: subjectId);
});

class StudentHomeScreen extends ConsumerWidget {
  const StudentHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);
    final userName = authState.mapOrNull(authenticated: (s) => s.user.name) ?? 'Murid';
    final subjectsAsync = ref.watch(subjectsProvider);
    final selectedSubjectId = ref.watch(selectedSubjectIdProvider);
    final tutorsAsync = ref.watch(tutorListProvider);
    final notificationsAsync = ref.watch(notificationApiProvider).getNotifications();
    final accent = Theme.of(context).extension<RoleAccent>() ?? RoleAccent.student;
    final currencyFormatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(tutorListProvider);
            ref.invalidate(subjectsProvider);
          },
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
                sliver: SliverToBoxAdapter(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hi, $userName 👋',
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Yuk, mulai belajar! 📚',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Brand.neutral,
                                ),
                          ),
                        ],
                      ),
                      FutureBuilder(
                        future: notificationsAsync,
                        builder: (context, snapshot) {
                          final unreadCount = snapshot.data?.unreadCount ?? 0;
                          return Stack(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.notifications_outlined, size: 28),
                                onPressed: () => context.push('/notifications'),
                              ),
                              if (unreadCount > 0)
                                Positioned(
                                  right: 8,
                                  top: 8,
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: const BoxDecoration(
                                      color: StatusColors.errorLight,
                                      shape: BoxShape.circle,
                                    ),
                                    constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                                    child: Text(
                                      '$unreadCount',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                sliver: SliverToBoxAdapter(
                  child: InkWell(
                    onTap: () => context.push('/search'),
                    borderRadius: BorderRadius.circular(Radii.sm),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardTheme.color,
                        borderRadius: BorderRadius.circular(Radii.sm),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.search_rounded, color: Brand.neutral),
                          const SizedBox(width: 12),
                          Text(
                            'Cari tentor atau mata pelajaran...',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Brand.neutral,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 48,
                  child: subjectsAsync.when(
                    data: (subjects) => ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      scrollDirection: Axis.horizontal,
                      itemCount: subjects.length + 1,
                      separatorBuilder: (_, __) => const SizedBox(width: 8),
                      itemBuilder: (context, index) {
                        final isAll = index == 0;
                        final isSelected = isAll
                            ? selectedSubjectId == null
                            : selectedSubjectId == subjects[index - 1].id;
                        final label = isAll ? 'Semua' : subjects[index - 1].name;

                        return ChoiceChip(
                          label: Text(label),
                          selected: isSelected,
                          onSelected: (_) {
                            ref.read(selectedSubjectIdProvider.notifier).state =
                                isAll ? null : subjects[index - 1].id;
                          },
                          selectedColor: accent.c100,
                          backgroundColor: Theme.of(context).cardTheme.color,
                          labelStyle: TextStyle(
                            color: isSelected ? accent.c600 : Theme.of(context).colorScheme.onSurface,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(Radii.full),
                            side: BorderSide(
                              color: isSelected ? accent.c600 : Colors.transparent,
                            ),
                          ),
                        );
                      },
                    ),
                    loading: () => const SizedBox.shrink(),
                    error: (_, __) => const SizedBox.shrink(),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
                sliver: SliverToBoxAdapter(
                  child: Text(
                    'Tentor Rekomendasi ⭐',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),
              ),
              tutorsAsync.when(
                data: (data) {
                  if (data.items.isEmpty) {
                    return const SliverFillRemaining(
                      hasScrollBody: false,
                      child: EmptyState(
                        message: 'Belum ada tentor yang cocok. Coba ubah filter ya!',
                      ),
                    );
                  }

                  return SliverPadding(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 80),
                    sliver: SliverList.separated(
                      itemCount: data.items.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        final tutor = data.items[index];
                        final startingPrice = tutor.subjects.isNotEmpty
                            ? tutor.subjects.map((s) => s.priceIdr).reduce((a, b) => a < b ? a : b)
                            : 0;

                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    AvatarWidget(
                                      imageUrl: tutor.avatarUrl,
                                      size: 52,
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  tutor.name,
                                                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w700,
                                                      ),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              const SizedBox(width: 4),
                                              const Icon(
                                                Icons.verified_rounded,
                                                size: 16,
                                                color: StatusColors.paidLight,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 4),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.star_rounded,
                                                size: 18,
                                                color: Brand.tertiary,
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                tutor.ratingAvg > 0
                                                    ? tutor.ratingAvg.toStringAsFixed(1)
                                                    : 'Baru',
                                                style: const TextStyle(fontWeight: FontWeight.w600),
                                              ),
                                              if (tutor.ratingCount > 0) ...[
                                                const SizedBox(width: 4),
                                                Text(
                                                  '(${tutor.ratingCount} sesi)',
                                                  style: TextStyle(
                                                    color: Brand.neutral,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                if (tutor.subjects.isNotEmpty) ...[
                                  const SizedBox(height: 12),
                                  Wrap(
                                    spacing: 6,
                                    runSpacing: 6,
                                    children: tutor.subjects.map((s) {
                                      return Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).colorScheme.surface,
                                          borderRadius: BorderRadius.circular(Radii.full),
                                        ),
                                        child: Text(
                                          s.subjectName,
                                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Mulai dari',
                                          style: TextStyle(color: Brand.neutral, fontSize: 11),
                                        ),
                                        Text(
                                          '${currencyFormatter.format(startingPrice)}/jam',
                                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                color: accent.c600,
                                              ),
                                        ),
                                      ],
                                    ),
                                    AppButton(
                                      label: 'Lihat Jadwal',
                                      variant: AppButtonVariant.primary,
                                      onPressed: () => context.push('/tutors/${tutor.id}'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
                loading: () => SliverPadding(
                  padding: const EdgeInsets.all(20),
                  sliver: SliverList.separated(
                    itemCount: 3,
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemBuilder: (_, __) => const SkeletonLoader(width: double.infinity, height: 160),
                  ),
                ),
                error: (err, _) => SliverFillRemaining(
                  hasScrollBody: false,
                  child: ErrorState(
                    message: 'Gagal memuat daftar tentor',
                    onRetry: () => ref.refresh(tutorListProvider),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
