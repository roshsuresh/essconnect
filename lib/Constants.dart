import 'dart:core';
import 'package:essconnect/Application/StudentProviders/LocationServiceProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

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
import '../Application/StudentProviders/ProfileProvider.dart';
import '../Application/StudentProviders/ReportCardProvider.dart';
import '../Application/StudentProviders/SiblingsProvider.dart';
import '../Application/StudentProviders/StudLocationProvider.dart';
import '../Application/StudentProviders/TimetableProvider.dart';
import '../Application/StudentProviders/TokenCheckProviders.dart';
import '../Application/SuperAdminProviders/NoticeBoardProvidersSA.dart';
import 'Application/AdminProviders/AdminPortalprovider.dart';
import 'Application/AdminProviders/FeedbackCategoryProvider.dart';
import 'Application/AdminProviders/FeedbackProvider.dart';
import 'Application/AdminProviders/OfflineFeesCollectionProvider.dart';
import 'Application/Staff_Providers/HPC/FeedbackProvider.dart';
import 'Application/Staff_Providers/HPC/PeerAssessmentProvider.dart';
import 'Application/Staff_Providers/HPC/PeerLearningProvider.dart';
import 'Application/Staff_Providers/HPC/PeerProgressProvider.dart';
import 'Application/Staff_Providers/HPC/SelfAssessmentProvider.dart';
import 'Application/Staff_Providers/HPC/SelfLearningProvider.dart';
import 'Application/Staff_Providers/HPC/SelfProgressGridProvider.dart';
import 'Application/Staff_Providers/PortionProvider.dart';
import 'Application/StudentProviders/AdminPortalResultprovider.dart';
import 'Application/StudentProviders/FeedbackEntryProvider.dart';
import 'Application/StudentProviders/FeesWiseProvider.dart';
import 'Application/StudentProviders/PortionProvider.dart';
import 'Presentation/Student/Student_home.dart';


//sized box
const kWidth5 = SizedBox(
  width: 5,
);
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

List<SingleChildWidget> getProviders()
{
  return [

    ChangeNotifierProvider(create: (context) => LoginProvider()),
    ChangeNotifierProvider(create: (context) => ProfileProvider()),
    ChangeNotifierProvider(create: (context) => TokenExpiryCheckProviders()),
    ChangeNotifierProvider(create: (context) => NoticeProvider()),
    ChangeNotifierProvider(create: (context) => AttendenceProvider()),
    ChangeNotifierProvider(create: (context) => FeesProvider()),
    ChangeNotifierProvider(create: (context) => GalleryProvider()),
    ChangeNotifierProvider(create: (context) => ReportCardProvider()),
    ChangeNotifierProvider(create: (context) => Timetableprovider()),
    ChangeNotifierProvider(create: (context) => PasswordChangeprovider()),
    ChangeNotifierProvider(create: (context) => SibingsProvider()),
    ChangeNotifierProvider(create: (context) => StaffProfileProvider()),
    ChangeNotifierProvider(
        create: (context) => StudReportListProvider_stf()),
    // ChangeNotifierProvider(create: (context) => MarkEntryProvider()),
    ChangeNotifierProvider(create: (context) => StaffTimetableProvider()),
    ChangeNotifierProvider(create: (context) => AttendenceStaffProvider()),
    ChangeNotifierProvider(create: (context) => FlashnewsProvider()),
    ChangeNotifierProvider(
        create: (context) => StaffNoticeboardSendProviders()),
    ChangeNotifierProvider(create: (context) => Screen_Search_Providers()),
    ChangeNotifierProvider(
        create: (context) => NotificationToGuardian_Providers()),
    ChangeNotifierProvider(
        create: (context) => TextSMS_ToGuardian_Providers()),
    ChangeNotifierProvider(create: (context) => GallerySendProvider_Stf()),
    ChangeNotifierProvider(
        create: (context) => MarkEntryReportProvider_stf()),
    ChangeNotifierProvider(create: (context) => StaffReportProviders()),
    ChangeNotifierProvider(create: (context) => DashboardAdmin()),
    ChangeNotifierProvider(create: (context) => SearchStaffProviders()),
    ChangeNotifierProvider(create: (context) => SchoolPhotoProviders()),
    ChangeNotifierProvider(create: (context) => GalleryProviderAdmin()),
    ChangeNotifierProvider(create: (context) => PaymentHistoryProvider()),
    ChangeNotifierProvider(create: (context) => NoticeBoardAdminProvider()),
    ChangeNotifierProvider(
        create: (context) => NotificationReceivedProviderStudent()),
    ChangeNotifierProvider(
        create: (context) => StaffNotificationScreenProvider()),
    ChangeNotifierProvider(
        create: (context) => NotificationToGuardianAdmin()),
    ChangeNotifierProvider(
        create: (context) => NotificationToStaffAdminProviders()),
    ChangeNotifierProvider(create: (context) => FeeReportProvider()),
    ChangeNotifierProvider(
        create: (context) => NoticeBoardListAdminProvider()),
    ChangeNotifierProvider(create: (context) => FlashNewsProviderAdmin()),
    ChangeNotifierProvider(
        create: (context) => TimeTableClassProvidersAdmin()),
    ChangeNotifierProvider(create: (context) => TimetableStaffProviders()),
    ChangeNotifierProvider(create: (context) => FeeDetailsProvider()),
    ChangeNotifierProvider(create: (context) => StudStatiticsProvider()),
    ChangeNotifierProvider(create: (context) => ConnectivityProvider()),
    ChangeNotifierProvider(create: (context) => FinalStatusProvider()),
    ChangeNotifierProvider(create: (context) => ModuleProviders()),
    ChangeNotifierProvider(create: (context) => Curriculamprovider()),
    ChangeNotifierProvider(
        create: (context) => StudNotificationCountProviders()),
    ChangeNotifierProvider(
        create: (context) => StaffNotificationCountProviders()),
    ChangeNotifierProvider(create: (context) => DiaryProvidersstud()),
    ChangeNotifierProvider(create: (context) => ExamTTAdmProviders()),
    ChangeNotifierProvider(create: (context) => ExamTTAdmProvidersStaff()),
    ChangeNotifierProvider(create: (context) => AttendanceReportProvider()),
    ChangeNotifierProvider(
        create: (context) => NoticeBoardProvidersSAdmin()),
    ChangeNotifierProvider(create: (context) => MobileAppCheckinProvider()),
    ChangeNotifierProvider(
        create: (context) => TokenExpiryCheckProviders()),
    ChangeNotifierProvider(create: (context) => ChatProviders()),
    ChangeNotifierProvider(create: (context) => ToolMarkEntryProviders()),
    ChangeNotifierProvider(create: (context) => MissingReportProviders()),
    ChangeNotifierProvider(create: (context) => MarkEntryNewProvider()),
    ChangeNotifierProvider(create: (context) => RemarksEntryProvider()),
    ChangeNotifierProvider(create: (context) => OfflineFeeProviders()),
    ChangeNotifierProvider(create: (context) => SchoolNameProvider()),
    ChangeNotifierProvider(
        create: (context) => StudentReportProviderStaff()),
    ChangeNotifierProvider(create: (context) => AnecdotalStaffProviders()),
    ChangeNotifierProvider(create: (context) => BirthdayListProviders()),
    ChangeNotifierProvider(create: (context) => StudLocationProvider()),
    ChangeNotifierProvider(create: (context) => MarksheetProvider()),
    ChangeNotifierProvider(create: (context) => AnecDotalStudViewProvider()),
    ChangeNotifierProvider(create: (context) => AnecdotalStaffListProviders()),
    ChangeNotifierProvider(create: (context) => TimeTableUploadProvider()),
    ChangeNotifierProvider(create: (context) => AppReviewProvider()),
    ChangeNotifierProvider(create: (context) => PortionProvider()),
    ChangeNotifierProvider(create: (context) => StudentPortionProvider()),
    ChangeNotifierProvider(create: (context) => FeeWiseProvider()),
    ChangeNotifierProvider(create: (context) => OffflineFeesProvider()),
    ChangeNotifierProvider(create: (context) => LocationProvider()),
    ChangeNotifierProvider(create: (context)=>Hpcprovider()),
    ChangeNotifierProvider(create: (context)=>HPC_SelfAssessment_Provider()),
    ChangeNotifierProvider(create: (context)=>HPC_PeerAssessment_Provider()),
    ChangeNotifierProvider(create: (context)=>HPC_SelfProgressGrid_Provider()),
    ChangeNotifierProvider(create: (context)=>HPC_SelfLearning_Provider()),
    ChangeNotifierProvider(create: (context)=>HPC_PeerLearning_Provider()),
    ChangeNotifierProvider(create: (context)=>HPC_PeerProgressGrid_Provider()),
    ChangeNotifierProvider(create: (context)=>AdminPortalProvider()),
    ChangeNotifierProvider(create: (context)=>StudentPortalProvider()),
    ChangeNotifierProvider(create: (context)=>FeedbackCategoryProvider()),
    ChangeNotifierProvider(create: (context)=>FbProvider()),
    ChangeNotifierProvider(create: (context)=>FeedbackProvider()),
    ChangeNotifierProvider(create: (context)=>IconClickNotifier()),

  ];
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