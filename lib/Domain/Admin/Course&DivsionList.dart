class CourseListModel {
  String? courseId;
  String? name;
  int? sectionOrder;
  int? courseOrder;

  CourseListModel(
      {this.courseId, this.name, this.sectionOrder, this.courseOrder});

  CourseListModel.fromJson(Map<String, dynamic> json) {
    courseId = json['courseId'];
    name = json['name'];
    sectionOrder = json['sectionOrder'];
    courseOrder = json['courseOrder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['courseId'] = courseId;
    data['name'] = name;
    data['sectionOrder'] = sectionOrder;
    data['courseOrder'] = courseOrder;
    return data;
  }
}

//Division

class DivisionListModel {
  String? value;
  String? text;

  DivisionListModel({
    this.value,
    this.text,
  });

  DivisionListModel.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['text'] = text;
    return data;
  }
}
