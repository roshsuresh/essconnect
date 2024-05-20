import 'package:essconnect/Application/AdminProviders/SchoolPhotoProviders.dart';
import 'package:essconnect/Application/AdminProviders/StudstattiticsProvider.dart';
import 'package:essconnect/Constants.dart';
import 'package:essconnect/Domain/Staff/StudentReport_staff.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:essconnect/utils/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class Student_statistics_admin extends StatelessWidget {
  Student_statistics_admin({Key? key}) : super(key: key);
  String course = '';
  String section = '';
  List subjectData = [];
  List diviData = [];
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Provider.of<StudStatiticsProvider>(context, listen: false)
          .clearStaticsList();
      await Provider.of<StudStatiticsProvider>(context, listen: false)
          .clearTotalList();
      var p = Provider.of<SchoolPhotoProviders>(context, listen: false);
      p.stdReportSectionStaff();
      p.courseDrop.clear();
      p.dropDown.clear();
      p.stdReportInitialValues.clear();
      p.courselist.clear();
      p.courseCounter(0);
      p.sectionCounter(0);
    });
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              const Spacer(),
              const Text(
                'Student Statistics',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const Spacer(),
              IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.leftToRight,
                            child: this,
                            duration: const Duration(milliseconds: 400),
                            childCurrent: this));
                  },
                  icon: const Icon(Icons.refresh_outlined)),
              kWidth
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
        body: Consumer<StudStatiticsProvider>(
          builder: (context, val, _) => Column(
            children: [
              kheight10,
              Row(
                children: [
                  const Spacer(),
                  Consumer<SchoolPhotoProviders>(
                    builder: (context, value, child) => SizedBox(
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
                          borderRadius: BorderRadius.all(Radius.circular(10)),
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
                          value.courseLen = 0;
                          value.divisionLen = 0;
                          await Provider.of<SchoolPhotoProviders>(context,
                                  listen: false)
                              .clearCourse();
                          await Provider.of<StudStatiticsProvider>(context,
                                  listen: false)
                              .clearAllList();

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
                          // await Provider.of<SchoolPhotoProviders>(context,
                          //         listen: false)
                          //     .courseDropClear();
                          diviData.clear();
                          // await Provider.of<SchoolPhotoProviders>(context,
                          //         listen: false)
                          //     .courseListClear();
                          await Provider.of<SchoolPhotoProviders>(context,
                                  listen: false)
                              .sectionCounter(results.length);
                          await Provider.of<SchoolPhotoProviders>(context,
                                  listen: false)
                              .getCourseList(section);

                          print("data $subjectData");

                          print(subjectData.join(','));
                        },
                      ),
                    ),
                  ),
                  const Spacer(),
                  Consumer<SchoolPhotoProviders>(
                    builder: (context, value, child) => SizedBox(
                      width: size.width * .43,
                      height: 50,
                      child: MultiSelectDialogField(
                        // height: 200,
                        items: value.courseDrop,
                        listType: MultiSelectListType.CHIP,
                        title: const Text(
                          "Select Course",
                          style: TextStyle(color: Colors.black),
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
                          borderRadius: BorderRadius.all(Radius.circular(10)),
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
                          await Provider.of<StudStatiticsProvider>(context,
                                  listen: false)
                              .clearAllList();
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
                          print(course);
                        },
                      ),
                    ),
                  ),
                  const Spacer()
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Consumer<StudStatiticsProvider>(
                      builder: (context, value, child) => value.loading
                          ? const SizedBox(
                              height: 40,
                              width: 100,
                              child: Center(
                                  child: Text(
                                'Loading...',
                                style: TextStyle(
                                    color: UIGuide.light_Purple, fontSize: 16),
                              )))
                          : SizedBox(
                              height: 40,
                              width: 130,
                              child: MaterialButton(
                                color: UIGuide.light_Purple,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                onPressed: () async {
                                  value.statiticsList.clear();
                                  value.totalList.clear();
                                  await value.getstatitics(section, course);
                                },
                                child: const Text(
                                  'View',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
              val.statiticsList.isEmpty
                  ? const SizedBox(
                      height: 0,
                      width: 0,
                    )
                  : Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Table(
                        border: TableBorder.all(
                            color: const Color.fromARGB(255, 255, 255, 255)),
                        columnWidths: const {
                          0: FlexColumnWidth(1),
                          1: FlexColumnWidth(2),
                          2: FlexColumnWidth(1),
                          3: FlexColumnWidth(1),
                          4: FlexColumnWidth(1),
                        },
                        children: const [
                          TableRow(
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 211, 211, 211),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      topRight: Radius.circular(12))),
                              children: [
                                SizedBox(
                                  height: 30,
                                  child: Center(
                                      child: Text(
                                    'Sl No.',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12),
                                  )),
                                ),
                                SizedBox(
                                  height: 30,
                                  child: Center(
                                      child: Text(
                                    'Course',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12),
                                  )),
                                ),
                                SizedBox(
                                  height: 30,
                                  child: Center(
                                    child: Text(
                                      'Male',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                  child: Center(
                                      child: Text(
                                    'Female',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12),
                                  )),
                                ),
                                SizedBox(
                                  height: 30,
                                  child: Center(
                                      child: Text(
                                    'Total',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12),
                                  )),
                                ),
                              ]),
                        ],
                      ),
                    ),
              Consumer<StudStatiticsProvider>(builder: (context, value, child) {
                return value.loading
                    ? Expanded(child: spinkitLoader())
                    : Expanded(
                        //flex: 8,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: value.statiticsList.isEmpty
                                  ? 0
                                  : value.statiticsList.length,
                              itemBuilder: ((context, index) {
                                return Table(
                                  border: TableBorder.all(
                                      color: const Color.fromARGB(
                                          255, 247, 244, 244)),
                                  columnWidths: const {
                                    0: FlexColumnWidth(1),
                                    1: FlexColumnWidth(2),
                                    2: FlexColumnWidth(1),
                                    3: FlexColumnWidth(1),
                                    4: FlexColumnWidth(1),
                                  },
                                  children: [
                                    TableRow(
                                        decoration: BoxDecoration(
                                          color: index.isEven
                                              ? const Color.fromARGB(
                                                  255, 255, 255, 255)
                                              : const Color.fromARGB(
                                                  255, 231, 231, 231),
                                        ),
                                        children: [
                                          TableCell(
                                            verticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Text(
                                                (index + 1).toString(),
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    fontSize: 12),
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            verticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5),
                                                child: Text(
                                                  value.statiticsList[index]
                                                          .course ??
                                                      '--',
                                                  textAlign: TextAlign.start,
                                                  style: const TextStyle(
                                                      fontSize: 12),
                                                ),
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            verticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Text(
                                                value.statiticsList[index]
                                                            .male ==
                                                        null
                                                    ? '--'
                                                    : value.statiticsList[index]
                                                        .male
                                                        .toString(),
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    fontSize: 14),
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            verticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Text(
                                                value.statiticsList[index]
                                                            .feMale ==
                                                        null
                                                    ? '--'
                                                    : value.statiticsList[index]
                                                        .feMale
                                                        .toString(),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            verticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Text(
                                                value.statiticsList[index]
                                                            .totalCount ==
                                                        null
                                                    ? '--'
                                                    : value.statiticsList[index]
                                                        .totalCount
                                                        .toString(),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          )
                                        ]),
                                  ],
                                );
                              })),
                        ),
                      );
              }),
              Consumer<StudStatiticsProvider>(
                builder: (context, value, child) => Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount:
                        value.totalList.isEmpty ? 0 : value.totalList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Table(
                        columnWidths: const {
                          0: FlexColumnWidth(1),
                          1: FlexColumnWidth(2),
                          2: FlexColumnWidth(1),
                          3: FlexColumnWidth(1),
                          4: FlexColumnWidth(1),
                        },
                        children: [
                          TableRow(
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                              children: [
                                const SizedBox(
                                  height: 30,
                                  child: Center(
                                      child: Text(
                                    '    ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12),
                                  )),
                                ),
                                const SizedBox(
                                  height: 30,
                                  child: Center(
                                      child: Text(
                                    '   Total:     ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        color: UIGuide.light_Purple,
                                        fontSize: 12),
                                  )),
                                ),
                                SizedBox(
                                  height: 30,
                                  child: Center(
                                    child: Text(
                                      value.totalList[index].netMaleCount ==
                                              null
                                          ? '--'
                                          : value.totalList[index].netMaleCount
                                              .toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w900,
                                          color: UIGuide.light_Purple,
                                          fontSize: 12),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                  child: Center(
                                      child: Text(
                                    value.totalList[index].netFemaleCount ==
                                            null
                                        ? '--'
                                        : value.totalList[index].netFemaleCount
                                            .toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w900,
                                        color: UIGuide.light_Purple,
                                        fontSize: 12),
                                  )),
                                ),
                                SizedBox(
                                  height: 30,
                                  child: Center(
                                      child: Text(
                                    value.totalList[index].netTotal == null
                                        ? '--'
                                        : value.totalList[index].netTotal
                                            .toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w900,
                                        color: UIGuide.light_Purple,
                                        fontSize: 12),
                                  )),
                                ),
                              ]),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
