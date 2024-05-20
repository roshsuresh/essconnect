import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../Application/StudentProviders/PasswordChangeProvider.dart';
import '../../Constants.dart';
import '../../utils/constants.dart';

class PasswordChange extends StatelessWidget {
  PasswordChange({Key? key}) : super(key: key);

  final bool _isObscure = false;

  final _passwordNew = TextEditingController();

  final _password = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
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
      body: Center(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            kheight20,
            kheight10,
            Center(
              child: SizedBox(
                  height: 150,
                  width: 200,
                  child: LottieBuilder.asset('assets/vsqFXTvh4d.json')

                  // Image.network(
                  //   'https://cdn-icons-png.flaticon.com/512/6195/6195699.png',
                  //   fit: BoxFit.fill,
                  // ),
                  ),
            ),
            kheight20,
            kheight10,
            Form(
              key: _formkey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      obscureText: !_isObscure,
                      controller: _password,
                      decoration: InputDecoration(
                          focusColor: const Color.fromARGB(255, 213, 215, 218),
                          prefixIcon: const Icon(
                            Icons.key_outlined,
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: UIGuide.light_Purple, width: 1.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          fillColor: Colors.grey,
                          hintText: "Enter Your Current Password",
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontFamily: "verdana_regular",
                            fontWeight: FontWeight.w400,
                          ),
                          labelText: 'Current Password',
                          labelStyle: const TextStyle(
                            color: UIGuide.light_Purple,
                          )),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter old password';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                        obscureText: !_isObscure,
                        controller: _passwordNew,
                        decoration: InputDecoration(
                            focusColor:
                                const Color.fromARGB(255, 213, 215, 218),
                            prefixIcon: const Icon(
                              Icons.key_outlined,
                              color: Colors.grey,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: UIGuide.light_Purple, width: 1.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            fillColor: Colors.grey,
                            hintText: "Enter Your New Password",
                            hintStyle: const TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              fontFamily: "verdana_regular",
                              fontWeight: FontWeight.w400,
                            ),
                            labelText: 'New Password',
                            labelStyle: const TextStyle(
                              color: UIGuide.light_Purple,
                            )),
                        validator: (PassCurrentValue) {
                          RegExp regex = RegExp(
                              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                          var passNonNullValue = PassCurrentValue ?? "";
                          if (passNonNullValue.isEmpty) {
                            return ("Please enter New password");
                          } else if (passNonNullValue.length < 8) {
                            return ("Password Must be more than 8 characters");
                          } else if (!regex.hasMatch(passNonNullValue)) {
                            return ("Password should contain upper,lower,digit and Special character ");
                          }
                          return null;
                        }),
                  ),
                  Consumer<PasswordChangeprovider>(
                    builder: (context, value, child) => Padding(
                      padding: const EdgeInsets.all(0),
                      child: FlutterPwValidator(
                        controller: _passwordNew,
                        minLength: 8,
                        uppercaseCharCount: 1,
                        numericCharCount: 1,
                        specialCharCount: 1,
                        normalCharCount: 3,
                        width: 300,
                        height: 120,
                        onSuccess: () {
                          print("MATCHED");
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  elevation: 10,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  duration: Duration(seconds: 1),
                                  margin: EdgeInsets.only(
                                      bottom: 80, left: 30, right: 30),
                                  behavior: SnackBarBehavior.floating,
                                  content: Text("Password is matched")));
                          value.visiblee();
                        },
                        onFail: () {
                          print("NOT MATCHED");
                        },
                      ),
                    ),
                  ),
                  kheight20,
                  const SizedBox(
                    height: 60,
                  ),
                  Consumer<PasswordChangeprovider>(
                    builder: (context, value, child) => Visibility(
                      visible: value.isVisible,
                      child: SizedBox(
                        width: 150,
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22.0)),
                          height: 50,
                          onPressed: () async {
                            String pass = _password.text.toString();
                            String newPass = _passwordNew.text.toString();
                            String confirmPass = newPass;
                            if (_formkey.currentState!.validate()) {
                              print('validated');
                              await Provider.of<PasswordChangeprovider>(context,
                                      listen: false)
                                  .checkOldPassword(pass);
                              String check =
                                  value.oldPasswordCorrect.toString();
                              print(value.oldPasswordCorrect.toString());
                              if (check.toString() == true.toString()) {
                                print('success');
                                await Provider.of<PasswordChangeprovider>(
                                        context,
                                        listen: false)
                                    .updatePassword(
                                        context, pass, newPass, confirmPass);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        elevation: 10,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        duration: Duration(seconds: 1),
                                        margin: EdgeInsets.only(
                                            bottom: 80, left: 30, right: 30),
                                        behavior: SnackBarBehavior.floating,
                                        content:
                                            Text("Incorrect Old Password")));
                              }
                            }
                            _password.clear();
                            _passwordNew.clear();
                          },
                          color: UIGuide.light_Purple,
                          child: const Text(
                            'Update',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
