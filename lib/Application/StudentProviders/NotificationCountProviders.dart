import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../Domain/Student/NotificationCountModel.dart';
import '../../utils/constants.dart';

class StudNotificationCountProviders with ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future seeNotification() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    var parsedResponse = await parseJWT();
    final studId = await parsedResponse['ChildId'];
    var request = http.Request(
        'POST',
        Uri.parse(
            '${UIGuide.baseURL}/mobileapp/token/updateWebStatus?studentId=$studId'));
    request.body = json.encode({"IsSeen": true, "Type": "Student"});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      setLoading(true);
      print(
          '_ _ _ _ _ _ _ _ _ _ _ _   Correct   _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _');
      setLoading(false);
    } else {
      setLoading(false);
      print(response.statusCode);
      print('Error in notificationInitial respo');
    }
  }

  int? count;
  int? noticeCount;
  int? anecdotalCount;
  int? homeworkcount;
  int? portionCount;
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
            "${UIGuide.baseURL}/mobileapp/parent/initial-Web-Notification-Count?Type=Student&StudentId=$studID"),
        headers: headers);

    try {
      if (response.statusCode == 200) {
        setLoading(true);
        final data = json.decode(response.body);
        log(data.toString());
        CountmodelNotification not = CountmodelNotification.fromJson(data);
        count = not.totalCount;
        noticeCount = not.noticeboardCount;
        anecdotalCount= not.anecdotalCount;
         homeworkcount=not.homeworkcount;
        portionCount=not.portionCount;
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
