import 'dart:convert';
import 'dart:developer';

import 'package:essconnect/Constants.dart';
import 'package:essconnect/Domain/Staff/Anecdotal/InitialSelectionModel.dart';
import 'package:essconnect/Domain/Staff/Anecdotal/StudListviewAnectdotal.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AnecdotalStaffProviders with ChangeNotifier {
  bool isimportant = false;
  bool showToGuardian = false;

  isimportantCheckbox() {
    isimportant = !isimportant;
    notifyListeners();
  }

  //
  isShownToGuardian() {
    showToGuardian = !showToGuardian;
    notifyListeners();
  }

  clearAllDetails() {
    sectiondropDown.clear();
    sectionInitialValues.clear();
    divisiondropDown.clear();
    divisionList.clear();
    coursedropDown.clear();
    courseList.clear();
    studentViewList.clear();
    sectionCounter(0);
    courseCounter(0);
    divisionCounter(0);
    notifyListeners();
  }

  clearCourse() {
    coursedropDown.clear();
    courseList.clear();
    studentViewList.clear();
    notifyListeners();
  }

  clearDivision() async {
    divisiondropDown.clear();
    divisionList.clear();
    studentViewList.clear();
    notifyListeners();
  }

  List<SectionsModel> sectionInitialValues = [];
  List<MultiSelectItem> sectiondropDown = [];
  Future getSectionInitial() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    try {
      var response = await http.get(
          Uri.parse(
              "${UIGuide.baseURL}/student-selector/student-selector-search-options"),
          headers: headers);

      if (response.statusCode == 200) {
        print("corect");
        setLoading(true);
        final data = json.decode(response.body);

        List<SectionsModel> templist = List<SectionsModel>.from(
            data["sections"].map((x) => SectionsModel.fromJson(x)));
        sectionInitialValues.addAll(templist);
        sectiondropDown = sectionInitialValues.map((subjectdata) {
          return MultiSelectItem(subjectdata, subjectdata.name!);
        }).toList();
        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        print("Error in section response");
      }
    } catch (e) {
      setLoading(false);
      print(e);
    }
  }

  //Course

  List<SectionsModel> courseList = [];
  List<MultiSelectItem> coursedropDown = [];
  Future getCourseList(String section) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    try {
      var response = await http.get(
          Uri.parse(
              "${UIGuide.baseURL}/student-selector/courses-custom/$section"),
          headers: headers);

      if (response.statusCode == 200) {
        print("corect");
        setLoading(true);
        final data = json.decode(response.body);
        log(data.toString());

        List<SectionsModel> templist = List<SectionsModel>.from(
            data.map((x) => SectionsModel.fromJson(x)));
        courseList.addAll(templist);
        coursedropDown = courseList.map((subjectdata) {
          return MultiSelectItem(subjectdata, subjectdata.name!);
        }).toList();
        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        print("Error in course response");
      }
    } catch (e) {
      setLoading(false);
      print(e);
    }
  }

  //Division

  List<SectionsModel> divisionList = [];
  List<MultiSelectItem> divisiondropDown = [];
  Future getDivisionList(String course) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    try {
      var response = await http.get(
          Uri.parse(
              "${UIGuide.baseURL}/student-selector/student-selector-search-options?$course"),
          headers: headers);

      if (response.statusCode == 200) {
        print("corect");
        setLoading(true);
        final data = json.decode(response.body);
        log(data.toString());

        List<SectionsModel> templist = List<SectionsModel>.from(
            data.map((x) => SectionsModel.fromJson(x)));
        divisionList.addAll(templist);
        divisiondropDown = divisionList.map((subjectdata) {
          return MultiSelectItem(subjectdata, subjectdata.name!);
        }).toList();
        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        print("Error in division response");
      }
    } catch (e) {
      setLoading(false);
      print(e);
    }
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

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  clearStudentViewList() {
    studentViewList.clear();
    notifyListeners();
  }

  int currentPage = 0;
  int? pageSize;
  int? countStud;

  List<StudentViewAnecdotalModel> studentViewList = [];
  Future getStudentViewList(
      String section, String course, String division) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    try {
      var request = http.Request(
          'GET',
          Uri.parse(
              '${UIGuide.baseURL}/student-selector?filterStudyingStatus=studying&avoidRelievedStaff=all&searchOption=contains&page=$currentPage&$section&$course&$division'));

      request.headers.addAll(headers);
      print(request);
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        setLoading(true);

        Map<String, dynamic> data =
            jsonDecode(await response.stream.bytesToString());
        print(data);

        List<StudentViewAnecdotalModel> templist =
            List<StudentViewAnecdotalModel>.from(data["results"]
                .map((x) => StudentViewAnecdotalModel.fromJson(x)));
        studentViewList.addAll(templist);

        PaginationStudentView pagenata =
            PaginationStudentView.fromJson(data['pagination']);
        pageSize = pagenata.pageSize;
        countStud = pagenata.count;
        //  currentPage++;
        print(countStud);

        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        print('Error in getStudentViewList stf');
      }
    } catch (e) {
      print('Error in getStudentViewList stf');
      setLoading(false);
    }
  }

  //Stud List by pagination

  bool _loadingPage = false;
  bool get loadingPage => _loadingPage;
  setLoadingPage(bool value) {
    _loadingPage = value;
    notifyListeners();
  }

  Future getStudentViewByPagination(
      String section, String course, String division) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoadingPage(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    try {
      var request = http.Request(
          'GET',
          Uri.parse(
              '${UIGuide.baseURL}/student-selector?filterStudyingStatus=studying&avoidRelievedStaff=all&searchOption=contains&page=$currentPage&$section&$course&$division'));

      request.headers.addAll(headers);
      print(request);
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        setLoadingPage(true);

        Map<String, dynamic> data =
            jsonDecode(await response.stream.bytesToString());
        // print(data);
        List<StudentViewAnecdotalModel> templist =
            List<StudentViewAnecdotalModel>.from(data["results"]
                .map((x) => StudentViewAnecdotalModel.fromJson(x)));
        studentViewList.addAll(templist);
        PaginationStudentView pagenata =
            PaginationStudentView.fromJson(data['pagination']);
        pageSize = pagenata.pageSize;
        countStud = pagenata.count;
        currentPage++;
        print(currentPage);

        setLoadingPage(false);
        notifyListeners();
      } else {
        setLoadingPage(false);
        print('Error in getStudentViewList stf');
      }
    } catch (e) {
      print('Error in getStudentViewList stf');
      setLoadingPage(false);
    }
  }

  //check more Pagination

  bool hasMoreData() {
    final totalCount = countStud;
    // print("studentView length :  ${studentViewList.length}");
    // print("Total  :  $totalCount");
    notifyListeners();
    return studentViewList.length < totalCount!;
  }
}
