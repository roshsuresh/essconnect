import 'package:essconnect/Presentation/Student/FeedbackForm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_infinite_marquee/flutter_infinite_marquee.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:lottie/lottie.dart';
import 'package:badges/badges.dart' as badges;
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upgrader/upgrader.dart';
import '../../Application/Module Providers.dart/Module.dart';
import '../../Application/Module Providers.dart/SchoolNameProvider.dart';
import '../../Application/StudentProviders/CurriculamProviders.dart';
import '../../Application/StudentProviders/FeesWiseProvider.dart';
import '../../Application/StudentProviders/InternetConnection.dart';
import '../../Application/StudentProviders/LocationServiceProvider.dart';
import '../../Application/StudentProviders/LoginProvider.dart';
import '../../Application/StudentProviders/NotificationCountProviders.dart';
import '../../Application/StudentProviders/ProfileProvider.dart';
import '../../Application/StudentProviders/SiblingsProvider.dart';
import '../../Application/StudentProviders/TimetableProvider.dart';
import '../../Constants.dart';
import '../../utils/constants.dart';
import '../../utils/spinkit.dart';
import '../Login_Activation/Login_page.dart';
import 'Anecdotal.dart';
import 'Attendence.dart';
import 'CurriculamScreen.dart';
import 'Diary.dart';
import 'FeeWebScreen.dart';
import 'FeeWisepayment.dart';
import 'Gallery.dart';
import 'MarkSheet.dart';
import 'NoInternetScreen.dart';
import 'NoticeBoard.dart';
import 'Offline/BusFeeInitial.dart';
import 'Offline/FeeInitialScreen.dart';
import 'PasswordChange.dart';
import 'PayFee.dart';
import 'PaymentHistory.dart';
import 'PortionView.dart';
import 'Profile_Info.dart';
import 'ReportTab.dart';
import 'Reportcard.dart';
import 'Stud_Notification.dart';
import 'StudentPortal.dart';
import 'TimeTable.dart';
import 'mappage.dart';

class StudentHome extends StatefulWidget {
  const StudentHome({Key? key}) : super(key: key);

  @override
  State<StudentHome> createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  var size, height, width, kheight, kheight20;
  String? schoolid;
  String? subDomain;
  String? userId;

  bool? status;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Provider.of<IconClickNotifier>(context, listen: false).enableIcons();
      Provider.of<ConnectivityProvider>(context, listen: false);
      await Provider.of<ProfileProvider>(context, listen: false).profileData();
      await Provider.of<StudNotificationCountProviders>(context, listen: false)
          .getnotificationCount();

      // Provider.of<SibingsProvider>(context, listen: false).siblingList.clear();
      // await Provider.of<SibingsProvider>(context, listen: false)
      //     .getSiblingName();
      await Provider.of<ModuleProviders>(context, listen: false)
          .getModuleDetails();
      await Provider.of<SchoolNameProvider>(context, listen: false)
          .getSchoolname();
      await Provider.of<LoginProvider>(context, listen: false).getMobileViewerId();
      await Provider.of<LoginProvider>(context, listen: false)
          .getsavemobileViewer(context);
      await Provider.of<LoginProvider>(context, listen: false)
          .sendUserDetails(context);
      await Provider.of<SibingsProvider>(context, listen: false)
          .setLoading(false);
      var provider = Provider.of<LocationProvider>(context, listen: false);
      await provider.gpsDevice();

      SharedPreferences pref = await SharedPreferences.getInstance();
      schoolid = pref.getString('schoolId');
      subDomain = pref.getString('subDomain');
      userId = pref.getString('userId');

      print("schooolllllllllll");
      print(schoolid);
      print(subDomain);

      //  showNotificationPermissionDialog();
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
    var prov=Provider.of<FeeWiseProvider>(context);
    return Scaffold(
      body: Consumer<ConnectivityProvider>(
        builder: (context, connection, child) => connection.isOnline == false
            ? const NoInternetConnection()
            : UpgradeAlert(
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
                                              child: Profile_Info(),
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
                                                        image: NetworkImage(
                                                          'https://gj-eschool-files-public.s3.amazonaws.com/mobileapp/assets/Profilee.png',
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              kheight,
                                              const Text(
                                                'Profile',
                                                // 'Bus Tracking',
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
                                                                      NetworkImage(
                                                                    'https://gj-eschool-files-public.s3.amazonaws.com/mobileapp/assets/Noticeboard.png',
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
                                                    showBadge:
                                                        count.noticeCount == 0
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
                                                                          NetworkImage(
                                                                        'https://gj-eschool-files-public.s3.amazonaws.com/mobileapp/assets/Noticeboard.png',
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
                                                                      NetworkImage(
                                                                    'https://gj-eschool-files-public.s3.amazonaws.com/mobileapp/assets/Notification.png',
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
                                                                  Stud_Notification(),
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
                                                                          NetworkImage(
                                                                        'https://gj-eschool-files-public.s3.amazonaws.com/mobileapp/assets/Notification.png',
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


                                      Consumer<IconClickNotifier>(
                                        builder: (context, iconClickNotifier,
                                                child) =>
                                            GestureDetector(
                                          onTap: iconClickNotifier
                                                  .areIconsClickable
                                              ? () {
                                                  // Disable all icons
                                                  iconClickNotifier
                                                      .disableIcons();

                                                  // Navigate to a new page
                                                  Navigator.push(
                                                    context,
                                                    PageTransition(
                                                      type: PageTransitionType
                                                          .rightToLeft,
                                                      child:
                                                          // PortionView(),
                                                          // StudentPortions(),
                                                          const StudentPortal(),
                                                      duration: const Duration(
                                                          milliseconds: 300),
                                                    ),
                                                  ).then((_) {
                                                    // Re-enable icons when returning
                                                    iconClickNotifier
                                                        .enableIcons();
                                                  });
                                                }
                                              : null,
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
                                                          image: NetworkImage(
                                                            'https://gj-eschool-files-public.s3.amazonaws.com/mobileapp/assets/adminportal.png',
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                kheight,
                                                const Text(
                                                  'School\nPortal',
                                                  // 'Bus Tracking',
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
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            kheight20,
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


                                                      Consumer<
                                                          IconClickNotifier>(
                                                        builder: (context,
                                                                iconClickNotifier,
                                                                child) =>
                                                            Expanded(
                                                          child:
                                                              GestureDetector(
                                                            onTap: iconClickNotifier
                                                                    .areIconsClickable
                                                                ? () async {
                                                                    // Disable all icons
                                                                    iconClickNotifier
                                                                        .disableIcons();

                                                                    // Navigate to a new page
                                                                    await prov
                                                                        .getFeeWiseStatus(
                                                                            context);
                                                                    status = prov
                                                                        .existFeeWise;
                                                                    print(
                                                                        "modulee ${module.fees}");
                                                                    module.fees ==
                                                                                true ||
                                                                            module.feesOnly ==
                                                                                true
                                                                        ? await Navigator.push(
                                                                            context,
                                                                            PageTransition(
                                                                              type: PageTransitionType.rightToLeft,
                                                                              child:
                                                                              // schoolid == "59318baf-974a-4fab-ab47-55680293dc97"
                                                                              // ||schoolid=="aae5cd74-bf25-4f4d-8fcd-fe19448c313f"
                                                                              // || schoolid == "aa923813-71dc-4af0-861b-bb2d4c625aa8"
                                                                              // || schoolid == "82fe07de-c0f7-44b1-9f85-07cfb26caf04"
                                                                                prov. webViewforMobileappPayment == true
                                                                                   ? FeeWebScreen(schdomain: subDomain!) :
                                                                              status == true
                                                                                      ? PayFeeWise()
                                                                                      : PayFee(),
                                                                              duration: const Duration(milliseconds: 300),
                                                                            )).then((_) {
                                                                            // Re-enable icons when returning
                                                                            iconClickNotifier.enableIcons();
                                                                          })
                                                                        : _noAcess();
                                                                  }
                                                                : null,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left: 10,
                                                                      right:
                                                                          10),
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
                                                                children: [
                                                                  Card(
                                                                    elevation:
                                                                        10,
                                                                    color: Colors
                                                                        .white,
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              12.0),
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                      child:
                                                                          Container(
                                                                        height:
                                                                            38,
                                                                        width:
                                                                            38,
                                                                        decoration:
                                                                            const BoxDecoration(
                                                                          image:
                                                                              DecorationImage(
                                                                            opacity:
                                                                                20,
                                                                            image:
                                                                                NetworkImage(
                                                                              'https://gj-eschool-files-public.s3.amazonaws.com/mobileapp/assets/payNew.png',
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  kheight,
                                                                  const Text(
                                                                    'Pay Fee',
                                                                    // 'Bus Tracking',
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        fontSize:
                                                                            11,
                                                                        color: Colors
                                                                            .black),
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
                                                                        opacity: module.fees == true ||
                                                                                module.feesOnly == true
                                                                            ? 20
                                                                            : 0.2,
                                                                        image:
                                                                            const NetworkImage(
                                                                          'https://gj-eschool-files-public.s3.ap-south-1.amazonaws.com/mobileapp/assets/Payment+History.png',
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
                                                                    color: module.fees ==
                                                                                true ||
                                                                            module.feesOnly ==
                                                                                true
                                                                        ? Colors
                                                                            .black
                                                                        : Colors
                                                                            .black26),
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
                                                                        opacity: module.offlineFees ==
                                                                                true
                                                                            ? 20
                                                                            : 0.2,
                                                                        image:
                                                                            const NetworkImage(
                                                                          'https://gj-eschool-files-public.s3.ap-south-1.amazonaws.com/mobileapp/assets/offline+fee.png',
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
                                                                    color: module.offlineFees ==
                                                                            true
                                                                        ? Colors
                                                                            .black
                                                                        : Colors
                                                                            .black26),
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
                                                                        opacity: module.offlineFees ==
                                                                                true
                                                                            ? 20
                                                                            : 0.2,
                                                                        image:
                                                                            const NetworkImage(
                                                                          'https://gj-eschool-files-public.s3.ap-south-1.amazonaws.com/mobileapp/assets/offline+bus+fee.png',
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
                                                                    color: module.offlineFees ==
                                                                            true
                                                                        ? Colors
                                                                            .black
                                                                        : Colors
                                                                            .black26),
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
                                                      decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                          opacity:
                                                              module.offlineAttendence ==
                                                                      true
                                                                  ? 20
                                                                  : 0.2,
                                                          image:
                                                              const NetworkImage(
                                                            'https://gj-eschool-files-public.s3.amazonaws.com/mobileapp/assets/Attendance.png',
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
                                                          module.offlineAttendence ==
                                                                  true
                                                              ? Colors.black
                                                              : Colors.black26),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),


                                        Consumer<IconClickNotifier>(
                                          builder: (context, iconClickNotifier,
                                                  child) =>
                                              Consumer<ProfileProvider>(
                                            builder: (context, value, child) {
                                              return GestureDetector(
                                                onTap: iconClickNotifier
                                                        .areIconsClickable
                                                    ? () async {
                                                        // Disable all icons
                                                        iconClickNotifier
                                                            .disableIcons();

                                                        // Navigate to a new page
                                                        if (module.timetable ==
                                                            true) {
                                                          var divId = value
                                                                      .divisionId ==
                                                                  null
                                                              ? 'divId is null'
                                                              : value.divisionId
                                                                  .toString();
                                                          print(divId);
                                                          await Provider.of<
                                                                      Timetableprovider>(
                                                                  context,
                                                                  listen: false)
                                                              .getTimeTable(
                                                                  divId);
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
                                                              )).then((_) {
                                                            // Re-enable icons when returning
                                                            iconClickNotifier
                                                                .enableIcons();
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
                                                                    NetworkImage(
                                                                  'https://gj-eschool-files-public.s3.amazonaws.com/mobileapp/assets/Timetable.png',
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      kheight,
                                                      const Text(
                                                        'Timetable',
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
                                              );
                                            },
                                          ),
                                        ), //timetable_new

                                        GestureDetector(
                                          onTap: () async {
                                            await Navigator.push(
                                                context,
                                                PageTransition(
                                                  type: PageTransitionType
                                                      .rightToLeft,
                                                  child: const Diary(),
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
                                                          image: NetworkImage(
                                                            'https://gj-eschool-files-public.s3.amazonaws.com/mobileapp/assets/diary.png',
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
                                                            // const ReportCard(),
                                                            // const HpcReportCard(),
                                                            const ReportTab(),
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
                                                        image: DecorationImage(
                                                          opacity:
                                                              module.offlineTab ==
                                                                      true
                                                                  ? 20
                                                                  : 0.2,
                                                          image:
                                                              const NetworkImage(
                                                            'https://gj-eschool-files-public.s3.amazonaws.com/mobileapp/assets/Reportcard.png',
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
                                                          module.offlineTab ==
                                                                  true
                                                              ? Colors.black
                                                              : Colors.black26),
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
                                                            //const MapPage(),
                                                            const MarkSheetView(),
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
                                                        image: DecorationImage(
                                                          opacity:
                                                              module.offlineTab ==
                                                                      true
                                                                  ? 20
                                                                  : 0.2,
                                                          image:
                                                              const NetworkImage(
                                                            'https://gj-eschool-files-public.s3.amazonaws.com/mobileapp/assets/Marksheet.png',
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
                                                          module.offlineTab ==
                                                                  true
                                                              ? Colors.black
                                                              : Colors.black26),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Consumer<
                                            StudNotificationCountProviders>(
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
                                                                        NetworkImage(
                                                                      'https://gj-eschool-files-public.s3.amazonaws.com/mobileapp/assets/anecdotal.png',
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
                                                                color: Colors
                                                                    .black),
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  : badges.Badge(
                                                      showBadge:
                                                          count.anecdotalCount ==
                                                                  0
                                                              ? false
                                                              : true,
                                                      badgeAnimation: const badges
                                                          .BadgeAnimation.rotation(
                                                        animationDuration:
                                                            Duration(
                                                                seconds: 1),
                                                        colorChangeAnimationDuration:
                                                            Duration(
                                                                seconds: 1),
                                                        loopAnimation: false,
                                                        curve: Curves
                                                            .fastOutSlowIn,
                                                        colorChangeAnimationCurve:
                                                            Curves.easeInCubic,
                                                      ),
                                                      position:
                                                          badges.BadgePosition
                                                              .topEnd(end: 9),
                                                      badgeContent: Text(
                                                        count.anecdotalCount ==
                                                                null
                                                            ? ''
                                                            : count
                                                                .anecdotalCount
                                                                .toString(),
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      child: GestureDetector(
                                                        onTap: () async {
                                                          module.curiculam ==
                                                                  true
                                                              ? await Navigator
                                                                  .push(
                                                                      context,
                                                                      PageTransition(
                                                                        type: PageTransitionType
                                                                            .rightToLeft,
                                                                        child:
                                                                            const AnecDotal(),
                                                                        duration:
                                                                            const Duration(milliseconds: 300),
                                                                      ))
                                                              : _noAcess();
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
                                                                        opacity: module.curiculam ==
                                                                                true
                                                                            ? 20
                                                                            : 0.2,
                                                                        image:
                                                                            const NetworkImage(
                                                                          'https://gj-eschool-files-public.s3.amazonaws.com/mobileapp/assets/anecdotal.png',
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
                                                                    fontSize:
                                                                        11,
                                                                    color: module.curiculam ==
                                                                            true
                                                                        ? Colors
                                                                            .black
                                                                        : Colors
                                                                            .black26),
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
                                ),
                              ),
                            ),
                            kheight10,

                            ////////////////////// Start of Third Row //////////////////////////
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
                                        Consumer<IconClickNotifier>(
                                          builder: (context, iconClickNotifier, child) =>
                                              Consumer<Curriculamprovider>(
                                                builder: (context, curri, child) =>
                                                    Consumer<StudNotificationCountProviders>(
                                                builder: (context, count, child) =>
                                                    badges.Badge(
                                                        showBadge: count.portionCount ==
                                                            0 ||
                                                            count.portionCount == null
                                                            ? false
                                                            : true,
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
                                                          count.portionCount == null ||
                                                              count.portionCount == 0
                                                              ? ''
                                                              : count.portionCount
                                                              .toString(),
                                                          style: const TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 10,
                                                              fontWeight:
                                                              FontWeight.bold),
                                                        ),
                                                        child:
                                                        Padding(
                                                          padding: const EdgeInsets.only(left: 10),
                                                          child: GestureDetector(
                                                            onTap: iconClickNotifier.areIconsClickable
                                                            ? () async {
                                                          // Disable all icons
                                                          iconClickNotifier.disableIcons();

                                                          // Navigate to a new page

                                                          if (module.curiculam ==
                                                              true) {
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
                                                                  type:
                                                                  PageTransitionType
                                                                      .rightToLeft,
                                                                  child:
                                                                  //HomeWorkInbox(),

                                                                  const PortionView(),
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
                                                                        NetworkImage(
                                                                          'https://gj-eschool-files-public.s3.amazonaws.com/mobileapp/assets/PortionEntryReport.png',
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              kheight,
                                                              const Text(
                                                                'Portion',
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
                                                                                                              ),
                                                        )
                                                    ),
                                              ),
                                              ),
                                        ), //portion_new

                                        Consumer<IconClickNotifier>(
                                          builder: (context, iconClickNotifier, child) =>
                                              Consumer<Curriculamprovider>(
                                                builder: (context, curri, child) =>
                                                    Consumer<StudNotificationCountProviders>(
                                                      builder: (context, count, child) =>
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
                                                                            NetworkImage(
                                                                              'https://gj-eschool-files-public.s3.amazonaws.com/mobileapp/assets/Curriculum.png',
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  kheight,
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
                                        ), //e-classroom_new

                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: GestureDetector(
                                            onTap: () async {
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
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Container(
                                                      height: 38,
                                                      width: 38,
                                                      decoration: BoxDecoration(
                                                        image:
                                                            const DecorationImage(
                                                          opacity: 20,
                                                          image: NetworkImage(
                                                            'https://gj-eschool-files-public.s3.amazonaws.com/mobileapp/assets/Gallery.png',
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
                            ////////////////////// End of Third Row //////////////////////////

                            ////////////////////// Start of Fourth Row //////////////////////////
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const FeedbackForm()));
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
                                                        image: DecorationImage(
                                                          opacity:
                                                              module.tabulation ==
                                                                      true
                                                                  ? 20
                                                                  : 0.2,
                                                          image: AssetImage(
                                                            'assets/feedback_entry_icon.png',
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                kheight10,
                                                Text(
                                                  'Feedback\nEntry',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 11,
                                                      color:
                                                          module.tabulation ==
                                                                  true
                                                              ? Colors.black
                                                              : Colors.black26),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Consumer<SchoolNameProvider>(
                                          builder: (context, snap, child) =>
                                              snap.allowGPSTracking == "true"
                                                  ? Expanded(
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          Navigator.push(
                                                            context,
                                                            PageTransition(
                                                              type: PageTransitionType
                                                                  .rightToLeft,
                                                              child:
                                                                  //  Profile_Info(),
                                                                  MapScreen(
                                                                imeiNumber: Provider.of<
                                                                            ProfileProvider>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .imeiNumber
                                                                    .toString(),
                                                              ),
                                                              duration:
                                                                  const Duration(
                                                                      milliseconds:
                                                                          300),
                                                            ),
                                                          );
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
                                                                        const BoxDecoration(
                                                                      image:
                                                                          DecorationImage(
                                                                        opacity:
                                                                            20,
                                                                        image:
                                                                            NetworkImage(
                                                                          'https://gj-eschool-files-public.s3.amazonaws.com/mobileapp/assets/bus-station.png',
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
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        11,
                                                                    color: Colors
                                                                        .black),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  : const SizedBox(
                                                      height: 0,
                                                      width: 0,
                                                    ),
                                        ), //bus  Tracking
                                        /////////////////////////////////   Bus End    /////////////////////////////////////////
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            kheight10,
                            ////////////////////// End of Fourth Row //////////////////////////

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
                                            type:
                                                PageTransitionType.rightToLeft,
                                            child: PasswordChange(),
                                            duration: const Duration(
                                                milliseconds: 300),
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
                                                color: Colors.black
                                                    .withOpacity(0.5),
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
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                    CupertinoDialogAction(
                                                      child: const Text(
                                                          "Logout",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: UIGuide
                                                                  .light_Purple)),
                                                      onPressed: () async {
                                                        SharedPreferences
                                                            prefs =
                                                            await SharedPreferences
                                                                .getInstance();
                                                        print(
                                                            "accesstoken  $prefs");
                                                        await prefs.remove(
                                                            "accesstoken");
                                                        print(
                                                            "username  $prefs");
                                                        await prefs
                                                            .remove("username");
                                                        print(
                                                            "password  $prefs");
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
    var size = MediaQuery.of(context).size;
    return QuickAlert.show(
      context: context,
      title: "",
      type: QuickAlertType.warning,
      text: "Sorry, you don't have access to this module",
      autoCloseDuration: const Duration(seconds: 2),
      showConfirmBtn: false,
    );
    //   showAnimatedDialog(
    //   animationType: DialogTransitionType.slideFromBottomFade,
    //   curve: Curves.fastOutSlowIn,
    //   context: context,
    //   barrierDismissible: true,
    //   builder: (BuildContext context) {
    //     return Dialog(
    //       shape: const RoundedRectangleBorder(
    //           borderRadius: BorderRadius.all(Radius.circular(10.0))),
    //       child: SizedBox(
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
    //                           style: TextStyle(),
    //                         )),
    //                     kWidth,
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
    var size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15, top: 5, bottom: 15),
      child: Consumer<ProfileProvider>(
        builder: (contex, value, child) => Container(
          height: value.bankIntegrationSettings == false ? 110 : 120,
          width: size.width,
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
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              )),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      showRoundedImageDialog(
                          context,
                          value.studPhoto == null
                              ? 'https://gj-eschool-files-public.s3.ap-south-1.amazonaws.com/ess-connect/student/avathar-02.jpeg'
                              : value.studPhoto.toString());
                    },
                    child: CircleAvatar(
                      radius: 45,
                      backgroundColor: UIGuide.WHITE,
                      backgroundImage: NetworkImage(
                        value.studPhoto == null
                            ? 'https://gj-eschool-files-public.s3.ap-south-1.amazonaws.com/ess-connect/student/avathar-02.jpeg'
                            : value.studPhoto.toString(),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      kheight10,
                      Row(
                        children: [
                          const Text(
                            'Name : ',
                            style: TextStyle(
                                color: Colors.white54,
                                fontSize: 12,
                                fontWeight: FontWeight.w700),
                          ),
                          Expanded(
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
                      kheight10,
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
                                : value.admissionNo.toString(),
                            style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                                fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            'Class : ',
                            style: TextStyle(
                                color: Colors.white54,
                                fontSize: 12,
                                fontWeight: FontWeight.w700),
                          ),
                          Expanded(
                            child: Text(
                              value.division == null
                                  ? '--'
                                  : value.division.toString(),
                              style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              studName = value.studName;
                              HapticFeedback.selectionClick();
                              var currentname = value.studName;
                              await value.siblingsAPI();
                              await _displayNameOfSiblings(contex, currentname);
                            },
                            icon: const Icon(
                              Icons.switch_account_outlined,
                              size: 30,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                      value.bankIntegrationSettings == true
                          ? Row(
                              children: [
                                Text(
                                  "${value.bankAdmissionNo}",
                                  style: const TextStyle(
                                      color: Colors.orange,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w800),
                                ),
                                const Text(
                                  "  (Only For Direct Bank Payment)",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.white70,
                                  ),
                                )
                              ],
                            )
                          : const SizedBox(
                              height: 0,
                              width: 0,
                            )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _displayNameOfSiblings(BuildContext context, String? name) async {
    var size = MediaQuery.of(context).size;
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0))),
          child: Consumer<SibingsProvider>(builder: (context, value, _) {
            return Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: UIGuide.light_Purple, width: 2),
                      borderRadius: BorderRadius.circular(32)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      kheight20,
                      kheight10,
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: siblinggResponse == null
                            ? 0
                            : siblinggResponse!.length,
                        itemBuilder: (context, index) {
                          bool same = false;
                          studName == siblinggResponse![index]['name']
                              ? same = true
                              : same = false;
                          print(studName);
                          print(siblinggResponse![index]['name']);

                          return ListTile(
                            focusColor: UIGuide.light_Purple,
                            hoverColor: UIGuide.light_Purple,
                            selectedTileColor: UIGuide.THEME_LIGHT,
                            selectedColor: UIGuide.THEME_LIGHT,
                            selected: same,
                            onTap: value.loading
                                ? null
                                : () async {
                                    var idd =
                                        siblinggResponse![index]['id'] == null
                                            ? '--'
                                            : siblinggResponse![index]['id']
                                                .toString();

                                    await value.getSibling(context, idd);
                                    // await Navigator.pushAndRemoveUntil(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) => StudentHome()),
                                    //       (Route<dynamic> route) => false,
                                    // );
                                  },
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                kheight20,
                                Center(
                                    child: Text(
                                  siblinggResponse![index]['name'] == null
                                      ? '--'
                                      : siblinggResponse![index]['name']
                                          .toString(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: UIGuide.light_Purple,
                                      fontSize: 16),
                                )),
                                kheight20,
                              ],
                            ),
                          );
                        },
                      ),
                      kheight20
                    ],
                  ),
                ),
                Positioned(
                  left: 60,
                  right: 60,
                  top: -80,
                  child: Center(
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.white,
                      child: LottieBuilder.asset(
                        'assets/lf30_editor_4qdhnu8u.json',
                      ),
                    ),
                  ),
                ),
                if (value.loading)
                  SizedBox(
                      height: 200,
                      width: size.width * 0.8,
                      child: Center(child: spinkitLoader())),
              ],
            );
          }),
        );
      },
    );

    //   showAnimatedDialog(
    //   context: context,
    //   barrierDismissible: true,
    //   builder: (BuildContext context) {
    //     return Dialog(
    //       shape: const RoundedRectangleBorder(
    //           borderRadius: BorderRadius.all(Radius.circular(32.0))),
    //       child: Consumer<SibingsProvider>(builder: (context, value, _) {
    //         return Stack(
    //           clipBehavior: Clip.none,
    //           children: [
    //             Container(
    //               decoration: BoxDecoration(
    //                   border: Border.all(color: UIGuide.light_Purple, width: 2),
    //                   borderRadius: BorderRadius.circular(32)),
    //               child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 mainAxisAlignment: MainAxisAlignment.start,
    //                 mainAxisSize: MainAxisSize.min,
    //                 children: [
    //                   ListView.builder(
    //                     shrinkWrap: true,
    //                     itemCount: siblinggResponse == null
    //                         ? 0
    //                         : siblinggResponse!.length,
    //                     itemBuilder: (context, index) {
    //                       bool same = false;
    //                       studName == siblinggResponse![index]['name']
    //                           ? same = true
    //                           : same = false;
    //                       print(studName);
    //                       print(siblinggResponse![index]['name']);
    //
    //                       return ListTile(
    //                         focusColor: UIGuide.light_Purple,
    //                         hoverColor: UIGuide.light_Purple,
    //                         selectedTileColor: UIGuide.THEME_LIGHT,
    //                         selectedColor: UIGuide.THEME_LIGHT,
    //                         selected: same,
    //                         onTap: value.loading
    //                             ? null
    //                             : () async {
    //
    //                           var idd = siblinggResponse![index]['id'] == null
    //                               ? '--'
    //                               : siblinggResponse![index]['id'].toString();
    //
    //                           await value.getSibling(context, idd);
    //                           await Navigator.pushAndRemoveUntil(
    //                             context,
    //                             MaterialPageRoute(
    //                                 builder: (context) => StudentHome()),
    //                                 (Route<dynamic> route) => false,
    //                           );
    //                         },
    //                         title: Column(
    //                           crossAxisAlignment: CrossAxisAlignment.start,
    //                           mainAxisAlignment: MainAxisAlignment.start,
    //                           children: [
    //                             kheight20,
    //                             Center(
    //                                 child: Text(
    //                                   siblinggResponse![index]['name'] == null
    //                                       ? '--'
    //                                       : siblinggResponse![index]['name']
    //                                       .toString(),
    //                                   textAlign: TextAlign.center,
    //                                   style: const TextStyle(
    //                                       color: UIGuide.light_Purple,
    //                                       fontSize: 16),
    //                                 )
    //                             ),
    //                             kheight20,
    //                           ],
    //                         ),
    //                       );
    //                     },
    //                   ),
    //                   kheight20
    //                 ],
    //               ),
    //             ),
    //             Positioned(
    //               left: 60,
    //               right: 60,
    //               top: -80,
    //               child: Center(
    //                 child: CircleAvatar(
    //                   radius: 60,
    //                   backgroundColor: Colors.white,
    //                   child: LottieBuilder.asset(
    //                     'assets/lf30_editor_4qdhnu8u.json',
    //                   ),
    //                 ),
    //               ),
    //             ),
    //             if (value.loading)
    //               SizedBox(height:200,width:size.width*0.8,
    //         child: Center(child: spinkitLoader())),
    //           ],
    //         );
    //       }),
    //     );
    //   },
    // );
  }

  void showRoundedImageDialog(BuildContext context, String studPhoto) {
    showDialog(
      barrierColor: const Color.fromARGB(202, 0, 0, 0),
      context: context,
      builder: (context) {
        return Center(
          child: Dialog(
            shape: const CircleBorder(),
            child: Container(
                width: 200.0,
                height: 200.0,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.contain, image: NetworkImage(studPhoto)))),

            // CircleAvatar(
            //   radius: 100,
            //   backgroundImage: NetworkImage(studPhoto),
            // ),
          ),
        );
      },
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
    return Consumer<ProfileProvider>(
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
                    child: InfiniteMarquee(
                      itemBuilder: (BuildContext context, int index) {
                        return Text(
                          value.flashnews == null || value.flashnews == ''
                              ? '-----'
                              : "${value.flashnews.toString()}  *  ",
                          style: TextStyle(fontSize: 12),
                        );
                      },
                    )),
          );
        }
      },
    );
  }
}

class IconClickNotifier extends ChangeNotifier {
  bool _areIconsClickable = true;

  bool get areIconsClickable => _areIconsClickable;

  void disableIcons() {
    _areIconsClickable = false;
    notifyListeners();
  }

  void enableIcons() {
    _areIconsClickable = true;
    notifyListeners();
  }
}
