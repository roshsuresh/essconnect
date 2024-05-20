class Results {
  String? id;
  String? createdStaffId;
  String? cancelledStaffId;
  String? createStaffName;
  String? entryDate;
  String? category;
  String? categoryId;
  String? displayTo;
  String? createdAt;
  String? title;
  String? role;
  String? matter;
  String? reason;
  String? startDate;
  String? endDate;
  bool? approved;
  bool? cancelled;

  Results({
    this.id,
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
  });

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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['createdStaffId'] = createdStaffId;
    data['cancelledStaffId'] = cancelledStaffId;
    data['createStaffName'] = createStaffName;
    data['entryDate'] = entryDate;
    data['category'] = category;
    data['categoryId'] = categoryId;
    data['displayTo'] = displayTo;
    data['createdAt'] = createdAt;
    data['title'] = title;
    data['role'] = role;
    data['matter'] = matter;
    data['reason'] = reason;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['approved'] = approved;
    data['cancelled'] = cancelled;

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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['currentPage'] = currentPage;
    data['pageSize'] = pageSize;
    data['count'] = count;
    return data;
  }
}
