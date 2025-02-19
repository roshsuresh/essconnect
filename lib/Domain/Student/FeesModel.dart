
class FeeInitialModel {
  OnlineFeePayModel? onlineFeePaymentStudentDetails;
  bool? isLocked;
  // IsBankAdmnNoCheck? isBankAdmnNoCheck;
  bool? installmentDueDateCheck;
  bool? isExistFeegroup;
  bool? isBusFeeGeneralFeeTogether;
  bool? hideMiscellaneousFeesPayment;
  bool? multiplePaymentGateway;
  FeeInitialModel(
      {this.onlineFeePaymentStudentDetails,
      this.isLocked,
      // this.isBankAdmnNoCheck,
      this.installmentDueDateCheck,
      this.isExistFeegroup,
      this.isBusFeeGeneralFeeTogether,
        this.multiplePaymentGateway,
      this.hideMiscellaneousFeesPayment});

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
    multiplePaymentGateway = json['multiplePaymentGateway'];
    hideMiscellaneousFeesPayment =json['hideMiscellaneousFeesPayment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (onlineFeePaymentStudentDetails != null) {
      data['onlineFeePaymentStudentDetails'] =
          onlineFeePaymentStudentDetails!.toJson();
    }
    data['isLocked'] = isLocked;
    // if (this.isBankAdmnNoCheck != null) {
    //   data['isBankAdmnNoCheck'] = this.isBankAdmnNoCheck!.toJson();
    // }
    data['installmentDueDateCheck'] = installmentDueDateCheck;
    data['isExistFeegroup'] = isExistFeegroup;
    data['isBusFeeGeneralFeeTogether'] = isBusFeeGeneralFeeTogether;
    data['multiplePaymentGateway'] = multiplePaymentGateway;
    data['hideMiscellaneousFeesPayment'] = hideMiscellaneousFeesPayment;
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
        ? StudentDetailsList.fromJson(json['studentDetailsList'])
        : null;
    if (json['feeFeesInstallments'] != null) {
      feeFeesInstallments = <FeeFeesInstallments>[];
      json['feeFeesInstallments'].forEach((v) {
        feeFeesInstallments!.add(FeeFeesInstallments.fromJson(v));
      });
    }
    if (json['feeBusInstallments'] != null) {
      feeBusInstallments = <FeeBusInstallments>[];
      json['feeBusInstallments'].forEach((v) {
        feeBusInstallments!.add(FeeBusInstallments.fromJson(v));
      });
    }
    order = json['order'] != null ? Order.fromJson(json['order']) : null;
    feeOrder = json['feeOrder'] != null
        ? FeeOrder.fromJson(json['feeOrder'])
        : null;
    if (json['transactiontype'] != null) {
      transactiontype = <Transactiontype>[];
      json['transactiontype'].forEach((v) {
        transactiontype!.add(Transactiontype.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['allowPartialPayment'] = allowPartialPayment;
    //  data['concessionCaption'] = this.concessionCaption;
    if (studentDetailsList != null) {
      data['studentDetailsList'] = studentDetailsList!.toJson();
    }
    if (feeFeesInstallments != null) {
      data['feeFeesInstallments'] =
          feeFeesInstallments!.map((v) => v.toJson()).toList();
    }
    if (feeBusInstallments != null) {
      data['feeBusInstallments'] =
          feeBusInstallments!.map((v) => v.toJson()).toList();
    }
    if (order != null) {
      data['order'] = order!.toJson();
    }
    if (feeOrder != null) {
      data['feeOrder'] = feeOrder!.toJson();
    }
    if (transactiontype != null) {
      data['transactiontype'] =
          transactiontype!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['studentId'] = studentId;
    data['studentName'] = studentName;
    data['admissionNo'] = admissionNo;
    data['classNo'] = classNo;
    data['division'] = division;
    return data;
  }
}

class FeeFeesInstallments {
  String? onlineInstallmentId;
  int? offlineInstallmentId;
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
  int? installmentOrder;
  String? dueDate;
  bool? enabled;
  bool? selected;

  FeeFeesInstallments(
      {
        this.onlineInstallmentId,
        this.offlineInstallmentId,
        this.feesDetailsId,
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
        this.installmentOrder,
      this.dueDate,
      this.enabled,
      this.selected});

  FeeFeesInstallments.fromJson(Map<String, dynamic> json) {
    onlineInstallmentId = json['onlineInstallmentId'];
    offlineInstallmentId = json['offlineInstallmentId'];
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
    installmentOrder = json['installmentOrder'];
    dueDate = json['dueDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['onlineInstallmentId'] = onlineInstallmentId;
    data['offlineInstallmentId'] = offlineInstallmentId;
    data['feesDetailsId'] = feesDetailsId;
    data['installmentName'] = installmentName;
    data['installmentGroup'] = installmentGroup;
    data['installmentNetDue'] = installmentNetDue;
    data['concessionAmount'] = concessionAmount;
    data['netDue'] = netDue;
    data['fineAmount'] = fineAmount;
    data['balanceAmount'] = balanceAmount;
    data['checkedInstallment'] = checkedInstallment;
    data['enableInstallment'] = enableInstallment;
    data['checkedFees'] = checkedFees;
    data['totalPaidAmount'] = totalPaidAmount;
    data['installmentOrder'] = installmentOrder;

    return data;
  }
}

class FeeBusInstallments {
  String? onlineInstallmentId;
  int? offlineInstallmentId;
  String? feesDetailsId;
  String? installmentName;
  int? installmentGroup;
  String? offlineBusGroupId;
  double? installmentNetDue;
  double? netDue;
  double? fineAmount;
  double? concessionAmount;
  double? balanceAmount;
  bool? checkedInstallment;
  bool? enableInstallment;
  bool? checkedFees;
  double? totalPaidAmount;
  int? installmentOrder;
  String? dueDate;
  bool? enabled;

  bool? selected;

  FeeBusInstallments(
      {
        this.onlineInstallmentId,
        this.offlineInstallmentId,
        this.feesDetailsId,
      this.installmentName,
        this.installmentGroup,
        this.offlineBusGroupId,
      this.installmentNetDue,
      this.netDue,
      this.fineAmount,
        this.concessionAmount,
      this.balanceAmount,
      this.checkedInstallment,
      this.enableInstallment,
      this.checkedFees,
      this.totalPaidAmount,
        this.installmentOrder,
        this.dueDate,
      this.enabled,
      this.selected});

  FeeBusInstallments.fromJson(Map<String, dynamic> json) {
    onlineInstallmentId = json['onlineInstallmentId'];
    offlineInstallmentId = json['offlineInstallmentId'];
    feesDetailsId = json['feesDetailsId'];
    installmentName = json['installmentName'];
    installmentGroup = json['installmentGroup'];
    offlineBusGroupId = json['offlineBusGroupId'];
    installmentNetDue = json['installmentNetDue'];
    netDue = json['netDue'];
    fineAmount = json['fineAmount'];
    concessionAmount = json['concessionAmount'];
    balanceAmount = json['balanceAmount'];
    checkedInstallment = json['checkedInstallment'];
    enableInstallment = json['enableInstallment'];
    checkedFees = json['checkedFees'];
    totalPaidAmount = json['totalPaidAmount'];
    installmentOrder = json['installmentOrder'];
    dueDate = json['dueDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['onlineInstallmentId'] = onlineInstallmentId;
    data['offlineInstallmentId'] = offlineInstallmentId;
    data['feesDetailsId'] = feesDetailsId;
    data['installmentName'] = installmentName;
    data['installmentGroup'] = installmentGroup;
    data['offlineBusGroupId'] = offlineBusGroupId;
    data['installmentNetDue'] = installmentNetDue;
    data['netDue'] = netDue;
    data['fineAmount'] = fineAmount;
    data['concessionAmount'] = concessionAmount;
    data['balanceAmount'] = balanceAmount;
    data['checkedInstallment'] = checkedInstallment;
    data['enableInstallment'] = enableInstallment;
    data['checkedFees'] = checkedFees;
    data['totalPaidAmount'] = totalPaidAmount;
    data['installmentOrder'] = installmentOrder;
    data['dueDate'] = dueDate;
    return data;
  }
}


class MiscellaneousFeesSchedule {
  String? miscellaneousFeesScheduleId;
  int? miscFeesOfflineScheduleId;
  String? feesName;
  double? amount;
  String? vendorCode;
  String? startDate;
  String? endDate;
  bool? checkedInstallment;

  MiscellaneousFeesSchedule(
      {this.miscellaneousFeesScheduleId,
        this.miscFeesOfflineScheduleId,
        this.feesName,
        this.amount,
        this.vendorCode,
        this.startDate,
        this.endDate,
      this.checkedInstallment});

  MiscellaneousFeesSchedule.fromJson(Map<String, dynamic> json) {
    miscellaneousFeesScheduleId = json['miscellaneousFeesScheduleId'];
    miscFeesOfflineScheduleId = json['miscFeesOfflineScheduleId'];
    feesName = json['feesName'];
    amount = json['amount'];
    vendorCode = json['vendorCode'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    checkedInstallment = json['checkedInstallment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['miscellaneousFeesScheduleId'] = this.miscellaneousFeesScheduleId;
    data['miscFeesOfflineScheduleId'] = this.miscFeesOfflineScheduleId;
    data['feesName'] = this.feesName;
    data['amount'] = this.amount;
    data['vendorCode'] = this.vendorCode;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['checkedInstallment'] = this.checkedInstallment;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['storeFeesDetailsId'] = storeFeesDetailsId;
    data['feesName'] = feesName;
    data['amount'] = amount;
    data['vendorCode'] = vendorCode;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
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
  String? images;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['extension'] = extension;
    data['path'] = path;
    data['url'] = url;
    data['isTemporary'] = isTemporary;
    data['isDeleted'] = isDeleted;
    data['images'] = images;
    data['createdAt'] = createdAt;
    data['id'] = id;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['gateway'] = gateway;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['existMap'] = existMap;
    return data;
  }
}

class VendorMapFeeWiseModel {
  bool? existMapFeesWise;

  VendorMapFeeWiseModel({this.existMapFeesWise});

  VendorMapFeeWiseModel.fromJson(Map<String, dynamic> json) {
    existMapFeesWise = json['existMapFeesWise'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['existMapFeesWise'] = existMapFeesWise;
    return data;
  }
}

//-----------Multiple Gateway----------
//---------------------------------------


class MultiGatewaysModel {
  String? pgId;
  String? schoolPaymentGatewayId;
  bool? defaultPaymentGateway;
  String? text;
  String? url;
  bool? selected;

  MultiGatewaysModel(
      {this.pgId,
        this.schoolPaymentGatewayId,
        this.defaultPaymentGateway,
        this.text,
        this.url,
        this.selected});

  MultiGatewaysModel.fromJson(Map<String, dynamic> json) {
    pgId = json['pgId'];
    schoolPaymentGatewayId = json['schoolPaymentGatewayId'];
    defaultPaymentGateway = json['defaultPaymentGateway'];
    text = json['text'];
    url = json['url'];
    selected = json['selected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pgId'] = this.pgId;
    data['schoolPaymentGatewayId'] = this.schoolPaymentGatewayId;
    data['defaultPaymentGateway'] = this.defaultPaymentGateway;
    data['text'] = this.text;
    data['url'] = this.url;
    data['selected'] = this.selected;
    return data;
  }
}