import 'dart:core';

import 'package:flutter/material.dart';

// ///constant Strings
// const String login = "Login";
// const String forgotPass = "Forgot Password";
// const String userName = "User Name";
// const String passWord = "Password";
// const String schoolCode = "School Code";
// const String activate = "Activate";
// const String baseUrl =
// //"https://api.esstestonline.in";
//     "https://api.eschoolweb.org";

// ///constant assets
// const String buttonBackground = "assets/but_back.png";
// const String loginBackground = "assets/activation_page.png";
// const String gjlogo = "assets/backlogo.png";
// const String notcheck = "assets/square.svg";
// const String check = "assets/check-square.svg";
// const String activationButton = "assets/act_button.png";
// const String loginTabBackground = "assets/login_tab_back.png";

// ///error
// const String activationError = "Enter a Valid Code to Continue";
// const String loginError = "Wrong  Username or Password";

//sized box
const kWidth = SizedBox(
  width: 10,
);
const kWidth20 = SizedBox(
  width: 20,
);
const kheight5 = SizedBox(
  height: 5,
);
const kheight10 = SizedBox(
  height: 10,
);
const kheight20 = SizedBox(
  height: 20,
);

snackbarWidget(int second, content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      elevation: 10,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      duration: Duration(seconds: second),
      margin: const EdgeInsets.only(bottom: 80, left: 30, right: 30),
      behavior: SnackBarBehavior.floating,
      content: Text(
        content,
        textAlign: TextAlign.center,
      ),
    ),
  );
}

snackbarCenterWidget(int second, content, BuildContext context) {
  var size = MediaQuery.of(context).size;
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      elevation: 10,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      duration: Duration(seconds: second),
      margin: EdgeInsets.only(bottom: size.height / 2, left: 30, right: 30),
      behavior: SnackBarBehavior.floating,
      content: Text(
        content,
        textAlign: TextAlign.center,
      ),
    ),
  );
}
//     TEXT    overflow//

//  Flexible(
//     child: RichText(
//     overflow: TextOverflow.ellipsis,
//     strutStyle: StrutStyle(fontSize: 12.0),
//     text: TextSpan(
//     style: TextStyle(color: Colors.black),
//     text: 'Ravidranath@gmail.com'),
//      ),
//   ),



//https://poki.com/en/g/burnin-rubber-5-xs