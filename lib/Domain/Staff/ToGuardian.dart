class NotificationToGuardian_initialValues {
  List<CommunicationToGuardian_course>? courseList;
  bool? isClassTeacher;
  NotificationToGuardian_initialValues({this.courseList, this.isClassTeacher});
  NotificationToGuardian_initialValues.fromJson(Map<String, dynamic> json) {
    if (json['courseList'] != null) {
      courseList = [];
      json['courseList'].forEach((v) {
        courseList!.add(CommunicationToGuardian_course.fromJson(v));
      });
    }
    isClassTeacher = json['isClassTeacher'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.courseList != null) {
      data['courseList'] = this.courseList!.map((v) => v.toJson()).toList();
    }

    data['isClassTeacher'] = this.isClassTeacher;
    return data;
  }
}

class CommunicationToGuardian_course {
  String? value;
  String? text;
  int? order;

  CommunicationToGuardian_course({this.value, this.text, this.order});

  CommunicationToGuardian_course.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    text = json['text'];
    order = json['order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['text'] = this.text;
    data['order'] = this.order;
    return data;
  }
}

class CommunicationToGuardian_Division {
  String? value;
  String? text;

  CommunicationToGuardian_Division({
    this.value,
    this.text,
  });

  CommunicationToGuardian_Division.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['text'] = this.text;
    return data;
  }
}

// //View

class StudentViewbyCourseDivision_notification_Stf {
  StudentViewbyCourseDivision_notification_Stf({
    required this.studentId,
    required this.name,
    required this.admnNo,
    required this.division,
    required this.course,
    required this.rollNo,
    required this.mobNo,
    this.selected,
  });

  String studentId;
  String name;
  String? admnNo;
  String? division;
  String? course;
  int? rollNo;
  String? mobNo;
  bool? selected;
  factory StudentViewbyCourseDivision_notification_Stf.fromJson(
          Map<String, dynamic> json) =>
      StudentViewbyCourseDivision_notification_Stf(
        studentId: json["studentId"],
        name: json["name"],
        admnNo: json["admnNo"],
        division: json["division"],
        course: json["course"],
        rollNo: json["rollNo"],
        mobNo: json["mobNo"],
      );

  Map<String, dynamic> toJson() => {
        "studentId": studentId,
        "name": name,
        "admnNo": admnNo,
        "division": division,
        "course": course,
        "rollNo": rollNo,
        "mobNo": mobNo,
        "division": division,
      };
}
