class RazorPayModel {
  String? key;
  String? amount;
  String? currency;
  String? name;
  String? description;
  String? image;
  String? orderId;
  String? callbackUrl;
  bool? retry;
  bool? redirect;
  Prefill? prefill;
  // Notes? notes;
  // Theme? theme;

  RazorPayModel({
    this.key,
    this.amount,
    this.currency,
    this.name,
    this.description,
    this.image,
    this.orderId,
    this.callbackUrl,
    this.retry,
    this.redirect,
    this.prefill,
    // this.notes,
    // this.theme
  });

  RazorPayModel.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    amount = json['amount'];
    currency = json['currency'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    orderId = json['order_id'];
    callbackUrl = json['callback_url'];
    retry = json['retry'];
    redirect = json['redirect'];
    prefill =
        json['prefill'] != null ? Prefill.fromJson(json['prefill']) : null;
    // notes = json['notes'] != null ? new Notes.fromJson(json['notes']) : null;
    // theme = json['theme'] != null ? new Theme.fromJson(json['theme']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['key'] = key;
    data['amount'] = amount;
    data['currency'] = currency;
    data['name'] = name;
    data['description'] = description;
    data['image'] = image;
    data['order_id'] = orderId;
    data['callback_url'] = callbackUrl;
    data['retry'] = retry;
    data['redirect'] = redirect;
    if (prefill != null) {
      data['prefill'] = prefill!.toJson();
    }
    // if (this.notes != null) {
    //   data['notes'] = this.notes!.toJson();
    // }
    // if (this.theme != null) {
    //   data['theme'] = this.theme!.toJson();
    // }
    return data;
  }
}

class Prefill {
  String? name;
  String? email;
  String? contact;

  Prefill({this.name, this.email, this.contact});

  Prefill.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    contact = json['contact'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['contact'] = contact;
    return data;
  }
}

class Notes {
  String? admissionNumber;
  String? readableOrderid;
  String? schoold;

  Notes({this.admissionNumber, this.readableOrderid, this.schoold});

  Notes.fromJson(Map<String, dynamic> json) {
    admissionNumber = json['admissionNumber'];
    readableOrderid = json['readableOrderid'];
    schoold = json['schoold'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['admissionNumber'] = admissionNumber;
    data['readableOrderid'] = readableOrderid;
    data['schoold'] = schoold;
    return data;
  }
}

class Theme {
  String? color;

  Theme({this.color});

  Theme.fromJson(Map<String, dynamic> json) {
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['color'] = color;
    return data;
  }
}

/////////////         Razorpay status

class RazorpayFinalStatus {
  String? orderId;
  String? readableOrderId;
  String? reponseCode;
  String? reponseMsg;
  String? txnId;
  String? paymentMode;

  RazorpayFinalStatus(
      {this.orderId,
      this.readableOrderId,
      this.reponseCode,
      this.reponseMsg,
      this.txnId,
      this.paymentMode});

  RazorpayFinalStatus.fromJson(Map<String, dynamic> json) {
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
