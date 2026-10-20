// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DashboardDto _$DashboardDtoFromJson(Map<String, dynamic> json) =>
    _DashboardDto(
      thisWeekSessions: (json['thisWeekSessions'] as num).toInt(),
      pendingRequests: (json['pendingRequests'] as num).toInt(),
      earningsThisMonth: (json['earningsThisMonth'] as num).toInt(),
      ratingAvg: (json['ratingAvg'] as num).toDouble(),
      ratingCount: (json['ratingCount'] as num).toInt(),
      incomingBookings: (json['incomingBookings'] as List<dynamic>)
          .map((e) => BookingDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      upcomingSessions: (json['upcomingSessions'] as List<dynamic>)
          .map((e) => BookingDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      needsGrading: (json['needsGrading'] as List<dynamic>)
          .map((e) => BookingDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DashboardDtoToJson(_DashboardDto instance) =>
    <String, dynamic>{
      'thisWeekSessions': instance.thisWeekSessions,
      'pendingRequests': instance.pendingRequests,
      'earningsThisMonth': instance.earningsThisMonth,
      'ratingAvg': instance.ratingAvg,
      'ratingCount': instance.ratingCount,
      'incomingBookings': instance.incomingBookings,
      'upcomingSessions': instance.upcomingSessions,
      'needsGrading': instance.needsGrading,
    };
