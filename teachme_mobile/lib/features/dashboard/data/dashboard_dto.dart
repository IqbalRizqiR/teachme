import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:teachme_mobile/features/booking/data/booking_dto.dart';

part 'dashboard_dto.freezed.dart';
part 'dashboard_dto.g.dart';

@freezed
abstract class DashboardDto with _$DashboardDto {
  const factory DashboardDto({
    required int thisWeekSessions,
    required int pendingRequests,
    required int earningsThisMonth,
    required double ratingAvg,
    required int ratingCount,
    required List<BookingDto> incomingBookings,
    required List<BookingDto> upcomingSessions,
    required List<BookingDto> needsGrading,
  }) = _DashboardDto;

  factory DashboardDto.fromJson(Map<String, dynamic> json) =>
      _$DashboardDtoFromJson(json);
}
