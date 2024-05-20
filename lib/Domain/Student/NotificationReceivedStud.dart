class StudNotificationReceivedList {
  String? mobileNotificationDetId;
  String? createdDate;
  String? fromStaff;
  String? title;
  String? body;
  bool? isSeen;

  StudNotificationReceivedList(
      {this.mobileNotificationDetId,
      this.createdDate,
      this.fromStaff,
      this.title,
      this.body,
      this.isSeen});

  StudNotificationReceivedList.fromJson(Map<String, dynamic> json) {
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

class NotificationListModel {
  String? notificationId;
  String? staffId;
  String? notificationEntryId;
  String? title;
  String? message;
  String? sendStaff;
  bool? readStatus;
  String? sentOn;
  String? sentOnDisplay;
  double? orderBy;

  NotificationListModel(
      {this.notificationId,
      this.staffId,
      this.notificationEntryId,
      this.title,
      this.message,
      this.sendStaff,
      this.readStatus,
      this.sentOn,
      this.sentOnDisplay,
      this.orderBy});

  NotificationListModel.fromJson(Map<String, dynamic> json) {
    notificationId = json['notificationId'];
    staffId = json['staffId'];
    notificationEntryId = json['notificationEntryId'];
    title = json['title'];
    message = json['message'];
    sendStaff = json['sendStaff'];
    readStatus = json['readStatus'];
    sentOn = json['sentOn'];
    sentOnDisplay = json['sentOnDisplay'];
    orderBy = json['orderBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['notificationId'] = notificationId;
    data['staffId'] = staffId;
    data['notificationEntryId'] = notificationEntryId;
    data['title'] = title;
    data['message'] = message;
    data['sendStaff'] = sendStaff;
    data['readStatus'] = readStatus;
    data['sentOn'] = sentOn;
    data['sentOnDisplay'] = sentOnDisplay;
    data['orderBy'] = orderBy;
    return data;
  }
}
