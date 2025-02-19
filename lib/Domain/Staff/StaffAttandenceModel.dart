class Attendenceinitvalues {
  bool? isClassTeacher;
  bool? isDualAttendance;
  bool? smsLinkAttendance;
  List<AttendenceCourse>? course;

  Attendenceinitvalues(
      {this.isClassTeacher, this.isDualAttendance, this.course});

  Attendenceinitvalues.fromJson(Map<String, dynamic> json) {
    isClassTeacher = json['isClassTeacher'];
    isDualAttendance = json['isDualAttendance'];
    smsLinkAttendance = json['smsLinkAttendance'];
    if (json['course'] != null) {
      course = [];
      json['course'].forEach((v) {
        course!.add(AttendenceCourse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isClassTeacher'] = isClassTeacher;
    data['isDualAttendance'] = isDualAttendance;
    data['smsLinkAttendance'] = smsLinkAttendance;
    if (course != null) {
      data['course'] = course!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class AttendenceCourse {
  String? value;
  String? text;
  int? order;

  AttendenceCourse({this.value, this.text, this.order});

  AttendenceCourse.fromJson(Map<String, dynamic> json) {
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

class AttendenceDivisions {
  String? value;
  String? text;

  AttendenceDivisions({this.value, this.text});

  AttendenceDivisions.fromJson(Map<String, dynamic> json) {
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

//view


class StudentAttendance {
  List<StudentsAttendenceView_stf>? studentList;
  bool? isDisabled;

  StudentAttendance({this.studentList, this.isDisabled});

  StudentAttendance.fromJson(Map<String, dynamic> json) {
    if (json['studentList'] != null) {
      studentList = <StudentsAttendenceView_stf>[];
      json['studentList'].forEach((v) {
        studentList!.add(new StudentsAttendenceView_stf.fromJson(v));
      });
    }
    isDisabled = json['isDisabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.studentList != null) {
      data['studentList'] = this.studentList!.map((v) => v.toJson()).toList();
    }
    data['isDisabled'] = this.isDisabled;
    return data;
  }
}

class StudentsAttendenceView_stf {
  String? studAttId;
  String? divisionId;
  String? id;
  String? forenoon;
  String? afternoon;
  String? admNo;
  int? rollNo;
  String? name;
  bool? terminatedStatus;
  bool? select;
  bool? selectedd;
  String? absent;

  StudentsAttendenceView_stf(
      {this.studAttId,
      this.divisionId,
      this.id,
      this.forenoon,
      this.afternoon,
      this.admNo,
      this.rollNo,
      this.name,
        this.terminatedStatus,
      this.select,
      this.selectedd,
      this.absent});

  StudentsAttendenceView_stf.fromJson(Map<String, dynamic> json) {
    studAttId = json['studAttId'];
    divisionId = json['divisionId'];
    id = json['id'];
    forenoon = json['forenoon'];
    afternoon = json['afternoon'];
    admNo = json['admNo'];
    rollNo = json['rollNo'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['studAttId'] = studAttId;
    data['divisionId'] = divisionId;
    data['id'] = id;
    data['forenoon'] = forenoon;
    data['afternoon'] = afternoon;
    data['admNo'] = admNo;
    data['rollNo'] = rollNo;
    data['name'] = name;
    data['id'] = id;
    data['id'] = id;
    data['id'] = id;
    return data;
  }
}



class AttendanceSaveModel {
  AttendanceSaveModel({
    this.studAttId,
    this.divisionId,
    this.id,
    this.forenoon,
    this.afternoon,
    this.admNo,
    this.rollNo,
    this.name,
    this.terminatedStatus,
  });

  dynamic studAttId;
  String? divisionId;
  String? id;
  String? forenoon;
  String? afternoon;
  String? admNo;
  int? rollNo;
  String? name;
  bool? terminatedStatus;

  factory AttendanceSaveModel.fromJson(Map<String, dynamic> json) => AttendanceSaveModel(
    studAttId: json["studAttId"],
    divisionId: json["divisionId"],
    id: json["id"],
    forenoon: json["forenoon"],
    afternoon: json["afternoon"],
    admNo: json["admNo"],
    rollNo: json["rollNo"],
    name: json["name"],
    terminatedStatus: json["terminatedStatus"],
  );

  Map<String, dynamic> toJson() => {
    "studAttId": studAttId,
    "divisionId": divisionId,
    "id": id,
    "forenoon": forenoon,
    "afternoon": afternoon,
    "admNo": admNo,
    "rollNo": rollNo,
    "name": name,
    "terminatedStatus": terminatedStatus,
  };
}
