import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:essconnect/utils/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../Application/StudentProviders/AttendenceProvider.dart';
import '../../Constants.dart';
import '../../utils/constants.dart';

class Attendence extends StatelessWidget {
  const Attendence({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Provider.of<AttendenceProvider>(context, listen: false)
          .attendList
          .clear();
      await Provider.of<AttendenceProvider>(context, listen: false)
          .attendenceList();
    });

    var size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Attendance'),
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
        body: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Consumer<AttendenceProvider>(
            builder: (context, value, child) => value.loading
                ? spinkitLoader()
                : value.attendList.isEmpty
                    ? Container(
                        child: LottieBuilder.network(
                            'https://assets2.lottiefiles.com/private_files/lf30_lkquf6qz.json'),
                      )
                    : Stack(
                        children: [
                          ListView(
                            physics: const BouncingScrollPhysics(),
                            children: [
                              Center(
                                child: Container(
                                  width: size.width - 45,
                                  padding: const EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: UIGuide.light_Purple,
                                          width: .5),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Consumer<AttendenceProvider>(
                                    builder: (_, provider, child) {
                                      return Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Center(
                                            child: Table(
                                              children: [
                                                TableRow(children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      'Working Days : ${provider.workDays == null ? '--' : provider.workDays.toString()}',
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      'Days Present :  ${provider.presentDays == null ? '--' : provider.presentDays.toString()}',
                                                    ),
                                                  ),
                                                ]),
                                                TableRow(children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      'Days Absent : ${provider.absentDays == null ? '--' : provider.absentDays.toString()}',
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                        'Percentage : ${provider.totPercentage == null ? '--' : provider.totPercentage.toString()}'),
                                                  ),
                                                ])
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ),
                              kheight10,
                              Table(
                                columnWidths: const {
                                  0: FlexColumnWidth(3),
                                  1: FlexColumnWidth(2),
                                  2: FlexColumnWidth(2),
                                  3: FlexColumnWidth(2),
                                  4: FlexColumnWidth(2),
                                },
                                border: TableBorder.all(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10)),
                                    color: const Color.fromARGB(
                                        255, 248, 248, 248)),
                                children: const [
                                  TableRow(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10)),
                                        color:
                                            Color.fromARGB(255, 223, 223, 223),
                                      ),
                                      children: [
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            'Month',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                              top: 6.0,
                                              bottom: 6,
                                            ),
                                            child: Text(
                                              'No of Working Days',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            'Days Present',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            'Days Absent',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        TableCell(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          child: Text(
                                            '%',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ])
                                ],
                              ),
                              Consumer<AttendenceProvider>(
                                builder: (_, value, child) => ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: value.attendList.isEmpty
                                        ? 0
                                        : value.attendList.length,
                                    shrinkWrap: true,
                                    itemBuilder: ((context, index) {
                                      return InkWell(
                                        onTap: () async {
                                          await value.clearDetailList();
                                          await value.detailList(
                                              value.attendList[index].month ??
                                                  "");
                                          print("object");
                                          value.attDetailList.isEmpty
                                              ? snackbarWidget(2,
                                                  "No Data Found..!", context)
                                              : value.dualAttendance == true
                                                  ? await showModalBottomSheet(
                                                      context: context,
                                                      shape:
                                                          const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        30),
                                                                topRight: Radius
                                                                    .circular(
                                                                        30)),
                                                      ),
                                                      builder: (BuildContext
                                                          context) {
                                                        return SingleChildScrollView(
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: <Widget>[
                                                              Row(
                                                                children: [
                                                                  const Spacer(),
                                                                  const Text(
                                                                    "Absent Details  ",
                                                                    style: TextStyle(
                                                                        color: UIGuide
                                                                            .light_Purple,
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight.w500),
                                                                  ),
                                                                  Container(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              4),
                                                                      decoration: BoxDecoration(
                                                                          color: UIGuide
                                                                              .LightBlue,
                                                                          borderRadius: BorderRadius.circular(
                                                                              10)),
                                                                      child:
                                                                          Text(
                                                                        value.monthName ??
                                                                            "",
                                                                        style: const TextStyle(
                                                                            color:
                                                                                UIGuide.BLACK,
                                                                            fontWeight: FontWeight.w500),
                                                                      )),
                                                                  const Spacer(),
                                                                  TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child:
                                                                          const Text(
                                                                        "Close  ",
                                                                        style:
                                                                            TextStyle(
                                                                          color: Color
                                                                              .fromARGB(
                                                                              255,
                                                                              95,
                                                                              95,
                                                                              95),
                                                                        ),
                                                                      ))
                                                                ],
                                                              ),
                                                              Table(
                                                                columnWidths: const {
                                                                  0: FlexColumnWidth(
                                                                      3),
                                                                  1: FlexColumnWidth(
                                                                      2),
                                                                  2: FlexColumnWidth(
                                                                      2),
                                                                },
                                                                border: TableBorder.all(
                                                                    color: const Color
                                                                        .fromARGB(
                                                                        255,
                                                                        215,
                                                                        216,
                                                                        216),
                                                                    width: .2),
                                                                children: const [
                                                                  TableRow(
                                                                      decoration: BoxDecoration(
                                                                          color: Color.fromARGB(
                                                                              255,
                                                                              231,
                                                                              233,
                                                                              235)),
                                                                      children: [
                                                                        Padding(
                                                                          padding:
                                                                              EdgeInsets.all(8.0),
                                                                          child:
                                                                              Text(
                                                                            'Date',
                                                                            style:
                                                                                TextStyle(fontWeight: FontWeight.w700),
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding:
                                                                              EdgeInsets.all(8.0),
                                                                          child:
                                                                              Text(
                                                                            'Forenoon',
                                                                            style:
                                                                                TextStyle(fontWeight: FontWeight.w700),
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding:
                                                                              EdgeInsets.all(8.0),
                                                                          child:
                                                                              Text(
                                                                            'Afternoon',
                                                                            style:
                                                                                TextStyle(fontWeight: FontWeight.w700),
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                          ),
                                                                        ),
                                                                      ])
                                                                ],
                                                              ),
                                                              Consumer<
                                                                  AttendenceProvider>(
                                                                builder: (_,
                                                                        value,
                                                                        child) =>
                                                                    LimitedBox(
                                                                  maxHeight:
                                                                      size.height /
                                                                          3,
                                                                  child: ListView
                                                                      .builder(
                                                                          physics:
                                                                              const BouncingScrollPhysics(),
                                                                          itemCount: value.attDetailList.isEmpty
                                                                              ? 0
                                                                              : value
                                                                                  .attDetailList.length,
                                                                          shrinkWrap:
                                                                              true,
                                                                          itemBuilder:
                                                                              ((context, index) {
                                                                            String
                                                                                createddate =
                                                                                value.attDetailList[index].date ?? '--';
                                                                            String
                                                                                finalCreatedDate =
                                                                                '';
                                                                            if (value.attDetailList[index].date !=
                                                                                null) {
                                                                              DateTime parsedDateTime = DateTime.parse(createddate);

                                                                              finalCreatedDate = DateFormat('dd-MMM-yyyy').format(parsedDateTime);
                                                                            }

                                                                            return Table(
                                                                              columnWidths: const {
                                                                                0: FlexColumnWidth(3),
                                                                                1: FlexColumnWidth(2),
                                                                                2: FlexColumnWidth(2),
                                                                              },
                                                                              border: TableBorder.all(color: const Color.fromARGB(255, 245, 243, 243)),
                                                                              children: [
                                                                                TableRow(children: [
                                                                                  Padding(
                                                                                    padding: const EdgeInsets.all(8.0),
                                                                                    child: Text(
                                                                                      finalCreatedDate,
                                                                                      style: const TextStyle(fontWeight: FontWeight.w400),
                                                                                      textAlign: TextAlign.center,
                                                                                    ),
                                                                                  ),
                                                                                  Padding(padding: const EdgeInsets.all(8.0), child: value.attDetailList[index].foreNoon == "P" ? SizedBox(height: 25, width: 25, child: SvgPicture.asset("assets/ppp.svg")) : SizedBox(height: 25, width: 25, child: SvgPicture.asset("assets/aa.svg"))),
                                                                                  Padding(padding: const EdgeInsets.all(8.0), child: value.attDetailList[index].afterNoon == "P" ? SizedBox(height: 25, width: 25, child: SvgPicture.asset("assets/ppp.svg")) : SizedBox(height: 25, width: 25, child: SvgPicture.asset("assets/aa.svg"))),
                                                                                ])
                                                                              ],
                                                                            );
                                                                          })),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    )
                                                  : await showModalBottomSheet(
                                                      context: context,
                                                      shape:
                                                          const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        30),
                                                                topRight: Radius
                                                                    .circular(
                                                                        30)),
                                                      ),
                                                      builder: (BuildContext
                                                          context) {
                                                        return SingleChildScrollView(
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: <Widget>[
                                                              Row(
                                                                children: [
                                                                  const Spacer(),
                                                                  const Text(
                                                                    "Absent Details  ",
                                                                    style: TextStyle(
                                                                        color: UIGuide
                                                                            .light_Purple,
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight.w500),
                                                                  ),
                                                                  Container(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              4),
                                                                      decoration: BoxDecoration(
                                                                          color: UIGuide
                                                                              .LightBlue,
                                                                          borderRadius: BorderRadius.circular(
                                                                              10)),
                                                                      child:
                                                                          Text(
                                                                        value.monthName ??
                                                                            "",
                                                                        style: const TextStyle(
                                                                            color:
                                                                                UIGuide.BLACK,
                                                                            fontWeight: FontWeight.w500),
                                                                      )),
                                                                  const Spacer(),
                                                                  TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child:
                                                                          const Text(
                                                                        "Close  ",
                                                                        style:
                                                                            TextStyle(
                                                                          color: Color
                                                                              .fromARGB(
                                                                              255,
                                                                              95,
                                                                              95,
                                                                              95),
                                                                        ),
                                                                      ))
                                                                ],
                                                              ),
                                                              Table(
                                                                columnWidths: const {
                                                                  0: FlexColumnWidth(
                                                                      3),
                                                                  1: FlexColumnWidth(
                                                                      2),
                                                                },
                                                                border: TableBorder.all(
                                                                    color: const Color
                                                                        .fromARGB(
                                                                        255,
                                                                        215,
                                                                        216,
                                                                        216),
                                                                    width: .2),
                                                                children: const [
                                                                  TableRow(
                                                                      decoration: BoxDecoration(
                                                                          color: Color.fromARGB(
                                                                              255,
                                                                              231,
                                                                              233,
                                                                              235)),
                                                                      children: [
                                                                        Padding(
                                                                          padding:
                                                                              EdgeInsets.all(8.0),
                                                                          child:
                                                                              Text(
                                                                            'Date',
                                                                            style:
                                                                                TextStyle(fontWeight: FontWeight.w700),
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding:
                                                                              EdgeInsets.all(8.0),
                                                                          child:
                                                                              Text(
                                                                            'Attendance',
                                                                            style:
                                                                                TextStyle(fontWeight: FontWeight.w700),
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                          ),
                                                                        ),
                                                                      ])
                                                                ],
                                                              ),
                                                              Consumer<
                                                                  AttendenceProvider>(
                                                                builder: (_,
                                                                        value,
                                                                        child) =>
                                                                    LimitedBox(
                                                                  maxHeight:
                                                                      size.height /
                                                                          3,
                                                                  child: ListView
                                                                      .builder(
                                                                          physics:
                                                                              const BouncingScrollPhysics(),
                                                                          itemCount: value.attDetailList.isEmpty
                                                                              ? 0
                                                                              : value
                                                                                  .attDetailList.length,
                                                                          shrinkWrap:
                                                                              true,
                                                                          itemBuilder:
                                                                              ((context, index) {
                                                                            String
                                                                                createddate =
                                                                                value.attDetailList[index].date ?? '--';
                                                                            String
                                                                                finalCreatedDate =
                                                                                '';
                                                                            if (value.attDetailList[index].date !=
                                                                                null) {
                                                                              DateTime parsedDateTime = DateTime.parse(createddate);

                                                                              finalCreatedDate = DateFormat('dd-MMM-yyyy').format(parsedDateTime);
                                                                            }

                                                                            return Table(
                                                                              columnWidths: const {
                                                                                0: FlexColumnWidth(3),
                                                                                1: FlexColumnWidth(2),
                                                                              },
                                                                              border: TableBorder.all(color: const Color.fromARGB(255, 245, 243, 243)),
                                                                              children: [
                                                                                TableRow(children: [
                                                                                  Padding(
                                                                                    padding: const EdgeInsets.all(8.0),
                                                                                    child: Text(
                                                                                      finalCreatedDate,
                                                                                      style: const TextStyle(fontWeight: FontWeight.w400),
                                                                                      textAlign: TextAlign.center,
                                                                                    ),
                                                                                  ),
                                                                                  Padding(padding: const EdgeInsets.all(8.0), child: value.attDetailList[index].foreNoon == "P" ? SizedBox(height: 25, width: 25, child: SvgPicture.asset("assets/ppp.svg")) : SizedBox(height: 25, width: 25, child: SvgPicture.asset("assets/aa.svg"))),
                                                                                ])
                                                                              ],
                                                                            );
                                                                          })),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    );
                                        },
                                        child: AnimationConfiguration
                                            .staggeredList(
                                          position: index,
                                          delay:
                                              const Duration(milliseconds: 100),
                                          child: SlideAnimation(
                                            duration: const Duration(
                                                milliseconds: 3500),
                                            curve:
                                                Curves.fastLinearToSlowEaseIn,
                                            child: FadeInAnimation(
                                              curve:
                                                  Curves.fastLinearToSlowEaseIn,
                                              duration: const Duration(
                                                  milliseconds: 3500),
                                              child: Table(
                                                columnWidths: const {
                                                  0: FlexColumnWidth(3),
                                                  1: FlexColumnWidth(2),
                                                  2: FlexColumnWidth(2),
                                                  3: FlexColumnWidth(2),
                                                  4: FlexColumnWidth(2),
                                                },
                                                border: TableBorder.all(
                                                    color: const Color.fromARGB(
                                                        255, 255, 255, 255)),
                                                children: [
                                                  TableRow(
                                                      decoration: BoxDecoration(
                                                        color: index.isEven
                                                            ? Colors.white
                                                            : const Color
                                                                .fromARGB(255,
                                                                241, 241, 241),
                                                      ),
                                                      children: [
                                                        TableCell(
                                                          verticalAlignment:
                                                              TableCellVerticalAlignment
                                                                  .middle,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    top: 12,
                                                                    left: 8,
                                                                    bottom: 12),
                                                            child: Text(
                                                              value
                                                                      .attendList[
                                                                          index]
                                                                      .month ??
                                                                  '--',
                                                              style: const TextStyle(
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                            ),
                                                          ),
                                                        ),
                                                        TableCell(
                                                          verticalAlignment:
                                                              TableCellVerticalAlignment
                                                                  .middle,
                                                          child: Text(
                                                            value
                                                                        .attendList[
                                                                            index]
                                                                        .totalWorkingDays ==
                                                                    null
                                                                ? '--'
                                                                : value
                                                                    .attendList[
                                                                        index]
                                                                    .totalWorkingDays
                                                                    .toString(),
                                                            style: const TextStyle(
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ),
                                                        TableCell(
                                                          verticalAlignment:
                                                              TableCellVerticalAlignment
                                                                  .middle,
                                                          child: Text(
                                                            value
                                                                        .attendList[
                                                                            index]
                                                                        .daysPresent ==
                                                                    null
                                                                ? '--'
                                                                : value
                                                                    .attendList[
                                                                        index]
                                                                    .daysPresent
                                                                    .toString(),
                                                            style: const TextStyle(
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ),
                                                        TableCell(
                                                          verticalAlignment:
                                                              TableCellVerticalAlignment
                                                                  .middle,
                                                          child: Text(
                                                            value
                                                                        .attendList[
                                                                            index]
                                                                        .daysAbsent ==
                                                                    null
                                                                ? '--'
                                                                : value
                                                                    .attendList[
                                                                        index]
                                                                    .daysAbsent
                                                                    .toString(),
                                                            style: const TextStyle(
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ),
                                                        TableCell(
                                                          verticalAlignment:
                                                              TableCellVerticalAlignment
                                                                  .middle,
                                                          child: Text(
                                                            value
                                                                        .attendList[
                                                                            index]
                                                                        .monthres ==
                                                                    null
                                                                ? '--'
                                                                : value
                                                                    .attendList[
                                                                        index]
                                                                    .monthres
                                                                    .toString(),
                                                            style: const TextStyle(
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ),
                                                      ])
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    })),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DefaultTextStyle(
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                      fontSize: 14.0,
                                      color: UIGuide.light_Purple,
                                      fontWeight: FontWeight.w700),
                                  child: AnimatedTextKit(
                                    pause: const Duration(milliseconds: 50),
                                    isRepeatingAnimation: true,
                                    repeatForever: true,
                                    animatedTexts: [
                                      RotateAnimatedText(
                                          'Click on month for Absent Details',
                                          textStyle: const TextStyle(
                                              fontWeight: FontWeight.normal)),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (value.loadingD)
                            Container(
                              color: Colors.black.withOpacity(0.2),
                              child: Center(
                                child: spinkitLoader(),
                              ),
                            ),
                        ],
                      ),
          ),
        ));
  }
}
