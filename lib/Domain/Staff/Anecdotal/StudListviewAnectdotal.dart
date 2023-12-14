class StudentViewAnecdotalModel {
  String? id;
  String? admNo;
  String? name;
  String? division;
  String? divisionId;
  String? courseId;
  String? rollNo;
  String? guardianId;
  String? guardianMobile;
  String? guardianName;
  String? relationId;
  bool? selected;

  StudentViewAnecdotalModel(
      {this.id,
      this.admNo,
      this.name,
      this.division,
      this.divisionId,
      this.courseId,
      this.rollNo,
      this.guardianId,
      this.guardianMobile,
      this.guardianName,
      this.relationId});

  StudentViewAnecdotalModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    admNo = json['admNo'];
    name = json['name'];
    division = json['division'];
    divisionId = json['divisionId'];
    courseId = json['courseId'];
    rollNo = json['rollNo'];
    guardianId = json['guardianId'];
    guardianMobile = json['guardianMobile'];
    guardianName = json['guardianName'];
    relationId = json['relationId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['admNo'] = admNo;
    data['name'] = name;
    data['division'] = division;
    data['divisionId'] = divisionId;
    data['courseId'] = courseId;
    data['rollNo'] = rollNo;
    data['guardianId'] = guardianId;
    data['guardianMobile'] = guardianMobile;
    data['guardianName'] = guardianName;
    data['relationId'] = relationId;
    return data;
  }
}

class PaginationStudentView {
  int? currentPage;
  int? pageSize;
  int? count;

  PaginationStudentView({this.currentPage, this.pageSize, this.count});

  PaginationStudentView.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    pageSize = json['pageSize'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['currentPage'] = currentPage;
    data['pageSize'] = pageSize;
    data['count'] = count;
    return data;
  }
}
