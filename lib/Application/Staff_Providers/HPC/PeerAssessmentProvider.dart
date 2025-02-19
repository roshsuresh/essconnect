import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Domain/Staff/HPC/HPC_PeerAssessment_model.dart';
import '../../../Domain/Staff/HPC/HPc_Feedback_Model.dart';
import '../../../utils/constants.dart';





class HPC_PeerAssessment_Provider with ChangeNotifier {
// String bearer="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiQWFyYWR5YSIsIm5hbWVpZCI6ImFkeWFAZ21haWwuY29tIiwic3ViIjoiQWFyYWR5YSIsImVtYWlsIjoiYWR5YUBnbWFpbC5jb20iLCJqdGkiOiJhNjI2ZGZlZS04MDQ2LTQwMDYtODI0ZC1mNTUwMzU4YWQzZWEiLCJyb2xlIjoiVGVhY2hlciIsIlVzZXJJZCI6IjA5Y2E4NzBmLWQ1MzAtNGFlNy04MDUwLWM3YjQ0ODIwNjMzMyIsIlNjaG9vbElkIjoiYTZkZTVhNzctY2I4Yy00NDU4LTgwZTItMTk1YmYxZTRkMWVmIiwiU2Nob29sTmFtZSI6IkF0aGlyYWNyZXNjZW50LUhQQyIsIk1vZHVsZXMiOiJTQ0gsRkVFLFRULFRBQixPQyxPRSxDQyxBVFQsT0ZGTElORV9BVFQsT0ZGTElORV9UQUIsTU9CX0FQUCxPRkZMSU5FX0ZFRVMsU1RPUkVfRkVFLEhQQyIsIlNob3dNZW51RnJvbVVzZXJQb3dlciI6ImZhbHNlIiwiU3RhZmZJZCI6ImUzM2YwYjkwLWM0NzUtNDRhZi1hYjZiLWYyMDJkZTAzOGRiYSIsIlN0YWZmTmFtZSI6IkFhcmFkeWEiLCJuYmYiOjE3Mjg5OTg5NDIsImV4cCI6MTcyOTAzMTM0MiwiaWF0IjoxNzI4OTk4OTQyLCJpc3MiOiJnamluZm90ZWNoLm5ldCIsImF1ZCI6IkZyb250ZW5kQXBwIn0.MXefG0ZEBaqDKEOrNlTvGa6kmTik0MttISKyHtu8YGw";
  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  List<Stages> stagelist = [];
  List<Stages> termlist = [];
  List<Stages> courselist = [];
  List<Stages> partlist = [];
  List<Domains> domainlist = [];
  List<Stages> divisionslist = [];
  List<Activity> activitylist = [];
  List<Ablities> abilitylist = [];
  List<ResponseLevels> responseslist = [];
  List<StudentEntriesPeerAssessment> studententrieslist = [];
  AssessmentEntry? selfassessmententry;
  //StudentEntries? studententries;
  List<Statements> statementList = [];
  // List<Ablities> studentabilitieslist = [];

  String? assessmentTypeId;
  String? assessmentTypeName;

  Future<void> stagelistfn(BuildContext context) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };

    var response = await http.get(
      Uri.parse(
          '${UIGuide.baseURL}/hpc-assessment-entry/initialvalues/Peer-Assessment'),
      headers: headers,
    );
    // Log the raw response body to inspect its structure
    log(response.body.toString());


    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      // Check if the response is an empty object {} or if the "divisions" field is missing
      if (data.isEmpty || data["stages"] == null) {
        print("Empty or null stages data received.");
        setLoading(false);
        return; // Return early if data is empty or invalid
      }

      // If data is valid, continue processing
      List<Stages> templist3 = List<Stages>.from(
          data["stages"].map((x) => Stages.fromJson(x))
      );
      stagelist.addAll(templist3);
      Assessment ac= Assessment.fromJson(data['assessment']);
      assessmentTypeId = ac.assessmentTypeId;
      assessmentTypeName= ac.assessmentTypeName;


      setLoading(false);
      notifyListeners();
    } else {
      print(response.reasonPhrase);
      setLoading(false);
      notifyListeners();
    }
  }
  Future<void> courselistfn(BuildContext context, String stageValue) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };

    var response = await http.get(
      Uri.parse(
          '${UIGuide.baseURL}/hpc-assessment-entry/stage-change/$stageValue/Peer-Assessment'),
      headers: headers,
    );
    // Log the raw response body to inspect its structure
    log(response.body.toString());


    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      // Check if the response is an empty object {} or if the "divisions" field is missing
      if (data.isEmpty || data["courses"] == null) {
        print("Empty or null course data received.");
        setLoading(false);
        return; // Return early if data is empty or invalid
      }

      // If data is valid, continue processing
      List<Stages> templist4 = List<Stages>.from(
          data["courses"].map((x) => Stages.fromJson(x))
      );
      courselist.addAll(templist4);

      List<Stages> templist5 = List<Stages>.from(
          data["parts"].map((x) => Stages.fromJson(x))
      );
      partlist.addAll(templist5);
      setLoading(false);
      notifyListeners();
    } else {
      print(response.reasonPhrase);
      setLoading(false);

      notifyListeners();
    }
  }
  Future<void> divisionlistfn(BuildContext context, String courseValue) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };

    var response = await http.get(
      Uri.parse('${UIGuide.baseURL}/hpc-assessment-entry/course-change/$courseValue'),
      headers: headers,
    );

    // Log the raw response body to inspect its structure
    log(response.body.toString());

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      // Check if the response is an empty object {} or if the "divisions" field is missing
      if (data.isEmpty || data["divisions"] == null) {
        print("Empty or null divisions data received.");
        setLoading(false);
        return; // Return early if data is empty or invalid
      }

      // If data is valid, continue processing
      List<Stages> templist5 = List<Stages>.from(
          data["divisions"].map((x) => Stages.fromJson(x))
      );

      divisionslist.addAll(templist5);
      setLoading(false);
      notifyListeners();

    } else {
      // Handle error response
      print('Error: ${response.reasonPhrase}');
      setLoading(false);
      notifyListeners();
    }
  }


  Future<void> domainlistfn(BuildContext context, String courseValue, String divisionValue) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };

    var response = await http.get(
      Uri.parse('${UIGuide.baseURL}/hpc-feedback-entry/division-change/$divisionValue/$courseValue'),
      headers: headers,
    );

    // Log the raw response body to inspect its structure
    log(response.body.toString());

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      // Check if the response is an empty object {} or if the "domains" field is missing
      if (data.isEmpty || data["domains"] == null) {
        print("Empty or null domains data received.");
        setLoading(false);
        return; // Return early if data is empty or invalid
      }

      // If data is valid, continue processing
      List<Domains> templist6 = List<Domains>.from(
          data["domains"].map((x) => Domains.fromJson(x))
      );

      domainlist.addAll(templist6);
      setLoading(false);
      notifyListeners();

    } else {
      // Handle error response
      print('Error: ${response.reasonPhrase}');
      setLoading(false);
      notifyListeners();
    }
  }

  Future<void> activitylistfn(BuildContext context, String domainValue) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization':'Bearer ${_pref.getString('accesstoken')}',
    };

    var response = await http.get(
      Uri.parse('${UIGuide.baseURL}/hpc-assessment-entry/domain-change/$domainValue'),
      headers: headers,
    );

    // Log the raw response body to inspect its structure
    log(response.body.toString());

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      // Check if the response is an empty object {}
      if (data.isEmpty || data["activity"] == null) {
        print("Empty or null activity data received.");
        setLoading(false);
        return;
      }

      // If data is valid, continue processing
      List<Activity> templist6 = List<Activity>.from(
          data["activity"].map((x) => Activity.fromJson(x))
      );

      activitylist.addAll(templist6);
      setLoading(false);
      notifyListeners();

    } else {
      // Handle error response
      print('Error: ${response.reasonPhrase}');
      setLoading(false);
      notifyListeners();
    }
  }


  Future termlistfn(
      String stageId,String courseId, String division, String domain,String activity,bool terminated, String coursedomain) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}',
    };

    var request = http.Request(
        'POST', Uri.parse('${UIGuide.baseURL}/hpc-feedback-entry/activity-change'));
    request.body = json.encode({
      "stage": stageId,
      "course": courseId,
      "domain": domain,
      "activity": activity,
      "term": null,
      "division": division,
      "search": "",
      "includeTerminatedStudents": false,
      "CourseDomain": coursedomain
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      setLoading(true);


      final data = await jsonDecode(await response.stream.bytesToString());
      if (data.isEmpty || data["terms"] == null) {
        print("Empty or null terms data received.");
        setLoading(false);
        return;
      }

      // If data is valid, continue processing
      List<Stages> templist7 = List<Stages>.from(
          data["terms"].map((x) => Stages.fromJson(x))
      );

      termlist.addAll(templist7);
      setLoading(false);
      notifyListeners();
    } else {
      setLoading(false);
      print(response.reasonPhrase);
    }
    return true;
  }
String entryStatus="";
  Future<void> viewfnPeerassessment(
      BuildContext context,
      String stage,
      String course,
      String domain,
      String activity,
      String part,
      String division,
      String search,
      bool includeTerminatedStudents,
      String courseDomain,

      ) async
  {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}',
    };

    var body = jsonEncode({
      "stage": stage,
      "course": course,
      "domain": domain,
      "activity": activity,
      "part": part,
      "division": division,
      "search": search,
      "includeTerminatedStudents": includeTerminatedStudents,
      "CourseDomain": courseDomain,
      "AssessmentTypeId": assessmentTypeId, // New data in the request body
      "AssessmentTypeName": assessmentTypeName // New data in the request body
    });
    print("selfbodyyyyyyyyyyyyy");
    print(body);

    var request = http.Request(
        'POST',
        Uri.parse('${UIGuide.baseURL}/hpc-assessment-entry/view')
    );
    request.headers.addAll(headers);
    request.body = body;

    http.StreamedResponse response = await request.send();
    print(response);

    setLoading(true);

    if (response.statusCode == 200) {
      final data = await jsonDecode(await response.stream.bytesToString());
      print("Data Fetched successfully .....................................................................");

      // Parsing statements
      List<Statements> templist7 = List<Statements>.from(
          data["statements"].map((x) => Statements.fromJson(x))
      );
      statementList.addAll(templist7); // Assuming `statementList` is defined elsewhere
      print(statementList);
      print("statements");
      responseslist.clear();


      selfassessmententry = AssessmentEntry.fromJson(data['assessmentEntry']);
      entryStatus=selfassessmententry!.entryStatus.toString();
      print("entry status newwww $entryStatus");
      // Parsing student entries
      List<StudentEntriesPeerAssessment> templist9 = List<StudentEntriesPeerAssessment>.from(
          data['assessmentEntry']["studentEntries"].map((x) => StudentEntriesPeerAssessment.fromJson(x))
      );
      studententrieslist.addAll(templist9); // Assuming studentEntriesList is defined elsewhere
      print(studententrieslist[0].admissionNo);
  print(selfassessmententry!.entryStatus);
      setLoading(false);

    } else if (response.statusCode == 422) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        duration: Duration(seconds: 1),
        margin: EdgeInsets.only(bottom: 20, left: 30, right: 30),
        behavior: SnackBarBehavior.floating,
        content: Text(
          'No student details',
          textAlign: TextAlign.center,
        ),
      ));
      setLoading(false);

    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        duration: Duration(seconds: 1),
        margin: EdgeInsets.only(bottom: 20, left: 30, right: 30),
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


  //saveeeeeeeeeeeeeeeee


  Future<void> savePeerAssessmentEntry(BuildContext context,String stage,String course,
      String domain,String activity,
      String part,String division,
      String courseDomain,List studentEntriesList,
      String date,
      bool terminated,
      ) async {
    setLoading(true);
    SharedPreferences _pref = await SharedPreferences.getInstance();

    // Prepare the JSON data
    final Map<String, dynamic> feedbackData = {
      "stage": stage,
      "course": course,
      "domain": domain,
      "activity": activity,
      "part": part,
      "division": division,
      "search": "",
      "includeTerminatedStudents": terminated,
      "CourseDomain": courseDomain,
      "AssessmentTypeId": assessmentTypeId, // New data in the request body
      "AssessmentTypeName": assessmentTypeName,
      "entryDate": date,
      "studentEntries": studentEntriesList,

    };
    print("passs data");
    print(feedbackData.toString());
    // Send the POST request
    final response = await http.post(
      Uri.parse('${UIGuide.baseURL}/hpc-assessment-entry/save'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${_pref.getString('accesstoken')}',
      },
      body: jsonEncode(feedbackData),
    );

    // Check the response
    if (response.statusCode == 200) {
      setLoading(true);
      print('SelfAssessment entry saved successfully!');

      QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          barrierDismissible: false,
          text: 'Entry Saved Successfully!',
          confirmBtnColor: UIGuide.light_Purple,
          onConfirmBtnTap: ()async{
            print("view fbbbbbbbbbbbbbb333");
            clearlistfn();
            Navigator.pop(context);
            await viewfnPeerassessment(
                context,
                stage, course,
                domain, activity,
                part, division,
                "",
                terminated,
                courseDomain);
            print("view fbbbbbbbbbbbbbb444");


          }
      );
      setLoading(false);
      notifyListeners();
      // Handle the response if needed
    } else {
      print('Failed to save feedback entry: ${response.statusCode} ${response.body}');
      // Handle errors here
      setLoading(false);
      notifyListeners();
    }
  }



  //-----------------Verify-----------------

  Future<void> verifyPeerAssesmentEntry(BuildContext context,String stage,String course,
      String domain,String activity,
      String part,String division,
      String courseDomain,List studentEntriesList,
      String date,
      bool terminated,
      String updatedStaff
      ) async {
    setLoading(true);

    SharedPreferences _pref = await SharedPreferences.getInstance();
    // Prepare the JSON data
    final Map<String, dynamic> feedbackData = {
      "stage": stage,
      "course": course,
      "domain": domain,
      "activity": activity,
      "part": part,
      "division": division,
      "search": "",
      "includeTerminatedStudents": terminated,
      "CourseDomain": courseDomain,
      "AssessmentTypeId": assessmentTypeId,
      "AssessmentTypeName": assessmentTypeName,
      "studentEntries": studentEntriesList,
      "entryDate": date,
    };
    print("passs data");
    log(feedbackData.toString());
    // Send the POST request
    final response = await http.post(
      Uri.parse('${UIGuide.baseURL}/hpc-assessment-entry/verify'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':'Bearer ${_pref.getString('accesstoken')}',
      },
      body: jsonEncode(feedbackData),
    );

    // Check the response
    if (response.statusCode == 200) {
      setLoading(true);
      print('Peer assessmnet entry verified successfully!');

      QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          barrierDismissible: false,
          text: 'Entry Verified Successfully!',
          confirmBtnColor: UIGuide.light_Purple,
          onConfirmBtnTap: ()async{
            clearlistfn();
            print("view fbbbbbbbbbbbbbb1111");
            Navigator.pop(context);
            await viewfnPeerassessment(
                context,
                stage,
                course,
                domain,
                activity,
                part,
                division,
                "",
                terminated,
                courseDomain);
            print("view fbbbbbbbbbbbbbb222222222222");

          }

      );
      setLoading(false);
      notifyListeners();
      // Handle the response if needed
    } else {
      print('Failed to save peer assessment entry: ${response.statusCode} ${response.body}');
      setLoading(false);
      notifyListeners();
      // Handle errors here
    }
  }

//---------Delete--------------

  Future<void> deletePeerssessmentEntry(BuildContext context,String stage,String course,
      String domain,String activity,
      String part,String division,
      String courseDomain,List studentEntriesList,
      String date,
      bool terminated,
      ) async {
    setLoading(true);
    SharedPreferences _pref = await SharedPreferences.getInstance();
    // Prepare the JSON data
    final Map<String, dynamic> feedbackData = {
      "stage": stage,
      "course": course,
      "domain": domain,
      "activity": activity,
      "part": part,
      "division": division,
      "search": "",
      "includeTerminatedStudents": terminated,
      "entryDate":date,
      "CourseDomain": courseDomain,
      "AssessmentTypeId": assessmentTypeId,
      "AssessmentTypeName": assessmentTypeName,
      "studentEntries": studentEntriesList,

    };
    print("passs data");
    log(feedbackData.toString());
    // Send the POST request
    final response = await http.post(
      Uri.parse('${UIGuide.baseURL}/hpc-assessment-entry/delete'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${_pref.getString('accesstoken')}',
      },
      body: jsonEncode(feedbackData),
    );

    // Check the response
    if (response.statusCode == 200) {
      setLoading(true);

      print('Selfassessment entry deleted successfully !');

      QuickAlert.show(
        context: context,
        type: QuickAlertType.confirm,  // Use "confirm" type for confirmation
        text: 'You want to delete this entry !',
        confirmBtnText: 'Yes',
        cancelBtnText: 'No',
        confirmBtnTextStyle: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),
        cancelBtnTextStyle: TextStyle(color: Colors.black45,fontSize: 15,fontWeight: FontWeight.bold),
        confirmBtnColor: UIGuide.THEME_LIGHT,
        onConfirmBtnTap: () async {

          Navigator.pop(context);

          clearlistfn(); // Clear list function
          await viewfnPeerassessment(
            context,
            stage,
            course,
            domain,
            activity,
            part,
            division,
            "",
            terminated,
            courseDomain,
          );

          // Show success alert after deletion
          QuickAlert.show(
            context: context,
            type: QuickAlertType.success,
            barrierDismissible: false,
            text: 'Entry deleted successfully !',
            confirmBtnColor: UIGuide.light_Purple,
            onConfirmBtnTap: () {
              Navigator.pop(context); // Close success alert
            },
          );
        },
        onCancelBtnTap: () {
          Navigator.pop(context);  // Close the confirmation dialog if user cancels
        },
      );
      setLoading(false);
      notifyListeners();
    }
    else {
      print('Failed to delete selfasseesmnet entry: ${response.statusCode} ${response.body}');
     setLoading(false);
     notifyListeners();

      // Handle errors here
    }
  }
  clearlistfn()
  {
    statementList.clear();
    abilitylist.clear();
    responseslist.clear();
    studententrieslist.clear();
  }
}