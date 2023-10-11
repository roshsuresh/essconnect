import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:essconnect/Application/Module%20Providers.dart/Module.dart';
import 'package:essconnect/Application/Module%20Providers.dart/SchoolNameProvider.dart';
import 'package:essconnect/Application/Staff_Providers/NotificationCount.dart';
import 'package:essconnect/Application/StudentProviders/CurriculamProviders.dart';
import 'package:essconnect/Application/StudentProviders/InternetConnection.dart';
import 'package:essconnect/Application/StudentProviders/SiblingsProvider.dart';
import 'package:essconnect/Presentation/Staff/AbsenteesReport.dart';
import 'package:essconnect/Presentation/Staff/ExamTT.dart/ExamTTScreen.dart';
import 'package:essconnect/Presentation/Staff/GalleryUpload.dart';
import 'package:essconnect/Presentation/Staff/MarkEntryNew.dart';
import 'package:essconnect/Presentation/Staff/MissingReport.dart';
import 'package:essconnect/Presentation/Staff/NoticeBoard.dart';
import 'package:essconnect/Presentation/Staff/RemarksEntry.dart';
import 'package:essconnect/Presentation/Staff/ScreenNotification.dart';
import 'package:essconnect/Presentation/Staff/StaffProfile.dart';
import 'package:essconnect/Presentation/Staff/StaffTimeTable.dart';
import 'package:essconnect/Presentation/Staff/StudAttendenceEntry.dart';
import 'package:essconnect/Presentation/Staff/StudReport.dart';
import 'package:essconnect/Presentation/Staff/ToGuardian.dart';
import 'package:essconnect/Presentation/Staff/ToolMarkEntry.dart';
import 'package:essconnect/Presentation/StaffAsGuardian.dart/StudentHomeStaff.dart';
import 'package:essconnect/Presentation/Student/CurriculamScreen.dart';
import 'package:essconnect/Presentation/Student/NoInternetScreen.dart';
import 'package:essconnect/utils/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:marquee/marquee.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upgrader/upgrader.dart';
import '../../Application/Staff_Providers/StaffFlashnews.dart';
import '../../Application/Staff_Providers/StaffProfile.dart';
import '../../Constants.dart';
import '../../utils/constants.dart';
import '../Login_Activation/Login_page.dart';
import '../Student/PasswordChange.dart';

class StaffHomeScreen extends StatefulWidget {
  StaffHomeScreen({Key? key}) : super(key: key);

  @override
  State<StaffHomeScreen> createState() => _StaffHomeScreenState();
}

class _StaffHomeScreenState extends State<StaffHomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Provider.of<ConnectivityProvider>(context, listen: false);
      await Provider.of<StaffNotificationCountProviders>(context, listen: false)
          .getnotificationCount();
      await Provider.of<ModuleProviders>(context, listen: false)
          .getModuleDetails();
      Provider.of<SibingsProvider>(context, listen: false).siblingList.clear();
      await Provider.of<SibingsProvider>(context, listen: false)
          .getSiblingName();
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
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    Consumer<SchoolNameProvider>(
                      builder: (context, snap, child) => snap.schoolname == null
                          ? Container(
                              height: 0,
                              width: 0,
                            )
                          : Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Container(
                                padding: EdgeInsets.only(top: 4, bottom: 4),
                                decoration: BoxDecoration(
                                  // border: Border.all(color: UIGuide.THEME_LIGHT),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5)),
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
                                  style: TextStyle(
                                      color: UIGuide.light_Purple,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                )),
                              ),
                            ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: StaffProfile(),
                    ), //  <--<---  StaffProfile....
                    StaffFlashNews(),
                    Container(
                      clipBehavior: Clip.antiAlias,
                      width: size.width,
                      height: size.height - 200,
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(blurRadius: 5, offset: Offset(1, 3))
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30)),
                      ),
                      child: ListView(
                        physics: const BouncingScrollPhysics(),
                        children: [
                          kheight20,
                          kheight10,
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  await Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.rightToLeft,
                                        child: const StaffProfileView(),
                                        duration:
                                            const Duration(milliseconds: 300),
                                      ));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Card(
                                          elevation: 10,
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
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
                                                    'assets/Profilee.png',
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        kheight10,
                                        const Text(
                                          'Profile',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 11,
                                              color: Colors.black),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  await Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.rightToLeft,
                                        child: StudentHomeByStaff(),
                                        duration:
                                            const Duration(milliseconds: 300),
                                      ));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Card(
                                        elevation: 10,
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
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
                                                  'assets/01communicationto guardian.png',
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      kheight10,
                                      const Text(
                                        'Student Login',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 11,
                                            color: Colors.black),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  await Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.rightToLeft,
                                        child: const StudReport(),
                                        duration:
                                            const Duration(milliseconds: 300),
                                      ));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Card(
                                        elevation: 10,
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: 38,
                                            width: 38,
                                            decoration: const BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(
                                                  'assets/01student report.png',
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      kheight10,
                                      const Text(
                                        'Student\nReport',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 11,
                                            color: Colors.black),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Consumer<StaffNotificationCountProviders>(
                                builder: (context, count, child) => count
                                        .loading
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Card(
                                              elevation: 10,
                                              color: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  height: 38,
                                                  width: 38,
                                                  decoration:
                                                      const BoxDecoration(
                                                    image: DecorationImage(
                                                      image: AssetImage(
                                                        'assets/notificationnew.png',
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            kheight10,
                                            const Text(
                                              'Notifications',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 11,
                                                  color: Colors.black),
                                            )
                                          ],
                                        ),
                                      )
                                    : badges.Badge(
                                        showBadge:
                                            count.count == 0 ? false : true,
                                        badgeAnimation: const badges
                                            .BadgeAnimation.rotation(
                                          animationDuration:
                                              Duration(seconds: 1),
                                          colorChangeAnimationDuration:
                                              Duration(seconds: 1),
                                          loopAnimation: false,
                                          curve: Curves.fastOutSlowIn,
                                          colorChangeAnimationCurve:
                                              Curves.easeInCubic,
                                        ),
                                        position:
                                            badges.BadgePosition.topEnd(end: 9),
                                        badgeContent: Text(
                                          count.count == null
                                              ? '0'
                                              : count.count.toString(),
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        child: GestureDetector(
                                          onTap: () async {
                                            // await Provider.of<
                                            //             StaffNotificationCountProviders>(
                                            //         context,
                                            //         listen: false)
                                            //     .seeNotification();
                                            // await Provider.of<
                                            //             StaffNotificationCountProviders>(
                                            //         context,
                                            //         listen: false)
                                            //     .getnotificationCount();

                                            await Navigator.push(
                                                context,
                                                PageTransition(
                                                  type: PageTransitionType
                                                      .rightToLeft,
                                                  child:
                                                      StaffNotificationScreen(),
                                                  duration: const Duration(
                                                      milliseconds: 300),
                                                  // childCurrent:this
                                                ));
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10),
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
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Container(
                                                      height: 38,
                                                      width: 38,
                                                      decoration:
                                                          const BoxDecoration(
                                                        image: DecorationImage(
                                                          image: AssetImage(
                                                            'assets/notificationnew.png',
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                kheight10,
                                                const Text(
                                                  'Notifications',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 11,
                                                      color: Colors.black),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                              ),
                            ],
                          ),
                          // kheight10,
                          // kheight20,
                          // Row(
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //   children: [

                          //   ],
                          // ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              height: 170,
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 236, 237, 245),
                                  borderRadius: BorderRadius.circular(20)),
                              width: size.width,
                              child: Column(
                                children: [
                                  kheight10,
                                  Row(children: <Widget>[
                                    const Text(
                                      ' ──  ',
                                      style: TextStyle(
                                        color: Colors.black26,
                                      ),
                                    ),
                                    const Text(
                                      " * Entries * ",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: UIGuide.light_Purple,
                                          fontWeight: FontWeight.w900),
                                    ),
                                    Expanded(
                                      child: Container(
                                          margin: const EdgeInsets.only(
                                              left: 10.0, right: 20.0),
                                          child: const Divider(
                                            color: UIGuide.light_Purple,
                                            height: 36,
                                          )),
                                    ),
                                  ]),
                                  kheight10,
                                  //kheight10,
                                  Consumer<ModuleProviders>(
                                    builder: (context, module, child) => Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 5, right: 5),
                                          child: GestureDetector(
                                            onTap: () async {
                                              module.attendenceEntry == true
                                                  ? await Navigator.push(
                                                      context,
                                                      PageTransition(
                                                        type: PageTransitionType
                                                            .rightToLeft,
                                                        child:
                                                            AttendenceEntry(),
                                                        duration:
                                                            const Duration(
                                                                milliseconds:
                                                                    300),
                                                      ))
                                                  : _noAcess();
                                            },
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
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Container(
                                                      height: 38,
                                                      width: 38,
                                                      decoration:
                                                          const BoxDecoration(
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
                                                const Text(
                                                  'Attendance',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 11,
                                                      color: Colors.black),
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
                                                      type: PageTransitionType
                                                          .rightToLeft,
                                                      child:
                                                          const MarkEntryNew(),
                                                      duration: const Duration(
                                                          milliseconds: 300),
                                                    ))
                                                : _noAcess();
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
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Container(
                                                      height: 38,
                                                      width: 38,
                                                      decoration:
                                                          const BoxDecoration(
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
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 11,
                                                      color: Colors.black),
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
                                                      type: PageTransitionType
                                                          .rightToLeft,
                                                      child:
                                                          const ToolMarkEntry(),
                                                      duration: const Duration(
                                                          milliseconds: 300),
                                                    ))
                                                : _noAcess();
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
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Container(
                                                      height: 38,
                                                      width: 38,
                                                      decoration:
                                                          const BoxDecoration(
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
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 11,
                                                      color: Colors.black),
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
                                                      type: PageTransitionType
                                                          .rightToLeft,
                                                      child:
                                                          const RemarksEntry(),
                                                      duration: const Duration(
                                                          milliseconds: 300),
                                                    ))
                                                : _noAcess();
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
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Container(
                                                      height: 38,
                                                      width: 38,
                                                      decoration:
                                                          const BoxDecoration(
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
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 11,
                                                      color: Colors.black),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          Row(children: <Widget>[
                            const Text(
                              ' ──    ',
                              style: TextStyle(
                                color: Colors.black26,
                              ),
                            ),
                            const Text(
                              "Communication",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: UIGuide.light_Purple,
                                  fontWeight: FontWeight.w900),
                            ),
                            Expanded(
                              child: Container(
                                  margin: const EdgeInsets.only(
                                      left: 20.0, right: 10.0),
                                  child: const Divider(
                                    color: UIGuide.light_Purple,
                                    height: 36,
                                  )),
                            ),
                          ]),
                          kheight10,
                          // kheight20,

                          Consumer<ModuleProviders>(
                            builder: (context, module, child) => Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    module.curiculam == true
                                        ? await Navigator.push(
                                            context,
                                            PageTransition(
                                              type: PageTransitionType
                                                  .rightToLeft,
                                              child: Staff_ToGuardian(),
                                              duration: const Duration(
                                                  milliseconds: 300),
                                              // childCurrent:this
                                            ))
                                        : _noAcess();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Card(
                                          elevation: 10,
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
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
                                          'To Guardian',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 11,
                                              color: Colors.black),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: GestureDetector(
                                    onTap: () async {
                                      await Navigator.push(
                                          context,
                                          PageTransition(
                                            type:
                                                PageTransitionType.rightToLeft,
                                            child: StaffNoticeBoard(),
                                            duration: const Duration(
                                                milliseconds: 300),
                                          ));
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Card(
                                          elevation: 10,
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
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
                                                    'assets/Noticeboard.png',
                                                  ),
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                          ),
                                        ),
                                        kheight10,
                                        const Text(
                                          'Notice Board',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 11,
                                              color: Colors.black),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    await Navigator.push(
                                        context,
                                        PageTransition(
                                          type: PageTransitionType.rightToLeft,
                                          child: const StaffGallery(),
                                          duration:
                                              const Duration(milliseconds: 300),
                                        ));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Card(
                                          elevation: 10,
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
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
                                          'Gallery ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 11,
                                              color: Colors.black),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    module.timetable == true
                                        ? await Navigator.push(
                                            context,
                                            PageTransition(
                                              type: PageTransitionType
                                                  .rightToLeft,
                                              child: const ExamTimetableStaff(),
                                              duration: const Duration(
                                                  milliseconds: 300),
                                            ))
                                        : _noAcess();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Card(
                                          elevation: 10,
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              height: 38,
                                              width: 38,
                                              decoration: const BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                    'assets/diary.png',
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        kheight10,
                                        const Text(
                                          'Exam\nTimetable',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 11,
                                              color: Colors.black),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          kheight20,
                          Consumer<ModuleProviders>(
                            builder: (context, module, _) => Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Consumer<Curriculamprovider>(
                                  builder: (context, curri, child) =>
                                      GestureDetector(
                                    onTap: () async {
                                      if (module.curiculam == true) {
                                        await Provider.of<Curriculamprovider>(
                                                context,
                                                listen: false)
                                            .getCuriculamtoken();
                                        String token =
                                            await curri.token.toString();

                                        await Navigator.push(
                                            context,
                                            PageTransition(
                                              type: PageTransitionType
                                                  .rightToLeft,
                                              child: CurriculamPage(
                                                token: token,
                                              ),
                                              duration: const Duration(
                                                  milliseconds: 300),
                                            ));
                                      } else {
                                        _noAcess();
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Card(
                                            elevation: 10,
                                            color: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
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
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                            ),
                                          ),
                                          kheight10,
                                          const Text(
                                            'e-Class room',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 11,
                                                color: Colors.black),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    module.timetable == true
                                        ? await Navigator.push(
                                            context,
                                            PageTransition(
                                              type: PageTransitionType
                                                  .rightToLeft,
                                              child: const Staff_Timetable(),
                                              duration: const Duration(
                                                  milliseconds: 300),
                                            ))
                                        : _noAcess();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Card(
                                          elevation: 10,
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              height: 38,
                                              width: 38,
                                              decoration: const BoxDecoration(
                                                image: DecorationImage(
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
                                          'Timetable',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 11,
                                              color: Colors.black),
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
                                              type: PageTransitionType
                                                  .rightToLeft,
                                              child: const MissingReport(),
                                              duration: const Duration(
                                                  milliseconds: 300),
                                            ))
                                        : _noAcess();
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
                                                BorderRadius.circular(12.0),
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
                                          'MarkEntry\nMissing Report ',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 11,
                                              color: Colors.black),
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
                                            PageTransition(
                                              type: PageTransitionType
                                                  .rightToLeft,
                                              child:
                                                  const AbsenteesReportStaff(),
                                              duration: const Duration(
                                                  milliseconds: 300),
                                            ))
                                        : _noAcess();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Card(
                                          elevation: 10,
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
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
                                              fontWeight: FontWeight.w400,
                                              fontSize: 11,
                                              color: Colors.black),
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
                              "Change Password/ SignOut",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: UIGuide.light_Purple,
                                  fontWeight: FontWeight.w900),
                            ),
                            Expanded(
                              child: Container(
                                  margin: const EdgeInsets.only(
                                      left: 20.0, right: 10.0),
                                  child: const Divider(
                                    color: Colors.black,
                                    height: 36,
                                  )),
                            ),
                          ]),
                          kheight10,
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              MaterialButton(
                                  elevation: 10,
                                  minWidth: 50,
                                  color: UIGuide.THEME_LIGHT,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(30.0)),
                                  onPressed: () async {
                                    await Navigator.push(
                                        context,
                                        PageTransition(
                                          type: PageTransitionType.rightToLeft,
                                          child: PasswordChange(),
                                          duration:
                                              const Duration(milliseconds: 300),
                                          // childCurrent:this
                                        ));
                                    // Navigator.of(context).push(
                                    //   MaterialPageRoute(
                                    //       builder: (context) =>
                                    //         PasswordChange(),),
                                    // );
                                  },
                                  child: const Icon(
                                    Icons.key_sharp,
                                    color: UIGuide.light_Purple,
                                  )),
                              MaterialButton(
                                  minWidth: 50,
                                  elevation: 10,
                                  color: UIGuide.THEME_LIGHT,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(30.0)),
                                  onPressed: () async {
                                    AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.info,
                                      borderSide: const BorderSide(
                                          color: UIGuide.light_Purple,
                                          width: 2),
                                      buttonsBorderRadius:
                                          const BorderRadius.all(
                                              Radius.circular(2)),
                                      headerAnimationLoop: false,
                                      animType: AnimType.bottomSlide,
                                      title: 'SignOut',
                                      desc: 'Are you sure want to sign out',
                                      showCloseIcon: true,
                                      btnOkColor: UIGuide.button1,
                                      btnCancelColor: UIGuide.button2,
                                      btnCancelOnPress: () {
                                        return;
                                      },
                                      btnOkOnPress: () async {
                                        SharedPreferences prefs =
                                            await SharedPreferences
                                                .getInstance();
                                        print("accesstoken  $prefs");
                                        await prefs.remove("accesstoken");
                                        print("username  $prefs");
                                        await prefs.remove("username");
                                        print("password  $prefs");
                                        await prefs.remove("password");

                                        Navigator.of(context)
                                            .pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        LoginPage()),
                                                (Route<dynamic> route) =>
                                                    false);
                                      },
                                    ).show();
                                  },
                                  child: const Icon(
                                    Icons.logout_outlined,
                                    color: UIGuide.light_Purple,
                                  )),
                            ],
                          ),
                          kheight20,
                          Consumer<SibingsProvider>(
                            builder: (context, value, child) {
                              return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: value.siblingList.isEmpty
                                      ? 0
                                      : value.siblingList.length,
                                  itemBuilder: (context, index) {
                                    var idd =
                                        value.siblingList[index].id ?? '--';
                                    Provider.of<SibingsProvider>(context,
                                            listen: false)
                                        .getToken(idd);
                                    return Container(
                                      height: 0,
                                      width: 0,
                                    );
                                  });
                            },
                          ),
                          const Center(
                            child: Text(
                              "Powered By GJ Infotech (P) Ltd.",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: UIGuide.light_Purple),
                            ),
                          ),
                          kheight20, kheight20, kheight20,
                          kheight10,
                          kheight10, kheight10, kheight10,
                          kheight10, kheight10,
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  _noAcess() {
    var size = MediaQuery.of(context).size;
    return showAnimatedDialog(
      animationType: DialogTransitionType.slideFromBottomFade,
      curve: Curves.fastOutSlowIn,
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
                              style: TextStyle(),
                            )),
                        kWidth,
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

class StaffProfile extends StatelessWidget {
  StaffProfile({Key? key}) : super(key: key);

  // late AnimationController _controller;
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var p = Provider.of<StaffProfileProvider>(context, listen: false);
      p.staff_profileData();
    });
    var size = MediaQuery.of(context).size;
    const Color background = Colors.white;
    const Color fill1 = Color.fromARGB(255, 7, 110, 206);
    const Color fill2 = Color.fromARGB(255, 164, 197, 247);

    final List<Color> gradient = [
      fill1,
      fill2,
    ];
    const double fillPercent = 35;
    const double fillStop = (100 - fillPercent) / 100;
    final List<double> stops = [
      0.0,
      fillStop,
    ];
    return Column(
      children: [
        const SizedBox(
          height: 2,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10),
          child: Container(
              height: 140,
              width: size.width,
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      UIGuide.light_Purple,
                      Color.fromARGB(255, 25, 121, 201),
                      Color.fromARGB(255, 64, 148, 216),
                    ],
                  ),
                  border: Border.all(color: UIGuide.THEME_LIGHT),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  )),
              child: Stack(
                children: [
                  // Row(
                  //   children: [
                  //     kWidth,
                  //     LottieBuilder.network(
                  //         "https://assets7.lottiefiles.com/packages/lf20_2m1smtya.json"),
                  //     const Spacer(),
                  //     LottieBuilder.network(
                  //         "https://assets7.lottiefiles.com/packages/lf20_2m1smtya.json"),
                  //     //"https://assets3.lottiefiles.com/packages/lf20_w6y7r1ap.json"),
                  //     kWidth
                  //   ],
                  // ),
                  Consumer<StaffProfileProvider>(
                    builder: (context, value, child) => value.loading
                        ? spinkitLoader()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(value.photo ==
                                                  null
                                              ? 'https://gj-eschool-files-public.s3.ap-south-1.amazonaws.com/ess-connect/student/avathar-01.jpeg'
                                              : value.photo.toString()),
                                        ),
                                        shape: BoxShape.circle,
                                        boxShadow: const [
                                          BoxShadow(blurRadius: 1)
                                        ]),
                                    width: 70,
                                    height: 100,
                                  ),
                                  RichText(
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    strutStyle: const StrutStyle(fontSize: 8.0),
                                    text: TextSpan(
                                        style: const TextStyle(
                                            fontSize: 15,
                                            color: UIGuide.THEME_LIGHT,
                                            fontWeight: FontWeight.w900),
                                        text: value.name == null
                                            ? '----'
                                            : value.name.toString()),
                                  ),
                                  RichText(
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    strutStyle: const StrutStyle(fontSize: 8.0),
                                    text: TextSpan(
                                        style: const TextStyle(
                                            fontSize: 13,
                                            color: Color.fromARGB(
                                                255, 190, 190, 190),
                                            fontWeight: FontWeight.w900),
                                        text: value.designation == null
                                            ? '---'
                                            : value.designation.toString()),
                                  ),
                                ],
                              ),
                            ],
                          ),
                  ),
                ],
              )),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

class StaffFlashNews extends StatelessWidget {
  StaffFlashNews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var p = Provider.of<FlashnewsProvider>(context, listen: false);
      p.flashNewsProvider();
    });

    var size = MediaQuery.of(context).size;
    return Consumer<FlashnewsProvider>(
      builder: (context, value, child) {
        if (value.flashnews == null || value.flashnews == '') {
          return Container(
            height: 25,
          );
        } else {
          return LimitedBox(
            maxHeight: 30,
            child: value.loading
                ? Container(
                    height: 30,
                    width: 30,
                  )
                : LimitedBox(
                    maxHeight: 30,
                    child: Marquee(
                      text: value.flashnews == null || value.flashnews == ''
                          ? '-----'
                          : value.flashnews.toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          fontSize: 14),
                      scrollAxis: Axis.horizontal,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      blankSpace: 60.0,
                      velocity: 40.0,
                      pauseAfterRound: const Duration(seconds: 1),
                      showFadingOnlyWhenScrolling: true,
                      fadingEdgeStartFraction: 0.3,
                      fadingEdgeEndFraction: 0.3,
                      numberOfRounds: null,
                      startPadding: 10.0,
                      accelerationDuration: const Duration(seconds: 1),
                      accelerationCurve: Curves.linear,
                      decelerationDuration: const Duration(milliseconds: 500),
                      decelerationCurve: Curves.easeOut,
                    ),
                  ),
          );
        }
      },
    );
  }
}
