class CourseListMissingReport {
  String? id;
  String? courseName;
  int? sortOrder;

  CourseListMissingReport({this.id, this.courseName, this.sortOrder});

  CourseListMissingReport.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseName = json['courseName'];
    sortOrder = json['sortOrder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['courseName'] = courseName;
    data['sortOrder'] = sortOrder;
    return data;
  }
}

//Division

class DivisionListReport {
  String? value;
  String? text;
  int? order;

  DivisionListReport({this.value, this.text, this.order});

  DivisionListReport.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    text = json['text'];
    order = json['order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['text'] = text;
    data['order'] = order;
    return data;
  }
}

//PartList

class PartListReport {
  String? value;
  String? text;
  int? order;

  PartListReport({this.value, this.text, this.order});

  PartListReport.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    text = json['text'];
    order = json['order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['text'] = text;
    data['order'] = order;
    return data;
  }
}

//PART

class PartList {
  String? value;
  String? text;
  bool? selected;
  bool? active;
  int? order;

  PartList({this.value, this.text, this.selected, this.active, this.order});

  PartList.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    text = json['text'];
    selected = json['selected'];
    active = json['active'];
    order = json['order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['text'] = text;
    data['selected'] = selected;
    data['active'] = active;
    data['order'] = order;
    return data;
  }
}

//Exam

class ExamsListReport {
  String? value;
  String? text;

  ExamsListReport({
    this.value,
    this.text,
  });

  ExamsListReport.fromJson(Map<String, dynamic> json) {
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

//SubjectListModel

class SubjectListModel {
  String? text;
  String? value;
  String? mainSubject;
  int? id;
  String? divisionId;
  bool? isMainSub;

  SubjectListModel(
      {this.text,
      this.value,
      this.mainSubject,
      this.id,
      this.divisionId,
      this.isMainSub});

  SubjectListModel.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    value = json['value'];
    mainSubject = json['mainSubject'];
    id = json['id'];
    divisionId = json['divisionId'];
    isMainSub = json['isMainSub'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['text'] = text;
    data['value'] = value;
    data['mainSubject'] = mainSubject;
    data['id'] = id;
    data['divisionId'] = divisionId;
    data['isMainSub'] = isMainSub;
    return data;
  }
}

//UsersListModel

class UsersListModel {
  String? value;
  String? text;

  UsersListModel({
    this.value,
    this.text,
  });

  UsersListModel.fromJson(Map<String, dynamic> json) {
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
