// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UIGuide {
  static const String ourlogo = "assets/plogo.png";
  static const String esslogo = "assets/backlogo.png";
  static const String notification = "assets/notification.png";
  static const String studentnoti = "assets/studentsnotifications.png";
  static const String staffnoti = "assets/staffnotification.png";
  static const String student = "assets/stud.png";
  static const String pay = "assets/pay.png";
  static const String board = "assets/blackboard.png";
  static const String school = "assets/school1.png";
  static const String homeback = "assets/activation_page.png";
  static const String notcheckk = "assets/success-green-check-mark-icon.svg";
  static const String notcheck = "assets/square.svg";
  static const String check = "assets/check-square.svg";
  static const String checkk = "assets/red-x-line-icon.svg";
  static const String profile = "assets/Profile.png";
  static const String reportcard = "assets/Reportcard.png";
  static const String baseURL = "https://api.esstestonline.in";
  //"https://api.eschoolweb.org";
  static const String absent = "assets/aa.svg";
  static const String present = "assets/ppp.svg";
  static const String success = "assets/success.svg";
  static const String failed = "assets/failed.svg";
  static const String pending = "assets/pending.svg";
  static const String somethingWentWrong = "assets/somethingWentWrong.svg";

  static const Color WHITE = Colors.white;
  static const Color BLACK = Colors.black;
  static const Color THEME_PRIMARY = Color(0XFF575C79);
  static const Color THEME_LIGHT = Color.fromARGB(255, 212, 216, 240);
  static const Color THEME_DARK = Color(0XFF2D334D);
  static const Color BACKGROUND_COLOR = Color(0XFFAEB2D1);
  static const Color PRIMARY = Color(0XFF36235a);
  static const Color PRIMARY2 = Color(0XFF59081b);
  static const Color PRIMARY3 = Color(0XFFff6699);
  static const Color light_black = Color.fromARGB(255, 228, 229, 230);
  static const Color light_Purple = Color.fromARGB(255, 7, 68, 126);
  static const Color custom_blue = Color.fromARGB(255, 44, 127, 238);
  static const Color button1 = Color.fromARGB(255, 166, 232, 161);
  static const Color button2 = Color.fromARGB(255, 241, 135, 118);
  static const Color LightBlue = Color.fromARGB(255, 236, 240, 255);
  static const Color primary4 = Color(0xff17a2b8);
  Widget sizer20 = const SizedBox(
    height: 20,
  );

  static const Color FACEBOOK_COLOR = Color(0xfff3b5998);
}

Future<Map<String, dynamic>> parseJWT() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String? token = pref.getString("accesstoken");
  print(token);
  if (token == null) {
    // Navigator.push(context, MaterialPageRoute(builder: (context) => LoginUI()));
    return {};
  } else {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    // print(decodedToken);
    return decodedToken;
  }
}

enum LoginType { student, guardian, staff }
