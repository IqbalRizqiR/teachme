import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:teachme_mobile/core/theme/tokens.dart';
import 'package:teachme_mobile/core/widgets/app_button.dart';
import 'package:teachme_mobile/core/widgets/empty_state.dart';
import 'package:teachme_mobile/core/widgets/error_state.dart';
import 'package:teachme_mobile/core/widgets/skeleton_loader.dart';
import 'package:teachme_mobile/features/schedule/data/schedule_api.dart';
import 'package:teachme_mobile/features/schedule/data/schedule_dto.dart';
import 'package:teachme_mobile/features/tutors/data/tutor_dto.dart';

final rulesProvider = FutureProvider<List<AvailabilityRuleDto>>(
  (ref) => ref.watch(scheduleApiProvider).getRules(),
);

final exceptionsProvider = FutureProvider<List<AvailabilityExceptionDto>>(
  (ref) => ref.watch(scheduleApiProvider).getExceptions(),
);

final tutorSlotsProvider = FutureProvider<List<SlotDto>>(
  (ref) => ref.watch(scheduleApiProvider).getSlots(),
);

const _dayNames = ['Minggu', 'Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu'];
const _weekdayOrder = [1, 2, 3, 4, 5, 6, 0];

String _fmtTime(int minutes) =>
    '${(minutes ~/ 60).toString().padLeft(2, '0')}:${(minutes % 60).toString().padLeft(2, '0')}';

int? _parseTime(String value) {
  final parts = value.trim().split(':');
  if (parts.length != 2) return null;
  final h = int.tryParse(parts[0]);
  final m = int.tryParse(parts[1]);
  if (h == null || m == null) return null;
  if (h < 0 || h > 23 || m < 0 || m > 59) return null;
  return h * 60 + m;
}

class ManageScheduleScreen extends ConsumerStatefulWidget {
  const ManageScheduleScreen({super.key});

  @override
  ConsumerState<ManageScheduleScreen> createState() =>
      _ManageScheduleScreenState();
}

class _ManageScheduleScreenState extends ConsumerState<ManageScheduleScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tab;

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  Future<void> _showRuleSheet({AvailabilityRuleDto? existing}) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: _RuleSheet(existing: existing),
      ),
    );
  }

  Future<void> _showExceptionSheet() {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: const _ExceptionSheet(),
      ),
    );
  }

  Future<void> _confirmDeleteRule(AvailabilityRuleDto rule) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Jadwal'),
        content: Text(
          'Hapus jadwal ${_dayNames[rule.weekday]} '
          '${_fmtTime(rule.startMinute)} - ${_fmtTime(rule.endMinute)}?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    try {
      await ref.read(scheduleApiProvider).deleteRule(rule.id);
      ref.invalidate(rulesProvider);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Jadwal berhasil dihapus')),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menghapus jadwal: $e')),
      );
    }
  }

  Future<void> _confirmDeleteException(AvailabilityExceptionDto ex) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Hari Libur'),
        content: Text('Hapus hari libur pada ${_formatDate(ex.date)}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    try {
      await ref.read(scheduleApiProvider).deleteException(ex.id);
      ref.invalidate(exceptionsProvider);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Hari libur berhasil dihapus')),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menghapus hari libur: $e')),
      );
    }
  }

  String _formatDate(String iso) {
    final dt = DateTime.tryParse(iso);
    if (dt == null) return iso;
    return DateFormat('d MMM yyyy', 'id_ID').format(dt);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accent = theme.extension<RoleAccent>() ?? RoleAccent.tutor;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Jadwal Saya'),
        bottom: TabBar(
          controller: _tab,
          tabs: const [Tab(text: 'Mingguan'), Tab(text: 'Hari Libur')],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showRuleSheet(),
        backgroundColor: accent.c600,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Tambah Jadwal'),
      ),
      body: Column(
        children: [
          Expanded(
            child: TabBarView(
              controller: _tab,
              children: [
                _buildRulesTab(theme),
                _buildExceptionsTab(theme),
              ],
            ),
          ),
          _buildSlotPreview(theme),
        ],
      ),
    );
  }

  Widget _buildRulesTab(ThemeData theme) {
    final asyncRules = ref.watch(rulesProvider);

    return asyncRules.when(
      loading: () => ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          SkeletonLoader(width: double.infinity, height: 96, borderRadius: Radii.lg),
          SizedBox(height: 12),
          SkeletonLoader(width: double.infinity, height: 96, borderRadius: Radii.lg),
          SizedBox(height: 12),
          SkeletonLoader(width: double.infinity, height: 96, borderRadius: Radii.lg),
        ],
      ),
      error: (error, _) => ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 100),
          ErrorState(
            message: 'Gagal memuat jadwal',
            onRetry: () => ref.invalidate(rulesProvider),
          ),
        ],
      ),
      data: (rules) => RefreshIndicator(
        color: theme.colorScheme.primary,
        onRefresh: () async {
          ref.invalidate(rulesProvider);
          await ref.read(rulesProvider.future);
        },
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
          children: [
            for (final weekday in _weekdayOrder)
              _dayCard(
                weekday,
                rules.where((r) => r.weekday == weekday).toList(),
                theme,
              ),
          ],
        ),
      ),
    );
  }

  Widget _dayCard(
    int weekday,
    List<AvailabilityRuleDto> dayRules,
    ThemeData theme,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _dayNames[weekday],
              style: theme.textTheme.labelLarge,
            ),
            const SizedBox(height: 8),
            if (dayRules.isEmpty)
              Text(
                'Tidak ada jadwal',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              )
            else
              for (final rule in dayRules)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Row(
                    children: [
                      Icon(
                        Icons.schedule_rounded,
                        size: 16,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          '${_fmtTime(rule.startMinute)} - ${_fmtTime(rule.endMinute)}',
                          style: theme.textTheme.bodyMedium,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit, size: 20),
                        tooltip: 'Ubah',
                        onPressed: () => _showRuleSheet(existing: rule),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline, size: 20),
                        tooltip: 'Hapus',
                        onPressed: () => _confirmDeleteRule(rule),
                      ),
                    ],
                  ),
                ),
          ],
        ),
      ),
    );
  }

  Widget _buildExceptionsTab(ThemeData theme) {
    final asyncExceptions = ref.watch(exceptionsProvider);

    return asyncExceptions.when(
      loading: () => ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          SkeletonLoader(width: double.infinity, height: 72, borderRadius: Radii.lg),
          SizedBox(height: 12),
          SkeletonLoader(width: double.infinity, height: 72, borderRadius: Radii.lg),
        ],
      ),
      error: (error, _) => ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 100),
          ErrorState(
            message: 'Gagal memuat hari libur',
            onRetry: () => ref.invalidate(exceptionsProvider),
          ),
        ],
      ),
      data: (items) => RefreshIndicator(
        color: theme.colorScheme.primary,
        onRefresh: () async {
          ref.invalidate(exceptionsProvider);
          await ref.read(exceptionsProvider.future);
        },
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
          children: [
            AppButton(
              label: 'Tambah Tanggal Libur',
              variant: AppButtonVariant.primary,
              onPressed: _showExceptionSheet,
            ),
            const SizedBox(height: 16),
            if (items.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 40),
                child: EmptyState(message: 'Belum ada tanggal libur.'),
              )
            else
              for (final ex in items) _exceptionCard(ex, theme),
          ],
        ),
      ),
    );
  }

  Widget _exceptionCard(AvailabilityExceptionDto ex, ThemeData theme) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              Icons.event_busy_rounded,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_formatDate(ex.date), style: theme.textTheme.labelLarge),
                  if (ex.reason != null && ex.reason!.isNotEmpty)
                    Text(
                      ex.reason!,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline),
              tooltip: 'Hapus',
              onPressed: () => _confirmDeleteException(ex),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSlotPreview(ThemeData theme) {
    final asyncSlots = ref.watch(tutorSlotsProvider);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: theme.colorScheme.outline.withValues(alpha: 0.3),
          ),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Preview Slot 7 Hari', style: theme.textTheme.labelLarge),
          const SizedBox(height: 8),
          SizedBox(
            height: 56,
            child: asyncSlots.when(
              loading: () => ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (_, __) => const SkeletonLoader(
                  width: 88,
                  height: 56,
                  borderRadius: Radii.md,
                ),
              ),
              error: (error, _) => Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Gagal memuat slot',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              data: (slots) {
                if (slots.isEmpty) {
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Belum ada slot',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  );
                }
                final sorted = [...slots]
                  ..sort((a, b) => a.startsAt.compareTo(b.startsAt));
                return ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: sorted.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (_, index) => _slotPill(sorted[index], theme),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _slotPill(SlotDto slot, ThemeData theme) {
    final (bg, fg, border) = switch (slot.status) {
      'BOOKED' => (StatusColors.paidBg, StatusColors.paidLight, Colors.transparent),
      'HELD' => (StatusColors.warningBg, StatusColors.warningText, Colors.transparent),
      _ => (Colors.transparent, theme.colorScheme.onSurface, theme.colorScheme.outline),
    };
    final dt = DateTime.tryParse(slot.startsAt)?.toLocal();
    final label = dt == null ? slot.startsAt : _fmtTime(dt.hour * 60 + dt.minute);

    return Container(
      width: 88,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(Radii.md),
        border: Border.all(color: border),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label, style: theme.textTheme.labelLarge?.copyWith(color: fg)),
          Text(slot.status, style: theme.textTheme.labelSmall?.copyWith(color: fg)),
        ],
      ),
    );
  }
}

class _RuleSheet extends ConsumerStatefulWidget {
  const _RuleSheet({super.key, this.existing});

  final AvailabilityRuleDto? existing;

  @override
  ConsumerState<_RuleSheet> createState() => _RuleSheetState();
}

class _RuleSheetState extends ConsumerState<_RuleSheet> {
  late int _weekday;
  late final TextEditingController _startCtrl;
  late final TextEditingController _endCtrl;
  bool _saving = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    final existing = widget.existing;
    _weekday = existing?.weekday ?? 1;
    _startCtrl = TextEditingController(
      text: _fmtTime(existing?.startMinute ?? 8 * 60),
    );
    _endCtrl = TextEditingController(
      text: _fmtTime(existing?.endMinute ?? 9 * 60),
    );
  }

  @override
  void dispose() {
    _startCtrl.dispose();
    _endCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickTime(TextEditingController controller) async {
    final current = _parseTime(controller.text);
    final initial = current == null
        ? TimeOfDay.now()
        : TimeOfDay(hour: current ~/ 60, minute: current % 60);
    final picked = await showTimePicker(context: context, initialTime: initial);
    if (picked == null) return;
    setState(() {
      controller.text = _fmtTime(picked.hour * 60 + picked.minute);
      _error = null;
    });
  }

  Future<void> _save() async {
    final start = _parseTime(_startCtrl.text);
    final end = _parseTime(_endCtrl.text);
    if (start == null || end == null) {
      setState(() => _error = 'Format jam tidak valid (HH:mm)');
      return;
    }
    if (end <= start) {
      setState(() => _error = 'Jam selesai harus setelah jam mulai');
      return;
    }

    setState(() {
      _saving = true;
      _error = null;
    });

    try {
      final api = ref.read(scheduleApiProvider);
      final request = CreateRuleRequest(
        weekday: _weekday,
        startMinute: start,
        endMinute: end,
      );
      final existing = widget.existing;
      if (existing == null) {
        await api.createRule(request);
      } else {
        await api.updateRule(existing.id, request);
      }
      ref.invalidate(rulesProvider);
      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      if (mounted) {
        setState(() {
          _saving = false;
          _error = 'Gagal menyimpan: $e';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isEditing = widget.existing != null;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isEditing ? 'Ubah Jadwal' : 'Tambah Jadwal',
            style: theme.textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<int>(
            initialValue: _weekday,
            decoration: const InputDecoration(labelText: 'Hari'),
            items: [
              for (var i = 0; i < _dayNames.length; i++)
                DropdownMenuItem(value: i, child: Text(_dayNames[i])),
            ],
            onChanged: (value) {
              if (value == null) return;
              setState(() => _weekday = value);
            },
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _startCtrl,
                  decoration: InputDecoration(
                    labelText: 'Mulai',
                    hintText: 'HH:mm',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.access_time),
                      onPressed: () => _pickTime(_startCtrl),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextFormField(
                  controller: _endCtrl,
                  decoration: InputDecoration(
                    labelText: 'Selesai',
                    hintText: 'HH:mm',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.access_time),
                      onPressed: () => _pickTime(_endCtrl),
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (_error != null) ...[
            const SizedBox(height: 12),
            Text(
              _error!,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.error,
              ),
            ),
          ],
          const SizedBox(height: 20),
          AppButton(
            label: 'Simpan',
            variant: AppButtonVariant.primary,
            isLoading: _saving,
            onPressed: _save,
          ),
        ],
      ),
    );
  }
}

class _ExceptionSheet extends ConsumerStatefulWidget {
  const _ExceptionSheet({super.key});

  @override
  ConsumerState<_ExceptionSheet> createState() => _ExceptionSheetState();
}

class _ExceptionSheetState extends ConsumerState<_ExceptionSheet> {
  final _reasonCtrl = TextEditingController();
  DateTime? _date;
  bool _saving = false;
  String? _error;

  @override
  void dispose() {
    _reasonCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _date ?? now,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 2),
    );
    if (picked == null) return;
    setState(() {
      _date = picked;
      _error = null;
    });
  }

  Future<void> _save() async {
    if (_date == null) {
      setState(() => _error = 'Pilih tanggal terlebih dahulu');
      return;
    }
    setState(() {
      _saving = true;
      _error = null;
    });

    try {
      final reason = _reasonCtrl.text.trim();
      await ref.read(scheduleApiProvider).createException(
            CreateExceptionRequest(
              date: _date!.toIso8601String().substring(0, 10),
              reason: reason.isEmpty ? null : reason,
            ),
          );
      ref.invalidate(exceptionsProvider);
      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      if (mounted) {
        setState(() {
          _saving = false;
          _error = 'Gagal menyimpan: $e';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Tambah Tanggal Libur', style: theme.textTheme.headlineSmall),
          const SizedBox(height: 16),
          InkWell(
            onTap: _pickDate,
            borderRadius: BorderRadius.circular(Radii.sm),
            child: InputDecorator(
              decoration: const InputDecoration(
                labelText: 'Tanggal',
                suffixIcon: Icon(Icons.calendar_today_rounded),
              ),
              child: Text(
                _date == null
                    ? 'Pilih tanggal'
                    : DateFormat('d MMM yyyy', 'id_ID').format(_date!),
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _reasonCtrl,
            decoration: const InputDecoration(
              labelText: 'Alasan (opsional)',
            ),
          ),
          if (_error != null) ...[
            const SizedBox(height: 12),
            Text(
              _error!,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.error,
              ),
            ),
          ],
          const SizedBox(height: 20),
          AppButton(
            label: 'Simpan',
            variant: AppButtonVariant.primary,
            isLoading: _saving,
            onPressed: _save,
          ),
        ],
      ),
    );
  }
}