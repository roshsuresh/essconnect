import 'dart:convert';
import 'dart:developer';
import 'package:essconnect/Domain/Staff/StudentReport_staff.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../utils/constants.dart';

Map? staffStudReportRespo;
List? studReportinitvalues_stf;

class StudReportListProvider_stf with ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

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
    stdReportInitialValues.clear();
    notifyListeners();
  }

  List<StudReportSectionList> stdReportInitialValues = [];

  Future stdReportSectionStaff() async {
    setLoading(true);
    SharedPreferences pref = await SharedPreferences.getInstance();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    try {
      var response = await http.get(
          Uri.parse(
              "${UIGuide.baseURL}/mobileapp/staffdet/studentreportinitialvalues"),
          headers: headers);

      if (response.statusCode == 200) {
        setLoading(true);
        print("corect");
        final data = json.decode(response.body);

        //print(data);
        staffStudReportRespo = data['studentReportInitialValues'];
        studReportinitvalues_stf = staffStudReportRespo!['sectionList'];
        print(studReportinitvalues_stf);
        // print(staffStudReportRespo);
        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        print("Error in StdReportSection response");
      }
    } catch (e) {
      setLoading(false);
      print(e);
    }
  }

//course List

  List<StudReportCourse> studReportCourse = [];
  addSelectedCourse(StudReportCourse item) {
    if (studReportCourse.contains(item)) {
      print("removing");
      studReportCourse.remove(item);
      notifyListeners();
    } else {
      print("adding");
      studReportCourse.add(item);
      notifyListeners();
    }
    clearAllFilters();
    //addFilterCourse(studReportCourse.first.text);
  }

  removeCourse(StudReportCourse item) {
    studReportCourse.remove(item);
    notifyListeners();
  }

  removeCourseAll() {
    studReportCourse.clear();
  }

  isCourseSelected(
    StudReportCourse item,
  ) {
    if (studReportCourse.contains(item)) {
      return true;
    } else {
      return false;
    }
  }

  courseClear() {
    courselist.clear();
    notifyListeners();
  }

  List<StudReportCourse> courselist = [];

  Future getCourseList(String sectionId) async {
    setLoading(true);
    SharedPreferences pref = await SharedPreferences.getInstance();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    try {
      var request = http.Request(
          'GET',
          Uri.parse(
              '${UIGuide.baseURL}/mobileapp/staffdet/studentreport/course/$sectionId'));
      request.body = json.encode({"SchoolId": pref.getString('schoolId')});
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        setLoading(true);
        Map<String, dynamic> data =
            jsonDecode(await response.stream.bytesToString());
        List<StudReportCourse> templist = List<StudReportCourse>.from(
            data["course"].map((x) => StudReportCourse.fromJson(x)));
        courselist.addAll(templist);
        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        print('Error in courseList stf');
      }
    } catch (e) {
      setLoading(false);
    }
  }

  //Division List

  List<StudReportDivision> studReportDivision = [];
  addSelectedDivision(StudReportDivision item) {
    if (studReportDivision.contains(item)) {
      print("removing");
      studReportDivision.remove(item);
      notifyListeners();
    } else {
      print("adding");
      studReportDivision.add(item);
      notifyListeners();
    }
  }

  void selectItem(ViewStudentReport model) {
    ViewStudentReport selected = viewStudReportListt
        .firstWhere((element) => element.admnNo == model.admnNo);
    selected.selected ??= false;
    selected.selected = !selected.selected!;
    print(selected.toJson());
    notifyListeners();
  }

  removeDivision(StudReportDivision item) {
    studReportDivision.remove(item);
    notifyListeners();
  }

  removeDivisionAll() {
    studReportDivision.clear();
  }

  isDivisionSelected(
    StudReportDivision item,
  ) {
    if (studReportDivision.contains(item)) {
      return true;
    } else {
      return false;
    }
  }

  divisionClear() {
    divisionlist.clear();
    notifyListeners();
  }

  List<StudReportDivision> divisionlist = [];

  Future getDivisionList(String courseId) async {
    setLoading(true);
    SharedPreferences pref = await SharedPreferences.getInstance();

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    try {
      var request = http.Request(
          'GET',
          Uri.parse(
              '${UIGuide.baseURL}/mobileapp/staffdet/studentreport/divisions/$courseId'));
      request.body = json.encode({"SchoolId": pref.getString('schoolId')});
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        setLoading(true);
        Map<String, dynamic> data =
            jsonDecode(await response.stream.bytesToString());

        log(data.toString());

        List<StudReportDivision> templist = List<StudReportDivision>.from(
            data["divisionbyCourse"]
                .map((x) => StudReportDivision.fromJson(x)));
        divisionlist.addAll(templist);
        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        print('Error in DivisionList stf');
      }
    } catch (e) {
      setLoading(false);
    }
  }

  //view initial

  List<ViewStudentReport> viewStudReportListt = [];
  List<ViewStudentReport> viewterminatedList = [];
  List<ViewStudentReport> viewNotTerminatedList = [];
  Future viewStudentReportList(
      String section, String course, String division) async {
    setLoading(true);
    SharedPreferences pref = await SharedPreferences.getInstance();

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    try {
      var request = http.Request(
          'GET',
          Uri.parse(
              '${UIGuide.baseURL}/mobileapp/staffdet/studentreport/viewStudentReport?section=$section&course=$course&division=$division'));
      request.body = json.encode({"SchoolId": pref.getString('schoolId')});
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
   print(request);
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

  clearViewList() {
    viewStudReportListt.clear();
    viewNotTerminatedList.clear();
    viewterminatedList.clear();
    notifyListeners();
  }
}
