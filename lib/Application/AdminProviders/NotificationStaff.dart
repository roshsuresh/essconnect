import 'dart:convert';
import 'dart:developer';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:essconnect/Constants.dart';
import 'package:essconnect/Domain/Admin/StaffListModel.dart';
import 'package:essconnect/Domain/Staff/NotifcationSendModel.dart';
import 'package:essconnect/Presentation/Admin/Communication/ToStaff.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../Domain/Admin/AttendanceModel.dart';
import '../../Presentation/Admin/Communication/SmsFormatToStaff.dart';

class NotificationToStaffAdminProviders with ChangeNotifier {
  bool _loading = false;

  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  //view
  List<StaffReportNotification> stafflist = [];
  Future<bool> getNotificationView(String section) async {
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
            '${UIGuide.baseURL}/mobileapp/admin/viewStaffReport?section=$section'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Map<String, dynamic> data =
          jsonDecode(await response.stream.bytesToString());

      log(data.toString());
      List<StaffReportNotification> templistt =
          List<StaffReportNotification>.from(data["staffReport"]
              .map((x) => StaffReportNotification.fromJson(x)));

      stafflist.addAll(templistt);

      print('correct');
      setLoading(false);
      notifyListeners();
    } else {
      print('Error in notificationView Admin to staff');
    }
    return true;
  }

  clearStaffList() {
    stafflist.clear();
    notifyListeners();
  }

  //clearsmslist
  clearSMSList() {
    formatlists.clear();
    balance = "";
    notifyListeners();
  }

  bool isSelected(StaffReportNotification model) {
    StaffReportNotification selected =
        stafflist.firstWhere((element) => element.id == model.id);
    return selected.selected ??= false;
  }

  void selectItem(StaffReportNotification model) {
    StaffReportNotification selected =
        stafflist.firstWhere((element) => element.id == model.id);

    selected.selected ??= false;
    selected.selected = !selected.selected!;
    print(selected.toJson());
    if (selected.selected == false) {
      isSelectAllStaff = false;
    }

    notifyListeners();
  }

  bool isSelectAllStaff = false;
  void selectAllStaff() {
    if (stafflist.first.selected == true) {
      for (var element in stafflist) {
        element.selected = false;
      }
      isSelectAllStaff = false;
    } else {
      for (var element in stafflist) {
        element.selected = true;
      }
      isSelectAllStaff = true;
    }
    notifyListeners();
  }
//send notification

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
    // print(_pref.getString('token'));
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    var request = http.Request('POST',
        Uri.parse('${UIGuide.baseURL}/mobileapp/token/saveusernotification'));
    print(Uri.parse('${UIGuide.baseURL}/mobileapp/token/saveusernotification'));
    request.body = json.encode({
      // "SchoolId": data["SchoolId"],
      "Title": body,
      "Body": content,
      "FromStaffId":
          data['role'] == "Guardian" ? data['StudentId'] : data["StaffId"],
      "SentTo": sentTo,
      "ToId": to,
      "IsSeen": false
    });
    print({
      // "SchoolId": data["SchoolId"],
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
    } else {
      setLoad(false);
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
      print(response.reasonPhrase);
    }
  }

  List<StaffReportNotification> selectedStaffList = [];
  submitStaff(BuildContext context) {
    selectedStaffList.clear();
    selectedStaffList =
        stafflist.where((element) => element.selected == true).toList();
    if (selectedStaffList.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        duration: Duration(seconds: 1),
        margin: EdgeInsets.only(bottom: 80, left: 30, right: 30),
        behavior: SnackBarBehavior.floating,
        content: Text(
          'Please Select....',
          textAlign: TextAlign.center,
        ),
      ));
    } else {
      print('v ${selectedStaffList.map((e) => e.id).toList().length}');
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => Text_Matter_NotificationAdminToStaff(
                    toList: selectedStaffList.map((e) => e.id!).toList(),
                    type: "Staff",
                  )));
    }
  }

  List<AdminStaffNotificationHistory> historyList = [];
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
      "CreatedDate": null,
      "StaffGuardianStudId": parse['StaffId'],
      "Type": "Staff"
    });
    print(json.encode({
      "CreatedDate": null,
      "StaffGuardianStudId": parse['StaffId'],
      "Type": "Staff"
    }));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    try {
      if (response.statusCode == 200) {
        Map<String, dynamic> data =
            jsonDecode(await response.stream.bytesToString());

        List<AdminStaffNotificationHistory> templist =
            List<AdminStaffNotificationHistory>.from(data["results"]
                .map((x) => AdminStaffNotificationHistory.fromJson(x)));
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
  //provider details

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

  //sms balance

  String? balance;
  Future<int> getSMSBalanceStaff() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    var response = await http.get(
        Uri.parse("${UIGuide.baseURL}/sendsmstostaff/getbalance"),
        headers: headers);
    if (response.statusCode == 200) {
      print('correct');
      Map<String, dynamic> dashboard = json.decode(response.body);
      SmsBalanceStaff ac = SmsBalanceStaff.fromJson(dashboard);
      balance = ac.count.toString();

      notifyListeners();
    } else {
      print('Error in dashboard');
    }
    return response.statusCode;
  }

//sms format

  List<SmsFormatsAdminCompleteview> formatlists = [];
  Future<bool> viewSMSFormat() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    var request = http.Request(
        'GET', Uri.parse('${UIGuide.baseURL}/sendsmstostaff/get-formats'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print('object');
    if (response.statusCode == 200) {
      var data = jsonDecode(await response.stream.bytesToString());
      print(data);

      List<SmsFormatsAdminCompleteview> templist =
          List<SmsFormatsAdminCompleteview>.from(data["smsFormats"]
              .map((x) => SmsFormatsAdminCompleteview.fromJson(x)));
      formatlists.addAll(templist);
      print(formatlists);

      notifyListeners();
    } else {
      print('Error in formatList stf');
    }
    return true;
  }


  //sms format list
  String? replacedString;
  String? replacementValue;
  String? replacednewString;
  List<String> extractedValuesStaff=[];
  List<String> extractValuesInDoubleBrackets(String input) {
    RegExp regExp = RegExp(r'\[\[(.*?)\]\]');
    Iterable<Match> matches = regExp.allMatches(input);

    List<String> extractedValuesStaff =
    matches.map((match) => match.group(1)!).toList();

    return extractedValuesStaff;
  }

  //replace
  void main() {

    String replacedString = replaceValuesInsideDoubleBrackets(smsBody!, extractedValuesStaff);

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
              '${UIGuide.baseURL}/sendsmstostaff/save-format/$formatid'));
      print(Uri.parse(
          '${UIGuide.baseURL}/sendsmstostaff/save-format/$formatid'));
      request.body = json.encode({
      "group": "guardianGeneralSMS",
        "name": {
          "id":formatid,
          "name": name,
          "smsBody": smsBodyold,
          "content": "",
          "isApproved": isapproved
        },
        "smsBody": replacedString,
        "content": "",
        "isApproved": isapproved,
        "formatName": {
          "id":formatid,
          "name": name,
          "smsBody": smsBodyold,
          "content": "",
          "isApproved": isapproved
        },
        "changeableText": changable
      }
      );

      print("edittttttt");
      print(json.encode({
        "group": "guardianGeneralSMS",
        "name": {
          "id":formatid,
          "name": name,
          "smsBody": smsBodyold,
          "content": "",
          "isApproved": isapproved
        },
        "smsBody": replacedString,
        "content": "",
        "isApproved": isapproved,
        "formatName": {
          "id":formatid,
          "name": name,
          "smsBody": smsBodyold,
          "content": "",
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



  //select format

  String? smsBody;
  Future<int> getStaffSMSContent(String idd) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    var response = await http.get(
        Uri.parse("${UIGuide.baseURL}/sendsmstostaff/get-formats-by-id/$idd"),
        headers: headers);
    if (response.statusCode == 200) {
      print('correct');
      Map<String, dynamic> dashboard = json.decode(response.body);
      SmsFormatsAdminCompleteview ac =
          SmsFormatsAdminCompleteview.fromJson(dashboard);
      smsBody = ac.smsBody;
      extractedValuesStaff = extractValuesInDoubleBrackets(smsBody!);
      print("binithaaaa");
      print(extractedValuesStaff);
      print(extractedValuesStaff.length);

      notifyListeners();
    } else {
      print('Error in dashboard');
    }
    return response.statusCode;
  }


  //format edit


//sendsms
  bool _loadSMS = false;
  bool get loadSMS => _loadSMS;
  setLoadSMS(bool value) {
    _loadSMS = value;
    notifyListeners();
  }

  String? issuccess;
  String? isfailed;
  String? types;
  Future sendSmstoStaff(
      BuildContext context, String formatId, List toStaffList) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoadSMS(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };

    var request = http.Request(
        'POST', Uri.parse('${UIGuide.baseURL}/sendsmstostaff/send-sms'));
    print(Uri.parse('${UIGuide.baseURL}/sendsmstostaff/send-sms'));
    request.body = json.encode({
      "formatId": formatId,
      "group": "guardianGeneralSMS",
      "ExampleMessage": "",
      "SendEmailorSMS": types == "sms" ? "SMS" : "Email",
      "content": null,
      "StaffEntry": toStaffList,
      "Title": ""
    });

    print(json.encode({
      "formatId": formatId,
      "group": "guardianGeneralSMS",
      "ExampleMessage": "",
      "SendEmailorSMS": types == "sms" ? "SMS" : "Email",
      "content": null,
      "StaffEntry": toStaffList,
      "Title": ""
    }));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    setLoadSMS(true);

    if (response.statusCode == 200) {
      setLoadSMS(true);
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
                //  stafflist.clear();
                balance = "";
              },
              btnOkColor: Colors.green)
          .show();
      setLoadSMS(false);
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
      setLoadSMS(false);
      print('Error Response in sms send');
    }
    setLoadSMS(false);
  }

  List<StaffReportNotification> selectedSmsList = [];
  submitSmsStaff(BuildContext context) {
    selectedSmsList.clear();
    selectedSmsList =
        stafflist.where((element) => element.selected == true).toList();
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
          'Select any Staff',
          textAlign: TextAlign.center,
        ),
      ));
    } else {
      print('selected.....');
      print(stafflist.where((element) => element.selected == true).toList());
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SmsFormatToStaff(
            toList: selectedSmsList,
            types: types.toString(),
          ),
        ),
      );
    }
  }
}
