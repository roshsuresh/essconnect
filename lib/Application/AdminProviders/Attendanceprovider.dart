import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:essconnect/Presentation/Admin/AttendanceTaken/SmsPage.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../Domain/Admin/AttendanceModel.dart';
import '../../Domain/Admin/SMSFormatModel.dart';
import '../../Presentation/Admin/Communication/ToGuardian.dart';

import '../../utils/constants.dart';

class AttendanceReportProvider with ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  List lastList = [];
  List<AttendanceModel> attendanceList = [];
  bool? isDualttendance;
  Future attendanceInitial() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    try {
      var request = http.Request(
          'GET',
          Uri.parse(
              '${UIGuide.baseURL}/studentAbsentPresentReport/initialvalues'));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      print(response.statusCode);
      if (response.statusCode == 200) {
        setLoading(true);
        final data = jsonDecode(await response.stream.bytesToString());
        print(data);
        AttendanceInitial dual = AttendanceInitial.fromJson(data);
        isDualttendance = dual.isDualAttendance;
        print("attttttt$isDualttendance");
        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        print('erroorrrrrrrr');
      }
    } catch (e) {
      setLoading(false);
    }
  }

  Future getAttReportView(String section, String course, String division,
      String date, String attType, String type) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    var response = await http.get(
        Uri.parse(
            "${UIGuide.baseURL}/studentAbsentPresentReport?sectionId=$section&courseId=$course&divisionId=$division&attendanceDate=$date&attendance=1&absentType=$attType&sendType=$type&"),
        headers: headers);
    print(
        "${UIGuide.baseURL}/studentAbsentPresentReport?sectionId=$section&courseId=$course&divisionId=$division&attendanceDate=$date&attendance=1&absentType=$attType&sendType=$type&");

    if (response.statusCode == 200) {
      setLoading(true);
      print('correct');
      List data = json.decode(response.body);

      List<AttendanceModel> templist = List<AttendanceModel>.from(
          data.map((x) => AttendanceModel.fromJson(x)));
      attendanceList.addAll(templist);
      notifyListeners();
      setLoading(false);
    } else {
      print('Error in attendance report');
      setLoading(false);
    }

    return response.statusCode;
  }

  List<StudentAttendancetakenDatum> takenList = [];
  Future getAttendanceTaken(BuildContext context, String date, String section,
      String course, String type) async {
    setLoading(true);
    SharedPreferences pref = await SharedPreferences.getInstance();
    notifyListeners();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    try {
      var request = http.Request(
          'GET',
          Uri.parse(
              '${UIGuide.baseURL}/attendancetakenornottaken/viewAttendance/?attendanceDate=$date&section=$section&course=$course&attendance=$type'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        Map<String, dynamic> data =
            jsonDecode(await response.stream.bytesToString());

        List<StudentAttendancetakenDatum> templist =
            List<StudentAttendancetakenDatum>.from(
                data["studentAttendancetakenData"]
                    .map((x) => StudentAttendancetakenDatum.fromJson(x)));
        takenList.addAll(templist);

        print('correct');
        setLoading(false);
        notifyListeners();
      } else {
        print('Error in attendance report');
        setLoading(false);
      }
    } catch (e) {
      setLoading(false);
    }
  }

  //smsProvider
  String? smstype;
  String? senderId;
  String? providerName;
  //String? providerId;

  Future getProvider() async {
    setLoading(true);
    SharedPreferences pref = await SharedPreferences.getInstance();
    notifyListeners();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    try {
      var request = http.Request(
          'GET',
          Uri.parse(
              '${UIGuide.baseURL}/mobileapp/staffdet/sms/currentprovider'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        Map<String, dynamic> data =
            jsonDecode(await response.stream.bytesToString());

        Map<String, dynamic> providerrrr = data['currentSmsProvider'];
        print(data);
        print(providerrrr);
        CurrentSmsProvider prov =
            CurrentSmsProvider.fromJson(data['currentSmsProvider']);
        providerName = prov.providerName;
        print("provid,$providerName".toString());

        setLoading(false);
        notifyListeners();
      } else {
        print('Error in attendance report');
        setLoading(false);
      }
    } catch (e) {
      setLoading(false);
    }
  }

  clearList() {
    attendanceList.clear();
    isselectAll = false;
    notifyListeners();
  }

  cleartakenList() {
    takenList.clear();
    notifyListeners();
  }

  void selectItem(AttendanceModel model) {
    AttendanceModel selected =
        attendanceList.firstWhere((element) => element.admNo == model.admNo);
    selected.selected ??= false;
    selected.selected = !selected.selected!;
    if (selected.selected == false) {
      isselectAll = false;
    }

    // selected.selected! ? lastList.add(selected.toJson()) : lastList.remove(selected);
    print("List   ${selected.toJson()}");
    //lastList.add(selected.toJson());
    print("lssssss $lastList");
    notifyListeners();
  }

  clearSelectedList() {
    lastList.clear();
    notifyListeners();
  }

  bool isselectAll = false;
  void selectAll() {
    if (attendanceList.first.selected == true) {
      for (var element in attendanceList) {
        element.selected = false;
      }
      isselectAll = false;
    } else {
      for (var element in attendanceList) {
        element.selected = true;
      }
      isselectAll = true;
    }
    notifyListeners();
  }

  List<AttendanceModel> selectedList = [];
  submitStudent(BuildContext context) {
    selectedList.clear();
    selectedList =
        attendanceList.where((element) => element.selected == true).toList();

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
          'Select any student...',
          textAlign: TextAlign.center,
        ),
      ));
    } else {
      print(
          attendanceList.where((element) => element.selected == true).toList());
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Text_Matter_NotificationAdmin(
              toList: selectedList.map((e) => e.studentId!).toList(),
              type: "Student",
            ),
          ));
    }
  }

//smslist
  List<AttendanceModel> selectedsmsList = [];
  submitSmsStudent(BuildContext context, String date) {
    selectedsmsList.clear();
    selectedsmsList =
        attendanceList.where((element) => element.selected == true).toList();
    if (selectedsmsList.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        duration: Duration(seconds: 1),
        margin: EdgeInsets.only(bottom: 80, left: 30, right: 30),
        behavior: SnackBarBehavior.floating,
        content: Text(
          'Select any student...',
          textAlign: TextAlign.center,
        ),
      ));
    } else {
      print('selected.....');
      print(
          attendanceList.where((element) => element.selected == true).toList());
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SMSFormats(
              toList: selectedsmsList.map((e) => e.studentId!).toList(),
              time: date,
            ),
          ));
    }
  }

  /// sms formats list
  ///

  clearSMSList() {
    formatlist.clear();
    notifyListeners();
  }

  List<SMSfomatModel> formatlist = [];
  Future viewSMSFormat() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    try {
      var request = http.Request('GET',
          Uri.parse('${UIGuide.baseURL}/mobileapp/staffdet/attendanceformat'));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      print('object');
      if (response.statusCode == 200) {
        setLoading(true);
        List data = jsonDecode(await response.stream.bytesToString());
        print(data);
        List<SMSfomatModel> templist = List<SMSfomatModel>.from(
            data.map((x) => SMSfomatModel.fromJson(x)));
        formatlist.addAll(templist);
        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        print('Error in formatList stf');
      }
    } catch (e) {
      setLoading(false);
    }
  }

  String? smsBody;
  Future getSMSContent(String idd) async {
    setLoading(true);
    SharedPreferences pref = await SharedPreferences.getInstance();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    try {
      var response = await http.get(
          Uri.parse(
              "${UIGuide.baseURL}/studentAbsentPresentReport/get-formats-by-id/$idd"),
          headers: headers);
      if (response.statusCode == 200) {
        print('correct');
        Map<String, dynamic> dashboard = json.decode(response.body);
        SMSContentModel ac = SMSContentModel.fromJson(dashboard);
        smsBody = ac.smsBody;
        setLoading(false);

        notifyListeners();
      } else {
        setLoading(false);
        print('Error in dashboard');
      }
    } catch (e) {
      setLoading(false);
    }
  }

  //sendsms

  String? issuccess;
  String? isfailed;
  Future sendSmsAttendance(
      BuildContext context, String date, String formatId) async {
    setLoading(true);
    SharedPreferences pref = await SharedPreferences.getInstance();

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    try {
      var request = http.Request('POST',
          Uri.parse('${UIGuide.baseURL}/studentAbsentPresentReport/send-sms'));
      print(
          Uri.parse('${UIGuide.baseURL}/studentAbsentPresentReport/send-sms'));
      request.body = json.encode({
        "ExampleMessage": "",
        "SendEmailorSMS": "SMS",
        "content": null,
        "StudEntry": selectedsmsList,
        "formatId": formatId,
        "group": "guardianGeneralSMS",
        "attendanceDate": date
      });

      print(json.encode({
        "ExampleMessage": "",
        "SendEmailorSMS": "SMS",
        "content": null,
        "StudEntry": selectedsmsList,
        "formatId": formatId,
        "group": "guardianGeneralSMS",
        "attendanceDate": date
      }));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 201) {
        setLoading(true);
        Map<String, dynamic> data =
            jsonDecode(await response.stream.bytesToString());
        print(data["sendSMS"]);
        AttendanceSmsSave smsrrsponse =
            AttendanceSmsSave.fromJson(data["sendSMS"]);
        issuccess = smsrrsponse.sendSuccess.toString();
        isfailed = smsrrsponse.sendFailed.toString();
        print(
            ' _ _ _ _ _ _ _ _ _ _ _ _ _ Correct_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _');
        await AwesomeDialog(
                dismissOnTouchOutside: false,
                dismissOnBackKeyPress: false,
                context: context,
                dialogType: DialogType.success,
                animType: AnimType.rightSlide,
                headerAnimationLoop: false,
                title: 'Sent Successfully',
                desc: 'Success: $issuccess \n Failed: $isfailed',
                btnOkOnPress: () async {},
                btnOkColor: Colors.green)
            .show();
        setLoading(false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          duration: Duration(seconds: 1),
          margin: EdgeInsets.only(bottom: 80, left: 30, right: 30),
          behavior: SnackBarBehavior.floating,
          content: Text(
            'Something Went Wrong....',
            textAlign: TextAlign.center,
          ),
        ));
        setLoading(false);
        print('Error Response in attendance');
      }
    } catch (e) {
      setLoading(false);
    }
  }
}
