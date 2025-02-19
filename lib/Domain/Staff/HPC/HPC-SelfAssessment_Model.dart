class ResponseLevels {
  String? value;
  String? text;
  bool? selected;
  bool? active;
  int? order;

  ResponseLevels({
    this.value,
    this.text,
    this.selected,
    this.active,
    this.order,
  });

  factory ResponseLevels.fromJson(Map<String, dynamic> json) {
    return ResponseLevels(
      value: json['value'] ?? '',
      text: json['text'] ?? '',
      selected: json['selected'] ?? false,
      active: json['active'] ?? false,
      order: json['order'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'value': value ?? '',
      'text': text ?? '',
      'selected': selected ?? false,
      'active': active ?? false,
      'order': order ?? 0,
    };
  }
}

class Statements {
  String? responseLevelId;
  String? statementId;
  String? statementName;
  int? statementOrder;
  List<ResponseLevels> responseLevels;

  Statements({
    this.responseLevelId,
    this.statementId,
    this.statementName,
    this.statementOrder,
    required this.responseLevels,
  });

  factory Statements.fromJson(Map<String, dynamic> json) {
    return Statements(
      responseLevelId: json['responseLevelId'] ?? '',
      statementId: json['statementId'] ?? '',
      statementName: json['statementName'] ?? '',
      statementOrder: json['statementOrder'] ?? 0,
      responseLevels: (json['responseLevels'] as List)
          .map((i) => ResponseLevels.fromJson(i))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'responseLevelId': responseLevelId ?? '',
      'statementId': statementId ?? '',
      'statementName': statementName ?? '',
      'statementOrder': statementOrder ?? 0,
      'responseLevels': responseLevels.map((e) => e.toJson()).toList(),
    };
  }
}

class StudentEntriesSelfAssessment {
  String? studentName;
  String? admissionNo;
  String? entryStaffName;
  String? entryDate;
  int? rollNo;
  String? studentId;
  String? peerStudentId;
  String? assessmentEntryId;
  bool? isEdited;
  bool? isDisabled;
  String? entryStatus;
  bool? isAttendanceDisabled;
  List<Statements> studentStatements;


  StudentEntriesSelfAssessment({
    this.studentName,
    this.admissionNo,
    this.entryStaffName,
    this.entryDate,
    this.rollNo,
    this.studentId,
    this.peerStudentId,
    this.assessmentEntryId,
    this.isEdited,
    this.isDisabled,
    this.entryStatus,
    this.isAttendanceDisabled,
    required this.studentStatements,
  });

  factory StudentEntriesSelfAssessment.fromJson(Map<String, dynamic> json) {
    return StudentEntriesSelfAssessment(
      studentName: json['studentName'] ?? '',
      admissionNo: json['admissionNo'] ?? '',
      entryStaffName: json['entryStaffName'],
      entryDate: json['entryDate'],
      rollNo: json['rollNo'],
      studentId: json['studentId'] ?? '',
      peerStudentId: json['peerStudentId'],
      assessmentEntryId: json['assessmentEntryId'],
      isEdited: json['isEdited'] ?? false,
      isDisabled: json['isDisabled'] ?? false,
      entryStatus: json['entryStatus'] ?? '',
      isAttendanceDisabled: json['isAttendanceDisabled'] ?? false,
      studentStatements: (json['studentStatements'] as List)
          .map((i) => Statements.fromJson(i))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'studentName': studentName ?? '',
      'admissionNo': admissionNo ?? '',
      'entryStaffName': entryStaffName,
      'entryDate': entryDate,
      'rollNo': rollNo,
      'studentId': studentId ?? '',
      'peerStudentId': peerStudentId,
      'assessmentEntryId': assessmentEntryId,
      'isEdited': isEdited ?? false,
      'isDisabled': isDisabled ?? false,
      'entryStatus': entryStatus ?? '',
      'isAttendanceDisabled': isAttendanceDisabled ?? false,
      'studentStatements': studentStatements.map((e) => e.toJson()).toList(),
    };
  }
}



class AssessmentEntries {
  List<StudentEntriesSelfAssessment>? studentEntries;
  String? assessmentTypeId;
  String? assessmentTypeName;
  String? course;
  String? stage;
  String? part;
  String? courseDomain;
  String? domain;
  String? activity;
  String? term;
  String? division;
  String? assessmentEntryId;
  String? entryDate;
  String? search;
  String? entryStatus;
  String? updatedStaff;
  String? verifyStaff;
  String? includeTerminatedStudents;

  AssessmentEntries(
      {this.studentEntries,
        this.assessmentTypeId,
        this.assessmentTypeName,
        this.course,
        this.stage,
        this.part,
        this.courseDomain,
        this.domain,
        this.activity,
        this.term,
        this.division,
        this.assessmentEntryId,
        this.entryDate,
        this.search,
        this.entryStatus,
        this.updatedStaff,
        this.verifyStaff,
        this.includeTerminatedStudents});

  AssessmentEntries.fromJson(Map<String, dynamic> json) {
    if (json['studentEntries'] != null) {
      studentEntries = <StudentEntriesSelfAssessment>[];
      json['studentEntries'].forEach((v) {
        studentEntries!.add(new StudentEntriesSelfAssessment.fromJson(v));
      });
    }
    assessmentTypeId = json['assessmentTypeId'];
    assessmentTypeName = json['assessmentTypeName'];
    course = json['course'];
    stage = json['stage'];
    part = json['part'];
    courseDomain = json['courseDomain'];
    domain = json['domain'];
    activity = json['activity'];
    term = json['term'];
    division = json['division'];
    assessmentEntryId = json['assessmentEntryId'];
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
    data['assessmentTypeId'] = this.assessmentTypeId;
    data['assessmentTypeName'] = this.assessmentTypeName;
    data['course'] = this.course;
    data['stage'] = this.stage;
    data['part'] = this.part;
    data['courseDomain'] = this.courseDomain;
    data['domain'] = this.domain;
    data['activity'] = this.activity;
    data['term'] = this.term;
    data['division'] = this.division;
    data['assessmentEntryId'] = this.assessmentEntryId;
    data['entryDate'] = this.entryDate;
    data['search'] = this.search;
    data['entryStatus'] = this.entryStatus;
    data['updatedStaff'] = this.updatedStaff;
    data['verifyStaff'] = this.verifyStaff;
    data['includeTerminatedStudents'] = this.includeTerminatedStudents;
    return data;
  }
}
