import 'dart:convert';
import 'package:essconnect/Domain/Student/NotificationCountModel.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class StudNotificationCountProviders with ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  int? count;
  Future getnotificationCount() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    var parsedResponse = await parseJWT();
    final studID = await parsedResponse['ChildId'];
    var response = await http.get(
        Uri.parse(
            "${UIGuide.baseURL}/mobileapp/parent/initial-Web-Notification-Count?Type=Parent&StudentId=$studID"),
        headers: headers);

    try {
      if (response.statusCode == 200) {
        setLoading(true);
        final data = json.decode(response.body);
        CountmodelNotification not = CountmodelNotification.fromJson(data);
        count = not.totalCount;
        print("Notification Count = $count");

        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        print(response.statusCode);
        print("Error in Notification Response");
      }
    } catch (e) {
      setLoading(false);
      print(e);
    }
  }
}
