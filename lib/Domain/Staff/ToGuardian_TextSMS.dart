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
//Communication Initial


class CommunicationInitial {
  bool? isTeacher;
  List<SectionsforCommunication>? sections;
  bool? isClassTeacher;
  bool? showCommunication;
  bool? showNotification;
  bool? showEmail;
  bool? showTextSMS;
  bool? showVoiceSMS;

  CommunicationInitial(
      {this.isTeacher,
        this.sections,

        this.isClassTeacher,
        this.showCommunication,
        this.showNotification,
        this.showEmail,
        this.showTextSMS,
        this.showVoiceSMS});

  CommunicationInitial.fromJson(Map<String, dynamic> json) {
    isTeacher = json['isTeacher'];
    if (json['sections'] != null) {
      sections = <SectionsforCommunication>[];
      json['sections'].forEach((v) {
        sections!.add(new SectionsforCommunication.fromJson(v));
      });
    }


    isClassTeacher = json['isClassTeacher'];
    showCommunication = json['showCommunication'];
    showNotification = json['showNotification'];
    showEmail = json['showEmail'];
    showTextSMS = json['showTextSMS'];
    showVoiceSMS = json['showVoiceSMS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isTeacher'] = this.isTeacher;
    if (this.sections != null) {
      data['sections'] = this.sections!.map((v) => v.toJson()).toList();
    }

    data['isClassTeacher'] = this.isClassTeacher;
    data['showCommunication'] = this.showCommunication;
    data['showNotification'] = this.showNotification;
    data['showEmail'] = this.showEmail;
    data['showTextSMS'] = this.showTextSMS;
    data['showVoiceSMS'] = this.showVoiceSMS;
    return data;
  }
}

class SectionsforCommunication {
  String? value;
  String? text;
  bool? selected;
  bool? active;
  String? order;

  SectionsforCommunication({this.value, this.text, this.selected, this.active, this.order});

  SectionsforCommunication.fromJson(Map<String, dynamic> json) {
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

class CourseInCommnunication {
  String? value;
  String? text;
  bool? selected;
  bool? active;
  String? order;

  CourseInCommnunication(
      {this.value, this.text, this.selected, this.active, this.order});

  CourseInCommnunication.fromJson(Map<String, dynamic> json) {
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

//division
class DivisionInCommnunication {
  String? value;
  String? text;
  bool? selected;
  bool? active;
  String? order;

  DivisionInCommnunication(
      {this.value, this.text, this.selected, this.active, this.order});

  DivisionInCommnunication.fromJson(Map<String, dynamic> json) {
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

//StudentData

class StudentView {
  String? id;
  String studentId;
  String? admNo;
  String name;
  String? course;
  String? division;
  String? rollNo;
  String? guardianName;
  String? guardianMobile;
  String? guardianEmail;
  String? fatherName;
  String? fatherMobile;
  String? fatherEmail;
  String? motherName;
  String? motherMobile;
  String? motherEmail;
  String? content;
  String? todaysDate;
  String? presentTime;
  String? classTeacher;
  bool? selected;

  StudentView(
      {this.id,
        required this.studentId,
        this.admNo,
        required this.name,
        this.course,
        this.division,
        this.rollNo,
        this.guardianName,
        this.guardianMobile,
        this.guardianEmail,
        this.fatherName,
        this.fatherMobile,
        this.fatherEmail,
        this.motherName,
        this.motherMobile,
        this.motherEmail,
        this.content,
        this.todaysDate,
        this.presentTime,
        this.classTeacher,
        this.selected
      });

  factory StudentView.fromJson(
      Map<String, dynamic> json) =>
      StudentView(

    studentId : json['studentId'],
    admNo : json['admNo'],
    name : json['name'],
    course : json['course'],
    division : json['division'],
    rollNo : json['rollNo'],
    guardianName : json['guardianName'],
    guardianMobile : json['guardianMobile'],
    guardianEmail : json['guardianEmail'],
    fatherName : json['fatherName'],
    fatherMobile : json['fatherMobile'],
    fatherEmail : json['fatherEmail'],
    motherName : json['motherName'],
    motherMobile : json['motherMobile'],
    motherEmail : json['motherEmail'],
    content : json['content'],
    todaysDate : json['todaysDate'],
    presentTime : json['presentTime'],
    classTeacher : json['classTeacher'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['studentId'] = this.studentId;
    data['admNo'] = this.admNo;
    data['name'] = this.name;
    data['course'] = this.course;
    data['division'] = this.division;
    data['rollNo'] = this.rollNo;
    data['guardianName'] = this.guardianName;
    data['guardianMobile'] = this.guardianMobile;
    data['guardianEmail'] = this.guardianEmail;
    data['fatherName'] = this.fatherName;
    data['fatherMobile'] = this.fatherMobile;
    data['fatherEmail'] = this.fatherEmail;
    data['motherName'] = this.motherName;
    data['motherMobile'] = this.motherMobile;
    data['motherEmail'] = this.motherEmail;
    data['content'] = this.content;
    data['todaysDate'] = this.todaysDate;
    data['presentTime'] = this.presentTime;
    data['classTeacher'] = this.classTeacher;
    return data;
  }
}


