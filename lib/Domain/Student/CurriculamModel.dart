class CurriculamModel {
  CurriculamModel({
    this.results,
  });

  String? results;

  factory CurriculamModel.fromJson(Map<String, dynamic> json) =>
      CurriculamModel(
        results: json["results"],
      );

  Map<String, dynamic> toJson() => {
        "results": results,
      };
}

class CurriculamAccessToken {
  CurriculamAccessToken({
    required this.accessToken,
  });

  String accessToken;

  factory CurriculamAccessToken.fromJson(Map<String, dynamic> json) => CurriculamAccessToken(
    accessToken: json["access_token"],
  );

  Map<String, dynamic> toJson() => {
    "access_token": accessToken,
  };
}