import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teachme_mobile/core/network/dio_client.dart';
import 'package:teachme_mobile/features/subjects/data/subject_dto.dart';

class SubjectApi {
  SubjectApi(this._dio);

  final Dio _dio;

  Future<List<SubjectDto>> getSubjects() async {
    final res = await _dio.get<List<dynamic>>('/subjects');
    return res.data!
        .map((e) => SubjectDto.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}

final subjectApiProvider = Provider<SubjectApi>((ref) {
  return SubjectApi(ref.watch(dioProvider));
});
