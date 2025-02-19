class StudPortionList {
  String? date;
  String? caption;
  int? newCount;
  int? viewedCount;

  StudPortionList({this.date, this.caption, this.newCount, this.viewedCount});

  StudPortionList.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    caption = json['caption'];
    newCount = json['newCount'];
    viewedCount = json['viewedCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['caption'] = this.caption;
    data['newCount'] = this.newCount;
    data['viewedCount'] = this.viewedCount;
    return data;
  }
}

class StudPortionDetials {
  String? tblId;
  String? date;
  String? createdAt;
  String? topic;
  String? chapter;
  String? studentId;
  String? description;
  String? details;
  String? subject;
  String? submittedBy;
  String? staffId;
  String? courseSubjectId;
  String? courseSubSubjectId;
  String? courseOptionSubjectId;
  String? portions;
  List<PhotoList>? photoList;

  StudPortionDetials(
      {this.tblId,
        this.date,
        this.createdAt,
        this.topic,
        this.chapter,
        this.studentId,
        this.description,
        this.details,
        this.subject,
        this.submittedBy,
        this.staffId,
        this.courseSubjectId,
        this.courseSubSubjectId,
        this.courseOptionSubjectId,
        this.portions,
        this.photoList});

  StudPortionDetials.fromJson(Map<String, dynamic> json) {
    tblId = json['tblId'];
    date = json['date'];
    createdAt = json['createdAt'];
    topic = json['topic'];
    chapter = json['chapter'];
    studentId = json['studentId'];
    description = json['description'];
    details = json['details'];
    subject = json['subject'];
    submittedBy = json['submittedBy'];
    staffId = json['staffId'];
    courseSubjectId = json['courseSubjectId'];
    courseSubSubjectId = json['courseSubSubjectId'];
    courseOptionSubjectId = json['courseOptionSubjectId'];
    portions = json['portions'];
    if (json['photoList'] != null) {
      photoList = <PhotoList>[];
      json['photoList'].forEach((v) {
        photoList!.add(new PhotoList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tblId'] = this.tblId;
    data['date'] = this.date;
    data['createdAt'] = this.createdAt;
    data['topic'] = this.topic;
    data['chapter'] = this.chapter;
    data['studentId'] = this.studentId;
    data['description'] = this.description;
    data['details'] = this.details;
    data['subject'] = this.subject;
    data['submittedBy'] = this.submittedBy;
    data['staffId'] = this.staffId;
    data['courseSubjectId'] = this.courseSubjectId;
    data['courseSubSubjectId'] = this.courseSubSubjectId;
    data['courseOptionSubjectId'] = this.courseOptionSubjectId;
    data['portions'] = this.portions;
    if (this.photoList != null) {
      data['photoList'] = this.photoList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class PhotoList {
  String? name;
  String? extension;
  String? path;
  String? url;
  bool? isTemporary;
  bool? isDeleted;
  String? images;
  String? createdAt;
  String? id;

  PhotoList(
      {this.name,
        this.extension,
        this.path,
        this.url,
        this.isTemporary,
        this.isDeleted,
        this.images,
        this.createdAt,
        this.id});

  PhotoList.fromJson(Map<String, dynamic> json) {
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