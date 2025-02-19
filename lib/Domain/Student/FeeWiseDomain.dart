class FeesWise {
  bool? existFeeWisePayment;
  bool? webViewforMobileappPayment;

  FeesWise({this.existFeeWisePayment,this.webViewforMobileappPayment});

  FeesWise.fromJson(Map<String, dynamic> json) {
    existFeeWisePayment = json['existFeeWisePayment'];
    webViewforMobileappPayment = json['webViewforMobileappPayment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['existFeeWisePayment'] = existFeeWisePayment;
    data['webViewforMobileappPayment'] = webViewforMobileappPayment;
    return data;
  }
}


class FeesWiseFeesCollection {
  bool? existFeeOrderWisePayment;
  bool? installmentDueDateCheck;
  bool? isLocked;
  StudentDetails? studentDetails;
  List<GeneralFeesList>? generalFeesList;
  List<BusFeesList>? busFeesList;
  Order? order;
  String? concessionCaption;
  FeeOrderFeeWise? feeOrder;
  List<TransactiontypeFeesWise>? transactiontype;
  bool? hideBusFeesPayment;
  bool? instWiseForfeesWise;

  FeesWiseFeesCollection(
      {this.existFeeOrderWisePayment,
        this.installmentDueDateCheck,
        this.isLocked,
        this.studentDetails,
        this.generalFeesList,
        this.busFeesList,
        this.order,
        this.concessionCaption,
        this.feeOrder,
        this.transactiontype,
        this.hideBusFeesPayment,
        this.instWiseForfeesWise
      });

  FeesWiseFeesCollection.fromJson(Map<String, dynamic> json) {
    existFeeOrderWisePayment = json['existFeeOrderWisePayment'];
    installmentDueDateCheck = json['installmentDueDateCheck'];
    isLocked = json['isLocked'];
    studentDetails = json['studentDetails'] != null
        ? StudentDetails.fromJson(json['studentDetails'])
        : null;
    if (json['generalFeesList'] != null) {
      generalFeesList = <GeneralFeesList>[];
      json['generalFeesList'].forEach((v) {
        generalFeesList!.add(GeneralFeesList.fromJson(v));
      });
    }
    if (json['busFeesList'] != null) {
      busFeesList = <BusFeesList>[];
      json['busFeesList'].forEach((v) {
        busFeesList!.add(BusFeesList.fromJson(v));
      });
    }
    order = json['order'] != null ? Order.fromJson(json['order']) : null;
    concessionCaption = json['concessionCaption'];
    feeOrder = json['feeOrder'] != null
        ? FeeOrderFeeWise.fromJson(json['feeOrder'])
        : null;
    if (json['transactiontype'] != null) {
      transactiontype = <TransactiontypeFeesWise>[];
      json['transactiontype'].forEach((v) {
        transactiontype!.add(TransactiontypeFeesWise.fromJson(v));
      });
    }
    hideBusFeesPayment = json['hideBusFeesPayment'];
    instWiseForfeesWise = json['instWiseForfeesWise'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['existFeeOrderWisePayment'] = existFeeOrderWisePayment;
    data['installmentDueDateCheck'] = installmentDueDateCheck;
    data['isLocked'] = isLocked;
    if (studentDetails != null) {
      data['studentDetails'] = studentDetails!.toJson();
    }
    if (generalFeesList != null) {
      data['generalFeesList'] =
          generalFeesList!.map((v) => v.toJson()).toList();
    }
    if (busFeesList != null) {
      data['busFeesList'] = busFeesList!.map((v) => v.toJson()).toList();
    }
    if (order != null) {
      data['order'] = order!.toJson();
    }
    data['concessionCaption'] = concessionCaption;
    if (feeOrder != null) {
      data['feeOrder'] = feeOrder!.toJson();
    }
    if (transactiontype != null) {
      data['transactiontype'] =
          transactiontype!.map((v) => v.toJson()).toList();
    }
    data['hideBusFeesPayment'] = hideBusFeesPayment;
    data['instWiseForfeesWise'] = instWiseForfeesWise;
    return data;
  }
}

class StudentDetails {
  String? studentId;
  String? studentName;
  String? admissionNo;
  int? classNo;
  String? division;

  StudentDetails(
      {this.studentId,
        this.studentName,
        this.admissionNo,
        this.classNo,
        this.division});

  StudentDetails.fromJson(Map<String, dynamic> json) {
    studentId = json['studentId'];
    studentName = json['studentName'];
    admissionNo = json['admissionNo'];
    classNo = json['classNo'];
    division = json['division'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['studentId'] = studentId;
    data['studentName'] = studentName;
    data['admissionNo'] = admissionNo;
    data['classNo'] = classNo;
    data['division'] = division;
    return data;
  }
}

class GeneralFeesList {
  String? feesDetailsId;
  String? installmentName;
  int? offlineInstallmentId;
  double? installmentNetDue;
  double? concessionAmount;
  double? fineAmount;
  double? netDue;
  String? dueDate;
  bool? checkedInstallment;
  bool? disableInstallment;
  List<FeesDetails>? feesDetails;

  GeneralFeesList(
      {this.feesDetailsId,
        this.installmentName,
        this.offlineInstallmentId,
        this.installmentNetDue,
        this.concessionAmount,
        this.fineAmount,
        this.netDue,
        this.dueDate,
        this.checkedInstallment,
        this.disableInstallment,
        this.feesDetails});

  GeneralFeesList.fromJson(Map<String, dynamic> json) {
    feesDetailsId = json['feesDetailsId'];
    installmentName = json['installmentName'];
    offlineInstallmentId = json['offlineInstallmentId'];
    installmentNetDue = json['installmentNetDue'];
    concessionAmount = json['concessionAmount'];
    fineAmount = json['fineAmount'];
    netDue = json['netDue'];
    dueDate = json['dueDate'];
    checkedInstallment = json['checkedInstallment'];
    disableInstallment = json['disableInstallment'];
    if (json['feesDetails'] != null) {
      feesDetails = <FeesDetails>[];
      json['feesDetails'].forEach((v) {
        feesDetails!.add(FeesDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['feesDetailsId'] = feesDetailsId;
    data['installmentName'] = installmentName;
    data['offlineInstallmentId'] = offlineInstallmentId;
    data['installmentNetDue'] = installmentNetDue;
    data['concessionAmount'] = concessionAmount;
    data['fineAmount'] = fineAmount;
    data['netDue'] = netDue;
    data['dueDate'] = dueDate;
    data['checkedInstallment'] = checkedInstallment;
    data['disableInstallment'] = disableInstallment;
    if (feesDetails != null) {
      data['feesDetails'] = feesDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FeesDetails {
  String? feesName;
  int? offlineFeesId;
  double? feesDue;
  String? concessionCaption;
  int? feesOrder;
  double? feesNetDue;
  double? balanceAmount;
  double? totalPaidAmount;
  double? feesConcessionAmount;
  bool? checkedFees;
  bool? disableFees;

  FeesDetails(
      {this.feesName,
        this.offlineFeesId,
        this.feesDue,
        this.concessionCaption,
        this.feesOrder,
        this.feesNetDue,
        this.balanceAmount,
        this.totalPaidAmount,
        this.feesConcessionAmount,
        this.checkedFees,
        this.disableFees});

  FeesDetails.fromJson(Map<String, dynamic> json) {
    feesName = json['feesName'];
    offlineFeesId = json['offlineFeesId'];
    feesDue = json['feesDue'];
    concessionCaption = json['concessionCaption'];
    feesOrder = json['feesOrder'];
    feesNetDue = json['feesNetDue'];
    balanceAmount = json['balanceAmount'];
    totalPaidAmount = json['totalPaidAmount'];
    feesConcessionAmount = json['feesConcessionAmount'];
    checkedFees = json['checkedFees'];
    disableFees = json['disableFees'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['feesName'] = feesName;
    data['offlineFeesId'] = offlineFeesId;
    data['feesDue'] = feesDue;
    data['concessionCaption'] = concessionCaption;
    data['feesOrder'] = feesOrder;
    data['feesNetDue'] = feesNetDue;
    data['balanceAmount'] = balanceAmount;
    data['totalPaidAmount'] = totalPaidAmount;
    data['feesConcessionAmount'] = feesConcessionAmount;
    data['checkedFees'] = checkedFees;
    data['disableFees'] = disableFees;
    return data;
  }
}

class BusFeesList {
  String? feesDetailsId;
  String? onlineInstallmentId;
  int? offlineInstallmentId;
  int? installmentGroup;
  String? offlineBusGroupId;
  String? installmentName;
  double? installmentNetDue;
  double? netDue;
  double? fineAmount;
  double? balanceAmount;
  bool? checkedInstallment;
  bool? enableInstallment;
  bool? checkedFees;
  double? totalPaidAmount;
  String? dueDate;
  int? installmentOrder;

  BusFeesList(
      {this.feesDetailsId,
        this.onlineInstallmentId,
        this.offlineInstallmentId,
        this.installmentGroup,
        this.offlineBusGroupId,
        this.installmentName,
        this.installmentNetDue,
        this.netDue,
        this.fineAmount,
        this.balanceAmount,
        this.checkedInstallment,
        this.enableInstallment,
        this.checkedFees,
        this.totalPaidAmount,
        this.dueDate,
        this.installmentOrder});

  BusFeesList.fromJson(Map<String, dynamic> json) {
    feesDetailsId = json['feesDetailsId'];
    onlineInstallmentId = json['onlineInstallmentId'];
    offlineInstallmentId = json['offlineInstallmentId'];
    installmentGroup = json['installmentGroup'];
    offlineBusGroupId = json['offlineBusGroupId'];
    installmentName = json['installmentName'];
    installmentNetDue = json['installmentNetDue'];
    netDue = json['netDue'];
    fineAmount = json['fineAmount'];
    balanceAmount = json['balanceAmount'];
    checkedInstallment = json['checkedInstallment'];
    enableInstallment = json['enableInstallment'];
    checkedFees = json['checkedFees'];
    totalPaidAmount = json['totalPaidAmount'];
    dueDate = json['dueDate'];
    installmentOrder = json['installmentOrder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['feesDetailsId'] = feesDetailsId;
    data['onlineInstallmentId'] = onlineInstallmentId;
    data['offlineInstallmentId'] = offlineInstallmentId;
    data['installmentGroup'] = installmentGroup;
    data['offlineBusGroupId'] = offlineBusGroupId;
    data['installmentName'] = installmentName;
    data['installmentNetDue'] = installmentNetDue;
    data['netDue'] = netDue;
    data['fineAmount'] = fineAmount;
    data['balanceAmount'] = balanceAmount;
    data['checkedInstallment'] = checkedInstallment;
    data['enableInstallment'] = enableInstallment;
    data['checkedFees'] = checkedFees;
    data['totalPaidAmount'] = totalPaidAmount;
    data['dueDate'] = dueDate;
    data['installmentOrder'] = installmentOrder;
    return data;
  }
}

class Order {
  String? status;
  String? tranType;

  Order({this.status, this.tranType});

  Order.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    tranType = json['tranType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['tranType'] = tranType;
    return data;
  }
}

class FeeOrderFeeWise {
  String? lastOrderStatus;
  String? lastTransactionTypeId;
  String? lastTransactionTypeName;
  String? transactionId;
  String? lastTransactionDate;
  String? lastTransactionStartDate;
  double? lastTransactionAmount;
  int? lastOrderId;
  String? paymentGatewayId;
  String? readableOrderId;
  int? orderExpiry;

  FeeOrderFeeWise(
      {this.lastOrderStatus,
        this.lastTransactionTypeId,
        this.lastTransactionTypeName,
        this.transactionId,
        this.lastTransactionDate,
        this.lastTransactionStartDate,
        this.lastTransactionAmount,
        this.lastOrderId,
        this.paymentGatewayId,
        this.readableOrderId,
        this.orderExpiry});

  FeeOrderFeeWise.fromJson(Map<String, dynamic> json) {
    lastOrderStatus = json['lastOrderStatus'];
    lastTransactionTypeId = json['lastTransactionTypeId'];
    lastTransactionTypeName = json['lastTransactionTypeName'];
    transactionId = json['transactionId'];
    lastTransactionDate = json['lastTransactionDate'];
    lastTransactionStartDate = json['lastTransactionStartDate'];
    lastTransactionAmount = json['lastTransactionAmount'];
    lastOrderId = json['lastOrderId'];
    paymentGatewayId = json['paymentGatewayId'];
    readableOrderId = json['readableOrderId'];
    orderExpiry = json['orderExpiry'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lastOrderStatus'] = lastOrderStatus;
    data['lastTransactionTypeId'] = lastTransactionTypeId;
    data['lastTransactionTypeName'] = lastTransactionTypeName;
    data['transactionId'] = transactionId;
    data['lastTransactionDate'] = lastTransactionDate;
    data['lastTransactionStartDate'] = lastTransactionStartDate;
    data['lastTransactionAmount'] = lastTransactionAmount;
    data['lastOrderId'] = lastOrderId;
    data['paymentGatewayId'] = paymentGatewayId;
    data['readableOrderId'] = readableOrderId;
    data['orderExpiry'] = orderExpiry;
    return data;
  }
}

class TransactiontypeFeesWise {
  String? name;
  String? id;

  TransactiontypeFeesWise({this.name, this.id});

  TransactiontypeFeesWise.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    return data;
  }
}