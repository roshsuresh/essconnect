class PayuHdfcModel {
  String? firstname;
  String? lastname;
  String? surl;
  String? phone;
  String? key;
  String? hash;
  String? curl;
  String? furl;
  String? txnid;
  String? productinfo;
  String? amount;
  String? email;
  String? udf1;
  String? udf2;
  String? formAction;
  String? paymentMode;
  String? salt;
  var splitRequest;

  PayuHdfcModel(
      {this.firstname,
        this.lastname,
        this.surl,
        this.phone,
        this.key,
        this.hash,
        this.curl,
        this.furl,
        this.txnid,
        this.productinfo,
        this.amount,
        this.email,
        this.udf1,
        this.udf2,
        this.formAction,
        this.paymentMode,
        this.salt,
        this.splitRequest
      });

  PayuHdfcModel.fromJson(Map<String, dynamic> json) {
    firstname = json['firstname'];
    lastname = json['lastname'];
    surl = json['surl'];
    phone = json['phone'];
    key = json['key'];
    hash = json['hash'];
    curl = json['curl'];
    furl = json['furl'];
    txnid = json['txnid'];
    productinfo = json['productinfo'];
    amount = json['amount'];
    email = json['email'];
    udf1 = json['udf1'];
    udf2 = json['udf2'];
    formAction = json['formAction'];
    paymentMode = json['paymentMode'];
    salt = json['salt'];
    splitRequest = json['splitRequest'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['surl'] = this.surl;
    data['phone'] = this.phone;
    data['key'] = this.key;
    data['hash'] = this.hash;
    data['curl'] = this.curl;
    data['furl'] = this.furl;
    data['txnid'] = this.txnid;
    data['productinfo'] = this.productinfo;
    data['amount'] = this.amount;
    data['email'] = this.email;
    data['udf1'] = this.udf1;
    data['udf2'] = this.udf2;
    data['formAction'] = this.formAction;
    data['paymentMode'] = this.paymentMode;
    data['salt'] = this.salt;
    data['splitRequest'] = this.splitRequest;
    return data;
  }
}
