import 'dart:convert';
import 'package:essconnect/Domain/Student/ExamTTModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../Domain/Student/TimeTableModel.dart';
import '../../utils/constants.dart';

class Timetableprovider with ChangeNotifier {
  String? url;
  String? createdAt;
  String? extension;
  String? name;
  String? id;

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  String? divIDD;
  Future getDivisionId() async {
    setLoading(true);
    SharedPreferences pref = await SharedPreferences.getInstance();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    setLoading(true);
    var response = await http.get(
        Uri.parse(
            "${UIGuide.baseURL}/upload-exam-timetable/Preview/initvalues"),
        headers: headers);

    try {
      if (response.statusCode == 200) {
        print("corect");
        final data = json.decode(response.body);
        // Map<String, dynamic> initialVal = data['initialValues'];
        DivisionIdModel divi = DivisionIdModel.fromJson(data['initialValues']);
        divIDD = divi.divisionId;
        print(divIDD);
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

  Future getTimeTable(String divId) async {
    setLoading(true);
    SharedPreferences pref = await SharedPreferences.getInstance();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    setLoading(true);
    var response = await http.get(
        Uri.parse(
            "${UIGuide.baseURL}/upload-exam-timetable/guardian-classtimetable/$divId"),
        headers: headers);
    setLoading(true);
    try {
      if (response.statusCode == 200) {
        print("corect");
        Map<String, dynamic> data = json.decode(response.body);
        Map<String, dynamic> timetableRespo = data['viewClassTimeTable'];
        Item1 prev = Item1.fromJson(timetableRespo['item1']);
        url = prev.url;
        createdAt = prev.createdAt;
        name = prev.name;
        extension = prev.extension;
        id = prev.extension;
        print(name);
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

  String? nameExam;
  String? idExam;
  String? extensionExam;

  String? urlExam;
  Future viewAttachment(String Id) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };

    var response = await http.get(
        Uri.parse(
            "${UIGuide.baseURL}/upload-exam-timetable/guardian-timetable-preview-download/$Id"),
        headers: headers);

    try {
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(data);
        PreviewExamTimeTable reattach =
            PreviewExamTimeTable.fromJson(data['previewExamTimeTable']);
        nameExam = reattach.name;
        urlExam = reattach.url;
        extensionExam = reattach.extension;
        idExam = reattach.id;
        notifyListeners();
      } else {
        print("Error in response");
      }
    } catch (e) {
      print(e);
    }
  }

  //Exam tt
  clearExamList() {
    examList.clear();
    notifyListeners();
  }

  List<ExamTTModel> examList = [];
  Future getExamTimeTable(String id) async {
    setLoading(true);
    SharedPreferences pref = await SharedPreferences.getInstance();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    setLoading(true);
    var response = await http.get(
        Uri.parse(
            "${UIGuide.baseURL}/upload-exam-timetable/guardian-timetable-view/$id"),
        headers: headers);

    try {
      if (response.statusCode == 200) {
        print("corect");
        final data = json.decode(response.body);
        List<ExamTTModel> templist = List<ExamTTModel>.from(
            data!["viewExamTimeTableList"].map((x) => ExamTTModel.fromJson(x)));
        examList.addAll(templist);

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
