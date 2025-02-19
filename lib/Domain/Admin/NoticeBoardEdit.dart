class NoticeEditAdmin {
  String? id;
  String? title;
  String? matter;
  String? reason;
  String? displayStartDate;
  String? displayEndDate;
  String? createdDate;
  bool? cancelled;
  bool? approved;
  String? createdStaffId;
  String? cancelledStaffId;
  String? attachmentId;
  AttachmentNoticeAdmin? attachment;
  bool? forClassTeacherOnly;
  String? categoryId;
  String? staffRole;
  String? displayTo;
  List<String>? divisionId;
  List<String>? courseId;
  String? sectionId;
  List<Category>? category;
  List<Courses>? courses;
  List<Divisions>? divisions;

  NoticeEditAdmin(
      {this.id,
        this.title,
        this.matter,
        this.reason,
        this.displayStartDate,
        this.displayEndDate,
        this.createdDate,
        this.cancelled,
        this.approved,
        this.createdStaffId,
        this.cancelledStaffId,
        this.attachmentId,
        this.attachment,
        this.forClassTeacherOnly,
        this.categoryId,
        this.staffRole,
        this.displayTo,
        this.divisionId,
        this.courseId,
        this.sectionId,
        this.category,
        this.courses,
        this.divisions});

  NoticeEditAdmin.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    matter = json['matter'];
    reason = json['reason'];
    displayStartDate = json['displayStartDate'];
    displayEndDate = json['displayEndDate'];
    createdDate = json['createdDate'];
    cancelled = json['cancelled'];
    approved = json['approved'];
    createdStaffId = json['createdStaffId'];
    cancelledStaffId = json['cancelledStaffId'];
    attachmentId = json['attachmentId'];
    attachment = json['attachment'] != null
        ? new AttachmentNoticeAdmin.fromJson(json['attachment'])
        : null;
    forClassTeacherOnly = json['forClassTeacherOnly'];
    categoryId = json['categoryId'];
    staffRole = json['staffRole'];
    displayTo = json['displayTo'];
    divisionId = List<String>.from(json['divisionId']);
    courseId =  List<String>.from(json['courseId']);
    sectionId =  json['sectionId'];
    if (json['category'] != null) {
      category = <Category>[];
      json['category'].forEach((v) {
        category!.add(new Category.fromJson(v));
      });
    }
    if (json['courses'] != null) {
      courses = <Courses>[];
      json['courses'].forEach((v) {
        courses!.add(new Courses.fromJson(v));
      });
    }
    if (json['divisions'] != null) {
      divisions = <Divisions>[];
      json['divisions'].forEach((v) {
        divisions!.add(new Divisions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['matter'] = this.matter;
    data['reason'] = this.reason;
    data['displayStartDate'] = this.displayStartDate;
    data['displayEndDate'] = this.displayEndDate;
    data['createdDate'] = this.createdDate;
    data['cancelled'] = this.cancelled;
    data['approved'] = this.approved;
    data['createdStaffId'] = this.createdStaffId;
    data['cancelledStaffId'] = this.cancelledStaffId;
    data['attachmentId'] = this.attachmentId;
    if (this.attachment != null) {
      data['attachment'] = this.attachment!.toJson();
    }
    data['forClassTeacherOnly'] = this.forClassTeacherOnly;
    data['categoryId'] = this.categoryId;
    data['staffRole'] = this.staffRole;
    data['displayTo'] = this.displayTo;
    data['divisionId'] = this.divisionId;
    data['courseId'] = this.courseId;
    data['sectionId'] = this.sectionId;
    if (this.category != null) {
      data['category'] = this.category!.map((v) => v.toJson()).toList();
    }
    if (this.courses != null) {
      data['courses'] = this.courses!.map((v) => v.toJson()).toList();
    }
    if (this.divisions != null) {
      data['divisions'] = this.divisions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  String? value;
  String? text;
  bool? selected;
  bool? active;
  String? order;

  Category({this.value, this.text, this.selected, this.active, this.order});

  Category.fromJson(Map<String, dynamic> json) {
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

class Divisions {
  String? value;
  String? text;
  bool? selected;
  bool? active;
  String? order;

  Divisions({this.value, this.text, this.selected, this.active, this.order});

  Divisions.fromJson(Map<String, dynamic> json) {
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


class AttachmentNoticeAdmin {
  String? name;
  String? extension;
  String? path;
  String? url;
  bool? isTemporary;
  bool? isDeleted;
  String? createdAt;
  String? id;

  AttachmentNoticeAdmin(
      {this.name,
        this.extension,
        this.path,
        this.url,
        this.isTemporary,
        this.isDeleted,
        this.createdAt,
        this.id});

  AttachmentNoticeAdmin.fromJson(Map<String, dynamic> json) {
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
