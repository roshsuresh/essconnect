class NotifiCountModel {
  int? totalCount;

  NotifiCountModel({this.totalCount});

  NotifiCountModel.fromJson(Map<String, dynamic> json) {
    totalCount = json['totalCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalCount'] = this.totalCount;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalCount'] = this.totalCount;
    return data;
  }
}
