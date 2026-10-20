import 'package:freezed_annotation/freezed_annotation.dart';

part 'tutor_dto.freezed.dart';
part 'tutor_dto.g.dart';

@freezed
abstract class TutorSubjectDto with _$TutorSubjectDto {
  const factory TutorSubjectDto({
    required String id,
    required String subjectId,
    required String subjectName,
    required int priceIdr,
  }) = _TutorSubjectDto;

  factory TutorSubjectDto.fromJson(Map<String, dynamic> json) =>
      _$TutorSubjectDtoFromJson(json);
}

@freezed
abstract class TutorCard with _$TutorCard {
  const factory TutorCard({
    required String id,
    required String userId,
    required String name,
    String? avatarUrl,
    required double ratingAvg,
    required int ratingCount,
    required List<TutorSubjectDto> subjects,
    String? nextSlot,
  }) = _TutorCard;

  factory TutorCard.fromJson(Map<String, dynamic> json) =>
      _$TutorCardFromJson(json);
}

@freezed
abstract class TutorDetail with _$TutorDetail {
  const factory TutorDetail({
    required String id,
    required String userId,
    required String name,
    String? avatarUrl,
    String? bio,
    required bool isVerified,
    required double ratingAvg,
    required int ratingCount,
    required List<TutorSubjectDto> subjects,
  }) = _TutorDetail;

  factory TutorDetail.fromJson(Map<String, dynamic> json) =>
      _$TutorDetailFromJson(json);
}

@freezed
abstract class SlotDto with _$SlotDto {
  const factory SlotDto({
    required String id,
    required String startsAt,
    required String endsAt,
    required String status,
  }) = _SlotDto;

  factory SlotDto.fromJson(Map<String, dynamic> json) =>
      _$SlotDtoFromJson(json);
}

@freezed
abstract class ReviewDto with _$ReviewDto {
  const factory ReviewDto({
    required String id,
    required int rating,
    String? comment,
    required String studentName,
    required String createdAt,
  }) = _ReviewDto;

  factory ReviewDto.fromJson(Map<String, dynamic> json) =>
      _$ReviewDtoFromJson(json);
}

@freezed
abstract class PaginatedTutors with _$PaginatedTutors {
  const factory PaginatedTutors({
    required List<TutorCard> items,
    String? nextCursor,
  }) = _PaginatedTutors;

  factory PaginatedTutors.fromJson(Map<String, dynamic> json) =>
      _$PaginatedTutorsFromJson(json);
}

@freezed
abstract class PaginatedReviews with _$PaginatedReviews {
  const factory PaginatedReviews({
    required List<ReviewDto> items,
    String? nextCursor,
  }) = _PaginatedReviews;

  factory PaginatedReviews.fromJson(Map<String, dynamic> json) =>
      _$PaginatedReviewsFromJson(json);
}
