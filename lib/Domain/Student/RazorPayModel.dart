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
   Notes? notes;
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
    this.notes,
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
        json['prefill'] != null ? new Prefill.fromJson(json['prefill']) : null;
   notes = json['notes'] != null ? new Notes.fromJson(json['notes']) : null;
    // theme = json['theme'] != null ? new Theme.fromJson(json['theme']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['amount'] = this.amount;
    data['currency'] = this.currency;
    data['name'] = this.name;
    data['description'] = this.description;
    data['image'] = this.image;
    data['order_id'] = this.orderId;
    data['callback_url'] = this.callbackUrl;
    data['retry'] = this.retry;
    data['redirect'] = this.redirect;
    if (this.prefill != null) {
      data['prefill'] = this.prefill!.toJson();
    }
    if (this.notes != null) {
      data['notes'] = this.notes!.toJson();
    }
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['contact'] = this.contact;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['admissionNumber'] = this.admissionNumber;
    data['readableOrderid'] = this.readableOrderid;
    data['schoold'] = this.schoold;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['color'] = this.color;
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
