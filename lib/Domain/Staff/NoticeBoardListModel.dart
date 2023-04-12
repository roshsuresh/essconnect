class Results {
  String? id;
  String? createdStaffId;
  Null? cancelledStaffId;
  String? createStaffName;
  String? entryDate;
  String? category;
  Null? categoryId;
  String? displayTo;
  String? createdAt;
  String? title;
  Null? role;
  Null? matter;
  Null? reason;
  String? startDate;
  String? endDate;
  bool? approved;
  bool? cancelled;
  Null? forClassTeachers;

  Results(
      {this.id,
      this.createdStaffId,
      this.cancelledStaffId,
      this.createStaffName,
      this.entryDate,
      this.category,
      this.categoryId,
      this.displayTo,
      this.createdAt,
      this.title,
      this.role,
      this.matter,
      this.reason,
      this.startDate,
      this.endDate,
      this.approved,
      this.cancelled,
      this.forClassTeachers});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdStaffId = json['createdStaffId'];
    cancelledStaffId = json['cancelledStaffId'];
    createStaffName = json['createStaffName'];
    entryDate = json['entryDate'];
    category = json['category'];
    categoryId = json['categoryId'];
    displayTo = json['displayTo'];
    createdAt = json['createdAt'];
    title = json['title'];
    role = json['role'];
    matter = json['matter'];
    reason = json['reason'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    approved = json['approved'];
    cancelled = json['cancelled'];
    forClassTeachers = json['forClassTeachers'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createdStaffId'] = this.createdStaffId;
    data['cancelledStaffId'] = this.cancelledStaffId;
    data['createStaffName'] = this.createStaffName;
    data['entryDate'] = this.entryDate;
    data['category'] = this.category;
    data['categoryId'] = this.categoryId;
    data['displayTo'] = this.displayTo;
    data['createdAt'] = this.createdAt;
    data['title'] = this.title;
    data['role'] = this.role;
    data['matter'] = this.matter;
    data['reason'] = this.reason;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['approved'] = this.approved;
    data['cancelled'] = this.cancelled;
    data['forClassTeachers'] = this.forClassTeachers;
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
