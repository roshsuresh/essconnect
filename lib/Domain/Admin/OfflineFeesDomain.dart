class OfflineCourse {
  String? value;
  String? text;
  bool? selected;
  bool? active;
  int? order;

  OfflineCourse({this.value, this.text, this.selected, this.active, this.order});

  OfflineCourse.fromJson(Map<String, dynamic> json) {
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

//div
class OfflineFeeDiv {
  String? value;
  String? text;
  bool? selected;
  bool? active;
  String? order;

  OfflineFeeDiv(
      {this.value, this.text, this.selected, this.active, this.order});

  OfflineFeeDiv.fromJson(Map<String, dynamic> json) {
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

class OfflineFeeView {
  String? uploadedDate;
  List<Results>? results;
  List<ExportList>? exportList;
  double? netAmount;

  OfflineFeeView(
      {this.uploadedDate,
        this.results,
        this.exportList,
        this.netAmount});

  OfflineFeeView.fromJson(Map<String, dynamic> json) {
    uploadedDate = json['uploadedDate'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(new Results.fromJson(v));
      });
    }
    if (json['exportList'] != null) {
      exportList = <ExportList>[];
      json['exportList'].forEach((v) {
        exportList!.add(new ExportList.fromJson(v));
      });
    }
    netAmount = json['netAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uploadedDate'] = this.uploadedDate;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }

    if (this.exportList != null) {
      data['exportList'] = this.exportList!.map((v) => v.toJson()).toList();
    }
    data['netAmount'] = this.netAmount;
    return data;
  }
}

class Results {
  String? uploadedDate;
  String? billDate;
  String? studentId;
  String? billNo;
  String? admnNo;
  String? studentName;
  String? division;
  int? rollNo;
  double? amount;
  double? discount;
  bool? isCancelled;
  double? fine;
  double? totalAmount;

  Results(
      {this.uploadedDate,
        this.billDate,
        this.studentId,
        this.billNo,
        this.admnNo,
        this.studentName,
        this.division,
        this.rollNo,
        this.amount,
        this.discount,
        this.isCancelled,
        this.fine,
        this.totalAmount});

  Results.fromJson(Map<String, dynamic> json) {
    uploadedDate = json['uploadedDate'];
    billDate = json['billDate'];
    studentId = json['studentId'];
    billNo = json['billNo'];
    admnNo = json['admnNo'];
    studentName = json['studentName'];
    division = json['division'];
    rollNo = json['rollNo'];
    amount = json['amount'];
    discount = json['discount'];
    isCancelled = json['isCancelled'];
    fine = json['fine'];
    totalAmount = json['totalAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uploadedDate'] = this.uploadedDate;
    data['billDate'] = this.billDate;
    data['studentId'] = this.studentId;
    data['billNo'] = this.billNo;
    data['admnNo'] = this.admnNo;
    data['studentName'] = this.studentName;
    data['division'] = this.division;
    data['rollNo'] = this.rollNo;
    data['amount'] = this.amount;
    data['discount'] = this.discount;
    data['isCancelled'] = this.isCancelled;
    data['fine'] = this.fine;
    data['totalAmount'] = this.totalAmount;
    return data;
  }
}


class ExportList {
  String? uploadedDate;
  String? billDate;
  String? studentId;
  String? billNo;
  String? admnNo;
  String? studentName;
  String? division;
  int? rollNo;
  double? amount;
  double? discount;
  bool? isCancelled;
  double? fine;
  double? totalAmount;

  ExportList(
      {this.uploadedDate,
        this.billDate,
        this.studentId,
        this.billNo,
        this.admnNo,
        this.studentName,
        this.division,
        this.rollNo,
        this.amount,
        this.discount,
        this.isCancelled,
        this.fine,
        this.totalAmount});

  ExportList.fromJson(Map<String, dynamic> json) {
    uploadedDate = json['uploadedDate'];
    billDate = json['billDate'];
    studentId = json['studentId'];
    billNo = json['billNo'];
    admnNo = json['admnNo'];
    studentName = json['studentName'];
    division = json['division'];
    rollNo = json['rollNo'];
    amount = json['amount'];
    discount = json['discount'];
    isCancelled = json['isCancelled'];
    fine = json['fine'];
    totalAmount = json['totalAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uploadedDate'] = this.uploadedDate;
    data['billDate'] = this.billDate;
    data['studentId'] = this.studentId;
    data['billNo'] = this.billNo;
    data['admnNo'] = this.admnNo;
    data['studentName'] = this.studentName;
    data['division'] = this.division;
    data['rollNo'] = this.rollNo;
    data['amount'] = this.amount;
    data['discount'] = this.discount;
    data['isCancelled'] = this.isCancelled;
    data['fine'] = this.fine;
    data['totalAmount'] = this.totalAmount;
    return data;
  }
}


//excel

class FeesCollectionExport {
  String? name;
  String? extension;
  String? path;
  String? url;
  bool? isTemporary;
  bool? isDeleted;
  String? images;
  String? createdAt;
  String? id;

  FeesCollectionExport(
      {this.name,
        this.extension,
        this.path,
        this.url,
        this.isTemporary,
        this.isDeleted,
        this.images,
        this.createdAt,
        this.id});

  FeesCollectionExport.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    extension = json['extension'];
    path = json['path'];
    url = json['url'];
    isTemporary = json['isTemporary'];
    isDeleted = json['isDeleted'];
    images = json['images'];
    createdAt = json['createdAt'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['extension'] = this.extension;
    data['path'] = this.path;
    data['url'] = this.url;
    data['isTemporary'] = this.isTemporary;
    data['isDeleted'] = this.isDeleted;
    data['images'] = this.images;
    data['createdAt'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}


//bus
class BusFee {
  String? uploadedDate;
  List<BusResults>? results;
  List<BusExportList>? exportList;
  double? netAmount;

  BusFee(
      {this.uploadedDate,
        this.results,
        this.exportList,
        this.netAmount});

  BusFee.fromJson(Map<String, dynamic> json) {
    uploadedDate = json['uploadedDate'];
    if (json['results'] != null) {
      results = <BusResults>[];
      json['results'].forEach((v) {
        results!.add(new BusResults.fromJson(v));
      });
    }
    if (json['exportList'] != null) {
      exportList = <BusExportList>[];
      json['exportList'].forEach((v) {
        exportList!.add(new BusExportList.fromJson(v));
      });
    }
    netAmount = json['netAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uploadedDate'] = this.uploadedDate;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    if (this.exportList != null) {
      data['exportList'] = this.exportList!.map((v) => v.toJson()).toList();
    }
    data['netAmount'] = this.netAmount;
    return data;
  }
}

class BusResults {
  String? uploadedDate;
  String? billDate;
  String? studentId;
  String? billNo;
  String? admnNo;
  String? studentName;
  String? division;
  String? busStop;
  int? rollNo;
  double? amountPaid;
  double? discount;
  bool? isCancelled;
  double? fine;
  double? totalAmount;

  BusResults(
      {this.uploadedDate,
        this.billDate,
        this.studentId,
        this.billNo,
        this.admnNo,
        this.studentName,
        this.division,
        this.busStop,
        this.rollNo,
        this.amountPaid,
        this.discount,
        this.isCancelled,
        this.fine,
        this.totalAmount});

  BusResults.fromJson(Map<String, dynamic> json) {
    uploadedDate = json['uploadedDate'];
    billDate = json['billDate'];
    studentId = json['studentId'];
    billNo = json['billNo'];
    admnNo = json['admnNo'];
    studentName = json['studentName'];
    division = json['division'];
    busStop = json['busStop'];
    rollNo = json['rollNo'];
    amountPaid = json['amountPaid'];
    discount = json['discount'];
    isCancelled = json['isCancelled'];
    fine = json['fine'];
    totalAmount = json['totalAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uploadedDate'] = this.uploadedDate;
    data['billDate'] = this.billDate;
    data['studentId'] = this.studentId;
    data['billNo'] = this.billNo;
    data['admnNo'] = this.admnNo;
    data['studentName'] = this.studentName;
    data['division'] = this.division;
    data['busStop'] = this.busStop;
    data['rollNo'] = this.rollNo;
    data['amountPaid'] = this.amountPaid;
    data['discount'] = this.discount;
    data['isCancelled'] = this.isCancelled;
    data['fine'] = this.fine;
    data['totalAmount'] = this.totalAmount;
    return data;
  }
}



class BusExportList {
  String? uploadedDate;
  String? billDate;
  String? studentId;
  String? billNo;
  String? admnNo;
  String? studentName;
  String? division;
  String? busStop;
  int? rollNo;
  double? amountPaid;
  double? discount;
  bool? isCancelled;
  double? fine;
  double? totalAmount;

  BusExportList(
      {this.uploadedDate,
        this.billDate,
        this.studentId,
        this.billNo,
        this.admnNo,
        this.studentName,
        this.division,
        this.busStop,
        this.rollNo,
        this.amountPaid,
        this.discount,
        this.isCancelled,
        this.fine,
        this.totalAmount});

  BusExportList.fromJson(Map<String, dynamic> json) {
    uploadedDate = json['uploadedDate'];
    billDate = json['billDate'];
    studentId = json['studentId'];
    billNo = json['billNo'];
    admnNo = json['admnNo'];
    studentName = json['studentName'];
    division = json['division'];
    busStop = json['busStop'];
    rollNo = json['rollNo'];
    amountPaid = json['amountPaid'];
    discount = json['discount'];
    isCancelled = json['isCancelled'];
    fine = json['fine'];
    totalAmount = json['totalAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uploadedDate'] = this.uploadedDate;
    data['billDate'] = this.billDate;
    data['studentId'] = this.studentId;
    data['billNo'] = this.billNo;
    data['admnNo'] = this.admnNo;
    data['studentName'] = this.studentName;
    data['division'] = this.division;
    data['busStop'] = this.busStop;
    data['rollNo'] = this.rollNo;
    data['amountPaid'] = this.amountPaid;
    data['discount'] = this.discount;
    data['isCancelled'] = this.isCancelled;
    data['fine'] = this.fine;
    data['totalAmount'] = this.totalAmount;
    return data;
  }
}
