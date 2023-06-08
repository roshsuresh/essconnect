import 'dart:convert';
import 'dart:developer';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:essconnect/Domain/Staff/ToGuardian.dart';
import 'package:essconnect/Presentation/Staff/ToGuardian.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationToGuardian_Providers with ChangeNotifier {
  List<CommunicationToGuardian_course> selectedCourse = [];

  String filtersDivision = "";
  String filterCourse = "";

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

//course List
  addSelectedCourse(CommunicationToGuardian_course item) {
    if (selectedCourse.contains(item)) {
      print("removing");
      selectedCourse.remove(item);
      notifyListeners();
    } else {
      print("adding");
      selectedCourse.add(item);
      notifyListeners();
    }
    clearAllFilters();
    addFilterCourse(selectedCourse.first.text!);
  }

  removeCourse(CommunicationToGuardian_course item) {
    selectedCourse.remove(item);
    notifyListeners();
  }

  removeCourseAll() {
    selectedCourse.clear();
  }

  isCourseSelected(CommunicationToGuardian_course item) {
    if (selectedCourse.contains(item)) {
      return true;
    } else {
      return false;
    }
  }

  courseClear() {
    communicationToGuardianInitialValues.clear();
  }

  List<CommunicationToGuardian_course> communicationToGuardianInitialValues =
      [];
  bool? isClassTeacher;

  Future communicationToGuardianCourseStaff() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };

    var response = await http.get(
        Uri.parse(
            "${UIGuide.baseURL}/mobileapp/staffdet/noticeBoard/initialValues"),
        headers: headers);

    try {
      if (response.statusCode == 200) {
        print("corect");
        final data = json.decode(response.body);

        Map<String, dynamic> smsiniti = await data['initialValues'];

        List<CommunicationToGuardian_course> templist =
            List<CommunicationToGuardian_course>.from(smsiniti["courseList"]
                .map((x) => CommunicationToGuardian_course.fromJson(x)));
        communicationToGuardianInitialValues.addAll(templist);
        print(data);
        NotificationToGuardian_initialValues att =
            NotificationToGuardian_initialValues.fromJson(
                data['initialValues']);

        isClassTeacher = att.isClassTeacher;

        notifyListeners();
      } else {
        print("Error in Notifi_toguard_course response");
      }
    } catch (e) {
      print(e);
    }
  }

// Division
  List<CommunicationToGuardian_Division> selectedDivision = [];

  addSelectedDivision(CommunicationToGuardian_Division item) {
    if (selectedDivision.contains(item)) {
      print("removing");
      selectedDivision.remove(item);
      notifyListeners();
    } else {
      print("adding");
      selectedDivision.add(item);
      notifyListeners();
    }
  }

  removeDivision(CommunicationToGuardian_Division item) {
    selectedDivision.remove(item);
    notifyListeners();
  }

  removeDivisionAll() {
    selectedDivision.clear();
    notifyListeners();
  }

  isDivisonSelected(CommunicationToGuardian_Division item) {
    if (selectedDivision.contains(item)) {
      return true;
    } else {
      return false;
    }
  }

  divisionClear() {
    notificationDivisionList.clear();
  }

  List<CommunicationToGuardian_Division> notificationDivisionList = [];
  Future<bool> communicationToGuardianDivisionStaff(String courseId) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            '${UIGuide.baseURL}/mobileapp/staffdet/noticeboard/divisions/$courseId'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Map<String, dynamic> data =
          jsonDecode(await response.stream.bytesToString());

      log(data.toString());

      List<CommunicationToGuardian_Division> templist =
          List<CommunicationToGuardian_Division>.from(data["divisions"]
              .map((x) => CommunicationToGuardian_Division.fromJson(x)));
      notificationDivisionList.addAll(templist);
      print('correct');
      notifyListeners();
    } else {
      print('Error in staff_toGuard_notifi_DivisionList ');
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
      print('Error in notificationView stf');
    }
    return true;
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
    print(_pref.getString('accesstoken'));
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
      //       'Notification Sent Successfully',
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
}
