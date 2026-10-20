// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BookingTutor _$BookingTutorFromJson(Map<String, dynamic> json) =>
    _BookingTutor(id: json['id'] as String, name: json['name'] as String);

Map<String, dynamic> _$BookingTutorToJson(_BookingTutor instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};

_BookingStudent _$BookingStudentFromJson(Map<String, dynamic> json) =>
    _BookingStudent(id: json['id'] as String, name: json['name'] as String);

Map<String, dynamic> _$BookingStudentToJson(_BookingStudent instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};

_PaymentDto _$PaymentDtoFromJson(Map<String, dynamic> json) => _PaymentDto(
  id: json['id'] as String,
  orderId: json['orderId'] as String,
  amountIdr: (json['amountIdr'] as num).toInt(),
  status: json['status'] as String,
  method: json['method'] as String?,
  methods: (json['methods'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  reference: json['reference'] as String?,
);

Map<String, dynamic> _$PaymentDtoToJson(_PaymentDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'orderId': instance.orderId,
      'amountIdr': instance.amountIdr,
      'status': instance.status,
      'method': instance.method,
      'methods': instance.methods,
      'reference': instance.reference,
    };

_BookingDto _$BookingDtoFromJson(Map<String, dynamic> json) => _BookingDto(
  id: json['id'] as String,
  status: json['status'] as String,
  priceIdr: (json['priceIdr'] as num).toInt(),
  feeIdr: (json['feeIdr'] as num).toInt(),
  note: json['note'] as String?,
  rejectReason: json['rejectReason'] as String?,
  respondBy: json['respondBy'] as String,
  payBy: json['payBy'] as String?,
  createdAt: json['createdAt'] as String,
  slot: SlotDto.fromJson(json['slot'] as Map<String, dynamic>),
  tutor: json['tutor'] == null
      ? null
      : BookingTutor.fromJson(json['tutor'] as Map<String, dynamic>),
  student: json['student'] == null
      ? null
      : BookingStudent.fromJson(json['student'] as Map<String, dynamic>),
  subjectName: json['subjectName'] as String?,
  payment: json['payment'] == null
      ? null
      : PaymentDto.fromJson(json['payment'] as Map<String, dynamic>),
);

Map<String, dynamic> _$BookingDtoToJson(_BookingDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'priceIdr': instance.priceIdr,
      'feeIdr': instance.feeIdr,
      'note': instance.note,
      'rejectReason': instance.rejectReason,
      'respondBy': instance.respondBy,
      'payBy': instance.payBy,
      'createdAt': instance.createdAt,
      'slot': instance.slot,
      'tutor': instance.tutor,
      'student': instance.student,
      'subjectName': instance.subjectName,
      'payment': instance.payment,
    };

_CreateBookingRequest _$CreateBookingRequestFromJson(
  Map<String, dynamic> json,
) => _CreateBookingRequest(
  slotId: json['slotId'] as String,
  subjectId: json['subjectId'] as String,
  note: json['note'] as String?,
);

Map<String, dynamic> _$CreateBookingRequestToJson(
  _CreateBookingRequest instance,
) => <String, dynamic>{
  'slotId': instance.slotId,
  'subjectId': instance.subjectId,
  'note': instance.note,
};

_PaginatedBookings _$PaginatedBookingsFromJson(Map<String, dynamic> json) =>
    _PaginatedBookings(
      items: (json['items'] as List<dynamic>)
          .map((e) => BookingDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextCursor: json['nextCursor'] as String?,
    );

Map<String, dynamic> _$PaginatedBookingsToJson(_PaginatedBookings instance) =>
    <String, dynamic>{
      'items': instance.items,
      'nextCursor': instance.nextCursor,
    };
