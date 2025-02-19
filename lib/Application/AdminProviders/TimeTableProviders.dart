import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../Domain/Admin/Course&DivsionList.dart';
import '../../Domain/Admin/TimeTableAdmin.dart';
import '../../Domain/Staff/NoticeboardSendModel.dart';
import '../../utils/constants.dart';

class TimeTableClassProvidersAdmin with ChangeNotifier {
  List<CourseListModel> course = [];
  addSelectedCourse(CourseListModel item) {
    if (course.contains(item)) {
      print("removing");
      course.remove(item);
      notifyListeners();
    } else {
      print("adding");
      course.add(item);
      notifyListeners();
    }
  }

  removeCourse(CourseListModel item) {
    course.remove(item);
    notifyListeners();
  }

  removeCourseAll() {
    course.clear();
    notifyListeners();
  }

  isCourseSelected(
    CourseListModel item,
  ) {
    if (course.contains(item)) {
      return true;
    } else {
      return false;
    }
  }

  courseClear() {
    courselist.clear();
    notifyListeners();
  }

  List<CourseListModel> courselist = [];

  Future<bool> getCourseList() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    var request = http.Request(
        'GET', Uri.parse('${UIGuide.baseURL}/mobileapp/common/courselist'));
    // request.body = json.encode({"SchoolId": _pref.getString('schoolId')});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print('object');
    if (response.statusCode == 200) {
      Map<String, dynamic> data =
          jsonDecode(await response.stream.bytesToString());

      //log(data.toString());

      List<CourseListModel> templist = List<CourseListModel>.from(
          data["courseList"].map((x) => CourseListModel.fromJson(x)));
      courselist.addAll(templist);

      notifyListeners();
    } else {
      print('Error in courseList stf');
    }
    return true;
  }

  //view

  clearList() {
    viewlist.clear();
    notifyListeners();
  }

  List<TimeTableViewModel> viewlist = [];
  Future<bool> viewTimeTable(String course) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            '${UIGuide.baseURL}/Upload-Timetable/divisions?course=$course'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print('object');
    if (response.statusCode == 200) {
      List data = jsonDecode(await response.stream.bytesToString());

      log(data.toString());

      List<TimeTableViewModel> templist = List<TimeTableViewModel>.from(
          data.map((x) => TimeTableViewModel.fromJson(x)));
      viewlist.addAll(templist);

      notifyListeners();
    } else {
      print('Error in courseList stf');
    }
    return true;
  }

  //image  --pdf id find

  String? id;
  Future timeTableImageSave(String path) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${UIGuide.baseURL}/files/single/School'));
    request.fields.addAll({'': ''});
    request.files.add(await http.MultipartFile.fromPath('', path));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Map<String, dynamic> data =
          jsonDecode(await response.stream.bytesToString());

      NoticeImageId idd = NoticeImageId.fromJson(data);
      id = idd.id;
      print('...............   $id');
      notifyListeners();
    } else {
      print(response.reasonPhrase);
    }
  }

  //upload timetable

  Future timetableSave(
      BuildContext context, String value, String attachmentId) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    var request = http.Request('POST',
        Uri.parse('${UIGuide.baseURL}Upload-Timetable/class-timetable-upload'));
    request.body = json.encode({"value": value, "fileId": attachmentId});
    request.headers.addAll(headers);
    print(json.encode({"value": value, "fileId": attachmentId}));
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 204) {
      print('Correct...______________________________');
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Uploaded Successfully")));
      notifyListeners();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Something went wrong...")));
      print('Error in gallery save respo');
    }
  }
}
