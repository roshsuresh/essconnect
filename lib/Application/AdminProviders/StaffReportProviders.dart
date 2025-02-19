import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Domain/Admin/StaffReportModel.dart';
import '../../Domain/Staff/StudentReport_staff.dart';
import '../../utils/constants.dart';

class StaffReportProviders with ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  clearStudentList() {
    staffReportList.clear();
    notifyListeners();
  }

  List<StaffReportByAdmin> staffReportList = [];
  Future<bool> staffReportt(String terminateStatus) async {
    setLoading(true);
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    var request = http.Request(
        'GET', Uri.parse('${UIGuide.baseURL}/mobileapp/admin/viewStaffReport/?terminatedStatus=$terminateStatus'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      Map<String, dynamic> data =
      jsonDecode(await response.stream.bytesToString());
      List<StaffReportByAdmin> templist = List<StaffReportByAdmin>.from(
          data["staffReport"].map((x) => StaffReportByAdmin.fromJson(x)));
      staffReportList.addAll(templist);
      setLoading(false);
      notifyListeners();
    } else {
      setLoading(false);
      print('Error in staffReport stf');
    }
    return true;
  }

  //section List

  List<StudReportSectionList> selectedSection = [];

  String filtersDivision = "";
  String filterCourse = "";

  addFilterSection(String section) {
    filterCourse = section;
    notifyListeners();
  }

  addFilterCourse(String course) {
    filterCourse = course;
    notifyListeners();
  }

  addFilters(String f) {
    filtersDivision = f;
  }

  clearAllFilters() {
    filtersDivision = "";
    filterCourse = "";
    staffReportList.clear();

    notifyListeners();
  }

  //Section List
  addSelectedSection(StudReportSectionList item) {
    if (selectedSection.contains(item)) {
      print("removing");
      selectedSection.remove(item);
      notifyListeners();
    } else {
      print("adding");
      selectedSection.add(item);
      notifyListeners();
    }
    clearAllFilters();
    addFilterSection(selectedSection.first.text!);
  }

  removeSection(StudReportSectionList item) {
    selectedSection.remove(item);
  }

  removeSectionAll() {
    selectedSection.clear();
  }

  isSectionSelected(StudReportSectionList item) {
    if (selectedSection.contains(item)) {
      return true;
    } else {
      return false;
    }
  }

  sectionClear() {
    stdReportInitialValues.clear();
    notifyListeners();
  }

  List<StudReportSectionList> stdReportInitialValues = [];

  Future stdReportSectionStaff() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    var response = await http.get(
        Uri.parse(
            "${UIGuide.baseURL}/mobileapp/staffdet/studentreportinitialvalues"),
        headers: headers);
    try {
      if (response.statusCode == 200) {
        print("corect");
        notifyListeners();
      } else {
        print("Error in StdReportSection response");
      }
    } catch (e) {
      print(e);
    }
  }
}
