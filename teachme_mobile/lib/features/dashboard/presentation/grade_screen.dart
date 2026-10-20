import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:teachme_mobile/core/theme/tokens.dart';
import 'package:teachme_mobile/core/widgets/app_button.dart';
import 'package:teachme_mobile/core/widgets/error_state.dart';
import 'package:teachme_mobile/core/widgets/skeleton_loader.dart';
import 'package:teachme_mobile/features/booking/data/booking_api.dart';
import 'package:teachme_mobile/features/booking/data/booking_dto.dart';

final gradeBookingProvider = FutureProvider.family<BookingDto, String>(
  (ref, id) => ref.watch(bookingApiProvider).getBooking(id),
);

const _quickTags = [
  'Fokus',
  'Perlu Latihan',
  'Kemajuan Pesat',
  'Pemahaman Bagus',
  'Aktif Bertanya',
];

class GradeScreen extends ConsumerStatefulWidget {
  const GradeScreen({super.key, required this.bookingId});

  final String bookingId;

  @override
  ConsumerState<GradeScreen> createState() => _GradeScreenState();
}

class _GradeScreenState extends ConsumerState<GradeScreen> {
  double _score = 80;
  final _noteController = TextEditingController();
  String _selectedTag = '';
  bool _saving = false;

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  String _date(String iso) =>
      DateFormat('EEE, d MMM, HH:mm', 'id_ID')
          .format(DateTime.parse(iso).toLocal());

  Future<void> _submit() async {
    var note = _noteController.text.trim();
    if (_selectedTag.isNotEmpty && !note.contains(_selectedTag)) {
      note = note.isEmpty ? _selectedTag : '$note\n\n$_selectedTag';
    }
    if (note.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Catatan wajib diisi')),
      );
      return;
    }

    setState(() => _saving = true);
    try {
      await ref.read(bookingApiProvider).gradeBooking(
            widget.bookingId,
            score: _score.round(),
            note: note,
          );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nilai tersimpan!')),
      );
      context.go('/dashboard');
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menyimpan nilai: $e')),
      );
      setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accent = theme.extension<RoleAccent>() ?? RoleAccent.tutor;
    final booking = ref.watch(gradeBookingProvider(widget.bookingId));

    return Scaffold(
      appBar: AppBar(title: const Text('Input Nilai & Catatan')),
      body: booking.when(
        loading: () => const Padding(
          padding: EdgeInsets.all(20),
          child: SkeletonLoader(
            width: double.infinity,
            height: 200,
            borderRadius: Radii.lg,
          ),
        ),
        error: (error, _) => ErrorState(
          message: 'Gagal memuat sesi: $error',
          onRetry: () =>
              ref.invalidate(gradeBookingProvider(widget.bookingId)),
        ),
        data: (data) => ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(Radii.lg),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.student?.name ?? 'Murid',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    data.subjectName ?? '-',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.schedule_rounded,
                        size: 15,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          _date(data.slot.startsAt),
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Gimana progres muridmu hari ini?',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              '${_score.round()} / 100',
              textAlign: TextAlign.center,
              style: theme.textTheme.displayLarge?.copyWith(
                color: accent.c600,
                fontWeight: FontWeight.bold,
              ),
            ),
            Slider(
              value: _score,
              min: 0,
              max: 100,
              divisions: 100,
              activeColor: accent.c600,
              onChanged: (v) => setState(() => _score = v),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _quickTags.map((tag) {
                final selected = _selectedTag == tag;
                return ChoiceChip(
                  label: Text(tag),
                  selected: selected,
                  onSelected: (_) => setState(() {
                    _selectedTag = tag;
                    if (_noteController.text.trim().isEmpty) {
                      _noteController.text = tag;
                    }
                  }),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _noteController,
              minLines: 3,
              maxLines: 6,
              decoration: const InputDecoration(
                hintText:
                    'Tuliskan evaluasi belajar, materi yang dikuasai, dan pekerjaan rumah...',
              ),
            ),
            const SizedBox(height: 24),
            AppButton(
              label: 'Simpan & Selesaikan Sesi 🎉',
              variant: AppButtonVariant.primary,
              isLoading: _saving,
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }
}