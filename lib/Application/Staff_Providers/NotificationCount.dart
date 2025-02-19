import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../Domain/Student/NotificationCountModel.dart';
import '../../utils/constants.dart';

class StaffNotificationCountProviders with ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future seeNotification() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    var parsedResponse = await parseJWT();
    final staffId = await parsedResponse['StaffId'];
    var request = http.Request(
        'POST',
        Uri.parse(
            '${UIGuide.baseURL}/mobileapp/token/updateWebStatus?staffId=$staffId'));
    request.body = json.encode({"IsSeen": true, "Type": "Staff"});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      setLoading(true);
      print(' _ _ _ _ _ _  Notification Count  _ _ _ _ _ _');
      setLoading(false);
    } else {
      setLoading(false);
      print('Error in notificationInitial respo');
    }
  }

  int? count;
  Future getnotificationCount() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    var parsedResponse = await parseJWT();
    final staffID = await parsedResponse['StaffId'];
    var response = await http.get(
        Uri.parse(
            "${UIGuide.baseURL}/mobileapp/staffdet/initial-staffnotification-Count?staffId=$staffID"),
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
        print("Error in Response");
      }
    } catch (e) {
      setLoading(false);
      print(e);
    }
  }
}
