class CastModel {
  String originalName;
   String profilePath;
   String character;

  CastModel({
    required this.originalName,
     required this.profilePath,
     required this.character,

});

  factory CastModel.fromJson(Map<String, dynamic> json) {
    return CastModel(
      originalName: json["original_name"] ?? "",
      profilePath: json["profile_path"] ?? "",
      character: json["character"] ?? "",
    );
  }


}