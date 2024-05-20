class GalleryViewList_staff {
  String? id;
  String? createdStaffId;
  String? entryDate;
  String? createStaffName;
  String? title;
  String? createdAt;
  String? startDate;
  String? endDate;
  bool? approved;
  bool? cancelled;
  String? displayTo;

  GalleryViewList_staff(
      {this.id,
      this.createdStaffId,
      this.entryDate,
      this.createStaffName,
      this.title,
      this.createdAt,
      this.startDate,
      this.endDate,
      this.approved,
      this.cancelled,
      this.displayTo});

  GalleryViewList_staff.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdStaffId = json['createdStaffId'];
    entryDate = json['entryDate'];
    createStaffName = json['createStaffName'];
    title = json['title'];
    createdAt = json['createdAt'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    approved = json['approved'];
    cancelled = json['cancelled'];
    displayTo = json['displayTo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['createdStaffId'] = createdStaffId;
    data['entryDate'] = entryDate;
    data['createStaffName'] = createStaffName;
    data['title'] = title;
    data['createdAt'] = createdAt;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['approved'] = approved;
    data['cancelled'] = cancelled;
    data['displayTo'] = displayTo;
    return data;
  }
}

//gallery received

class GalleryEventListReceived {
  String? title;
  String? galleryId;
  String? caption;
  String? url;

  GalleryEventListReceived(
      {this.title, this.galleryId, this.caption, this.url});

  GalleryEventListReceived.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    galleryId = json['galleryId'];
    caption = json['caption'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['galleryId'] = galleryId;
    data['caption'] = caption;
    data['url'] = url;
    return data;
  }
}


//Gallery  Attachment