import 'dart:io';

import 'package:path/path.dart';
import 'package:archive/archive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:permission_handler/permission_handler.dart';

import '../models/subtitles.dart';

Future<String> downloadFile(String url) async {
  Directory tempDir = await getTemporaryDirectory();
  String tempPath = tempDir.path;
  Dio dio = Dio();
  Response response = await dio.download(url, '$tempPath/temp.zip');
  print(response.toString());

  return '$tempPath/temp.zip';
}

void unArchive(
    File zipFile, String subFileName, File movieFile, String subFileExt) async {
  var data = zipFile.readAsBytesSync();
  var archive = ZipDecoder().decodeBytes(data);
  for (var file in archive) {
    print(file.name + ' - ' + subFileName);
    if (file.name == subFileName) {
      String subFileName =
          '${dirname(movieFile.path)}/${basenameWithoutExtension(movieFile.path)}.$subFileExt';
      var subFile = File(subFileName);
      // code of read or write file in external storage (SD card)
      if (await Permission.storage.request().isGranted) {
        // code of read or write file in external storage (SD card)
        subFile = await subFile.create();
        await subFile.writeAsBytes(file.content);
      }
    }
  }
}

Future<bool> downloadSub({Subtitle subtitle, File movieFile}) async {
  var zipFile = await downloadFile(subtitle.zipDownloadLink);
  await unArchive(
      File(zipFile), subtitle.fileName, movieFile, subtitle.subFormat);
  return true;
}
