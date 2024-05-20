
class NoticeBoardModel {
  NoticeBoardModel({
    required this.noticeId,
    required this.title,
    required this.matter,
    required this.entryDate,
    required this.entryTime,
    this.staffId,
    required this.staffName,
  });

  String noticeId;
  String title;
  String matter;
  DateTime entryDate;
  String entryTime;
  dynamic staffId;
  String staffName;

  factory NoticeBoardModel.fromJson(Map<String, dynamic> json) =>
      NoticeBoardModel(
        noticeId: json["noticeId"],
        title: json["title"],
        matter: json["matter"],
        entryDate: DateTime.parse(json["entryDate"]),
        entryTime: json["entryTime"],
        staffId: json["staffId"],
        staffName: json["staffName"],
      );

  Map<String, dynamic> toJson() => {
        "noticeId": noticeId,
        "title": title,
        "matter": matter,
        "entryDate":
            "${entryDate.year.toString().padLeft(4, '0')}-${entryDate.month.toString().padLeft(2, '0')}-${entryDate.day.toString().padLeft(2, '0')}",
        "entryTime": entryTime,
        "staffId": staffId,
        "staffName": staffName,
      };
}
