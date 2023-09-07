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
import '../../Presentation/Staff/SmsFormatGuardian.dart';

class NotificationToGuardianAdmin with ChangeNotifier {
  //view NotificationList
  bool _loading = false;

  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  List<StudentViewbyCourseDivision_notification_Stf> notificationView = [];
  Future<bool> getNotificationView(String course, String division) async {
    setLoading(true);
    SharedPreferences _pref = await SharedPreferences.getInstance();
    notifyListeners();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            '${UIGuide.baseURL}/mobileapp/staffdet/studentlistbycoursedivision?courseId=$course&divisionId=$division'));
    print(http.Request(
        'GET',
        Uri.parse(
            '${UIGuide.baseURL}/mobileapp/staffdet/studentlistbycoursedivision?courseId=$course&divisionId=$division')));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Map<String, dynamic> data =
          jsonDecode(await response.stream.bytesToString());
      List<StudentViewbyCourseDivision_notification_Stf> templist =
          List<StudentViewbyCourseDivision_notification_Stf>.from(
              data["studentViewbyCourseDivision"].map((x) =>
                  StudentViewbyCourseDivision_notification_Stf.fromJson(x)));
      notificationView.addAll(templist);

      print('correct');
      setLoading(false);
      notifyListeners();
    } else {
      print('Error in notificationView stf');
    }
    return true;
  }

  clearStudentList() {
    notificationView.clear();
    selectedList.clear();
    notifyListeners();
  }

//selelct............
  bool isSelected(StudentViewbyCourseDivision_notification_Stf model) {
    StudentViewbyCourseDivision_notification_Stf selected = notificationView
        .firstWhere((element) => element.admnNo == model.admnNo);
    return selected.selected!;
  }

  void selectItem(StudentViewbyCourseDivision_notification_Stf model) {
    StudentViewbyCourseDivision_notification_Stf selected = notificationView
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

//send
  bool _load = false;
  bool get load => _load;
  setLoad(bool value) {
    _load = value;
    notifyListeners();
  }

  sendNotification(
      BuildContext context, String body, String content, List<String> to,
      {required String sentTo}) async {
    Map<String, dynamic> data = await parseJWT();
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoad(true);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    var request = http.Request('POST',
        Uri.parse('${UIGuide.baseURL}/mobileapp/token/saveusernotification'));
    print(Uri.parse('${UIGuide.baseURL}/mobileapp/token/saveusernotification'));
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
      setLoad(true);
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
      setLoad(false);
      notifyListeners();
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(
      //     elevation: 10,
      //     shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.all(Radius.circular(10)),
      //     ),
      //     duration: Duration(seconds: 1),
      //     margin: EdgeInsets.only(bottom: 80, left: 30, right: 30),
      //     behavior: SnackBarBehavior.floating,
      //     content: Text(
      //       "Notification Sent Successfully",
      //       textAlign: TextAlign.center,
      //     ),
      //   ),
      // );
    } else {
      setLoad(false);
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
  }

  List<StudentViewbyCourseDivision_notification_Stf> selectedList = [];
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

    try {
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

  Future<bool> getProvider() async {
    setLoading(true);
    SharedPreferences _pref = await SharedPreferences.getInstance();
    notifyListeners();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    var request = http.Request('GET',
        Uri.parse('${UIGuide.baseURL}/mobileapp/staffdet/sms/currentprovider'));

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
    return true;
  }

  //SMS FORMAT

  List<SmsFormatByStaff> formatlist = [];
  Future<bool> viewSMSFormat() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    var request = http.Request('GET',
        Uri.parse('${UIGuide.baseURL}/mobileapp/staffdet/sms/smsformats'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print('object');
    if (response.statusCode == 200) {
      var  data = jsonDecode(await response.stream.bytesToString());
      print(data);
      Map<String,dynamic> smsfor = data["smsSettings"];
      List<SmsFormatByStaff> templist =
      List<SmsFormatByStaff>.from(smsfor["smsFormat"].map((x) => SmsFormatByStaff.fromJson(x)));
      formatlist.addAll(templist);
      print(formatlist);

      notifyListeners();
    } else {
      print('Error in formatList stf');
    }
    return true;
  }

  //clearsmslist
  clearSMSList() {
    formatlist.clear();
    balance="";
    numbList.clear();
    notifyListeners();
  }

  //sms format list

  String? smsBody;
  Future<int> getSMSContent(String idd) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    var response = await http.get(
        Uri.parse(
            "${UIGuide.baseURL}/sms-to-guardian/get-formats-by-id/$idd"),
        headers: headers);
    if (response.statusCode == 200) {
      print('correct');
      Map<String, dynamic> dashboard = json.decode(response.body);
      SmsFormatList ac = SmsFormatList.fromJson(dashboard);
      smsBody = ac.smsBody;

      notifyListeners();
    } else {
      print('Error in dashboard');
    }
    return response.statusCode;
  }

  //sms balance

  String? balance;
  Future<int> getSMSBalance() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    var response = await http.get(
        Uri.parse(
            "${UIGuide.baseURL}/sms-to-guardian/getbalance"),
        headers: headers);
    if (response.statusCode == 200) {
      print('correct');
      Map<String, dynamic> dashboard = json.decode(response.body);
      SmsBalance ac = SmsBalance.fromJson(dashboard);
      balance = ac.count.toString();

      notifyListeners();
    } else {
      print('Error in dashboard');
    }
    return response.statusCode;
  }

  //getnumbers
  List<GetNumbers> numbList=[];
  Future<int> getNumbers(List toList,bool avoid) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    var request = http.Request('POST',
        Uri.parse('${UIGuide.baseURL}/sms-to-guardian/sms/get-phone-numbers-to-send'));
    print(Uri.parse('${UIGuide.baseURL}/sms-to-guardian/sms/get-phone-numbers-to-send'));
    request.body = json.encode({

      "userIds": toList,
      "avoidRepeatedSMS": avoid,

    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print('correct');
      List numb =  jsonDecode(await response.stream.bytesToString());
      List<GetNumbers> templist = List<GetNumbers>.from(
          numb.map((x) => GetNumbers.fromJson(x)));
      numbList.addAll(templist);
      print("NumbLst$numb");




      notifyListeners();
    } else {
      print('Error in response');
    }
    return response.statusCode;
  }

  //sendsms

  String? issuccess;
  String? isfailed;
  String? types;
  Future sendSms(
      BuildContext context, List studList,String formatId) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };

    var request = http.Request('POST',
        Uri.parse('${UIGuide.baseURL}/sms-to-guardian/send-sms'));
    print(Uri.parse('${UIGuide.baseURL}/sms-to-guardian/send-sms'));
    request.body = json.encode({
      "formatId": formatId,
      "group": "guardianGeneralSMS",
      "ExampleMessage": "",
      "SendEmailorSMS": types=="sms"? "SMS":"Email",
      "content": null,
      "entries": studList,
      "sendTowhom": "Guardian"
    });

    print(json.encode({
      "formatId": formatId,
      "group": "guardianGeneralSMS",
      "ExampleMessage": "",
      "SendEmailorSMS": types=="sms"? "SMS":"Email",
      "content": null,
      "entries": studList,
      "sendTowhom": "Guardian"
    }));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Map<String, dynamic> data =
      jsonDecode(await response.stream.bytesToString());
      Map<String, dynamic> result =data["result"];
      SmsResult smres =SmsResult.fromJson(result);
      issuccess=smres.sendSuccess.toString();
      isfailed=smres.sendFailed.toString();
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
            balance="";

          },
          btnOkColor: Colors.green)
          .show();
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
    }
  }

  List<StudentViewbyCourseDivision_notification_Stf> selectedSmsList = [];
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
            toList: selectedSmsList.map((e) => e.studentId!).toList(),
            types: types.toString(),
          ),
        ),
      );
    }
  }

}
