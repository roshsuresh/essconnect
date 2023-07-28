import 'dart:convert';
import 'dart:developer';
import 'package:essconnect/Domain/Staff/MarkEntry/InitailModel.dart';
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

  //markentry view
  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  // List<StudentMEList> studentMEList = [];
  // List<MaxMarkList> maxmarkList = [];
  // List<GradeList> gradeList = [];
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
      String subjectCaption) async {
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
      "includeTerminatedStudents": false,
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

      log(data.toString());
      setLoading(true);

      // List<StudentMEList> templist = List<StudentMEList>.from(
      //     data["studentMEList"].map((x) => StudentMEList.fromJson(x)));
      // studentMEList.addAll(templist);
      // MarkentryViewByStaff daaataa = MarkentryViewByStaff.fromJson(data);
      // typecode = daaataa.typeCode;
      // examStatus = daaataa.examStatus;
      // List<MaxMarkList> templist1 = List<MaxMarkList>.from(
      //     data["maxMarkList"].map((x) => MaxMarkList.fromJson(x)));
      // maxmarkList.addAll(templist1);
      // List<GradeList> templist2 = List<GradeList>.from(
      //     data["gradeList"].map((x) => GradeList.fromJson(x)));
      // gradeList.addAll(templist2);

      setLoading(false);
      notifyListeners();
    } else {
      setLoading(false);
      print('Error in MarkEntryView stf');
    }
    return true;
  }
}
