//course List

class MarkReportCourseList {
  String? id;
  String? courseName;
  int? sortOrder;

  MarkReportCourseList({this.id, this.courseName, this.sortOrder});

  MarkReportCourseList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseName = json['courseName'];
    sortOrder = json['sortOrder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['courseName'] = courseName;
    data['sortOrder'] = sortOrder;
    return data;
  }
}

class StaffMarkEntryReport {
  List<MarkReportPartList>? parts;
  List<MarkReportDivisions>? divisions;
  List<MarkReportExamList>? exam;
  String? tabulationTypeCode;

  StaffMarkEntryReport(
      {this.parts, this.divisions, this.exam, this.tabulationTypeCode});

  StaffMarkEntryReport.fromJson(Map<String, dynamic> json) {
    if (json['parts'] != null) {
      parts = [];
      json['parts'].forEach((v) {
        parts!.add(MarkReportPartList.fromJson(v));
      });
    }
    if (json['divisions'] != null) {
      divisions = [];
      json['divisions'].forEach((v) {
        divisions!.add(MarkReportDivisions.fromJson(v));
      });
    }
    if (json['exam'] != null) {
      exam = [];
      json['exam'].forEach((v) {
        exam!.add(MarkReportExamList.fromJson(v));
      });
    }
    tabulationTypeCode = json['tabulationTypeCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (parts != null) {
      data['parts'] = parts!.map((v) => v.toJson()).toList();
    }
    if (divisions != null) {
      data['divisions'] = divisions!.map((v) => v.toJson()).toList();
    }
    if (exam != null) {
      data['exam'] = exam!.map((v) => v.toJson()).toList();
    }
    data['tabulationTypeCode'] = tabulationTypeCode;
    return data;
  }
}

//part List

class MarkReportPartList {
  String? value;
  String? text;

  MarkReportPartList({
    this.value,
    this.text,
  });

  MarkReportPartList.fromJson(Map<String, dynamic> json) {
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

//Division list

class MarkReportDivisions {
  String? value;
  String? text;

  MarkReportDivisions({
    this.value,
    this.text,
  });

  MarkReportDivisions.fromJson(Map<String, dynamic> json) {
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

//Exam list

class MarkReportExamList {
  String? value;
  String? text;

  MarkReportExamList({
    this.value,
    this.text,
  });

  MarkReportExamList.fromJson(Map<String, dynamic> json) {
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

//subject List

class MarkReportSubjectList {
  String? value;
  String? text;

  MarkReportSubjectList({
    this.value,
    this.text,
  });

  MarkReportSubjectList.fromJson(Map<String, dynamic> json) {
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
///////////////////////////////////////////////////////////////////////////////////////////
////////////////                  view markReport                  ///////////////////////
/////////////////////////////////////////////////////////////////////////////////////////

class MarkEntryReportView {
  String? divisionId;
  String? division;
  int? divisionWiseStudentsCount;
  int? divisionOrder;
  List<MarkReportStudentList>? studentList;

  MarkEntryReportView(
      {this.divisionId,
      this.division,
      this.divisionWiseStudentsCount,
      this.divisionOrder,
      this.studentList});

  MarkEntryReportView.fromJson(Map<String, dynamic> json) {
    divisionId = json['divisionId'];
    division = json['division'];
    divisionWiseStudentsCount = json['divisionWiseStudentsCount'];
    divisionOrder = json['divisionOrder'];
    if (json['studentList'] != null) {
      studentList = <MarkReportStudentList>[];
      json['studentList'].forEach((v) {
        studentList!.add(MarkReportStudentList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['divisionId'] = divisionId;
    data['division'] = division;
    data['divisionWiseStudentsCount'] = divisionWiseStudentsCount;
    data['divisionOrder'] = divisionOrder;
    if (studentList != null) {
      data['studentList'] = studentList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MarkReportStudentList {
  int? rollNo;
  String? name;
  String? studentId;
  bool? isChecked;
  double? totalTEMark;
  double? totalPEMark;
  double? totalCEMark;
  List<SubjectMarkDetails>? subjectMarkDetails;

  MarkReportStudentList(
      {this.rollNo,
      this.name,
      this.studentId,
      this.isChecked,
      this.totalTEMark,
      this.totalPEMark,
      this.totalCEMark,
      this.subjectMarkDetails});

  MarkReportStudentList.fromJson(Map<String, dynamic> json) {
    rollNo = json['rollNo'];
    name = json['name'];
    studentId = json['studentId'];
    isChecked = json['isChecked'];
    totalTEMark = json['totalTEMark'];
    totalPEMark = json['totalPEMark'];
    totalCEMark = json['totalCEMark'];
    if (json['subjectMarkDetails'] != null) {
      subjectMarkDetails = <SubjectMarkDetails>[];
      json['subjectMarkDetails'].forEach((v) {
        subjectMarkDetails!.add(SubjectMarkDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rollNo'] = rollNo;
    data['name'] = name;
    data['studentId'] = studentId;
    data['isChecked'] = isChecked;
    data['totalTEMark'] = totalTEMark;
    data['totalPEMark'] = totalPEMark;
    data['totalCEMark'] = totalCEMark;
    if (subjectMarkDetails != null) {
      data['subjectMarkDetails'] =
          subjectMarkDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubjectMarkDetails {
  String? entryMethod;
  String? attendance;
  String? subject;
  String? teCaption;
  String? peCaption;
  String? ceCaption;
  double? peMark;
  double? teMark;
  double? ceMark;
  String? peGrade;
  String? teGrade;
  String? ceGrade;
  double? teMaxMark;
  double? peMaxMark;
  double? ceMaxMark;
  double? totalMark;
  double? totalTEMark;
  double? totalPEMark;
  double? totalCEMark;

  SubjectMarkDetails({
    this.entryMethod,
    this.attendance,
    this.subject,
    this.teCaption,
    this.peCaption,
    this.ceCaption,
    this.peMark,
    this.teMark,
    this.ceMark,
    this.peGrade,
    this.teGrade,
    this.ceGrade,
    this.teMaxMark,
    this.peMaxMark,
    this.ceMaxMark,
    this.totalMark,
    this.totalTEMark,
    this.totalPEMark,
    this.totalCEMark,
  });

  SubjectMarkDetails.fromJson(Map<String, dynamic> json) {
    entryMethod = json['entryMethod'];
    attendance = json['attendance'];
    subject = json['subject'];
    teCaption = json['teCaption'];
    peCaption = json['peCaption'];
    ceCaption = json['ceCaption'];
    peMark = json['peMark'];
    teMark = json['teMark'];
    ceMark = json['ceMark'];
    peGrade = json['peGrade'];
    teGrade = json['teGrade'];
    ceGrade = json['ceGrade'];
    teMaxMark = json['teMaxMark'];
    peMaxMark = json['peMaxMark'];
    ceMaxMark = json['ceMaxMark'];
    totalMark = json['totalMark'];
    totalTEMark = json['totalTEMark'];
    totalPEMark = json['totalPEMark'];
    totalCEMark = json['totalCEMark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['entryMethod'] = entryMethod;
    data['attendance'] = attendance;
    data['subject'] = subject;
    data['teCaption'] = teCaption;
    data['peCaption'] = peCaption;
    data['ceCaption'] = ceCaption;
    data['peMark'] = peMark;
    data['teMark'] = teMark;
    data['ceMark'] = ceMark;
    data['peGrade'] = peGrade;
    data['teGrade'] = teGrade;
    data['ceGrade'] = ceGrade;
    data['teMaxMark'] = teMaxMark;
    data['peMaxMark'] = peMaxMark;
    data['ceMaxMark'] = ceMaxMark;
    data['totalMark'] = totalMark;
    data['totalTEMark'] = totalTEMark;
    data['totalPEMark'] = totalPEMark;
    data['totalCEMark'] = totalCEMark;

    return data;
  }
}

class HeadingList {
  String? subject;
  String? subjectId;
  String? teCaption;
  String? peCaption;
  String? ceCaption;
  double? teMax;
  double? peMax;
  double? ceMax;
  double? course;
  double? count;
  double? totalTeMaxMark;
  double? totalPeMaxMark;
  double? totalCeMaxMark;

  HeadingList(
      {this.subject,
      this.subjectId,
      this.teCaption,
      this.peCaption,
      this.ceCaption,
      this.teMax,
      this.peMax,
      this.ceMax,
      this.course,
      this.count,
      this.totalTeMaxMark,
      this.totalPeMaxMark,
      this.totalCeMaxMark});

  HeadingList.fromJson(Map<String, dynamic> json) {
    subject = json['subject'];
    subjectId = json['subjectId'];
    teCaption = json['teCaption'];
    peCaption = json['peCaption'];
    ceCaption = json['ceCaption'];
    teMax = json['teMax'];
    peMax = json['peMax'];
    ceMax = json['ceMax'];
    course = json['course'];
    count = json['count'];
    totalTeMaxMark = json['totalTeMaxMark'];
    totalPeMaxMark = json['totalPeMaxMark'];
    totalCeMaxMark = json['totalCeMaxMark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subject'] = subject;
    data['subjectId'] = subjectId;
    data['teCaption'] = teCaption;
    data['peCaption'] = peCaption;
    data['ceCaption'] = ceCaption;
    data['teMax'] = teMax;
    data['peMax'] = peMax;
    data['ceMax'] = ceMax;
    data['course'] = course;
    data['count'] = count;
    data['totalTeMaxMark'] = totalTeMaxMark;
    data['totalPeMaxMark'] = totalPeMaxMark;
    data['totalCeMaxMark'] = totalCeMaxMark;
    return data;
  }
}
