class NoticeBoardViewSuperAdmin {
  String? noticeId;
  String? noticeBoardFileid;
  String? noticeBoardFile;
  String? title;
  String? matter;
  String? createdAt;
  String? entryDate;
  String? entryTime;
  String? staffId;
  String? staffName;
  String? staffPhotoId;
  String? staffPhoto;
  bool? forClassTeachers;
  bool? approved;
  bool? cancelled;
  int? displayTo;

  NoticeBoardViewSuperAdmin({
    this.noticeId,
    this.noticeBoardFileid,
    this.noticeBoardFile,
    this.title,
    this.matter,
    this.createdAt,
    this.entryDate,
    this.entryTime,
    this.staffId,
    this.staffName,
    this.staffPhotoId,
    this.staffPhoto,
    this.forClassTeachers,
    this.approved,
    this.cancelled,
    this.displayTo,
  });

  NoticeBoardViewSuperAdmin.fromJson(Map<String, dynamic> json) {
    noticeId = json['noticeId'];
    noticeBoardFileid = json['noticeBoardFileid'];
    noticeBoardFile = json['noticeBoardFile'];
    title = json['title'];
    matter = json['matter'];
    createdAt = json['createdAt'];
    entryDate = json['entryDate'];
    entryTime = json['entryTime'];
    staffId = json['staffId'];
    staffName = json['staffName'];
    staffPhotoId = json['staffPhotoId'];
    staffPhoto = json['staffPhoto'];
    forClassTeachers = json['forClassTeachers'];
    approved = json['approved'];
    cancelled = json['cancelled'];
    displayTo = json['displayTo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['noticeId'] = noticeId;
    data['noticeBoardFileid'] = noticeBoardFileid;
    data['noticeBoardFile'] = noticeBoardFile;
    data['title'] = title;
    data['matter'] = matter;
    data['createdAt'] = createdAt;
    data['entryDate'] = entryDate;
    data['entryTime'] = entryTime;
    data['staffId'] = staffId;
    data['staffName'] = staffName;
    data['staffPhotoId'] = staffPhotoId;
    data['staffPhoto'] = staffPhoto;
    data['forClassTeachers'] = forClassTeachers;
    data['approved'] = approved;
    data['cancelled'] = cancelled;
    data['displayTo'] = displayTo;

    return data;
  }
}
