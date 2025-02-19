import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


import '../../Domain/Student/DiaryModel.dart';
import '../../utils/constants.dart';

class DiaryProvidersstud with ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  List<DiaryList> diarylist = [];
  Future getDiaryList() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };

    var request = http.Request(
        'GET', Uri.parse('${UIGuide.baseURL}/mobileapp/parents/getDiary'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Map<String, dynamic> data =
          jsonDecode(await response.stream.bytesToString());

      List<DiaryList> templist = List<DiaryList>.from(
          data["diaryList"].map((x) => DiaryList.fromJson(x)));
      diarylist.addAll(templist);
      setLoading(false);
      notifyListeners();
    } else {
      setLoading(false);
      print("Error in diarylist response");
    }
  }

  clearDiary() {
    diarylist.clear();
    notifyListeners();
  }
}
