//Section
class AppreviewSection {
  String? value;
  String? text;
  bool? selected;
  bool? active;
  String? order;

  AppreviewSection({this.value, this.text, this.selected, this.active, this.order});

  AppreviewSection.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    text = json['text'];
    selected = json['selected'];
    active = json['active'];
    order = json['order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['text'] = this.text;
    data['selected'] = this.selected;
    data['active'] = this.active;
    data['order'] = this.order;
    return data;
  }
}

//course
class AppreviewCourse {
  String? value;
  String? text;
  bool? selected;
  bool? active;
  String? order;

  AppreviewCourse({this.value, this.text, this.selected, this.active, this.order});

  AppreviewCourse.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    text = json['text'];
    selected = json['selected'];
    active = json['active'];
    order = json['order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['text'] = this.text;
    data['selected'] = this.selected;
    data['active'] = this.active;
    data['order'] = this.order;
    return data;
  }
}

//division

class AppreviewDivision {
  String? value;
  String? text;
  bool? selected;
  bool? active;
  String? order;

  AppreviewDivision({this.value, this.text, this.selected, this.active, this.order});

  AppreviewDivision.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    text = json['text'];
    selected = json['selected'];
    active = json['active'];
    order = json['order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['text'] = this.text;
    data['selected'] = this.selected;
    data['active'] = this.active;
    data['order'] = this.order;
    return data;
  }
}

//view

class ResultView {
  List<Results>? results;
  Pagination? pagination;

  ResultView({this.results, this.pagination});

  ResultView.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(new Results.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    return data;
  }
}

class Results {
  String? studentId;
  String? admNo;
  String? name;
  String? course;
  String? division;
  int? rollNo;
  String? mobNo;

  Results(
      {this.studentId,
        this.admNo,
        this.name,
        this.course,
        this.division,
        this.rollNo,
        this.mobNo});

  Results.fromJson(Map<String, dynamic> json) {
    studentId = json['studentId'];
    admNo = json['admNo'];
    name = json['name'];
    course = json['course'];
    division = json['division'];
    rollNo = json['rollNo'];
    mobNo = json['mobNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['studentId'] = this.studentId;
    data['admNo'] = this.admNo;
    data['name'] = this.name;
    data['course'] = this.course;
    data['division'] = this.division;
    data['rollNo'] = this.rollNo;
    data['mobNo'] = this.mobNo;
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

//AppCurrentUser


class AppUsersDetails{
  String? studentId;
  String? admNo;
  String? name;
  String? course;
  String? division;
  int? rollNo;
  String? mobNo;
  int? count;
  String? modifiedDate;
  double? month;
  int? totalCount;

  AppUsersDetails(
      {this.studentId,
        this.admNo,
        this.name,
        this.course,
        this.division,
        this.rollNo,
        this.mobNo,
        this.count,
        this.modifiedDate,
        this.month,
        this.totalCount});

  AppUsersDetails.fromJson(Map<String, dynamic> json) {
    studentId = json['studentId'];
    admNo = json['admNo'];
    name = json['name'];
    course = json['course'];
    division = json['division'];
    rollNo = json['rollNo'];
    mobNo = json['mobNo'];
    count = json['count'];
    modifiedDate = json['modifiedDate'];
    month = json['month'];
    totalCount = json['totalCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['studentId'] = this.studentId;
    data['admNo'] = this.admNo;
    data['name'] = this.name;
    data['course'] = this.course;
    data['division'] = this.division;
    data['rollNo'] = this.rollNo;
    data['mobNo'] = this.mobNo;
    data['count'] = this.count;
    data['modifiedDate'] = this.modifiedDate;
    data['month'] = this.month;
    data['totalCount'] = this.totalCount;
    return data;
  }
}