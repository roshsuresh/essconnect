class SchooNameModel {
  String? name;
  String? place;

  SchooNameModel({this.name, this.place});

  SchooNameModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    place = json['place'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['place'] = place;
    return data;
  }
}