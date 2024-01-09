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
  String? name;
  String? extension;
  bool isLoading = false;
  String? url;
  String? id;

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  List<MarksheetList> marksheetList = [];
  clearReportCard() {
    marksheetList.clear();
    notifyListeners();
  }

  bool? isLocked;
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
    try {
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        ReportModel repo = ReportModel.fromJson(data);
        isLocked = repo.isLocked;
        // reportResponse = data['reportCardList'];
        List<MarksheetList> templist = List<MarksheetList>.from(
            data['marksheetList'].map((x) => MarksheetList.fromJson(x)));
        marksheetList.addAll(templist);
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

  Future reportCardAttachment(String fileId) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    String file = fileId.toString();
    var response = await http.get(
        Uri.parse("${UIGuide.baseURL}/parent-report-card/preview/$file"),
        headers: headers);
    print(response);
    try {
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        ReportAttachment reattach = ReportAttachment.fromJson(data);
        name = reattach.name;
        url = reattach.url;
        extension = reattach.extension;
        id = reattach.id;
        log('.................$url');
        print(data);
        notifyListeners();
      } else {
        print("Error in response");
      }
    } catch (e) {
      print(e);
    }
  }
}
