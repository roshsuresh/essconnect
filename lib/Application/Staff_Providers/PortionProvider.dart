
import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../Domain/Staff/PortionModel.dart';
import '../../utils/constants.dart';

class PortionProvider with ChangeNotifier{

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  bool _loadingPage = false;
  bool get loadingPage => _loadingPage;
  setLoadingPage(bool value) {
    _loadingPage = value;
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
    //results.clear();

    fromdateselect = await showDatePicker(
      context: context,
      initialDate: fromdateselect ?? DateTime.now(),
      firstDate: DateTime(2022),
      lastDate:DateTime(9999, 12, 31),
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
    reportView.clear();
    notifyListeners();
  }

  gettoDate(BuildContext context) async {
   // results.clear();
    todateselect = await showDatePicker(
      context: context,
      initialDate: todateselect ?? DateTime.now(),
      firstDate: DateTime(2022),
      lastDate:DateTime(9999, 12, 31),
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
    reportView.clear();
    notifyListeners();
  }
  DateTime _currentTime = DateTime.now();
  late Timer _timer;
  int? hour;
  int? minute;
  int? second;
  String get formattedTime => DateFormat('hh:mm a').format(_currentTime);

  timeModel() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _currentTime = DateTime.now();
      hour = _currentTime.hour;
      minute = _currentTime.minute;
      second = _currentTime.second;

      notifyListeners();
    });
  }

  clearAllDetails() {

    divisiondropDown.clear();
    divisionListApproval.clear();
    courseList.clear();
    studentViewList.clear();
    subjectListApproval.clear();
    subjectdropDown.clear();
    divisionCounter(0);
    subjectCounter(0);
    reportView.clear();
    notifyListeners();

    //studentViewListReport.clear();

  }

  clearInitial() {
    courseList.clear();
    divisionList.clear();
    finalSelectedList.clear();
      subjectList.clear();
      subSubjectList.clear();
      portionList.clear();
     // file.clear();
      mobFile.clear();
      approvecourseList.clear();
      divisionListApproval.clear();
      subjectListApproval.clear();

  }
  clearStudentList() {
  studentViewList.clear();
  notifyListeners();

  }

  List<PortionCourse> courseList = [];
  String? isApproval;
  String? isClassTeacher;
  Future getPortionCourse() async {

    SharedPreferences _pref = await SharedPreferences.getInstance();

    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('curiaccesstoken')}'
    };
    try {
      var response = await http.get(
          Uri.parse("${UIGuide.curriculamUrl}/homeworkentry/initialvalues"),
          headers: headers);

      if (response.statusCode == 200) {
        print("corect");
        setLoading(true);
        final data = json.decode(response.body);
        print(data);
        PortionInitial portion = PortionInitial.fromJson(data);

        List<PortionCourse> templist = List<PortionCourse>.from(
            data['staffDivisionList']["course"].map((x) => PortionCourse.fromJson(x)));
        courseList.addAll(templist);

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

    List<PortionDivisions> divisionList=[];
    Future getDivisionList(String course) async {
      SharedPreferences _pref = await SharedPreferences.getInstance();
      setLoading(true);
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${_pref.getString('curiaccesstoken')}'
      };
      try {
        var response = await http.get(
            Uri.parse(
                "${UIGuide.curriculamUrl}/homeworkentry/divisions/$course"),
            headers: headers);

        if (response.statusCode == 200) {
          print("corect");
          setLoading(true);
          final data = json.decode(response.body);
          log(data.toString());

          List<PortionDivisions> templist = List<PortionDivisions>.from(
              data["divisions"].map((x) => PortionDivisions.fromJson(x)));
          divisionList.addAll(templist);
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

  List<PortionSubjects> subjectList=[];
  Future getSubjectList(String division) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('curiaccesstoken')}'
    };
    try {
      var response = await http.get(
          Uri.parse(
              "${UIGuide.curriculamUrl}/homeworkentry/subjects/$division"),
          headers: headers);

      if (response.statusCode == 200) {
        print("corect");
        setLoading(true);
        final data = json.decode(response.body);
        log(data.toString());

        List<PortionSubjects> templist = List<PortionSubjects>.from(
            data["subjects"].map((x) => PortionSubjects.fromJson(x)));
        subjectList.addAll(templist);
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

  //subsubject/optional list
  List<PortionSubSubject> subSubjectList=[];
  Future getsubSubjectList(String subjectId,String subject,String option,String subsubjectiD,String coursesubjectId,String divisionId) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('curiaccesstoken')}'
    };
    try {
      var response = await http.get(
          Uri.parse(
              "${UIGuide.curriculamUrl}/homeworkentry/subject-chapter-topics?value=$subjectId&text=$subject&courseSubjectId=$coursesubjectId&optionSubjectId=$option&subSubjectId=$subsubjectiD&divisionId=$divisionId&"),
          headers: headers);
      print( "${UIGuide.curriculamUrl}/homeworkentry/subject-chapter-topics?value=$subjectId&text=$subject&courseSubjectId=$coursesubjectId&optionSubjectId=$option&subSubjectId=$subsubjectiD&divisionId=$divisionId&");

      if (response.statusCode == 200) {
        print("corect");
        setLoading(true);
        final data = json.decode(response.body);
        log(data.toString());

        List<PortionSubSubject> templist = List<PortionSubSubject>.from(
            data["optionOrSubSubjectList"].map((x) => PortionSubSubject.fromJson(x)));
        subSubjectList.addAll(templist);
        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        print("Error in subsubject response");
      }
    } catch (e) {
      setLoading(false);
      print(e);
    }
  }


  //Student view

  int currentPage = 2;
  int? pageSize;
  int? countStud;
  List? myList;
  List<StudentListPortions> studentViewList = [];
  Future getStudentViewList(
      String division,String subId) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('curiaccesstoken')}'
    };
    try {
      var request =


      http.Request(
          'GET',
          Uri.parse(
              '${UIGuide.curriculamUrl}/student-selector?filterStudyingStatus=studying&divisionId=$division&optionSubId=$subId&page=1'));

      request.headers.addAll(headers);
      print(request);
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        setLoading(true);

        Map<String, dynamic> data =
        jsonDecode(await response.stream.bytesToString());
        log(data.toString());
         myList=  data['results'];
        print("mylistttttttttttt");
        print(myList);

        List<StudentListPortions> templist =
        List<StudentListPortions>.from(data["results"]
            .map((x) => StudentListPortions.fromJson(x)));

        studentViewList.addAll(templist);

        Pagination pagenata =
        Pagination.fromJson(data['pagination']);
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

  //All student

  Future getStudentAllViewList(
      String division,String optionSubId) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('curiaccesstoken')}'
    };
    try {
      var request =


      http.Request(
          'GET',
          Uri.parse(
              '${UIGuide.curriculamUrl}/student-selector/student-det?filterStudyingStatus=studying&divisionId=$division&optionSubId=$optionSubId'));

      request.headers.addAll(headers);
      print(request);
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        setLoading(true);

        List data =
        jsonDecode(await response.stream.bytesToString());
        log(data.toString());

        print("mylistttttttttttt");
        print(myList);

        List<StudentListPortions> templist =
        List<StudentListPortions>.from(data
            .map((x) => StudentListPortions.fromJson(x)));

        studentViewList.addAll(templist);

        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        print('Error in getStudentViewListAll stf');
      }
    } catch (e) {
      print('Error in getStudentViewListAll stf');
      setLoading(false);
    }
  }

  Future getStudentViewByPagination(String division, String subId) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);
    print("Paginationnew");
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('curiaccesstoken')}'
    };
    try {
      var request = http.Request(
          'GET',
          Uri.parse(
              '${UIGuide.curriculamUrl}/student-selector?filterStudyingStatus=studying&divisionId=$division&optionSubId=$subId&page=$currentPage&'));

      request.headers.addAll(headers);
      print(request);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        setLoading(true);

        Map<String, dynamic> data =
        jsonDecode(await response.stream.bytesToString());
        // print(data);
        List<StudentListPortions> templist =
        List<StudentListPortions>.from(data["results"]
            .map((x) => StudentListPortions.fromJson(x)));
        studentViewList.addAll(templist);
        Pagination pagenata =
        Pagination.fromJson(data['pagination']);
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

  selectAll(String division,String optionSubId) async {
    if (allSelected == true) {
      allStudentID.clear();
      allSelected = false;
      isselectAll = false;
    } else {
      await getSelectAllStudents(division,optionSubId);
      allSelected = true;
      isselectAll = true;
    }
    notifyListeners();
  }

  Future getSelectAllStudents(
       String division,String optionSubId) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('curiaccesstoken')}'
    };
    try {
      var request = http.Request(
          'GET',
          Uri.parse(
              '${UIGuide.curriculamUrl}/student-selector?filterStudyingStatus=studying&divisionId=$division&optionSubId=$optionSubId&page=1&fetchAllIds=1&'));

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

  //by name
  Future getPortionListbyName(String name,String division,String optSubID) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var parsedResponse =await parseJWT();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('curiaccesstoken')}'
    };
    try {
      var request = http.Request(
          'GET',
          Uri.parse(
              '${UIGuide.curriculamUrl}/student-selector?filterStudyingStatus=studying&name=$name&divisionId=$division&optionSubId=$optSubID'));

      request.headers.addAll(headers);
      print(request);
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        setLoading(true);

        Map<String, dynamic> data =
        jsonDecode(await response.stream.bytesToString());
        print(data);

        List<StudentListPortions> templist =
        List<StudentListPortions>.from(data["results"]
            .map((x) => StudentListPortions.fromJson(x)));
        studentViewList.addAll(templist);

        Pagination pagenata =
        Pagination.fromJson(data['pagination']);
        pageSize = pagenata.pageSize;
        countStud = pagenata.count;
        // currentPage++;
        // print(currentPage);
        // print(countStud);

        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        print('Error in portionstudent list');
      }
    } catch (e) {
      print('Error in portionstudent list');
      setLoading(false);
    }
  }
  // Future getAnecdotalListPaginationByName() async {
  //   SharedPreferences _pref = await SharedPreferences.getInstance();
  //   var parsedResponse =await parseJWT();
  //
  //
  //   setLoading(true);
  //   var headers = {
  //     'Content-Type': 'application/json',
  //     'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
  //   };
  //   try {
  //     var request = http.Request(
  //         'GET',
  //         Uri.parse(
  //             '${UIGuide.baseURL}/anecdotal/anecdotal-list/?page=$currentPage'));
  //
  //     request.headers.addAll(headers);
  //     print(request);
  //     http.StreamedResponse response = await request.send();
  //
  //     if (response.statusCode == 200) {
  //       setLoadingPage(true);
  //
  //       data =
  //           jsonDecode(await response.stream.bytesToString());
  //       print(data);
  //
  //       // demoData =
  //       // jsonDecode(await response.stream.bytesToString());
  //
  //       List<AnecdotalListViewModel> templist =
  //       List<AnecdotalListViewModel>.from(data["results"]
  //           .map((x) => AnecdotalListViewModel.fromJson(x)));
  //
  //       anecDotalList.addAll(templist);
  //       print("lisssssssssssss");
  //       print(templist);
  //       print(anecDotalList);
  //       print(data);
  //
  //       PaginationAnecDotalList pagenata =
  //       PaginationAnecDotalList.fromJson(data['pagination']);
  //       pageSize = pagenata.pageSize;
  //       countStud = pagenata.count;
  //       currentPage++;
  //       print(currentPage);
  //
  //       setLoadingPage(false);
  //       notifyListeners();
  //     } else {
  //       setLoadingPage(false);
  //       print('Error in anecDotal list');
  //     }
  //   } catch (e) {
  //     print('Error in anecDotal list');
  //     setLoadingPage(false);
  //   }
  // }

  //Select Student

  void selectItem(StudentListPortions model) {
    StudentListPortions selected =
    studentViewList.firstWhere((element) => element.id == model.id);
    selected.selected ??= false;
    selected.selected = !selected.selected!;
    if (selected.selected == false) {
      isselectAll = false;
    }
    print(selected.toJson());
    notifyListeners();
  }

  bool isselectAll = false;


  List<StudentListPortions> selectedList = [];
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

  //Choose file

  String? imageid;
  String? name;
  String? extension;
  String? paths;
  String? url;
  bool? isTemporary;
  bool? isDeleted;
  String? images;
  String? createdAt;
  List imagess=[];
  Future portionfileSave(BuildContext context, String path) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('curiaccesstoken')}'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${UIGuide.curriculamUrl}/files/single/School'));
    request.fields.addAll({'': ''});
    request.files.add(await http.MultipartFile.fromPath('', path));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    setLoading(true);
    if (response.statusCode == 200) {
      setLoading(true);
      Map<String, dynamic> data =
      jsonDecode(await response.stream.bytesToString());

      PortionFiles idd = PortionFiles.fromJson(data);
      imagess.clear();
      imageid = idd.id;
      name=idd.name;
      extension=idd.extension;
      paths= idd.path;
      url=idd.url;
      createdAt=idd.createdAt;


      print("immmmmmmmmmmmmm");
      print(imagess);

      print('...............   $imageid');
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //   elevation: 10,
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.all(Radius.circular(20)),
      //   ),
      //   duration: Duration(seconds: 1),
      //   margin: EdgeInsets.only(bottom: 80, left: 30, right: 30),
      //   behavior: SnackBarBehavior.floating,
      //   content: Text(
      //     'File added...',
      //     textAlign: TextAlign.center,
      //   ),
      // ));
      print("successsssssssssssss");

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
          'Something went wrong',
          textAlign: TextAlign.center,
        ),
      ));
      print(response.reasonPhrase);
      setLoading(false);
    }
  }

  //portionfiledeletd
  int dltstatus=0;
  Future portionfileDelete( String id) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('curiaccesstoken')}'
    };
    var request = http.MultipartRequest(
        'DELETE', Uri.parse('${UIGuide.curriculamUrl}/files/$id/School'));
    request.headers.addAll(headers);
    print(request);

    http.StreamedResponse response = await request.send();
    setLoading(true);
    if (response.statusCode == 204) {
      status=response.statusCode;
      // setLoading(true);
      // print("deleetd");
      // ScaffoldMessenger.of(context).showSnackBar( SnackBar(
      //   elevation: 10,
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.all(Radius.circular(20)),
      //   ),
      //   duration: Duration(seconds: 1),
      //   margin: EdgeInsets.only(bottom: 80, left: 30, right: 30),
      //   behavior: SnackBarBehavior.floating,
      //   content: Text(
      //     'File Deleted...',
      //     textAlign: TextAlign.center,
      //   ),
      // ));
  setLoading(false);
    }
     else {
    //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    //     elevation: 10,
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.all(Radius.circular(20)),
    //     ),
    //     duration: Duration(seconds: 1),
    //     margin: EdgeInsets.only(bottom: 80, left: 30, right: 30),
    //     behavior: SnackBarBehavior.floating,
    //     content: Text(
    //       'Something went wrong',
    //       textAlign: TextAlign.center,
    //     ),
    //   ));
    //   print(response.reasonPhrase);
       setLoading(false);
    }
  }


  Future getPortionFileDelete(String id,String fileId) async {

    SharedPreferences _pref = await SharedPreferences.getInstance();

    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('curiaccesstoken')}'
    };
    try {
      var response = await http.get(
          Uri.parse("${UIGuide.curriculamUrl}/portionentry/delete-file/$id/$fileId"),
          headers: headers);
      print("${UIGuide.curriculamUrl}/portionentry/delete-file/$id/$fileId");

      if (response.statusCode == 200) {
        print("corect");
        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        print("Error in delete file");
      }
    } catch (e) {
      print("Error in deleet file response");
      setLoading(false);
      print(e);
    }
  }


  //save
int status=0;
  String? portionResponseId;
  Future portionsend(
      BuildContext context,
      String entryDate,
      String courseId,
      String divisionId,
      String subjectId,
      String subSubjectId,
      String subSubjectOrOptional,
      String chapter,
      String topic,
      String description,
      String details,
      String assignment,
      List? studList,
      List? attachmentId) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
   setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('curiaccesstoken')}'
    };
    var request = http.Request('POST',
        Uri.parse('${UIGuide.curriculamUrl}/portionentry/save'));
    print(request);
    request.body = json.encode(
        {
          "courseId": courseId,
          "divisionId":divisionId,
          "subjectId":subjectId,
          "subsubjectId":subSubjectId.isEmpty?null:subSubjectId,
          "assignment":assignment.isEmpty?null:assignment,
          "chapter":chapter,
          "topicId":topic.isEmpty?null:topic,
          "description":description.isEmpty?null:description,
          "details":details,
          "entryDate":entryDate,
          "photoList":attachmentId,
          "studentIds":studList,
          "subSubjectOrOptional":subSubjectId.isEmpty?"": subSubjectOrOptional
        }
    );
    log(request.body = json.encode({
      "courseId": courseId,
      "divisionId":divisionId,
      "subjectId":subjectId,
      "subsubjectId":subSubjectId.isEmpty?null:subSubjectId,
      "assignment":assignment.isEmpty?null:assignment,
      "chapter":chapter,
      "topicId":topic.isEmpty?null:topic,
      "description":description.isEmpty?null:description,
      "details":details,
      "entryDate":entryDate,
      "photoList":attachmentId,
      "studentIds":studList,
      "subSubjectOrOptional":subSubjectId.isEmpty?"": subSubjectOrOptional
    }
    ));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print('Correct........______________________________');
      Map<String, dynamic> data =
      jsonDecode(await response.stream.bytesToString());
      print(data);
      PortionResponse portion = PortionResponse.fromJson(data);
      portionResponseId = portion.portionEntryId;
      print("portionId  $portionResponseId");

      await AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          headerAnimationLoop: false,
          title: 'Success',
          desc: 'Successfully sent',
          btnOkOnPress: () {
            return;
          },
          btnOkIcon: Icons.cancel,
          btnOkColor: Colors.green)
          .show();

      status=response.statusCode;
      setLoading(false);
      //getVariables();
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
      print('Error Response notice send stf');
    }
  }

  //--------Notification------------

  Future portionsendNotification(
      String entryDate,
      String courseId,
      String divisionId,
      String subjectId,
      String subSubjectId,
      String subSubjectOrOptional,
      String chapter,
      String topic,
      String description,
      String details,
      String assignment,
      List? studList,
      List? attachmentId) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('curiaccesstoken')}'
    };
    var request = http.Request('POST',
        Uri.parse('${UIGuide.curriculamUrl}/portionentry/sentNotification/$portionResponseId'));
    print(request);
    request.body = json.encode(
        {
          "courseId": courseId,
          "divisionId":divisionId,
          "subjectId":subjectId,
          "subsubjectId":subSubjectId.isEmpty||subSubjectId=="null"?null:subSubjectId,
          "assignment":assignment.isEmpty?null:assignment,
          "chapter":chapter,
          "topicId":topic.isEmpty?null:topic,
          "description":description.isEmpty?null:description,
          "details":details,
          "entryDate":entryDate,
          "photoList":attachmentId,
          "studentIds":studList,
          "subSubjectOrOptional":subSubjectId.isEmpty?"": subSubjectOrOptional
        }
    );
    log(request.body = json.encode({
      "courseId": courseId,
      "divisionId":divisionId,
      "subjectId":subjectId,
      "subsubjectId":subSubjectId.isEmpty||subSubjectId=="null"?null:subSubjectId,
      "assignment":assignment.isEmpty?null:assignment,
      "chapter":chapter,
      "topicId":topic.isEmpty?null:topic,
      "description":description.isEmpty?null:description,
      "details":details,
      "entryDate":entryDate,
      "photoList":attachmentId,
      "studentIds":studList,
      "subSubjectOrOptional":subSubjectId.isEmpty?"": subSubjectOrOptional
    }));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {

      print('-Notification success-');

      notifyListeners();
    } else {

      print("Error in portion send notification");
    }
  }


  //Notificationin update

  // Future portionupdateNotification(
  //     String id,
  //     String entryDate,
  //     String courseId,
  //     String divisionId,
  //     String subjectId,
  //     String subSubjectId,
  //     String subSubjectOrOptional,
  //     String chapter,
  //     String topic,
  //     String description,
  //     String details,
  //     String assignment,
  //     List? studList,
  //     List? attachmentId) async {
  //   SharedPreferences _pref = await SharedPreferences.getInstance();
  //   var headers = {
  //     'Content-Type': 'application/json',
  //     'Authorization': 'Bearer ${_pref.getString('curiaccesstoken')}'
  //   };
  //   var request = http.Request('POST',
  //       Uri.parse('${UIGuide.curriculamUrl}/portionentry/sentNotification/$id'));
  //   print(request);
  //   request.body = json.encode(
  //       {
  //         "courseId": courseId,
  //         "divisionId":divisionId,
  //         "subjectId":subjectId,
  //         "subsubjectId":subSubjectId.isEmpty?null:subSubjectId,
  //         "assignment":assignment.isEmpty?null:assignment,
  //         "chapter":chapter,
  //         "topicId":topic.isEmpty?null:topic,
  //         "description":description.isEmpty?null:description,
  //         "details":details,
  //         "entryDate":entryDate,
  //         "photoList":attachmentId,
  //         "studentIds":studList,
  //         "subSubjectOrOptional":subSubjectId.isEmpty?"": subSubjectOrOptional
  //       }
  //   );
  //   log(request.body = json.encode({
  //     "courseId": courseId,
  //     "divisionId":divisionId,
  //     "subjectId":subjectId,
  //     "subsubjectId":subSubjectId.isEmpty?null:subSubjectId,
  //     "assignment":assignment.isEmpty?null:assignment,
  //     "chapter":chapter,
  //     "topicId":topic.isEmpty?null:topic,
  //     "description":description.isEmpty?null:description,
  //     "details":details,
  //     "entryDate":entryDate,
  //     "photoList":attachmentId,
  //     "studentIds":studList,
  //     "subSubjectOrOptional":subSubjectId.isEmpty?"": subSubjectOrOptional
  //   }));
  //   request.headers.addAll(headers);
  //
  //   http.StreamedResponse response = await request.send();
  //
  //   if (response.statusCode == 200) {
  //
  //     print('-Notification success-');
  //
  //     notifyListeners();
  //   } else {
  //
  //     print("Error in portion send notification");
  //   }
  // }


  //---------------List-------------

  List<PortionList> portionList = [];
  List<StudViewedorNotList> viewList=[];
  List<StudViewedorNotList> notViewList=[];
  Future getPortionList() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('curiaccesstoken')}'
    };
    try {
      var request =


      http.Request(
          'GET',
          Uri.parse(
              '${UIGuide.curriculamUrl}/portionentry/portions-list?'));

      request.headers.addAll(headers);
      print(request);
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        setLoading(true);

        Map<String, dynamic> data =
        jsonDecode(await response.stream.bytesToString());
        print(data);

        List<PortionList> templist =
        List<PortionList>.from(data["results"]
            .map((x) => PortionList.fromJson(x)));
        portionList.addAll(templist);

        // List<StudViewedorNotList> templist1 =
        // List<StudViewedorNotList>.from(data["results"]["viewedList"]
        //     .map((x) => StudViewedorNotList.fromJson(x)));
        // viewList.addAll(templist1);
        //
        // List<StudViewedorNotList> templist3 =
        // List<StudViewedorNotList>.from(data["results"]["notViewedList"]
        //     .map((x) => StudViewedorNotList.fromJson(x)));
        // notViewList.addAll(templist3);


        Pagination pagenata =
        Pagination.fromJson(data['pagination']);
        pageSize = pagenata.pageSize;
        countStud = pagenata.count;

        print(countStud);

        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        print('Error in PortionList stf');
      }
    } catch (e) {
      print('Error in PortionList stf');
      setLoading(false);
    }
  }
  Future getPortionListBypagination() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoadingPage(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('curiaccesstoken')}'
    };
    try {
      var request =


      http.Request(
          'GET',
          Uri.parse(
              '${UIGuide.curriculamUrl}/portionentry/portions-list?page=$currentPage&'));

      request.headers.addAll(headers);
      print(request);
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        setLoadingPage(true);

        Map<String, dynamic> data =
        jsonDecode(await response.stream.bytesToString());
        print(data);

        List<PortionList> templist =
        List<PortionList>.from(data["results"]
            .map((x) => PortionList.fromJson(x)));
        portionList.addAll(templist);



        Pagination pagenata =
        Pagination.fromJson(data['pagination']);
        pageSize = pagenata.pageSize;
        countStud = pagenata.count;
        currentPage++;


        print(countStud);

        setLoadingPage(false);
        notifyListeners();
      } else {
        setLoadingPage(false);
        print('Error in PortionList stf');
      }
    } catch (e) {
      print('Error in PortionList stf');
      setLoadingPage(false);
    }
  }

  bool hasMoreListData() {
    final totalCount = countStud;
    print("portion length :  ${portionList.length}");
    notifyListeners();
    return portionList.length < totalCount!;
  }


  //--------Edit---------------

  String? id;
  String? entryDate;
  String? entrydateNew;
  String? course;
  String? courseId;
  String? topic;
  String? assignment;
  List file=[];
  List<PortionFiles> mobFile=[];
  List<String>? studentIds;
  String? division;
  String? divisionId;
  String? subjectId;
  String? courseSubjectId;
  String? optionalSubjectId;
  String? subjectName;
  String? subOrOptionalSubjectId;
  String? subSubjectName;
  String? optionalSubjectName;
  String? subOrOptionalType;
  String? details;
  String? description;
  String? chapter;
  String? actualStudCount;
  Future getUpdateRow(String id) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('curiaccesstoken')}'
    };
    var response = await http.get(
        Uri.parse("${UIGuide.curriculamUrl}/portionentry/portion-event/$id"),
        headers: headers);
    if (response.statusCode == 200) {
      setLoading(true);
      Map<String, dynamic> data = json.decode(response.body);
      Map<String, dynamic> update = data['portionUpdateRow'];

      List<PortionFiles> templist = List<PortionFiles>.from(
          update["mobileAppFile"].map((x) => PortionFiles.fromJson(x)));
      mobFile.addAll(templist);

       if(  update["optionalorSubSubjectList"] !=null) {
         List<PortionSubSubject> templist1 = List<PortionSubSubject>.from(
             update["optionalorSubSubjectList"].map((x) =>
                 PortionSubSubject.fromJson(x)));
         subSubjectList.addAll(templist1);
       }



      print("filllllfdsdsdsd");
    // print(mobFile[0].name);

      PortionUpdateRow ur = PortionUpdateRow.fromJson(update);
      entryDate= ur.entryDate;
      DateTime inputDate = DateTime.parse(entryDate!);
      DateFormat outputFormat = DateFormat('dd-MM-yyyy');
      entrydateNew = outputFormat.format(inputDate);
      courseId =ur.courseId;
      course=ur.course;
      division=ur.division;
      divisionId= ur.divisionId;
      studentIds= ur.studentIds;
      subjectId =ur.subjectId;
      optionalSubjectId=ur.optionalSubjectId;
      optionalSubjectName=ur.optionalOrSubSubjectName;
      subjectName =ur.subjectName;
      subOrOptionalSubjectId= ur.subOrOptionalSubjectId;
      subSubjectName= ur.optionalOrSubSubjectName;
      details =ur.details;
      description =ur.description;
      chapter= ur.chapter;
      actualStudCount =ur.actualStudCount;
      topic= ur.topicId;
      assignment=ur.assignment;
      subOrOptionalType=ur.subOrOptionalType;
      setLoading(false);
      notifyListeners();
    } else {
      print('Error in getData');
      setLoading(false);
    }
    return response.statusCode;
  }


  //Update

  Future portionUpdate(
      String id,
      BuildContext context,
      String entryDate,
      String courseId,
      String divisionId,
      String subjectId,
      String subSubjectId,
      String subSubjectOrOptional,
      String chapter,
      String topic,
      String description,
      String assignment,
      String details,
      List? studList,
      List? attachmentId) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('curiaccesstoken')}'
    };
    var request = http.Request('POST',
        Uri.parse('${UIGuide.curriculamUrl}/portionentry/update-portion/$id'));
    print(request);
    request.body = json.encode(
        {"courseId": courseId,
          "divisionId":divisionId,
          "subjectId":subjectId,
          "subsubjectId":subSubjectId.isEmpty||subSubjectId=="null"?null:subSubjectId,
        "assignment":assignment.isEmpty?null:assignment,
          "chapter":chapter,
          "topicId":topic.isEmpty?null:topic,
          "description":description.isEmpty?null:description,
          "details":details,
          "entryDate":entryDate,
          "photoList":attachmentId,
          "studentIds":studList,
          "subSubjectOrOptional":subSubjectId.isEmpty?"": subSubjectOrOptional
        }
    );
    log(request.body = json.encode({
      "courseId": courseId,
      "divisionId":divisionId,
      "subjectId":subjectId,
      "subsubjectId":subSubjectId.isEmpty||subSubjectId=="null"?null:subSubjectId,
      "assignment":assignment,
      "chapter":chapter,
      "topicId":topic,
      "description":description,
      "details":details,
      "entryDate":entryDate,
      "photoList":attachmentId,
      "studentIds":studList,
      "subSubjectOrOptional":subSubjectId.isEmpty?"": subSubjectOrOptional
    }));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print('Correct........______________________________');
      print(await response.stream.bytesToString());
      await AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          headerAnimationLoop: false,
          title: 'Success',
          desc: 'Successfully Updated',
          btnOkOnPress: () {
            return;
          },
          btnOkIcon: Icons.cancel,
          btnOkColor: Colors.green)
          .show();

      status=response.statusCode;
      setLoading(false);

      //getVariables();
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
      print('Error Response notice send stf');
    }
  }

  //----delete----

  Future portionDelete(
      BuildContext context, String eventID, int indexx) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('curiaccesstoken')}'
    };
    var request = http.Request('DELETE',
        Uri.parse('${UIGuide.curriculamUrl}/portionentry/delete-portionentry/$eventID'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      portionList.removeAt(indexx);

      print(await response.stream.bytesToString());
      print('correct');
      await AwesomeDialog(
          dismissOnTouchOutside: false,
          dismissOnBackKeyPress: false,
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          headerAnimationLoop: false,
          title: 'Deleted Successfully',

          btnOkOnPress: () async {
            Navigator.pop(context);
          },
          btnOkColor: Color.fromRGBO(
              217,62,71,5))
          .show();

      notifyListeners();
    }
   else if (response.statusCode == 422) {
      portionList.removeAt(indexx);

      print(await response.stream.bytesToString());
      print('correct');
      await AwesomeDialog(
          dismissOnTouchOutside: false,
          dismissOnBackKeyPress: false,
          context: context,
          dialogType: DialogType.warning,
          animType: AnimType.rightSlide,
          headerAnimationLoop: false,
         // title: 'Deleted Successfully',
          desc: "Something went wrong",

          btnOkOnPress: () async {
            Navigator.pop(context);
          },
          btnOkColor: Color.fromARGB(
              255,254,184,0)
      )
          .show();

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
      print('Error in portion Delete');
    }
  }

  //--------------------------------------------------------------------------------
  //--------------------------- APPROVAL -------------------------------------------
 //----------------------------------------------------------------------------------




  clearDivision() async {
    divisiondropDown.clear();
    divisionCounter(0);
    divisionListApproval.clear();
    studentViewList.clear();
    notifyListeners();
  }
  clearSubject() async {
    subjectdropDown.clear();
    subjectCounter(0);
    subjectListApproval.clear();
    studentViewList.clear();
    notifyListeners();
  }

  int subjLen = 0;
  subjectCounter(int len) async {
    subjLen = 0;
    if (len == 0) {
      subjLen = 0;
    } else {
      subjLen = len;
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



  List<ApproveCourseList> approvecourseList = [];

  Future getPortionApproveCourse() async {

    SharedPreferences _pref = await SharedPreferences.getInstance();

    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('curiaccesstoken')}'
    };
    try {
      var response = await http.get(
          Uri.parse("${UIGuide.curriculamUrl}/portionentryApproval/initial-values"),
          headers: headers);

      if (response.statusCode == 200) {
        print("corect");
        setLoading(true);
        final data = json.decode(response.body);
        print(data);
        PortionInitial portion = PortionInitial.fromJson(data);
        isApproval = portion.isExistApprovalSettings;
        List<ApproveCourseList> templist = List<ApproveCourseList>.from(
            data['courseList'].map((x) => ApproveCourseList.fromJson(x)));
        approvecourseList.addAll(templist);



        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        print("Error in getApprovalCourse response");
      }
    } catch (e) {
      print("Error in getApprovalCourse response");
      setLoading(false);
      print(e);
    }
  }


  List<PortionDivisions> divisionListApproval = [];
  List<MultiSelectItem> divisiondropDown = [];
  List<PortionSubjects> subjectListApproval = [];
  List<MultiSelectItem>subjectdropDown = [];
  Future getDivisionListApproval(String course) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('curiaccesstoken')}'
    };
    try {
      var response = await http.get(
          Uri.parse(
              "${UIGuide.curriculamUrl}/portionentryApproval/coursedetails/$course"),
          headers: headers);

      print( "${UIGuide.curriculamUrl}/portionentryApproval/coursedetails/$course");

      if (response.statusCode == 200) {
        print("corect");
        setLoading(true);
        final data = json.decode(response.body);
        log(data.toString());

        List<PortionDivisions> templist = List<PortionDivisions>.from(
            data['divisionList'].map((x) => PortionDivisions.fromJson(x)));
        divisionListApproval.addAll(templist);
        divisiondropDown = divisionListApproval.map((subjectdata) {
          return MultiSelectItem(subjectdata, subjectdata.text!);
        }).toList();
        print(divisiondropDown);

        List<PortionSubjects> templist1 = List<PortionSubjects>.from(
            data['subjectList'].map((x) => PortionSubjects.fromJson(x)));
        subjectListApproval.addAll(templist1);
        subjectdropDown = subjectListApproval.map((subjectdata) =>
          MultiSelectItem(subjectdata, subjectdata.text!)
        ).toList();
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

  List<PortionApprovalView> reportView = [];
  Future getApprovalReport(
      String course,String division,String subject,String fromDate,String toDate,String type) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('curiaccesstoken')}'
    };
    try {
      var request =


      http.Request(
          'GET',
          Uri.parse(
              '${UIGuide.curriculamUrl}/portionentryApproval/view/?fromDate=$fromDate&toDate=$toDate&courseId=$course&divisionId=$division&subjectId=$subject&type=$type&'));

      request.headers.addAll(headers);
      print(request);
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        setLoading(true);

       List data =
        jsonDecode(await response.stream.bytesToString());
        // print(data);

        List<PortionApprovalView> templist =
        List<PortionApprovalView>.from(data
            .map((x) => PortionApprovalView.fromJson(x)));
        reportView.addAll(templist);


        // PaginationReport pagenata =
        // PaginationReport.fromJson(data['pagination']);
        // pageSize = pagenata.pageSize;
        // countStud = pagenata.count;
        // currentPage++;
        // print(currentPage);

        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        print('Error in getPortionReport');
      }
    } catch (e) {
      print('Error in getPortionReport');
      setLoading(false);
    }
  }

  String? portionId;
  String? portionEntryId;
  String? portionDate;
  String? portionSubject;
  String? portionChapter;
  String? portionTopic;
  String? portionStatus;
  String? portionDetails;
  String? portionDescription;
  String? portionAssignment;
  bool? allowApproval;
  List<dynamic> photoList1=[];
  Future getApprovalReportDetailView(String portionId) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    //setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('curiaccesstoken')}'
    };
    try {
      var request =


      http.Request(
          'GET',
          Uri.parse(
              '${UIGuide.curriculamUrl}/portionentryApproval/detailedView/$portionId'));

      request.headers.addAll(headers);
      print(request);
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        setLoading(true);

        Map<String, dynamic> data =
        jsonDecode(await response.stream.bytesToString());
        // print(data);
        ApprovalDetails ad =ApprovalDetails.fromJson(data);

        portionEntryId= ad.portionEntryId!;
        portionDate= ad.date;
        portionSubject= ad.subject;
        portionChapter= ad.chapter;
        portionTopic= ad.topic;
        portionStatus= ad.status;
        allowApproval= ad.allowApproval;
        portionDetails=ad.details;
        portionDescription=ad.description;
        portionAssignment= ad.assignment;

          photoList1 = data['photoList'];

        print("photo list");
        log(photoList1.toString());


        print("photoooo");
        // List<PortionFiles> templist = List<PortionFiles>.from(
        //     data['photoList']["file"].map((x) => PortionFiles.fromJson(x)));
        // photoList.addAll(templist);
        // print("photoooo");



        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        print('Error in getPortionReportDetail');
      }
    } catch (e) {
      print('Error in getPortionReportDetail');
      setLoading(false);
    }
  }


  Future portionApprovalConfirm(
      BuildContext context,
      String pid,
      String type,
      String remarks,
      ) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('curiaccesstoken')}'
    };
    var request = http.Request('POST',
        Uri.parse('${UIGuide.curriculamUrl}/portionentryApproval/save/$pid'));
    print(request);
    request.body = json.encode(
        {"saveAs": type,
          "remarks":remarks.isEmpty?"":remarks
        }
    );
    log(request.body = json.encode(
        {"saveAs":type,
          "remarks":remarks.isEmpty?"":remarks

        }
    ));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print('Correct........_____________________________');
      print(await response.stream.bytesToString());
      await AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          headerAnimationLoop: false,
          title: 'Success',
          desc: type=="0"?'Approved Successfully':'Rejected Successfully',
          btnOkOnPress: () {
           //Navigator.pop(context);
          },
          btnOkIcon: Icons.cancel,
          btnOkColor: Colors.green)
          .show();

      status=response.statusCode;
      setLoading(false);
      //getVariables();
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
      print('Error Response approvals stf');
    }
  }

  Future portionApprovalConfirmUpdate(
      BuildContext context,
      String pid,
      String type,
      String remarks,
      ) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('curiaccesstoken')}'
    };
    var request = http.Request('POST',
        Uri.parse('${UIGuide.curriculamUrl}/portionentryApproval/update/$pid'));
    print(request);
    request.body = json.encode(
        {"saveAs": type,
          "remarks":remarks.isEmpty?"":remarks
        }
    );
    log(request.body = json.encode(
        {"saveAs":type,
          "remarks":remarks.isEmpty?"":remarks

        }
    ));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print('Correct........_____________________________');
      print(await response.stream.bytesToString());
      await AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          headerAnimationLoop: false,
          title: 'Success',
          desc: type=="0"?'Approved Successfully':'Rejected Successfully',
          btnOkOnPress: () {
            //Navigator.pop(context);
          },
          btnOkIcon: Icons.cancel,
          btnOkColor: Colors.green)
          .show();

      status=response.statusCode;
      setLoading(false);
      //getVariables();
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
      print('Error Response approvals stf');
    }
  }



}