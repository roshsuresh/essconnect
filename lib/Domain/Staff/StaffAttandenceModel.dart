class Attendenceinitvalues {
  bool? isClassTeacher;
  bool? isDualAttendance;
  List<AttendenceCourse>? course;

  Attendenceinitvalues(
      {this.isClassTeacher, this.isDualAttendance, this.course});

  Attendenceinitvalues.fromJson(Map<String, dynamic> json) {
    isClassTeacher = json['isClassTeacher'];
    isDualAttendance = json['isDualAttendance'];
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['text'] = text;
    data['order'] = order;
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
