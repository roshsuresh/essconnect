class ExamTTModelAdmin {
  String? id;
  String? examStartDate;
  String? description;
  String? course;
  String? division;
  String? role;
  String? createdAt;
  String? createdStaffId;
  String? createStaffName;

  ExamTTModelAdmin(
      {this.id,
      this.examStartDate,
      this.description,
      this.course,
      this.division,
      this.role,
      this.createdAt,
      this.createdStaffId,
      this.createStaffName});

  ExamTTModelAdmin.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    examStartDate = json['examStartDate'];
    description = json['description'];
    course = json['course'];
    division = json['division'];
    role = json['role'];
    createdAt = json['createdAt'];
    createdStaffId = json['createdStaffId'];
    createStaffName = json['createStaffName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['id'] = id;
    data['examStartDate'] = examStartDate;
    data['description'] = description;
    data['course'] = course;
    data['division'] = division;
    data['role'] = role;
    data['createdAt'] = createdAt;
    data['createdStaffId'] = createdStaffId;
    data['createStaffName'] = createStaffName;
    return data;
  }
}
