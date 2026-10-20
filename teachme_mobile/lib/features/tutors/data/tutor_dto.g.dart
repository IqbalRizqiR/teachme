// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tutor_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TutorSubjectDto _$TutorSubjectDtoFromJson(Map<String, dynamic> json) =>
    _TutorSubjectDto(
      id: json['id'] as String,
      subjectId: json['subjectId'] as String,
      subjectName: json['subjectName'] as String,
      priceIdr: (json['priceIdr'] as num).toInt(),
    );

Map<String, dynamic> _$TutorSubjectDtoToJson(_TutorSubjectDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'subjectId': instance.subjectId,
      'subjectName': instance.subjectName,
      'priceIdr': instance.priceIdr,
    };

_TutorCard _$TutorCardFromJson(Map<String, dynamic> json) => _TutorCard(
  id: json['id'] as String,
  userId: json['userId'] as String,
  name: json['name'] as String,
  avatarUrl: json['avatarUrl'] as String?,
  ratingAvg: (json['ratingAvg'] as num).toDouble(),
  ratingCount: (json['ratingCount'] as num).toInt(),
  subjects: (json['subjects'] as List<dynamic>)
      .map((e) => TutorSubjectDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  nextSlot: json['nextSlot'] as String?,
);

Map<String, dynamic> _$TutorCardToJson(_TutorCard instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'name': instance.name,
      'avatarUrl': instance.avatarUrl,
      'ratingAvg': instance.ratingAvg,
      'ratingCount': instance.ratingCount,
      'subjects': instance.subjects,
      'nextSlot': instance.nextSlot,
    };

_TutorDetail _$TutorDetailFromJson(Map<String, dynamic> json) => _TutorDetail(
  id: json['id'] as String,
  userId: json['userId'] as String,
  name: json['name'] as String,
  avatarUrl: json['avatarUrl'] as String?,
  bio: json['bio'] as String?,
  isVerified: json['isVerified'] as bool,
  ratingAvg: (json['ratingAvg'] as num).toDouble(),
  ratingCount: (json['ratingCount'] as num).toInt(),
  subjects: (json['subjects'] as List<dynamic>)
      .map((e) => TutorSubjectDto.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$TutorDetailToJson(_TutorDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'name': instance.name,
      'avatarUrl': instance.avatarUrl,
      'bio': instance.bio,
      'isVerified': instance.isVerified,
      'ratingAvg': instance.ratingAvg,
      'ratingCount': instance.ratingCount,
      'subjects': instance.subjects,
    };

_SlotDto _$SlotDtoFromJson(Map<String, dynamic> json) => _SlotDto(
  id: json['id'] as String,
  startsAt: json['startsAt'] as String,
  endsAt: json['endsAt'] as String,
  status: json['status'] as String,
);

Map<String, dynamic> _$SlotDtoToJson(_SlotDto instance) => <String, dynamic>{
  'id': instance.id,
  'startsAt': instance.startsAt,
  'endsAt': instance.endsAt,
  'status': instance.status,
};

_ReviewDto _$ReviewDtoFromJson(Map<String, dynamic> json) => _ReviewDto(
  id: json['id'] as String,
  rating: (json['rating'] as num).toInt(),
  comment: json['comment'] as String?,
  studentName: json['studentName'] as String,
  createdAt: json['createdAt'] as String,
);

Map<String, dynamic> _$ReviewDtoToJson(_ReviewDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'rating': instance.rating,
      'comment': instance.comment,
      'studentName': instance.studentName,
      'createdAt': instance.createdAt,
    };

_PaginatedTutors _$PaginatedTutorsFromJson(Map<String, dynamic> json) =>
    _PaginatedTutors(
      items: (json['items'] as List<dynamic>)
          .map((e) => TutorCard.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextCursor: json['nextCursor'] as String?,
    );

Map<String, dynamic> _$PaginatedTutorsToJson(_PaginatedTutors instance) =>
    <String, dynamic>{
      'items': instance.items,
      'nextCursor': instance.nextCursor,
    };

_PaginatedReviews _$PaginatedReviewsFromJson(Map<String, dynamic> json) =>
    _PaginatedReviews(
      items: (json['items'] as List<dynamic>)
          .map((e) => ReviewDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextCursor: json['nextCursor'] as String?,
    );

Map<String, dynamic> _$PaginatedReviewsToJson(_PaginatedReviews instance) =>
    <String, dynamic>{
      'items': instance.items,
      'nextCursor': instance.nextCursor,
    };
