import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../Domain/Staff/MissingModel.dart/InitialMissingReportModel.dart';
import '../../Domain/Staff/MissingModel.dart/StaffViewModel.dart';
import '../../Domain/Staff/MissingModel.dart/StudViewModel.dart';
import '../../utils/constants.dart';

class MissingReportProviders with ChangeNotifier {
  courseClear() {
    missingInitialValues.clear();
    notifyListeners();
  }

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  List<CourseListMissingReport> missingInitialValues = [];
  Future getInitialValues() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    try {
      var request = http.Request('GET',
          Uri.parse('${UIGuide.baseURL}/markentryMissingRpt/initialvalues'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        setLoading(true);
        Map<String, dynamic> data =
            jsonDecode(await response.stream.bytesToString());

        List<CourseListMissingReport> templist =
            List<CourseListMissingReport>.from(data["courseList"]
                .map((x) => CourseListMissingReport.fromJson(x)));
        missingInitialValues.addAll(templist);
        print(templist);
        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        print('Error in InitialValues');
      }
    } catch (e) {
      setLoading(false);
    }
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

  Future getDivisionList(String courseId) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    try {
      var request = http.Request(
          'GET',
          Uri.parse(
              '${UIGuide.baseURL}/markentryMissingRpt/division/$courseId'));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        setLoading(true);
        Map<String, dynamic> data =
            jsonDecode(await response.stream.bytesToString());
        log(data.toString());

        List<DivisionListReport> templist = List<DivisionListReport>.from(
            data["courseList"].map((x) => DivisionListReport.fromJson(x)));
        divisionList.addAll(templist);
        divisionDrop = divisionList.map((subjectdata) {
          return MultiSelectItem(subjectdata, subjectdata.text!);
        }).toList();
        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        print('Error in division & Part stf');
      }
    } catch (e) {
      setLoading(false);
    }
  }

  //PART

  Future getPartList(String divisionId) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    try {
      setLoading(true);
      var request = http.Request('GET',
          Uri.parse('${UIGuide.baseURL}/markentryMissingRpt/part/$divisionId'));
      request.headers.addAll(headers);
      print('part/$divisionId');
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        setLoading(true);
        Map<String, dynamic> data =
            jsonDecode(await response.stream.bytesToString());
        log(data.toString());

        List<PartList> templist = List<PartList>.from(
            data["partList"].map((x) => PartList.fromJson(x)));
        partList.addAll(templist);
        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);

        print('Error in division & Part stf');
      }
    } catch (e) {
      setLoading(false);
    }
  }

  //Exam

  examClear() {
    examList.clear();
    notifyListeners();
  }

  List<ExamsListReport> examList = [];
  Future getExamValues(String course, String part, List divisi) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    try {
      var request = http.Request(
          'POST', Uri.parse('${UIGuide.baseURL}/markentryMissingRpt/exam'));
      request.body = json.encode({
        "courseId": course,
        "partId": part,
        "divisionId": divisi,
        "subjectId": null,
        "examId": null,
        "userId": null,
        "showStudentwiseRpt": false
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        setLoading(true);
        Map<String, dynamic> data =
            jsonDecode(await response.stream.bytesToString());
        print("exam-----$data");
        List<ExamsListReport> templist = List<ExamsListReport>.from(
            data["exams"].map((x) => ExamsListReport.fromJson(x)));
        examList.addAll(templist);
        print(templist);
        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        print('Error in Exam');
      }
    } catch (e) {
      setLoading(false);
    }
  }

  //--  Subject
  List<SubjectListModel> subjectList = [];
  List<MultiSelectItem> subjectDrop = [];
  List<UsersListModel> userList = [];
  List<MultiSelectItem> userDrop = [];

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

  int userLen = 0;
  userCounter(int len) async {
    userLen = 0;
    if (len == 0) {
      userLen = 0;
    } else {
      userLen = len;
    }
    notifyListeners();
  }

  clearSubject() {
    subjectDrop.clear();
    subjectList.clear();
    userDrop.clear();
    userList.clear();
    notifyListeners();
  }

  Future getSubjectList(
      String courseId, String partID, String exam, List div) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    try {
      var request = http.Request(
          'POST', Uri.parse('${UIGuide.baseURL}/markentryMissingRpt/subjects'));
      request.body = json.encode({
        "courseId": courseId,
        "partId": partID,
        "divisionId": div,
        "subjectId": null,
        "examId": exam,
        "userId": null,
        "showStudentwiseRpt": false
      });
      log(request.body.toString());
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        setLoading(true);
        Map<String, dynamic> data =
            jsonDecode(await response.stream.bytesToString());
        log(data.toString());

        List<SubjectListModel> templist = List<SubjectListModel>.from(
            data["subjectList"].map((x) => SubjectListModel.fromJson(x)));
        subjectList.addAll(templist);
        subjectDrop = subjectList.map((subjectdata) {
          return MultiSelectItem(subjectdata, subjectdata.text!);
        }).toList();

        List<UsersListModel> templist1 = List<UsersListModel>.from(
            data["users"].map((x) => UsersListModel.fromJson(x)));
        userList.addAll(templist1);
        userDrop = userList.map((subjectdata) {
          return MultiSelectItem(subjectdata, subjectdata.text!);
        }).toList();
        setLoading(false);

        notifyListeners();
      } else {
        setLoading(false);
        print('Error in subject stf');
      }
    } catch (e) {
      setLoading(false);
    }
  }

  //View  staff
  clearViewStaffList() async {
    viewStaffList.clear();
    notifyListeners();
  }
  //Checkbox

  bool isShown = false;

  studentWiseCheckbox() async {
    isShown = !isShown;
    await clearViewStaffList();
    await clearViewStudentList();
    notifyListeners();
  }

  List division = [];

  List subject = [];

  List<MeListStaff> viewStaffList = [];
  Future getView(String courseId, String partID, String exam, division, subject,
      bool checked, BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    try {
      var request = http.Request('POST',
          Uri.parse('${UIGuide.baseURL}/markentryMissingRpt/viewreport'));
      request.body = json.encode({
        "courseId": courseId,
        "partId": partID,
        "divisionId": division,
        "subjectId": subject,
        "examId": exam,
        "userId": null,
        "showStudentwiseRpt": checked
      });
      setLoading(true);
      print(request.body);
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        setLoading(true);
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

        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        print('Error in view stf');
      }
    } catch (e) {
      setLoading(false);
    }
  }

  //View  student
  clearViewStudentList() async {
    viewStudentList.clear();
    notifyListeners();
  }

  List<MeListModel> viewStudentList = [];

  List divisionn = [];

  List subjectt = [];
  Future getViewStudent(String courseId, String partID, String exam, divisionn,
      subjectt, bool checked, BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    try {
      var request = http.Request('POST',
          Uri.parse('${UIGuide.baseURL}/markentryMissingRpt/viewreport'));
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
        setLoading(true);
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
        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        print('Error in view student');
      }
    } catch (e) {
      setLoading(false);
    }
  }

  //Admin

  Future getViewAdmin(String courseId, String partID, String exam, division,
      subject, bool checked, BuildContext context, List userL) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    try {
      var request = http.Request('POST',
          Uri.parse('${UIGuide.baseURL}/markentryMissingRpt/viewreport'));
      request.body = json.encode({
        "courseId": courseId,
        "partId": partID,
        "divisionId": division,
        "subjectId": subject,
        "examId": exam,
        "userId": userL,
        "showStudentwiseRpt": checked
      });
      setLoading(true);
      print(request.body);
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        setLoading(true);
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

        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        print('Error in view stf');
      }
    } catch (e) {
      setLoading(false);
    }
  }

  //View  student

  Future getViewStudentAdmin(
      String courseId,
      String partID,
      String exam,
      divisionn,
      subjectt,
      bool checked,
      BuildContext context,
      List userL) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    try {
      var request = http.Request('POST',
          Uri.parse('${UIGuide.baseURL}/markentryMissingRpt/viewreport'));
      request.body = json.encode({
        "courseId": courseId,
        "partId": partID,
        "divisionId": divisionn,
        "subjectId": subjectt,
        "examId": exam,
        "userId": userL,
        "showStudentwiseRpt": checked
      });
      print(request.body);
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        setLoading(true);
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
        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        print('Error in view student');
      }
    } catch (e) {
      setLoading(false);
    }
  }
}
