class Stages {
  String? value;
  String? text;
  String? selected;
  String? active;
  int? order;

  Stages({this.value, this.text, this.selected, this.active, this.order});

  Stages.fromJson(Map<String, dynamic> json) {
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


class Assessment {
  String? assessmentTypeId;
  String? assessmentTypeName;

  Assessment({this.assessmentTypeId, this.assessmentTypeName});

  Assessment.fromJson(Map<String, dynamic> json) {
    assessmentTypeId = json['assessmentTypeId'];
    assessmentTypeName = json['assessmentTypeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['assessmentTypeId'] = this.assessmentTypeId;
    data['assessmentTypeName'] = this.assessmentTypeName;
    return data;
  }
}

class Domains {
  String? value;
  String? courseDomainId;
  String? text;
  int? order;

  Domains({this.value, this.courseDomainId, this.text, this.order});

  Domains.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    courseDomainId = json['courseDomainId'];
    text = json['text'];
    order = json['order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['courseDomainId'] = this.courseDomainId;
    data['text'] = this.text;
    data['order'] = this.order;
    return data;
  }
}

class Activity {
  String? value;
  String? courseDomainId;
  String? text;

  Activity({this.value, this.courseDomainId, this.text});

  Activity.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    courseDomainId = json['course_domain_id'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['course_domain_id'] = this.courseDomainId;
    data['text'] = this.text;
    return data;
  }
}

class Ablities {
  String? ablityId;
  String? ablityName;
  int? ablityOrder;
  String? responseLevelId;

  Ablities(
      {this.ablityId, this.ablityName, this.ablityOrder, this.responseLevelId});

  Ablities.fromJson(Map<String, dynamic> json) {
    ablityId = json['ablityId'];
    ablityName = json['ablityName'];
    ablityOrder = json['ablityOrder'];
    responseLevelId = json['responseLevelId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ablityId'] = this.ablityId;
    data['ablityName'] = this.ablityName;
    data['ablityOrder'] = this.ablityOrder;
    data['responseLevelId'] = this.responseLevelId;
    return data;
  }
}

class Responses {
  String? value;
  String? text;
  String? selected;
  String? active;
  int? order;

  Responses({this.value, this.text, this.selected, this.active, this.order});

  Responses.fromJson(Map<String, dynamic> json) {
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

class FeedBackEntry {
  List<StudentEntries>? studentEntries;
  String? course;
  String? stage;
  String? courseDomain;
  String? domain;
  String? activity;
  String? term;
  String? division;
  String? teacherFeedBackEntryId;
  String? entryDate;
  String? search;
  String? entryStatus;
  String? updatedStaff;
  String? verifyStaff;
  bool? includeTerminatedStudents;

  FeedBackEntry(
      {this.studentEntries,
        this.course,
        this.stage,
        this.courseDomain,
        this.domain,
        this.activity,
        this.term,
        this.division,
        this.teacherFeedBackEntryId,
        this.entryDate,
        this.search,
        this.entryStatus,
        this.updatedStaff,
        this.verifyStaff,
        this.includeTerminatedStudents});

  FeedBackEntry.fromJson(Map<String, dynamic> json) {
    if (json['studentEntries'] != null) {
      studentEntries = <StudentEntries>[];
      json['studentEntries'].forEach((v) {
        studentEntries!.add(new StudentEntries.fromJson(v));
      });
    }
    course = json['course'];
    stage = json['stage'];
    courseDomain = json['courseDomain'];
    domain = json['domain'];
    activity = json['activity'];
    term = json['term'];
    division = json['division'];
    teacherFeedBackEntryId = json['teacherFeedBackEntryId'];
    entryDate = json['entryDate'];
    search = json['search'];
    entryStatus = json['entryStatus'];
    updatedStaff = json['updatedStaff'];
    verifyStaff = json['verifyStaff'];
    includeTerminatedStudents = json['includeTerminatedStudents'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.studentEntries != null) {
      data['studentEntries'] =
          this.studentEntries!.map((v) => v.toJson()).toList();
    }
    data['course'] = this.course;
    data['stage'] = this.stage;
    data['courseDomain'] = this.courseDomain;
    data['domain'] = this.domain;
    data['activity'] = this.activity;
    data['term'] = this.term;
    data['division'] = this.division;
    data['teacherFeedBackEntryId'] = this.teacherFeedBackEntryId;
    data['entryDate'] = this.entryDate;
    data['search'] = this.search;
    data['entryStatus'] = this.entryStatus;
    data['updatedStaff'] = this.updatedStaff;
    data['verifyStaff'] = this.verifyStaff;
    data['includeTerminatedStudents'] = this.includeTerminatedStudents;
    return data;
  }
}

class StudentEntries {
  List<Ablities>? studentAblity;
  String? teacherObservation;
  String? attendance;
  String? studentName;
  String? admissionNo;
  int? rollNo;
  String? studentId;
  String? teacherFeedbackEntryStudentId;
  bool? isEdited;
  bool? isDisabled;
  bool? isAttendanceDisabled;

  StudentEntries(
      {this.studentAblity,
        this.teacherObservation,
        this.attendance,
        this.studentName,
        this.admissionNo,
        this.rollNo,
        this.studentId,
        this.teacherFeedbackEntryStudentId,
        this.isEdited,
        this.isDisabled,
        this.isAttendanceDisabled});

  StudentEntries.fromJson(Map<String, dynamic> json) {
    if (json['studentAblity'] != null) {
      studentAblity = <Ablities>[];
      json['studentAblity'].forEach((v) {
        studentAblity!.add(new Ablities.fromJson(v));
      });
    }
    teacherObservation = json['teacherObservation'];
    attendance = json['attendance'];
    studentName = json['studentName'];
    admissionNo = json['admissionNo'];
    rollNo = json['rollNo'];
    studentId = json['studentId'];
    teacherFeedbackEntryStudentId = json['teacherFeedbackEntryStudentId'];
    isEdited = json['isEdited'];
    isDisabled = json['isDisabled'];
    isAttendanceDisabled = json['isAttendanceDisabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.studentAblity != null) {
      data['studentAblity'] =
          this.studentAblity!.map((v) => v.toJson()).toList();
    }
    data['teacherObservation'] = this.teacherObservation;
    data['attendance'] = this.attendance;
    data['studentName'] = this.studentName;
    data['admissionNo'] = this.admissionNo;
    data['rollNo'] = this.rollNo;
    data['studentId'] = this.studentId;
    data['teacherFeedbackEntryStudentId'] = this.teacherFeedbackEntryStudentId;
    data['isEdited'] = this.isEdited;
    data['isDisabled'] = this.isDisabled;
    data['isAttendanceDisabled'] = this.isAttendanceDisabled;
    return data;
  }
}


