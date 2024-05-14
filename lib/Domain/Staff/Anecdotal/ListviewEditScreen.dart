class AnecdotalListViewModel {
  String? studentId;
  String? id;
  String? createStaffId;
  String? admissionNo;
  String? name;
  String? date;
  String? createdBy;
  String? remarksCategory;
  String? subject;

  AnecdotalListViewModel(
      {this.studentId,
      this.id,
      this.createStaffId,
      this.admissionNo,
      this.name,
      this.date,
      this.createdBy,
      this.remarksCategory,
      this.subject});

  AnecdotalListViewModel.fromJson(Map<String, dynamic> json) {
    studentId = json['studentId'];
    id = json['id'];
    createStaffId = json['createStaffId'];
    admissionNo = json['admissionNo'];
    name = json['name'];
    date = json['date'];
    createdBy = json['createdBy'];
    remarksCategory = json['remarksCategory'];
    subject = json['subject'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['studentId'] = this.studentId;
    data['id'] = this.id;
    data['createStaffId'] = this.createStaffId;
    data['admissionNo'] = this.admissionNo;
    data['name'] = this.name;
    data['date'] = this.date;
    data['createdBy'] = this.createdBy;
    data['remarksCategory'] = this.remarksCategory;
    data['subject'] = this.subject;
    return data;
  }
}

class PaginationAnecDotalList {
  int? currentPage;
  int? pageSize;
  int? count;

  PaginationAnecDotalList({this.currentPage, this.pageSize, this.count});

  PaginationAnecDotalList.fromJson(Map<String, dynamic> json) {
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
//edit

