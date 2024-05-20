class StaffReportByAdmin {
  String? id;
  String? name;
  String? sectionId;
  String? section;
  String? designation;
  String? mobileNo;
  String? emailId;
  String? staffRole;
  String? staffPhoto;
  String? gender;
  String? address;
  String? dateOfBirth;

  StaffReportByAdmin(
      {this.id,
      this.name,
      this.sectionId,
      this.section,
      this.designation,
      this.mobileNo,
      this.emailId,
      this.staffRole,
      this.staffPhoto,
      this.gender,
      this.address,
      this.dateOfBirth});

  StaffReportByAdmin.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    sectionId = json['sectionId'];
    section = json['section'];
    designation = json['designation'];
    mobileNo = json['mobileNo'];
    emailId = json['emailId'];
    staffRole = json['staffRole'];
    staffPhoto = json['staffPhoto'];
    gender = json['gender'];
    address = json['address'];
    dateOfBirth = json['dateOfBirth'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['sectionId'] = sectionId;
    data['section'] = section;
    data['designation'] = designation;
    data['mobileNo'] = mobileNo;
    data['emailId'] = emailId;
    data['staffRole'] = staffRole;
    data['staffPhoto'] = staffPhoto;
    data['gender'] = gender;
    data['address'] = address;
    data['dateOfBirth'] = dateOfBirth;
    return data;
  }
}
