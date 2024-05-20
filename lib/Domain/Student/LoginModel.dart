class LoginModel {
  LoginModel({
    required this.accessToken,
  });

  String accessToken;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        accessToken: json["access_token"],
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
      };
}

//App review

class GetUserMobielViewId {
  String? viewId;

  GetUserMobielViewId({this.viewId});

  GetUserMobielViewId.fromJson(Map<String, dynamic> json) {
    viewId = json['viewId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['viewId'] = this.viewId;
    return data;
  }
}