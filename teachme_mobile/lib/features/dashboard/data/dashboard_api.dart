import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teachme_mobile/core/network/dio_client.dart';
import 'package:teachme_mobile/features/dashboard/data/dashboard_dto.dart';

class DashboardApi {
  DashboardApi(this._dio);

  final Dio _dio;

  Future<DashboardDto> getDashboard() async {
    final res = await _dio.get<Map<String, dynamic>>('/tutor/dashboard');
    return DashboardDto.fromJson(res.data!);
  }
}

final dashboardApiProvider = Provider<DashboardApi>((ref) {
  return DashboardApi(ref.watch(dioProvider));
});
