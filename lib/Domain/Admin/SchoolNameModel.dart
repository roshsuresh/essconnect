class SchooNameModel {
  String? name;
  String? place;
  String? allowGPSTracking;

  SchooNameModel({this.name, this.place});

  SchooNameModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    place = json['place'];
    allowGPSTracking = json['allowGPSTracking'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['place'] = place;
    data['allowGPSTracking'] = allowGPSTracking;
    return data;
  }
}