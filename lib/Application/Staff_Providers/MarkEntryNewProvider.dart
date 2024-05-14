import 'dart:convert';
import 'dart:developer';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:essconnect/Constants.dart';
import 'package:essconnect/Domain/Staff/MarkEntry/InitailModel.dart';
import 'package:essconnect/Domain/Staff/MarkEntry/UASViewModel.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MarkEntryNewProvider with ChangeNotifier {
  //String? examStatus;
  bool? isLocked;
  courseClear() {
    markEntryInitialValues.clear();
    notifyListeners();
  }

  List<MarkEntryInitialValues> markEntryInitialValues = [];
  Future getMarkEntryInitialValues(BuildContext context) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);
    await courseClear();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    try {
      var request = http.Request('GET',
          Uri.parse('${UIGuide.baseURL}/markentry-latest/initialvalues'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        setLoading(true);
        Map<String, dynamic> data =
            jsonDecode(await response.stream.bytesToString());
        MarkEntryViewModel view = MarkEntryViewModel.fromJson(data);
        isLocked = view.isLocked;

        log(data.toString());

        List<MarkEntryInitialValues> templist =
            List<MarkEntryInitialValues>.from(data["courseList"]
                .map((x) => MarkEntryInitialValues.fromJson(x)));
        markEntryInitialValues.addAll(templist);

        print(templist);
        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        print('Error in markEntryInitialValues stf');
      }
    } catch (e) {
      setLoading(false);
    }
  }

// Division

  divisionClear() {
    markEntryDivisionList.clear();
    notifyListeners();
  }

  String? typeCode;
  List<MarkEntryDivisionList> markEntryDivisionList = [];
  Future getMarkEntryDivisionValues(String id, BuildContext context) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    try {
      var request = http.Request('GET',
          Uri.parse('${UIGuide.baseURL}/markentry-latest/coursedetails/$id'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        setLoading(true);
        Map<String, dynamic> data =
            jsonDecode(await response.stream.bytesToString());
        MarkEntryDivisionList inita =
        MarkEntryDivisionList.fromJson(data);
        typeCode = inita.typeCode;
        print("trypecode: $typeCode");

        log(data.toString());

        List<MarkEntryDivisionList> templist = List<MarkEntryDivisionList>.from(
            data["divisionList"].map((x) => MarkEntryDivisionList.fromJson(x)));
        markEntryDivisionList.addAll(templist);
        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        print('Error in MarkEntryDivisionList stf');
      }
    } catch (e) {
      snackbarWidget(4, 'Something Went Wrong....', context);
      setLoading(false);
    }
  }

  //part

  removeAllpartClear() {
    markEntryPartList.clear();
    notifyListeners();
  }

  List<MarkEntryPartList> markEntryPartList = [];
  Future getMarkEntryPartValues(
      String courseId, String divisionId, BuildContext context) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    try {
      var request = http.Request(
          'GET',
          Uri.parse(
              '${UIGuide.baseURL}/markentry-latest/part/$courseId/$divisionId'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        setLoading(true);
        Map<String, dynamic> data =
            jsonDecode(await response.stream.bytesToString());

        log(data.toString());
        MarkEntryPartList inita =
        MarkEntryPartList.fromJson(data);
        typeCode = inita.typeCode;
        print("last coe: $typeCode");

        List<MarkEntryPartList> templist = List<MarkEntryPartList>.from(
            data["parts"].map((x) => MarkEntryPartList.fromJson(x)));
        markEntryPartList.addAll(templist);
        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        print('Error in MarkEntryPartList stf');
      }
    } catch (e) {
      snackbarWidget(4, 'Something Went Wrong....', context);
      setLoading(false);
    }
  }

  //subjectList

  removeAllSubjectClear() {
    markEntrySubjectList.clear();
    notifyListeners();
  }

  List<MarkEntrySubjectList> markEntrySubjectList = [];
  Future getMarkEntrySubjectValues(
      String divionId, String partId, BuildContext context) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    print('object');
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    try {
      var request = http.Request(
          'GET',
          Uri.parse(
              '${UIGuide.baseURL}/markentry-latest/subjects/$divionId/$partId'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        setLoading(true);
        Map<String, dynamic> data =
            jsonDecode(await response.stream.bytesToString());

        log(data.toString());

        List<MarkEntrySubjectList> templist = List<MarkEntrySubjectList>.from(
            data["subjectList"].map((x) => MarkEntrySubjectList.fromJson(x)));
        markEntrySubjectList.addAll(templist);
        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        print('Error in MarkEntrysubjectList stf');
      }
    } catch (e) {
      snackbarWidget(4, 'Something Went Wrong....', context);
      setLoading(false);
    }
  }

//Optional subject List

  removeAllOptionSubjectListClear() {
    markEntryOptionSubjectList.clear();
    notifyListeners();
  }

  List<MarkEntryOptionSubjectModel> markEntryOptionSubjectList = [];
  Future getMarkEntryOptionSubject(String subject, String division, String part,
      BuildContext context) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    try {
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
        setLoading(true);
        print('correct');
        Map<String, dynamic> data =
            jsonDecode(await response.stream.bytesToString());

        log(data.toString());

        List<MarkEntryOptionSubjectModel> templist =
            List<MarkEntryOptionSubjectModel>.from(data['subjectList']
                .map((x) => MarkEntryOptionSubjectModel.fromJson(x)));
        markEntryOptionSubjectList.addAll(templist);
        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        print('Error in markEntryOptionSubjectList stf');
      }
    } catch (e) {
      snackbarWidget(4, 'Something Went Wrong....', context);
      setLoading(false);
    }
  }
  //examList

  removeAllExamClear() {
    markEntryExamList.clear();
    notifyListeners();
  }

  List<MarkEntryExamList> markEntryExamList = [];
  Future getMarkEntryExamValues(String subject, String division, String part,
      String optionSub, BuildContext context) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);
    print('object');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    try {
      var request = http.Request(
          'GET',
          Uri.parse(
              '${UIGuide.baseURL}/markentry-latest/examdetails/?subject=$subject&division=$division&part=$part'));

      request.headers.addAll(headers);
      print(request);
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        setLoading(true);
        print('correct');
        Map<String, dynamic> data =
            jsonDecode(await response.stream.bytesToString());

        log(data.toString());

        List<MarkEntryExamList> templist = List<MarkEntryExamList>.from(
            data["examslist"].map((x) => MarkEntryExamList.fromJson(x)));
        markEntryExamList.addAll(templist);
        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        print('Error in MarkEntryExamList stf');
      }
    } catch (e) {
      snackbarWidget(4, 'Something Went Wrong....', context);
      setLoading(false);
    }
  }

  //exam values with  option sub
  Future getMarkEntryExamValuesOPtion(
      String subject,
      String division,
      String part,
      String optionSub,
      String caption,
      BuildContext context) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);
    print('object');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    try {
      var request = http.Request(
          'GET',
          Uri.parse(
              '${UIGuide.baseURL}/markentry-latest/examdetails/?subject=$subject&division=$division&part=$part&$caption=$optionSub'));

      request.headers.addAll(headers);
      print(request);
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        setLoading(true);
        print('correct');
        Map<String, dynamic> data =
            jsonDecode(await response.stream.bytesToString());

        log(data.toString());

        List<MarkEntryExamList> templist = List<MarkEntryExamList>.from(
            data["examslist"].map((x) => MarkEntryExamList.fromJson(x)));
        markEntryExamList.addAll(templist);
        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        print('Error in MarkEntryExamList stf');
      }
    } catch (e) {
      snackbarWidget(4, 'Something Went Wrong....', context);
      setLoading(false);
    }
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
  bool? existPeAttendance;
  bool? existCeAttendance;
  String? teCaptionUAS;
  String? peCaptionUAS;
  String? ceCaptionUAS;
  bool? isBlockedUAS;
  String? examStatusUAS;
  String? updatedAtUAS;
  var partsUAS;

  List<MarkEntryDetailsUAS> studListUAS = [];
  List<GradeListUAS> gradeListUAS = [];
  Future getMarkEntryUASView(
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
    try {
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
        print("es=xisttttttttttttt $existCeAttendance ");
        setLoading(false);
        List<MarkEntryDetailsUAS> templist = List<MarkEntryDetailsUAS>.from(
            data['markEntry']["markEntryDetails"]
                .map((x) => MarkEntryDetailsUAS.fromJson(x)));
        studListUAS.addAll(templist);
        if (data['markEntry']["gradeList"] != null) {
          List<GradeListUAS> templist1 = List<GradeListUAS>.from(
              data['markEntry']["gradeList"]
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
    } catch (e) {
      setLoading(false);
    }
  }

  //markEntry State View
  List booleanList = [];
  Future getMarkEntrySTATEView(
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
    try {
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
  log(data.toString());
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
        existPeAttendance=marku.existPeAttendance;
        existCeAttendance=marku.existCeAttendance;
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

        for(int i=0;i<studListUAS.length;i++){
          if(studListUAS.isNotEmpty){
            booleanList.add(studListUAS[i].isEdited);
          }
        }
        if (data['markEntry']["gradeList"] != null) {
          List<GradeListUAS> templist1 = List<GradeListUAS>.from(
              data['markEntry']["gradeList"]
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
    } catch (e) {
      setLoading(false);
    }
  }

  bool _loadCommon = false;
  bool get loadCommon => _loadCommon;
  setLoadCommon(bool value) {
    _loadCommon = value;
    notifyListeners();
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
    setLoadCommon(true);
    setLoading(true);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    try {
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
        setLoading(true);
        setLoadSave(true);
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
                  await clearStudentMEList();
                  await getMarkEntryUASView(
                      course,
                      division,
                      exam,
                      part,
                      subject,
                      subSubject,
                      optionSubject,
                      tabulationTypeCode,
                      partItemm,
                      subjectCaption,
                      isTerminated);
                },
                btnOkColor: Colors.green)
            .show();

        setLoadSave(false);
        setLoadCommon(false);
        setLoading(false);

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
        setLoadSave(false);
        setLoading(false);
        setLoadCommon(false);
        print('Error Response save');
      }
    } catch (e) {
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
      setLoadSave(false);
      setLoading(false);
      setLoadCommon(false);
    }
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
    setLoadCommon(true);
    setLoading(true);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    try {
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
        "existPeAttendance": existPeAttendance,
        "existCeAttendance": existCeAttendance,
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

      print("save dattttta");
      log(request.body);
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      setLoadSave(true);

      if (response.statusCode == 200) {
        setLoading(true);
        setLoadSave(true);
        setLoadCommon(true);

        print('Correct........______________________________State');
        log(request.body.toString());
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
                  await getMarkEntrySTATEView(
                      course,
                      division,
                      exam,
                      part,
                      subject,
                      subSubject,
                      optionSubject,
                      tabulationTypeCode,
                      partItemm,
                      subjectCaption,
                      isTerminated);
                },
                btnOkColor: Colors.green)
            .show();

        setLoadSave(false);
        setLoadCommon(false);
        setLoading(false);

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
        setLoadSave(false);
        setLoadCommon(false);
        setLoading(false);
        print('Error Response save');
      }
    } catch (e) {
      snackbarWidget(4, 'Something Went Wrong....', context);

      setLoadSave(false);
      setLoadCommon(false);
      setLoading(false);
    }
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
    setLoadVerify(true);
    setLoadCommon(true);
    setLoading(true);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    try {
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
        "examStatus": examStatus == "null" ? null : examStatus,
        "updatedAt": updatedAt == "null" ? null : updatedAt,
        "markEntryDetails": studentListSave,
        "gradeList": null,
        "partItem": partItemm
      });
      log(request.body);
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      setLoadVerify(true);

      if (response.statusCode == 200) {
        setLoadVerify(true);
        setLoadCommon(true);
        setLoading(true);

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
                  typeCode == 'UAS'
                      ? await getMarkEntryUASView(
                          course,
                          division,
                          exam,
                          part,
                          subject,
                          subSubject,
                          optionSubject,
                          tabulationTypeCode,
                          partItemm,
                          subjectCaption,
                          isTerminated)
                      : await getMarkEntrySTATEView(
                          course,
                          division,
                          exam,
                          part,
                          subject,
                          subSubject,
                          optionSubject,
                          tabulationTypeCode,
                          partItemm,
                          subjectCaption,
                          isTerminated);
                },
                btnOkColor: Colors.green)
            .show();

        setLoadVerify(false);
        setLoadCommon(false);
        setLoading(false);

        notifyListeners();
      } else {
        print(response.reasonPhrase);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          duration: Duration(seconds: 4),
          margin: EdgeInsets.only(bottom: 80, left: 30, right: 30),
          behavior: SnackBarBehavior.floating,
          content: Text(
            'Something Went Wrong ....',
            textAlign: TextAlign.center,
          ),
        ));
        setLoadVerify(false);
        setLoadCommon(false);
        setLoading(false);
        print('Error Response Verify');
      }
    } catch (e) {
      snackbarWidget(4, 'Something Went Wrong....', context);

      setLoadVerify(false);
      setLoadCommon(false);
      setLoading(false);
    }
  }

  //delete

  bool _loadDelete = false;
  bool get loadDelete => _loadDelete;
  setLoadDelete(bool value) {
    _loadDelete = value;
    notifyListeners();
  }

  Future markEntryUASDelete(
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
    setLoadDelete(true);
    setLoadCommon(true);
    setLoading(true);
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
      };

      var request = http.Request(
          'POST', Uri.parse('${UIGuide.baseURL}/markentry-latest/delete'));

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
        "gradeList": null,
        "partItem": partItemm
      });
      log(request.body);
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      setLoadDelete(true);

      if (response.statusCode == 200) {
        setLoadDelete(true);
        setLoadCommon(true);
        setLoading(true);

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
                  await clearStudentMEList();
                },
                btnOkColor: Colors.red)
            .show();

        setLoadDelete(false);
        setLoadCommon(false);
        setLoading(false);

        notifyListeners();
      } else {
        print(response.reasonPhrase);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          duration: Duration(seconds: 4),
          margin: EdgeInsets.only(bottom: 80, left: 30, right: 30),
          behavior: SnackBarBehavior.floating,
          content: Text(
            'Something Went Wrong ....',
            textAlign: TextAlign.center,
          ),
        ));
        setLoadDelete(false);
        setLoadCommon(false);
        setLoading(false);
        print('Error Response Verify');
      }
    } catch (e) {
      snackbarWidget(4, 'Something Went Wrong....', context);

      setLoadDelete(false);
      setLoadCommon(false);
      setLoading(false);
    }
  }

  //State

  Future markEntrySTATEDelete(
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
    setLoadDelete(true);
    setLoadCommon(true);
    setLoading(true);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    print("/state-delete/All");
    try {
      var request = http.Request('POST',
          Uri.parse('${UIGuide.baseURL}/markentry-latest/state-delete/All'));

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
        "gradeList": null,
        "partItem": partItemm
      });
      log(request.body);
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      setLoadDelete(true);

      if (response.statusCode == 200) {
        setLoadDelete(true);
        setLoading(true);
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
                  await clearStudentMEList();
                },
                btnOkColor: Colors.red)
            .show();

        setLoadDelete(false);
        setLoadCommon(false);
        setLoading(false);
        notifyListeners();
      } else {
        print(response.reasonPhrase);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          duration: Duration(seconds: 4),
          margin: EdgeInsets.only(bottom: 80, left: 30, right: 30),
          behavior: SnackBarBehavior.floating,
          content: Text(
            'Something Went Wrong ....',
            textAlign: TextAlign.center,
          ),
        ));
        setLoadDelete(false);
        setLoading(false);
        setLoadCommon(false);
        print('Error Response Verify');
      }
    } catch (e) {
      snackbarWidget(4, 'Something Went Wrong....', context);

      setLoadDelete(false);
      setLoading(false);
      setLoadCommon(false);
    }
  }

  // clear

  clearStudentMEList() {
    studListUAS.clear();
    gradeListUAS.clear();
    examStatusUAS = '';
    notifyListeners();
  }
}
