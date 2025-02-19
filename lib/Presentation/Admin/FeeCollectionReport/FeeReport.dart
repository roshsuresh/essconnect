import 'package:essconnect/Application/AdminProviders/FeeReportProvider.dart';
import 'package:essconnect/Application/AdminProviders/SchoolPhotoProviders.dart';
import 'package:essconnect/Constants.dart';
import 'package:essconnect/utils/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';

import '../../../Domain/Staff/StudentReport_staff.dart';
import '../../../utils/constants.dart';

class FeeReport extends StatefulWidget {
  const FeeReport({Key? key}) : super(key: key);

  @override
  @override
  State<FeeReport> createState() => _FeeReportState();
}

class _FeeReportState extends State<FeeReport> {
  DateTime? _mydatetimeFrom;
  DateTime? _mydatetimeTo;
  List subjectData = [];
  List diviData = [];
  List crs=[];
  String time = '--';
  String timeNow = '--';
  String course = '';
  String section = '';

  String _selectedValue="All";
  String category= "All";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var p = Provider.of<SchoolPhotoProviders>(context, listen: false);
      p.stdReportSectionStaff();
      p.courseDrop.clear();
      var c = Provider.of<FeeReportProvider>(context, listen: false);
      c.clearcollectionList();
      p.dropDown.clear();
      p.stdReportInitialValues.clear();
      p.courselist.clear();
      p.courseCounter(0);
      c.allTotal = null;
      p.sectionCounter(0);

    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Consumer<FeeReportProvider>(
        builder: (context, val, _) => Stack(
          children: [
            ListView(
              children: [
                Row(
                  children: [
                    const Spacer(),
                    Consumer<SchoolPhotoProviders>(
                      builder: (context, value, child) => value.loadingSection
                          ? SizedBox(
                              width: size.width * .42,
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
                                    style:
                                        TextStyle(color: UIGuide.light_Purple),
                                  ),
                                  cancelText: const Text(
                                    'Cancel',
                                    style:
                                        TextStyle(color: UIGuide.light_Purple),
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
                                  searchable: true,
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

                                    val.clearcollectionList();
                                    subjectData.clear();
                                    value.courselist.clear();
                                    crs.clear();
                                    diviData.clear();
                                    crs.clear();
                                    course="";
                                    val.allTotal = null;
                                    value.courseLen=0;




                                    for (var i = 0; i < results.length; i++) {
                                      StudReportSectionList data =
                                      results[i] as StudReportSectionList;

                                      print(data.value);
                                      subjectData.add(data.value);
                                      subjectData.map((e) => data.value);
                                      print("${subjectData.map((e) => data.value)}");
                                    }
                                    print("section data    $subjectData");
                                    section = subjectData.join(',');
                                    await Provider.of<SchoolPhotoProviders>(
                                            context,
                                            listen: false)
                                        .sectionCounter(results.length);
                                    await Provider.of<SchoolPhotoProviders>(
                                            context,
                                            listen: false)
                                        .getCourseList(section);

                                  },
                                ),
                              ),
                            ),
                    ),
                    const Spacer(),
                    Consumer<SchoolPhotoProviders>(
                      builder: (context, value, child) => value.loadingCourse
                          ? SizedBox(
                              width: size.width * .42,
                              height: 45,
                              child: const Center(child: Text('Loading...')))
                          : Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: SizedBox(
                                width: size.width * .42,
                                height: 45,
                                child: MultiSelectDialogField(
                                  // height: 200,
                                  items: value.courseDrop, searchable: true,
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
                                    style:
                                        TextStyle(color: UIGuide.light_Purple),
                                  ),
                                  cancelText: const Text(
                                    'Cancel',
                                    style:
                                        TextStyle(color: UIGuide.light_Purple),
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

                                    crs= results;
                                    diviData.clear();
                                    print("cccccccccccc");
                                    value.courselist.clear();
                                    print("clearrrrrrrr");
                                    val.clearcollectionList();
                                    val.allTotal = null;


                                    // results.clear();
                                    for (var i = 0; i < results.length; i++) {
                                  StudReportCourse data =
                                    crs[i] as StudReportCourse;

                                    print(data.value);
                                    diviData.add(data.value);
                                    diviData.map((e) => data.value);
                                    print("${diviData.map((e) => data.value)}");
                                    }
                                    print("divisionDataaa    $diviData");
                                    course = diviData
                                        .map((id) => id)
                                        .join(',');
                                    print(course);
                                    await value.courseCounter(diviData.length);
                                    //value.studentViewList.clear();

                                    print("data division  $course");
                                    //  await value.getDivisionList(course);
                                    },
                                    //diviData = [];
                                    // for (var i = 0; i < results.length; i++) {
                                    //   StudReportCourse data =
                                    //       results[i] as StudReportCourse;
                                    //   print(data.value);
                                    //   print(data.text);
                                    //   diviData.add(data.value);
                                    //   diviData.map((e) => data.value);
                                    //   print(
                                    //       "${diviData.map((e) => data.value)}");
                                    // }
                                    // course = diviData.join(',');
                                    // await Provider.of<SchoolPhotoProviders>(
                                    //         context,
                                    //         listen: false)
                                    //     .courseCounter(results.length);
                                    // results.clear();
                                    // await Provider.of<SchoolPhotoProviders>(
                                    //         context,
                                    //         listen: false)
                                    //     .getDivisionList(course);
                                    //
                                    // print(diviData.join(','));
                                 // },
                                ),
                              ),
                            ),
                    ),
                    const Spacer()
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 6.0),
                  child: Text(
                    'From Date and To date should not exceed 30 days',
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 11.5,
                        color: Color.fromARGB(255, 241, 128, 128)),
                  ),
                ),
                Row(
                  children: [
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: SizedBox(
                        width: size.width * .42,
                        height: 40,
                        child: Consumer<FeeReportProvider>(
                          builder: (context, value, child) => ElevatedButton(
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
                            onPressed: (() async {
                              value.clearcollectionList();
                              value.allTotal=null;
                              _mydatetimeFrom = await showDatePicker(
                                context: context,
                                initialDate: _mydatetimeFrom ?? DateTime.now(),
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
                                time = DateFormat('dd-MMM-yyyy')
                                    .format(_mydatetimeFrom!);
                                print(time);
                              });
                            }),
                            child: Center(child: Text('From ${time}')),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: SizedBox(
                        width: size.width * .42,
                        height: 40,
                        child: Consumer<FeeReportProvider>(
                          builder: (context, value, child) => ElevatedButton(
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
                            onPressed: (() async {
                              value.clearcollectionList();
                              value.allTotal=null;
                              _mydatetimeTo = await showDatePicker(
                                context: context,
                                initialDate: _mydatetimeTo ?? DateTime.now(),
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
                                timeNow = DateFormat('dd-MMM-yyyy')
                                    .format(_mydatetimeTo!);
                                print(timeNow);
                              });
                            }),
                            // minWidth: size.width - 250,
                            child: Center(child: Text('To $timeNow')),
                          ),
                        ),
                      ),
                    ),
                    const Spacer()
                  ],
                ),
                kheight10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Spacer(),
                    Padding(
                    padding:   const EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                        width: size.width * .42,
                        height: 40,
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                        decoration: BoxDecoration(
                          color: Colors.white, // Background color of the box
                          border: Border.all(color: UIGuide.light_Purple, width: 1), // Border color and width
                          borderRadius: BorderRadius.circular(8), // Rounded corners
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26, // Shadow color
                              blurRadius: 6.0, // Shadow blur effect
                              offset: Offset(0, 2), // Shadow position
                            ),
                          ],
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _selectedValue,
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedValue = newValue!;
                                val.clearcollectionList();
                                val.allTotal = null;
                                if(_selectedValue=='School Fees')
                                  {
                                    category="SCHOOL%20FEES";
                                  }
                                else if(_selectedValue=='Bus Fees'){
                                  category="BUS FEES";
                                }
                                else{
                                  category="All";
                                }

                              });
                            },
                            items: <String>['All','School Fees', 'Bus Fees']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value,style: TextStyle(
                                    fontWeight: FontWeight.w400
                                ),),
                              );
                            }).toList(),
                            isExpanded: true,
                          ),
                        ),
                      ),
                    ),
                    Spacer(),

                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: SizedBox(
                        width: size.width * .42,
                        height: 40,
                        child: Consumer<FeeReportProvider>(
                          builder: (contexr, value, child) => value.loading
                              ? const Center(
                                  child: Text(
                                  'Loading..',
                                  style: TextStyle(
                                      color: UIGuide.light_Purple, fontSize: 16),
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
                                    if (time == "--" || timeNow == "--") {
                                      snackbarWidget(
                                          2, "Select From & To date ", context);
                                    } else {
                                      DateTime dt1 = _mydatetimeFrom!;
                                      DateTime dt2 = _mydatetimeTo!;
                                      Duration diff = dt2.difference(dt1);
                                      if (diff.inDays >= 0 && diff.inDays <= 30) {
                                        await Provider.of<FeeReportProvider>(
                                                context,
                                                listen: false)
                                            .clearcollectionList();
                                        await Provider.of<FeeReportProvider>(
                                                context,
                                                listen: false)
                                            .getFeeReportView(
                                               category,
                                                section,
                                                course,
                                                time,
                                                timeNow);

                                        if (value.collectionList.isEmpty) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              elevation: 10,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20)),
                                              ),
                                              duration: Duration(seconds: 3),
                                              margin: EdgeInsets.only(
                                                  bottom: 80,
                                                  left: 30,
                                                  right: 30),
                                              behavior: SnackBarBehavior.floating,
                                              content: Text(
                                                'No Data For Specified Condition',
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          );
                                        }
                                      } else if (diff.isNegative) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            elevation: 10,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                            ),
                                            duration: Duration(seconds: 3),
                                            margin: EdgeInsets.only(
                                                bottom: 80, left: 30, right: 30),
                                            behavior: SnackBarBehavior.floating,
                                            content: Text(
                                              'From date should be lesser than To date',
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            elevation: 10,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(20),
                                                  bottomRight:
                                                      Radius.circular(20)),
                                            ),
                                            duration: Duration(seconds: 3),
                                            margin: EdgeInsets.only(
                                                bottom: 80, left: 30, right: 30),
                                            behavior: SnackBarBehavior.floating,
                                            content: Text(
                                              'Please select date range between 30 days',
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        );
                                      }
                                    }
                                  }),
                                  child: const Text(
                                    'View',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                        ),
                      ),
                    ),
                    Spacer()
                  ],
                ),
                kheight20,
                Padding(
                  padding: const EdgeInsets.only(left: 3, right: 3),
                  child: Table(
                    border: TableBorder.all(
                        color: const Color.fromARGB(255, 248, 248, 248)),
                    columnWidths: const {
                      0: FlexColumnWidth(0.5),
                      1: FlexColumnWidth(1.5),
                      2: FlexColumnWidth(2.5),
                      3: FlexColumnWidth(1.5),
                      4: FlexColumnWidth(.6),
                    },
                    children: const [
                      TableRow(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 223, 223, 223),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                            ),
                          ),
                          children: [
                            TableCell(
                              verticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              child: Center(
                                child: Text(
                                  'Sl No.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            TableCell(
                              verticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              child: Center(
                                child: Text(
                                  'Date',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            TableCell(
                              verticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              child: Center(
                                child: Text(
                                  'Name',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            TableCell(
                              verticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              child: Padding(
                                padding: EdgeInsets.all(3.0),
                                child: Center(
                                  child: Text(
                                    'Remitted\nFee',
                                    textAlign: TextAlign.center,
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ),
                            TableCell(
                              verticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              child: Center(
                                child: Text(
                                  'View',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ])
                    ],
                  ),
                ),
                Consumer<FeeReportProvider>(
                  builder: (context, value, child) => Padding(
                    padding: const EdgeInsets.only(left: 3, right: 3),
                    child:
                    value.collectionList.isNotEmpty?
                    LimitedBox(
                      maxHeight: size.height / 1.8,
                      child: Scrollbar(
                        child: ListView.builder(
                            //  physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: value.collectionList.isEmpty
                                ? 0
                                : value.collectionList.length,
                            itemBuilder: ((context, index) {
                              String newdate = '';

                              if (value.collectionList[index].remittedDate !=
                                  null) {
                                String createddate =
                                    value.collectionList[index].remittedDate ??
                                        '--';
                                DateTime parsedDateTime =
                                    DateTime.parse(createddate);
                                newdate = DateFormat('dd-MMM-yyyy')
                                    .format(parsedDateTime);
                              }
                              String studID =
                                  value.collectionList[index].studentId ?? '';
                              String FeeID =
                                  value.collectionList[index].feeCollectionId ??
                                      '';
                              String busID = value.collectionList[index]
                                      .busFeeCollectionId ??
                                  '';

                              return InkWell(
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Table(
                                    border: TableBorder.all(
                                        color: const Color.fromARGB(
                                            255, 255, 255, 255)),
                                    columnWidths: const {
                                      0: FlexColumnWidth(0.5),
                                      1: FlexColumnWidth(1.5),
                                      2: FlexColumnWidth(2.5),
                                      3: FlexColumnWidth(1.5),
                                      4: FlexColumnWidth(.6),
                                    },
                                    children: [
                                      TableRow(
                                          decoration: BoxDecoration(
                                            color: index.isEven
                                                ? Colors.white
                                                : const Color.fromARGB(
                                                    255, 241, 241, 241),
                                          ),
                                          children: [
                                            TableCell(
                                              verticalAlignment:
                                                  TableCellVerticalAlignment
                                                      .middle,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5, bottom: 5),
                                                child: Text(
                                                  (index + 1).toString(),
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 13),
                                                ),
                                              ),
                                            ),
                                            TableCell(
                                              verticalAlignment:
                                                  TableCellVerticalAlignment
                                                      .middle,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5, bottom: 5),
                                                child: Center(
                                                  child: Text(
                                                    newdate.isEmpty
                                                        ? '----'
                                                        : newdate,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 13),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            TableCell(
                                              verticalAlignment:
                                                  TableCellVerticalAlignment
                                                      .middle,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5, bottom: 5, left: 2),
                                                child: Text(
                                                  value.collectionList[index]
                                                              .name ==
                                                          null
                                                      ? '--'
                                                      : "  ${value.collectionList[index].name}",
                                                  textAlign: TextAlign.start,
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                            ),
                                            TableCell(
                                              verticalAlignment:
                                                  TableCellVerticalAlignment
                                                      .middle,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 16),
                                                child: Text(
                                                  value.collectionList[index]
                                                              .remittedFees ==
                                                          null
                                                      ? '---'
                                                      : value
                                                          .collectionList[index]
                                                          .remittedFees!
                                                          .toStringAsFixed(2),
                                                  textAlign: TextAlign.end,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const TableCell(
                                              verticalAlignment:
                                                  TableCellVerticalAlignment
                                                      .middle,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    top: 10, bottom: 10),
                                                child: Icon(
                                                  Icons.remove_red_eye,
                                                  size: 18,
                                                ),
                                              ),
                                            ),
                                          ])
                                    ],
                                  ),
                                ),
                                onTap: () async {
                                  value.generalList.clear();
                                  value.busFeeList.clear();
                                  await Provider.of<FeeReportProvider>(context,
                                          listen: false)
                                      .getAttachmentView(studID, FeeID, busID);
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext context) {
                                        String finalCreatedDate = '';

                                        if (value.transactionDate != null) {
                                          String createddate =
                                              value.transactionDate ?? '--';
                                          DateTime parsedDateTime =
                                              DateTime.parse(createddate);
                                          finalCreatedDate =
                                              DateFormat('dd-MMM-yyyy')
                                                  .format(parsedDateTime);
                                        }
                                        return ListView(
                                          shrinkWrap: true,
                                          //  mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text(
                                                  "Close",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16),
                                                ),
                                              ),
                                            ),
                                            const Divider(
                                              height: 0,
                                              color: Color.fromARGB(
                                                  255, 95, 95, 95),
                                            ),
                                            // Padding(
                                            //   padding:
                                            //       const EdgeInsets.all(8.0),
                                            //   child: SizedBox(
                                            //     width: size.width / 2.5,
                                            //     child: const Divider(
                                            //       thickness: 5,
                                            //       color: Color.fromARGB(
                                            //           255, 188, 189, 190),
                                            //     ),
                                            //   ),
                                            // ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10, right: 10, top: 5),
                                              child: LimitedBox(
                                                maxHeight: size.height / 2,
                                                child: ListView(
                                                  shrinkWrap: true,
                                                  //   mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: Row(
                                                        children: [
                                                          const Text(
                                                            'Name: ',
                                                            style: TextStyle(
                                                                fontSize: 14),
                                                          ),
                                                          Flexible(
                                                            child: RichText(
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              maxLines: 2,
                                                              strutStyle:
                                                                  const StrutStyle(
                                                                      fontSize:
                                                                          13.0),
                                                              text: TextSpan(
                                                                  style: const TextStyle(
                                                                      color: UIGuide
                                                                          .light_Purple,
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                  text: value
                                                                          .name ??
                                                                      '---'),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: Row(
                                                        children: [
                                                          const Text(
                                                            'Adm No: ',
                                                            style: TextStyle(
                                                                fontSize: 14),
                                                          ),
                                                          Text(
                                                            value.admissionNo ??
                                                                '---',
                                                            style: const TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: UIGuide
                                                                    .light_Purple),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: Row(
                                                        children: [
                                                          const Text(
                                                            'Division: ',
                                                            style: TextStyle(
                                                                fontSize: 14),
                                                          ),
                                                          Text(
                                                            value.division ??
                                                                '---',
                                                            style: const TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: UIGuide
                                                                    .light_Purple),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: Row(
                                                        children: [
                                                          const Text(
                                                            'Date: ',
                                                            style: TextStyle(
                                                                fontSize: 14),
                                                          ),
                                                          Text(
                                                            finalCreatedDate,
                                                            style: const TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: UIGuide
                                                                    .light_Purple),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: Row(
                                                        children: [
                                                          const Text(
                                                            'Order Id: ',
                                                            style: TextStyle(
                                                                fontSize: 14),
                                                          ),
                                                          Flexible(
                                                            child: RichText(
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              maxLines: 2,
                                                              strutStyle:
                                                                  const StrutStyle(
                                                                      fontSize:
                                                                          13.0),
                                                              text: TextSpan(
                                                                  style: const TextStyle(
                                                                      color: UIGuide
                                                                          .light_Purple,
                                                                      fontSize:
                                                                          15,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                  text: value
                                                                          .orderId ??
                                                                      '---'),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: Row(
                                                        children: [
                                                          const Text(
                                                            'Transaction Id: ',
                                                            style: TextStyle(
                                                                fontSize: 14),
                                                          ),
                                                          Flexible(
                                                            child: RichText(
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              maxLines: 2,
                                                              strutStyle:
                                                                  const StrutStyle(
                                                                      fontSize:
                                                                          13.0),
                                                              text: TextSpan(
                                                                  style: const TextStyle(
                                                                      color: UIGuide
                                                                          .light_Purple,
                                                                      fontSize:
                                                                          15,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                  text: value
                                                                          .transactionId ??
                                                                      '---'),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    kheight10,
                                                    Consumer<FeeReportProvider>(
                                                      builder: (context,
                                                          provider, child) {
                                                        if (provider.generalList
                                                            .isEmpty) {
                                                          return Container();
                                                        } else if (provider
                                                            .generalList
                                                            .isNotEmpty) {
                                                          return Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(2.0),
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                  border: Border.all(
                                                                      color: UIGuide
                                                                          .light_Purple,
                                                                      width: 1),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5)),
                                                              child: Column(
                                                                children: [
                                                                  const Text(
                                                                    'School Fees',
                                                                    style: TextStyle(
                                                                        color: UIGuide
                                                                            .light_Purple,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w700,
                                                                        decoration:
                                                                            TextDecoration
                                                                                .underline,
                                                                        decorationStyle:
                                                                            TextDecorationStyle
                                                                                .dotted,
                                                                        fontSize:
                                                                            18),
                                                                  ),
                                                                  LimitedBox(
                                                                    maxHeight:
                                                                        150,
                                                                    child: Consumer<
                                                                        FeeReportProvider>(
                                                                      builder: (context, value, child) => ListView.builder(
                                                                          physics: const NeverScrollableScrollPhysics(),
                                                                          itemCount: value.generalList.isEmpty ? 0 : value.generalList.length,
                                                                          shrinkWrap: true,
                                                                          itemBuilder: ((context, index) {
                                                                            return Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                              children: [
                                                                                Padding(
                                                                                  padding: const EdgeInsets.only(left: 16.0),
                                                                                  child: Text(
                                                                                    value.generalList[index].installmentname ?? '--',
                                                                                    style: const TextStyle(color: UIGuide.light_Purple, fontWeight: FontWeight.bold),
                                                                                  ),
                                                                                ),
                                                                                ListTile(
                                                                                  visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                                                                                  title: const Text(
                                                                                    'Amount to be Paid',
                                                                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                                                                                  ),
                                                                                  trailing: Text(
                                                                                    value.generalList[index].netDue!.toStringAsFixed(2),
                                                                                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                                                                                  ),
                                                                                ),
                                                                                ListTile(
                                                                                  visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                                                                                  title: const Text(
                                                                                    'Paid Amount',
                                                                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                                                                                  ),
                                                                                  trailing: Text(
                                                                                    value.generalList[index].paidAmount!.toStringAsFixed(2),
                                                                                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                                                                                  ),
                                                                                )
                                                                              ],
                                                                            );
                                                                          })),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        }
                                                        return const Text(' ');
                                                      },
                                                    ),
                                                    kheight10,
                                                    Consumer<FeeReportProvider>(
                                                      builder: (context,
                                                          provider, child) {
                                                        if (provider.busFeeList
                                                            .isEmpty) {
                                                          return Container();
                                                        } else if (provider
                                                            .busFeeList
                                                            .isNotEmpty) {
                                                          return Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(2.0),
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                  border: Border.all(
                                                                      color: UIGuide
                                                                          .light_Purple,
                                                                      width: 1),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5)),
                                                              child: Consumer<
                                                                  FeeReportProvider>(
                                                                builder: (context,
                                                                        value,
                                                                        child) =>
                                                                    Column(
                                                                  children: [
                                                                    const Text(
                                                                      'Bus Fees',
                                                                      style: TextStyle(
                                                                          color: UIGuide
                                                                              .light_Purple,
                                                                          fontWeight: FontWeight
                                                                              .w700,
                                                                          decoration: TextDecoration
                                                                              .underline,
                                                                          decorationStyle: TextDecorationStyle
                                                                              .dotted,
                                                                          fontSize:
                                                                              18),
                                                                    ),
                                                                    LimitedBox(
                                                                      maxHeight:
                                                                          150,
                                                                      child: ListView.builder(
                                                                          physics: const NeverScrollableScrollPhysics(),
                                                                          itemCount: value.busFeeList.isEmpty ? 0 : value.busFeeList.length,
                                                                          shrinkWrap: true,
                                                                          itemBuilder: ((context, index) {
                                                                            return Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                              children: [
                                                                                Padding(
                                                                                  padding: const EdgeInsets.only(left: 16.0),
                                                                                  child: Text(
                                                                                    value.busFeeList[index].installmentname.toString(),
                                                                                    style: const TextStyle(color: UIGuide.light_Purple, fontWeight: FontWeight.bold),
                                                                                  ),
                                                                                ),
                                                                                ListTile(
                                                                                  visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                                                                                  horizontalTitleGap: 0,
                                                                                  title: const Text(
                                                                                    'Amount to be Paid',
                                                                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                                                                                  ),
                                                                                  trailing: Text(
                                                                                    value.busFeeList[index].netDue!.toStringAsFixed(2),
                                                                                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                                                                                  ),
                                                                                ),
                                                                                ListTile(
                                                                                  visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                                                                                  title: const Text(
                                                                                    'Paid Amount',
                                                                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                                                                                  ),
                                                                                  trailing: Text(
                                                                                    value.busFeeList[index].paidAmount!.toStringAsFixed(2),
                                                                                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                                                                                  ),
                                                                                )
                                                                              ],
                                                                            );
                                                                          })),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        }
                                                        return const Text(' ');
                                                      },
                                                    ),
                                                    kheight20
                                                    // Row(
                                                    //   crossAxisAlignment:
                                                    //       CrossAxisAlignment.end,
                                                    //   mainAxisAlignment:
                                                    //       MainAxisAlignment.end,
                                                    //   children: [
                                                    //     Padding(
                                                    //       padding:
                                                    //           const EdgeInsets
                                                    //               .all(6.0),
                                                    //       child: SizedBox(
                                                    //         width: 70,
                                                    //         child: MaterialButton(
                                                    //           shape: RoundedRectangleBorder(
                                                    //               borderRadius:
                                                    //                   BorderRadius
                                                    //                       .circular(
                                                    //                           10)),
                                                    //           onPressed: () {
                                                    //             Navigator.pop(
                                                    //                 context);
                                                    //           },
                                                    //           color: UIGuide
                                                    //               .light_Purple,
                                                    //           child: const Text(
                                                    //             "OK",
                                                    //             style: TextStyle(
                                                    //                 color: UIGuide
                                                    //                     .WHITE,
                                                    //                 fontSize: 14),
                                                    //           ),
                                                    //         ),
                                                    //       ),
                                                    //     )
                                                    //   ],
                                                    // )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      });
                                },
                              );
                            })),
                      ),
                    ):
                    SizedBox(height: 0,width: 0,),
                  ),
                ),
                // Consumer<FeeReportProvider>(
                //   builder: (context, value, child) => Row(
                //     crossAxisAlignment: CrossAxisAlignment.end,
                //     mainAxisAlignment: MainAxisAlignment.end,
                //     children: [
                //       value.allTotal == null
                //           ? const Text('')
                //           : const Text(
                //               "Total:  ",
                //               style: TextStyle(
                //                   fontWeight: FontWeight.w700, fontSize: 16),
                //             ),
                //       value.allTotal == null
                //           ? const Text('')
                //           : Text(
                //               value.allTotal == null
                //                   ? '0.00'
                //                   : value.allTotal!.toStringAsFixed(2),
                //               style: const TextStyle(
                //                   fontWeight: FontWeight.w900, fontSize: 16),
                //             ),
                //       kWidth20,
                //       kWidth20
                //     ],
                //   ),
                // )
              ],
            ),
            if (val.loading) pleaseWaitLoader()
          ],
        ),
      ),
      bottomNavigationBar: Consumer<FeeReportProvider>(
        builder: (context, snap, _) => snap.loading
            ? const SizedBox(
          height: 0,
          width: 0,
        )
            : BottomAppBar(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 10, right: 10, top: 5, bottom: 5),
            child: SizedBox(
              height: 35,
              child:

              // Text("Net Total: ${snap.netAmount}")
              ElevatedButton(
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
                onPressed: () async {
                },
                child:
                Text(
                  "Net Total: ${snap.allTotal==null?"":snap.allTotal.toString()}",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
