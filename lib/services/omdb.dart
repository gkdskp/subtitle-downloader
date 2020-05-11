import 'dart:convert';

import 'package:http/http.dart' as http;

import '../constants.dart';
import '../data/movie.dart';

class OMDBAApi {
  static final String _apiKey = OMDbApiKey;
  static final String _apiUrl = 'http://www.omdbapi.com/?apikey=$_apiKey';

  static Future<List<Movie>> getMovies(String title) async {
    if (title == '') return null;
    var response = await http.get('$_apiUrl&s=$title').then((responseData) {
      return responseData.body;
    });

    print(response);
    Map<String, dynamic> result = await jsonDecode(response);
    List<dynamic> movies = result["Search"];
    return movies.map((movie) => Movie.fromAPI(movie)).toList();
  }

  static Future<List<Movie>> getEpisode(
      String title, int season, int episode) async {
    if (title == '') return null;
    var response = await http
        .get('$_apiUrl&t=$title&season=$season&episode=$episode&type=episode')
        .then((responseData) {
      return responseData.body;
    });

    Map<String, dynamic> result = await jsonDecode(response);
    return [Movie.fromAPI(result)];
  }
}
