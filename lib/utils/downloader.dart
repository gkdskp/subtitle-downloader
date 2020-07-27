import 'dart:io';
import 'package:path/path.dart';
import 'package:archive/archive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:subtitle_downloader/models/subtitles.dart';

Future<String> downloadSub({Subtitle subtitle, File movieFile}) async {
  Directory tempDir = await getTemporaryDirectory();
  String zipDownloadPath = '${tempDir.path}/temp.zip';
  String subFileName =
      '${dirname(movieFile.path)}/${basenameWithoutExtension(movieFile.path)}.${subtitle.subFormat}';

  try {
    Dio dio = Dio();
    await dio.download(subtitle.zipDownloadLink, zipDownloadPath);
  } catch (_) {
    throw new Exception('Download failed');
  }

  try {
    ZipDecoder()
        .decodeBytes(File(zipDownloadPath).readAsBytesSync())
        .forEach((file) async {
      if (file.name == subtitle.fileName) {
        if (await Permission.storage.request().isGranted) {
          await (await File(subFileName).create()).writeAsBytes(file.content);
        } else {
          throw new Exception('No storage permission');
        }
      }
    });
  } catch (_) {
    throw new Exception('Error while reading archive');
  }

  return subFileName;
}
