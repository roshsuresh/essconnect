import 'dart:convert';
import 'dart:developer';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:essconnect/Domain/Staff/MarkEntry/InitailModel.dart';
import 'package:essconnect/Domain/Staff/MarkEntry/UASViewModel.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Domain/Admin/StudentListModel.dart';
import '../../Domain/Staff/RemarkentryStaff.dart';

class RemarksEntryProvider with ChangeNotifier {
  //String? examStatus;

  courseClear() {
    remarksEntryInitialValues.clear();
    notifyListeners();
  }

  List<RemarksCourseList> remarksEntryInitialValues = [];
  Future<bool> getRemarkEntryInitialValues() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    var request = http.Request(
        'GET', Uri.parse('${UIGuide.baseURL}/remarks-entry/initialvalues'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Map<String, dynamic> data =
      jsonDecode(await response.stream.bytesToString());


      List<RemarksCourseList> templist = List<RemarksCourseList>.from(
          data["courseList"].map((x) => RemarksCourseList.fromJson(x)));
      remarksEntryInitialValues.addAll(templist);
      print(templist);
      notifyListeners();
    } else {
      print('Error in markEntryInitialValues stf');
    }
    return true;
  }

// Division

  divisionClear() {
    remarkEntryDivisionList.clear();
    remarkCategoryList.clear();
    remarkterm.clear();
    notifyListeners();
  }

  String? tabmethod;

  List<RemarkDivisionList> remarkEntryDivisionList = [];
  List<RemarksCategoryList> remarkCategoryList = [];
  List<RemarksTermlist> remarkterm = [];
  Future<bool> getRemarkEntryDivisionValues(String id,String instId) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    var request = http.Request('GET',
        Uri.parse('${UIGuide.baseURL}/remarks-entry/division/$id/$instId'));


    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Map<String, dynamic> data =
      jsonDecode(await response.stream.bytesToString());
      RemarkDivisionInitialValues inita =
      RemarkDivisionInitialValues.fromJson(data);
      tabmethod = inita.tabulationMethod;
      print("tabemthd: $tabmethod");
     print("division and term");
      log(data.toString());

      List<RemarkDivisionList> templist = List<RemarkDivisionList>.from(
          data["divisionList"].map((x) => RemarkDivisionList.fromJson(x)));
      remarkEntryDivisionList.addAll(templist);
      List<RemarksCategoryList> templist1 = List<RemarksCategoryList>.from(
          data["remarksCategoryList"].map((x) => RemarksCategoryList.fromJson(x)));
      remarkCategoryList.addAll(templist1);
      List<RemarksTermlist> templist2 = List<RemarksTermlist>.from(
          data["termList"].map((x) => RemarksTermlist.fromJson(x)));
      remarkterm.addAll(templist2);

      notifyListeners();
    } else {
      print('Error in MarkEntryDivisionList stf');
    }
    return true;
  }

  //term

  removeAllTermClear() {
    remarkTermList.clear();
    notifyListeners();
  }

  List<RemarksTermlist>remarkTermList = [];
  Future<bool> getRemarkEntryTermValues(
       String divisionId,String assessmentId,String assessment,String instId) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            '${UIGuide.baseURL}/remarks-entry/term/$divisionId/$assessmentId/$instId'));
  print(request);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Map<String, dynamic> data =
      jsonDecode(await response.stream.bytesToString());

      log(data.toString());
      print(assessment);

        List<RemarksTermlist> templist = List<RemarksTermlist>.from(
            data["termlist"].map((x) => RemarksTermlist.fromJson(x)));
        print("termlisssss");
        remarkTermList.addAll(templist);

      // else{
      //   List<RemarksTermlist> templist1 = List<RemarksTermlist>.from(
      //       data["assessmentList"].map((x) => RemarksTermlist.fromJson(x)));
      //   remarkTermList.addAll(templist1);
      // }


      notifyListeners();
    } else {
      print('Error in MarkEntryPartList stf');
    }
    return true;
  }

  //Assessment

  removeAllAssessmentClear() {
    remarkEntryAssessmentList.clear();
    notifyListeners();
  }

  List<RemarksAssessmentList> remarkEntryAssessmentList = [];
  Future<bool> getRemarkEntryAssessmentValues(String divionId, String assessmentId,String termId,String instId) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    print('object');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };

    var request = http.Request(
        'GET',
        Uri.parse(
            '${UIGuide.baseURL}/remarks-entry/assessment/$divionId/$assessmentId/$instId/$termId'));

    request.headers.addAll(headers);
    print(request);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Map<String, dynamic> data =
      jsonDecode(await response.stream.bytesToString());

      log(data.toString());

      List<RemarksAssessmentList> templist = List<RemarksAssessmentList>.from(
          data["assessmentList"].map((x) => RemarksAssessmentList.fromJson(x)));
      remarkEntryAssessmentList.addAll(templist);

      notifyListeners();
    } else {
      print('Error in MarkEntrysubjectList stf');
    }
    return true;
  }

  bool isTerminated = false;

  terminatedCheckbox() {
    isTerminated = !isTerminated;
    notifyListeners();
  }


  //remarkentry view
  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }
  clearStuentList(){
    studListRemarks.clear();
    remarksMaster.clear();
    notifyListeners();
  }



//VIEW
  String? course;
  String? division;
  String? category;
  String? term;
  String? assessment;
  bool? terminated;



  List<RemarksStudentList> studListRemarks = [];
  List<RemarkMasterList> remarksMaster = [];
  String remarksEntryId='';
  Future<bool> getRemarksEntryView(
      String course,
      String division,
      String category,
      String term,
      String assessment,
      bool terminated,
      bool isAssessment,
      bool isTerm,
      String tabCode) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    setLoading(true);
    var request = http.Request(
        'POST', Uri.parse('${UIGuide.baseURL}/remarks-entry/view'));
    print(request);
    request.body = json.encode({
      "course": course == "null" ? null : course,
      "division": division == "null" ? null : division,
      "category": category == "null" ? null : category,
      "term": term == "null" ? null : term,
      "assessment": assessment == "null" ? null : assessment,
      "includeTerminatedStudents": terminated,
      "IsAssessment": isAssessment,
      "IsTerm": isTerm,
      "TabulationType" :tabCode


    });
    print(request.body);

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

      List<RemarksStudentList> templist = List<RemarksStudentList>.from(
          data['studentList']
              .map((x) => RemarksStudentList.fromJson(x)));
      studListRemarks.addAll(templist);

        List<RemarkMasterList> templist1 = List<RemarkMasterList>.from(data['remarkMasterList']
            .map((x) => RemarkMasterList.fromJson(x)));
        remarksMaster.addAll(templist1);
        remarksEntryId=studListRemarks[0].remarksEntryId.toString();



      notifyListeners();
      setLoading(false);
    } else {
      setLoading(false);
      print('Error in MarkEntryView UAS');
    }

    return true;
  }


//ATTACHMENT


  //attachment
  String? name;
  String? extension;
  String? path;
  String? url;
  String? id;

  Future markHistoryAttachment(
      String rollNo, String studentId, String studName, String remarks,
      String remarksMasterId, String fileId, String remarksEntryId,
      String remarksEntryDetId
      ) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    var request = await  http.Request('GET', Uri.parse(
            "${UIGuide.baseURL}/remarks-entry/preview/?rollNo=$rollNo&studentId=$studentId&name=$studName&remarks=$remarks&remarksMasterId=$remarksMasterId&fileId=$fileId&remarksEntryId=$remarksEntryId&remarksEntryDetId=$remarksEntryDetId"));
    request.headers.addAll(headers);
    print(request);

    http.StreamedResponse response = await request.send();

    print(response);
    if (response.statusCode == 200) {

      print('correct');

      Map<String, dynamic> data =
      jsonDecode(await response.stream.bytesToString());
      MarkHistoryAttachment attach = MarkHistoryAttachment.fromJson(data);
       name= attach.name.toString();
       print(name);
       extension =attach.extension.toString();
       path =attach.path.toString();
       url=attach.url.toString();
       id= attach.id.toString();


      notifyListeners();
    } else {
      setLoading(false);
      print('Error in Response');
    }
    return response.statusCode;
  }

 // public -attachment

  Future markHistoryPublicAttachment(
      String rollNo, String studentId, String studName,
      String fileId, String remarksEntryId,
      String remarksEntryDetId
      ) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    var request = await  http.Request('GET', Uri.parse(
        "${UIGuide.baseURL}/remarks-entry/preview/?rollNo=$rollNo&studentId=$studentId&name=$studName&fileId=$fileId&remarksEntryId=$remarksEntryId&remarksEntryDetId=$remarksEntryDetId"));
    request.headers.addAll(headers);
    print(request);

    http.StreamedResponse response = await request.send();

    print(response);
    if (response.statusCode == 200) {
      setLoading(true);
      print('correct');

      Map<String, dynamic> data =
      jsonDecode(await response.stream.bytesToString());
      MarkHistoryAttachment attach = MarkHistoryAttachment.fromJson(data);
      name= attach.name.toString();
      print(name);
      extension =attach.extension.toString();
      path =attach.path.toString();
      url=attach.url.toString();
      id= attach.id.toString();

      setLoading(false);
      notifyListeners();
    } else {
      setLoading(false);
      print('Error in Response');
    }
    return response.statusCode;
  }


  //SAVE
  bool _loadSave = false;
  bool get loadSave => _loadSave;
  setLoadSave(bool value) {
    _loadSave = value;
    notifyListeners();
  }

  Future remarkEntrySave(
      String course,
      String division,
      String category,
      String term,
      String assessment,
      bool includeTerminatedStudents,
      bool isAssessment,
      bool isTerm,
      String tabmethod,
      BuildContext context,
      List studentListSave,
      ) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoadSave(true);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };

    var request = http.Request(
        'POST', Uri.parse('${UIGuide.baseURL}/remarks-entry/save'));

    request.body = json.encode({
      "course": course == "null" ? null : course,
      "division": division == "null" ? null : division,
      "category": category == "null" ? null : category,
      "term": term == "null" ? null : term,
      "assessment": assessment == "null" ? null : assessment,
      "includeTerminatedStudents": includeTerminatedStudents,
      "IsAssessment": isAssessment,
      "IsTerm": isTerm,
      "TabulationMethod": tabmethod == "null" ? null : tabmethod,
      "StudentList": studentListSave,

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
            await clearStuentList();
            await getRemarksEntryView(
                 course,
                 division,
                 category,
                 term,
                 assessment,
                 isTerminated,
                isAssessment,
                isTerm,
              tabmethod
            );
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

  //delete

  bool _loadDelete = false;
  bool get loadDelete => _loadDelete;
  setLoadDelete(bool value) {
    _loadDelete = value;
    notifyListeners();
  }

  Future remarkEntryDelete(
      String course,
      String division,
      String category,
      String term,
      String assessment,
      bool includeTerminatedStudents,
      String remarkEntryId,
      String tabmethod,
      BuildContext context,
      ) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoadDelete(true);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };

    var request = http.Request(
        'POST', Uri.parse('${UIGuide.baseURL}/remarks-entry/delete'));
    print(request);

    request.body = json.encode({
      "RemarkeDetails":{
        "course": course,
        "division": division,
        "category": category,
        "term": term,
        "assessment": assessment,
        "includeTerminatedStudents": includeTerminatedStudents
      },
      "RemarksEntryId":remarkEntryId,
      "TabulationMethod":tabmethod
    });
    log(request.body);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    setLoadDelete(true);

    if (response.statusCode == 200) {
      setLoadDelete(true);

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
            await clearStuentList();
          },
          btnOkColor: Colors.red)
          .show();

      setLoadDelete(false);

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
      setLoadDelete(false);
      print('Error Response Verify');
    }
    setLoadDelete(false);
  }


 }
