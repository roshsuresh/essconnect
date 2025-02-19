import 'package:carousel_slider/carousel_slider.dart';
import 'package:essconnect/Application/AdminProviders/SchoolPhotoProviders.dart';
import 'package:essconnect/Application/AdminProviders/dashboardProvider.dart';
import 'package:essconnect/Application/Module%20Providers.dart/Module.dart';
import 'package:essconnect/Application/Module%20Providers.dart/SchoolNameProvider.dart';
import 'package:essconnect/Application/StudentProviders/CurriculamProviders.dart';
import 'package:essconnect/Presentation/Admin/AttendanceTaken/Takenornot.dart';
import 'package:essconnect/Presentation/Admin/Communication/ToGuardian.dart';
import 'package:essconnect/Presentation/Admin/Communication/ToStaff.dart';
import 'package:essconnect/Presentation/Admin/ExamTimetable/ExamScreen.dart';
import 'package:essconnect/Presentation/Admin/History/NotificationHistoryStaff.dart';
import 'package:essconnect/Presentation/Admin/StaffReport.dart';
import 'package:essconnect/Presentation/Admin/StudentStatistiics.dart';
import 'package:essconnect/Presentation/SchoolSuperAdmin/GalleryReceived.dart';
import 'package:essconnect/Presentation/SchoolSuperAdmin/NoticeBoardSA.dart';
import 'package:essconnect/Presentation/Staff/MarkEntryNew.dart';
import 'package:essconnect/Presentation/Staff/MissingReport.dart';
import 'package:essconnect/Presentation/Staff/RemarksEntry.dart';
import 'package:essconnect/Presentation/Staff/StaffHome.dart';
import 'package:essconnect/Presentation/Staff/StudAttendenceEntry.dart';
import 'package:essconnect/Presentation/Staff/StudReport.dart';
import 'package:essconnect/Presentation/Staff/ToolMarkEntry.dart';
import 'package:essconnect/Presentation/Student/CurriculamScreen.dart';
import 'package:essconnect/Presentation/Student/NoInternetScreen.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:essconnect/utils/spinkit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upgrader/upgrader.dart';
import '../../Application/StudentProviders/InternetConnection.dart';
import '../../Constants.dart';
import '../Admin/Anecdotal/AnecdotalInitialScreenAdmin.dart';
import '../Admin/AppReview.dart';
import '../Admin/AttendanceTaken/AbsentReport.dart';
import '../Login_Activation/Login_page.dart';
import '../Staff/Portion/Portions.dart';
import '../Student/PasswordChange.dart';

class SchoolHeadHomeScreen extends StatefulWidget {
  const SchoolHeadHomeScreen({Key? key}) : super(key: key);

  @override
  State<SchoolHeadHomeScreen> createState() => _SchoolHeadHomeScreenState();
}

class _SchoolHeadHomeScreenState extends State<SchoolHeadHomeScreen> {
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
            : UpgradeAlert(
                upgrader: Upgrader(
                    showReleaseNotes: false,
                    showIgnore: false,
                    dialogStyle: UpgradeDialogStyle.cupertino,
                    durationUntilAlertAgain: const Duration(days: 1)),
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
                    const SuperAdminProfileTop(),
                    const SizedBox(
                      height: 2,
                    ),
                    const StaffFlashNews(),
                    Container(
                      width: size.width,
                      height: size.height - 200,
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: UIGuide.THEME_LIGHT, width: 1),
                          color: Colors.white,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30))),
                      child: const SchoolHeadHomeScreenContents(),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}

class SchoolHeadHomeScreenContents extends StatelessWidget {
  const SchoolHeadHomeScreenContents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        Container(
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const StudReport()),
                      );
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
                              'Student \n Report',
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
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Student_statistics_admin()),
                      );
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
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const GalleryReceivedSAdmin()),
                      );
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
                            style: TextStyle(
                                fontSize: 11,
                                color: Colors.black87,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NoticeBoardSA()),
                      );
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
                ],
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
              Consumer<ModuleProviders>(
                builder: (context, module, child) => Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AdminToStaff()),
                              );
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
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Notification_AdminToGuardain()),
                            );
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
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                        Consumer<ModuleProviders>(
                          builder: (context, module, child) =>
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
                        ),


                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            module.timetable == true
                                ? await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                  const ExamTimetable()),
                            )
                                : _noAcess(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 30,),
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

                        Consumer<Curriculamprovider>(
                          builder: (context, curri, child) =>
                              GestureDetector(
                                onTap: () async {
                                  if (module.curiculam == true) {
                                    await Provider.of<
                                        Curriculamprovider>(
                                        context,
                                        listen: false)
                                        .getCuriculamtoken();
                                    String token =
                                    curri.token.toString();

                                    await Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType
                                            .rightToLeft,
                                        child: PortionScreen(),
                                        duration: const Duration(
                                            milliseconds: 300),
                                      ),
                                    );
                                  } else {
                                    _noAcess(context);
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 5, right: 5),
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Card(
                                        elevation: 10,
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(
                                              12.0),
                                        ),
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: 38,
                                            width: 38,
                                            decoration: BoxDecoration(
                                              image:
                                              const DecorationImage(
                                                opacity: 20,
                                                image: AssetImage(
                                                  'assets/Portion Entry.png',
                                                ),
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(
                                                  10),
                                            ),
                                          ),
                                        ),
                                      ),
                                      kheight10,
                                      const Text(
                                        'Portion',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 11,
                                            color: Colors.black),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                        ),

                        Consumer<Curriculamprovider>(
                          builder: (context, curri, child) => GestureDetector(
                            onTap: () async {
                              if (module.curiculam == true) {
                                await Provider.of<Curriculamprovider>(context,
                                    listen: false)
                                    .getCuriculamtoken();
                                String token = curri.token.toString();
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CurriculamPage(
                                        token: token,
                                      )),
                                );
                              } else {
                                _noAcess(context);
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.only( right:20),
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
                                    'e-Classroom',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11,
                                        color: Colors.black87),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    )
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
                    GestureDetector(
                      onTap: () async {
                        module.attendenceEntry == true
                            ? await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const AttendenceEntry()),
                              )
                            : _noAcess(context);
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
                                          'assets/Attendance entry.png'),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            kheight10,
                            const Center(
                              child: Text(
                                'Attendence\nEntry',
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
                    GestureDetector(
                      onTap: () async {
                        module.attendenceEntry == true
                            ? await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const AttendanceReport()),
                              )
                            : _noAcess(context);
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
                                        'assets/Attendance.png',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            kheight10,
                            const Text(
                              'Absentees\nReport',
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
                    GestureDetector(
                      onTap: () async {
                        module.attendenceEntry == true
                            ? await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const AttendanceTakenReport()),
                              )
                            : _noAcess(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
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
                    GestureDetector(
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
                    GestureDetector(
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
                              'Tool Mark\nEntry',
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
                    GestureDetector(
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
                              'Remarks Entry',
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
              kheight10,
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
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const StaffReport()),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
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
                              ' Staff Report',
                              style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        module.tabulation == true
                            ? await Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: const MissingReport(),
                                  duration: const Duration(milliseconds: 300),
                                ))
                            : _noAcess(context);
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
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const NotificationHistory()),
                        );
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
                                        'assets/Notification.png',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            kheight10,
                            const Text(
                              'Notification\n     History',
                              style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        module.mobileApp == true ? await Navigator.push(
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
                            'App User \n Statistics',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 11,
                                color: Colors.black87,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              kheight10,
             // kheight10,
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
    return showAnimatedDialog(
      animationType: DialogTransitionType.slideFromBottomFade,
      curve: Curves.fastOutSlowIn,
      // duration: Duration(seconds: 1),
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          child: SizedBox(
            height: size.height / 7.2,
            width: size.width * 3,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "Sorry, you don't have access to this module",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: UIGuide.light_Purple),
                  ),
                  //kheight10,
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Spacer(),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Cancel',
                              style: TextStyle(color: Colors.grey),
                            )),
                        kWidth,
                        //kWidth
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class SuperAdminProfileTop extends StatefulWidget {
  const SuperAdminProfileTop({Key? key}) : super(key: key);

  @override
  State<SuperAdminProfileTop> createState() => _SuperAdminProfileTopState();
}

class _SuperAdminProfileTopState extends State<SuperAdminProfileTop> {
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
