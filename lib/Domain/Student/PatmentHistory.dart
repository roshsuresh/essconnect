class OnlineFeePaymentHistoryDetails {
  int? id;
  String? billDate;
  String? paymentMode;
  String? paymentGateWay;
  String? orderNo;
  String? transactionId;
  double? billAmount;
  int? orderId;

  OnlineFeePaymentHistoryDetails(
      {this.id,
      this.billDate,
      this.paymentMode,
      this.paymentGateWay,
      this.orderNo,
      this.transactionId,
      this.billAmount,
      this.orderId});

  OnlineFeePaymentHistoryDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    billDate = json['billDate'];
    paymentMode = json['paymentMode'];
    paymentGateWay = json['paymentGateWay'];
    orderNo = json['orderNo'];
    transactionId = json['transactionId'];
    billAmount = json['billAmount'];
    orderId = json['orderId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['billDate'] = billDate;
    data['paymentMode'] = paymentMode;
    data['paymentGateWay'] = paymentGateWay;
    data['orderNo'] = orderNo;
    data['transactionId'] = transactionId;
    data['billAmount'] = billAmount;
    data['orderId'] = orderId;
    return data;
  }
}

//attachment
class FeeHistoryAttachment {
  String? name;
  String? extension;
  String? path;
  String? url;
  bool? isTemporary;
  bool? isDeleted;

  String? createdAt;
  String? id;

  FeeHistoryAttachment(
      {this.name,
      this.extension,
      this.path,
      this.url,
      this.isTemporary,
      this.isDeleted,
      this.createdAt,
      this.id});

  FeeHistoryAttachment.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    extension = json['extension'];
    path = json['path'];
    url = json['url'];
    isTemporary = json['isTemporary'];
    isDeleted = json['isDeleted'];

    createdAt = json['createdAt'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['extension'] = extension;
    data['path'] = path;
    data['url'] = url;
    data['isTemporary'] = isTemporary;
    data['isDeleted'] = isDeleted;

    data['createdAt'] = createdAt;
    data['id'] = id;
    return data;
  }
}
