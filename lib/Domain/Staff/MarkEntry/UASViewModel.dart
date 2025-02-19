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
  String? verifiedStaffName;
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
  String? verifiedFileId;

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
        this.partItem,
        this.verifiedFileId,
        this.verifiedStaffName,
      });

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
    verifiedStaffName = json['verifiedStaffName'];
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
        gradeList!.add(GradeListUAS.fromJson(v));
      });
    }
    partItem = json['partItem'] != null
        ? PartItemView.fromJson(json['partItem'])
        : null;
    verifiedFileId = json['verifiedFileId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['markEntryId'] = markEntryId;
    data['schoolId'] = schoolId;
    data['tabulationTypeCode'] = tabulationTypeCode;
    data['subjectCaption'] = subjectCaption;
    data['division'] = division;
    data['course'] = course;
    data['part'] = part;
    data['subject'] = subject;
    data['subSubject'] = subSubject;
    data['optionSubject'] = optionSubject;
    data['staffId'] = staffId;
    data['staffName'] = staffName;
    data['entryMethod'] = entryMethod;
    data['exam'] = exam;
    data['includeTerminatedStudents'] = includeTerminatedStudents;
    data['teMax'] = teMax;
    data['peMax'] = peMax;
    data['ceMax'] = ceMax;
    data['existPeAttendance']=existPeAttendance;
    data['existCeAttendance']=existCeAttendance;
    data['teCaption'] = teCaption;
    data['peCaption'] = peCaption;
    data['ceCaption'] = ceCaption;
    data['isBlocked'] = isBlocked;
    data['examStatus'] = examStatus;
    data['updatedAt'] = updatedAt;
    data['verifiedFileId'] = verifiedFileId;
    data['verifiedStaffName'] = verifiedStaffName;
    if (markEntryDetails != null) {
      data['markEntryDetails'] =
          markEntryDetails!.map((v) => v.toJson()).toList();
    }
    if (gradeList != null) {
      data['gradeList'] = gradeList!.map((v) => v.toJson()).toList();
    }
    if (partItem != null) {
      data['partItem'] = partItem!.toJson();
    }
    return data;
  }
}

class MarkEntryDetailsUAS {
  String? attendance;
  String? ceAttendance;
  String? peAttendance;
  String? studentName;
  String? admissionNo;
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
  bool? isPeDisabled;
  bool? isCeDisabled;
  bool? isAttendanceDisabled;

  MarkEntryDetailsUAS(
      {this.attendance,
        this.peAttendance,
        this.ceAttendance,
        this.studentName,
        this.admissionNo,
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
        this.isPeDisabled,
        this.isCeDisabled,
        this.isAttendanceDisabled});

  MarkEntryDetailsUAS.fromJson(Map<String, dynamic> json) {
    attendance = json['attendance'];
    peAttendance = json['peAttendance'];
    ceAttendance = json['ceAttendance'];
    studentName = json['studentName'];
    admissionNo = json['admissionNo'];
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
    isPeDisabled = json['isPeDisabled'];
    isCeDisabled = json['isCeDisabled'];
    isAttendanceDisabled = json['isAttendanceDisabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['attendance'] = attendance;
    data['peAttendance'] = peAttendance;
    data['ceAttendance'] = ceAttendance;
    data['studentName'] = studentName;
    data['admissionNo'] = admissionNo;
    data['rollNo'] = rollNo;
    data['studentId'] = studentId;
    data['markEntryDetId'] = markEntryDetId;
    data['teMark'] = teMark;
    data['peMark'] = peMark;
    data['ceMark'] = ceMark;
    data['teGrade'] = teGrade;
    data['peGrade'] = peGrade;
    data['ceGrade'] = ceGrade;
    data['total'] = total;
    data['teGradeId'] = teGradeId;
    data['peGradeId'] = peGradeId;
    data['ceGradeId'] = ceGradeId;
    data['tabMarkEntryId'] = tabMarkEntryId;
    data['isEdited'] = isEdited;
    data['isDisabled'] = isDisabled;
    data['isPeDisabled'] = isPeDisabled;
    data['isCeDisabled'] = isCeDisabled;
    data['isAttendanceDisabled'] = isAttendanceDisabled;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['text'] = text;
    data['order'] = order;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['text'] = text;
    data['order'] = order;
    return data;
  }
}
