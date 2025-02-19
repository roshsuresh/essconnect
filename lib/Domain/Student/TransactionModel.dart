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
//Smrtgateway


class SmartGatewayModel {
  String? smartgatewayurl;
  String? smartgatewayRequest;

  SmartGatewayModel({this.smartgatewayurl, this.smartgatewayRequest});

  SmartGatewayModel.fromJson(Map<String, dynamic> json) {
    smartgatewayurl = json['smartgatewayurl'];
    smartgatewayRequest = json['smartgatewayRequest'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['smartgatewayurl'] = smartgatewayurl;
    data['smartgatewayRequest'] = smartgatewayRequest;
    return data;
  }
}



class SdkPayload {
  String? requestId;
  String? service;
  Payload? payload;
  String? expiry;

  SdkPayload({this.requestId, this.service, this.payload, this.expiry});

  SdkPayload.fromJson(Map<String, dynamic> json) {
    requestId = json['requestId'];
    service = json['service'];
    payload =
    json['payload'] != null ? Payload.fromJson(json['payload']) : null;
    expiry = json['expiry'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['requestId'] = requestId;
    data['service'] = service;
    if (payload != null) {
      data['payload'] = payload!.toJson();
    }
    data['expiry'] = expiry;
    return data;
  }
}

class Payload {
  bool? collectAvsInfo;
  String? clientId;
  String? amount;
  String? merchantId;
  String? clientAuthToken;
  String? udf2;
  String? service;
  String? clientAuthTokenExpiry;
  String? environment;
  String? lastName;
  String? action;
  String? udf1;
  String? customerId;
  String? returnUrl;
  String? currency;
  String? firstName;
  String? customerPhone;
  String? customerEmail;
  String? orderId;
  String? description;
  String? displayBusinessAs;

  Payload(
      {this.collectAvsInfo,
        this.clientId,
        this.amount,
        this.merchantId,
        this.clientAuthToken,
        this.udf2,
        this.service,
        this.clientAuthTokenExpiry,
        this.environment,
        this.lastName,
        this.action,
        this.udf1,
        this.customerId,
        this.returnUrl,
        this.currency,
        this.firstName,
        this.customerPhone,
        this.customerEmail,
        this.orderId,
        this.description,
        this.displayBusinessAs});

  Payload.fromJson(Map<String, dynamic> json) {
    collectAvsInfo = json['collectAvsInfo'];
    clientId = json['clientId'];
    amount = json['amount'];
    merchantId = json['merchantId'];
    clientAuthToken = json['clientAuthToken'];
    udf2 = json['udf2'];
    service = json['service'];
    clientAuthTokenExpiry = json['clientAuthTokenExpiry'];
    environment = json['environment'];
    lastName = json['lastName'];
    action = json['action'];
    udf1 = json['udf1'];
    customerId = json['customerId'];
    returnUrl = json['returnUrl'];
    currency = json['currency'];
    firstName = json['firstName'];
    customerPhone = json['customerPhone'];
    customerEmail = json['customerEmail'];
    orderId = json['orderId'];
    description = json['description'];
    displayBusinessAs = json['displayBusinessAs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['collectAvsInfo'] = collectAvsInfo;
    data['clientId'] = clientId;
    data['amount'] = amount;
    data['merchantId'] = merchantId;
    data['clientAuthToken'] = clientAuthToken;
    data['udf2'] = udf2;
    data['service'] = service;
    data['clientAuthTokenExpiry'] = clientAuthTokenExpiry;
    data['environment'] = environment;
    data['lastName'] = lastName;
    data['action'] = action;
    data['udf1'] = udf1;
    data['customerId'] = customerId;
    data['returnUrl'] = returnUrl;
    data['currency'] = currency;
    data['firstName'] = firstName;
    data['customerPhone'] = customerPhone;
    data['customerEmail'] = customerEmail;
    data['orderId'] = orderId;
    data['description'] = description;
    data['displayBusinessAs'] = displayBusinessAs;
    return data;
  }
}

//Smarttt Response

class SmartFinalStatus {
  String? orderId;
  String? readableOrderId;
  String? reponseCode;
  String? reponseMsg;
  String? dbstatus;
  String? txnId;
  String? paymentMode;

  SmartFinalStatus(
      {this.orderId,
        this.readableOrderId,
        this.reponseCode,
        this.reponseMsg,
        this.txnId,
        this.paymentMode});

  SmartFinalStatus.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    readableOrderId = json['readableOrderId'];
    reponseCode = json['reponseCode'];
    reponseMsg = json['reponseMsg'];
    dbstatus = json['dbstatus'];
    txnId = json['txnId'];
    paymentMode = json['paymentMode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['orderId'] = orderId;
    data['readableOrderId'] = readableOrderId;
    data['reponseCode'] = reponseCode;
    data['reponseMsg'] = reponseMsg;
    data['dbstatus'] = dbstatus;
    data['txnId'] = txnId;
    data['paymentMode'] = paymentMode;
    return data;
  }
}

//BillDesk Status///
///////////////////

class BillDeskResponse {
  String? orderId;
  String? readableOrderId;
  String? reponseCode;
  String? reponseMsg;
  String? txnId;
  String? paymentMode;

  BillDeskResponse(
      {this.orderId,
        this.readableOrderId,
        this.reponseCode,
        this.reponseMsg,
        this.txnId,
        this.paymentMode});

  BillDeskResponse.fromJson(Map<String, dynamic> json) {
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
//TraknPaya ststus
class TrakNPatStatus {
  String? orderId;
  String? readableOrderId;
  String? reponseCode;
  String? reponseMsg;
  String? txnId;
  String? paymentMode;

  TrakNPatStatus(
      {this.orderId,
        this.readableOrderId,
        this.reponseCode,
        this.reponseMsg,
        this.txnId,
        this.paymentMode});

  TrakNPatStatus.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    readableOrderId = json['readableOrderId'];
    reponseCode = json['reponseCode'];
    reponseMsg = json['reponseMsg'];
    txnId = json['txnId'];
    paymentMode = json['paymentMode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderId'] = this.orderId;
    data['readableOrderId'] = this.readableOrderId;
    data['reponseCode'] = this.reponseCode;
    data['reponseMsg'] = this.reponseMsg;
    data['txnId'] = this.txnId;
    data['paymentMode'] = this.paymentMode;
    return data;
  }
}

//EaseBuzz Status

class EaseBuzzResponse {
  String? orderId;
  String? readableOrderId;
  String? reponseCode;
  String? reponseMsg;
  String? txnId;
  String? paymentMode;

  EaseBuzzResponse(
      {this.orderId,
        this.readableOrderId,
        this.reponseCode,
        this.reponseMsg,
        this.txnId,
        this.paymentMode});

  EaseBuzzResponse.fromJson(Map<String, dynamic> json) {
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