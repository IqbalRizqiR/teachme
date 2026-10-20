import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teachme_mobile/core/network/dio_client.dart';
import 'package:teachme_mobile/features/notifications/data/notification_dto.dart';

class NotificationApi {
  NotificationApi(this._dio);

  final Dio _dio;

  Future<NotificationResponse> getNotifications({
    String? cursor,
    int limit = 20,
  }) async {
    final res = await _dio.get<Map<String, dynamic>>(
      '/notifications',
      queryParameters: {
        'cursor': ?cursor,
        'limit': limit,
      },
    );
    return NotificationResponse.fromJson(res.data!);
  }

  Future<void> markRead(String id) async {
    await _dio.post<void>('/notifications/$id/read');
  }

  Future<void> markAllRead() async {
    await _dio.post<void>('/notifications/read-all');
  }
}

final notificationApiProvider = Provider<NotificationApi>((ref) {
  return NotificationApi(ref.watch(dioProvider));
});
