import 'package:essconnect/Application/Module%20Providers.dart/MobileAppCheckin.dart';
import 'package:essconnect/utils/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rect_getter/rect_getter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Application/StudentProviders/LoginProvider.dart';
import '../../Constants.dart';
import '../../Utils.dart';
import '../../utils/constants.dart';
import 'Login_page.dart';

class ActivatePage extends StatefulWidget {
  const ActivatePage({Key? key}) : super(key: key);

  @override
  _ActivatePageState createState() => _ActivatePageState();
}

class _ActivatePageState extends State<ActivatePage>
    with SingleTickerProviderStateMixin {
  _saveSession(String subDomain) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('baseUrl', subDomain);
    await prefs.setBool('activated', true);
  }

  showBottomDialogSchool() {
    showModalBottomSheet(
        context: context,
        isDismissible: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        builder: (_) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Consumer<LoginProvider>(
                  builder: (_, provider, child) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Welcome",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                decorationThickness: 5),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              provider.schoolName,
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  overflow: TextOverflow.fade),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                                _saveSession(provider.subDomain);
                                _onTap();
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    color: UIGuide.light_Purple,
                                    borderRadius: BorderRadius.circular(15)),
                                child: const Center(
                                  child: Text(
                                    'Continue',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 16),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        });
  }

  //for button tap animations
  late AnimationController sizeAnimationController;
  late Animation<double> sizeAnimation;
  bool isLoading = false;
  void sizeAnimationOnTap() {
    sizeAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    // sizeAnimation=TweenSequence(items)

    sizeAnimation = TweenSequence<double>(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 10, end: 20)
              .chain(CurveTween(curve: Curves.ease)),
          weight: 40.0,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 20, end: 10)
              .chain(CurveTween(curve: Curves.ease)),
          weight: 40.0,
        ),
      ],
    ).animate(sizeAnimationController);
  }

  var rectGetterKey = RectGetter.createGlobalKey(); //<--Create a key
  Rect? rect;
  final Duration animationDuration = const Duration(milliseconds: 350);
  final Duration delay = const Duration(milliseconds: 300);
  final secretKeyController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  void _onTap() {
    //-->function for ripple animation transition
    setState(() => rect = RectGetter.getRectFromKey(rectGetterKey)!); //
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //<-- on the next frame...
      setState(() => rect = rect!.inflate(1.3 *
          MediaQuery.of(context).size.longestSide)); //<-- set rect to be big
      Future.delayed(animationDuration + delay,
          _goToNextPage); //<-- after delay, go to next page
    }); // <--onTap, update rect
    // Navigator.of(context).push(FadeRouteBuilder(page: LoginPage()));
  }

  Future<void> _goToNextPage() async {
    //-->function for navigation

    // SharedPreferences _pref = await SharedPreferences.getInstance();

    // Navigator.of(context)
    //     .push(FadeRouteBuilder(page: LoginPageWeb()))
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (BuildContext context) {
      return const LoginPage();
    }));
    // .then((_) => setState(() => rect = null));
  }

  @override
  void initState() {
    //_checkSession();
    sizeAnimationOnTap();
    super.initState();
  }

  @override
  void dispose() {
    sizeAnimationController.dispose();

    super.dispose();
  }

  bool _isObscure = false;

  final _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: false,
          body: isLoading
              ? Container(
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Stack(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/activation_page.jpg"),
                              fit: BoxFit.fill)),
                    ),
                    Positioned(
                      // bottom: 200,
                      left: 10,
                      right: 10,
                      bottom: size.height / 4.5,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 30.0, right: 30),
                              child: TextFormField(
                                obscureText: !_isObscure,
                                cursorColor: UIGuide.light_Purple,
                                controller: secretKeyController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your Activation Key';
                                  }
                                  return null;
                                },
                                style: const TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                    labelStyle: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400),
                                    label: Text(
                                      "School Code",
                                      style: TextStyle(
                                          color: Colors.grey.shade600),
                                    ),
                                    prefixIcon: const Icon(
                                      Icons.key_outlined,
                                      color: UIGuide.light_Purple,
                                    ),
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
                                    filled: true,
                                    fillColor: Colors.white,
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: const BorderSide(
                                            color: UIGuide.WHITE)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: const BorderSide(
                                            color: UIGuide.WHITE)),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: const BorderSide(
                                            color: UIGuide.WHITE))),
                                obscuringCharacter: "*",
                              ),
                            ),
                            kheight20,
                            Consumer<LoginProvider>(
                              builder: (context, loginn, child) => loginn
                                      .loading
                                  ? spinkitLoader()
                                  : RectGetter(
                                      key: rectGetterKey,
                                      child: Consumer<MobileAppCheckinProvider>(
                                        builder: (context, checkk, child) =>
                                            InkWell(
                                          splashColor: UIGuide.light_black,
                                          onTap: () async {
                                            sizeAnimationController.forward();
                                            FocusScope.of(context)
                                                .requestFocus(FocusNode());
                                            if (_formKey.currentState!
                                                .validate()) {
                                              _formKey.currentState!.save();
                                              setState(() {
                                                isLoading = false;
                                              });
                                              int statusCode = await Provider
                                                      .of<LoginProvider>(
                                                          context,
                                                          listen: false)
                                                  .getActivation(
                                                      secretKeyController.text);
                                              if (statusCode == 200) {
                                                print(statusCode);
                                                String schlId =
                                                    loginn.schoolid == null
                                                        ? '--'
                                                        : loginn.schoolid
                                                            .toString();
                                                await checkk.getMobile(schlId);
                                                if (checkk.existapp == true) {
                                                  print(
                                                      "------------------------------IsMobileAppChecked---------------------------");
                                                  setState(() {
                                                    isLoading = false;
                                                    showBottomDialogSchool();
                                                  });
                                                } else {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    const SnackBar(
                                                      elevation: 10,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10)),
                                                      ),
                                                      duration:
                                                          Duration(seconds: 1),
                                                      margin: EdgeInsets.only(
                                                          bottom: 80,
                                                          left: 30,
                                                          right: 30),
                                                      behavior: SnackBarBehavior
                                                          .floating,
                                                      content: Text(
                                                        'You have no Privilege \nPlease contact your School...',
                                                        style: TextStyle(
                                                            fontSize: 16),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                  );
                                                }
                                                //Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPageWeb()));
                                              } else {
                                                return scaff();
                                                // setState(() {
                                                //   isLoading = false;
                                                // });
                                                // ScaffoldMessenger.of(context)
                                                //     .showSnackBar(
                                                //   const SnackBar(
                                                //     backgroundColor:
                                                //         Colors.white,
                                                //     elevation: 10,
                                                //     shape:
                                                //         RoundedRectangleBorder(
                                                //       borderRadius:
                                                //           BorderRadius.all(
                                                //               Radius.circular(
                                                //                   10)),
                                                //     ),
                                                //     duration:
                                                //         Duration(seconds: 1),
                                                //     margin: EdgeInsets.only(
                                                //         bottom: 180,
                                                //         left: 30,
                                                //         right: 30),
                                                //     behavior: SnackBarBehavior
                                                //         .floating,
                                                //     content: Text(
                                                //       'Invalid School Code',
                                                //       textAlign:
                                                //           TextAlign.center,
                                                //       style: TextStyle(
                                                //           color: Colors.red,
                                                //           fontWeight:
                                                //               FontWeight.bold,
                                                //           fontSize: 15),
                                                //     ),
                                                //   ),
                                                // );
                                              }
                                            } else {
                                              return;
                                            }
                                          },
                                          child: AnimatedBuilder(
                                            animation: sizeAnimation,
                                            builder: (BuildContext context,
                                                Widget? child) {
                                              print(
                                                  '${(width * 0.4) + sizeAnimation.value} size animation');
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(18.0),
                                                child: Container(
                                                  width: 60,
                                                  height: 60,
                                                  decoration:
                                                      const BoxDecoration(
                                                          // borderRadius:
                                                          //     BorderRadius.circular(10),
                                                          image: DecorationImage(
                                                              image: AssetImage(
                                                                  'assets/submitButton.png'),
                                                              fit:
                                                                  BoxFit.fill)),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        height: 40,
                        width: size.width,
                        decoration: const BoxDecoration(color: Colors.white24),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Powered by  ',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 92, 92, 92)),
                            ),
                            Text(
                              '𝗚𝗝 𝗜𝗡𝗙𝗢𝗧𝗘𝗖𝗛 (𝗣) 𝗟𝗧𝗗.',
                              style: TextStyle(
                                  fontSize: 19,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
        ),
        rect == null ? Container() : ripple(context, animationDuration, rect)
      ],
    );
  }

  scaff() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.white,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        duration: Duration(seconds: 1),
        margin: EdgeInsets.only(bottom: 180, left: 30, right: 30),
        behavior: SnackBarBehavior.floating,
        content: Text(
          'Invalid School Code',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.red, fontWeight: FontWeight.bold, fontSize: 15),
        ),
      ),
    );
  }
}
