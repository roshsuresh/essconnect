class AttendencePercentageModel {
  AttendenceModel? attendence;
  double? percentage;

  AttendencePercentageModel({this.attendence, this.percentage});

  AttendencePercentageModel.fromJson(Map<String, dynamic> json) {
    attendence = json['attendence'] != null
        ? AttendenceModel.fromJson(json['attendence'])
        : null;
    percentage = json['percentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (attendence != null) {
      data['attendence'] = attendence!.toJson();
    }
    data['percentage'] = percentage;
    return data;
  }
}

class AttendenceModel {
  double? workDays;
  double? presentDays;
  double? absentDays;
  double? attendancePercentage;
  String? attendanceAsOnDate;
  List<MonthwiseAttendence>? monthwiseAttendence;

  AttendenceModel(
      {this.workDays,
      this.presentDays,
      this.absentDays,
      this.attendancePercentage,
      this.attendanceAsOnDate,
      this.monthwiseAttendence});

  AttendenceModel.fromJson(Map<String, dynamic> json) {
    workDays = json['workDays'];
    presentDays = json['presentDays'];
    absentDays = json['absentDays'];
    attendancePercentage = json['attendancePercentage'];
    attendanceAsOnDate = json['attendanceAsOnDate'];
    if (json['monthwiseAttendence'] != null) {
      monthwiseAttendence = <MonthwiseAttendence>[];
      json['monthwiseAttendence'].forEach((v) {
        monthwiseAttendence!.add(MonthwiseAttendence.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['workDays'] = workDays;
    data['presentDays'] = presentDays;
    data['absentDays'] = absentDays;
    data['attendancePercentage'] = attendancePercentage;
    data['attendanceAsOnDate'] = attendanceAsOnDate;
    if (monthwiseAttendence != null) {
      data['monthwiseAttendence'] =
          monthwiseAttendence!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MonthwiseAttendence {
  String? month;
  double? monthres;
  String? attMonthId;
  int? totalWorkingDays;
  double? daysPresent;
  double? daysAbsent;
  double? percentage;

  MonthwiseAttendence(
      {this.month,
      this.monthres,
      this.attMonthId,
      this.totalWorkingDays,
      this.daysPresent,
      this.daysAbsent,
      this.percentage});

  MonthwiseAttendence.fromJson(Map<String, dynamic> json) {
    month = json['month'];
    monthres = json['monthres'];
    attMonthId = json['attMonthId'];
    totalWorkingDays = json['totalWorkingDays'];
    daysPresent = json['daysPresent'];
    daysAbsent = json['daysAbsent'];
    percentage = json['percentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['month'] = month;
    data['monthres'] = monthres;
    data['attMonthId'] = attMonthId;
    data['totalWorkingDays'] = totalWorkingDays;
    data['daysPresent'] = daysPresent;
    data['daysAbsent'] = daysAbsent;
    data['percentage'] = percentage;
    return data;
  }
}

///  Attendance detail Model
///
class AttendanceDetailModel {
  List<Absenteeslists>? absenteeslists;
  bool? dualAttendance;
  String? monthName;

  AttendanceDetailModel(
      {this.absenteeslists, this.dualAttendance, this.monthName});

  AttendanceDetailModel.fromJson(Map<String, dynamic> json) {
    if (json['absenteeslists'] != null) {
      absenteeslists = <Absenteeslists>[];
      json['absenteeslists'].forEach((v) {
        absenteeslists!.add(Absenteeslists.fromJson(v));
      });
    }
    dualAttendance = json['dualAttendance'];
    monthName = json['monthName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (absenteeslists != null) {
      data['absenteeslists'] =
          absenteeslists!.map((v) => v.toJson()).toList();
    }
    data['dualAttendance'] = dualAttendance;
    data['monthName'] = monthName;
    return data;
  }
}

class Absenteeslists {
  String? date;
  String? foreNoon;
  String? afterNoon;

  Absenteeslists({this.date, this.foreNoon, this.afterNoon});

  Absenteeslists.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    foreNoon = json['foreNoon'];
    afterNoon = json['afterNoon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['foreNoon'] = foreNoon;
    data['afterNoon'] = afterNoon;
    return data;
  }
}
