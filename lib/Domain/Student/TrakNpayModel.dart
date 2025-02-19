class TrackNPayModel {
  String? apiKey;
  String? country;
  String? name;
  String? orderId;
  String? addressLine2;
  String? addressLine1;
  String? returnUrlCancel;
  String? hash;
  String? udf1;
  String? zipCode;
  String? description;
  String? city;
  String? currency;
  String? email;
  String? formActionUrl;
  String? udf2;
  String? udf4;
  String? amount;
  String? returnUrlFailure;
  String? mode;
  String? state;
  String? udf5;
  String? returnUrl;
  String? udf3;
  String? phone;
  String? salt;
  var split_info;

  TrackNPayModel(
      {this.apiKey,
        this.country,
        this.name,
        this.orderId,
        this.addressLine2,
        this.addressLine1,
        this.returnUrlCancel,
        this.hash,
        this.udf1,
        this.zipCode,
        this.description,
        this.city,
        this.currency,
        this.email,
        this.formActionUrl,
        this.udf2,
        this.udf4,
        this.amount,
        this.returnUrlFailure,
        this.mode,
        this.state,
        this.udf5,
        this.returnUrl,
        this.udf3,
        this.phone,
        this.salt,
      this.split_info});

  TrackNPayModel.fromJson(Map<String, dynamic> json) {
    apiKey = json['api_key'];
    country = json['country'];
    name = json['name'];
    orderId = json['order_id'];
    addressLine2 = json['address_line_2'];
    addressLine1 = json['address_line_1'];
    returnUrlCancel = json['return_url_cancel'];
    hash = json['hash'];
    udf1 = json['udf1'];
    zipCode = json['zip_code'];
    description = json['description'];
    city = json['city'];
    currency = json['currency'];
    email = json['email'];
    formActionUrl = json['formActionUrl'];
    udf2 = json['udf2'];
    udf4 = json['udf4'];
    amount = json['amount'];
    returnUrlFailure = json['return_url_failure'];
    mode = json['mode'];
    state = json['state'];
    udf5 = json['udf5'];
    returnUrl = json['return_url'];
    udf3 = json['udf3'];
    phone = json['phone'];
    salt = json['salt'];
    split_info = json['split_info'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['api_key'] = this.apiKey;
    data['country'] = this.country;
    data['name'] = this.name;
    data['order_id'] = this.orderId;
    data['address_line_2'] = this.addressLine2;
    data['address_line_1'] = this.addressLine1;
    data['return_url_cancel'] = this.returnUrlCancel;
    data['hash'] = this.hash;
    data['udf1'] = this.udf1;
    data['zip_code'] = this.zipCode;
    data['description'] = this.description;
    data['city'] = this.city;
    data['currency'] = this.currency;
    data['email'] = this.email;
    data['formActionUrl'] = this.formActionUrl;
    data['udf2'] = this.udf2;
    data['udf4'] = this.udf4;
    data['amount'] = this.amount;
    data['return_url_failure'] = this.returnUrlFailure;
    data['mode'] = this.mode;
    data['state'] = this.state;
    data['udf5'] = this.udf5;
    data['return_url'] = this.returnUrl;
    data['udf3'] = this.udf3;
    data['phone'] = this.phone;
    data['salt'] = this.salt;
    data['split_info'] = this.split_info;
    return data;
  }
}