import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../Domain/Student/MarkSheetModel.dart';
import '../../Domain/Student/ReportCardModel.dart';
import '../../utils/constants.dart';

//List reportResponse = [];

class MarksheetProvider with ChangeNotifier {

  bool isLoading = false;


  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  List<MarksheetList> marksheetList = [];
  clearMarksheet() {
    marksheetList.clear();
    notifyListeners();
  }


  Future getMarkLit() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    setLoading(true);
    var response = await http.get(
        Uri.parse(
            "${UIGuide.baseURL}/marksheet/initvalues"),
        headers: headers);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        MarksheetList repo = MarksheetList.fromJson(data);
        List<MarksheetList> templist = List<MarksheetList>.from(
            data['marksheetList'].map((x) => MarksheetList.fromJson(x)));
        marksheetList.addAll(templist);
        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        print("Error in response");
      }

  }
  List<MarksheetListView> marksheetValues = [];
  Future markSheetView(String marksheetid) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    var response = await http.get(
        Uri.parse("${UIGuide.baseURL}/marksheet/subMarkList/$marksheetid"),
        headers: headers);
    print(response);
    try {
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
       // MarkSheetValues repo = MarkSheetValues.fromJson(data);

        List<MarksheetListView> templist1= List<MarksheetListView>.from(
            data['marksheetList'].map((x) => MarksheetListView.fromJson(x)));
        marksheetValues.addAll(templist1);
        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        print("Error in response");
      }
    } catch (e) {
      setLoading(false);
      print(e);
    }
  }
}
