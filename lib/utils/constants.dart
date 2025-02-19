import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class UIGuide {
  static const String notcheck = "assets/square.svg";
  static const String check = "assets/check-square.svg";

  static const String curriculamUrl =
     // "https://api.curriculumtestonline.in";

   // "https://api.uatcurriculum.in";

   "https://api.esscurriculum.in";


  static const String baseURL =
      // "https://api.esstestonline.in";

 // "https://api.essuatonline.in";

  "https://api.eschoolweb.org";

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

class LinkTextWidget extends StatelessWidget {
  final String text;
  double? font;

  LinkTextWidget({super.key, required this.text,this.font});

  @override
  Widget build(BuildContext context) {
    // Regular expression to find URLs starting with https
    final RegExp urlRegExp = RegExp(r'(https:\/\/[^\s]+)');
    final Iterable<Match> matches = urlRegExp.allMatches(text);

    // If no URL matches, return a simple SelectableText
    if (matches.isEmpty) {
      return SelectableText(
        text,
        style: TextStyle(fontSize: font),
        toolbarOptions: ToolbarOptions(copy: true, selectAll: true),
      );
    } else {
      final List<TextSpan> textSpans = [];
      int lastMatchEnd = 0;

      for (final Match match in matches) {
        if (match.start > lastMatchEnd) {
          textSpans.add(TextSpan(
            text: text.substring(lastMatchEnd, match.start),
          ));
        }

        final String url = match.group(0)!;
        textSpans.add(
          TextSpan(
            text: url,
            style: TextStyle(color: Colors.blue, fontSize: font),
            recognizer: TapGestureRecognizer()
              ..onTap = () async {
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  throw 'Could not launch $url';
                }
              },
          ),
        );

        lastMatchEnd = match.end;
      }

      // Add remaining text after the last match
      if (lastMatchEnd < text.length) {
        textSpans.add(TextSpan(
          text: text.substring(lastMatchEnd),
        ));
      }

      return SelectableText.rich(
        TextSpan(
          style: DefaultTextStyle.of(context).style.copyWith(fontSize: font),
          children: textSpans,
        ),
        toolbarOptions: ToolbarOptions(copy: true, selectAll: true),
        cursorColor: Colors.blue,
        showCursor: true,
      );
    }
  }
}
