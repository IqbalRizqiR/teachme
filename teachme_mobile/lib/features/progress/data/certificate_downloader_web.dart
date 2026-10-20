import 'dart:js_interop';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:web/web.dart' as web;

Future<String> saveAndOpenCertificate({
  required Dio dio,
  required String certificateId,
}) async {
  final response = await dio.get<List<int>>(
    '/certificates/$certificateId/download',
    options: Options(responseType: ResponseType.bytes),
  );

  final bytes = response.data;
  if (bytes == null) {
    throw StateError('Empty certificate payload');
  }

  final blob = web.Blob(
    [Uint8List.fromList(bytes).toJS].toJS,
    web.BlobPropertyBag(type: 'application/pdf'),
  );
  final url = web.URL.createObjectURL(blob);
  final fileName = 'certificate_$certificateId.pdf';

  final anchor = web.document.createElement('a') as web.HTMLAnchorElement
    ..href = url
    ..download = fileName
    ..style.display = 'none';

  web.document.body?.appendChild(anchor);
  anchor.click();
  anchor.remove();

  SchedulerBinding.instance.addPostFrameCallback((_) {
    web.URL.revokeObjectURL(url);
  });

  if (kDebugMode) {
    debugPrint('Certificate downloaded: $fileName');
  }

  return fileName;
}
