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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mobileNotificationDetId'] = this.mobileNotificationDetId;
    data['createdDate'] = this.createdDate;
    data['fromStaff'] = this.fromStaff;
    data['title'] = this.title;
    data['body'] = this.body;
    data['isSeen'] = this.isSeen;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['notificationId'] = this.notificationId;
    data['staffId'] = this.staffId;
    data['notificationEntryId'] = this.notificationEntryId;
    data['title'] = this.title;
    data['message'] = this.message;
    data['sendStaff'] = this.sendStaff;
    data['readStatus'] = this.readStatus;
    data['sentOn'] = this.sentOn;
    data['sentOnDisplay'] = this.sentOnDisplay;
    data['orderBy'] = this.orderBy;
    return data;
  }
}
