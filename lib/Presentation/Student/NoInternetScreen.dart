import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoInternetConnection extends StatelessWidget {
  const NoInternetConnection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Center(
        child: LottieBuilder.asset(
      'assets/no internet.json',
      height: size.height / 2,
      width: size.width / 1.2,
      fit: BoxFit.fill,
    ));
  }
}
