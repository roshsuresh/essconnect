import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../Domain/Admin/StaffReportModel.dart';
import '../../utils/constants.dart';

class SearchStaffProviders with ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  List<StaffReportByAdmin> staffReportList = [];
  Future<bool> getSearchStaffView(String word) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            '${UIGuide.baseURL}/mobileapp/admin/viewStaffReport?search=$word'));

    request.headers.addAll(headers);
    setLoading(true);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      Map<String, dynamic> data =
          jsonDecode(await response.stream.bytesToString());
      List<StaffReportByAdmin> templist = List<StaffReportByAdmin>.from(
          data["staffReport"].map((x) => StaffReportByAdmin.fromJson(x)));
      staffReportList.addAll(templist);
      setLoading(false);
      notifyListeners();
    } else {
      setLoading(false);
      print('Error in staffReport stf');
    }
    return true;
  }

  clearStaffList() {
    staffReportList.clear();
    notifyListeners();
  }
}
