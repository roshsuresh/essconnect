class MeListModel {
  String? divisionId;
  String? division;
  int? divisionWiseStudentsCount;
  int? divisionOrder;
  bool? isExisting;
  // Null? subjectList;
  List<StudentListModel>? studentList;

  MeListModel(
      {this.divisionId,
      this.division,
      this.divisionWiseStudentsCount,
      this.divisionOrder,
      this.isExisting,
      // this.subjectList,
      this.studentList});

  MeListModel.fromJson(Map<String, dynamic> json) {
    divisionId = json['divisionId'];
    division = json['division'];
    divisionWiseStudentsCount = json['divisionWiseStudentsCount'];
    divisionOrder = json['divisionOrder'];
    isExisting = json['isExisting'];
    //  subjectList = json['subjectList'];
    if (json['studentList'] != null) {
      studentList = <StudentListModel>[];
      json['studentList'].forEach((v) {
        studentList!.add(StudentListModel.fromJson(v));
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
    //  data['subjectList'] = this.subjectList;
    if (studentList != null) {
      data['studentList'] = studentList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StudentListModel {
  int? rollNo;
  String? name;
  String? studentPresentDetailsId;
  bool? missingMarkEntry;
  List<SUbjectListModel>? sUbjectList;

  StudentListModel(
      {this.rollNo,
      this.name,
      this.studentPresentDetailsId,
      this.missingMarkEntry,
      this.sUbjectList});

  StudentListModel.fromJson(Map<String, dynamic> json) {
    rollNo = json['rollNo'];
    name = json['name'];
    studentPresentDetailsId = json['studentPresentDetailsId'];
    missingMarkEntry = json['missingMarkEntry'];
    if (json['sUbjectList'] != null) {
      sUbjectList = <SUbjectListModel>[];
      json['sUbjectList'].forEach((v) {
        sUbjectList!.add(SUbjectListModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rollNo'] = rollNo;
    data['name'] = name;
    data['studentPresentDetailsId'] = studentPresentDetailsId;
    data['missingMarkEntry'] = missingMarkEntry;
    if (sUbjectList != null) {
      data['sUbjectList'] = sUbjectList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SUbjectListModel {
  String? id;
  String? subject;
  String? shortName;
  String? mainSubject;
  String? user;
  bool? isMainSub;

  SUbjectListModel(
      {this.id,
      this.subject,
      this.shortName,
      this.mainSubject,
      this.user,
      this.isMainSub});

  SUbjectListModel.fromJson(Map<String, dynamic> json) {
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
