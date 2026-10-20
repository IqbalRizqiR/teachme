import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teachme_mobile/core/storage/prefs.dart';
import 'package:teachme_mobile/core/theme/tokens.dart';
import 'package:teachme_mobile/core/widgets/app_button.dart';
import 'package:teachme_mobile/core/widgets/avatar_widget.dart';
import 'package:teachme_mobile/features/auth/domain/auth_state.dart';
import 'package:teachme_mobile/features/auth/presentation/auth_controller.dart';

class TutorProfileScreen extends ConsumerStatefulWidget {
  const TutorProfileScreen({super.key});

  @override
  ConsumerState<TutorProfileScreen> createState() => _TutorProfileScreenState();
}

class _TutorProfileScreenState extends ConsumerState<TutorProfileScreen> {
  static const _subjects = ['Matematika', 'Fisika'];

  Future<void> _confirmLogout() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Keluar dari akun?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Keluar'),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await ref.read(authControllerProvider.notifier).logout();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accent = theme.extension<RoleAccent>() ?? RoleAccent.tutor;
    final state = ref.watch(authControllerProvider);
    final name =
        state.mapOrNull(authenticated: (s) => s.user.name) ?? 'Tentor';
    final email = state.mapOrNull(authenticated: (s) => s.user.email) ?? '';
    final mode = ref.watch(themeModeProvider);

    final cardShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(Radii.lg),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Profil')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Center(
            child: AvatarWidget(size: 80, isVerified: true),
          ),
          const SizedBox(height: 16),
          Text(
            name,
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            email,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(color: Brand.neutral),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.star_rounded, size: 20, color: Brand.tertiary),
              const SizedBox(width: 4),
              Text(
                '5.0',
                style: theme.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Card(
            shape: cardShape,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tentang',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Tentor di teachMe. Siap membantu kamu belajar dengan cara yang seru!',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Brand.neutral,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _subjects
                        .map(
                          (s) => Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: accent.c100,
                              borderRadius: BorderRadius.circular(Radii.full),
                            ),
                            child: Text(
                              s,
                              style: theme.textTheme.labelLarge?.copyWith(
                                color: accent.c600,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            shape: cardShape,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pendapatan',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _moneyRow(theme, 'Kotor', 'Rp0'),
                  _moneyRow(theme, 'Biaya Platform (10%)', 'Rp0'),
                  _moneyRow(theme, 'Bersih', 'Rp0', emphasized: true, accent: accent),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            shape: cardShape,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Preferensi',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Text('Tema', style: theme.textTheme.bodyMedium),
                      const SizedBox(width: 16),
                      Expanded(
                        child: SegmentedButton<ThemeMode>(
                          showSelectedIcon: false,
                          segments: const [
                            ButtonSegment(
                              value: ThemeMode.system,
                              label: Text('Sistem'),
                            ),
                            ButtonSegment(
                              value: ThemeMode.light,
                              label: Text('Terang'),
                            ),
                            ButtonSegment(
                              value: ThemeMode.dark,
                              label: Text('Gelap'),
                            ),
                          ],
                          selected: {mode},
                          onSelectionChanged: (selection) {
                            ref
                                .read(themeModeProvider.notifier)
                                .setMode(selection.first);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            shape: cardShape,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: AppButton(
                label: 'Keluar Akun',
                variant: AppButtonVariant.outlined,
                onPressed: _confirmLogout,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _moneyRow(
    ThemeData theme,
    String label,
    String value, {
    bool emphasized = false,
    RoleAccent? accent,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(color: Brand.neutral),
          ),
          Text(
            value,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: emphasized ? FontWeight.w700 : FontWeight.w500,
              color: emphasized ? accent?.c600 : null,
            ),
          ),
        ],
      ),
    );
  }
}