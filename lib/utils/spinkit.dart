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
