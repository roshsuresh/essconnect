import 'package:essconnect/Constants.dart';
import 'package:essconnect/utils/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../../Application/AdminProviders/FeeDetailsProvider.dart';
import '../../../utils/constants.dart';

class StudFeeDetails extends StatefulWidget {
  //SearchStudReport stud;
  String studid;
  String name;
  String roll;
  String division;
  StudFeeDetails(
      {Key? key,
      required this.studid,
      required this.name,
      required this.roll,
      required this.division})
      : super(key: key);

  @override
  State<StudFeeDetails> createState() => _StudFeeDetailsState();
}

class _StudFeeDetailsState extends State<StudFeeDetails> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var p = Provider.of<FeeDetailsProvider>(context, listen: false);
      await p.generalPaidListClear();
      await p.busPaidListClear();
      await p.generalDueListClear();
      await p.busDueListClear();
      await p.getFeeDetails(widget.studid);
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Student Fee Report'),
        titleSpacing: 20.0,
        centerTitle: true,
        toolbarHeight: 50.2,
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
        child: Consumer<FeeDetailsProvider>(builder: (context, value, child) {
          return value.load
              ? spinkitLoader()
              : Consumer<FeeDetailsProvider>(
                  builder: (context, list, child) {
                    return list.generalFeeDueList.isEmpty &&
                            list.generalFeePaidList.isEmpty &&
                            list.busFeeDueList.isEmpty &&
                            list.busFeePaidList.isEmpty
                        ? Center(
                            child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: size.height / 2,
                              child: LottieBuilder.network(
                                  'https://assets9.lottiefiles.com/packages/lf20_rdjfuniz.json'),
                            ),
                          ))
                        : Scrollbar(
                            thickness: 5,
                            child: ListView(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: UIGuide.light_black),
                                        color: const Color.fromARGB(
                                            255, 245, 245, 245),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    width: size.width,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              const Text(
                                                'Name : ',
                                              ),
                                              Text(
                                                widget.name == null
                                                    ? '--'
                                                    : widget.name.toString(),
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color:
                                                        UIGuide.light_Purple),
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Text(
                                                'Division : ',
                                              ),
                                              Expanded(
                                                child: Text(
                                                  widget.division == null
                                                      ? '--'
                                                      : widget.division
                                                          .toString(),
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                              //const Spacer(),
                                              const Text(
                                                'Roll No : ',
                                              ),
                                              Expanded(
                                                child: Text(
                                                  widget.roll == null
                                                      ? '--'
                                                      : widget.roll.toString(),
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                kheight5,
                                Consumer<FeeDetailsProvider>(
                                  builder: (context, due, child) {
                                    return due.generalFeeDueList.isEmpty &&
                                            due.busFeeDueList.isEmpty
                                        ? const SizedBox(
                                            height: 0,
                                            width: 0,
                                          )
                                        : SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                const Padding(
                                                  padding: EdgeInsets.all(4.0),
                                                  child: Text(
                                                    'Fees Due List',
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: UIGuide
                                                            .light_Purple),
                                                  ),
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      border: Border.all(
                                                          color: Colors.black,
                                                          style: BorderStyle
                                                              .solid)),
                                                  width: size.width,
                                                  child: Column(
                                                    children: [
                                                      Consumer<
                                                          FeeDetailsProvider>(
                                                        builder: (context,
                                                            school, child) {
                                                          return school
                                                                  .generalFeeDueList
                                                                  .isEmpty
                                                              ? const SizedBox(
                                                                  height: 0,
                                                                  width: 0,
                                                                )
                                                              : Column(
                                                                  children: [
                                                                    Container(
                                                                      width: size
                                                                          .width,
                                                                      decoration: const BoxDecoration(
                                                                          color: Color.fromARGB(
                                                                              255,
                                                                              246,
                                                                              247,
                                                                              250),
                                                                          borderRadius: BorderRadius.only(
                                                                              topLeft: Radius.circular(10),
                                                                              topRight: Radius.circular(10))),
                                                                      child:
                                                                          const Padding(
                                                                        padding:
                                                                            EdgeInsets.all(4.0),
                                                                        child:
                                                                            Text(
                                                                          'School Fees',
                                                                          style: TextStyle(
                                                                              fontSize: 15,
                                                                              fontWeight: FontWeight.w700),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Table(
                                                                      border: TableBorder.all(
                                                                          color: const Color
                                                                              .fromARGB(
                                                                              255,
                                                                              255,
                                                                              255,
                                                                              255)),
                                                                      columnWidths: const {
                                                                        0: FlexColumnWidth(
                                                                            4),
                                                                        1: FlexColumnWidth(
                                                                            3),
                                                                        2: FlexColumnWidth(
                                                                            3),
                                                                        3: FlexColumnWidth(
                                                                            3),
                                                                      },
                                                                      children: const [
                                                                        TableRow(
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: Color.fromARGB(255, 223, 223, 223),
                                                                            ),
                                                                            children: [
                                                                              TableCell(
                                                                                verticalAlignment: TableCellVerticalAlignment.middle,
                                                                                child: Padding(
                                                                                  padding: EdgeInsets.only(top: 6, bottom: 6),
                                                                                  child: Center(
                                                                                      child: Text(
                                                                                    'Installment',
                                                                                    style: TextStyle(fontWeight: FontWeight.w500),
                                                                                  )),
                                                                                ),
                                                                              ),
                                                                              TableCell(
                                                                                verticalAlignment: TableCellVerticalAlignment.middle,
                                                                                child: Center(
                                                                                    child: Text(
                                                                                  'Fine',
                                                                                  style: TextStyle(fontWeight: FontWeight.w500),
                                                                                )),
                                                                              ),
                                                                              TableCell(
                                                                                verticalAlignment: TableCellVerticalAlignment.middle,
                                                                                child: Center(
                                                                                    child: Text(
                                                                                  'NetDue',
                                                                                  style: TextStyle(fontWeight: FontWeight.w500),
                                                                                )),
                                                                              ),
                                                                              TableCell(
                                                                                verticalAlignment: TableCellVerticalAlignment.middle,
                                                                                child: Center(
                                                                                    child: Text(
                                                                                  'Paid Amount',
                                                                                  style: TextStyle(fontWeight: FontWeight.w500),
                                                                                )),
                                                                              ),
                                                                            ]),
                                                                      ],
                                                                    ),
                                                                    Consumer<
                                                                        FeeDetailsProvider>(
                                                                      builder: (context, general, child) => ListView.builder(
                                                                          physics: const BouncingScrollPhysics(),
                                                                          shrinkWrap: true,
                                                                          itemCount: general.generalFeeDueList.isEmpty ? 0 : general.generalFeeDueList.length,
                                                                          itemBuilder: ((context, index) {
                                                                            return Table(
                                                                              border: TableBorder.all(color: const Color.fromARGB(255, 255, 255, 255)),
                                                                              columnWidths: const {
                                                                                0: FlexColumnWidth(4),
                                                                                1: FlexColumnWidth(3),
                                                                                2: FlexColumnWidth(3),
                                                                                3: FlexColumnWidth(3),
                                                                              },
                                                                              children: [
                                                                                TableRow(
                                                                                    decoration: BoxDecoration(
                                                                                      color: index.isEven ? Colors.white : const Color.fromARGB(255, 241, 241, 241),
                                                                                    ),
                                                                                    children: [
                                                                                      TableCell(
                                                                                        verticalAlignment: TableCellVerticalAlignment.middle,
                                                                                        child: Padding(
                                                                                          padding: const EdgeInsets.only(top: 6, bottom: 6),
                                                                                          child: Center(
                                                                                              child: Text(
                                                                                            general.generalFeeDueList[index].installmentName ?? '--',
                                                                                            style: const TextStyle(fontWeight: FontWeight.w500),
                                                                                          )),
                                                                                        ),
                                                                                      ),
                                                                                      TableCell(
                                                                                        verticalAlignment: TableCellVerticalAlignment.middle,
                                                                                        child: Center(
                                                                                            child: Text(
                                                                                          general.generalFeeDueList[index].fineAmount == null ? '--' : general.generalFeeDueList[index].fineAmount.toString(),
                                                                                          style: const TextStyle(fontWeight: FontWeight.w500),
                                                                                        )),
                                                                                      ),
                                                                                      TableCell(
                                                                                        verticalAlignment: TableCellVerticalAlignment.middle,
                                                                                        child: Center(
                                                                                            child: Text(
                                                                                          general.generalFeeDueList[index].netDue == null ? '--' : general.generalFeeDueList[index].netDue.toString(),
                                                                                          style: const TextStyle(fontWeight: FontWeight.w500),
                                                                                        )),
                                                                                      ),
                                                                                      TableCell(
                                                                                        verticalAlignment: TableCellVerticalAlignment.middle,
                                                                                        child: Center(
                                                                                            child: Text(
                                                                                          general.generalFeeDueList[index].paidAmount == null ? '--' : general.generalFeeDueList[index].paidAmount.toString(),
                                                                                          style: const TextStyle(fontWeight: FontWeight.w500),
                                                                                        )),
                                                                                      ),
                                                                                    ]),
                                                                              ],
                                                                            );
                                                                          })),
                                                                    ),
                                                                  ],
                                                                );
                                                        },
                                                      ),
                                                      kheight10,
                                                      Consumer<
                                                          FeeDetailsProvider>(
                                                        builder: (context, bus,
                                                            child) {
                                                          return bus
                                                                  .busFeeDueList
                                                                  .isEmpty
                                                              ? const SizedBox(
                                                                  height: 0,
                                                                  width: 0,
                                                                )
                                                              : Column(
                                                                  children: [
                                                                    Container(
                                                                      width: size
                                                                          .width,
                                                                      color: const Color
                                                                          .fromARGB(
                                                                          255,
                                                                          246,
                                                                          247,
                                                                          250),
                                                                      child:
                                                                          const Padding(
                                                                        padding:
                                                                            EdgeInsets.all(4.0),
                                                                        child:
                                                                            Text(
                                                                          'Bus Fees',
                                                                          style: TextStyle(
                                                                              fontSize: 15,
                                                                              fontWeight: FontWeight.w700),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Table(
                                                                      border: TableBorder.all(
                                                                          color: const Color
                                                                              .fromARGB(
                                                                              255,
                                                                              255,
                                                                              255,
                                                                              255)),
                                                                      columnWidths: const {
                                                                        0: FlexColumnWidth(
                                                                            4),
                                                                        1: FlexColumnWidth(
                                                                            3),
                                                                        2: FlexColumnWidth(
                                                                            3),
                                                                        3: FlexColumnWidth(
                                                                            3),
                                                                      },
                                                                      children: const [
                                                                        TableRow(
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: Color.fromARGB(255, 223, 223, 223),
                                                                            ),
                                                                            children: [
                                                                              TableCell(
                                                                                verticalAlignment: TableCellVerticalAlignment.middle,
                                                                                child: Padding(
                                                                                  padding: EdgeInsets.only(top: 6, bottom: 6),
                                                                                  child: Center(
                                                                                      child: Text(
                                                                                    'Installment',
                                                                                    style: TextStyle(fontWeight: FontWeight.w500),
                                                                                  )),
                                                                                ),
                                                                              ),
                                                                              TableCell(
                                                                                verticalAlignment: TableCellVerticalAlignment.middle,
                                                                                child: Center(
                                                                                    child: Text(
                                                                                  'Fine',
                                                                                  style: TextStyle(fontWeight: FontWeight.w500),
                                                                                )),
                                                                              ),
                                                                              TableCell(
                                                                                verticalAlignment: TableCellVerticalAlignment.middle,
                                                                                child: Center(
                                                                                    child: Text(
                                                                                  'NetDue',
                                                                                  style: TextStyle(fontWeight: FontWeight.w500),
                                                                                )),
                                                                              ),
                                                                              TableCell(
                                                                                verticalAlignment: TableCellVerticalAlignment.middle,
                                                                                child: Center(
                                                                                    child: Text(
                                                                                  'Paid Amount',
                                                                                  style: TextStyle(fontWeight: FontWeight.w500),
                                                                                )),
                                                                              ),
                                                                            ]),
                                                                      ],
                                                                    ),
                                                                    Consumer<
                                                                        FeeDetailsProvider>(
                                                                      builder: (context, busfee, child) => ListView.builder(
                                                                          physics: const BouncingScrollPhysics(),
                                                                          shrinkWrap: true,
                                                                          itemCount: busfee.busFeeDueList.isEmpty ? 0 : busfee.busFeeDueList.length,
                                                                          itemBuilder: ((context, index) {
                                                                            return Table(
                                                                              border: TableBorder.all(color: const Color.fromARGB(255, 255, 255, 255)),
                                                                              columnWidths: const {
                                                                                0: FlexColumnWidth(4),
                                                                                1: FlexColumnWidth(3),
                                                                                2: FlexColumnWidth(3),
                                                                                3: FlexColumnWidth(3),
                                                                              },
                                                                              children: [
                                                                                TableRow(
                                                                                    decoration: BoxDecoration(
                                                                                      color: index.isEven ? Colors.white : const Color.fromARGB(255, 241, 241, 241),
                                                                                    ),
                                                                                    children: [
                                                                                      TableCell(
                                                                                        verticalAlignment: TableCellVerticalAlignment.middle,
                                                                                        child: Padding(
                                                                                          padding: const EdgeInsets.only(top: 6, bottom: 6, left: 4),
                                                                                          child: Text(
                                                                                            busfee.busFeeDueList[index].installmentName ?? '--',
                                                                                            style: const TextStyle(fontWeight: FontWeight.w500),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      TableCell(
                                                                                        verticalAlignment: TableCellVerticalAlignment.middle,
                                                                                        child: Center(
                                                                                            child: Text(
                                                                                          busfee.busFeeDueList[index].fineAmount == null ? '--' : busfee.busFeeDueList[index].fineAmount.toString(),
                                                                                          style: const TextStyle(fontWeight: FontWeight.w500),
                                                                                        )),
                                                                                      ),
                                                                                      TableCell(
                                                                                        verticalAlignment: TableCellVerticalAlignment.middle,
                                                                                        child: Center(
                                                                                            child: Text(
                                                                                          busfee.busFeeDueList[index].netDue == null ? '--' : busfee.busFeeDueList[index].netDue.toString(),
                                                                                          style: const TextStyle(fontWeight: FontWeight.w500),
                                                                                        )),
                                                                                      ),
                                                                                      TableCell(
                                                                                        verticalAlignment: TableCellVerticalAlignment.middle,
                                                                                        child: Center(
                                                                                            child: Text(
                                                                                          busfee.busFeeDueList[index].paidAmount == null ? '--' : busfee.busFeeDueList[index].paidAmount.toString(),
                                                                                          style: const TextStyle(fontWeight: FontWeight.w500),
                                                                                        )),
                                                                                      ),
                                                                                    ]),
                                                                              ],
                                                                            );
                                                                          })),
                                                                    ),
                                                                  ],
                                                                );
                                                        },
                                                      ),
                                                      Consumer<
                                                          FeeDetailsProvider>(
                                                        builder: (context,
                                                                value, child) =>
                                                            Table(
                                                          // border: TableBorder.all(
                                                          //     color: const Color
                                                          //         .fromARGB(
                                                          //         255,
                                                          //         248,
                                                          //         248,
                                                          //         248)),
                                                          columnWidths: const {
                                                            0: FlexColumnWidth(
                                                                4),
                                                            1: FlexColumnWidth(
                                                                3),
                                                            2: FlexColumnWidth(
                                                                3),
                                                            3: FlexColumnWidth(
                                                                3),
                                                          },
                                                          children: [
                                                            TableRow(
                                                                decoration:
                                                                    const BoxDecoration(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          212,
                                                                          212,
                                                                          212),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .only(
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            8),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            8),
                                                                  ),
                                                                ),
                                                                children: [
                                                                  const TableCell(
                                                                    verticalAlignment:
                                                                        TableCellVerticalAlignment
                                                                            .middle,
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsets.only(
                                                                          top:
                                                                              5,
                                                                          bottom:
                                                                              5),
                                                                      child:
                                                                          Text(
                                                                        'Net Total',
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.w700),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  TableCell(
                                                                    verticalAlignment:
                                                                        TableCellVerticalAlignment
                                                                            .middle,
                                                                    child: Text(
                                                                      value.allTotalDueFineAmount ==
                                                                              null
                                                                          ? '--'
                                                                          : value
                                                                              .allTotalDueFineAmount
                                                                              .toString(),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: const TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.w700),
                                                                    ),
                                                                  ),
                                                                  TableCell(
                                                                    verticalAlignment:
                                                                        TableCellVerticalAlignment
                                                                            .middle,
                                                                    child: Text(
                                                                      value.allTotalDueNetDueAmount ==
                                                                              null
                                                                          ? '--'
                                                                          : value
                                                                              .allTotalDueNetDueAmount
                                                                              .toString(),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: const TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.w700),
                                                                    ),
                                                                  ),
                                                                  TableCell(
                                                                    verticalAlignment:
                                                                        TableCellVerticalAlignment
                                                                            .middle,
                                                                    child: Text(
                                                                      value.allTotalDuePaidAmount ==
                                                                              null
                                                                          ? '--'
                                                                          : value
                                                                              .allTotalDuePaidAmount
                                                                              .toString(),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: const TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.w700),
                                                                    ),
                                                                  )
                                                                ])
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                  },
                                ),
                                kheight20,
                                Consumer<FeeDetailsProvider>(
                                  builder: (context, paid, child) {
                                    return paid.generalFeePaidList.isEmpty &&
                                            paid.busFeePaidList.isEmpty
                                        ? const SizedBox(
                                            height: 0,
                                            width: 0,
                                          )
                                        : SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                const Center(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(4.0),
                                                    child: Text(
                                                      'Fee Paid Details',
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          color: UIGuide
                                                              .light_Purple,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: size.width,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      border: Border.all(
                                                          color: Colors.black,
                                                          style: BorderStyle
                                                              .solid)),
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        width: size.width,
                                                        decoration: const BoxDecoration(
                                                            color: Color
                                                                .fromARGB(
                                                                    255,
                                                                    246,
                                                                    247,
                                                                    250),
                                                            borderRadius: BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        10),
                                                                topRight: Radius
                                                                    .circular(
                                                                        10))),
                                                        child: const Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  4.0),
                                                          child: Text(
                                                            'School Fees',
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                          ),
                                                        ),
                                                      ),

                                                      LimitedBox(
                                                        maxHeight: 250,
                                                        child: Consumer<
                                                            FeeDetailsProvider>(
                                                          builder: (context,
                                                                  generalPaid,
                                                                  child) =>
                                                              Scrollbar(
                                                            child: ListView
                                                                .builder(
                                                              shrinkWrap: true,
                                                              physics:
                                                                  const BouncingScrollPhysics(),
                                                              itemCount: generalPaid
                                                                      .generalFeePaidList
                                                                      .isEmpty
                                                                  ? 0
                                                                  : generalPaid
                                                                      .generalFeePaidList
                                                                      .length,
                                                              itemBuilder:
                                                                  (context,
                                                                      indexx) {
                                                                String
                                                                    finalDate =
                                                                    "";

                                                                if (generalPaid
                                                                        .generalFeePaidList[
                                                                            indexx]
                                                                        .billDate !=
                                                                    null) {
                                                                  String
                                                                      createddate =
                                                                      generalPaid
                                                                              .generalFeePaidList[indexx]
                                                                              .billDate ??
                                                                          '--';
                                                                  DateTime
                                                                      parsedDateTime =
                                                                      DateTime.parse(
                                                                          createddate);
                                                                  finalDate = DateFormat(
                                                                          'dd-MMM-yyyy')
                                                                      .format(
                                                                          parsedDateTime);
                                                                }

                                                                return Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          4.0),
                                                                  child:
                                                                      InkWell(
                                                                    onTap: () {
                                                                      showDialog(
                                                                          context:
                                                                              context,
                                                                          builder:
                                                                              (context) {
                                                                            return Dialog(
                                                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                                                                child: SingleChildScrollView(
                                                                                  scrollDirection: Axis.vertical,
                                                                                  child: Column(
                                                                                    mainAxisSize: MainAxisSize.min,
                                                                                    children: [
                                                                                      ListView.builder(
                                                                                          physics: const BouncingScrollPhysics(),
                                                                                          shrinkWrap: true,
                                                                                          itemCount: generalPaid.generalFeePaidList[indexx].schoolFees!.isEmpty ? 0 : generalPaid.generalFeePaidList[indexx].schoolFees!.length,
                                                                                          itemBuilder: (context, index) {
                                                                                            return Padding(
                                                                                              padding: const EdgeInsets.all(3.0),
                                                                                              child: Container(
                                                                                                decoration: BoxDecoration(border: Border.all(color: UIGuide.light_Purple), borderRadius: const BorderRadius.all(Radius.circular(10)), color: UIGuide.WHITE),
                                                                                                child: Padding(
                                                                                                  padding: const EdgeInsets.all(4),
                                                                                                  child: Column(
                                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                                    children: [
                                                                                                      Padding(
                                                                                                        padding: const EdgeInsets.all(4.0),
                                                                                                        child: Row(
                                                                                                          children: [
                                                                                                            const Text('Installment Name: '),
                                                                                                            Flexible(
                                                                                                              child: RichText(
                                                                                                                overflow: TextOverflow.ellipsis,
                                                                                                                strutStyle: const StrutStyle(fontSize: 12.0),
                                                                                                                text: TextSpan(
                                                                                                                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                                                                                                                  text: generalPaid.generalFeePaidList[indexx].schoolFees![index].installmentname ?? '--',
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ],
                                                                                                        ),
                                                                                                      ),
                                                                                                      Padding(
                                                                                                        padding: const EdgeInsets.all(4.0),
                                                                                                        child: Row(
                                                                                                          children: [
                                                                                                            const Text('Due Amount: '),
                                                                                                            Flexible(
                                                                                                              child: RichText(
                                                                                                                overflow: TextOverflow.ellipsis,
                                                                                                                strutStyle: const StrutStyle(fontSize: 12.0),
                                                                                                                text: TextSpan(
                                                                                                                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                                                                                                                  text: generalPaid.generalFeePaidList[indexx].schoolFees![index].dueAmount == null ? '0.00' : generalPaid.generalFeePaidList[indexx].schoolFees![index].dueAmount.toString(),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ],
                                                                                                        ),
                                                                                                      ),
                                                                                                      Padding(
                                                                                                        padding: const EdgeInsets.all(4.0),
                                                                                                        child: Row(
                                                                                                          children: [
                                                                                                            const Text('Concession Amount: '),
                                                                                                            Flexible(
                                                                                                              child: RichText(
                                                                                                                overflow: TextOverflow.ellipsis,
                                                                                                                strutStyle: const StrutStyle(fontSize: 12.0),
                                                                                                                text: TextSpan(
                                                                                                                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                                                                                                                  text: generalPaid.generalFeePaidList[indexx].schoolFees![index].concessionAmount == null ? '0.00' : generalPaid.generalFeePaidList[indexx].schoolFees![index].concessionAmount.toString(),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ],
                                                                                                        ),
                                                                                                      ),
                                                                                                      Padding(
                                                                                                        padding: const EdgeInsets.all(4.0),
                                                                                                        child: Row(
                                                                                                          children: [
                                                                                                            const Text('Fine Amount: '),
                                                                                                            Flexible(
                                                                                                              child: RichText(
                                                                                                                overflow: TextOverflow.ellipsis,
                                                                                                                strutStyle: const StrutStyle(fontSize: 12.0),
                                                                                                                text: TextSpan(
                                                                                                                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                                                                                                                  text: generalPaid.generalFeePaidList[indexx].schoolFees![index].fineAmount == null ? '0.00' : generalPaid.generalFeePaidList[indexx].schoolFees![index].fineAmount.toString(),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ],
                                                                                                        ),
                                                                                                      ),
                                                                                                      Padding(
                                                                                                        padding: const EdgeInsets.all(4.0),
                                                                                                        child: Row(
                                                                                                          children: [
                                                                                                            const Text('Paid: '),
                                                                                                            Flexible(
                                                                                                              child: RichText(
                                                                                                                overflow: TextOverflow.ellipsis,
                                                                                                                strutStyle: const StrutStyle(fontSize: 12.0),
                                                                                                                text: TextSpan(
                                                                                                                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                                                                                                                  text: generalPaid.generalFeePaidList[indexx].schoolFees![index].paidAmount == null ? '0.00' : generalPaid.generalFeePaidList[indexx].schoolFees![index].paidAmount.toString(),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ],
                                                                                                        ),
                                                                                                      )
                                                                                                    ],
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            );
                                                                                          }),
                                                                                    ],
                                                                                  ),
                                                                                ));
                                                                          });
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      decoration: BoxDecoration(
                                                                          border: Border.all(
                                                                              color: UIGuide
                                                                                  .light_Purple),
                                                                          borderRadius: const BorderRadius.all(Radius.circular(
                                                                              10)),
                                                                          color:
                                                                              UIGuide.WHITE),
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            4),
                                                                        child:
                                                                            Column(
                                                                          children: [
                                                                            Padding(
                                                                              padding: const EdgeInsets.all(4.0),
                                                                              child: Row(
                                                                                children: [
                                                                                  const Text(
                                                                                    'Date: ',
                                                                                  ),
                                                                                  Text(
                                                                                    finalDate.isEmpty ? '--' : finalDate,
                                                                                    style: const TextStyle(color: UIGuide.light_Purple, fontWeight: FontWeight.w500),
                                                                                  ),
                                                                                  const Spacer(),
                                                                                  const Icon(
                                                                                    Icons.info_outline_rounded,
                                                                                    size: 18,
                                                                                  ),
                                                                                  kWidth,
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets.all(4.0),
                                                                              child: Row(
                                                                                children: [
                                                                                  const Text(
                                                                                    'Txn ID: ',
                                                                                  ),
                                                                                  Flexible(
                                                                                    child: RichText(
                                                                                      overflow: TextOverflow.ellipsis,
                                                                                      strutStyle: const StrutStyle(fontSize: 12.0),
                                                                                      text: TextSpan(style: const TextStyle(color: UIGuide.light_Purple, fontWeight: FontWeight.w500), text: generalPaid.generalFeePaidList[indexx].transactionId ?? '--'),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      value.generalFeePaidList
                                                              .isEmpty
                                                          ? const SizedBox(
                                                              height: 0,
                                                              width: 0,
                                                            )
                                                          : Container(
                                                              width: size.width,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .all(Radius
                                                                            .zero),
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        230,
                                                                        230,
                                                                        230),
                                                              ),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        4.0),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    const Text(
                                                                      'Total Paid: ',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              15,
                                                                          fontWeight:
                                                                              FontWeight.w700),
                                                                    ),
                                                                    Text(
                                                                      value.generalFeePaidList[0].totalPaidAmount ==
                                                                              null
                                                                          ? "0.00"
                                                                          : value
                                                                              .generalFeePaidList[0]
                                                                              .totalPaidAmount!
                                                                              .toStringAsFixed(2),
                                                                      style: const TextStyle(
                                                                          color: UIGuide
                                                                              .light_Purple,
                                                                          fontWeight:
                                                                              FontWeight.w700),
                                                                    ),
                                                                    kWidth
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
///////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////

                                                      ///Bus fee
                                                      kheight5,
                                                      Consumer<
                                                          FeeDetailsProvider>(
                                                        builder: (context,
                                                            busPaid, child) {
                                                          return busPaid
                                                                  .busFeePaidList
                                                                  .isEmpty
                                                              ? const SizedBox(
                                                                  height: 0,
                                                                  width: 0,
                                                                )
                                                              : Column(
                                                                  children: [
                                                                    Container(
                                                                      width: size
                                                                          .width,
                                                                      color: const Color
                                                                          .fromARGB(
                                                                          255,
                                                                          246,
                                                                          247,
                                                                          250),
                                                                      child:
                                                                          const Padding(
                                                                        padding:
                                                                            EdgeInsets.all(4.0),
                                                                        child:
                                                                            Text(
                                                                          'Bus Fees',
                                                                          style: TextStyle(
                                                                              fontSize: 15,
                                                                              fontWeight: FontWeight.w700),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    LimitedBox(
                                                                      maxHeight:
                                                                          250,
                                                                      child: Consumer<
                                                                          FeeDetailsProvider>(
                                                                        builder: (context,
                                                                                busFeePaidList,
                                                                                child) =>
                                                                            Scrollbar(
                                                                          child:
                                                                              ListView.builder(
                                                                            physics:
                                                                                const BouncingScrollPhysics(),
                                                                            shrinkWrap:
                                                                                true,
                                                                            itemCount: busPaid.busFeePaidList.isEmpty
                                                                                ? 0
                                                                                : busPaid.busFeePaidList.length,
                                                                            itemBuilder:
                                                                                (context, indexx) {
                                                                              String finalDate = "";

                                                                              if (busPaid.busFeePaidList[indexx].billDate != null) {
                                                                                String createddate = busPaid.busFeePaidList[indexx].billDate ?? '--';
                                                                                DateTime parsedDateTime = DateTime.parse(createddate);
                                                                                finalDate = DateFormat('dd-MMM-yyyy').format(parsedDateTime);
                                                                              }

                                                                              return Padding(
                                                                                padding: const EdgeInsets.all(4.0),
                                                                                child: GestureDetector(
                                                                                  onTap: () {
                                                                                    showDialog(
                                                                                        context: context,
                                                                                        builder: (context) {
                                                                                          return Dialog(
                                                                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                                                                              child: SingleChildScrollView(
                                                                                                scrollDirection: Axis.vertical,
                                                                                                child: Column(
                                                                                                  mainAxisSize: MainAxisSize.min,
                                                                                                  children: [
                                                                                                    ListView.builder(
                                                                                                        physics: const BouncingScrollPhysics(),
                                                                                                        shrinkWrap: true,
                                                                                                        itemCount: busPaid.busFeePaidList[indexx].busFees!.isEmpty ? 0 : busPaid.busFeePaidList[indexx].busFees!.length,
                                                                                                        itemBuilder: (context, index) {
                                                                                                          return Padding(
                                                                                                            padding: const EdgeInsets.all(3.0),
                                                                                                            child: Container(
                                                                                                              decoration: BoxDecoration(border: Border.all(color: UIGuide.light_Purple), borderRadius: const BorderRadius.all(Radius.circular(10)), color: UIGuide.WHITE),
                                                                                                              child: Center(
                                                                                                                child: Padding(
                                                                                                                  padding: const EdgeInsets.all(4),
                                                                                                                  child: Column(
                                                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                                                    children: [
                                                                                                                      Padding(
                                                                                                                        padding: const EdgeInsets.all(4.0),
                                                                                                                        child: Row(
                                                                                                                          children: [
                                                                                                                            const Text('Installment Name: '),
                                                                                                                            Flexible(
                                                                                                                              child: RichText(
                                                                                                                                overflow: TextOverflow.ellipsis,
                                                                                                                                strutStyle: const StrutStyle(fontSize: 12.0),
                                                                                                                                text: TextSpan(
                                                                                                                                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                                                                                                                                  text: busPaid.busFeePaidList[indexx].busFees![index].installmentname ?? '--',
                                                                                                                                ),
                                                                                                                              ),
                                                                                                                            ),
                                                                                                                          ],
                                                                                                                        ),
                                                                                                                      ),
                                                                                                                      Padding(
                                                                                                                        padding: const EdgeInsets.all(4.0),
                                                                                                                        child: Row(
                                                                                                                          children: [
                                                                                                                            const Text('Due Amount: '),
                                                                                                                            Flexible(
                                                                                                                              child: RichText(
                                                                                                                                overflow: TextOverflow.ellipsis,
                                                                                                                                strutStyle: const StrutStyle(fontSize: 12.0),
                                                                                                                                text: TextSpan(
                                                                                                                                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                                                                                                                                  text: busPaid.busFeePaidList[indexx].busFees![index].dueAmount == null ? '--' : busPaid.busFeePaidList[indexx].busFees![index].dueAmount.toString(),
                                                                                                                                ),
                                                                                                                              ),
                                                                                                                            ),
                                                                                                                          ],
                                                                                                                        ),
                                                                                                                      ),
                                                                                                                      Padding(
                                                                                                                        padding: const EdgeInsets.all(4.0),
                                                                                                                        child: Row(
                                                                                                                          children: [
                                                                                                                            const Text('Fine Amount: '),
                                                                                                                            Flexible(
                                                                                                                              child: RichText(
                                                                                                                                overflow: TextOverflow.ellipsis,
                                                                                                                                strutStyle: const StrutStyle(fontSize: 12.0),
                                                                                                                                text: TextSpan(
                                                                                                                                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                                                                                                                                  text: busPaid.busFeePaidList[indexx].busFees![index].fineAmount == null ? '--' : busPaid.busFeePaidList[indexx].busFees![index].fineAmount.toString(),
                                                                                                                                ),
                                                                                                                              ),
                                                                                                                            ),
                                                                                                                          ],
                                                                                                                        ),
                                                                                                                      ),
                                                                                                                      Padding(
                                                                                                                        padding: const EdgeInsets.all(4.0),
                                                                                                                        child: Row(
                                                                                                                          children: [
                                                                                                                            const Text('Paid: '),
                                                                                                                            Flexible(
                                                                                                                              child: RichText(
                                                                                                                                overflow: TextOverflow.ellipsis,
                                                                                                                                strutStyle: const StrutStyle(fontSize: 12.0),
                                                                                                                                text: TextSpan(
                                                                                                                                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                                                                                                                                  text: busPaid.busFeePaidList[indexx].busFees![index].paidAmount == null ? '--' : busPaid.busFeePaidList[indexx].busFees![index].paidAmount.toString(),
                                                                                                                                ),
                                                                                                                              ),
                                                                                                                            ),
                                                                                                                          ],
                                                                                                                        ),
                                                                                                                      )
                                                                                                                    ],
                                                                                                                  ),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          );
                                                                                                        }),
                                                                                                  ],
                                                                                                ),
                                                                                              ));
                                                                                        });
                                                                                  },
                                                                                  child: Container(
                                                                                    decoration: BoxDecoration(border: Border.all(color: UIGuide.light_Purple), borderRadius: const BorderRadius.all(Radius.circular(10)), color: UIGuide.WHITE),
                                                                                    child: Padding(
                                                                                      padding: const EdgeInsets.all(4),
                                                                                      child: Column(
                                                                                        children: [
                                                                                          Padding(
                                                                                            padding: const EdgeInsets.all(4.0),
                                                                                            child: Row(
                                                                                              children: [
                                                                                                const Text(
                                                                                                  'Date: ',
                                                                                                ),
                                                                                                Text(
                                                                                                  finalDate.isEmpty ? '--' : finalDate,
                                                                                                  style: const TextStyle(color: UIGuide.light_Purple, fontWeight: FontWeight.w500),
                                                                                                ),
                                                                                                const Spacer(),
                                                                                                const Icon(
                                                                                                  Icons.info_outline_rounded,
                                                                                                  size: 18,
                                                                                                ),
                                                                                                kWidth,
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                          Padding(
                                                                                            padding: const EdgeInsets.all(4.0),
                                                                                            child: Row(
                                                                                              children: [
                                                                                                const Text(
                                                                                                  'Txn ID: ',
                                                                                                ),
                                                                                                Flexible(
                                                                                                  child: RichText(
                                                                                                    overflow: TextOverflow.ellipsis,
                                                                                                    strutStyle: const StrutStyle(fontSize: 12.0),
                                                                                                    text: TextSpan(style: const TextStyle(color: UIGuide.light_Purple, fontWeight: FontWeight.w500), text: busPaid.busFeePaidList[indexx].transactionId ?? '--'),
                                                                                                  ),
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                          ),

                                                                                          // Row(
                                                                                          //   children: [
                                                                                          //     const Text(
                                                                                          //       'Paid Amount: ',
                                                                                          //       style: TextStyle(color: UIGuide.light_Purple),
                                                                                          //     ),
                                                                                          //     Text(
                                                                                          //       busPaid.busFeePaidList[indexx].totalPaidAmount == null ? "0.00" : busPaid.busFeePaidList[indexx].totalPaidAmount.toString(),
                                                                                          //     ),
                                                                                          //   ],
                                                                                          // ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              );
                                                                            },
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                );
                                                        },
                                                      ),
                                                      value.busFeePaidList
                                                              .isEmpty
                                                          ? const SizedBox(
                                                              height: 0,
                                                              width: 0,
                                                            )
                                                          : Container(
                                                              width: size.width,
                                                              color: const Color
                                                                  .fromARGB(
                                                                  255,
                                                                  230,
                                                                  230,
                                                                  230),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        4.0),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    const Text(
                                                                      'Total Paid: ',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              15,
                                                                          fontWeight:
                                                                              FontWeight.w700),
                                                                    ),
                                                                    Text(
                                                                      value.busFeePaidList[0].totalPaidAmount ==
                                                                              null
                                                                          ? "0.00"
                                                                          : value
                                                                              .busFeePaidList[0]
                                                                              .totalPaidAmount!
                                                                              .toStringAsFixed(2),
                                                                      style: const TextStyle(
                                                                          color: UIGuide
                                                                              .light_Purple,
                                                                          fontWeight:
                                                                              FontWeight.w700),
                                                                    ),
                                                                    kWidth
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                      const Divider(
                                                        height: 0,
                                                        color: Color.fromARGB(
                                                            255, 68, 68, 68),
                                                      ),
                                                      Container(
                                                        width: size.width,
                                                        decoration:
                                                            const BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          10),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          10)),
                                                          color: Color.fromARGB(
                                                              255,
                                                              228,
                                                              227,
                                                              228),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(4.0),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              const Text(
                                                                'Net Total Paid: ',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700),
                                                              ),
                                                              Text(
                                                                value.allPaidAmount ==
                                                                        null
                                                                    ? "0.00"
                                                                    : value
                                                                        .allPaidAmount!
                                                                        .toStringAsFixed(
                                                                            2),
                                                                style: const TextStyle(
                                                                    color: UIGuide
                                                                        .light_Purple,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700),
                                                              ),
                                                              kWidth
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                  },
                                ),
                                kheight20,
                              ],
                            ),
                          );
                  },
                );
        }),
      ),
    );
  }
}
