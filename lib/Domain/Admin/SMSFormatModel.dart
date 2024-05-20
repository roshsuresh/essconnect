class SMSfomatModel {
  String? text;
  String? value;
  bool? isApproved;

  SMSfomatModel({this.text, this.value, this.isApproved});

  SMSfomatModel.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    value = json['value'];
    isApproved = json['isApproved'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['text'] = text;
    data['value'] = value;
    data['isApproved'] = isApproved;
    return data;
  }
}

class SMSContentModel {
  String? id;
  String? name;
  String? smsBody;
  String? content;
  bool? isApproved;

  SMSContentModel(
      {this.id, this.name, this.smsBody, this.content, this.isApproved});

  SMSContentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    smsBody = json['smsBody'];
    content = json['content'];
    isApproved = json['isApproved'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['smsBody'] = smsBody;
    data['content'] = content;
    data['isApproved'] = isApproved;
    return data;
  }
}
