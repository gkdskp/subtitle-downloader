class Movie {
  String title;
  String year;
  String imdbID;
  String poster;

  Movie({
    this.title,
    this.year,
    this.imdbID,
    this.poster,
  });

  factory Movie.fromAPI(Map<String, dynamic> movie) {
    return Movie(
      title: movie['Title'],
      year: movie['Year'],
      imdbID: movie['imdbID'],
      poster: movie['Poster']
    );
  }
}
