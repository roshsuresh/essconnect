import 'dart:convert';
import 'package:essconnect/Domain/Staff/StudentReport_staff.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class TimetableStaffProviders with ChangeNotifier {
  //Section List
  List<StudReportSectionList> selectedSection = [];
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
  }

  removeSection(StudReportSectionList item) {
    selectedSection.remove(item);
    notifyListeners();
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
    sectionList.clear();
  }

  List<StudReportSectionList> sectionList = [];

  Future stdReportSectionStaff() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };

    var response = await http.get(
        Uri.parse(
            "${UIGuide.baseURL}/mobileapp/staffdet/studentreportinitialvalues"),
        headers: headers);

    try {
      if (response.statusCode == 200) {
        print("corect");
        Map<String, dynamic> data = json.decode(response.body);
        Map<String, dynamic> staffStudReportRespo =
            data['studentReportInitialValues'];
        print(staffStudReportRespo);
        List<StudReportSectionList> templist = List<StudReportSectionList>.from(
            staffStudReportRespo['sectionList']
                .map((x) => StudReportSectionList.fromJson(x)));
        sectionList.addAll(templist);
        notifyListeners();
      } else {
        print("Error in StdReportSection response");
      }
    } catch (e) {
      print(e);
    }
  }
}
