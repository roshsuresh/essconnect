class FeeDetailsAdmin {
  FeeCollectionPopupDetails? feeCollectionPopupDetails;

  FeeDetailsAdmin({this.feeCollectionPopupDetails});

  FeeDetailsAdmin.fromJson(Map<String, dynamic> json) {
    feeCollectionPopupDetails = json['feeCollectionPopupDetails'] != null
        ? FeeCollectionPopupDetails.fromJson(json['feeCollectionPopupDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (feeCollectionPopupDetails != null) {
      data['feeCollectionPopupDetails'] = feeCollectionPopupDetails!.toJson();
    }
    return data;
  }
}

class FeeCollectionPopupDetails {
  String? totalpaid;
  StudentAllDetails? studentAllDetails;
  List<GeneralCollectDetails>? generalCollectDetails;
  List<BusCollectDetails>? busCollectDetails;
  FeeCollectionPopupDetails(
      {this.totalpaid,
      this.studentAllDetails,
      this.generalCollectDetails,
      this.busCollectDetails});

  FeeCollectionPopupDetails.fromJson(Map<String, dynamic> json) {
    totalpaid = json['totalpaid'];
    studentAllDetails = json['studentAllDetails'] != null
        ? StudentAllDetails.fromJson(json['studentAllDetails'])
        : null;
    if (json['generalCollectDetails'] != null) {
      generalCollectDetails = <GeneralCollectDetails>[];
      json['generalCollectDetails'].forEach((v) {
        generalCollectDetails!.add(GeneralCollectDetails.fromJson(v));
      });
    }
    if (json['busCollectDetails'] != null) {
      busCollectDetails = <BusCollectDetails>[];
      json['busCollectDetails'].forEach((v) {
        busCollectDetails!.add(BusCollectDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalpaid'] = totalpaid;
    if (studentAllDetails != null) {
      data['studentAllDetails'] = studentAllDetails!.toJson();
    }
    if (generalCollectDetails != null) {
      data['generalCollectDetails'] =
          generalCollectDetails!.map((v) => v.toJson()).toList();
    }
    if (busCollectDetails != null) {
      data['busCollectDetails'] =
          busCollectDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StudentAllDetails {
  String? feeCollectionId;
  String? busFeeCollectionId;
  String? admissionNo;
  String? name;
  String? division;
  String? orderId;
  String? transactionId;
  String? transactionDate;
  String? studentId;

  StudentAllDetails(
      {this.feeCollectionId,
      this.busFeeCollectionId,
      this.admissionNo,
      this.name,
      this.division,
      this.orderId,
      this.transactionId,
      this.transactionDate,
      this.studentId});

  StudentAllDetails.fromJson(Map<String, dynamic> json) {
    feeCollectionId = json['feeCollectionId'];
    busFeeCollectionId = json['busFeeCollectionId'];
    admissionNo = json['admissionNo'];
    name = json['name'];
    division = json['division'];
    orderId = json['orderId'];
    transactionId = json['transactionId'];
    transactionDate = json['transactionDate'];
    studentId = json['studentId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['feeCollectionId'] = feeCollectionId;
    data['busFeeCollectionId'] = busFeeCollectionId;
    data['admissionNo'] = admissionNo;
    data['name'] = name;
    data['division'] = division;
    data['orderId'] = orderId;
    data['transactionId'] = transactionId;
    data['transactionDate'] = transactionDate;
    data['studentId'] = studentId;
    return data;
  }
}

class GeneralCollectDetails {
  String? feeCollectionId;
  String? busFeeCollectionId;
  String? dueAmount;
  double? concessionAmount;
  double? fineAmount;
  double? netDue;
  double? paidAmount;
  String? installmentname;

  GeneralCollectDetails(
      {this.feeCollectionId,
      this.busFeeCollectionId,
      this.dueAmount,
      this.concessionAmount,
      this.fineAmount,
      this.netDue,
      this.paidAmount,
      this.installmentname});

  GeneralCollectDetails.fromJson(Map<String, dynamic> json) {
    feeCollectionId = json['feeCollectionId'];
    busFeeCollectionId = json['busFeeCollectionId'];
    dueAmount = json['dueAmount'];
    concessionAmount = json['concessionAmount'];
    fineAmount = json['fineAmount'];
    netDue = json['netDue'];
    paidAmount = json['paidAmount'];
    installmentname = json['installmentname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['feeCollectionId'] = feeCollectionId;
    data['busFeeCollectionId'] = busFeeCollectionId;
    data['dueAmount'] = dueAmount;
    data['concessionAmount'] = concessionAmount;
    data['fineAmount'] = fineAmount;
    data['netDue'] = netDue;
    data['paidAmount'] = paidAmount;
    data['installmentname'] = installmentname;
    return data;
  }
}

class BusCollectDetails {
  String? feeCollectionId;
  String? busFeeCollectionId;
  String? dueAmount;
  double? netDue;
  double? paidAmount;
  String? installmentname;
  double? concessionAmount;
  double? fineAmount;

  BusCollectDetails(
      {this.feeCollectionId,
      this.busFeeCollectionId,
      this.dueAmount,
      this.netDue,
      this.paidAmount,
      this.installmentname,
      this.concessionAmount,
      this.fineAmount});

  BusCollectDetails.fromJson(Map<String, dynamic> json) {
    feeCollectionId = json['feeCollectionId'];
    busFeeCollectionId = json['busFeeCollectionId'];
    dueAmount = json['dueAmount'];
    netDue = json['netDue'];
    paidAmount = json['paidAmount'];
    installmentname = json['installmentname'];
    concessionAmount = json['concessionAmount'];
    fineAmount = json['fineAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['feeCollectionId'] = feeCollectionId;
    data['busFeeCollectionId'] = busFeeCollectionId;
    data['dueAmount'] = dueAmount;
    data['netDue'] = netDue;
    data['paidAmount'] = paidAmount;
    data['installmentname'] = installmentname;
    data['concessionAmount'] = concessionAmount;
    data['fineAmount'] = fineAmount;
    return data;
  }
}
