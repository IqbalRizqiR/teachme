// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'progress_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProgressEntryDto _$ProgressEntryDtoFromJson(Map<String, dynamic> json) =>
    _ProgressEntryDto(
      sessionNo: (json['sessionNo'] as num).toInt(),
      date: json['date'] as String,
      score: (json['score'] as num).toInt(),
      note: json['note'] as String,
      subjectName: json['subjectName'] as String,
      tutorName: json['tutorName'] as String,
    );

Map<String, dynamic> _$ProgressEntryDtoToJson(_ProgressEntryDto instance) =>
    <String, dynamic>{
      'sessionNo': instance.sessionNo,
      'date': instance.date,
      'score': instance.score,
      'note': instance.note,
      'subjectName': instance.subjectName,
      'tutorName': instance.tutorName,
    };

_ProgressSummary _$ProgressSummaryFromJson(Map<String, dynamic> json) =>
    _ProgressSummary(
      targetScore: (json['targetScore'] as num?)?.toInt(),
      minSessions: (json['minSessions'] as num?)?.toInt(),
      completedSessions: (json['completedSessions'] as num).toInt(),
      average: (json['average'] as num).toDouble(),
    );

Map<String, dynamic> _$ProgressSummaryToJson(_ProgressSummary instance) =>
    <String, dynamic>{
      'targetScore': instance.targetScore,
      'minSessions': instance.minSessions,
      'completedSessions': instance.completedSessions,
      'average': instance.average,
    };

_ProgressResponse _$ProgressResponseFromJson(Map<String, dynamic> json) =>
    _ProgressResponse(
      entries: (json['entries'] as List<dynamic>)
          .map((e) => ProgressEntryDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      summary: ProgressSummary.fromJson(
        json['summary'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$ProgressResponseToJson(_ProgressResponse instance) =>
    <String, dynamic>{'entries': instance.entries, 'summary': instance.summary};

_EnrollmentDto _$EnrollmentDtoFromJson(Map<String, dynamic> json) =>
    _EnrollmentDto(
      id: json['id'] as String,
      subjectName: json['subjectName'] as String,
      tutorName: json['tutorName'] as String,
      targetScore: (json['targetScore'] as num?)?.toInt(),
      minSessions: (json['minSessions'] as num?)?.toInt(),
      completedSessions: (json['completedSessions'] as num).toInt(),
      averageScore: (json['averageScore'] as num).toDouble(),
      hasCertificate: json['hasCertificate'] as bool,
      certificateId: json['certificateId'] as String?,
    );

Map<String, dynamic> _$EnrollmentDtoToJson(_EnrollmentDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'subjectName': instance.subjectName,
      'tutorName': instance.tutorName,
      'targetScore': instance.targetScore,
      'minSessions': instance.minSessions,
      'completedSessions': instance.completedSessions,
      'averageScore': instance.averageScore,
      'hasCertificate': instance.hasCertificate,
      'certificateId': instance.certificateId,
    };
