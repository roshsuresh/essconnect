class ExamTTModelAdmin {
  String? id;
  String? examStartDate;
  String? description;
  String? course;
  String? division;
  String? role;
  String? createdAt;
  String? createdStaffId;
  String? createStaffName;

  ExamTTModelAdmin(
      {this.id,
      this.examStartDate,
      this.description,
      this.course,
      this.division,
      this.role,
      this.createdAt,
      this.createdStaffId,
      this.createStaffName});

  ExamTTModelAdmin.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    examStartDate = json['examStartDate'];
    description = json['description'];
    course = json['course'];
    division = json['division'];
    role = json['role'];
    createdAt = json['createdAt'];
    createdStaffId = json['createdStaffId'];
    createStaffName = json['createStaffName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['id'] = id;
    data['examStartDate'] = examStartDate;
    data['description'] = description;
    data['course'] = course;
    data['division'] = division;
    data['role'] = role;
    data['createdAt'] = createdAt;
    data['createdStaffId'] = createdStaffId;
    data['createStaffName'] = createStaffName;
    return data;
  }
}


/////////Edit Model ///////////////


class EditUploadExamtimetable {
  String? id;
  String? examStartDate;
  String? displayFrom;
  String? displayUpto;
  String? description;
  String? courseId;
  List<String>? divisionId;
  String? attachmentId;
  Attachment? attachment;
  String? createStaffId;
  List<Courses>? courses;
  List<Division>? division;

  EditUploadExamtimetable(
      {this.id,
        this.examStartDate,
        this.displayFrom,
        this.displayUpto,
        this.description,
        this.courseId,
        this.divisionId,
        this.attachmentId,
        this.attachment,
        this.createStaffId,
        this.courses,
        this.division});

  EditUploadExamtimetable.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    examStartDate = json['examStartDate'];
    displayFrom = json['displayFrom'];
    displayUpto = json['displayUpto'];
    description = json['description'];
    courseId = json['courseId'];
    divisionId = json['divisionId'].cast<String>();
    attachmentId = json['attachmentId'];
    attachment = json['attachment'] != null
        ? new Attachment.fromJson(json['attachment'])
        : null;
    createStaffId = json['createStaffId'];
    if (json['courses'] != null) {
      courses = <Courses>[];
      json['courses'].forEach((v) {
        courses!.add(new Courses.fromJson(v));
      });
    }
    if (json['division'] != null) {
      division = <Division>[];
      json['division'].forEach((v) {
        division!.add(new Division.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['examStartDate'] = this.examStartDate;
    data['displayFrom'] = this.displayFrom;
    data['displayUpto'] = this.displayUpto;
    data['description'] = this.description;
    data['courseId'] = this.courseId;
    data['divisionId'] = this.divisionId;
    data['attachmentId'] = this.attachmentId;
    if (this.attachment != null) {
      data['attachment'] = this.attachment!.toJson();
    }
    data['createStaffId'] = this.createStaffId;
    if (this.courses != null) {
      data['courses'] = this.courses!.map((v) => v.toJson()).toList();
    }
    if (this.division != null) {
      data['division'] = this.division!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Attachment {
  String? name;
  String? extension;
  String? path;
  String? url;
  bool? isTemporary;
  bool? isDeleted;
  List<Images>? images;
  String? createdAt;
  String? id;

  Attachment(
      {this.name,
        this.extension,
        this.path,
        this.url,
        this.isTemporary,
        this.isDeleted,
        this.images,
        this.createdAt,
        this.id});

  Attachment.fromJson(Map<String, dynamic> json) {
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

class Courses {
  String? id;
  String? courseName;
  int? sortOrder;

  Courses({this.id, this.courseName, this.sortOrder});

  Courses.fromJson(Map<String, dynamic> json) {
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

class Division {
  String? value;
  String? text;
  Null? selected;
  Null? active;
  Null? order;

  Division({this.value, this.text, this.selected, this.active, this.order});

  Division.fromJson(Map<String, dynamic> json) {
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


class DownloadExamTimeTableList {
  String? name;
  String? extension;
  String? path;
  String? url;
  bool? isTemporary;
  bool? isDeleted;
  List<Images>? images;
  String? createdAt;
  String? id;

  DownloadExamTimeTableList(
      {this.name,
        this.extension,
        this.path,
        this.url,
        this.isTemporary,
        this.isDeleted,
        this.images,
        this.createdAt,
        this.id});

  DownloadExamTimeTableList.fromJson(Map<String, dynamic> json) {
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
