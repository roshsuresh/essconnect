import 'dart:convert';

import 'package:essconnect/Domain/Admin/Birthday/BirthdayListModel.dart';
import 'package:essconnect/Presentation/Admin/Communication/ToGuardian.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class BirthdayListProviders with ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  clearList() {
    studentBirthdayList.clear();
    classStudentBirthList.clear();
    staffBirthdayList.clear();
    notifyListeners();
  }

  List<StudentBirthdayList> studentBirthdayList = [];
  List<StudentBirthdayList> classStudentBirthList = [];
  List<StaffBirthdayList> staffBirthdayList = [];
  Future getBirthdayList() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };

    try {
      var response = await http.get(
          Uri.parse("${UIGuide.baseURL}/mobileapp/staffdet/birthday_list"),
          headers: headers);

      if (response.statusCode == 200) {
        final data = await json.decode(response.body);
        final stl = data['birthdayList'];

        List<StudentBirthdayList> templist = List<StudentBirthdayList>.from(
            stl["studentBirthdayList"]
                .map((x) => StudentBirthdayList.fromJson(x)));
        studentBirthdayList.addAll(templist);

        List<StudentBirthdayList> templist1 = List<StudentBirthdayList>.from(
            stl["birthdayListforClassTeacher"]
                .map((x) => StudentBirthdayList.fromJson(x)));
        classStudentBirthList.addAll(templist1);

        List<StaffBirthdayList> templist2 = List<StaffBirthdayList>.from(
            stl["staffBirthdayList"].map((x) => StaffBirthdayList.fromJson(x)));
        staffBirthdayList.addAll(templist2);

        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        print("Error in BirthdayList response");
      }
    } catch (e) {
      setLoading(false);
      print(e);
      print("Error in BirthdayList response");
    }
  }

  void selectItem(StudentBirthdayList model) {
    StudentBirthdayList selected = studentBirthdayList
        .firstWhere((element) => element.studentId == model.studentId);
    selected.selectedStud ??= false;
    selected.selectedStud = !selected.selectedStud!;
    print(selected.toJson());

    notifyListeners();
  }

  void selectStudByClass(StudentBirthdayList model) {
    StudentBirthdayList selected = classStudentBirthList
        .firstWhere((element) => element.studentId == model.studentId);
    selected.selectedStud ??= false;
    selected.selectedStud = !selected.selectedStud!;
    print(selected.toJson());

    notifyListeners();
  }

  List<StudentBirthdayList> selectedStudList = [];
  submitStudent(BuildContext context) {
    selectedStudList.clear();
    if (toggleVal == 'classTeacher') {
      selectedStudList = classStudentBirthList
          .where((element) => element.selectedStud == true)
          .toList();
    } else {
      selectedStudList = studentBirthdayList
          .where((element) => element.selectedStud == true)
          .toList();
    }
    if (selectedStudList.isEmpty) {
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
      print(studentBirthdayList
          .where((element) => element.selectedStud == true)
          .toList());
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Text_Matter_NotificationAdmin(
              toList: selectedStudList.map((e) => e.studentId!).toList(),
              type: "Student",
            ),
          ));
    }
  }

  // Staff notification

  void selectStaff(StaffBirthdayList model) {
    StaffBirthdayList selected = staffBirthdayList
        .firstWhere((element) => element.staffId == model.staffId);
    selected.selectedStaff ??= false;
    selected.selectedStaff = !selected.selectedStaff!;
    print(selected.toJson());

    notifyListeners();
  }

  List<StaffBirthdayList> selectedStaffList = [];
  submitStaff(BuildContext context) {
    selectedStaffList.clear();
    selectedStaffList = staffBirthdayList
        .where((element) => element.selectedStaff == true)
        .toList();
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
          'Select any staff...',
          textAlign: TextAlign.center,
        ),
      ));
    }
    //
    else {
      print('selected.....');
      print(staffBirthdayList
          .where((element) => element.selectedStaff == true)
          .toList());
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Text_Matter_NotificationAdmin(
            toList: selectedStaffList.map((e) => e.staffId!).toList(),
            type: "Staff",
          ),
        ),
      );
    }
  }

  String toggleVal = 'all';
  int indval = 0;
  onToggleChanged(int ind) {
    if (ind == 0) {
      toggleVal = 'all';
      indval = ind;
      print(toggleVal);
      notifyListeners();
    } else {
      toggleVal = 'classTeacher';
      print(toggleVal);
      indval = ind;
      notifyListeners();
    }
  }
}
