class StudentProfileModel {
  String? studentName;
  String? admissionNo;
  String? rollNo;
  String? classc;
  String? divisionName;
  String? divisionId;
  String? bloodGroup;
  String? houseGroup;
  String? classTeacher;
  String? dob;
  String? studentPhoto;
  String? studentPhotoId;
  String? fatherPhoto;
  String? fatherPhotoId;
  String? motherPhoto;
  String? motherPhotoId;
  String? gender;
  String? height;
  String? weight;
  String? address;
  String? fatherName;
  String? fatherMailId;
  String? fatherMobileno;
  String? motherName;
  String? motherMailId;
  String? motherMobileno;
  String? area;
  bool? editProfile;
  String? guardianName;
  String? guardianMobile;
  String? guardianEmail;
  bool? bankIntegrationSettings;
  String? bankAdmissionNo;
  String? imeiNumber;
  String? busName;
  String? busStop;

  StudentProfileModel(
      {this.studentName,
        this.admissionNo,
        this.rollNo,
        this.classc,
        this.divisionName,
        this.divisionId,
        this.bloodGroup,
        this.houseGroup,
        this.classTeacher,
        this.dob,
        this.studentPhoto,
        this.studentPhotoId,
        this.fatherPhoto,
        this.fatherPhotoId,
        this.motherPhoto,
        this.motherPhotoId,
        this.gender,
        this.height,
        this.weight,
        this.address,
        this.fatherName,
        this.fatherMailId,
        this.fatherMobileno,
        this.motherName,
        this.motherMailId,
        this.motherMobileno,
        this.area,
        this.editProfile,
        this.guardianName,
        this.guardianMobile,
        this.guardianEmail,
        this.bankIntegrationSettings,
        this.bankAdmissionNo,
        this.imeiNumber,
        this.busName,
        this.busStop
      });

  StudentProfileModel.fromJson(Map<String, dynamic> json) {
    studentName = json['studentName'];
    admissionNo = json['admissionNo'];
    rollNo = json['rollNo'];
    classc = json['class'];
    divisionName = json['divisionName'];
    divisionId = json['divisionId'];
    bloodGroup = json['bloodGroup'];
    houseGroup = json['houseGroup'];
    classTeacher = json['classTeacher'];
    dob = json['dob'];
    studentPhoto = json['studentPhoto'];
    studentPhotoId = json['studentPhotoId'];
    fatherPhoto = json['fatherPhoto'];
    fatherPhotoId = json['fatherPhotoId'];
    motherPhoto = json['motherPhoto'];
    motherPhotoId = json['motherPhotoId'];
    gender = json['gender'];
    height = json['height'];
    weight = json['weight'];
    address = json['address'];
    fatherName = json['fatherName'];
    fatherMailId = json['fatherMailId'];
    fatherMobileno = json['fatherMobileno'];
    motherName = json['motherName'];
    motherMailId = json['motherMailId'];
    motherMobileno = json['motherMobileno'];
    area = json['area'];
    editProfile = json['editProfile'];
    guardianName = json['guardianName'];
    guardianMobile = json['guardianMobile'];
    guardianEmail = json['guardianEmail'];
    bankIntegrationSettings = json['bankIntegrationSettings'];
    bankAdmissionNo = json['bankAdmissionNo'];
    imeiNumber = json['imeiNumber'];
    busName = json['busName'];
    busStop = json['busStop'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['studentName'] = studentName;
    data['admissionNo'] = admissionNo;
    data['rollNo'] = rollNo;
    data['class'] = classc;
    data['divisionName'] = divisionName;
    data['divisionId'] = divisionId;
    data['bloodGroup'] = bloodGroup;
    data['houseGroup'] = houseGroup;
    data['classTeacher'] = classTeacher;
    data['dob'] = dob;
    data['studentPhoto'] = studentPhoto;
    data['studentPhotoId'] = studentPhotoId;
    data['fatherPhoto'] = fatherPhoto;
    data['fatherPhotoId'] = fatherPhotoId;
    data['motherPhoto'] = motherPhoto;
    data['motherPhotoId'] = motherPhotoId;
    data['gender'] = gender;
    data['height'] = height;
    data['weight'] = weight;
    data['address'] = address;
    data['fatherName'] = fatherName;
    data['fatherMailId'] = fatherMailId;
    data['fatherMobileno'] = fatherMobileno;
    data['motherName'] = motherName;
    data['motherMailId'] = motherMailId;
    data['motherMobileno'] = motherMobileno;
    data['area'] = area;
    data['editProfile'] = editProfile;
    data['guardianName'] = guardianName;
    data['guardianMobile'] = guardianMobile;
    data['guardianEmail'] = guardianEmail;
    data['bankIntegrationSettings'] = bankIntegrationSettings;
    data['bankAdmissionNo'] = bankAdmissionNo;
    data['imeiNumber'] = imeiNumber;
    data['busName'] = busName;
    data['busStop'] = busStop;
    return data;
  }
}
