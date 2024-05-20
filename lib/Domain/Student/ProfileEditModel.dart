class ProfileViewEditModel {
  InitialValues? initialValues;
  OfflineStudentValues? offlineStudentValues;
  bool? editprofile;

  ProfileViewEditModel(
      {this.initialValues, this.offlineStudentValues, this.editprofile});

  ProfileViewEditModel.fromJson(Map<String, dynamic> json) {
    initialValues = json['initialValues'] != null
        ? InitialValues.fromJson(json['initialValues'])
        : null;
    offlineStudentValues = json['offlineStudentValues'] != null
        ? OfflineStudentValues.fromJson(json['offlineStudentValues'])
        : null;
    editprofile = json['editprofile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (initialValues != null) {
      data['initialValues'] = initialValues!.toJson();
    }
    if (offlineStudentValues != null) {
      data['offlineStudentValues'] = offlineStudentValues!.toJson();
    }
    data['editprofile'] = editprofile;
    return data;
  }
}

class InitialValues {
  String? studentId;
  int? offlineId;
  int? installationId;
  String? studentName;
  String? guardianName;
  String? userName;
  String? address;
  String? emailId;
  String? mobileNo;
  String? photoId;
  StudentPhoto? studentPhoto;
  String? bloodGroupId;
  String? bloodGroup;

  InitialValues(
      {this.studentId,
      this.offlineId,
      this.installationId,
      this.studentName,
      this.guardianName,
      this.userName,
      this.address,
      this.emailId,
      this.mobileNo,
      this.photoId,
      this.studentPhoto,
      this.bloodGroupId,
      this.bloodGroup});

  InitialValues.fromJson(Map<String, dynamic> json) {
    studentId = json['studentId'];
    offlineId = json['offlineId'];
    installationId = json['installationId'];
    studentName = json['studentName'];
    guardianName = json['guardianName'];
    userName = json['userName'];
    address = json['address'];
    emailId = json['emailId'];
    mobileNo = json['mobileNo'];
    photoId = json['photoId'];
    studentPhoto = json['studentPhoto'] != null
        ? StudentPhoto.fromJson(json['studentPhoto'])
        : null;
    bloodGroupId = json['bloodGroupId'];
    bloodGroup = json['bloodGroup'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['studentId'] = studentId;
    data['offlineId'] = offlineId;
    data['installationId'] = installationId;
    data['studentName'] = studentName;
    data['guardianName'] = guardianName;
    data['userName'] = userName;
    data['address'] = address;
    data['emailId'] = emailId;
    data['mobileNo'] = mobileNo;
    data['photoId'] = photoId;
    if (studentPhoto != null) {
      data['studentPhoto'] = studentPhoto!.toJson();
    }
    data['bloodGroupId'] = bloodGroupId;
    data['bloodGroup'] = bloodGroup;
    return data;
  }
}

class StudentPhoto {
  String? name;
  String? extension;
  String? path;
  String? url;
  bool? isTemporary;
  bool? isDeleted;
  List<Images>? images;
  String? createdAt;
  String? id;

  StudentPhoto(
      {this.name,
      this.extension,
      this.path,
      this.url,
      this.isTemporary,
      this.isDeleted,
      this.images,
      this.createdAt,
      this.id});

  StudentPhoto.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    extension = json['extension'];
    path = json['path'];
    url = json['url'];
    isTemporary = json['isTemporary'];
    isDeleted = json['isDeleted'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['extension'] = extension;
    data['path'] = path;
    data['url'] = url;
    data['isTemporary'] = isTemporary;
    data['isDeleted'] = isDeleted;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = createdAt;
    data['id'] = id;
    return data;
  }
}

class Images {
  String? fileId;
  String? dimension;
  String? url;
  String? id;

  Images({this.fileId, this.dimension, this.url, this.id});

  Images.fromJson(Map<String, dynamic> json) {
    fileId = json['fileId'];
    dimension = json['dimension'];
    url = json['url'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fileId'] = fileId;
    data['dimension'] = dimension;
    data['url'] = url;
    data['id'] = id;
    return data;
  }
}

class OfflineStudentValues {
  String? id;
  String? studentId;
  String? guardianName;
  int? offlineId;
  int? installationId;
  String? address;
  String? emailId;
  String? mobileNo;
  String? studentPhotoId;
  StudentPhoto? studentPhoto;
  bool? isPhotoChanged;
  bool? isGuardianNameChanged;
  bool? isAddressChanged;
  bool? isEmailIdChanged;
  bool? isMobileNoChanged;
  String? bloodGroupId;
  bool? isBloodGroupChanged;

  OfflineStudentValues(
      {this.id,
      this.studentId,
      this.guardianName,
      this.offlineId,
      this.installationId,
      this.address,
      this.emailId,
      this.mobileNo,
      this.studentPhotoId,
      this.studentPhoto,
      this.isPhotoChanged,
      this.isGuardianNameChanged,
      this.isAddressChanged,
      this.isEmailIdChanged,
      this.isMobileNoChanged,
      this.bloodGroupId,
      this.isBloodGroupChanged});

  OfflineStudentValues.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    studentId = json['studentId'];
    guardianName = json['guardianName'];
    offlineId = json['offlineId'];
    installationId = json['installationId'];
    address = json['address'];
    emailId = json['emailId'];
    mobileNo = json['mobileNo'];
    studentPhotoId = json['studentPhotoId'];
    studentPhoto = json['studentPhoto'] != null
        ? StudentPhoto.fromJson(json['studentPhoto'])
        : null;
    isPhotoChanged = json['isPhotoChanged'];
    isGuardianNameChanged = json['isGuardianNameChanged'];
    isAddressChanged = json['isAddressChanged'];
    isEmailIdChanged = json['isEmailIdChanged'];
    isMobileNoChanged = json['isMobileNoChanged'];
    bloodGroupId = json['bloodGroupId'];
    isBloodGroupChanged = json['isBloodGroupChanged'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['studentId'] = studentId;
    data['guardianName'] = guardianName;
    data['offlineId'] = offlineId;
    data['installationId'] = installationId;
    data['address'] = address;
    data['emailId'] = emailId;
    data['mobileNo'] = mobileNo;
    data['studentPhotoId'] = studentPhotoId;
    if (studentPhoto != null) {
      data['studentPhoto'] = studentPhoto!.toJson();
    }
    data['isPhotoChanged'] = isPhotoChanged;
    data['isGuardianNameChanged'] = isGuardianNameChanged;
    data['isAddressChanged'] = isAddressChanged;
    data['isEmailIdChanged'] = isEmailIdChanged;
    data['isMobileNoChanged'] = isMobileNoChanged;
    data['bloodGroupId'] = bloodGroupId;
    data['isBloodGroupChanged'] = isBloodGroupChanged;
    return data;
  }
}

class BloodGroupListModel {
  String? value;
  String? text;

  BloodGroupListModel({
    this.value,
    this.text,
  });

  BloodGroupListModel.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['text'] = text;

    return data;
  }
}
