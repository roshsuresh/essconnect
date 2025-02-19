
import 'package:essconnect/Presentation/Staff/staff_feedback.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_infinite_marquee/flutter_infinite_marquee.dart';

import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upgrader/upgrader.dart';
import '../../Application/Module Providers.dart/Module.dart';
import '../../Application/Module Providers.dart/SchoolNameProvider.dart';
import '../../Application/Staff_Providers/NotificationCount.dart';
import '../../Application/Staff_Providers/Notification_ToGuardianProvider.dart';
import '../../Application/Staff_Providers/StaffFlashnews.dart';
import '../../Application/Staff_Providers/StaffProfile.dart';
import '../../Application/StudentProviders/CurriculamProviders.dart';
import '../../Application/StudentProviders/InternetConnection.dart';
import '../../Constants.dart';
import '../../utils/constants.dart';
import '../../utils/spinkit.dart';
import '../Admin/Birthday/InitialScreen.dart';
import '../Admin/WebViewLogin.dart';
import '../Login_Activation/Login_page.dart';
import '../Student/CurriculamScreen.dart';
import '../Student/NoInternetScreen.dart';
import '../Student/PasswordChange.dart';
import '../Student/Student_home.dart';
import 'AbsenteesReport.dart';
import 'Anecdotal/StudAnecdotal/AnecdotalInitialScreen.dart';
import 'CommunicationToGuardian.dart';
import 'ExamTT.dart/ExamTTScreen.dart';
import 'GalleryUpload.dart';
import 'HPC/HPC_Home_Page.dart';
import 'MarkEntryNew.dart';
import 'MissingReport.dart';
import 'NoticeBoard.dart';
import 'Portion/Portions.dart';
import 'RemarksEntry.dart';
import 'ScreenNotification.dart';
import 'StaffProfile.dart';
import 'StaffTimeTable.dart';
import 'StudAttendenceEntry.dart';
import 'StudReport.dart';
import 'StudentReportNew/InitialScreen.dart';
import 'ToGuardian.dart';
import 'ToolMarkEntry.dart';

class StaffHome extends StatefulWidget {
  const StaffHome({Key? key}) : super(key: key);

  @override
  State<StaffHome> createState() => _StaffHomeState();
}

class _StaffHomeState extends State<StaffHome> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Provider.of<IconClickNotifier>(context, listen: false).enableIcons();
      Provider.of<ConnectivityProvider>(context, listen: false);
      await Provider.of<StaffProfileProvider>(context, listen: false)
          .staff_profileData();
      await Provider.of<StaffNotificationCountProviders>(context, listen: false)
          .getnotificationCount();
      await Provider.of<ModuleProviders>(context, listen: false)
          .getModuleDetails();
      await Provider.of<NotificationToGuardian_Providers>(context,
              listen: false)
          .communicationToGuardianCourseStaff();
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
                    showReleaseNotes: true,
                    showIgnore: false,
                    dialogStyle: UpgradeDialogStyle.cupertino,
                    durationUntilAlertAgain: const Duration(days: 1)),
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
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
                                  ),
                                ),
                              ),
                            ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: StaffProfile(),
                    ), //  <--<---  StaffProfile....
                    const StaffFlashNews(),
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
                      child: AnimationLimiter(
                        child: ListView(
                          physics: const BouncingScrollPhysics(),
                          children: [
                            kheight20,
                            kheight10,
                            AnimationConfiguration.staggeredList(
                              position: 0,
                              delay: const Duration(milliseconds: 100),
                              child: SlideAnimation(
                                duration: const Duration(milliseconds: 2500),
                                curve: Curves.fastLinearToSlowEaseIn,
                                child: FadeInAnimation(
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  duration: const Duration(milliseconds: 2500),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                          await Navigator.push(
                                              context,
                                              PageTransition(
                                                type: PageTransitionType
                                                    .rightToLeft,
                                                child: const StaffProfileView(),
                                                duration: const Duration(
                                                    milliseconds: 300),
                                              ));
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
                                                    decoration:
                                                        const BoxDecoration(
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
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 11,
                                                    color: Colors.black),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Consumer<StaffNotificationCountProviders>(
                                        builder: (context, count, child) =>
                                            count.loading
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 5, right: 5),
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
                                                                  image:
                                                                      AssetImage(
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
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 11,
                                                              color:
                                                                  Colors.black),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                : badges.Badge(
                                                    showBadge: count.count == 0
                                                        ? false
                                                        : true,
                                                    badgeAnimation: const badges
                                                        .BadgeAnimation.rotation(
                                                      animationDuration:
                                                          Duration(seconds: 1),
                                                      colorChangeAnimationDuration:
                                                          Duration(seconds: 1),
                                                      loopAnimation: false,
                                                      curve:
                                                          Curves.fastOutSlowIn,
                                                      colorChangeAnimationCurve:
                                                          Curves.easeInCubic,
                                                    ),
                                                    position:
                                                        badges.BadgePosition
                                                            .topEnd(end: 9),
                                                    badgeContent: Text(
                                                      count.count == null
                                                          ? ''
                                                          : count.count
                                                              .toString(),
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    child: GestureDetector(
                                                      onTap: () async {
                                                        await Navigator.push(
                                                            context,
                                                            PageTransition(
                                                              type: PageTransitionType
                                                                  .rightToLeft,
                                                              child:
                                                                  const StaffNotificationScreen(),
                                                              duration:
                                                                  const Duration(
                                                                      milliseconds:
                                                                          300),
                                                            ));
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 5,
                                                                right: 5),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            Card(
                                                              elevation: 10,
                                                              color:
                                                                  Colors.white,
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
                                                                        .all(
                                                                        8.0),
                                                                child:
                                                                    Container(
                                                                  height: 38,
                                                                  width: 38,
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    image:
                                                                        DecorationImage(
                                                                      image:
                                                                          AssetImage(
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
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 11,
                                                                  color: Colors
                                                                      .black),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                      ),
                                      Consumer<ModuleProviders>(
                                          builder: (context, module, child) =>
                                              GestureDetector(
                                                onTap: () async {
                                                  module.timetable == true
                                                      ? await Navigator.push(
                                                          context,
                                                          PageTransition(
                                                            type:
                                                                PageTransitionType
                                                                    .rightToLeft,
                                                            child:
                                                                const Staff_Timetable(),
                                                            duration:
                                                                const Duration(
                                                                    milliseconds:
                                                                        300),
                                                          ))
                                                      : _noAcess();
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 5, right: 5),
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
                                                                    opacity:  module.timetable ==
                                                                  true? 20 :0.2,
                                                                image:
                                                                    AssetImage(
                                                                  'assets/Timetable.png',
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      kheight10,
                                                       Text(
                                                        'Timetable',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 11,
                                                            color:
                                                            module.timetable ==
                                                                true  ? Colors.black:
                                                            Colors.black26),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              )),
                                      Consumer<ModuleProviders>(
                                        builder: (context, module, child) =>
                                            GestureDetector(
                                          onTap: () async {
                                            module.timetable == true
                                                ? await Navigator.push(
                                                    context,
                                                    PageTransition(
                                                      type: PageTransitionType
                                                          .rightToLeft,
                                                      child:
                                                          const ExamTimetableStaff(),
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
                                                           BoxDecoration(
                                                        image: DecorationImage(
                                                          opacity:  module.timetable ==
                                                              true? 20 :0.2,
                                                          image: AssetImage(
                                                            'assets/diary.png',
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                kheight10,
                                                 Text(
                                                  'Exam\nTimetable',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 11,
                                                      color: module.timetable ==
                                                          true  ? Colors.black:
                                                      Colors.black26),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            kheight10,
                            AnimationConfiguration.staggeredList(
                              position: 1,
                              delay: const Duration(milliseconds: 300),
                              child: SlideAnimation(
                                duration: const Duration(milliseconds: 2500),
                                curve: Curves.fastLinearToSlowEaseIn,
                                child: FadeInAnimation(
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  duration: const Duration(milliseconds: 2500),
                                  child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Container(
                                      height: 280,
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 236, 237, 245),
                                          borderRadius:
                                              BorderRadius.circular(20)),
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
                                          Consumer<ModuleProviders>(
                                            builder: (context, module, child) =>
                                                Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                kWidth,
                                                Expanded(
                                                  child: GestureDetector(
                                                    onTap: () async {
                                                      module.attendenceEntry ==
                                                              true
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
                                                                    opacity:   module.attendenceEntry ==
                                                                          true? 20 :0.2,
                                                                  image: AssetImage(
                                                                      'assets/Attendance entry.png'),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        kheight10,
                                                         Text(
                                                          'Attendance',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 11,
                                                              color:
                                                              module.attendenceEntry ==
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
                                                      module.tabulation == true
                                                          ? await Navigator.push(
                                                              context,
                                                              PageTransition(
                                                                type: PageTransitionType
                                                                    .rightToLeft,
                                                                child:
                                                                    const MarkEntryNew(),
                                                                duration:
                                                                    const Duration(
                                                                        milliseconds:
                                                                            300),
                                                              ))
                                                          : _noAcess();
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
                                                                    'assets/Tabulation.png',
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        kheight10,
                                                         Text(
                                                          'MarkEntry',
                                                          textAlign:
                                                              TextAlign.center,
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
                                                      module.tabulation == true
                                                          ? await Navigator.push(
                                                              context,
                                                              PageTransition(
                                                                type: PageTransitionType
                                                                    .rightToLeft,
                                                                child:
                                                                    const ToolMarkEntry(),
                                                                duration:
                                                                    const Duration(
                                                                        milliseconds:
                                                                            300),
                                                              ))
                                                          : _noAcess();
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
                                                                    'assets/ToolMarkEntry.png',
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        kheight10,
                                                         Text(
                                                          'Tool Mark\nEntry',
                                                          textAlign:
                                                              TextAlign.center,
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
                                                kWidth,
                                              ],
                                            ),
                                          ),
                                          kheight10,
                                          Consumer<ModuleProviders>(
                                            builder: (context, module, child) =>
                                                Row(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    kWidth,
                                                    Expanded(
                                                      child: GestureDetector(
                                                        onTap: () async {
                                                          module.tabulation == true
                                                              ? await Navigator.push(
                                                              context,
                                                              PageTransition(
                                                                type: PageTransitionType
                                                                    .rightToLeft,
                                                                child:
                                                                const RemarksEntry(),
                                                                duration:
                                                                const Duration(
                                                                    milliseconds:
                                                                    300),
                                                              ))
                                                              : _noAcess();
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
                                                                        'assets/Remarks.png',
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            kheight10,
                                                            Text(
                                                              'Remarks Entry',
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
                                                              : _noAcess();
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
                                                    kWidth,
                                                  ],
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            kheight10,
                            AnimationConfiguration.staggeredList(
                              position: 4,
                              delay: const Duration(milliseconds: 100),
                              child: SlideAnimation(
                                duration: const Duration(milliseconds: 2500),
                                curve: Curves.fastLinearToSlowEaseIn,
                                child: FadeInAnimation(
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  duration: const Duration(milliseconds: 2500),
                                  child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Container(
                                      height: 170,
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 236, 237, 245),
                                          borderRadius:
                                              BorderRadius.circular(20)),
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
                                              " * Reports * ",
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
                                          Consumer<ModuleProviders>(
                                            builder: (context, module, child) =>
                                                Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                kWidth,
                                                Expanded(
                                                  child: GestureDetector(
                                                    onTap: () async {
                                                      var parsedResponse =
                                                          await parseJWT();

                                                      if (parsedResponse[
                                                              'role'] ==
                                                          "NonTeachingStaff") {
                                                        await Navigator.push(
                                                            context,
                                                            PageTransition(
                                                              type: PageTransitionType
                                                                  .rightToLeft,
                                                              child:
                                                                  const StudReport(),
                                                              duration:
                                                                  const Duration(
                                                                      milliseconds:
                                                                          300),
                                                            ));
                                                      } else {
                                                        await Navigator.push(
                                                            context,
                                                            PageTransition(
                                                              type: PageTransitionType
                                                                  .rightToLeft,
                                                              child:
                                                                  const StudReportStaff(),
                                                              duration:
                                                                  const Duration(
                                                                      milliseconds:
                                                                          300),
                                                            ));
                                                      }
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 5,
                                                              right: 5),
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
                                                                    image:
                                                                        AssetImage(
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
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 11,
                                                                color: Colors
                                                                    .black),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: GestureDetector(
                                                    onTap: () async {
                                                      module.attendenceEntry ==
                                                              true
                                                          ? await Navigator.push(
                                                              context,
                                                              PageTransition(
                                                                type: PageTransitionType
                                                                    .rightToLeft,
                                                                child:
                                                                    const AbsenteesReportStaff(),
                                                                duration:
                                                                    const Duration(
                                                                        milliseconds:
                                                                            300),
                                                              ))
                                                          : _noAcess();
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 5,
                                                              right: 5),
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
                                                                        module.attendenceEntry ==
                                                                            true? 20 :0.2,
                                                                    image:
                                                                        AssetImage(
                                                                      'assets/attendance report.png',
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          kheight10,
                                                           Text(
                                                            'Absentees\nReport',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 11,
                                                                color:  module.attendenceEntry ==
                                                                    true  ? Colors.black:
                                                                Colors.black26),
                                                          )
                                                        ],
                                                      ),
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
                                                                type: PageTransitionType
                                                                    .rightToLeft,
                                                                child:
                                                                    const MissingReport(),
                                                                duration:
                                                                    const Duration(
                                                                        milliseconds:
                                                                            300),
                                                              ))
                                                          : _noAcess();
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 5,
                                                              right: 5),
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
                                                                    opacity:     module.tabulation ==
                                                                            true? 20 :0.2,
                                                                    image:
                                                                        AssetImage(
                                                                      'assets/missing report.png',
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          kheight10,
                                                           Text(
                                                            'MarkEntry\nMissing Report ',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 11,
                                                                color: module.tabulation ==
                                                                    true  ? Colors.black:
                                                                Colors.black26),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(context,
                                                          MaterialPageRoute(builder: (context)=>const FeedbackList3()));
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
                                                          'Guardian\nFeedback',
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

                                                // Expanded(
                                                //   child: GestureDetector(
                                                //     onTap: () async {
                                                //       await Navigator.push(
                                                //           context,
                                                //           PageTransition(
                                                //             type:
                                                //                 PageTransitionType
                                                //                     .rightToLeft,
                                                //             child:
                                                //                 const AnecdotalInitialScreen(),
                                                //             duration:
                                                //                 const Duration(
                                                //                     milliseconds:
                                                //                         300),
                                                //           ));
                                                //     },
                                                //     child: Column(
                                                //       mainAxisAlignment:
                                                //           MainAxisAlignment
                                                //               .spaceEvenly,
                                                //       children: [
                                                //         Card(
                                                //           elevation: 10,
                                                //           color: Colors.white,
                                                //           shape:
                                                //               RoundedRectangleBorder(
                                                //             borderRadius:
                                                //                 BorderRadius
                                                //                     .circular(
                                                //                         12.0),
                                                //           ),
                                                //           child: Padding(
                                                //             padding:
                                                //                 const EdgeInsets
                                                //                     .all(8.0),
                                                //             child: Container(
                                                //               height: 38,
                                                //               width: 38,
                                                //               decoration:
                                                //                   const BoxDecoration(
                                                //                 image:
                                                //                     DecorationImage(
                                                //                   opacity: 20,
                                                //                   image:
                                                //                       AssetImage(
                                                //                     'assets/Loginwebb.png',
                                                //                   ),
                                                //                 ),
                                                //               ),
                                                //             ),
                                                //           ),
                                                //         ),
                                                //         kheight10,
                                                //         const Text(
                                                //           'Anecdotal',
                                                //           textAlign:
                                                //               TextAlign.center,
                                                //           style: TextStyle(
                                                //               fontWeight:
                                                //                   FontWeight
                                                //                       .bold,
                                                //               fontSize: 11,
                                                //               color: Colors
                                                //                   .black87),
                                                //         )
                                                //       ],
                                                //     ),
                                                //   ),
                                                // ),
                                                kWidth
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            kheight10,
                            AnimationConfiguration.staggeredList(
                              position: 2,
                              delay: const Duration(milliseconds: 100),
                              child: SlideAnimation(
                                duration: const Duration(milliseconds: 2500),
                                curve: Curves.fastLinearToSlowEaseIn,
                                child: FadeInAnimation(
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  duration: const Duration(milliseconds: 2500),
                                  child: Row(children: <Widget>[
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
                                ),
                              ),
                            ),
                            kheight10,
                            Consumer<ModuleProviders>(
                              builder: (context, module, child) =>
                                  AnimationConfiguration.staggeredList(
                                position: 3,
                                delay: const Duration(milliseconds: 100),
                                child: SlideAnimation(
                                  duration: const Duration(milliseconds: 2500),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  child: FadeInAnimation(
                                    curve: Curves.fastLinearToSlowEaseIn,
                                    duration:
                                        const Duration(milliseconds: 2500),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () async {
                                              module.curiculam == true
                                                  ? await Navigator.push(
                                                      context,
                                                      PageTransition(
                                                        type: PageTransitionType
                                                            .rightToLeft,
                                                        child:
                                                        Notification_StaffToGuardain(),
                                                        duration:
                                                            const Duration(
                                                                milliseconds:
                                                                    300),
                                                      ))
                                                  : _noAcess();
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5, right: 5),
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
                                                             BoxDecoration(
                                                          image:
                                                              DecorationImage(
                                                                opacity:  module.curiculam ==
                                                                    true? 20 :0.2,
                                                            image: AssetImage(
                                                              'assets/01communicationto guardian.png',
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  kheight10,
                                                   Text(
                                                    'To Guardian',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 11,
                                                        color:  module.curiculam ==
                                                            true  ? Colors.black:
                                                        Colors.black26),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5, right: 5),
                                            child: GestureDetector(
                                              onTap: () async {
                                                await Navigator.push(
                                                    context,
                                                    PageTransition(
                                                      type: PageTransitionType
                                                          .rightToLeft,
                                                      child: const StaffNoticeBoard(),
                                                      duration: const Duration(
                                                          milliseconds: 300),
                                                    ));
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
                                                            BoxDecoration(
                                                          image:
                                                              const DecorationImage(
                                                            opacity: 20,
                                                            image: AssetImage(
                                                              'assets/Noticeboard.png',
                                                            ),
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  kheight10,
                                                  const Text(
                                                    'Notice Board',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 11,
                                                        color: Colors.black),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () async {
                                              module.curiculam == true
                                                  ? await Navigator.push(
                                                  context,
                                                  PageTransition(
                                                    type: PageTransitionType
                                                        .rightToLeft,
                                                    child:
                                                    AnecdotalInitialScreen(),
                                                    duration:
                                                    const Duration(
                                                        milliseconds:
                                                        300),
                                                  ))
                                                  : _noAcess();
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5, right: 5),
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
                                                         BoxDecoration(
                                                          image:
                                                          DecorationImage(
                                                            opacity:  module.curiculam ==
                                                                true? 20 :0.2,
                                                            image: AssetImage(
                                                              'assets/anecdotal.png',
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  kheight10,
                                                   Text(
                                                    'Anecdotal',
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight.w600,
                                                        fontSize: 11,
                                                        color:  module.curiculam ==
                                                            true  ? Colors.black:
                                                        Colors.black26),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () async {
                                              await Navigator.push(
                                                  context,
                                                  PageTransition(
                                                    type: PageTransitionType
                                                        .rightToLeft,
                                                    child: const StaffGallery(),
                                                    duration: const Duration(
                                                        milliseconds: 300),
                                                  ));
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5, right: 5),
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
                                                             BoxDecoration(
                                                          image:
                                                              DecorationImage(
                                                                opacity:  module.curiculam ==
                                                                    true? 20 :0.2,
                                                            image: AssetImage(
                                                              'assets/Gallery.png',
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  kheight10,
                                                   Text(
                                                    'Gallery',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 11,
                                                        color:  module.curiculam ==
                                                            true  ? Colors.black:
                                                        Colors.black26),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            kheight10,
                            Consumer<ModuleProviders>(
                              builder: (context, module, child) => Row(
                                children: [
                                  // Consumer<Curriculamprovider>(
                                  //   builder: (context, curri, child) =>
                                  //       Expanded(
                                  //     child: GestureDetector(
                                  //       onTap: () async {
                                  //         if (module.curiculam == true) {
                                  //           await Provider.of<
                                  //                       Curriculamprovider>(
                                  //                   context,
                                  //                   listen: false)
                                  //               .getCuriculamtoken();
                                  //           String token =
                                  //               curri.token.toString();
                                  //
                                  //           await Navigator.push(
                                  //             context,
                                  //             PageTransition(
                                  //               type: PageTransitionType
                                  //                   .rightToLeft,
                                  //               child: CurriculamPage(
                                  //                 token: token,
                                  //               ),
                                  //               duration: const Duration(
                                  //                   milliseconds: 300),
                                  //             ),
                                  //           );
                                  //         } else {
                                  //           _noAcess();
                                  //         }
                                  //       },
                                  //       child: Padding(
                                  //         padding: const EdgeInsets.only(
                                  //             left: 5, right: 5),
                                  //         child: Column(
                                  //           mainAxisAlignment:
                                  //               MainAxisAlignment.spaceEvenly,
                                  //           children: [
                                  //             Card(
                                  //               elevation: 10,
                                  //               color: Colors.white,
                                  //               shape: RoundedRectangleBorder(
                                  //                 borderRadius:
                                  //                     BorderRadius.circular(
                                  //                         12.0),
                                  //               ),
                                  //               child: Padding(
                                  //                 padding:
                                  //                     const EdgeInsets.all(8.0),
                                  //                 child: Container(
                                  //                   height: 38,
                                  //                   width: 38,
                                  //                   decoration: BoxDecoration(
                                  //                     image:
                                  //                          DecorationImage(
                                  //                           opacity:  module.curiculam ==
                                  //                               true? 20 :0.2,
                                  //                       image: AssetImage(
                                  //                         'assets/Curriculum.png',
                                  //                       ),
                                  //                     ),
                                  //                     borderRadius:
                                  //                         BorderRadius.circular(
                                  //                             10),
                                  //                   ),
                                  //                 ),
                                  //               ),
                                  //             ),
                                  //             kheight10,
                                  //              Text(
                                  //               'e-Class room',
                                  //               style: TextStyle(
                                  //                   fontWeight: FontWeight.w600,
                                  //                   fontSize: 11,
                                  //                   color:  module.curiculam ==
                                  //                       true  ? Colors.black:
                                  //                   Colors.black26),
                                  //             )
                                  //           ],
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),    // e-classsroom old
                                  Consumer<IconClickNotifier>(
                                    builder: (context, iconClickNotifier, child) =>
                                        Consumer<Curriculamprovider>(
                                          builder: (context, curri, child) =>
                                              Expanded(
                                                  child:
                                                  GestureDetector(
                                                        onTap: iconClickNotifier.areIconsClickable
                                                            ? () async {
                                                          // Disable all icons
                                                          iconClickNotifier.disableIcons();

                                                          // Navigate to a new page
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
                                                                  child:
                                                                  //  const SubjectPage(),
                                                                  CurriculamPage(
                                                                    token: token,
                                                                  ),
                                                                  duration:
                                                                  const Duration(
                                                                      milliseconds:
                                                                      300),
                                                                )).then((_) {
                                                              // Re-enable icons when returning
                                                              iconClickNotifier.enableIcons();
                                                            });
                                                          } else {
                                                            _noAcess();
                                                          }

                                                        }
                                                            : null,
                                                        child: Padding(
                                                          padding:
                                                          const EdgeInsets.only(
                                                              left: 10, right: 10),
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
                                                                          'assets/Curriculum.png',
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              kheight10,
                                                              const Text(
                                                                'e-Classroom',
                                                                // 'Bus Tracking',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                    FontWeight.w600,
                                                                    fontSize: 11,
                                                                    color:
                                                                    Colors.black),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                              ),
                                        ),
                                  ),

                                  Consumer<Curriculamprovider>(
                                    builder: (context, curri, child) =>
                                        Expanded(
                                          child: GestureDetector(
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
                                                _noAcess();
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
                                                           DecorationImage(
                                                            opacity:  module.curiculam ==
                                                                true? 20 :0.2,
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
                                                   Text(
                                                    'Portion',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 11,
                                                        color: module.curiculam ==
                                                            true  ? Colors.black:
                                                        Colors.black26),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                  ),

                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () async {
                                        module.curiculam == true
                                            ? await Navigator.push(
                                                context,
                                                PageTransition(
                                                  type: PageTransitionType
                                                      .rightToLeft,
                                                  child:
                                                      const BirthdayInitialScreen(),
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
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  height: 38,
                                                  width: 38,
                                                  decoration:
                                                      const BoxDecoration(
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
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 11,
                                                  color: Colors.black),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () async {
                                        SharedPreferences pref =
                                            await SharedPreferences
                                                .getInstance();
                                        String schdomain = pref
                                            .getString("subDomain")
                                            .toString();
                                        print(schdomain);
                                        await Navigator.push(
                                            context,
                                            PageTransition(
                                              type: PageTransitionType
                                                  .rightToLeft,
                                              child: LoginScreenWeb(
                                                schdomain: schdomain,
                                              ),
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
                                              padding:
                                                  const EdgeInsets.all(8.0),
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
                            //kheight20,
                            Container(
                                margin: const EdgeInsets.only(
                                    left: 10.0, right: 10.0),
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
                                            borderRadius:
                                                BorderRadius.circular(30.0)),
                                        onPressed: () async {
                                          await Navigator.push(
                                              context,
                                              PageTransition(
                                                type:
                                                    PageTransitionType.rightToLeft,
                                                child: PasswordChange(),
                                                duration: const Duration(
                                                    milliseconds: 300),
                                              ));
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
                                            borderRadius:
                                                BorderRadius.circular(30.0)),
                                        onPressed: () async {
                                          showCupertinoDialog(
                                            context: context,
                                            builder: (context) {
                                              return Container(
                                                color:
                                                    Colors.black.withOpacity(0.5),
                                                child: CupertinoAlertDialog(
                                                  title: const Text("Logout"),
                                                  content: const Text(
                                                      "Are you sure you want to log out?"),
                                                  actions: <Widget>[
                                                    CupertinoDialogAction(
                                                      child: const Text(
                                                        "Cancel",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: UIGuide
                                                                .light_Purple),
                                                      ),
                                                      onPressed: () {
                                                        Navigator.of(context).pop();
                                                      },
                                                    ),
                                                    CupertinoDialogAction(
                                                      child: const Text("Logout",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight.w500,
                                                              color: UIGuide
                                                                  .light_Purple)),
                                                      onPressed: () async {
                                                        SharedPreferences prefs =
                                                            await SharedPreferences
                                                                .getInstance();
                                                        print(
                                                            "accesstoken  $prefs");
                                                        await prefs
                                                            .remove("accesstoken");
                                                        print("username  $prefs");
                                                        await prefs
                                                            .remove("username");
                                                        print("password  $prefs");
                                                        await prefs
                                                            .remove("password");

                                                        Navigator.of(context)
                                                            .pushAndRemoveUntil(
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            const LoginPage()),
                                                                (Route<dynamic>
                                                                        route) =>
                                                                    false);
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          );

                                          // AwesomeDialog(
                                          //   context: context,
                                          //   dialogType: DialogType.info,
                                          //   borderSide: const BorderSide(
                                          //       color: UIGuide.light_Purple,
                                          //       width: 2),
                                          //   buttonsBorderRadius:
                                          //       const BorderRadius.all(
                                          //           Radius.circular(2)),
                                          //   headerAnimationLoop: false,
                                          //   animType: AnimType.bottomSlide,
                                          //   title: 'SignOut',
                                          //   desc: 'Are you sure want to sign out',
                                          //   showCloseIcon: true,
                                          //   btnOkColor: UIGuide.button1,
                                          //   btnCancelColor: UIGuide.button2,
                                          //   btnCancelOnPress: () {
                                          //     return;
                                          //   },
                                          //   btnOkOnPress: () async {
                                          //     SharedPreferences prefs =
                                          //         await SharedPreferences
                                          //             .getInstance();
                                          //     print("accesstoken  $prefs");
                                          //     await prefs.remove("accesstoken");
                                          //     print("username  $prefs");
                                          //     await prefs.remove("username");
                                          //     print("password  $prefs");
                                          //     await prefs.remove("password");

                                          //     Navigator.of(context)
                                          //         .pushAndRemoveUntil(
                                          //             MaterialPageRoute(
                                          //                 builder: (context) =>
                                          //                     LoginPage()),
                                          //             (Route<dynamic> route) =>
                                          //                 false);
                                          //   },
                                          // ).show();
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
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  _noAcess() {
    var size = MediaQuery
        .of(context)
        .size;
    return

      QuickAlert.show(
        context: context,
        type: QuickAlertType.warning,
        text: "Sorry, you don't have access to this module",
        autoCloseDuration: const Duration(seconds: 2),
        showConfirmBtn: false,

      );
  }
}

class StaffProfile extends StatelessWidget {
  const StaffProfile({Key? key}) : super(key: key);

  // late AnimationController _controller;
  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   var p = Provider.of<StaffProfileProvider>(context, listen: false);
    //   p.staff_profileData();
    // });
    var size = MediaQuery.of(context).size;

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
  const StaffFlashNews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var p = Provider.of<FlashnewsProvider>(context, listen: false);
      p.flashNewsProvider();
    });

    return Consumer<FlashnewsProvider>(
      builder: (context, value, child) {
        if (value.flashnews == null || value.flashnews == '') {
          return Container(
            height: 0,
          );
        } else {
          return LimitedBox(
            maxHeight: 30,
            child: value.loading || value.flashnews!.isEmpty
                ? const SizedBox(
                    height: 0,
                    width: 0,
                  )
                : LimitedBox(
                    maxHeight: 30,
                    child:
                    InfiniteMarquee(
                      itemBuilder: (BuildContext context, int index) {
                        return Text(value.flashnews == null || value.flashnews == ''
                            ? '-----'
                            : "${value.flashnews.toString()}  *  ",style: TextStyle(fontSize: 12),);
                      },
                    ),
                    // Marquee(
                    //   text: value.flashnews == null || value.flashnews == ''
                    //       ? '-----'
                    //       : value.flashnews.toString(),
                    //   style: const TextStyle(
                    //       fontWeight: FontWeight.bold,
                    //       color: Colors.grey,
                    //       fontSize: 14),
                    //   scrollAxis: Axis.horizontal,
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   blankSpace: 60.0,
                    //   velocity: 40.0,
                    //   pauseAfterRound: const Duration(seconds: 1),
                    //   showFadingOnlyWhenScrolling: true,
                    //   fadingEdgeStartFraction: 0.3,
                    //   fadingEdgeEndFraction: 0.3,
                    //   numberOfRounds: null,
                    //   startPadding: 10.0,
                    //   accelerationDuration: const Duration(seconds: 1),
                    //   accelerationCurve: Curves.linear,
                    //   decelerationDuration: const Duration(milliseconds: 500),
                    //   decelerationCurve: Curves.easeOut,
                    // ),
                  ),
          );
        }
      },
    );
  }
}
