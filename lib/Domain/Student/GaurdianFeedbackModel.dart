class Results5 {
  String? categoryId;
  String? categoryName;
  String? matter;
  int? sortOrder;
  String? createDate;


  Results5({this.categoryId, this.categoryName, this.matter, this.sortOrder, this.createDate});

  Results5.fromJson(Map<String, dynamic> json) {
    categoryId = json['categoryId'];
    categoryName = json['categoryName'];
    matter = json['matter'];
    sortOrder = json['sortOrder'];
    createDate = json['createDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoryId'] = this.categoryId;
    data['categoryName'] = this.categoryName;
    data['matter'] = this.matter;
    data['sortOrder'] = this.sortOrder;
    data['createDate'] = this.createDate;
    return data;
  }
}

class Pagination {
  int? currentPage;
  int? pageSize;
  int? count;

  Pagination({this.currentPage, this.pageSize, this.count});

  Pagination.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    pageSize = json['pageSize'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currentPage'] = this.currentPage;
    data['pageSize'] = this.pageSize;
    data['count'] = this.count;
    return data;
  }
}