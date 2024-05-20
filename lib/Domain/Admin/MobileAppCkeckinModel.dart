class MobileAppCheckinModel {
  bool? existapp;

  MobileAppCheckinModel({this.existapp});

  MobileAppCheckinModel.fromJson(Map<String, dynamic> json) {
    existapp = json['existapp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['existapp'] = existapp;
    return data;
  }
}
