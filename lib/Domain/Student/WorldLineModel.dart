class WorldLineModel {
  bool? tarCall;
  Features? features;
  ConsumerData? consumerData;

  WorldLineModel({this.tarCall, this.features, this.consumerData});

  WorldLineModel.fromJson(Map<String, dynamic> json) {
    tarCall = json['tarCall'];
    features =
        json['features'] != null ? Features.fromJson(json['features']) : null;
    consumerData = json['consumerData'] != null
        ? ConsumerData.fromJson(json['consumerData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['tarCall'] = this.tarCall;
    if (this.features != null) {
      data['features'] = this.features!.toJson();
    }
    if (this.consumerData != null) {
      data['consumerData'] = this.consumerData!.toJson();
    }
    return data;
  }
}

class Features {
  bool? showPGResponseMsg;
  bool? enableExpressPay;
  bool? enableNewWindowFlow;

  Features(
      {this.showPGResponseMsg,
      this.enableExpressPay,
      this.enableNewWindowFlow});

  Features.fromJson(Map<String, dynamic> json) {
    showPGResponseMsg = json['showPGResponseMsg'];
    enableExpressPay = json['enableExpressPay'];
    enableNewWindowFlow = json['enableNewWindowFlow'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['showPGResponseMsg'] = this.showPGResponseMsg;
    data['enableExpressPay'] = this.enableExpressPay;
    data['enableNewWindowFlow'] = this.enableNewWindowFlow;
    return data;
  }
}

class ConsumerData {
  String? deviceId;
  String? token;
  String? returnUrl;
  bool? redirectOnClose;
  String? responseHandler;
  String? paymentMode;
  String? merchantId;
  String? currency;
  String? consumerId;
  String? consumerMobileNo;
  String? consumerEmailId;
  String? txnId;
  String? cartDescription;
  List<WorldLineItemsModel>? items;
  CustomStyle? customStyle;

  ConsumerData(
      {this.deviceId,
      this.token,
      this.returnUrl,
      this.redirectOnClose,
      this.responseHandler,
      this.paymentMode,
      this.merchantId,
      this.currency,
      this.consumerId,
      this.consumerMobileNo,
      this.consumerEmailId,
      this.txnId,
      this.cartDescription,
      this.items,
      this.customStyle});

  ConsumerData.fromJson(Map<String, dynamic> json) {
    deviceId = json['deviceId'];
    token = json['token'];
    returnUrl = json['returnUrl'];
    redirectOnClose = json['redirectOnClose'];
    responseHandler = json['responseHandler'];
    paymentMode = json['paymentMode'];
    merchantId = json['merchantId'];
    currency = json['currency'];
    consumerId = json['consumerId'];
    consumerMobileNo = json['consumerMobileNo'];
    consumerEmailId = json['consumerEmailId'];
    txnId = json['txnId'];
    cartDescription = json['cartDescription'];
    if (json['items'] != null) {
      items = <WorldLineItemsModel>[];
      json['items'].forEach((v) {
        items!.add(WorldLineItemsModel.fromJson(v));
      });
    }
    customStyle = json['customStyle'] != null
        ? CustomStyle.fromJson(json['customStyle'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['deviceId'] = this.deviceId;
    data['token'] = this.token;
    data['returnUrl'] = this.returnUrl;
    data['redirectOnClose'] = this.redirectOnClose;
    data['responseHandler'] = this.responseHandler;
    data['paymentMode'] = this.paymentMode;
    data['merchantId'] = this.merchantId;
    data['currency'] = this.currency;
    data['consumerId'] = this.consumerId;
    data['consumerMobileNo'] = this.consumerMobileNo;
    data['consumerEmailId'] = this.consumerEmailId;
    data['txnId'] = this.txnId;
    data['cartDescription'] = this.cartDescription;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    if (this.customStyle != null) {
      data['customStyle'] = this.customStyle!.toJson();
    }
    return data;
  }
}

class WorldLineItemsModel {
  String? itemId;
  String? amount;
  String? comAmt;

  WorldLineItemsModel({this.itemId, this.amount, this.comAmt});

  WorldLineItemsModel.fromJson(Map<String, dynamic> json) {
    itemId = json['itemId'];
    amount = json['amount'];
    comAmt = json['comAmt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['itemId'] = this.itemId;
    data['amount'] = this.amount;
    data['comAmt'] = this.comAmt;
    return data;
  }
}

class CustomStyle {
  String? primarYCOLORCODE;
  String? secondarYCOLORCODE;
  String? buttoNCOLORCODE1;
  String? buttoNCOLORCODE2;

  CustomStyle(
      {this.primarYCOLORCODE,
      this.secondarYCOLORCODE,
      this.buttoNCOLORCODE1,
      this.buttoNCOLORCODE2});

  CustomStyle.fromJson(Map<String, dynamic> json) {
    primarYCOLORCODE = json['primarY_COLOR_CODE'];
    secondarYCOLORCODE = json['secondarY_COLOR_CODE'];
    buttoNCOLORCODE1 = json['buttoN_COLOR_CODE_1'];
    buttoNCOLORCODE2 = json['buttoN_COLOR_CODE_2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['primarY_COLOR_CODE'] = this.primarYCOLORCODE;
    data['secondarY_COLOR_CODE'] = this.secondarYCOLORCODE;
    data['buttoN_COLOR_CODE_1'] = this.buttoNCOLORCODE1;
    data['buttoN_COLOR_CODE_2'] = this.buttoNCOLORCODE2;
    return data;
  }
}
