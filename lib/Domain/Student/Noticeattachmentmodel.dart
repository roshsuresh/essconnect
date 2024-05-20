class AttachmentModel {
  String? name;
  String? extension;
  String? path;
  String? url;
  bool? isTemporary;
  bool? isDeleted;
  List<Images>? images;
  String? createdAt;
  String? id;

  AttachmentModel(
      {this.name,
      this.extension,
      this.path,
      this.url,
      this.isTemporary,
      this.isDeleted,
      this.images,
      this.createdAt,
      this.id});

  AttachmentModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    extension = json['extension'];
    path = json['path'];
    url = json['url'];
    isTemporary = json['isTemporary'];
    isDeleted = json['isDeleted'];
    if (json['images'] != null) {
      images = [];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
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
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = createdAt;
    data['id'] = id;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fileId'] = fileId;
    data['dimension'] = dimension;
    data['url'] = url;
    data['id'] = id;
    return data;
  }
}
