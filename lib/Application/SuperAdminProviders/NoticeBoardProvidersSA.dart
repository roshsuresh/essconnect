import 'dart:convert';
import 'package:essconnect/Domain/Staff/NoticeboardSendModel.dart';
import 'package:essconnect/Domain/SuperAdmin/NoticeBoardModel.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class NoticeBoardProvidersSAdmin with ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  List<NoticeBoardViewSuperAdmin> noticeList = [];
  Future<bool> getNoticeView() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoading(true);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    var request = http.Request('GET',
        Uri.parse('${UIGuide.baseURL}/mobileapp/staffdet/noticeBoard/view'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Map<String, dynamic> data =
          jsonDecode(await response.stream.bytesToString());

      List<NoticeBoardViewSuperAdmin> templist =
          List<NoticeBoardViewSuperAdmin>.from(data["noticeBoardView"]
              .map((x) => NoticeBoardViewSuperAdmin.fromJson(x)));
      noticeList.addAll(templist);
      setLoading(false);
      notifyListeners();
    } else {
      setLoading(false);
      print('Error in noticeBoardView stf');
    }
    return true;
  }

  clearStudentList() {
    noticeList.clear();
    notifyListeners();
  }

  //noticeBoard Attachment View

  String? name;
  String? extension;
  String? url;
  String? idd;
  String? createdAt;

  Future staffNoticeBoardAttach(String id) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };

    var response = await http.get(
        Uri.parse(
            "${UIGuide.baseURL}/mobileapp/staffdet/noticeboard-attachment/$id"),
        headers: headers);

    try {
      if (response.statusCode == 200) {
        print("corect");
        final data = json.decode(response.body);
        Map<String, dynamic> staffNoticeViewAttach =
            data['noticeBoardAttatchment'];

        NoticeBoardAttatchmentStaffReceived notice =
            NoticeBoardAttatchmentStaffReceived.fromJson(
                data['noticeBoardAttatchment']);

        name = notice.name;
        extension = notice.extension;
        url = notice.url;
        idd = notice.id;
        createdAt = notice.createdAt;
        print(name);

        notifyListeners();
      } else {
        print("Error in staffNoticeAttach response");
      }
    } catch (e) {
      print(e);
    }
  }
}
