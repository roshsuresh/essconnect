import 'dart:convert';
import 'dart:developer';
import 'package:essconnect/Domain/Admin/schoolPhotoModel.dart';
import 'package:essconnect/Domain/Staff/StudentReport_staff.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SchoolPhotoProviders with ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  String? url;
  Future<int> getSchoolPhoto() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    var response = await http.get(
        Uri.parse("${UIGuide.baseURL}/mobileapp/admin/school/photo"),
        headers: headers);
    if (response.statusCode == 200) {
      setLoading(true);
      Map<String, dynamic> data = json.decode(response.body);
      Map<String, dynamic> school = data['schoolphoto'];
      Schoolphoto ac = Schoolphoto.fromJson(school);
      url = ac.url;
      setLoading(false);
      notifyListeners();
    } else {
      print('Error in dashboard');
    }
    return response.statusCode;
  }

  //section list
  bool _loadingSection = false;
  bool get loadingSection => _loadingSection;
  setloadingSection(bool value) {
    _loadingSection = value;
    notifyListeners();
  }

  List<StudReportSectionList> stdReportInitialValues = [];
  List<MultiSelectItem> dropDown = [];
  Future stdReportSectionStaff() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
   setloadingSection(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };

    var request = http.Request(
        'GET',
        Uri.parse(
            '${UIGuide.baseURL}/sms-to-guardian/initialvalues'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    print(request);


      if (response.statusCode == 200) {
        print("corect");
        setloadingSection(true);
        Map<String, dynamic> data =
        jsonDecode(await response.stream.bytesToString());

       // List<StudReportSectionList> templist = List<StudReportSectionList>.from(
       //      data["sectionList"].map((x) => StudReportSectionList.fromJson(x)));
       //   stdReportInitialValues.addAll(templist);
        List<StudReportSectionList> templist =
        List<StudReportSectionList>.from(data["sections"]
            .map((x) => StudReportSectionList.fromJson(x)));
        stdReportInitialValues.addAll(templist);


        dropDown = stdReportInitialValues.map((subjectdata) {
          return MultiSelectItem(subjectdata, subjectdata.text!);
        }).toList();
        List<StudReportCourse> templist2 = List<StudReportCourse>.from(data["courses"]
            .map((x) => StudReportCourse.fromJson(x)));
        courselist.addAll(templist2);

        print(courselist.toList());


        List<StudReportDivision> templist3 = List<StudReportDivision>.from(data["divisions"]
            .map((x) => StudReportDivision.fromJson(x)));
        divisionSectionlist.addAll(templist3);
        print(divisionSectionlist.toList());

        setloadingSection(false);
        notifyListeners();
      } else {
        setloadingSection(false);
        print("Error in notification response");
      }

  }

  //divisionsetion

  List<StudReportDivision> divisionSectionlist = [];
  Future getDivisonSectionList(String sectionId) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };

    var request = http.Request(
        'GET',
        Uri.parse(
            '${UIGuide.baseURL}/sms-to-guardian/divisionsection/$sectionId'));
    request.body = json.encode({"SchoolId": _pref.getString('schoolId')});
    request.headers.addAll(headers);
    print("____________");
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      setloadingDivision(true);
      List<dynamic> data =
      jsonDecode(await response.stream.bytesToString());

      List<StudReportDivision> templist = List<StudReportDivision>.from(
          data.map((x) => StudReportDivision.fromJson(x)));
      divisionSectionlist.clear();
      divisionSectionlist.addAll(templist);
      divisionDrop = divisionSectionlist.map((subjectdata) {
        return MultiSelectItem(subjectdata, subjectdata.text ?? "");
      }).toList();
      setloadingDivision(false);
      notifyListeners();
    } else {
      print('Error in Notice stf');
    }
    return true;
  }


  //course
  courseListClear() {
    courselist.clear();
    notifyListeners();
  }

  courseDropClear() {
    courseDrop.clear();
    notifyListeners();
  }

  List<StudReportCourse> courselist = [];
  List<MultiSelectItem> courseDrop = [];
  List<MultiSelectItem> divisionDrop = [];
  clearSection() {
    dropDown.clear();
    stdReportInitialValues.clear();
    notifyListeners();
  }

  clearCourse() {
    courseDrop.clear();
    courselist.clear();
    notifyListeners();
  }

  clearDivision() async {
    divisionDrop.clear();
    divisionlist.clear();
    notifyListeners();
  }

  int sectionLen = 0;
  sectionCounter(int len) async {
    sectionLen = 0;
    if (len == 0) {
      sectionLen = 0;
    } else {
      sectionLen = len;
    }

    notifyListeners();
  }

  int courseLen = 0;
  courseCounter(int len) async {
    courseLen = 0;
    if (len == 0) {
      courseLen = 0;
    } else {
      courseLen = len;
    }

    notifyListeners();
  }

  int divisionLen = 0;
  divisionCounter(int leng) async {
    divisionLen = 0;
    if (leng == 0) {
      divisionLen = 0;
    } else {
      divisionLen = leng;
    }

    notifyListeners();
  }

  bool _loadingCourse = false;
  bool get loadingCourse => _loadingCourse;
  setloadingCourse(bool value) {
    _loadingCourse = value;
    notifyListeners();
  }

  Future<bool> getCourseList(String sectionId) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setloadingCourse(true);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };

    var request = http.Request(
        'GET',
        Uri.parse(
            '${UIGuide.baseURL}/mobileapp/staffdet/studentreport/course/$sectionId'));
    request.body = json.encode({"SchoolId": _pref.getString('schoolId')});
    request.headers.addAll(headers);
    print(http.Request(
        'GET',
        Uri.parse(
            '${UIGuide.baseURL}/mobileapp/staffdet/studentreport/course/$sectionId')));
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      setloadingCourse(true);
      Map<String, dynamic> data =
          jsonDecode(await response.stream.bytesToString());

      List<StudReportCourse> templist = List<StudReportCourse>.from(
          data["course"].map((x) => StudReportCourse.fromJson(x)));
      courselist.addAll(templist);
      courseDrop = courselist.map((subjectdata) {
        return MultiSelectItem(subjectdata, subjectdata.text ?? "");
      }).toList();
      setloadingCourse(false);
      notifyListeners();
    } else {
      setloadingCourse(false);
      print('Error in courseList stf');
    }
    return true;
  }

  //Division

  bool _loadingDivision = false;
  bool get loadingDivision => _loadingDivision;
  setloadingDivision(bool value) {
    _loadingDivision = value;
    notifyListeners();
  }

  List<StudReportDivision> divisionlist = [];

  Future<bool> getDivisionList(String courseId) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setloadingDivision(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            '${UIGuide.baseURL}/mobileapp/staffdet/studentreport/divisions/$courseId'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      setloadingDivision(true);
      Map<String, dynamic> data =
          jsonDecode(await response.stream.bytesToString());
      List<StudReportDivision> templist = List<StudReportDivision>.from(
          data["divisionbyCourse"].map((x) => StudReportDivision.fromJson(x)));
      divisionlist.addAll(templist);
      divisionDrop = divisionlist.map((subjectdata) {
        return MultiSelectItem(subjectdata, subjectdata.text!);
      }).toList();
      setloadingDivision(false);
      notifyListeners();
    } else {
      setloadingDivision(false);
      print('Error in DivisionList stf');
    }
    return true;
  }
}
