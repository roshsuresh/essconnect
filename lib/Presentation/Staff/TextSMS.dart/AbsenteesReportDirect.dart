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

class AbsenteesReportDirectStaff extends StatefulWidget {
   AbsenteesReportDirectStaff({super.key,required this.course,required this.division,required this.date,required this.coursename,required this.divname,required this.datedisplay});
 String course;
 String division;
  String date;
  String coursename;
   String divname;
   String datedisplay;
  @override
  State<AbsenteesReportDirectStaff> createState() => _AbsenteesReportStaffState();
}

class _AbsenteesReportStaffState extends State<AbsenteesReportDirectStaff> {
  DateTime? curdate;
  String? newdate;
  String dateFinal = '--';


  @override
  void initState() {
    super.initState();
    curdate = DateTime.now();
    newdate = DateFormat('dd-MMM-yyyy').format(curdate!);
    dateFinal = newdate!;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var p = Provider.of<AttendenceStaffProvider>(context, listen: false);
      p.setLoad(false);
      var c = Provider.of<AttendanceReportProvider>(context, listen: false);
      c.clearList();
      c.setLoading(false);

      c.clearSelectedList();
      p.studentsAttendenceView.clear();
      c.getAttReportView('', widget.course,
          widget.division, widget.date, attType, type);
      c.isselectAll = true;
      c.isDualttendance;
    });
  }

  final courseController = TextEditingController();
  final courseController1 = TextEditingController();
  final divisionListController = TextEditingController();
  final divisionListController1 = TextEditingController();
  String type = 'sms';
  String attType = 'both';
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
      body: Consumer<AttendanceReportProvider>(
        builder: (context, snap, child) =>
            Column(
              children: [
                kheight10,
                Row(
                  children: [
                    kWidth,
                    Expanded(
                      child: SizedBox(
                        height: 45,
                        child: Consumer<AttendenceStaffProvider>(
                            builder: (context, snapshot, child) {
                              return snapshot.load
                                  ? Container(
                                height: 45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: UIGuide.light_Purple,
                                      width: 1),
                                ),
                                child: const Center(
                                  child: Text("Loading..."),
                                ),
                              )
                                  : ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 3,
                                  foregroundColor: UIGuide.light_Purple,
                                  backgroundColor: UIGuide.ButtonBlue,
                                  padding: const EdgeInsets.all(0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: const BorderSide(
                                        color: UIGuide.light_black,
                                      )),
                                ),
                                onPressed: () {
                                },
                                child: TextField(
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: UIGuide.BLACK,
                                      overflow: TextOverflow.clip),
                                  textAlign: TextAlign.center,
                                  controller: courseController1,
                                  decoration:  InputDecoration(
                                    contentPadding:
                                    EdgeInsets.only(left: 0, top: 0),
                                    floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                    filled: true,
                                    fillColor: Colors.transparent,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          style: BorderStyle.none, width: 0),
                                    ),
                                    labelText: "   ${widget.coursename}",
                                    hintText: "Course",
                                  ),
                                  enabled: false,
                                ),
                              );
                            }),
                      ),
                    ),
                    kWidth,
                    Expanded(
                      child: SizedBox(
                        height: 45,
                        child: Consumer<AttendenceStaffProvider>(
                            builder: (context, snapshot, child) {
                              return snapshot.loadDivision
                                  ? Container(
                                height: 45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: UIGuide.light_Purple,
                                      width: 1),
                                ),
                                child: const Center(
                                  child: Text("Loading..."),
                                ),
                              )
                                  : ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 3,
                                  foregroundColor: UIGuide.light_Purple,
                                  backgroundColor: UIGuide.ButtonBlue,
                                  padding: const EdgeInsets.all(0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: const BorderSide(
                                        color: UIGuide.light_black,
                                      )),
                                ),
                                onPressed: () async {

                                },
                                child: TextField(
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: UIGuide.BLACK,
                                      overflow: TextOverflow.clip),
                                  textAlign: TextAlign.center,
                                  controller: divisionListController1,
                                  decoration:  InputDecoration(
                                    contentPadding:
                                    EdgeInsets.only(left: 0, top: 0),
                                    floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                    filled: true,
                                    fillColor: Colors.transparent,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          style: BorderStyle.none, width: 0),
                                    ),
                                    labelText: "   ${widget.divname}",
                                    hintText: "Division",
                                  ),
                                  enabled: false,
                                ),
                              );
                            }),
                      ),
                    ),
                    kWidth
                  ],
                ),
                //  kheight10,
                Row(
                  children: [
                    const Spacer(),
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
                    InkWell(
                      onTap: () {
                        setState(() {
                          type = 'sms';
                        });
                      },
                      child: const Text(
                        "Text SMS",
                      ),
                    ),
                    const Spacer(),
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
                    InkWell(
                      onTap: () {
                        setState(() {
                          type = 'Notification';
                        });
                      },
                      child: const Text(
                        "Notification",
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
                snap.isDualttendance == true
                    ? Padding(
                  padding: const EdgeInsets.only(
                      left: 8.0, right: 8, bottom: 5, top: 0),
                  child: Container(
                    decoration: BoxDecoration(
                      //color: UIGuide.light_black,
                        border: Border.all(color: UIGuide.light_black),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        const Spacer(),
                        Radio(
                          activeColor: UIGuide.light_Purple,
                          value: 'both',
                          groupValue: attType,
                          onChanged: (value) {
                            attType != 'both'
                                ? snap.clearList()
                                : print("no change");

                            setState(() {
                              attType = value.toString();
                            });
                            print(attType);
                          },
                        ),
                        InkWell(
                          onTap: () {
                            attType != 'both'
                                ? snap.clearList()
                                : print("no change");
                            setState(() {
                              attType = 'both';
                            });
                          },
                          child: const Text(
                            "Both",
                          ),
                        ),
                        const Spacer(),
                        Radio(
                          activeColor: UIGuide.light_Purple,
                          value: 'forenoon',
                          groupValue: attType,
                          onChanged: (value) {
                            setState(() {
                              attType != 'forenoon'
                                  ? snap.clearList()
                                  : print("no change");
                              attType = value.toString();
                            });
                            print(attType);
                          },
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              attType != 'forenoon'
                                  ? snap.clearList()
                                  : print("no change");

                              attType = 'forenoon';
                            });
                          },
                          child: const Text(
                            "Forenoon",
                          ),
                        ),
                        const Spacer(),
                        Radio(
                          activeColor: UIGuide.light_Purple,
                          value: 'afternoon',
                          groupValue: attType,
                          onChanged: (value) {
                            attType != 'afternoon'
                                ? snap.clearList()
                                : print("no change");
                            setState(() {
                              attType = value.toString();
                            });
                            print(attType);
                          },
                        ),
                        InkWell(
                          onTap: () {
                            attType != 'afternoon'
                                ? snap.clearList()
                                : print("no change");

                            setState(() {
                              attType = 'afternoon';
                            });
                          },
                          child: const Text(
                            "Afternoon",
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                )
                    : const SizedBox(
                  height: 0,
                  width: 0,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    kWidth,
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 3,
                              foregroundColor: UIGuide.light_Purple,
                              backgroundColor: UIGuide.ButtonBlue,
                              padding: const EdgeInsets.all(0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: const BorderSide(
                                    color: UIGuide.light_black,
                                  )),
                            ),
                            child: Text(
                             "${widget.datedisplay}",
                              style:
                              const TextStyle(color: UIGuide.light_Purple),
                            ),
                            onPressed: () async {
                              // _mydatetime = await showDatePicker(
                              //   context: context,
                              //   initialDate: _mydatetime ?? DateTime.now(),
                              //   firstDate: DateTime(2022),
                              //   lastDate: DateTime(2030),
                              //   builder: (context, child) {
                              //     return Theme(
                              //         data: ThemeData.light().copyWith(
                              //           primaryColor: UIGuide.light_Purple,
                              //           colorScheme: const ColorScheme.light(
                              //             primary: UIGuide.light_Purple,
                              //           ),
                              //           buttonTheme: const ButtonThemeData(
                              //               textTheme: ButtonTextTheme.primary),
                              //         ),
                              //         child: child!);
                              //   },
                              // );
                              // setState(() {
                              //   dateFinal = DateFormat('dd-MMM-yyyy')
                              //       .format(_mydatetime!);
                              //   print(dateFinal);
                              // });
                              //
                              // await Provider.of<AttendanceReportProvider>(
                              //     context,
                              //     listen: false)
                              //     .clearList();
                            }),
                      ),
                    ),
                    kWidth,
                    Consumer<AttendanceReportProvider>(
                      builder: (context, val, child) => Expanded(
                        child: SizedBox(
                          height: 40,
                          child: val.loading
                              ? const Center(
                              child: Text(
                                'Loading Data...',
                                style: TextStyle(
                                    color: UIGuide.light_Purple,
                                    fontWeight: FontWeight.bold),
                              ))
                              : ElevatedButton(
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
                            onPressed: (() async {

                                await val.clearList();
                                await val.clearSelectedList();
                                await val.getAttReportView('', widget.course,
                                    widget.division, widget.datedisplay, attType, type);
                                if (val.attendanceList.isEmpty) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(
                                    const SnackBar(
                                      elevation: 10,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      duration: Duration(seconds: 1),
                                      margin: EdgeInsets.only(
                                          bottom: 80,
                                          left: 30,
                                          right: 30),
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
                    ),
                    const SizedBox(
                      width: 5,
                    )
                  ],
                ),
                kheight10,
                Provider.of<AttendanceReportProvider>(context, listen: false)
                    .attendanceList
                    .isEmpty
                    ? const SizedBox(
                  height: 0,
                  width: 0,
                )
                    : Container(
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 241, 243, 245),
                      border: Border.all(
                          color: UIGuide.light_black, width: 1)),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2.0, bottom: 2),
                    child: Table(
                      columnWidths: const {
                        0: FlexColumnWidth(1.3),
                        1: FlexColumnWidth(4),
                        2: FlexColumnWidth(1.3),
                      },
                      children: [
                        TableRow(children: [
                          const Text(
                            ' Sl.No.',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            'Name',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          Consumer<AttendanceReportProvider>(
                            builder: (context, value, child) =>
                                GestureDetector(
                                    onTap: () {
                                      value.selectAll();
                                      type == 'sms'
                                          ? value.lastList =
                                          value.attendanceList
                                          : print("error");
                                    },
                                    child: value.isselectAll
                                        ? Padding(
                                      padding:
                                      const EdgeInsets.only(
                                          left: 15),
                                      child: SvgPicture.asset(
                                        UIGuide.check,
                                        color: UIGuide.light_Purple,
                                      ),
                                    )
                                        : const Text(
                                      'Select All',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight:
                                          FontWeight.bold,
                                          color:
                                          UIGuide.light_Purple),
                                    )),
                          )
                        ])
                      ],
                    ),
                  ),
                ),
                Consumer<AttendanceReportProvider>(
                  builder: (context, value, child) {
                    return
                      // value.loading
                      //     ? Expanded(
                      //         child: Center(child: spinkitLoader()),
                      //       )
                      //     :
                      Expanded(
                        child: Scrollbar(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: value.attendanceList.isEmpty
                                ? 0
                                : value.attendanceList.length,
                            itemBuilder: ((context, index) {
                              return Container(
                                decoration: BoxDecoration(
                                  color: index.isEven
                                      ? Colors.white
                                      : const Color.fromARGB(255, 241, 243, 245),
                                  border: Border.all(
                                      color: UIGuide.light_black, width: 1),
                                ),
                                child: Attendance_List_Vie(
                                  viewStud: value.attendanceList[index],
                                  indexx: index,
                                ),
                              );
                            }),
                          ),
                        ),
                      );
                  },
                ),

                if (snap.loading) pleaseWaitLoader()
              ],
            ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 3.0,
        child: Padding(
          padding:
          const EdgeInsets.only(left: 10, right: 10, bottom: 2, top: 2),
          child: Consumer<AttendanceReportProvider>(
            builder: (context, value, child) => value.attendanceList.isEmpty
                ? const SizedBox(
              height: 0,
              width: 0,
            )
                : MaterialButton(
              color: UIGuide.light_Purple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
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
                          borderRadius:
                          BorderRadius.all(Radius.circular(10)),
                        ),
                        duration: Duration(seconds: 1),
                        margin: EdgeInsets.only(
                            bottom: 80, left: 30, right: 30),
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

class Attendance_List_Vie extends StatefulWidget {
  final AttendanceModel viewStud;
  const Attendance_List_Vie(
      {Key? key, required this.viewStud, required this.indexx})
      : super(key: key);
  final int indexx;
  @override
  State<Attendance_List_Vie> createState() => _Attendance_List_VieState();
}

class _Attendance_List_VieState extends State<Attendance_List_Vie> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var p = Provider.of<AttendenceStaffProvider>(context, listen: false);
      p.setLoad(false);
      var c = Provider.of<AttendanceReportProvider>(context, listen: false);
      c.selectItem(widget.viewStud);


    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AttendanceReportProvider>(
      builder: (context, value, child) => ListTile(
        dense: true,
        titleAlignment: ListTileTitleAlignment.center,
        shape: const RoundedRectangleBorder(),
        leading: Text(
          "${widget.indexx + 1}",
          textAlign: TextAlign.center,
        ),
        title: Text(
          widget.viewStud.name ?? "--",
          style: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.w600, color: UIGuide.BLACK),
        ),
        subtitle: Row(
          children: [
            const Text("Division: "),
            Expanded(child: Text(widget.viewStud.division ?? '---')),
          ],
        ),
        onTap: () {
          value.selectItem(widget.viewStud);
        },
        trailing: widget.viewStud.selected != null && widget.viewStud.selected!
            ? SvgPicture.asset(
          UIGuide.check,
          color: UIGuide.light_Purple,
        )
            : SvgPicture.asset(
          UIGuide.notcheck,
          color: UIGuide.light_Purple,
        ),
      ),
    );
  }
}
