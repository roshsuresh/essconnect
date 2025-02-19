import 'dart:convert';
import 'dart:developer';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../Constants.dart';
import '../../Domain/Staff/StaffAttandenceModel.dart';
import '../../utils/constants.dart';

Map? staffAttendeceRespo;
List? attendecourse;

class AttendenceStaffProvider with ChangeNotifier {
  DateTime? dateselect;
  String dateDisplay = '';
  String dateSend = '';
  DateTime? currentDate;

  getDateNow() async {
    currentDate = DateTime.now();
    dateDisplay = DateFormat('dd-MMM-yyyy').format(currentDate!);
    dateSend = DateFormat('yyyy-MM-dd').format(currentDate!);
    print("dateDis:  $dateDisplay");
    print("dateS:  $dateSend");
    notifyListeners();
  }

  //get date

  getDate(BuildContext context) async {
    dateselect = await showDatePicker(
      context: context,
      initialDate: dateselect ?? DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: UIGuide.light_Purple,
              colorScheme: const ColorScheme.light(
                primary: UIGuide.light_Purple,
              ),
              buttonTheme:
                  const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child!);
      },
    );
    dateDisplay = DateFormat('dd-MMM-yyyy').format(dateselect!);
    dateSend = DateFormat('yyyy-MM-dd').format(dateselect!);
    print("dateDisplay:  $dateDisplay");
    print("dateSend:  $dateSend");
    studentsAttendenceView.clear();
    notifyListeners();
  }

  List<AttendenceCourse> selectedCourse = [];

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
  addSelectedCourse(AttendenceCourse item) {
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

  removeCourse(AttendenceCourse item) {
    selectedCourse.remove(item);
    notifyListeners();
  }

  removeCourseAll() {
    selectedCourse.clear();
  }

  isCourseSelected(AttendenceCourse item) {
    if (selectedCourse.contains(item)) {
      return true;
    } else {
      return false;
    }
  }

  courseClear() {
    attendenceInitialValues.clear();
  }

  List<AttendenceCourse> attendenceInitialValues = [];
  bool? isClassTeacher;
  bool? isDualAttendance;
  bool? smsLinkAttendance;

  bool _load = false;
  bool get load => _load;
  setLoad(bool value) {
    _load = value;
    notifyListeners();
  }

  Future attendenceCourseStaff() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoad(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    var response = await http.get(
        Uri.parse("${UIGuide.baseURL}/mobileapp/staff/AttendenceInitialvalues"),
        headers: headers);
    try {
      if (response.statusCode == 200) {
        setLoad(true);
        //  print("corect");
        final data = json.decode(response.body);

        //  print(data);
        staffAttendeceRespo = data['attendenceinitvalues'];
        Attendenceinitvalues att =
            Attendenceinitvalues.fromJson(data['attendenceinitvalues']);
        isClassTeacher = att.isClassTeacher;
        isDualAttendance = att.isDualAttendance;
        smsLinkAttendance=att.smsLinkAttendance;
        attendecourse = staffAttendeceRespo!['course'];
        print(attendecourse);
        print(isClassTeacher);
        setLoad(false);
        notifyListeners();
      } else {
        setLoad(false);
        print("Error in attendencecourse response");
      }
    } catch (e) {
      setLoad(false);
      print(e);
    }
  }

// Division
  List<AttendenceDivisions> selectedDivision = [];

  addSelectedDivision(AttendenceDivisions item) {
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

  removeDivision(AttendenceDivisions item) {
    selectedDivision.remove(item);
    notifyListeners();
  }

  removeDivisionAll() {
    selectedDivision.clear();
    notifyListeners();
  }

  isDivisonSelected(AttendenceDivisions item) {
    if (selectedDivision.contains(item)) {
      return true;
    } else {
      return false;
    }
  }

  divisionClear() {
    attendenceDivisionList.clear();
  }

  bool _loadDivision = false;
  bool get loadDivision => _loadDivision;
  setLoadDivision(bool value) {
    _loadDivision = value;
    notifyListeners();
  }

  List<AttendenceDivisions> attendenceDivisionList = [];
  Future<bool> getAttendenceDivisionValues(String id) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoadDivision(true);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    var request = http.Request('GET',
        Uri.parse('${UIGuide.baseURL}/mobileapp/staff/AttendenceDivision/$id'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      setLoadDivision(true);
      Map<String, dynamic> data =
          jsonDecode(await response.stream.bytesToString());

      log(data.toString());

      List<AttendenceDivisions> templist = List<AttendenceDivisions>.from(
          data["divisions"].map((x) => AttendenceDivisions.fromJson(x)));
      attendenceDivisionList.addAll(templist);
      print('correct');
      setLoadDivision(false);
      notifyListeners();
    } else {
      setLoadDivision(false);
      print('Error in AttendenceDivisionList stf');
    }
    setLoadDivision(false);
    return true;
  }

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  //view Attendence
  String? forattt;
  String? aftattt;
  attendView() {
    forattt;
    aftattt;
    notifyListeners();
  }

  List<StudentsAttendenceView_stf> studentsAttendenceView = [];
  bool? attandance_disable;
  Future<bool> getstudentsAttendenceView(BuildContext context,String date, String id) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            '${UIGuide.baseURL}/mobileapp/staff/AttendenceView?attendanceDate=$date&divisionId=$id'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print(request);

    if (response.statusCode == 200) {
      setLoading(true);
      Map<String, dynamic> data =
          jsonDecode(await response.stream.bytesToString());
      StudentAttendance sdt = StudentAttendance.fromJson(data);
      attandance_disable = sdt.isDisabled;
      print("isdissabled");
      print(attandance_disable);
      List<StudentsAttendenceView_stf> templist =
          List<StudentsAttendenceView_stf>.from(data["studentsAttendenceView"]
              .map((x) => StudentsAttendenceView_stf.fromJson(x)));
      studentsAttendenceView.addAll(templist);
if(studentsAttendenceView.isEmpty){
  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    elevation: 10,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
    duration: Duration(seconds: 1),
    margin: EdgeInsets.only(bottom: 80, left: 30, right: 30),
    behavior: SnackBarBehavior.floating,
    content: Text(
      'No data for specified condition',
      textAlign: TextAlign.center,
    ),
  ));
}
      setLoading(false);
      notifyListeners();
    } else {
      setLoading(false);
      print('Error in AttendenceView stf');
    }
    return true;
  }

  // bool _loadingg = false;
  // bool get loadingg => _loadingg;
  // setLoadingg(bool value) {
  //   _loadingg = value;
  //   notifyListeners();
  // }
  //save

  Future attendanceSave(BuildContext context, List finallList, String date,
      int forecount, int aftcount) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);
    // setLoadinggNull(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };

    var request = http.Request('POST',
        Uri.parse('${UIGuide.baseURL}/mobileapp/staff/saveattendance/$date'));
    print(request);
    request.body = json.encode(finallList);

    log("finalelist      $finallList".toString());
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    setLoading(true);
    if (response.statusCode == 200) {
      setLoading(true);
      //  setLoadinggNull(true);
      print('Correct........______________________________');
      print(await response.stream.bytesToString());
      await AwesomeDialog(
              dismissOnTouchOutside: false,
              dismissOnBackKeyPress: false,
              context: context,
              dialogType: DialogType.success,
              animType: AnimType.rightSlide,
              headerAnimationLoop: false,
              title: 'Saved',
              desc: isDualAttendance == true
                  ? 'Absentees in ForeNoon  : $forecount \nAbsentees in AfterNoon : $aftcount'
                  : 'No.of Absentees : $forecount',
              btnOkOnPress: () async {
                await clearStudentList();
              },
              btnOkColor: Colors.green)
          .show();

      setLoading(false);
      //  setLoadinggNull(false);
      notifyListeners();
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
      // setLoadinggNull(false);
      print('Error Response in attendance');
    }
  }
  //delete

  // bool _loadinggDelete = false;
  // bool get loadinggDelete => _loadinggDelete;
  // setLoadinggDelete(bool value) {
  //   _loadinggDelete = value;
  //   notifyListeners();
  // }

  // bool _loadinggNull = false;
  // bool get loadinggNull => _loadinggNull;
  // setLoadinggNull(bool value) {
  //   _loadinggNull = value;
  //   notifyListeners();
  // }

  Future attendanceDelete(
      String divisionid, String date, BuildContext context) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);
    // setLoadinggNull(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    var request = http.Request(
        'DELETE',
        Uri.parse(
            '${UIGuide.baseURL}/mobileapp/staff/deleteAttendence/?attendanceDate=$date&divisionId=$divisionid'));
    request.headers.addAll(headers);
    print(request);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      setLoading(true);
      // setLoadinggNull(true);
      print(await response.stream.bytesToString());
      print('correct');
      snackbarWidget(2, "Deleted Successfully", context);
      await clearStudentList();
      setLoading(false);
      // setLoadinggNull(false);
      notifyListeners();
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
          'No data to delete....',
          textAlign: TextAlign.center,
        ),
      ));
      setLoading(false);
      // setLoadinggNull(false);
      print('Error in noticeDelete stf');
    }
  }

  clearStudentList() {
    setLoading(true);
    studentsAttendenceView.clear();
    setLoading(false);
    notifyListeners();
  }
  //single attendence

  // bool isSelected(StudentsAttendenceView_stf model) {
  //   StudentsAttendenceView_stf selected = studentsAttendenceView
  //       .firstWhere((element) => element.admNo == model.admNo);
  //   return selected.select!;
  // }

  //submit

  List<StudentsAttendenceView_stf> selectedList = [];
  submitStudent(BuildContext context) {
    selectedList.clear();
    selectedList = studentsAttendenceView
        .where((element) => element.select == true)
        .toList();
    if (studentsAttendenceView
        .where((element) => element.select == true)
        .toList()
        .isNotEmpty) {
      print('Attendence');
      print(studentsAttendenceView.where((element) => element.select == true));
    }
    // if (selectedList.isEmpty) {
    //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    //     content: Text('Select Any Student..'),
    //     duration: Duration(seconds: 1),
    //   ));
    // } else {
    //   print('selected.....');
    //   print(studentsAttendenceView
    //       .where((element) => element.select == true)
    //       .toList());
    // }
  }

  //dual attendence
  bool isSelect(StudentsAttendenceView_stf model) {
    StudentsAttendenceView_stf selected = studentsAttendenceView
        .firstWhere((element) => element.admNo == model.admNo);
    return selected.selectedd!;
  }

  void selectItemm(StudentsAttendenceView_stf model) {
    StudentsAttendenceView_stf selected = studentsAttendenceView
        .firstWhere((element) => element.admNo == model.admNo);
    selected.selectedd ??= false;
    selected.selectedd = !selected.selectedd!;
    print(selected.toJson());
    notifyListeners();
  }

  // DateTime? _mydatetime;
  // String? timeNew;

  // String? timee = DateFormat('yyyy-MM-dd').format(DateTime.now());

  // getDate(BuildContext context) async {
  //   _mydatetime = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(2020),
  //     lastDate: DateTime(2100),
  //     builder: (context, child) {
  //       return Theme(
  //           data: ThemeData.light().copyWith(
  //             primaryColor: UIGuide.light_Purple,
  //             colorScheme: const ColorScheme.light(
  //               primary: UIGuide.light_Purple,
  //             ),
  //             buttonTheme:
  //                 const ButtonThemeData(textTheme: ButtonTextTheme.primary),
  //           ),
  //           child: child!);
  //     },
  //   );

  //   timeNew = DateFormat('yyyy-MM-dd').format(_mydatetime!) == null
  //       ? timee
  //       : DateFormat('yyyy-MM-dd').format(_mydatetime!).toString();
  //   timee = DateFormat('yyyy-MM-dd').format(DateTime.now());
  //   print(timeNew);

  //   print(_mydatetime);
  //   notifyListeners();
  // }
}
