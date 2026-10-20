import 'dart:async';
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
import 'package:teachme_mobile/features/tutors/data/tutor_api.dart';
import 'package:teachme_mobile/features/tutors/data/tutor_dto.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _searchController = TextEditingController();
  Timer? _debounce;
  String _query = '';
  double? _minRating;
  String? _sort;

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      setState(() => _query = value.trim());
    });
  }

  @override
  Widget build(BuildContext context) {
    final accent = Theme.of(context).extension<RoleAccent>() ?? RoleAccent.student;
    final currencyFormatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);

    final searchResults = ref.watch(tutorApiProvider).searchTutors(
          q: _query.isNotEmpty ? _query : null,
          minRating: _minRating,
          sort: _sort,
        );

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.only(right: 16),
          child: TextField(
            controller: _searchController,
            autofocus: true,
            onChanged: _onSearchChanged,
            decoration: InputDecoration(
              hintText: 'Cari tentor, fisika, matematika...',
              prefixIcon: const Icon(Icons.search_rounded),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear_rounded),
                      onPressed: () {
                        _searchController.clear();
                        setState(() => _query = '');
                      },
                    )
                  : null,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                FilterChip(
                  label: const Text('Rating ≥ 4.5 ⭐'),
                  selected: _minRating == 4.5,
                  onSelected: (val) {
                    setState(() => _minRating = val ? 4.5 : null);
                  },
                  selectedColor: accent.c100,
                  labelStyle: TextStyle(
                    color: _minRating == 4.5 ? accent.c600 : Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(width: 8),
                ChoiceChip(
                  label: const Text('Rating Tertinggi'),
                  selected: _sort == 'rating',
                  onSelected: (val) {
                    setState(() => _sort = val ? 'rating' : null);
                  },
                  selectedColor: accent.c100,
                ),
                const SizedBox(width: 8),
                ChoiceChip(
                  label: const Text('Harga Terendah'),
                  selected: _sort == 'price_asc',
                  onSelected: (val) {
                    setState(() => _sort = val ? 'price_asc' : null);
                  },
                  selectedColor: accent.c100,
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<PaginatedTutors>(
              future: searchResults,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: 4,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (_, __) => const SkeletonLoader(width: double.infinity, height: 140),
                  );
                }

                if (snapshot.hasError) {
                  return ErrorState(
                    message: 'Gagal memuat hasil pencarian',
                    onRetry: () => setState(() {}),
                  );
                }

                final data = snapshot.data!;
                if (data.items.isEmpty) {
                  return const EmptyState(
                    message: 'Tidak ada tentor yang cocok dengan pencarianmu.',
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: data.items.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final tutor = data.items[index];
                    final startingPrice = tutor.subjects.isNotEmpty
                        ? tutor.subjects.map((s) => s.priceIdr).reduce((a, b) => a < b ? a : b)
                        : 0;

                    return Card(
                      child: InkWell(
                        onTap: () => context.push('/tutors/${tutor.id}'),
                        borderRadius: BorderRadius.circular(Radii.lg),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AvatarWidget(imageUrl: tutor.avatarUrl, size: 48),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            tutor.name,
                                            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            const Icon(Icons.star_rounded, size: 16, color: Brand.tertiary),
                                            const SizedBox(width: 2),
                                            Text(
                                              tutor.ratingAvg > 0 ? tutor.ratingAvg.toStringAsFixed(1) : '-',
                                              style: const TextStyle(fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      tutor.subjects.map((s) => s.subjectName).join(' · '),
                                      style: TextStyle(color: Brand.neutral, fontSize: 13),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      '${currencyFormatter.format(startingPrice)}/jam',
                                      style: TextStyle(
                                        color: accent.c600,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
