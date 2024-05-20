import 'dart:convert';
import 'package:essconnect/Domain/Admin/MobileAppCkeckinModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../utils/constants.dart';

class MobileAppCheckinProvider extends ChangeNotifier {
  bool? existapp;
  Future<int> getMobile(String schoolId) async {
    var response = await http.get(
      Uri.parse(
          "${UIGuide.baseURL}/mobileapp/common/mobileapp-module/$schoolId"),
    );
    if (response.statusCode == 200) {
      print('correct');
      Map<String, dynamic> dashboard = json.decode(response.body);
      MobileAppCheckinModel ac = MobileAppCheckinModel.fromJson(dashboard);
      existapp = ac.existapp;

      notifyListeners();
    } else {
      print('Error in Checkin');
    }
    return response.statusCode;
  }
}
