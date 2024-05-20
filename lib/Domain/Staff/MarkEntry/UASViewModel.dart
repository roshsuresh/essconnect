class MarkEntryUASModel {
  String? markEntryId;
  String? schoolId;
  String? tabulationTypeCode;
  String? subjectCaption;
  String? division;
  String? course;
  String? part;
  String? subject;
  String? subSubject;
  String? optionSubject;
  String? staffId;
  String? staffName;
  String? entryMethod;
  String? exam;
  bool? includeTerminatedStudents;
  String? teMax;
  String? peMax;
  String? ceMax;
  bool? existPeAttendance;
  bool? existCeAttendance;
  String? teCaption;
  String? peCaption;
  String? ceCaption;
  bool? isBlocked;
  String? examStatus;
  String? updatedAt;
  List<MarkEntryDetailsUAS>? markEntryDetails;
  List<GradeListUAS>? gradeList;
  PartItemView? partItem;

  MarkEntryUASModel(
      {this.markEntryId,
      this.schoolId,
      this.tabulationTypeCode,
      this.subjectCaption,
      this.division,
      this.course,
      this.part,
      this.subject,
      this.subSubject,
      this.optionSubject,
      this.staffId,
      this.staffName,
      this.entryMethod,
      this.exam,
      this.includeTerminatedStudents,
      this.teMax,
      this.peMax,
      this.ceMax,
      this.existPeAttendance,
      this.existCeAttendance,
      this.teCaption,
      this.peCaption,
      this.ceCaption,
      this.isBlocked,
      this.examStatus,
      this.updatedAt,
      this.markEntryDetails,
      this.gradeList,
      this.partItem});

  MarkEntryUASModel.fromJson(Map<String, dynamic> json) {
    markEntryId = json['markEntryId'];
    schoolId = json['schoolId'];
    tabulationTypeCode = json['tabulationTypeCode'];
    subjectCaption = json['subjectCaption'];
    division = json['division'];
    course = json['course'];
    part = json['part'];
    subject = json['subject'];
    subSubject = json['subSubject'];
    optionSubject = json['optionSubject'];
    staffId = json['staffId'];
    staffName = json['staffName'];
    entryMethod = json['entryMethod'];
    exam = json['exam'];
    includeTerminatedStudents = json['includeTerminatedStudents'];
    teMax = json['teMax'];
    peMax = json['peMax'];
    ceMax = json['ceMax'];
    existPeAttendance= json['existPeAttendance'];
    existCeAttendance =json['existCeAttendance'];
    teCaption = json['teCaption'];
    peCaption = json['peCaption'];
    ceCaption = json['ceCaption'];
    isBlocked = json['isBlocked'];
    examStatus = json['examStatus'];
    updatedAt = json['updatedAt'];
    if (json['markEntryDetails'] != null) {
      markEntryDetails = <MarkEntryDetailsUAS>[];
      json['markEntryDetails'].forEach((v) {
        markEntryDetails!.add(MarkEntryDetailsUAS.fromJson(v));
      });
    }
    if (json['gradeList'] != null) {
      gradeList = <GradeListUAS>[];
      json['gradeList'].forEach((v) {
        gradeList!.add(new GradeListUAS.fromJson(v));
      });
    }
    partItem = json['partItem'] != null
        ? PartItemView.fromJson(json['partItem'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['markEntryId'] = this.markEntryId;
    data['schoolId'] = this.schoolId;
    data['tabulationTypeCode'] = this.tabulationTypeCode;
    data['subjectCaption'] = this.subjectCaption;
    data['division'] = this.division;
    data['course'] = this.course;
    data['part'] = this.part;
    data['subject'] = this.subject;
    data['subSubject'] = this.subSubject;
    data['optionSubject'] = this.optionSubject;
    data['staffId'] = this.staffId;
    data['staffName'] = this.staffName;
    data['entryMethod'] = this.entryMethod;
    data['exam'] = this.exam;
    data['includeTerminatedStudents'] = this.includeTerminatedStudents;
    data['teMax'] = this.teMax;
    data['peMax'] = this.peMax;
    data['ceMax'] = this.ceMax;
    data['existPeAttendance']=this.existPeAttendance;
    data['existCeAttendance']=this.existCeAttendance;
    data['teCaption'] = this.teCaption;
    data['peCaption'] = this.peCaption;
    data['ceCaption'] = this.ceCaption;
    data['isBlocked'] = this.isBlocked;
    data['examStatus'] = this.examStatus;
    data['updatedAt'] = this.updatedAt;
    if (this.markEntryDetails != null) {
      data['markEntryDetails'] =
          this.markEntryDetails!.map((v) => v.toJson()).toList();
    }
    if (this.gradeList != null) {
      data['gradeList'] = this.gradeList!.map((v) => v.toJson()).toList();
    }
    if (this.partItem != null) {
      data['partItem'] = this.partItem!.toJson();
    }
    return data;
  }
}

class MarkEntryDetailsUAS {
  String? attendance;
  String? ceAttendance;
  String? peAttendance;
  String? studentName;
  int? rollNo;
  String? studentId;
  String? markEntryDetId;
  double? teMark;
  double? peMark;
  double? ceMark;
  String? teGrade;
  String? peGrade;
  String? ceGrade;
  double? total;
  String? teGradeId;
  String? peGradeId;
  String? ceGradeId;
  String? tabMarkEntryId;
  bool? isEdited;
  bool? isDisabled;
  bool? isAttendanceDisabled;

  MarkEntryDetailsUAS(
      {this.attendance,
        this.peAttendance,
        this.ceAttendance,
      this.studentName,
      this.rollNo,
      this.studentId,
      this.markEntryDetId,
      this.teMark,
      this.peMark,
      this.ceMark,
      this.teGrade,
      this.peGrade,
      this.ceGrade,
      this.total,
      this.teGradeId,
      this.peGradeId,
      this.ceGradeId,
      this.tabMarkEntryId,
      this.isEdited,
      this.isDisabled,
      this.isAttendanceDisabled});

  MarkEntryDetailsUAS.fromJson(Map<String, dynamic> json) {
    attendance = json['attendance'];
    peAttendance = json['peAttendance'];
    ceAttendance = json['ceAttendance'];
    studentName = json['studentName'];
    rollNo = json['rollNo'];
    studentId = json['studentId'];
    markEntryDetId = json['markEntryDetId'];
    teMark = json['teMark'];
    peMark = json['peMark'];
    ceMark = json['ceMark'];
    teGrade = json['teGrade'];
    peGrade = json['peGrade'];
    ceGrade = json['ceGrade'];
    total = json['total'];
    teGradeId = json['teGradeId'];
    peGradeId = json['peGradeId'];
    ceGradeId = json['ceGradeId'];
    tabMarkEntryId = json['tabMarkEntryId'];
    isEdited = json['isEdited'];
    isDisabled = json['isDisabled'];
    isAttendanceDisabled = json['isAttendanceDisabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attendance'] = this.attendance;
    data['peAttendance'] = this.peAttendance;
    data['ceAttendance'] = this.ceAttendance;
    data['studentName'] = this.studentName;
    data['rollNo'] = this.rollNo;
    data['studentId'] = this.studentId;
    data['markEntryDetId'] = this.markEntryDetId;
    data['teMark'] = this.teMark;
    data['peMark'] = this.peMark;
    data['ceMark'] = this.ceMark;
    data['teGrade'] = this.teGrade;
    data['peGrade'] = this.peGrade;
    data['ceGrade'] = this.ceGrade;
    data['total'] = this.total;
    data['teGradeId'] = this.teGradeId;
    data['peGradeId'] = this.peGradeId;
    data['ceGradeId'] = this.ceGradeId;
    data['tabMarkEntryId'] = this.tabMarkEntryId;
    data['isEdited'] = this.isEdited;
    data['isDisabled'] = this.isDisabled;
    data['isAttendanceDisabled'] = this.isAttendanceDisabled;
    return data;
  }
}

class GradeListUAS {
  String? value;
  String? text;
  int? order;

  GradeListUAS({this.value, this.text, this.order});

  GradeListUAS.fromJson(Map<String, dynamic> json) {
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

class PartItemView {
  String? value;
  String? text;
  int? order;

  PartItemView({this.value, this.text, this.order});

  PartItemView.fromJson(Map<String, dynamic> json) {
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
