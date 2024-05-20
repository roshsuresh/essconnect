class StatisticsData {
  String? course;
  int? male;
  int? feMale;
  int? totalCount;
  String? group;
  int? sectionOrder;
  int? courseOrder;

  StatisticsData({
    this.course,
    this.male,
    this.feMale,
    this.totalCount,
    this.group,
    this.sectionOrder,
    this.courseOrder,
  });

  StatisticsData.fromJson(Map<String, dynamic> json) {
    course = json['course'];
    male = json['male'];
    feMale = json['feMale'];
    totalCount = json['totalCount'];
    group = json['group'];
    sectionOrder = json['sectionOrder'];
    courseOrder = json['courseOrder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['course'] = course;
    data['male'] = male;
    data['feMale'] = feMale;
    data['totalCount'] = totalCount;
    data['group'] = group;
    data['sectionOrder'] = sectionOrder;
    data['courseOrder'] = courseOrder;
    return data;
  }
}

class TotalStatitics {
  int? netMaleCount;
  int? netFemaleCount;
  int? netTotal;

  TotalStatitics({this.netMaleCount, this.netFemaleCount, this.netTotal});

  TotalStatitics.fromJson(Map<String, dynamic> json) {
    netMaleCount = json['netMaleCount'];
    netFemaleCount = json['netFemaleCount'];
    netTotal = json['netTotal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['netMaleCount'] = netMaleCount;
    data['netFemaleCount'] = netFemaleCount;
    data['netTotal'] = netTotal;
    return data;
  }
}
