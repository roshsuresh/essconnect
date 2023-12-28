import 'package:essconnect/Application/AdminProviders/BirthdayListProviders.dart';
import 'package:essconnect/Constants.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:essconnect/utils/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class StaffBirthdayScreenAdmin extends StatelessWidget {
  StaffBirthdayScreenAdmin({super.key});

  bool check = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<BirthdayListProviders>(
        builder: (context, value, _) => Stack(
          children: [
            ListView.builder(
                itemCount: value.staffBirthdayList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    tileColor: index.isOdd
                        ? const Color.fromARGB(255, 243, 243, 243)
                        : UIGuide.WHITE,
                    leading: CircleAvatar(
                      backgroundColor: UIGuide.WHITE,
                      radius: 30,
                      backgroundImage: NetworkImage(value
                              .staffBirthdayList[index].staffPhoto ??
                          "https://gj-eschool-files-public.s3.ap-south-1.amazonaws.com/ess-connect/student/avathar-01.jpeg"),
                    ),
                    title: Text(
                      value.staffBirthdayList[index].staffName ?? "--",
                      style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: UIGuide.light_Purple),
                    ),
                    subtitle: Row(
                      children: [
                        Text(
                          value.staffBirthdayList[index].designation ?? "--",
                        ),
                        kWidth,
                        Text(
                          value.staffBirthdayList[index].section ?? "--",
                        ),
                      ],
                    ),
                    trailing:
                        value.staffBirthdayList[index].selectedStaff != null &&
                                value.staffBirthdayList[index].selectedStaff!
                            ? SvgPicture.asset(
                                UIGuide.check,
                                color: UIGuide.light_Purple,
                              )
                            : SvgPicture.asset(
                                UIGuide.notcheck,
                                color: UIGuide.light_Purple,
                              ),
                    onTap: () {
                      value.selectStaff(value.staffBirthdayList[index]);
                    },
                  );
                }),
            if (value.loading) pleaseWaitLoader()
          ],
        ),
      ),
      bottomNavigationBar: Consumer<BirthdayListProviders>(
        builder: (context, val, _) => val.staffBirthdayList.isEmpty
            ? const SizedBox(
                height: 0,
                width: 0,
              )
            : BottomAppBar(
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
                        ),
                      ),
                    ),
                    onPressed: () async {
                      await val.submitStaff(context);
                    },
                    child: const Text("Send Notification"),
                  )),
                  kWidth
                ]),
              ),
      ),
    );
  }
}
