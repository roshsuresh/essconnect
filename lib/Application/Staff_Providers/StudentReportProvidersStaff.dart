import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../Domain/Staff/StudentReport_staff.dart';
import '../../utils/constants.dart';

class StudentReportProviderStaff with ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  initialClear() {
    sectionList.clear();
    initialCourseList.clear();
    initialDivisionList.clear();
    viewStudReportListt.clear();
    viewNotTerminatedList.clear();
    viewterminatedList.clear();
    notifyListeners();
  }

  List<StudReportCourse> sectionList = [];
  List<StudReportCourse> initialCourseList = [];
  List<StudReportCourse> initialDivisionList = [];

  Future getInitialList() async {
    sectionList.clear();
    initialCourseList.clear();
    initialDivisionList.clear();
    viewStudReportListt.clear();
    viewNotTerminatedList.clear();
    viewterminatedList.clear();
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    try {
      var request = http.Request('GET',
          Uri.parse('${UIGuide.baseURL}/student/studentReport/initialvalues'));
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        setLoading(true);
        var data = jsonDecode(await response.stream.bytesToString());

        //section
        List<StudReportCourse> templist = List<StudReportCourse>.from(
            data["sections"].map((x) => StudReportCourse.fromJson(x)));
        sectionList.addAll(templist);

        //course

        List<StudReportCourse> templist2 = List<StudReportCourse>.from(
            data["courses"].map((x) => StudReportCourse.fromJson(x)));
        initialCourseList.addAll(templist2);

        //division

        List<StudReportCourse> templist3 = List<StudReportCourse>.from(
            data["divisions"].map((x) => StudReportCourse.fromJson(x)));
        initialDivisionList.addAll(templist3);
        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        print('Error in initial stf');
      }
    } catch (e) {
      setLoading(false);
      print(e);
    }
  }

  Future getCourseList(String sectionId) async {
    initialCourseList.clear();
    viewStudReportListt.clear();
    viewNotTerminatedList.clear();
    viewterminatedList.clear();
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
              '${UIGuide.baseURL}/student/studentReport/courses/$sectionId'));
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        setLoading(true);
        var data = jsonDecode(await response.stream.bytesToString());
        List<StudReportCourse> templist = List<StudReportCourse>.from(
            data.map((x) => StudReportCourse.fromJson(x)));
        initialCourseList.addAll(templist);
        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        print('Error in courseList stf');
      }
    } catch (e) {
      setLoading(false);
      print(e);
    }
  }

// Division by section
  Future getDivisionBySectionList(String sectionId) async {
    initialDivisionList.clear();
    viewStudReportListt.clear();
    viewNotTerminatedList.clear();
    viewterminatedList.clear();
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
              '${UIGuide.baseURL}/student/studentReport/divisionsection/$sectionId'));
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        setLoading(true);
        var data = jsonDecode(await response.stream.bytesToString());
        List<StudReportCourse> templist = List<StudReportCourse>.from(
            data.map((x) => StudReportCourse.fromJson(x)));
        initialDivisionList.addAll(templist);
        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        print('Error in getDivisionBySectionList stf');
      }
    } catch (e) {
      setLoading(false);
      print(e);
    }
  }

  // Division
  Future getDivisionList(String courseID) async {
    initialDivisionList.clear();
    viewStudReportListt.clear();
    viewNotTerminatedList.clear();
    viewterminatedList.clear();
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
              '${UIGuide.baseURL}/student/studentReport/divisions/$courseID'));
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        setLoading(true);
        var data = jsonDecode(await response.stream.bytesToString());
        List<StudReportCourse> templist = List<StudReportCourse>.from(
            data.map((x) => StudReportCourse.fromJson(x)));
        initialDivisionList.addAll(templist);
        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        print('Error in getDivisionBySectionList stf');
      }
    } catch (e) {
      setLoading(false);
      print(e);
    }
  }

  // view

  List<ViewStudentReport> viewStudReportListt = [];
  List<ViewStudentReport> viewterminatedList = [];
  List<ViewStudentReport> viewNotTerminatedList = [];
  Future viewStudentReportList(
      String section, String course, String division) async {
    setLoading(true);
    viewStudReportListt.clear();
    viewNotTerminatedList.clear();
    viewterminatedList.clear();
    SharedPreferences pref = await SharedPreferences.getInstance();

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    print("section===$section");
    try {
      var request = http.Request(
          'GET',
          Uri.parse(
              '${UIGuide.baseURL}/mobileapp/staffdet/studentreport/viewStudentReport?section=$section&course=$course&division=$division'));
      request.body = json.encode({"SchoolId": pref.getString('schoolId')});
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      log(request.toString());
      if (response.statusCode == 200) {
        Map<String, dynamic> data =
            jsonDecode(await response.stream.bytesToString());
        print(data);
        List<ViewStudentReport> templist = List<ViewStudentReport>.from(
            data["viewStudentReport"]
                .map((x) => ViewStudentReport.fromJson(x)));
        viewStudReportListt.addAll(templist);

        viewNotTerminatedList = viewStudReportListt
            .where((item) => item.terminationStatus == false)
            .toList();

        viewterminatedList = viewStudReportListt
            .where((item) => item.terminationStatus == true)
            .toList();

        print(viewStudReportListt.length);
        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        print('Error in ViewList stf');
      }
    } catch (e) {
      setLoading(false);
      print(e);
    }
  }

  //Search

  Future searchStudentReportListStaff(
      String section, String course, String division, String word) async {
    setLoading(true);
    viewStudReportListt.clear();
    SharedPreferences pref = await SharedPreferences.getInstance();

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    try {
      print("section===$section");
      var request = http.Request(
          'GET',
          Uri.parse(
              '${UIGuide.baseURL}/mobileapp/staffdet/studentreport/viewStudentReport?search=$word&section=$section&course=$course&division=$division'));
      request.body = json.encode({"SchoolId": pref.getString('schoolId')});
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      log(request.toString());
      if (response.statusCode == 200) {
        Map<String, dynamic> data =
            jsonDecode(await response.stream.bytesToString());
        print(data);
        List<ViewStudentReport> templist = List<ViewStudentReport>.from(
            data["viewStudentReport"]
                .map((x) => ViewStudentReport.fromJson(x)));
        viewStudReportListt.addAll(templist);

        print(viewStudReportListt.length);
        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        print('Error in ViewList stf');
      }
    } catch (e) {
      setLoading(false);
    }
  }
}
