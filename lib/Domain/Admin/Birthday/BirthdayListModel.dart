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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['studentId'] = this.studentId;
    data['studentName'] = this.studentName;
    data['divisionId'] = this.divisionId;
    data['division'] = this.division;
    data['rollNo'] = this.rollNo;
    data['studentPhotoId'] = this.studentPhotoId;
    data['mobileNumber'] = this.mobileNumber;
    data['studentPhoto'] = this.studentPhoto;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['staffId'] = this.staffId;
    data['staffName'] = this.staffName;
    data['designation'] = this.designation;
    data['section'] = this.section;
    data['staffPhotoId'] = this.staffPhotoId;
    data['mobileNumber'] = this.mobileNumber;
    data['staffPhoto'] = this.staffPhoto;
    return data;
  }
}
