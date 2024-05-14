class StudentViewAnecdotalModel {
  String? id;
  String? admNo;
  String? name;
  String? division;
  String? divisionId;
  String? courseId;
  String? rollNo;
  String? guardianId;
  String? guardianMobile;
  String? guardianName;
  String? relationId;
  bool? selected;

  StudentViewAnecdotalModel(
      {this.id,
      this.admNo,
      this.name,
      this.division,
      this.divisionId,
      this.courseId,
      this.rollNo,
      this.guardianId,
      this.guardianMobile,
      this.guardianName,
      this.relationId});

  StudentViewAnecdotalModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    admNo = json['admNo'];
    name = json['name'];
    division = json['division'];
    divisionId = json['divisionId'];
    courseId = json['courseId'];
    rollNo = json['rollNo'];
    guardianId = json['guardianId'];
    guardianMobile = json['guardianMobile'];
    guardianName = json['guardianName'];
    relationId = json['relationId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['admNo'] = admNo;
    data['name'] = name;
    data['division'] = division;
    data['divisionId'] = divisionId;
    data['courseId'] = courseId;
    data['rollNo'] = rollNo;
    data['guardianId'] = guardianId;
    data['guardianMobile'] = guardianMobile;
    data['guardianName'] = guardianName;
    data['relationId'] = relationId;
    return data;
  }
}

class PaginationStudentView {
  int? currentPage;
  int? pageSize;
  int? count;

  PaginationStudentView({this.currentPage, this.pageSize, this.count});

  PaginationStudentView.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    pageSize = json['pageSize'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['currentPage'] = currentPage;
    data['pageSize'] = pageSize;
    data['count'] = count;
    return data;
  }
}
//Staff List

class StaffList {
  String? id;
  String? name;
  String? mobile;
  String? email;
  String? section;
  String? designation;
  String? gender;
  String? staffCode;
  bool? selected;

  StaffList(
      {this.id,
        this.name,
        this.mobile,
        this.email,
        this.section,
        this.designation,
        this.gender,
        this.staffCode,
       this.selected
      });

  StaffList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    email = json['email'];
    section = json['section'];
    designation = json['designation'];
    gender = json['gender'];
    staffCode = json['staffCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['section'] = this.section;
    data['designation'] = this.designation;
    data['gender'] = this.gender;
    data['staffCode'] = this.staffCode;
    return data;
  }
}
//pagination staff

class PaginationStaffView {
  int? currentPage;
  int? pageSize;
  int? count;

  PaginationStaffView({this.currentPage, this.pageSize, this.count});

  PaginationStaffView.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    pageSize = json['pageSize'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['currentPage'] = currentPage;
    data['pageSize'] = pageSize;
    data['count'] = count;
    return data;
  }
}
class Pagination {
  int? currentPage;
  int? pageSize;
  int? count;

  Pagination({this.currentPage, this.pageSize, this.count});

  Pagination.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    pageSize = json['pageSize'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currentPage'] = this.currentPage;
    data['pageSize'] = this.pageSize;
    data['count'] = this.count;
    return data;
  }
}

//AnedDotalEdit

class UpdateRow {
  String? studId;
  String? categoryId;
  String? subject;
  String? staffId;
  String? createStaffId;
  String? createdDate;
  String? date;
  String? time;
  String? remarks;
  String? name;
  String? admissionNo;
  bool? isImportantEntry;
  bool? showGuardianLogin;
  String? studentName;
  String? category;
  String? subjectName;
  String? staffName;

  UpdateRow(
      {this.studId,
        this.categoryId,
        this.subject,
        this.staffId,
        this.createStaffId,
        this.createdDate,
        this.date,
        this.time,
        this.remarks,
        this.name,
        this.admissionNo,
        this.isImportantEntry,
        this.showGuardianLogin,
        this.studentName,
        this.category,
        this.subjectName,
        this.staffName
      });

  UpdateRow.fromJson(Map<String, dynamic> json) {
    studId = json['studId'];
    categoryId = json['categoryId'];
    subject = json['subject'];
    staffId = json['staffId'];
    createStaffId = json['createStaffId'];
    createdDate = json['createdDate'];
    date = json['date'];
    time = json['time'];
    remarks = json['remarks'];
    name = json['name'];
    admissionNo = json['admissionNo'];
    isImportantEntry = json['isImportantEntry'];
    showGuardianLogin = json['showGuardianLogin'];
    studentName = json['studentName'];
    category = json['category'];
    subjectName = json['subjectName'];
    staffName = json['staffName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['studId'] = this.studId;
    data['categoryId'] = this.categoryId;
    data['subject'] = this.subject;
    data['staffId'] = this.staffId;
    data['createStaffId'] = this.createStaffId;
    data['createdDate'] = this.createdDate;
    data['date'] = this.date;
    data['time'] = this.time;
    data['remarks'] = this.remarks;
    data['name'] = this.name;
    data['admissionNo'] = this.admissionNo;
    data['isImportantEntry'] = this.isImportantEntry;
    data['showGuardianLogin'] = this.showGuardianLogin;
    data['studentName'] = this.studentName;
    data['category'] = this.category;
    data['subjectName'] = this.subjectName;
    data['staffName'] = this.staffName;
    return data;
  }
}
  //Report


class Results {
  DateTime? date;
  String? totalCount;
  List<DiaryList> diaryList;

  Results({this.date, this.totalCount, required this.diaryList});

  factory Results.fromJson(Map<String, dynamic> json) {
    return Results(
      date: DateTime.parse(json['date']),
      diaryList: List<DiaryList>.from(
          json['diaryList'].map((entry) => DiaryList.fromJson(entry))),
    );
  }


}

class DiaryList {
  int? slNo;
  String? studentId;
  String? categoryId;
  String? subjectId;
  int? divisionOrder;
  int? courseOrder;
  int? sectionOrder;
  String? date;
  int? rollNo;
  String? admNo;
  String? name;
  String? guardianName;
  String? admissionNo;
  String? division;
  String? course;
  String? remarksCategory;
  String? subject;
  bool? isImportant;
  String? remarksBy;
  String? createdBy;
  String? remarks;

  DiaryList(
      {this.slNo,
        this.studentId,
        this.categoryId,
        this.subjectId,
        this.divisionOrder,
        this.courseOrder,
        this.sectionOrder,
        this.date,
        this.rollNo,
        this.admNo,
        this.name,
        this.guardianName,
        this.admissionNo,
        this.division,
        this.course,
        this.remarksCategory,
        this.subject,
        this.isImportant,
        this.remarksBy,
        this.createdBy,
        this.remarks});

  DiaryList.fromJson(Map<String, dynamic> json) {
    slNo = json['slNo'];
    studentId = json['studentId'];
    categoryId = json['categoryId'];
    subjectId = json['subjectId'];
    divisionOrder = json['divisionOrder'];
    courseOrder = json['courseOrder'];
    sectionOrder = json['sectionOrder'];
    date = json['date'];
    rollNo = json['rollNo'];
    admNo = json['admNo'];
    name = json['name'];
    guardianName = json['guardianName'];
    admissionNo = json['admissionNo'];
    division = json['division'];
    course = json['course'];
    remarksCategory = json['remarksCategory'];
    subject = json['subject'];
    isImportant = json['isImportant'];
    remarksBy = json['remarksBy'];
    createdBy = json['createdBy'];
    remarks = json['remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['slNo'] = this.slNo;
    data['studentId'] = this.studentId;
    data['categoryId'] = this.categoryId;
    data['subjectId'] = this.subjectId;
    data['divisionOrder'] = this.divisionOrder;
    data['courseOrder'] = this.courseOrder;
    data['sectionOrder'] = this.sectionOrder;
    data['date'] = this.date;
    data['rollNo'] = this.rollNo;
    data['admNo'] = this.admNo;
    data['name'] = this.name;
    data['guardianName'] = this.guardianName;
    data['admissionNo'] = this.admissionNo;
    data['division'] = this.division;
    data['course'] = this.course;
    data['remarksCategory'] = this.remarksCategory;
    data['subject'] = this.subject;
    data['isImportant'] = this.isImportant;
    data['remarksBy'] = this.remarksBy;
    data['createdBy'] = this.createdBy;
    data['remarks'] = this.remarks;
    return data;
  }
}
class PaginationReport {
  int? currentPage;
  int? pageSize;
  int? count;

  PaginationReport({this.currentPage, this.pageSize, this.count});

  PaginationReport.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    pageSize = json['pageSize'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currentPage'] = this.currentPage;
    data['pageSize'] = this.pageSize;
    data['count'] = this.count;
    return data;
  }
}

//category

class AnecdotalCategory {
  String? schoolId;
  String? name;
  int? sortOrder;
  bool? active;
  String? id;

  AnecdotalCategory(
      {this.schoolId, this.name, this.sortOrder, this.active, this.id});

  AnecdotalCategory.fromJson(Map<String, dynamic> json) {
    schoolId = json['schoolId'];
    name = json['name'];
    sortOrder = json['sortOrder'];
    active = json['active'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['schoolId'] = this.schoolId;
    data['name'] = this.name;
    data['sortOrder'] = this.sortOrder;
    data['active'] = this.active;
    data['id'] = this.id;
    return data;
  }
}

class AnecdotalSubjects {
  String? schoolId;
  String? name;
  int? sortOrder;
  bool? active;
  String? id;

  AnecdotalSubjects(
      {this.schoolId, this.name, this.sortOrder, this.active, this.id});

  AnecdotalSubjects.fromJson(Map<String, dynamic> json) {
    schoolId = json['schoolId'];
    name = json['name'];
    sortOrder = json['sortOrder'];
    active = json['active'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['schoolId'] = this.schoolId;
    data['name'] = this.name;
    data['sortOrder'] = this.sortOrder;
    data['active'] = this.active;
    data['id'] = this.id;
    return data;
  }
}