import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../Domain/Student/ReportCardModel.dart';
import '../../utils/constants.dart';

//List reportResponse = [];

class ReportCardProvider with ChangeNotifier {
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

  List<ReportCardModel> reportcardList = [];
  clearReportCard() {
    reportcardList.clear();
    notifyListeners();
  }

  bool? isLocked;
  Future getReportCard() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    setLoading(true);
    var response = await http.get(
        Uri.parse(
            "${UIGuide.baseURL}/mobileapp/parents/tabulation/initialvalues"),
        headers: headers);
    try {
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        ReportModel repo = ReportModel.fromJson(data);
        isLocked = repo.isLocked;
        // reportResponse = data['reportCardList'];
        List<ReportCardModel> templist = List<ReportCardModel>.from(
            data['reportCardList'].map((x) => ReportCardModel.fromJson(x)));
        reportcardList.addAll(templist);
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
    SharedPreferences pref = await SharedPreferences.getInstance();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
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


  //////////////Hpc Report Card /////////////////////

  String? hpcname;
  String? hpcextension;
  // bool isLoading = false;
  String? hpcurl;
  String? hpcid;

  List<ReportCardModel> hpcreportcardList = [];
  clearHpcReportCard() {
    hpcreportcardList.clear();
    notifyListeners();
  }

  bool? isLocked_hpc;

  Future getHpcReportCard() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    setLoading(true);
    var response = await http.get(
        Uri.parse(
            "${UIGuide.baseURL}/parent-report-card/hpc-report-card"),
        headers: headers);
    try {
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        ReportModel hpcrepo = ReportModel.fromJson(data);
        isLocked_hpc = hpcrepo.isLocked;
        // reportResponse = data['reportCardList'];
        List<ReportCardModel> templist1 = List<ReportCardModel>.from(
            data['reportCardList'].map((x) => ReportCardModel.fromJson(x)));
        hpcreportcardList.addAll(templist1);
        print(hpcreportcardList);
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
  Future HpcreportCardAttachment(String fileId) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    String file = fileId.toString();
    var response = await http.get(
        Uri.parse("${UIGuide.baseURL}/parent-report-card/preview/$file"),
        headers: headers);
    print(response);
    try {
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        ReportAttachment hpc_reattach = ReportAttachment.fromJson(data);
        hpcname = hpc_reattach.name;
        hpcurl = hpc_reattach.url;
        hpcextension = hpc_reattach.extension;
        hpcid = hpc_reattach.id;
        log('.................$hpcurl');
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
