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
  int? noticeboardCount;
  int? anecdotalCount;
  int? homeworkcount;
  int? portionCount;
  CountmodelNotification({this.totalCount,this.noticeboardCount,this.anecdotalCount,this.homeworkcount,this.portionCount});

  CountmodelNotification.fromJson(Map<String, dynamic> json) {
    totalCount = json['totalCount'];
    noticeboardCount = json['noticeboardCount'];
    anecdotalCount = json['anecdotalCount'];
    homeworkcount =  json['homeworkcount'];
    portionCount =  json['portionCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalCount'] = this.totalCount;
    data['noticeboardCount'] = this.noticeboardCount;
    data['anecdotalCount'] = this.anecdotalCount;
    data['homeworkcount'] = this.homeworkcount;
    data['portionCount'] = this.portionCount;
    return data;

  }
}

class AppreviwId {
  String? appId;


  AppreviwId({this.appId,});

  AppreviwId.fromJson(Map<String, dynamic> json) {
    appId = json[''];

  }

  StringtoJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[''] = this.appId;
    return data;

  }
}