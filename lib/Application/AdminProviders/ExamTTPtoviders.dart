import 'dart:convert';
import 'dart:developer';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Domain/Admin/Course&DivsionList.dart';
import '../../Domain/Admin/ExamTTModel.dart';
import '../../Domain/Admin/ExamTTModel.dart';
import '../../Domain/Staff/GallerySendStaff.dart';
import '../../Domain/Student/ExamTTModel.dart';
import '../../Presentation/Admin/ExamTimetable/ExamScreen.dart';
import '../../Presentation/Staff/ExamTT.dart/ExamTTScreen.dart';
import '../../utils/constants.dart';

class ExamTTAdmProviders with ChangeNotifier {
  getVariables() {
    startDateD = '';
    startDate = '';
    fromDateDis = '';
    fromDate = '';
    toDateDis = '';
    toDate = '';
    imageid = '';
    notifyListeners();
  }

  DateTime? examStart;
  String startDateD = '';
  String startDate = '';
  late DateTime startDateCheck;
  getExamStartDate(BuildContext context) async {
    examStart = (await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 0)),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: UIGuide.light_Purple,
              colorScheme: const ColorScheme.light(
                primary: UIGuide.light_Purple,
              ),
              buttonTheme:
                  const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child!);
      },
    ));

    startDateD = DateFormat('dd-MM-yyyy').format(examStart!);
    startDate = DateFormat('yyyy-MM-dd').format(examStart!);
    startDateCheck =
        DateTime(examStart!.year, examStart!.month, examStart!.day);
    print(startDateD);
    notifyListeners();
  }

  // Get From date

  DateTime? fromexam;
  String fromDateDis = '';
  String fromDate = '';
  late DateTime fromDateCheck;

  getFromDate(BuildContext context) async {
    fromexam = await showDatePicker(
      context: context,
      initialDate: fromexam ?? DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 0)),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: UIGuide.light_Purple,
              colorScheme: const ColorScheme.light(
                primary: UIGuide.light_Purple,
              ),
              buttonTheme:
                  const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child!);
      },
    );
    fromDateDis = DateFormat('dd-MM-yyyy').format(fromexam!);
    fromDate = DateFormat('yyyy-MM-dd').format(fromexam!);
    fromDateCheck = DateTime(fromexam!.year, fromexam!.month, fromexam!.day);
    print(fromDateDis);
    notifyListeners();
  }

  // Get To date

  DateTime? toexam;
  String toDateDis = '';
  String toDate = '';
  late DateTime toDateCheck;

  getToDate(BuildContext context) async {
    toexam = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 0)),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: UIGuide.light_Purple,
              colorScheme: const ColorScheme.light(
                primary: UIGuide.light_Purple,
              ),
              buttonTheme:
                  const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child!);
      },
    );
    toDateDis = DateFormat('dd-MM-yyyy').format(toexam!);
    toDate = DateFormat('yyyy-MM-dd').format(toexam!);
    toDateCheck = DateTime(toexam!.year, toexam!.month, toexam!.day);
    print(toDateDis);
    notifyListeners();
  }

  List<CourseListModel> courseList = [];
  //List<MultiSelectItem> courseDropDown = [];
  Future getCourseList() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };

    var request = http.Request(
        'GET', Uri.parse('${UIGuide.baseURL}/mobileapp/common/courselist'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Map<String, dynamic> data =
          jsonDecode(await response.stream.bytesToString());

      List<CourseListModel> templist = List<CourseListModel>.from(
          data["courseList"].map((x) => CourseListModel.fromJson(x)));
      courseList.addAll(templist);

      // courseDropDown = courseList.map((subjectdata) {
      //   return MultiSelectItem(subjectdata, subjectdata.name!);
      // }).toList();

      notifyListeners();
    } else {
      print("Error in Course response");
    }
  }

  int divisionLen = 0;
  divisionCounter(int leng) async {
    divisionLen = 0;
    print(divisionLen);
    if (leng == 0) {
      divisionLen = 0;
    } else {
      divisionLen = leng;
    }

    notifyListeners();
  }
  //Division

  List<DivisionListModel> divisionList = [];
  List<MultiSelectItem> divisionDropDown = [];
  Future<bool> getDivisionList(String courseId) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            '${UIGuide.baseURL}/mobileapp/staffdet/studentreport/divisions/$courseId'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print('object');
    if (response.statusCode == 200) {
      Map<String, dynamic> data =
          jsonDecode(await response.stream.bytesToString());

      log(data.toString());

      List<DivisionListModel> templist = List<DivisionListModel>.from(
          data["divisionbyCourse"].map((x) => DivisionListModel.fromJson(x)));
      divisionList.addAll(templist);
      divisionDropDown = divisionList.map((subjectdata) {
        return MultiSelectItem(subjectdata, subjectdata.text!);
      }).toList();
      notifyListeners();
    } else {
      print('Error in DivisionList stf');
    }
    return true;
  }

  divisionClear() {
    divisionList.clear();
    notifyListeners();
  }

  //find image id

  bool _loaddg = false;
  bool get loaddg => _loaddg;
  setLoadddd(bool valu) {
    _loaddg = valu;
    notifyListeners();
  }

  String? imageid;
  Future examImageSave(BuildContext context, String path) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoadddd(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${UIGuide.baseURL}/files/single/School'));
    request.files.add(await http.MultipartFile.fromPath('file', path));
    request.headers.addAll(headers);
    print(path);
    setLoadddd(true);
    http.StreamedResponse response = await request.send();
    print(request);

    if (response.statusCode == 200) {
      setLoadddd(true);
      Map<String, dynamic> data =
          jsonDecode(await response.stream.bytesToString());

      GalleryImageId idd = GalleryImageId.fromJson(data);
      imageid = idd.id;
      print(path);
      print('...............   $imageid');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        duration: Duration(seconds: 1),
        margin: EdgeInsets.only(bottom: 80, left: 30, right: 30),
        behavior: SnackBarBehavior.floating,
        content: Text(
          'File added...',
          textAlign: TextAlign.center,
        ),
      ));
      setLoadddd(false);
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
      print(response.reasonPhrase);
      setLoadddd(false);
    }
  }

  //gallery save

  final List divisionn = [];
  Future examSave(
      context,
      String examStartDate,
      String displayStartDate,
      String displayEndDate,
      String discription,
      String coursee,
      divisionn,
      String attachmentId) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    print('$attachmentId ___________________');
    var request = http.Request(
        'POST',
        Uri.parse(
            '${UIGuide.baseURL}/upload-exam-timetable/save-exam-timeTable'));
    request.body = json.encode({
      "attachmentId": attachmentId,
      "courseId": coursee,
      "description": discription,
      "displayFrom": displayStartDate,
      "displayUpto": displayEndDate,
      "divisionId": divisionn,
      "examStartDate": examStartDate,
      "forClassTeacherOnly": false,
      "staffRole": "null"
    });
    print(json.encode({
      "attachmentId": attachmentId,
      "courseId": coursee,
      "description": discription,
      "displayFrom": displayStartDate,
      "displayUpto": displayEndDate,
      "divisionId": divisionn,
      "examStartDate": examStartDate,
      "forClassTeacherOnly": false,
      "staffRole": "null"
    }));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print('Correct...______________________________');
      await AwesomeDialog(
              context: context,
              dialogType: DialogType.success,
              animType: AnimType.rightSlide,
              headerAnimationLoop: false,
              title: 'Success',
              desc: 'Saved Successfully',
              btnOkOnPress: () {},
              btnOkIcon: Icons.check,
              btnOkColor: Colors.green)
          .show();
      getVariables();
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
    }
  }

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  List<ExamTTModelAdmin> examlist = [];
  Future getExamTimeTableList() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };

    var request = http.Request(
        'GET',
        Uri.parse(
            '${UIGuide.baseURL}/mobileapp/staffdet/upload-exam-timeTable-list'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Map<String, dynamic> data =
          jsonDecode(await response.stream.bytesToString());

      List<ExamTTModelAdmin> templist = List<ExamTTModelAdmin>.from(
          data["uploadExamTimeTableList"]
              .map((x) => ExamTTModelAdmin.fromJson(x)));
      examlist.addAll(templist);
      setLoading(false);
      notifyListeners();
    } else {
      setLoading(false);
      print("Error in ExamTimeTableList response");
    }
  }

  clearTTexamList() {
    examlist.clear();
    notifyListeners();
  }

  //delete
  Future examTTDelete(String eventID, BuildContext context, int indexx) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    var request = http.Request(
        'DELETE',
        Uri.parse(
            '${UIGuide.baseURL}/upload-exam-timetable/delete-exam-timeTable/$eventID'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      examlist.removeAt(indexx);
      print('correct');

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        duration: Duration(seconds: 1),
        margin: EdgeInsets.only(bottom: 80, left: 30, right: 30),
        behavior: SnackBarBehavior.floating,
        content: Text(
          'Deleted Successfully',
          textAlign: TextAlign.center,
        ),
      ));

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
          'Something went wrong..!',
          textAlign: TextAlign.center,
        ),
      ));
      print('Error in ExamDelete admin');
    }
  }


  //Edit Section //
  DateTime? dateTimeEditStart;
  DateTime? dateTimeEditFrom;
  DateTime? dateTimeEditTo;
  EditUploadExamtimetable? EditUploadExamtimetables;
  String createdstaff = "";
  Future examTTEdit(BuildContext context,String? eventID) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };

    var request = http.Request(
        'GET',
        Uri.parse(
            '${UIGuide.baseURL}/upload-exam-timetable/edit-exam-timetable/$eventID'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Map<String, dynamic> data =
      jsonDecode(await response.stream.bytesToString());
      EditUploadExamtimetables = EditUploadExamtimetable.fromJson(data['editUploadExamtimetable']);
      print(EditUploadExamtimetables!.description.toString());
      createdstaff = EditUploadExamtimetables!.createStaffId!;

      dateTimeEditStart = DateTime.parse(EditUploadExamtimetables!.examStartDate!);
      startDateDEdit = DateFormat('dd-MM-yyyy').format(dateTimeEditStart!);
      startDateEdit = DateFormat('yyyy-MM-dd').format(dateTimeEditStart!);
      startDateCheckEdit =
          DateTime(dateTimeEditStart!.year, dateTimeEditStart!.month, dateTimeEditStart!.day);

      dateTimeEditFrom = DateTime.parse(EditUploadExamtimetables!.displayFrom!);
      fromDateDisEdit = DateFormat('dd-MM-yyyy').format(dateTimeEditFrom!);
      fromDateEdit = DateFormat('yyyy-MM-dd').format(dateTimeEditFrom!);
      fromDateCheckEdit = DateTime(dateTimeEditFrom!.year, dateTimeEditFrom!.month, dateTimeEditFrom!.day);

      dateTimeEditTo = DateTime.parse(EditUploadExamtimetables!.displayUpto!);
      toDateDisEdit = DateFormat('dd-MM-yyyy').format(dateTimeEditTo!);
      toDateEdit = DateFormat('yyyy-MM-dd').format(dateTimeEditTo!);
      toDateCheckEdit = DateTime(dateTimeEditTo!.year, dateTimeEditTo!.month, dateTimeEditTo!.day);

      print(startDateDEdit);
      setLoading(false);
      notifyListeners();
    } else {
      setLoading(false);
      print("Error in ExamTimeTableEditList response");
    }
  }


  DateTime? examStartEdit;
  String startDateDEdit = '';
  String startDateEdit = '';
  late DateTime startDateCheckEdit;
  getExamStartDateEdit(BuildContext context) async {
    examStartEdit = (await showDatePicker(
      context: context,
      initialDate: dateTimeEditStart,
      firstDate: DateTime.now().subtract(const Duration(days: 0)),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: UIGuide.light_Purple,
              colorScheme: const ColorScheme.light(
                primary: UIGuide.light_Purple,
              ),
              buttonTheme:
              const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child!);
      },
    ));

    startDateDEdit = DateFormat('dd-MM-yyyy').format(examStartEdit!);
    startDateEdit = DateFormat('yyyy-MM-dd').format(examStartEdit!);
    startDateCheckEdit =
        DateTime(examStartEdit!.year, examStartEdit!.month, examStartEdit!.day);
    print(startDateDEdit);
    notifyListeners();
  }

  // Get From date

  DateTime? fromexamEdit;
  String fromDateDisEdit = '';
  String fromDateEdit = '';
  late DateTime fromDateCheckEdit;

  getFromDateEdit(BuildContext context) async {
    fromexamEdit = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 0)),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: UIGuide.light_Purple,
              colorScheme: const ColorScheme.light(
                primary: UIGuide.light_Purple,
              ),
              buttonTheme:
              const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child!);
      },
    );
    fromDateDisEdit = DateFormat('dd-MM-yyyy').format(fromexamEdit!);
    fromDateEdit = DateFormat('yyyy-MM-dd').format(fromexamEdit!);
    fromDateCheckEdit = DateTime(fromexamEdit!.year, fromexamEdit!.month, fromexamEdit!.day);
    print(fromDateDisEdit);
    notifyListeners();
  }

  // Get To date

  DateTime? toexamEdit;
  String toDateDisEdit = '';
  String toDateEdit = '';
  late DateTime toDateCheckEdit;

  getToDateEdit(BuildContext context) async {
    toexamEdit = await showDatePicker(
      context: context,
      initialDate: dateTimeEditTo,
      firstDate: DateTime.now().subtract(const Duration(days: 0)),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: UIGuide.light_Purple,
              colorScheme: const ColorScheme.light(
                primary: UIGuide.light_Purple,
              ),
              buttonTheme:
              const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child!);
      },
    );
    toDateDisEdit = DateFormat('dd-MM-yyyy').format(toexamEdit!);
    toDateEdit = DateFormat('yyyy-MM-dd').format(toexamEdit!);
    toDateCheckEdit = DateTime(toexamEdit!.year, toexamEdit!.month, toexamEdit!.day);
    print(toDateDisEdit);
    notifyListeners();
  }

  Future examUpdate(
      context,
      String examStartDate,
      String displayStartDate,
      String displayEndDate,
      String discription,
      String coursee,
      divisionn,
      String attachmentId,
      String? eventId) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    print('$attachmentId ___________________');
    var request = http.Request(
        'PATCH',
        Uri.parse(
            '${UIGuide.baseURL}/upload-exam-timetable/update-Exam-timeTable/$eventId'));
    request.body = json.encode({
      "attachmentId": attachmentId,
      "courseId": coursee,
      "description": discription,
      "displayFrom": displayStartDate,
      "displayUpto": displayEndDate,
      "divisionId": divisionn,
      "examStartDate": examStartDate,
      "forClassTeacherOnly": false,
      "staffRole": "null"
    });
    print(request);
    print(json.encode({
      "attachmentId": attachmentId,
      "courseId": coursee,
      "description": discription,
      "displayFrom": displayStartDate,
      "displayUpto": displayEndDate,
      "divisionId": divisionn,
      "examStartDate": examStartDate,
      "forClassTeacherOnly": false,
      'eventId': eventId,
      "staffRole": "null"
    }));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200 || response.statusCode == 204) {
      print('Correct...______________________________');
      await AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          headerAnimationLoop: false,
          title: 'Success',
          desc: 'Updated Successfully',
          btnOkOnPress: () async {
            var parsedResponse = await parseJWT();
            print(parsedResponse['role']);
            if (parsedResponse['role']=="Teacher" || parsedResponse['role'].contains("NonTeachingStaff"))  {
              // Navigator.pushReplacement(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => const ExamTimetableStaff()));
              await Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => ExamTimetableStaff()),
                    (Route<dynamic> route) => route.settings.name == '/' || route.isFirst,
              );
            }
            else
              {
                // Navigator.pushReplacement(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => const ExamTimetable()));
                await Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => ExamTimetable()),
                      (Route<dynamic> route) => route.settings.name == '/' || route.isFirst,
                );
              }
          },
          btnOkIcon: Icons.check,
          btnOkColor: Colors.green)
          .show();
      getVariables();
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
    }
  }

  String? nameExam;
  String? idExam;
  String? extensionExam;
  String? urlExam;
  Future viewAttachmentAdmin(String Id) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };

    var response = await http.get(
        Uri.parse(
            "${UIGuide.baseURL}/upload-exam-timetable/download-exam-timeTable/$Id"),
        headers: headers);

    try {
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(data);
        DownloadExamTimeTableList reattach =
        DownloadExamTimeTableList.fromJson(data['downloadExamTimeTableList']);
        nameExam = reattach.name;
        urlExam = reattach.url;
        extensionExam = reattach.extension;
        idExam = reattach.id;
        notifyListeners();
      } else {
        print("Error in response");
      }
    } catch (e) {
      print(e);
    }
  }


}
