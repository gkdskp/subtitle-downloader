import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../constants.dart';
import '../models/subtitles.dart';
import '../utils/sort_list.dart';
import '../utils/hash.dart';

class OpenSubtitlesService {
  static final _uaHeader = {'X-User-Agent': OpenSubUA};
  static const _subLang =
      'eng'; // Change this to obtain subtitles in other languages
  static const _apiPrefix =
      'https://rest.opensubtitles.org/search/sublanguageid-$_subLang';

  // This function returns a map of hash and size of the file
  static Future<Map<String, String>> _getFileHash(File file) async => {
        'hash': await OpenSubtitlesHasher.computeFileHash(file),
        'size': (await file.length()).toString(),
        // 'hash': '319b23c54e9cf314',
        // 'size': '750005572'
      };

  // Returns the list of URIs to fetch data
  static Future<List<String>> _getApiUri(File file, [String title]) async {
    List<String> uris = [];

    final fileHash = await _getFileHash(file);
    uris.add(
        '$_apiPrefix/moviebytesize-${fileHash['size']}/moviehash-${fileHash['hash']}/');

    if (title != null && title != '')
      uris.add('$_apiPrefix/query-${Uri.encodeComponent(title)}');

    return uris;
  }

  // Fetching the subtitles
  static Future<List<Subtitle>> fetch(File file, [String title]) async {
    List<Subtitle> subList = [];
    List<String> fetchedIDs = [];

    for (String uri in (await _getApiUri(file, title))) {
      var response = await http.get(uri, headers: _uaHeader);

      if (response.statusCode == 200) {
        (await jsonDecode(response.body) as List<dynamic>).forEach((subtitle) {
          if (!fetchedIDs.contains(subtitle['IDSubtitleFile'])) {
            // Add subtitle id to a list to prevent duplicates
            fetchedIDs.add(subtitle['IDSubtitleFile']);
            subList.add(Subtitle.fromAPI(subtitle));
          }
        });
      } else {
        throw new FormatException('Failed to contact Opensubtitles.org');
      }
    }

    sortList(subList);
    return subList;
  }
}

main(List<String> args) {
  OpenSubtitlesService.fetch(null, 'Shadowhunters S02E20');
}
