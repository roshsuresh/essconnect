import 'package:essconnect/Constants.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StudentBirthdayScreenAdmin extends StatelessWidget {
  StudentBirthdayScreenAdmin({super.key});
  bool check = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: 4,
          itemBuilder: (context, index) {
            return ListTile(
              tileColor: index.isOdd
                  ? const Color.fromARGB(255, 243, 243, 243)
                  : UIGuide.WHITE,
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                    "https://gj-eschool-files-public.s3.ap-south-1.amazonaws.com/ess-connect/student/avathar-01.jpeg"),
              ),
              title: Text(
                "akshay",
                style: TextStyle(
                    fontWeight: FontWeight.w600, color: UIGuide.light_Purple),
              ),
              subtitle: Row(
                children: [
                  Text("Adm no: 114"),
                  kWidth,
                  Text("Division: IV-A"),
                ],
              ),
              trailing:
                  //   viewStud.selected != null && viewStud.selected!
                  // ? SvgPicture.asset(
                  //     UIGuide.check,
                  //     color: UIGuide.light_Purple,
                  //   )
                  // :
                  SvgPicture.asset(
                UIGuide.notcheck,
                color: UIGuide.light_Purple,
              ),
            );
          }),
      bottomNavigationBar: BottomAppBar(
        child: Row(children: [
          kWidth,
          Expanded(
              child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 3,
              foregroundColor: UIGuide.WHITE,
              backgroundColor: UIGuide.light_Purple,
              padding: const EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(
                    color: UIGuide.light_black,
                  )),
            ),
            onPressed: () {},
            child: Text("SMS"),
          )),
          kWidth,
          Expanded(
              child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 3,
              foregroundColor: UIGuide.WHITE,
              backgroundColor: UIGuide.light_Purple,
              padding: const EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(
                    color: UIGuide.light_black,
                  )),
            ),
            onPressed: () {},
            child: const Text("Notification"),
          )),
          kWidth
        ]),
      ),
    );
  }
}
