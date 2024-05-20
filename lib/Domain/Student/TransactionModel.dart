class TransactionModel {
  String? requestType;
  String? mid;
  String? websiteName;
  String? orderId;
  String? callbackUrl;
  TxnAmount? txnAmount;
  UserInfo? userInfo;
  bool? isStaging;
  bool? success;
  String? txnToken;

  TransactionModel(
      {this.requestType,
      this.mid,
      this.websiteName,
      this.orderId,
      this.callbackUrl,
      this.txnAmount,
      this.userInfo,
      this.isStaging,
      this.success,
      this.txnToken});

  TransactionModel.fromJson(Map<String, dynamic> json) {
    requestType = json['requestType'];
    mid = json['mid'];
    websiteName = json['websiteName'];
    orderId = json['orderId'];
    callbackUrl = json['callbackUrl'];
    txnAmount = json['txnAmount'] != null
        ? TxnAmount.fromJson(json['txnAmount'])
        : null;
    userInfo = json['userInfo'] != null
        ? UserInfo.fromJson(json['userInfo'])
        : null;
    isStaging = json['isStaging'];
    success = json['success'];
    txnToken = json['txnToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['requestType'] = requestType;
    data['mid'] = mid;
    data['websiteName'] = websiteName;
    data['orderId'] = orderId;
    data['callbackUrl'] = callbackUrl;
    if (txnAmount != null) {
      data['txnAmount'] = txnAmount!.toJson();
    }
    if (userInfo != null) {
      data['userInfo'] = userInfo!.toJson();
    }
    data['isStaging'] = isStaging;
    data['success'] = success;
    data['txnToken'] = txnToken;
    return data;
  }
}

class TxnAmount {
  String? value;
  String? currency;

  TxnAmount({this.value, this.currency});

  TxnAmount.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['currency'] = currency;
    return data;
  }
}

class UserInfo {
  String? custId;
  String? mobile;
  String? email;

  UserInfo({this.custId, this.mobile, this.email});

  UserInfo.fromJson(Map<String, dynamic> json) {
    custId = json['custId'];
    mobile = json['mobile'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['custId'] = custId;
    data['mobile'] = mobile;
    data['email'] = email;
    return data;
  }
}

//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////        payment       //////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
class PaytmFinalStatusModel {
  String? orderId;
  String? readableOrderId;
  String? reponseCode;
  String? reponseMsg;
  String? txnId;
  String? paymentMode;

  PaytmFinalStatusModel(
      {this.orderId,
      this.readableOrderId,
      this.reponseCode,
      this.reponseMsg,
      this.txnId,
      this.paymentMode});

  PaytmFinalStatusModel.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    readableOrderId = json['readableOrderId'];
    reponseCode = json['reponseCode'];
    reponseMsg = json['reponseMsg'];
    txnId = json['txnId'];
    paymentMode = json['paymentMode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['orderId'] = orderId;
    data['readableOrderId'] = readableOrderId;
    data['reponseCode'] = reponseCode;
    data['reponseMsg'] = reponseMsg;
    data['txnId'] = txnId;
    data['paymentMode'] = paymentMode;
    return data;
  }
}
