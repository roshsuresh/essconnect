import 'dart:async';
import 'package:animate_gradient/animate_gradient.dart';
import 'package:essconnect/Constants.dart';
import 'package:essconnect/Presentation/Login_Activation/ForgotPassword.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Application/StudentProviders/LoginProvider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  late AnimationController controller1;
  late AnimationController controller2;
  late Animation<double> animation1;
  late Animation<double> animation2;
  late Animation<double> animation3;
  late Animation<double> animation4;

  @override
  void initState() {
    super.initState();

    controller1 = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 5,
      ),
    );
    animation1 = Tween<double>(begin: .1, end: .15).animate(
      CurvedAnimation(
        parent: controller1,
        curve: Curves.easeInOut,
      ),
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller1.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller1.forward();
        }
      });
    animation2 = Tween<double>(begin: .02, end: .06).animate(
      CurvedAnimation(
        parent: controller1,
        curve: Curves.easeInOut,
      ),
    )..addListener(() {
        setState(() {});
      });

    controller2 = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 5,
      ),
    );
    animation3 = Tween<double>(begin: .41, end: .38).animate(CurvedAnimation(
      parent: controller2,
      curve: Curves.easeInOut,
    ))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller2.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller2.forward();
        }
      });
    animation4 = Tween<double>(begin: 170, end: 190).animate(
      CurvedAnimation(
        parent: controller2,
        curve: Curves.easeInOut,
      ),
    )..addListener(() {
        setState(() {});
      });

    Timer(const Duration(milliseconds: 2500), () {
      controller1.forward();
    });

    controller2.forward();
  }

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    super.dispose();
  }

  bool _isObscure = false;

  final _formKey = GlobalKey<FormState>();
  final _username = TextEditingController();
  final _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 243, 243),
      // backgroundColor: Color.fromARGB(255, 211, 228, 245),
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child: SizedBox(
            height: size.height,
            child: AnimateGradient(
              primaryColors: const [
                Color.fromARGB(255, 109, 173, 233),
                Color.fromARGB(255, 255, 255, 255),
                Color.fromARGB(255, 255, 255, 255),
              ],
              secondaryColors: const [
                Color.fromARGB(255, 255, 255, 255),
                Color.fromARGB(255, 255, 255, 255),
                Color.fromARGB(255, 109, 173, 233),
              ],
              child: Stack(
                children: [
                  Positioned(
                    top: size.height * (animation2.value + .25),
                    left: size.width * .75,
                    child: CustomPaint(
                      painter: MyPainter(35),
                    ),
                  ),
                  Positioned(
                    top: size.height * .98,
                    left: size.width * .1,
                    child: CustomPaint(
                      painter: MyPainter(animation4.value - 55),
                    ),
                  ),
                  Positioned(
                    top: size.height * .12,
                    left: size.width * .95,
                    child: CustomPaint(
                      painter: MyPainter(animation4.value - 90),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 30.0, right: 30),
                          child: TextFormField(
                            cursorColor: UIGuide.light_Purple,
                            controller: _username,
                            decoration: InputDecoration(
                              focusColor: UIGuide.light_Purple,
                              prefixIcon: const Icon(
                                Icons.person_outline_outlined,
                                color: UIGuide.light_Purple,
                              ),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    style: BorderStyle.solid,
                                    color: UIGuide.light_Purple,
                                    width: 1.0),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: UIGuide.light_Purple, width: 1),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              fillColor:
                                  const Color.fromARGB(255, 255, 255, 255),
                              hintText: "Enter Your Username",
                              hintStyle: const TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                                fontFamily: "verdana_regular",
                                fontWeight: FontWeight.w400,
                              ),
                              labelText: 'Username',
                              labelStyle:
                                  const TextStyle(color: UIGuide.light_Purple),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: const BorderSide(
                                  color: UIGuide.light_Purple,
                                  width: 1,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your Username';
                              }
                              return null;
                            },
                          ),
                        ),
                        kheight20,
                        Padding(
                          padding: const EdgeInsets.only(left: 30.0, right: 30),
                          child: TextFormField(
                            cursorColor: UIGuide.light_Purple,
                            obscureText: !_isObscure,
                            controller: _password,
                            decoration: InputDecoration(
                              focusColor:
                                  const Color.fromARGB(255, 255, 255, 255),
                              prefixIcon: const Icon(
                                Icons.password_sharp,
                                color: UIGuide.light_Purple,
                              ),
                              // errorText: "Please enter valid username",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: UIGuide.light_Purple, width: 1.0),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              fillColor: Colors.grey,
                              hintText: "Enter Your Password",
                              hintStyle: const TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                                fontFamily: "verdana_regular",
                                fontWeight: FontWeight.w400,
                              ),
                              labelText: 'Password',
                              labelStyle:
                                  const TextStyle(color: UIGuide.light_Purple),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isObscure
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: UIGuide.light_Purple,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isObscure = !_isObscure;
                                  });
                                },
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: const BorderSide(
                                  color: UIGuide.light_Purple,
                                  width: 1.0,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                          ),
                        ),
                        kheight20,
                        Consumer<LoginProvider>(
                          builder: (context, val, _) => Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 45,
                                width: size.width / 2.5,
                                child: val.loadingLogin
                                    ? const Center(
                                        child: CircularProgressIndicator(
                                          color: UIGuide.light_Purple,
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : Container(
                                        decoration: BoxDecoration(
                                            borderRadius: const BorderRadius.all(
                                                Radius.circular(15.0)),
                                            border: Border.all(
                                                color: UIGuide.light_Purple,
                                                width: 2)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(1.0),
                                          child: MaterialButton(
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  12.0))),
                                              color: UIGuide.light_Purple,
                                              onPressed: () async {
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  val.checkLogin(
                                                      _username.text.trim(),
                                                      _password.text.trim(),
                                                      context);

                                                  print(_username);
                                                  print(_password);
                                                } else {
                                                  print("Enter some value");
                                                }
                                              },
                                              child: const Text(
                                                'LOGIN',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                        ),
                                      ),
                              ),
                            ],
                          ),
                        ),
                        kheight10,
                        Consumer<LoginProvider>(
                          builder: (context, valu, _) => InkWell(
                            splashColor: UIGuide.THEME_LIGHT,
                            onTap: valu.loadingLogin
                                ? null
                                : () async {
                                    await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const ForgotPasswordScreen()));
                                  },
                            child: const Text(
                              "Forgot Password ? ",
                              style: TextStyle(
                                  color: UIGuide.light_Purple, fontSize: 15),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // void checkLogin(String username, String password) async {
  //   SharedPreferences _pref = await SharedPreferences.getInstance();
  //   var headers = {'Content-Type': 'application/json'};
  //   var request = http.Request(
  //       'POST',
  //       Uri.parse(
  //           '${UIGuide.baseURL}/login?id=${_pref.getString('schoolId')}'));
  //   request.body = json.encode({"email": username, "password": password});
  //   print(request.body);
  //   request.headers.addAll(headers);

  //   http.StreamedResponse response = await request.send();

  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     var data = jsonDecode(await response.stream.bytesToString());
  //     LoginModel res = LoginModel.fromJson(data);
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     await prefs.setString('accesstoken', res.accessToken);
  //     SharedPreferences user = await SharedPreferences.getInstance();
  //     await user.setString('username', username);
  //     SharedPreferences pass = await SharedPreferences.getInstance();
  //     await pass.setString('password', password);

  //     await Provider.of<LoginProvider>(context, listen: false)
  //         .getToken(context);
  //     var parsedResponse = await parseJWT();
  //     List<dynamic> roleList = [];
  //     print(parsedResponse['role'] is List);
  //     if (parsedResponse['role'] is List) {
  //       roleList = await parsedResponse['role'];
  //       print(roleList);
  //     }

  //     if (parsedResponse['role'] == "Guardian") {
  //       if (isLoading) return;
  //       setState(() {
  //         isLoading = true;
  //       });
  //       await Future.delayed(const Duration(seconds: 3));

  //       await Navigator.pushReplacement(
  //           context,
  //           MaterialPageRoute(
  //               builder: (BuildContext context) => StudentHome()));
  //     } else if (parsedResponse['role'] == "SystemAdmin" ||
  //         roleList.contains("SystemAdmin")) {
  //       if (isLoading) return;
  //       setState(() {
  //         isLoading = true;
  //       });
  //       await Permission.videos.request();

  //       await Permission.photos.request();
  //       await Future.delayed(const Duration(seconds: 3));

  //       Navigator.pushReplacement(
  //           context,
  //           MaterialPageRoute(
  //               builder: (BuildContext context) => const AdminHome()));
  //     } else if (parsedResponse['role'] == "Teacher" ||
  //         parsedResponse['role'] == "NonTeachingStaff") {
  //       if (isLoading) return;
  //       setState(() {
  //         isLoading = true;
  //       });
  //       await Permission.videos.request();

  //       await Permission.photos.request();
  //       await Future.delayed(const Duration(seconds: 3));

  //       Navigator.pushReplacement(context,
  //           MaterialPageRoute(builder: (BuildContext context) => StaffHome()));
  //     } else if ((roleList.contains("Guardian") &&
  //             roleList.contains("Teacher")) ||
  //         (roleList.contains("NonTeachingStaff") &&
  //             roleList.contains("Guardian"))) {
  //       if (isLoading) return;
  //       setState(() {
  //         isLoading = true;
  //       });
  //       await Permission.videos.request();

  //       await Permission.photos.request();
  //       await Future.delayed(const Duration(seconds: 3));

  //       Navigator.pushReplacement(
  //           context,
  //           MaterialPageRoute(
  //               builder: (BuildContext context) => StaffHomeScreen()));
  //     }
  //     //SchoolSuperAdmin
  //     else if (parsedResponse['role'] == "SchoolSuperAdmin" ||
  //         roleList.contains("SchoolSuperAdmin")) {
  //       if (isLoading) return;
  //       setState(() {
  //         isLoading = true;
  //       });
  //       await Permission.videos.request();

  //       await Permission.photos.request();
  //       await Future.delayed(const Duration(seconds: 3));

  //       Navigator.pushReplacement(
  //           context,
  //           MaterialPageRoute(
  //               builder: (BuildContext context) => SuperAdminHome()));
  //     } else if (parsedResponse['role'] == "SchoolHead") {
  //       if (isLoading) return;
  //       setState(() {
  //         isLoading = true;
  //       });
  //       await Permission.videos.request();

  //       await Permission.photos.request();
  //       await Future.delayed(const Duration(seconds: 3));

  //       Navigator.pushReplacement(
  //           context,
  //           MaterialPageRoute(
  //               builder: (BuildContext context) => SchoolHeadHomeScreen()));
  //     } else if (parsedResponse['role'] == "Student") {
  //       if (isLoading) return;
  //       setState(() {
  //         isLoading = true;
  //       });
  //       await Permission.videos.request();
  //       await Permission.photos.request();
  //       await Future.delayed(const Duration(seconds: 3));
  //       Navigator.pushReplacement(context,
  //           MaterialPageRoute(builder: (BuildContext context) => ChildHome()));
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //           elevation: 10,
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.all(Radius.circular(10)),
  //           ),
  //           duration: Duration(seconds: 3),
  //           margin: EdgeInsets.only(bottom: 45, left: 30, right: 30),
  //           behavior: SnackBarBehavior.floating,
  //           content: Text(
  //             "Login credentials mismatch \n Please contact your School Admin... ",
  //             textAlign: TextAlign.center,
  //             style: TextStyle(fontSize: 16),
  //           )));
  //     }
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //         elevation: 10,
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.all(Radius.circular(10)),
  //         ),
  //         duration: Duration(seconds: 1),
  //         margin: EdgeInsets.only(bottom: 45, left: 30, right: 30),
  //         behavior: SnackBarBehavior.floating,
  //         content: Text(
  //           "Invalid Username or Password...!",
  //           textAlign: TextAlign.center,
  //         )));
  //   }
  // }
}

class MyPainter extends CustomPainter {
  final double radius;

  MyPainter(this.radius);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = const LinearGradient(colors: [
        UIGuide.light_Purple,
        UIGuide.light_Purple,
        Color.fromARGB(255, 173, 211, 245),
      ], begin: Alignment.topLeft, end: Alignment.bottomRight)
          .createShader(Rect.fromCircle(
        center: const Offset(0, 0),
        radius: radius,
      ));
    canvas.drawCircle(Offset.zero, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
