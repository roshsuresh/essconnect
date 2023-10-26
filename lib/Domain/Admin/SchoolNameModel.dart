class SchooNameModel {
  String? name;
  String? place;

  SchooNameModel({this.name, this.place});

  SchooNameModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    place = json['place'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['place'] = this.place;
    return data;
  }
}