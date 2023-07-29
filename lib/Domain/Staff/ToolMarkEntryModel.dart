class ToolMarkModel {
  List<ToolCourseList>? courseList;
  bool? isLocked;

  ToolMarkModel({this.courseList, this.isLocked});

  ToolMarkModel.fromJson(Map<String, dynamic> json) {
    if (json['courseList'] != null) {
      courseList = <ToolCourseList>[];
      json['courseList'].forEach((v) {
        courseList!.add(ToolCourseList.fromJson(v));
      });
    }
    isLocked = json['isLocked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.courseList != null) {
      data['courseList'] = this.courseList!.map((v) => v.toJson()).toList();
    }
    data['isLocked'] = this.isLocked;
    return data;
  }
}

class ToolCourseList {
  String? id;
  String? courseName;
  int? sortOrder;

  ToolCourseList({this.id, this.courseName, this.sortOrder});

  ToolCourseList.fromJson(Map<String, dynamic> json) {
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

//Division'

class ToolDivisionList {
  String? value;
  String? text;
  int? order;

  ToolDivisionList({this.value, this.text, this.order});

  ToolDivisionList.fromJson(Map<String, dynamic> json) {
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

class ToolParts {
  String? value;
  String? text;
  int? order;

  ToolParts({this.value, this.text, this.order});

  ToolParts.fromJson(Map<String, dynamic> json) {
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

class ToolSubjectList {
  String? value;
  String? text;

  ToolSubjectList({
    this.value,
    this.text,
  });

  ToolSubjectList.fromJson(Map<String, dynamic> json) {
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

class OptionalSubjectList {
  String? id;
  String? subjectName;
  String? subjectDescription;

  OptionalSubjectList({this.id, this.subjectName, this.subjectDescription});

  OptionalSubjectList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subjectName = json['subjectName'];
    subjectDescription = json['subjectDescription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['subjectName'] = this.subjectName;
    data['subjectDescription'] = this.subjectDescription;
    return data;
  }
}

class ToolExamslist {
  String? value;
  String? text;

  ToolExamslist({
    this.value,
    this.text,
  });

  ToolExamslist.fromJson(Map<String, dynamic> json) {
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

//////////////View

class ToolViewModel {
  List<StudentMEList>? studentMEList;
  List<GradeList>? gradeList;
  int? totalToolMaxmark;
  List<ToolList>? toolList;
  ToolBasicData? toolBasicData;

  ToolViewModel(
      {this.studentMEList,
      this.gradeList,
      this.totalToolMaxmark,
      this.toolList,
      this.toolBasicData});

  ToolViewModel.fromJson(Map<String, dynamic> json) {
    if (json['studentMEList'] != null) {
      studentMEList = <StudentMEList>[];
      json['studentMEList'].forEach((v) {
        studentMEList!.add(new StudentMEList.fromJson(v));
      });
    }
    if (json['gradeList'] != null) {
      gradeList = <GradeList>[];
      json['gradeList'].forEach((v) {
        gradeList!.add(new GradeList.fromJson(v));
      });
    }
    totalToolMaxmark = json['totalToolMaxmark'];
    if (json['toolList'] != null) {
      toolList = <ToolList>[];
      json['toolList'].forEach((v) {
        toolList!.add(new ToolList.fromJson(v));
      });
    }
    toolBasicData = json['toolBasicData'] != null
        ? new ToolBasicData.fromJson(json['toolBasicData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.studentMEList != null) {
      data['studentMEList'] =
          this.studentMEList!.map((v) => v.toJson()).toList();
    }
    if (this.gradeList != null) {
      data['gradeList'] = this.gradeList!.map((v) => v.toJson()).toList();
    }
    data['totalToolMaxmark'] = this.totalToolMaxmark;
    if (this.toolList != null) {
      data['toolList'] = this.toolList!.map((v) => v.toJson()).toList();
    }
    if (this.toolBasicData != null) {
      data['toolBasicData'] = this.toolBasicData!.toJson();
    }
    return data;
  }
}

class StudentMEList {
  String? name;
  int? rollNo;
  String? studentPresentDetailsId;
  String? attendance;
  String? description;
  bool? disableAbsentRow;
  List<ToolList>? toolList;
  double? totalMark;
  double? totalPer;
  String? totalGrade;

  StudentMEList(
      {this.name,
      this.rollNo,
      this.studentPresentDetailsId,
      this.attendance,
      this.description,
      this.disableAbsentRow,
      this.toolList,
      this.totalMark,
      this.totalPer,
      this.totalGrade});

  StudentMEList.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    rollNo = json['rollNo'];
    studentPresentDetailsId = json['studentPresentDetailsId'];
    attendance = json['attendance'];
    description = json['description'];
    disableAbsentRow = json['disableAbsentRow'];
    if (json['toolList'] != null) {
      toolList = <ToolList>[];
      json['toolList'].forEach((v) {
        toolList!.add(new ToolList.fromJson(v));
      });
    }
    totalMark = json['totalMark'];
    totalPer = json['totalPer'];
    totalGrade = json['totalGrade'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['rollNo'] = this.rollNo;
    data['studentPresentDetailsId'] = this.studentPresentDetailsId;
    data['attendance'] = this.attendance;
    data['description'] = this.description;
    data['disableAbsentRow'] = this.disableAbsentRow;
    if (this.toolList != null) {
      data['toolList'] = this.toolList!.map((v) => v.toJson()).toList();
    }
    data['totalMark'] = this.totalMark;
    data['totalPer'] = this.totalPer;
    data['totalGrade'] = this.totalGrade;
    return data;
  }
}

class ToolList {
  String? markEntryId;
  String? presentDetId;
  String? attendance;
  String? toolId;
  double? teMark;
  double? peMark;
  double? ceMark;
  String? teGrade;
  String? peGrade;
  String? ceGrade;
  String? teGradeId;
  String? peGradeId;
  String? ceGradeId;
  double? teMaxMark;

  ToolList(
      {this.markEntryId,
      this.presentDetId,
      this.attendance,
      this.toolId,
      this.teMark,
      this.peMark,
      this.ceMark,
      this.teGrade,
      this.peGrade,
      this.ceGrade,
      this.teGradeId,
      this.peGradeId,
      this.ceGradeId,
      this.teMaxMark});

  ToolList.fromJson(Map<String, dynamic> json) {
    markEntryId = json['markEntryId'];
    presentDetId = json['presentDetId'];
    attendance = json['attendance'];
    toolId = json['toolId'];
    teMark = json['teMark'];
    peMark = json['peMark'];
    ceMark = json['ceMark'];
    teGrade = json['teGrade'];
    peGrade = json['peGrade'];
    ceGrade = json['ceGrade'];
    teGradeId = json['teGradeId'];
    peGradeId = json['peGradeId'];
    ceGradeId = json['ceGradeId'];
    teMaxMark = json['teMaxMark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['markEntryId'] = this.markEntryId;
    data['presentDetId'] = this.presentDetId;
    data['attendance'] = this.attendance;
    data['toolId'] = this.toolId;
    data['teMark'] = this.teMark;
    data['peMark'] = this.peMark;
    data['ceMark'] = this.ceMark;
    data['teGrade'] = this.teGrade;
    data['peGrade'] = this.peGrade;
    data['ceGrade'] = this.ceGrade;
    data['teGradeId'] = this.teGradeId;
    data['peGradeId'] = this.peGradeId;
    data['ceGradeId'] = this.ceGradeId;
    data['teMaxMark'] = this.teMaxMark;
    return data;
  }
}

class GradeList {
  String? gradeName;
  int? gradeOrder;
  String? gradeId;

  GradeList({this.gradeName, this.gradeOrder, this.gradeId});

  GradeList.fromJson(Map<String, dynamic> json) {
    gradeName = json['gradeName'];
    gradeOrder = json['gradeOrder'];
    gradeId = json['gradeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gradeName'] = this.gradeName;
    data['gradeOrder'] = this.gradeOrder;
    data['gradeId'] = this.gradeId;
    return data;
  }
}

class ToolListViewModel {
  String? markEntryId;
  String? presentDetId;
  String? toolId;
  String? toolName;
  String? teCaption;
  String? peCaption;
  String? ceCaption;
  double? teMaxMark;
  double? peMaxMark;
  double? ceMaxMark;
  double? teMark;
  double? peMark;
  double? ceMark;
  String? teGrade;
  String? peGrade;
  String? ceGrade;
  String? teGradeId;
  String? peGradeId;
  String? ceGradeId;
  double? totalMark;
  double? markInPer;
  String? grade;
  String? gradeId;
  bool? isConfirmed;
  bool? isBlocked;
  String? createdAt;
  String? typeCode;
  String? examStatus;
  String? entryMethod;
  String? enteredBy;
  String? entryDate;

  ToolListViewModel(
      {this.markEntryId,
      this.presentDetId,
      this.toolId,
      this.toolName,
      this.teCaption,
      this.peCaption,
      this.ceCaption,
      this.teMaxMark,
      this.peMaxMark,
      this.ceMaxMark,
      this.teMark,
      this.peMark,
      this.ceMark,
      this.teGrade,
      this.peGrade,
      this.ceGrade,
      this.teGradeId,
      this.peGradeId,
      this.ceGradeId,
      this.totalMark,
      this.markInPer,
      this.grade,
      this.gradeId,
      this.isConfirmed,
      this.isBlocked,
      this.createdAt,
      this.typeCode,
      this.examStatus,
      this.entryMethod,
      this.enteredBy,
      this.entryDate});

  ToolListViewModel.fromJson(Map<String, dynamic> json) {
    markEntryId = json['markEntryId'];
    presentDetId = json['presentDetId'];
    toolId = json['toolId'];
    toolName = json['toolName'];
    teCaption = json['teCaption'];
    peCaption = json['peCaption'];
    ceCaption = json['ceCaption'];
    teMaxMark = json['teMaxMark'];
    peMaxMark = json['peMaxMark'];
    ceMaxMark = json['ceMaxMark'];
    teMark = json['teMark'];
    peMark = json['peMark'];
    ceMark = json['ceMark'];
    teGrade = json['teGrade'];
    peGrade = json['peGrade'];
    ceGrade = json['ceGrade'];
    teGradeId = json['teGradeId'];
    peGradeId = json['peGradeId'];
    ceGradeId = json['ceGradeId'];
    totalMark = json['totalMark'];
    markInPer = json['markInPer'];
    grade = json['grade'];
    gradeId = json['gradeId'];
    isConfirmed = json['isConfirmed'];
    isBlocked = json['isBlocked'];
    createdAt = json['createdAt'];
    typeCode = json['typeCode'];
    examStatus = json['examStatus'];
    entryMethod = json['entryMethod'];
    enteredBy = json['enteredBy'];
    entryDate = json['entryDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['markEntryId'] = this.markEntryId;
    data['presentDetId'] = this.presentDetId;
    data['toolId'] = this.toolId;
    data['toolName'] = this.toolName;
    data['teCaption'] = this.teCaption;
    data['peCaption'] = this.peCaption;
    data['ceCaption'] = this.ceCaption;
    data['teMaxMark'] = this.teMaxMark;
    data['peMaxMark'] = this.peMaxMark;
    data['ceMaxMark'] = this.ceMaxMark;
    data['teMark'] = this.teMark;
    data['peMark'] = this.peMark;
    data['ceMark'] = this.ceMark;
    data['teGrade'] = this.teGrade;
    data['peGrade'] = this.peGrade;
    data['ceGrade'] = this.ceGrade;
    data['teGradeId'] = this.teGradeId;
    data['peGradeId'] = this.peGradeId;
    data['ceGradeId'] = this.ceGradeId;
    data['totalMark'] = this.totalMark;
    data['markInPer'] = this.markInPer;
    data['grade'] = this.grade;
    data['gradeId'] = this.gradeId;
    data['isConfirmed'] = this.isConfirmed;
    data['isBlocked'] = this.isBlocked;
    data['createdAt'] = this.createdAt;
    data['typeCode'] = this.typeCode;
    data['examStatus'] = this.examStatus;
    data['entryMethod'] = this.entryMethod;
    data['enteredBy'] = this.enteredBy;
    data['entryDate'] = this.entryDate;
    return data;
  }
}

class ToolBasicData {
  bool? isConfirmed;
  bool? isBlocked;
  String? entryMethod;
  String? typeCode;
  String? examStatus;
  String? enteredBy;
  String? entryDate;

  ToolBasicData(
      {this.isConfirmed,
      this.isBlocked,
      this.entryMethod,
      this.typeCode,
      this.examStatus,
      this.enteredBy,
      this.entryDate});

  ToolBasicData.fromJson(Map<String, dynamic> json) {
    isConfirmed = json['isConfirmed'];
    isBlocked = json['isBlocked'];
    entryMethod = json['entryMethod'];
    typeCode = json['typeCode'];
    examStatus = json['examStatus'];
    enteredBy = json['enteredBy'];
    entryDate = json['entryDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isConfirmed'] = this.isConfirmed;
    data['isBlocked'] = this.isBlocked;
    data['entryMethod'] = this.entryMethod;
    data['typeCode'] = this.typeCode;
    data['examStatus'] = this.examStatus;
    data['enteredBy'] = this.enteredBy;
    data['entryDate'] = this.entryDate;
    return data;
  }
}
