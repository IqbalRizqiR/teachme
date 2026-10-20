import 'dart:io';

import 'package:dio/dio.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

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

  final directory = await getTemporaryDirectory();
  final path = '${directory.path}/certificate_$certificateId.pdf';
  await File(path).writeAsBytes(bytes);
  await OpenFilex.open(path);

  return path;
}
