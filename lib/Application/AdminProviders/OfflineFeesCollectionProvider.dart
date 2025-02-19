
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Domain/Admin/OfflineFeesDomain.dart';
import '../../utils/constants.dart';

class OffflineFeesProvider with ChangeNotifier{


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

  bool _loadingCourse = false;
  bool get loadingCourse => _loadingCourse;
  setloadingCourse(bool value) {
    _loadingCourse = value;
    notifyListeners();
  }

  bool _loadingDivision = false;
  bool get loadingDivision => _loadingDivision;
  setloadingDivision(bool value) {
    _loadingDivision = value;
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
  divisionCounter(int len) async {
    divisionLen = 0;
    if (len == 0) {
      divisionLen = 0;
    } else {
      divisionLen = len;
    }

    notifyListeners();
  }


  clearInitial(){
    divisionDrop.clear();
    divisionList.clear();
    courseDrop.clear();
    courseList.clear();
    collectionlList.clear();
    buscollectionlList.clear();
    exportFeesList.clear();
    exportBusFeesList.clear();
    courseCounter(0);
    divisionCounter(0);
  }
  clearDivision(){
    divisionList.clear();
    divisionDrop.clear();
    notifyListeners();
  }

  //date

  DateTime fromdateselect=DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  String fromdateDisplay = '';
  String fromdateSend = '';
  DateTime todateselect=DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  String todateDisplay = '';
  String todateSend = '';
  DateTime? currentDate;

  getDateNow() async {

    currentDate = DateTime.now();

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
    collectionlList.clear();

    fromdateselect = (await showDatePicker(
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
    ))!;
    fromdateDisplay = DateFormat('dd-MMM-yyyy').format(fromdateselect!);
    fromdateSend = DateFormat('yyyy-MM-dd').format(fromdateselect!);
    print("dateDisplay:  $fromdateDisplay");
    print("dateSend:  $fromdateSend");
    notifyListeners();
  }
  gettoDate(BuildContext context) async {
    collectionlList.clear();
    todateselect = (await showDatePicker(
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
    ))!;
    todateDisplay = DateFormat('dd-MMM-yyyy').format(todateselect!);
    todateSend = DateFormat('yyyy-MM-dd').format(todateselect!);
    print("dateDisplay:  $todateDisplay");
    print("dateSend:  $todateSend");
    notifyListeners();
  }

 List<OfflineCourse> courseList= [];
  List<MultiSelectItem> courseDrop = [];
  Future getCourseList() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setloadingCourse(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };

    var request = http.Request(
        'GET', Uri.parse('${UIGuide.baseURL}/fee-col-summary/initialvalues'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Map<String, dynamic> data =
      jsonDecode(await response.stream.bytesToString());

      List<OfflineCourse> templist1 = List<OfflineCourse>.from(
          data["course"].map((x) => OfflineCourse.fromJson(x)));
      courseList.addAll(templist1);
      courseDrop = courseList.map((subjectdata) {
        return MultiSelectItem(subjectdata, subjectdata.text ?? "");
      }).toList();
      setloadingCourse(false);
      notifyListeners();
    } else {
      setloadingCourse(false);
      print("Error in Course response");
    }
  }
  //div
  List<OfflineFeeDiv> divisionList = [];
  List<MultiSelectItem> divisionDrop = [];
  Future<bool> getDivisionList(String courseId) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            '${UIGuide.baseURL}/fee-col-summary/division/$courseId'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print(response);

    if (response.statusCode == 200) {
      setloadingDivision(true);
      List<dynamic> data =
      jsonDecode(await response.stream.bytesToString());

      List<OfflineFeeDiv> templist = List<OfflineFeeDiv>.from(
          data.map((x) => OfflineFeeDiv.fromJson(x)));
      divisionList.addAll(templist);
      print(divisionList);
      divisionDrop = divisionList.map((subjectdata) {
        return MultiSelectItem(subjectdata, subjectdata.text ?? "");
      }).toList();
      setLoading(false);
      notifyListeners();
    }
    else {
      print('Error in Division response ');
      setLoading(false);
    }
    return true;
  }

  //view
  int currentPage = 2;
  int? pageSize;
  int? countStud;
  String? uploadedDate;
  String? netAmount;
  List<Results> collectionlList = [];
  List<ExportList> exportFeesList = [];
  List<BusExportList> exportBusFeesList = [];

  Future getFeeCollectionReport(
    List courseId, List divId, String fromDate,toDate) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };

    var request = http.Request(
        'POST', Uri.parse('${UIGuide.baseURL}/fee-col-summary/genFeesSummary'));

    print('${UIGuide.baseURL}/fee-col-summary/genFeesSummary');
    request.body =
        json.encode({

        "courses":courseId,
        "divisions":divId,
        "fromDate":fromDate,
        "toDate":toDate

    });
    print(request.body);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      setLoading(true);

      final data = await jsonDecode(await response.stream.bytesToString());
      print('correct');
    // Map<String, dynamic> data = json.decode(response.body);

      List<Results> templist2 = List<Results>.from(
          data["results"].map((x) => Results.fromJson(x)));
      collectionlList.addAll(templist2);
      List<ExportList> templist3 = List<ExportList>.from(
          data["exportList"].map((x) => ExportList.fromJson(x)));
      exportFeesList.addAll(templist3);

      OfflineFeeView res = OfflineFeeView.fromJson(data);
        netAmount= res.netAmount!.toStringAsFixed(2);

      if(collectionlList.isNotEmpty) {
        DateTime dateTime = DateTime.parse(res.uploadedDate.toString());
        uploadedDate = DateFormat('dd-MM-yyyy').format(dateTime);
      }

      setLoading(false);
      notifyListeners();
    } else {
      setLoading(false);
      print(response.reasonPhrase);
    }
    return true;
  }



  //Fees Export

  String? id;
  String? name;
  String? extension;
  String? path;
  String? url;
  Future fesscollectionDownload() async{

    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoadingPage(true);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };

    var request = http.Request(
        'POST', Uri.parse('${UIGuide.baseURL}/fee-col-summary/export-excel'));
    request.body = json.encode({
      "tableValues":exportFeesList,
      "filter": {
        "From Date":[fromdateDisplay],
        "To Date": [todateDisplay]
      },
      "netAmount": netAmount,

    });
    print("dddddddddddd");
    log(request.body);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    log(request.body.toString());
    if (response.statusCode == 200) {
      setLoadingPage(true);
      Map<String, dynamic> data =
      jsonDecode(await response.stream.bytesToString());
      FeesCollectionExport feereport =
      FeesCollectionExport.fromJson(data);
      id= feereport.id;
      name= feereport.name;
      extension= feereport.extension;
      path= feereport.path;
      url= feereport.url;
      print("llllllllll");
      print(url);
      print(path);



      print("Correct");
      setLoadingPage(false);
      notifyListeners();
    } else {
      setLoadingPage(false);
      print(" Error in download");
    }
  }
  //busfee

  String? uploadedBusDate;
  String? netAmountBus;
  List<BusResults> buscollectionlList = [];
  // List<BusCollectDetails> busFeeList = [];
  Future getBusFeeCollectionReport(List courseId,List divId, String fromDate,toDate) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    var request = http.Request(
        'POST', Uri.parse('${UIGuide.baseURL}/fee-col-summary/busFeesSummary/'));

    print('${UIGuide.baseURL}/fee-col-summary/busFeesSummary/');
    request.body =
        json.encode({

          "courses":courseId,
          "divisions":divId,
          "fromDate":fromDate,
          "toDate":toDate

        });
    print(request.body);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      setLoading(true);

      final data = await jsonDecode(await response.stream.bytesToString());
      print('correct');
      // Map<String, dynamic> data = json.decode(response.body);

      List<BusResults> templist2 = List<BusResults>.from(
          data["results"].map((x) => BusResults.fromJson(x)));
      buscollectionlList.addAll(templist2);
      List<BusExportList> templist3 = List<BusExportList>.from(
          data["exportList"].map((x) => BusExportList.fromJson(x)));
      exportBusFeesList.addAll(templist3);

      BusFee res = BusFee.fromJson(data);
      netAmountBus= res.netAmount!.toStringAsFixed(2);

      if(buscollectionlList.isNotEmpty) {
        DateTime dateTime = DateTime.parse(res.uploadedDate.toString());
        uploadedBusDate = DateFormat('dd-MM-yyyy').format(dateTime);
      }

      setLoading(false);
      notifyListeners();
    } else {
      setLoading(false);
      print(response.reasonPhrase);
    }
    return true;
  }




  //downlaod busfee
  Future busfesscollectionDownload() async{

    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoadingPage(true);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };

    var request = http.Request(
        'POST', Uri.parse('${UIGuide.baseURL}/fee-col-summary/export-bus-excel'));
    request.body = json.encode({
      "tableValues":exportBusFeesList,
      "filter": {
        "From Date":[fromdateDisplay],
        "To Date": [todateDisplay]
      },
      "netAmount": netAmountBus,

    });
    print("dddddddddddd");
    log(request.body);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    log(request.body.toString());
    if (response.statusCode == 200) {
      setLoadingPage(true);
      Map<String, dynamic> data =
      jsonDecode(await response.stream.bytesToString());
      FeesCollectionExport feereport =
      FeesCollectionExport.fromJson(data);
      id= feereport.id;
      name= feereport.name;
      extension= feereport.extension;
      path= feereport.path;
      url= feereport.url;
      print("llllllllll");
      print(url);
      print(path);



      print("Correct");
      setLoadingPage(false);
      notifyListeners();
    } else {
      setLoadingPage(false);
      print(" Error in download");
    }
  }
}
