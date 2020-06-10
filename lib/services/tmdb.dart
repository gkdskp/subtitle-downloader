// import 'dart:convert';
// import 'dart:core';
// import 'package:http/http.dart' as http;
// import 'package:subtitle_downloader/models/movie.dart';

// class TMDBAPi {
//   static const _apiPrefix = 'https://api.themoviedb.org/3';

//   static final _searchEndpoint =
//       '$_apiPrefix/search/multi?api_key=$_apiKey&language=en-US';

//   static Future<List<Movie>> getMovieList(
//     String title, {
//     int season,
//     int episode,
//   }) async {
//     if (title == '') {
//       throw new FormatException('Search string cannot be null');
//     }
//     // Encode the URI
//     final _apiUrl = Uri.encodeFull('$_searchEndpoint&query=$title');

//     var response = await http.get(_apiUrl);
//     if (response.statusCode != 200) {
//       throw new FormatException('Could not fetch data from TMDb API');
//     }

//     Map<String, dynamic> result = await jsonDecode(response.body);
//     result['results'].map();

//     return [];
//   }
// }
