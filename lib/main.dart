import 'dart:async';
import 'dart:core';
import 'dart:io';
import 'package:essconnect/Application/StudentProviders/TokenCheckProviders.dart';
import 'package:essconnect/Presentation/ChildLogin/ChildHomeScreen.dart';
import 'package:essconnect/Presentation/SchoolHead/SchoolHeadHome.dart';
import 'package:essconnect/Presentation/SchoolSuperAdmin/SuperAdminHome.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Application/StudentProviders/LoginProvider.dart';
import 'Constants.dart';
import 'Firebase_options.dart';
import 'Presentation/Admin/AdminHome.dart';
import 'Presentation/Login_Activation/ActivatePage.dart';
import 'Presentation/Login_Activation/Login_page.dart';
import 'Presentation/Staff/StaffHome.dart';
import 'Presentation/StaffAsGuardian.dart/StaffHomeScreen.dart';
import 'Presentation/Student/Student_home.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  RemoteNotification? notification = message.notification;
  print('Handling a background message ${message.messageId}');

  flutterLocalNotificationsPlugin?.show(
    notification.hashCode,
    notification!.title,
    notification.body,
    NotificationDetails(
        android: AndroidNotificationDetails(channel!.id, channel!.name,
            icon: '@mipmap/ic_launcher', channelShowBadge: true),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
        )),
  );
}

AndroidNotificationChannel? channel;
FirebaseMessaging? _messaging;
FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  _messaging = FirebaseMessaging.instance;
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  await FlutterDownloader.initialize(debug: true, ignoreSsl: true);
  NotificationSettings settings = await _messaging!.requestPermission(
      alert: true, badge: true, provisional: true, sound: true);

  if (Platform.isIOS) {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);
  }
  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
      'offer_notification_channel', // id
      'offer notification channel', // 1

      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin!
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel!);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
  if (Platform.isAndroid) {
    // await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
  }
  if (Platform.isAndroid) {
    //await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
  }
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(GjInfoTech()));

// await FlutterDownloader.initialize(debug: true);
  //await Permission.storage.request();
  // await Permission.videos.request();

  // await Permission.photos.request();
  await Permission.notification.request();
  // await Permission.manageExternalStorage.request();
  //
  await Permission.storage.request();
  await Permission.accessMediaLocation.request();
  runApp(setupProviders(GjInfoTech()));
}

Widget setupProviders(Widget child) {
  return MultiProvider(
    providers:getProviders(),
    child: child,
  );
}

class GjInfoTech extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<GjInfoTech> createState() => _GjInfoTechState();
}

class _GjInfoTechState extends State<GjInfoTech> {
  late SharedPreferences prefs;
  _checkSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getBool('activated') != null) {

      activated = true;
    }
  }

  late bool activated;

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (prefs.getBool('activated') != null) {
        activated = true;
      }
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin!.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
              android: AndroidNotificationDetails(
                channel!.id,
                channel!.name,
                icon: '@mipmap/ic_launcher',
                playSound: true,
              ),
              iOS: DarwinNotificationDetails(
                presentAlert: true,
                badgeNumber: 1,
                presentSound: true,
                subtitle: notification.body,
                threadIdentifier: notification.title,
              )),
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:  getProviders(),
      child: GetMaterialApp(
        title: 'e-SS Connect',
        themeMode: ThemeMode.light,
        theme: ThemeData(

          useMaterial3: false,
          textTheme: const TextTheme(
            displayLarge: TextStyle(fontSize: 14),
            bodyLarge: TextStyle(fontSize: 14.0),
            bodyMedium: TextStyle(fontSize: 14.0),
            labelLarge: TextStyle(fontSize: 14.0),
            headlineLarge: TextStyle(fontSize: 14),
            headlineSmall: TextStyle(fontSize: 14),
          ),
          colorScheme: ColorScheme.fromSwatch(
            accentColor: const Color.fromARGB(255, 219, 235, 250),
          ),
          primaryColor: UIGuide.light_Purple,

          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: UIGuide.light_Purple,
            selectionColor: Color.fromARGB(255, 211, 225, 238),
            selectionHandleColor: Colors.transparent,
          ),
          inputDecorationTheme: InputDecorationTheme(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.black))),
        ),
        home: SplashFuturePage(),
        debugShowCheckedModeBanner: false,
        //debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class SplashFuturePage extends StatefulWidget {
  SplashFuturePage({Key? key}) : super(key: key);

  @override
  State<SplashFuturePage> createState() => _SplashFuturePageState();
}

class _SplashFuturePageState extends State<SplashFuturePage>
    with TickerProviderStateMixin {
  double _fontSize = 2;
  double _containerSize = 1.5;
  double _textOpacity = 0.0;
  double _containerOpacity = 0.0;
  Timer? _timer;
  late AnimationController _controller;
  late Animation<double> animation1;

  Future _checkSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getBool('activated') != null) {
      if (prefs.getString('accesstoken') != null) {
        var data = await parseJWT();
        List<dynamic> roleList = [];
        print(data['role'] is List);
        if (data['role'] is List) {
          roleList = await data['role'];
          print(roleList);
        }
        if (data['role'] == "SystemAdmin" || roleList.contains("SystemAdmin")) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const AdminHome()),
          );
        } else if (data['role'] == "Guardian") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => StudentHome()),
          );
        } else if (data['role'] == "Teacher" ||
            data['role'] == "NonTeachingStaff") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => StaffHome()),
          );
        } else if ((roleList.contains("Guardian") &&
                roleList.contains("Teacher")) ||
            (roleList.contains("NonTeachingStaff") &&
                roleList.contains("Guardian"))) {
          await Permission.videos.request();
          await Permission.photos.request();
          await Future.delayed(const Duration(seconds: 3));

          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => StaffHomeScreen()));
        } else if (data['role'] == "SchoolSuperAdmin" ||
            roleList.contains("SchoolSuperAdmin")) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const SuperAdminHome()),
          );
        } else if (data['role'] == "SchoolHead") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const SchoolHeadHomeScreen()),
          );
        } else if (data['role'] == "Student") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ChildHome()),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        }
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      }
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ActivatePage()),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));

    animation1 = Tween<double>(begin: 40, end: 20).animate(CurvedAnimation(
        parent: _controller, curve: Curves.fastLinearToSlowEaseIn))
      ..addListener(() {
        setState(() {
          _textOpacity = 1.0;
        });
      });

    _controller.forward();

    Timer(const Duration(seconds: 2), () {

        _fontSize = 1.06;

    });

    Timer(const Duration(seconds: 2), () {

        _containerSize = 2;
        _containerOpacity = 1;

    });

    // Timer(const Duration(seconds: 3), () async {
    //   await Provider.of<TokenExpiryCheckProviders>(context, listen: false)
    //       .checkTokenExpired(context);
    //
    //   //democode 20-02-2024
    //   await Provider.of<LoginProvider>(context, listen: false)
    //       .getToken(context);
    //   await Provider.of<LoginProvider>(context, listen: false)
    //       .getMobileViewerId();
    //   await Provider.of<LoginProvider>(context, listen: false)
    //       .getsavemobileViewer(context);
    //   await Provider.of<LoginProvider>(context, listen: false)
    //       .sendUserDetails(context);
    //
    //   await _checkSession();
    // }
    //
    // );
  }
  void _startTimer() {
    _timer = Timer(const Duration(seconds: 3), _handleTimer);
  }
  Future<void> _handleTimer() async {
    if (!mounted) return;

    await Provider.of<TokenExpiryCheckProviders>(context, listen: false)
        .checkTokenExpired(context);
    await Provider.of<LoginProvider>(context, listen: false).getToken(context);

    // if (!mounted) return;
    // await Provider.of<LoginProvider>(context, listen: false).getMobileViewerId();
    //
    // if (!mounted) return;
    // await Provider.of<LoginProvider>(context, listen: false).getsavemobileViewer(context);
    //
    // if (!mounted) return;
    // await Provider.of<LoginProvider>(context, listen: false).sendUserDetails(context);

    if (!mounted) return;
    await _checkSession();
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: UIGuide.THEME_LIGHT,
      body: Stack(
        children: [
          Column(
            children: [
              AnimatedContainer(
                  duration: const Duration(milliseconds: 2000),
                  curve: Curves.fastLinearToSlowEaseIn,
                  height: _height / _fontSize),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 1000),
                opacity: _textOpacity,
                child: Text(
                  'e-SS Connect',
                  style: TextStyle(
                    color: UIGuide.light_Purple,
                    fontWeight: FontWeight.bold,
                    fontSize: animation1.value,
                  ),
                ),
              ),
            ],
          ),
          Center(
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 2000),
              curve: Curves.fastLinearToSlowEaseIn,
              opacity: _containerOpacity,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 2000),
                curve: Curves.fastLinearToSlowEaseIn,
                height: _width / _containerSize,
                width: _width / _containerSize,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                    30,
                  ),
                ),
                child: Image.asset('assets/ESS-logo.png'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PageTransition extends PageRouteBuilder {
  final Widget page;

  PageTransition(this.page)
      : super(
          pageBuilder: (context, animation, anotherAnimation) => page,
          transitionDuration: const Duration(milliseconds: 2000),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
              curve: Curves.fastLinearToSlowEaseIn,
              parent: animation,
            );
            return Align(
              alignment: Alignment.bottomCenter,
              child: SizeTransition(
                sizeFactor: animation,
                child: page,
                axisAlignment: 0,
              ),
            );
          },
        );
}
