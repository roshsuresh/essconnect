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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['courseName'] = this.courseName;
    data['sortOrder'] = this.sortOrder;
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
        parts!.add(new MarkReportPartList.fromJson(v));
      });
    }
    if (json['divisions'] != null) {
      divisions = [];
      json['divisions'].forEach((v) {
        divisions!.add(new MarkReportDivisions.fromJson(v));
      });
    }
    if (json['exam'] != null) {
      exam = [];
      json['exam'].forEach((v) {
        exam!.add(new MarkReportExamList.fromJson(v));
      });
    }
    tabulationTypeCode = json['tabulationTypeCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.parts != null) {
      data['parts'] = this.parts!.map((v) => v.toJson()).toList();
    }
    if (this.divisions != null) {
      data['divisions'] = this.divisions!.map((v) => v.toJson()).toList();
    }
    if (this.exam != null) {
      data['exam'] = this.exam!.map((v) => v.toJson()).toList();
    }
    data['tabulationTypeCode'] = this.tabulationTypeCode;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['text'] = this.text;

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['text'] = this.text;

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
    data['value'] = this.value;
    data['text'] = this.text;

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
    data['value'] = this.value;
    data['text'] = this.text;

    return data;
  }
}
///////////////////////////////////////////////////////////////////////////////////////////
////////////////                  view markReport                  ///////////////////////
/////////////////////////////////////////////////////////////////////////////////////////


class MarkEntryReport {
  List<MarkEntryReportView>? meList;
  List<HeadingList>? headingList;
  String? entryMethod;
  String? tabulationTypeCode;

  MarkEntryReport(
      {this.meList,
        this.headingList,
        this.entryMethod,
        this.tabulationTypeCode});

  MarkEntryReport.fromJson(Map<String, dynamic> json) {
    if (json['meList'] != null) {
      meList = <MarkEntryReportView>[];
      json['meList'].forEach((v) {
        meList!.add(new MarkEntryReportView.fromJson(v));
      });
    }
    if (json['headingList'] != null) {
      headingList = <HeadingList>[];
      json['headingList'].forEach((v) {
        headingList!.add(new HeadingList.fromJson(v));
      });
    }
    entryMethod = json['entryMethod'];
    tabulationTypeCode = json['tabulationTypeCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.meList != null) {
      data['meList'] = this.meList!.map((v) => v.toJson()).toList();
    }
    if (this.headingList != null) {
      data['headingList'] = this.headingList!.map((v) => v.toJson()).toList();
    }
    data['entryMethod'] = this.entryMethod;
    data['tabulationTypeCode'] = this.tabulationTypeCode;
    return data;
  }
}


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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['divisionId'] = this.divisionId;
    data['division'] = this.division;
    data['divisionWiseStudentsCount'] = this.divisionWiseStudentsCount;
    data['divisionOrder'] = this.divisionOrder;
    if (this.studentList != null) {
      data['studentList'] = this.studentList!.map((v) => v.toJson()).toList();
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
        subjectMarkDetails!.add(new SubjectMarkDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rollNo'] = this.rollNo;
    data['name'] = this.name;
    data['studentId'] = this.studentId;
    data['isChecked'] = this.isChecked;
    data['totalTEMark'] = this.totalTEMark;
    data['totalPEMark'] = this.totalPEMark;
    data['totalCEMark'] = this.totalCEMark;
    if (this.subjectMarkDetails != null) {
      data['subjectMarkDetails'] =
          this.subjectMarkDetails!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['entryMethod'] = this.entryMethod;
    data['attendance'] = this.attendance;
    data['subject'] = this.subject;
    data['teCaption'] = this.teCaption;
    data['peCaption'] = this.peCaption;
    data['ceCaption'] = this.ceCaption;
    data['peMark'] = this.peMark;
    data['teMark'] = this.teMark;
    data['ceMark'] = this.ceMark;
    data['peGrade'] = this.peGrade;
    data['teGrade'] = this.teGrade;
    data['ceGrade'] = this.ceGrade;
    data['teMaxMark'] = this.teMaxMark;
    data['peMaxMark'] = this.peMaxMark;
    data['ceMaxMark'] = this.ceMaxMark;
    data['totalMark'] = this.totalMark;
    data['totalTEMark'] = this.totalTEMark;
    data['totalPEMark'] = this.totalPEMark;
    data['totalCEMark'] = this.totalCEMark;

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
  int? count;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subject'] = this.subject;
    data['subjectId'] = this.subjectId;
    data['teCaption'] = this.teCaption;
    data['peCaption'] = this.peCaption;
    data['ceCaption'] = this.ceCaption;
    data['teMax'] = this.teMax;
    data['peMax'] = this.peMax;
    data['ceMax'] = this.ceMax;
    data['course'] = this.course;
    data['count'] = this.count;
    data['totalTeMaxMark'] = this.totalTeMaxMark;
    data['totalPeMaxMark'] = this.totalPeMaxMark;
    data['totalCeMaxMark'] = this.totalCeMaxMark;
    return data;
  }
}
//download

class MarkReportDownload {
  String? name;
  String? extension;
  String? path;
  String? url;
  bool? isTemporary;
  bool? isDeleted;
  String? images;
  String? createdAt;
  String? id;

  MarkReportDownload(
      {this.name,
        this.extension,
        this.path,
        this.url,
        this.isTemporary,
        this.isDeleted,
        this.images,
        this.createdAt,
        this.id});

  MarkReportDownload.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    extension = json['extension'];
    path = json['path'];
    url = json['url'];
    isTemporary = json['isTemporary'];
    isDeleted = json['isDeleted'];
    images = json['images'];
    createdAt = json['createdAt'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['extension'] = this.extension;
    data['path'] = this.path;
    data['url'] = this.url;
    data['isTemporary'] = this.isTemporary;
    data['isDeleted'] = this.isDeleted;
    data['images'] = this.images;
    data['createdAt'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}