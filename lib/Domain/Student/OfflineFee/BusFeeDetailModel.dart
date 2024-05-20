class BusFEEDetailModel {
  List<FeesSummaryBusModel>? feesSummary;
  String? uploadedDate;
  bool? showConcessionColumn;
  String? busName;
  String? busStop;
  List<TotalListBus>? totalList;

  BusFEEDetailModel(
      {this.feesSummary,
      this.uploadedDate,
      this.showConcessionColumn,
      this.busName,
      this.busStop,
      this.totalList});

  BusFEEDetailModel.fromJson(Map<String, dynamic> json) {
    if (json['feesSummary'] != null) {
      feesSummary = <FeesSummaryBusModel>[];
      json['feesSummary'].forEach((v) {
        feesSummary!.add(FeesSummaryBusModel.fromJson(v));
      });
    }
    uploadedDate = json['uploadedDate'];
    showConcessionColumn = json['showConcessionColumn'];
    busName = json['busName'];
    busStop = json['busStop'];
    if (json['totalList'] != null) {
      totalList = <TotalListBus>[];
      json['totalList'].forEach((v) {
        totalList!.add(TotalListBus.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (feesSummary != null) {
      data['feesSummary'] = feesSummary!.map((v) => v.toJson()).toList();
    }
    data['uploadedDate'] = uploadedDate;
    data['showConcessionColumn'] = showConcessionColumn;
    data['busName'] = busName;
    data['busStop'] = busStop;
    if (totalList != null) {
      data['totalList'] = totalList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FeesSummaryBusModel {
  String? uploadedDate;
  String? installment;
  String? fineStartsFrom;
  double? amount;
  double? concessionAmount;
  double? paidAmount;
  double? balanceAmount;

  FeesSummaryBusModel({
    this.uploadedDate,
    this.installment,
    this.fineStartsFrom,
    this.amount,
    this.concessionAmount,
    this.paidAmount,
    this.balanceAmount,
  });

  FeesSummaryBusModel.fromJson(Map<String, dynamic> json) {
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

class TotalListBus {
  double? totalAmount;
  double? totalConcessionAmount;
  double? totalPaidAmount;
  double? totalBalanceAmount;

  TotalListBus(
      {this.totalAmount,
      this.totalConcessionAmount,
      this.totalPaidAmount,
      this.totalBalanceAmount});

  TotalListBus.fromJson(Map<String, dynamic> json) {
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
