import 'dart:js_interop';
import 'package:essconnect/Application/AdminProviders/Attendanceprovider.dart';
import 'package:essconnect/Application/AdminProviders/BirthdayListProviders.dart';
import 'package:essconnect/Application/AdminProviders/ChatProviders.dart';
import 'package:essconnect/Application/AdminProviders/ExamTTPtoviders.dart';
import 'package:essconnect/Application/AdminProviders/TimeTableProvider.dart';
import 'package:essconnect/Application/Module%20Providers.dart/MobileAppCheckin.dart';
import 'package:essconnect/Application/Module%20Providers.dart/SchoolNameProvider.dart';
import 'package:essconnect/Application/Staff_Providers/ExamTTProviderStaff.dart';
import 'package:essconnect/Application/Staff_Providers/MarkEntryNewProvider.dart';
import 'package:essconnect/Application/Staff_Providers/MissingReportProviders.dart';
import 'package:essconnect/Application/Staff_Providers/NotificationCount.dart';
import 'package:essconnect/Application/Staff_Providers/PortionProvider.dart';
import 'package:essconnect/Application/Staff_Providers/StudentReportProvidersStaff.dart';
import 'package:essconnect/Application/Staff_Providers/TimetableProvider.dart';
import 'package:essconnect/Application/Staff_Providers/ToolMarkProvider.dart';
import 'package:essconnect/Application/StudentProviders/AnecDotalProvider.dart';
import 'package:essconnect/Application/StudentProviders/DiaryProviders.dart';
import 'package:essconnect/Application/StudentProviders/NotificationCountProviders.dart';
import 'package:essconnect/Application/StudentProviders/OfflineFeeProviders.dart';
import 'package:essconnect/Application/StudentProviders/PortionProvider.dart';
import 'package:essconnect/Application/StudentProviders/StudLocationProvider.dart';
import 'package:essconnect/Application/StudentProviders/TokenCheckProviders.dart';
import 'package:essconnect/Application/SuperAdminProviders/NoticeBoardProvidersSA.dart';
import 'package:provider/provider.dart';
import 'Application/AdminProviders/AppReviewProvider.dart';
import 'Application/AdminProviders/FeeDetailsProvider.dart';
import 'Application/AdminProviders/FeeReportProvider.dart';
import 'Application/AdminProviders/FlashNewsProviders.dart';
import 'Application/AdminProviders/GalleryProviders.dart';
import 'Application/AdminProviders/NoticeBoardList.dart';
import 'Application/AdminProviders/NoticeBoardadmin.dart';
import 'Application/AdminProviders/NotificationStaff.dart';
import 'Application/AdminProviders/NotificationToGuardian.dart';
import 'Application/AdminProviders/OfflineFeesCollectionProvider.dart';
import 'Application/AdminProviders/SchoolPhotoProviders.dart';
import 'Application/AdminProviders/SearchstaffProviders.dart';
import 'Application/AdminProviders/StaffReportProviders.dart';
import 'Application/AdminProviders/StudstattiticsProvider.dart';
import 'Application/AdminProviders/TimeTableProviders.dart';
import 'Application/AdminProviders/TimeTableStaff.dart';
import 'Application/AdminProviders/dashboardProvider.dart';
import 'Application/Module Providers.dart/Module.dart';
import 'Application/Staff_Providers/Anecdotal/AncedotalStaffProvider.dart';
import 'Application/Staff_Providers/Anecdotal/AnecdotalStaffListProvider.dart';
import 'Application/Staff_Providers/Attendencestaff.dart';
import 'Application/Staff_Providers/GallerySendProviderStaff.dart';
import 'Application/Staff_Providers/MarkReportProvider.dart';
import 'Application/Staff_Providers/NoticeboardSend.dart';
import 'Application/Staff_Providers/Notification_ToGuardianProvider.dart';
import 'Application/Staff_Providers/RemarksEntry.dart';
import 'Application/Staff_Providers/SearchProvider.dart';
import 'Application/Staff_Providers/StaffFlashnews.dart';
import 'Application/Staff_Providers/StaffNotificationScreen.dart';
import 'Application/Staff_Providers/StaffProfile.dart';
import 'Application/Staff_Providers/StudListProvider.dart';
import 'Application/Staff_Providers/TextSMS_ToGuardian.dart';
import 'Application/StudentProviders/AttendenceProvider.dart';
import 'Application/StudentProviders/CurriculamProviders.dart';
import 'Application/StudentProviders/FeesProvider.dart';
import 'Application/StudentProviders/FinalStatusProvider.dart';
import 'Application/StudentProviders/GalleryProvider.dart';
import 'Application/StudentProviders/InternetConnection.dart';
import 'Application/StudentProviders/LoginProvider.dart';
import 'Application/StudentProviders/MarkSheetProvider.dart';
import 'Application/StudentProviders/NoticProvider.dart';
import 'Application/StudentProviders/NotificationReceived.dart';
import 'Application/StudentProviders/PasswordChangeProvider.dart';
import 'Application/StudentProviders/PaymentHistory.dart';
import 'Application/StudentProviders/ProfileProvider.dart';
import 'Application/StudentProviders/ReportCardProvider.dart';
import 'Application/StudentProviders/SiblingsProvider.dart';
import 'Application/StudentProviders/TimetableProvider.dart';




MultiProvider setupEssConnectProviders() {

  return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginProvider()),
        ChangeNotifierProvider(create: (context) => ProfileProvider()),
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
        ChangeNotifierProvider(create: (context) => OffflineFeesProvider()),
        ChangeNotifierProvider(create: (context) => AppReviewProvider()),
        ChangeNotifierProvider(create: (context) => PortionProvider()),
        ChangeNotifierProvider(create: (context) => StudentPortionProvider()),
      ]

  );
}





