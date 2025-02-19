class FeePaidModel {
  List<DetailedFeesSummary>? detailedFeesSummary;
  bool? showConcession;
  String? uploadedDate;
  bool? showFeesWise;

  FeePaidModel(
      {this.detailedFeesSummary,
        this.showConcession,
        this.uploadedDate,
        this.showFeesWise});

  FeePaidModel.fromJson(Map<String, dynamic> json) {
    if (json['detailedFeesSummary'] != null) {
      detailedFeesSummary = <DetailedFeesSummary>[];
      json['detailedFeesSummary'].forEach((v) {
        detailedFeesSummary!.add(new DetailedFeesSummary.fromJson(v));
      });
    }
    showConcession = json['showConcession'];
    uploadedDate = json['uploadedDate'];
    showFeesWise = json['showFeesWise'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.detailedFeesSummary != null) {
      data['detailedFeesSummary'] =
          this.detailedFeesSummary!.map((v) => v.toJson()).toList();
    }
    data['showConcession'] = this.showConcession;
    data['uploadedDate'] = this.uploadedDate;
    data['showFeesWise'] = this.showFeesWise;
    return data;
  }
}

class DetailedFeesSummary {
  String? uploadedDate;
  String? receiptDate;
  String? receiptNumber;
  String? isCancelled;
  double? fine;
  double? subsidy;
  double? totalAmount;
  double? totalConcessionAmount;
  double? totalPaidAmount;
  double? netAmount;
  double? totalActualAmount;
  double? totalConAmount;
  double? netTotalAmount;
  List<DetailedFeesList>? detailedFeesList;

  DetailedFeesSummary(
      {this.uploadedDate,
        this.receiptDate,
        this.receiptNumber,
        this.isCancelled,
        this.fine,
        this.subsidy,
        this.totalAmount,
        this.totalConcessionAmount,
        this.totalPaidAmount,
        this.netAmount,
        this.totalActualAmount,
        this.totalConAmount,
        this.netTotalAmount,
        this.detailedFeesList});

  DetailedFeesSummary.fromJson(Map<String, dynamic> json) {
    uploadedDate = json['uploadedDate'];
    receiptDate = json['receiptDate'];
    receiptNumber = json['receiptNumber'];
    isCancelled = json['isCancelled'];
    fine = json['fine'];
    subsidy = json['subsidy'];
    totalAmount = json['totalAmount'];
    totalConcessionAmount = json['totalConcessionAmount'];
    totalPaidAmount = json['totalPaidAmount'];
    netAmount = json['netAmount'];
    totalActualAmount = json['totalActualAmount'];
    totalConAmount = json['totalConAmount'];
    netTotalAmount = json['netTotalAmount'];
    if (json['detailedFeesList'] != null) {
      detailedFeesList = <DetailedFeesList>[];
      json['detailedFeesList'].forEach((v) {
        detailedFeesList!.add(new DetailedFeesList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uploadedDate'] = this.uploadedDate;
    data['receiptDate'] = this.receiptDate;
    data['receiptNumber'] = this.receiptNumber;
    data['isCancelled'] = this.isCancelled;
    data['fine'] = this.fine;
    data['subsidy'] = this.subsidy;
    data['totalAmount'] = this.totalAmount;
    data['totalConcessionAmount'] = this.totalConcessionAmount;
    data['totalPaidAmount'] = this.totalPaidAmount;
    data['netAmount'] = this.netAmount;
    data['totalActualAmount'] = this.totalActualAmount;
    data['totalConAmount'] = this.totalConAmount;
    data['netTotalAmount'] = this.netTotalAmount;
    if (this.detailedFeesList != null) {
      data['detailedFeesList'] =
          this.detailedFeesList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DetailedFeesList {
  String? installment;
  String? fees;
  double? actualAmount;
  double? concessionAmount;
  double? amount;

  DetailedFeesList(
      {this.installment,
        this.fees,
        this.actualAmount,
        this.concessionAmount,
        this.amount});

  DetailedFeesList.fromJson(Map<String, dynamic> json) {
    installment = json['installment'];
    fees = json['fees'];
    actualAmount = json['actualAmount'];
    concessionAmount = json['concessionAmount'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['installment'] = this.installment;
    data['fees'] = this.fees;
    data['actualAmount'] = this.actualAmount;
    data['concessionAmount'] = this.concessionAmount;
    data['amount'] = this.amount;
    return data;
  }
}
