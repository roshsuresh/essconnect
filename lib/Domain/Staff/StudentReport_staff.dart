class StudentReportInitialValues {
  List<StudReportSectionList>? sectionList;

  StudentReportInitialValues({this.sectionList});

  StudentReportInitialValues.fromJson(Map<String, dynamic> json) {
    if (json['sectionList'] != null) {
      sectionList = [];
      json['sectionList'].forEach((v) {
        sectionList!.add(StudReportSectionList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (sectionList != null) {
      data['sectionList'] = sectionList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StudReportSectionList {
  String? value;
  String? text;
  bool? selected;

  StudReportSectionList({this.value, this.text, this.selected});

  StudReportSectionList.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    text = json['text'];
    selected = json['selected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['text'] = text;
    data['selected'] = selected;
    return data;
  }
}

//course

class StudReportCourse {
  StudReportCourse({this.value, required this.text});

  String? value;
  String? text;

  factory StudReportCourse.fromJson(Map<String, dynamic> json) =>
      StudReportCourse(
        value: json["value"],
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "text": text,
      };
}

//Division

class StudReportDivision {
  String? value;
  String? text;

  StudReportDivision({this.value, this.text});

  StudReportDivision.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['text'] = text;
    return data;
  }
}

//View initial

class ViewStudentReport {
  String? studentId;
  String? admnNo;
  String? name;
  String? division;
  String? course;
  int? sectionOrder;
  int? courseOrder;
  int? divisionOrder;
  int? rollNo;
  String? mobNo;
  String? address;
  String? bus;
  String? stop;
  String? studentPhotoId;
  String? photo;
  String? photoId;
  String? studentPhoto;
  bool? terminationStatus;
  String? sectionId;
  String? courseId;
  String? divisionId;
  String? schoolId;
  bool? selected;

  ViewStudentReport(
      {this.studentId,
      this.admnNo,
      this.name,
      this.division,
      this.course,
      this.sectionOrder,
      this.courseOrder,
      this.divisionOrder,
      this.rollNo,
      this.mobNo,
      this.address,
      this.bus,
      this.stop,
      this.studentPhotoId,
      this.photo,
      this.photoId,
      this.studentPhoto,
      this.terminationStatus,
      this.sectionId,
      this.courseId,
      this.divisionId,
      this.schoolId,
      this.selected});

  ViewStudentReport.fromJson(Map<String, dynamic> json) {
    studentId = json['studentId'];
    admnNo = json['admnNo'];
    name = json['name'];
    division = json['division'];
    course = json['course'];
    sectionOrder = json['sectionOrder'];
    courseOrder = json['courseOrder'];
    divisionOrder = json['divisionOrder'];
    rollNo = json['rollNo'];
    mobNo = json['mobNo'];
    address = json['address'];
    bus = json['bus'];
    stop = json['stop'];
    studentPhotoId = json['studentPhotoId'];
    photo = json['photo'];
    photoId = json['photoId'];
    studentPhoto = json['studentPhoto'];
    terminationStatus = json['terminationStatus'];
    sectionId = json['sectionId'];
    courseId = json['courseId'];
    divisionId = json['divisionId'];
    schoolId = json['schoolId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['studentId'] = studentId;
    data['admnNo'] = admnNo;
    data['name'] = name;
    data['division'] = division;
    data['course'] = course;
    data['sectionOrder'] = sectionOrder;
    data['courseOrder'] = courseOrder;
    data['divisionOrder'] = divisionOrder;
    data['rollNo'] = rollNo;
    data['mobNo'] = mobNo;
    data['address'] = address;
    data['bus'] = bus;
    data['stop'] = stop;
    data['studentPhotoId'] = studentPhotoId;
    data['photo'] = photo;
    data['photoId'] = photoId;
    data['studentPhoto'] = studentPhoto;
    data['terminationStatus'] = terminationStatus;
    data['sectionId'] = sectionId;
    data['courseId'] = courseId;
    data['divisionId'] = divisionId;
    data['schoolId'] = schoolId;
    return data;
  }
}
