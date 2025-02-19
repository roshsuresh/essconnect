
class StudReportSectionList {
  String? value;
  String? text;
  bool? selected;
  bool? active;
  int? order;

  StudReportSectionList({this.value, this.text, this.selected, this.active, this.order});

  StudReportSectionList.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    text = json['text'];
    selected = json['selected'];
    active = json['active'];
    order = json['order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['text'] = this.text;
    data['selected'] = this.selected;
    data['active'] = this.active;
    data['order'] = this.order;
    return data;
  }
}


//course

class StudReportCourse {
  String? value;
  String? text;
  bool? selected;
  bool? active;
  int? order;

  StudReportCourse({this.value, this.text, this.selected, this.active, this.order});

  StudReportCourse.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    text = json['text'];
    selected = json['selected'];
    active = json['active'];
    order = json['order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['text'] = this.text;
    data['selected'] = this.selected;
    data['active'] = this.active;
    data['order'] = this.order;
    return data;
  }
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
//Class Teachers

class ClassTeachersModel {
  String? name;
  String? division;
  String? classTeacherId;
  String? sortOrder;
  String? mobileNo;
  String? emailId;

  ClassTeachersModel(
      {this.name,
        this.division,
        this.classTeacherId,
        this.sortOrder,
        this.mobileNo,
        this.emailId});

  ClassTeachersModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    division = json['division'];
    classTeacherId = json['classTeacherId'];
    sortOrder = json['sortOrder'];
    mobileNo = json['mobileNo'];
    emailId = json['emailId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['division'] = this.division;
    data['classTeacherId'] = this.classTeacherId;
    data['sortOrder'] = this.sortOrder;
    data['mobileNo'] = this.mobileNo;
    data['emailId'] = this.emailId;
    return data;
  }
}
