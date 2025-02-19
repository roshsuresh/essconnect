class PeerModel {
  List<Statements>? statements;
  AssessmentEntry? assessmentEntry;

  PeerModel({this.statements, this.assessmentEntry});

  PeerModel.fromJson(Map<String, dynamic> json) {
    if (json['statements'] != null) {
      statements = <Statements>[];
      json['statements'].forEach((v) {
        statements!.add(new Statements.fromJson(v));
      });
    }
    assessmentEntry = json['assessmentEntry'] != null
        ? new AssessmentEntry.fromJson(json['assessmentEntry'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.statements != null) {
      data['statements'] = this.statements!.map((v) => v.toJson()).toList();
    }
    if (this.assessmentEntry != null) {
      data['assessmentEntry'] = this.assessmentEntry!.toJson();
    }
    return data;
  }
}

class Statements {
  String? responseLevelId;
  String? statementId;
  String? statementName;
  int? statementOrder;
  List<ResponseLevels>? responseLevels;

  Statements(
      {this.responseLevelId,
        this.statementId,
        this.statementName,
        this.statementOrder,
        this.responseLevels});

  Statements.fromJson(Map<String, dynamic> json) {
    responseLevelId = json['responseLevelId'];
    statementId = json['statementId'];
    statementName = json['statementName'];
    statementOrder = json['statementOrder'];
    if (json['responseLevels'] != null) {
      responseLevels = <ResponseLevels>[];
      json['responseLevels'].forEach((v) {
        responseLevels!.add(new ResponseLevels.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['responseLevelId'] = this.responseLevelId;
    data['statementId'] = this.statementId;
    data['statementName'] = this.statementName;
    data['statementOrder'] = this.statementOrder;
    if (this.responseLevels != null) {
      data['responseLevels'] =
          this.responseLevels!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ResponseLevels {
  String? value;
  String? text;
  Null? selected;
  Null? active;
  int? order;

  ResponseLevels(
      {this.value, this.text, this.selected, this.active, this.order});

  ResponseLevels.fromJson(Map<String, dynamic> json) {
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

class AssessmentEntry {
  List<StudentEntriesPeerAssessment>? studentEntries;
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
  bool? includeTerminatedStudents;

  AssessmentEntry(
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

  AssessmentEntry.fromJson(Map<String, dynamic> json) {
    if (json['studentEntries'] != null) {
      studentEntries = <StudentEntriesPeerAssessment>[];
      json['studentEntries'].forEach((v) {
        studentEntries!.add(new StudentEntriesPeerAssessment.fromJson(v));
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

class StudentEntriesPeerAssessment {
  List<Statements>? studentStatements;
  List<PeerStudents>? peerStudents;
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

  StudentEntriesPeerAssessment(
      {this.studentStatements,
        this.peerStudents,
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
        this.isAttendanceDisabled});

  StudentEntriesPeerAssessment.fromJson(Map<String, dynamic> json) {
    if (json['studentStatements'] != null) {
      studentStatements = <Statements>[];
      json['studentStatements'].forEach((v) {
        studentStatements!.add(new Statements.fromJson(v));
      });
    }
    if (json['peerStudents'] != null) {
      peerStudents = <PeerStudents>[];
      json['peerStudents'].forEach((v) {
        peerStudents!.add(new PeerStudents.fromJson(v));
      });
    }
    studentName = json['studentName'];
    admissionNo = json['admissionNo'];
    entryStaffName = json['entryStaffName'];
    entryDate = json['entryDate'];
    rollNo = json['rollNo'];
    studentId = json['studentId'];
    peerStudentId = json['peerStudentId'];
    assessmentEntryId = json['assessmentEntryId'];
    isEdited = json['isEdited'];
    isDisabled = json['isDisabled'];
    entryStatus = json['entryStatus'];
    isAttendanceDisabled = json['isAttendanceDisabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.studentStatements != null) {
      data['studentStatements'] =
          this.studentStatements!.map((v) => v.toJson()).toList();
    }
    if (this.peerStudents != null) {
      data['peerStudents'] = this.peerStudents!.map((v) => v.toJson()).toList();
    }
    data['studentName'] = this.studentName;
    data['admissionNo'] = this.admissionNo;
    data['entryStaffName'] = this.entryStaffName;
    data['entryDate'] = this.entryDate;
    data['rollNo'] = this.rollNo;
    data['studentId'] = this.studentId;
    data['peerStudentId'] = this.peerStudentId;
    data['assessmentEntryId'] = this.assessmentEntryId;
    data['isEdited'] = this.isEdited;
    data['isDisabled'] = this.isDisabled;
    data['entryStatus'] = this.entryStatus;
    data['isAttendanceDisabled'] = this.isAttendanceDisabled;
    return data;
  }
}

class PeerStudents {
  String? studentId;
  String? studentName;

  PeerStudents({this.studentId, this.studentName});

  PeerStudents.fromJson(Map<String, dynamic> json) {
    studentId = json['studentId'];
    studentName = json['studentName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['studentId'] = this.studentId;
    data['studentName'] = this.studentName;
    return data;
  }
}