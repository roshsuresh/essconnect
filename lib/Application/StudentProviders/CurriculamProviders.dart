import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../Domain/Student/CurriculamModel.dart';
import '../../utils/constants.dart';

class Curriculamprovider with ChangeNotifier {
  String? token;
  String? accessToken;

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future getCuriculamtoken() async {
    setLoading(true);
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
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

        print("token  : $token");
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


  Future getCuriculamAceesstoken() async {
    setLoading(true);
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    setLoading(true);
    var response = await http.get(Uri.parse("${UIGuide.curriculamUrl}/login?token=$token"),
        headers: headers);
    print("${UIGuide.curriculamUrl}/login?token=$token");
    setLoading(true);
    try {
      if (response.statusCode == 200) {
        print("corect");
        Map<String, dynamic> data = json.decode(response.body);
        print("daaaata:,$data");
        CurriculamAccessToken prev = CurriculamAccessToken.fromJson(data);
        accessToken = prev.accessToken;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('curiaccesstoken', prev.accessToken);

        print(accessToken);
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
