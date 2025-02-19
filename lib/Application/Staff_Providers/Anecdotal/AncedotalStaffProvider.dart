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
  bool showDate =false;
  bool includeterminated =false;

  isimportantCheckbox() {
    isimportant = !isimportant;
    notifyListeners();
  }

  isshowdateCheckbox() {
    showDate = !showDate;
    notifyListeners();
  }
  istrminatedCheckbox() {
    includeterminated = !includeterminated;
    notifyListeners();
  }


  //
  isShownToGuardian() {
    showToGuardian = !showToGuardian;
    notifyListeners();
  }

  DateTime? fromdateselect;
  String fromdateDisplay = '';
  String fromdateSend = '';
  DateTime? todateselect;
  String todateDisplay = '';
  String todateSend = '';
  DateTime? currentDate;

  getDateNow() async {

    currentDate = DateTime.now();
    fromdateselect=currentDate;
    todateselect = currentDate;
    fromdateDisplay = DateFormat('dd-MMM-yyyy').format(currentDate!);
    fromdateSend = DateFormat('yyyy-MM-dd').format(currentDate!);
    print("dateDis:  $fromdateDisplay");
    print("dateS:  $fromdateSend");
    todateDisplay = DateFormat('dd-MMM-yyyy').format(currentDate!);
    todateSend = DateFormat('yyyy-MM-dd').format(currentDate!);
    print("dateDis:  $todateDisplay");
    print("dateS:  $todateSend");
    notifyListeners();
  }

  //get date

  getfromDate(BuildContext context) async {
    results.clear();

    fromdateselect = await showDatePicker(
      context: context,
      initialDate: fromdateselect ?? DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
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
    fromdateDisplay = DateFormat('dd-MMM-yyyy').format(fromdateselect!);
    fromdateSend = DateFormat('yyyy-MM-dd').format(fromdateselect!);
    print("dateDisplay:  $fromdateDisplay");
    print("dateSend:  $fromdateSend");
    notifyListeners();
  }
  gettoDate(BuildContext context) async {
    results.clear();
    todateselect = await showDatePicker(
      context: context,
      initialDate: todateselect ?? DateTime.now(),
      firstDate: DateTime(2022),
      lastDate:DateTime.now(),
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
    todateDisplay = DateFormat('dd-MMM-yyyy').format(todateselect!);
    todateSend = DateFormat('yyyy-MM-dd').format(todateselect!);
    print("dateDisplay:  $todateDisplay");
    print("dateSend:  $todateSend");
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
    staffId='';
    staffname='';
    isimportant = false;
    showToGuardian = false;

  }
  String? userName;
  String? userID;
  List<CategorySubjectModel> remarksCategoryList = [];
  List<MultiSelectItem> categorydropDown = [];
  List<CategorySubjectModel> dairySubjectList = [];
  Future getCategorySubject() async {
    remarksCategoryList.clear();
    dairySubjectList.clear();
    SharedPreferences pref = await SharedPreferences.getInstance();
    var parsedResponse =await parseJWT();
    userName= await parsedResponse['StaffName'];
    userID= await parsedResponse['StaffId'];
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
        categorydropDown = remarksCategoryList.map((subjectdata) {
          return MultiSelectItem(subjectdata, subjectdata.text!);
        }).toList();

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
    courseList.clear();
    categorydropDown.clear();
    sectionCounter(0);
    courseCounter(0);
    divisionCounter(0);
    categoryCounter(0);
    notifyListeners();
    results.clear();


    studentViewListReport.clear();

  }


  clearCategory() {
    categorydropDown.clear();
    remarksCategoryList.clear();
    studentViewList.clear();
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
        print(divisiondropDown);
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
  int categoryLen = 0;
  categoryCounter(int len) async {
    categoryLen = 0;
    if (len == 0) {
      categoryLen = 0;
    } else {
      categoryLen = len;
    }

    notifyListeners();
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
  clearStaffList() {
    staffList.clear();
    notifyListeners();
  }
  clearStudList(){
    studentViewListReport.clear();
    notifyListeners();
  }

  int currentPage = 2;
  int? pageSize;
  int? countStud;

  List<StudentViewAnecdotalModel> studentViewList = [];
  Future getStudentViewList(
      String section, String course, String division,String search) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    try {
      var request =


      http.Request(
          'GET',
          Uri.parse(
              '${UIGuide.baseURL}/student-selector?filterStudyingStatus=studying&avoidRelievedStaff=all&name=$search&searchOption=contains&page=1&$section&$course&$division'));

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

  Future getStudentViewByPagination(
      String section, String course, String division) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoading(true);
    print("Paginationnew");
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
        setLoading(true);

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

  //check more Pagination

  bool hasMoreData() {
    final totalCount = countStud;
    print("studentView length :  ${studentViewList.length}");
    notifyListeners();
    return studentViewList.length < totalCount!;
  }

  // ----------------- select all stud
  //

  List allStudentID = [];
  bool allSelected = false;

  selectAll(String section, String course, String division,String search) async {
    if (allSelected == true) {
      allStudentID.clear();
      allSelected = false;
      isselectAll = false;
    } else {
      await getSelectAllStudents(section, course, division,search);
      allSelected = true;
      isselectAll = true;
    }
    notifyListeners();
  }

  Future getSelectAllStudents(
      String section, String course, String division,String search) async {
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
              '${UIGuide.baseURL}/student-selector?filterStudyingStatus=studying&avoidRelievedStaff=all&name=$search&searchOption=contains&page=$currentPage&fetchAllIds=1&$section&$course&$division'));

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

  //Staff list

  List<StaffList> staffList = [];
  List<StaffList> templist1=[];
  String staffname='';
  String staffId='';

  Future getStaffList(
      String name) async {
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
              '${UIGuide.baseURL}/staff-selector?filterStudyingStatus=all&avoidRelievedStaff=all&name=$name&searchOption=contains&page=1'));

      request.headers.addAll(headers);
      print(request);
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        setLoading(true);

        Map<String, dynamic> data =
        jsonDecode(await response.stream.bytesToString());
        print(data);
        templist1 =
        List<StaffList>.from(data["results"]
            .map((x) => StaffList.fromJson(x)));
        staffList.addAll(templist1);

        PaginationStaffView pagenata =
        PaginationStaffView.fromJson(data['pagination']);
        pageSize = pagenata.pageSize;
        countStud = pagenata.count;


        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        print('Error in staffList');
      }
    } catch (e) {
      print('Error in staffList');
      setLoading(false);
    }
  }

  //stafflist by pagination

  Future getStaffListbyPagination(
      String name) async {
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
              '${UIGuide.baseURL}/staff-selector?filterStudyingStatus=all&avoidRelievedStaff=all&name=$name&searchOption=contains&page=$currentPage'));

      request.headers.addAll(headers);
      print(request);
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        setLoadingPage(true);

        Map<String, dynamic> data =
        jsonDecode(await response.stream.bytesToString());
        print(data);
        templist1 =
        List<StaffList>.from(data["results"]
            .map((x) => StaffList.fromJson(x)));
        staffList.addAll(templist1);

        PaginationStaffView pagenata =
        PaginationStaffView.fromJson(data['pagination']);
        pageSize = pagenata.pageSize;
        countStud = pagenata.count;
        currentPage++;
        print(currentPage);


        setLoadingPage(false);
        notifyListeners();
      } else {
        setLoadingPage(false);
        print('Error in staffList');
      }
    } catch (e) {
      print('Error in staffList');
      setLoadingPage(false);
    }
  }

  //staffmore data

  bool hasMoreStaffData() {
    final totalCount = countStud;
    // print("studentView length :  ${studentViewList.length}");
    notifyListeners();
    return staffList.length < totalCount!;
  }

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

  //select staff
  void selectStaff(StaffList model) {
    StaffList selected = staffList
        .firstWhere((element) => element.id == model.id);
    selected.selected ??= false;
    selected.selected = !selected.selected!;
    if (selected.selected == false) {
      isselectAll = false;
    }
    print(selected.toJson());
    notifyListeners();
  }

  //Stud List by pagination

  bool _loadingPage = false;
  bool get loadingPage => _loadingPage;
  setLoadingPage(bool value) {
    _loadingPage = value;
    notifyListeners();
  }


  bool existsInList = false;
  void checkExist(Map<String, dynamic> targetMap,List<Map<String, dynamic>> listOfMaps){

    for (var map in listOfMaps) {
      if (mapsAreEqual(map, targetMap)) {
        existsInList = true;
        break;
      }
    }

  }
  bool mapsAreEqual(Map<String, dynamic> map1, Map<String, dynamic> map2) {
    if (map1.length != map2.length) {
      return false;
    }
    for (var key in map1.keys) {
      if (map1[key] != map2[key]) {
        return false;
      }
    }
    return true;
  }


  //  save anecdotal
  int status = 0;
  String? saveId;
  Future getSaveAnecdotal(String categoryID, String subjectID, String remarks,
      List studList,String staffID, BuildContext context) async {
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
      "createdDate": fromdateSend,
      "time": {"hour": hour, "minute": minute, "second": second},
      "remarks": remarks,
      "isImportant": isimportant,
      "showInGuardianLogin": showToGuardian,
      "studId": studList,
      "studentId": studList,
      "staffId": staffID
    });
    print(
        json.encode({
          "categoryId": categoryID,
          "subject": subjectID,
          "createdDate": fromdateSend,
          "time": {"hour": hour, "minute": minute, "second": second},
          "remarks": remarks,
          "isImportant": isimportant,
          "showInGuardianLogin": showToGuardian,
          "studId": studList,
          "studentId": studList,
          "staffId": staffID
        })
    );

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
      String data =
      jsonDecode(await response.stream.bytesToString());
      saveId= data.toString();
      print("idddddddddddd");
      print(saveId);

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


  //notification

  Future sendanecdotalNotiication(String categoryID, String subjectID, String remarks,
      List studList,String staffID, BuildContext context) async {
    status = 0;
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoadingPage(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    //try {
    var request =
    http.Request('POST', Uri.parse('${UIGuide.baseURL}/anecdotal/sentAnecdotalNotification/$saveId'));
    print(request);
    request.body = json.encode({
      "categoryId": categoryID,
      "subject": subjectID,
      "createdDate": fromdateSend,
      "remarks": remarks,
      "isImportant": isimportant,
      "showInGuardianLogin": showToGuardian,
      "studId": studList,
      "studentId": studList,
      "staffId": staffID
    });
    print(
        json.encode({
          "categoryId": categoryID,
          "subject": subjectID,
          "createdDate": fromdateSend,
          "time": {"hour": hour, "minute": minute, "second": second},
          "remarks": remarks,
          "isImportant": isimportant,
          "showInGuardianLogin": showToGuardian,
          "studId": studList,
          "studentId": studList,
          "staffId": staffID
        })
    );


    request.headers.addAll(headers);
    print(request.body);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print("success");
      setLoadingPage(false);
      notifyListeners();
    } else {
      setLoadingPage(false);
      print('Error in send notification');
    }
  }


  //update

//Update
  Future updateAnecdotal(String id,String categoryID, String subjectID, String remarks,
      String studId,String staffID, BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoadingPage(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    //try {
    var request =
    http.Request('PATCH', Uri.parse('${UIGuide.baseURL}/anecdotal/$id'));
    request.body = json.encode({
      "categoryId": categoryID,
      "subject": subjectID,
      "createdDate": fromdateSend,
      "remarks": remarks,
      "isImportant": isimportant,
      "showInGuardianLogin": showToGuardian,
      "studId": studId,
      "staffId": staffID
    });
    print(
        json.encode({
          "categoryId": categoryID,
          "subject": subjectID,
          "createdDate": fromdateSend,
          "remarks": remarks,
          "isImportant": isimportant,
          "showInGuardianLogin": showToGuardian,
          "studId": studId,
          "staffId": staffID
        })
    );

    request.headers.addAll(headers);
    print(request.body);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200||response.statusCode == 204) {
      setLoadingPage(true);
      await AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          headerAnimationLoop: false,
          title: 'Success',
          desc: 'Updated Successfully',
          btnOkOnPress: () {},
          btnOkIcon: Icons.cancel,
          btnOkColor: Colors.green)
          .show();
      status = 200;

      setLoadingPage(false);
      notifyListeners();
    }
    else {
      setLoadingPage(false);
      print('Error in getSaveAnecdotal stf');
    }

  }
//update

  String? studId;

  String? name;
  String? admNo;
  String? remarks;
  String? date;
  String? time;
  String? category;
  String? categoryId;
  String? subject;
  String? subjectId;
  String? staffid;
  bool? showGuardian;
  bool? isImportant;



  Future getInitialRow(String id) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    var response = await http.get(
        Uri.parse("${UIGuide.baseURL}/anecdotal/getData/$id"),
        headers: headers);
    if (response.statusCode == 200) {
      setLoading(true);
      Map<String, dynamic> data = json.decode(response.body);
      Map<String, dynamic> update = data['updateRow'];

      List<CategorySubjectModel> templist =
      List<CategorySubjectModel>.from(data["category"]
          .map((x) => CategorySubjectModel.fromJson(x)));
      remarksCategoryList.addAll(templist);

      List<CategorySubjectModel> templist2 =
      List<CategorySubjectModel>.from(data["subject"]
          .map((x) => CategorySubjectModel.fromJson(x)));
      dairySubjectList.addAll(templist2);

      UpdateRow ur = UpdateRow.fromJson(update);
      studId =ur.studId;
      staffid= ur.staffId;
      name= ur.studentName;
      category =ur.category;
      categoryId =ur.categoryId;
      subject= ur.subjectName;
      subjectId= ur.subject;
      date =ur.date;
      time=ur.time;
      remarks =ur.remarks;
      showGuardian =ur.showGuardianLogin;
      isImportant=ur.isImportantEntry;
      setLoading(false);
      notifyListeners();
    } else {
      print('Error in getData');
      setLoading(false);
    }
    return response.statusCode;
  }

//Report View
  List<Results> results = [];

  Future getReportView(
      String section,String course,String division,String childIdd,String category,bool important,bool terminated) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoadingPage(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    try {
      var request =


      http.Request(
          'GET',
          Uri.parse(
              '${UIGuide.baseURL}/anecdotalRpt/viewReport/?section=$section&course=$course&division=$division&presentDetailsId=$childIdd&studId=$childIdd&remarks=$category&showImportantOnly=$important&terminatedStudents=$terminated&page=1&'));

      request.headers.addAll(headers);
      print(request);
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        setLoadingPage(true);

        Map<String, dynamic> data =
        jsonDecode(await response.stream.bytesToString());
        // List<dynamic> results = data['results'];
        //
        //
        // for (var result in results) {
        //   List<dynamic> diaryList = result['diaryList'];
        // }
        //
        //
        List<Results> templist =
        List<Results>.from(data["results"]
            .map((x) => Results.fromJson(x)));
        results.addAll(templist);





        PaginationReport pagenata =
        PaginationReport.fromJson(data['pagination']);
        pageSize = pagenata.pageSize;
        countStud = pagenata.count;



        setLoadingPage(false);
        notifyListeners();
      } else {
        setLoadingPage(false);
        print('Error in anecdotalreport');
      }
    } catch (e) {
      print('Error in anecdotalreport');
      setLoadingPage(false);
    }
  }

//by date
  Future getReportViewByDate(
      String section,String course,String division,String childIdd,String category,String fromDate,String toDate,bool important,bool terminated) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoadingPage(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    try {
      var request =


      http.Request(
          'GET',
          Uri.parse(
              '${UIGuide.baseURL}/anecdotalRpt/viewReport/?section=$section&course=$course&division=$division&presentDetailsId=$childIdd&studId=$childIdd&remarks=$category&fromDate=$fromDate&toDate=$toDate&showDate=$showDate&showImportantOnly=$important&terminatedStudents=$terminated&page=1&'));

      request.headers.addAll(headers);
      print(request);
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        setLoadingPage(true);

        Map<String, dynamic> data =
        jsonDecode(await response.stream.bytesToString());
        // List<dynamic> results = data['results'];
        //
        //
        // for (var result in results) {
        //   List<dynamic> diaryList = result['diaryList'];
        // }
        //
        //
        List<Results> templist =
        List<Results>.from(data["results"]
            .map((x) => Results.fromJson(x)));
        results.addAll(templist);





        PaginationReport pagenata =
        PaginationReport.fromJson(data['pagination']);
        pageSize = pagenata.pageSize;
        countStud = pagenata.count;



        setLoadingPage(false);
        notifyListeners();
      } else {
        setLoadingPage(false);
        print('Error in anecdotalreport');
      }
    } catch (e) {
      print('Error in anecdotalreport');
      setLoadingPage(false);
    }
  }

  //

  Future getReportDataByPaginationbyDate(
      String section,String course,String division,String childIdd,String category,String fromDate,String toDate,bool important,bool terminated) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    try {
      var request =


      http.Request(
          'GET',
          Uri.parse(
              '${UIGuide.baseURL}/anecdotalRpt/viewReport/?section=$section&course=$course&division=$division&presentDetailsId=$childIdd&studId=$childIdd&remarks=$category&fromDate=$fromDate&toDate=$toDate&showDate=$showDate&showImportantOnly=$important&terminatedStudents=$terminated&page=$currentPage&'));

      request.headers.addAll(headers);
      print(request);
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        setLoading(true);

        Map<String, dynamic> data =
        jsonDecode(await response.stream.bytesToString());
        // print(data);

        List<Results> templist =
        List<Results>.from(data["results"]
            .map((x) => Results.fromJson(x)));
        results.addAll(templist);


        PaginationReport pagenata =
        PaginationReport.fromJson(data['pagination']);
        pageSize = pagenata.pageSize;
        countStud = pagenata.count;
        currentPage++;
        print(currentPage);

        setLoadingPage(false);
        notifyListeners();
      } else {
        setLoading(false);
        print('Error in getanecdotalList stf');
      }
    } catch (e) {
      print('Error in getanecdotalList stf');
      setLoading(false);
    }
  }



  //
  Future getReportDataByPagination(
      String section,String course,String division,String childIdd,String category,bool important,bool terminated) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    try {
      var request =


      http.Request(
          'GET',
          Uri.parse(
              '${UIGuide.baseURL}/anecdotalRpt/viewReport/?section=$section&course=$course&division=$division&presentDetailsId=$childIdd&studId=$childIdd&remarks=$category&showImportantOnly=$important&terminatedStudents=$terminated&page=$currentPage&'));

      request.headers.addAll(headers);
      print(request);
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        setLoading(true);

        Map<String, dynamic> data =
        jsonDecode(await response.stream.bytesToString());
        // print(data);

        List<Results> templist =
        List<Results>.from(data["results"]
            .map((x) => Results.fromJson(x)));
        results.addAll(templist);


        PaginationReport pagenata =
        PaginationReport.fromJson(data['pagination']);
        pageSize = pagenata.pageSize;
        countStud = pagenata.count;
        currentPage++;
        print(currentPage);

        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        print('Error in getanecdotalList stf');
      }
    } catch (e) {
      print('Error in getanecdotalList stf');
      setLoading(false);
    }
  }

  //check more Pagination

  bool hasMoreReportData() {
    final totalCount = countStud;
    // print("studentView length :  ${studentViewList.length}");
    notifyListeners();
    return results.length < totalCount!;
  }

  //stsudent report view
  String childId='';
  String childName='';

  List<StudentViewAnecdotalModel> studentViewListReport = [];
  Future getStudentReportViewList(
      ) async {
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
              '${UIGuide.baseURL}/student-selector?filterStudyingStatus=all&avoidRelievedStaff=all&searchOption=contains&page=1&'));

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
        studentViewListReport.addAll(templist);

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

  //pagination
  Future getStudentReportViewListBypagination(
      ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoadingPage(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    try {
      var request =

      http.Request(
          'GET',
          Uri.parse(
              '${UIGuide.baseURL}/student-selector?filterStudyingStatus=all&avoidRelievedStaff=all&searchOption=contains&page=$currentPage&'));

      request.headers.addAll(headers);
      print(request);
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        setLoadingPage(true);

        Map<String, dynamic> data =
        jsonDecode(await response.stream.bytesToString());
        print(data);

        List<StudentViewAnecdotalModel> templist =
        List<StudentViewAnecdotalModel>.from(data["results"]
            .map((x) => StudentViewAnecdotalModel.fromJson(x)));
        studentViewListReport.addAll(templist);


        PaginationReport pagenata =
        PaginationReport.fromJson(data['pagination']);
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

  // more data


  bool hasMoreStudentData() {
    final totalCount = countStud;
    // print("studentView length :  ${studentViewList.length}");
    notifyListeners();
    return studentViewListReport.length < totalCount!;
  }

  //by name

  Future getStudentReportViewListByName(
      String name) async {
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
              '${UIGuide.baseURL}/student-selector?filterStudyingStatus=all&avoidRelievedStaff=all&name=$name&searchOption=contains&'));

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
        studentViewListReport.addAll(templist);


        PaginationReport pagenata =
        PaginationReport.fromJson(data['pagination']);
        pageSize = pagenata.pageSize;
        countStud = pagenata.count;
        currentPage++;
        print(currentPage);

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

//category
  clearListcategoryListt() {
    categoryListt.clear();
    notifyListeners();
  }
  int? lastNo;
  List<AnecdotalCategory> categoryListt = [];
  Future<bool> categoryList() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoading(true);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    var request = http.Request('GET',
        Uri.parse('${UIGuide.baseURL}/settings/general/remarksCategory'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print('object');
    if (response.statusCode == 200) {
      setLoading(true);
      List data = jsonDecode(await response.stream.bytesToString());

      //log(data.toString());

      List<AnecdotalCategory> templist = List<AnecdotalCategory>.from(
          data.map((x) => AnecdotalCategory.fromJson(x)));
      categoryListt.addAll(templist);

      lastNo= categoryListt.isEmpty? 1 :categoryListt.last.sortOrder! + 1;

      setLoading(false);
      notifyListeners();
    } else {
      setLoading(false);
      print('Error in category ');
    }
    return true;
  }

  // add category

  Future anecdotalCategorySave(
      BuildContext context,
      String name,
      String sortOrder,
      ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    var request = http.Request('POST',
        Uri.parse('${UIGuide.baseURL}/settings/general/remarksCategory'));
    request.body = json.encode({
      "active": true,
      "name": name,
      "selected": false,
      "sortOrder": sortOrder
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 201) {
      print('Correct______..........______');

      AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          headerAnimationLoop: false,
          title: 'Success',
          desc: 'Uploaded Successfully',
          btnOkOnPress: () {},
          btnOkIcon: Icons.cancel,
          btnOkColor: Colors.green)
          .show();
    }
    else if(response.statusCode == 422){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        duration: Duration(seconds: 1),
        margin: EdgeInsets.only(bottom: 80, left: 30, right: 30),
        behavior: SnackBarBehavior.floating,
        content: Text(
          'Category already exists....',
          textAlign: TextAlign.center,
        ),
      ));
    }
    else {
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
      print('Error Response notice send admin');
    }
  }

  Future anecDotalcategoryDelete(String eventID, BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    var request = http.Request(
        'DELETE',
        Uri.parse(
            '${UIGuide.baseURL}/settings/general/remarksCategory/$eventID'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 204) {
      print(await response.stream.bytesToString());
      print('correct');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        duration: Duration(seconds: 1),
        margin: EdgeInsets.only(bottom: 80, left: 30, right: 30),
        behavior: SnackBarBehavior.floating,
        content: Text(
          'Deleted Successfully',
          textAlign: TextAlign.center,
        ),
      ));
      notifyListeners();
    }
    else if (response.statusCode == 422) {
      print(await response.stream.bytesToString());
      print('correct');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        duration: Duration(seconds: 1),
        margin: EdgeInsets.only(bottom: 80, left: 30, right: 30),
        behavior: SnackBarBehavior.floating,
        content: Text(
          'This Category is being used somewhere else, so cannot be deleted',
          textAlign: TextAlign.center,
        ),
      ));
      notifyListeners();
    }
    else {
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
      print('Error in category delete');
    }
  }

//subjects
  clearListsubjectListt() {
    subjectList.clear();
    notifyListeners();
  }

  List<AnecdotalSubjects> subjectList = [];
  int? subLastno;
  Future<bool> getsubjectList() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoading(true);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    var request = http.Request('GET',
        Uri.parse('${UIGuide.baseURL}/settings/general/diarySubject'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print('object');
    if (response.statusCode == 200) {
      setLoading(true);
      List data = jsonDecode(await response.stream.bytesToString());

      //log(data.toString());

      List<AnecdotalSubjects> templist = List<AnecdotalSubjects>.from(
          data.map((x) => AnecdotalSubjects.fromJson(x)));
      subjectList.addAll(templist);
      subLastno= subjectList.isEmpty? 1 :subjectList.last.sortOrder! + 1;
      setLoading(false);
      notifyListeners();
    } else {
      setLoading(false);
      print('Error in subjects ');
    }
    return true;
  }

  // add category

  Future anecdotalSubjctSave(
      BuildContext context,
      String name,
      String sortOrder,
      ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    var request = http.Request('POST',
        Uri.parse('${UIGuide.baseURL}/settings/general/diarySubject'));
    request.body = json.encode({
      "active": true,
      "name": name,
      "selected": false,
      "sortOrder": sortOrder
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 201) {
      print('Correct______..........______');

      AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          headerAnimationLoop: false,
          title: 'Success',
          desc: 'Uploaded Successfully',
          btnOkOnPress: () {},
          btnOkIcon: Icons.cancel,
          btnOkColor: Colors.green)
          .show();
    }
    else if(response.statusCode == 422){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        duration: Duration(seconds: 1),
        margin: EdgeInsets.only(bottom: 80, left: 30, right: 30),
        behavior: SnackBarBehavior.floating,
        content: Text(
          'Subject already exists....',
          textAlign: TextAlign.center,
        ),
      ));
    }
    else {
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
      print('Error Response notice send admin');
    }
  }

  Future anecDotalSubjectDelete(String eventID, BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    var request = http.Request(
        'DELETE',
        Uri.parse(
            '${UIGuide.baseURL}/settings/general/diarySubject/$eventID'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 204) {
      print(await response.stream.bytesToString());
      print('correct');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        duration: Duration(seconds: 1),
        margin: EdgeInsets.only(bottom: 80, left: 30, right: 30),
        behavior: SnackBarBehavior.floating,
        content: Text(
          'Deleted Successfully',
          textAlign: TextAlign.center,
        ),
      ));
      notifyListeners();
    }
    else if (response.statusCode == 422) {
      print(await response.stream.bytesToString());
      print('correct');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        duration: Duration(seconds: 1),
        margin: EdgeInsets.only(bottom: 80, left: 30, right: 30),
        behavior: SnackBarBehavior.floating,
        content: Text(
          'This Subject is being used somewhere else, so cannot be deleted',
          textAlign: TextAlign.center,
        ),
      ));
      notifyListeners();
    }

    else {
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
      print('Error in category delete');
    }
  }

}
