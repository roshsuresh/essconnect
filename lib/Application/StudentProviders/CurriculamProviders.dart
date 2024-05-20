import 'dart:convert';
import 'package:essconnect/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../Domain/Student/CurriculamModel.dart';

class Curriculamprovider with ChangeNotifier {
  String? token;

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future getCuriculamtoken() async {
    setLoading(true);
    SharedPreferences pref = await SharedPreferences.getInstance();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    setLoading(true);
    var response = await http.get(Uri.parse("${UIGuide.baseURL}/curriculum"),
        headers: headers);
    setLoading(true);
    try {
      if (response.statusCode == 200) {
        print("corect");
        Map<String, dynamic> data = json.decode(response.body);
        print("daaaata:,$data");
        CurriculamModel prev = CurriculamModel.fromJson(data);
        token = prev.results;

        print(token);
        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        print("Error in response");
      }
    } catch (e) {
      print(e);
    }
  }
}
