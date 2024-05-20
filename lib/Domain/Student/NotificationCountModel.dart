class NotifiCountModel {
  int? totalCount;

  NotifiCountModel({this.totalCount});

  NotifiCountModel.fromJson(Map<String, dynamic> json) {
    totalCount = json['totalCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalCount'] = totalCount;
    return data;
  }
}

//Count new

class CountmodelNotification {
  int? totalCount;

  CountmodelNotification({this.totalCount});

  CountmodelNotification.fromJson(Map<String, dynamic> json) {
    totalCount = json['totalCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalCount'] = totalCount;
    return data;
  }
}
