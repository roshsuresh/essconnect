import 'dart:convert';
import 'dart:developer';
import 'package:essconnect/Domain/Staff/MissingModel.dart/InitialMissingReportModel.dart';
import 'package:essconnect/Domain/Staff/MissingModel.dart/StaffViewModel.dart';
import 'package:essconnect/Domain/Staff/MissingModel.dart/StudViewModel.dart';
import 'package:flutter/material.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class MissingReportProviders with ChangeNotifier {
  courseClear() {
    missingInitialValues.clear();
    notifyListeners();
  }

  List<CourseListMissingReport> missingInitialValues = [];
  Future<bool> getInitialValues() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    var request = http.Request('GET',
        Uri.parse('${UIGuide.baseURL}/markentryMissingRpt/initialvalues'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Map<String, dynamic> data =
          jsonDecode(await response.stream.bytesToString());

      List<CourseListMissingReport> templist =
          List<CourseListMissingReport>.from(data["courseList"]
              .map((x) => CourseListMissingReport.fromJson(x)));
      missingInitialValues.addAll(templist);
      print(templist);
      notifyListeners();
    } else {
      print('Error in InitialValues');
    }
    return true;
  }

//--  Division --  Part
  List<DivisionListReport> divisionList = [];
  List<MultiSelectItem> divisionDrop = [];
  List<PartList> partList = [];

  int divisionLen = 0;
  divisionCounter(int len) async {
    divisionLen = 0;
    if (len == 0) {
      divisionLen = 0;
    } else {
      divisionLen = len;
    }

    notifyListeners();
  }

  clearDivision() {
    divisionDrop.clear();
    divisionList.clear();
    notifyListeners();
  }

  clearPart() {
    partList.clear();
    notifyListeners();
  }

  Future<bool> getDivisionList(String courseId) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };

    var request = http.Request('GET',
        Uri.parse('${UIGuide.baseURL}/markentryMissingRpt/division/$courseId'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Map<String, dynamic> data =
          jsonDecode(await response.stream.bytesToString());
      log(data.toString());

      List<DivisionListReport> templist = List<DivisionListReport>.from(
          data["courseList"].map((x) => DivisionListReport.fromJson(x)));
      divisionList.addAll(templist);
      divisionDrop = divisionList.map((subjectdata) {
        return MultiSelectItem(subjectdata, subjectdata.text!);
      }).toList();


      notifyListeners();
    } else {
      print('Error in division & Part stf');
    }
    return true;
  }

  //PART

  Future<bool> getPartList(String divisionId) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };

    var request = http.Request('GET',
        Uri.parse('${UIGuide.baseURL}/markentryMissingRpt/part/$divisionId'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Map<String, dynamic> data =
      jsonDecode(await response.stream.bytesToString());
      log(data.toString());


      List<PartList> templist = List<PartList>.from(
          data["partList"].map((x) => PartList.fromJson(x)));
      partList.addAll(templist);
      notifyListeners();
    } else {
      print('Error in division & Part stf');
    }
    return true;
  }

  //Exam

  examClear() {
    examList.clear();
    notifyListeners();
  }

  List<ExamsListReport> examList = [];
  Future<bool> getExamValues(String course, String part) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    var request = http.Request(
        'POST', Uri.parse('${UIGuide.baseURL}/markentryMissingRpt/exam'));
    request.body = json.encode({
      "courseId": course,
      "partId": part,
      "divisionId": null,
      "subjectId": null,
      "examId": null,
      "userId": null,
      "showStudentwiseRpt": false
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Map<String, dynamic> data =
          jsonDecode(await response.stream.bytesToString());

      List<ExamsListReport> templist = List<ExamsListReport>.from(
          data["exams"].map((x) => ExamsListReport.fromJson(x)));
      examList.addAll(templist);
      print(templist);
      notifyListeners();
    } else {
      print('Error in Exam');
    }
    return true;
  }

  //--  Subject
  List<SubjectListModel> subjectList = [];
  List<MultiSelectItem> subjectDrop = [];

  int subjectLen = 0;
  subjectCounter(int len) async {
    subjectLen = 0;
    if (len == 0) {
      subjectLen = 0;
    } else {
      subjectLen = len;
    }

    notifyListeners();
  }

  clearSubject() {
    subjectDrop.clear();
    subjectList.clear();
    notifyListeners();
  }

  Future<bool> getSubjectList(
      String courseId, String partID, String exam) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };

    var request = http.Request(
        'POST', Uri.parse('${UIGuide.baseURL}/markentryMissingRpt/subjects'));
    request.body = json.encode({
      "courseId": courseId,
      "partId": partID,
      "divisionId": null,
      "subjectId": null,
      "examId": exam,
      "userId": null,
      "showStudentwiseRpt": false
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Map<String, dynamic> data =
          jsonDecode(await response.stream.bytesToString());
      log(data.toString());

      List<SubjectListModel> templist = List<SubjectListModel>.from(
          data["subjectList"].map((x) => SubjectListModel.fromJson(x)));
      subjectList.addAll(templist);
      subjectDrop = subjectList.map((subjectdata) {
        return MultiSelectItem(subjectdata, subjectdata.text!);
      }).toList();

      notifyListeners();
    } else {
      print('Error in subject stf');
    }
    return true;
  }

  //View  staff
  clearViewStaffList() async {
    viewStaffList.clear();
    notifyListeners();
  }

  bool _load = false;
  bool get load => _load;
  setLoad(bool value) {
    _load = value;
    notifyListeners();
  }

  List division = [];

  List subject = [];

  List<MeListStaff> viewStaffList = [];
  Future<bool> getView(String courseId, String partID, String exam, division,
      subject, bool checked, BuildContext context) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoad(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };

    var request = http.Request(
        'POST', Uri.parse('${UIGuide.baseURL}/markentryMissingRpt/viewreport'));
    request.body = json.encode({
      "courseId": courseId,
      "partId": partID,
      "divisionId": division,
      "subjectId": subject,
      "examId": exam,
      "userId": null,
      "showStudentwiseRpt": checked
    });
    setLoad(true);
    print(request.body);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      setLoad(true);
      Map<String, dynamic> data =
          jsonDecode(await response.stream.bytesToString());

      List<MeListStaff> templist = List<MeListStaff>.from(
          data["meList"].map((x) => MeListStaff.fromJson(x)));
      viewStaffList.addAll(templist);
      if (viewStaffList.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          duration: Duration(seconds: 3),
          margin: EdgeInsets.only(bottom: 80, left: 30, right: 30),
          behavior: SnackBarBehavior.floating,
          content: Text(
            'No data for specified condition...',
            textAlign: TextAlign.center,
          ),
        ));
      }

      setLoad(false);
      notifyListeners();
    } else {
      setLoad(false);
      print('Error in view stf');
    }
    return true;
  }

  //View  student
  clearViewStudentList() async {
    viewStudentList.clear();
    notifyListeners();
  }

  List<MeListModel> viewStudentList = [];

  List divisionn = [];

  List subjectt = [];
  Future<bool> getViewStudent(String courseId, String partID, String exam,
      divisionn, subjectt, bool checked, BuildContext context) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoad(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };

    var request = http.Request(
        'POST', Uri.parse('${UIGuide.baseURL}/markentryMissingRpt/viewreport'));
    request.body = json.encode({
      "courseId": courseId,
      "partId": partID,
      "divisionId": divisionn,
      "subjectId": subjectt,
      "examId": exam,
      "userId": null,
      "showStudentwiseRpt": checked
    });
    print(request.body);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      setLoad(true);
      Map<String, dynamic> data =
          jsonDecode(await response.stream.bytesToString());

      List<MeListModel> templist = List<MeListModel>.from(
          data["meList"].map((x) => MeListModel.fromJson(x)));
      viewStudentList.addAll(templist);
      if (viewStudentList.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          duration: Duration(seconds: 3),
          margin: EdgeInsets.only(bottom: 80, left: 30, right: 30),
          behavior: SnackBarBehavior.floating,
          content: Text(
            'No data for specified condition...',
            textAlign: TextAlign.center,
          ),
        ));
      }
      setLoad(false);
      notifyListeners();
    } else {
      setLoad(false);
      print('Error in view student');
    }
    return true;
  }
}
