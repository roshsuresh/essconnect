import 'dart:convert';
import 'dart:developer';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:essconnect/Domain/Staff/MarkEntry/InitailModel.dart';
import 'package:essconnect/Domain/Staff/MarkEntry/UASViewModel.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MarkEntryNewProvider with ChangeNotifier {
  String? examStatus;
  bool? isLocked;
  courseClear() {
    markEntryInitialValues.clear();
    notifyListeners();
  }

  List<MarkEntryInitialValues> markEntryInitialValues = [];
  Future<bool> getMarkEntryInitialValues() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    var request = http.Request(
        'GET', Uri.parse('${UIGuide.baseURL}/markentry-latest/initialvalues'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Map<String, dynamic> data =
          jsonDecode(await response.stream.bytesToString());
      MarkEntryViewModel view = MarkEntryViewModel.fromJson(data);
      isLocked = view.isLocked;

      log(data.toString());

      List<MarkEntryInitialValues> templist = List<MarkEntryInitialValues>.from(
          data["courseList"].map((x) => MarkEntryInitialValues.fromJson(x)));
      markEntryInitialValues.addAll(templist);
      print(templist);
      notifyListeners();
    } else {
      print('Error in markEntryInitialValues stf');
    }
    return true;
  }

// Division

  divisionClear() {
    markEntryDivisionList.clear();
    notifyListeners();
  }

  String? typeCode;
  List<MarkEntryDivisionList> markEntryDivisionList = [];
  Future<bool> getMarkEntryDivisionValues(String id) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    var request = http.Request('GET',
        Uri.parse('${UIGuide.baseURL}/markentry-latest/coursedetails/$id'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Map<String, dynamic> data =
          jsonDecode(await response.stream.bytesToString());
      MarkEntryDivisionInitailModel inita =
          MarkEntryDivisionInitailModel.fromJson(data);
      typeCode = inita.typeCode;

      log(data.toString());

      List<MarkEntryDivisionList> templist = List<MarkEntryDivisionList>.from(
          data["divisionList"].map((x) => MarkEntryDivisionList.fromJson(x)));
      markEntryDivisionList.addAll(templist);

      notifyListeners();
    } else {
      print('Error in MarkEntryDivisionList stf');
    }
    return true;
  }

  //part

  removeAllpartClear() {
    markEntryPartList.clear();
    notifyListeners();
  }

  List<MarkEntryPartList> markEntryPartList = [];
  Future<bool> getMarkEntryPartValues(
      String courseId, String divisionId) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            '${UIGuide.baseURL}/markentry-latest/part/$courseId/$divisionId'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Map<String, dynamic> data =
          jsonDecode(await response.stream.bytesToString());

      log(data.toString());

      List<MarkEntryPartList> templist = List<MarkEntryPartList>.from(
          data["parts"].map((x) => MarkEntryPartList.fromJson(x)));
      markEntryPartList.addAll(templist);

      notifyListeners();
    } else {
      print('Error in MarkEntryPartList stf');
    }
    return true;
  }

  //subjectList

  removeAllSubjectClear() {
    markEntrySubjectList.clear();
    notifyListeners();
  }

  List<MarkEntrySubjectList> markEntrySubjectList = [];
  Future<bool> getMarkEntrySubjectValues(String divionId, String partId) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    print('object');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };

    var request = http.Request(
        'GET',
        Uri.parse(
            '${UIGuide.baseURL}/markentry-latest/subjects/$divionId/$partId'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Map<String, dynamic> data =
          jsonDecode(await response.stream.bytesToString());

      log(data.toString());

      List<MarkEntrySubjectList> templist = List<MarkEntrySubjectList>.from(
          data["subjectList"].map((x) => MarkEntrySubjectList.fromJson(x)));
      markEntrySubjectList.addAll(templist);

      notifyListeners();
    } else {
      print('Error in MarkEntrysubjectList stf');
    }
    return true;
  }

//Optional subject List

  removeAllOptionSubjectListClear() {
    markEntryOptionSubjectList.clear();
    notifyListeners();
  }

  List<MarkEntryOptionSubjectModel> markEntryOptionSubjectList = [];
  Future<bool> getMarkEntryOptionSubject(
      String subject, String division, String part) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    print('object');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };

    var request = http.Request(
        'GET',
        Uri.parse(
            '${UIGuide.baseURL}/markentry-latest/subjectdetails/?subject=$subject&division=$division&part=$part'));
    print(
        '${UIGuide.baseURL}/markentry-latest/subjectdetails/?subject=$subject&division=$division&part=$part');
    request.headers.addAll(headers);
    print('object');
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print('correct');
      Map<String, dynamic> data =
          jsonDecode(await response.stream.bytesToString());

      log(data.toString());

      List<MarkEntryOptionSubjectModel> templist =
          List<MarkEntryOptionSubjectModel>.from(data['subjectList']
              .map((x) => MarkEntryOptionSubjectModel.fromJson(x)));
      markEntryOptionSubjectList.addAll(templist);

      notifyListeners();
    } else {
      print('Error in markEntryOptionSubjectList stf');
    }
    return true;
  }
  //examList

  removeAllExamClear() {
    markEntryExamList.clear();
    notifyListeners();
  }

  List<MarkEntryExamList> markEntryExamList = [];
  Future<bool> getMarkEntryExamValues(
      String subject, String division, String part) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    print('object');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };

    var request = http.Request(
        'GET',
        Uri.parse(
            '${UIGuide.baseURL}/markentry-latest/examdetails/?subject=$subject&division=$division&part=$part'));

    request.headers.addAll(headers);
    print(request);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print('correct');
      Map<String, dynamic> data =
          jsonDecode(await response.stream.bytesToString());

      log(data.toString());

      List<MarkEntryExamList> templist = List<MarkEntryExamList>.from(
          data["examslist"].map((x) => MarkEntryExamList.fromJson(x)));
      markEntryExamList.addAll(templist);
      notifyListeners();
    } else {
      print('Error in MarkEntryExamList stf');
    }
    return true;
  }

  //Checkbox

  bool isTerminated = false;

  terminatedCheckbox() {
    isTerminated = !isTerminated;
    notifyListeners();
  }

  //markentry view UAS
  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  String? markEntryIdUAS;
  String? schoolIdUAS;
  String? tabulationTypeCode;
  String? subjectCaptionUAS;
  String? divisionUAS;
  String? courseUAS;
  String? partUAS;
  String? subjectUAS;
  String? subSubjectUAS;
  String? optionSubjectUAS;
  String? staffIdUAS;
  String? staffNameUAS;
  String? entryMethodUAS;
  String? examUAS;
  bool includeTerminatedStudentsUAS = false;
  String? teMax;
  String? peMax;
  String? ceMax;
  String? teCaptionUAS;
  String? peCaptionUAS;
  String? ceCaptionUAS;
  bool? isBlockedUAS;
  String? examStatusUAS;
  String? updatedAtUAS;
  var partsUAS;

  List<MarkEntryDetailsUAS> studListUAS = [];
  List<GradeListUAS> gradeListUAS = [];
  Future<bool> getMarkEntryUASView(
      String course,
      String division,
      String exam,
      String partID,
      String subject,
      String subSubject,
      String optionSubject,
      String typeCodee,
      var partItems,
      String subjectCaption,
      bool terminated) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    setLoading(true);
    var request = http.Request(
        'POST', Uri.parse('${UIGuide.baseURL}/markentry-latest/view/'));
    request.body = json.encode({
      "course": course == "null" ? null : course,
      "division": division == "null" ? null : division,
      "subject": subject == "null" ? null : subject,
      "subSubject": subSubject == "null" ? null : subSubject,
      "optionSubject": optionSubject == "null" ? null : optionSubject,
      "exam": exam == "null" ? null : exam,
      "includeTerminatedStudents": terminated,
      "tabulationTypeCode": typeCodee,
      "part": partID == "null" ? null : partID,
      "partItem": partItems,
      "subjectCaption": subjectCaption == "null" ? null : subjectCaption
    });

    request.headers.addAll(headers);
    setLoading(true);
    http.StreamedResponse response = await request.send();
    print(request.body);
    if (response.statusCode == 200) {
      setLoading(true);

      print('---------------------correct--------------------------');
      Map<String, dynamic> data =
          jsonDecode(await response.stream.bytesToString());

      // log(data.toString());
      setLoading(true);

      MarkEntryUASModel marku = MarkEntryUASModel.fromJson(data['markEntry']);

      markEntryIdUAS = marku.markEntryId;
      schoolIdUAS = marku.schoolId;
      tabulationTypeCode = marku.tabulationTypeCode;
      subjectCaptionUAS = marku.subjectCaption;
      divisionUAS = marku.division;
      courseUAS = marku.course;
      partUAS = marku.part;
      subjectUAS = marku.subject;
      subSubjectUAS = marku.subSubject;
      optionSubjectUAS = marku.optionSubject;
      staffIdUAS = marku.staffId;
      staffNameUAS = marku.staffName;
      entryMethodUAS = marku.entryMethod;
      examUAS = marku.exam;
      includeTerminatedStudentsUAS = marku.includeTerminatedStudents!;
      teMax = marku.teMax;
      peMax = marku.peMax;
      ceMax = marku.ceMax;
      teCaptionUAS = marku.teCaption;
      peCaptionUAS = marku.peCaption;
      ceCaptionUAS = marku.ceCaption;
      isBlockedUAS = marku.isBlocked;
      examStatusUAS = marku.examStatus;
      updatedAtUAS = marku.updatedAt;
      setLoading(false);
      List<MarkEntryDetailsUAS> templist = List<MarkEntryDetailsUAS>.from(
          data['markEntry']["markEntryDetails"]
              .map((x) => MarkEntryDetailsUAS.fromJson(x)));
      studListUAS.addAll(templist);
      if (data['markEntry']["gradeList"] != null) {
        List<GradeListUAS> templist1 = List<GradeListUAS>.from(data['markEntry']
                ["gradeList"]
            .map((x) => GradeListUAS.fromJson(x)));
        gradeListUAS.addAll(templist1);
      }
      partsUAS = data['markEntry']["partItem"];

      setLoading(false);
      notifyListeners();
    } else {
      setLoading(false);
      print('Error in MarkEntryView UAS');
    }
    return true;
  }

  //markEntry State View

  Future<bool> getMarkEntrySTATEView(
      String course,
      String division,
      String exam,
      String partID,
      String subject,
      String subSubject,
      String optionSubject,
      String typeCodee,
      var partItems,
      String subjectCaption,
      bool terminated) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    setLoading(true);
    var request = http.Request(
        'POST', Uri.parse('${UIGuide.baseURL}/markentry-latest/state-view/'));
    request.body = json.encode({
      "course": course == "null" ? null : course,
      "division": division == "null" ? null : division,
      "subject": subject == "null" ? null : subject,
      "subSubject": subSubject == "null" ? null : subSubject,
      "optionSubject": optionSubject == "null" ? null : optionSubject,
      "exam": exam == "null" ? null : exam,
      "includeTerminatedStudents": terminated,
      "tabulationTypeCode": typeCodee,
      "part": partID == "null" ? null : partID,
      "partItem": partItems,
      "subjectCaption": subjectCaption == "null" ? null : subjectCaption
    });

    request.headers.addAll(headers);
    setLoading(true);
    http.StreamedResponse response = await request.send();
    print(request.body);
    if (response.statusCode == 200) {
      setLoading(true);

      print('---------------------correct-STATE-------------------------');
      Map<String, dynamic> data =
          jsonDecode(await response.stream.bytesToString());

      // log(data.toString());
      setLoading(true);

      MarkEntryUASModel marku = MarkEntryUASModel.fromJson(data['markEntry']);

      markEntryIdUAS = marku.markEntryId;
      schoolIdUAS = marku.schoolId;
      tabulationTypeCode = marku.tabulationTypeCode;
      subjectCaptionUAS = marku.subjectCaption;
      divisionUAS = marku.division;
      courseUAS = marku.course;
      partUAS = marku.part;
      subjectUAS = marku.subject;
      subSubjectUAS = marku.subSubject;
      optionSubjectUAS = marku.optionSubject;
      staffIdUAS = marku.staffId;
      staffNameUAS = marku.staffName;
      entryMethodUAS = marku.entryMethod;
      examUAS = marku.exam;
      includeTerminatedStudentsUAS = marku.includeTerminatedStudents!;
      teMax = marku.teMax;
      peMax = marku.peMax;
      ceMax = marku.ceMax;
      teCaptionUAS = marku.teCaption;
      peCaptionUAS = marku.peCaption;
      ceCaptionUAS = marku.ceCaption;
      isBlockedUAS = marku.isBlocked;
      examStatusUAS = marku.examStatus;
      updatedAtUAS = marku.updatedAt;
      setLoading(false);
      List<MarkEntryDetailsUAS> templist = List<MarkEntryDetailsUAS>.from(
          data['markEntry']["markEntryDetails"]
              .map((x) => MarkEntryDetailsUAS.fromJson(x)));
      studListUAS.addAll(templist);
      if (data['markEntry']["gradeList"] != null) {
        List<GradeListUAS> templist1 = List<GradeListUAS>.from(data['markEntry']
                ["gradeList"]
            .map((x) => GradeListUAS.fromJson(x)));
        gradeListUAS.addAll(templist1);
      }
      partsUAS = data['markEntry']["partItem"];

      setLoading(false);
      notifyListeners();
    } else {
      setLoading(false);
      print('Error in MarkEntryView UAS');
    }
    return true;
  }

  //SAVE
  bool _loadSave = false;
  bool get loadSave => _loadSave;
  setLoadSave(bool value) {
    _loadSave = value;
    notifyListeners();
  }

  Future markEntrySave(
      String markEntryId,
      String schoolId,
      String tabulationTypeCode,
      String subjectCaption,
      String division,
      String course,
      String part,
      String subject,
      String subSubject,
      String optionSubject,
      String staffId,
      String staffName,
      String entryMethod,
      String exam,
      bool includeTerminatedStudents,
      String teMax,
      String peMax,
      String ceMax,
      String teCaption,
      String peCaption,
      String ceCaption,
      String examStatus,
      BuildContext context,
      String updatedAt,
      List studentListSave,
      List gradeListSave,
      var partItemm) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoadSave(true);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };

    var request = http.Request(
        'POST', Uri.parse('${UIGuide.baseURL}/markentry-latest/save'));

    request.body = json.encode({
      "markEntryId": markEntryId == "null" ? null : markEntryId,
      "schoolId": schoolId == "null" ? null : schoolId,
      "tabulationTypeCode":
          tabulationTypeCode == "null" ? null : tabulationTypeCode,
      "subjectCaption": subjectCaption == "null" ? null : subjectCaption,
      "division": division == "null" ? null : division,
      "course": course == "null" ? null : course,
      "part": part == "null" ? null : part,
      "subject": subject == "null" ? null : subject,
      "subSubject": subSubject == "null" ? null : subSubject,
      "optionSubject": optionSubject == "null" ? null : optionSubject,
      "staffId": staffId == "null" ? null : staffId,
      "staffName": staffName == "null" ? null : staffName,
      "entryMethod": entryMethod == "null" ? null : entryMethod,
      "exam": exam == "null" ? null : exam,
      "includeTerminatedStudents": includeTerminatedStudents,
      "teMax": teMax == "null" ? null : teMax,
      "peMax": peMax == "null" ? null : peMax,
      "ceMax": ceMax == "null" ? null : ceMax,
      "teCaption": teCaption == "null" ? null : teCaption,
      "peCaption": peCaption == "null" ? null : peCaption,
      "ceCaption": ceCaption == "null" ? null : ceCaption,
      "isBlocked": false,
      "examStatus": examStatus == "null" ? null : examStatus,
      "updatedAt": updatedAt == "null" ? null : updatedAt,
      "markEntryDetails": studentListSave,
      "gradeList": gradeListSave.isEmpty ? null : gradeListSave,
      "partItem": partItemm
    });
    log(request.body);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    setLoadSave(true);

    if (response.statusCode == 200) {
      setLoadSave(true);

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
                await clearStudentMEList();
              },
              btnOkColor: Colors.green)
          .show();

      setLoadSave(false);

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
      setLoadSave(false);
      print('Error Response save');
    }
    setLoadSave(false);
  }

  //State save

  Future markEntrySTATESave(
      String markEntryId,
      String schoolId,
      String tabulationTypeCode,
      String subjectCaption,
      String division,
      String course,
      String part,
      String subject,
      String subSubject,
      String optionSubject,
      String staffId,
      String staffName,
      String entryMethod,
      String exam,
      bool includeTerminatedStudents,
      String teMax,
      String peMax,
      String ceMax,
      String teCaption,
      String peCaption,
      String ceCaption,
      String examStatus,
      BuildContext context,
      String updatedAt,
      List studentListSave,
      List gradeListSave,
      var partItemm) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoadSave(true);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };

    var request = http.Request(
        'POST', Uri.parse('${UIGuide.baseURL}/markentry-latest/state-save/'));

    request.body = json.encode({
      "markEntryId": markEntryId == "null" ? null : markEntryId,
      "schoolId": schoolId == "null" ? null : schoolId,
      "tabulationTypeCode":
          tabulationTypeCode == "null" ? null : tabulationTypeCode,
      "subjectCaption": subjectCaption == "null" ? null : subjectCaption,
      "division": division == "null" ? null : division,
      "course": course == "null" ? null : course,
      "part": part == "null" ? null : part,
      "subject": subject == "null" ? null : subject,
      "subSubject": subSubject == "null" ? null : subSubject,
      "optionSubject": optionSubject == "null" ? null : optionSubject,
      "staffId": staffId == "null" ? null : staffId,
      "staffName": staffName == "null" ? null : staffName,
      "entryMethod": entryMethod == "null" ? null : entryMethod,
      "exam": exam == "null" ? null : exam,
      "includeTerminatedStudents": includeTerminatedStudents,
      "teMax": teMax == "null" ? null : teMax,
      "peMax": peMax == "null" ? null : peMax,
      "ceMax": ceMax == "null" ? null : ceMax,
      "teCaption": teCaption == "null" ? null : teCaption,
      "peCaption": peCaption == "null" ? null : peCaption,
      "ceCaption": ceCaption == "null" ? null : ceCaption,
      "isBlocked": false,
      "examStatus": examStatus == "null" ? null : examStatus,
      "updatedAt": updatedAt == "null" ? null : updatedAt,
      "markEntryDetails": studentListSave,
      "gradeList": gradeListSave.isEmpty ? null : gradeListSave,
      "partItem": partItemm
    });
    log(request.body);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    setLoadSave(true);

    if (response.statusCode == 200) {
      setLoadSave(true);

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
                await clearStudentMEList();
              },
              btnOkColor: Colors.green)
          .show();

      setLoadSave(false);

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
      setLoadSave(false);
      print('Error Response save');
    }
    setLoadSave(false);
  }

  //Verify
  bool _loadVerify = false;
  bool get loadVerify => _loadVerify;
  setLoadVerify(bool value) {
    _loadVerify = value;
    notifyListeners();
  }

  Future markEntryVerify(
      String markEntryId,
      String schoolId,
      String tabulationTypeCode,
      String subjectCaption,
      String division,
      String course,
      String part,
      String subject,
      String subSubject,
      String optionSubject,
      String staffId,
      String staffName,
      String entryMethod,
      String exam,
      bool includeTerminatedStudents,
      String teMax,
      String peMax,
      String ceMax,
      String teCaption,
      String peCaption,
      String ceCaption,
      String examStatus,
      BuildContext context,
      String updatedAt,
      List studentListSave,
      List gradeListSave,
      var partItemm) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoadSave(true);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };

    var request = http.Request(
        'POST', Uri.parse('${UIGuide.baseURL}/markentry-latest/verify'));

    request.body = json.encode({
      "markEntryId": markEntryId == "null" ? null : markEntryId,
      "schoolId": schoolId == "null" ? null : schoolId,
      "tabulationTypeCode":
          tabulationTypeCode == "null" ? null : tabulationTypeCode,
      "subjectCaption": subjectCaption == "null" ? null : subjectCaption,
      "division": division == "null" ? null : division,
      "course": course == "null" ? null : course,
      "part": part == "null" ? null : part,
      "subject": subject == "null" ? null : subject,
      "subSubject": subSubject == "null" ? null : subSubject,
      "optionSubject": optionSubject == "null" ? null : optionSubject,
      "staffId": staffId == "null" ? null : staffId,
      "staffName": staffName == "null" ? null : staffName,
      "entryMethod": entryMethod == "null" ? null : entryMethod,
      "exam": exam == "null" ? null : exam,
      "includeTerminatedStudents": includeTerminatedStudents,
      "teMax": teMax == "null" ? null : teMax,
      "peMax": peMax == "null" ? null : peMax,
      "ceMax": ceMax == "null" ? null : ceMax,
      "teCaption": teCaption == "null" ? null : teCaption,
      "peCaption": peCaption == "null" ? null : peCaption,
      "ceCaption": ceCaption == "null" ? null : ceCaption,
      "isBlocked": false,
      "examStatus": "Entered",
      //examStatus == "null" ? null : examStatus,
      "updatedAt": "2023-07-29",
      // updatedAt == "null" ? null : updatedAt,
      "markEntryDetails": studentListSave,
      "gradeList": null,
      "partItem": partItemm
    });
    log(request.body);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    setLoadSave(true);

    if (response.statusCode == 200) {
      setLoadSave(true);

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
                await clearStudentMEList();
              },
              btnOkColor: Colors.green)
          .show();

      setLoadSave(false);

      notifyListeners();
    } else {
      print(response.reasonPhrase);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        duration: Duration(seconds: 1),
        margin: EdgeInsets.only(bottom: 80, left: 30, right: 30),
        behavior: SnackBarBehavior.floating,
        content: Text(
          'Something Went Wrong ....',
          textAlign: TextAlign.center,
        ),
      ));
      setLoadSave(false);
      print('Error Response Verify');
    }
    setLoadSave(false);
  }

  // clear

  clearStudentMEList() {
    studListUAS.clear();
    gradeListUAS.clear();
    examStatus = '';
    notifyListeners();
  }
}
