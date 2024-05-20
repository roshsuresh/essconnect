//Sections
class Sections {
  String? value;
  String? text;
  bool? selected;
  bool? active;
  String? order;

  Sections({this.value, this.text, this.selected, this.active, this.order});

  Sections.fromJson(Map<String, dynamic> json) {
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
//Course
class Courses {
  String? value;
  String? text;
  bool? selected;
  bool? active;
  String? order;

  Courses({this.value, this.text, this.selected, this.active, this.order});

  Courses.fromJson(Map<String, dynamic> json) {
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
//division
class Divisions {
  String? value;
  String? text;
  String? fileId;
  String? classTTUploadId;
  String? fileName;
  String? imageId;
  String? imageName;

  Divisions({this.value, this.text, this.fileId, this.classTTUploadId,
    this.fileName, this.imageId,this.imageName
  });

  Divisions.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    text = json['text'];
    fileId = json['fileId'];
    classTTUploadId = json['classTTUploadId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['text'] = this.text;
    data['fileId'] = this.fileId;
    data['classTTUploadId'] = this.classTTUploadId;
    return data;
  }
}
//Save Image

class TimTableFile {
  String? name;
  String? extension;
  String? path;
  String? url;
  bool? isTemporary;
  bool? isDeleted;
  String? images;
  String? createdAt;
  String? id;

  TimTableFile(
      {this.name,
        this.extension,
        this.path,
        this.url,
        this.isTemporary,
        this.isDeleted,
        this.images,
        this.createdAt,
        this.id});

  TimTableFile.fromJson(Map<String, dynamic> json) {
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

//file

class TimeTableView {
  String? name;
  String? extension;
  String? path;
  String? url;
  bool? isTemporary;
  bool? isDeleted;
  List<Images>? images;
  String? createdAt;
  String? id;

  TimeTableView(
      {this.name,
        this.extension,
        this.path,
        this.url,
        this.isTemporary,
        this.isDeleted,
        this.images,
        this.createdAt,
        this.id});

  TimeTableView.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    extension = json['extension'];
    path = json['path'];
    url = json['url'];
    isTemporary = json['isTemporary'];
    isDeleted = json['isDeleted'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
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
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}

class Images {
  String? fileId;
  String? dimension;
  String? url;
  String? id;

  Images({this.fileId, this.dimension, this.url, this.id});

  Images.fromJson(Map<String, dynamic> json) {
    fileId = json['fileId'];
    dimension = json['dimension'];
    url = json['url'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fileId'] = this.fileId;
    data['dimension'] = this.dimension;
    data['url'] = this.url;
    data['id'] = this.id;
    return data;
  }
}
//******************StaffList

class StaffList {
  String? value;
  String? text;
  String? fileId;
  String? teacherTTUploadId;
  String? role;
  String? fileName;
  String? imageId;
  String? imageName;

  StaffList(
      {this.value, this.text, this.fileId, this.teacherTTUploadId, this.role,
      this.fileName,this.imageId,this.imageName});

  StaffList.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    text = json['text'];
    fileId = json['fileId'];
    teacherTTUploadId = json['teacherTTUploadId'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['text'] = this.text;
    data['fileId'] = this.fileId;
    data['teacherTTUploadId'] = this.teacherTTUploadId;
    data['role'] = this.role;
    return data;
  }
}

//Staff filessss

class StaffTimeTableView {
  String? name;
  String? extension;
  String? path;
  String? url;
  bool? isTemporary;
  bool? isDeleted;
  List<Images>? images;
  String? createdAt;
  String? id;

  StaffTimeTableView(
      {this.name,
        this.extension,
        this.path,
        this.url,
        this.isTemporary,
        this.isDeleted,
        this.images,
        this.createdAt,
        this.id});

  StaffTimeTableView.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    extension = json['extension'];
    path = json['path'];
    url = json['url'];
    isTemporary = json['isTemporary'];
    isDeleted = json['isDeleted'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
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
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
