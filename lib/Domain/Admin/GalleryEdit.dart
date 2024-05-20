class GalleryEditAdmin {
  String? id;
  String? title;
  String? displayStartDate;
  String? displayEndDate;
  bool? cancelled;
  bool? approved;
  String? createdStaffId;
  String? entryDate;
  bool? forClassTeacherOnly;
  String? displayTo;
  List<PhotoEdit>? photo;

  GalleryEditAdmin({
    this.id,
    this.title,
    this.displayStartDate,
    this.displayEndDate,
    this.cancelled,
    this.approved,
    this.createdStaffId,
    this.entryDate,
    this.forClassTeacherOnly,
    this.displayTo,
    this.photo,
  });

  GalleryEditAdmin.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    displayStartDate = json['displayStartDate'];
    displayEndDate = json['displayEndDate'];

    cancelled = json['cancelled'];
    approved = json['approved'];
    createdStaffId = json['createdStaffId'];

    entryDate = json['entryDate'];
    forClassTeacherOnly = json['forClassTeacherOnly'];

    displayTo = json['displayTo'];

    if (json['photo'] != null) {
      photo = <PhotoEdit>[];
      json['photo'].forEach((v) {
        photo!.add(PhotoEdit.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['displayStartDate'] = displayStartDate;
    data['displayEndDate'] = displayEndDate;
    data['cancelled'] = cancelled;
    data['approved'] = approved;
    data['createdStaffId'] = createdStaffId;
    data['entryDate'] = entryDate;
    data['forClassTeacherOnly'] = forClassTeacherOnly;
    data['displayTo'] = displayTo;
    if (photo != null) {
      data['photo'] = photo!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class PhotoEdit {
  String? file;
  String? photoCaption;
  bool? isMaster;

  PhotoEdit({this.file, this.photoCaption, this.isMaster});

  PhotoEdit.fromJson(Map<String, dynamic> json) {
    file = json['file'];
    photoCaption = json['photoCaption'];
    isMaster = json['isMaster'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['file'] = file;
    data['photoCaption'] = photoCaption;
    data['isMaster'] = isMaster;
    return data;
  }
}
