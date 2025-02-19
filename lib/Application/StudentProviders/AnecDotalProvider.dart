import 'dart:convert';
import 'package:essconnect/Domain/Student/AnecDotalModel.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AnecDotalStudViewProvider with ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  String? maxDate;


  Future getanecDotalInitial() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };



    var response = await http.get(
        Uri.parse(
            "${UIGuide.baseURL}/anecdotal-view/anecdotal-list"),
        headers: headers);

    if (response.statusCode == 200 ) {

      Map<String, dynamic> data = await json.decode(response.body);
      AnecDotalInitial inita = AnecDotalInitial.fromJson(data);
      maxDate =inita.maxDate;
      setLoading(false);
      notifyListeners();
    } else {
      setLoading(false);
      print("Error in anecdotal response");
    }
  }



  List<AnacDotalData> anecdotalDataList = [];
  String? date;
  List<AnecdotalList> anecdotallist = [];
  Future getanecDotalVieList(String fromDate,String toDate ) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };



    var response = await http.get(
        Uri.parse(
            "${UIGuide.baseURL}/anecdotal-view/anecdotal-datewise-view?fromDate=$fromDate&toDate=$toDate"),
        headers: headers);
    print(response);

    print(Uri.parse(
        "${UIGuide.baseURL}/anecdotal-view/anecdotal-datewise-view?fromDate=$fromDate&toDate=$toDate"),
    );

    if (response.statusCode == 200 ) {
      final List<dynamic> responseData = json.decode(response.body);
      print("roshssssss");

      anecdotalDataList = responseData.map((data) => AnacDotalData.fromJson(data)).toList();
      print("liniiiii");
      print(anecdotalDataList);

      print(date);
      print(anecdotalDataList.length);
      //anecdotallist.clear();

      for(int i=0;i<anecdotalDataList.length;i++) {
        List<AnecdotalList> templist = List<AnecdotalList>.from(
            responseData[i]["anecdotalList"].map((x) =>
                AnecdotalList.fromJson(x)));
        anecdotallist.addAll(templist);
        print(anecdotallist);
      }

      setLoading(false);
      notifyListeners();
    } else {
      setLoading(false);
      print("Error in anecdotal response");
    }
  }



  //update count

  Future seeAnecdotal() async {
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
            '${UIGuide.baseURL}/mobileapp/token/updateAnecdotalStatus?Type=Student&StudentId=$studId'));
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
      print('Error in anecdotal respo');
    }
  }
  clearanecdotal() {
    anecdotallist.clear();
    notifyListeners();
  }
}
