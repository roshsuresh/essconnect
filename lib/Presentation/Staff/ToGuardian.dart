import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:essconnect/Application/Staff_Providers/Notification_ToGuardianProvider.dart';
import 'package:essconnect/Domain/Staff/ToGuardian.dart';
import 'package:essconnect/utils/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../Constants.dart';
import '../../utils/constants.dart';

class Staff_ToGuardian extends StatelessWidget {
  Staff_ToGuardian({Key? key}) : super(key: key);
  String? valuee;
  bool checked = true;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Spacer(),
            const Text(
              'Notification to Guardian',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
            ),
            const Spacer(),
            IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Staff_ToGuardian()));
                },
                icon: const Icon(Icons.refresh_outlined)),
            kWidth
          ],
        ),
        titleSpacing: 00.0,
        centerTitle: true,
        toolbarHeight: 60,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
        ),
        // bottom: const TabBar(
        //   indicatorSize: TabBarIndicatorSize.label,
        //   indicatorColor: Colors.white,
        //   indicatorWeight: 5,
        //   tabs: [
        //     Tab(
        //       text: "Notification",
        //     ),
        //     Tab(text: "Text SMS"),
        //   ],
        // ),
        backgroundColor: UIGuide.light_Purple,
      ),
      body:

          // TabBarView(
          //   children: [
          Consumer<NotificationToGuardian_Providers>(
        builder: (context, value, child) {
          if (value.isClassTeacher != false) {
            return Notification_StaffToGuardain(
                size: size, valuee: valuee, checked: checked);
          } else {
            return Container(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.sentiment_dissatisfied_outlined,
                      size: 60,
                      color: Colors.grey,
                    ),
                    kheight10,
                    Text(
                      "Sorry you don't have access",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
      // Consumer<NotificationToGuardian_Providers>(
      //   builder: (context, value, child) {
      //     if (value.isClassTeacher != false) {
      //       return const TextSMS_staff();
      //     } else {
      //       return Container(
      //         child: Center(
      //           child: Column(
      //             crossAxisAlignment: CrossAxisAlignment.center,
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             children: const [
      //               Icon(
      //                 Icons.sentiment_dissatisfied_outlined,
      //                 size: 60,
      //                 color: Colors.grey,
      //               ),
      //               kheight10,
      //               Text(
      //                 "Sorry you don't have access",
      //                 style: TextStyle(
      //                     fontSize: 20,
      //                     fontWeight: FontWeight.w600,
      //                     color: Colors.grey),
      //               ),
      //             ],
      //           ),
      //         ),
      //       );
      //     }
      //   },
      // ),
      //   ],
      // ),
    );
  }
}

class Notification_StaffToGuardain extends StatefulWidget {
  Notification_StaffToGuardain({
    Key? key,
    required this.size,
    required this.valuee,
    required this.checked,
  }) : super(key: key);

  final Size size;
  final String? valuee;
  final bool checked;

  @override
  State<Notification_StaffToGuardain> createState() =>
      _Notification_StaffToGuardainState();
}

class _Notification_StaffToGuardainState
    extends State<Notification_StaffToGuardain> {
  String courseId = '';

  String divisionId = '';

  final notificationCourseController = TextEditingController();

  final notificationCourseController1 = TextEditingController();

  final notificationDivisionListController = TextEditingController();

  final notificationDivisionListController1 = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var p =
          Provider.of<NotificationToGuardian_Providers>(context, listen: false);
      p.communicationToGuardianCourseStaff();
      p.clearAllFilters();
      p.selectedCourse.clear();
      p.courseClear();
      p.divisionClear();
      p.removeDivisionAll();
      p.clearStudentList();
      p.selectedList.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(
            height: 3,
          ),
          Row(
            children: [
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.49,
                child: Consumer<NotificationToGuardian_Providers>(
                    builder: (context, snapshot, child) {
                  return InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                                child: LimitedBox(
                              maxHeight: size.height - 300,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: snapshot
                                      .communicationToGuardianInitialValues
                                      .length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      selectedTileColor: Colors.blue.shade100,
                                      selectedColor: UIGuide.PRIMARY2,
                                      onTap: () async {
                                        notificationCourseController
                                            .text = snapshot
                                                .communicationToGuardianInitialValues[
                                                    index]
                                                .value ??
                                            '--';
                                        notificationCourseController1
                                            .text = snapshot
                                                .communicationToGuardianInitialValues[
                                                    index]
                                                .text ??
                                            '--';
                                        courseId = notificationCourseController
                                            .text
                                            .toString();
                                        await snapshot.clearStudentList();
                                        await Provider.of<
                                                    NotificationToGuardian_Providers>(
                                                context,
                                                listen: false)
                                            .communicationToGuardianDivisionStaff(
                                                courseId);
                                        Navigator.of(context).pop();
                                      },
                                      title: Text(
                                        snapshot
                                                .communicationToGuardianInitialValues[
                                                    index]
                                                .text ??
                                            '--',
                                        textAlign: TextAlign.center,
                                      ),
                                    );
                                  }),
                            ));
                          });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: UIGuide.light_Purple, width: 1),
                            ),
                            height: 40,
                            child: TextField(
                              textAlign: TextAlign.center,
                              controller: notificationCourseController1,
                              decoration: const InputDecoration(
                                contentPadding:
                                    EdgeInsets.only(left: 0, top: 0),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                filled: true,
                                fillColor: Color.fromARGB(255, 238, 237, 237),
                                border: OutlineInputBorder(),
                                labelText: "  Select Course",
                                hintText: "Course",
                              ),
                              enabled: false,
                            ),
                          ),
                          SizedBox(
                            height: 0,
                            child: TextField(
                              textAlign: TextAlign.center,
                              controller: notificationCourseController,
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Color.fromARGB(255, 238, 237, 237),
                                border: OutlineInputBorder(),
                                labelText: "",
                                hintText: "",
                              ),
                              enabled: false,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
              const Spacer(),
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.49,
                child: Consumer<NotificationToGuardian_Providers>(
                    builder: (context, snapshot, child) {
                  return InkWell(
                    onTap: () async {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                                child: LimitedBox(
                              maxHeight: size.height - 300,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount:
                                      snapshot.notificationDivisionList.length,
                                  itemBuilder: (context, index) {
                                    print(snapshot
                                        .notificationDivisionList.length);
                                    return ListTile(
                                      onTap: () async {
                                        print(snapshot
                                            .notificationDivisionList[index]
                                            .order);
                                        notificationDivisionListController
                                            .text = snapshot
                                                .notificationDivisionList[index]
                                                .value ??
                                            '---';
                                        notificationDivisionListController1
                                            .text = snapshot
                                                .notificationDivisionList[index]
                                                .text ??
                                            '---';
                                        print(notificationDivisionListController
                                            .text);
                                        divisionId =
                                            notificationDivisionListController
                                                .text
                                                .toString();
                                        courseId = notificationCourseController1
                                            .text
                                            .toString();
                                        Navigator.of(context).pop();
                                      },
                                      title: Text(
                                        snapshot.notificationDivisionList[index]
                                                .text ??
                                            '---',
                                        textAlign: TextAlign.center,
                                      ),
                                    );
                                  }),
                            ));
                          });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: UIGuide.light_Purple, width: 1),
                            ),
                            height: 40,
                            child: TextField(
                              textAlign: TextAlign.center,
                              controller: notificationDivisionListController1,
                              decoration: const InputDecoration(
                                contentPadding:
                                    EdgeInsets.only(left: 0, top: 0),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                filled: true,
                                fillColor: Color.fromARGB(255, 238, 237, 237),
                                border: OutlineInputBorder(),
                                labelText: "  Select Division",
                                hintText: "Division",
                              ),
                              enabled: false,
                            ),
                          ),
                          SizedBox(
                            height: 0,
                            child: TextField(
                              controller: notificationDivisionListController,
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Color.fromARGB(255, 238, 237, 237),
                                border: OutlineInputBorder(),
                                labelText: "",
                                hintText: "",
                              ),
                              enabled: false,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 120,
                height: 35,
                child: Consumer<NotificationToGuardian_Providers>(
                  builder: (context, val, child) => val.loading
                      ? const Center(
                          child: Text(
                          "Loading",
                          style: TextStyle(
                              color: UIGuide.light_Purple, fontSize: 16),
                        ))
                      : MaterialButton(
                          color: UIGuide.light_Purple,
                          child: const Text(
                            'View',
                            style: TextStyle(
                                color: UIGuide.WHITE,
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () async {
                            if (notificationCourseController.text.isEmpty &&
                                notificationDivisionListController
                                    .text.isEmpty) {
                              return AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.error,
                                      animType: AnimType.rightSlide,
                                      headerAnimationLoop: false,
                                      title: 'Error',
                                      desc: 'Select course & Division',
                                      btnOkOnPress: () {
                                        return;
                                      },
                                      btnOkIcon: Icons.cancel,
                                      btnOkColor: Colors.red)
                                  .show();
                            } else {
                              await Provider.of<
                                          NotificationToGuardian_Providers>(
                                      context,
                                      listen: false)
                                  .clearStudentList();
                              await Provider.of<
                                          NotificationToGuardian_Providers>(
                                      context,
                                      listen: false)
                                  .divisionClear();
                              await Provider.of<
                                          NotificationToGuardian_Providers>(
                                      context,
                                      listen: false)
                                  .removeDivisionAll();
                              divisionId = notificationDivisionListController
                                  .text
                                  .toString();
                              courseId =
                                  notificationCourseController.text.toString();

                              await Provider.of<
                                          NotificationToGuardian_Providers>(
                                      context,
                                      listen: false)
                                  .getNotificationView(courseId, divisionId);
                            }
                          }),
                ),
              ),
            ],
          ),
          kheight20,
          Table(
            columnWidths: const {
              0: FlexColumnWidth(1.5),
              1: FlexColumnWidth(4),
              2: FlexColumnWidth(1.2),
            },
            children: [
              TableRow(children: [
                const Text(
                  '   NO.',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Name',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Consumer<NotificationToGuardian_Providers>(
                  builder: (context, value, child) => GestureDetector(
                      onTap: () {
                        value.selectAll();
                      },
                      child: value.isselectAll
                          ? Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: SvgPicture.asset(
                                UIGuide.check,
                                color: UIGuide.light_Purple,
                              ),
                            )
                          : const Text(
                              'Select All',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: UIGuide.light_Purple),
                            )),
                )
              ])
            ],
          ),
          Consumer<NotificationToGuardian_Providers>(
            builder: (context, value, child) {
              return value.loading
                  ? LimitedBox(
                      maxHeight: widget.size.height - 330,
                      child: Center(child: spinkitLoader()),
                    )
                  : LimitedBox(
                      maxHeight: widget.size.height - 305,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: value.notificationView.isEmpty
                            ? 0
                            : value.notificationView.length,
                        itemBuilder: ((context, index) {
                          return Notification_StudList(
                            viewStud: value.notificationView[index],
                            indexx: index,
                          );
                        }),
                      ),
                    );
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 3.0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: MaterialButton(
            color: UIGuide.light_Purple,
            onPressed: () async {
              await Provider.of<NotificationToGuardian_Providers>(context,
                      listen: false)
                  .submitStudent(context);
            },
            child: const Text('Proceed',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400)),
          ),
        ),
      ),
    );
  }
}

class Notification_StudList extends StatelessWidget {
  final StudentViewbyCourseDivision_notification_Stf viewStud;
  const Notification_StudList(
      {Key? key, required this.viewStud, required this.indexx})
      : super(key: key);
  final int indexx;

  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationToGuardian_Providers>(
      builder: (context, value, child) => SizedBox(
        height: 53,
        child: ListTile(
          style: ListTileStyle.list,
          selectedColor: UIGuide.light_Purple,
          leading: Text(
            (indexx + 1).toString(),
            textAlign: TextAlign.center,
          ),
          onTap: () {
            value.selectItem(viewStud);
          },
          selectedTileColor: const Color.fromARGB(255, 10, 27, 141),
          title: Text(viewStud.name == null ? '---' : viewStud.name.toString()),
          subtitle: Text(viewStud.admnNo ?? '---'),
          trailing: viewStud.selected != null && viewStud.selected!
              ? SvgPicture.asset(
                  UIGuide.check,
                  color: UIGuide.light_Purple,
                )
              : SvgPicture.asset(
                  UIGuide.notcheck,
                  color: UIGuide.light_Purple,
                ),
        ),
      ),
    );
  }
}

class Text_Matter_Notification extends StatelessWidget {
  final List<String> toList;
  final String type;
  Text_Matter_Notification({Key? key, required this.toList, required this.type})
      : super(key: key);
  final titleController = TextEditingController();
  final matterController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Notification'),
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
      body: SingleChildScrollView(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LottieBuilder.network(
                'https://assets10.lottiefiles.com/private_files/lf30_kBx3K1.json'),
            kheight20,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 50,
                child: TextFormField(
                  inputFormatters: [LengthLimitingTextInputFormatter(50)],
                  controller: titleController,
                  minLines: 1,
                  maxLines: 1,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    labelText: 'Title*',
                    hintText: 'Enter Title',
                    labelStyle: TextStyle(color: UIGuide.light_Purple),
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(0),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(20)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: UIGuide.light_Purple, width: 1.0),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(0),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(20)),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 100,
                child: TextFormField(
                  inputFormatters: [LengthLimitingTextInputFormatter(500)],
                  controller: matterController,
                  minLines: 1,
                  maxLines: 5,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    labelText: 'Matter*',
                    hintText: 'Enter Matter',
                    labelStyle: TextStyle(color: UIGuide.light_Purple),
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(0),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(20)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: UIGuide.light_Purple, width: 1.0),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(0),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(20)),
                    ),
                  ),
                ),
              ),
            ),
            Consumer<NotificationToGuardian_Providers>(
              builder: (context, value, _) => value.load
                  ? spinkitLoader()
                  : SizedBox(
                      width: 150,
                      height: 40,
                      child: MaterialButton(
                        onPressed: () async {
                          if (titleController.text.isNotEmpty &&
                              matterController.text.isNotEmpty) {
                            await Provider.of<NotificationToGuardian_Providers>(
                                    context,
                                    listen: false)
                                .sendNotification(context, titleController.text,
                                    matterController.text, toList,
                                    sentTo: type);
                            titleController.clear();
                            matterController.clear();
                          } else {
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
                                content: Text(
                                  'Enter Title & Matter!',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                          }
                        },
                        color: UIGuide.light_Purple,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(0),
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(20)),
                        ),
                        child: const Text(
                          'Send',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
