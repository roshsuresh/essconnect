import 'package:essconnect/Application/AdminProviders/BirthdayListProviders.dart';
import 'package:essconnect/Constants.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:essconnect/utils/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

class StudentBirthdayScreenAdmin extends StatelessWidget {
  StudentBirthdayScreenAdmin({super.key});
  bool check = false;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Consumer<BirthdayListProviders>(
        builder: (context, value, _) => Stack(
          children: [
            value.classStudentBirthList.isEmpty
                ? StudentBirthdayWidget()
                : ListView(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 10, bottom: 10),
                            child: SizedBox(
                              width: size.width / 2,
                              child: ToggleSwitch(
                                //  totalSwitches: 2,
                                initialLabelIndex: value.indval,
                                labels: const ['All', 'Division'],
                                onToggle: (inde) async {
                                  print('Swiched index $inde');
                                  await value.onToggleChanged(inde!);
                                },
                                fontSize: 14,
                                minHeight: 30,
                                minWidth: size.width / 4.05,
                                inactiveBgColor:
                                    const Color.fromARGB(255, 212, 212, 212),
                                activeBgColor: const [UIGuide.light_Purple],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Consumer<BirthdayListProviders>(
                          builder: (context, snap, _) {
                        if (snap.toggleVal == 'all') {
                          return StudentBirthdayWidget();
                        } else if (snap.toggleVal == 'classTeacher') {
                          return const ClassStudentBirthdayWidget();
                        } else {
                          return const SizedBox(
                            height: 0,
                          );
                        }
                      })
                    ],
                  ),
            if (value.loading) pleaseWaitLoader()
          ],
        ),
      ),
      bottomNavigationBar: Consumer<BirthdayListProviders>(
        builder: (context, val, _) => val.studentBirthdayList.isEmpty
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
                      await val.submitStudent(context);
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

class StudentBirthdayWidget extends StatelessWidget {
  StudentBirthdayWidget({
    super.key,
  });
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Consumer<BirthdayListProviders>(
      builder: (context, value, _) => LimitedBox(
        maxHeight: size.height - 250,
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: value.studentBirthdayList.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return ListTile(
                tileColor: index.isOdd
                    ? const Color.fromARGB(255, 243, 243, 243)
                    : UIGuide.WHITE,
                leading: CircleAvatar(
                  backgroundColor: UIGuide.WHITE,
                  radius: 30,
                  backgroundImage: NetworkImage(value
                          .studentBirthdayList[index].studentPhoto ??
                      "https://gj-eschool-files-public.s3.ap-south-1.amazonaws.com/ess-connect/student/avathar-01.jpeg"),
                ),
                title: Text(
                  value.studentBirthdayList[index].studentName ?? "--",
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, color: UIGuide.light_Purple),
                ),
                subtitle: Row(
                  children: [
                    Expanded(
                        child: Text(
                            "Roll no: ${value.studentBirthdayList[index].rollNo ?? "--"}")),
                    kWidth,
                    Expanded(
                        child: Text(
                            "Division: ${value.studentBirthdayList[index].division ?? "--"}")),
                  ],
                ),
                trailing:
                    value.studentBirthdayList[index].selectedStud != null &&
                            value.studentBirthdayList[index].selectedStud!
                        ? SvgPicture.asset(
                            UIGuide.check,
                            color: UIGuide.light_Purple,
                          )
                        : SvgPicture.asset(
                            UIGuide.notcheck,
                            color: UIGuide.light_Purple,
                          ),
                onTap: () {
                  value.selectItem(value.studentBirthdayList[index]);
                },
              );
            }),
      ),
    );
  }
}

class ClassStudentBirthdayWidget extends StatelessWidget {
  const ClassStudentBirthdayWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Consumer<BirthdayListProviders>(
      builder: (context, value, _) => LimitedBox(
        maxHeight: size.height - 250,
        child: ListView.builder(
            itemCount: value.classStudentBirthList.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return ListTile(
                tileColor: index.isOdd
                    ? const Color.fromARGB(255, 243, 243, 243)
                    : UIGuide.WHITE,
                leading: CircleAvatar(
                  backgroundColor: UIGuide.WHITE,
                  radius: 30,
                  backgroundImage: NetworkImage(value
                          .classStudentBirthList[index].studentPhoto ??
                      "https://gj-eschool-files-public.s3.ap-south-1.amazonaws.com/ess-connect/student/avathar-01.jpeg"),
                ),
                title: Text(
                  value.classStudentBirthList[index].studentName ?? "--",
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, color: UIGuide.light_Purple),
                ),
                subtitle: Row(
                  children: [
                    Expanded(
                      child: Text(
                          "Roll no: ${value.classStudentBirthList[index].rollNo ?? "--"}"),
                    ),
                    kWidth,
                    Expanded(
                      child: Text(
                          "Division: ${value.classStudentBirthList[index].division ?? "--"}"),
                    ),
                  ],
                ),
                trailing:
                    value.classStudentBirthList[index].selectedStud != null &&
                            value.classStudentBirthList[index].selectedStud!
                        ? SvgPicture.asset(
                            UIGuide.check,
                            color: UIGuide.light_Purple,
                          )
                        : SvgPicture.asset(
                            UIGuide.notcheck,
                            color: UIGuide.light_Purple,
                          ),
                onTap: () {
                  value.selectStudByClass(value.classStudentBirthList[index]);
                },
              );
            }),
      ),
    );
  }
}
