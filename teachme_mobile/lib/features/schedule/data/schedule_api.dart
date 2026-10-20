import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teachme_mobile/core/network/dio_client.dart';
import 'package:teachme_mobile/features/schedule/data/schedule_dto.dart';
import 'package:teachme_mobile/features/tutors/data/tutor_dto.dart';

class ScheduleApi {
  ScheduleApi(this._dio);

  final Dio _dio;

  Future<List<AvailabilityRuleDto>> getRules() async {
    final res = await _dio.get<List<dynamic>>('/tutor/availability-rules');
    return res.data!
        .map((e) => AvailabilityRuleDto.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<AvailabilityRuleDto> createRule(CreateRuleRequest req) async {
    final res = await _dio.post<Map<String, dynamic>>(
      '/tutor/availability-rules',
      data: req.toJson(),
    );
    return AvailabilityRuleDto.fromJson(res.data!);
  }

  Future<AvailabilityRuleDto> updateRule(
    String id,
    CreateRuleRequest req,
  ) async {
    final res = await _dio.patch<Map<String, dynamic>>(
      '/tutor/availability-rules/$id',
      data: req.toJson(),
    );
    return AvailabilityRuleDto.fromJson(res.data!);
  }

  Future<void> deleteRule(String id) async {
    await _dio.delete<void>('/tutor/availability-rules/$id');
  }

  Future<List<AvailabilityExceptionDto>> getExceptions() async {
    final res = await _dio.get<List<dynamic>>('/tutor/availability-exceptions');
    return res.data!
        .map((e) =>
            AvailabilityExceptionDto.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<AvailabilityExceptionDto> createException(
    CreateExceptionRequest req,
  ) async {
    final res = await _dio.post<Map<String, dynamic>>(
      '/tutor/availability-exceptions',
      data: req.toJson(),
    );
    return AvailabilityExceptionDto.fromJson(res.data!);
  }

  Future<void> deleteException(String id) async {
    await _dio.delete<void>('/tutor/availability-exceptions/$id');
  }

  Future<List<SlotDto>> getSlots({
    String? from,
    String? to,
  }) async {
    final res = await _dio.get<List<dynamic>>(
      '/tutor/slots',
      queryParameters: {
        'from': ?from,
        'to': ?to,
      },
    );
    return res.data!
        .map((e) => SlotDto.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}

final scheduleApiProvider = Provider<ScheduleApi>((ref) {
  return ScheduleApi(ref.watch(dioProvider));
});
