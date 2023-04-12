class MeListModel {
  String? divisionId;
  String? division;
  int? divisionWiseStudentsCount;
  int? divisionOrder;
  bool? isExisting;
  Null? subjectList;
  List<StudentListModel>? studentList;

  MeListModel(
      {this.divisionId,
      this.division,
      this.divisionWiseStudentsCount,
      this.divisionOrder,
      this.isExisting,
      this.subjectList,
      this.studentList});

  MeListModel.fromJson(Map<String, dynamic> json) {
    divisionId = json['divisionId'];
    division = json['division'];
    divisionWiseStudentsCount = json['divisionWiseStudentsCount'];
    divisionOrder = json['divisionOrder'];
    isExisting = json['isExisting'];
    subjectList = json['subjectList'];
    if (json['studentList'] != null) {
      studentList = <StudentListModel>[];
      json['studentList'].forEach((v) {
        studentList!.add(new StudentListModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['divisionId'] = this.divisionId;
    data['division'] = this.division;
    data['divisionWiseStudentsCount'] = this.divisionWiseStudentsCount;
    data['divisionOrder'] = this.divisionOrder;
    data['isExisting'] = this.isExisting;
    data['subjectList'] = this.subjectList;
    if (this.studentList != null) {
      data['studentList'] = this.studentList!.map((v) => v.toJson()).toList();
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
        sUbjectList!.add(new SUbjectListModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rollNo'] = this.rollNo;
    data['name'] = this.name;
    data['studentPresentDetailsId'] = this.studentPresentDetailsId;
    data['missingMarkEntry'] = this.missingMarkEntry;
    if (this.sUbjectList != null) {
      data['sUbjectList'] = this.sUbjectList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SUbjectListModel {
  String? id;
  String? subject;
  Null? shortName;
  Null? mainSubject;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['subject'] = this.subject;
    data['shortName'] = this.shortName;
    data['mainSubject'] = this.mainSubject;
    data['user'] = this.user;
    data['isMainSub'] = this.isMainSub;
    return data;
  }
}
