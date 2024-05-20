import 'dart:convert';
import 'dart:developer';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:essconnect/Constants.dart';
import 'package:essconnect/Presentation/Staff/SmsFormatGuardian.dart';
import 'package:essconnect/Domain/Staff/ToGuardian.dart';
import 'package:essconnect/Presentation/Staff/ToGuardian.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Domain/Admin/AttendanceModel.dart';

import '../../Domain/Staff/NotifcationSendModel.dart';
import '../../Domain/Staff/ToGuardian_TextSMS.dart';
import '../../Presentation/Staff/CommunicationToGuardian.dart';

class NotificationToGuardian_Providers with ChangeNotifier {
  bool _loading = false;

  String? replacementValue;

  String? replacedString;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }


//course List

  courseClear() {
    communicationToGuardianInitialValues.clear();
    notifyListeners();
  }

  List<CommunicationToGuardian_course> communicationToGuardianInitialValues =
      [];
  bool? isClassTeacher;

  Future communicationToGuardianCourseStaff() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    await courseClear();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    try {
      var response = await http.get(
          Uri.parse(
              "${UIGuide.baseURL}/mobileapp/staffdet/noticeBoard/initialValues"),
          headers: headers);

      if (response.statusCode == 200) {
        setLoading(true);
        print("corect");
        final data = json.decode(response.body);

        Map<String, dynamic> smsiniti = await data['initialValues'];

        List<CommunicationToGuardian_course> templist =
            List<CommunicationToGuardian_course>.from(smsiniti["courseList"]
                .map((x) => CommunicationToGuardian_course.fromJson(x)));
        communicationToGuardianInitialValues.addAll(templist);

        NotificationToGuardian_initialValues att =
            NotificationToGuardian_initialValues.fromJson(
                data['initialValues']);

        isClassTeacher = att.isClassTeacher;
        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        print("Error in Notification course response");
      }
    } catch (e) {
      setLoading(false);
      print(e);
    }
  }

// Division

  divisionClear() {
    notificationDivisionList.clear();
    notifyListeners();
  }

  List<CommunicationToGuardian_Division> notificationDivisionList = [];
  Future communicationToGuardianDivisionStaff(String courseId) async {
    setLoading(true);
    SharedPreferences _pref = await SharedPreferences.getInstance();

    await divisionClear();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    try {
      var request = http.Request(
          'GET',
          Uri.parse(
              '${UIGuide.baseURL}/mobileapp/staffdet/noticeboard/divisions/$courseId'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        setLoading(true);
        Map<String, dynamic> data =
            jsonDecode(await response.stream.bytesToString());

        log(data.toString());

        List<CommunicationToGuardian_Division> templist =
            List<CommunicationToGuardian_Division>.from(data["divisions"]
                .map((x) => CommunicationToGuardian_Division.fromJson(x)));
        notificationDivisionList.addAll(templist);

        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        print('Error in staff_toGuard_notifi_DivisionList ');
      }
    } catch (e) {
      setLoading(false);
      print(e);
    }
  }

  //view NotificationList

  List<StudentViewbyCourseDivision_notification_Stf> notificationView = [];
  Future getNotificationView(String course, String division) async {
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
              '${UIGuide.baseURL}/mobileapp/staffdet/studentlistbycoursedivision?courseId=$course&divisionId=$division'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        Map<String, dynamic> data =
            jsonDecode(await response.stream.bytesToString());
        log(data.toString());
        List<StudentViewbyCourseDivision_notification_Stf> templist =
            List<StudentViewbyCourseDivision_notification_Stf>.from(
                data["studentViewbyCourseDivision"].map((x) =>
                    StudentViewbyCourseDivision_notification_Stf.fromJson(x)));
        notificationView.addAll(templist);
        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        print('Error in notificationView stf');
      }
    } catch (e) {
      setLoading(false);
    }
  }

  clearStudentList() {
    notificationView.clear();

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
    if (selected.selected == false) {
      isselectAll = false;
    }
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
//send notification

  // bool _load = false;
  // bool get load => _load;
  // setLoad(bool value) {
  //   _load = value;
  //   notifyListeners();
  // }

  sendNotification(
      BuildContext context, String body, String content, List to,
      {required String sentTo}) async {
    Map<String, dynamic> data = await parseJWT();
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);

    print(_pref.getString('accesstoken'));
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
        "Title-": body,
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

      snackbarWidget(3, "Something Went Wrong", context);
    }
  }
//Send common notification

  sendCommonNotification(
      BuildContext context, String body, String content, List to,
      {required String sentTo}) async {
    Map<String, dynamic> data = await parseJWT();
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);

    print(_pref.getString('accesstoken'));
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
        "Title-": body,
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

        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
      }
    } catch (e) {
      setLoading(false);

      snackbarWidget(3, "Something Went Wrong", context);
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
            builder: (context) => Text_Matter_Notification(
              toList: selectedList.map((e) => e.studentId).toList(),
              type: "Student",
            ),
          ));
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
    notifyListeners();
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
    }
  }

  //SMS FORMAT

  List<SmsFormatByStaff> formatlist = [];
  Future viewSMSFormat() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);
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
        print("bimalll");
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
String? replacednewString;
  List<String> extractedValues=[];
  List<String> extractValuesInDoubleBrackets(String input) {
    RegExp regExp = RegExp(r'\[\[(.*?)\]\]');
    Iterable<Match> matches = regExp.allMatches(input);

    List<String> extractedValues =
    matches.map((match) => match.group(1)!).toList();

    return extractedValues;
  }

    //replace
  void main() {

    String replacedString = replaceValuesInsideDoubleBrackets(smsBody!, extractedValues);

    print(replacedString);
  }

  String replaceValuesInsideDoubleBrackets(String originalString, List<String> replacementList) {
    int index = 0;

     replacedString = originalString.replaceAllMapped(
      RegExp(r'\[\[(.*?)\]\]'),
          (Match match) {
        // Get the replacement value from the list.
         replacementValue = replacementList.length > index ? '[[${replacementList[index]}]]' : '';

        index++;

        return replacementValue!;
      },
    );
    print("roooooooo");
  print(replacedString);
    return replacedString!;
  }


  //smscontent
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
        print("roshh");
        print('correct');
        Map<String, dynamic> dashboard = json.decode(response.body);
        SmsFormatList ac = SmsFormatList.fromJson(dashboard);
        smsBody = ac.smsBody;

       extractedValues = extractValuesInDoubleBrackets(smsBody!);
        print("binithaaaa");
        print(extractedValues);
        print(extractedValues.length);

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
    }
  }

  //getnumbers
  List<GetNumbers> numbList = [];
  Future getNumbers(List toList, bool avoid) async {
    setLoading(true);
    SharedPreferences _pref = await SharedPreferences.getInstance();
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
        print('correct');
        List numb = jsonDecode(await response.stream.bytesToString());
        List<GetNumbers> templist =
            List<GetNumbers>.from(numb.map((x) => GetNumbers.fromJson(x)));
        numbList.addAll(templist);
        print("NumbLst$numb");
        setLoading(false);
        notifyListeners();
      } else {
        setLoading(true);
        print('Error in response');
      }
    } catch (e) {
      setLoading(false);
    }
  }


  //sms format edit


  Future smsformatedit(BuildContext context,String smsbody,String name,String smsBodyold,bool isapproved,List changable,String formatid) async {
    setLoading(true);
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    try {
      var request = http.Request(
          'POST',
          Uri.parse(
              '${UIGuide.baseURL}/sms-to-guardian/save-format/$formatid'));
      print(Uri.parse(
          '${UIGuide.baseURL}/sms-to-guardian/save-format/$formatid'));
      request.body = json.encode({
        "smsBody": replacedString,
        "content": null,
        "formatName": {
          "id":formatid,
          "name": name,
          "smsBody": smsBodyold,
          "content": null,
          "isApproved": isapproved
        },
        "changeableText": changable
      }
      );

      print("edittttttt");
      print(json.encode({
        "smsBody": replacedString,
        "content": null,
        "formatName": {
          "id":formatid,
          "name": name,
          "smsBody": smsBodyold,
          "content": null,
          "isApproved": isapproved
        },
        "changeableText": changable
      }
      ));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        print('correct');
        Map<String, dynamic> data =
        jsonDecode(await response.stream.bytesToString());
        SmsFormatEdit editFormt = SmsFormatEdit.fromJson(data);

        smsBody = editFormt.smsBody;

        await AwesomeDialog(
            dismissOnTouchOutside: false,
            dismissOnBackKeyPress: false,
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.rightSlide,
            headerAnimationLoop: false,
            title: 'SMS Format Updated Successfully',
            titleTextStyle: TextStyle(
              fontSize: 16
            ),
            btnOkOnPress: () async {
             Navigator.pop(context);
            },
            btnOkColor: Colors.green)
            .show();


        setLoading(false);
        notifyListeners();
      } else {
        setLoading(true);
        print('Error in response');
      }
    } catch (e) {
      setLoading(false);
    }
  }


  // //sendsms
  // bool _loadsendSms = false;
  // bool get loadsendSms => _loadsendSms;
  // setLoadsendSms(bool value) {
  //   _loadsendSms = value;
  //   notifyListeners();
  // }

  String? issuccess;
  String? isfailed;
  String? type;
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
        "SendEmailorSMS": type == "sms" ? "SMS" : "Email",
        "content": null,
        "entries": studList,
        "sendTowhom": "Guardian"
      });

      print(json.encode({
        "formatId": formatId,
        "group": "guardianGeneralSMS",
        "ExampleMessage": "",
        "SendEmailorSMS": type == "sms" ? "SMS" : "Email",
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
        print('Error Response in sms send');
      }
    } catch (e) {
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
          builder: (context) => SmsFormatGuardian(
            toList: selectedSmsList.map((e) => e.studentId).toList(),
            types: type.toString(),
          ),
        ),
      );
    }
  }
}
