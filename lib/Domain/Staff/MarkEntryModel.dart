import 'package:flutter/material.dart';

class MarkEntryViewModel {
  List<MarkEntryInitialValues>? courseList;
  bool? isLocked;
  String? code;

  MarkEntryViewModel({this.courseList, this.isLocked, this.code});

  MarkEntryViewModel.fromJson(Map<String, dynamic> json) {
    if (json['courseList'] != null) {
      courseList = <MarkEntryInitialValues>[];
      json['courseList'].forEach((v) {
        courseList!.add(MarkEntryInitialValues.fromJson(v));
      });
    }
    isLocked = json['isLocked'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (courseList != null) {
      data['courseList'] = courseList!.map((v) => v.toJson()).toList();
    }
    data['isLocked'] = isLocked;
    data['code'] = code;
    return data;
  }
}

class MarkEntryInitialValues {
  String? id;
  String? courseName;
  int? sortOrder;
  TextEditingController? contro;

  MarkEntryInitialValues(
      {this.id, this.courseName, this.sortOrder, this.contro});

  MarkEntryInitialValues.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseName = json['courseName'];
    sortOrder = json['sortOrder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['courseName'] = courseName;
    data['sortOrder'] = sortOrder;
    data['id'] = id;
    return data;
  }
}

class MarkEntryDivisionInitailModel {
  String? typeCode;
  List<MarkEntryDivisionList>? divisionList;

  MarkEntryDivisionInitailModel({this.typeCode, this.divisionList});

  MarkEntryDivisionInitailModel.fromJson(Map<String, dynamic> json) {
    typeCode = json['typeCode'];
    if (json['divisionList'] != null) {
      divisionList = <MarkEntryDivisionList>[];
      json['divisionList'].forEach((v) {
        divisionList!.add(new MarkEntryDivisionList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['typeCode'] = this.typeCode;
    if (this.divisionList != null) {
      data['divisionList'] = this.divisionList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MarkEntryDivisionList {
  String? value;
  String? text;
  int? order;

  MarkEntryDivisionList({this.value, this.text, this.order});

  MarkEntryDivisionList.fromJson(Map<String, dynamic> json) {
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

class MarkEntryPartList {
  String? value;
  String? text;
  String? selected;
  String? active;
  int? order;

  MarkEntryPartList(
      {this.value, this.text, this.selected, this.active, this.order});

  MarkEntryPartList.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    text = json['text'];
    selected = json['selected'];
    active = json['active'];
    order = json['order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['text'] = text;
    data['selected'] = selected;
    data['active'] = active;
    data['order'] = order;
    return data;
  }
}

class MarkEntrySubjectList {
  String? value;
  String? text;

  MarkEntrySubjectList({
    this.value,
    this.text,
  });

  MarkEntrySubjectList.fromJson(Map<String, dynamic> json) {
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

class MarkEntryOptionSubjectModel {
  String? id;
  String? subjectName;
  String? subjectDescription;

  MarkEntryOptionSubjectModel(
      {this.id, this.subjectName, this.subjectDescription});

  MarkEntryOptionSubjectModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subjectName = json['subjectName'];
    subjectDescription = json['subjectDescription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['subjectName'] = subjectName;
    data['subjectDescription'] = subjectDescription;
    return data;
  }
}

class MarkEntryExamList {
  String? value;
  String? text;

  MarkEntryExamList({this.value, this.text});

  MarkEntryExamList.fromJson(Map<String, dynamic> json) {
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

//Mark Entry View Model

class MarkEntryViewModelNew {
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
  String? exam;
  bool? includeTerminatedStudents;
  double? teMax;
  double? peMax;
  double? ceMax;
  String? teCaption;
  String? peCaption;
  String? ceCaption;
  bool? isBlocked;
  String? examStatus;
  String? updatedAt;
  List<MarkEntryDetails>? markEntryDetails;
  List<GradeListNew>? gradeList;
  PartItem? partItem;

  MarkEntryViewModelNew(
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
      this.exam,
      this.includeTerminatedStudents,
      this.teMax,
      this.peMax,
      this.ceMax,
      this.teCaption,
      this.peCaption,
      this.ceCaption,
      this.isBlocked,
      this.examStatus,
      this.updatedAt,
      this.markEntryDetails,
      this.gradeList,
      this.partItem});

  MarkEntryViewModelNew.fromJson(Map<String, dynamic> json) {
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
    exam = json['exam'];
    includeTerminatedStudents = json['includeTerminatedStudents'];
    teMax = json['teMax'];
    peMax = json['peMax'];
    ceMax = json['ceMax'];
    teCaption = json['teCaption'];
    peCaption = json['peCaption'];
    ceCaption = json['ceCaption'];
    isBlocked = json['isBlocked'];
    examStatus = json['examStatus'];
    updatedAt = json['updatedAt'];
    if (json['markEntryDetails'] != null) {
      markEntryDetails = <MarkEntryDetails>[];
      json['markEntryDetails'].forEach((v) {
        markEntryDetails!.add(new MarkEntryDetails.fromJson(v));
      });
    }
    if (json['gradeList'] != null) {
      gradeList = <GradeListNew>[];
      json['gradeList'].forEach((v) {
        gradeList!.add(new GradeListNew.fromJson(v));
      });
    }
    partItem = json['partItem'] != null
        ? new PartItem.fromJson(json['partItem'])
        : null;
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
    data['exam'] = exam;
    data['includeTerminatedStudents'] = includeTerminatedStudents;
    data['teMax'] = teMax;
    data['peMax'] = peMax;
    data['ceMax'] = ceMax;
    data['teCaption'] = teCaption;
    data['peCaption'] = peCaption;
    data['ceCaption'] = ceCaption;
    data['isBlocked'] = isBlocked;
    data['examStatus'] = examStatus;
    data['updatedAt'] = updatedAt;
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

class MarkEntryDetails {
  String? attendance;
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
  String? teGradeId;
  String? peGradeId;
  String? ceGradeId;
  String? tabMarkEntryId;
  bool? isEdited;
  bool? isDisabled;

  MarkEntryDetails(
      {this.attendance,
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
      this.teGradeId,
      this.peGradeId,
      this.ceGradeId,
      this.tabMarkEntryId,
      this.isEdited,
      this.isDisabled});

  MarkEntryDetails.fromJson(Map<String, dynamic> json) {
    attendance = json['attendance'];
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
    teGradeId = json['teGradeId'];
    peGradeId = json['peGradeId'];
    ceGradeId = json['ceGradeId'];
    tabMarkEntryId = json['tabMarkEntryId'];
    isEdited = json['isEdited'];
    isDisabled = json['isDisabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['attendance'] = attendance;
    data['studentName'] = studentName;
    data['rollNo'] = rollNo;
    data['studentId'] = studentId;
    data['markEntryDetId'] = markEntryDetId;
    data['teMark'] = teMark;
    data['peMark'] = peMark;
    data['ceMark'] = ceMark;
    data['teGrade'] = teGrade;
    data['peGrade'] = peGrade;
    data['ceGrade'] = ceGrade;
    data['teGradeId'] = teGradeId;
    data['peGradeId'] = peGradeId;
    data['ceGradeId'] = ceGradeId;
    data['tabMarkEntryId'] = tabMarkEntryId;
    data['isEdited'] = isEdited;
    data['isDisabled'] = isDisabled;
    return data;
  }
}

class PartItem {
  String? value;
  String? text;

  int? order;

  PartItem({this.value, this.text, this.order});

  PartItem.fromJson(Map<String, dynamic> json) {
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

class GradeListNew {
  String? value;
  String? text;
  int? order;

  GradeListNew({this.value, this.text, this.order});

  GradeListNew.fromJson(Map<String, dynamic> json) {
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
