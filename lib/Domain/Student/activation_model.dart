import 'dart:convert';

ActivationModel activationModelFromJson(String str) =>
    ActivationModel.fromJson(json.decode(str));

class ActivationModel {
  final String? subDomain;
  final String? schoolName;
  final String? logoUrl;
  final String? schoolId;

  ActivationModel({
    this.subDomain,
    this.schoolName,
    this.logoUrl,
    this.schoolId,
  });

  factory ActivationModel.fromJson(Map<String, dynamic> json) {
    return ActivationModel(
        subDomain: json['subDomain'],
        schoolName: json['schoolName'],
        logoUrl: json['logoUrl'],
        schoolId: json['schoolId']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subDomain'] = subDomain;
    data['schoolName'] = schoolName;
    data['logoUrl'] = logoUrl;
    data['schoolId'] = schoolId;
    return data;
  }
}

class ForgotPassword {
  bool? item1;
  String? item2;

  ForgotPassword({this.item1, this.item2});

  factory ForgotPassword.fromJson(Map<String, dynamic> json) {
    return ForgotPassword(item1: json['item1'], item2: json['item2']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['item1'] = item1;
    data['item2'] = item2;

    return data;
  }
}
