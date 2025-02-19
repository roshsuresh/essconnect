
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
import '../../Application/Staff_Providers/StaffFlashnews.dart';
import '../../Application/Staff_Providers/StaffProfile.dart';
import '../../Application/StudentProviders/CurriculamProviders.dart';
import '../../Application/StudentProviders/InternetConnection.dart';
import '../../Application/StudentProviders/SiblingsProvider.dart';
import '../../Constants.dart';
import '../../utils/constants.dart';
import '../../utils/spinkit.dart';
import '../Admin/Birthday/InitialScreen.dart';
import '../Admin/WebViewLogin.dart';
import '../Login_Activation/Login_page.dart';
import '../Staff/AbsenteesReport.dart';
import '../Staff/Anecdotal/StudAnecdotal/AnecdotalInitialScreen.dart';
import '../Staff/CommunicationToGuardian.dart';
import '../Staff/ExamTT.dart/ExamTTScreen.dart';
import '../Staff/GalleryUpload.dart';
import '../Staff/HPC/HPC_Home_Page.dart';
import '../Staff/MarkEntryNew.dart';
import '../Staff/MissingReport.dart';
import '../Staff/NoticeBoard.dart';
import '../Staff/Portion/Portions.dart';
import '../Staff/RemarksEntry.dart';
import '../Staff/ScreenNotification.dart';
import '../Staff/StaffProfile.dart';
import '../Staff/StaffTimeTable.dart';
import '../Staff/StudAttendenceEntry.dart';
import '../Staff/StudReport.dart';
import '../Staff/StudentReportNew/InitialScreen.dart';
import '../Staff/ToolMarkEntry.dart';
import '../Staff/staff_feedback.dart';
import '../Student/CurriculamScreen.dart';
import '../Student/NoInternetScreen.dart';
import '../Student/PasswordChange.dart';
import 'StudentHomeStaff.dart';

class StaffHomeScreen extends StatefulWidget {
  const StaffHomeScreen({Key? key}) : super(key: key);

  @override
  State<StaffHomeScreen> createState() => _StaffHomeScreenState();
}

class _StaffHomeScreenState extends State<StaffHomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Provider.of<ConnectivityProvider>(context, listen: false);
      await Provider.of<StaffProfileProvider>(context, listen: false)
          .staff_profileData();
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
            :
        UpgradeAlert(
          dialogStyle: UpgradeDialogStyle.cupertino,

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
                        )),
                  ),
                ),
              ),
              ProfileHome(kheight20: kheight20, kheight: kheight),
              const Flashnews(),
              Container(
                clipBehavior: Clip.antiAlias,
                width: width,
                height: size.height - 180,
                decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(blurRadius: 5, offset: Offset(1, 3))
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: AnimationLimiter(
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
                          'Personal info',
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
                                color: Colors.black45,
                                height: 36,
                              )),
                        ),
                      ]),
                      kheight,
                      AnimationConfiguration.staggeredList(
                        position: 1,
                        delay: const Duration(milliseconds: 100),
                        child: SlideAnimation(
                          duration: const Duration(milliseconds: 3500),
                          curve: Curves.fastLinearToSlowEaseIn,
                          child: FadeInAnimation(
                            curve: Curves.fastLinearToSlowEaseIn,
                            duration: const Duration(milliseconds: 3500),
                            child: Row(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType
                                            .rightToLeft,
                                        child:
                                        // StudentPortal(),
                                        //Profile_Info(),
                                        //SpeechScreen(),
                                        EnhancedMarkAnalysisScreen(),


                                        // MapScreen(
                                        //   imeiNumber:Provider.of<ProfileProvider>(context, listen: false).imeiNumber.toString(),
                                        // ),


                                        duration: const Duration(
                                            milliseconds: 300),
                                      ),
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
                                                    'assets/Profilee.png',
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        kheight,
                                        const Text(
                                          'Profile',
                                          //'Bus Tracking',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 11,
                                              color: Colors.black),
                                        )
                                      ],
                                    ),
                                  ),
                                ),

                                Consumer<StudNotificationCountProviders>(
                                  builder: (context, count, child) =>
                                  count.loading
                                      ? Padding(
                                    padding:
                                    const EdgeInsets.only(
                                        left: 10,
                                        right: 10),
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
                                                const DecorationImage(
                                                  opacity: 20,
                                                  image:
                                                  AssetImage(
                                                    'assets/Noticeboard.png',
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
                                          'Notice Board',
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
                                    showBadge: count.noticeCount == 0
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
                                      count.noticeCount == null
                                          ? ''
                                          : count.noticeCount
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
                                              const NoticeBoard(),
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
                                            left: 10,
                                            right: 10),
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
                                                  BoxDecoration(
                                                    image:
                                                    const DecorationImage(
                                                      opacity:
                                                      20,
                                                      image:
                                                      AssetImage(
                                                        'assets/Noticeboard.png',
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
                                              'Notice Board',
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

                                Consumer<StudNotificationCountProviders>(
                                  builder: (context, count, child) =>
                                  count.loading
                                      ? Padding(
                                    padding:
                                    const EdgeInsets.only(
                                        left: 10,
                                        right: 10),
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
                                                const DecorationImage(
                                                  opacity: 20,
                                                  image:
                                                  AssetImage(
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
                                              const Stud_Notification(),
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
                                            left: 10,
                                            right: 10),
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
                                                  BoxDecoration(
                                                    image:
                                                    const DecorationImage(
                                                      opacity:
                                                      20,
                                                      image:
                                                      AssetImage(
                                                        'assets/notificationnew.png',
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
                                              'Notification',
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
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: GestureDetector(
                                    onTap: () async {
                                      await Provider.of<
                                          Curriculamprovider>(
                                          context,
                                          listen: false)
                                          .getCuriculamtoken();
                                      await Navigator.push(
                                        context,
                                        PageTransition(
                                          type: PageTransitionType
                                              .rightToLeft,
                                          child:
                                          // AnimatedLoginScreen(),

                                          //EventInitial(),
                                          StudentPortal(),
                                          duration: const Duration(
                                              milliseconds: 300),
                                        ),
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
                                                    'assets/adminportal.png',
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
                                          'School Portal',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
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
                        ),
                      ),



                      kheight20,
                      // AnimationConfiguration.staggeredList(
                      //   position: 2,
                      //   delay: const Duration(milliseconds: 100),
                      //   child: SlideAnimation(
                      //     duration: const Duration(milliseconds: 3500),
                      //     curve: Curves.fastLinearToSlowEaseIn,
                      //     child: FadeInAnimation(
                      //       curve: Curves.fastLinearToSlowEaseIn,
                      //       duration: const Duration(milliseconds: 3500),
                      //       child: Consumer<ModuleProviders>(
                      //         builder: (context, module, child) => Row(
                      //           children: [
                      //             // Online Fees Container
                      //             if (module.fees == true || module.feesOnly == true)
                      //               Expanded(
                      //                 child: Padding(
                      //                   padding: const EdgeInsets.only(left: 8, right: 4),
                      //                   child: Container(
                      //                     decoration: const BoxDecoration(
                      //                         color: Color.fromARGB(255, 236, 237, 245),
                      //                         borderRadius: BorderRadius.all(Radius.circular(10))
                      //                     ),
                      //                     height: 170,
                      //                     width: width,
                      //                     child: Column(
                      //                       children: [
                      //                         kheight,
                      //                         Row(children: <Widget>[
                      //                           Expanded(
                      //                             child: Container(
                      //                                 margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                      //                                 child: const Divider(
                      //                                   color: Colors.black45,
                      //                                   height: 36,
                      //                                 )
                      //                             ),
                      //                           ),
                      //                           const Text(
                      //                             '* Online Fees *',
                      //                             textAlign: TextAlign.left,
                      //                             style: TextStyle(
                      //                                 color: UIGuide.light_Purple,
                      //                                 fontWeight: FontWeight.w900
                      //                             ),
                      //                           ),
                      //                           Expanded(
                      //                             child: Container(
                      //                                 margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                      //                                 child: const Divider(
                      //                                   color: Colors.black45,
                      //                                   height: 36,
                      //                                 )
                      //                             ),
                      //                           ),
                      //                         ]),
                      //                         kheight,
                      //                         Row(
                      //                           crossAxisAlignment: CrossAxisAlignment.start,
                      //                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //                           children: [
                      //                             Expanded(
                      //                               child: GestureDetector(
                      //                                 onTap: () async {
                      //                                   await prov.getFeeWiseStatus(context);
                      //                                   status = prov.existFeeWise;
                      //                                   await Navigator.push(
                      //                                       context,
                      //                                       PageTransition(
                      //                                         type: PageTransitionType.rightToLeft,
                      //                                         child: prov.webViewforMobileappPayment == true
                      //                                             ? FeeWebScreen(schdomain: subDomain!)
                      //                                             : status == true
                      //                                             ? const PayFeeWise()
                      //                                             : const PayFee(),
                      //                                         duration: const Duration(milliseconds: 300),
                      //                                       )
                      //                                   );
                      //                                 },
                      //                                 child: Column(
                      //                                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //                                   children: [
                      //                                     Card(
                      //                                       elevation: 10,
                      //                                       color: Colors.white,
                      //                                       shape: RoundedRectangleBorder(
                      //                                         borderRadius: BorderRadius.circular(12.0),
                      //                                       ),
                      //                                       child: Padding(
                      //                                         padding: const EdgeInsets.all(8.0),
                      //                                         child: Container(
                      //                                           height: 38,
                      //                                           width: 38,
                      //                                           decoration: const BoxDecoration(
                      //                                             image: DecorationImage(
                      //                                               image: AssetImage('assets/payNew.png'),
                      //                                             ),
                      //                                           ),
                      //                                         ),
                      //                                       ),
                      //                                     ),
                      //                                     kheight,
                      //                                     const Text(
                      //                                       'Pay Fee',
                      //                                       style: TextStyle(
                      //                                           fontWeight: FontWeight.w600,
                      //                                           fontSize: 11,
                      //                                           color: Colors.black
                      //                                       ),
                      //                                     )
                      //                                   ],
                      //                                 ),
                      //                               ),
                      //                             ),
                      //                             Expanded(
                      //                               child: GestureDetector(
                      //                                 onTap: () async {
                      //                                   await Navigator.push(
                      //                                       context,
                      //                                       PageTransition(
                      //                                         type: PageTransitionType.rightToLeft,
                      //                                         child: const PaymentHistory(),
                      //                                         duration: const Duration(milliseconds: 300),
                      //                                       )
                      //                                   );
                      //                                 },
                      //                                 child: Column(
                      //                                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //                                   children: [
                      //                                     Card(
                      //                                       elevation: 10,
                      //                                       color: Colors.white,
                      //                                       shape: RoundedRectangleBorder(
                      //                                         borderRadius: BorderRadius.circular(12.0),
                      //                                       ),
                      //                                       child: Padding(
                      //                                         padding: const EdgeInsets.all(8.0),
                      //                                         child: Container(
                      //                                           height: 38,
                      //                                           width: 38,
                      //                                           decoration: BoxDecoration(
                      //                                             image: const DecorationImage(
                      //                                               image: AssetImage('assets/Payment History.png'),
                      //                                             ),
                      //                                             borderRadius: BorderRadius.circular(10),
                      //                                           ),
                      //                                         ),
                      //                                       ),
                      //                                     ),
                      //                                     kheight,
                      //                                     const Text(
                      //                                       'Payment \n History',
                      //                                       textAlign: TextAlign.center,
                      //                                       style: TextStyle(
                      //                                           fontWeight: FontWeight.w600,
                      //                                           fontSize: 11,
                      //                                           color: Colors.black
                      //                                       ),
                      //                                     )
                      //                                   ],
                      //                                 ),
                      //                               ),
                      //                             ),
                      //                           ],
                      //                         ),
                      //                       ],
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ),
                      //
                      //             // Offline Fees Container
                      //             if (module.offlineFees == true)
                      //               Expanded(
                      //                 child: Padding(
                      //                   padding: const EdgeInsets.only(right: 8, left: 4),
                      //                   child: Container(
                      //                     decoration: const BoxDecoration(
                      //                         color: Color.fromARGB(255, 236, 237, 245),
                      //                         borderRadius: BorderRadius.all(Radius.circular(10))
                      //                     ),
                      //                     height: 170,
                      //                     child: Column(
                      //                       children: [
                      //                         kheight,
                      //                         Row(children: <Widget>[
                      //                           Expanded(
                      //                             child: Container(
                      //                                 margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                      //                                 child: const Divider(
                      //                                   color: Colors.black45,
                      //                                   height: 36,
                      //                                 )
                      //                             ),
                      //                           ),
                      //                           const Text(
                      //                             '* Offline Fees *',
                      //                             textAlign: TextAlign.left,
                      //                             style: TextStyle(
                      //                                 color: UIGuide.light_Purple,
                      //                                 fontWeight: FontWeight.w900
                      //                             ),
                      //                           ),
                      //                           Expanded(
                      //                             child: Container(
                      //                                 margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                      //                                 child: const Divider(
                      //                                   color: Colors.black45,
                      //                                   height: 36,
                      //                                 )
                      //                             ),
                      //                           ),
                      //                         ]),
                      //                         kheight,
                      //                         Row(
                      //                           crossAxisAlignment: CrossAxisAlignment.start,
                      //                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //                           children: [
                      //                             Expanded(
                      //                               child: GestureDetector(
                      //                                 onTap: () {
                      //                                   Navigator.push(
                      //                                       context,
                      //                                       PageTransition(
                      //                                         type: PageTransitionType.rightToLeft,
                      //                                         child: const FeeInitialScreen(),
                      //                                         duration: const Duration(milliseconds: 300),
                      //                                       )
                      //                                   );
                      //                                 },
                      //                                 child: Column(
                      //                                   mainAxisAlignment: MainAxisAlignment.center,
                      //                                   children: [
                      //                                     Card(
                      //                                       elevation: 10,
                      //                                       color: Colors.white,
                      //                                       shape: RoundedRectangleBorder(
                      //                                         borderRadius: BorderRadius.circular(12.0),
                      //                                       ),
                      //                                       child: Padding(
                      //                                         padding: const EdgeInsets.all(8.0),
                      //                                         child: Container(
                      //                                           height: 38,
                      //                                           width: 38,
                      //                                           decoration: const BoxDecoration(
                      //                                             image: DecorationImage(
                      //                                               image: AssetImage('assets/offline fee.png'),
                      //                                             ),
                      //                                           ),
                      //                                         ),
                      //                                       ),
                      //                                     ),
                      //                                     kheight,
                      //                                     const Text(
                      //                                       'Fees',
                      //                                       style: TextStyle(
                      //                                           fontWeight: FontWeight.w600,
                      //                                           fontSize: 11,
                      //                                           color: Colors.black
                      //                                       ),
                      //                                     )
                      //                                   ],
                      //                                 ),
                      //                               ),
                      //                             ),
                      //                             Expanded(
                      //                               child: GestureDetector(
                      //                                 onTap: () async {
                      //                                   await Navigator.push(
                      //                                       context,
                      //                                       PageTransition(
                      //                                         type: PageTransitionType.rightToLeft,
                      //                                         child: const BusFeeInitialScreen(),
                      //                                         duration: const Duration(milliseconds: 300),
                      //                                       )
                      //                                   );
                      //                                 },
                      //                                 child: Column(
                      //                                   mainAxisAlignment: MainAxisAlignment.center,
                      //                                   children: [
                      //                                     Card(
                      //                                       elevation: 10,
                      //                                       color: Colors.white,
                      //                                       shape: RoundedRectangleBorder(
                      //                                         borderRadius: BorderRadius.circular(12.0),
                      //                                       ),
                      //                                       child: Padding(
                      //                                         padding: const EdgeInsets.all(8.0),
                      //                                         child: Container(
                      //                                           height: 38,
                      //                                           width: 38,
                      //                                           decoration: BoxDecoration(
                      //                                             image: const DecorationImage(
                      //                                               image: AssetImage('assets/offline bus fee.png'),
                      //                                             ),
                      //                                             borderRadius: BorderRadius.circular(10),
                      //                                           ),
                      //                                         ),
                      //                                       ),
                      //                                     ),
                      //                                     kheight,
                      //                                     const Text(
                      //                                       'Bus Fees',
                      //                                       textAlign: TextAlign.center,
                      //                                       style: TextStyle(
                      //                                           fontWeight: FontWeight.w600,
                      //                                           fontSize: 11,
                      //                                           color: Colors.black
                      //                                       ),
                      //                                     )
                      //                                   ],
                      //                                 ),
                      //                               ),
                      //                             ),
                      //                           ],
                      //                         ),
                      //                       ],
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ),
                      //           ],
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      AnimationConfiguration.staggeredList(
                        position: 2,
                        delay: const Duration(milliseconds: 100),
                        child: SlideAnimation(
                          duration: const Duration(milliseconds: 3500),
                          curve: Curves.fastLinearToSlowEaseIn,
                          child: FadeInAnimation(
                            curve: Curves.fastLinearToSlowEaseIn,
                            duration: const Duration(milliseconds: 3500),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 4),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 236, 237, 245),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      height: 170,
                                      width: width,
                                      child: Column(
                                        children: [
                                          kheight,
                                          Row(children: <Widget>[
                                            Expanded(
                                              child: Container(
                                                  margin: const EdgeInsets
                                                      .only(
                                                      left: 10.0,
                                                      right: 10.0),
                                                  child: const Divider(
                                                    color: Colors.black45,
                                                    height: 36,
                                                  )),
                                            ),
                                            const Text(
                                              '* Online Fees *',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: UIGuide
                                                      .light_Purple,
                                                  fontWeight:
                                                  FontWeight.w900),
                                            ),
                                            Expanded(
                                              child: Container(
                                                  margin: const EdgeInsets
                                                      .only(
                                                      left: 10.0,
                                                      right: 10.0),
                                                  child: const Divider(
                                                    color: Colors.black45,
                                                    height: 36,
                                                  )),
                                            ),
                                          ]),
                                          kheight,
                                          Consumer<ModuleProviders>(
                                            builder: (context, module,
                                                child) =>
                                                Row(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceEvenly,
                                                  children: [
                                                    Expanded(
                                                      child: GestureDetector(
                                                        onTap: () async {
                                                          await prov
                                                              .getFeeWiseStatus(context);
                                                          status=  prov.existFeeWise;
                                                          print("modulee ${module.fees}");
                                                          module.fees ==
                                                              true ||
                                                              module.feesOnly ==
                                                                  true
                                                              ? await Navigator
                                                              .push(
                                                              context,
                                                              PageTransition(
                                                                type:
                                                                PageTransitionType.rightToLeft,
                                                                child:
                                                                // schoolid=="aae5cd74-bf25-4f4d-8fcd-fe19448c313f"
                                                                //     ||
                                                                //     schoolid=="82fe07de-c0f7-44b1-9f85-07cfb26caf04"
                                                                prov.webViewforMobileappPayment==true
                                                                    ? FeeWebScreen(schdomain: subDomain!)
                                                                    :
                                                                status==true?
                                                                const PayFeeWise():
                                                                const PayFee(),
                                                                duration:
                                                                const Duration(milliseconds: 300),
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
                                                                  BoxDecoration(
                                                                    image:
                                                                    DecorationImage(
                                                                      opacity:
                                                                      module.fees ==
                                                                          true ||
                                                                          module.feesOnly ==
                                                                              true? 20 :0.2,
                                                                      image:
                                                                      const AssetImage(
                                                                        'assets/payNew.png',
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            kheight,
                                                            Text(
                                                              'Pay Fee',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                                  fontSize:
                                                                  11,
                                                                  color:
                                                                  module.fees ==
                                                                      true ||
                                                                      module.feesOnly ==
                                                                          true? Colors.black:
                                                                  Colors.black26),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: GestureDetector(
                                                        onTap: () async {
                                                          module.fees ==
                                                              true ||
                                                              module.feesOnly ==
                                                                  true
                                                              ? await Navigator
                                                              .push(
                                                              context,
                                                              PageTransition(
                                                                type:
                                                                PageTransitionType.rightToLeft,
                                                                child:
                                                                const PaymentHistory(),
                                                                duration:
                                                                const Duration(milliseconds: 300),
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
                                                                    .all(
                                                                    8.0),
                                                                child:
                                                                Container(
                                                                  height: 38,
                                                                  width: 38,
                                                                  decoration:
                                                                  BoxDecoration(
                                                                    image:
                                                                    DecorationImage(
                                                                      opacity:
                                                                      module.fees ==
                                                                          true ||
                                                                          module.feesOnly ==
                                                                              true? 20 :0.2,
                                                                      image:
                                                                      const AssetImage(
                                                                        'assets/Payment History.png',
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
                                                            Text(
                                                              'Payment \n History',
                                                              textAlign:
                                                              TextAlign
                                                                  .center,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                                  fontSize:
                                                                  11,
                                                                  color:
                                                                  module.fees ==
                                                                      true ||
                                                                      module.feesOnly ==
                                                                          true ?
                                                                  Colors.black :
                                                                  Colors.black26),
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
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 8, left: 4),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 236, 237, 245),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      height: 170,
                                      child: Column(
                                        children: [
                                          kheight,
                                          Row(children: <Widget>[
                                            Expanded(
                                              child: Container(
                                                  margin: const EdgeInsets
                                                      .only(
                                                      left: 10.0,
                                                      right: 10.0),
                                                  child: const Divider(
                                                    color: Colors.black45,
                                                    height: 36,
                                                  )),
                                            ),
                                            const Text(
                                              '* Offline Fees *',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: UIGuide
                                                      .light_Purple,
                                                  fontWeight:
                                                  FontWeight.w900),
                                            ),
                                            Expanded(
                                              child: Container(
                                                  margin: const EdgeInsets
                                                      .only(
                                                      left: 10.0,
                                                      right: 10.0),
                                                  child: const Divider(
                                                    color: Colors.black45,
                                                    height: 36,
                                                  )),
                                            ),
                                          ]),
                                          kheight,
                                          Consumer<ModuleProviders>(
                                            builder: (context, module,
                                                child) =>
                                                Row(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceEvenly,
                                                  children: [
                                                    Expanded(
                                                      child: GestureDetector(
                                                        onTap: () async {
                                                          module.offlineFees ==
                                                              true
                                                              ? Navigator.push(
                                                              context,
                                                              PageTransition(
                                                                type: PageTransitionType
                                                                    .rightToLeft,
                                                                child:
                                                                const FeeInitialScreen(),
                                                                duration: const Duration(
                                                                    milliseconds:
                                                                    300),
                                                              ))
                                                              : _noAcess();
                                                        },
                                                        child: Column(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                          children: [
                                                            Card(
                                                              elevation: 10,
                                                              color: Colors
                                                                  .white,
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
                                                                  BoxDecoration(
                                                                    image:
                                                                    DecorationImage(
                                                                      opacity:
                                                                      module.offlineFees ==
                                                                          true?  20:0.2,
                                                                      image:
                                                                      const AssetImage(
                                                                        'assets/offline fee.png',
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            kheight,
                                                            Text(
                                                              'Fees',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                                  fontSize:
                                                                  11,
                                                                  color:
                                                                  module.offlineFees ==
                                                                      true?Colors.black:
                                                                  Colors.black26),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: GestureDetector(
                                                        onTap: () async {
                                                          module.offlineFees ==
                                                              true
                                                              ? await Navigator
                                                              .push(
                                                              context,
                                                              PageTransition(
                                                                type:
                                                                PageTransitionType.rightToLeft,
                                                                child:
                                                                const BusFeeInitialScreen(),
                                                                duration:
                                                                const Duration(milliseconds: 300),
                                                              ))
                                                              : _noAcess();
                                                        },
                                                        child: Column(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                          children: [
                                                            Card(
                                                              elevation: 10,
                                                              color: Colors
                                                                  .white,
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
                                                                  BoxDecoration(
                                                                    image:
                                                                    DecorationImage(
                                                                      opacity:
                                                                      module.offlineFees ==
                                                                          true?  20:0.2,
                                                                      image:
                                                                      const AssetImage(
                                                                        'assets/offline bus fee.png',
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
                                                            Text(
                                                              'Bus Fees',
                                                              textAlign:
                                                              TextAlign
                                                                  .center,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                                  fontSize:
                                                                  11,
                                                                  color:
                                                                  module.offlineFees ==
                                                                      true?Colors.black   :
                                                                  Colors.black26),
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
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      kheight10,
                      AnimationConfiguration.staggeredList(
                        position: 3,
                        delay: const Duration(milliseconds: 100),
                        child: SlideAnimation(
                          duration: const Duration(milliseconds: 3500),
                          curve: Curves.fastLinearToSlowEaseIn,
                          child: FadeInAnimation(
                            curve: Curves.fastLinearToSlowEaseIn,
                            duration: const Duration(milliseconds: 3500),
                            child: Row(children: <Widget>[
                              const Text(
                                "──   ",
                                style: TextStyle(color: Colors.black26),
                              ),
                              const Text(
                                "Academics",
                                textAlign: TextAlign.left,
                                style: TextStyle(
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
                          ),
                        ),
                      ),
                      kheight,
                      Consumer<ModuleProviders>(
                        builder: (context, module, child) =>
                            AnimationConfiguration.staggeredList(
                              position: 4,
                              delay: const Duration(milliseconds: 100),
                              child: SlideAnimation(
                                duration: const Duration(milliseconds: 3500),
                                curve: Curves.fastLinearToSlowEaseIn,
                                child: FadeInAnimation(
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  duration:
                                  const Duration(milliseconds: 3500),
                                  child: Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                          module.offlineAttendence == true
                                              ? await Navigator.push(
                                              context,
                                              PageTransition(
                                                type: PageTransitionType
                                                    .rightToLeft,
                                                child: const Attendence(),
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
                                                        opacity:
                                                        module.offlineAttendence == true?20: 0.2,
                                                        image: const AssetImage(
                                                          'assets/Attendance.png',
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              kheight,
                                              Text(
                                                'Attendance',
                                                style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.w600,
                                                    fontSize: 11,
                                                    color:
                                                    module.offlineAttendence == true?Colors.black:
                                                    Colors.black26),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Consumer<ProfileProvider>(
                                        builder: (context, value, child) {
                                          return GestureDetector(
                                            onTap: () async {
                                              if (module.timetable == true) {
                                                var divId =
                                                value.divisionId == null
                                                    ? 'divId is null'
                                                    : value.divisionId
                                                    .toString();
                                                print(divId);
                                                await Provider.of<
                                                    Timetableprovider>(
                                                    context,
                                                    listen: false)
                                                    .getTimeTable(divId);
                                                await Navigator.push(
                                                    context,
                                                    PageTransition(
                                                      type: PageTransitionType
                                                          .rightToLeft,
                                                      child:
                                                      const Timetable(),
                                                      duration:
                                                      const Duration(
                                                          milliseconds:
                                                          300),
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
                                                          DecorationImage(
                                                            opacity:module.timetable == true? 20:0.2,
                                                            image: const AssetImage(
                                                              'assets/Timetable.png',
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  kheight,
                                                  Text(
                                                    'Timetable',
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight.w600,
                                                        fontSize: 11,
                                                        color:
                                                        module.timetable == true?
                                                        Colors.black:Colors.black26),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          await Navigator.push(
                                              context,
                                              PageTransition(
                                                type: PageTransitionType
                                                    .rightToLeft,
                                                child:
                                                const Diary(),
                                                // const AnecDotal(),
                                                // MyTimeline(),
                                                duration: const Duration(
                                                    milliseconds: 300),
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
                                                        opacity: 20,
                                                        image: AssetImage(
                                                          'assets/diary.png',
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              kheight,
                                              const Text(
                                                'Diary',
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

                                    ],
                                  ),
                                ),
                              ),
                            ),
                      ),
                      kheight10,
                      Consumer<ModuleProviders>(
                        builder: (context, module, child) =>
                            AnimationConfiguration.staggeredList(
                              position: 5,
                              delay: const Duration(milliseconds: 100),
                              child: SlideAnimation(
                                duration: const Duration(milliseconds: 3500),
                                curve: Curves.fastLinearToSlowEaseIn,
                                child: FadeInAnimation(
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  duration:
                                  const Duration(milliseconds: 3500),
                                  child: Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: GestureDetector(
                                          onTap: () async {
                                            module.offlineTab == true
                                                ? await Navigator.push(
                                                context,
                                                PageTransition(
                                                  type: PageTransitionType
                                                      .rightToLeft,
                                                  child:
                                                  const ReportCard(),
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
                                                    decoration: BoxDecoration(
                                                      image:
                                                      DecorationImage(
                                                        opacity:
                                                        module.offlineTab == true?20:0.2,
                                                        image: const AssetImage(
                                                          'assets/Reportcard.png',
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
                                              Text(
                                                'Report Card',
                                                style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.w600,
                                                    fontSize: 11,
                                                    color:
                                                    module.offlineTab == true?
                                                    Colors.black: Colors.black26),
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
                                            module.offlineTab == true
                                                ? await Navigator.push(
                                                context,
                                                PageTransition(
                                                  type: PageTransitionType
                                                      .rightToLeft,
                                                  child:
                                                  // const MapPage(),
                                                  const  MarkSheetView(),
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
                                                    decoration: BoxDecoration(
                                                      image:
                                                      DecorationImage(
                                                        opacity:
                                                        module.offlineTab == true? 20 :0.2,
                                                        image: const AssetImage(
                                                          'assets/Marksheet.png',
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
                                              Text(
                                                'Mark Sheet',
                                                style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.w600,
                                                    fontSize: 11,
                                                    color:
                                                    module.offlineTab == true ? Colors.black:
                                                    Colors.black26),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Consumer<StudNotificationCountProviders>(
                                        builder: (context, count, child) =>
                                        count.loading
                                            ? Padding(
                                          padding:
                                          const EdgeInsets.only(
                                              left: 10,
                                              right: 10),
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
                                                      const DecorationImage(
                                                        opacity: 20,
                                                        image:
                                                        AssetImage(
                                                          'assets/anecdotal.png',
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
                                                'Anecdotal',
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
                                          showBadge: count.anecdotalCount == 0
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
                                            count.anecdotalCount == null
                                                ? ''
                                                : count.anecdotalCount
                                                .toString(),
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                                fontWeight:
                                                FontWeight.bold),
                                          ),
                                          child: GestureDetector(
                                            onTap: () async {
                                              module.curiculam == true
                                                  ?
                                              await Navigator.push(
                                                  context,
                                                  PageTransition(
                                                    type: PageTransitionType
                                                        .rightToLeft,
                                                    child:
                                                    const AnecDotal(),
                                                    duration:
                                                    const Duration(
                                                        milliseconds:
                                                        300),
                                                  )):
                                              _noAcess();

                                            },
                                            child: Padding(
                                              padding:
                                              const EdgeInsets
                                                  .only(
                                                  left: 10,
                                                  right: 10),
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
                                                        BoxDecoration(
                                                          image:
                                                          DecorationImage(
                                                            opacity:
                                                            module.curiculam == true
                                                                ?  20:0.2,
                                                            image:
                                                            const AssetImage(
                                                              'assets/anecdotal.png',
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
                                                  Text(
                                                    'Anecdotal',
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight
                                                            .w600,
                                                        fontSize: 11,
                                                        color: module.curiculam == true
                                                            ? Colors
                                                            .black:Colors.black26),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: GestureDetector(
                                          onTap: () async {
                                            await Provider.of<
                                                Curriculamprovider>(
                                                context,
                                                listen: false)
                                                .getCuriculamtoken();
                                            await Navigator.push(
                                              context,
                                              PageTransition(
                                                type: PageTransitionType
                                                    .rightToLeft,
                                                child:
                                                // PortionView(),
                                                // StudentPortions(),
                                                const Gallery(),
                                                duration: const Duration(
                                                    milliseconds: 300),
                                              ),
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
                                                          'assets/Gallery.png',
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
                                                'Gallery',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
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
                              ),
                            ),
                      ),
                      kheight10,
                      Consumer<ModuleProviders>(
                        builder: (context, module, child) =>
                            AnimationConfiguration.staggeredList(
                              position: 4,
                              delay: const Duration(milliseconds: 100),
                              child: SlideAnimation(
                                duration: const Duration(milliseconds: 3500),
                                curve: Curves.fastLinearToSlowEaseIn,
                                child: FadeInAnimation(
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  duration:
                                  const Duration(milliseconds: 3500),
                                  child: Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                                                          String token = curri.token
                                                              .toString();

                                                          await Navigator.push(
                                                              context,
                                                              PageTransition(
                                                                type: PageTransitionType
                                                                    .rightToLeft,
                                                                child:
                                                                //HomeWorkInbox(),

                                                                const PortionView(),
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
                                                                    DecorationImage(
                                                                      opacity:module.curiculam == true? 20:0.2,
                                                                      image: const AssetImage(
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
                                                            Text(
                                                              'portion',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight.w600,
                                                                  fontSize: 11,
                                                                  color:
                                                                  module.curiculam == true?Colors.black:
                                                                  Colors.black26),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                            ),
                                      ),


                                      Consumer<Curriculamprovider>(
                                        builder: (context, curri, child) =>
                                            Consumer<StudNotificationCountProviders>(
                                              builder: (context, count, child) =>
                                                  GestureDetector(
                                                    onTap: () async {
                                                      if (module.curiculam == true) {
                                                        await Provider.of<
                                                            Curriculamprovider>(
                                                            context,
                                                            listen: false)
                                                            .getCuriculamtoken();
                                                        String token = curri.token
                                                            .toString();

                                                        await Navigator.push(
                                                            context,
                                                            PageTransition(
                                                              type: PageTransitionType
                                                                  .rightToLeft,
                                                              child:
                                                              const SubjectPage(),
                                                              // CurriculamPage(
                                                              //   token: token,
                                                              // ),
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
                                                                  DecorationImage(
                                                                    opacity:
                                                                    module.curiculam == true?20:0.2,
                                                                    image: const AssetImage(
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
                                                          Text(
                                                            'Homework',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                FontWeight.w600,
                                                                fontSize: 11,
                                                                color:
                                                                module.curiculam == true?Colors.black:
                                                                Colors.black26
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                            ),
                                      ),
                                      Consumer<ChatProviders>(
                                        builder: (context, chat, child) => GestureDetector(
                                          onTap: () {
                                            if (module.curiculam == false) {
                                              _noAcess();
                                            } else {
                                              Navigator.push(
                                                context,
                                                PageTransition(
                                                  type: PageTransitionType.rightToLeft,
                                                  child: const ChatFirstScreen(),
                                                  duration: const Duration(milliseconds: 200),
                                                ),
                                              );
                                            }
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 8),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                badges.Badge(
                                                  showBadge: provvv.chatCount > 0,
                                                  badgeAnimation: const badges.BadgeAnimation.rotation(
                                                    animationDuration: Duration(seconds: 1),
                                                    colorChangeAnimationDuration: Duration(seconds: 1),
                                                    loopAnimation: false,
                                                    curve: Curves.fastOutSlowIn,
                                                    colorChangeAnimationCurve: Curves.easeInCubic,
                                                  ),
                                                  position: badges.BadgePosition.topEnd(end: 9),
                                                  badgeContent: Text(
                                                    provvv.chatCount == 0 ? '' : provvv.chatCount.toString(),
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 10,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  child: Card(
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
                                                          image: DecorationImage(
                                                            opacity: module.curiculam == true ? 1.0 : 0.2,
                                                            image: AssetImage('assets/chat.png'),
                                                          ),
                                                          borderRadius: BorderRadius.circular(10),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                kheight10,
                                                Text(
                                                  'Chat',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 11,
                                                    color: module.curiculam == true ? Colors.black : Colors.black26,
                                                  ),
                                                ),
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
                      Consumer<SchoolNameProvider>(
                        builder: (context, snap, child) => snap
                            .allowGPSTracking ==
                            "true"
                            ? GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType
                                    .rightToLeft,
                                child:

                                MapScreen(
                                  imeiNumber: Provider.of<
                                      ProfileProvider>(
                                      context,
                                      listen: false)
                                      .imeiNumber
                                      .toString(),
                                ),
                                duration: const Duration(
                                    milliseconds: 300),
                              ),
                            );
                          },
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
                                            'assets/bus-station.png',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                kheight,
                                const Text(
                                  //'Profile',
                                  'Bus Tracking',
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
                            : const SizedBox(
                          height: 0,
                          width: 0,
                        ),
                      ), //bus  Tracking
                      Container(
                          margin: const EdgeInsets.only(
                              left: 10.0, right: 10.0),
                          child: const Divider(
                            color: Colors.black45,
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
                                      type: PageTransitionType.rightToLeft,
                                      child: PasswordChange(),
                                      duration:
                                      const Duration(milliseconds: 300),
                                    ),
                                  );
                                },
                                child: const Icon(
                                  Icons.key_sharp,
                                  color: UIGuide.light_Purple,
                                ),
                              ),
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
                                    //         context: context,
                                    //         dialogType: DialogType.noHeader,
                                    //         // borderSide: const BorderSide(
                                    //         //     color: UIGuide.light_Purple,
                                    //         //     width: 2),
                                    //         buttonsBorderRadius:
                                    //             const BorderRadius.all(
                                    //                 Radius.circular(2)),
                                    //         animType: AnimType.bottomSlide,
                                    //         title: 'SignOut?',
                                    //         desc:
                                    //             'Are you sure want to sign out?',
                                    //         showCloseIcon: false,
                                    //         btnCancelColor: UIGuide.button2,
                                    //         btnOkColor: UIGuide.button1,
                                    //         btnCancelOnPress: () {
                                    //           return;
                                    //         },
                                    //         btnOkOnPress: () async {
                                    //           SharedPreferences prefs =
                                    //               await SharedPreferences
                                    //                   .getInstance();
                                    //           print("accesstoken  $prefs");
                                    //           await prefs.remove("accesstoken");
                                    //           print("username  $prefs");
                                    //           await prefs.remove("username");
                                    //           print("password  $prefs");
                                    //           await prefs.remove("password");

                                    //           Navigator.of(context)
                                    //               .pushAndRemoveUntil(
                                    //                   MaterialPageRoute(
                                    //                       builder: (context) =>
                                    //                           LoginPage()),
                                    //                   (Route<dynamic> route) =>
                                    //                       false);
                                    //         },
                                    //         buttonsTextStyle: const TextStyle(
                                    //             color: Colors.white))
                                    //     .show();
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
                      kheight20,
                      // Consumer<SibingsProvider>(
                      //   builder: (context, value, child) {
                      //     return ListView.builder(
                      //         shrinkWrap: true,
                      //         itemCount: value.siblingList.isEmpty
                      //             ? 0
                      //             : value.siblingList.length,
                      //         itemBuilder: (context, index) {
                      //           var idd =
                      //               value.siblingList[index].id ?? '--';
                      //           Provider.of<SibingsProvider>(context,
                      //                   listen: false)
                      //               .getToken(idd);
                      //           return Container(
                      //             height: 0,
                      //             width: 0,
                      //           );
                      //         });
                      //   },
                      // ),
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
                      kheight10
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
