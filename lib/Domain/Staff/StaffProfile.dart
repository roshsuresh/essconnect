class StaffprofileModel {
  Staffprofile? staffprofile;

  StaffprofileModel({this.staffprofile});

  StaffprofileModel.fromJson(Map<String, dynamic> json) {
    staffprofile = json['staffprofile'] != null
        ? Staffprofile.fromJson(json['staffprofile'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (staffprofile != null) {
      data['staffprofile'] = staffprofile!.toJson();
    }
    return data;
  }
}

class Staffprofile {
  String? name;
  String? section;
  String? designation;
  String? mobileNo;
  String? emailid;
  String? dateOfBirth;
  String? userName;
  String? shortname;
  String? gender;
  String? address;
  String? staffRole;
  String? photoId;
  String? photo;

  Staffprofile(
      {this.name,
      this.section,
      this.designation,
      this.mobileNo,
      this.emailid,
      this.dateOfBirth,
      this.userName,
      this.shortname,
      this.gender,
      this.address,
      this.staffRole,
      this.photoId,
      this.photo});

  Staffprofile.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    section = json['section'];
    designation = json['designation'];
    mobileNo = json['mobileNo'];
    emailid = json['emailid'];
    dateOfBirth = json['dateOfBirth'];
    userName = json['userName'];
    shortname = json['shortname'];
    gender = json['gender'];
    address = json['address'];
    staffRole = json['staffRole'];
    photoId = json['photoId'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['section'] = section;
    data['designation'] = designation;
    data['mobileNo'] = mobileNo;
    data['emailid'] = emailid;
    data['dateOfBirth'] = dateOfBirth;
    data['userName'] = userName;
    data['shortname'] = shortname;
    data['gender'] = gender;
    data['address'] = address;
    data['staffRole'] = staffRole;
    data['photoId'] = photoId;
    data['photo'] = photo;
    return data;
  }
}
