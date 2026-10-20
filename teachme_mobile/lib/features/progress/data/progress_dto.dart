import 'package:freezed_annotation/freezed_annotation.dart';

part 'progress_dto.freezed.dart';
part 'progress_dto.g.dart';

@freezed
abstract class ProgressEntryDto with _$ProgressEntryDto {
  const factory ProgressEntryDto({
    required int sessionNo,
    required String date,
    required int score,
    required String note,
    required String subjectName,
    required String tutorName,
  }) = _ProgressEntryDto;

  factory ProgressEntryDto.fromJson(Map<String, dynamic> json) =>
      _$ProgressEntryDtoFromJson(json);
}

@freezed
abstract class ProgressSummary with _$ProgressSummary {
  const factory ProgressSummary({
    int? targetScore,
    int? minSessions,
    required int completedSessions,
    required double average,
  }) = _ProgressSummary;

  factory ProgressSummary.fromJson(Map<String, dynamic> json) =>
      _$ProgressSummaryFromJson(json);
}

@freezed
abstract class ProgressResponse with _$ProgressResponse {
  const factory ProgressResponse({
    required List<ProgressEntryDto> entries,
    required ProgressSummary summary,
  }) = _ProgressResponse;

  factory ProgressResponse.fromJson(Map<String, dynamic> json) =>
      _$ProgressResponseFromJson(json);
}

@freezed
abstract class EnrollmentDto with _$EnrollmentDto {
  const factory EnrollmentDto({
    required String id,
    required String subjectName,
    required String tutorName,
    int? targetScore,
    int? minSessions,
    required int completedSessions,
    required double averageScore,
    required bool hasCertificate,
    String? certificateId,
  }) = _EnrollmentDto;

  factory EnrollmentDto.fromJson(Map<String, dynamic> json) =>
      _$EnrollmentDtoFromJson(json);
}
