class MediaGenreModel{
  int id;
  String genreName;

  MediaGenreModel({
    required this.id,
    required this.genreName,
  });

  factory MediaGenreModel.fromJson(Map<String, dynamic> json) {
    return MediaGenreModel(
      id: json["id"] ?? 'N/A',
      genreName: json["name"] ?? 'N/A',
    );
  }
}

