import 'dart:convert';
import 'dart:developer';
import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Constants.dart';
import '../../Domain/Admin/AttendanceModel.dart';
import '../../Domain/Staff/NotifcationSendModel.dart';
import '../../Domain/Staff/ToGuardian_TextSMS.dart';
import '../../Presentation/Staff/CommunicationToGuardian.dart';
import '../../Presentation/Staff/SmsFormatGuardian.dart';
import '../../utils/constants.dart';


Map? staffTextSMSToGuardianRespo;
List? staffTextSMSToGuardRespo;

class TextSMS_ToGuardian_Providers with ChangeNotifier {

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
  //length

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

  //clear
  clearStudentList() {
    notificationView.clear();
    selectedList.clear();
    notifyListeners();
  }


  clearSection() {
    dropDown.clear();
    sectionList.clear();
    notifyListeners();
  }

  clearCourse() {
    courseDrop.clear();
    courseList.clear();
    notifyListeners();
  }

  clearDivision() async {
    divisionDrop.clear();
    divisionlist.clear();
    notifyListeners();
  }
  clearSectionDivision() async {
    divisionDrop.clear();
    divisionSectionlist.clear();
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
    courseList.clear();
  }
  //loading

  bool _loadingSection = false;
  bool get loadingSection => _loadingSection;
  setloadingSection(bool value) {
    _loadingSection = value;
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
  //Initial for Communication new

  List<SectionsforCommunication> sectionList = [];
  List<MultiSelectItem> dropDown = [];
  bool? isClassTeacher;
  bool? showCommunication;
  bool? showTextSMS;
  bool? showEmail;
  bool? showNotification;
  bool? empty;
  List checkType=[];




  Future<bool> getInitialCommunication() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setloadingSection(true);


    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            '${UIGuide.baseURL}/sms-to-guardian/initialvalues'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      setloadingSection(true);
      Map<String, dynamic> data =
      jsonDecode(await response.stream.bytesToString());

      List<SectionsforCommunication> templist =
      List<SectionsforCommunication>.from(data["sections"]
          .map((x) => SectionsforCommunication.fromJson(x)));
      sectionList.addAll(templist);


      List<CourseInCommnunication> templist2 = List<CourseInCommnunication>.from(data["courses"]
          .map((x) => CourseInCommnunication.fromJson(x)));
      courseList.addAll(templist2);

      print(courseList.toList());


      List<DivisionInCommnunication> templist3 = List<DivisionInCommnunication>.from(data["divisions"]
          .map((x) => DivisionInCommnunication.fromJson(x)));
      divisionSectionlist.addAll(templist3);
      print(divisionSectionlist.toList());


      dropDown = sectionList.map((subjectdata) {
        return MultiSelectItem(subjectdata, subjectdata.text!);
      }).toList();
      showCommunication= data['showCommunication'];
      showNotification= data['showNotification'];
      showEmail= data['showEmail'];
      showTextSMS= data['showTextSMS'];
      isClassTeacher =data['isClassTeacher'];
      setloadingSection(false);
      notifyListeners();

      print(checkType);

      print("valueeeeeeeeeee");
      print(showCommunication);
    } else {
      setloadingSection(false);
      print('Error in Settings');
    }
    return true;
  }
  //divisonSection

  List<DivisionInCommnunication> divisionSectionlist = [];
  Future getDivisonSectionList(String sectionId) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };

    var request = http.Request(
        'GET',
        Uri.parse(
            '${UIGuide.baseURL}/sms-to-guardian/divisionsection/$sectionId'));
    request.body = json.encode({"SchoolId": _pref.getString('schoolId')});
    request.headers.addAll(headers);
    print("____________");
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      setloadingDivision(true);
      List<dynamic> data =
      jsonDecode(await response.stream.bytesToString());

      List<DivisionInCommnunication> templist = List<DivisionInCommnunication>.from(
          data.map((x) => DivisionInCommnunication.fromJson(x)));
      divisionSectionlist.clear();
      divisionSectionlist.addAll(templist);
      divisionDrop = divisionSectionlist.map((subjectdata) {
        return MultiSelectItem(subjectdata, subjectdata.text ?? "");
      }).toList();
      setloadingDivision(false);
      notifyListeners();
    } else {
      print('Error in Notice stf');
    }
    return true;
  }


//course

  List<CourseInCommnunication> courseList = [];
  List<MultiSelectItem> courseDrop = [];

  Future getCourseList(String sectionId) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };

      var request = http.Request(
        'GET',
        Uri.parse(
            '${UIGuide.baseURL}/sms-to-guardian/courses/$sectionId'));
    request.body = json.encode({"SchoolId": _pref.getString('schoolId')});
    request.headers.addAll(headers);
    print("____________");
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      setloadingCourse(true);
      List<dynamic> data =
      jsonDecode(await response.stream.bytesToString());

      List<CourseInCommnunication> templist = List<CourseInCommnunication>.from(
          data.map((x) => CourseInCommnunication.fromJson(x)));
      courseList.addAll(templist);
      courseDrop = courseList.map((subjectdata) {
        return MultiSelectItem(subjectdata, subjectdata.text ?? "");
      }).toList();
      setloadingCourse(false);
      notifyListeners();
    } else {
      print('Error in Notice stf');
    }
    return true;
  }



  //Division List

  List<DivisionInCommnunication> divisionlist = [];
  List<MultiSelectItem> divisionDrop = [];
  Future<bool> getDivisionList(String courseId) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            '${UIGuide.baseURL}/sms-to-guardian/divisions/$courseId'));
    request.body = json.encode({"SchoolId": _pref.getString('schoolId')});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      setloadingDivision(true);
      List<dynamic> data =
      jsonDecode(await response.stream.bytesToString());

      List<DivisionInCommnunication> templist = List<DivisionInCommnunication>.from(
          data.map((x) => DivisionInCommnunication.fromJson(x)));
      divisionlist.addAll(templist);
      divisionDrop = divisionlist.map((subjectdata) {
        return MultiSelectItem(subjectdata, subjectdata.text ?? "");
      }).toList();
      setloadingDivision(false);
      notifyListeners();
    }
    else {
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

  List<StudentView> notificationView = [];

  Future getStudentsView(
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
      BuildContext context, String body, String content, List<String> to,
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
          builder: (context) => SmsFormatGuardian(
            toList: selectedSmsList.map((e) => e.studentId).toList(),
            types: type.toString(),
          ),
        ),
      );
    }
  }
}
