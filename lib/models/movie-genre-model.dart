class MovieGenreModel{
  int id;
  String genreName;

  MovieGenreModel({
    required this.id,
    required this.genreName,
  });

  factory MovieGenreModel.fromJson(Map<String, dynamic> json) {
    return MovieGenreModel(
      id: json["id"] ?? 'N/A',
      genreName: json["name"] ?? 'N/A',
    );
  }
}

