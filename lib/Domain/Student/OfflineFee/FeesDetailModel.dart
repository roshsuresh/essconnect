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
        feesSummary!.add(FeesSummaryFEES.fromJson(v));
      });
    }
    showInstallmentwiseSummary = json['showInstallmentwiseSummary'];
    uploadedDate = json['uploadedDate'];
    showConcessionColumnFees = json['showConcessionColumn'];
    if (json['totalList'] != null) {
      totalList = <TotalListFees>[];
      json['totalList'].forEach((v) {
        totalList!.add(TotalListFees.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (feesSummary != null) {
      data['feesSummary'] = feesSummary!.map((v) => v.toJson()).toList();
    }
    data['showInstallmentwiseSummary'] = showInstallmentwiseSummary;
    data['uploadedDate'] = uploadedDate;
    data['showConcessionColumn'] = showConcessionColumnFees;
    if (totalList != null) {
      data['totalList'] = totalList!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uploadedDate'] = uploadedDate;
    data['installment'] = installment;

    data['fineStartsFrom'] = fineStartsFrom;
    data['amount'] = amount;
    data['concessionAmount'] = concessionAmount;
    data['paidAmount'] = paidAmount;
    data['balanceAmount'] = balanceAmount;

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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalAmount'] = totalAmount;
    data['totalConcessionAmount'] = totalConcessionAmount;
    data['totalPaidAmount'] = totalPaidAmount;
    data['totalBalanceAmount'] = totalBalanceAmount;
    return data;
  }
}
