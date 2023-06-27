class ReportModel {
  List<ReportCardModel>? reportCardList;
  bool? isLocked;

  ReportModel({this.reportCardList, this.isLocked});

  ReportModel.fromJson(Map<String, dynamic> json) {
    if (json['reportCardList'] != null) {
      reportCardList = <ReportCardModel>[];
      json['reportCardList'].forEach((v) {
        reportCardList!.add(new ReportCardModel.fromJson(v));
      });
    }
    isLocked = json['isLocked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.reportCardList != null) {
      data['reportCardList'] =
          this.reportCardList!.map((v) => v.toJson()).toList();
    }
    data['isLocked'] = this.isLocked;
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['studentId'] = this.studentId;
    data['uploadedDate'] = this.uploadedDate;
    data['description'] = this.description;
    data['fileId'] = this.fileId;
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
    final Map<String, dynamic> data = Map<String, dynamic>();
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
