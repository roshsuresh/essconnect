class TextSMSToGuardian {
  List<TextSMSToGuardianCourseList>? courseList;
  bool? isClassTeacher;
  TextSMSToGuardian({this.courseList, this.isClassTeacher});
  TextSMSToGuardian.fromJson(Map<String, dynamic> json) {
    if (json['courseList'] != null) {
      courseList = [];
      json['courseList'].forEach((v) {
        courseList!.add(TextSMSToGuardianCourseList.fromJson(v));
      });
    }
    isClassTeacher = json['isClassTeacher'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (courseList != null) {
      data['courseList'] = courseList!.map((v) => v.toJson()).toList();
    }

    data['isClassTeacher'] = isClassTeacher;
    return data;
  }
}

class TextSMSToGuardianCourseList {
  String? value;
  String? text;
  int? order;

  TextSMSToGuardianCourseList({this.value, this.text, this.order});

  TextSMSToGuardianCourseList.fromJson(Map<String, dynamic> json) {
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

class TextSMSToGuardianDivisionList {
  String? value;
  String? text;

  TextSMSToGuardianDivisionList({this.value, this.text});

  TextSMSToGuardianDivisionList.fromJson(Map<String, dynamic> json) {
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

//View
class TextSMSToGuardianCourseDivision_notification_Stf {
  String? studentId;
  String? guardianId;

  String? admnNo;
  String? name;
  int? rollNo;
  String? mobNo;
  String? division;
  String? course;
  bool? selected;

  TextSMSToGuardianCourseDivision_notification_Stf(
      {this.studentId,
      this.guardianId,
      this.admnNo,
      this.name,
      this.rollNo,
      this.mobNo,
      this.division,
      this.course,
      this.selected});

  TextSMSToGuardianCourseDivision_notification_Stf.fromJson(
      Map<String, dynamic> json) {
    studentId = json['studentId'];
    guardianId = json['guardianId'];
    admnNo = json['admnNo'];
    name = json['name'];
    rollNo = json['rollNo'];
    mobNo = json['mobNo'];
    division = json['division'];
    course = json['course'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['studentId'] = studentId;
    data['guardianId'] = guardianId;
    data['admnNo'] = admnNo;
    data['name'] = name;
    data['rollNo'] = rollNo;
    data['mobNo'] = mobNo;
    data['division'] = division;
    data['course'] = course;
    return data;
  }
}

//SMS Format

class SmsSettingsByStaff {
  List<SmsFormatByStaff>? smsFormat;
  String? applySMSFormatApproval;

  SmsSettingsByStaff({this.smsFormat, this.applySMSFormatApproval});

  SmsSettingsByStaff.fromJson(Map<String, dynamic> json) {
    if (json['smsFormat'] != null) {
      smsFormat = [];
      json['smsFormat'].forEach((v) {
        smsFormat!.add(SmsFormatByStaff.fromJson(v));
      });
    }
    applySMSFormatApproval = json['applySMSFormatApproval'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (smsFormat != null) {
      data['smsFormat'] = smsFormat!.map((v) => v.toJson()).toList();
    }
    data['applySMSFormatApproval'] = applySMSFormatApproval;
    return data;
  }
}

class SmsFormatByStaff {
  String? text;
  String? value;
  bool? isApproved;

  SmsFormatByStaff({this.text, this.value, this.isApproved});

  SmsFormatByStaff.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    value = json['value'];
    isApproved = json['isApproved'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['text'] = text;
    data['value'] = value;
    data['isApproved'] = isApproved;
    return data;
  }
}

//sms formats complete view

class SmsFormatsCompleteview {
  String? id;
  String? name;
  String? smsBody;

  bool? isApproved;

  SmsFormatsCompleteview({this.id, this.name, this.smsBody, this.isApproved});

  SmsFormatsCompleteview.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    smsBody = json['smsBody'];
    isApproved = json['isApproved'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['smsBody'] = smsBody;
    data['isApproved'] = isApproved;
    return data;
  }
}
