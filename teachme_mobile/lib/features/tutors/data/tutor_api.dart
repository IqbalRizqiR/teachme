import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teachme_mobile/core/network/dio_client.dart';
import 'package:teachme_mobile/features/tutors/data/tutor_dto.dart';

class TutorApi {
  TutorApi(this._dio);

  final Dio _dio;

  Future<PaginatedTutors> searchTutors({
    String? q,
    String? subjectId,
    int? minPrice,
    int? maxPrice,
    double? minRating,
    String? sort,
    String? cursor,
    int limit = 20,
  }) async {
    final res = await _dio.get<Map<String, dynamic>>(
      '/tutors',
      queryParameters: {
        'q': ?q,
        'subjectId': ?subjectId,
        'minPrice': ?minPrice,
        'maxPrice': ?maxPrice,
        'minRating': ?minRating,
        'sort': ?sort,
        'cursor': ?cursor,
        'limit': limit,
      },
    );
    return PaginatedTutors.fromJson(res.data!);
  }

  Future<TutorDetail> getTutorDetail(String id) async {
    final res = await _dio.get<Map<String, dynamic>>('/tutors/$id');
    return TutorDetail.fromJson(res.data!);
  }

  Future<List<SlotDto>> getTutorSlots(
    String id,
    String from,
    String to,
  ) async {
    final res = await _dio.get<List<dynamic>>(
      '/tutors/$id/slots',
      queryParameters: {'from': from, 'to': to},
    );
    return res.data!.map((e) => SlotDto.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<PaginatedReviews> getTutorReviews(
    String id, {
    String? cursor,
    int limit = 20,
  }) async {
    final res = await _dio.get<Map<String, dynamic>>(
      '/tutors/$id/reviews',
      queryParameters: {
        'cursor': ?cursor,
        'limit': limit,
      },
    );
    return PaginatedReviews.fromJson(res.data!);
  }
}

final tutorApiProvider = Provider<TutorApi>((ref) {
  return TutorApi(ref.watch(dioProvider));
});
