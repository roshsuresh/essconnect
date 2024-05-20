import 'dart:convert';
import 'package:essconnect/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Domain/Admin/FeeCollectionDetails.dart';
import '../../Domain/Admin/FeeReportModel.dart';

class FeeReportProvider with ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  double? allTotal;
  List<AllFeeCollect> collectionList = [];
  Future getFeeReportView(
      String section, String course, String start, String end) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    var response = await http.get(
        Uri.parse(
            "${UIGuide.baseURL}/fee-collection/fees-collection-report?feeCategory=ALL&section=$section&courses=$course&displayStartDate=$start&displayEndDate=$end"),
        headers: headers);
    if (response.statusCode == 200) {
      setLoading(true);
      print('correct');
      Map<String, dynamic> data = json.decode(response.body);
      Map<String, dynamic> fee = data['feeCollectionReportDetails'];
      FeeCollectionReportDetails ac = FeeCollectionReportDetails.fromJson(fee);
      allTotal = ac.allTotal!;
      List<AllFeeCollect> templist = List<AllFeeCollect>.from(
          fee['allFeeCollect'].map((x) => AllFeeCollect.fromJson(x)));
      collectionList.addAll(templist);
      setLoading(false);
      notifyListeners();
    } else {
      setLoading(false);
      print('Error in fee collection report');
    }
    return response.statusCode;
  }

  clearcollectionList() {
    collectionList.clear();
    notifyListeners();
  }

  //attachment View

  String? admissionNo;
  String? name;
  String? division;
  String? orderId;
  String? transactionId;
  String? transactionDate;
  String? studentId;
  List general = [];
  List busFee = [];
  List<GeneralCollectDetails> generalList = [];
  List<BusCollectDetails> busFeeList = [];
  Future getAttachmentView(String studId, String feeID, String busId) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    var response = await http.get(
        Uri.parse(
            "${UIGuide.baseURL}/fee-collection/fees-collections-detail?FeeCategory=ALL&StudentId=$studId&FeeCollectionId=$feeID&BusFeeCollectionId=$busId"),
        headers: headers);
    print(Uri.parse(
        "${UIGuide.baseURL}/fee-collection/fees-collections-detail?FeeCategory=ALL&StudentId=$studId&FeeCollectionId=$feeID&BusFeeCollectionId=$busId"));
    if (response.statusCode == 200) {
      print('correct');
      Map<String, dynamic> data = json.decode(response.body);
      Map<String, dynamic> fee = data['feeCollectionPopupDetails'];
      Map<String, dynamic> feedata = fee['studentAllDetails'];
      StudentAllDetails ac = StudentAllDetails.fromJson(feedata);
      print(fee);
      print(feedata);
      admissionNo = ac.admissionNo;
      name = ac.name;
      division = ac.division;
      orderId = ac.orderId;
      transactionId = ac.transactionId;
      transactionDate = ac.transactionDate;
      print(allTotal);
      general = fee['generalCollectDetails'];
      List<GeneralCollectDetails> templist = List<GeneralCollectDetails>.from(
          fee['generalCollectDetails']
              .map((x) => GeneralCollectDetails.fromJson(x)));
      generalList.addAll(templist);

      notifyListeners();
          busFee = fee['busCollectDetails'];
      List<BusCollectDetails> templist1 = List<BusCollectDetails>.from(
          fee['busCollectDetails'].map((x) => BusCollectDetails.fromJson(x)));
      busFeeList.addAll(templist1);

      notifyListeners();
          notifyListeners();
    } else {
      print('Error in fee collection report');
    }
    return response.statusCode;
  }
}
