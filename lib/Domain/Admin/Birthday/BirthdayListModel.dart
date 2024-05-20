class StudentBirthdayList {
  String? studentId;
  String? studentName;
  String? divisionId;
  String? division;
  int? rollNo;
  String? studentPhotoId;
  String? mobileNumber;
  String? studentPhoto;
  bool? selectedStud;

  StudentBirthdayList(
      {this.studentId,
      this.studentName,
      this.divisionId,
      this.division,
      this.rollNo,
      this.studentPhotoId,
      this.mobileNumber,
      this.studentPhoto,
      this.selectedStud});

  StudentBirthdayList.fromJson(Map<String, dynamic> json) {
    studentId = json['studentId'];
    studentName = json['studentName'];
    divisionId = json['divisionId'];
    division = json['division'];
    rollNo = json['rollNo'];
    studentPhotoId = json['studentPhotoId'];
    mobileNumber = json['mobileNumber'];
    studentPhoto = json['studentPhoto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['studentId'] = studentId;
    data['studentName'] = studentName;
    data['divisionId'] = divisionId;
    data['division'] = division;
    data['rollNo'] = rollNo;
    data['studentPhotoId'] = studentPhotoId;
    data['mobileNumber'] = mobileNumber;
    data['studentPhoto'] = studentPhoto;
    return data;
  }
}

class StaffBirthdayList {
  String? staffId;
  String? staffName;
  String? designation;
  String? section;
  String? staffPhotoId;
  String? mobileNumber;
  String? staffPhoto;
  bool? selectedStaff;

  StaffBirthdayList(
      {this.staffId,
      this.staffName,
      this.designation,
      this.section,
      this.staffPhotoId,
      this.mobileNumber,
      this.staffPhoto,
      this.selectedStaff});

  StaffBirthdayList.fromJson(Map<String, dynamic> json) {
    staffId = json['staffId'];
    staffName = json['staffName'];
    designation = json['designation'];
    section = json['section'];
    staffPhotoId = json['staffPhotoId'];
    mobileNumber = json['mobileNumber'];
    staffPhoto = json['staffPhoto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['staffId'] = staffId;
    data['staffName'] = staffName;
    data['designation'] = designation;
    data['section'] = section;
    data['staffPhotoId'] = staffPhotoId;
    data['mobileNumber'] = mobileNumber;
    data['staffPhoto'] = staffPhoto;
    return data;
  }
}
