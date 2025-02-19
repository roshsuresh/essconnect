import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
  import 'package:http/http.dart' as http;

import '../../Domain/Student/PortionModel.dart';
import '../../utils/constants.dart';
class StudentPortionProvider with ChangeNotifier{


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

  DateTime? fromdateselect;
  String fromdateDisplay = '';
  String fromdateSend = '';
  DateTime? todateselect;
  String todateDisplay = '';
  String todateSend = '';
  DateTime? currentDate;
  getfromDate(BuildContext context) async {
    //results.clear();

    fromdateselect = await showDatePicker(
      context: context,
      initialDate: fromdateselect ?? DateTime.now(),
      firstDate: DateTime(2022),
      lastDate:DateTime(9999, 12, 31),
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
    studportionListByDate.clear();
    notifyListeners();
  }

  gettoDate(BuildContext context) async {
    // results.clear();
    todateselect = await showDatePicker(
      context: context,
      initialDate: todateselect,
      firstDate: DateTime(2022),
      lastDate:DateTime(9999, 12, 31),
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
    studportionListByDate.clear();
    notifyListeners();
  }

  void clearDate(){
    fromdateselect=null;
    todateselect=null;
  }

  List<StudPortionList> studportionList=[];
  List<StudPortionList> studportionListpre=[];

  Future getStudentPortionList() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
 setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('curiaccesstoken')}'
    };
    try {
      var response = await http.get(
          Uri.parse(
              "${UIGuide.curriculamUrl}/portionentry/datewise"),
          headers: headers);

      if (response.statusCode == 200) {
        print("corect");
        setLoading(true);
       final data = json.decode(response.body);
        log(data.toString());

        List<StudPortionList> templist = List<StudPortionList>.from(
            data["portionList"].map((x) => StudPortionList.fromJson(x)));
        studportionList.addAll(templist);

        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        print("Error in studPortionList response");
      }
    } catch (e) {
      setLoading(false);
      print(e);
    }
  }

  //previous sata

  Future getStudentPortionListPrevious(String status) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoadingPage(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('curiaccesstoken')}'
    };
    try {
      var response = await http.get(
          Uri.parse(
              "${UIGuide.curriculamUrl}/portionentry/$status"),
          headers: headers);

      if (response.statusCode == 200) {
        print("corect");
        setLoadingPage(true);
        final data = json.decode(response.body);
        log(data.toString());

        List<StudPortionList> templist = List<StudPortionList>.from(
            data["portionList"].map((x) => StudPortionList.fromJson(x)));
        studportionListpre.addAll(templist);

        setLoadingPage(false);
        notifyListeners();
      } else {
        setLoadingPage(false);
        print("Error in studPortionList response");
      }
    } catch (e) {
      setLoadingPage(false);
      print(e);
    }
  }

//Bydate

  List<StudPortionList> studportionListByDate=[];

  Future getStudentPortionListByDate() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoadingPage(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('curiaccesstoken')}'
    };
    try {
      var response = await http.get(
          Uri.parse(
              "${UIGuide.curriculamUrl}/portionentry/fromtoDate/$fromdateSend/$todateSend"),
          headers: headers);

      if (response.statusCode == 200) {
        print("corect");
        setLoadingPage(true);
        final data = json.decode(response.body);
        log(data.toString());

        List<StudPortionList> templist = List<StudPortionList>.from(
            data.map((x) => StudPortionList.fromJson(x)));
        studportionListByDate.addAll(templist);

        setLoadingPage(false);
        notifyListeners();
      } else {
        setLoadingPage(false);
        print("Error in studPortionList response Date");
      }
    } catch (e) {
      setLoadingPage(false);
      print(e);
    }
  }


  List<StudPortionDetials> studportionDetailList=[];
  List<PhotoList> photoList=[];
  List<String> imageUrls = [];
  List<String> imageName = [];

  Future getStudentPortionDetailList(String date,String status) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('curiaccesstoken')}'
    };
    try {
      var response = await http.get(
          Uri.parse(
              "${UIGuide.curriculamUrl}/portionentry/getportions/$date/$status"),
          headers: headers);
      print(response);
      print( "${UIGuide.curriculamUrl}/portionentry/getportions/$date/$status");

      if (response.statusCode == 200) {
        print("correct");
        setLoading(true);
        final data = json.decode(response.body);
        log(data.toString());

        List<StudPortionDetials> templist = List<StudPortionDetials>.from(
            data.map((x) => StudPortionDetials.fromJson(x)));
        studportionDetailList.addAll(templist);
        print("studlengthh   ${studportionDetailList.length}");


        // List<PhotoList> photoList = studportionDetailList.isNotEmpty ? studportionDetailList[0].photoList! : [];
        //
        //
        // print("image urlsssss");
        // print(imageUrls.length);
        // log(imageUrls.toString());
        //
        // log(photoList.toString());
        // print(photoList.length);
        // print('photoliststt');
        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        print("Error in studPortionList response");
      }
    } catch (e) {
      setLoading(false);
      print(e);
    }
  }

  //Notification count update

  Future updatePortionCount() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    var parsedResponse = await parseJWT();
    final studId = await parsedResponse['ChildId'];
    var request = http.Request(
        'POST',
        Uri.parse(
            '${UIGuide.baseURL}/mobileapp/token/updatePortionStatus?StudentId=$studId'));
    request.body = json.encode({"IsSeen": true, "Type": "Student"});
    request.headers.addAll(headers);

    print(request);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      setLoading(true);
      print(
          '_ _ _ _ _ _ _ _ _ _ _ _   Correct   _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _');
      setLoading(false);
    } else {
      setLoading(false);
      print(response.statusCode);
      print('Error in PortionCountNotification respo');
    }
  }

}