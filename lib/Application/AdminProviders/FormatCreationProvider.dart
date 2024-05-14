// import 'dart:convert';
// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:essconnect/Presentation/Admin/Communication/FormatCreation.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
//
// import '../../utils/constants.dart';
// class FormatCreationProvider with ChangeNotifier{
//
//   Future notificationFormatSave(BuildContext context,String formatname,String title,String description
//       ) async {
//     SharedPreferences _pref = await SharedPreferences.getInstance();
//
//     var headers = {
//       'Content-Type': 'application/json',
//       'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
//     };
//     var request = http.Request('POST',
//         Uri.parse('${UIGuide.baseURL}/notification/common/save-new-format'));
//     print(request);
//     request.body = json.encode(
//         {
//           "group": "guardianGeneralNotifications",
//           "notificationFormatName": formatname,
//           "notificationTitle": title,
//           "notificationDescription": description,
//           "notificationFormat": formatname,
//           "formatType": "Notification"
//         }
//     );
//     print("notice---------");
//     print(request.body = json.encode({
//       "group": "guardianGeneralNotifications",
//       "notificationFormatName": formatname,
//       "notificationTitle": title,
//       "notificationDescription": description,
//       "notificationFormat": formatname,
//       "formatType": "Notification"
//     }));
//     request.headers.addAll(headers);
//
//     http.StreamedResponse response = await request.send();
//
//     if (response.statusCode == 200) {
//       print('Correct______..........______');
//
//       Map<String, dynamic> data =
//       jsonDecode(await response.stream.bytesToString());
//       print(data);
//       // NoticeSuccessModel notice = NoticeSuccessModel.fromJson(data);
//       // noticeBoardId = notice.noticeBoardId;
//
//
//       AwesomeDialog(
//           context: context,
//           dialogType: DialogType.success,
//           animType: AnimType.rightSlide,
//           headerAnimationLoop: false,
//           title: 'Success',
//           desc: 'Uploaded Successfully',
//           btnOkOnPress: () {
//             Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => FormatCreation()));
//           },
//           btnOkIcon: Icons.cancel,
//           btnOkColor: Colors.green)
//           .show();
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//         elevation: 10,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(20)),
//         ),
//         duration: Duration(seconds: 1),
//         margin: EdgeInsets.only(bottom: 80, left: 30, right: 30),
//         behavior: SnackBarBehavior.floating,
//         content: Text(
//           'Something Went Wrong....',
//           textAlign: TextAlign.center,
//         ),
//       ));
//       print('Error Response notice send admin');
//     }
//   }
//
// }