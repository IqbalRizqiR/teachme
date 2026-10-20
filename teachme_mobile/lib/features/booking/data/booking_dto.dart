import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:teachme_mobile/features/tutors/data/tutor_dto.dart';

part 'booking_dto.freezed.dart';
part 'booking_dto.g.dart';

@freezed
abstract class BookingTutor with _$BookingTutor {
  const factory BookingTutor({
    required String id,
    required String name,
  }) = _BookingTutor;

  factory BookingTutor.fromJson(Map<String, dynamic> json) =>
      _$BookingTutorFromJson(json);
}

@freezed
abstract class BookingStudent with _$BookingStudent {
  const factory BookingStudent({
    required String id,
    required String name,
  }) = _BookingStudent;

  factory BookingStudent.fromJson(Map<String, dynamic> json) =>
      _$BookingStudentFromJson(json);
}

@freezed
abstract class PaymentDto with _$PaymentDto {
  const factory PaymentDto({
    required String id,
    required String orderId,
    required int amountIdr,
    required String status,
    String? method,
    List<String>? methods,
    String? reference,
  }) = _PaymentDto;

  factory PaymentDto.fromJson(Map<String, dynamic> json) =>
      _$PaymentDtoFromJson(json);
}

@freezed
abstract class BookingDto with _$BookingDto {
  const factory BookingDto({
    required String id,
    required String status,
    required int priceIdr,
    required int feeIdr,
    String? note,
    String? rejectReason,
    required String respondBy,
    String? payBy,
    required String createdAt,
    required SlotDto slot,
    BookingTutor? tutor,
    BookingStudent? student,
    String? subjectName,
    PaymentDto? payment,
  }) = _BookingDto;

  factory BookingDto.fromJson(Map<String, dynamic> json) =>
      _$BookingDtoFromJson(json);
}

@freezed
abstract class CreateBookingRequest with _$CreateBookingRequest {
  const factory CreateBookingRequest({
    required String slotId,
    required String subjectId,
    String? note,
  }) = _CreateBookingRequest;

  factory CreateBookingRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateBookingRequestFromJson(json);
}

@freezed
abstract class PaginatedBookings with _$PaginatedBookings {
  const factory PaginatedBookings({
    required List<BookingDto> items,
    String? nextCursor,
  }) = _PaginatedBookings;

  factory PaginatedBookings.fromJson(Map<String, dynamic> json) =>
      _$PaginatedBookingsFromJson(json);
}
