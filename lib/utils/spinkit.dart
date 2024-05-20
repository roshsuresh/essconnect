import 'package:essconnect/Constants.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class spinkitLoader extends StatelessWidget {
  spinkitLoader({Key? key}) : super(key: key);
  final List<Color> _kDefaultRainbowColors = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    const Color.fromARGB(255, 0, 207, 235),
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 68,
        height: 68,
        child: LoadingIndicator(
          colors: _kDefaultRainbowColors,
          strokeWidth: 2.0,
          indicatorType: Indicator.ballRotateChase,
        ),
      ),
    );
  }
}

pleaseWaitLoader() {
  final List<Color> kDefaultRainbowColors = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    const Color.fromARGB(255, 0, 207, 235),
  ];
  return WillPopScope(
    onWillPop: () async {
      return false;
    },
    child: Container(
      color: Colors.black.withOpacity(0.2),
      child: Center(
        child: Container(
          decoration: const BoxDecoration(
              color: UIGuide.WHITE,
              borderRadius: BorderRadius.all(Radius.circular(5))),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 40,
                  height: 40,
                  child: LoadingIndicator(
                    colors: kDefaultRainbowColors,
                    strokeWidth: 5.0,
                    indicatorType: Indicator.ballRotateChase,
                  ),
                ),
                kWidth,
                const Text(
                  "Please Wait...",
                  style: TextStyle(
                      color: UIGuide.light_Purple,
                      fontWeight: FontWeight.w700,
                      fontSize: 16),
                )
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
