import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../Domain/Admin/AppReviewModel.dart';
import '../../utils/constants.dart';

class AppReviewProvider with ChangeNotifier{

  bool notused = false;
  String? usedornot;


  notUsedCheckbox() {
    notused = !notused;
    usedornot = notused==false?"Used":"NotUsed";
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

  clearCourse() {
    coursedropDown.clear();
    courseList.clear();
  //  studentViewList.clear();
    notifyListeners();
  }

  clearDivision() async {
    divisiondropDown.clear();
    divisionList.clear();
   // studentViewList.clear();
    notifyListeners();
  }


  clearAllDetails() {
    sectiondropDown.clear();
    sectionList.clear();
    divisiondropDown.clear();
    divisionList.clear();
    coursedropDown.clear();
    courseList.clear();
    studentViewList.clear();
    studentUserViewList.clear();
    courseList.clear();
    //categorydropDown.clear();
    sectionCounter(0);
    courseCounter(0);
    divisionCounter(0);
    //categoryCounter(0);
    notifyListeners();
    //results.clear();


   // studentViewListReport.clear();

  }

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  bool _loadingPage = false;
  bool get loadingPage => _loadingPage;
  setLoadingPage(bool value) {
    _loadingPage = value;
    notifyListeners();
  }


  //date

  DateTime? fromdateselect;
  String fromdateDisplay = '';
  String fromdateSend = '';
  DateTime? todateselect;
  String todateDisplay = '';
  String todateSend = '';
  DateTime? currentDate;
  DateTime? nowDate;
  getDateNow() async {
    nowDate =DateTime.now();
    currentDate = DateTime(nowDate!.year, nowDate!.month, nowDate!.day);
    fromdateselect=currentDate;
    todateselect = currentDate;
    fromdateDisplay = DateFormat('dd-MMM-yyyy').format(currentDate!);
    fromdateSend = DateFormat('yyyy-MM-dd').format(currentDate!);
    print("dateDis:  $fromdateDisplay");
    print("dateS:  $fromdateSend");
    todateDisplay = DateFormat('dd-MMM-yyyy').format(currentDate!);
    todateSend = DateFormat('yyyy-MM-dd').format(currentDate!);
    print("dateDis:  $todateDisplay");
    print("dateS:  $todateSend");
    notifyListeners();
  }

  //get date

  getfromDate(BuildContext context) async {
    studentViewList.clear();

    fromdateselect = await showDatePicker(
      context: context,
      initialDate: fromdateselect ?? DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: UIGuide.light_Purple,
              colorScheme: const ColorScheme.light(
                primary: UIGuide.light_Purple,
              ),
              buttonTheme:
              const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child!);
      },
    );
    fromdateDisplay = DateFormat('dd-MMM-yyyy').format(fromdateselect!);
    fromdateSend = DateFormat('yyyy-MM-dd').format(fromdateselect!);
    print("dateDisplay:  $fromdateDisplay");
    print("dateSend:  $fromdateSend");
    notifyListeners();
  }
  gettoDate(BuildContext context) async {
    studentViewList.clear();
    todateselect = await showDatePicker(
      context: context,
      initialDate: todateselect ?? DateTime.now(),
      firstDate: DateTime(2022),
      lastDate:DateTime.now(),
      builder: (context, child) {
        return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: UIGuide.light_Purple,
              colorScheme: const ColorScheme.light(
                primary: UIGuide.light_Purple,
              ),
              buttonTheme:
              const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child!);
      },
    );
    todateDisplay = DateFormat('dd-MMM-yyyy').format(todateselect!);
    todateSend = DateFormat('yyyy-MM-dd').format(todateselect!);
    print("dateDisplay:  $todateDisplay");
    print("dateSend:  $todateSend");
    notifyListeners();
  }
  DateTime _currentTime = DateTime.now();
  late Timer _timer;
  int? hour;
  int? minute;
  int? second;
  String get formattedTime => DateFormat('hh:mm a').format(_currentTime);

  timeModel() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _currentTime = DateTime.now();
      hour = _currentTime.hour;
      minute = _currentTime.minute;
      second = _currentTime.second;

      notifyListeners();
    });
  }


  List<AppreviewSection> sectionList=[];
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
              "${UIGuide.baseURL}/mobileapp/installedUser/initialvalues"),
          headers: headers);

      if (response.statusCode == 200) {
        print("corect");
        setLoading(true);
        final data = json.decode(response.body);
        Map<String, dynamic> update = data['initialValues'];

        List<AppreviewSection> templist = List<AppreviewSection>.from(
            update["section"].map((x) => AppreviewSection.fromJson(x)));
        sectionList.addAll(templist);

        sectiondropDown = sectionList.map((subjectdata) {
          return MultiSelectItem(subjectdata, subjectdata.text!);
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

  List<AppreviewCourse> courseList = [];
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
              "${UIGuide.baseURL}/mobileapp/installedUser/course/$section"),
          headers: headers);

      if (response.statusCode == 200) {
        print("corect");
        setLoading(true);
        final data = json.decode(response.body);
        log(data.toString());

        List<AppreviewCourse> templist = List<AppreviewCourse>.from(
            data["course"].map((x) => AppreviewCourse.fromJson(x)));
        courseList.addAll(templist);
        coursedropDown = courseList.map((subjectdata) {
          return MultiSelectItem(subjectdata, subjectdata.text!);
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


  List<AppreviewDivision> divisionList = [];
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
              "${UIGuide.baseURL}/mobileapp/installedUser/divisions/$course"),
          headers: headers);
      print("${UIGuide.baseURL}/mobileapp/installedUser/divisions/$course");

      if (response.statusCode == 200) {
        print("corect");
        setLoading(true);
        final data = json.decode(response.body);
        log(data.toString());

        List<AppreviewDivision> templist = List<AppreviewDivision>.from(
            data["division"].map((x) => AppreviewDivision.fromJson(x)));
        divisionList.addAll(templist);
        divisiondropDown = divisionList.map((subjectdata) {
          return MultiSelectItem(subjectdata, subjectdata.text !);
        }).toList();
        print(divisiondropDown);
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

  //view

  int currentPage = 2;
  int? pageSize;
  int? countStud;

  List<Results> studentViewList = [];
  Future getStudentViewList(
      String section, String course, String division,String status) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    try {
      var request =


      http.Request(
          'GET',
          Uri.parse(
              '${UIGuide.baseURL}/mobileapp/installedUser/view/?instasection=$section&instacourse=$course&instadivision=$division&installedStatus=$status&pageCount=50&page=1&'));


      request.headers.addAll(headers);
      print(request);
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        setLoading(true);

        Map<String, dynamic> data =
        jsonDecode(await response.stream.bytesToString());
        print(data);

        List<Results> templist =
        List<Results>.from(data["results"]
            .map((x) => Results.fromJson(x)));
        studentViewList.addAll(templist);

        Pagination pagenata =
        Pagination.fromJson(data['pagination']);
        pageSize = pagenata.pageSize;
        countStud = pagenata.count;

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

  //Pagination

  Future getStudentViewListByPagination(
      String section, String course, String division,String status) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoadingPage(true);
    print("Pagination");
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    try {
      var request = http.Request(
          'GET',
          Uri.parse(
              '${UIGuide.baseURL}/mobileapp/installedUser/view/?instasection=$section&instacourse=$course&instadivision=$division&installedStatus=$status&pageCount=50&page=$currentPage'));

      request.headers.addAll(headers);
      print(request);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        setLoadingPage(true);

        Map<String, dynamic> data =
        jsonDecode(await response.stream.bytesToString());
        // print(data);
        List<Results> templist =
        List<Results>.from(data["results"]
            .map((x) => Results.fromJson(x)));
        studentViewList.addAll(templist);
        Pagination pagenata =
        Pagination.fromJson(data['pagination']);
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
    print("studentView length :  ${studentViewList.length}");
    notifyListeners();
    return studentViewList.length < totalCount!;
  }


 //UsedorNot


  List<AppUsersDetails> studentUserViewList = [];
  Future getStudentUserViewList(
      String section, String course, String division,String usedStatus) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    try {
      var request =

      http.Request(
          'GET',
          Uri.parse(
              '${UIGuide.baseURL}/mobileapp/installedUser/usedview/?section=$section&course=$course&division=$division&displayStartDate=$fromdateSend&displayEndDate=$todateSend&usedStatus=$usedStatus&pageCount=50&page=1&'));


      request.headers.addAll(headers);
      print(request);
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        setLoading(true);
        print("statuscode :${response.statusCode}");

        Map<String, dynamic> dataa =
        jsonDecode(await response.stream.bytesToString());
       print(dataa);
        List<AppUsersDetails> templist =
        List<AppUsersDetails>.from(dataa["results"]
            .map((x) => AppUsersDetails.fromJson(x)));
        studentUserViewList.addAll(templist);
        print("lissssss");

        Pagination pagenata =
        Pagination.fromJson(dataa['pagination']);
        pageSize = pagenata.pageSize;
        countStud = pagenata.count;

        print(countStud);

        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        print('Error in getStudentUserViewList stf');
      }
    } catch (e) {
      print('Error in getStudentUserViewList stf');
      setLoading(false);
    }
  }

  //Pagination

  Future getStudentUserViewListByPagination(
      String section, String course, String division,String usedStatus ) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoadingPage(true);
    print("Paginationnew");
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    try {
      var request = http.Request(
          'GET',
          Uri.parse(
              '${UIGuide.baseURL}/mobileapp/installedUser/usedview/?section=$section&course=$course&division=$division&displayStartDate=$fromdateSend&displayEndDate=$todateSend&usedStatus=$usedStatus&pageCount=50&page=$currentPage&'));

      request.headers.addAll(headers);
      print(request);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        setLoadingPage(true);

        Map<String, dynamic> data =
        jsonDecode(await response.stream.bytesToString());
        // print(data);
        List<AppUsersDetails> templist =
        List<AppUsersDetails>.from(data["results"]
            .map((x) => AppUsersDetails.fromJson(x)));
        studentUserViewList.addAll(templist);
        Pagination pagenata =
        Pagination.fromJson(data['pagination']);
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

  bool hasMoreUserData() {
    final totalCount = countStud;
    print("studentView length :  ${studentUserViewList.length}");
    notifyListeners();
    return studentUserViewList.length < totalCount!;
  }




}