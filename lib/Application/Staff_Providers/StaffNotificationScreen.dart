import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../Domain/Staff/NotifcationSendModel.dart';
import '../../Domain/Student/NotificationReceivedStud.dart';
import '../../utils/constants.dart';

class StaffNotificationScreenProvider with ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  List<NotificationListModel> notificationList = [];
  Future getNotificationReceived() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };

    var request = http.Request('GET',
        Uri.parse("${UIGuide.baseURL}/mobileapp/staffdet/staff-notification"));

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    try {
      if (response.statusCode == 200) {
        print("corect");
        // final data = json.decode(await response.stream.bytesToString());
        Map<String, dynamic> data =
            jsonDecode(await response.stream.bytesToString());

        List<NotificationListModel> templist = List<NotificationListModel>.from(
            data["notificationList"]
                .map((x) => NotificationListModel.fromJson(x)));
        notificationList.addAll(templist);

        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        print("Error in Notification screen send Response");
      }
    } catch (e) {
      setLoading(false);
      print(e);
    }
  }

  //send history
  List<StaffNotificationHistory> historyList = [];
  Future getNotificationHistory() async {
    Map<String, dynamic> parse = await parseJWT();
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };

    var request = http.Request(
        'GET', Uri.parse("${UIGuide.baseURL}/mobileapp/token/sentlist"));
    request.body = json.encode({
      //   "SchoolId": _pref.getString('schoolId'),
      "CreatedDate": null,
      "StaffGuardianStudId": parse['StaffId'],
      "Type": "Student"
    });
    print(json.encode({
      //  "SchoolId": _pref.getString('schoolId'),
      "CreatedDate": null,
      "StaffGuardianStudId": parse['StaffId'],
      "Type": "Student"
    }));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    try {
      if (response.statusCode == 200) {
        print("corect");

        Map<String, dynamic> data =
            jsonDecode(await response.stream.bytesToString());

        //   log(data.toString());

        List<StaffNotificationHistory> templist =
            List<StaffNotificationHistory>.from(data["results"]
                .map((x) => StaffNotificationHistory.fromJson(x)));
        historyList.addAll(templist);
        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        print("Error in Notification screen send Response");
      }
    } catch (e) {
      setLoading(false);
      print(e);
    }
  }
}
