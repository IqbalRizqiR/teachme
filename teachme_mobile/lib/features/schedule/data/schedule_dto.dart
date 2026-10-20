import 'package:freezed_annotation/freezed_annotation.dart';

part 'schedule_dto.freezed.dart';
part 'schedule_dto.g.dart';

@freezed
abstract class AvailabilityRuleDto with _$AvailabilityRuleDto {
  const factory AvailabilityRuleDto({
    required String id,
    required int weekday,
    required int startMinute,
    required int endMinute,
  }) = _AvailabilityRuleDto;

  factory AvailabilityRuleDto.fromJson(Map<String, dynamic> json) =>
      _$AvailabilityRuleDtoFromJson(json);
}

@freezed
abstract class AvailabilityExceptionDto with _$AvailabilityExceptionDto {
  const factory AvailabilityExceptionDto({
    required String id,
    required String date,
    String? reason,
  }) = _AvailabilityExceptionDto;

  factory AvailabilityExceptionDto.fromJson(Map<String, dynamic> json) =>
      _$AvailabilityExceptionDtoFromJson(json);
}

@freezed
abstract class CreateRuleRequest with _$CreateRuleRequest {
  const factory CreateRuleRequest({
    required int weekday,
    required int startMinute,
    required int endMinute,
  }) = _CreateRuleRequest;

  factory CreateRuleRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateRuleRequestFromJson(json);
}

@freezed
abstract class CreateExceptionRequest with _$CreateExceptionRequest {
  const factory CreateExceptionRequest({
    required String date,
    String? reason,
  }) = _CreateExceptionRequest;

  factory CreateExceptionRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateExceptionRequestFromJson(json);
}
