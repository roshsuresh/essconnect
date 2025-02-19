class ViewStudentDetails {
  String? createDate;
  String? category;
  List<FeedbackList2>? feedbackList;

  ViewStudentDetails({this.createDate, this.category, this.feedbackList});

  ViewStudentDetails.fromJson(Map<String, dynamic> json) {
    createDate = json['createDate'];
    category = json['category'];
    if (json['feedbackList'] != null) {
      feedbackList = <FeedbackList2>[];
      json['feedbackList'].forEach((v) {
        feedbackList!.add(new FeedbackList2.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createDate'] = this.createDate;
    data['category'] = this.category;
    if (this.feedbackList != null) {
      data['feedbackList'] = this.feedbackList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FeedbackList2 {
  int? slNo;
  String? matter;
  String? division;
  String? category;
  String? student;
  String? admNo;
  String? guardian;
  String? createDate;

  FeedbackList2(
      {this.slNo,
        this.matter,
        this.division,
        this.category,
        this.student,
        this.admNo,
        this.guardian,
        this.createDate});

  FeedbackList2.fromJson(Map<String, dynamic> json) {
    slNo = json['slNo'];
    matter = json['matter'];
    division = json['division'];
    category = json['category'];
    student = json['student'];
    admNo = json['admNo'];
    guardian = json['guardian'];
    createDate = json['createDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['slNo'] = this.slNo;
    data['matter'] = this.matter;
    data['division'] = this.division;
    data['category'] = this.category;
    data['student'] = this.student;
    data['admNo'] = this.admNo;
    data['guardian'] = this.guardian;
    data['createDate'] = this.createDate;
    return data;
  }
}

class Results {
  String? id;
  String? category;
  bool? active;
  int? sortOrder;
  bool? schoolSuperAdmin;
  bool? schoolHead;
  bool? systemAdmin;
  bool? classTeacher;
  Null? allowdRole;

  Results(
      {this.id,
        this.category,
        this.active,
        this.sortOrder,
        this.schoolSuperAdmin,
        this.schoolHead,
        this.systemAdmin,
        this.classTeacher,
        this.allowdRole});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    active = json['active'];
    sortOrder = json['sortOrder'];
    schoolSuperAdmin = json['schoolSuperAdmin'];
    schoolHead = json['schoolHead'];
    systemAdmin = json['systemAdmin'];
    classTeacher = json['classTeacher'];
    allowdRole = json['allowdRole'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category'] = this.category;
    data['active'] = this.active;
    data['sortOrder'] = this.sortOrder;
    data['schoolSuperAdmin'] = this.schoolSuperAdmin;
    data['schoolHead'] = this.schoolHead;
    data['systemAdmin'] = this.systemAdmin;
    data['classTeacher'] = this.classTeacher;
    data['allowdRole'] = this.allowdRole;
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