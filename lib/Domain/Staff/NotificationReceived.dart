class StaffNotificationReceivedModel {
  String? mobileNotificationDetId;
  String? createdDate;
  String? fromStaff;
  String? title;
  String? body;
  bool? isSeen;

  StaffNotificationReceivedModel(
      {this.mobileNotificationDetId,
      this.createdDate,
      this.fromStaff,
      this.title,
      this.body,
      this.isSeen});

  StaffNotificationReceivedModel.fromJson(Map<String, dynamic> json) {
    mobileNotificationDetId = json['mobileNotificationDetId'];
    createdDate = json['createdDate'];
    fromStaff = json['fromStaff'];
    title = json['title'];
    body = json['body'];
    isSeen = json['isSeen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mobileNotificationDetId'] = mobileNotificationDetId;
    data['createdDate'] = createdDate;
    data['fromStaff'] = fromStaff;
    data['title'] = title;
    data['body'] = body;
    data['isSeen'] = isSeen;
    return data;
  }
}
