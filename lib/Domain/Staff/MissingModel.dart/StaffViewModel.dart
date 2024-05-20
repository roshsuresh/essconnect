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
    data['divisionId'] = divisionId;
    data['division'] = division;
    data['divisionWiseStudentsCount'] = divisionWiseStudentsCount;
    data['divisionOrder'] = divisionOrder;
    data['isExisting'] = isExisting;
    if (subjectList != null) {
      data['subjectList'] = subjectList!.map((v) => v.toJson()).toList();
    }
    if (studentList != null) {
      data['studentList'] = studentList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubjectListStaff {
  String? id;
  String? subject;
  String? shortName;
  String? mainSubject;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['subject'] = subject;
    data['shortName'] = shortName;
    data['mainSubject'] = mainSubject;
    data['user'] = user;
    data['isMainSub'] = isMainSub;
    return data;
  }
}

class StudentListStaff {
  int? rollNo;
  String? name;
  String? studentPresentDetailsId;
  bool? missingMarkEntry;
  List? sUbjectList;

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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rollNo'] = rollNo;
    data['name'] = name;
    data['studentPresentDetailsId'] = studentPresentDetailsId;
    data['missingMarkEntry'] = missingMarkEntry;
    data['sUbjectList'] = sUbjectList;
    return data;
  }
}
