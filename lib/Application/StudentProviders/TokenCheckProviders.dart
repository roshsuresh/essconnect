import 'dart:convert';
import 'dart:developer';
import 'package:essconnect/Domain/Student/LoginModel.dart';
import 'package:essconnect/Presentation/Login_Activation/Login_page.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class TokenExpiryCheckProviders with ChangeNotifier {
  Future checkTokenExpired(BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? userNamee = pref.getString('username');
    String? passWordd = pref.getString('password');
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST',
        Uri.parse('${UIGuide.baseURL}/login?id=${pref.getString('schoolId')}'));
    request.body = json.encode({"email": userNamee, "password": passWordd});
    print(request.body);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200 || response.statusCode == 201) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove("accesstoken");
      var data = jsonDecode(await response.stream.bytesToString());
      LoginModel res = LoginModel.fromJson(data);
      await prefs.setString('accesstoken', res.accessToken);

      log('token added-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-');
      notifyListeners();
    } else if (response.statusCode == 401) {
      print("Unauthorized  ");

      return Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const LoginPage()));
    } else {
      print('Something went wrong in token generation');
    }
  }
}
