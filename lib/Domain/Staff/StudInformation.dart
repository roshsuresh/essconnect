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
  Null? houseGroup;
  String? permanentAddress1;
  String? height;
  String? weight;
  Null? healthCardNo;
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
        siblingsDetails!.add(new SiblingsDetails.fromJson(v));
      });
    }
    studentPhoto = json['studentPhoto'] != null
        ? new SiblingPhoto.fromJson(json['studentPhoto'])
        : null;
    studentPhotoId = json['studentPhotoId'];
    fatherPhoto = json['fatherPhoto'] != null
        ? new SiblingPhoto.fromJson(json['fatherPhoto'])
        : null;
    fatherPhotoId = json['fatherPhotoId'];
    motherPhoto = json['motherPhoto'] != null
        ? new SiblingPhoto.fromJson(json['motherPhoto'])
        : null;
    motherPhotoId = json['motherPhotoId'];
    guardianPhoto = json['guardianPhoto'] != null
        ? new SiblingPhoto.fromJson(json['guardianPhoto'])
        : null;
    guardianPhotoId = json['guardianPhotoId'];
    bankAdmnNo = json['bankAdmnNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['studentName'] = this.studentName;
    data['admissionNo'] = this.admissionNo;
    data['gender'] = this.gender;
    data['classNo'] = this.classNo;
    data['course'] = this.course;
    data['division'] = this.division;
    data['dob'] = this.dob;
    data['terminationStatus'] = this.terminationStatus;
    data['bloodgroup'] = this.bloodgroup;
    data['houseGroup'] = this.houseGroup;
    data['permanentAddress1'] = this.permanentAddress1;
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['healthCardNo'] = this.healthCardNo;
    data['visionLeft'] = this.visionLeft;
    data['visionRight'] = this.visionRight;
    data['teeth'] = this.teeth;
    data['oralHygiene'] = this.oralHygiene;
    data['remarks'] = this.remarks;
    data['disability'] = this.disability;
    data['guardianName'] = this.guardianName;
    data['guardianRelation'] = this.guardianRelation;
    data['guardianMobile1'] = this.guardianMobile1;
    data['guardianEmail'] = this.guardianEmail;
    data['fatherName'] = this.fatherName;
    data['fatherMobile1'] = this.fatherMobile1;
    data['fatherEmail'] = this.fatherEmail;
    data['motherName'] = this.motherName;
    data['motherMobile1'] = this.motherMobile1;
    data['motherEmail'] = this.motherEmail;
    data['secondLanguage'] = this.secondLanguage;
    if (this.siblingsDetails != null) {
      data['siblingsDetails'] =
          this.siblingsDetails!.map((v) => v.toJson()).toList();
    }
    if (this.studentPhoto != null) {
      data['studentPhoto'] = this.studentPhoto!.toJson();
    }
    data['studentPhotoId'] = this.studentPhotoId;
    if (this.fatherPhoto != null) {
      data['fatherPhoto'] = this.fatherPhoto!.toJson();
    }
    data['fatherPhotoId'] = this.fatherPhotoId;
    if (this.motherPhoto != null) {
      data['motherPhoto'] = this.motherPhoto!.toJson();
    }
    data['motherPhotoId'] = this.motherPhotoId;
    if (this.guardianPhoto != null) {
      data['guardianPhoto'] = this.guardianPhoto!.toJson();
    }
    data['guardianPhotoId'] = this.guardianPhotoId;
    data['bankAdmnNo'] = this.bankAdmnNo;
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
        ? new SiblingPhoto.fromJson(json['siblingPhoto'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['siblingAdmNo'] = this.siblingAdmNo;
    data['siblingRollNo'] = this.siblingRollNo;
    data['siblingName'] = this.siblingName;
    data['siblingDivision'] = this.siblingDivision;
    data['siblingRelation'] = this.siblingRelation;
    data['studentPhotoId'] = this.studentPhotoId;
    if (this.siblingPhoto != null) {
      data['siblingPhoto'] = this.siblingPhoto!.toJson();
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
        images!.add(new Images.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['extension'] = this.extension;
    data['path'] = this.path;
    data['url'] = this.url;
    data['isTemporary'] = this.isTemporary;
    data['isDeleted'] = this.isDeleted;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['id'] = this.id;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fileId'] = this.fileId;
    data['dimension'] = this.dimension;
    data['url'] = this.url;
    data['id'] = this.id;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attendanceAsOnDate'] = this.attendanceAsOnDate;
    data['workDays'] = this.workDays;
    data['presentDays'] = this.presentDays;
    data['absentDays'] = this.absentDays;
    data['attendancePercentage'] = this.attendancePercentage;
    data['absentPercentage'] = this.absentPercentage;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['busPaidAmount'] = this.busPaidAmount;
    data['schoolPaidAmount'] = this.schoolPaidAmount;
    data['busPendingAmount'] = this.busPendingAmount;
    data['schoolPendingAmount'] = this.schoolPendingAmount;
    data['maxDate'] = this.maxDate;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['studentId'] = this.studentId;
    data['uploadedDate'] = this.uploadedDate;
    data['description'] = this.description;
    data['fileId'] = this.fileId;
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
  Null? images;
  String? createdAt;
  String? id;

  ReportcardAttachment(
      {this.name,
        this.extension,
        this.path,
        this.url,
        this.isTemporary,
        this.isDeleted,
        this.images,
        this.createdAt,
        this.id});

  ReportcardAttachment.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['extension'] = this.extension;
    data['path'] = this.path;
    data['url'] = this.url;
    data['isTemporary'] = this.isTemporary;
    data['isDeleted'] = this.isDeleted;
    data['images'] = this.images;
    data['createdAt'] = this.createdAt;
    data['id'] = this.id;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['extension'] = this.extension;
    data['path'] = this.path;
    data['url'] = this.url;
    data['isTemporary'] = this.isTemporary;
    data['isDeleted'] = this.isDeleted;
    data['images'] = this.images;
    data['createdAt'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
