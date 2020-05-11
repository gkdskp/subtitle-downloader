import 'package:flutter/material.dart';
import 'package:subtitle_downloader/data/movie.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final Function onPress;

  MovieCard(this.movie, this.onPress);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 125,
        child: InkWell(
          onTap: () => onPress(movie.imdbID),
          child: Row(
            children: [
              Container(
                  child: Image.network(
                    (movie.poster != null) ? movie.poster: null,
                  ),
                  width: 100),
              Expanded(
                child: Container(
                  child: ListTile(
                    title: Text(movie.title),
                    subtitle: Text(movie.year),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
