import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:teachme_mobile/core/theme/tokens.dart';
import 'package:teachme_mobile/core/widgets/empty_state.dart';
import 'package:teachme_mobile/core/widgets/error_state.dart';
import 'package:teachme_mobile/core/widgets/skeleton_loader.dart';
import 'package:teachme_mobile/features/notifications/data/notification_api.dart';
import 'package:teachme_mobile/features/notifications/data/notification_dto.dart';

final notificationsProvider = FutureProvider<NotificationResponse>(
  (ref) => ref.watch(notificationApiProvider).getNotifications(),
);

class NotificationScreen extends ConsumerStatefulWidget {
  const NotificationScreen({super.key});

  @override
  ConsumerState<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends ConsumerState<NotificationScreen> {
  Future<void> _markAllRead() async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      await ref.read(notificationApiProvider).markAllRead();
      ref.invalidate(notificationsProvider);
      messenger.showSnackBar(
        const SnackBar(content: Text('Semua notifikasi ditandai dibaca')),
      );
    } catch (_) {
      messenger.showSnackBar(
        const SnackBar(content: Text('Gagal menandai notifikasi')),
      );
    }
  }

  Future<void> _open(NotificationDto n) async {
    try {
      await ref.read(notificationApiProvider).markRead(n.id);
      ref.invalidate(notificationsProvider);
    } catch (_) {}
    if (!mounted) return;
    final bookingId = n.data?['bookingId'];
    if (bookingId != null) {
      context.push('/bookings/$bookingId');
    }
  }

  IconData _iconFor(String type) {
    if (type.contains('BOOKING')) return Icons.event_note;
    if (type.contains('COMPLETED')) return Icons.celebration;
    if (type.contains('CERTIFICATE')) return Icons.emoji_events;
    return Icons.notifications;
  }

  String _formatDate(String isoString) {
    try {
      final dt = DateTime.parse(isoString).toLocal();
      return DateFormat('d MMM yyyy, HH:mm', 'id_ID').format(dt);
    } catch (_) {
      return isoString;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accent = theme.extension<RoleAccent>() ?? RoleAccent.brand;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifikasi'),
        actions: [
          TextButton(
            onPressed: _markAllRead,
            child: const Text('Tandai semua dibaca'),
          ),
        ],
      ),
      body: ref.watch(notificationsProvider).when(
            data: (res) {
              if (res.items.isEmpty) {
                return const EmptyState(message: 'Belum ada notifikasi');
              }
              return ListView.separated(
                padding: const EdgeInsets.all(20),
                itemCount: res.items.length,
                separatorBuilder: (_, _) => const SizedBox(height: 12),
                itemBuilder: (_, index) =>
                    _card(theme, accent, res.items[index]),
              );
            },
            loading: () => ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: 5,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (_, _) =>
                  const SkeletonLoader(width: double.infinity, height: 88),
            ),
            error: (_, _) => ErrorState(
              message: 'Gagal memuat notifikasi',
              onRetry: () => ref.invalidate(notificationsProvider),
            ),
          ),
    );
  }

  Widget _card(ThemeData theme, RoleAccent accent, NotificationDto n) {
    final unread = n.readAt == null;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Radii.lg),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(Radii.lg),
        onTap: () => _open(n),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: accent.c100,
                child: Icon(_iconFor(n.type), color: accent.c600),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            n.title,
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        if (unread)
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: accent.c500,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      n.body,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Brand.neutral,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      _formatDate(n.createdAt),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Brand.neutral,
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
  }
}