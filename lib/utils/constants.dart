import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Application/AdminProviders/AppReviewProvider.dart';
import '../Application/AdminProviders/Attendanceprovider.dart';
import '../Application/AdminProviders/BirthdayListProviders.dart';
import '../Application/AdminProviders/ChatProviders.dart';
import '../Application/AdminProviders/ExamTTPtoviders.dart';
import '../Application/AdminProviders/FeeDetailsProvider.dart';
import '../Application/AdminProviders/FeeReportProvider.dart';
import '../Application/AdminProviders/FlashNewsProviders.dart';
import '../Application/AdminProviders/GalleryProviders.dart';
import '../Application/AdminProviders/NoticeBoardList.dart';
import '../Application/AdminProviders/NoticeBoardadmin.dart';
import '../Application/AdminProviders/NotificationStaff.dart';
import '../Application/AdminProviders/NotificationToGuardian.dart';
import '../Application/AdminProviders/OfflineFeesCollectionProvider.dart';
import '../Application/AdminProviders/SchoolPhotoProviders.dart';
import '../Application/AdminProviders/SearchstaffProviders.dart';
import '../Application/AdminProviders/StaffReportProviders.dart';
import '../Application/AdminProviders/StudstattiticsProvider.dart';
import '../Application/AdminProviders/TimeTableProvider.dart';
import '../Application/AdminProviders/TimeTableProviders.dart';
import '../Application/AdminProviders/TimeTableStaff.dart';
import '../Application/AdminProviders/dashboardProvider.dart';
import '../Application/Module Providers.dart/MobileAppCheckin.dart';
import '../Application/Module Providers.dart/Module.dart';
import '../Application/Module Providers.dart/SchoolNameProvider.dart';
import '../Application/Staff_Providers/Anecdotal/AncedotalStaffProvider.dart';
import '../Application/Staff_Providers/Anecdotal/AnecdotalStaffListProvider.dart';
import '../Application/Staff_Providers/Attendencestaff.dart';
import '../Application/Staff_Providers/ExamTTProviderStaff.dart';
import '../Application/Staff_Providers/GallerySendProviderStaff.dart';
import '../Application/Staff_Providers/MarkEntryNewProvider.dart';
import '../Application/Staff_Providers/MarkReportProvider.dart';
import '../Application/Staff_Providers/MissingReportProviders.dart';
import '../Application/Staff_Providers/NoticeboardSend.dart';
import '../Application/Staff_Providers/NotificationCount.dart';
import '../Application/Staff_Providers/Notification_ToGuardianProvider.dart';
import '../Application/Staff_Providers/PortionProvider.dart';
import '../Application/Staff_Providers/RemarksEntry.dart';
import '../Application/Staff_Providers/SearchProvider.dart';
import '../Application/Staff_Providers/StaffFlashnews.dart';
import '../Application/Staff_Providers/StaffNotificationScreen.dart';
import '../Application/Staff_Providers/StaffProfile.dart';
import '../Application/Staff_Providers/StudListProvider.dart';
import '../Application/Staff_Providers/StudentReportProvidersStaff.dart';
import '../Application/Staff_Providers/TextSMS_ToGuardian.dart';
import '../Application/Staff_Providers/TimetableProvider.dart';
import '../Application/Staff_Providers/ToolMarkProvider.dart';
import '../Application/StudentProviders/AnecDotalProvider.dart';
import '../Application/StudentProviders/AttendenceProvider.dart';
import '../Application/StudentProviders/CurriculamProviders.dart';
import '../Application/StudentProviders/DiaryProviders.dart';
import '../Application/StudentProviders/FeesProvider.dart';
import '../Application/StudentProviders/FinalStatusProvider.dart';
import '../Application/StudentProviders/GalleryProvider.dart';
import '../Application/StudentProviders/InternetConnection.dart';
import '../Application/StudentProviders/LoginProvider.dart';
import '../Application/StudentProviders/MarkSheetProvider.dart';
import '../Application/StudentProviders/NoticProvider.dart';
import '../Application/StudentProviders/NotificationCountProviders.dart';
import '../Application/StudentProviders/NotificationReceived.dart';
import '../Application/StudentProviders/OfflineFeeProviders.dart';
import '../Application/StudentProviders/PasswordChangeProvider.dart';
import '../Application/StudentProviders/PaymentHistory.dart';
import '../Application/StudentProviders/PortionProvider.dart';
import '../Application/StudentProviders/ProfileProvider.dart';
import '../Application/StudentProviders/ReportCardProvider.dart';
import '../Application/StudentProviders/SiblingsProvider.dart';
import '../Application/StudentProviders/StudLocationProvider.dart';
import '../Application/StudentProviders/TimetableProvider.dart';
import '../Application/StudentProviders/TokenCheckProviders.dart';
import '../Application/SuperAdminProviders/NoticeBoardProvidersSA.dart';

class UIGuide {
  static const String notcheck = "assets/square.svg";
  static const String check = "assets/check-square.svg";

  static const String curriculamUrl =
  "https://api.curriculumtestonline.in";


  static const String baseURL =
  "https://api.esstestonline.in";

  // "https://api.essuatonline.in";

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
  String failed1="=vallllle";




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
