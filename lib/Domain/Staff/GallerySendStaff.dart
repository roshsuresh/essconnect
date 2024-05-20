class GallerySendStaffInitialvalues {
  List<GalleryCourseListStaff>? courseList;

  bool? isClassTeacher;

  GallerySendStaffInitialvalues({this.courseList, this.isClassTeacher});

  GallerySendStaffInitialvalues.fromJson(Map<String, dynamic> json) {
    if (json['courseList'] != null) {
      courseList = [];
      json['courseList'].forEach((v) {
        courseList!.add(GalleryCourseListStaff.fromJson(v));
      });
    }

    isClassTeacher = json['isClassTeacher'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (courseList != null) {
      data['courseList'] = courseList!.map((v) => v.toJson()).toList();
    }

    data['isClassTeacher'] = isClassTeacher;
    return data;
  }
}

class GalleryCourseListStaff {
  String? value;
  String? text;
  int? order;

  GalleryCourseListStaff({this.value, this.text, this.order});

  GalleryCourseListStaff.fromJson(Map<String, dynamic> json) {
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

class GalleryDivisionListStaff {
  String? value;
  String? text;

  GalleryDivisionListStaff({this.value, this.text});

  GalleryDivisionListStaff.fromJson(Map<String, dynamic> json) {
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

//GAllery Post method ---- Image id

class GalleryImageId {
  String? name;
  String? extension;
  String? path;
  String? url;
  bool? isTemporary;
  bool? isDeleted;

  String? createdAt;
  String? id;

  GalleryImageId(
      {this.name,
      this.extension,
      this.path,
      this.url,
      this.isTemporary,
      this.isDeleted,
      this.createdAt,
      this.id});

  GalleryImageId.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    extension = json['extension'];
    path = json['path'];
    url = json['url'];
    isTemporary = json['isTemporary'];
    isDeleted = json['isDeleted'];

    createdAt = json['createdAt'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['extension'] = extension;
    data['path'] = path;
    data['url'] = url;
    data['isTemporary'] = isTemporary;
    data['isDeleted'] = isDeleted;

    data['createdAt'] = createdAt;
    data['id'] = id;
    return data;
  }
}
