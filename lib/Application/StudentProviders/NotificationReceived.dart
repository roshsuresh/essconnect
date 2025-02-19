import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Domain/Student/NotificationReceivedStud.dart';
import '../../utils/constants.dart';

class NotificationReceivedProviderStudent with ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  // List? notificationstud;

  clearReceivedList() async {
    receivedList.clear();
    notifyListeners();
  }

  List<NotificationListModel> receivedList = [];
  Future getNotificationReceived() async {
    //  Map<String, dynamic> parse = await parseJWT();
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };

    var request = http.Request(
        'GET', Uri.parse("${UIGuide.baseURL}/mobileapp/parent/notification"));

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
        receivedList.addAll(templist);

        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        print("Error in Notification screen send  Response");
      }
    } catch (e) {
      setLoading(false);
      print(e);
    }
  }
}
