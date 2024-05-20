class NoticeboardInitialValues {
  List<NoticeboardCourseList>? courseList;
  List<NoticeBoardDivision>? divisionList;

  List<NoticeboardCategory>? category;
  bool? isClassTeacher;

  NoticeboardInitialValues(
      {this.courseList, this.divisionList, this.category, this.isClassTeacher});

  NoticeboardInitialValues.fromJson(Map<String, dynamic> json) {
    if (json['courseList'] != null) {
      courseList = [];
      json['courseList'].forEach((v) {
        courseList!.add(NoticeboardCourseList.fromJson(v));
      });
    }
    if (json['divisionList'] != null) {
      divisionList = [];
      json['divisionList'].forEach((v) {
        divisionList!.add(NoticeBoardDivision.fromJson(v));
      });
    }

    if (json['category'] != null) {
      category = [];
      json['category'].forEach((v) {
        category!.add(NoticeboardCategory.fromJson(v));
      });
    }
    isClassTeacher = json['isClassTeacher'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (courseList != null) {
      data['courseList'] = courseList!.map((v) => v.toJson()).toList();
    }
    if (divisionList != null) {
      data['divisionList'] = divisionList!.map((v) => v.toJson()).toList();
    }

    if (category != null) {
      data['category'] = category!.map((v) => v.toJson()).toList();
    }
    data['isClassTeacher'] = isClassTeacher;
    return data;
  }
}

class NoticeboardCourseList {
  String? value;
  String? text;
  int? order;

  NoticeboardCourseList({this.value, this.text, this.order});

  NoticeboardCourseList.fromJson(Map<String, dynamic> json) {
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

class NoticeBoardDivision {
  String? value;
  String? text;

  NoticeBoardDivision({this.value, this.text});

  NoticeBoardDivision.fromJson(Map<String, dynamic> json) {
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

class NoticeboardCategory {
  String? value;
  String? text;
  bool? selected;

  NoticeboardCategory({this.value, this.text, this.selected});

  NoticeboardCategory.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    text = json['text'];
    selected = json['selected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['text'] = text;
    data['selected'] = selected;

    return data;
  }
}

//Noticeboard Post method ---- Image id

class NoticeImageId {
  String? name;
  String? extension;
  String? path;
  String? url;
  bool? isTemporary;
  bool? isDeleted;
  String? createdAt;
  String? id;

  NoticeImageId(
      {this.name,
      this.extension,
      this.path,
      this.url,
      this.isTemporary,
      this.isDeleted,
      this.createdAt,
      this.id});

  NoticeImageId.fromJson(Map<String, dynamic> json) {
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

//NoticeBoard received

class NoticeBoardReceivedstaff {
  String? noticeId;
  String? noticeBoardFileid;
  String? title;
  String? matter;
  String? entryDate;
  String? entryTime;
  String? staffName;

  NoticeBoardReceivedstaff({
    this.noticeId,
    this.noticeBoardFileid,
    this.title,
    this.matter,
    this.entryDate,
    this.entryTime,
    this.staffName,
  });

  NoticeBoardReceivedstaff.fromJson(Map<String, dynamic> json) {
    noticeId = json['noticeId'];
    noticeBoardFileid = json['noticeBoardFileid'];
    title = json['title'];
    matter = json['matter'];
    entryDate = json['entryDate'];
    entryTime = json['entryTime'];
    staffName = json['staffName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['noticeId'] = noticeId;
    data['noticeBoardFileid'] = noticeBoardFileid;
    data['title'] = title;
    data['matter'] = matter;
    data['entryDate'] = entryDate;
    data['entryTime'] = entryTime;
    data['staffName'] = staffName;
    return data;
  }
}

//NoticeBoardAttachmnet

class NoticeBoardAttatchmentStaffReceived {
  String? name;
  String? extension;
  String? path;
  String? url;
  bool? isDeleted;
  String? createdAt;
  String? id;

  NoticeBoardAttatchmentStaffReceived(
      {this.name,
      this.extension,
      this.path,
      this.url,
      this.isDeleted,
      this.createdAt,
      this.id});

  NoticeBoardAttatchmentStaffReceived.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    extension = json['extension'];
    path = json['path'];
    url = json['url'];
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
    data['isDeleted'] = isDeleted;
    data['createdAt'] = createdAt;
    data['id'] = id;
    return data;
  }
}

//Notice success reponse

class NoticeSuccessModel {
  String? state;
  String? noticeBoardId;

  NoticeSuccessModel({this.state, this.noticeBoardId});

  NoticeSuccessModel.fromJson(Map<String, dynamic> json) {
    state = json['state'];
    noticeBoardId = json['noticeBoardId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['state'] = state;
    data['noticeBoardId'] = noticeBoardId;
    return data;
  }
}
