import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../constants.dart';
import '../data/subtitles.dart';
import '../utils/sublist_process.dart';
import '../utils/hash.dart';

class OpenSubs {
  static final _apiUrl = 'https://rest.opensubtitles.org/search/';
  static final _UA = OpenSubUA;
  static final _sublang = 'eng';

  static Future<Map<String, String>> _getFileInfo(File file) async {
    var hash = await OpenSubtitlesHasher.computeFileHash(file);
    var size = await file.length();
    return {
      "hash": hash,
      "size": size.toString(),
    };
  }

  static String _generateURIFromFile(String hash, String size) =>
      '${_apiUrl}moviebytesize-$size/moviehash-$hash/sublanguageid-$_sublang/';
  static String _generateURIFromID({String imdbID}) =>
      '${_apiUrl}imdbid-$imdbID/sublanguageid-$_sublang/';

  static Future<List<Subtitle>> fetchByFile({File file}) async {
    final fileInfo = await _getFileInfo(file);
    var _uri =
        _generateURIFromFile(fileInfo['hash'], fileInfo['size']);
    return await _getSubList(_uri);
  }

  static Future<List<Subtitle>> fetchByID({File file, String imdbID}) async {
    final fileInfo = await _getFileInfo(file);
    var _uri =
        _generateURIFromFile(fileInfo['hash'], fileInfo['size']);
    var list1 = await _getSubList(_uri);
    _uri = _generateURIFromID(imdbID: imdbID);
    var list2 = await _getSubList(_uri);
    return joinLists(list1, list2);
  }

  static Future<List<Subtitle>> _getSubList(String _uri) async {
    var response = await http
        .get(_uri, headers: {'X-User-Agent': _UA});
    if (response.statusCode != 200) {
      return [];
    } else {
      List<dynamic> subtitles = await jsonDecode(response.body);
      var subList = subtitles.map((subtitle) {
        return Subtitle.fromAPI(subtitle);
      }).toList();
      sortList(subList);
      return subList;
    }
  }
}
