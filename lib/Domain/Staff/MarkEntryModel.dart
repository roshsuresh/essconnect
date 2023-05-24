import 'package:flutter/cupertino.dart';

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.courseList != null) {
      data['courseList'] = this.courseList!.map((v) => v.toJson()).toList();
    }
    data['isLocked'] = this.isLocked;
    data['code'] = this.code;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    data['value'] = this.value;
    data['text'] = this.text;
    data['selected'] = this.selected;
    data['active'] = this.active;
    data['order'] = this.order;
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
    data['exam'] = this.exam;
    data['includeTerminatedStudents'] = this.includeTerminatedStudents;
    data['teMax'] = this.teMax;
    data['peMax'] = this.peMax;
    data['ceMax'] = this.ceMax;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attendance'] = this.attendance;
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
    data['teGradeId'] = this.teGradeId;
    data['peGradeId'] = this.peGradeId;
    data['ceGradeId'] = this.ceGradeId;
    data['tabMarkEntryId'] = this.tabMarkEntryId;
    data['isEdited'] = this.isEdited;
    data['isDisabled'] = this.isDisabled;
    return data;
  }
}

class PartItem {
  String? value;
  String? text;
  Null? selected;
  Null? active;
  int? order;

  PartItem({this.value, this.text, this.selected, this.active, this.order});

  PartItem.fromJson(Map<String, dynamic> json) {
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

class GradeListNew {
  String? value;
  String? text;
  Null? selected;
  Null? active;
  int? order;

  GradeListNew({this.value, this.text, this.selected, this.active, this.order});

  GradeListNew.fromJson(Map<String, dynamic> json) {
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
