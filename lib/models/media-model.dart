class MediaModel {
  int id;
  String title; // Use title for both movies and series
  String backDropPath;
  String originalTitle; // Use originalTitle for both movies and series
  String overview;
  String posterPath;
  List<String> mediaType;
  String releaseDate; // Assuming it applies to both movies and series
  double voteAverage;
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
      id: json["id"] ?? 0, // Provide a default value if "id" is null
      title: json["title"] ?? json["name"] ?? "", // Use title for both movies and series
      backDropPath: json["backdrop_path"] ?? "",
      originalTitle: json["original_title"] ?? json["name"] ?? "", // Use originalTitle for both movies and series
      overview: json["overview"] ?? "",
      posterPath: json["poster_path"] ?? "",
      releaseDate: json["release_date"] ?? json["first_air_date"] ?? "", // Assuming it applies to both movies and series
      voteAverage: json["vote_average"]?.toDouble() ?? 0.0,
      genre: json["genre_ids"] ?? [],
      mediaType: json[""] ?? ["movie"] ?? ["tv"]
    );
  }

}
