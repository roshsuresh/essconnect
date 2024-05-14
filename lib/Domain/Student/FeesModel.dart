class FeeInitialModel {
  OnlineFeePayModel? onlineFeePaymentStudentDetails;
  bool? isLocked;
  // IsBankAdmnNoCheck? isBankAdmnNoCheck;
  bool? installmentDueDateCheck;
  bool? isExistFeegroup;
  bool? isBusFeeGeneralFeeTogether;

  FeeInitialModel(
      {this.onlineFeePaymentStudentDetails,
      this.isLocked,
      // this.isBankAdmnNoCheck,
      this.installmentDueDateCheck,
      this.isExistFeegroup,
      this.isBusFeeGeneralFeeTogether});

  FeeInitialModel.fromJson(Map<String, dynamic> json) {
    onlineFeePaymentStudentDetails =
        json['onlineFeePaymentStudentDetails'] != null
            ? OnlineFeePayModel.fromJson(json['onlineFeePaymentStudentDetails'])
            : null;
    isLocked = json['isLocked'];
    // isBankAdmnNoCheck = json['isBankAdmnNoCheck'] != null
    //     ? new IsBankAdmnNoCheck.fromJson(json['isBankAdmnNoCheck'])
    //     : null;
    installmentDueDateCheck = json['installmentDueDateCheck'];
    isExistFeegroup = json['isExistFeegroup'];
    isBusFeeGeneralFeeTogether = json['isBusFeeGeneralFeeTogether'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.onlineFeePaymentStudentDetails != null) {
      data['onlineFeePaymentStudentDetails'] =
          this.onlineFeePaymentStudentDetails!.toJson();
    }
    data['isLocked'] = this.isLocked;
    // if (this.isBankAdmnNoCheck != null) {
    //   data['isBankAdmnNoCheck'] = this.isBankAdmnNoCheck!.toJson();
    // }
    data['installmentDueDateCheck'] = this.installmentDueDateCheck;
    data['isExistFeegroup'] = this.isExistFeegroup;
    data['isBusFeeGeneralFeeTogether'] = this.isBusFeeGeneralFeeTogether;
    return data;
  }
}

class OnlineFeePayModel {
  bool? allowPartialPayment;
  // Null? concessionCaption;
  StudentDetailsList? studentDetailsList;
  List<FeeFeesInstallments>? feeFeesInstallments;
  List<FeeBusInstallments>? feeBusInstallments;
  Order? order;
  FeeOrder? feeOrder;
  List<Transactiontype>? transactiontype;

  OnlineFeePayModel(
      {this.allowPartialPayment,
      //this.concessionCaption,
      this.studentDetailsList,
      this.feeFeesInstallments,
      this.feeBusInstallments,
      this.order,
      this.feeOrder,
      this.transactiontype});

  OnlineFeePayModel.fromJson(Map<String, dynamic> json) {
    allowPartialPayment = json['allowPartialPayment'];
    // concessionCaption = json['concessionCaption'];
    studentDetailsList = json['studentDetailsList'] != null
        ? new StudentDetailsList.fromJson(json['studentDetailsList'])
        : null;
    if (json['feeFeesInstallments'] != null) {
      feeFeesInstallments = <FeeFeesInstallments>[];
      json['feeFeesInstallments'].forEach((v) {
        feeFeesInstallments!.add(new FeeFeesInstallments.fromJson(v));
      });
    }
    if (json['feeBusInstallments'] != null) {
      feeBusInstallments = <FeeBusInstallments>[];
      json['feeBusInstallments'].forEach((v) {
        feeBusInstallments!.add(new FeeBusInstallments.fromJson(v));
      });
    }
    order = json['order'] != null ? new Order.fromJson(json['order']) : null;
    feeOrder = json['feeOrder'] != null
        ? new FeeOrder.fromJson(json['feeOrder'])
        : null;
    if (json['transactiontype'] != null) {
      transactiontype = <Transactiontype>[];
      json['transactiontype'].forEach((v) {
        transactiontype!.add(new Transactiontype.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['allowPartialPayment'] = this.allowPartialPayment;
    //  data['concessionCaption'] = this.concessionCaption;
    if (this.studentDetailsList != null) {
      data['studentDetailsList'] = this.studentDetailsList!.toJson();
    }
    if (this.feeFeesInstallments != null) {
      data['feeFeesInstallments'] =
          this.feeFeesInstallments!.map((v) => v.toJson()).toList();
    }
    if (this.feeBusInstallments != null) {
      data['feeBusInstallments'] =
          this.feeBusInstallments!.map((v) => v.toJson()).toList();
    }
    if (this.order != null) {
      data['order'] = this.order!.toJson();
    }
    if (this.feeOrder != null) {
      data['feeOrder'] = this.feeOrder!.toJson();
    }
    if (this.transactiontype != null) {
      data['transactiontype'] =
          this.transactiontype!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StudentDetailsList {
  String? studentId;
  String? studentName;
  String? admissionNo;
  int? classNo;
  String? division;

  StudentDetailsList(
      {this.studentId,
      this.studentName,
      this.admissionNo,
      this.classNo,
      this.division});

  StudentDetailsList.fromJson(Map<String, dynamic> json) {
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

class FeeFeesInstallments {
  String? feesDetailsId;
  String? installmentName;
  int? installmentGroup;
  double? installmentNetDue;
  double? concessionAmount;
  double? netDue;
  double? fineAmount;
  double? balanceAmount;
  bool? checkedInstallment;
  bool? enableInstallment;
  bool? checkedFees;
  double? totalPaidAmount;
  bool? enabled;
  bool? selected;

  FeeFeesInstallments(
      {this.feesDetailsId,
      this.installmentName,
        this.installmentGroup,
      this.installmentNetDue,
      this.concessionAmount,
      this.netDue,
      this.fineAmount,
      this.balanceAmount,
      this.checkedInstallment,
      this.enableInstallment,
      this.checkedFees,
      this.totalPaidAmount,
      this.enabled,
      this.selected});

  FeeFeesInstallments.fromJson(Map<String, dynamic> json) {
    feesDetailsId = json['feesDetailsId'];
    installmentName = json['installmentName'];
    installmentGroup = json['installmentGroup'];
    installmentNetDue = json['installmentNetDue'];
    concessionAmount = json['concessionAmount'];
    netDue = json['netDue'];
    fineAmount = json['fineAmount'];
    balanceAmount = json['balanceAmount'];
    checkedInstallment = json['checkedInstallment'];
    enableInstallment = json['enableInstallment'];
    checkedFees = json['checkedFees'];
    totalPaidAmount = json['totalPaidAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['feesDetailsId'] = this.feesDetailsId;
    data['installmentName'] = this.installmentName;
    data['installmentGroup'] = this.installmentGroup;
    data['installmentNetDue'] = this.installmentNetDue;
    data['concessionAmount'] = this.concessionAmount;
    data['netDue'] = this.netDue;
    data['fineAmount'] = this.fineAmount;
    data['balanceAmount'] = this.balanceAmount;
    data['checkedInstallment'] = this.checkedInstallment;
    data['enableInstallment'] = this.enableInstallment;
    data['checkedFees'] = this.checkedFees;
    data['totalPaidAmount'] = this.totalPaidAmount;
    return data;
  }
}

class FeeBusInstallments {
  String? feesDetailsId;
  String? installmentName;
  int? installmentGroup;
  String? offlineBusGroupId;
  double? installmentNetDue;
  double? netDue;
  double? fineAmount;
  double? balanceAmount;
  bool? checkedInstallment;
  bool? enableInstallment;
  bool? checkedFees;
  double? totalPaidAmount;
  bool? enabled;
  bool? selected;

  FeeBusInstallments(
      {this.feesDetailsId,
      this.installmentName,
        this.installmentGroup,
        this.offlineBusGroupId,
      this.installmentNetDue,
      this.netDue,
      this.fineAmount,
      this.balanceAmount,
      this.checkedInstallment,
      this.enableInstallment,
      this.checkedFees,
      this.totalPaidAmount,
      this.enabled,
      this.selected});

  FeeBusInstallments.fromJson(Map<String, dynamic> json) {
    feesDetailsId = json['feesDetailsId'];
    installmentName = json['installmentName'];
    installmentGroup = json['installmentGroup'];
    offlineBusGroupId = json['offlineBusGroupId'];
    installmentNetDue = json['installmentNetDue'];
    netDue = json['netDue'];
    fineAmount = json['fineAmount'];
    balanceAmount = json['balanceAmount'];
    checkedInstallment = json['checkedInstallment'];
    enableInstallment = json['enableInstallment'];
    checkedFees = json['checkedFees'];
    totalPaidAmount = json['totalPaidAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['feesDetailsId'] = this.feesDetailsId;
    data['installmentName'] = this.installmentName;
    data['installmentGroup'] = this.installmentGroup;
    data['offlineBusGroupId'] = this.offlineBusGroupId;
    data['installmentNetDue'] = this.installmentNetDue;
    data['netDue'] = this.netDue;
    data['fineAmount'] = this.fineAmount;
    data['balanceAmount'] = this.balanceAmount;
    data['checkedInstallment'] = this.checkedInstallment;
    data['enableInstallment'] = this.enableInstallment;
    data['checkedFees'] = this.checkedFees;
    data['totalPaidAmount'] = this.totalPaidAmount;
    return data;
  }
}

class FeesStore {
  String? storeFeesDetailsId;
  String? feesName;
  double? amount;
  String? vendorCode;
  bool? selected;
  bool? enabled;

  FeesStore(
      {this.storeFeesDetailsId,
        this.feesName,
        this.amount,
        this.vendorCode,
       this.selected,
        this.enabled
      });

  FeesStore.fromJson(Map<String, dynamic> json) {
    storeFeesDetailsId = json['storeFeesDetailsId'];
    feesName = json['feesName'];
    amount = json['amount'];
    vendorCode = json['vendorCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['storeFeesDetailsId'] = this.storeFeesDetailsId;
    data['feesName'] = this.feesName;
    data['amount'] = this.amount;
    data['vendorCode'] = this.vendorCode;
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

class FeeOrder {
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

  FeeOrder(
      {this.lastOrderStatus,
      this.lastTransactionTypeId,
      this.lastTransactionTypeName,
      this.transactionId,
      this.lastTransactionDate,
      this.lastTransactionStartDate,
      this.lastTransactionAmount,
      this.lastOrderId,
      this.paymentGatewayId,
      this.readableOrderId});

  FeeOrder.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}

class Transactiontype {
  String? name;
  String? id;

  Transactiontype({this.name, this.id});

  Transactiontype.fromJson(Map<String, dynamic> json) {
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

//fee order pdf download

class FilePathPdfDownload {
  String? name;
  String? extension;
  String? path;
  String? url;
  bool? isTemporary;
  bool? isDeleted;
  Null? images;
  String? createdAt;
  String? id;

  FilePathPdfDownload(
      {this.name,
      this.extension,
      this.path,
      this.url,
      this.isTemporary,
      this.isDeleted,
      this.images,
      this.createdAt,
      this.id});

  FilePathPdfDownload.fromJson(Map<String, dynamic> json) {
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
//status Payment

class StatusPayment {
  String? status;

  StatusPayment({this.status});

  StatusPayment.fromJson(Map<String, dynamic> json) {
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    return data;
  }
}

//gateway Name Check

class GateWayName {
  String? gateway;

  GateWayName({this.gateway});

  GateWayName.fromJson(Map<String, dynamic> json) {
    gateway = json['gateway'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gateway'] = this.gateway;
    return data;
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////                     vendor mapping                              ///////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class VendorMapModel {
  bool? existMap;

  VendorMapModel({this.existMap});

  VendorMapModel.fromJson(Map<String, dynamic> json) {
    existMap = json['existMap'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['existMap'] = this.existMap;
    return data;
  }
}
