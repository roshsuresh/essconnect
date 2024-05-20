import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../Domain/Admin/DashboardModel.dart';
import '../../utils/constants.dart';

class DashboardAdmin extends ChangeNotifier {
  int? totalStudentStrength;
  int? boysStrength;
  int? girlsStrength;
  int? totalStaffStrength;
  int? nonTeachingStrength;
  int? teachingStrength;

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<int> getDashboard() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    var response = await http.get(
        Uri.parse("${UIGuide.baseURL}/mobileapp/admin/dashboarddetails"),
        headers: headers);
    if (response.statusCode == 200) {
      print('correct');
      Map<String, dynamic> dashboard = json.decode(response.body);
      Dashboard ac = Dashboard.fromJson(dashboard);
      totalStudentStrength = ac.totalStudentStrength!;
      boysStrength = ac.boysStrength;
      girlsStrength = ac.girlsStrength;
      teachingStrength = ac.teachingStrength;
      totalStaffStrength = ac.totalStaffStrength;
      nonTeachingStrength = ac.nonTeachingStrength;
      notifyListeners();
    } else {
      print('Error in dashboard');
    }
    return response.statusCode;
  }
}
