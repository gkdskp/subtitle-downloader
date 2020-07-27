import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:subtitle_downloader/constants.dart';
import 'package:subtitle_downloader/models/subtitles.dart';
import 'package:subtitle_downloader/utils/sort_list.dart';
import 'package:subtitle_downloader/utils/hash.dart';

class OpenSubtitlesService {
  static final _uaHeader = {'X-User-Agent': OpenSubUA};
  static const _subLang = 'eng';
  static const _apiPrefix =
      'https://rest.opensubtitles.org/search/sublanguageid-$_subLang';

  static Future<Map<String, String>> _getFileHash(File file) async => {
        'hash': await OpenSubtitlesHasher.computeFileHash(file),
        'size': (await file.length()).toString(),
        // 'hash': '319b23c54e9cf314',
        // 'size': '750005572'
      };

  // Returns the list of URIs to fetch data
  static Future<List<String>> _getApiUri(File file, [String title]) async {
    List<String> uris = [];
    try {
      final fileHash = await _getFileHash(file);
      uris.add(
          '$_apiPrefix/moviebytesize-${fileHash['size']}/moviehash-${fileHash['hash']}/');

      if (title != null && title != '')
        uris.add('$_apiPrefix/query-${Uri.encodeComponent(title)}');
    } catch (FileSystemException) {
      throw new FormatException('Could not access file');
    }

    return uris;
  }

  // Fetching the subtitles
  static Future<List<Subtitle>> fetch(File file, [String title]) async {
    List<Subtitle> subList = [];
    List<String> fetchedIDs = [];

    for (String uri in (await _getApiUri(file, title))) {
      try {
        var response = await http.get(uri, headers: _uaHeader);

        if (response.statusCode == 200) {
          (await jsonDecode(response.body) as List<dynamic>)
              .forEach((subtitle) {
            if (!fetchedIDs.contains(subtitle['IDSubtitleFile'])) {
              fetchedIDs.add(subtitle['IDSubtitleFile']);
              subList.add(Subtitle.fromAPI(subtitle));
            }
          });
        } else {
          throw new FormatException('Invalid response');
        }
      } catch (_) {
        throw new Exception('Failed to contact Opensubtitles.org');
      }
    }

    sortList(subList);
    return subList;
  }
}
