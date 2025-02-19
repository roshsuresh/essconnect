import 'dart:convert';
import 'dart:developer';
import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../../Constants.dart';
import '../../Domain/Staff/ToolMarkEntryModel.dart';
import '../../utils/constants.dart';

class ToolMarkEntryProviders with ChangeNotifier {
  bool? isLocked;

  List toollListView = [];

  courseClear() {
    toolInitialValues.clear();
    notifyListeners();
  }

  List<ToolCourseList> toolInitialValues = [];
  Future getToolInitialValues(BuildContext context) async {
    await courseClear();
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    try {
      var request = http.Request(
          'GET', Uri.parse('${UIGuide.baseURL}/toolmarkentry/initialvalues'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        setLoading(true);
        Map<String, dynamic> data =
            jsonDecode(await response.stream.bytesToString());
        ToolMarkModel view = ToolMarkModel.fromJson(data);
        isLocked = view.isLocked;
        log(data.toString());

        List<ToolCourseList> templist = List<ToolCourseList>.from(
            data["courseList"].map((x) => ToolCourseList.fromJson(x)));
        toolInitialValues.addAll(templist);
        print(templist);
        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        print('Error in ToolInitialValues stf');
      }
    } catch (e) {
      setLoading(false);
    }
  }

// Division

  divisionClear() {
    toolDivisionList.clear();
    notifyListeners();
  }

  List<ToolDivisionList> toolDivisionList = [];
  Future getToolDivisionValues(String id, BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    try {
      var request = http.Request('GET',
          Uri.parse('${UIGuide.baseURL}/toolmarkentry/coursedetails/$id'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        setLoading(true);
        Map<String, dynamic> data =
            jsonDecode(await response.stream.bytesToString());

        log(data.toString());

        List<ToolDivisionList> templist = List<ToolDivisionList>.from(
            data["divisionList"].map((x) => ToolDivisionList.fromJson(x)));
        toolDivisionList.addAll(templist);
        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        print('Error in toolDivisionList stf');
      }
    } catch (e) {
      snackbarWidget(4, 'Something Went Wrong....', context);
      setLoading(false);
    }
  }

  //part

  removeAllpartClear() {
    toolPartList.clear();
    notifyListeners();
  }

  List<ToolParts> toolPartList = [];
  Future getToolPartValues(
      String courseId, String divisionId, BuildContext context) async {
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
              '${UIGuide.baseURL}/toolmarkentry/part/$courseId/$divisionId'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        setLoading(true);
        Map<String, dynamic> data =
            jsonDecode(await response.stream.bytesToString());

        log(data.toString());

        List<ToolParts> templist = List<ToolParts>.from(
            data["parts"].map((x) => ToolParts.fromJson(x)));
        toolPartList.addAll(templist);
        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        print('Error in toolPartList stf');
      }
    } catch (e) {
      snackbarWidget(4, 'Something Went Wrong....', context);
      setLoading(false);
    }
  }

  //subjectList

  removeAllSubjectClear() {
    toolSubjectList.clear();
    notifyListeners();
  }

  List<ToolSubjectList> toolSubjectList = [];
  Future getToolSubjectValues(
      String divionId, String partId, BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoading(true);
    print('object');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    try {
      var request = http.Request(
          'GET',
          Uri.parse(
              '${UIGuide.baseURL}/toolmarkentry/subjects/$divionId/$partId'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        setLoading(true);
        Map<String, dynamic> data =
            jsonDecode(await response.stream.bytesToString());

        log(data.toString());

        List<ToolSubjectList> templist = List<ToolSubjectList>.from(
            data["subjectList"].map((x) => ToolSubjectList.fromJson(x)));
        toolSubjectList.addAll(templist);
        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        print('Error in toolsubjectList stf');
      }
    } catch (e) {
      snackbarWidget(4, 'Something Went Wrong....', context);
      setLoading(false);
    }
  }

//Optional subject List

  removeAllOptionSubjectListClear() {
    toolOptionSubjectList.clear();
    notifyListeners();
  }

  List<OptionalSubjectList> toolOptionSubjectList = [];
  Future getToolOptionSubject(
      String subjectId, String divisionId, BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoading(true);
    print('object');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    try {
      var request = http.Request(
          'GET',
          Uri.parse(
              '${UIGuide.baseURL}/toolmarkentry/subOptionsubjectdetails/$subjectId/$divisionId'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        setLoading(true);
        print('correct');
        List data = jsonDecode(await response.stream.bytesToString());

        log(data.toString());

        List<OptionalSubjectList> templist = List<OptionalSubjectList>.from(
            data.map((x) => OptionalSubjectList.fromJson(x)));
        toolOptionSubjectList.addAll(templist);
        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        print('Error in toolOptionSubjectList stf');
      }
    } catch (e) {
      snackbarWidget(4, 'Something Went Wrong....', context);
      setLoading(false);
    }
  }

  //examList

  removeAllExamClear() {
    toolExamList.clear();
    notifyListeners();
  }

  List<ToolExamslist> toolExamList = [];
  Future getToolExamValues(String subjectId, String divisionId, String partId,
      BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoading(true);
    print('object');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    try {
      var request = http.Request(
          'GET',
          Uri.parse(
              '${UIGuide.baseURL}/toolmarkentry/examdetails/$subjectId/$divisionId/$partId'));

      request.headers.addAll(headers);
      print('object');
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        setLoading(true);
        print('correct');
        Map<String, dynamic> data =
            jsonDecode(await response.stream.bytesToString());

        log(data.toString());

        List<ToolExamslist> templist = List<ToolExamslist>.from(
            data["examslist"].map((x) => ToolExamslist.fromJson(x)));
        toolExamList.addAll(templist);
        setLoading(false);

        notifyListeners();
      } else {
        setLoading(false);
        print('Error in toolExamList stf');
      }
    } catch (e) {
      snackbarWidget(4, 'Something Went Wrong....', context);
      setLoading(false);
    }
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
  Future getMarkEntryView(
      String course,
      String date,
      String division,
      String exam,
      String part,
      String subject,
      String optionalSubject,
      BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoading(true);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    setLoading(true);
    try {
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
    } catch (e) {
      snackbarWidget(4, 'Something Went Wrong....', context);
      setLoading(false);
    }
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
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoading(true);
    setLoad(true);
    setLoadCommon(true);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };

    try {
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
        setLoading(true);
        setLoad(true);
        setLoadCommon(true);

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
        setLoading(false);
        setLoadCommon(false);

        notifyListeners();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          duration: Duration(seconds: 4),
          margin: EdgeInsets.only(bottom: 80, left: 30, right: 30),
          behavior: SnackBarBehavior.floating,
          content: Text(
            'Something Went Wrong....',
            textAlign: TextAlign.center,
          ),
        ));
        setLoad(false);
        setLoading(false);
        setLoadCommon(false);
        print('Error Response in attendance');
      }
    } catch (e) {
      snackbarWidget(4, 'Something Went Wrong....', context);
      setLoad(false);
      setLoading(false);
      setLoadCommon(false);
    }
  }

  //verify

  bool _loadverify = false;
  bool get loadverify => _loadverify;
  setLoadverify(bool value) {
    _loadverify = value;
    notifyListeners();
  }

  bool _loadCommon = false;
  bool get loadCommon => _loadCommon;
  setLoadCommon(bool value) {
    _loadCommon = value;
    notifyListeners();
  }

  Future markEntryVerify(BuildContext context, List toolLists, List studentList,
      Map criteria) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoadverify(true);
    setLoadCommon(true);
    setLoading(true);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    try {
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
        setLoading(true);
        setLoadverify(true);
        setLoadCommon(true);
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
        setLoading(false);
        setLoadverify(false);
        setLoadCommon(false);
        notifyListeners();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          duration: Duration(seconds: 4),
          margin: EdgeInsets.only(bottom: 80, left: 30, right: 30),
          behavior: SnackBarBehavior.floating,
          content: Text(
            'Something Went Wrong....',
            textAlign: TextAlign.center,
          ),
        ));
        setLoading(false);
        setLoadverify(false);
        setLoadCommon(false);
        print('Error Response in attendance');
      }
    } catch (e) {
      snackbarWidget(4, 'Something Went Wrong....', context);
      setLoadverify(false);
      setLoadCommon(false);
      setLoading(false);
    }
  }

  //delete
  Future markEntryDelete(BuildContext context, List toolLists, List studentList,
      Map criteria) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoad(true);
    setLoading(true);
    setLoadCommon(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    try {
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
        setLoading(true);
        setLoad(true);
        setLoadCommon(true);
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
                btnOkColor: const Color.fromARGB(255, 217, 14, 14))
            .show();

        gradeList.clear();
        setLoading(false);
        setLoad(false);
        setLoadCommon(false);
        notifyListeners();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          duration: Duration(seconds: 4),
          margin: EdgeInsets.only(bottom: 80, left: 30, right: 30),
          behavior: SnackBarBehavior.floating,
          content: Text(
            'Something Went Wrong....',
            textAlign: TextAlign.center,
          ),
        ));
        setLoad(false);
        setLoading(false);
        setLoadCommon(false);
        print('Error Response in attendance');
      }
    } catch (e) {
      snackbarWidget(4, 'Something Went Wrong....', context);
      setLoad(false);
      setLoading(false);
      setLoadCommon(false);
    }
  }

  clearStudList() async {
    studentMEList.clear();
    gradeList.clear();
    toolListView.clear();
    notifyListeners();
  }
}
