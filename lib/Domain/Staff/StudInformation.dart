//Student Data
class StudentData {
  String? studentName;
  String? admissionNo;
  String? gender;
  String? classNo;
  String? course;
  String? division;
  String? dob;
  String? terminationStatus;
  String? bloodgroup;
  String? houseGroup;
  String? permanentAddress1;
  String? height;
  String? weight;
  String? healthCardNo;
  String? visionLeft;
  String? visionRight;
  String? teeth;
  String? oralHygiene;
  String? remarks;
  String? disability;
  String? guardianName;
  String? guardianRelation;
  String? guardianMobile1;
  String? guardianEmail;
  String? fatherName;
  String? fatherMobile1;
  String? fatherEmail;
  String? motherName;
  String? motherMobile1;
  String? motherEmail;
  String? secondLanguage;
  List<SiblingsDetails>? siblingsDetails;
  SiblingPhoto? studentPhoto;
  String? studentPhotoId;
  SiblingPhoto? fatherPhoto;
  String? fatherPhotoId;
  SiblingPhoto? motherPhoto;
  String? motherPhotoId;
  SiblingPhoto? guardianPhoto;
  String? guardianPhotoId;
  String? bankAdmnNo;

  StudentData(
      {this.studentName,
      this.admissionNo,
      this.gender,
      this.classNo,
      this.course,
      this.division,
      this.dob,
      this.terminationStatus,
      this.bloodgroup,
      this.houseGroup,
      this.permanentAddress1,
      this.height,
      this.weight,
      this.healthCardNo,
      this.visionLeft,
      this.visionRight,
      this.teeth,
      this.oralHygiene,
      this.remarks,
      this.disability,
      this.guardianName,
      this.guardianRelation,
      this.guardianMobile1,
      this.guardianEmail,
      this.fatherName,
      this.fatherMobile1,
      this.fatherEmail,
      this.motherName,
      this.motherMobile1,
      this.motherEmail,
      this.secondLanguage,
      this.siblingsDetails,
      this.studentPhoto,
      this.studentPhotoId,
      this.fatherPhoto,
      this.fatherPhotoId,
      this.motherPhoto,
      this.motherPhotoId,
      this.guardianPhoto,
      this.guardianPhotoId,
      this.bankAdmnNo});

  StudentData.fromJson(Map<String, dynamic> json) {
    studentName = json['studentName'];
    admissionNo = json['admissionNo'];
    gender = json['gender'];
    classNo = json['classNo'];
    course = json['course'];
    division = json['division'];
    dob = json['dob'];
    terminationStatus = json['terminationStatus'];
    bloodgroup = json['bloodgroup'];
    houseGroup = json['houseGroup'];
    permanentAddress1 = json['permanentAddress1'];
    height = json['height'];
    weight = json['weight'];
    healthCardNo = json['healthCardNo'];
    visionLeft = json['visionLeft'];
    visionRight = json['visionRight'];
    teeth = json['teeth'];
    oralHygiene = json['oralHygiene'];
    remarks = json['remarks'];
    disability = json['disability'];
    guardianName = json['guardianName'];
    guardianRelation = json['guardianRelation'];
    guardianMobile1 = json['guardianMobile1'];
    guardianEmail = json['guardianEmail'];
    fatherName = json['fatherName'];
    fatherMobile1 = json['fatherMobile1'];
    fatherEmail = json['fatherEmail'];
    motherName = json['motherName'];
    motherMobile1 = json['motherMobile1'];
    motherEmail = json['motherEmail'];
    secondLanguage = json['secondLanguage'];
    if (json['siblingsDetails'] != null) {
      siblingsDetails = <SiblingsDetails>[];
      json['siblingsDetails'].forEach((v) {
        siblingsDetails!.add(SiblingsDetails.fromJson(v));
      });
    }
    studentPhoto = json['studentPhoto'] != null
        ? SiblingPhoto.fromJson(json['studentPhoto'])
        : null;
    studentPhotoId = json['studentPhotoId'];
    fatherPhoto = json['fatherPhoto'] != null
        ? SiblingPhoto.fromJson(json['fatherPhoto'])
        : null;
    fatherPhotoId = json['fatherPhotoId'];
    motherPhoto = json['motherPhoto'] != null
        ? SiblingPhoto.fromJson(json['motherPhoto'])
        : null;
    motherPhotoId = json['motherPhotoId'];
    guardianPhoto = json['guardianPhoto'] != null
        ? SiblingPhoto.fromJson(json['guardianPhoto'])
        : null;
    guardianPhotoId = json['guardianPhotoId'];
    bankAdmnNo = json['bankAdmnNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['studentName'] = studentName;
    data['admissionNo'] = admissionNo;
    data['gender'] = gender;
    data['classNo'] = classNo;
    data['course'] = course;
    data['division'] = division;
    data['dob'] = dob;
    data['terminationStatus'] = terminationStatus;
    data['bloodgroup'] = bloodgroup;
    data['houseGroup'] = houseGroup;
    data['permanentAddress1'] = permanentAddress1;
    data['height'] = height;
    data['weight'] = weight;
    data['healthCardNo'] = healthCardNo;
    data['visionLeft'] = visionLeft;
    data['visionRight'] = visionRight;
    data['teeth'] = teeth;
    data['oralHygiene'] = oralHygiene;
    data['remarks'] = remarks;
    data['disability'] = disability;
    data['guardianName'] = guardianName;
    data['guardianRelation'] = guardianRelation;
    data['guardianMobile1'] = guardianMobile1;
    data['guardianEmail'] = guardianEmail;
    data['fatherName'] = fatherName;
    data['fatherMobile1'] = fatherMobile1;
    data['fatherEmail'] = fatherEmail;
    data['motherName'] = motherName;
    data['motherMobile1'] = motherMobile1;
    data['motherEmail'] = motherEmail;
    data['secondLanguage'] = secondLanguage;
    if (siblingsDetails != null) {
      data['siblingsDetails'] =
          siblingsDetails!.map((v) => v.toJson()).toList();
    }
    if (studentPhoto != null) {
      data['studentPhoto'] = studentPhoto!.toJson();
    }
    data['studentPhotoId'] = studentPhotoId;
    if (fatherPhoto != null) {
      data['fatherPhoto'] = fatherPhoto!.toJson();
    }
    data['fatherPhotoId'] = fatherPhotoId;
    if (motherPhoto != null) {
      data['motherPhoto'] = motherPhoto!.toJson();
    }
    data['motherPhotoId'] = motherPhotoId;
    if (guardianPhoto != null) {
      data['guardianPhoto'] = guardianPhoto!.toJson();
    }
    data['guardianPhotoId'] = guardianPhotoId;
    data['bankAdmnNo'] = bankAdmnNo;
    return data;
  }
}

class SiblingsDetails {
  String? siblingAdmNo;
  String? siblingRollNo;
  String? siblingName;
  String? siblingDivision;
  String? siblingRelation;
  String? studentPhotoId;
  SiblingPhoto? siblingPhoto;

  SiblingsDetails(
      {this.siblingAdmNo,
      this.siblingRollNo,
      this.siblingName,
      this.siblingDivision,
      this.siblingRelation,
      this.studentPhotoId,
      this.siblingPhoto});

  SiblingsDetails.fromJson(Map<String, dynamic> json) {
    siblingAdmNo = json['siblingAdmNo'];
    siblingRollNo = json['siblingRollNo'];
    siblingName = json['siblingName'];
    siblingDivision = json['siblingDivision'];
    siblingRelation = json['siblingRelation'];
    studentPhotoId = json['studentPhotoId'];
    siblingPhoto = json['siblingPhoto'] != null
        ? SiblingPhoto.fromJson(json['siblingPhoto'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['siblingAdmNo'] = siblingAdmNo;
    data['siblingRollNo'] = siblingRollNo;
    data['siblingName'] = siblingName;
    data['siblingDivision'] = siblingDivision;
    data['siblingRelation'] = siblingRelation;
    data['studentPhotoId'] = studentPhotoId;
    if (siblingPhoto != null) {
      data['siblingPhoto'] = siblingPhoto!.toJson();
    }
    return data;
  }
}

class SiblingPhoto {
  String? name;
  String? extension;
  String? path;
  String? url;
  bool? isTemporary;
  bool? isDeleted;
  List<Images>? images;
  String? createdAt;
  String? id;

  SiblingPhoto(
      {this.name,
      this.extension,
      this.path,
      this.url,
      this.isTemporary,
      this.isDeleted,
      this.images,
      this.createdAt,
      this.id});

  SiblingPhoto.fromJson(Map<String, dynamic> json) {
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

//Attendance
class StduAttendanceDetails {
  String? attendanceAsOnDate;
  int? workDays;
  double? presentDays;
  double? absentDays;
  double? attendancePercentage;
  double? absentPercentage;

  StduAttendanceDetails(
      {this.attendanceAsOnDate,
      this.workDays,
      this.presentDays,
      this.absentDays,
      this.attendancePercentage,
      this.absentPercentage});

  StduAttendanceDetails.fromJson(Map<String, dynamic> json) {
    attendanceAsOnDate = json['attendanceAsOnDate'];
    workDays = json['workDays'];
    presentDays = json['presentDays'];
    absentDays = json['absentDays'];
    attendancePercentage = json['attendancePercentage'];
    absentPercentage = json['absentPercentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['attendanceAsOnDate'] = attendanceAsOnDate;
    data['workDays'] = workDays;
    data['presentDays'] = presentDays;
    data['absentDays'] = absentDays;
    data['attendancePercentage'] = attendancePercentage;
    data['absentPercentage'] = absentPercentage;
    return data;
  }
}

//fees
class StudFeeDetails {
  double? busPaidAmount;
  double? schoolPaidAmount;
  double? busPendingAmount;
  double? schoolPendingAmount;
  String? maxDate;

  StudFeeDetails(
      {this.busPaidAmount,
      this.schoolPaidAmount,
      this.busPendingAmount,
      this.schoolPendingAmount,
      this.maxDate});

  StudFeeDetails.fromJson(Map<String, dynamic> json) {
    busPaidAmount = json['busPaidAmount'];
    schoolPaidAmount = json['schoolPaidAmount'];
    busPendingAmount = json['busPendingAmount'];
    schoolPendingAmount = json['schoolPendingAmount'];
    maxDate = json['maxDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['busPaidAmount'] = busPaidAmount;
    data['schoolPaidAmount'] = schoolPaidAmount;
    data['busPendingAmount'] = busPendingAmount;
    data['schoolPendingAmount'] = schoolPendingAmount;
    data['maxDate'] = maxDate;
    return data;
  }
}
//Academic Performance

class AcademicPerformance {
  String? studentId;
  String? uploadedDate;
  String? description;
  String? fileId;

  AcademicPerformance(
      {this.studentId, this.uploadedDate, this.description, this.fileId});

  AcademicPerformance.fromJson(Map<String, dynamic> json) {
    studentId = json['studentId'];
    uploadedDate = json['uploadedDate'];
    description = json['description'];
    fileId = json['fileId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['studentId'] = studentId;
    data['uploadedDate'] = uploadedDate;
    data['description'] = description;
    data['fileId'] = fileId;
    return data;
  }
}

//ReportCard

class ReportcardAttachment {
  String? name;
  String? extension;
  String? path;
  String? url;
  bool? isTemporary;
  bool? isDeleted;

  String? createdAt;
  String? id;

  ReportcardAttachment(
      {this.name,
      this.extension,
      this.path,
      this.url,
      this.isTemporary,
      this.isDeleted,
      this.createdAt,
      this.id});

  ReportcardAttachment.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    extension = json['extension'];
    path = json['path'];
    url = json['url'];
    isTemporary = json['isTemporary'];
    isDeleted = json['isDeleted'];

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

    data['createdAt'] = createdAt;
    data['id'] = id;
    return data;
  }
}

//Timetable

class TimtableView {
  String? name;
  String? extension;
  String? path;
  String? url;
  bool? isTemporary;
  bool? isDeleted;
  List? images;
  String? createdAt;
  String? id;

  TimtableView(
      {this.name,
      this.extension,
      this.path,
      this.url,
      this.isTemporary,
      this.isDeleted,
      this.images,
      this.createdAt,
      this.id});

  TimtableView.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    extension = json['extension'];
    path = json['path'];
    url = json['url'];
    isTemporary = json['isTemporary'];
    isDeleted = json['isDeleted'];
    images = json['images'];
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
    data['images'] = images;
    data['createdAt'] = createdAt;
    data['id'] = id;
    return data;
  }
}
