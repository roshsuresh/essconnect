class FlashnewsListAdmin {
  String? id;
  String? createdStaffId;
  String? createStaffName;
  String? createdAt;
  String? entryDate;
  String? news;
  String? startDate;
  String? endDate;
  bool? approved;
  bool? cancelled;
  bool? activeStatus;

  FlashnewsListAdmin(
      {this.id,
      this.createdStaffId,
      this.createStaffName,
      this.createdAt,
      this.entryDate,
      this.news,
      this.startDate,
      this.endDate,
      this.approved,
      this.cancelled,
      this.activeStatus});

  FlashnewsListAdmin.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdStaffId = json['createdStaffId'];
    createStaffName = json['createStaffName'];
    createdAt = json['createdAt'];
    entryDate = json['entryDate'];
    news = json['news'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    approved = json['approved'];
    cancelled = json['cancelled'];
    activeStatus = json['activeStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['createdStaffId'] = createdStaffId;
    data['createStaffName'] = createStaffName;
    data['createdAt'] = createdAt;
    data['entryDate'] = entryDate;
    data['news'] = news;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['approved'] = approved;
    data['cancelled'] = cancelled;
    data['activeStatus'] = activeStatus;
    return data;
  }
}
