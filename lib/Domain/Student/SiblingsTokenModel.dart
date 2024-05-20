class SiblingTokenModel {
  SiblingTokenModel({
    required this.accessToken,
  });

  String accessToken;

  factory SiblingTokenModel.fromJson(Map<String, dynamic> json) =>
      SiblingTokenModel(
        accessToken: json["access_token"],
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
      };
}
