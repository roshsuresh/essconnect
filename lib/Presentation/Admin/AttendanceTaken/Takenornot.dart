import 'package:essconnect/Application/AdminProviders/Attendanceprovider.dart';
import 'package:essconnect/Application/AdminProviders/SchoolPhotoProviders.dart';
import 'package:essconnect/Constants.dart';
import 'package:essconnect/utils/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';
import '../../../../Domain/Staff/StudentReport_staff.dart';
import '../../../../utils/constants.dart';

class AttendanceTakenReport extends StatefulWidget {
  const AttendanceTakenReport({Key? key}) : super(key: key);

  @override
  State<AttendanceTakenReport> createState() => _AttendanceTakenReportState();
}

class _AttendanceTakenReportState extends State<AttendanceTakenReport> {
  DateTime? _mydatetime;

  List subjectData = [];
  List diviData = [];
  DateTime? curdate;
  String? newdate;
  String timeNow = '--';
  String course = '';
  String section = '';
  String division = '';
  String type = '';

  final index = 0;

  @override
  void initState() {
    curdate = DateTime.now();
    newdate = DateFormat('dd-MMM-yyyy').format(curdate!);
    timeNow = newdate!;
    type = '1';
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var p = Provider.of<SchoolPhotoProviders>(context, listen: false);
      p.stdReportSectionStaff();
      p.courseDrop.clear();
      var c = Provider.of<AttendanceReportProvider>(context, listen: false);
      c.cleartakenList();
      p.dropDown.clear();
      p.stdReportInitialValues.clear();
      p.courselist.clear();
      p.courseCounter(0);
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
              'Attendance Status Report',
            ),
            const Spacer(),
            IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AttendanceTakenReport()));
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
      body: Column(
        children: [
          Row(
            children: [
              const Spacer(),
              Consumer<SchoolPhotoProviders>(
                builder: (context, value, child) => value.loadingSection
                    ? SizedBox(
                    width: size.width * .43,
                    height: 45,
                    child: const Center(child: Text('Loading...')))
                    : Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    width: size.width * .42,
                    height: 45,
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
                      decoration: const BoxDecoration(
                        color: UIGuide.ButtonBlue,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0, 2),
                            blurRadius: 4,
                            spreadRadius: 0,
                          ),
                        ],
                        borderRadius:
                        BorderRadius.all(Radius.circular(10)),
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
                          fontSize: 15,
                        ),
                      )
                          : Text(
                        "   ${value.sectionLen.toString()} Selected",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                      chipDisplay: MultiSelectChipDisplay.none(),
                      onConfirm: (results) async {
                        subjectData = [];
                        diviData.clear();
                        value.clearCourse();
                        await Provider.of<AttendanceReportProvider>(
                            context,
                            listen: false)
                            .cleartakenList();

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
                        await Provider.of<SchoolPhotoProviders>(context,
                            listen: false)
                            .getCourseList(section);
                        print("data $subjectData");

                        print(subjectData.join('&'));
                      },
                    ),
                  ),
                ),
              ),
              //const Spacer(),
              Consumer<SchoolPhotoProviders>(
                builder: (context, value, child) => value.loadingCourse
                    ? SizedBox(
                    width: size.width * .43,
                    height: 45,
                    child: const Center(child: Text('Loading...')))
                    : Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    width: size.width * .42,
                    height: 45,
                    child: MultiSelectDialogField(
                      // height: 200,
                      items: value.courseDrop,
                      listType: MultiSelectListType.CHIP,
                      title: const Text(
                        "Select Course",
                        style: TextStyle(color: Colors.black),
                      ),
                      // selectedColor: Color.fromARGB(255, 157, 232, 241),
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
                      decoration: const BoxDecoration(
                        color: UIGuide.ButtonBlue,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0, 2),
                            blurRadius: 4,
                            spreadRadius: 0,
                          ),
                        ],
                        borderRadius:
                        BorderRadius.all(Radius.circular(10)),
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
                          fontSize: 15,
                        ),
                      )
                          : Text(
                        "   ${value.courseLen.toString()} Selected",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                      chipDisplay: MultiSelectChipDisplay.none(),
                      onConfirm: (results) async {
                        diviData = [];
                        value.clearDivision();
                        await Provider.of<AttendanceReportProvider>(
                            context,
                            listen: false)
                            .cleartakenList();
                        for (var i = 0; i < results.length; i++) {
                          StudReportCourse data =
                          results[i] as StudReportCourse;
                          print(data.value);
                          print(data.text);
                          diviData.add(data.value);
                          diviData.map((e) => data.value);
                          print("${diviData.map((e) => data.value)}");
                        }
                        course = diviData.join(',');
                        await Provider.of<SchoolPhotoProviders>(context,
                            listen: false)
                            .courseCounter(results.length);
                        results.clear();
                        await Provider.of<SchoolPhotoProviders>(context,
                            listen: false)
                            .getDivisionList(course);

                        print(diviData.join(','));
                      },
                    ),
                  ),
                ),
              ),
              const Spacer()
            ],
          ),

          Row(
            children: [
              const Spacer(),
              Radio(
                activeColor: UIGuide.light_Purple,
                value: '0',
                groupValue: type,
                onChanged: (value) async {
                  await Provider.of<AttendanceReportProvider>(
                      context,
                      listen: false)
                      .cleartakenList();
                  setState(() {
                    type = value.toString();
                  });
                  print(type);
                },
              ),
              const Text(
                "Taken",
              ),
              const Spacer(),
              Radio(
                activeColor: UIGuide.light_Purple,
                value: '1',
                groupValue: type,
                onChanged: (value) async {
                  await Provider.of<AttendanceReportProvider>(
                      context,
                      listen: false)
                      .cleartakenList();
                  setState(() {
                    type = value.toString();
                  });
                  print(type);
                },
              ),
              const Text(
                "Not Taken",
              ),
              const Spacer(),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              SizedBox(
                height: 42,
                width: size.width * .42,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 3,
                    foregroundColor: UIGuide.light_Purple,
                    backgroundColor: UIGuide.ButtonBlue,
                    padding: const EdgeInsets.all(0),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: UIGuide.light_black,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: (() async {
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
                    await Provider.of<AttendanceReportProvider>(
                        context,
                        listen: false)
                        .cleartakenList();
                    setState(() {
                      timeNow = DateFormat('dd-MMM-yyyy').format(_mydatetime!);

                      print(timeNow);
                    });
                  }),
                  // minWidth: size.width - 250,
                  child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('🗓️  '),
                          Text(timeNow == '--' ? newdate.toString() : timeNow),
                        ],
                      )),
                ),
              ),
              const Spacer(),
              Consumer<AttendanceReportProvider>(
                builder: (context, loadd, child) => SizedBox(
                  width: size.width * 0.42,
                  height: 42,
                  child: loadd.loading
                      ? Center(
                      child: Container(
                          child: const Text(
                            'Loading Data...',
                            style: TextStyle(
                                color: UIGuide.light_Purple,
                                fontWeight: FontWeight.bold),
                          )))
                      : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 3,
                      foregroundColor: UIGuide.WHITE,
                      backgroundColor: UIGuide.light_Purple,
                      padding: const EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          color: UIGuide.light_black,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: (() async {
                      await Provider.of<AttendanceReportProvider>(context,
                          listen: false)
                          .cleartakenList();

                      await Provider.of<AttendanceReportProvider>(context,
                          listen: false)
                          .getAttendanceTaken(
                          context, timeNow, section, course, type);
                      if (loadd.takenList.isEmpty) {
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
              const Spacer()
            ],
          ),
          kheight20,
          Consumer<AttendanceReportProvider>(
            builder: (context, value, child) => value.loading
                ? Expanded(child: spinkitLoader())
                : Expanded(
              child: Scrollbar(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: value.takenList.isEmpty
                      ? 0
                      : value.takenList.length,
                  itemBuilder: (context, index) {
                    final opted =
                    value.takenList[index].optedStaffs.toString();
                    final optedstaff =
                    opted.substring(1, opted.length - 1);
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        height: type == "0"?size.height*.145:size.height*.12,
                        width: size.width,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color.fromARGB(
                                  255, 176, 179, 179),
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                const EdgeInsets.only(bottom: 1.0),
                                child: Row(
                                  children: [
                                    const Text(
                                      'Sl No : ',
                                    ),
                                    Text(
                                      (index + 1).toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: UIGuide.BLACK),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.only(bottom: 1.0),
                                child: Row(
                                  children: [
                                    const Text(
                                      'Division : ',
                                    ),
                                    Expanded(
                                      child: Text(
                                        value.takenList[index].division ==
                                            null
                                            ? '--'
                                            : "  ${value.takenList[index].division}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: UIGuide.BLACK),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.only(bottom: 1.0),
                                child: Row(
                                  children: [
                                    const Text(
                                      'Class Teacher :',
                                    ),
                                    Expanded(
                                      child: Text(
                                        value.takenList[index]
                                            .classTeacher ==
                                            null
                                            ? '---'
                                            : value.takenList[index]
                                            .classTeacher
                                            .toString(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: UIGuide.BLACK),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.only(bottom: 1.0),
                                child: Row(
                                  children: [
                                    const Text(
                                      'Alotted Staff :',
                                    ),
                                    Flexible(
                                      child: RichText(
                                        overflow: TextOverflow.ellipsis,
                                        strutStyle: const StrutStyle(
                                            fontSize: 12.0),
                                        text: TextSpan(
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight:
                                              FontWeight.w600),
                                          text: optedstaff ?? "--",
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              type == "0"?
                              Padding(
                                padding:
                                const EdgeInsets.only(bottom: 1.0),
                                child: Row(
                                  children: [
                                    const Text(
                                      'Entered/Updated Staff :',
                                    ),
                                    Flexible(
                                      child: RichText(
                                        overflow: TextOverflow.ellipsis,
                                        strutStyle: const StrutStyle(
                                            fontSize: 12.0),
                                        text: TextSpan(
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight:
                                              FontWeight.w600),
                                          text: value.takenList[index].enteredOrUpdatedStaff ==
                                              null
                                              ? '--'
                                              : "  ${value.takenList[index].enteredOrUpdatedStaff}",
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ):
                              SizedBox(width: 0,height: 0,),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          // Table(
          //   border: TableBorder.all(
          //     color: Colors.white,
          //   ),
          //   columnWidths: const {
          //     0: FlexColumnWidth(1),
          //     1: FlexColumnWidth(4),
          //     2: FlexColumnWidth(4),
          //     3: FlexColumnWidth(4),
          //   },
          //   children: [
          //     TableRow(
          //         decoration: BoxDecoration(
          //           color: UIGuide.light_black,
          //         ),
          //         children: [
          //           SizedBox(
          //             child: Center(
          //               child: const Text(
          //                 'Sl.',
          //                 style: TextStyle(
          //                     fontSize: 15, fontWeight: FontWeight.bold),
          //               ),
          //             ),
          //           ),
          //           SizedBox(
          //             child: Center(
          //               child: const Text(
          //                 'Division',
          //                 style: TextStyle(
          //                     fontSize: 15, fontWeight: FontWeight.bold),
          //               ),
          //             ),
          //           ),
          //           SizedBox(
          //             child: Center(
          //               child: const Text(
          //                 'Class Teacher',
          //                 style: TextStyle(
          //                     fontSize: 15, fontWeight: FontWeight.bold),
          //               ),
          //             ),
          //           ),
          //           SizedBox(
          //             child: Center(
          //               child: const Text(
          //                 'Allotted Staff',
          //                 style: TextStyle(
          //                     fontSize: 15, fontWeight: FontWeight.bold),
          //               ),
          //             ),
          //           ),
          //         ])
          //   ],
          // ),
          // Consumer<AttendanceReportProvider>(
          //     builder: (context, value, child) => value.loading
          //         ? spinkitLoader()
          //         : Padding(
          //             padding: const EdgeInsets.only(left: 6, right: 6),
          //             child: LimitedBox(
          //                 maxHeight: size.height / 1.8,
          //                 child: ListView.builder(
          //                     physics: const BouncingScrollPhysics(),
          //                     shrinkWrap: true,
          //                     itemCount: value.takenList.isEmpty
          //                         ? 0
          //                         : value.takenList.length,
          //                     itemBuilder: ((context, index) {
          //                       final opted = value.takenList[index].optedStaffs
          //                           .toString();
          //                       final optedstaff =
          //                           opted.substring(1, opted.length - 1);
          //                       print("opttttt $optedstaff");

          //                       // var updatedDate =
          //                       // DateFormat('yyyy-MM-dd').parse(date);
          //                       // String studID =
          //                       // value.collectionList[index].studentId ?? '';
          //                       // String FeeID =
          //                       // value.collectionList[index].feeCollectionId ??
          //                       // '';
          //                       // String busID = value
          //                       //     .collectionList[index].busFeeCollectionId ??
          //                       // '';
          //                       // var newdate =
          //                       // updatedDate.toString().replaceRange(10, 23, '');
          //                       // print(updatedDate);

          //                       return Padding(
          //                         padding: const EdgeInsets.all(1.0),
          //                         child: Table(
          //                           border: TableBorder.all(
          //                             color: Colors.white,
          //                           ),
          //                           columnWidths: const {
          //                             0: FlexColumnWidth(1),
          //                             1: FlexColumnWidth(4),
          //                             2: FlexColumnWidth(4),
          //                             3: FlexColumnWidth(4),
          //                           },
          //                           children: [
          //                             TableRow(children: [
          //                               SizedBox(
          //                                 child: Center(
          //                                   child: Text(
          //                                     (index + 1).toString(),
          //                                     textAlign: TextAlign.center,
          //                                   ),
          //                                 ),
          //                               ),
          //                               SizedBox(
          //                                 child: Center(
          //                                   child: Text(
          //                                     value.takenList[index].division ==
          //                                             null
          //                                         ? '--'
          //                                         : "  ${value.takenList[index].division}",
          //                                     textAlign: TextAlign.start,
          //                                   ),
          //                                 ),
          //                               ),
          //                               SizedBox(
          //                                 child: Center(
          //                                   child: Text(
          //                                     value.takenList[index]
          //                                                 .classTeacher ==
          //                                             null
          //                                         ? '---'
          //                                         : value.takenList[index]
          //                                             .classTeacher
          //                                             .toString(),
          //                                   ),
          //                                 ),
          //                               ),
          //                               SizedBox(
          //                                 child: Center(
          //                                   child: Text(
          //                                     optedstaff == null
          //                                         ? "--"
          //                                         : optedstaff,
          //                                   ),
          //                                 ),
          //                               ),
          //                             ]),
          //                           ],
          //                         ),
          //                       );
          //                     })))))
        ],
      ),
    );
  }
}
