import 'package:essconnect/Application/AdminProviders/NotificationToGuardian.dart';
import 'package:essconnect/Constants.dart';
import 'package:essconnect/Domain/Staff/ToGuardian.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:essconnect/utils/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';
import '../../../Application/AdminProviders/SchoolPhotoProviders.dart';
import '../../../Domain/Staff/StudentReport_staff.dart';

class AdminToGuardian extends StatelessWidget {
  AdminToGuardian({Key? key}) : super(key: key);
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
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const Spacer(),
            IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AdminToGuardian()));
                },
                icon: const Icon(Icons.refresh_outlined)),
            kWidth
          ],
        ),
        titleSpacing: 5.0,
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
      body: Notification_AdminToGuardain(),
    );
  }
}

//Notification To guard

class Notification_AdminToGuardain extends StatefulWidget {
  Notification_AdminToGuardain({Key? key}) : super(key: key);

  @override
  State<Notification_AdminToGuardain> createState() =>
      _Notification_AdminToGuardainState();
}

class _Notification_AdminToGuardainState
    extends State<Notification_AdminToGuardain> {
  // @override
  List subjectData = [];

  List diviData = [];

  List courseData = [];

  String course = '';

  String section = '';
  int length = 0;
  String division = '';

  divClearr() {
    diviData.clear();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var p = await Provider.of<SchoolPhotoProviders>(context, listen: false);
      p.stdReportSectionStaff();
      p.courseDrop.clear();
      p.divisionDrop.clear();
      p.dropDown.clear();
      p.stdReportInitialValues.clear();
      p.courselist.clear();
      p.divisionlist.clear();
      p.courseCounter(0);
      p.divisionCounter(0);
      p.sectionCounter(0);
      await Provider.of<NotificationToGuardianAdmin>(context, listen: false)
          .clearStudentList();
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(
        children: [
          Row(
            children: [
              Consumer<SchoolPhotoProviders>(
                builder: (context, value, child) => value.loadingSection
                    ? SizedBox(
                        width: size.width * .43,
                        height: 50,
                        child: const Center(child: Text('Loading...')))
                    : Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SizedBox(
                          width: size.width * .43,
                          height: 50,
                          child: MultiSelectDialogField(
                            items: value.dropDown,
                            listType: MultiSelectListType.CHIP,
                            title: const Text(
                              "Select Section",
                              style: TextStyle(color: Colors.grey),
                            ),
                            selectedItemsTextStyle: const TextStyle(
                                fontWeight: FontWeight.w900,
                                color: UIGuide.light_Purple),
                            confirmText: const Text(
                              'OK',
                              style: TextStyle(color: UIGuide.light_Purple),
                            ),
                            cancelText: const Text(
                              'Cancel',
                              style: TextStyle(color: UIGuide.light_Purple),
                            ),
                            separateSelectedItems: true,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              border: Border.all(
                                color: Colors.grey,
                                width: 2,
                              ),
                            ),
                            buttonIcon: const Icon(
                              Icons.arrow_drop_down_outlined,
                              color: Colors.grey,
                            ),
                            buttonText: value.sectionLen == 0
                                ? const Text(
                                    "Select Section",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  )
                                : Text(
                                    "   ${value.sectionLen.toString()} Selected",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                            chipDisplay: MultiSelectChipDisplay.none(),
                            onConfirm: (results) async {
                              subjectData = [];
                              diviData.clear();
                              courseData.clear();
                              value.courseLen = 0;
                              value.divisionLen = 0;
                              await Provider.of<SchoolPhotoProviders>(context,
                                      listen: false)
                                  .clearCourse();
                              await Provider.of<SchoolPhotoProviders>(context,
                                      listen: false)
                                  .clearDivision();

                              await Provider.of<NotificationToGuardianAdmin>(
                                      context,
                                      listen: false)
                                  .clearStudentList();

                              for (var i = 0; i < results.length; i++) {
                                StudReportSectionList data =
                                    results[i] as StudReportSectionList;
                                print(data.text);
                                print(data.value);
                                subjectData.add(data.value);
                                subjectData.map((e) => data.value);
                                print("${subjectData.map((e) => data.value)}");
                              }
                              section = subjectData.join(',');
                              await Provider.of<SchoolPhotoProviders>(context,
                                      listen: false)
                                  .sectionCounter(results.length);
                              // await Provider.of<SchoolPhotoProviders>(context,
                              //         listen: false)
                              //     .clearCourse();
                              await Provider.of<SchoolPhotoProviders>(context,
                                      listen: false)
                                  .getCourseList(section);
                              print("data $section");

                              print(subjectData.join(','));
                            },
                          ),
                        ),
                      ),
              ),
              const Spacer(),
              Consumer<SchoolPhotoProviders>(
                builder: (context, value, child) => value.loadingCourse
                    ? SizedBox(
                        width: size.width * .43,
                        height: 50,
                        child: const Center(child: Text('Loading...')))
                    : Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SizedBox(
                          width: size.width * .43,
                          height: 50,
                          child: MultiSelectDialogField(
                            items: value.courseDrop,
                            listType: MultiSelectListType.CHIP,
                            title: const Text(
                              "Select Course",
                              style: TextStyle(color: Colors.black),
                            ),
                            selectedItemsTextStyle: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w900,
                                color: UIGuide.light_Purple),
                            confirmText: const Text(
                              'OK',
                              style: TextStyle(color: UIGuide.light_Purple),
                            ),
                            cancelText: const Text(
                              'Cancel',
                              style: TextStyle(color: UIGuide.light_Purple),
                            ),
                            separateSelectedItems: true,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              border: Border.all(
                                color: Colors.grey,
                                width: 2,
                              ),
                            ),
                            buttonIcon: const Icon(
                              Icons.arrow_drop_down_outlined,
                              color: Colors.grey,
                            ),
                            buttonText: value.courseLen == 0
                                ? const Text(
                                    "Select Course",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  )
                                : Text(
                                    "   ${value.courseLen.toString()} Selected",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                            chipDisplay: MultiSelectChipDisplay.none(),
                            onConfirm: (results) async {
                              diviData = [];
                              courseData.clear();
                              value.divisionLen = 0;
                              print("coursddeleteeee   $courseData");
                              await Provider.of<SchoolPhotoProviders>(context,
                                      listen: false)
                                  .clearDivision();

                              await Provider.of<NotificationToGuardianAdmin>(
                                      context,
                                      listen: false)
                                  .clearStudentList();
                              for (var a = 0; a < results.length; a++) {
                                StudReportCourse data =
                                    results[a] as StudReportCourse;

                                diviData.add(data.value);
                                diviData.map((e) => data.value);
                                print("${diviData.map((e) => data.value)}");
                              }
                              print('diviData course== $diviData');
                              course = '';
                              course = diviData.join(',');
                              await Provider.of<SchoolPhotoProviders>(context,
                                      listen: false)
                                  .courseCounter(results.length);
                              results.clear();
                              await Provider.of<SchoolPhotoProviders>(context,
                                      listen: false)
                                  .getDivisionList(course);

                              print("course   $course");
                            },
                          ),
                        ),
                      ),
              )
            ],
          ),
          Row(
            children: [
              Consumer<SchoolPhotoProviders>(
                builder: (context, value, child) => value.loadingDivision
                    ? SizedBox(
                        width: size.width * .43,
                        height: 50,
                        child: const Center(child: Text('Loading...')))
                    : Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10),
                        child: SizedBox(
                          width: size.width * .43,
                          height: 50,
                          child: MultiSelectDialogField(
                            items: value.divisionDrop,
                            listType: MultiSelectListType.CHIP,
                            title: const Text(
                              "Select Division",
                              style: TextStyle(color: Colors.grey),
                            ),
                            selectedItemsTextStyle: const TextStyle(
                                fontWeight: FontWeight.w900,
                                color: UIGuide.light_Purple),
                            confirmText: const Text(
                              'OK',
                              style: TextStyle(color: UIGuide.light_Purple),
                            ),
                            cancelText: const Text(
                              'Cancel',
                              style: TextStyle(color: UIGuide.light_Purple),
                            ),
                            separateSelectedItems: true,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              border: Border.all(
                                color: Colors.grey,
                                width: 2,
                              ),
                            ),
                            buttonIcon: const Icon(
                              Icons.arrow_drop_down_outlined,
                              color: Colors.grey,
                            ),
                            buttonText: value.divisionLen == 0
                                ? const Text(
                                    "Select Division",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  )
                                : Text(
                                    "   ${value.divisionLen.toString()} Selected",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                            chipDisplay: MultiSelectChipDisplay.none(),
                            onConfirm: (results) {
                              courseData = [];
                              for (var i = 0; i < results.length; i++) {
                                StudReportDivision data =
                                    results[i] as StudReportDivision;
                                print(data.text);
                                print(data.value);
                                courseData.add(data.value);
                                courseData.map((e) => data.value);
                                print("${courseData.map((e) => data.value)}");
                              }
                              print("Coursedataaaa    $courseData");
                              division = courseData.join(',');
                              Provider.of<SchoolPhotoProviders>(context,
                                      listen: false)
                                  .divisionCounter(results.length);
                              results.clear();
                              print("data div  $division");
                            },
                          ),
                        ),
                      ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: SizedBox(
                  width: size.width * .43,
                  height: 44,
                  child: Consumer<NotificationToGuardianAdmin>(
                    builder: (context, val, child) => val.loading
                        ? const Center(
                            child: Text(
                            'Loading...',
                            style: TextStyle(
                                color: UIGuide.light_Purple, fontSize: 16),
                          ))
                        : MaterialButton(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            onPressed: () async {
                              // var p = await Provider.of<SchoolPhotoProviders>(context,
                              //     listen: false);
                              // p.courselist.clear();
                              // p.divisionlist.clear();
                              // Provider.of<NotificationToGuardianAdmin>(context,
                              //         listen: false)
                              //     .notificationView
                              //     .clear();
                              await Provider.of<NotificationToGuardianAdmin>(
                                      context,
                                      listen: false)
                                  .clearStudentList();
                              await Provider.of<NotificationToGuardianAdmin>(
                                      context,
                                      listen: false)
                                  .getNotificationView(course.toLowerCase(),
                                      division.toLowerCase());
                            },
                            color: UIGuide.THEME_LIGHT,
                            child: const Text('View'),
                          ),
                  ),
                ),
              )
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
                Consumer<NotificationToGuardianAdmin>(
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
          Consumer<NotificationToGuardianAdmin>(
            builder: (context, value, child) {
              return value.loading
                  ? LimitedBox(
                      maxHeight: size.height - 300,
                      child: Center(child: spinkitLoader()),
                    )
                  : Scrollbar(
                      child: LimitedBox(
                        maxHeight: size.height - 330,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: value.notificationView.isEmpty
                              ? 0
                              : value.notificationView.length,
                          itemBuilder: ((context, index) {
                            return Notification_StudListAdmin(
                              viewStud: value.notificationView[index],
                              indexx: index,
                            );
                          }),
                        ),
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
            onPressed: () {
              Provider.of<NotificationToGuardianAdmin>(context, listen: false)
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

class Notification_StudListAdmin extends StatelessWidget {
  final StudentViewbyCourseDivision_notification_Stf viewStud;
  const Notification_StudListAdmin(
      {Key? key, required this.viewStud, required this.indexx})
      : super(key: key);
  final int indexx;

  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationToGuardianAdmin>(
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
          title: Text(viewStud.name == null ? '---' : viewStud.name),
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

class Text_Matter_NotificationAdmin extends StatelessWidget {
  final List<String> toList;
  final String type;
  Text_Matter_NotificationAdmin(
      {Key? key, required this.toList, required this.type})
      : super(key: key);
  final titleController = TextEditingController();
  final matterController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
              child: LimitedBox(
                maxHeight: 80,
                child: TextFormField(
                  inputFormatters: [LengthLimitingTextInputFormatter(50)],
                  controller: titleController,
                  minLines: 1,
                  maxLines: 4,
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
              child: LimitedBox(
                maxHeight: 150,
                child: TextFormField(
                  inputFormatters: [LengthLimitingTextInputFormatter(500)],
                  controller: matterController,
                  minLines: 1,
                  maxLines: 15,
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
            kheight20,
            Consumer<NotificationToGuardianAdmin>(
              builder: (context, value, _) => value.load
                  ? spinkitLoader()
                  : SizedBox(
                      width: 150,
                      height: 40,
                      child: MaterialButton(
                        onPressed: () async {
                          if (titleController.text.isNotEmpty &&
                              matterController.text.isNotEmpty) {
                            await value.sendNotification(
                                context,
                                titleController.text,
                                matterController.text,
                                toList,
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
                        shape: RoundedRectangleBorder(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(0),
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(20)),
                          side:
                              BorderSide(color: Theme.of(context).primaryColor),
                        ),
                        color: UIGuide.light_Purple,
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
