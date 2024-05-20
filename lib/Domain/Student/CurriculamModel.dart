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
