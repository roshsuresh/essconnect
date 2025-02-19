class EaseBuzzModel {
  String? accessKey;
  String? onResponse;
  String? theme;
  String? pgKeyForMobileapp;

  EaseBuzzModel({this.accessKey, this.onResponse, this.theme});

  EaseBuzzModel.fromJson(Map<String, dynamic> json) {
    accessKey = json['access_key'];
    onResponse = json['onResponse'];
    theme = json['theme'];
    pgKeyForMobileapp = json['pgKeyForMobileapp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_key'] = this.accessKey;
    data['onResponse'] = this.onResponse;
    data['theme'] = this.theme;
    data['pgKeyForMobileapp'] = this.pgKeyForMobileapp;
    return data;
  }
}
