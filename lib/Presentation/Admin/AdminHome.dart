import 'package:carousel_slider/carousel_slider.dart';
import 'package:essconnect/Presentation/Admin/AdminPortal.dart';
import 'package:essconnect/Presentation/Admin/FeedbackCategory.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upgrader/upgrader.dart';
import '../../Application/AdminProviders/SchoolPhotoProviders.dart';
import '../../Application/AdminProviders/dashboardProvider.dart';
import '../../Application/Module Providers.dart/Module.dart';
import '../../Application/Module Providers.dart/SchoolNameProvider.dart';
import '../../Application/StudentProviders/CurriculamProviders.dart';
import '../../Application/StudentProviders/InternetConnection.dart';
import '../../Constants.dart';
import '../../utils/constants.dart';
import '../../utils/spinkit.dart';
import '../Login_Activation/Login_page.dart';
import '../Staff/HPC/HPC_Home_Page.dart';
import '../Staff/MarkEntryNew.dart';
import '../Staff/Portion/Portions.dart';
import '../Staff/RemarksEntry.dart';
import '../Staff/StudAttendenceEntry.dart';
import '../Staff/StudReport.dart';
import '../Staff/ToolMarkEntry.dart';
import '../Student/CurriculamScreen.dart';
import '../Student/NoInternetScreen.dart';
import '../Student/PasswordChange.dart';
import 'Anecdotal/AnecdotalInitialScreenAdmin.dart';
import 'AppReview.dart';
import 'AttendanceTaken/AbsentReport.dart';
import 'AttendanceTaken/Takenornot.dart';
import 'Birthday/InitialScreen.dart';
import 'BusSelect.dart';
import 'Communication/ToGuardian.dart';
import 'Communication/ToStaff.dart';
import 'ExamTimetable/ExamScreen.dart';
import 'FeeCollectionReport/FeeReport.dart';
import 'FeeCollectionReport/FeesReportInitial.dart';
import 'FlashNews/FlashnewsScreen.dart';
import 'Gallery/GalleryScreen.dart';
import 'History/NotificationHistoryStaff.dart';
import 'MarkEntryMissingReportAdmin.dart';
import 'NoticeBoard/NoticeboardScreen.dart';
import 'StaffReport.dart';
import 'FeeDetails/StudFeeSearch.dart';
import 'StudentStatistiics.dart';
import 'TimeTableUpload.dart';
import 'WebViewLogin.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Provider.of<ConnectivityProvider>(context, listen: false);
      await Provider.of<ModuleProviders>(context, listen: false)
          .getModuleDetails();
      await Provider.of<SchoolNameProvider>(context, listen: false)
          .getSchoolname();
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Consumer<ConnectivityProvider>(
        builder: (context, connection, child) => connection.isOnline == false
            ? const NoInternetConnection()
            :
        UpgradeAlert(
          dialogStyle: UpgradeDialogStyle.cupertino,


          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Consumer<SchoolNameProvider>(
                builder: (context, snap, child) => snap.schoolname == null
                    ? const SizedBox(
                  height: 0,
                  width: 0,
                )
                    : Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    padding:
                    const EdgeInsets.only(top: 4, bottom: 4),
                    decoration: const BoxDecoration(
                      // border: Border.all(color: UIGuide.THEME_LIGHT),
                      borderRadius:
                      BorderRadius.all(Radius.circular(5)),
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(255, 234, 237, 239),
                          Color.fromARGB(255, 206, 203, 203),
                          Color.fromARGB(255, 206, 203, 203),
                          Color.fromARGB(255, 234, 237, 239),
                        ],
                      ),
                    ),
                    child: Center(
                        child: Text(
                          "${snap.schoolname ?? ""}, ${snap.place ?? ""}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: UIGuide.light_Purple,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        )),
                  ),
                ),
              ),
              const AdminProfileTop(),
              Container(
                width: size.width,
                height: size.height - 170,
                decoration: BoxDecoration(
                    border:
                    Border.all(color: UIGuide.THEME_LIGHT, width: 1),
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: const AdminHomeContent(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AdminHomeContent extends StatelessWidget {
  const AdminHomeContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        Container(
          clipBehavior: Clip.hardEdge,
          decoration: const BoxDecoration(
              color: Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          child: Column(
            children: [
              kheight20,
              Row(children: <Widget>[
                const Text(
                  ' ──  ',
                  style: TextStyle(
                    color: Colors.black26,
                  ),
                ),
                const Text(
                  'General Info',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: UIGuide.light_Purple, fontWeight: FontWeight.w900),
                ),
                Expanded(
                  child: Container(
                      margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                      child: const Divider(
                        color: Colors.black45,
                        height: 36,
                      )),
                ),
              ]),
              kheight20,
              Consumer<ModuleProviders>(
                builder: (context, module, child) => Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child:
                                  const StudReport(),


                                  //  MarkEntryReport(),
                                  duration: const Duration(milliseconds: 200),
                                  childCurrent: this));
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Card(
                              elevation: 10,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 38,
                                  width: 38,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      opacity: 20,
                                      image: AssetImage(
                                        'assets/01student report.png',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            kheight10,
                            const Center(
                              child: Text(
                                'Student\nReport',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child:
                                  Student_statistics_admin(),
                                  //LessonPlan(),
                                  duration: const Duration(milliseconds: 200),
                                  childCurrent: this));
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Card(
                              elevation: 10,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 38,
                                  width: 38,
                                  decoration: BoxDecoration(
                                    image: const DecorationImage(
                                      opacity: 20,
                                      image: AssetImage(
                                        'assets/statistics.png',
                                      ),
                                    ),
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                ),
                              ),
                            ),
                            kheight10,
                            const Center(
                              child: Text(
                                ' Student\nStatistics',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child:
                                  const StaffReport(),

                                  duration: const Duration(milliseconds: 200),
                                  childCurrent: this));
                        },
                        child: Column(
                          children: [
                            Card(
                              elevation: 10,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 38,
                                  width: 38,
                                  decoration: BoxDecoration(
                                    image: const DecorationImage(
                                      opacity: 20,
                                      image: AssetImage(
                                        'assets/01staffreport.png',
                                      ),
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                            kheight10,
                            const Text(
                              'Staff\nReport',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child:
                                  const AdminPortal(),
                                  duration: const Duration(milliseconds: 200),
                                  childCurrent: this));
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Card(
                              elevation: 10,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 38,
                                  width: 38,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      opacity: 20,
                                      image: AssetImage(
                                        'assets/adminportal.png',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            kheight10,
                            const Text(
                              'Admin\nPortal',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),

                  ],
                ),
              ),
              kheight10,
              kheight10,
              Row(children: <Widget>[
                const Text(
                  ' ──  ',
                  style: TextStyle(
                    color: Colors.black26,
                  ),
                ),
                const Text(
                  "Communication",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: UIGuide.light_Purple, fontWeight: FontWeight.w900),
                ),
                Expanded(
                  child: Container(
                      margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                      child: const Divider(
                        color: Colors.black45,
                        height: 36,
                      )),
                ),
              ]),
              kheight20,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: AdminToStaff(),
                                duration: const Duration(milliseconds: 200),
                                childCurrent: this));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Card(
                            elevation: 10,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 38,
                                width: 38,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    opacity: 20,
                                    image: AssetImage(
                                      'assets/01communication to staff.png',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          kheight10,
                          const Text(
                            'To Staff',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 11,
                                color: Colors.black87,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child:  Notification_AdminToGuardain(),
                                duration: const Duration(milliseconds: 200),
                                childCurrent: this));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Card(
                            elevation: 10,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 38,
                                width: 38,
                                decoration: BoxDecoration(
                                  image: const DecorationImage(
                                    opacity: 20,
                                    image: AssetImage(
                                      'assets/01communicationto guardian.png',
                                    ),
                                  ),
                                  borderRadius: BorderRadius.circular(0),
                                ),
                              ),
                            ),
                          ),
                          kheight10,
                          const Text(
                            'To Guardian',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 11,
                                color: Colors.black87,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: const NotificationHistory(),
                                duration: const Duration(milliseconds: 200),
                                childCurrent: this));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Card(
                            elevation: 10,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 38,
                                width: 38,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    opacity: 20,
                                    image: AssetImage(
                                      'assets/Notification.png',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          kheight10,
                          const Text(
                            'Notification\nHistory',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 11,
                                color: Colors.black87,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: const AdminGallery(),
                                duration: const Duration(milliseconds: 200),
                                childCurrent: this));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Card(
                            elevation: 10,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 38,
                                width: 38,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    opacity: 20,
                                    image: AssetImage(
                                      'assets/Gallery.png',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          kheight10,
                          const Text(
                            'Gallery',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 11,
                                color: Colors.black87,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              kheight10,
              Consumer<ModuleProviders>(
                builder: (context, module, child) => Row(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: const ScreenFlashNews(),
                                  duration: const Duration(milliseconds: 200),
                                  childCurrent: this));
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Card(
                              elevation: 10,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 38,
                                  width: 38,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      opacity: 20,
                                      image: AssetImage(
                                        'assets/01flashnews.png',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            kheight10,
                            const Text(
                              'Flash News',
                              style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: const NoticeBoardAdnin(),
                                  duration: const Duration(milliseconds: 200),
                                  childCurrent: this));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Card(
                                elevation: 10,
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 38,
                                    width: 38,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        opacity: 20,
                                        image: AssetImage(
                                          'assets/Noticeboard.png',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              kheight10,
                              const Text(
                                'NoticeBoard',
                                style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: const BirthdayInitialScreen(),
                                  duration: const Duration(milliseconds: 200),
                                  childCurrent: this));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Card(
                                elevation: 10,
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 38,
                                    width: 38,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        opacity: 20,
                                        image: AssetImage(
                                          'assets/birthdayIcon.png',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              kheight10,
                              const Text(
                                'Birthday',
                                style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Consumer<Curriculamprovider>(
                      builder: (context, curri, child) => Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            if (module.curiculam == true) {
                              await Provider.of<Curriculamprovider>(context,
                                  listen: false)
                                  .getCuriculamtoken();
                              String token = curri.token.toString();
                              await Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child:
                                      // const Homeworkentry(),
                                      CurriculamPage(
                                        token: token,
                                      ),
                                      duration:
                                      const Duration(milliseconds: 200),
                                      childCurrent: this));
                            } else {
                              _noAcess(context);
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Card(
                                  elevation: 10,
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 38,
                                      width: 38,
                                      decoration: BoxDecoration(
                                        image: const DecorationImage(
                                          opacity: 20,
                                          image: AssetImage(
                                            'assets/Curriculum.png',
                                          ),
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                                kheight10,
                                const Text(
                                  'Homework',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11,
                                      color: Colors.black87),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              kheight10,
              Consumer<ModuleProviders>(
                builder: (context, module, child) => Row(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Consumer<Curriculamprovider>(
                      builder: (context, curri, child) => Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            if (module.curiculam == true) {
                              await Provider.of<Curriculamprovider>(context,
                                  listen: false)
                                  .getCuriculamtoken();
                              String token = curri.token.toString();
                              await Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child:  PortionScreen(),
                                      duration:
                                      const Duration(milliseconds: 200),
                                      childCurrent: this));
                            } else {
                              _noAcess(context);
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Card(
                                  elevation: 10,
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 38,
                                      width: 38,
                                      decoration: BoxDecoration(
                                        image: const DecorationImage(
                                          opacity: 20,
                                          image: AssetImage(
                                            'assets/Portion Entry.png',
                                          ),
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                                kheight10,
                                const Text(
                                  'Portion',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11,
                                      color: Colors.black87),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: const TimeTableUplaod(),
                                  duration: const Duration(milliseconds: 200),
                                  childCurrent: this));
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Card(
                              elevation: 10,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 38,
                                  width: 38,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      opacity: 20,
                                      image: AssetImage(
                                        'assets/Timetable.png',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            kheight10,
                            const Text(
                              'Time Table',
                              style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {

                          module.curiculam == true
                              ?
                          await Navigator.push(
                              context,
                              PageTransition(
                                type:
                                PageTransitionType
                                    .rightToLeft,
                                child:
                                const AnecdotalInitialScreenAdmin(),
                                duration:
                                const Duration(
                                    milliseconds:
                                    300),
                              )
                          )

                              : _noAcess(context);
                        },
                        child: Column(
                          mainAxisAlignment:
                          MainAxisAlignment
                              .spaceEvenly,
                          children: [
                            Card(
                              elevation: 10,
                              color: Colors.white,
                              shape:
                              RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius
                                    .circular(
                                    12.0),
                              ),
                              child: Padding(
                                padding:
                                const EdgeInsets
                                    .all(8.0),
                                child: Container(
                                  height: 38,
                                  width: 38,
                                  decoration:
                                  const BoxDecoration(
                                    image:
                                    DecorationImage(
                                      opacity: 20,
                                      image:
                                      AssetImage(
                                        'assets/anecdotal.png',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            kheight10,
                            const Text(
                              'Anecdotal',
                              textAlign:
                              TextAlign.center,
                              style: TextStyle(
                                  fontWeight:
                                  FontWeight
                                      .bold,
                                  fontSize: 11,
                                  color: Colors
                                      .black87),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          module.timetable == true
                              ? await Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: const ExamTimetable(),
                                  duration:
                                  const Duration(milliseconds: 200),
                                  childCurrent: this))
                              : _noAcess(context);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Card(
                              elevation: 10,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 38,
                                  width: 38,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      opacity: 20,
                                      image: AssetImage(
                                        'assets/Timetable.png',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            kheight10,
                            const Text(
                              'Exam\nTimeTable',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),

/////////////////////////////////   BUs Start   ///////////////////////////////////////

                    // Consumer<SchoolNameProvider>(
                    //   builder: (context, snap, child) => snap
                    //       .allowGPSTracking ==
                    //       "true"
                    //       ?Expanded(
                    //     child: GestureDetector(
                    //       onTap: () async {
                    //
                    //         module.curiculam == true
                    //             ?
                    //         await Navigator.push(
                    //             context,
                    //             PageTransition(
                    //               type:
                    //               PageTransitionType
                    //                   .rightToLeft,
                    //               child:
                    //               BusSelectionScreen(),
                    //               duration:
                    //               const Duration(
                    //                   milliseconds:
                    //                   300),
                    //             )
                    //         )
                    //
                    //             : _noAcess(context);
                    //       },
                    //       child: Column(
                    //         mainAxisAlignment:
                    //         MainAxisAlignment
                    //             .spaceEvenly,
                    //         children: [
                    //           Card(
                    //             elevation: 10,
                    //             color: Colors.white,
                    //             shape:
                    //             RoundedRectangleBorder(
                    //               borderRadius:
                    //               BorderRadius
                    //                   .circular(
                    //                   12.0),
                    //             ),
                    //             child: Padding(
                    //               padding:
                    //               const EdgeInsets
                    //                   .all(8.0),
                    //               child: Container(
                    //                 height: 38,
                    //                 width: 38,
                    //                 decoration:
                    //                 const BoxDecoration(
                    //                   image:
                    //                   DecorationImage(
                    //                     opacity: 20,
                    //                     image:
                    //                     AssetImage(
                    //                       'assets/bus-station.png',
                    //                     ),
                    //                   ),
                    //                 ),
                    //               ),
                    //             ),
                    //           ),
                    //           kheight10,
                    //           const Text(
                    //             'Bus Tracking',
                    //             textAlign:
                    //             TextAlign.center,
                    //             style: TextStyle(
                    //                 fontWeight:
                    //                 FontWeight
                    //                     .bold,
                    //                 fontSize: 11,
                    //                 color: Colors
                    //                     .black87),
                    //           )
                    //         ],
                    //       ),
                    //     ),
                    //   )
                    //       : const SizedBox(
                    //     height: 0,
                    //     width: 0,
                    //   ),
                    // ),

/////////////////////////////////   Bus End    /////////////////////////////////////////
                  ],),),
              kheight10,
              Consumer<ModuleProviders>(
                builder: (context, module, child) => Row(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
/////////////////////////////////   BUs Start   ///////////////////////////////////////

                    Consumer<SchoolNameProvider>(
                      builder: (context, snap, child) => snap
                          .allowGPSTracking ==
                          "true"
                          ?Expanded(
                        child: GestureDetector(
                          onTap: () async {

                            module.curiculam == true
                                ?
                            await Navigator.push(
                                context,
                                PageTransition(
                                  type:
                                  PageTransitionType
                                      .rightToLeft,
                                  child:
                                  BusSelectionScreen(),
                                  duration:
                                  const Duration(
                                      milliseconds:
                                      300),
                                )
                            )

                                : _noAcess(context);
                          },
                          child: Column(
                            mainAxisAlignment:
                            MainAxisAlignment
                                .spaceEvenly,
                            children: [
                              Card(
                                elevation: 10,
                                color: Colors.white,
                                shape:
                                RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius
                                      .circular(
                                      12.0),
                                ),
                                child: Padding(
                                  padding:
                                  const EdgeInsets
                                      .all(8.0),
                                  child: Container(
                                    height: 38,
                                    width: 38,
                                    decoration:
                                    const BoxDecoration(
                                      image:
                                      DecorationImage(
                                        opacity: 20,
                                        image:
                                        AssetImage(
                                          'assets/bus-station.png',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              kheight10,
                              const Text(
                                'Bus Tracking',
                                textAlign:
                                TextAlign.center,
                                style: TextStyle(
                                    fontWeight:
                                    FontWeight
                                        .bold,
                                    fontSize: 11,
                                    color: Colors
                                        .black87),
                              )
                            ],
                          ),
                        ),
                      )
                          : const SizedBox(
                        height: 0,
                        width: 0,
                      ),
                    ),

/////////////////////////////////   Bus End    /////////////////////////////////////////
                  ],),),
              kheight20,
              Row(children: <Widget>[
                const Text(
                  ' ──  ',
                  style: TextStyle(
                    color: Colors.black26,
                  ),
                ),
                const Text(
                  "Attendance",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: UIGuide.light_Purple, fontWeight: FontWeight.w900),
                ),
                Expanded(
                  child: Container(
                      margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                      child: const Divider(
                        color: Colors.black45,
                        height: 36,
                      )),
                ),
              ]),
              kheight20,
              Consumer<ModuleProviders>(
                builder: (context, module, child) => Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          module.attendenceEntry == true
                              ? await Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child:  AttendenceEntry(),
                                  duration:
                                  const Duration(milliseconds: 200),
                                  childCurrent: this))
                              : _noAcess(context);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Card(
                              elevation: 10,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 38,
                                  width: 38,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      opacity: 20,
                                      image: AssetImage(
                                          'assets/Attendance entry.png'),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            kheight10,
                            const Center(
                              child: Text(
                                'Attendence Entry',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          module.attendenceEntry == true
                              ? await Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: const AttendanceReport(),
                                  duration:
                                  const Duration(milliseconds: 200),
                                  childCurrent: this))
                              : _noAcess(context);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Card(
                              elevation: 10,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 38,
                                  width: 38,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      opacity: 20,
                                      image: AssetImage(
                                        'assets/Attendance.png',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            kheight10,
                            const Text(
                              'Absentees Report',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          module.attendenceEntry == true
                              ? await Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: const AttendanceTakenReport(),
                                  duration:
                                  const Duration(milliseconds: 200),
                                  childCurrent: this))
                              : _noAcess(context);
                        },
                        child: Column(
                          children: [
                            Card(
                              elevation: 10,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 38,
                                  width: 38,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      opacity: 20,
                                      image: AssetImage(
                                        'assets/attendance report.png',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            kheight10,
                            const Text(
                              'Taken / NotTaken\nReport',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              kheight20,
              Row(children: <Widget>[
                const Text(
                  ' ──  ',
                  style: TextStyle(
                    color: Colors.black26,
                  ),
                ),
                const Text(
                  "Tabulation",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: UIGuide.light_Purple, fontWeight: FontWeight.w900),
                ),
                Expanded(
                  child: Container(
                      margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                      child: const Divider(
                        color: Colors.black45,
                        height: 36,
                      )),
                ),
              ]),
              kheight20,
              Consumer<ModuleProviders>(
                builder: (context, module, child) => Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          module.tabulation == true
                              ? await Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: const MarkEntryNew(),
                                duration: const Duration(milliseconds: 300),
                              ))
                              : _noAcess(context);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Card(
                              elevation: 10,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 38,
                                  width: 38,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      opacity: 20,
                                      image: AssetImage(
                                        'assets/Tabulation.png',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            kheight10,
                            const Text(
                              'MarkEntry',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                  color: Colors.black87),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          module.tabulation == true
                              ? await Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: const ToolMarkEntry(),
                                duration: const Duration(milliseconds: 300),
                              ))
                              : _noAcess(context);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Card(
                              elevation: 10,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 38,
                                  width: 38,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                        'assets/ToolMarkEntry.png',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            kheight10,
                            const Text(
                              'Tool Mark Entry',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                  color: Colors.black87),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          module.tabulation == true
                              ? await Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: const RemarksEntry(),
                                duration: const Duration(milliseconds: 300),
                              ))
                              : _noAcess(context);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Card(
                              elevation: 10,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 38,
                                  width: 38,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                        'assets/Remarks.png',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            kheight10,
                            const Text(
                              'Remarks\nEntry',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                  color: Colors.black87),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          module.hpc == true
                              ? await Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType
                                    .rightToLeft,
                                child:
                                //   SelfAssessmentEntry(),
                                HpcMain(),
                                //   const HpcEntry(),
                                duration:
                                const Duration(
                                    milliseconds:
                                    300),
                              ))
                              : _noAcess(context);
                        },
                        child: Column(
                          mainAxisAlignment:
                          MainAxisAlignment
                              .spaceEvenly,
                          children: [
                            Card(
                              elevation: 10,
                              color: Colors.white,
                              shape:
                              RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius
                                    .circular(
                                    12.0),
                              ),
                              child: Padding(
                                padding:
                                const EdgeInsets
                                    .all(8.0),
                                child: Container(
                                  height: 38,
                                  width: 38,
                                  decoration:
                                  BoxDecoration(
                                    image:
                                    DecorationImage(
                                      opacity:
                                      module.hpc ==
                                          true? 20 :0.2,
                                      image:
                                      AssetImage(
                                        'assets/hpc.png',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            kheight10,
                            Text(
                              'HPC',
                              style: TextStyle(
                                  fontWeight:
                                  FontWeight
                                      .w600,
                                  fontSize: 11,
                                  color:
                                  module.tabulation ==
                                      true  ? Colors.black:
                                  Colors.black26),
                            )
                          ],
                        ),
                      ),
                    ),
                    // Expanded(
                    //   child: GestureDetector(
                    //     onTap: () async {
                    //       module.tabulation == true
                    //           ? await Navigator.push(
                    //               context,
                    //               PageTransition(
                    //                 type: PageTransitionType.rightToLeft,
                    //                 child: MarkEntryReport(),
                    //                 duration: const Duration(milliseconds: 300),
                    //               ))
                    //           : _noAcess(context);
                    //     },
                    //     child: Column(
                    //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //       children: [
                    //         Card(
                    //           elevation: 10,
                    //           color: Colors.white,
                    //           shape: RoundedRectangleBorder(
                    //             borderRadius: BorderRadius.circular(12.0),
                    //           ),
                    //           child: Padding(
                    //             padding: const EdgeInsets.all(8.0),
                    //             child: Container(
                    //               height: 38,
                    //               width: 38,
                    //               decoration: const BoxDecoration(
                    //                 image: DecorationImage(
                    //                   image: AssetImage(
                    //                     'assets/Remarks.png',
                    //                   ),
                    //                 ),
                    //               ),
                    //             ),
                    //           ),
                    //         ),
                    //         kheight10,
                    //         const Text(
                    //           'Mark Entry\nReport',
                    //           textAlign: TextAlign.center,
                    //           style: TextStyle(
                    //               fontWeight: FontWeight.bold,
                    //               fontSize: 11,
                    //               color: Colors.black87),
                    //         )
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
              kheight20,
              Row(children: <Widget>[
                const Text(
                  ' ──  ',
                  style: TextStyle(
                    color: Colors.black26,
                  ),
                ),
                const Text(
                  "Reports",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: UIGuide.light_Purple, fontWeight: FontWeight.w900),
                ),
                Expanded(
                  child: Container(
                      margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                      child: const Divider(
                        color: Colors.black45,
                        height: 36,
                      )),
                ),
              ]),
              kheight20,
              Consumer<ModuleProviders>(
                builder: (context, module, child) => Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          module.fees == true || module.feesOnly == true
                              ? await Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: const FeeReportInitial(),
                                  duration:
                                  const Duration(milliseconds: 200),
                                  childCurrent: this))
                              : _noAcess(context);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Card(
                              elevation: 10,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 38,
                                  width: 38,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      opacity: 20,
                                      image: AssetImage(
                                        'assets/01feescollectionreport.png',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            kheight10,
                            const Center(
                              child: Text(
                                'Fees Collection\nReport',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          module.fees == true || module.feesOnly == true
                              ? await Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: const StudentFeeSearch(),
                                  duration:
                                  const Duration(milliseconds: 200),
                                  childCurrent: this))
                              : _noAcess(context);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Card(
                              elevation: 10,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 38,
                                  width: 38,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      opacity: 20,
                                      image: AssetImage(
                                        "assets/Fees.png",
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            kheight10,
                            const Text(
                              'Student\nFees Report',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          module.tabulation == true
                              ? await Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: const MissingReportAdmin(),
                                duration: const Duration(milliseconds: 300),
                              ))
                              : _noAcess(context);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Card(
                              elevation: 10,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 38,
                                  width: 38,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      opacity: 20,
                                      image: AssetImage(
                                        'assets/missing report.png',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            kheight10,
                            const Text(
                              'MarkEntry\nMissing Report ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                  color: Colors.black87),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              kheight5,
              Consumer<ModuleProviders>(
                builder: (context, module, child) => Row(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          module.mobileApp == true
                              ? await Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child:
                                  const AppReviewInitial(),
                                  duration:
                                  const Duration(milliseconds: 200),
                                  childCurrent: this))
                              : _noAcess(context);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Card(
                              elevation: 10,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 38,
                                  width: 38,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      opacity: 20,
                                      image: AssetImage(
                                        'assets/appstatistics.png',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            kheight10,
                            const Text(
                              'App User\nStatistics',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const Feedbackcategory()));
                        },
                        child: Column(
                          mainAxisAlignment:
                          MainAxisAlignment
                              .spaceEvenly,
                          children: [
                            Card(
                              elevation: 10,
                              color: Colors.white,
                              shape:
                              RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius
                                    .circular(
                                    12.0),
                              ),
                              child: Padding(
                                padding:
                                const EdgeInsets
                                    .all(8.0),
                                child: Container(
                                  height: 38,
                                  width: 38,
                                  decoration:
                                  BoxDecoration(
                                    image:
                                    DecorationImage(
                                      opacity:
                                      module.tabulation ==
                                          true? 20 :0.2,
                                      image:
                                      AssetImage(
                                        'assets/feedback_entry_icon.png',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            kheight10,
                            Text(
                              'Guardian Feedback',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight:
                                  FontWeight
                                      .w600,
                                  fontSize: 11,
                                  color:
                                  module.tabulation ==
                                      true  ? Colors.black:
                                  Colors.black26),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          SharedPreferences pref =
                          await SharedPreferences.getInstance();
                          String schdomain =
                          pref.getString("subDomain").toString();
                          print(schdomain);
                          await Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: LoginScreenWeb(
                                  schdomain: schdomain,
                                ),
                                duration: const Duration(milliseconds: 300),
                              ));
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Card(
                              elevation: 10,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 38,
                                  width: 38,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      opacity: 20,
                                      image: AssetImage(
                                        'assets/Loginwebb.png',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            kheight10,
                            const Text(
                              'Login-Web',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                  color: Colors.black87),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              kheight10,
              Container(
                  margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: const Divider(
                    color: UIGuide.light_Purple,
                    height: 36,
                  )),
              kheight10,
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      MaterialButton(
                          elevation: 10,
                          minWidth: 50,
                          color: UIGuide.THEME_LIGHT,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                          onPressed: () async {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => PasswordChange()),
                            );
                          },
                          child: const Icon(
                            Icons.key_sharp,
                            color: UIGuide.light_Purple,
                          )),
                      kheight5,
                      const Text(
                        'Change Password',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                            color: Colors.black87),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      MaterialButton(
                          minWidth: 50,
                          elevation: 10,
                          color: UIGuide.THEME_LIGHT,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                          onPressed: () async {
                            showCupertinoDialog(
                              context: context,
                              builder: (context) {
                                return Container(
                                  color: Colors.black.withOpacity(0.5),
                                  child: CupertinoAlertDialog(
                                    title: const Text("Logout"),
                                    content: const Text(
                                        "Are you sure you want to log out?"),
                                    actions: <Widget>[
                                      CupertinoDialogAction(
                                        child: const Text(
                                          "Cancel",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: UIGuide.light_Purple),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      CupertinoDialogAction(
                                        child: const Text("Logout",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: UIGuide.light_Purple)),
                                        onPressed: () async {
                                          SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                          print("accesstoken  $prefs");
                                          await prefs.remove("accesstoken");
                                          print("username  $prefs");
                                          await prefs.remove("username");
                                          print("password  $prefs");
                                          await prefs.remove("password");

                                          Navigator.of(context).pushAndRemoveUntil(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                  const LoginPage()),
                                                  (Route<dynamic> route) => false);
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: const Icon(
                            Icons.logout_outlined,
                            color: UIGuide.light_Purple,
                          )),
                      kheight5,
                      const Text(
                        'SignOut',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                            color: Colors.black87),
                      )
                    ],
                  ),
                ],
              ),
              kheight20,
              const Center(
                child: Text(
                  "Powered By GJ Infotech (P) Ltd.",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: UIGuide.light_Purple),
                ),
              ),
              kheight20,
              kheight20,
              kheight10,
            ],
          ),
        ),
      ],
    );
  }

  _noAcess(context) {
    var size = MediaQuery.of(context).size;
    return

      QuickAlert.show(
        context: context,
        type: QuickAlertType.warning,
        text: "Sorry, you don't have access to this module",
        autoCloseDuration: const Duration(seconds: 2),
        showConfirmBtn: false,

      );

    //   showAnimatedDialog(
    //   animationType: DialogTransitionType.slideFromBottomFade,
    //   curve: Curves.fastOutSlowIn,
    //   // duration: Duration(seconds: 1),
    //   context: context,
    //   barrierDismissible: true,
    //   builder: (BuildContext context) {
    //     return Dialog(
    //       shape: const RoundedRectangleBorder(
    //           borderRadius: BorderRadius.all(Radius.circular(10.0))),
    //       child: Container(
    //         height: size.height / 7.2,
    //         width: size.width * 3,
    //         child: Padding(
    //           padding: const EdgeInsets.all(5.0),
    //           child: Column(
    //             mainAxisSize: MainAxisSize.min,
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: [
    //               const SizedBox(
    //                 height: 15,
    //               ),
    //               const Text(
    //                 "Sorry, you don't have access to this module",
    //                 style: TextStyle(
    //                     fontWeight: FontWeight.w500,
    //                     fontSize: 15,
    //                     color: UIGuide.light_Purple),
    //               ),
    //               //kheight10,
    //               Expanded(
    //                 child: Row(
    //                   crossAxisAlignment: CrossAxisAlignment.center,
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   children: [
    //                     const Spacer(),
    //                     TextButton(
    //                         onPressed: () {
    //                           Navigator.pop(context);
    //                         },
    //                         child: const Text(
    //                           'Cancel',
    //                           style: TextStyle(color: Colors.grey),
    //                         )),
    //                     kWidth,
    //                     //kWidth
    //                   ],
    //                 ),
    //               )
    //             ],
    //           ),
    //         ),
    //       ),
    //     );
    //   },
    // );
  }
}

class AdminProfileTop extends StatefulWidget {
  const AdminProfileTop({Key? key}) : super(key: key);

  @override
  State<AdminProfileTop> createState() => _AdminProfileTopState();
}

class _AdminProfileTopState extends State<AdminProfileTop> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var p = Provider.of<DashboardAdmin>(context, listen: false);
      p.getDashboard();
      var m = Provider.of<SchoolPhotoProviders>(context, listen: false);
      m.getSchoolPhoto();
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: CarouselSlider(
        items: [
          Container(
            width: size.width,
            margin: const EdgeInsets.all(6.0),
            decoration: BoxDecoration(
                gradient: const LinearGradient(
                    colors: [Color(0xFFc2e59c), Color(0xFF64b3f4)]),
                // color: UIGuide.light_Purple,
                border: Border.all(color: UIGuide.THEME_LIGHT),
                borderRadius: const BorderRadius.all(Radius.circular(5))),
            child: Consumer<DashboardAdmin>(
              builder: (context, value, child) => value.loading
                  ? spinkitLoader()
                  : SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 4,
                    ),
                    const Text(
                      'Student Info',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color.fromARGB(255, 37, 37, 117),
                          fontWeight: FontWeight.bold),
                    ),
                    Row(children: [
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            kheight10,
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  const Text(
                                    'Total Strength:  ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    value.totalStudentStrength == null
                                        ? '--'
                                        : value.totalStudentStrength
                                        .toString(),
                                    style: const TextStyle(
                                        color: UIGuide.light_Purple,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  const Text(
                                    'Boys Strength:  ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    value.boysStrength == null
                                        ? '--'
                                        : value.boysStrength.toString(),
                                    style: const TextStyle(
                                        color: UIGuide.light_Purple,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  const Text(
                                    'Girls Strength:  ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    value.girlsStrength == null
                                        ? '--'
                                        : value.girlsStrength.toString(),
                                    style: const TextStyle(
                                        color: UIGuide.light_Purple,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      const Spacer(),
                      Container(
                        height: 100,
                        width: 85,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    "assets/cardstudent.png"))),
                      ),
                      const Spacer(),
                    ]),
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: size.width,
            margin: const EdgeInsets.all(6.0),
            decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [
                  Color.fromARGB(255, 79, 93, 223),
                  Color.fromARGB(255, 98, 195, 219),
                ]),
                border: Border.all(color: UIGuide.THEME_LIGHT),
                borderRadius: const BorderRadius.all(Radius.circular(5))),
            child: Consumer<DashboardAdmin>(
                builder: (context, value, child) => value.loading
                    ? spinkitLoader()
                    : SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 4,
                      ),
                      const Text(
                        'Staff Info',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color.fromARGB(255, 37, 37, 117),
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                kheight10,
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      const Text(
                                        'Total Strength:  ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        value.totalStaffStrength == null
                                            ? '--'
                                            : value.totalStaffStrength
                                            .toString(),
                                        style: const TextStyle(
                                            color: UIGuide.light_Purple,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(0),
                                  child: Row(
                                    children: [
                                      const Text(
                                        '  Teaching  :  ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        value.teachingStrength == null
                                            ? '--'
                                            : value.teachingStrength
                                            .toString(),
                                        style: const TextStyle(
                                            color: UIGuide.light_Purple,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      const Text(
                                        'Non-Teaching:  ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        value.nonTeachingStrength == null
                                            ? '--'
                                            : value.nonTeachingStrength
                                            .toString(),
                                        style: const TextStyle(
                                            color: UIGuide.light_Purple,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          const Spacer(),
                          Container(
                            height: 100,
                            width: 85,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/Staffdb1.png"))),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ],
                  ),
                )),
          ),
          Consumer<SchoolPhotoProviders>(
            builder: (context, value, child) => Container(
              width: size.width,
              margin: const EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                image: DecorationImage(
                  image: NetworkImage(value.url ??
                      "https://previews.123rf.com/images/dualororua/dualororua1707/dualororua170700237/82718617-happy-school-children-in-front-of-school-building.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
        options: CarouselOptions(
          height: 150.0,
          enlargeCenterPage: true,
          autoPlay: true,
          aspectRatio: 16 / 9,
          autoPlayCurve: Curves.easeInBack,
          enableInfiniteScroll: true,
          autoPlayAnimationDuration: const Duration(milliseconds: 700),
          viewportFraction: 0.75,
        ),
      ),
    );
  }
}

