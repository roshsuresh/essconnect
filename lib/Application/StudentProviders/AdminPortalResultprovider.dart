import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Domain/Admin/AdminPortalmodel.dart';
import '../../utils/constants.dart';

class StudentPortalProvider with ChangeNotifier {

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  List<AdminPortal> results = [];

  Future<void> resultfn(BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}',
    };
    print("1");
    var response = await http.get(
      Uri.parse(
          '${UIGuide.baseURL}/communication/admin-port/admin-port-list'),
      headers: headers,
    );
    print("2");
    log(response.body.toString());

    var data = jsonDecode(response.body.toString());
    print("3");
    if (response.statusCode == 200) {
      setLoading(false);
      results =
          List<AdminPortal>.from(data["results"].map((x) => AdminPortal.fromJson(x)));
      notifyListeners();
    } else {
      print(response.reasonPhrase);
      setLoading(false);
      notifyListeners();
    }
  }
}
