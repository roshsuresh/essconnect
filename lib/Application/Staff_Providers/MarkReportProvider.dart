import 'dart:convert';
import 'package:essconnect/Domain/Staff/MarkEntryReport.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Map? markSubject;
// List? markReportSub;
// List? markRepoExam;

class MarkEntryReportProvider_stf with ChangeNotifier {
//course List

  courseClear() {
    markReportCourseList.clear();
  }

  List<MarkReportCourseList> markReportCourseList = [];
  bool? isClassTeacher;
  bool? isDualAttendance;

  Future markReportcourse() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };

    var response = await http.get(
        Uri.parse("${UIGuide.baseURL}/markentryReport/initialvalues"),
        headers: headers);

    try {
      if (response.statusCode == 200) {
        print("corect");
        final data = json.decode(response.body);

        print(data);
        List<MarkReportCourseList> templist = List<MarkReportCourseList>.from(
            data["courseList"].map((x) => MarkReportCourseList.fromJson(x)));
        markReportCourseList.addAll(templist);

        notifyListeners();
      } else {
        print("Error in MarkentryReport_course response");
      }
    } catch (e) {
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
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };

    var response = await http.get(
        Uri.parse("${UIGuide.baseURL}/markentryReport/coursedetails/$courseId"),
        headers: headers);

    try {
      if (response.statusCode == 200) {
        print("corect");
        final data = json.decode(response.body);

        print(data);
        List<MarkReportDivisions> templist = List<MarkReportDivisions>.from(
            data["divisions"].map((x) => MarkReportDivisions.fromJson(x)));
        markReportDivisions.addAll(templist);
        divisionDrop = markReportDivisions.map((subjectdata) {
          return MultiSelectItem(subjectdata, subjectdata.text!);
        }).toList();

        notifyListeners();
      } else {
        print("Error in MarkentryReport_Division response");
      }
    } catch (e) {
      print(e);
    }
  }

  //part list

  partClear() {
    markReportPartList.clear();
  }

  List<MarkReportPartList> markReportPartList = [];

  Future markReportPart(String courseId) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };

    var response = await http.get(
        Uri.parse("${UIGuide.baseURL}/markentryReport/coursedetails/$courseId"),
        headers: headers);

    try {
      if (response.statusCode == 200) {
        print("corect");
        final data = json.decode(response.body);

        print(data);
        List<MarkReportPartList> templist = List<MarkReportPartList>.from(
            data["parts"].map((x) => MarkReportPartList.fromJson(x)));
        markReportPartList.addAll(templist);

        notifyListeners();
      } else {
        print("Error in MarkentryReport_Parts response");
      }
    } catch (e) {
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
  Future markReportSubject(String courseId, List division, String part) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };

    var request = http.Request(
        'POST', Uri.parse('${UIGuide.baseURL}/markentryReport/subjects'));
    request.body = json
        .encode({"CourseId": courseId, "DivisionId": division, "PartId": part});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final data = await jsonDecode(await response.stream.bytesToString());

      print(data);
      List<MarkReportSubjectList> templist = List<MarkReportSubjectList>.from(
          data["subjectList"].map((x) => MarkReportSubjectList.fromJson(x)));
      markSubjectList.addAll(templist);
      subjectDrop = markSubjectList.map((subjectdata) {
        return MultiSelectItem(subjectdata, subjectdata.text!);
      }).toList();

      notifyListeners();
    } else {
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
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
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
      final data = await jsonDecode(await response.stream.bytesToString());
      print(data);
      List<MarkReportExamList> templist = List<MarkReportExamList>.from(
          data["examList"].map((x) => MarkReportExamList.fromJson(x)));
      markReportExamList.addAll(templist);
      notifyListeners();
    } else {
      print(response.reasonPhrase);
    }
  }

  //view

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  List meList = [];

  List studList = [];

  List<MarkReportStudentList> markReportStudList = [];

  Future markReportView(String course, String division, String part,
      String exam, String subject, String subText, String divText) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };

    var request = http.Request(
        'POST', Uri.parse('${UIGuide.baseURL}/markentryReport/view'));
    request.body = json.encode({
      "courseId": "77d9839f-c910-47d6-94ee-9bd119e2dae7",
      "divisionId":
          "b2ba13d8-9834-4393-ae11-a9714045ec44,be83b908-f6ee-4529-a877-5f927303a275",
      "divisionIdList": [
        {
          "value": "b2ba13d8-9834-4393-ae11-a9714045ec44",
          "text": "I-A",
          "selected": null,
          "active": null,
          "order": 1
        },
        {
          "value": "be83b908-f6ee-4529-a877-5f927303a275",
          "text": "1-B",
          "selected": null,
          "active": null,
          "order": 2
        }
      ],
      "partId": "415854e0-9d90-40c3-bc30-9e1ce619ba29",
      "examId": "Term-1_NBS1",
      "subjectId":
          "f20e6138-e1f7-4d88-8a60-3c73820f1415,75a5d2d1-027a-4f97-900f-8faacf9dc256",
      "subjectIdList": [
        {
          "value": "f20e6138-e1f7-4d88-8a60-3c73820f1415",
          "text": "English",
          "selected": null,
          "active": null,
          "order": null
        },
        {
          "value": "75a5d2d1-027a-4f97-900f-8faacf9dc256",
          "text": "Environmental Studies",
          "selected": null,
          "active": null,
          "order": null
        }
      ],
      "showOptions": 0,
      "ShowSubsubjects": 0
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Map<String, dynamic> data =
          jsonDecode(await response.stream.bytesToString());

      meList = data['meList'];
      studList = meList[0]['studentList'];
      print(studList);
      List<MarkReportStudentList> templist = List<MarkReportStudentList>.from(
          meList[0]['studentList']
              .map((x) => MarkReportStudentList.fromJson(x)));
      markReportStudList.addAll(templist);
      setLoading(false);
      notifyListeners();
    } else {
      setLoading(false);
      print(" Error in markReportView");
    }
  }
}
