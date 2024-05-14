import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../Domain/Student/Noticeattachmentmodel.dart';
import '../../utils/constants.dart';

List? noticeresponse;
Map? attachResponse;

class NoticeProvider with ChangeNotifier {
  String? title;
  String? matter;
  DateTime? date;
  String noticeId = "";
  String? extension;
  String? name;
  String? idd;
  String? url;

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future getnoticeList() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };

    setLoading(true);
    var response = await http.get(
        Uri.parse("${UIGuide.baseURL}/mobileapp/parent/noticeboard-details"),
        headers: headers);
    try {
      if (response.statusCode == 200) {
        setLoading(true);

        final data = json.decode(response.body);

        noticeresponse = data["noticeBoardDetails"];
        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        print("Error in Response");
      }
    } catch (e) {
      print(e);
    }
  }

  Future noticeAttachement(String noticeId) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    final id = noticeId.toString();

    var response = await http.get(
        Uri.parse(
            "${UIGuide.baseURL}/mobileapp/parent/noticeboard-attachment/$id"),
        headers: headers);
    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(response.body);
        attachResponse = json.decode(response.body);

        AttachmentModel attach = AttachmentModel.fromJson(data);
        extension = attach.extension;
        url = attach.url;
        name = attach.name;
        idd = attach.id;
        print("object  $extension");
        notifyListeners();
      } else {
        print('Error in response');
      }
    } catch (e) {
      print(e);
    }
  }

  Future seeNoticeBoard() async {
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
            '${UIGuide.baseURL}/mobileapp/token/updateNoticeboardStatus?Type=Student&StudentId=$studId'));
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
      print('Error in noticecount respo');
    }
  }


}
