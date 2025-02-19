import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Domain/Staff/HPC/HPc_Feedback_Model.dart';
import '../../../utils/constants.dart';


class Hpcprovider with ChangeNotifier {


  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  List<Stages> stagelist = [];
  List<Stages> termlist = [];
  List<Stages> courselist = [];
  List<Domains> domainlist = [];
  List<Stages> divisionslist = [];
  List<Activity> activitylist = [];
  List<Ablities> abilitylist = [];
  List<Responses> responseslist = [];
  List<StudentEntries> studententrieslist = [];
  FeedBackEntry? feedbackentry;
  StudentEntries? studententries;
  // List<Ablities> studentabilitieslist = [];



  Future<void> stagelistfn(BuildContext context) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };

    var response = await http.get(
      Uri.parse(
          '${UIGuide.baseURL}/hpc-feedback-entry/initialvalues'),
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
          '${UIGuide.baseURL}/hpc-feedback-entry/stage-change/$stageValue'),
      headers: headers,
    );
    // Log the raw response body to inspect its structure
    log(response.body.toString());

    var data = jsonDecode(response.body.toString());
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
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}',
    };

    var response = await http.get(
      Uri.parse('${UIGuide.baseURL}/hpc-feedback-entry/course-change/$courseValue'),
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
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}',
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
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}',
    };

    var response = await http.get(
      Uri.parse('${UIGuide.baseURL}/hpc-feedback-entry/domain-change/$domainValue'),
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
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
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

  Future<void> viewfn(
      BuildContext context,
      String stage,
      String course,
      String domain,
      String activity,
      String term,
      String division,
      String search,
      bool includeTerminatedStudents,
      String CourseDomain) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };

    var body = jsonEncode({
      "stage": stage,
      "course": course,
      "domain": domain,
      "activity": activity,
      "term": term,
      "division": division,
      "search": search,
      "includeTerminatedStudents": includeTerminatedStudents,
      "CourseDomain": CourseDomain,


    });
    print(body);
    var request = http.Request(
        'POST',
        Uri.parse(
            '${UIGuide.baseURL}/hpc-feedback-entry/view'));
    request.headers.addAll(headers);
    request.body = body;
    http.StreamedResponse response = await request.send();
    print(response);

    setLoading(true);

    if (response.statusCode == 200) {
      final data = await jsonDecode(await response.stream.bytesToString());
      print("Data Fetched successfully .....................................................................");

      List<Ablities> templist7 =
      List<Ablities>.from(data["ablities"].map((x) => Ablities.fromJson(x)));
      abilitylist.addAll(templist7);
      print(abilitylist);

      List<Responses> templist8 =
      List<Responses>.from(data["responses"].map((x) => Responses.fromJson(x)));
      responseslist.addAll(templist8);
      print(responseslist);

      feedbackentry = FeedBackEntry.fromJson(data['feedBackEntry']);


      List<StudentEntries> templist9 =
      List<StudentEntries>.from(data['feedBackEntry']["studentEntries"].map((x) => StudentEntries.fromJson(x)));
      studententrieslist.addAll(templist9);
      print(studententrieslist[0].admissionNo);

      setLoading(false);
    }

    else if(response.statusCode==422){

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

    }
    else {
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


  Future<void> saveFeedbackEntry(BuildContext context,String stage,String course,
      String domain,String activity,
      String term,String division,
      String courseDomain,List studentEntriesList,
      String date,
      bool terminated,String teacherfeedback
      ) async {
    setLoading(true);
    SharedPreferences _pref = await SharedPreferences.getInstance();

    // Prepare the JSON data
    final Map<String, dynamic> feedbackData = {
      "stage": stage,
      "course": course,
      "domain": domain,
      "activity": activity,
      "term": term,
      "division": division,
      "search": "",
      "includeTerminatedStudents": terminated,
      "CourseDomain": courseDomain,
      "studentEntries": studentEntriesList,
      "entryDate": date,
      "teacherFeedBackEntryId": teacherfeedback
    };
  print("passs data");
    log(feedbackData.toString());
    // Send the POST request
    final response = await http.post(
      Uri.parse('${UIGuide.baseURL}/hpc-feedback-entry/save'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
      },
      body: jsonEncode(feedbackData),
    );

    // Check the response
    if (response.statusCode == 200) {
      setLoading(true);
      print('Feedback entry saved successfully!');

      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        text: 'Entry Saved Successfully!',
        confirmBtnColor: UIGuide.light_Purple,
        barrierDismissible: false,
        onConfirmBtnTap: ()async{
          clearlistfn();
          Navigator.pop(context);
         await viewfn(
             context,
             stage, course,
             domain, activity,
             term, division,
             "",
             terminated,
             courseDomain);

        }
      );
      setLoading(false);
      notifyListeners();
      // Handle the response if needed
    } else {
      print('Failed to save feedback entry: ${response.statusCode} ${response.body}');
      setLoading(false);
      notifyListeners();
      // Handle errors here
    }
  }



  //-----------------Verify-----------------

  Future<void> verifyFeedbackEntry(BuildContext context,String stage,String course,
      String domain,String activity,
      String term,String division,
      String courseDomain,List studentEntriesList,
      String date,
      bool terminated,String teacherfeedback,
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
      "term": term,
      "division": division,
      "search": "",
      "includeTerminatedStudents": terminated,
      "CourseDomain": courseDomain,
      "studentEntries": studentEntriesList,
      "entryDate": date,
      "entryStatus":"Entered",
      "updatedStaff":updatedStaff,
      "teacherFeedBackEntryId": teacherfeedback,
      "verifyStaff": ""
    };
    print("passs data");
    log(feedbackData.toString());
    // Send the POST request
    final response = await http.post(
      Uri.parse('${UIGuide.baseURL}/hpc-feedback-entry/verify'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
      },
      body: jsonEncode(feedbackData),
    );

    // Check the response
    if (response.statusCode == 200) {
      setLoading(true);
      print('Feedback entry saved successfully!');

      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
          barrierDismissible: false,
        text: 'Entry Verified Successfully!',
          confirmBtnColor: UIGuide.light_Purple,
          onConfirmBtnTap: ()async{
            clearlistfn();
            Navigator.pop(context);
            await viewfn(
                context,
                stage, course,
                domain, activity,
                term, division,
                "",
                terminated,
                courseDomain);

          }

      );
         setLoading(false);
         notifyListeners();

      // Handle the response if needed
    } else {
      print('Failed to save feedback entry: ${response.statusCode} ${response.body}');
      setLoading(false);
      notifyListeners();
      // Handle errors here
    }
  }

//---------Delete--------------

  Future<void> deleteFeedbackEntry(BuildContext context,String stage,String course,
      String domain,String activity,
      String term,String division,
      String courseDomain,List studentEntriesList,
      String date,
      bool terminated,String teacherfeedback,
      String updatedStaff,String verifiedStaff,String entryStatus
      ) async {
   setLoading(true);
    SharedPreferences _pref = await SharedPreferences.getInstance();
    // Prepare the JSON data
    final Map<String, dynamic> feedbackData = {
      "stage": stage,
      "course": course,
      "domain": domain,
      "activity": activity,
      "term": term,
      "division": division,
      "search": "",
      "includeTerminatedStudents": terminated,
      "CourseDomain": courseDomain,
      "studentEntries": studentEntriesList,
      "entryDate": date,
      "entryStatus":entryStatus,
      "updatedStaff":updatedStaff,
      "teacherFeedBackEntryId": teacherfeedback,
      "verifyStaff": verifiedStaff
    };
    print("passs data");
    log(feedbackData.toString());
    // Send the POST request
    final response = await http.post(
      Uri.parse('${UIGuide.baseURL}/hpc-feedback-entry/delete'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
      },
      body: jsonEncode(feedbackData),
    );

    // Check the response
    if (response.statusCode == 200) {
      setLoading(true);
      print('Feedback entry saved successfully !');

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
          await viewfn(
            context,
            stage,
            course,
            domain,
            activity,
            term,
            division,
            "",
            terminated,
            courseDomain,
          );

          // Show success alert after deletion
          QuickAlert.show(
            context: context,
            barrierDismissible: false,
            type: QuickAlertType.success,
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
      print('Failed to save feedback entry: ${response.statusCode} ${response.body}');
      setLoading(false);
      notifyListeners();
      // Handle errors here
    }
  }
  clearlistfn()
{
  abilitylist.clear();
  responseslist.clear();
  studententrieslist.clear();
}
}