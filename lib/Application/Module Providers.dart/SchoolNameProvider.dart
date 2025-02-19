import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../Domain/Admin/SchoolNameModel.dart';
import '../../utils/constants.dart';

class SchoolNameProvider with ChangeNotifier {
  String? schoolname;
  String? place;
  String? allowGPSTracking;

  Future<int> getSchoolname() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? schoolId= pref.getString('schoolId');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    var request = http.Request(
        'GET', Uri.parse('${UIGuide.baseURL}/mobileapp/common/schoolDet/$schoolId'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print('correct');
      Map<String, dynamic> schooldata = json.decode(await response.stream.bytesToString());
      SchooNameModel ac = SchooNameModel.fromJson(schooldata);
      schoolname = ac.name;
      place = ac.place;
      allowGPSTracking = ac.allowGPSTracking;
     print(schoolname);
     print(place);
     print(allowGPSTracking);

      notifyListeners();
    } else {
      print('Error in schoolname');
    }
    return response.statusCode;
  }
}