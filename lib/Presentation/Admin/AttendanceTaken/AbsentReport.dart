import 'package:essconnect/Application/AdminProviders/Attendanceprovider.dart';
import 'package:essconnect/Application/AdminProviders/SchoolPhotoProviders.dart';
import 'package:essconnect/Constants.dart';
import 'package:essconnect/utils/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../Domain/Staff/StudentReport_staff.dart';
import '../../../../utils/constants.dart';
import '../../../Domain/Admin/AttendanceModel.dart';

class AttendanceReport extends StatefulWidget {
  const AttendanceReport({Key? key}) : super(key: key);

  @override
  State<AttendanceReport> createState() => _AttendanceReportState();
}

class _AttendanceReportState extends State<AttendanceReport> {
  DateTime? _mydatetime;
  String smsDate = '-';
  List subjectData = [];
  List diviData = [];
  List courseData = [];
  DateTime? curdate;
  String? newdate;
  String timeNow = '--';
  String course = '';
  String section = '';
  String division = '';
  String type = '';

  @override
  void initState() {
    curdate = DateTime.now();
    newdate = DateFormat('dd-MMM-yyyy').format(curdate!);
    smsDate = DateFormat('yyyy-MM-dd').format(curdate!);
    timeNow = newdate!;

    type = 'sms';
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var p = Provider.of<SchoolPhotoProviders>(context, listen: false);
      p.stdReportSectionStaff();
      p.courseDrop.clear();
      var c = Provider.of<AttendanceReportProvider>(context, listen: false);
      c.clearList();
      c.clearSelectedList();
      c.isselectAll = false;
      p.dropDown.clear();
      p.stdReportInitialValues.clear();
      p.courselist.clear();
      p.divisionlist.clear();
      p.courseCounter(0);
      p.divisionCounter(0);
      p.sectionCounter(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Spacer(),
            const Text(
              'Absentees Report',
            ),
            const Spacer(),
            IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AttendanceReport()));
                },
                icon: const Icon(Icons.refresh_outlined))
          ],
        ),
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
      body: ListView(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              //  const Spacer(),
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

                              await Provider.of<AttendanceReportProvider>(
                                      context,
                                      listen: false)
                                  .clearList();

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

                              await Provider.of<AttendanceReportProvider>(
                                      context,
                                      listen: false)
                                  .clearList();
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

                              // await Provider.of<NotificationToGuardianAdmin>(context,
                              //         listen: false)
                              //     .clearStudentList();

                              // courseData.clear();
                              // value.divisionDrop.clear();
                              await Provider.of<SchoolPhotoProviders>(context,
                                      listen: false)
                                  .courseCounter(results.length);
                              results.clear();
                              // await Provider.of<SchoolPhotoProviders>(context,
                              //         listen: false)
                              //     .clearDivision();

                              await Provider.of<SchoolPhotoProviders>(context,
                                      listen: false)
                                  .getDivisionList(course);

                              print("course   $course");
                            },
                          ),
                        ),
                      ),
              ),
              //  const Spacer()
            ],
          ),
          Row(
            children: [
              // const Spacer(),
              Consumer<SchoolPhotoProviders>(
                builder: (context, value, child) => value.loadingDivision
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
                              //results.clear();
                              Provider.of<SchoolPhotoProviders>(context,
                                      listen: false)
                                  .divisionCounter(results.length);
                              results.clear();
                              // Provider.of<SchoolPhotoProviders>(context, listen: false)
                              //     .getCourseList(div);

                              print("data div  $division");
                            },
                          ),
                        ),
                      ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(
                      color: Colors.grey,
                      width: 2,
                    ),
                  ),
                  width: size.width * .43,
                  height: 47,
                  child: MaterialButton(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),

                    // minWidth: size.width - 250,
                    color: Colors.white,
                    onPressed: (() async {
                      await Provider.of<AttendanceReportProvider>(context,
                              listen: false)
                          .clearList();
                      _mydatetime = await showDatePicker(
                        context: context,
                        initialDate: _mydatetime ?? DateTime.now(),
                        firstDate: DateTime(2022),
                        lastDate: DateTime(2030),
                        builder: (context, child) {
                          return Theme(
                              data: ThemeData.light().copyWith(
                                primaryColor: UIGuide.light_Purple,
                                colorScheme: const ColorScheme.light(
                                  primary: UIGuide.light_Purple,
                                ),
                                buttonTheme: const ButtonThemeData(
                                    textTheme: ButtonTextTheme.primary),
                              ),
                              child: child!);
                        },
                      );
                      setState(() {
                        timeNow =
                            DateFormat('dd-MMM-yyyy').format(_mydatetime!);
                        print(timeNow);
                        smsDate = DateFormat('yyyy-MM-dd').format(_mydatetime!);

                        // smsDate = smsDate =='-'  ? DateFormat('yyyy-MM-dd').format(_mydatetime!):t
                        // print("Smsdate $smsDate
                        //     );
                      });
                    }),
                    // minWidth: size.width - 250,
                    child: Center(
                        child: Text(
                      timeNow == '--' ? newdate.toString() : timeNow,
                      style: TextStyle(fontSize: 16),
                    )),
                  ),
                ),
              ),
              //const Spacer()
            ],
          ),
          Row(
            children: [
              Spacer(),
              Radio(
                activeColor: UIGuide.light_Purple,
                value: 'sms',
                groupValue: type,
                onChanged: (value) {
                  setState(() {
                    type = value.toString();
                  });
                  print(type);
                },
              ),
              Text(
                "Text SMS",
              ),
              Spacer(),
              Radio(
                activeColor: UIGuide.light_Purple,
                value: 'Notification',
                groupValue: type,
                onChanged: (value) {
                  setState(() {
                    type = value.toString();
                  });
                  print(type);
                },
              ),
              Text(
                "Notification",
              ),
              Spacer(),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //        RadioListTile(
              //        title: Text("Text Sms"),
              //         value: "sms",
              //        groupValue: type,
              //          onChanged: (value){
              //         setState(() {
              //          type = value.toString();
              //        });
              //       },
              //        ),
              //
              // RadioListTile(
              // title: Text("Notification"),
              // value: "notification",
              // groupValue: type,
              // onChanged: (value){
              // setState(() {
              // type = value.toString();
              // });
              // },
              // ),
              Consumer<AttendanceReportProvider>(
                builder: (context, val, child) => SizedBox(
                  width: 120,
                  height: 44,
                  child: val.loading
                      ? Center(
                          child: Container(
                              child: Text(
                          'Loading Data...',
                          style: TextStyle(
                              color: UIGuide.light_Purple,
                              fontWeight: FontWeight.bold),
                        )))
                      : TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: UIGuide.light_Purple),
                          onPressed: (() async {
                            await Provider.of<AttendanceReportProvider>(context,
                                    listen: false)
                                .clearList();
                            await Provider.of<AttendanceReportProvider>(context,
                                    listen: false)
                                .clearSelectedList();

                            await Provider.of<AttendanceReportProvider>(context,
                                    listen: false)
                                .getAttReportView(
                                    section, course, division, timeNow);
                            if (val.attendanceList.isEmpty) {
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
                                    'No data found..!',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              );
                            }
                          }),
                          child: const Text(
                            'View',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
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
                  '   Sl.No.',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Name',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Consumer<AttendanceReportProvider>(
                  builder: (context, value, child) => GestureDetector(
                      onTap: () {
                        value.selectAll();
                        type == 'sms'
                            ? value.lastList = value.attendanceList
                            : print("eroor");
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
          Consumer<AttendanceReportProvider>(
            builder: (context, value, child) {
              return value.loading
                  ? LimitedBox(
                      maxHeight: size.height - 300,
                      child: Center(child: spinkitLoader()),
                    )
                  : Scrollbar(
                      child: LimitedBox(
                        maxHeight: size.height / 2.4,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: value.attendanceList.isEmpty
                              ? 0
                              : value.attendanceList.length,
                          itemBuilder: ((context, index) {
                            return Attendance_List_View(
                              viewStud: value.attendanceList[index],
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
          child: Consumer<AttendanceReportProvider>(
            builder: (context, value, child) => MaterialButton(
              color: UIGuide.light_Purple,
              onPressed: () async {
                if (type == 'Notification') {
                  await Provider.of<AttendanceReportProvider>(context,
                          listen: false)
                      .submitStudent(context);
                } else {
                  await value.getProvider();
                  if (value.providerName == null) {
                    await ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        duration: Duration(seconds: 1),
                        margin:
                            EdgeInsets.only(bottom: 80, left: 30, right: 30),
                        behavior: SnackBarBehavior.floating,
                        content: Text(
                          'Sms Provider Not Found.....!',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  } else {
                    await Provider.of<AttendanceReportProvider>(context,
                            listen: false)
                        .submitSmsStudent(context, smsDate.toString());
                  }
                }
              },
              child: const Text('Proceed',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400)),
            ),
          ),
        ),
      ),
    );
  }
}

class Attendance_List_View extends StatelessWidget {
  final AttendanceModel viewStud;
  const Attendance_List_View(
      {Key? key, required this.viewStud, required this.indexx})
      : super(key: key);
  final int indexx;

  @override
  Widget build(BuildContext context) {
    return Consumer<AttendanceReportProvider>(
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
          title: Text(viewStud.name.toString()),
          subtitle: Text(viewStud.division ?? '---'),
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
