// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AvailabilityRuleDto _$AvailabilityRuleDtoFromJson(Map<String, dynamic> json) =>
    _AvailabilityRuleDto(
      id: json['id'] as String,
      weekday: (json['weekday'] as num).toInt(),
      startMinute: (json['startMinute'] as num).toInt(),
      endMinute: (json['endMinute'] as num).toInt(),
    );

Map<String, dynamic> _$AvailabilityRuleDtoToJson(
  _AvailabilityRuleDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'weekday': instance.weekday,
  'startMinute': instance.startMinute,
  'endMinute': instance.endMinute,
};

_AvailabilityExceptionDto _$AvailabilityExceptionDtoFromJson(
  Map<String, dynamic> json,
) => _AvailabilityExceptionDto(
  id: json['id'] as String,
  date: json['date'] as String,
  reason: json['reason'] as String?,
);

Map<String, dynamic> _$AvailabilityExceptionDtoToJson(
  _AvailabilityExceptionDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'date': instance.date,
  'reason': instance.reason,
};

_CreateRuleRequest _$CreateRuleRequestFromJson(Map<String, dynamic> json) =>
    _CreateRuleRequest(
      weekday: (json['weekday'] as num).toInt(),
      startMinute: (json['startMinute'] as num).toInt(),
      endMinute: (json['endMinute'] as num).toInt(),
    );

Map<String, dynamic> _$CreateRuleRequestToJson(_CreateRuleRequest instance) =>
    <String, dynamic>{
      'weekday': instance.weekday,
      'startMinute': instance.startMinute,
      'endMinute': instance.endMinute,
    };

_CreateExceptionRequest _$CreateExceptionRequestFromJson(
  Map<String, dynamic> json,
) => _CreateExceptionRequest(
  date: json['date'] as String,
  reason: json['reason'] as String?,
);

Map<String, dynamic> _$CreateExceptionRequestToJson(
  _CreateExceptionRequest instance,
) => <String, dynamic>{'date': instance.date, 'reason': instance.reason};
