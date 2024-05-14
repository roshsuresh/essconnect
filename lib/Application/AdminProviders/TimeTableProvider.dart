
import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Domain/Admin/TimeTableUploadModel.dart';
import '../../Domain/Staff/GallerySendStaff.dart';
import '../../utils/constants.dart';

class TimeTableUploadProvider with ChangeNotifier {

  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  bool _load = false;

  bool get load => _load;

  setLoad(bool value) {
    _load = value;
    notifyListeners();
  }

  bool _loadingCourse = false;

  bool get loadingCourse => _loadingCourse;

  setloadingCourse(bool value) {
    _loadingCourse = value;
    notifyListeners();
  }

  bool _loadingDivision = false;

  bool get loadingDivision => _loadingDivision;

  setloadingDivision(bool value) {
    _loadingDivision = value;
    notifyListeners();
  }
  bool _loadingSection = false;

  bool get loadingSection => _loadingSection;

  setloadingSection(bool value) {
    _loadingSection = value;
    notifyListeners();
  }

  int courseLen = 0;

  courseCounter(int len) async {
    courseLen = 0;
    if (len == 0) {
      courseLen = 0;
    } else {
      courseLen = len;
    }

    notifyListeners();
  }

  int secLen = 0;

  sectionCounter(int len) async {
    secLen = 0;
    if (len == 0) {
      secLen = 0;
    } else {
      secLen = len;
    }

    notifyListeners();
  }


  clearList() {
    divisionList.clear();

    notifyListeners();
  }


  clearStaffList() {
    staffListfull.clear();
    staffList.clear();

    notifyListeners();
  }
  List<Sections> sectionList = [];
  List<Courses> courseList = [];
  List<MultiSelectItem> sectionDrop = [];
  List<MultiSelectItem> courseDrop = [];

  Future getCourseList() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setloadingCourse(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };

    var request = http.Request(
        'GET',
        Uri.parse('${UIGuide.baseURL}/Upload-Timetable/getinitialvalues'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Map<String, dynamic> data =
      jsonDecode(await response.stream.bytesToString());

      List<Sections> templist = List<Sections>.from(
          data["sections"].map((x) => Sections.fromJson(x)));
      sectionList.addAll(templist);
      sectionDrop = sectionList.map((subjectdata) {
        return MultiSelectItem(subjectdata, subjectdata.text ?? "");
      }).toList();

      List<Courses> templist1 = List<Courses>.from(
          data["courses"].map((x) => Courses.fromJson(x)));
      courseList.addAll(templist1);
      courseDrop = courseList.map((subjectdata) {
        return MultiSelectItem(subjectdata, subjectdata.text ?? "");
      }).toList();
      setloadingCourse(false);
      notifyListeners();
    } else {
      setloadingCourse(false);
      print("Error in Course response");
    }
  }

//divlist
  List<Divisions> divisionList = [];
  List<MultiSelectItem> divisionDrop = [];

  Future<bool> getDivisionList(String courseId) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            '${UIGuide.baseURL}/Upload-Timetable/divisions?course=$courseId'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print(response);

    if (response.statusCode == 200) {
      setloadingDivision(true);
      List<dynamic> data =
      jsonDecode(await response.stream.bytesToString());

      List<Divisions> templist = List<Divisions>.from(
          data.map((x) => Divisions.fromJson(x)));
      divisionList.addAll(templist);
      print(divisionList);
      divisionDrop = divisionList.map((subjectdata) {
        return MultiSelectItem(subjectdata, subjectdata.text ?? "");
      }).toList();
      setLoading(false);
      notifyListeners();
    }
    else {
      print('Error in Division response ');
      setLoading(false);
    }
    return true;
  }

  //image Save

  String? imageid;

  Future timetableImagesave(BuildContext context, String path) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${UIGuide.baseURL}/files/single/Students'));
    request.files.add(await http.MultipartFile.fromPath('file', path));
    request.headers.addAll(headers);
    print(path);
    setLoading(true);
    http.StreamedResponse response = await request.send();
    print(request);

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
      print(response.reasonPhrase);
      setLoading(false);
    }
  }


  //Upload

  Future timeTableUpload(context,
      String divisionId,
      String divName,
      String fileId,) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    print('$fileId ___________________');
    var request = http.Request(
        'POST',
        Uri.parse(
            '${UIGuide.baseURL}/Upload-Timetable/class-timetable-upload'));
    request.body = json.encode({
      "value": divisionId,
      "text": divName,
      "fileId": fileId,
      "classTTUploadId": null
    });
    print(
        json.encode({
          "value": divisionId,
          "text": divName,
          "fileId": fileId,
          "classTTUploadId": null
        })
    );
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 204) {
      print('Correct...______________________________');
      await AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          headerAnimationLoop: false,
          title: 'Success',
          desc: 'Uploaded Successfully',
          btnOkOnPress: () {},
          btnOkIcon: Icons.cancel,
          btnOkColor: Colors.green)
          .show();
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

  //TimeTableView
  String? url;
  String? id;
  String? extension;
  String? name;

  Future getTimeTableView(String divId) async {
    setLoad(true);
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    setLoad(true);
    var response = await http.get(
        Uri.parse(
            "${UIGuide
                .baseURL}/Upload-Timetable/class-timetable-download/$divId"),
        headers: headers);
    print(response);
    setLoad(true);
    try {
      if (response.statusCode == 200) {
        print("corectss");
        Map<String, dynamic> data = json.decode(response.body);
        TimeTableView tt = TimeTableView.fromJson(data);

        url = tt.url;
        extension = tt.extension;
        id = tt.extension;
        name = tt.name;
        print(url);

        setLoad(false);
        notifyListeners();
      } else {
        setLoad(false);
        print("Error in response");
      }
    } catch (e) {
      print(e);
    }
  }

  //delete

  Future timtableDelete(BuildContext context, String divId, String fileId,
      int indexx) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    var request = http.Request('DELETE',
        Uri.parse('${UIGuide
            .baseURL}/Upload-Timetable/class-timetable-delete/$divId/$fileId'));
    request.headers.addAll(headers);
    print(request);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      divisionList.removeAt(indexx);
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
      print('Error in timetableDelete');
    }
  }


//********************Staff TimeTable*****************************************
  List<StaffList> staffListfull = [];
  List staffList=[];
  Future<bool> getStaffList(String sectionId) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            '${UIGuide.baseURL}/Upload-Timetable/stafflist?section=$sectionId'));
    request.headers.addAll(headers);
    print(request);

    http.StreamedResponse response = await request.send();
    print(response);

    if (response.statusCode == 200) {
      setloadingSection(true);
      List<dynamic> data =
      jsonDecode(await response.stream.bytesToString());

      List<StaffList> templist = List<StaffList>.from(
          data.map((x) => StaffList.fromJson(x)));

      staffListfull.addAll(templist);

       staffList =
      staffListfull.where((staff) => staff.role== "Teacher").toList();
      print(staffList);
      print(staffList);
      setLoading(false);
      notifyListeners();
    }
    else {
      print('Error in stafflist response ');
      setLoading(false);
    }
    return true;
  }


  //TimeTableView
  String? sturl;
  String? stid;
  String? stextension;
  String? stname;

  Future getStaffTimeTableView(String staffId) async {
    setLoad(true);
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    setLoad(true);
    var response = await http.get(
        Uri.parse(
            "${UIGuide
                .baseURL}/Upload-Timetable/teacher-timetable-download/$staffId"),
        headers: headers);
    print(response);
    setLoad(true);
    try {
      if (response.statusCode == 200) {
        print("corectss");
        Map<String, dynamic> data = json.decode(response.body);
        StaffTimeTableView tt = StaffTimeTableView.fromJson(data);

        sturl = tt.url;
        stextension = tt.extension;
        stid = tt.extension;
        stname = tt.name;
        print(url);

        setLoad(false);
        notifyListeners();
      } else {
        setLoad(false);
        print("Error in response");
      }
    } catch (e) {
      print(e);
    }
  }

  //upload

  Future stafftimeTableUpload(context,
      String staffId,
      String staffName,
      String fileId,) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    print('$fileId ___________________');
    var request = http.Request(
        'POST',
        Uri.parse(
            '${UIGuide.baseURL}/Upload-Timetable/staff-timetable-upload'));
    request.body = json.encode({
      "value": staffId,
      "text": staffName,
      "role": 'teacher',
      "fileId": fileId,
      "teacherTTUploadId": null
    });
    print(
        json.encode({
          "value": staffId,
          "text": staffName,
          "role": 'teacher',
          "fileId": fileId,
          "teacherTTUploadId": null
        })
    );
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 204) {
      print('Correct...______________________________');
      await AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          headerAnimationLoop: false,
          title: 'Success',
          desc: 'Uploaded Successfully',
          btnOkOnPress: () {},
          btnOkIcon: Icons.cancel,
          btnOkColor: Colors.green)
          .show();
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
  //delete

  Future stafftimtableDelete(BuildContext context, String staffId, String fileId,
      int indexx) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    var request = http.Request('DELETE',
        Uri.parse('${UIGuide
            .baseURL}/Upload-Timetable/teacher-timetable-delete/$staffId/$fileId'));
    request.headers.addAll(headers);
    print(request);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      staffList.removeAt(indexx);
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
      print('Error in timetableDelete');
    }
  }


}