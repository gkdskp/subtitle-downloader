import 'dart:convert';

import 'package:http/http.dart' as http;

import '../constants.dart';
import '../models/movie.dart';

// class OMDBAApi {
//   static final String _apiKey = OMDbApiKey;
//   static final String _apiUrl = 'http://www.omdbapi.com/?apikey=$_apiKey';

//   static Future<List<Movie>> getMovies(String title) async {
//     if (title == '') return null;
//     var response = await http.get('$_apiUrl&s=$title').then((responseData) {
//       return responseData.body;
//     });

//     print(response);
//     Map<String, dynamic> result = await jsonDecode(response);
//     List<dynamic> movies = result["Search"];
//     return movies.map((movie) => Movie.fromAPI(movie)).toList();
//   }

//   static Future<List<Movie>> getEpisode(
//       String title, int season, int episode) async {
//     if (title == '') return null;
//     var response = await http
//         .get('$_apiUrl&t=$title&season=$season&episode=$episode&type=episode')
//         .then((responseData) {
//       return responseData.body;
//     });

//     Map<String, dynamic> result = await jsonDecode(response);
//     return [Movie.fromAPI(result)];
//   }
// }

class OMDBApi {
  static final String _apiKey = OMDbApiKey;
  static final String _apiPrefix = 'http://www.omdbapi.com/?apikey=$_apiKey';

  static Future<List<Movie>> getMovieList(
    String title, {
    int season,
    int episode,
  }) async {
    if (title == '')
      throw new FormatException('Title to be searched cannot be null');

    // Finding the api endpoint based on the type of file
    final String _apiUrl = (episode == null)
        ? '$_apiPrefix&s=$title'
        : '$_apiPrefix&t=$title&season=$season&episode=$episode&type=episode';

    var response = await http.get(_apiUrl);
    if (response.statusCode != 200) {
      print(response);
      throw new FormatException('Error contacting OMdB API');
    }

    Map<String, dynamic> result = await jsonDecode(response.body);

    // Returns list of Movie objects if it is not an episode
    // Else return a singleton list of the episode Movie object
    print(result);
    return (episode == null)
        ? await result['Search'].map((movie) => Movie.fromAPI(movie)).toList()
        : [Movie.fromAPI(result)];
  }
}
