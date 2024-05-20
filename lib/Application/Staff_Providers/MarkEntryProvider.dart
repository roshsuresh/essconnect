// import 'dart:convert';
// import 'dart:developer';
// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../Domain/Staff/MarkEntryModel.dart';
// import '../../Domain/Staff/MarkentryViewStaff.dart';
// import '../../utils/constants.dart';

// class MarkEntryProvider with ChangeNotifier {
//   String? typecode;
//   String? examStatus;
//   bool? isLocked;
//   courseClear() {
//     markEntryInitialValues.clear();
//     notifyListeners();
//   }

//   List<MarkEntryInitialValues> markEntryInitialValues = [];
//   Future<bool> getMarkEntryInitialValues() async {
//     SharedPreferences _pref = await SharedPreferences.getInstance();

//     var headers = {
//       'Content-Type': 'application/json',
//       'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
//     };
//     var request = http.Request(
//         'GET', Uri.parse('${UIGuide.baseURL}/markentry/initialvalues'));

//     request.headers.addAll(headers);

//     http.StreamedResponse response = await request.send();

//     if (response.statusCode == 200) {
//       Map<String, dynamic> data =
//           jsonDecode(await response.stream.bytesToString());
//       MarkEntryViewModel view = MarkEntryViewModel.fromJson(data);
//       isLocked = view.isLocked;
//       log(data.toString());

//       List<MarkEntryInitialValues> templist = List<MarkEntryInitialValues>.from(
//           data["courseList"].map((x) => MarkEntryInitialValues.fromJson(x)));
//       markEntryInitialValues.addAll(templist);
//       print(templist);
//       notifyListeners();
//     } else {
//       print('Error in markEntryInitialValues stf');
//     }
//     return true;
//   }

// // Division

//   divisionClear() {
//     markEntryDivisionList.clear();
//     notifyListeners();
//   }

//   List<MarkEntryDivisionList> markEntryDivisionList = [];
//   Future<bool> getMarkEntryDivisionValues(String id) async {
//     SharedPreferences _pref = await SharedPreferences.getInstance();

//     var headers = {
//       'Content-Type': 'application/json',
//       'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
//     };
//     var request = http.Request(
//         'GET', Uri.parse('${UIGuide.baseURL}/markentry/coursedetails/$id'));

//     request.headers.addAll(headers);

//     http.StreamedResponse response = await request.send();

//     if (response.statusCode == 200) {
//       Map<String, dynamic> data =
//           jsonDecode(await response.stream.bytesToString());

//       log(data.toString());

//       List<MarkEntryDivisionList> templist = List<MarkEntryDivisionList>.from(
//           data["divisionList"].map((x) => MarkEntryDivisionList.fromJson(x)));
//       markEntryDivisionList.addAll(templist);

//       notifyListeners();
//     } else {
//       print('Error in MarkEntryDivisionList stf');
//     }
//     return true;
//   }

//   //part

//   removeAllpartClear() {
//     markEntryPartList.clear();
//     notifyListeners();
//   }

//   List<MarkEntryPartList> markEntryPartList = [];
//   Future<bool> getMarkEntryPartValues(
//       String courseId, String divisionId) async {
//     SharedPreferences _pref = await SharedPreferences.getInstance();

//     var headers = {
//       'Content-Type': 'application/json',
//       'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
//     };
//     var request = http.Request('GET',
//         Uri.parse('${UIGuide.baseURL}/markentry/part/$courseId/$divisionId'));

//     request.headers.addAll(headers);

//     http.StreamedResponse response = await request.send();

//     if (response.statusCode == 200) {
//       Map<String, dynamic> data =
//           jsonDecode(await response.stream.bytesToString());

//       log(data.toString());

//       List<MarkEntryPartList> templist = List<MarkEntryPartList>.from(
//           data["parts"].map((x) => MarkEntryPartList.fromJson(x)));
//       markEntryPartList.addAll(templist);

//       notifyListeners();
//     } else {
//       print('Error in MarkEntryPartList stf');
//     }
//     return true;
//   }

//   //subjectList

//   removeAllSubjectClear() {
//     markEntrySubjectList.clear();
//     notifyListeners();
//   }

//   List<MarkEntrySubjectList> markEntrySubjectList = [];
//   Future<bool> getMarkEntrySubjectValues(String divionId, String partId) async {
//     SharedPreferences _pref = await SharedPreferences.getInstance();
//     print('object');
//     var headers = {
//       'Content-Type': 'application/json',
//       'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
//     };

//     var request = http.Request('GET',
//         Uri.parse('${UIGuide.baseURL}/markentry/subjects/$divionId/$partId'));

//     request.headers.addAll(headers);

//     http.StreamedResponse response = await request.send();

//     if (response.statusCode == 200) {
//       Map<String, dynamic> data =
//           jsonDecode(await response.stream.bytesToString());

//       log(data.toString());

//       List<MarkEntrySubjectList> templist = List<MarkEntrySubjectList>.from(
//           data["subjectList"].map((x) => MarkEntrySubjectList.fromJson(x)));
//       markEntrySubjectList.addAll(templist);

//       notifyListeners();
//     } else {
//       print('Error in MarkEntrysubjectList stf');
//     }
//     return true;
//   }

// //Optional subject List

//   removeAllOptionSubjectListClear() {
//     markEntryOptionSubjectList.clear();
//     notifyListeners();
//   }

//   List<MarkEntryOptionSubjectModel> markEntryOptionSubjectList = [];
//   Future<bool> getMarkEntryOptionSubject(
//       String subjectId, String divisionId) async {
//     SharedPreferences _pref = await SharedPreferences.getInstance();
//     print('object');
//     var headers = {
//       'Content-Type': 'application/json',
//       'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
//     };

//     var request = http.Request(
//         'GET',
//         Uri.parse(
//             '${UIGuide.baseURL}/markentry/subjectdetails/$subjectId/$divisionId'));
//     print('${UIGuide.baseURL}/markentry/subjectdetails/$subjectId/$divisionId');
//     request.headers.addAll(headers);
//     print('object');
//     http.StreamedResponse response = await request.send();

//     if (response.statusCode == 200) {
//       print('correct');
//       List data = jsonDecode(await response.stream.bytesToString());

//       log(data.toString());

//       List<MarkEntryOptionSubjectModel> templist =
//           List<MarkEntryOptionSubjectModel>.from(
//               data.map((x) => MarkEntryOptionSubjectModel.fromJson(x)));
//       markEntryOptionSubjectList.addAll(templist);

//       notifyListeners();
//     } else {
//       print('Error in markEntryOptionSubjectList stf');
//     }
//     return true;
//   }
//   //examList

//   removeAllExamClear() {
//     markEntryExamList.clear();
//     notifyListeners();
//   }

//   List<MarkEntryExamList> markEntryExamList = [];
//   Future<bool> getMarkEntryExamValues(
//       String subjectId, String divisionId, String partId) async {
//     SharedPreferences _pref = await SharedPreferences.getInstance();
//     print('object');
//     var headers = {
//       'Content-Type': 'application/json',
//       'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
//     };

//     var request = http.Request(
//         'GET',
//         Uri.parse(
//             '${UIGuide.baseURL}/markentry/examdetails/$subjectId/$divisionId/$partId'));

//     request.headers.addAll(headers);
//     print('object');
//     http.StreamedResponse response = await request.send();

//     if (response.statusCode == 200) {
//       print('correct');
//       Map<String, dynamic> data =
//           jsonDecode(await response.stream.bytesToString());

//       log(data.toString());

//       List<MarkEntryExamList> templist = List<MarkEntryExamList>.from(
//           data["examslist"].map((x) => MarkEntryExamList.fromJson(x)));
//       markEntryExamList.addAll(templist);

//       notifyListeners();
//     } else {
//       print('Error in MarkEntryExamList stf');
//     }
//     return true;
//   }

//   //markentry view
//   bool _loading = false;
//   bool get loading => _loading;
//   setLoading(bool value) {
//     _loading = value;
//     notifyListeners();
//   }

//   List<StudentMEList> studentMEList = [];
//   List<MaxMarkList> maxmarkList = [];
//   List<GradeList> gradeList = [];
//   Future<bool> getMarkEntryView(String course, String date, String division,
//       String exam, String part, String subject) async {
//     SharedPreferences _pref = await SharedPreferences.getInstance();
//     setLoading(true);

//     var headers = {
//       'Content-Type': 'application/json',
//       'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
//     };
//     setLoading(true);
//     var request =
//         http.Request('POST', Uri.parse('${UIGuide.baseURL}/markentry/view'));
//     request.body = json.encode({
//       "Course": course,
//       "created date": date,
//       "Division": division,
//       "Exam": exam,
//       "Part": part,
//       "subject": subject,
//       "IsBlocked": "false",
//       "StudentMEDet[0]": "[null]"
//     });
//     request.headers.addAll(headers);
//     setLoading(true);
//     http.StreamedResponse response = await request.send();

//     if (response.statusCode == 200) {
//       setLoading(true);

//       print('---------------------correct--------------------------');
//       Map<String, dynamic> data =
//           jsonDecode(await response.stream.bytesToString());

//       // log(data.toString());
//       setLoading(true);

//       List<StudentMEList> templist = List<StudentMEList>.from(
//           data["studentMEList"].map((x) => StudentMEList.fromJson(x)));
//       studentMEList.addAll(templist);
//       MarkentryViewByStaff daaataa = MarkentryViewByStaff.fromJson(data);
//       typecode = daaataa.typeCode;
//       examStatus = daaataa.examStatus;

//       List<MaxMarkList> templist1 = List<MaxMarkList>.from(
//           data["maxMarkList"].map((x) => MaxMarkList.fromJson(x)));
//       maxmarkList.addAll(templist1);
//       List<GradeList> templist2 = List<GradeList>.from(
//           data["gradeList"].map((x) => GradeList.fromJson(x)));
//       gradeList.addAll(templist2);

//       setLoading(false);
//       notifyListeners();
//     } else {
//       setLoading(false);
//       print('Error in MarkEntryView stf');
//     }
//     return true;
//   }

//   //SAVE
//   bool _load = false;
//   bool get load => _load;
//   setLoad(bool value) {
//     _load = value;
//     notifyListeners();
//   }

//   Future markEntrySave(
//       String course,
//       String divison,
//       String part,
//       String subSubject,
//       String subject,
//       String exam,
//       String date,
//       BuildContext context,
//       List finallList) async {
//     SharedPreferences _pref = await SharedPreferences.getInstance();
//     setLoad(true);

//     var headers = {
//       'Content-Type': 'application/json',
//       'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
//     };

//     var request =
//         http.Request('POST', Uri.parse('${UIGuide.baseURL}/markentry/save'));

//     //request.body = json.encode(finallList);

//     request.body = json.encode({
//       "course": course,
//       "cretedAt": date,
//       "division": divison,
//       "exam": exam,
//       "isBlocked": false,
//       "isDeleteTePeCe": false,
//       "part": part,
//       "search": null,
//       "studentMEDet": finallList,
//       "subSubject": subSubject.isEmpty ? null : subSubject,
//       "subject": subject,
//       "te": null,
//       "tool": null
//     });

//     log("finalelist      $finallList".toString());

//     log(json.encode({
//       "course": course,
//       "cretedAt": date,
//       "division": divison,
//       "exam": exam,
//       "isBlocked": false,
//       "isDeleteTePeCe": false,
//       "part": part,
//       "search": null,
//       "studentMEDet": finallList,
//       "subSubject": subSubject.isEmpty ? null : subSubject,
//       "subject": subject,
//       "te": null,
//       "tool": null
//     }));

//     request.headers.addAll(headers);

//     http.StreamedResponse response = await request.send();
//     setLoad(true);

//     if (response.statusCode == 200) {
//       setLoad(true);

//       print('Correct........______________________________');
//       print(await response.stream.bytesToString());
//       await AwesomeDialog(
//               dismissOnTouchOutside: false,
//               dismissOnBackKeyPress: false,
//               context: context,
//               dialogType: DialogType.success,
//               animType: AnimType.rightSlide,
//               headerAnimationLoop: false,
//               title: 'Success',
//               desc: 'Successfully Saved',
//               btnOkOnPress: () async {
//                 await clearStudentMEList();
//               },
//               btnOkColor: Colors.green)
//           .show();
//       gradeList.clear();
//       setLoad(false);

//       notifyListeners();
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//         elevation: 10,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(20)),
//         ),
//         duration: Duration(seconds: 1),
//         margin: EdgeInsets.only(bottom: 80, left: 30, right: 30),
//         behavior: SnackBarBehavior.floating,
//         content: Text(
//           'Something Went Wrong....',
//           textAlign: TextAlign.center,
//         ),
//       ));
//       setLoad(false);
//       print('Error Response in attendance');
//     }
//     setLoad(false);
//   }

//   //verify
//   bool _loadVerify = false;
//   bool get loadVerify => _loadVerify;
//   setLoadVerify(bool value) {
//     _loadVerify = value;
//     notifyListeners();
//   }

//   Future markEntryVerify(
//       String course,
//       String divison,
//       String part,
//       String subSubject,
//       String subject,
//       String exam,
//       String date,
//       BuildContext context,
//       List finallList) async {
//     SharedPreferences _pref = await SharedPreferences.getInstance();
//     setLoadVerify(true);

//     var headers = {
//       'Content-Type': 'application/json',
//       'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
//     };

//     var request =
//         http.Request('POST', Uri.parse('${UIGuide.baseURL}/markentry/verify'));

//     //request.body = json.encode(finallList);

//     request.body = json.encode({
//       "course": course,
//       "cretedAt": date,
//       "division": divison,
//       "exam": exam,
//       "isBlocked": false,
//       "isDeleteTePeCe": false,
//       "part": part,
//       "search": null,
//       "studentMEDet": finallList,
//       "subSubject": null,
//       "subject": subject,
//       "te": null,
//       "tool": null
//     });

//     log("finalelist      $finallList".toString());

//     log(json.encode({
//       "course": course,
//       "cretedAt": date,
//       "division": divison,
//       "exam": exam,
//       "isBlocked": false,
//       "isDeleteTePeCe": false,
//       "part": part,
//       "search": null,
//       "studentMEDet": finallList,
//       "subSubject": subSubject,
//       "subject": subject,
//       "te": null,
//       "tool": null
//     }));

//     request.headers.addAll(headers);

//     http.StreamedResponse response = await request.send();
//     setLoadVerify(true);
//     if (response.statusCode == 200) {
//       setLoadVerify(true);
//       print('Correct........______________________________');
//       print(await response.stream.bytesToString());
//       await AwesomeDialog(
//               dismissOnTouchOutside: false,
//               dismissOnBackKeyPress: false,
//               context: context,
//               dialogType: DialogType.success,
//               animType: AnimType.rightSlide,
//               headerAnimationLoop: false,
//               title: 'Verified',
//               desc: 'Verified Successfully',
//               btnOkOnPress: () async {
//                 await clearStudentMEList();
//                 Navigator.pop(context);
//               },
//               btnOkColor: Colors.green)
//           .show();

//       setLoadVerify(false);
//       notifyListeners();
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//         elevation: 10,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(20)),
//         ),
//         duration: Duration(seconds: 1),
//         margin: EdgeInsets.only(bottom: 80, left: 30, right: 30),
//         behavior: SnackBarBehavior.floating,
//         content: Text(
//           'Something Went Wrong....',
//           textAlign: TextAlign.center,
//         ),
//       ));
//       setLoadVerify(false);
//       print('Error Response in attendance');
//     }
//     setLoadVerify(false);
//   }

// //delete

//   Future markEntryDelete(
//       String course,
//       String divison,
//       String part,
//       String subSubject,
//       String subject,
//       String exam,
//       String date,
//       BuildContext context,
//       List finallList) async {
//     SharedPreferences _pref = await SharedPreferences.getInstance();
//     setLoading(true);

//     var headers = {
//       'Content-Type': 'application/json',
//       'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
//     };

//     var request =
//         http.Request('POST', Uri.parse('${UIGuide.baseURL}/markentry/delete'));

//     //request.body = json.encode(finallList);

//     request.body = json.encode({
//       "course": course,
//       "cretedAt": date,
//       "division": divison,
//       "exam": exam,
//       "isBlocked": false,
//       "isDeleteTePeCe": false,
//       "part": part,
//       "search": null,
//       "studentMEDet": finallList,
//       "subSubject": null,
//       "subject": subject,
//       "te": null,
//       "tool": null
//     });

//     log("finalelist      $finallList".toString());

//     log(json.encode({
//       "course": course,
//       "cretedAt": date,
//       "division": divison,
//       "exam": exam,
//       "isBlocked": false,
//       "isDeleteTePeCe": false,
//       "part": part,
//       "search": null,
//       "studentMEDet": finallList,
//       "subSubject": subSubject,
//       "subject": subject,
//       "te": null,
//       "tool": null
//     }));

//     request.headers.addAll(headers);

//     http.StreamedResponse response = await request.send();
//     setLoading(true);
//     if (response.statusCode == 200) {
//       setLoading(true);
//       print('Correct........______________________________');
//       print(await response.stream.bytesToString());
//       await AwesomeDialog(
//               dismissOnTouchOutside: false,
//               dismissOnBackKeyPress: false,
//               context: context,
//               dialogType: DialogType.error,
//               animType: AnimType.rightSlide,
//               headerAnimationLoop: false,
//               title: 'Delete',
//               desc: 'Deleted Successfully',
//               btnOkOnPress: () async {
//                 await clearStudentMEList();
//                 Navigator.pop(context);
//               },
//               btnOkColor: Color.fromARGB(255, 217, 14, 14))
//           .show();

//       setLoading(false);
//       notifyListeners();
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//         elevation: 10,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(20)),
//         ),
//         duration: Duration(seconds: 1),
//         margin: EdgeInsets.only(bottom: 80, left: 30, right: 30),
//         behavior: SnackBarBehavior.floating,
//         content: Text(
//           'Something Went Wrong....',
//           textAlign: TextAlign.center,
//         ),
//       ));
//       setLoading(false);
//       print('Error Response in attendance');
//     }
//     setLoading(false);
//   }

//   clearStudentMEList() {
//     studentMEList.clear();
//     maxmarkList.clear();
//     examStatus = '';
//     notifyListeners();
//   }
// }
