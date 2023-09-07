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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['courseName'] = this.courseName;
    data['sortOrder'] = this.sortOrder;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['text'] = this.text;
    data['order'] = this.order;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['text'] = this.text;
    data['order'] = this.order;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['text'] = this.text;
    data['selected'] = this.selected;
    data['active'] = this.active;
    data['order'] = this.order;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['text'] = this.text;

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['value'] = this.value;
    data['mainSubject'] = this.mainSubject;
    data['id'] = this.id;
    data['divisionId'] = this.divisionId;
    data['isMainSub'] = this.isMainSub;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['text'] = this.text;

    return data;
  }
}
