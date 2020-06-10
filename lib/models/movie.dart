class Movie {
  String _title;
  String _year;
  String _imdbID;
  String _posterUrl;

  Movie._(
    this._title,
    this._year,
    this._imdbID,
    this._posterUrl,
  );

  factory Movie.fromAPI(Map<String, dynamic> movie) => Movie._(
        movie['Title'],
        movie['Year'],
        movie['imdbID'],
        movie['Poster'] == null
            ? movie['Poster']
            : 'https://upload.wikimedia.org/wikipedia/commons/c/c2/No_image_poster.png',
      );

  String get title => this._title;
  String get year => this._year;
  String get imdbID => this._imdbID;
  String get posterUrl => this._posterUrl;
}
