import 'package:freezed_annotation/freezed_annotation.dart';

part 'subject_dto.freezed.dart';
part 'subject_dto.g.dart';

@freezed
abstract class SubjectDto with _$SubjectDto {
  const factory SubjectDto({
    required String id,
    required String name,
    required String slug,
  }) = _SubjectDto;

  factory SubjectDto.fromJson(Map<String, dynamic> json) =>
      _$SubjectDtoFromJson(json);
}
