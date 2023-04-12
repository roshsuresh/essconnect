class MeListStaff {
  String? divisionId;
  String? division;
  int? divisionWiseStudentsCount;
  int? divisionOrder;
  bool? isExisting;
  List<SubjectListStaff>? subjectList;
  List<StudentListStaff>? studentList;

  MeListStaff(
      {this.divisionId,
      this.division,
      this.divisionWiseStudentsCount,
      this.divisionOrder,
      this.isExisting,
      this.subjectList,
      this.studentList});

  MeListStaff.fromJson(Map<String, dynamic> json) {
    divisionId = json['divisionId'];
    division = json['division'];
    divisionWiseStudentsCount = json['divisionWiseStudentsCount'];
    divisionOrder = json['divisionOrder'];
    isExisting = json['isExisting'];
    if (json['subjectList'] != null) {
      subjectList = <SubjectListStaff>[];
      json['subjectList'].forEach((v) {
        subjectList!.add(SubjectListStaff.fromJson(v));
      });
    }
    if (json['studentList'] != null) {
      studentList = <StudentListStaff>[];
      json['studentList'].forEach((v) {
        studentList!.add(StudentListStaff.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['divisionId'] = this.divisionId;
    data['division'] = this.division;
    data['divisionWiseStudentsCount'] = this.divisionWiseStudentsCount;
    data['divisionOrder'] = this.divisionOrder;
    data['isExisting'] = this.isExisting;
    if (this.subjectList != null) {
      data['subjectList'] = this.subjectList!.map((v) => v.toJson()).toList();
    }
    if (this.studentList != null) {
      data['studentList'] = this.studentList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubjectListStaff {
  String? id;
  String? subject;
  Null? shortName;
  Null? mainSubject;
  String? user;
  bool? isMainSub;

  SubjectListStaff(
      {this.id,
      this.subject,
      this.shortName,
      this.mainSubject,
      this.user,
      this.isMainSub});

  SubjectListStaff.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subject = json['subject'];
    shortName = json['shortName'];
    mainSubject = json['mainSubject'];
    user = json['user'];
    isMainSub = json['isMainSub'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['subject'] = this.subject;
    data['shortName'] = this.shortName;
    data['mainSubject'] = this.mainSubject;
    data['user'] = this.user;
    data['isMainSub'] = this.isMainSub;
    return data;
  }
}

class StudentListStaff {
  int? rollNo;
  String? name;
  String? studentPresentDetailsId;
  bool? missingMarkEntry;
  Null? sUbjectList;

  StudentListStaff(
      {this.rollNo,
      this.name,
      this.studentPresentDetailsId,
      this.missingMarkEntry,
      this.sUbjectList});

  StudentListStaff.fromJson(Map<String, dynamic> json) {
    rollNo = json['rollNo'];
    name = json['name'];
    studentPresentDetailsId = json['studentPresentDetailsId'];
    missingMarkEntry = json['missingMarkEntry'];
    sUbjectList = json['sUbjectList'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['rollNo'] = this.rollNo;
    data['name'] = this.name;
    data['studentPresentDetailsId'] = this.studentPresentDetailsId;
    data['missingMarkEntry'] = this.missingMarkEntry;
    data['sUbjectList'] = this.sUbjectList;
    return data;
  }
}
