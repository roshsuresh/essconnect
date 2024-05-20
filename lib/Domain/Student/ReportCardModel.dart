class ReportModel {
  List<ReportCardModel>? reportCardList;
  bool? isLocked;

  ReportModel({this.reportCardList, this.isLocked});

  ReportModel.fromJson(Map<String, dynamic> json) {
    if (json['reportCardList'] != null) {
      reportCardList = <ReportCardModel>[];
      json['reportCardList'].forEach((v) {
        reportCardList!.add(ReportCardModel.fromJson(v));
      });
    }
    isLocked = json['isLocked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (reportCardList != null) {
      data['reportCardList'] =
          reportCardList!.map((v) => v.toJson()).toList();
    }
    data['isLocked'] = isLocked;
    return data;
  }
}

class ReportCardModel {
  String? studentId;
  String? uploadedDate;
  String? description;
  String? fileId;

  ReportCardModel(
      {this.studentId, this.uploadedDate, this.description, this.fileId});

  ReportCardModel.fromJson(Map<String, dynamic> json) {
    studentId = json['studentId'];
    uploadedDate = json['uploadedDate'];
    description = json['description'];
    fileId = json['fileId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['studentId'] = studentId;
    data['uploadedDate'] = uploadedDate;
    data['description'] = description;
    data['fileId'] = fileId;
    return data;
  }
}

class ReportAttachment {
  String? name;
  String? extension;
  String? path;
  String? url;
  bool? isTemporary;
  bool? isDeleted;
  String? images;
  String? createdAt;
  String? id;

  ReportAttachment(
      {this.name,
      this.extension,
      this.path,
      this.url,
      this.isTemporary,
      this.isDeleted,
      this.images,
      this.createdAt,
      this.id});

  ReportAttachment.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['extension'] = extension;
    data['path'] = path;
    data['url'] = url;
    data['isTemporary'] = isTemporary;
    data['isDeleted'] = isDeleted;
    data['images'] = images;
    data['createdAt'] = createdAt;
    data['id'] = id;
    return data;
  }
}
