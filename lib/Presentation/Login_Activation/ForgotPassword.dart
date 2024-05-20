import 'package:essconnect/Application/StudentProviders/LoginProvider.dart';
import 'package:essconnect/Constants.dart';
import 'package:essconnect/Presentation/Login_Activation/Login_page.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../utils/constants.dart';
import '../../utils/spinkit.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final uname = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const LoginPage())),
        ),
        title: const Text(
          'Forgot Password',
        ),
        titleSpacing: 00.0,
        centerTitle: true,
        toolbarHeight: 60.2,
        toolbarOpacity: 0.8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
        ),
        backgroundColor: UIGuide.light_Purple,
      ),
      //   appBar: AppBar(
      //     backgroundColor: Colors.white,
      //     automaticallyImplyLeading: true,
      //     leading: IconButton(
      //       icon: Icon(Icons.arrow_back),
      //       color: Colors.black38,
      //       onPressed: () =>Navigator.pushReplacement(
      // context,
      // MaterialPageRoute(
      // builder: (BuildContext context) => LoginPage())),
      //     ),
      //   ),
      body: Consumer<LoginProvider>(builder: (_, value, child) {
        return Container(
          padding: const EdgeInsets.only(top: 60, left: 40, right: 40),
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      LottieBuilder.network(
                          'https://assets7.lottiefiles.com/packages/lf20_xvrofzfk.json'),
                      const SizedBox(
                        height: 30,
                      ),
                      kheight20
                    ],
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: SizedBox(
                            height: 80,
                            child: TextFormField(
                              cursorColor: UIGuide.light_Purple,
                              controller: uname,
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
                                labelStyle: const TextStyle(
                                    color: UIGuide.light_Purple),
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
                                  return 'Please Enter Your Username';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        value.load
                            ? spinkitLoader()
                            : Container(
                                height: 40,
                                width: size.width / 2,
                                alignment: Alignment.centerLeft,
                                decoration: const BoxDecoration(
                                  color: UIGuide.light_Purple,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                ),
                                child: SizedBox.expand(
                                  child: SizedBox(
                                    height: 30,
                                    width: size.width / 2.5,
                                    child: MaterialButton(
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15.0))),
                                        color: UIGuide.light_Purple,
                                        onPressed: () async {
                                          // value.loading
                                          //     ? spinkitLoader()
                                          //     : await
                                          // value.forgotPassword(context, uname.text);
                                          if (_formKey.currentState!
                                              .validate()) {
                                            value.forgotPassword(
                                                context, uname.text);
                                          } else {
                                            print("Enter Your Username");
                                          }
                                        },
                                        child: const Text(
                                          'Reset Password',
                                          style: TextStyle(color: Colors.white),
                                        )),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        );
      }),
    );
  }
}
