class ExamTTmodelStaff {
  List<CourseExam>? courses;
  bool? isClassTeacher;

  ExamTTmodelStaff({this.courses, this.isClassTeacher});

  ExamTTmodelStaff.fromJson(Map<String, dynamic> json) {
    if (json['courses'] != null) {
      courses = <CourseExam>[];
      json['courses'].forEach((v) {
        courses!.add(CourseExam.fromJson(v));
      });
    }

    isClassTeacher = json['isClassTeacher'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (courses != null) {
      data['courses'] = courses!.map((v) => v.toJson()).toList();
    }

    data['isClassTeacher'] = isClassTeacher;
    return data;
  }
}

class CourseExam {
  String? id;
  String? courseName;
  int? sortOrder;

  CourseExam({this.id, this.courseName, this.sortOrder});

  CourseExam.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseName = json['courseName'];
    sortOrder = json['sortOrder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['courseName'] = courseName;
    data['sortOrder'] = sortOrder;
    return data;
  }
}

class DivisionsExam {
  String? value;
  String? text;

  DivisionsExam({
    this.value,
    this.text,
  });

  DivisionsExam.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['text'] = text;

    return data;
  }
}
