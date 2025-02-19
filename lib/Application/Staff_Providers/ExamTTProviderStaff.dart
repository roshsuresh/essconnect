import 'dart:convert';
import 'dart:developer';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Domain/Admin/ExamTTModel.dart';
import '../../Domain/Staff/ExamTTModelStaff.dart';
import '../../Domain/Staff/GallerySendStaff.dart';
import '../../utils/constants.dart';

class ExamTTAdmProvidersStaff with ChangeNotifier {
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

  bool? isClassTeacher;
  List<CourseExam> courseList = [];
  Future getCourseList() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };

    var response = await http.get(
        Uri.parse("${UIGuide.baseURL}/upload-exam-timetable/initialValues"),
        headers: headers);

    if (response.statusCode == 200) {
      final data = await json.decode(response.body);
      Map<String, dynamic> initialStf = await data['initialcombovalues'];

      ExamTTmodelStaff sd =
          ExamTTmodelStaff.fromJson(data!['initialcombovalues']);

      isClassTeacher = sd.isClassTeacher;
      List<CourseExam> templist = List<CourseExam>.from(
          initialStf['courses'].map((x) => CourseExam.fromJson(x)));
      courseList.addAll(templist);

      notifyListeners();
    } else {
      print('Error in Notice stf');
    }
    return true;
  }

  // List<CourseListModel> courseList = [];
  // //List<MultiSelectItem> courseDropDown = [];
  // Future getCourseList() async {
  //   SharedPreferences _pref = await SharedPreferences.getInstance();
  //   var headers = {
  //     'Content-Type': 'application/json',
  //     'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
  //   };

  //   var request = http.Request(
  //       'GET', Uri.parse('${UIGuide.baseURL}/mobileapp/common/courselist'));

  //   request.headers.addAll(headers);

  //   http.StreamedResponse response = await request.send();

  //   if (response.statusCode == 200) {
  //     Map<String, dynamic> data =
  //         jsonDecode(await response.stream.bytesToString());

  //     List<CourseListModel> templist = List<CourseListModel>.from(
  //         data["courseList"].map((x) => CourseListModel.fromJson(x)));
  //     courseList.addAll(templist);

  //     // courseDropDown = courseList.map((subjectdata) {
  //     //   return MultiSelectItem(subjectdata, subjectdata.name!);
  //     // }).toList();

  //     notifyListeners();
  //   } else {
  //     print("Error in Course response");
  //   }
  // }

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

  List<DivisionsExam> divisionList = [];
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
            '${UIGuide.baseURL}/upload-exam-timetable/divisionbycourse/$courseId'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print('object');
    if (response.statusCode == 200) {
      Map<String, dynamic> data =
          jsonDecode(await response.stream.bytesToString());

      log(data.toString());

      List<DivisionsExam> templist = List<DivisionsExam>.from(
          data["divisions"].map((x) => DivisionsExam.fromJson(x)));
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
    divisionDropDown.clear();
    notifyListeners();
  }

  //find image id

  String? imageid;
  Future examImageSave(BuildContext context, String path) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${UIGuide.baseURL}/files/single/School'));
    request.files.add(await http.MultipartFile.fromPath('file', path));
    request.headers.addAll(headers);
    print(path);

    http.StreamedResponse response = await request.send();
    print(request);
    setLoading(true);
    if (response.statusCode == 200) {
      setLoading(true);
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
      setLoading(false);
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
      setLoading(false);
      print(response.reasonPhrase);
    }
  }

  //Exam save
  bool _loadingSave = false;
  bool get loadingSave => _loadingSave;
  setLoadingSave(bool value) {
    _loadingSave = value;
    notifyListeners();
  }

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
    setLoadingSave(true);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    print('$attachmentId  __________________');
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
      setLoadingSave(true);
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
      setLoadingSave(false);
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
      setLoadingSave(false);
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

    if (response.statusCode == 204 || response.statusCode == 200) {
      examlist.removeAt(indexx);
      print(await response.stream.bytesToString());
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
          'Something Went Wrong....',
          textAlign: TextAlign.center,
        ),
      ));
      print('Error in ExamDelete admin');
    }
  }
}
