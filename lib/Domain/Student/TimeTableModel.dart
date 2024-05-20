class ViewClassTimeTable {
  Item1? item1;
  String? item2;

  ViewClassTimeTable({this.item1, this.item2});

  ViewClassTimeTable.fromJson(Map<String, dynamic> json) {
    item1 = json['item1'] != null ? Item1.fromJson(json['item1']) : null;
    item2 = json['item2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (item1 != null) {
      data['item1'] = item1!.toJson();
    }
    data['item2'] = item2;
    return data;
  }
}

class Item1 {
  String? id;
  String? name;
  String? extension;
  String? path;
  String? url;
  bool? isTemporary;
  bool? isDeleted;
  String? images;
  String? createdAt;
  String? division;

  Item1(
      {this.id,
      this.name,
      this.extension,
      this.path,
      this.url,
      this.isTemporary,
      this.isDeleted,
      this.images,
      this.createdAt,
      this.division});

  Item1.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    extension = json['extension'];
    path = json['path'];
    url = json['url'];
    isTemporary = json['isTemporary'];
    isDeleted = json['isDeleted'];
    images = json['images'];
    createdAt = json['createdAt'];
    division = json['division'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['extension'] = extension;
    data['path'] = path;
    data['url'] = url;
    data['isTemporary'] = isTemporary;
    data['isDeleted'] = isDeleted;
    data['images'] = images;
    data['createdAt'] = createdAt;
    data['division'] = division;
    return data;
  }
}
