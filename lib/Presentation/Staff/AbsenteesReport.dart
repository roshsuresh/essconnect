import 'package:essconnect/Application/AdminProviders/Attendanceprovider.dart';
import 'package:essconnect/Application/Staff_Providers/Attendencestaff.dart';
import 'package:essconnect/Constants.dart';
import 'package:essconnect/Domain/Admin/AttendanceModel.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:essconnect/utils/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AbsenteesReportStaff extends StatefulWidget {
  const AbsenteesReportStaff({super.key});

  @override
  State<AbsenteesReportStaff> createState() => _AbsenteesReportStaffState();
}

class _AbsenteesReportStaffState extends State<AbsenteesReportStaff> {
  DateTime? curdate;
  String? newdate;
  String dateFinal = '--';
  DateTime? _mydatetime;
  @override
  void initState() {
    super.initState();
    curdate = DateTime.now();
    newdate = DateFormat('dd-MMM-yyyy').format(curdate!);
    dateFinal = newdate!;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var p = Provider.of<AttendenceStaffProvider>(context, listen: false);
      var c = Provider.of<AttendanceReportProvider>(context, listen: false);
      c.clearList();
      c.clearSelectedList();
      c.isselectAll = false;
      await p.clearAllFilters();
      p.selectedCourse.clear();
      await p.courseClear();
      await p.divisionClear();
      await p.attendenceCourseStaff();
      await p.removeDivisionAll();
      await p.clearStudentList();
      p.studentsAttendenceView.clear();
    });
  }

  final courseController = TextEditingController();
  final courseController1 = TextEditingController();
  final divisionListController = TextEditingController();
  final divisionListController1 = TextEditingController();
  String type = 'sms';
  String courseId = '';
  String divisionId = '';
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Absentees Report',
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
        children: [
          kheight10,
          Row(
            children: [
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.49,
                child: Consumer<AttendenceStaffProvider>(
                    builder: (context, snapshot, child) {
                  return InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                                child: Container(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: attendecourse!.length,
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          onTap: () async {
                                            divisionListController1.clear();
                                            courseController.text =
                                                await attendecourse![index]
                                                        ['value'] ??
                                                    '--';
                                            courseController1.text =
                                                await attendecourse![index]
                                                        ['text'] ??
                                                    '--';
                                            courseId = courseController.text
                                                .toString();

                                            print(courseId);

                                            await snapshot.divisionClear();

                                            await snapshot
                                                .getAttendenceDivisionValues(
                                                    courseId);
                                            await Provider.of<
                                                        AttendanceReportProvider>(
                                                    context,
                                                    listen: false)
                                                .clearList();

                                            Navigator.of(context).pop();
                                          },
                                          title: Text(
                                            attendecourse![index]['text'] ??
                                                '--',
                                            textAlign: TextAlign.center,
                                          ),
                                        );
                                      }),
                                ],
                              ),
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
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: UIGuide.BLACK,
                                  overflow: TextOverflow.clip),
                              textAlign: TextAlign.center,
                              controller: courseController1,
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
                              controller: courseController,
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
                child: Consumer<AttendenceStaffProvider>(
                    builder: (context, snapshot, child) {
                  return InkWell(
                    onTap: () async {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                                child: Container(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: snapshot
                                          .attendenceDivisionList.length,
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          onTap: () async {
                                            divisionListController.text =
                                                snapshot
                                                        .attendenceDivisionList[
                                                            index]
                                                        .value ??
                                                    '---';
                                            divisionListController1.text =
                                                snapshot
                                                        .attendenceDivisionList[
                                                            index]
                                                        .text ??
                                                    '---';
                                            divisionId = divisionListController
                                                .text
                                                .toString();
                                            courseId = courseController.text
                                                .toString();
                                            await Provider.of<
                                                        AttendanceReportProvider>(
                                                    context,
                                                    listen: false)
                                                .clearList();

                                            Navigator.of(context).pop();
                                          },
                                          title: Text(
                                            snapshot
                                                    .attendenceDivisionList[
                                                        index]
                                                    .text ??
                                                '---',
                                            textAlign: TextAlign.center,
                                          ),
                                        );
                                      }),
                                ],
                              ),
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
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: UIGuide.BLACK,
                                  overflow: TextOverflow.clip),
                              textAlign: TextAlign.center,
                              controller: divisionListController1,
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
                              controller: divisionListController,
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
          kheight10,
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
              const Text(
                "Notification",
              ),
              Spacer(),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 5,
              ),
              SizedBox(
                height: 40,
                width: size.width * .45,
                child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    color: Color.fromARGB(255, 241, 240, 240),
                    elevation: 5,
                    child: Text(
                      dateFinal == '--' ? '🗓️   $newdate' : "🗓️   $dateFinal",
                      style: const TextStyle(color: UIGuide.light_Purple),
                    ),
                    onPressed: () async {
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
                        dateFinal =
                            DateFormat('dd-MMM-yyyy').format(_mydatetime!);
                        print(dateFinal);
                      });

                      await Provider.of<AttendanceReportProvider>(context,
                              listen: false)
                          .clearList();
                    }),
              ),
              Spacer(),
              Consumer<AttendanceReportProvider>(
                builder: (context, val, child) => SizedBox(
                  height: 40,
                  width: size.width * .45,
                  child: val.loading
                      ? const Center(
                          child: Text(
                          'Loading Data...',
                          style: TextStyle(
                              color: UIGuide.light_Purple,
                              fontWeight: FontWeight.bold),
                        ))
                      : TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: UIGuide.light_Purple),
                          onPressed: (() async {
                            if (courseController.text.isNotEmpty &&
                                divisionListController.text.isNotEmpty) {
                              await val.clearList();
                              await val.clearSelectedList();
                              await val.getAttReportView(
                                  '', courseId, divisionId, dateFinal);
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
                                    'Select mandatory fields',
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
              const SizedBox(
                width: 5,
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
                            : print("error");
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
                        maxHeight: size.height - 400,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: value.attendanceList.isEmpty
                              ? 0
                              : value.attendanceList.length,
                          itemBuilder: ((context, index) {
                            return Attendance_List_Vie(
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
          padding: const EdgeInsets.all(2.0),
          child: Consumer<AttendanceReportProvider>(
            builder: (context, value, child) => MaterialButton(
              color: UIGuide.light_Purple,
              onPressed: () async {
                if (type == 'Notification') {
                  await value.submitStudent(context);
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
                        .submitSmsStudent(context, dateFinal.toString());
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

class Attendance_List_Vie extends StatelessWidget {
  final AttendanceModel viewStud;
  const Attendance_List_Vie(
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
