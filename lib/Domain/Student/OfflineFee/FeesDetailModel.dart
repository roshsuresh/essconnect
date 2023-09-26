class FeeDetailModel {
  List<FeesSummaryFEES>? feesSummary;
  bool? showInstallmentwiseSummary;
  String? uploadedDate;
  bool? showConcessionColumnFees;
  List<TotalListFees>? totalList;

  FeeDetailModel(
      {this.feesSummary,
      this.showInstallmentwiseSummary,
      this.uploadedDate,
      this.showConcessionColumnFees,
      this.totalList});

  FeeDetailModel.fromJson(Map<String, dynamic> json) {
    if (json['feesSummary'] != null) {
      feesSummary = <FeesSummaryFEES>[];
      json['feesSummary'].forEach((v) {
        feesSummary!.add(new FeesSummaryFEES.fromJson(v));
      });
    }
    showInstallmentwiseSummary = json['showInstallmentwiseSummary'];
    uploadedDate = json['uploadedDate'];
    showConcessionColumnFees = json['showConcessionColumn'];
    if (json['totalList'] != null) {
      totalList = <TotalListFees>[];
      json['totalList'].forEach((v) {
        totalList!.add(new TotalListFees.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.feesSummary != null) {
      data['feesSummary'] = this.feesSummary!.map((v) => v.toJson()).toList();
    }
    data['showInstallmentwiseSummary'] = this.showInstallmentwiseSummary;
    data['uploadedDate'] = this.uploadedDate;
    data['showConcessionColumn'] = this.showConcessionColumnFees;
    if (this.totalList != null) {
      data['totalList'] = this.totalList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FeesSummaryFEES {
  String? uploadedDate;
  String? installment;

  String? fineStartsFrom;
  double? amount;
  double? concessionAmount;
  double? paidAmount;
  double? balanceAmount;

  FeesSummaryFEES({
    this.uploadedDate,
    this.installment,
    this.fineStartsFrom,
    this.amount,
    this.concessionAmount,
    this.paidAmount,
    this.balanceAmount,
  });

  FeesSummaryFEES.fromJson(Map<String, dynamic> json) {
    uploadedDate = json['uploadedDate'];
    installment = json['installment'];

    fineStartsFrom = json['fineStartsFrom'];
    amount = json['amount'];
    concessionAmount = json['concessionAmount'];
    paidAmount = json['paidAmount'];
    balanceAmount = json['balanceAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uploadedDate'] = this.uploadedDate;
    data['installment'] = this.installment;

    data['fineStartsFrom'] = this.fineStartsFrom;
    data['amount'] = this.amount;
    data['concessionAmount'] = this.concessionAmount;
    data['paidAmount'] = this.paidAmount;
    data['balanceAmount'] = this.balanceAmount;

    return data;
  }
}

class TotalListFees {
  double? totalAmount;
  double? totalConcessionAmount;
  double? totalPaidAmount;
  double? totalBalanceAmount;

  TotalListFees(
      {this.totalAmount,
      this.totalConcessionAmount,
      this.totalPaidAmount,
      this.totalBalanceAmount});

  TotalListFees.fromJson(Map<String, dynamic> json) {
    totalAmount = json['totalAmount'];
    totalConcessionAmount = json['totalConcessionAmount'];
    totalPaidAmount = json['totalPaidAmount'];
    totalBalanceAmount = json['totalBalanceAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalAmount'] = this.totalAmount;
    data['totalConcessionAmount'] = this.totalConcessionAmount;
    data['totalPaidAmount'] = this.totalPaidAmount;
    data['totalBalanceAmount'] = this.totalBalanceAmount;
    return data;
  }
}
