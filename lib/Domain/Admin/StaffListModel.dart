class StaffReportNotification {
  String? id;
  String? name;
  String? sectionId;
  String? designation;
  String? staffRole;
  String? mobileNo;
  String? emailId;
  bool? selected;

  StaffReportNotification({
    required this.id,
    required this.name,
    required this.sectionId,
    required this.designation,
    required this.staffRole,
    required this.selected,
    required this.mobileNo,
    required this.emailId
  });

  StaffReportNotification.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    sectionId = json['sectionId'];
    designation = json['designation'];
    staffRole = json['staffRole'];
    id = json['id'];
    mobileNo = json['mobileNo'];
    emailId = json['emailId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['sectionId'] = sectionId;
    data['designation'] = designation;
    data['staffRole'] = staffRole;
    data['id'] = id;
    data['mobileNo'] = mobileNo;
    data['emailId'] = emailId;

    return data;
  }
}

//SMS Format

// class SmsFormatByAdmin {
//   String? text;
//   String? value;
//   bool? isApproved;
//
//   SmsFormatByAdmin({this.text, this.value, this.isApproved});
//
//   SmsFormatByAdmin.fromJson(Map<String, dynamic> json) {
//     text = json['text'];
//     value = json['value'];
//     isApproved = json['isApproved'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['text'] = text;
//     data['value'] = value;
//     data['isApproved'] = isApproved;
//     return data;
//   }
// }

//sms formats complete view

class SmsFormatsAdminCompleteview {
  String? id;
  String? name;
  String? smsBody;

  bool? isApproved;

  SmsFormatsAdminCompleteview({this.id, this.name, this.smsBody, this.isApproved});

  SmsFormatsAdminCompleteview.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    smsBody = json['smsBody'];
    isApproved = json['isApproved'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['smsBody'] = smsBody;
    data['isApproved'] = isApproved;
    return data;
  }
}

//sms balance
class SmsBalanceStaff {
  int? count;

  SmsBalanceStaff({this.count});

  SmsBalanceStaff.fromJson(Map<String, dynamic> json) {
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    return data;
  }
}
//sms response
class SmsResultStaff {
  String? typeSend;
  int? sendFailed;
  int? sendSuccess;

  SmsResultStaff({this.typeSend, this.sendFailed, this.sendSuccess});

  SmsResultStaff.fromJson(Map<String, dynamic> json) {
    typeSend = json['typeSend'];
    sendFailed = json['sendFailed'];
    sendSuccess = json['sendSuccess'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['typeSend'] = typeSend;
    data['sendFailed'] = sendFailed;
    data['sendSuccess'] = sendSuccess;
    return data;
  }
}


