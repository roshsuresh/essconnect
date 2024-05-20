class Dashboard {
  Dashboard({
    this.totalStudentStrength,
    this.boysStrength,
    this.girlsStrength,
    this.totalStaffStrength,
    this.nonTeachingStrength,
    this.teachingStrength,
    this.flashNewsEventList,
  });

  int? totalStudentStrength;
  int? boysStrength;
  int? girlsStrength;
  int? totalStaffStrength;
  int? nonTeachingStrength;
  int? teachingStrength;
  List<FlashNewsEventList>? flashNewsEventList;

  factory Dashboard.fromJson(Map<String, dynamic> json) => Dashboard(
        totalStudentStrength: json["totalStudentStrength"],
        boysStrength: json["boysStrength"],
        girlsStrength: json["girlsStrength"],
        totalStaffStrength: json["totalStaffStrength"],
        nonTeachingStrength: json["nonTeachingStrength"],
        teachingStrength: json["teachingStrength"],
        flashNewsEventList: List<FlashNewsEventList>.from(
            json["flashNewsEventList"]
                .map((x) => FlashNewsEventList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "totalStudentStrength": totalStudentStrength,
        "boysStrength": boysStrength,
        "girlsStrength": girlsStrength,
        "totalStaffStrength": totalStaffStrength,
        "nonTeachingStrength": nonTeachingStrength,
        "teachingStrength": teachingStrength,
        "flashNewsEventList":
            List<dynamic>.from(flashNewsEventList!.map((x) => x.toJson())),
      };
}

class FlashNewsEventList {
  FlashNewsEventList({
    this.news,
  });

  String? news;

  factory FlashNewsEventList.fromJson(Map<String, dynamic> json) =>
      FlashNewsEventList(
        news: json["news"],
      );

  Map<String, dynamic> toJson() => {
        "news": news,
      };
}
