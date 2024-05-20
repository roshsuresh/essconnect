class GalleryModel {
  GalleryModel({
    this.title,
    this.galleryId,
    this.caption,
    this.url,
  });
  late final String? title;
  late final String? galleryId;
  late final String? caption;
  late final String? url;

  GalleryModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    galleryId = json['galleryId'];
    caption = null;
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['title'] = title;
    data['galleryId'] = galleryId;
    data['caption'] = caption;
    data['url'] = url;
    return data;
  }
}

class GalleryphotosModel {
  String? title;
  String? galleryId;
  String? caption;
  String? url;

  GalleryphotosModel({this.title, this.galleryId, this.caption, this.url});

  GalleryphotosModel.fromJson(Map<String, dynamic> json) {
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
