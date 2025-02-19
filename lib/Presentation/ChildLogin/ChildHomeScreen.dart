import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:essconnect/Application/StudentProviders/CurriculamProviders.dart';
import 'package:essconnect/Application/StudentProviders/InternetConnection.dart';
import 'package:essconnect/Application/StudentProviders/NotificationCountProviders.dart';
import 'package:essconnect/Constants.dart';
import 'package:essconnect/Presentation/Student/Attendence.dart';
import 'package:essconnect/Presentation/Student/CurriculamScreen.dart';
import 'package:essconnect/Presentation/Student/Gallery.dart';
import 'package:essconnect/Presentation/Student/MarkSheet.dart';

import 'package:essconnect/Presentation/Student/NoInternetScreen.dart';
import 'package:essconnect/Presentation/Student/NoticeBoard.dart';
import 'package:essconnect/Presentation/Student/PasswordChange.dart';
import 'package:essconnect/Presentation/Student/Stud_Notification.dart';
import 'package:essconnect/Presentation/Student/TimeTable.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:essconnect/utils/spinkit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:marquee/marquee.dart';
import 'package:badges/badges.dart' as badges;
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upgrader/upgrader.dart';
import '../../Application/Module Providers.dart/Module.dart';
import '../../Application/StudentProviders/ProfileProvider.dart';
import '../../Application/StudentProviders/TimetableProvider.dart';
import '../Login_Activation/Login_page.dart';
import '../Student/PortionView.dart';
import '../Student/Reportcard.dart';

class ChildHome extends StatefulWidget {
  ChildHome({Key? key}) : super(key: key);

  @override
  State<ChildHome> createState() => _ChildHomeState();
}

class _ChildHomeState extends State<ChildHome> {
  var size, height, width, kheight, kheight20;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Provider.of<ConnectivityProvider>(context, listen: false);
      await Provider.of<StudNotificationCountProviders>(context, listen: false)
          .getnotificationCount();

      await Provider.of<ModuleProviders>(context, listen: false)
          .getModuleDetails();
    });
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    kheight = const SizedBox(
      height: 10,
    );
    kheight20 = const SizedBox(
      height: 20,
    );
    return Scaffold(
      body: Consumer<ConnectivityProvider>(
        builder: (context, connection, child) => connection.isOnline == false
            ? const NoInternetConnection()
            : UpgradeAlert(
          upgrader: Upgrader(
              dialogStyle: UpgradeDialogStyle.cupertino,
              durationUntilAlertAgain: Duration(days: 1)),
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              ProfileHome(kheight20: kheight20, kheight: kheight),
              const Flashnews(),
              Container(
                width: width,
                height: size.height - 180,
                decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(blurRadius: 5, offset: Offset(1, 3))
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15))),
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    kheight20,
                    Row(children: <Widget>[
                      const Text(
                        "──   ",
                        style: TextStyle(color: Colors.black26),
                      ),
                      const Text(
                        "Academics",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          //fontStyle: FontStyle.italic,
                            color: UIGuide.light_Purple,
                            fontWeight: FontWeight.w900),
                      ),
                      Expanded(
                        child: Container(
                            margin: const EdgeInsets.only(
                                left: 16.0, right: 10.0),
                            child: const Divider(
                              color: Colors.black45,
                              height: 36,
                            )),
                      ),
                    ]),
                    kheight,
                    Consumer<ModuleProviders>(
                      builder: (context, module, child) => Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          module.offlineAttendence == true
                              ? GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                    const Attendence()),
                              );
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
                                      const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: 38,
                                        width: 38,
                                        decoration:
                                        const BoxDecoration(
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
                                  kheight,
                                  const Text(
                                    'Attendance',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 11,
                                        color: Colors.black),
                                  )
                                ],
                              ),
                            ),
                          )
                              : GestureDetector(
                            onTap: () {
                              _noAcess();
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => const Attendence()),
                              // );
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
                                      const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: 38,
                                        width: 38,
                                        decoration:
                                        const BoxDecoration(
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
                                  kheight,
                                  const Text(
                                    'Attendance',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 11,
                                        color: Colors.black),
                                  )
                                ],
                              ),
                            ),
                          ),
                          module.timetable == true
                              ? Consumer<ProfileProvider>(
                            builder: (context, value, child) {
                              return GestureDetector(
                                onTap: () async {
                                  var divId = value.divisionId ==
                                      null
                                      ? 'divId is null'
                                      : value.divisionId.toString();
                                  print(divId);
                                  await Provider.of<
                                      Timetableprovider>(
                                      context,
                                      listen: false)
                                      .getTimeTable(divId);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                        const Timetable()),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
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
                                              image:
                                              DecorationImage(
                                                opacity: 20,
                                                image: AssetImage(
                                                  'assets/Timetable.png',
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      kheight,
                                      const Text(
                                        'Timetable',
                                        style: TextStyle(
                                            fontWeight:
                                            FontWeight.w400,
                                            fontSize: 11,
                                            color: Colors.black),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          )
                              : GestureDetector(
                            onTap: () async {
                              _noAcess();
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
                                      const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: 38,
                                        width: 38,
                                        decoration:
                                        const BoxDecoration(
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
                                  kheight,
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
                          module.offlineTab == true
                              ? Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                      const ReportCard()),
                                );
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
                                      const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: 38,
                                        width: 38,
                                        decoration: BoxDecoration(
                                          image:
                                          const DecorationImage(
                                            opacity: 20,
                                            image: AssetImage(
                                              'assets/Reportcard.png',
                                            ),
                                          ),
                                          borderRadius:
                                          BorderRadius.circular(
                                              10),
                                        ),
                                      ),
                                    ),
                                  ),
                                  kheight,
                                  const Text(
                                    'Report Card',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 11,
                                        color: Colors.black),
                                  )
                                ],
                              ),
                            ),
                          )
                              : Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10),
                            child: GestureDetector(
                              onTap: () {
                                _noAcess();
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
                                      const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: 38,
                                        width: 38,
                                        decoration: BoxDecoration(
                                          image:
                                          const DecorationImage(
                                            opacity: 20,
                                            image: AssetImage(
                                              'assets/Reportcard.png',
                                            ),
                                          ),
                                          borderRadius:
                                          BorderRadius.circular(
                                              10),
                                        ),
                                      ),
                                    ),
                                  ),
                                  kheight,
                                  const Text(
                                    'Report Card',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 11,
                                        color: Colors.black),
                                  )
                                ],
                              ),
                            ),
                          ),
                          module.offlineTab == true
                              ? Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                      const MarkSheetView ()),
                                );
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
                                      const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: 38,
                                        width: 38,
                                        decoration: BoxDecoration(
                                          image:
                                          const DecorationImage(
                                            opacity: 20,
                                            image: AssetImage(
                                              'assets/Marksheet.png',
                                            ),
                                          ),
                                          borderRadius:
                                          BorderRadius.circular(
                                              10),
                                        ),
                                      ),
                                    ),
                                  ),
                                  kheight,
                                  const Text(
                                    'Mark Sheet',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 11,
                                        color: Colors.black),
                                  )
                                ],
                              ),
                            ),
                          )
                              : Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10),
                            child: GestureDetector(
                              onTap: () {
                                _noAcess();
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
                                      const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: 38,
                                        width: 38,
                                        decoration: BoxDecoration(
                                          image:
                                          const DecorationImage(
                                            opacity: 20,
                                            image: AssetImage(
                                              'assets/Marksheet.png',
                                            ),
                                          ),
                                          borderRadius:
                                          BorderRadius.circular(
                                              10),
                                        ),
                                      ),
                                    ),
                                  ),
                                  kheight,
                                  const Text(
                                    'Mark Sheet',
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
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        height: 210,
                        width: width,
                        decoration: BoxDecoration(
                            color:
                            const Color.fromARGB(255, 236, 237, 245),
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            kheight,
                            kheight,
                            Consumer<ModuleProviders>(
                              builder: (context, module, child) => Row(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                            const NoticeBoard()),
                                      );
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
                                                    opacity: 20,
                                                    image: AssetImage(
                                                      'assets/Noticeboard.png',
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          kheight,
                                          const Text(
                                            'Notice Board',
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
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Gallery()),
                                        );
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
                                                decoration: BoxDecoration(
                                                  image:
                                                  const DecorationImage(
                                                    opacity: 20,
                                                    image: AssetImage(
                                                      'assets/Gallery.png',
                                                    ),
                                                  ),
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(10),
                                                ),
                                              ),
                                            ),
                                          ),
                                          kheight,
                                          const Text(
                                            'Gallery',
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
                                  Consumer<
                                      StudNotificationCountProviders>(
                                    builder: (context, count, child) =>
                                        badges.Badge(
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
                                          badges.BadgePosition.topEnd(
                                              end: 9),
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
                                              //             StudNotificationCountProviders>(
                                              //         context,
                                              //         listen: false)
                                              //     .seeNotification();
                                              await Provider.of<
                                                  StudNotificationCountProviders>(
                                                  context,
                                                  listen: false)
                                                  .getnotificationCount();
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Stud_Notification()),
                                              );
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
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
                                                          .circular(12.0),
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
                                                          const DecorationImage(
                                                            opacity: 20,
                                                            image: AssetImage(
                                                              'assets/notificationnew.png',
                                                            ),
                                                          ),
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              10),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  kheight,
                                                  const Text(
                                                    'Notification',
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
                            ),
                            kheight5,

                            Consumer<ModuleProviders>(
                              builder: (context, module, child) => Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [

                                Consumer<Curriculamprovider>(
                                  builder: (context, curri, child) =>
                                      Consumer<StudNotificationCountProviders>(
                                        builder: (context, count, child) =>
                                            badges.Badge(
                                              showBadge: count.portionCount == 0||count.portionCount==null
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
                                                count.portionCount == null||count.portionCount==0
                                                    ? ''
                                                    :count.portionCount
                                                    .toString(),
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 10,
                                                    fontWeight:
                                                    FontWeight.bold),
                                              ),
                                              child: GestureDetector(
                                                onTap: () async {
                                                  if (module.curiculam == true) {
                                                    await Provider.of<
                                                        Curriculamprovider>(
                                                        context,
                                                        listen: false)
                                                        .getCuriculamtoken();
                                                    String token = await curri.token
                                                        .toString();

                                                    await Navigator.push(
                                                        context,
                                                        PageTransition(
                                                          type: PageTransitionType
                                                              .rightToLeft,
                                                          child: PortionView(),
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
                                                                  'assets/PortionEntryReport.png',
                                                                ),
                                                              ),
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      kheight,
                                                      const Text(
                                                        'Portion',
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
                                      ),
                                ),

                                module.curiculam == true
                                    ? Consumer<Curriculamprovider>(
                                  builder: (context, curri, child) =>
                                      GestureDetector(
                                        onTap: () async {
                                          await Provider.of<
                                              Curriculamprovider>(
                                              context,
                                              listen: false)
                                              .getCuriculamtoken();
                                          String token =
                                          await curri.token.toString();
                                          await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CurriculamPage(
                                                      token: token,
                                                    )),
                                          );
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
                                                    decoration: BoxDecoration(
                                                      image:
                                                      const DecorationImage(
                                                        opacity: 20,
                                                        image: AssetImage(
                                                          'assets/Curriculum.png',
                                                        ),
                                                      ),
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(10),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              kheight,
                                              const Text(
                                                'e-Classroom',
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
                                )
                                    : GestureDetector(
                                  onTap: () async {
                                    _noAcess();
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
                                            const EdgeInsets.all(8.0),
                                            child: Container(
                                              height: 38,
                                              width: 38,
                                              decoration: BoxDecoration(
                                                image:
                                                const DecorationImage(
                                                  opacity: 20,
                                                  image: AssetImage(
                                                    'assets/Curriculum.png',
                                                  ),
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(
                                                    10),
                                              ),
                                            ),
                                          ),
                                        ),
                                        kheight,
                                        const Text(
                                          'e-Classroom',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 11,
                                              color: Colors.black),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],),
                            )
                          ],
                        ),
                      ),
                    ),
                    kheight,
                    Row(children: <Widget>[
                      // Expanded(
                      //   child: Container(
                      //       margin: const EdgeInsets.only(
                      //           left: 10.0, right: 20.0),
                      //       child: const Divider(
                      //         color: Colors.black45,
                      //         height: 36,
                      //       )),
                      // ),
                      const Text(
                        "──   ",
                        style: TextStyle(color: Colors.black26),
                      ),
                      const Text(
                        "Change Password | Sign Out",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          //fontStyle: FontStyle.italic,
                            color: UIGuide.light_Purple,
                            fontWeight: FontWeight.w900),
                      ),
                      Expanded(
                        child: Container(
                            margin: const EdgeInsets.only(
                                left: 16.0, right: 10.0),
                            child: const Divider(
                              color: Colors.black45,
                              height: 36,
                            )),
                      ),
                    ]),
                    kheight,
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
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PasswordChange()),
                              );
                            },
                            child: const Icon(
                              Icons.key_sharp,
                              color: UIGuide.light_Purple,
                            )),
                        MaterialButton(
                            elevation: 10,
                            minWidth: 50,
                            color: UIGuide.THEME_LIGHT,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(30.0)),
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
                                                fontWeight:
                                                FontWeight.w500,
                                                color:
                                                UIGuide.light_Purple),
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
                                            print("accesstoken  $prefs");
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
                                                    builder: (context) =>
                                                        LoginPage()),
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
                            },
                            child: const Icon(
                              Icons.logout_outlined,
                              color: UIGuide.light_Purple,
                            )),
                      ],
                    ),
                    kheight20,
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

class ProfileHome extends StatelessWidget {
  ProfileHome({
    Key? key,
    required this.kheight20,
    required this.kheight,
  }) : super(key: key);

  var kheight20;
  var kheight;
  String? studName;
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Provider.of<ProfileProvider>(context, listen: false).profileData();
    });

    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: Stack(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 2,
              ),
              Consumer<ProfileProvider>(
                builder: (_, value, child) {
                  studName = value.studName;
                  return Container(
                    child: Padding(
                      padding:
                      const EdgeInsets.only(left: 20.0, right: 20, top: 5),
                      child: Container(
                        height: 120,
                        decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 0.5,
                              )
                            ],
                            gradient: LinearGradient(
                              colors: [
                                UIGuide.light_Purple,
                                UIGuide.custom_blue,
                              ],
                            ),
                            // LinearGradient(colors: [
                            //   UIGuide.light_Purple,
                            //   UIGuide.custom_blue
                            // ]),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            )),
                        child: value.loading
                            ? spinkitLoader()
                            : Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              width: 5,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  image: DecorationImage(
                                    // opacity: 20,
                                    image: NetworkImage(
                                      value.studPhoto == null
                                          ? 'https://gj-eschool-files-public.s3.ap-south-1.amazonaws.com/ess-connect/student/avathar-02.jpeg'
                                          : value.studPhoto.toString(),
                                    ),
                                  ),
                                  shape: BoxShape.circle,
                                  boxShadow: const [
                                    BoxShadow(blurRadius: 1)
                                  ]),
                              width: 70,
                              height: 120,
                            ),
                            const SizedBox(
                              width: 10,
                              height: 30,
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  kheight20,
                                  Row(
                                    children: [
                                      const Text(
                                        'Name : ',
                                        style: TextStyle(
                                            color: Colors.white54,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      SizedBox(
                                        width: size.width / 2.5,
                                        child: Text(
                                          value.studName ?? "--",
                                          maxLines: 1,
                                          overflow: TextOverflow.fade,
                                          softWrap: false,
                                          style: const TextStyle(
                                              color: Colors.white70,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12.0),
                                        ),
                                      ),
                                    ],
                                  ),
                                  kheight,
                                  Row(
                                    children: [
                                      const Text(
                                        'Adm no : ',
                                        style: TextStyle(
                                            color: Colors.white54,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                        value.admissionNo == null
                                            ? '--'
                                            : value.admissionNo
                                            .toString(),
                                        style: const TextStyle(
                                            color: Colors.white70,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700),
                                      )
                                    ],
                                  ),
                                  kheight,
                                  Row(
                                    children: [
                                      const Text(
                                        'Class : ',
                                        style: TextStyle(
                                            color: Colors.white54,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                        value.division == null
                                            ? '--'
                                            : value.division.toString(),
                                        style: const TextStyle(
                                            color: Colors.white70,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Flashnews extends StatefulWidget {
  const Flashnews({Key? key}) : super(key: key);

  @override
  State<Flashnews> createState() => _FlashnewsState();
}

class _FlashnewsState extends State<Flashnews> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var p = Provider.of<ProfileProvider>(context, listen: false);
      p.flashNewsProvider();
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Consumer<ProfileProvider>(
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
                    fontSize: 15),
                scrollAxis: Axis.horizontal,
                crossAxisAlignment: CrossAxisAlignment.start,
                blankSpace: 20.0,
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
