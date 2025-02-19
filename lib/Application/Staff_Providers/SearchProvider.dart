import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Domain/Staff/StudInformation.dart';
import '../../Domain/Staff/StudentReport_staff.dart';
import '../../utils/constants.dart';

class Screen_Search_Providers with ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  String? attendanceAsOnDate;
  int? workDays;
  double? presentDays;
  double? absentDays;
  double? attendancePercentage;
  double? absentPercentage;
  List<ViewStudentReport> searchStudent = [];
  Future<bool> getSearch_View(String word) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoading(true);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            '${UIGuide.baseURL}/mobileapp/staffdet/studentreport/viewStudentReport?search=$word'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      Map<String, dynamic> data =
          jsonDecode(await response.stream.bytesToString());
      // log(data.toString());
      List<ViewStudentReport> templist = List<ViewStudentReport>.from(
          data["viewStudentReport"].map((x) => ViewStudentReport.fromJson(x)));
      searchStudent.addAll(templist);
      setLoading(false);
      notifyListeners();
    } else {
      setLoading(false);
      print('Error in Search stf');
    }
    return true;
  }

  clearStudentList() {
    searchStudent.clear();
    notifyListeners();
  }

//Attendance

  Future<bool> getStudAttendance(String childId) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    var response = await http.get(
        Uri.parse(
            "${UIGuide.baseURL}/studentcompleteinforpt/getattendancedetails/$childId"),
        headers: headers);
    if (response.statusCode == 200) {
      print('correct');
      Map<String, dynamic> dashboard = json.decode(response.body);
      StduAttendanceDetails ac = StduAttendanceDetails.fromJson(dashboard);
      attendanceAsOnDate = ac.attendanceAsOnDate;
      workDays = ac.workDays;
      presentDays = ac.presentDays;
      absentDays = ac.absentDays;
      attendancePercentage = ac.attendancePercentage;
      absentPercentage = ac.absentPercentage;
      notifyListeners();
    } else {
      print('Error in dashboard');
    }
    return true;
  }
  //fees

  double? busPaidAmount;
  double? schoolPaidAmount;
  double? busPendingAmount;
  double? schoolPendingAmount;
  String? maxDate;
  Future<bool> geFeesDetails(String childId) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoading(true);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            '${UIGuide.baseURL}/studentinfo/get-student-fee-details/$childId'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      Map<String, dynamic> data =
          jsonDecode(await response.stream.bytesToString());
      // log(data.toString());
      Map<String, dynamic> feesdata = data['studentFee'];
      StudFeeDetails fee = StudFeeDetails.fromJson(feesdata);
      busPaidAmount = fee.busPaidAmount;
      schoolPaidAmount = fee.schoolPaidAmount;
      busPendingAmount = fee.busPendingAmount;
      schoolPendingAmount = fee.schoolPendingAmount;
      maxDate = fee.maxDate;
      setLoading(false);
      notifyListeners();
    } else {
      setLoading(false);
      print('Error in Search stf');
    }
    return true;
  }

  //Academic Performance
  String? height;
  String? weight;
  String? disability;
  String? visionLeft;
  String? visionRight;
  String? teeth;
  String? oralHygiene;
  String? remarks;
  String? guardianName;
  String? guardianRelation;
  String? guardianMobile1;
  String? guardianEmail;
  String? fatherName;
  String? fatherMobile1;
  String? fatherEmail;
  String? motherName;
  String? motherMobile1;
  String? motherEmail;
  String? fatherPhotoId;
  SiblingPhoto? motherPhoto;
  String? motherPhotoId;
  SiblingPhoto? guardianPhoto;
  String? guardianPhotoId;
  SiblingPhoto? fatherPhoto;
  List<AcademicPerformance> academics = [];
  List<SiblingsDetails> siblingdata = [];
  Future<bool> getAcademicPerformance(String childid) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoading(true);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            '${UIGuide.baseURL}/studentcompleteinforpt/getstudentdetails/$childid'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      Map<String, dynamic> data =
          jsonDecode(await response.stream.bytesToString());
      // log(data.toString());
      Map<String, dynamic> students = data['data'];
      StudentData studData = StudentData.fromJson(students);
      List students11 = data['data']["siblingsDetails"];
      if (studData.fatherPhoto != null) {
        fatherPhoto = studData.fatherPhoto;
      }
      if (studData.motherPhoto != null) {
        motherPhoto = studData.motherPhoto;
      }
      if (studData.guardianPhoto != null) {
        guardianPhoto = studData.guardianPhoto;
      }

      print(students11);

      List<SiblingsDetails> templist1 = List<SiblingsDetails>.from(
          students11.map((x) => SiblingsDetails.fromJson(x)));
      siblingdata.addAll(templist1);
      print(siblingdata);

      List<AcademicPerformance> templist = List<AcademicPerformance>.from(
          data["academicPerformance"]
              .map((x) => AcademicPerformance.fromJson(x)));
      academics.addAll(templist);
      disability = studData.disability;
      height = studData.height;
      weight = studData.weight;
      visionLeft = studData.visionLeft;
      visionRight = studData.visionRight;
      teeth = studData.teeth;
      oralHygiene = studData.oralHygiene;
      remarks = studData.remarks;
      guardianName = studData.guardianName;
      guardianMobile1 = studData.guardianMobile1;
      guardianEmail = studData.guardianEmail;
      guardianRelation = studData.guardianRelation;
      guardianPhotoId = studData.guardianPhotoId;
      fatherName = studData.fatherName;
      fatherMobile1 = studData.fatherMobile1;
      fatherEmail = studData.fatherEmail;
      fatherPhotoId = studData.fatherPhotoId;
      motherName = studData.motherName;
      motherMobile1 = studData.motherMobile1;
      motherEmail = studData.motherEmail;
      motherPhotoId = studData.motherPhotoId;
      setLoading(false);
      notifyListeners();
    } else {
      setLoading(false);
      print('Error in Search stf');
    }
    return true;
  }

  //Report Card
  String? name;
  String? extension;
  bool isLoading = false;
  String? url;
  String? id;
  Future getreportCardAttachment(String fileId) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    String file = fileId.toString();
    var response = await http.get(
        Uri.parse("${UIGuide.baseURL}/studentcompleteinforpt/preview/$file"),
        headers: headers);
    print(response);
    try {
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        ReportcardAttachment reattach = ReportcardAttachment.fromJson(data);
        name = reattach.name;
        url = reattach.url;
        extension = reattach.extension;
        id = reattach.id;
        log('.................$url');
        print(data);
        notifyListeners();
      } else {
        print("Error in response");
      }
    } catch (e) {
      print(e);
    }
  }

  //TimeTable
  String? ttname;
  String? ttextension;
  bool ttisLoading = false;
  String? tturl;
  String? ttid;
  Future getTimetable(String childId) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };

    var response = await http.get(
        Uri.parse(
            "${UIGuide.baseURL}/studentcompleteinforpt/getstudentclasstimetabledetails/$childId"),
        headers: headers);
    print(response);
    try {
      if (response.statusCode == 200) {
        print("corrrrrrrr");
        final data = json.decode(response.body);
        TimtableView reattach = TimtableView.fromJson(data);
        ttname = reattach.name;
        tturl = reattach.url;
        ttextension = reattach.extension;
        ttid = reattach.id;
        log('.................$url');
        print(data);
        notifyListeners();
      } else {
        print("Error in response");
      }
    } catch (e) {
      print(e);
    }
  }
}
