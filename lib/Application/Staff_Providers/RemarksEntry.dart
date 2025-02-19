import 'dart:convert';
import 'dart:developer';
import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../Constants.dart';
import '../../Domain/Staff/RemarkentryStaff.dart';
import '../../utils/constants.dart';

class RemarksEntryProvider with ChangeNotifier {
  //String? examStatus;

  courseClear() {
    remarksEntryInitialValues.clear();
    notifyListeners();
  }

  List<RemarksCourseList> remarksEntryInitialValues = [];
  Future getRemarkEntryInitialValues(BuildContext context) async {
    await courseClear();
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    try {
      var request = http.Request(
          'GET', Uri.parse('${UIGuide.baseURL}/remarks-entry/initialvalues'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        setLoading(true);
        Map<String, dynamic> data =
            jsonDecode(await response.stream.bytesToString());

        List<RemarksCourseList> templist = List<RemarksCourseList>.from(
            data["courseList"].map((x) => RemarksCourseList.fromJson(x)));
        remarksEntryInitialValues.addAll(templist);
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
    remarkEntryDivisionList.clear();
    remarkCategoryList.clear();
    remarkterm.clear();
    notifyListeners();
  }

  String? tabmethod;

  List<RemarkDivisionList> remarkEntryDivisionList = [];

  List<RemarksTermlist> remarkterm = [];
  Future getRemarkEntryDivisionValues(
      String id, String instId, BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoading(true);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    try {
      var request = http.Request('GET',
          Uri.parse('${UIGuide.baseURL}/remarks-entry/division/$id/$instId'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        setLoading(true);
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

        List<RemarksTermlist> templist2 = List<RemarksTermlist>.from(
            data["termList"].map((x) => RemarksTermlist.fromJson(x)));
        remarkterm.addAll(templist2);
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

//Category
  List<RemarksCategoryList> remarkCategoryList = [];
  Future getRemarkEntryCategoryValues(
      String divid, String instId, BuildContext context) async {
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
              '${UIGuide.baseURL}/remarks-entry/category/$divid/$instId'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        setLoading(true);
        Map<String, dynamic> data =
            jsonDecode(await response.stream.bytesToString());

        List<RemarksCategoryList> templist1 = List<RemarksCategoryList>.from(
            data["remarksCategoryList"]
                .map((x) => RemarksCategoryList.fromJson(x)));
        remarkCategoryList.addAll(templist1);
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

  //term

  removeAllTermClear() {
    remarkTermList.clear();
    notifyListeners();
  }

  List<RemarksTermlist> remarkTermList = [];
  Future getRemarkEntryTermValues(String divisionId, String? assessmentId,
      String instId, String tabmthd, BuildContext context) async {
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
              '${UIGuide.baseURL}/remarks-entry/term/$divisionId/$assessmentId/$instId/$tabmthd'));
      print("demooooooo");
      print(request);
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        setLoading(true);
        Map<String, dynamic> data =
            jsonDecode(await response.stream.bytesToString());

        log(data.toString());
        print(assessment);

        List<RemarksTermlist> templist = List<RemarksTermlist>.from(
            data["termlist"].map((x) => RemarksTermlist.fromJson(x)));
        print("termlisssss");
        remarkTermList.addAll(templist);
        setLoading(false);

        // else{
        //   List<RemarksTermlist> templist1 = List<RemarksTermlist>.from(
        //       data["assessmentList"].map((x) => RemarksTermlist.fromJson(x)));
        //   remarkTermList.addAll(templist1);
        // }

        notifyListeners();
      } else {
        setLoading(false);
        print('Error in category stf');
      }
    } catch (e) {
      snackbarWidget(4, 'Something Went Wrong....', context);
      setLoading(false);
    }
  }

  //Assessment

  removeAllAssessmentClear() {
    remarkEntryAssessmentList.clear();
    notifyListeners();
  }

  List<RemarksAssessmentList> remarkEntryAssessmentList = [];
  Future getRemarkEntryAssessmentValues(String divionId, String assessmentId,
      String termId, String instId, BuildContext context) async {
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
              '${UIGuide.baseURL}/remarks-entry/assessment/$divionId/$assessmentId/$instId/$termId'));

      request.headers.addAll(headers);
      print(request);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        setLoading(true);
        Map<String, dynamic> data =
            jsonDecode(await response.stream.bytesToString());

        log(data.toString());

        List<RemarksAssessmentList> templist = List<RemarksAssessmentList>.from(
            data["assessmentList"]
                .map((x) => RemarksAssessmentList.fromJson(x)));
        remarkEntryAssessmentList.addAll(templist);
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

  clearStuentList() {
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
  // String remarksEntryId='';
  Future getRemarksEntryView(
      String course,
      String division,
      String category,
      String term,
      String assessment,
      bool terminated,
      bool isAssessment,
      bool isTerm,
      String tabCode) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoading(true);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    try {
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
        "TabulationType": tabCode
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
            data['studentList'].map((x) => RemarksStudentList.fromJson(x)));
        studListRemarks.addAll(templist);

        List<RemarkMasterList> templist1 = List<RemarkMasterList>.from(
            data['remarkMasterList'].map((x) => RemarkMasterList.fromJson(x)));
        remarksMaster.addAll(templist1);
        // remarksEntryId=studListRemarks[0].remarksEntryId.toString();

        notifyListeners();
        setLoading(false);
      } else {
        setLoading(false);
        print('Error in MarkEntryView UAS');
      }
    } catch (e) {
      setLoading(false);
    }
  }

//ATTACHMENT

  //attachment
  String? name;
  String? extension;
  String? path;
  String? url;
  String? id;

  Future markHistoryAttachment(
      String rollNo,
      String studentId,
      String studName,
      String remarks,
      String remarksMasterId,
      String fileId,
      String remarksEntryId,
      String remarksEntryDetId) async {
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
              "${UIGuide.baseURL}/remarks-entry/preview/?rollNo=$rollNo&studentId=$studentId&name=$studName&remarks=$remarks&remarksMasterId=$remarksMasterId&fileId=$fileId&remarksEntryId=$remarksEntryId&remarksEntryDetId=$remarksEntryDetId"));
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
        name = attach.name.toString();
        print(name);
        extension = attach.extension.toString();
        path = attach.path.toString();
        url = attach.url.toString();
        id = attach.id.toString();
        setLoading(false);

        notifyListeners();
      } else {
        setLoading(false);
        print('Error in Response');
      }
    } catch (e) {
      setLoading(false);
    }
    // return response.statusCode;
  }

  // public -attachment

  Future markHistoryPublicAttachment(
      String rollNo,
      String studentId,
      String studName,
      String fileId,
      String remarksEntryId,
      String remarksEntryDetId) async {
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
        name = attach.name.toString();
        print(name);
        extension = attach.extension.toString();
        path = attach.path.toString();
        url = attach.url.toString();
        id = attach.id.toString();

        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        print('Error in Response');
      }
    } catch (e) {
      setLoading(false);
    }
  }

  //SAVE
  bool _loadSave = false;
  bool get loadSave => _loadSave;
  setLoadSave(bool value) {
    _loadSave = value;
    notifyListeners();
  }

  //commonload
  bool _commonload = false;
  bool get commonload => _commonload;
  setCommonLoad(bool value) {
    _commonload = value;
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
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoadSave(true);
    setLoading(true);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
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
    try {
      if (response.statusCode == 200) {
        setLoadSave(true);
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
                      tabmethod);
                },
                btnOkColor: Colors.green)
            .show();

        setLoadSave(false);
        setLoading(false);
        setCommonLoad(false);

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
        setLoading(false);
        print('Error Response save');
      }
    } catch (e) {
      setLoading(false);
      setLoadSave(false);
      snackbarWidget(4, 'Something Went Wrong....', context);
    }
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
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoadDelete(true);
    setLoading(true);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    try {
      var request = http.Request(
          'POST', Uri.parse('${UIGuide.baseURL}/remarks-entry/delete'));
      print(request);

      request.body = json.encode({
        "RemarkeDetails": {
          "course": course,
          "division": division,
          "category": category,
          "term": term,
          "assessment": assessment,
          "includeTerminatedStudents": includeTerminatedStudents
        },
        "RemarksEntryId": remarkEntryId,
        "TabulationMethod": tabmethod
      });
      log(request.body);
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      setLoadDelete(true);

      if (response.statusCode == 200) {
        setLoading(true);
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
        setLoading(false);

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
        setLoading(false);
        print('Error Response Verify');
      }
    } catch (e) {
      setLoadDelete(false);
      setLoading(false);
      snackbarWidget(4, 'Something Went Wrong....', context);
    }
  }
}
