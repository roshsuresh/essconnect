class FeeCollectionReportDetails {
  List<AllFeeCollect>? allFeeCollect;
  double? generalTotal;
  double? busTotal;
  double? allTotal;

  FeeCollectionReportDetails(
      {this.allFeeCollect, this.generalTotal, this.busTotal, this.allTotal});

  FeeCollectionReportDetails.fromJson(Map<String, dynamic> json) {
    if (json['allFeeCollect'] != null) {
      allFeeCollect = <AllFeeCollect>[];
      json['allFeeCollect'].forEach((v) {
        allFeeCollect!.add(AllFeeCollect.fromJson(v));
      });
    }
    generalTotal = json['generalTotal'];
    busTotal = json['busTotal'];
    allTotal = json['allTotal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (allFeeCollect != null) {
      data['allFeeCollect'] = allFeeCollect!.map((v) => v.toJson()).toList();
    }

    data['generalTotal'] = generalTotal;
    data['busTotal'] = busTotal;
    data['allTotal'] = allTotal;
    return data;
  }
}

class AllFeeCollect {
  String? feeCollectionId;
  String? busFeeCollectionId;
  int? id;
  String? studentId;
  String? admissionNo;
  String? name;
  String? course;
  String? division;
  double? remittedFees;
  String? remittedDate;

  AllFeeCollect(
      {this.feeCollectionId,
      this.busFeeCollectionId,
      this.id,
      this.studentId,
      this.admissionNo,
      this.name,
      this.course,
      this.division,
      this.remittedFees,
      this.remittedDate});

  AllFeeCollect.fromJson(Map<String, dynamic> json) {
    feeCollectionId = json['feeCollectionId'];
    busFeeCollectionId = json['busFeeCollectionId'];
    id = json['id'];
    studentId = json['studentId'];
    admissionNo = json['admissionNo'];
    name = json['name'];
    course = json['course'];
    division = json['division'];
    remittedFees = json['remittedFees'];
    remittedDate = json['remittedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['feeCollectionId'] = feeCollectionId;
    data['busFeeCollectionId'] = busFeeCollectionId;
    data['id'] = id;
    data['studentId'] = studentId;
    data['admissionNo'] = admissionNo;
    data['name'] = name;
    data['course'] = course;
    data['division'] = division;
    data['remittedFees'] = remittedFees;
    data['remittedDate'] = remittedDate;
    return data;
  }
}
