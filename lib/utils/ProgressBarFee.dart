import 'package:essconnect/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ProgressBarFee extends StatelessWidget {
  const ProgressBarFee({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: SizedBox(
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '𝐏𝐥𝐞𝐚𝐬𝐞 𝐖𝐚𝐢𝐭   ',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: UIGuide.light_Purple),
          ),
          SpinKitCircle(
            color: UIGuide.light_Purple,
            size: 50,
          )
        ],
      ),
    ));
  }
}
