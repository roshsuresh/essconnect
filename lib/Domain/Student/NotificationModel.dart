class RecieveNotificationModel {
  RecieveNotificationModel({
    required this.results,
    required this.pagination,
  });

  List<Result> results;
  Pagination pagination;

  factory RecieveNotificationModel.fromJson(Map<String, dynamic> json) => RecieveNotificationModel(
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    pagination: Pagination.fromJson(json["pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
    "pagination": pagination.toJson(),
  };
}
class Pagination {
  Pagination({
    this.currentPage,
    this.pageSize,
    this.count,
  });

  int? currentPage;
  int? pageSize;
  int? count;

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    currentPage: json["currentPage"],
    pageSize: json["pageSize"],
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "currentPage": currentPage,
    "pageSize": pageSize,
    "count": count,
  };
}

class Result {
  Result({
    required this.schoolId,
    required this.academicyearId,
    required this.createdDate,
    required this.staffGuardianStudId,
    required this.type,
  });

  String schoolId;
  String academicyearId;
  DateTime createdDate;
  String staffGuardianStudId;
  String type;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    schoolId: json["SchoolId"],
    academicyearId: json["AcademicyearId"],
    createdDate: DateTime.parse(json["CreatedDate"]),
    staffGuardianStudId: json["StaffGuardianStudId"],
    type: json["Type"],
  );

  Map<String, dynamic> toJson() => {
    "SchoolId": schoolId,
    "AcademicyearId": academicyearId,
    "CreatedDate": "${createdDate.year.toString().padLeft(4, '0')}-${createdDate.month.toString().padLeft(2, '0')}-${createdDate.day.toString().padLeft(2, '0')}",
    "StaffGuardianStudId": staffGuardianStudId,
    "Type": type,
  };
}
