import 'package:essconnect/Application/Staff_Providers/Attendencestaff.dart';
import 'package:essconnect/utils/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../Constants.dart';
import '../../utils/constants.dart';

class AttendenceEntry extends StatefulWidget {
  const AttendenceEntry({Key? key}) : super(key: key);

  @override
  State<AttendenceEntry> createState() => _AttendenceEntryState();
}

class _AttendenceEntryState extends State<AttendenceEntry> {
  String? forattd;
  String? aftattd;
  // DateTime? curdate;
  // String? newdate;
  // String dateFinal = '--';
  // DateTime? _mydatetime;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var p = Provider.of<AttendenceStaffProvider>(context, listen: false);
      await p.setLoad(false);
      await p.setLoadDivision(false);
      await p.setLoading(false);
      p.getDateNow();
      // curdate = DateTime.now();
      // newdate = DateFormat('yyyy-MM-dd').format(curdate!);
      // dateFinal = newdate!;
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

  String courseId = '';
  String partId = '';
  String subjectId = '';
  String divisionId = '';
  final markEntryInitialValuesController = TextEditingController();
  final markEntryInitialValuesController1 = TextEditingController();
  final markEntryDivisionListController = TextEditingController();
  final markEntryDivisionListController1 = TextEditingController();
  int forecount = 0;
  int aftcount = 0;
  @override
  Widget build(BuildContext context) {
    print("------------------------");
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Attendance Entry',
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
      body: Consumer<AttendenceStaffProvider>(builder: (context, value, child) {
        return value.load
            ? spinkitLoader()
            : WillPopScope(
                onWillPop: () async {
                  if (value.studentsAttendenceView.isNotEmpty) {
                    bool result = await showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          title: const Text('Are you sure?'),
                          content: const Text(
                              'Do you want to go back without Saving'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(false);

                                // Close the Entire screen
                              },
                              child: const Text('Yes',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: UIGuide.BLACK)),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(true);
                                // Close the Alertdialog
                              },
                              child: const Text(
                                'No',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: UIGuide.BLACK),
                              ),
                            ),
                          ],
                        );
                      },
                    );

                    return !(result);
                  } else {
                    return true;
                  }
                },
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              kWidth,
                              Expanded(
                                child: SizedBox(
                                  height: 45,
                                  child: Consumer<AttendenceStaffProvider>(
                                      builder: (context, snapshot, child) {
                                    return ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        elevation: 3,
                                        foregroundColor: UIGuide.light_Purple,
                                        backgroundColor: UIGuide.WHITE,
                                        padding: const EdgeInsets.all(0),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            side: const BorderSide(
                                              color: UIGuide.light_black,
                                            )),
                                      ),
                                      onPressed: () async {
                                        if (value.studentsAttendenceView
                                            .isNotEmpty) {
                                          await showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                title:
                                                    const Text('Are you sure?'),
                                                content: const Text(
                                                    'Do you want to change course without Saving'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () async {
                                                      await value
                                                          .clearStudentList();
                                                      Navigator.of(context)
                                                          .pop(true);

                                                      // Close the Entire screen
                                                    },
                                                    child: const Text('Yes',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                UIGuide.BLACK)),
                                                  ),
                                                  TextButton(
                                                    onPressed: () async {
                                                      Navigator.of(context)
                                                          .pop(true);
                                                      // Close the Alertdialog
                                                    },
                                                    child: const Text(
                                                      'No',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: UIGuide.BLACK),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        } else {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return Dialog(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15)),
                                                    child: LimitedBox(
                                                      maxHeight:
                                                          size.height / 1.3,
                                                      child: ListView.builder(
                                                          shrinkWrap: true,
                                                          itemCount:
                                                              attendecourse!
                                                                  .length,
                                                          itemBuilder:
                                                              (context, index) {
                                                            return ListTile(
                                                              onTap: () async {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                                //markEntryDivisionListController.clear();
                                                                markEntryDivisionListController1
                                                                    .clear();
                                                                markEntryDivisionListController
                                                                    .clear();
                                                                snapshot
                                                                    .clearStudentList();
                                                                markEntryInitialValuesController
                                                                        .text =
                                                                    await attendecourse![index]
                                                                            [
                                                                            'value'] ??
                                                                        '--';
                                                                markEntryInitialValuesController1
                                                                        .text =
                                                                    await attendecourse![index]
                                                                            [
                                                                            'text'] ??
                                                                        '--';
                                                                courseId =
                                                                    markEntryInitialValuesController
                                                                        .text
                                                                        .toString();

                                                                print(courseId);

                                                                await Provider.of<
                                                                            AttendenceStaffProvider>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .divisionClear();

                                                                await Provider.of<
                                                                            AttendenceStaffProvider>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .getAttendenceDivisionValues(
                                                                        courseId);
                                                              },
                                                              title: Text(
                                                                attendecourse![
                                                                            index]
                                                                        [
                                                                        'text'] ??
                                                                    '--',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                            );
                                                          }),
                                                    ));
                                              });
                                        }
                                      },
                                      child: TextField(
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: UIGuide.BLACK,
                                            overflow: TextOverflow.clip),
                                        textAlign: TextAlign.center,
                                        controller:
                                            markEntryInitialValuesController1,
                                        decoration: const InputDecoration(
                                          contentPadding:
                                              EdgeInsets.only(left: 0, top: 0),
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.never,
                                          filled: true,
                                          fillColor: Colors.transparent,
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                style: BorderStyle.none,
                                                width: 0),
                                          ),
                                          labelText: "  Select Course",
                                          hintText: "Course",
                                        ),
                                        enabled: false,
                                      ),
                                    );
                                  }),
                                ),
                              ),
                              kWidth,
                              value.loadDivision
                                  ? Expanded(
                                      child: Container(
                                        height: 45,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: UIGuide.light_Purple,
                                              width: 1),
                                        ),
                                        child: const Center(
                                          child: Text("Loading..."),
                                        ),
                                      ),
                                    )
                                  : Expanded(
                                      child: SizedBox(
                                        height: 45,
                                        child:
                                            Consumer<AttendenceStaffProvider>(
                                                builder:
                                                    (context, snapshot, child) {
                                          return ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              elevation: 3,
                                              foregroundColor:
                                                  UIGuide.light_Purple,
                                              backgroundColor:
                                                  UIGuide.ButtonBlue,
                                              padding: const EdgeInsets.all(0),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  side: const BorderSide(
                                                    color: UIGuide.light_black,
                                                  )),
                                            ),
                                            onPressed: () async {
                                              if (value.studentsAttendenceView
                                                  .isNotEmpty) {
                                                await showDialog(
                                                  context: context,
                                                  barrierDismissible: false,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15)),
                                                      title: const Text(
                                                          'Are you sure?'),
                                                      content: const Text(
                                                          'Do you want to change division without Saving'),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () async {
                                                            await value
                                                                .clearStudentList();
                                                            Navigator.of(
                                                                    context)
                                                                .pop(true);

                                                            // Close the Entire screen
                                                          },
                                                          child: const Text(
                                                              'Yes',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: UIGuide
                                                                      .BLACK)),
                                                        ),
                                                        TextButton(
                                                          onPressed: () async {
                                                            Navigator.of(
                                                                    context)
                                                                .pop(true);
                                                            // Close the Alertdialog
                                                            // Close the current form the parial
                                                          },
                                                          child: const Text(
                                                            'No',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: UIGuide
                                                                    .BLACK),
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              } else {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return Dialog(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15)),
                                                          child: LimitedBox(
                                                            maxHeight:
                                                                size.height /
                                                                    1.3,
                                                            child: ListView
                                                                .builder(
                                                                    shrinkWrap:
                                                                        true,
                                                                    itemCount: snapshot
                                                                        .attendenceDivisionList
                                                                        .length,
                                                                    itemBuilder:
                                                                        (context,
                                                                            index) {
                                                                      return ListTile(
                                                                        onTap:
                                                                            () async {
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                          markEntryDivisionListController.text =
                                                                              snapshot.attendenceDivisionList[index].value ?? '---';
                                                                          markEntryDivisionListController1.text =
                                                                              snapshot.attendenceDivisionList[index].text ?? '---';
                                                                          divisionId = markEntryDivisionListController
                                                                              .text
                                                                              .toString();
                                                                          courseId = markEntryInitialValuesController
                                                                              .text
                                                                              .toString();
                                                                          snapshot
                                                                              .clearStudentList();
                                                                        },
                                                                        title:
                                                                            Text(
                                                                          snapshot.attendenceDivisionList[index].text ??
                                                                              '---',
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                        ),
                                                                      );
                                                                    }),
                                                          ));
                                                    });
                                              }
                                            },
                                            child: TextField(
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: UIGuide.BLACK,
                                                  overflow: TextOverflow.clip),
                                              textAlign: TextAlign.center,
                                              controller:
                                                  markEntryDivisionListController1,
                                              decoration: const InputDecoration(
                                                contentPadding: EdgeInsets.only(
                                                    left: 0, top: 0),
                                                floatingLabelBehavior:
                                                    FloatingLabelBehavior.never,
                                                filled: true,
                                                fillColor: Colors.transparent,
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      style: BorderStyle.none,
                                                      width: 0),
                                                ),
                                                labelText: "  Select Division",
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
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8, right: 8, bottom: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              kWidth,
                              Expanded(
                                child: SizedBox(
                                  height: 38,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        elevation: 3,
                                        foregroundColor: UIGuide.light_Purple,
                                        backgroundColor: UIGuide.ButtonBlue,
                                        padding: const EdgeInsets.all(0),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            side: const BorderSide(
                                              color: UIGuide.light_black,
                                            )),
                                      ),
                                      child: Text(
                                        "🗓️    ${value.dateDisplay}",
                                        style: const TextStyle(
                                            color: UIGuide.light_Purple),
                                      ),
                                      onPressed: () async {
                                        if (value.studentsAttendenceView
                                            .isNotEmpty) {
                                          await showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                title:
                                                    const Text('Are you sure?'),
                                                content: const Text(
                                                    'Do you want to change date without Saving'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () async {
                                                      await value
                                                          .clearStudentList();
                                                      Navigator.of(context)
                                                          .pop(true);

                                                      // Close the Entire screen
                                                    },
                                                    child: const Text('Yes',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                UIGuide.BLACK)),
                                                  ),
                                                  TextButton(
                                                    onPressed: () async {
                                                      Navigator.of(context)
                                                          .pop(true);
                                                      // Close the Alertdialog
                                                      // Close the current form the parial
                                                    },
                                                    child: const Text(
                                                      'No',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: UIGuide.BLACK),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        } else {
                                          await value.getDate(context);
                                        }
                                      }),
                                ),
                              ),
                              kWidth,
                              Expanded(
                                child: SizedBox(
                                  height: 40,
                                  child: value.loading
                                      ? Container(
                                          height: 40,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color: UIGuide.light_Purple,
                                                width: 1),
                                          ),
                                          child: const Center(
                                              child: Text(
                                            "Loading...",
                                            style: TextStyle(
                                                color: UIGuide.light_Purple,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          )))
                                      : ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            elevation: 3,
                                            foregroundColor: UIGuide.WHITE,
                                            backgroundColor:
                                                UIGuide.light_Purple,
                                            padding: const EdgeInsets.all(0),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                side: const BorderSide(
                                                  color: UIGuide.light_black,
                                                )),
                                          ),
                                          child: const Text(
                                            'View',
                                            style: TextStyle(
                                                color: UIGuide.WHITE,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          onPressed: () async {
                                            print(value.dateSend);
                                            if (value.dateSend.isEmpty) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                elevation: 10,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10)),
                                                ),
                                                duration: Duration(seconds: 1),
                                                margin: EdgeInsets.only(
                                                    bottom: 80,
                                                    left: 30,
                                                    right: 30),
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                content: Text(
                                                  "Select Date..!",
                                                  textAlign: TextAlign.center,
                                                ),
                                              ));
                                            } else if (markEntryInitialValuesController
                                                    .text.isEmpty ||
                                                markEntryDivisionListController
                                                    .text.isEmpty) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                elevation: 10,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10)),
                                                ),
                                                duration: Duration(seconds: 1),
                                                margin: EdgeInsets.only(
                                                    bottom: 80,
                                                    left: 30,
                                                    right: 30),
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                content: Text(
                                                  "Select mandatory fields...!",
                                                  textAlign: TextAlign.center,
                                                ),
                                              ));
                                            } else {
                                              await value.clearStudentList();

                                              await value
                                                  .getstudentsAttendenceView(
                                                      value.dateSend,
                                                      divisionId);
                                            }
                                          }),
                                ),
                              ),
                              kWidth
                            ],
                          ),
                        ),
                        Consumer<AttendenceStaffProvider>(
                          builder: (context, val, child) =>
                              val.isDualAttendance == false
                                  ? Expanded(
                                      child: Column(
                                        children: [
                                          value.studentsAttendenceView.isEmpty
                                              ? const SizedBox(
                                                  height: 0,
                                                  width: 0,
                                                )
                                              : Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: Table(
                                                    border: TableBorder.all(
                                                        color: const Color
                                                            .fromARGB(255, 255,
                                                            255, 255)),
                                                    columnWidths: const {
                                                      0: FlexColumnWidth(.8),
                                                      1: FlexColumnWidth(3),
                                                      2: FlexColumnWidth(1.2),
                                                    },
                                                    children: const [
                                                      TableRow(
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Color.fromARGB(
                                                                      255,
                                                                      211,
                                                                      211,
                                                                      211),
                                                              borderRadius: BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          12),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          12))),
                                                          children: [
                                                            TableCell(
                                                              verticalAlignment:
                                                                  TableCellVerticalAlignment
                                                                      .middle,
                                                              child: SizedBox(
                                                                height: 35,
                                                                child: Center(
                                                                    child: Text(
                                                                  'Roll No.',
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontSize:
                                                                          13),
                                                                )),
                                                              ),
                                                            ),
                                                            TableCell(
                                                              verticalAlignment:
                                                                  TableCellVerticalAlignment
                                                                      .middle,
                                                              child: SizedBox(
                                                                height: 35,
                                                                child: Center(
                                                                  child: Text(
                                                                    'Name',
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        fontSize:
                                                                            13),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            TableCell(
                                                              verticalAlignment:
                                                                  TableCellVerticalAlignment
                                                                      .middle,
                                                              child: SizedBox(
                                                                height: 35,
                                                                child: Center(
                                                                    child: Text(
                                                                  'Attendance',
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontSize:
                                                                          13),
                                                                )),
                                                              ),
                                                            ),
                                                          ]),
                                                    ],
                                                  ),
                                                ),
                                          Consumer<AttendenceStaffProvider>(
                                            builder: (context, value, child) {
                                              return
                                                  //  value.loading
                                                  // ? Expanded(
                                                  //     child: spinkitLoader())
                                                  // :
                                                  Expanded(
                                                child: Scrollbar(
                                                  child: ListView.builder(
                                                    physics:
                                                        const BouncingScrollPhysics(
                                                            parent:
                                                                AlwaysScrollableScrollPhysics()),
                                                    shrinkWrap: true,
                                                    itemCount: value
                                                        .studentsAttendenceView
                                                        .length,
                                                    itemBuilder:
                                                        ((context, index) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 4.0,
                                                                right: 4,
                                                                top: 2,
                                                                bottom: 2),
                                                        child: Table(
                                                          border: TableBorder.all(
                                                              color: const Color
                                                                  .fromARGB(
                                                                  255,
                                                                  247,
                                                                  244,
                                                                  244)),
                                                          columnWidths: const {
                                                            0: FlexColumnWidth(
                                                                .8),
                                                            1: FlexColumnWidth(
                                                                3),
                                                            2: FlexColumnWidth(
                                                                1.2),
                                                          },
                                                          children: [
                                                            TableRow(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: value.studentsAttendenceView[0].studAttId !=
                                                                          null
                                                                      ? const Color
                                                                          .fromARGB(
                                                                          255,
                                                                          223,
                                                                          223,
                                                                          223)
                                                                      : index
                                                                              .isEven
                                                                          ? const Color
                                                                              .fromARGB(
                                                                              255,
                                                                              255,
                                                                              255,
                                                                              255)
                                                                          : const Color
                                                                              .fromARGB(
                                                                              255,
                                                                              236,
                                                                              236,
                                                                              236),
                                                                ),
                                                                children: [
                                                                  TableCell(
                                                                    verticalAlignment:
                                                                        TableCellVerticalAlignment
                                                                            .middle,
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Text(
                                                                        value.studentsAttendenceView[index].rollNo ==
                                                                                null
                                                                            ? '0'
                                                                            : value.studentsAttendenceView[index].rollNo.toString(),
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                12),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  TableCell(
                                                                    verticalAlignment:
                                                                        TableCellVerticalAlignment
                                                                            .middle,
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              4,
                                                                          top:
                                                                              4,
                                                                          bottom:
                                                                              4),
                                                                      child:
                                                                          Text(
                                                                        value.studentsAttendenceView[index].name ??
                                                                            '--',
                                                                        textAlign:
                                                                            TextAlign.start,
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.w500),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  TableCell(
                                                                    verticalAlignment:
                                                                        TableCellVerticalAlignment
                                                                            .middle,
                                                                    child:
                                                                        InkWell(
                                                                      onTap:
                                                                          () async {
                                                                        setState(
                                                                            () {
                                                                          if (value.studentsAttendenceView[index].forenoon == 'A' &&
                                                                              value.studentsAttendenceView[index].afternoon == 'A') {
                                                                            value.studentsAttendenceView[index].afternoon =
                                                                                'P';
                                                                            value.studentsAttendenceView[index].forenoon =
                                                                                'P';
                                                                          } else {
                                                                            value.studentsAttendenceView[index].afternoon =
                                                                                'A';
                                                                            value.studentsAttendenceView[index].forenoon =
                                                                                'A';
                                                                          }
                                                                          forattd = value
                                                                              .studentsAttendenceView[index]
                                                                              .forenoon;
                                                                          aftattd = value
                                                                              .studentsAttendenceView[index]
                                                                              .afternoon;
                                                                          print(
                                                                              "Forenonnn   $forattd");
                                                                          print(
                                                                              "afternoon   $aftattd");
                                                                        });
                                                                      },
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            4.0),
                                                                        child:
                                                                            SizedBox(
                                                                          width:
                                                                              28,
                                                                          height:
                                                                              28,
                                                                          child: value.studentsAttendenceView[index].forenoon == 'A' && value.studentsAttendenceView[index].afternoon == 'A'
                                                                              ? SvgPicture.asset(
                                                                                  UIGuide.absent,
                                                                                )
                                                                              : SvgPicture.asset(
                                                                                  UIGuide.present,
                                                                                ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ]),
                                                          ],
                                                        ),
                                                      );
                                                    }),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    )
                                  : Expanded(
                                      child: Column(
                                        children: [
                                          value.studentsAttendenceView.isEmpty
                                              ? const SizedBox(
                                                  height: 0,
                                                  width: 0,
                                                )
                                              : Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Table(
                                                    border: TableBorder.all(
                                                        color: const Color
                                                            .fromARGB(255, 255,
                                                            255, 255)),
                                                    columnWidths: const {
                                                      0: FlexColumnWidth(1),
                                                      1: FlexColumnWidth(3),
                                                      2: FlexColumnWidth(1.5),
                                                      3: FlexColumnWidth(1.5),
                                                    },
                                                    children: const [
                                                      TableRow(
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Color.fromARGB(
                                                                      255,
                                                                      211,
                                                                      211,
                                                                      211),
                                                              borderRadius: BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          12),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          12))),
                                                          children: [
                                                            TableCell(
                                                              verticalAlignment:
                                                                  TableCellVerticalAlignment
                                                                      .middle,
                                                              child: SizedBox(
                                                                height: 35,
                                                                child: Center(
                                                                    child: Text(
                                                                  'Roll No.',
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontSize:
                                                                          12),
                                                                )),
                                                              ),
                                                            ),
                                                            TableCell(
                                                              verticalAlignment:
                                                                  TableCellVerticalAlignment
                                                                      .middle,
                                                              child: SizedBox(
                                                                height: 35,
                                                                child: Center(
                                                                  child: Text(
                                                                    'Name           ',
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        fontSize:
                                                                            12),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            TableCell(
                                                              verticalAlignment:
                                                                  TableCellVerticalAlignment
                                                                      .middle,
                                                              child: SizedBox(
                                                                height: 35,
                                                                child: Center(
                                                                    child: Text(
                                                                  'Forenoon',
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontSize:
                                                                          12),
                                                                )),
                                                              ),
                                                            ),
                                                            TableCell(
                                                              verticalAlignment:
                                                                  TableCellVerticalAlignment
                                                                      .middle,
                                                              child: SizedBox(
                                                                height: 35,
                                                                child: Center(
                                                                    child: Text(
                                                                  'Afternoon',
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontSize:
                                                                          12),
                                                                )),
                                                              ),
                                                            ),
                                                          ]),
                                                    ],
                                                  ),
                                                ),
                                          Consumer<AttendenceStaffProvider>(
                                              builder: (context, value, child) {
                                            return
                                                // value.loading
                                                //     ? Expanded(child: spinkitLoader())
                                                //     :
                                                Expanded(
                                              child: Scrollbar(
                                                child: ListView.builder(
                                                  physics:
                                                      const BouncingScrollPhysics(
                                                          parent:
                                                              AlwaysScrollableScrollPhysics()),
                                                  shrinkWrap: true,
                                                  itemCount: value
                                                      .studentsAttendenceView
                                                      .length,
                                                  itemBuilder:
                                                      ((context, index) {
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 4.0,
                                                              right: 4,
                                                              top: 2,
                                                              bottom: 2),
                                                      child: Table(
                                                        border: TableBorder.all(
                                                            color: const Color
                                                                .fromARGB(255,
                                                                247, 244, 244)),
                                                        columnWidths: const {
                                                          0: FlexColumnWidth(
                                                              1.0),
                                                          1: FlexColumnWidth(3),
                                                          2: FlexColumnWidth(
                                                              1.5),
                                                          3: FlexColumnWidth(
                                                              1.5),
                                                        },
                                                        children: [
                                                          TableRow(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: value
                                                                          .studentsAttendenceView[
                                                                              0]
                                                                          .studAttId !=
                                                                      null
                                                                  ? const Color
                                                                      .fromARGB(
                                                                      255,
                                                                      223,
                                                                      223,
                                                                      223)
                                                                  : index.isEven
                                                                      ? const Color
                                                                          .fromARGB(
                                                                          255,
                                                                          255,
                                                                          255,
                                                                          255)
                                                                      : const Color
                                                                          .fromARGB(
                                                                          255,
                                                                          231,
                                                                          231,
                                                                          231),
                                                            ),
                                                            children: [
                                                              TableCell(
                                                                verticalAlignment:
                                                                    TableCellVerticalAlignment
                                                                        .middle,
                                                                child: Center(
                                                                  child: Text(
                                                                    value.studentsAttendenceView[index].rollNo ==
                                                                            null
                                                                        ? '0'
                                                                        : value
                                                                            .studentsAttendenceView[index]
                                                                            .rollNo
                                                                            .toString(),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            12),
                                                                  ),
                                                                ),
                                                              ),
                                                              TableCell(
                                                                verticalAlignment:
                                                                    TableCellVerticalAlignment
                                                                        .middle,
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              4,
                                                                          top:
                                                                              4,
                                                                          bottom:
                                                                              4),
                                                                  child: Text(
                                                                    value.studentsAttendenceView[index]
                                                                            .name ??
                                                                        '--',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            14),
                                                                  ),
                                                                ),
                                                              ),
                                                              TableCell(
                                                                verticalAlignment:
                                                                    TableCellVerticalAlignment
                                                                        .middle,
                                                                child: InkWell(
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      if (value
                                                                              .studentsAttendenceView[index]
                                                                              .forenoon ==
                                                                          'A') {
                                                                        value.studentsAttendenceView[index].forenoon =
                                                                            'P';
                                                                      } else {
                                                                        value.studentsAttendenceView[index].forenoon =
                                                                            'A';
                                                                      }
                                                                      forattd = value
                                                                          .studentsAttendenceView[
                                                                              index]
                                                                          .forenoon;

                                                                      print(
                                                                          "Forenonnn   $forattd");
                                                                    });
                                                                  },
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            1.0),
                                                                    child:
                                                                        SizedBox(
                                                                      width: 28,
                                                                      height:
                                                                          28,
                                                                      child: value.studentsAttendenceView[index].forenoon ==
                                                                              'A'
                                                                          ? SvgPicture
                                                                              .asset(
                                                                              UIGuide.absent,
                                                                            )
                                                                          : SvgPicture
                                                                              .asset(
                                                                              UIGuide.present,
                                                                            ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              TableCell(
                                                                verticalAlignment:
                                                                    TableCellVerticalAlignment
                                                                        .middle,
                                                                child: InkWell(
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      if (value
                                                                              .studentsAttendenceView[index]
                                                                              .afternoon ==
                                                                          'A') {
                                                                        value.studentsAttendenceView[index].afternoon =
                                                                            'P';
                                                                      } else {
                                                                        value.studentsAttendenceView[index].afternoon =
                                                                            'A';
                                                                      }
                                                                      forattd = value
                                                                          .studentsAttendenceView[
                                                                              index]
                                                                          .afternoon;

                                                                      print(
                                                                          "Forenonnn   $aftattd");
                                                                    });
                                                                  },
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            1.0),
                                                                    child:
                                                                        SizedBox(
                                                                      width: 28,
                                                                      height:
                                                                          28,
                                                                      child: value.studentsAttendenceView[index].afternoon ==
                                                                              'A'
                                                                          ? SvgPicture
                                                                              .asset(
                                                                              UIGuide.absent,
                                                                            )
                                                                          : SvgPicture
                                                                              .asset(
                                                                              UIGuide.present,
                                                                            ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  }),
                                                ),
                                              ),
                                            );
                                          }),
                                        ],
                                      ),
                                    ),
                        )
                      ],
                    ),
                    if (value.loading)
                      WillPopScope(
                        onWillPop: () async {
                          return false;
                        },
                        child: Container(
                          color: Colors.black.withOpacity(0.2),
                          child: Center(
                            child: Container(
                              decoration:
                                  const BoxDecoration(color: UIGuide.WHITE),
                              child: const Padding(
                                padding: EdgeInsets.all(15.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircularProgressIndicator(
                                      color: UIGuide.light_Purple,
                                      strokeWidth: 2,
                                    ),
                                    kWidth,
                                    Text(
                                      "Please Wait...",
                                      style: TextStyle(
                                          color: UIGuide.light_Purple,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              );
      }),
      bottomNavigationBar:
          Consumer<AttendenceStaffProvider>(builder: (context, val, child) {
        return val.studentsAttendenceView.isEmpty
            ? const SizedBox(
                height: 0,
                width: 0,
              )
            : Stack(
                children: [
                  BottomAppBar(
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          kWidth,
                          const Spacer(),
                          Consumer<AttendenceStaffProvider>(
                              builder: (context, value, child) {
                            return
                                //  value.loading
                                //     ? MaterialButton(
                                //         minWidth: 100,
                                //         shape: RoundedRectangleBorder(
                                //           borderRadius: BorderRadius.circular(10.0),
                                //         ),
                                //         onPressed: () async {},
                                //         color: UIGuide.WHITE,
                                //         child: const Text(
                                //           'Saving....',
                                //           style: TextStyle(color: UIGuide.light_Purple),
                                //         ),
                                //       )
                                //     :
                                MaterialButton(
                              minWidth: 100,
                              onPressed: value.loading
                                  ? null
                                  : () async {
                                      List obj = [];
                                      forecount = 0;
                                      aftcount = 0;
                                      obj.clear();
                                      print(
                                          "length:  ${value.studentsAttendenceView.length}");
                                      for (int i = 0;
                                          i <
                                              value.studentsAttendenceView
                                                  .length;
                                          i++) {
                                        obj.add({
                                          "studAttId": value
                                              .studentsAttendenceView[i]
                                              .studAttId,
                                          "divisionId": value
                                              .studentsAttendenceView[i]
                                              .divisionId,
                                          "id": value
                                              .studentsAttendenceView[i].id,
                                          "forenoon": value
                                              .studentsAttendenceView[i]
                                              .forenoon,
                                          "afternoon": value
                                              .studentsAttendenceView[i]
                                              .afternoon,
                                          "admNo": value
                                              .studentsAttendenceView[i].admNo,
                                          "rollNo": value
                                              .studentsAttendenceView[i].rollNo,
                                          "name": value
                                              .studentsAttendenceView[i].name,
                                          "terminatedStatus": value
                                              .studentsAttendenceView[i]
                                              .terminatedStatus,
                                        });
                                        value.studentsAttendenceView[i]
                                                    .forenoon ==
                                                'A'
                                            ? forecount = forecount + 1
                                            : forecount;
                                        print("count ,$forecount");
                                        value.studentsAttendenceView[i]
                                                    .afternoon ==
                                                'A'
                                            ? aftcount = aftcount + 1
                                            : aftcount;
                                      }

                                      if (markEntryDivisionListController
                                              .text.isEmpty ||
                                          markEntryInitialValuesController
                                              .text.isEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          elevation: 10,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                          ),
                                          duration: Duration(seconds: 1),
                                          margin: EdgeInsets.only(
                                              bottom: 80, left: 30, right: 30),
                                          behavior: SnackBarBehavior.floating,
                                          content: Text(
                                            "Select mandatory fields...!",
                                            textAlign: TextAlign.center,
                                          ),
                                        ));
                                      } else if (obj.isEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          elevation: 10,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                          ),
                                          duration: Duration(seconds: 1),
                                          margin: EdgeInsets.only(
                                              bottom: 80, left: 30, right: 30),
                                          behavior: SnackBarBehavior.floating,
                                          content: Text(
                                            "No data to save...",
                                            textAlign: TextAlign.center,
                                          ),
                                        ));
                                      } else {
                                        await value.attendanceSave(
                                            context,
                                            obj,
                                            value.dateSend,
                                            forecount,
                                            aftcount);
                                      }
                                    },
                              color: UIGuide.light_Purple,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: const Text(
                                'Save',
                                style: TextStyle(color: Colors.white),
                              ),
                            );
                          }),
                          kWidth,
                          Consumer<AttendenceStaffProvider>(
                              builder: (context, value, child) {
                            divisionId =
                                markEntryDivisionListController.text.toString();
                            return
                                // value.loading
                                //     ? MaterialButton(
                                //         minWidth: 100,
                                //         onPressed: () async {},
                                //         color: UIGuide.WHITE,
                                //         shape: RoundedRectangleBorder(
                                //           borderRadius: BorderRadius.circular(10.0),
                                //         ),
                                //         child: const Text(
                                //           'Deleting....',
                                //           style: TextStyle(color: Colors.red),
                                //         ),
                                //       )
                                //     :
                                MaterialButton(
                              minWidth: 100,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              onPressed: value.loading
                                  ? null
                                  : () {
                                      value.studentsAttendenceView[0]
                                                  .studAttId ==
                                              null
                                          ? ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                              elevation: 10,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20)),
                                              ),
                                              duration: Duration(seconds: 1),
                                              margin: EdgeInsets.only(
                                                  bottom: 80,
                                                  left: 30,
                                                  right: 30),
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              content: Text(
                                                'No data to delete....',
                                                textAlign: TextAlign.center,
                                              ),
                                            ))
                                          : showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: const Center(
                                                    child: Text(
                                                      "Are You Sure Want To Delete",
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                  ),
                                                  actions: <Widget>[
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 8.0),
                                                          child: OutlinedButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            style: ButtonStyle(
                                                                side: MaterialStateProperty.all(const BorderSide(
                                                                    color: UIGuide
                                                                        .light_Purple,
                                                                    width: 1.0,
                                                                    style: BorderStyle
                                                                        .solid))),
                                                            child: const Text(
                                                              '  Cancel  ',
                                                              style: TextStyle(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        201,
                                                                        13,
                                                                        13),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        OutlinedButton(
                                                          onPressed: () async {
                                                            await value
                                                                .attendanceDelete(
                                                                    divisionId,
                                                                    value
                                                                        .dateSend,
                                                                    context);
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          style: ButtonStyle(
                                                              side: MaterialStateProperty.all(const BorderSide(
                                                                  color: UIGuide
                                                                      .light_Purple,
                                                                  width: 1.0,
                                                                  style: BorderStyle
                                                                      .solid))),
                                                          child: const Text(
                                                            'Confirm',
                                                            style: TextStyle(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      12,
                                                                      162,
                                                                      46),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                );
                                              },
                                            );
                                    },
                              color: Colors.red,
                              child: const Text(
                                'Delete',
                                style: TextStyle(color: Colors.white),
                              ),
                            );
                          }),
                          kWidth
                        ],
                      ),
                    ),
                  ),
                  if (val.loading)
                    Positioned.fill(
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                ],
              );
      }),
    );
  }
}
