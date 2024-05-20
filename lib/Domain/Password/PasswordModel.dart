//old password

class CkeckoldPassword {
  String? oldPasswordCorrect;

  CkeckoldPassword({this.oldPasswordCorrect});

  CkeckoldPassword.fromJson(Map<String, dynamic> json) {
    oldPasswordCorrect = json['oldPasswordCorrect'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['oldPasswordCorrect'] = oldPasswordCorrect;
    return data;
  }
}
