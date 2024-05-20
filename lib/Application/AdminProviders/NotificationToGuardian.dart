import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:essconnect/Domain/Staff/NotifcationSendModel.dart';
import 'package:essconnect/Domain/Staff/ToGuardian.dart';
import 'package:essconnect/Presentation/Admin/Communication/ToGuardian.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Domain/Admin/AttendanceModel.dart';
import '../../Domain/Staff/ToGuardian_TextSMS.dart';
import '../../Presentation/Admin/Communication/SmsFormatAdmin.dart';

class NotificationToGuardianAdmin with ChangeNotifier {
  //view NotificationList
  bool _loading = false;

  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  List<StudentView> notificationView = [];

  Future getNotificationView(
      String section,
      String course,
      String division,
      String type,
      String formatid,
      ) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    setLoading(true);
    try {
      var request = http.Request(
          'POST', Uri.parse('${UIGuide.baseURL}/sms-to-guardian/viewData/?sectionId=$section&courseId=$course&divisionId=$division&filterStudyingStatus=studying&sendType=$type&reportFormatId=$formatid'));
      request.body = json.encode({
        "userIds": []
      });
      print("stud view.................");
      print(request);

      request.headers.addAll(headers);
      setLoading(true);
      http.StreamedResponse response = await request.send();
      print(request.body);
      if (response.statusCode == 200) {
        setLoading(true);

        print('---------------------correct--------------------------');
        List<dynamic> data =
        jsonDecode(await response.stream.bytesToString());

        List<StudentView> templist1 = List<StudentView>.from(
            data.map((x) => StudentView.fromJson(x)));
        notificationView.addAll(templist1);

        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        print('Error in StudentView');
      }
    } catch (e) {
      setLoading(false);
    }
  }



  // Future getNotificationView(String course, String division) async {
  //   setLoading(true);
  //   SharedPreferences _pref = await SharedPreferences.getInstance();
  //   notifyListeners();
  //   var headers = {
  //     'Content-Type': 'application/json',
  //     'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
  //   };
  //   try {
  //     var request = http.Request(
  //         'GET',
  //         Uri.parse(
  //             '${UIGuide.baseURL}/mobileapp/staffdet/studentlistbycoursedivision?courseId=$course&divisionId=$division'));
  //     print(http.Request(
  //         'GET',
  //         Uri.parse(
  //             '${UIGuide.baseURL}/mobileapp/staffdet/studentlistbycoursedivision?courseId=$course&divisionId=$division')));
  //     request.headers.addAll(headers);
  //
  //     http.StreamedResponse response = await request.send();
  //
  //     if (response.statusCode == 200) {
  //       setLoading(true);
  //       Map<String, dynamic> data =
  //           jsonDecode(await response.stream.bytesToString());
  //       List<StudentViewbyCourseDivision_notification_Stf> templist =
  //           List<StudentViewbyCourseDivision_notification_Stf>.from(
  //               data["studentViewbyCourseDivision"].map((x) =>
  //                   StudentViewbyCourseDivision_notification_Stf.fromJson(x)));
  //       notificationView.addAll(templist);
  //
  //       print('correct');
  //       setLoading(false);
  //       notifyListeners();
  //     } else {
  //       setLoading(false);
  //       print('Error in notificationView stf');
  //     }
  //   } catch (e) {
  //     setLoading(false);
  //   }
  // }

  //settings

  bool? showCommunication;
  bool? textSMS;
  bool? email;
  bool? notification;



  clearStudentList() {
    notificationView.clear();
    selectedList.clear();
    notifyListeners();
  }

//selelct............
  bool isSelected(StudentView model) {
    StudentView selected = notificationView
        .firstWhere((element) => element.admNo == model.admNo);
    return selected.selected!;
  }

  void selectItem(StudentView model) {
    StudentView selected = notificationView
        .firstWhere((element) => element.admNo == model.admNo);
    selected.selected ??= false;
    selected.selected = !selected.selected!;
    print(selected.toJson());
    if (selected.selected == false) {
      isselectAll = false;
    }
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

//send
  // bool _load = false;
  // bool get load => _load;
  // setLoad(bool value) {
  //   _load = value;
  //   notifyListeners();
  // }

  sendNotification(
      BuildContext context, String body, String content, List<String> to,
      {required String sentTo}) async {
    Map<String, dynamic> data = await parseJWT();
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    try {
      var request = http.Request('POST',
          Uri.parse('${UIGuide.baseURL}/mobileapp/token/saveusernotification'));
      print(
          Uri.parse('${UIGuide.baseURL}/mobileapp/token/saveusernotification'));
      request.body = json.encode({
        "Title": body,
        "Body": content,
        "FromStaffId":
            data['role'] == "Guardian" ? data['StudentId'] : data["StaffId"],
        "SentTo": sentTo,
        "ToId": to,
        "IsSeen": false
      });
      print({
        "Title": body,
        "Body": content,
        "FromStaffId":
            data['role'] == "Guardian" ? data['StudentId'] : data["StaffId"],
        "SentTo": sentTo,
        "ToId": to,
        "IsSeen": false
      });

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        setLoading(true);
        print(await response.stream.bytesToString());

        await AwesomeDialog(
                context: context,
                dialogType: DialogType.success,
                animType: AnimType.rightSlide,
                headerAnimationLoop: false,
                title: 'Success',
                desc: 'Notification Sent Successfully',
                btnOkOnPress: () {},
                btnOkIcon: Icons.cancel,
                btnOkColor: Colors.green)
            .show();
        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            duration: Duration(seconds: 1),
            margin: EdgeInsets.only(bottom: 80, left: 30, right: 30),
            behavior: SnackBarBehavior.floating,
            content: Text(
              "Something Went Wrong",
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
    } catch (e) {
      setLoading(false);
    }
  }

  List<StudentView> selectedList = [];
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
          'Select any student...',
          textAlign: TextAlign.center,
        ),
      ));
    } else {
      print('selected.....');
      print(notificationView
          .where((element) => element.selected == true)
          .toList());
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Text_Matter_NotificationAdmin(
              toList: selectedList.map((e) => e.studentId).toList(),
              type: "Student",
            ),
          ));
    }
  }

  //send History

  List<StaffNotificationHistory> historyList = [];
  Future getNotificationHistory() async {
    Map<String, dynamic> parse = await parseJWT();
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    try {
      var request = http.Request(
          'GET', Uri.parse("${UIGuide.baseURL}/mobileapp/token/sentlist"));
      request.body = json.encode({
        //  "SchoolId": _pref.getString('schoolId'),
        "CreatedDate": null,
        "StaffGuardianStudId": parse['StaffId'],
        "Type": "Student"
      });
      print(json.encode({
        // "SchoolId": _pref.getString('schoolId'),
        "CreatedDate": null,
        "StaffGuardianStudId": parse['StaffId'],
        "Type": "Student"
      }));
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print("corect");

        Map<String, dynamic> data =
            jsonDecode(await response.stream.bytesToString());

        // log(data.toString());

        List<StaffNotificationHistory> templist =
            List<StaffNotificationHistory>.from(data["results"]
                .map((x) => StaffNotificationHistory.fromJson(x)));
        historyList.addAll(templist);
        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        print("Error in Notification screen send Response");
      }
    } catch (e) {
      setLoading(false);
      print(e);
    }
  }

  //sms
  String? smstype;
  String? senderId;
  String? providerName;
  //String? providerId;

  Future getProvider() async {
    setLoading(true);
    SharedPreferences _pref = await SharedPreferences.getInstance();

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
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
      print(e);
    }
  }

  //SMS FORMAT

  List<SmsFormatByStaff> formatlist = [];
  Future viewSMSFormat() async {
    setLoading(true);
    SharedPreferences _pref = await SharedPreferences.getInstance();

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    try {
      var request = http.Request('GET',
          Uri.parse('${UIGuide.baseURL}/mobileapp/staffdet/sms/smsformats'));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      print('object');
      if (response.statusCode == 200) {
        setLoading(true);
        var data = jsonDecode(await response.stream.bytesToString());
        print(data);
        Map<String, dynamic> smsfor = data["smsSettings"];
        List<SmsFormatByStaff> templist = List<SmsFormatByStaff>.from(
            smsfor["smsFormat"].map((x) => SmsFormatByStaff.fromJson(x)));
        formatlist.addAll(templist);
        print(formatlist);
        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        print('Error in formatList stf');
      }
    } catch (e) {
      setLoading(false);
      print(e);
    }
  }

  //clearsmslist
  clearSMSList() {
    formatlist.clear();
    balance = "";
    numbList.clear();
    notifyListeners();
  }

  //sms format list

  String? smsBody;
  Future getSMSContent(String idd) async {
    setLoading(true);
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    try {
      var response = await http.get(
          Uri.parse(
              "${UIGuide.baseURL}/sms-to-guardian/get-formats-by-id/$idd"),
          headers: headers);
      if (response.statusCode == 200) {
        setLoading(true);
        print('correct');
        Map<String, dynamic> dashboard = json.decode(response.body);
        SmsFormatList ac = SmsFormatList.fromJson(dashboard);
        smsBody = ac.smsBody;
        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        print('Error in dashboard');
      }
    } catch (e) {
      setLoading(false);
      print(e);
    }
  }

  //sms balance

  String? balance;
  Future getSMSBalance() async {
    setLoading(true);
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    try {
      var response = await http.get(
          Uri.parse("${UIGuide.baseURL}/sms-to-guardian/getbalance"),
          headers: headers);
      if (response.statusCode == 200) {
        setLoading(true);
        print('correct');
        Map<String, dynamic> dashboard = json.decode(response.body);
        SmsBalance ac = SmsBalance.fromJson(dashboard);
        balance = ac.count.toString();
        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        print('Error in dashboard');
      }
    } catch (e) {
      setLoading(false);
      print(e);
    }
  }

  //getnumbers

  // bool _loadSMS = false;
  // bool get loadSMS => _loadSMS;
  // setLoadSMS(bool value) {
  //   _loadSMS = value;
  //   notifyListeners();
  // }

  List<GetNumbers> numbList = [];
  Future getNumbers(List toList, bool avoid) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    try {
      var request = http.Request(
          'POST',
          Uri.parse(
              '${UIGuide.baseURL}/sms-to-guardian/sms/get-phone-numbers-to-send'));
      print(Uri.parse(
          '${UIGuide.baseURL}/sms-to-guardian/sms/get-phone-numbers-to-send'));
      request.body = json.encode({
        "userIds": toList,
        "avoidRepeatedSMS": avoid,
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        setLoading(true);
        print('correct');
        List numb = jsonDecode(await response.stream.bytesToString());
        List<GetNumbers> templist =
            List<GetNumbers>.from(numb.map((x) => GetNumbers.fromJson(x)));
        numbList.addAll(templist);
        print("NumbLst$numb");
        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        print('Error in response');
      }
    } catch (e) {
      setLoading(false);
      print(e);
    }
  }

  //sendsms

  String? issuccess;
  String? isfailed;
  String? types;
  Future sendSms(BuildContext context, List studList, String formatId) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    try {
      var request = http.Request(
          'POST', Uri.parse('${UIGuide.baseURL}/sms-to-guardian/send-sms'));
      print(Uri.parse('${UIGuide.baseURL}/sms-to-guardian/send-sms'));
      request.body = json.encode({
        "formatId": formatId,
        "group": "guardianGeneralSMS",
        "ExampleMessage": "",
        "SendEmailorSMS": types == "sms" ? "SMS" : "Email",
        "content": null,
        "entries": studList,
        "sendTowhom": "Guardian"
      });

      print(json.encode({
        "formatId": formatId,
        "group": "guardianGeneralSMS",
        "ExampleMessage": "",
        "SendEmailorSMS": types == "sms" ? "SMS" : "Email",
        "content": null,
        "entries": studList,
        "sendTowhom": "Guardian"
      }));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        setLoading(true);
        Map<String, dynamic> data =
            jsonDecode(await response.stream.bytesToString());
        Map<String, dynamic> result = data["result"];
        SmsResult smres = SmsResult.fromJson(result);
        issuccess = smres.sendSuccess.toString();
        isfailed = smres.sendFailed.toString();
        print(result);

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
                btnOkOnPress: () async {
                  numbList.clear();
                  balance = "";
                },
                btnOkColor: Colors.green)
            .show();
        setLoading(false);
        notifyListeners();
        //await getSMSBalance();
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
        print('Error Response in sms send');
        setLoading(false);
      }
    } catch (e) {
      setLoading(false);
      print(e);
    }
  }

  List<StudentView> selectedSmsList = [];
  submitSmsStudent(BuildContext context) {
    selectedSmsList.clear();
    selectedSmsList =
        notificationView.where((element) => element.selected == true).toList();
    print(selectedSmsList);
    if (selectedSmsList.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        duration: Duration(seconds: 1),
        margin: EdgeInsets.only(bottom: 80, left: 30, right: 30),
        behavior: SnackBarBehavior.floating,
        content: Text(
          'Select any student',
          textAlign: TextAlign.center,
        ),
      ));
    } else {
      print('selected.....');
      print(notificationView
          .where((element) => element.selected == true)
          .toList());
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SmsFormatAdmin(
            toList: selectedSmsList.map((e) => e.studentId).toList(),
            types: types.toString(),
          ),
        ),
      );
    }
  }
}
