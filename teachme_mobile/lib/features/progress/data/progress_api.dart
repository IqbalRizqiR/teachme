import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teachme_mobile/core/network/dio_client.dart';
import 'package:teachme_mobile/features/progress/data/progress_dto.dart';

class ProgressApi {
  ProgressApi(this._dio);

  final Dio _dio;

  Future<ProgressResponse> getProgress({String? enrollmentId}) async {
    final res = await _dio.get<Map<String, dynamic>>(
      '/progress',
      queryParameters: {
        'enrollmentId': ?enrollmentId,
      },
    );
    return ProgressResponse.fromJson(res.data!);
  }

  Future<List<EnrollmentDto>> getEnrollments() async {
    final res = await _dio.get<List<dynamic>>('/enrollments');
    return res.data!
        .map((e) => EnrollmentDto.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> updateTarget(
    String enrollmentId, {
    int? targetScore,
    int? minSessions,
  }) async {
    await _dio.patch<void>(
      '/enrollments/$enrollmentId/target',
      data: {
        'targetScore': ?targetScore,
        'minSessions': ?minSessions,
      },
    );
  }
}

final progressApiProvider = Provider<ProgressApi>((ref) {
  return ProgressApi(ref.watch(dioProvider));
});
