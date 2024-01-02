class SeriesModel {
  int id;
  String backDropPath;
  String originalName;
  String overview;
  String posterPath;
  String firstAirDate;
  double voteAverage;
  List<dynamic> genre;

  SeriesModel({
    required this.id,
    required this.backDropPath,
    required this.originalName,
    required this.overview,
    required this.posterPath,
    required this.firstAirDate,
    required this.voteAverage,
    required this.genre
  });

  factory SeriesModel.fromJson(Map<String, dynamic> json) {
    return SeriesModel(
      id: json["id"],
      backDropPath: json["backdrop_path"],
      originalName: json["name"],
      overview: json["overview"],
      posterPath: json["poster_path"],
      firstAirDate: json["first_air_date"],
      voteAverage: json["vote_average"].toDouble(),
      genre: json["genre_ids"],
    );
  }
}