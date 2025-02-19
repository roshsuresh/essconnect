class AdminPortal {
  String? id;
  String? title;
  String? matter;
  bool? active;
  int? sortOrder;

  AdminPortal({this.id, this.title, this.matter, this.active, this.sortOrder});

  AdminPortal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    matter = json['matter'];
    active = json['active'];
    sortOrder = json['sortOrder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['matter'] = this.matter;
    data['active'] = this.active;
    data['sortOrder'] = this.sortOrder;
    return data;
  }
}
