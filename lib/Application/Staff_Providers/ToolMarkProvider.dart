import 'dart:convert';
import 'dart:developer';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:essconnect/Domain/Staff/ToolMarkEntryModel.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ToolMarkEntryProviders with ChangeNotifier {
  bool? isLocked;

  List toollListView = [];

  courseClear() {
    toolInitialValues.clear();
    notifyListeners();
  }

  List<ToolCourseList> toolInitialValues = [];
  Future<bool> getToolInitialValues() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    var request = http.Request(
        'GET', Uri.parse('${UIGuide.baseURL}/toolmarkentry/initialvalues'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Map<String, dynamic> data =
          jsonDecode(await response.stream.bytesToString());
      ToolMarkModel view = ToolMarkModel.fromJson(data);
      isLocked = view.isLocked;
      log(data.toString());

      List<ToolCourseList> templist = List<ToolCourseList>.from(
          data["courseList"].map((x) => ToolCourseList.fromJson(x)));
      toolInitialValues.addAll(templist);
      print(templist);
      notifyListeners();
    } else {
      print('Error in ToolInitialValues stf');
    }
    return true;
  }

// Division

  divisionClear() {
    toolDivisionList.clear();
    notifyListeners();
  }

  List<ToolDivisionList> toolDivisionList = [];
  Future<bool> getToolDivisionValues(String id) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    var request = http.Request(
        'GET', Uri.parse('${UIGuide.baseURL}/toolmarkentry/coursedetails/$id'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Map<String, dynamic> data =
          jsonDecode(await response.stream.bytesToString());

      log(data.toString());

      List<ToolDivisionList> templist = List<ToolDivisionList>.from(
          data["divisionList"].map((x) => ToolDivisionList.fromJson(x)));
      toolDivisionList.addAll(templist);

      notifyListeners();
    } else {
      print('Error in toolDivisionList stf');
    }
    return true;
  }

  //part

  removeAllpartClear() {
    toolPartList.clear();
    notifyListeners();
  }

  List<ToolParts> toolPartList = [];
  Future<bool> getToolPartValues(String courseId, String divisionId) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            '${UIGuide.baseURL}/toolmarkentry/part/$courseId/$divisionId'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Map<String, dynamic> data =
          jsonDecode(await response.stream.bytesToString());

      log(data.toString());

      List<ToolParts> templist =
          List<ToolParts>.from(data["parts"].map((x) => ToolParts.fromJson(x)));
      toolPartList.addAll(templist);

      notifyListeners();
    } else {
      print('Error in toolPartList stf');
    }
    return true;
  }

  //subjectList

  removeAllSubjectClear() {
    toolSubjectList.clear();
    notifyListeners();
  }

  List<ToolSubjectList> toolSubjectList = [];
  Future<bool> getToolSubjectValues(String divionId, String partId) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    print('object');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };

    var request = http.Request(
        'GET',
        Uri.parse(
            '${UIGuide.baseURL}/toolmarkentry/subjects/$divionId/$partId'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Map<String, dynamic> data =
          jsonDecode(await response.stream.bytesToString());

      log(data.toString());

      List<ToolSubjectList> templist = List<ToolSubjectList>.from(
          data["subjectList"].map((x) => ToolSubjectList.fromJson(x)));
      toolSubjectList.addAll(templist);

      notifyListeners();
    } else {
      print('Error in toolsubjectList stf');
    }
    return true;
  }

//Optional subject List

  removeAllOptionSubjectListClear() {
    toolOptionSubjectList.clear();
    notifyListeners();
  }

  List<OptionalSubjectList> toolOptionSubjectList = [];
  Future<bool> getToolOptionSubject(String subjectId, String divisionId) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    print('object');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };

    var request = http.Request(
        'GET',
        Uri.parse(
            '${UIGuide.baseURL}/toolmarkentry/subOptionsubjectdetails/$subjectId/$divisionId'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print('correct');
      List data = jsonDecode(await response.stream.bytesToString());

      log(data.toString());

      List<OptionalSubjectList> templist = List<OptionalSubjectList>.from(
          data.map((x) => OptionalSubjectList.fromJson(x)));
      toolOptionSubjectList.addAll(templist);

      notifyListeners();
    } else {
      print('Error in toolOptionSubjectList stf');
    }
    return true;
  }

  //examList

  removeAllExamClear() {
    toolExamList.clear();
    notifyListeners();
  }

  List<ToolExamslist> toolExamList = [];
  Future<bool> getToolExamValues(
      String subjectId, String divisionId, String partId) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    print('object');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };

    var request = http.Request(
        'GET',
        Uri.parse(
            '${UIGuide.baseURL}/toolmarkentry/examdetails/$subjectId/$divisionId/$partId'));

    request.headers.addAll(headers);
    print('object');
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print('correct');
      Map<String, dynamic> data =
          jsonDecode(await response.stream.bytesToString());

      log(data.toString());

      List<ToolExamslist> templist = List<ToolExamslist>.from(
          data["examslist"].map((x) => ToolExamslist.fromJson(x)));
      toolExamList.addAll(templist);

      notifyListeners();
    } else {
      print('Error in toolExamList stf');
    }
    return true;
  }

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  //View
  bool? isBlocked;
  String? entryMethod;
  String? enteredBy;
  String? typeCode;
  String? examStatus;
  List<StudentMEList> studentMEList = [];
  List<ToolListViewModel> toolListView = [];
  List<GradeList> gradeList = [];
  Future<bool> getMarkEntryView(String course, String date, String division,
      String exam, String part, String subject, String optionalSubject) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    setLoading(true);
    var request = http.Request(
        'POST', Uri.parse('${UIGuide.baseURL}/toolmarkentry/view'));
    request.body = json.encode({
      "course": course,
      "created date": date,
      "division": division,
      "exam": exam,
      "part": part,
      "subOptionSubject": optionalSubject.isEmpty ? null : optionalSubject,
      "subject": subject,
      "isBlocked": "false"
    });
    print(json.encode({
      "course": course,
      "created date": date,
      "division": division,
      "exam": exam,
      "part": part,
      "subOptionSubject": optionalSubject.isEmpty ? null : optionalSubject,
      "subject": subject,
      "isBlocked": "false"
    }));
    request.headers.addAll(headers);
    setLoading(true);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      setLoading(true);

      print('---------------------correct--------------------------');
      Map<String, dynamic> data =
          jsonDecode(await response.stream.bytesToString());

      setLoading(true);

      List<StudentMEList> templist = List<StudentMEList>.from(
          data["studentMEList"].map((x) => StudentMEList.fromJson(x)));
      studentMEList.addAll(templist);
      ToolBasicData daaataa = ToolBasicData.fromJson(data["toolBasicData"]);
      typeCode = daaataa.typeCode;
      examStatus = daaataa.examStatus;
      entryMethod = daaataa.entryMethod;
      isBlocked = daaataa.isBlocked;
      enteredBy = daaataa.enteredBy;

      List<GradeList> templist2 = List<GradeList>.from(
          data["gradeList"].map((x) => GradeList.fromJson(x)));
      gradeList.addAll(templist2);

      List<ToolListViewModel> templist3 = List<ToolListViewModel>.from(
          data["toolList"].map((x) => ToolListViewModel.fromJson(x)));
      toolListView.addAll(templist3);
      toollListView = data["toolList"];

      setLoading(false);
      notifyListeners();
    } else {
      setLoading(false);
      print('Error in MarkEntryView stf');
    }
    return true;
  }

  //SAVE
  bool _load = false;
  bool get load => _load;
  setLoad(bool value) {
    _load = value;
    notifyListeners();
  }

  Future markEntrySave(BuildContext context, List toolLists, List studentList,
      Map criteria) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoad(true);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };

    var request = http.Request(
        'POST', Uri.parse('${UIGuide.baseURL}/toolmarkentry/save'));

    request.body = json.encode({
      "Criteria": criteria,
      "StudentList": studentList,
      "ToolList": toolLists
    });
    print("markentry save---------------------------");
    log(json.encode({
      "Criteria": criteria,
      "StudentList": studentList,
      "ToolList": toolLists
    }));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    setLoad(true);

    if (response.statusCode == 200) {
      setLoad(true);

      print('Correct........______________________________');
      print(await response.stream.bytesToString());
      await AwesomeDialog(
              dismissOnTouchOutside: false,
              dismissOnBackKeyPress: false,
              context: context,
              dialogType: DialogType.success,
              animType: AnimType.rightSlide,
              headerAnimationLoop: false,
              title: 'Success',
              desc: 'Successfully Saved',
              btnOkOnPress: () async {
                await clearStudList();
                examStatus = "";
              },
              btnOkColor: Colors.green)
          .show();
      gradeList.clear();

      setLoad(false);

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
      setLoad(false);
      print('Error Response in attendance');
    }
    setLoad(false);
  }

  //verify

  bool _loadverify = false;
  bool get loadverify => _loadverify;
  setLoadverify(bool value) {
    _loadverify = value;
    notifyListeners();
  }

  Future markEntryVerify(BuildContext context, List toolLists, List studentList,
      Map criteria) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoadverify(true);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };

    var request = http.Request(
        'POST', Uri.parse('${UIGuide.baseURL}/toolmarkentry/verify'));

    request.body = json.encode({
      "Criteria": criteria,
      "StudentList": studentList,
      "ToolList": toolLists
    });
    print("markentry save---------------------------");
    log(json.encode({
      "Criteria": criteria,
      "StudentList": studentList,
      "ToolList": toolLists
    }));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    setLoadverify(true);

    if (response.statusCode == 200) {
      setLoadverify(true);

      print('Correct........______________________________');
      print(await response.stream.bytesToString());
      await AwesomeDialog(
              dismissOnTouchOutside: false,
              dismissOnBackKeyPress: false,
              context: context,
              dialogType: DialogType.success,
              animType: AnimType.rightSlide,
              headerAnimationLoop: false,
              title: 'Verified',
              desc: 'Verified Successfully',
              btnOkOnPress: () async {
                await clearStudList();
                Navigator.pop(context);
              },
              btnOkColor: Colors.green)
          .show();
      gradeList.clear();
      setLoadverify(false);

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
      setLoadverify(false);
      print('Error Response in attendance');
    }
    setLoadverify(false);
  }

  //delete
  Future markEntryDelete(BuildContext context, List toolLists, List studentList,
      Map criteria) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoad(true);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };

    var request = http.Request(
        'POST', Uri.parse('${UIGuide.baseURL}/toolmarkentry/delete'));

    request.body = json.encode({
      "Criteria": criteria,
      "StudentList": studentList,
      "ToolList": toolLists
    });
    print("markentry save---------------------------");
    log(json.encode({
      "Criteria": criteria,
      "StudentList": studentList,
      "ToolList": toolLists
    }));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    setLoad(true);

    if (response.statusCode == 200) {
      setLoad(true);

      print('Correct........______________________________');
      print(await response.stream.bytesToString());
      await AwesomeDialog(
              dismissOnTouchOutside: false,
              dismissOnBackKeyPress: false,
              context: context,
              dialogType: DialogType.error,
              animType: AnimType.rightSlide,
              headerAnimationLoop: false,
              title: 'Delete',
              desc: 'Deleted Successfully',
              btnOkOnPress: () async {
                await clearStudList();
                examStatus = "";
                Navigator.pop(context);
              },
              btnOkColor: Color.fromARGB(255, 217, 14, 14))
          .show();
      ;
      gradeList.clear();
      setLoad(false);

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
      setLoad(false);
      print('Error Response in attendance');
    }
    setLoad(false);
  }

  clearStudList() async {
    studentMEList.clear();
    gradeList.clear();
    toolListView.clear();
    notifyListeners();
  }
}
