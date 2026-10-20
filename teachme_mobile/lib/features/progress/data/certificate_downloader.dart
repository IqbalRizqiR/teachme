import 'package:dio/dio.dart';
import 'certificate_downloader_stub.dart'
    if (dart.library.io) 'certificate_downloader_io.dart'
    if (dart.library.js_interop) 'certificate_downloader_web.dart' as impl;

Future<String> saveAndOpenCertificate({
  required Dio dio,
  required String certificateId,
}) {
  return impl.saveAndOpenCertificate(dio: dio, certificateId: certificateId);
}
