class MarkEntryViewModel {
  List<MarkEntryInitialValues>? courseList;
  bool? isLocked;
  String? code;

  MarkEntryViewModel({this.courseList, this.isLocked, this.code});

  MarkEntryViewModel.fromJson(Map<String, dynamic> json) {
    if (json['courseList'] != null) {
      courseList = <MarkEntryInitialValues>[];
      json['courseList'].forEach((v) {
        courseList!.add(MarkEntryInitialValues.fromJson(v));
      });
    }
    isLocked = json['isLocked'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (courseList != null) {
      data['courseList'] = courseList!.map((v) => v.toJson()).toList();
    }
    data['isLocked'] = isLocked;
    data['code'] = code;
    return data;
  }
}

class MarkEntryInitialValues {
  String? id;
  String? courseName;
  int? sortOrder;

  MarkEntryInitialValues({
    this.id,
    this.courseName,
    this.sortOrder,
  });

  MarkEntryInitialValues.fromJson(Map<String, dynamic> json) {
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

class MarkEntryDivisionInitailModel {
  String? typeCode;
  List<MarkEntryDivisionList>? divisionList;

  MarkEntryDivisionInitailModel({this.typeCode, this.divisionList});

  MarkEntryDivisionInitailModel.fromJson(Map<String, dynamic> json) {
    typeCode = json['typeCode'];
    if (json['divisionList'] != null) {
      divisionList = <MarkEntryDivisionList>[];
      json['divisionList'].forEach((v) {
        divisionList!.add(MarkEntryDivisionList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['typeCode'] = typeCode;
    if (divisionList != null) {
      data['divisionList'] = divisionList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MarkEntryDivisionList {
  String? typeCode;
  String? value;
  String? text;
  int? order;

  MarkEntryDivisionList({this.typeCode,this.value, this.text, this.order});

  MarkEntryDivisionList.fromJson(Map<String, dynamic> json) {
    typeCode =json['typeCode'];
    value = json['value'];
    text = json['text'];
    order = json['order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['typeCode'] = typeCode;
    data['value'] = value;
    data['text'] = text;
    data['order'] = order;
    return data;
  }
}

class MarkEntryPartList {
  String? typeCode;
  String? value;
  String? text;
  String? selected;
  String? active;
  int? order;

  MarkEntryPartList(
      {this.typeCode,this.value, this.text, this.selected, this.active, this.order});

  MarkEntryPartList.fromJson(Map<String, dynamic> json) {
    typeCode = json['typeCode'];
    value = json['value'];
    text = json['text'];
    selected = json['selected'];
    active = json['active'];
    order = json['order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['typeCode'] = typeCode;
    data['value'] = value;
    data['text'] = text;
    data['selected'] = selected;
    data['active'] = active;
    data['order'] = order;
    return data;
  }
}

class MarkEntrySubjectList {
  String? value;
  String? text;

  MarkEntrySubjectList({
    this.value,
    this.text,
  });

  MarkEntrySubjectList.fromJson(Map<String, dynamic> json) {
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

class MarkEntryOptionSubjectModel {
  String? id;
  String? subjectName;
  String? subjectDescription;

  MarkEntryOptionSubjectModel(
      {this.id, this.subjectName, this.subjectDescription});

  MarkEntryOptionSubjectModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subjectName = json['subjectName'];
    subjectDescription = json['subjectDescription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['subjectName'] = subjectName;
    data['subjectDescription'] = subjectDescription;
    return data;
  }
}

class MarkEntryExamList {
  String? value;
  String? text;

  MarkEntryExamList({this.value, this.text});

  MarkEntryExamList.fromJson(Map<String, dynamic> json) {
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


//Print verified document

class PrintDocument {
  String? name;
  String? extension;
  String? path;
  String? url;
  bool? isTemporary;
  bool? isDeleted;
  String? images;
  String? createdAt;
  String? id;

  PrintDocument(
      {this.name,
        this.extension,
        this.path,
        this.url,
        this.isTemporary,
        this.isDeleted,
        this.images,
        this.createdAt,
        this.id});

  PrintDocument.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    extension = json['extension'];
    path = json['path'];
    url = json['url'];
    isTemporary = json['isTemporary'];
    isDeleted = json['isDeleted'];
    images = json['images'];
    createdAt = json['createdAt'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['extension'] = this.extension;
    data['path'] = this.path;
    data['url'] = this.url;
    data['isTemporary'] = this.isTemporary;
    data['isDeleted'] = this.isDeleted;
    data['images'] = this.images;
    data['createdAt'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}