import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../Domain/Staff/TimetableModel.dart';
import '../../utils/constants.dart';

Map? staff_timetableRespo;

class StaffTimetableProvider with ChangeNotifier {
  String? name;
  String? extension;
  String? url;
  String? id;

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future getTimeTable() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString('subDomain'));
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    setLoading(true);
    var response = await http.get(
        Uri.parse("${UIGuide.baseURL}/mobileapp/staff/class-timetable-preview"),
        headers: headers);
    try {
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        staff_timetableRespo = data['timeTable'];
        StaffTimeTable tabl = StaffTimeTable.fromJson(data['timeTable']);
        name = tabl.name;
        extension = tabl.extension;
        url = tabl.url;
        id = tabl.id;
        print(name);
        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        print("Error in timetable response");
      }
    } catch (e) {
      print(e);
    }
  }
}
