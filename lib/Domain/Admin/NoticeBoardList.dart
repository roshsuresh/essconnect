class NoticeBoardListAdmin {
  String? id;
  String? createdStaffId;
  String? createStaffName;
  String? entryDate;
  String? category;
  String? displayTo;
  String? createdAt;
  String? title;
  String? startDate;
  String? endDate;
  bool? approved;
  bool? cancelled;

  NoticeBoardListAdmin({
    this.id,
    this.createdStaffId,
    this.createStaffName,
    this.entryDate,
    this.category,
    this.displayTo,
    this.createdAt,
    this.title,
    this.startDate,
    this.endDate,
    this.approved,
    this.cancelled,
  });

  NoticeBoardListAdmin.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdStaffId = json['createdStaffId'];
    createStaffName = json['createStaffName'];
    entryDate = json['entryDate'];
    category = json['category'];
    displayTo = json['displayTo'];
    createdAt = json['createdAt'];
    title = json['title'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    approved = json['approved'];
    cancelled = json['cancelled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['createdStaffId'] = createdStaffId;
    data['createStaffName'] = createStaffName;
    data['entryDate'] = entryDate;
    data['category'] = category;
    data['displayTo'] = displayTo;
    data['createdAt'] = createdAt;
    data['title'] = title;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['approved'] = approved;
    data['cancelled'] = cancelled;

    return data;
  }
}

class NoticeBoardCategory {
  String? intlName;
  bool? isReserved;
  String? schoolId;
  String? name;
  int? sortOrder;
  bool? active;
  bool? selected;
  String? id;

  NoticeBoardCategory(
      {this.intlName,
      this.isReserved,
      this.schoolId,
      this.name,
      this.sortOrder,
      this.active,
      this.selected,
      this.id});

  NoticeBoardCategory.fromJson(Map<String, dynamic> json) {
    intlName = json['intlName'];
    isReserved = json['isReserved'];
    schoolId = json['schoolId'];
    name = json['name'];
    sortOrder = json['sortOrder'];
    active = json['active'];
    selected = json['selected'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['intlName'] = intlName;
    data['isReserved'] = isReserved;
    data['schoolId'] = schoolId;
    data['name'] = name;
    data['sortOrder'] = sortOrder;
    data['active'] = active;
    data['selected'] = selected;
    data['id'] = id;
    return data;
  }
}
