import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:subtitle_downloader/services/tmdb.dart';

import '../components/movie_card.dart';
import '../models/movie.dart';
import '../services/omdb.dart';

class MovieList extends StatefulWidget {
  final String title;
  final int season;
  final int episode;
  final Function handlePress;

  MovieList({this.title, this.season, this.episode, this.handlePress});

  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  List<Movie> _movieList = [];
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
    getMovies();
  }

  void getMovies() async {
    var movieList = [];
    setState(() {
      _isLoading = true;
    });
    if (widget.season != null && widget.episode != null)
    //   movieList = await TMDBAPi.getMovieList(
    //       widget.title, season: widget.season, episode: widget.episode);
    // else
    //   movieList = await TMDBAPi.getMovieList(widget.title);
    setState(() {
      _movieList = movieList;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select movie'),
      ),
      body: ModalProgressHUD(
        child: ListView.builder(
          padding: EdgeInsets.all(10),
          itemCount: _movieList.length,
          itemBuilder: (BuildContext context, int index) {
            return MovieCard(
              _movieList[index],
              widget.handlePress,
            );
          },
        ),
        inAsyncCall: _isLoading,
      ),
    );
  }
}
