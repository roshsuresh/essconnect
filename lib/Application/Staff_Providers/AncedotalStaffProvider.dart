import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:essconnect/Constants.dart';
import 'package:essconnect/Domain/Staff/Anecdotal/InitialSelectionModel.dart';
import 'package:essconnect/Domain/Staff/Anecdotal/StudListviewAnectdotal.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AnecdotalStaffProviders with ChangeNotifier {
  bool isimportant = false;
  bool showToGuardian = false;

  isimportantCheckbox() {
    isimportant = !isimportant;
    notifyListeners();
  }

  //
  isShownToGuardian() {
    showToGuardian = !showToGuardian;
    notifyListeners();
  }

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
    notifyListeners();
  }

  DateTime _currentTime = DateTime.now();
  late Timer _timer;
  int? hour;
  int? minute;
  int? second;
  String get formattedTime => DateFormat('hh:mm a').format(_currentTime);

  timeModel() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _currentTime = DateTime.now();
      hour = _currentTime.hour;
      minute = _currentTime.minute;
      second = _currentTime.second;

      notifyListeners();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  //  category --  subject List

  clearInitial() {
    remarksCategoryList.clear();
    dairySubjectList.clear();
    finalSelectedList.clear();
  }

  List<CategorySubjectModel> remarksCategoryList = [];
  List<CategorySubjectModel> dairySubjectList = [];
  Future getCategorySubject() async {
    remarksCategoryList.clear();
    dairySubjectList.clear();
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    try {
      var response = await http.get(
          Uri.parse("${UIGuide.baseURL}/anecdotal/initialvalues"),
          headers: headers);

      if (response.statusCode == 200) {
        print("corect");
        setLoading(true);
        final data = json.decode(response.body);

        List<CategorySubjectModel> templist = List<CategorySubjectModel>.from(
            data["category"].map((x) => CategorySubjectModel.fromJson(x)));
        remarksCategoryList.addAll(templist);

        List<CategorySubjectModel> templist1 = List<CategorySubjectModel>.from(
            data["subject"].map((x) => CategorySubjectModel.fromJson(x)));
        dairySubjectList.addAll(templist1);

        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        print("Error in getCategorySubject response");
      }
    } catch (e) {
      print("Error in getCategorySubject response");
      setLoading(false);
      print(e);
    }
  }

  clearAllDetails() {
    sectiondropDown.clear();
    sectionInitialValues.clear();
    divisiondropDown.clear();
    divisionList.clear();
    coursedropDown.clear();
    courseList.clear();
    studentViewList.clear();
    sectionCounter(0);
    courseCounter(0);
    divisionCounter(0);
    notifyListeners();
  }

  clearCourse() {
    coursedropDown.clear();
    courseList.clear();
    studentViewList.clear();
    notifyListeners();
  }

  clearDivision() async {
    divisiondropDown.clear();
    divisionList.clear();
    studentViewList.clear();
    notifyListeners();
  }

  List<SectionsModel> sectionInitialValues = [];
  List<MultiSelectItem> sectiondropDown = [];
  Future getSectionInitial() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    try {
      var response = await http.get(
          Uri.parse(
              "${UIGuide.baseURL}/student-selector/student-selector-search-options"),
          headers: headers);

      if (response.statusCode == 200) {
        print("corect");
        setLoading(true);
        final data = json.decode(response.body);

        List<SectionsModel> templist = List<SectionsModel>.from(
            data["sections"].map((x) => SectionsModel.fromJson(x)));
        sectionInitialValues.addAll(templist);
        sectiondropDown = sectionInitialValues.map((subjectdata) {
          return MultiSelectItem(subjectdata, subjectdata.name!);
        }).toList();
        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        print("Error in section response");
      }
    } catch (e) {
      setLoading(false);
      print(e);
    }
  }

  //Course

  List<SectionsModel> courseList = [];
  List<MultiSelectItem> coursedropDown = [];
  Future getCourseList(String section) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    try {
      var response = await http.get(
          Uri.parse(
              "${UIGuide.baseURL}/student-selector/courses-custom/$section"),
          headers: headers);

      if (response.statusCode == 200) {
        print("corect");
        setLoading(true);
        final data = json.decode(response.body);
        log(data.toString());

        List<SectionsModel> templist = List<SectionsModel>.from(
            data.map((x) => SectionsModel.fromJson(x)));
        courseList.addAll(templist);
        coursedropDown = courseList.map((subjectdata) {
          return MultiSelectItem(subjectdata, subjectdata.name!);
        }).toList();
        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        print("Error in course response");
      }
    } catch (e) {
      setLoading(false);
      print(e);
    }
  }

  //Division

  List<SectionsModel> divisionList = [];
  List<MultiSelectItem> divisiondropDown = [];
  Future getDivisionList(String course) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    try {
      var response = await http.get(
          Uri.parse(
              "${UIGuide.baseURL}/student-selector/student-selector-search-options?$course"),
          headers: headers);

      if (response.statusCode == 200) {
        print("corect");
        setLoading(true);
        final data = json.decode(response.body);
        log(data.toString());

        List<SectionsModel> templist = List<SectionsModel>.from(
            data.map((x) => SectionsModel.fromJson(x)));
        divisionList.addAll(templist);
        divisiondropDown = divisionList.map((subjectdata) {
          return MultiSelectItem(subjectdata, subjectdata.name!);
        }).toList();
        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        print("Error in division response");
      }
    } catch (e) {
      setLoading(false);
      print(e);
    }
  }

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

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  clearStudentViewList() {
    studentViewList.clear();
    notifyListeners();
  }

  int currentPage = 2;
  int? pageSize;
  int? countStud;

  List<StudentViewAnecdotalModel> studentViewList = [];
  Future getStudentViewList(
      String section, String course, String division) async {
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
              '${UIGuide.baseURL}/student-selector?filterStudyingStatus=studying&avoidRelievedStaff=all&searchOption=contains&page=1&$section&$course&$division'));

      request.headers.addAll(headers);
      print(request);
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        setLoading(true);

        Map<String, dynamic> data =
            jsonDecode(await response.stream.bytesToString());
        print(data);

        List<StudentViewAnecdotalModel> templist =
            List<StudentViewAnecdotalModel>.from(data["results"]
                .map((x) => StudentViewAnecdotalModel.fromJson(x)));
        studentViewList.addAll(templist);

        PaginationStudentView pagenata =
            PaginationStudentView.fromJson(data['pagination']);
        pageSize = pagenata.pageSize;
        countStud = pagenata.count;

        print(countStud);

        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        print('Error in getStudentViewList stf');
      }
    } catch (e) {
      print('Error in getStudentViewList stf');
      setLoading(false);
    }
  }

  // ----------------- select all stud
  //

  List allStudentID = [];
  bool allSelected = false;

  selectAll(String section, String course, String division) async {
    if (allSelected == true) {
      allStudentID.clear();
      allSelected = false;
      isselectAll = false;
    } else {
      await getSelectAllStudents(section, course, division);
      allSelected = true;
      isselectAll = true;
    }
    notifyListeners();
  }

  Future getSelectAllStudents(
      String section, String course, String division) async {
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
              '${UIGuide.baseURL}/student-selector?filterStudyingStatus=studying&avoidRelievedStaff=all&searchOption=contains&page=$currentPage&fetchAllIds=1&$section&$course&$division'));

      request.headers.addAll(headers);
      print(request);
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        setLoading(true);
        allStudentID.clear();

        var data = jsonDecode(await response.stream.bytesToString());
        print(data);
        allStudentID = data;
        // allSelected = true;
        print(allStudentID.length);

        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        print('Error in getSelectAllStudents stf');
      }
    } catch (e) {
      print('Error in getSelectAllStudents stf');
      setLoading(false);
    }
  }

  //Select Student

  void selectItem(StudentViewAnecdotalModel model) {
    StudentViewAnecdotalModel selected =
        studentViewList.firstWhere((element) => element.admNo == model.admNo);
    selected.selected ??= false;
    selected.selected = !selected.selected!;
    if (selected.selected == false) {
      isselectAll = false;
    }
    print(selected.toJson());
    notifyListeners();
  }

  bool isselectAll = false;
  // void selectAll() {
  //   if (studentViewList.first.selected == true) {
  //     for (var element in studentViewList) {
  //       element.selected = false;
  //     }
  //     isselectAll = false;
  //   } else {
  //     for (var element in studentViewList) {
  //       element.selected = true;
  //     }
  //     isselectAll = true;
  //   }
  //   notifyListeners();
  // }

  List<StudentViewAnecdotalModel> selectedList = [];
  List finalSelectedList = [];
  submitStudent(BuildContext context) {
    finalSelectedList.clear();
    if (allSelected == true) {
      finalSelectedList = allStudentID;
      Navigator.pop(context);
      print("finalSelectedList  -----   $finalSelectedList");
    } else {
      selectedList.clear();
      selectedList =
          studentViewList.where((element) => element.selected == true).toList();
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
        print(studentViewList
            .where((element) => element.selected == true)
            .toList());
        finalSelectedList = selectedList.map((e) => e.id).toList();
        Navigator.pop(context);
        print("finalSelectedList-single  -----   $finalSelectedList");
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => Text_Matter_Notification(
        //         toList: selectedList.map((e) => e.studentId).toList(),
        //         type: "Student",
        //       ),
        //     ));
      }
    }
    notifyListeners();
  }

  //Stud List by pagination

  bool _loadingPage = false;
  bool get loadingPage => _loadingPage;
  setLoadingPage(bool value) {
    _loadingPage = value;
    notifyListeners();
  }

  Future getStudentViewByPagination(
      String section, String course, String division) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoadingPage(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    try {
      var request = http.Request(
          'GET',
          Uri.parse(
              '${UIGuide.baseURL}/student-selector?filterStudyingStatus=studying&avoidRelievedStaff=all&searchOption=contains&page=$currentPage&$section&$course&$division'));

      request.headers.addAll(headers);
      print(request);
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        setLoadingPage(true);

        Map<String, dynamic> data =
            jsonDecode(await response.stream.bytesToString());
        // print(data);
        List<StudentViewAnecdotalModel> templist =
            List<StudentViewAnecdotalModel>.from(data["results"]
                .map((x) => StudentViewAnecdotalModel.fromJson(x)));
        studentViewList.addAll(templist);
        PaginationStudentView pagenata =
            PaginationStudentView.fromJson(data['pagination']);
        pageSize = pagenata.pageSize;
        countStud = pagenata.count;
        currentPage++;
        print(currentPage);

        setLoadingPage(false);
        notifyListeners();
      } else {
        setLoadingPage(false);
        print('Error in getStudentViewList stf');
      }
    } catch (e) {
      print('Error in getStudentViewList stf');
      setLoadingPage(false);
    }
  }

  //check more Pagination

  bool hasMoreData() {
    final totalCount = countStud;
    // print("studentView length :  ${studentViewList.length}");
    notifyListeners();
    return studentViewList.length < totalCount!;
  }

  //  save anecdotal
  int status = 0;
  Future getSaveAnecdotal(String categoryID, String subjectID, String remarks,
      List studList, BuildContext context) async {
    status = 0;
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoadingPage(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    //try {
    var request =
        http.Request('POST', Uri.parse('${UIGuide.baseURL}/anecdotal/create'));
    request.body = json.encode({
      "categoryId": categoryID,
      "subject": subjectID,
      "createdDate": dateSend,
      "time": {"hour": hour, "minute": minute, "second": second},
      "remarks": remarks,
      "isImportant": isimportant,
      "showInGuardianLogin": showToGuardian,
      "studId": studList,
      "studentId": studList,
      "staffId": null
    });

    request.headers.addAll(headers);
    print(request.body);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      setLoadingPage(true);
      await AwesomeDialog(
              context: context,
              dialogType: DialogType.success,
              animType: AnimType.rightSlide,
              headerAnimationLoop: false,
              title: 'Success',
              desc: 'Saved Successfully',
              btnOkOnPress: () {},
              btnOkIcon: Icons.cancel,
              btnOkColor: Colors.green)
          .show();
      status = 200;

      setLoadingPage(false);
      notifyListeners();
    } else if (response.statusCode == 422) {
      snackbarWidget(3, 'Remarks already exists.', context);
    } else {
      setLoadingPage(false);
      print('Error in getSaveAnecdotal stf');
    }
    // } catch (e) {
    //   print(e.hashCode);
    //   snackbarWidget(2, "Somethin went wrong", context);
    //   print('Error in getSaveAnecdotal stf----------');
    //   setLoadingPage(false);
    // }
  }
}
