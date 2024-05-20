class NoticeEditAdmin {
  String? id;
  String? title;
  String? matter;
  String? displayStartDate;
  String? displayEndDate;
  String? createdDate;
  bool? cancelled;
  bool? approved;
  String? createdStaffId;
  String? attachmentId;
  AttachmentNoticeAdmin? attachment;

  NoticeEditAdmin({
    this.id,
    this.title,
    this.matter,
    this.displayStartDate,
    this.displayEndDate,
    this.createdDate,
    this.cancelled,
    this.approved,
    this.createdStaffId,
    this.attachmentId,
    this.attachment,
  });

  NoticeEditAdmin.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    matter = json['matter'];
    displayStartDate = json['displayStartDate'];
    displayEndDate = json['displayEndDate'];
    createdDate = json['createdDate'];
    cancelled = json['cancelled'];
    approved = json['approved'];
    createdStaffId = json['createdStaffId'];
    attachmentId = json['attachmentId'];
    attachment = json['attachment'] != null
        ? AttachmentNoticeAdmin.fromJson(json['attachment'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['matter'] = matter;
    data['displayStartDate'] = displayStartDate;
    data['displayEndDate'] = displayEndDate;
    data['createdDate'] = createdDate;
    data['cancelled'] = cancelled;
    data['approved'] = approved;
    data['createdStaffId'] = createdStaffId;
    data['attachmentId'] = attachmentId;
    if (attachment != null) {
      data['attachment'] = attachment!.toJson();
    }
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
