import 'dart:convert';

StudentListModel studentListModelFromJson(String str) =>
    StudentListModel.fromJson(json.decode(str));

String studentListModelToJson(StudentListModel data) =>
    json.encode(data.toJson());

class StudentListModel {
  StudentListModel({
    this.userId,
    required this.studentId,
    required this.name,
    required this.admissionNo,
    this.division,
    required this.course,
    this.rollNo,
    this.sectionOrder,
    this.courseOrder,
    this.divisionOrder,
    this.mobileNo,
    this.presentAddress,
    this.busName,
    this.busStop,
    this.studentPhoto,
    this.studentPhotoId,
    this.selected,
  });

  String? userId;
  String studentId;
  String name;
  String? admissionNo;
  String? division;
  String course;
  int? rollNo;
  int? sectionOrder;
  int? courseOrder;
  int? divisionOrder;
  dynamic mobileNo;
  String? presentAddress;
  String? busName;
  String? busStop;
  dynamic studentPhoto;
  dynamic studentPhotoId;
  bool? selected;

  factory StudentListModel.fromJson(Map<String, dynamic> json) =>
      StudentListModel(
        userId: json["userId"],
        studentId: json["studentId"],
        name: json["name"],
        admissionNo: json["admissionNo"],
        division: json["division"],
        course: json["course"],
        rollNo: json["rollNo"],
        sectionOrder: json["sectionOrder"],
        courseOrder: json["courseOrder"],
        divisionOrder: json["divisionOrder"],
        mobileNo: json["mobileNo"],
        presentAddress: json["presentAddress"],
        busName: json["busName"],
        busStop: json["busStop"],
        studentPhoto: json["studentPhoto"],
        studentPhotoId: json["studentPhotoId"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "studentId": studentId,
        "name": name,
        "admissionNo": admissionNo,
        "division": division,
        "course": course,
        "rollNo": rollNo,
        "sectionOrder": sectionOrder,
        "courseOrder": courseOrder,
        "divisionOrder": divisionOrder,
        "mobileNo": mobileNo,
        "presentAddress": presentAddress,
        "busName": busName,
        "busStop": busStop,
        "studentPhoto": studentPhoto,
        "studentPhotoId": studentPhotoId,
      };
}

class CourseList {
  CourseList({
    required this.courseId,
    required this.name,
    required this.sectionOrder,
    required this.courseOrder,
  });

  String courseId;
  String name;
  int sectionOrder;
  int courseOrder;

  factory CourseList.fromJson(Map<String, dynamic> json) => CourseList(
        courseId: json["courseId"],
        name: json["name"],
        sectionOrder: json["sectionOrder"],
        courseOrder: json["courseOrder"],
      );

  Map<String, dynamic> toJson() => {
        "courseId": courseId,
        "name": name,
        "sectionOrder": sectionOrder,
        "courseOrder": courseOrder,
      };
}

class DivisionList {
  DivisionList({
    required this.divisionId,
    required this.name,
    required this.sectionOrder,
    required this.courseOrder,
    required this.divisionOrder,
  });

  String divisionId;
  String name;
  int sectionOrder;
  int courseOrder;
  int divisionOrder;

  factory DivisionList.fromJson(Map<String, dynamic> json) => DivisionList(
        divisionId: json["divisionId"],
        name: json["name"],
        sectionOrder: json["sectionOrder"],
        courseOrder: json["courseOrder"],
        divisionOrder: json["divisionOrder"],
      );

  Map<String, dynamic> toJson() => {
        "divisionId": divisionId,
        "name": name,
        "sectionOrder": sectionOrder,
        "courseOrder": courseOrder,
        "divisionOrder": divisionOrder,
      };
}
