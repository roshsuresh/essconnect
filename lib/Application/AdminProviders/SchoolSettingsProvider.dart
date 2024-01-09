import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Domain/Admin/SchoolSettings.dart';
import '../../utils/constants.dart';
class SchoolSettingByAdmin with ChangeNotifier {

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }
  // Map? mapResponse;
  // bool? showCommunication;
  // bool? textSMS;
  // bool? email;
  // bool? notification;
  //
  // Future schoolSettings() async {
  //   SharedPreferences _pref = await SharedPreferences.getInstance();
  //   setLoading(true);
  //   var headers = {
  //     'Content-Type': 'application/json',
  //     'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
  //   };
  //
  //   setLoading(true);
  //   var response = await http.get(
  //       Uri.parse("${UIGuide.baseURL}/school-settings"),
  //       headers: headers);
  //   try {
  //     if (response.statusCode == 200) {
  //       setLoading(true);
  //
  //       mapResponse = await json.decode(response.body);
  //       setLoading(true);
  //       Settings sets = Settings.fromJson(mapResponse!['settings']);
  //        showCommunication = sets.showCommunication;
  //        textSMS =  sets.showCommunication;
  //        email = sets.email;
  //        notification = sets.notification;
  //       setLoading(false);
  //       notifyListeners();
  //     } else {
  //       print("Error in profile Response");
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }
}
