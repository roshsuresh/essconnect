import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Domain/Admin/StudStatitics.dart';
import '../../utils/constants.dart';

class StudStatiticsProvider with ChangeNotifier {
  List<StatisticsData> statiticsList = [];
  List<TotalStatitics> totalList = [];
  clearAllList() {
    statiticsList.clear();
    totalList.clear();
    notifyListeners();
  }

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<bool> getstatitics(String section, String course) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoading(true);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            '${UIGuide.baseURL}/student/studentStatisticsReport/viewStudentStatistics/?section=$section&course=$course&showReport=1'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      setLoading(true);
      Map<String, dynamic> data =
          jsonDecode(await response.stream.bytesToString());

      List<StatisticsData> templist = List<StatisticsData>.from(
          data["statisticsData"].map((x) => StatisticsData.fromJson(x)));
      statiticsList.addAll(templist);
      List<TotalStatitics> templistt = List<TotalStatitics>.from(
          data["total"].map((x) => TotalStatitics.fromJson(x)));
      totalList.addAll(templistt);

      setLoading(false);
      notifyListeners();
    } else {
      setLoading(false);
      print('Error in Statitics admin');
    }
    return true;
  }

  clearStaticsList() {
    statiticsList.clear();
    notifyListeners();
  }

  clearTotalList() {
    totalList.clear();
    notifyListeners();
  }
}
