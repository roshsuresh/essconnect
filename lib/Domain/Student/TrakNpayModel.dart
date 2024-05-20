class TrackNPayModel {
  String? orderId;
  String? addressLine1;
  String? city;
  String? udf5;
  String? state;
  String? udf4;
  String? phone;
  String? zipCode;
  String? currency;
  String? returnUrlFailure;
  String? hash;
  String? returnUrlCancel;
  String? email;
  String? country;
  String? mode;
  String? salt;
  String? amount;
  String? name;
  String? apiKey;
  String? udf3;
  String? udf2;
  String? returnUrl;
  String? description;
  String? udf1;
  String? addressLine2;

  TrackNPayModel(
      {this.orderId,
      this.addressLine1,
      this.city,
      this.udf5,
      this.state,
      this.udf4,
      this.phone,
      this.zipCode,
      this.currency,
      this.returnUrlFailure,
      this.hash,
      this.returnUrlCancel,
      this.email,
      this.country,
      this.mode,
      this.salt,
      this.amount,
      this.name,
      this.apiKey,
      this.udf3,
      this.udf2,
      this.returnUrl,
      this.description,
      this.udf1,
      this.addressLine2});

  TrackNPayModel.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    addressLine1 = json['address_line_1'];
    city = json['city'];
    udf5 = json['udf5'];
    state = json['state'];
    udf4 = json['udf4'];
    phone = json['phone'];
    zipCode = json['zip_code'];
    currency = json['currency'];
    returnUrlFailure = json['return_url_failure'];
    hash = json['hash'];
    returnUrlCancel = json['return_url_cancel'];
    email = json['email'];
    country = json['country'];
    mode = json['mode'];
    salt = json['salt'];
    amount = json['amount'];
    name = json['name'];
    apiKey = json['api_key'];
    udf3 = json['udf3'];
    udf2 = json['udf2'];
    returnUrl = json['return_url'];
    description = json['description'];
    udf1 = json['udf1'];
    addressLine2 = json['address_line_2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_id'] = orderId;
    data['address_line_1'] = addressLine1;
    data['city'] = city;
    data['udf5'] = udf5;
    data['state'] = state;
    data['udf4'] = udf4;
    data['phone'] = phone;
    data['zip_code'] = zipCode;
    data['currency'] = currency;
    data['return_url_failure'] = returnUrlFailure;
    data['hash'] = hash;
    data['return_url_cancel'] = returnUrlCancel;
    data['email'] = email;
    data['country'] = country;
    data['mode'] = mode;
    data['salt'] = salt;
    data['amount'] = amount;
    data['name'] = name;
    data['api_key'] = apiKey;
    data['udf3'] = udf3;
    data['udf2'] = udf2;
    data['return_url'] = returnUrl;
    data['description'] = description;
    data['udf1'] = udf1;
    data['address_line_2'] = addressLine2;
    return data;
  }
}
