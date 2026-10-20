import 'package:dio/dio.dart';

Future<String> saveAndOpenCertificate({
  required Dio dio,
  required String certificateId,
}) async {
  throw UnsupportedError('Certificate download is not supported on this platform.');
}
