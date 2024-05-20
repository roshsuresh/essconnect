class MarkentryViewByStaff {
  List<StudentMEList>? studentMEList;
  List<MaxMarkList>? maxMarkList;
  List<GradeList>? gradeList;
  String? typeCode;
  String? examStatus;

  MarkentryViewByStaff(
      {this.studentMEList,
      this.maxMarkList,
      this.gradeList,
      this.typeCode,
      this.examStatus});

  MarkentryViewByStaff.fromJson(Map<String, dynamic> json) {
    if (json['studentMEList'] != null) {
      studentMEList = [];
      json['studentMEList'].forEach((v) {
        studentMEList!.add(StudentMEList.fromJson(v));
      });
    }
    if (json['maxMarkList'] != null) {
      maxMarkList = [];
      json['maxMarkList'].forEach((v) {
        maxMarkList!.add(MaxMarkList.fromJson(v));
      });
    }
    if (json['gradeList'] != null) {
      gradeList = <GradeList>[];
      json['gradeList'].forEach((v) {
        gradeList!.add(GradeList.fromJson(v));
      });
    }
    typeCode = json['typeCode'];
    examStatus = json['examStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (studentMEList != null) {
      data['studentMEList'] = studentMEList!.map((v) => v.toJson()).toList();
    }
    if (maxMarkList != null) {
      data['maxMarkList'] = maxMarkList!.map((v) => v.toJson()).toList();
    }
    if (gradeList != null) {
      data['gradeList'] = gradeList!.map((v) => v.toJson()).toList();
    }
    data['typeCode'] = typeCode;
    data['examStatus'] = examStatus;
    return data;
  }
}

class StudentMEList {
  String? name;
  int? rollNo;
  String? studentPresentDetailsId;
  double? teMark;
  double? peMark;
  double? ceMark;
  String? teGrade;
  String? peGrade;
  String? ceGrade;
  double? totalMark;
  double? markInPer;
  String? grade;
  String? gradeId;
  String? teGradeId;
  String? peGradeId;
  String? ceGradeId;
  String? attendance;
  String? description;
  bool? disableAbsentRow;

  StudentMEList(
      {this.name,
      this.rollNo,
      this.studentPresentDetailsId,
      this.teMark,
      this.peMark,
      this.ceMark,
      this.teGrade,
      this.peGrade,
      this.ceGrade,
      this.totalMark,
      this.markInPer,
      this.grade,
      this.gradeId,
      this.teGradeId,
      this.peGradeId,
      this.ceGradeId,
      this.attendance,
      this.description,
      this.disableAbsentRow});

  StudentMEList.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    rollNo = json['rollNo'];
    studentPresentDetailsId = json['studentPresentDetailsId'];
    teMark = json['teMark'];
    peMark = json['peMark'];
    ceMark = json['ceMark'];
    teGrade = json['teGrade'];
    peGrade = json['peGrade'];
    ceGrade = json['ceGrade'];
    totalMark = json['totalMark'];
    markInPer = json['markInPer'];
    grade = json['grade'];
    gradeId = json['gradeId'];
    teGradeId = json['teGradeId'];
    peGradeId = json['peGradeId'];
    ceGradeId = json['ceGradeId'];
    attendance = json['attendance'];
    description = json['description'];
    disableAbsentRow = json['disableAbsentRow'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['rollNo'] = rollNo;
    data['studentPresentDetailsId'] = studentPresentDetailsId;
    data['teMark'] = teMark;
    data['peMark'] = peMark;
    data['ceMark'] = ceMark;
    data['teGrade'] = teGrade;
    data['peGrade'] = peGrade;
    data['ceGrade'] = ceGrade;
    data['totalMark'] = totalMark;
    data['markInPer'] = markInPer;
    data['grade'] = grade;
    data['gradeId'] = gradeId;
    data['teGradeId'] = teGradeId;
    data['peGradeId'] = peGradeId;
    data['ceGradeId'] = ceGradeId;
    data['attendance'] = attendance;
    data['description'] = description;
    data['disableAbsentRow'] = disableAbsentRow;
    return data;
  }
}

class MaxMarkList {
  double? teMax;
  double? peMax;
  double? ceMax;
  String? teCaption;
  String? peCaption;
  String? ceCaption;
  String? entryMethod;
  double? teGrade;
  double? peGrade;
  double? ceGrade;
  bool? isBlocked;
  double? gradeId;
  String? createdDate;
  String? enteredBy;
  String? status;
  String? part;
  bool? isConfirmed;
  String? code;

  MaxMarkList(
      {this.teMax,
      this.peMax,
      this.ceMax,
      this.teCaption,
      this.peCaption,
      this.ceCaption,
      this.entryMethod,
      this.teGrade,
      this.peGrade,
      this.ceGrade,
      this.isBlocked,
      this.gradeId,
      this.createdDate,
      this.enteredBy,
      this.status,
      this.part,
      this.isConfirmed,
      this.code});

  MaxMarkList.fromJson(Map<String, dynamic> json) {
    teMax = json['teMax'];
    peMax = json['peMax'];
    ceMax = json['ceMax'];
    teCaption = json['teCaption'];
    peCaption = json['peCaption'];
    ceCaption = json['ceCaption'];
    entryMethod = json['entryMethod'];
    teGrade = json['teGrade'];
    peGrade = json['peGrade'];
    ceGrade = json['ceGrade'];
    isBlocked = json['isBlocked'];
    gradeId = json['gradeId'];
    createdDate = json['createdDate'];
    enteredBy = json['enteredBy'];
    status = json['status'];
    part = json['part'];
    isConfirmed = json['isConfirmed'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['teMax'] = teMax;
    data['peMax'] = peMax;
    data['ceMax'] = ceMax;
    data['teCaption'] = teCaption;
    data['peCaption'] = peCaption;
    data['ceCaption'] = ceCaption;
    data['entryMethod'] = entryMethod;
    data['teGrade'] = teGrade;
    data['peGrade'] = peGrade;
    data['ceGrade'] = ceGrade;
    data['isBlocked'] = isBlocked;
    data['gradeId'] = gradeId;
    data['createdDate'] = createdDate;
    data['enteredBy'] = enteredBy;
    data['status'] = status;
    data['part'] = part;
    data['isConfirmed'] = isConfirmed;
    data['code'] = code;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['gradeName'] = gradeName;
    data['gradeOrder'] = gradeOrder;
    data['gradeId'] = gradeId;
    return data;
  }
}
