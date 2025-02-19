import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Domain/Admin/FeeDetails.dart';
import '../../Domain/Staff/StudentReport_staff.dart';
import '../../utils/constants.dart';

class FeeDetailsProvider with ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  List<ViewStudentReport> searchStudent = [];
  Future<bool> getSearchView(String word) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoading(true);
    print(word);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            '${UIGuide.baseURL}/mobileapp/staffdet/studentreport/viewStudentReport?search=$word'));
    setLoading(true);
    request.headers.addAll(headers);
    print(
        "${UIGuide.baseURL}/mobileapp/staffdet/studentreport/viewStudentReport?search=$word");
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      setLoading(true);
      Map<String, dynamic> data =
          jsonDecode(await response.stream.bytesToString());
      print(data);
      List<ViewStudentReport> templist = List<ViewStudentReport>.from(
          data["viewStudentReport"].map((x) => ViewStudentReport.fromJson(x)));
      searchStudent.addAll(templist);
      setLoading(false);
      notifyListeners();
    } else {
      setLoading(false);
      print('Error in Search stf');
    }
    return true;
  }

  clearStudentList() {
    searchStudent.clear();
    notifyListeners();
  }

  bool _load = false;
  bool get load => _load;
  setLoad(bool value) {
    _load = value;
    notifyListeners();
  }

  //fee details
  double? allPaidAmount;
  double? allTotalDueInstallmentDue;
  double? allTotalDueConcessionAmount;
  double? allTotalDueFineAmount;
  double? allTotalDueNetDueAmount;
  double? allTotalDuePaidAmount;
  List generalDue = [];
  List busDue = [];
  List<dynamic> generalPaid = [];
  List busPaid = [];

  List<StudentGeneralFeePaidTotal> generalFeePaidList = [];
  List<StudentBusFeePaidTotal> busFeePaidList = [];
  List<StudentGeneralFeeDueTotal> generalFeeDueList = [];
  List<StudentBusFeeDueTotal> busFeeDueList = [];
  Future<bool> getFeeDetails(String studId) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoad(true);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            '${UIGuide.baseURL}/studentinfo/feeDetails?FeeCategory=ALL&studentId=$studId'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    setLoad(true);

    if (response.statusCode == 200) {
      setLoad(true);

      Map<String, dynamic> data =
          jsonDecode(await response.stream.bytesToString());

      print(data);
      Map<String, dynamic> studFeeDetails = data['studentFeeDetails'];

      StudentFeeDetailsAdmin adm =
          StudentFeeDetailsAdmin.fromJson(studFeeDetails);

      allTotalDueFineAmount = adm.allTotalDueFineAmount;
      allTotalDuePaidAmount = adm.allTotalDuePaidAmount;
      allTotalDueNetDueAmount = adm.allTotalDueNetDueAmount;
      allPaidAmount = adm.allPaidAmount;

      print(allTotalDueFineAmount);

//general due

      generalDue = studFeeDetails['studentGeneralFeeDueTotal'];
      List<StudentGeneralFeeDueTotal> templist =
          List<StudentGeneralFeeDueTotal>.from(
              studFeeDetails['studentGeneralFeeDueTotal']
                  .map((x) => StudentGeneralFeeDueTotal.fromJson(x)));
      generalFeeDueList.addAll(templist);
          setLoad(true);

//bus fee Due

      busDue = studFeeDetails['studentBusFeeDueTotal'];
      List<StudentBusFeeDueTotal> templist1 = List<StudentBusFeeDueTotal>.from(
          studFeeDetails['studentBusFeeDueTotal']
              .map((x) => StudentBusFeeDueTotal.fromJson(x)));
      busFeeDueList.addAll(templist1);
          setLoad(true);

//student General Fee Paid

      generalPaid = studFeeDetails['studentGeneralFeePaidTotal'];
      List<StudentGeneralFeePaidTotal> templist2=
          List<StudentGeneralFeePaidTotal>.from(
              studFeeDetails['studentGeneralFeePaidTotal']
                  .map((x) => StudentGeneralFeePaidTotal.fromJson(x)));
      generalFeePaidList.addAll(templist2);
          setLoad(true);

//student Bus Fee Paid

      busPaid = studFeeDetails['studentBusFeePaidTotal'];
      List<StudentBusFeePaidTotal> templist3 =
          List<StudentBusFeePaidTotal>.from(
              studFeeDetails['studentBusFeePaidTotal']
                  .map((x) => StudentBusFeePaidTotal.fromJson(x)));
      busFeePaidList.addAll(templist3);
          setLoad(false);

      notifyListeners();
    } else {
      setLoad(false);
      print('Error in bus fee details stf');
    }
    return true;
  }

  generalDueListClear() {
    generalFeeDueList.clear();
    notifyListeners();
  }

  busDueListClear() {
    busFeeDueList.clear();
    notifyListeners();
  }

  generalPaidListClear() {
    generalFeePaidList.clear();
    notifyListeners();
  }

  busPaidListClear() {
    busFeePaidList.clear();
    notifyListeners();
  }
}
