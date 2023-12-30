class SeriesModel {
  String backDropPath;
  String originalName;
  String overview;
  String posterPath;
  String firstAirDate;
  double voteAverage;

  SeriesModel({
    required this.backDropPath,
    required this.originalName,
    required this.overview,
    required this.posterPath,
    required this.firstAirDate,
    required this.voteAverage,
  });

  factory SeriesModel.fromJson(Map<String, dynamic> json) {
    return SeriesModel(
      backDropPath: json["backdrop_path"],
      originalName: json["original_name"],
      overview: json["overview"],
      posterPath: json["poster_path"],
      firstAirDate: json["first_air_date"],
      voteAverage: json["vote_average"].toDouble(),
    );
  }
}