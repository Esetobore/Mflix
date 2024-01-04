class MediaModel {
  int id;
  String title;
  String backDropPath;
  String originalTitle;
  String overview;
  String posterPath;
  String releaseDate;
  double voteAverage;
  String mediaType;
  List<dynamic> genre;

  MediaModel({
    required this.id,
    required this.title,
    required this.backDropPath,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.voteAverage,
    required this.genre,
    required this.mediaType
  });

  factory MediaModel.fromJson(Map<String, dynamic> json) {
    return MediaModel(
      id: json["id"] ?? 0,
      title: json["title"] ?? json["name"] ?? "",
      backDropPath: json["backdrop_path"] ?? "",
      originalTitle: json["original_title"] ?? json["name"] ?? "",
      overview: json["overview"] ?? "",
      posterPath: json["poster_path"] ?? "",
      releaseDate: json["release_date"] ?? json["first_air_date"] ?? "",
      voteAverage: json["vote_average"]?.toDouble() ?? 0.0,
      genre: json["genre_ids"] ?? [],
      mediaType: json["media_type"] ?? "",
    );
  }

}
