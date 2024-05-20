class BusFEEPAIDModel {
  List<DetailedFeesSummaryList>? detailedFeesSummary;
  bool? showConcession;
  String? uploadedDate;

  BusFEEPAIDModel(
      {this.detailedFeesSummary, this.showConcession, this.uploadedDate});

  BusFEEPAIDModel.fromJson(Map<String, dynamic> json) {
    if (json['detailedFeesSummary'] != null) {
      detailedFeesSummary = <DetailedFeesSummaryList>[];
      json['detailedFeesSummary'].forEach((v) {
        detailedFeesSummary!.add(DetailedFeesSummaryList.fromJson(v));
      });
    }
    showConcession = json['showConcession'];
    uploadedDate = json['uploadedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (detailedFeesSummary != null) {
      data['detailedFeesSummary'] =
          detailedFeesSummary!.map((v) => v.toJson()).toList();
    }
    data['showConcession'] = showConcession;
    data['uploadedDate'] = uploadedDate;
    return data;
  }
}

class DetailedFeesSummaryList {
  String? uploadedDate;
  String? receiptDate;
  String? receiptNumber;
  bool? isCancelled;
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

  DetailedFeesSummaryList(
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

  DetailedFeesSummaryList.fromJson(Map<String, dynamic> json) {
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
        detailedFeesList!.add(DetailedFeesList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uploadedDate'] = uploadedDate;
    data['receiptDate'] = receiptDate;
    data['receiptNumber'] = receiptNumber;
    data['isCancelled'] = isCancelled;
    data['fine'] = fine;
    data['subsidy'] = subsidy;
    data['totalAmount'] = totalAmount;
    data['totalConcessionAmount'] = totalConcessionAmount;
    data['totalPaidAmount'] = totalPaidAmount;
    data['netAmount'] = netAmount;
    data['totalActualAmount'] = totalActualAmount;
    data['totalConAmount'] = totalConAmount;
    data['netTotalAmount'] = netTotalAmount;
    if (detailedFeesList != null) {
      data['detailedFeesList'] =
          detailedFeesList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DetailedFeesList {
  String? installment;

  double? actualAmount;
  double? concessionAmount;
  double? amount;

  DetailedFeesList(
      {this.installment,
      this.actualAmount,
      this.concessionAmount,
      this.amount});

  DetailedFeesList.fromJson(Map<String, dynamic> json) {
    installment = json['installment'];

    actualAmount = json['actualAmount'];
    concessionAmount = json['concessionAmount'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['installment'] = installment;

    data['actualAmount'] = actualAmount;
    data['concessionAmount'] = concessionAmount;
    data['amount'] = amount;
    return data;
  }
}
