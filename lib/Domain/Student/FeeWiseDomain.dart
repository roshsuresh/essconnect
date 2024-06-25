class FeesWise {
  bool? existFeeWisePayment;

  FeesWise({this.existFeeWisePayment});

  FeesWise.fromJson(Map<String, dynamic> json) {
    existFeeWisePayment = json['existFeeWisePayment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['existFeeWisePayment'] = this.existFeeWisePayment;
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
        ? new StudentDetails.fromJson(json['studentDetails'])
        : null;
    if (json['generalFeesList'] != null) {
      generalFeesList = <GeneralFeesList>[];
      json['generalFeesList'].forEach((v) {
        generalFeesList!.add(new GeneralFeesList.fromJson(v));
      });
    }
    if (json['busFeesList'] != null) {
      busFeesList = <BusFeesList>[];
      json['busFeesList'].forEach((v) {
        busFeesList!.add(new BusFeesList.fromJson(v));
      });
    }
    order = json['order'] != null ? new Order.fromJson(json['order']) : null;
    concessionCaption = json['concessionCaption'];
    feeOrder = json['feeOrder'] != null
        ? new FeeOrderFeeWise.fromJson(json['feeOrder'])
        : null;
    if (json['transactiontype'] != null) {
      transactiontype = <TransactiontypeFeesWise>[];
      json['transactiontype'].forEach((v) {
        transactiontype!.add(new TransactiontypeFeesWise.fromJson(v));
      });
    }
    hideBusFeesPayment = json['hideBusFeesPayment'];
    instWiseForfeesWise = json['instWiseForfeesWise'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['existFeeOrderWisePayment'] = this.existFeeOrderWisePayment;
    data['installmentDueDateCheck'] = this.installmentDueDateCheck;
    data['isLocked'] = this.isLocked;
    if (this.studentDetails != null) {
      data['studentDetails'] = this.studentDetails!.toJson();
    }
    if (this.generalFeesList != null) {
      data['generalFeesList'] =
          this.generalFeesList!.map((v) => v.toJson()).toList();
    }
    if (this.busFeesList != null) {
      data['busFeesList'] = this.busFeesList!.map((v) => v.toJson()).toList();
    }
    if (this.order != null) {
      data['order'] = this.order!.toJson();
    }
    data['concessionCaption'] = this.concessionCaption;
    if (this.feeOrder != null) {
      data['feeOrder'] = this.feeOrder!.toJson();
    }
    if (this.transactiontype != null) {
      data['transactiontype'] =
          this.transactiontype!.map((v) => v.toJson()).toList();
    }
    data['hideBusFeesPayment'] = this.hideBusFeesPayment;
    data['instWiseForfeesWise'] = this.instWiseForfeesWise;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['studentId'] = this.studentId;
    data['studentName'] = this.studentName;
    data['admissionNo'] = this.admissionNo;
    data['classNo'] = this.classNo;
    data['division'] = this.division;
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
        feesDetails!.add(new FeesDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['feesDetailsId'] = this.feesDetailsId;
    data['installmentName'] = this.installmentName;
    data['offlineInstallmentId'] = this.offlineInstallmentId;
    data['installmentNetDue'] = this.installmentNetDue;
    data['concessionAmount'] = this.concessionAmount;
    data['fineAmount'] = this.fineAmount;
    data['netDue'] = this.netDue;
    data['dueDate'] = this.dueDate;
    data['checkedInstallment'] = this.checkedInstallment;
    data['disableInstallment'] = this.disableInstallment;
    if (this.feesDetails != null) {
      data['feesDetails'] = this.feesDetails!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['feesName'] = this.feesName;
    data['offlineFeesId'] = this.offlineFeesId;
    data['feesDue'] = this.feesDue;
    data['concessionCaption'] = this.concessionCaption;
    data['feesOrder'] = this.feesOrder;
    data['feesNetDue'] = this.feesNetDue;
    data['balanceAmount'] = this.balanceAmount;
    data['totalPaidAmount'] = this.totalPaidAmount;
    data['feesConcessionAmount'] = this.feesConcessionAmount;
    data['checkedFees'] = this.checkedFees;
    data['disableFees'] = this.disableFees;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['feesDetailsId'] = this.feesDetailsId;
    data['onlineInstallmentId'] = this.onlineInstallmentId;
    data['offlineInstallmentId'] = this.offlineInstallmentId;
    data['installmentGroup'] = this.installmentGroup;
    data['offlineBusGroupId'] = this.offlineBusGroupId;
    data['installmentName'] = this.installmentName;
    data['installmentNetDue'] = this.installmentNetDue;
    data['netDue'] = this.netDue;
    data['fineAmount'] = this.fineAmount;
    data['balanceAmount'] = this.balanceAmount;
    data['checkedInstallment'] = this.checkedInstallment;
    data['enableInstallment'] = this.enableInstallment;
    data['checkedFees'] = this.checkedFees;
    data['totalPaidAmount'] = this.totalPaidAmount;
    data['dueDate'] = this.dueDate;
    data['installmentOrder'] = this.installmentOrder;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['tranType'] = this.tranType;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lastOrderStatus'] = this.lastOrderStatus;
    data['lastTransactionTypeId'] = this.lastTransactionTypeId;
    data['lastTransactionTypeName'] = this.lastTransactionTypeName;
    data['transactionId'] = this.transactionId;
    data['lastTransactionDate'] = this.lastTransactionDate;
    data['lastTransactionStartDate'] = this.lastTransactionStartDate;
    data['lastTransactionAmount'] = this.lastTransactionAmount;
    data['lastOrderId'] = this.lastOrderId;
    data['paymentGatewayId'] = this.paymentGatewayId;
    data['readableOrderId'] = this.readableOrderId;
    data['orderExpiry'] = this.orderExpiry;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    return data;
  }
}