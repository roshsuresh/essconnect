class Schoolphoto {
  String? name;
  String? extension;
  String? path;
  String? url;

  Schoolphoto({
    this.name,
    this.extension,
    this.path,
    this.url,
  });

  Schoolphoto.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    extension = json['extension'];
    path = json['path'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['extension'] = extension;
    data['path'] = path;
    data['url'] = url;
    return data;
  }
}
