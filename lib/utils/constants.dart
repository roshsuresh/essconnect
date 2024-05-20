import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UIGuide {
  static const String notcheck = "assets/square.svg";
  static const String check = "assets/check-square.svg";

  static const String curiculamUrl =
  "https://api.curriculumtestonline.in";


  static const String baseURL =
  //"https://api.essuatonline.in";
  "https://api.esstestonline.in";
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
  static const Color light_black = Color.fromARGB(255, 228, 229, 230);
  static const Color light_Purple = Color.fromARGB(255, 7, 68, 126);
  static const Color custom_blue = Color.fromARGB(255, 44, 127, 238);
  static const Color button1 = Color.fromARGB(255, 117, 185, 112);
  static const Color button2 = Color.fromARGB(255, 213, 99, 82);
  static const Color LightBlue = Color.fromARGB(255, 233, 233, 233);
  static const Color ButtonBlue = Color.fromARGB(255, 255, 255, 255);
}

Future<Map<String, dynamic>> parseJWT() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String? token = pref.getString("accesstoken");
  print(token);
  if (token == null) {
    return {};
  } else {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    return decodedToken;
  }
}

class LottieAminBus extends StatelessWidget {
  const LottieAminBus({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: LottieBuilder.asset("assets/Animated bus.json")),
    );
  }
}
