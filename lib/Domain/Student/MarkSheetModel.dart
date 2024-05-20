class MarkSheetInitial {
  List<MarksheetList>? marksheetList;

  MarkSheetInitial({this.marksheetList});

  MarkSheetInitial.fromJson(Map<String, dynamic> json) {
    if (json['marksheetList'] != null) {
      marksheetList = <MarksheetList>[];
      json['marksheetList'].forEach((v) {
        marksheetList!.add(new MarksheetList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.marksheetList != null) {
      data['marksheetList'] =
          this.marksheetList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MarksheetList {
  String? marksheetId;
  String? studentId;
  String? uploadedDate;
  String? examName;
  int? examRank;
  double? totalMark;
  double? totalPercentage;
  String? totalGrade;

  MarksheetList(
      {this.marksheetId,
        this.studentId,
        this.uploadedDate,
        this.examName,
        this.examRank,
        this.totalMark,
        this.totalPercentage,
        this.totalGrade});

  MarksheetList.fromJson(Map<String, dynamic> json) {
    marksheetId = json['marksheetId'];
    studentId = json['studentId'];
    uploadedDate = json['uploadedDate'];
    examName = json['examName'];
    examRank = json['examRank'];
    totalMark = json['totalMark'];
    totalPercentage = json['totalPercentage'];
    totalGrade = json['totalGrade'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['marksheetId'] = this.marksheetId;
    data['studentId'] = this.studentId;
    data['uploadedDate'] = this.uploadedDate;
    data['examName'] = this.examName;
    data['examRank'] = this.examRank;
    data['totalMark'] = this.totalMark;
    data['totalPercentage'] = this.totalPercentage;
    data['totalGrade'] = this.totalGrade;
    return data;
  }
}

//view

class MarkSheetValues {
  List<MarksheetList>? marksheetList;
  bool? showMaxmarekWithHeading;
  double? maxScore;

  MarkSheetValues(
      {this.marksheetList, this.showMaxmarekWithHeading, this.maxScore});

  MarkSheetValues.fromJson(Map<String, dynamic> json) {
    if (json['marksheetList'] != null) {
      marksheetList = <MarksheetList>[];
      json['marksheetList'].forEach((v) {
        marksheetList!.add(new MarksheetList.fromJson(v));
      });
    }
    showMaxmarekWithHeading = json['showMaxmarekWithHeading'];
    maxScore = json['maxScore'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.marksheetList != null) {
      data['marksheetList'] =
          this.marksheetList!.map((v) => v.toJson()).toList();
    }
    data['showMaxmarekWithHeading'] = this.showMaxmarekWithHeading;
    data['maxScore'] = this.maxScore;
    return data;
  }
}

class MarksheetListView {
  String? marksheetId;
  String? subject;
  double? maxScore;
  double? score;
  double? convertedScore;
  double? percentage;
  String? grade;
  int? subjectRank;
  String? attendance;
  double? convertedMaxScore;

  MarksheetListView(
      {this.marksheetId,
        this.subject,
        this.maxScore,
        this.score,
        this.convertedScore,
        this.percentage,
        this.grade,
        this.subjectRank,
        this.attendance,
      this.convertedMaxScore});

  MarksheetListView.fromJson(Map<String, dynamic> json) {
    marksheetId = json['marksheetId'];
    subject = json['subject'];
    maxScore = json['maxScore'];
    score = json['score'];
    convertedScore = json['convertedScore'];
    percentage = json['percentage'];
    grade = json['grade'];
    subjectRank = json['subjectRank'];
    attendance = json['attendance'];
    convertedMaxScore = json['convertedMaxScore'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['marksheetId'] = this.marksheetId;
    data['subject'] = this.subject;
    data['maxScore'] = this.maxScore;
    data['score'] = this.score;
    data['convertedScore'] = this.convertedScore;
    data['percentage'] = this.percentage;
    data['grade'] = this.grade;
    data['subjectRank'] = this.subjectRank;
    data['attendance'] = this.attendance;
    data['convertedMaxScore'] = this.convertedMaxScore;
    return data;
  }
}
