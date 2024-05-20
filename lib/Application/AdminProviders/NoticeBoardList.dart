import 'dart:convert';
import 'package:essconnect/Domain/Admin/NoticeBoardEdit.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../Domain/Admin/NoticeBoardList.dart';

class NoticeBoardListAdminProvider with ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  List<NoticeBoardListAdmin> noticeList = [];
  Future<bool> getNoticeListView(BuildContext context) async {
    setLoading(true);
    SharedPreferences pref = await SharedPreferences.getInstance();
    notifyListeners();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    var request = http.Request('GET',
        Uri.parse('${UIGuide.baseURL}/mobileapp/admin/notice-board-list'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Map<String, dynamic> data =
          jsonDecode(await response.stream.bytesToString());

      // log(data.toString());

      List<NoticeBoardListAdmin> templist = List<NoticeBoardListAdmin>.from(
          data["noticeBoardList"].map((x) => NoticeBoardListAdmin.fromJson(x)));
      noticeList.addAll(templist);

      print('correct');
      setLoading(false);
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
      print('Error in notice View stf');
    }
    return true;
  }

  clearNoticeList() {
    noticeList.clear();
    notifyListeners();
  }
  //delete Notice

  Future noticeDelete(String eventID, BuildContext context, int indexx) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    var request = http.Request('DELETE',
        Uri.parse('${UIGuide.baseURL}/notice-board/delete-event/$eventID'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 204) {
      noticeList.removeAt(indexx);
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
      print('Error in noticeDelete stf');
    }
  }

  //edit notice

  String? title;
  String? matter;
  String? displayStartDate;
  String? displayEndDate;
  String? createdDate;
  bool? cancelled;
  bool? approved;
  String? url;

  bool _load = false;
  bool get load => _load;
  setLoad(bool value) {
    _load = value;
    notifyListeners();
  }

  Future<bool> editNoticeList(String eventId) async {
    setLoad(true);
    SharedPreferences pref = await SharedPreferences.getInstance();
    notifyListeners();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            '${UIGuide.baseURL}/notice-board/notice-board-event/$eventId'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Map<String, dynamic> data =
          jsonDecode(await response.stream.bytesToString());
      print(data);
      NoticeEditAdmin notice = NoticeEditAdmin.fromJson(data);
      title = notice.title;
      matter = notice.matter;
      displayEndDate = notice.displayEndDate;
      displayStartDate = notice.displayStartDate;
      createdDate = notice.createdDate;
      cancelled = notice.cancelled;
      approved = notice.approved;

      // Map<String, dynamic> attachment = data['attachment'];
      // AttachmentNoticeAdmin att = AttachmentNoticeAdmin.fromJson(attachment);
      // url = att.url;

      // print(attachment);
      setLoad(false);
      notifyListeners();
    } else {
      print('Error in notice edit admin');
    }
    return true;
  }

  //Notice Aproove

  Future noticeAproove(BuildContext context, String eventID) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    var request = http.Request('GET',
        Uri.parse('${UIGuide.baseURL}/notice-board/approve-event/$eventID'));
    request.headers.addAll(headers);
    print(http.Request('GET',
        Uri.parse('${UIGuide.baseURL}/notice-board/approve-event/$eventID')));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
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
          'Approved Successfully',
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
      print('Error in galleryApprove');
    }
  }
}
