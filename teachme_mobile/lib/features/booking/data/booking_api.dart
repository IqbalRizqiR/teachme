import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teachme_mobile/core/network/dio_client.dart';
import 'package:teachme_mobile/features/booking/data/booking_dto.dart';

class BookingApi {
  BookingApi(this._dio);

  final Dio _dio;

  Future<BookingDto> createBooking(CreateBookingRequest req) async {
    final res = await _dio.post<Map<String, dynamic>>(
      '/bookings',
      data: req.toJson(),
    );
    return BookingDto.fromJson(res.data!);
  }

  Future<PaginatedBookings> listBookings({
    String? status,
    String? cursor,
    int limit = 20,
  }) async {
    final res = await _dio.get<Map<String, dynamic>>(
      '/bookings',
      queryParameters: {
        'status': ?status,
        'cursor': ?cursor,
        'limit': limit,
      },
    );
    return PaginatedBookings.fromJson(res.data!);
  }

  Future<BookingDto> getBooking(String id) async {
    final res = await _dio.get<Map<String, dynamic>>('/bookings/$id');
    return BookingDto.fromJson(res.data!);
  }

  Future<BookingDto> acceptBooking(String id) async {
    final res = await _dio.post<Map<String, dynamic>>('/bookings/$id/accept');
    return BookingDto.fromJson(res.data!);
  }

  Future<BookingDto> rejectBooking(String id, {String? reason}) async {
    final res = await _dio.post<Map<String, dynamic>>(
      '/bookings/$id/reject',
      data: {'reason': ?reason},
    );
    return BookingDto.fromJson(res.data!);
  }

  Future<BookingDto> cancelBooking(String id) async {
    final res = await _dio.post<Map<String, dynamic>>('/bookings/$id/cancel');
    return BookingDto.fromJson(res.data!);
  }

  Future<PaymentDto> initiatePayment(String bookingId) async {
    final res = await _dio.post<Map<String, dynamic>>(
      '/bookings/$bookingId/pay',
    );
    return PaymentDto.fromJson(res.data!);
  }

  Future<void> settlePayment(String orderId) async {
    await _dio.post<void>('/dev/payments/$orderId/settle');
  }

  Future<BookingDto> gradeBooking(
    String id, {
    required int score,
    required String note,
  }) async {
    final res = await _dio.post<Map<String, dynamic>>(
      '/bookings/$id/grade',
      data: {'score': score, 'note': note},
    );
    return BookingDto.fromJson(res.data!);
  }

  Future<void> reviewBooking(
    String id, {
    required int rating,
    String? comment,
  }) async {
    await _dio.post<void>(
      '/bookings/$id/review',
      data: {
        'rating': rating,
        'comment': ?comment,
      },
    );
  }
}

final bookingApiProvider = Provider<BookingApi>((ref) {
  return BookingApi(ref.watch(dioProvider));
});
