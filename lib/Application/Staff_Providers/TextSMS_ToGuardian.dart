import 'dart:convert';
import 'dart:developer';
import 'package:essconnect/Domain/Staff/ToGuardian_TextSMS.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Map? staffTextSMSToGuardianRespo;
List? staffTextSMSToGuardRespo;

class TextSMS_ToGuardian_Providers with ChangeNotifier {
  bool? isClassTeacher;

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

  List<TextSMSToGuardianCourseList> smsCourse = [];
  addSelectedCourse(TextSMSToGuardianCourseList item) {
    if (smsCourse.contains(item)) {
      print("removing");
      smsCourse.remove(item);
      notifyListeners();
    } else {
      print("adding");
      smsCourse.add(item);
      notifyListeners();
    }
  }

  removeCourse(TextSMSToGuardianCourseList item) {
    smsCourse.remove(item);
    notifyListeners();
  }

  removeCourseAll() {
    smsCourse.clear();
  }

  isCourseSelected(
    TextSMSToGuardianCourseList item,
  ) {
    if (smsCourse.contains(item)) {
      return true;
    } else {
      return false;
    }
  }

  courseClear() {
    smscourseList.clear();
  }

  List<TextSMSToGuardianCourseList> smscourseList = [];
  Future getCourseList() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };

    var response = await http.get(
        Uri.parse(
            "${UIGuide.baseURL}/mobileapp/staffdet/noticeBoard/initialValues"),
        headers: headers);
    print("____________");
    if (response.statusCode == 200) {
      Map<String, dynamic> data = await json.decode(response.body);
      print(data);

      Map<String, dynamic> smsiniti = await data['initialValues'];

      List<TextSMSToGuardianCourseList> templist =
          List<TextSMSToGuardianCourseList>.from(smsiniti["courseList"]
              .map((x) => TextSMSToGuardianCourseList.fromJson(x)));
      smscourseList.addAll(templist);
      notifyListeners();
    } else {
      print('Error in Notice stf');
    }
    return true;
  }

  //Division List

  List<TextSMSToGuardianDivisionList> noticeDivision = [];
  addSelectedDivision(TextSMSToGuardianDivisionList item) {
    if (noticeDivision.contains(item)) {
      print("removing");
      noticeDivision.remove(item);
      notifyListeners();
    } else {
      print("adding");
      noticeDivision.add(item);
      notifyListeners();
    }
  }

  removeDivision(TextSMSToGuardianDivisionList item) {
    noticeDivision.remove(item);
    notifyListeners();
  }

  removeDivisionAll() {
    noticeDivision.clear();
  }

  isDivisionSelected(
    TextSMSToGuardianDivisionList item,
  ) {
    if (noticeDivision.contains(item)) {
      return true;
    } else {
      return false;
    }
  }

  divisionClear() {
    divisionlist.clear();
  }

  List<TextSMSToGuardianDivisionList> divisionlist = [];

  Future<bool> getDivisionList(String courseId) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            '${UIGuide.baseURL}/mobileapp/staffdet/noticeboard/divisions/$courseId'));
    request.body = json.encode({"SchoolId": _pref.getString('schoolId')});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Map<String, dynamic> data =
          jsonDecode(await response.stream.bytesToString());
      print('Division');
      log(data.toString());

      List<TextSMSToGuardianDivisionList> templist =
          List<TextSMSToGuardianDivisionList>.from(data["divisions"]
              .map((x) => TextSMSToGuardianDivisionList.fromJson(x)));
      divisionlist.addAll(templist);

      notifyListeners();
    } else {
      print('Error in Divisionsms stf');
    }
    return true;
  }

  //  sms formats

  List<SmsFormatByStaff> formats = [];
  addSelectedFormat(SmsFormatByStaff item) {
    if (formats.contains(item)) {
      print("removing");
      formats.remove(item);
      notifyListeners();
    } else {
      print("adding");
      formats.add(item);
      notifyListeners();
    }
  }

  removeFormat(SmsFormatByStaff item) {
    formats.remove(item);
    notifyListeners();
  }

  removeFormatAll() {
    formats.clear();
  }

  isFormatSelected(
    SmsFormatByStaff item,
  ) {
    if (formats.contains(item)) {
      return true;
    } else {
      return false;
    }
  }

  formatClear() {
    smsFormats.clear();
  }

  List<SmsFormatByStaff> smsFormats = [];

  Future<bool> getFormatList() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    var request = http.Request('GET',
        Uri.parse('${UIGuide.baseURL}/mobileapp/staffdet/sms/smsformats'));
    request.body = json.encode({"SchoolId": _pref.getString('schoolId')});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Map<String, dynamic> data =
          jsonDecode(await response.stream.bytesToString());
      Map<String, dynamic> smsSettings = data['smsSettings'];
      log(data.toString());

      List<SmsFormatByStaff> templist = List<SmsFormatByStaff>.from(
          smsSettings["smsFormat"].map((x) => SmsFormatByStaff.fromJson(x)));
      smsFormats.addAll(templist);

      notifyListeners();
    } else {
      print('Error in smsformat stf');
    }
    return true;
  }

  //view NotificationList
  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  List<TextSMSToGuardianCourseDivision_notification_Stf> notificationView = [];
  Future<bool> getSMSView(String course, String division) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);
    notifyListeners();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    setLoading(true);
    var request = http.Request(
        'GET',
        Uri.parse(
            '${UIGuide.baseURL}/mobileapp/staffdet/studentlistbycoursedivision?courseId=$course&divisionId=$division'));

    request.headers.addAll(headers);
    setLoading(true);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      setLoading(true);
      Map<String, dynamic> data =
          jsonDecode(await response.stream.bytesToString());

      log(data.toString());
      setLoading(true);
      List<TextSMSToGuardianCourseDivision_notification_Stf> templist =
          List<TextSMSToGuardianCourseDivision_notification_Stf>.from(
              data["studentViewbyCourseDivision"].map((x) =>
                  TextSMSToGuardianCourseDivision_notification_Stf.fromJson(
                      x)));
      notificationView.addAll(templist);
      print('correct');
      setLoading(false);
      notifyListeners();
    } else {
      setLoading(false);
      print('Error in textsmsView stf');
    }
    return true;
  }

  clearStudentList() {
    notificationView.clear();
    notifyListeners();
  }

  bool isSelected(TextSMSToGuardianCourseDivision_notification_Stf model) {
    TextSMSToGuardianCourseDivision_notification_Stf selected = notificationView
        .firstWhere((element) => element.admnNo == model.admnNo);
    return selected.selected!;
  }

  void selectItem(TextSMSToGuardianCourseDivision_notification_Stf model) {
    TextSMSToGuardianCourseDivision_notification_Stf selected = notificationView
        .firstWhere((element) => element.admnNo == model.admnNo);
    selected.selected ??= false;
    selected.selected = !selected.selected!;
    print(selected.toJson());
    notifyListeners();
  }

  bool isselectAll = false;
  void selectAll() {
    if (notificationView.first.selected == true) {
      for (var element in notificationView) {
        element.selected = false;
      }
      isselectAll = false;
    } else {
      for (var element in notificationView) {
        element.selected = true;
      }
      isselectAll = true;
    }

    notifyListeners();
  }

  List<TextSMSToGuardianCourseDivision_notification_Stf> selectedList = [];
  submitStudent(BuildContext context) {
    selectedList.clear();
    selectedList =
        notificationView.where((element) => element.selected == true).toList();
    if (selectedList.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        duration: Duration(seconds: 1),
        margin: EdgeInsets.only(bottom: 80, left: 30, right: 30),
        behavior: SnackBarBehavior.floating,
        content: Text(
          'Please Select',
          textAlign: TextAlign.center,
        ),
      ));
    } else {
      print('selected....');

      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => MessagePage(
      //               toList:
      //                   selectedList.map((e) => e.presentDetailsId).toList(),
      //               type: "Student",
      //             )));
    }
  }

  //sms format full view

  List<SmsFormatsCompleteview> smsFormatList = [];
  Future<bool> getSMSFormatView() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    notifyListeners();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    var request = http.Request(
        'GET', Uri.parse('${UIGuide.baseURL}/sms-to-guardian/get-formats'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Map<String, dynamic> data =
          jsonDecode(await response.stream.bytesToString());

      log(data.toString());

      List<SmsFormatsCompleteview> templist = List<SmsFormatsCompleteview>.from(
          data["smsFormats"].map((x) => SmsFormatsCompleteview.fromJson(x)));
      smsFormatList.addAll(templist);
      print('correct');
      notifyListeners();
    } else {
      print('Error in textsmsView stf');
    }
    return true;
  }
}
