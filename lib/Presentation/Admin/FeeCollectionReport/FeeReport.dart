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
  State<FeeReport> createState() => _FeeReportState();
}

class _FeeReportState extends State<FeeReport> {
  DateTime? _mydatetimeFrom;
  DateTime? _mydatetimeTo;
  List subjectData = [];
  List diviData = [];
  String time = '--';
  String timeNow = '--';
  String course = '';
  String section = '';

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
      appBar: AppBar(
        title: Row(
          children: [
            const Spacer(),
            const Text(
              'Fee Collection Report',
            ),
            const Spacer(),
            IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FeeReport()));
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
        children: [
          Row(
            children: [
              const Spacer(),
              Consumer<SchoolPhotoProviders>(
                builder: (context, value, child) => value.loadingSection
                    ? SizedBox(
                        width: size.width * .43,
                        height: 50,
                        child: const Center(child: Text('Loading...')))
                    : Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SizedBox(
                          width: size.width * .42,
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
                              subjectData = [];
                              diviData.clear();
                              value.courseLen = 0;
                              value.divisionLen = 0;
                              await Provider.of<SchoolPhotoProviders>(context,
                                      listen: false)
                                  .clearCourse();
                              await Provider.of<SchoolPhotoProviders>(context,
                                      listen: false)
                                  .clearDivision();

                              await Provider.of<FeeReportProvider>(context,
                                      listen: false)
                                  .collectionList;

                              for (var i = 0; i < results.length; i++) {
                                StudReportSectionList data =
                                    results[i] as StudReportSectionList;
                                print(data.text);
                                print(data.value);
                                subjectData.add(data.value);
                                subjectData.map((e) => data.value);
                                print("${subjectData.map((e) => data.value)}");
                              }
                              setState(() {
                                value.courselist.clear();
                                value.courseDrop.clear();
                                value.courseLen = 0;
                              });
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
                          width: size.width * .42,
                          height: 50,
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
          const Text(
            'From Date and To date should not exceed 30 days',
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 11.5, color: Color.fromARGB(255, 241, 128, 128)),
          ),
          Row(
            children: [
              const Spacer(),
              SizedBox(
                width: size.width * .42,
                child: Consumer<FeeReportProvider>(
                  builder: (context, value, child) => MaterialButton(
                    child: Center(child: Text('From ${time}')),
                    color: Colors.white,
                    onPressed: (() async {
                      value.clearcollectionList();
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
                        time =
                            DateFormat('dd-MMM-yyyy').format(_mydatetimeFrom!);
                        print(time);
                      });
                    }),
                  ),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: size.width * .42,
                child: Consumer<FeeReportProvider>(
                  builder: (context, value, child) => MaterialButton(
                    // minWidth: size.width - 250,
                    color: Colors.white,
                    onPressed: (() async {
                      value.clearcollectionList();
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
                        timeNow =
                            DateFormat('dd-MMM-yyyy').format(_mydatetimeTo!);
                        print(timeNow);
                      });
                    }),
                    // minWidth: size.width - 250,
                    child: Center(child: Text('To $timeNow')),
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
              SizedBox(
                width: 120,
                height: 40,
                child: Consumer<FeeReportProvider>(
                  builder: (contexr, value, child) => value.loading
                      ? const Center(
                          child: Text(
                          'Loading..',
                          style: TextStyle(
                              color: UIGuide.light_Purple, fontSize: 16),
                        ))
                      : TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: UIGuide.light_Purple),
                          onPressed: (() async {
                            // Provider.of<SchoolPhotoProviders>(context, listen: false)
                            //     .stdReportInitialValues
                            //     .clear();
                            // Provider.of<SchoolPhotoProviders>(context, listen: false)
                            //     .courselist
                            //     .clear();
                            // Provider.of<SchoolPhotoProviders>(context, listen: false)
                            //     .divisionDrop
                            //     .clear();

                            DateTime dt1 = _mydatetimeFrom!;
                            DateTime dt2 = _mydatetimeTo!;
                            Duration diff = dt2.difference(dt1);
                            if (diff.inDays >= 0 && diff.inDays <= 30) {
                              await Provider.of<FeeReportProvider>(context,
                                      listen: false)
                                  .clearcollectionList();
                              await Provider.of<FeeReportProvider>(context,
                                      listen: false)
                                  .getFeeReportView(
                                      section, course, time, timeNow);

                              if (value.collectionList.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    ),
                                    duration: Duration(seconds: 3),
                                    margin: EdgeInsets.only(
                                        bottom: 80, left: 30, right: 30),
                                    behavior: SnackBarBehavior.floating,
                                    content: Text(
                                      'No Data For Specified Condition',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                );
                              }
                            } else if (diff.isNegative) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  elevation: 10,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
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
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  elevation: 10,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20)),
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
                          }),
                          child: const Text(
                            'View',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                ),
              ),
            ],
          ),
          kheight20,
          Padding(
            padding: const EdgeInsets.only(left: 6, right: 6),
            child: Table(
              columnWidths: const {
                0: FlexColumnWidth(0.8),
                1: FlexColumnWidth(1),
                2: FlexColumnWidth(2.5),
                3: FlexColumnWidth(2),
                4: FlexColumnWidth(1),
              },
              border: TableBorder.all(
                  color: const Color.fromARGB(255, 216, 214, 214)),
              children: const [
                TableRow(
                    decoration: BoxDecoration(
                      //  border: Border.all(),
                      color: Color.fromARGB(255, 226, 230, 241),
                    ),
                    children: [
                      Center(
                        child: Text(
                          ('Sl\nNo.'),
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                      Center(
                        child: Text(
                          ('Date'),
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                      Center(
                        child: Text(
                          ('Name'),
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                      Center(
                        child: Text(
                          ('Remitted\n     Fee'),
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                      Center(
                        child: Text(
                          ('Details'),
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                    ])
              ],
            ),
          ),
          Consumer<FeeReportProvider>(
            builder: (context, value, child) => Padding(
              padding: const EdgeInsets.only(left: 6, right: 6),
              child: LimitedBox(
                maxHeight: size.height / 1.8,
                child: value.loading
                    ? spinkitLoader()
                    : Scrollbar(
                        child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: value.collectionList.isEmpty
                                ? 0
                                : value.collectionList.length,
                            itemBuilder: ((context, index) {
                              String date =
                                  value.collectionList[index].remittedDate ??
                                      '--';

                              var updatedDate =
                                  DateFormat('yyyy-MM-dd').parse(date);
                              String studID =
                                  value.collectionList[index].studentId ?? '';
                              String FeeID =
                                  value.collectionList[index].feeCollectionId ??
                                      '';
                              String busID = value.collectionList[index]
                                      .busFeeCollectionId ??
                                  '';
                              var newdate = updatedDate
                                  .toString()
                                  .replaceRange(10, 23, '');
                              print(updatedDate);

                              return Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: Table(
                                  border: TableBorder.all(
                                      color: const Color.fromARGB(
                                          255, 245, 243, 243)),
                                  columnWidths: const {
                                    0: FlexColumnWidth(0.8),
                                    1: FlexColumnWidth(1),
                                    2: FlexColumnWidth(2.4),
                                    3: FlexColumnWidth(2),
                                    4: FlexColumnWidth(1),
                                  },
                                  children: [
                                    TableRow(children: [
                                      SizedBox(
                                        child: Text(
                                          (index + 1).toString(),
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      Center(
                                        child: Text(
                                          newdate.isEmpty ? '----' : newdate,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      Text(
                                        value.collectionList[index].name == null
                                            ? '--'
                                            : "  ${value.collectionList[index].name}",
                                        textAlign: TextAlign.start,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Center(
                                        child: Text(
                                          value.collectionList[index]
                                                      .remittedFees ==
                                                  null
                                              ? '---'
                                              : value.collectionList[index]
                                                  .remittedFees
                                                  .toString(),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Consumer<FeeReportProvider>(
                                        builder: (context, value, child) =>
                                            GestureDetector(
                                          onTap: () async {
                                            value.generalList.clear();
                                            value.busFeeList.clear();
                                            await Provider.of<
                                                        FeeReportProvider>(
                                                    context,
                                                    listen: false)
                                                .getAttachmentView(
                                                    studID, FeeID, busID);
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return Dialog(
                                                      child: LimitedBox(
                                                    maxHeight:
                                                        size.height - 300,
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(4.0),
                                                          child: Row(
                                                            children: [
                                                              const Text(
                                                                'Name: ',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15),
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
                                                                          fontWeight: FontWeight
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
                                                              const EdgeInsets
                                                                  .all(4.0),
                                                          child: Row(
                                                            children: [
                                                              const Text(
                                                                'Adm No: ',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15),
                                                              ),
                                                              Text(
                                                                value.admissionNo ??
                                                                    '---',
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        15,
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
                                                              const EdgeInsets
                                                                  .all(4.0),
                                                          child: Row(
                                                            children: [
                                                              const Text(
                                                                'Division: ',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15),
                                                              ),
                                                              Text(
                                                                value.division ??
                                                                    '---',
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        15,
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
                                                              const EdgeInsets
                                                                  .all(4.0),
                                                          child: Row(
                                                            children: [
                                                              const Text(
                                                                'Date: ',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15),
                                                              ),
                                                              Text(
                                                                value.transactionDate ??
                                                                    '---',
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        15,
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
                                                              const EdgeInsets
                                                                  .all(4.0),
                                                          child: Row(
                                                            children: [
                                                              const Text(
                                                                'Order Id: ',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15),
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
                                                                          fontWeight: FontWeight
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
                                                              const EdgeInsets
                                                                  .all(4.0),
                                                          child: Row(
                                                            children: [
                                                              const Text(
                                                                'Transaction Id: ',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15),
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
                                                                          fontWeight: FontWeight
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
                                                        Consumer<
                                                            FeeReportProvider>(
                                                          builder: (context,
                                                              provider, child) {
                                                            if (provider
                                                                .generalList
                                                                .isEmpty) {
                                                              return Container();
                                                            } else if (provider
                                                                .generalList
                                                                .isNotEmpty) {
                                                              return Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        2.0),
                                                                child:
                                                                    Container(
                                                                  decoration: BoxDecoration(
                                                                      border: Border.all(
                                                                          color: UIGuide
                                                                              .light_Purple,
                                                                          width:
                                                                              1),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5)),
                                                                  child: Column(
                                                                    children: [
                                                                      const Text(
                                                                        'School Fees',
                                                                        style: TextStyle(
                                                                            color:
                                                                                UIGuide.light_Purple,
                                                                            fontWeight: FontWeight.w700,
                                                                            decoration: TextDecoration.underline,
                                                                            decorationStyle: TextDecorationStyle.dotted,
                                                                            fontSize: 18),
                                                                      ),
                                                                      LimitedBox(
                                                                        maxHeight:
                                                                            150,
                                                                        child: Consumer<
                                                                            FeeReportProvider>(
                                                                          builder: (context, value, child) => ListView.builder(
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
                                                                                        style: const TextStyle(color: UIGuide.light_Purple),
                                                                                      ),
                                                                                    ),
                                                                                    ListTile(
                                                                                      visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                                                                                      title: const Text('Amount to be Paid'),
                                                                                      trailing: Text(
                                                                                        value.generalList[index].netDue.toString(),
                                                                                      ),
                                                                                    ),
                                                                                    ListTile(
                                                                                      visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                                                                                      title: const Text('Paid Amount'),
                                                                                      trailing: Text(
                                                                                        value.generalList[index].paidAmount.toString(),
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
                                                            return const Text(
                                                                ' ');
                                                          },
                                                        ),
                                                        kheight10,
                                                        Consumer<
                                                            FeeReportProvider>(
                                                          builder: (context,
                                                              provider, child) {
                                                            if (provider
                                                                .busFeeList
                                                                .isEmpty) {
                                                              return Container();
                                                            } else if (provider
                                                                .busFeeList
                                                                .isNotEmpty) {
                                                              return Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        2.0),
                                                                child:
                                                                    Container(
                                                                  decoration: BoxDecoration(
                                                                      border: Border.all(
                                                                          color: UIGuide
                                                                              .light_Purple,
                                                                          width:
                                                                              1),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
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
                                                                              color: UIGuide.light_Purple,
                                                                              fontWeight: FontWeight.w700,
                                                                              decoration: TextDecoration.underline,
                                                                              decorationStyle: TextDecorationStyle.dotted,
                                                                              fontSize: 18),
                                                                        ),
                                                                        LimitedBox(
                                                                          maxHeight:
                                                                              150,
                                                                          child: ListView.builder(
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
                                                                                        style: const TextStyle(color: UIGuide.light_Purple),
                                                                                      ),
                                                                                    ),
                                                                                    ListTile(
                                                                                      visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                                                                                      horizontalTitleGap: 0,
                                                                                      title: const Text('Amount to be Paid'),
                                                                                      trailing: Text(
                                                                                        value.busFeeList[index].netDue.toString(),
                                                                                      ),
                                                                                    ),
                                                                                    ListTile(
                                                                                      visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                                                                                      title: const Text('Paid Amount'),
                                                                                      trailing: Text(
                                                                                        value.busFeeList[index].paidAmount.toString(),
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
                                                            return const Text(
                                                                ' ');
                                                          },
                                                        ),
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(6.0),
                                                              child: SizedBox(
                                                                width: 70,
                                                                child:
                                                                    MaterialButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  color: UIGuide
                                                                      .light_Purple,
                                                                  child:
                                                                      const Text(
                                                                    "OK",
                                                                    style: TextStyle(
                                                                        color: UIGuide
                                                                            .WHITE,
                                                                        fontSize:
                                                                            15),
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ));
                                                });
                                          },
                                          child: const Icon(
                                            Icons.remove_red_eye,
                                            size: 18,
                                          ),
                                        ),
                                      )
                                    ])
                                  ],
                                ),
                              );
                            })),
                      ),
              ),
            ),
          ),
          Consumer<FeeReportProvider>(
            builder: (context, value, child) => Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                value.allTotal == null
                    ? const Text('')
                    : const Text(
                        "Total:  ",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 16),
                      ),
                value.allTotal == null
                    ? const Text('')
                    : Text(
                        value.allTotal == null
                            ? '0.00'
                            : value.allTotal.toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 16),
                      ),
                kWidth
              ],
            ),
          )
        ],
      ),
    );
  }
}
