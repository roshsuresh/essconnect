import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Domain/Staff/MarkEntryReport.dart';
import '../../utils/constants.dart';

class MarkEntryReportProvider_stf with ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  courseClear() {
    markReportCourseList.clear();
  }

  List<MarkReportCourseList> markReportCourseList = [];
  bool? isClassTeacher;
  bool? isDualAttendance;

  Future markReportcourse() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    try {
      var response = await http.get(
          Uri.parse("${UIGuide.baseURL}/markentryReport/initialvalues"),
          headers: headers);

      if (response.statusCode == 200) {
        setLoading(true);
        print("corect");
        final data = json.decode(response.body);

        print(data);
        List<MarkReportCourseList> templist = List<MarkReportCourseList>.from(
            data["courseList"].map((x) => MarkReportCourseList.fromJson(x)));
        markReportCourseList.addAll(templist);
        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        print("Error in MarkentryReport_course response");
      }
    } catch (e) {
      setLoading(false);
      print(e);
    }
  }

  //division list

  divisionClear() {
    markReportDivisions.clear();
    divisionDrop.clear();
  }

  List<MarkReportDivisions> markReportDivisions = [];
  List<MultiSelectItem> divisionDrop = [];
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

  Future markReportDivisionList(String courseId) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    try {
      var response = await http.get(
          Uri.parse(
              "${UIGuide.baseURL}/markentryReport/coursedetails/$courseId"),
          headers: headers);

      if (response.statusCode == 200) {
        setLoading(true);
        print("corect");
        final data = json.decode(response.body);

        print(data);
        List<MarkReportDivisions> templist = List<MarkReportDivisions>.from(
            data["divisions"].map((x) => MarkReportDivisions.fromJson(x)));
        markReportDivisions.addAll(templist);
        divisionDrop = markReportDivisions.map((subjectdata) {
          return MultiSelectItem(subjectdata, subjectdata.text!);
        }).toList();
        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        print("Error in MarkentryReport_Division response");
      }
    } catch (e) {
      setLoading(false);
      print(e);
    }
  }

  //part list

  partClear() {
    markReportPartList.clear();
  }

  List<MarkReportPartList> markReportPartList = [];

  Future markReportPart(String courseId) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    try {
      var response = await http.get(
          Uri.parse(
              "${UIGuide.baseURL}/markentryReport/coursedetails/$courseId"),
          headers: headers);

      if (response.statusCode == 200) {
        setLoading(true);
        print("corect");
        final data = json.decode(response.body);

        print(data);
        List<MarkReportPartList> templist = List<MarkReportPartList>.from(
            data["parts"].map((x) => MarkReportPartList.fromJson(x)));
        markReportPartList.addAll(templist);
        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        print("Error in MarkentryReport_Parts response");
      }
    } catch (e) {
      setLoading(false);
      print(e);
    }
  }

  //subject
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

  subjectClear() {
    markSubjectList.clear();

    notifyListeners();
  }

  List<MarkReportSubjectList> markSubjectList = [];
  Future markReportSubject(
      String courseId, List division, String part, String exam) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };

    var request = http.Request(
        'POST', Uri.parse('${UIGuide.baseURL}/markentryReport/subjects'));
    request.body = json.encode({
      "courseId": courseId,
      "divisionId": division,
      "partId": part,
      "subjectId": division,
      "examID": exam
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      setLoading(true);

      final data = await jsonDecode(await response.stream.bytesToString());
      print(data);
      List<MarkReportSubjectList> templist = List<MarkReportSubjectList>.from(
          data["subjectList"].map((x) => MarkReportSubjectList.fromJson(x)));
      markSubjectList.addAll(templist);
      subjectDrop = markSubjectList.map((subjectdata) {
        return MultiSelectItem(subjectdata, subjectdata.text!);
      }).toList();
      setLoading(false);
      notifyListeners();
    } else {
      setLoading(false);
      print(response.reasonPhrase);
    }
    return true;
  }

  // exam
  examClear() {
    markReportExamList.clear();

    notifyListeners();
  }

  List<MarkReportExamList> markReportExamList = [];
  Future markReportExam(
      String course, List division, String part, List subject) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    var request = http.Request(
        'POST', Uri.parse('${UIGuide.baseURL}/markentryReport/exam'));
    request.body = json.encode({
      "CourseId": course,
      "DivisionId": division,
      "PartId": part,
      "SubjectId": subject
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      setLoading(true);
      final data = await jsonDecode(await response.stream.bytesToString());
      print(data);
      List<MarkReportExamList> templist = List<MarkReportExamList>.from(
          data["examList"].map((x) => MarkReportExamList.fromJson(x)));
      markReportExamList.addAll(templist);
      setLoading(false);
      notifyListeners();
    } else {
      setLoading(false);
      print(response.reasonPhrase);
    }
  }

  //  showOptions separately

  bool showOptions = false;

  showOptionsCheckbox() {
    showOptions = !showOptions;
    notifyListeners();
  }

  //  showSubsubjects separately

  bool showSubsubjects = false;

  showSubsubjectsCheckbox() {
    showSubsubjects = !showSubsubjects;
    notifyListeners();
  }

  //view

  List meList = [];
  List studList = [];
  List<MarkReportStudentList> markReportStudList = [];

  Future markReportView(
    String course,
    String division,
    String part,
    String exam,
    String subject,
    String subText,
    String divText,
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };

    var request = http.Request(
        'POST', Uri.parse('${UIGuide.baseURL}/markentryReport/view'));
    request.body = json.encode({
      "courseId": course,
      "divisionId": division,
      "divisionIdList": markReportDivisions,
      "partId": part,
      "examId": exam,
      "subjectId": subject,
      "subjectIdList": markSubjectList,
      "showOptions": 0,
      "ShowSubsubjects": 0
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    log(request.body.toString());
    if (response.statusCode == 200) {
      setLoading(true);
      // Map<String, dynamic> data =
      //     jsonDecode(await response.stream.bytesToString());

      // meList = data['meList'];
      // studList = meList[0]['studentList'];
      // print(studList);
      // List<MarkReportStudentList> templist = List<MarkReportStudentList>.from(
      //     meList[0]['studentList']
      //         .map((x) => MarkReportStudentList.fromJson(x)));
      // markReportStudList.addAll(templist);
      print("Correct");
      setLoading(false);
      notifyListeners();
    } else {
      setLoading(false);
      print(" Error in markReportView");
    }
  }
}
