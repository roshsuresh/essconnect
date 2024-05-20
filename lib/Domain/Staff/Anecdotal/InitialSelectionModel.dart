class SectionsModel {
  String? id;
  String? name;

  SectionsModel({this.id, this.name});

  SectionsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

// category

class CategorySubjectModel {
  String? value;
  String? text;

  CategorySubjectModel({this.value, this.text});

  CategorySubjectModel.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = this.value;
    data['text'] = this.text;
    return data;
  }
}
