import 'dart:developer';
import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:essconnect/Application/StudentProviders/FeesProvider.dart';
import 'package:essconnect/Application/StudentProviders/FinalStatusProvider.dart';
import 'package:essconnect/Constants.dart';
import 'package:essconnect/Presentation/Student/PayFee.dart';
import 'package:essconnect/Presentation/Student/Student_home.dart';
import 'package:essconnect/utils/ProgressBarFee.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:paytm_allinonesdk/paytm_allinonesdk.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:weipl_checkout_flutter/weipl_checkout_flutter.dart';

class FeePartialPayment extends StatefulWidget {
  FeePartialPayment({Key? key}) : super(key: key);

  @override
  State<FeePartialPayment> createState() => _FeePartialPaymentState();
}

class _FeePartialPaymentState extends State<FeePartialPayment> {
  final ScrollController _controllerr = ScrollController();
  WeiplCheckoutFlutter wlCheckoutFlutter = WeiplCheckoutFlutter();
  final ScrollController _controllerr2 = ScrollController();
  final _busController = TextEditingController();
  final _feeController = TextEditingController();

  String? lastresponse;



  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var p = Provider.of<FeesProvider>(context, listen: false);
      p.busFeeList.clear();
      p.feeList.clear();
      totalPartial = 0;
      totallPartial = 0;
      totalFeeCollect = 0;
      partialBUS = 0;
      partialFee = 0;
      p.transactionList.clear();
      await p.gatewayName();
      await p.feesData();
    });
  }

  double totalPartial = 0;
  double totallPartial = 0;
  double totalFeeCollect = 0;
  double partialBUS = 0;
  double partialFee = 0;

  totalFeeCollection() {
    if (_feeController.text.isEmpty) {
      _feeController.text == 0;
      totalFeeCollect = 0 + double.parse(_busController.text);

      print(totalFeeCollect);
    } else if (_busController.text.isEmpty) {
      _busController.text == 0;
      totalFeeCollect = 0 + double.parse(_feeController.text);

      print(totalFeeCollect);
    } else {
      totalFeeCollect =
          double.parse(_feeController.text) + double.parse(_busController.text);
      print(totalFeeCollect);
    }
  }

  String? readableid;
  String? orderidd;
  String? schoolId;
  String txnId = '';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext cont) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      body: Consumer<FeesProvider>(builder: (context, value, child) {
        return value.loading
            ? const ProgressBarFee()
            : value.allowPartialPayment == true
            ? value.isLocked == true
            ? const NotAvailable()
            : Stack(
          children: [
            ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                kheight20,
                value.feeList.isEmpty
                    ? const SizedBox(
                  height: 0,
                  width: 0,
                )
                    : Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  mainAxisAlignment:
                  MainAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(
                          left: 20, bottom: 10),
                      child: Text(
                        'Installment',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: UIGuide.light_Purple),
                      ),
                    ),
                    Scrollbar(
                      controller: _controllerr,
                      thumbVisibility: true,
                      thickness: 10,
                      radius: const Radius.circular(20),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 18, right: 5),
                        child: LimitedBox(
                            maxHeight: 160,
                            child: Consumer<FeesProvider>(
                              builder: (context, valuee,
                                  child) =>
                                  ListView.builder(
                                      physics:
                                      const BouncingScrollPhysics(),
                                      shrinkWrap: true,
                                      controller:
                                      _controllerr,
                                      itemCount: valuee
                                          .feeList
                                          .isEmpty
                                          ? 0
                                          : valuee.feeList
                                          .length,
                                      itemBuilder:
                                          (BuildContext
                                      context,
                                          int index) {
                                        // totallPartial = valuee
                                        //     .feeList[index].netDue!;

                                        partialFee = 0;
                                        for (int i = 0;
                                        i <
                                            valuee
                                                .feeList
                                                .length;
                                        i++) {
                                          totallPartial =
                                          valuee
                                              .feeList[
                                          i]
                                              .netDue!;
                                          partialFee +=
                                              totallPartial;
                                        }
                                        print(
                                            "totalFeePartial----$partialFee");

                                        // feeDate();

                                        return ListTile(
                                          trailing: Text(
                                            valuee.feeList[index].netDue ==
                                                null
                                                ? '--'
                                                : valuee
                                                .feeList[
                                            index]
                                                .netDue
                                                .toString(),
                                            style: const TextStyle(
                                                fontWeight:
                                                FontWeight
                                                    .w500,
                                                fontSize:
                                                15),
                                          ),
                                          title: SizedBox(
                                            width:
                                            size.width /
                                                2.5,
                                            child: Text(
                                              valuee.feeList[index]
                                                  .installmentName ??
                                                  '--',
                                              style: const TextStyle(
                                                  fontWeight:
                                                  FontWeight
                                                      .w500,
                                                  fontSize:
                                                  15),
                                            ),
                                          ),
                                        );
                                      }),
                            )),
                      ),
                    ),
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.end,
                      crossAxisAlignment:
                      CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 25.0),
                          child: SizedBox(
                            height: 30,
                            width: size.width / 3.5,
                            child: TextField(
                              controller: _feeController,
                              cursorColor:
                              UIGuide.light_Purple,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter
                                    .digitsOnly
                              ],
                              keyboardType:
                              TextInputType.number,
                              decoration: InputDecoration(
                                  focusColor:
                                  const Color.fromARGB(
                                      255,
                                      213,
                                      215,
                                      218),
                                  border:
                                  OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius
                                        .circular(10.0),
                                  ),
                                  focusedBorder:
                                  OutlineInputBorder(
                                    borderSide:
                                    const BorderSide(
                                        color: UIGuide
                                            .light_Purple,
                                        width: 1.0),
                                    borderRadius:
                                    BorderRadius
                                        .circular(10.0),
                                  ),
                                  fillColor: Colors.grey,
                                  hintStyle:
                                  const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontFamily:
                                    "verdana_regular",
                                    fontWeight:
                                    FontWeight.w400,
                                  ),
                                  labelText: 'Amount',
                                  labelStyle:
                                  const TextStyle(
                                      color: Color
                                          .fromARGB(
                                          255,
                                          106,
                                          107,
                                          109))),
                              onChanged: (value) {
                                if (double.parse(
                                    _feeController
                                        .text) ==
                                    0) {
                                  _feeController.clear();
                                } else if (double.parse(
                                    _feeController
                                        .text) -
                                    1 >=
                                    partialFee) {
                                  _feeController.clear();
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    kheight10,
                  ],
                ),
                Consumer<FeesProvider>(
                  builder: (context, buss, child) {
                    if (buss.busFeeList.isNotEmpty) {
                      return Column(
                        mainAxisAlignment:
                        MainAxisAlignment.start,
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(
                                left: 20, bottom: 10, top: 10),
                            child: Text(
                              'Bus Fee',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                  color: UIGuide.light_Purple),
                            ),
                          ),
                          Scrollbar(
                            controller: _controllerr2,
                            thumbVisibility: true,
                            thickness: 8,
                            radius: const Radius.circular(10),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 18, right: 5),
                              child: LimitedBox(
                                  maxHeight: 160,
                                  child: Consumer<FeesProvider>(
                                      builder:
                                          (context, val, child) {
                                        return ListView.builder(
                                            physics:
                                            const BouncingScrollPhysics(),
                                            shrinkWrap: true,
                                            controller: _controllerr2,
                                            itemCount:
                                            val.busFeeList.isEmpty
                                                ? 0
                                                : val.busFeeList
                                                .length,
                                            itemBuilder:
                                                (BuildContext context,
                                                int index) {
                                              // totalPartial = val
                                              //     .busFeeList[index].netDue!;
                                              partialBUS = 0;
                                              for (int i = 0;
                                              i <
                                                  buss.busFeeList
                                                      .length;
                                              i++) {
                                                totalPartial = val
                                                    .busFeeList[i]
                                                    .netDue!;
                                                partialBUS +=
                                                    totalPartial;
                                              }
                                              print(
                                                  "totalBus----$partialBUS");

                                              return ListTile(
                                                trailing: Text(
                                                  val
                                                      .busFeeList[
                                                  index]
                                                      .netDue
                                                      .toString(),
                                                  textAlign:
                                                  TextAlign.end,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                      FontWeight
                                                          .w500,
                                                      fontSize: 15),
                                                ),
                                                title: SizedBox(
                                                  width: size.width /
                                                      2.5,
                                                  child: Text(
                                                    val
                                                        .busFeeList[
                                                    index]
                                                        .installmentName ??
                                                        '--',
                                                    style: const TextStyle(
                                                        fontWeight:
                                                        FontWeight
                                                            .w500,
                                                        fontSize: 15),
                                                  ),
                                                ),
                                              );
                                            });
                                      })),
                            ),
                          ),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.end,
                            crossAxisAlignment:
                            CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 25.0),
                                child: SizedBox(
                                  height: 30,
                                  width: size.width / 3.5,
                                  child: TextFormField(
                                    controller: _busController,
                                    cursorColor:
                                    UIGuide.light_Purple,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter
                                          .digitsOnly
                                    ],
                                    keyboardType:
                                    TextInputType.number,
                                    decoration: InputDecoration(
                                        focusColor:
                                        const Color.fromARGB(
                                            255,
                                            213,
                                            215,
                                            218),
                                        border:
                                        OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius
                                              .circular(10.0),
                                        ),
                                        focusedBorder:
                                        OutlineInputBorder(
                                          borderSide:
                                          const BorderSide(
                                              color: UIGuide
                                                  .light_Purple,
                                              width: 1.0),
                                          borderRadius:
                                          BorderRadius
                                              .circular(10.0),
                                        ),
                                        fillColor: Colors.grey,
                                        hintStyle:
                                        const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 16,
                                          fontFamily:
                                          "verdana_regular",
                                          fontWeight:
                                          FontWeight.w400,
                                        ),
                                        labelText: 'Amount',
                                        labelStyle:
                                        const TextStyle(
                                            color: Color
                                                .fromARGB(
                                                255,
                                                106,
                                                107,
                                                109))),
                                    onChanged: (value) {
                                      if (double.parse(
                                          _busController
                                              .text) ==
                                          0 ||
                                          _busController
                                              .text.isEmpty) {
                                        _busController.clear();
                                      } else if (double.parse(
                                          _busController
                                              .text) -
                                          1 >=
                                          partialBUS) {
                                        _busController.clear();
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    } else {
                      return Container(
                        height: 0,
                        width: 0,
                      );
                    }
                  },
                ),
                kheight20,
                kheight20,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.circular(8),
                            border: Border.all(
                                color: const Color.fromARGB(
                                    255, 223, 223, 223))),
                        child: const Padding(
                          padding: EdgeInsets.all(3.0),
                          child: Text(
                            'Last Transaction Details',
                            style: TextStyle(
                                color: UIGuide.light_Purple,
                                fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      onTap: () async {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(
                                        15)),
                                child: Consumer<FeesProvider>(
                                    builder: (context, provider,
                                        child) {
                                      String finalDate = "";

                                      if (provider
                                          .lastTransactionStartDate !=
                                          null) {
                                        String createddate = provider
                                            .lastTransactionStartDate ??
                                            '--';
                                        DateTime parsedDateTime =
                                        DateTime.parse(
                                            createddate);
                                        finalDate = DateFormat(
                                            'dd-MMM-yyyy')
                                            .format(parsedDateTime);
                                      }

                                      return Padding(
                                        padding:
                                        const EdgeInsets.all(8.0),
                                        child: SingleChildScrollView(
                                          scrollDirection:
                                          Axis.vertical,
                                          child: Column(
                                            mainAxisSize:
                                            MainAxisSize.min,
                                            children: [
                                              kheight10,
                                              const Padding(
                                                padding:
                                                EdgeInsets.all(
                                                    4.0),
                                                child: Text(
                                                  'Your last transaction  details',
                                                  textAlign: TextAlign
                                                      .center,
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight
                                                          .bold,
                                                      fontSize: 15,
                                                      color: UIGuide
                                                          .light_Purple),
                                                ),
                                              ),
                                              kheight5,
                                              Padding(
                                                padding:
                                                const EdgeInsets
                                                    .all(8.0),
                                                child: Row(
                                                  children: [
                                                    const Text(
                                                      'Transaction Date: ',
                                                      style: TextStyle(
                                                          fontSize:
                                                          13),
                                                    ),
                                                    Flexible(
                                                      child: RichText(
                                                        overflow:
                                                        TextOverflow
                                                            .ellipsis,
                                                        strutStyle:
                                                        const StrutStyle(),
                                                        maxLines: 3,
                                                        text: TextSpan(
                                                            style: const TextStyle(fontWeight: FontWeight.bold, color: UIGuide.light_Purple),
                                                            text:
                                                            // provider.title ??
                                                            finalDate),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets
                                                    .all(8.0),
                                                child: Row(
                                                  children: [
                                                    const Text(
                                                      'Transaction Amount: ',
                                                      style: TextStyle(
                                                          fontSize:
                                                          13),
                                                    ),
                                                    Text(
                                                      provider.lastTransactionAmount ==
                                                          null
                                                          ? ''
                                                          : provider
                                                          .lastTransactionAmount
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontWeight:
                                                          FontWeight
                                                              .bold,
                                                          color: UIGuide
                                                              .light_Purple),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets
                                                    .all(8.0),
                                                child: Row(
                                                  children: [
                                                    const Text(
                                                      'Transaction Status: ',
                                                      style: TextStyle(
                                                          fontSize:
                                                          13),
                                                    ),
                                                    Consumer<
                                                        FeesProvider>(
                                                      builder:
                                                          (context,
                                                          value,
                                                          child) {
                                                        String stats = provider
                                                            .lastOrderStatus ==
                                                            null
                                                            ? ''
                                                            : provider
                                                            .lastOrderStatus
                                                            .toString();
                                                        if (stats ==
                                                            "Success") {
                                                          return const Text(
                                                            "Success",
                                                            style: TextStyle(
                                                                fontWeight: FontWeight
                                                                    .bold,
                                                                color:
                                                                Colors.green),
                                                          );
                                                        } else if (stats ==
                                                            "Failed") {
                                                          return const Text(
                                                            "Failed",
                                                            style: TextStyle(
                                                                fontWeight: FontWeight
                                                                    .bold,
                                                                color:
                                                                Colors.red),
                                                          );
                                                        } else if (stats ==
                                                            "Cancelled") {
                                                          return const Text(
                                                            "Cancelled",
                                                            style: TextStyle(
                                                                fontWeight: FontWeight
                                                                    .bold,
                                                                color: Color.fromARGB(
                                                                    255,
                                                                    192,
                                                                    56,
                                                                    7)),
                                                          );
                                                        } else if (stats ==
                                                            "Processing") {
                                                          return const Text(
                                                            "Processing",
                                                            style: TextStyle(
                                                                fontWeight: FontWeight
                                                                    .bold,
                                                                color:
                                                                Colors.orange),
                                                          );
                                                        } else if (stats ==
                                                            "Pending") {
                                                          return const Text(
                                                            "Pending",
                                                            style: TextStyle(
                                                                fontWeight: FontWeight
                                                                    .bold,
                                                                color:
                                                                Colors.orange),
                                                          );
                                                        } else {
                                                          return const Text(
                                                            "--",
                                                            style: TextStyle(
                                                                fontWeight: FontWeight
                                                                    .bold,
                                                                color:
                                                                UIGuide.light_Purple),
                                                          );
                                                        }
                                                      },
                                                      child: Text(
                                                        provider.lastOrderStatus ==
                                                            null
                                                            ? ''
                                                            : provider
                                                            .lastOrderStatus
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontWeight:
                                                            FontWeight
                                                                .bold,
                                                            color: UIGuide
                                                                .light_Purple),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Consumer<FeesProvider>(
                                                builder: (context,
                                                    value, child) {
                                                  String status = provider
                                                      .lastOrderStatus ==
                                                      null
                                                      ? ''
                                                      : provider
                                                      .lastOrderStatus
                                                      .toString();
                                                  if (status ==
                                                      'Success' ||
                                                      status ==
                                                          'Failed') {
                                                    return Padding(
                                                      padding:
                                                      const EdgeInsets
                                                          .all(
                                                          8.0),
                                                      child: Row(
                                                        children: [
                                                          const Text(
                                                            'Download Receipt: ',
                                                            style: TextStyle(
                                                                fontSize:
                                                                13),
                                                          ),
                                                          GestureDetector(
                                                            onTap:
                                                                () async {
                                                              String orderID = await provider.orderId ==
                                                                  null
                                                                  ? ''
                                                                  : provider.orderId.toString();

                                                              await Provider.of<FeesProvider>(context,
                                                                  listen: false)
                                                                  .pdfDownload(orderID);
                                                              String
                                                              extenstion =
                                                                  await provider.extension ??
                                                                      '--';

                                                              SchedulerBinding
                                                                  .instance
                                                                  .addPostFrameCallback((_) {
                                                                Navigator
                                                                    .pushReplacement(
                                                                  context,
                                                                  MaterialPageRoute(builder: (context) => PdfDownload()),
                                                                );
                                                              });
                                                            },
                                                            child: const Icon(
                                                                Icons
                                                                    .download,
                                                                color:
                                                                UIGuide.light_Purple),
                                                          )
                                                        ],
                                                      ),
                                                    );
                                                  } else {
                                                    return Container(
                                                      height: 0,
                                                      width: 0,
                                                    );
                                                  }
                                                },
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets
                                                    .all(8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .end,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .end,
                                                  children: [
                                                    kWidth,
                                                    MaterialButton(
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                      height: 30,
                                                      onPressed:
                                                          () async {
                                                        Navigator.pop(
                                                            context);
                                                      },
                                                      color: UIGuide
                                                          .light_Purple,
                                                      child:
                                                      const Text(
                                                        'OK',
                                                        style: TextStyle(
                                                            color: UIGuide
                                                                .WHITE),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                              );
                            });
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 80,
                ),
              ],
            ),
            Positioned(
              bottom: 10,
              left: 10,
              right: 10,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 50, left: 10, right: 10),
                child: Consumer<FeesProvider>(
                  builder: (context, trans, child) =>
                      MaterialButton(
                        height: 45,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        onPressed: () async {
                          if (trans.gateway == null) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(
                              const SnackBar(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(20)),
                                ),
                                duration: Duration(seconds: 1),
                                margin: EdgeInsets.only(
                                    bottom: 80, left: 30, right: 30),
                                behavior: SnackBarBehavior.floating,
                                content: Text(
                                  'Payment Gateway not exist..! \n Please contact your School...',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                          } else {
                            if (trans.existMap == true) {
                              if (value.lastOrderStatus ==
                                  'Success' ||
                                  value.lastOrderStatus == 'Failed' ||
                                  value.lastOrderStatus == 'Cancelled' ||
                                 // value.lastOrderStatus =='Processing' ||
                                  // trans.lastOrderStatus == 'Pending' ||
                                  value.lastOrderStatus == null) {
                                if (_busController.text.isEmpty &&
                                    _feeController.text.isEmpty) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(
                                    const SnackBar(
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
                                        'Enter Amount...',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  );
                                } else {
                                  await totalFeeCollection();
                                  print(
                                      "totalFeeCollect $totalFeeCollect");

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////          get data of one             /////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



                                      List transactionList = [];
                                      transactionList.clear();
                                      String amount = '';
                                      for (int i = 0; i <
                                      trans.transactionList.length; i++) {
                                      if (
                                      trans.transactionList[i].name == "FEES"
                                      ) {
                                      amount = _feeController.text.isEmpty?'0':_feeController.text;
                                      }
                                      else if (
                                      trans.transactionList[i].name == "BUS FEES"
                                      ) {
                                      amount = _busController.text.isEmpty?"0":_busController.text;
                                      }
                                      else {
                                      amount = "0";
                                      }

                                      transactionList.add(
                                      {"name": trans.transactionList[i].name,
                                      "id": trans.transactionList[i].id,
                                      "amount": amount}
                                      );
                                      }
                                      if (trans.transactionList.length !=0) {
                                    print(
                                        '---------------1111111111--------------------');
                                    String transType = trans
                                        .transactionList[0]
                                        .name ??
                                        '--';
                                    String transId1 =
                                        trans.transactionList[0].id ??
                                            '--';
                                    String gateWay =
                                        trans.gateway ?? '--';
                                    print(transType);
                                    print(transId1);

                                    await AwesomeDialog(
                                      context: context,
                                      animType: AnimType.scale,
                                      dialogType: DialogType.info,
                                      title:
                                      'Do you want to continue the payment',
                                      desc:
                                      "Please don't go 𝐁𝐚𝐜𝐤 once the payment has been initialized!",
                                      btnOkOnPress: () async {
                                        if (trans.gateway ==
                                            'Paytm') {
                                          await Provider.of<
                                              FeesProvider>(
                                              context,
                                              listen: false)
                                              .getDataOne(
                                             transactionList,
                                              totalFeeCollect
                                                  .toString(),
                                              gateWay);

                                          String mid1 =
                                              trans.mid1 ?? '--';
                                          String orderId1 =
                                              trans.txnorderId1 ??
                                                  '--';
                                          String amount1 =
                                              trans.txnAmount1 ??
                                                  '--';
                                          String txntoken =
                                              trans.txnToken1 ?? '';
                                          print(txntoken);
                                          String callbackURL1 =
                                              trans.callbackUrl1 ??
                                                  '--';
                                          bool staging1 =
                                              trans.isStaging1 ??
                                                  true;

                                          if (txntoken.isEmpty) {
                                            ScaffoldMessenger.of(cont)
                                                .showSnackBar(
                                              const SnackBar(
                                                elevation: 10,
                                                shape:
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius
                                                      .all(Radius
                                                      .circular(
                                                      10)),
                                                ),
                                                duration: Duration(
                                                    seconds: 1),
                                                margin:
                                                EdgeInsets.only(
                                                    bottom: 80,
                                                    left: 30,
                                                    right: 30),
                                                behavior:
                                                SnackBarBehavior
                                                    .floating,
                                                content: Text(
                                                  'Something went wrong...',
                                                  textAlign: TextAlign
                                                      .center,
                                                ),
                                              ),
                                            );
                                          } else {
                                            await _startTransaction(
                                                txntoken,
                                                mid1,
                                                orderId1,
                                                amount1,
                                                callbackURL1,
                                                staging1);
                                          }
                                        }
                                        ///////////////////       RazorPay         ////////////////////////////////////////////////////
                                        else if (trans.gateway ==
                                            'RazorPay') {
                                          await Provider.of<
                                              FeesProvider>(
                                              context,
                                              listen: false)
                                              .getDataOneRAZORPAY(
                                              transactionList,
                                              totalFeeCollect
                                                  .toString(),
                                              gateWay);

                                          String key1 =
                                              trans.key1Razo ?? '--';
                                          String orede =
                                              trans.order1 ?? '--';

                                          String amount1R =
                                              trans.amount1Razo ??
                                                  '--';
                                          String name1 =
                                              trans.name1Razo ?? '';
                                          String description1 = trans
                                              .description1Razo ??
                                              '';
                                          String customer1 =
                                              trans.customer1Razo ??
                                                  '';
                                          String email1 =
                                              trans.email1Razo ?? '';
                                          String contact1 =
                                              trans.contact1Razo ??
                                                  '';
                                          String admNo1 =
                                              trans.admnNo1 ?? '';
                                          orderidd = trans.order1;
                                          readableid = trans.readableOrderid1;
                                          schoolId = trans.schoolId1;

                                          print(key1);
                                          print("reaaaaaaaaaaaaaaaaa1  :  $readableid");

                                          if (key1.isEmpty) {
                                            ScaffoldMessenger.of(
                                                context)
                                                .showSnackBar(
                                              const SnackBar(
                                                elevation: 10,
                                                shape:
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius
                                                      .all(Radius
                                                      .circular(
                                                      10)),
                                                ),
                                                duration: Duration(
                                                    seconds: 1),
                                                margin:
                                                EdgeInsets.only(
                                                    bottom: 80,
                                                    left: 30,
                                                    right: 30),
                                                behavior:
                                                SnackBarBehavior
                                                    .floating,
                                                content: Text(
                                                  'Something went wrong...',
                                                  textAlign: TextAlign
                                                      .center,
                                                ),
                                              ),
                                            );
                                          } else {
                                            await _startRazorpay(
                                              key1,
                                              amount1R,
                                              name1,
                                              description1,
                                              customer1,
                                              email1,
                                              contact1,
                                              admNo1,
                                              readableid.toString(),
                                              schoolId.toString(),
                                              orede,
                                            );
                                          }
                                        }

//  -----------------------------------------------------------------------------------------------------------------  //
///////////////////                                 TrakNPay                                    ////////////////////////
//  -----------------------------------------------------------------------------------------------------------------  //
                                        else if (trans.gateway ==
                                            'TrakNPayyyy') {
                                          await Provider.of<
                                              FeesProvider>(
                                              context,
                                              listen: false)
                                              .getDataOneTpay(
                                              transactionList,
                                              totalFeeCollect
                                                  .toString(),
                                              gateWay);

                                          String orderId =
                                              trans.orderIdTPay1 ??
                                                  '';
                                          String addressLine1 = trans
                                              .addressLine1TPay1 ??
                                              '';
                                          String city =
                                              trans.cityTPay1 ?? '';
                                          String udf5 =
                                              trans.udf1TPay1 ?? '';
                                          String state =
                                              trans.stateTPay1 ?? '';
                                          String udf4 =
                                              trans.udf4TPay1 ?? '';
                                          String phone =
                                              trans.phoneTPay1 ?? '';
                                          String zipCode =
                                              trans.zipCodeTPay1 ??
                                                  '';
                                          String currency =
                                              trans.currencyTPay1 ??
                                                  '';
                                          String email =
                                              trans.emailTPay1 ?? '';
                                          String country =
                                              trans.countryTPay1 ??
                                                  '';

                                          String salt =
                                              trans.saltTPay1 ?? '';
                                          String amount =
                                              trans.amountTPay1 ?? '';
                                          String name =
                                              trans.nameTPay1 ?? '';
                                          String apiKey =
                                              trans.apiKeyTPay1 ?? '';
                                          String udf3 =
                                              trans.udf3TPay1 ?? '';
                                          String udf2 =
                                              trans.udf2TPay1 ?? '';
                                          String returnUrl =
                                              trans.returnUrlTPay1 ??
                                                  '';
                                          String description = trans
                                              .descriptionTPay1 ??
                                              '';
                                          String udf1 =
                                              trans.udf1TPay1 ?? '';
                                          String addressLine2 = trans
                                              .addressLine2TPay1 ??
                                              '';

                                          if (apiKey.isEmpty) {
                                            ScaffoldMessenger.of(
                                                context)
                                                .showSnackBar(
                                              const SnackBar(
                                                elevation: 10,
                                                shape:
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius
                                                      .all(Radius
                                                      .circular(
                                                      10)),
                                                ),
                                                duration: Duration(
                                                    seconds: 1),
                                                margin:
                                                EdgeInsets.only(
                                                    bottom: 80,
                                                    left: 30,
                                                    right: 30),
                                                behavior:
                                                SnackBarBehavior
                                                    .floating,
                                                content: Text(
                                                  'Something went wrong...',
                                                  textAlign: TextAlign
                                                      .center,
                                                ),
                                              ),
                                            );
                                          } else {
                                            await _startTrakNPay(
                                                orderId,
                                                amount,
                                                currency,
                                                description,
                                                name,
                                                email,
                                                phone,
                                                addressLine1,
                                                addressLine2,
                                                city,
                                                state,
                                                country,
                                                zipCode,
                                                udf1,
                                                udf2,
                                                udf3,
                                                udf4,
                                                udf5,
                                                apiKey,
                                                salt,
                                                returnUrl);
                                          }
                                        }

//  -----------------------------------------------------------------------------------------------------------------  //
///////////////////                                 WorldLine                               ////////////////////////
//  -----------------------------------------------------------------------------------------------------------------  //
                                        else if (trans.gateway ==
                                            'WorldLine' ||
                                            trans.gateway ==
                                                "SibWorldLine") {
                                          await Provider.of<
                                              FeesProvider>(
                                              context,
                                              listen: false)
                                              .getDataOneWORLDLINE(
                                              transactionList,
                                              totalFeeCollect
                                                  .toString(),
                                              gateWay);

                                          String token =
                                              trans.token1WL ?? '';
                                          String paymentMode =
                                              trans.paymentMode1WL ??
                                                  '';
                                          String merchantId =
                                              trans.merchantId1WL ??
                                                  '';
                                          String currency =
                                              trans.currency1WL ?? '';
                                          String consumerId =
                                              trans.consumerId1WL ??
                                                  '';
                                          String consumerMobileNo =
                                              trans.consumerMobileNo1WL ??
                                                  '7356642999';
                                          String consumerEmailId = trans
                                              .consumerEmailId1WL ??
                                              'gjinfotech@gmail.com';
                                          txnId =
                                              trans.txnId1WL ?? '';
                                          bool? enableExpressPay =
                                              trans.enableExpressPay1WL ??
                                                  false;
                                          List? items =
                                              trans.items1WL ?? [];
                                          String cartDescription =
                                              trans.cartDescription1WL ??
                                                  "";

                                          if (token.isEmpty ||
                                              token == null) {
                                            ScaffoldMessenger.of(
                                                context)
                                                .showSnackBar(
                                              const SnackBar(
                                                elevation: 10,
                                                shape:
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius
                                                      .all(Radius
                                                      .circular(
                                                      10)),
                                                ),
                                                duration: Duration(
                                                    seconds: 1),
                                                margin:
                                                EdgeInsets.only(
                                                    bottom: 80,
                                                    left: 30,
                                                    right: 30),
                                                behavior:
                                                SnackBarBehavior
                                                    .floating,
                                                content: Text(
                                                  'Something went wrong...',
                                                  textAlign: TextAlign
                                                      .center,
                                                ),
                                              ),
                                            );
                                          } else {
                                            await _startWorldLine(
                                                enableExpressPay,
                                                token,
                                                paymentMode,
                                                merchantId,
                                                currency,
                                                consumerId,
                                                consumerMobileNo,
                                                consumerEmailId,
                                                txnId,
                                                items,
                                                cartDescription);
                                          }
                                        } else {
                                          ScaffoldMessenger.of(
                                              context)
                                              .showSnackBar(
                                            const SnackBar(
                                              elevation: 10,
                                              shape:
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.all(
                                                    Radius
                                                        .circular(
                                                        10)),
                                              ),
                                              duration: Duration(
                                                  seconds: 1),
                                              margin: EdgeInsets.only(
                                                  bottom: 80,
                                                  left: 30,
                                                  right: 30),
                                              behavior:
                                              SnackBarBehavior
                                                  .floating,
                                              content: Text(
                                                'Payment Gateway Not Provided...',
                                                textAlign:
                                                TextAlign.center,
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                      btnCancelOnPress: () {
                                        Navigator.of(_scaffoldKey
                                            .currentContext!)
                                            .pop();
                                        //      Navigator.pop(context);
                                      },
                                    ).show();
                                  }



/////////////////////////////            _busController.text.isEmpty                  /////////////////////////////////////////


                                    // else {
                                    //   ScaffoldMessenger.of(cont)
                                    //       .showSnackBar(
                                    //     const SnackBar(
                                    //       elevation: 10,
                                    //       shape:
                                    //       RoundedRectangleBorder(
                                    //         borderRadius:
                                    //         BorderRadius.all(
                                    //             Radius.circular(
                                    //                 10)),
                                    //       ),
                                    //       duration:
                                    //       Duration(seconds: 1),
                                    //       margin: EdgeInsets.only(
                                    //           bottom: 80,
                                    //           left: 30,
                                    //           right: 30),
                                    //       behavior: SnackBarBehavior
                                    //           .floating,
                                    //       content: Text(
                                    //         'Something Went Wrong.....!',
                                    //         textAlign:
                                    //         TextAlign.center,
                                    //       ),
                                    //     ),
                                    //   );
                                    // }
                                  //}
                                  else if (trans
                                      .transactionList.length ==
                                      0) {
                                    ScaffoldMessenger.of(cont)
                                        .showSnackBar(
                                      const SnackBar(
                                        elevation: 10,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.all(
                                              Radius.circular(
                                                  10)),
                                        ),
                                        duration:
                                        Duration(seconds: 1),
                                        margin: EdgeInsets.only(
                                            bottom: 80,
                                            left: 30,
                                            right: 30),
                                        behavior:
                                        SnackBarBehavior.floating,
                                        content: Text(
                                          'Something Went Wrong.....!',
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    );
                                  }
                                  else {
                                    print(
                                      trans.transactionList.length,
                                    );
                                    print('Something Went wrong1');
                                    ScaffoldMessenger.of(cont)
                                        .showSnackBar(
                                      const SnackBar(
                                        elevation: 10,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.all(
                                              Radius.circular(
                                                  10)),
                                        ),
                                        duration:
                                        Duration(seconds: 1),
                                        margin: EdgeInsets.only(
                                            bottom: 80,
                                            left: 30,
                                            right: 30),
                                        behavior:
                                        SnackBarBehavior.floating,
                                        content: Text(
                                          'Something Went Wrong.....!',
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    );
                                  }
                                }
                              } else if (value.lastOrderStatus ==
                                  'Processing') {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(
                                  const SnackBar(
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20)),
                                    ),
                                    duration: Duration(seconds: 5),
                                    margin: EdgeInsets.only(
                                        bottom: 80,
                                        left: 30,
                                        right: 30),
                                    behavior:
                                    SnackBarBehavior.floating,
                                    content: Text(
                                      'Please wait for 30 minutes...\n Your payment is under 𝗣𝗿𝗼𝗰𝗲𝘀𝘀𝗶𝗻𝗴',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                );
                              } else if (value.lastOrderStatus ==
                                  'Pending') {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(
                                  const SnackBar(
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20)),
                                    ),
                                    duration: Duration(seconds: 5),
                                    margin: EdgeInsets.only(
                                        bottom: 80,
                                        left: 30,
                                        right: 30),
                                    behavior:
                                    SnackBarBehavior.floating,
                                    content: Text(
                                      'Please wait for 30 minutes...\n Your payment is under 𝐏𝐞𝐧𝐝𝐢𝐧𝐠',
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
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20)),
                                    ),
                                    duration: Duration(seconds: 5),
                                    margin: EdgeInsets.only(
                                        bottom: 80,
                                        left: 30,
                                        right: 30),
                                    behavior:
                                    SnackBarBehavior.floating,
                                    content: Text(
                                      'Please wait for 30 minutes...\n Your payment is under 𝐏𝐫𝐨𝐜𝐞𝐬𝐬𝐢𝐧𝐠 / 𝐒𝐮𝐜𝐜𝐞𝐬𝐬 / 𝐅𝐚𝐢𝐥𝐞𝐝 / 𝐂𝐚𝐧𝐜𝐞𝐥𝐥𝐞𝐝',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                );
                              }
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(
                                const SnackBar(
                                  elevation: 10,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20)),
                                  ),
                                  duration: Duration(seconds: 5),
                                  margin: EdgeInsets.only(
                                      bottom: 80,
                                      left: 30,
                                      right: 30),
                                  behavior: SnackBarBehavior.floating,
                                  content: Text(
                                    'Issue in Vendor Mapping..!,\n Please contact School...',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              );
                            }
                          }
                        },
                        color: UIGuide.light_Purple,
                        child: const Text(
                          'Proceed to Pay',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 16),
                        ),
                      ),
                ),
              ),
            ),
          ],
        )
            : const Text('');
      }),
    );
  }

  ///////////////////////////////////////////////////////////////////////

  String result = "";
  bool restrictAppInvoke = true;

  Future<void> _startTransaction(
      String txnToken,
      String mid,
      String orderId,
      String amount,
      String callbackUrl,
      bool isStaging,
      ) async {
    if (txnToken.isEmpty) {
      return;
    }

    print('sendMap');
    var size = MediaQuery.of(context).size;
    try {
      var response = AllInOneSdk.startTransaction(
        mid,
        orderId,
        amount,
        txnToken,
        callbackUrl,
        isStaging,
        restrictAppInvoke,
      );
      response.then((value) {
        print(value);
        log(value.toString());
        setState(() {
          result = value.toString();
        });
        print('-----------------------------------------------------------');
        _showAlert(context, orderId);
      }).catchError((onError) {
        if (onError is PlatformException) {
          print('-------------------Failed-----------------');
          _showAlert(context, orderId);
          setState(() {
            result = onError.message.toString() +
                " \n  " +
                onError.details.toString();
          });
        } else {
          setState(() {
            print('-------------------Pending-----------------');
            _showAlert(context, orderId);
            result = onError.toString();
          });
        }
      });
    } catch (err) {
      _showAlert(context, orderId);
      print('-------------------ERROR-----------------');
      result = err.toString();
    }
  }

  void _showAlert(BuildContext context, String orderID) async {
    var size = MediaQuery.of(context).size;
    await Provider.of<FinalStatusProvider>(context, listen: false)
        .transactionStatus(orderID);
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Consumer<FinalStatusProvider>(
          builder: (context, paytm, child) {
            if (paytm.reponseCode == '01') {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                content: Container(
                  height: size.height / 4,
                  width: size.width * 3,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: AlignmentDirectional.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: size.height / 10,
                          ),
                          const Text(
                            "TRANSACTION SUCCESS",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 20,
                                color: UIGuide.light_Purple),
                          ),
                          kheight20,
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                      MaterialStateProperty.all(
                                          UIGuide.light_Purple),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder:
                                                  (context) =>
                                                  StudentHome()),
                                              (Route<dynamic> route) =>
                                          false);
                                    },
                                    child: const Text(
                                      'Back to Home',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 18,
                                          color: UIGuide.WHITE),
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                      Positioned(
                        top: -190,
                        child: CircleAvatar(
                            radius: 165,
                            backgroundColor: Colors.transparent,
                            child: LottieBuilder.asset(
                              'assets/89618-gopay-succesfull-payment.json',
                            )),
                      )
                    ],
                  ),
                ),
              );
            } else if (paytm.reponseCode == '810' ||
                paytm.reponseCode == '501' ||
                paytm.reponseCode == '401' ||
                paytm.reponseCode == '335' ||
                paytm.reponseCode == '334' ||
                paytm.reponseCode == '295' ||
                paytm.reponseCode == '235' ||
                paytm.reponseCode == '227') {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                content: Container(
                  height: size.height / 4,
                  width: size.width * 3,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: AlignmentDirectional.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: size.height / 10,
                          ),
                          const Text(
                            "TRANSACTION FAILED",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 20,
                                color: UIGuide.light_Purple),
                          ),
                          kheight20,
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                      MaterialStateProperty.all(
                                          UIGuide.light_Purple),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder:
                                                  (context) =>
                                                  StudentHome()),
                                              (Route<dynamic> route) =>
                                          false);
                                    },
                                    child: const Text(
                                      'Back to Home',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 18,
                                          color: UIGuide.WHITE),
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                      Positioned(
                        top: -80,
                        child: CircleAvatar(
                            radius: 70,
                            backgroundColor: Colors.white,
                            child: SvgPicture.asset(UIGuide.failed)),
                      )
                    ],
                  ),
                ),
              );
            } else if (paytm.reponseCode == '400' ||
                paytm.reponseCode == '402') {
              AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                content: Container(
                  height: size.height / 4,
                  width: size.width * 3,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: AlignmentDirectional.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: size.height / 10,
                          ),
                          const Text(
                            "TRANSACTION PENDING",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 20,
                                color: UIGuide.light_Purple),
                          ),
                          kheight20,
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                      MaterialStateProperty.all(
                                          UIGuide.light_Purple),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder:
                                                  (context) =>
                                                  StudentHome()),
                                              (Route<dynamic> route) =>
                                          false);
                                    },
                                    child: const Text(
                                      'Back to Home',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 18,
                                          color: UIGuide.WHITE),
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                      Positioned(
                        top: -90,
                        child: CircleAvatar(
                            radius: 80,
                            backgroundColor: Colors.transparent,
                            child: SvgPicture.asset(UIGuide.pending)),
                      )
                    ],
                  ),
                ),
              );
            } else {
              AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                content: Container(
                  height: size.height / 4,
                  width: size.width * 3,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: AlignmentDirectional.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: size.height / 10,
                          ),
                          const Text(
                            "Something went wrong",
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 20,
                                color: UIGuide.light_Purple),
                          ),
                          kheight20,
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                      MaterialStateProperty.all(
                                          UIGuide.light_Purple),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder:
                                                  (context) =>
                                                  StudentHome()),
                                              (Route<dynamic> route) =>
                                          false);
                                    },
                                    child: const Text(
                                      'Back to Home',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 18,
                                          color: UIGuide.WHITE),
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                      Positioned(
                        top: -90,
                        child: CircleAvatar(
                            radius: 80,
                            backgroundColor: Colors.transparent,
                            child: SvgPicture.asset(
                                UIGuide.somethingWentWrong)),
                      )
                    ],
                  ),
                ),
              );
            }
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              content: Container(
                height: size.height / 4,
                width: size.width * 3,
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: AlignmentDirectional.center,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: size.height / 10,
                        ),
                        const Text(
                          "Something went wrong",
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 20,
                              color: UIGuide.light_Purple),
                        ),
                        kheight20,
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                    MaterialStateProperty.all(
                                        UIGuide.light_Purple),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                StudentHome()),
                                            (Route<dynamic> route) =>
                                        false);
                                  },
                                  child: const Text(
                                    'Back to Home',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 18,
                                        color: UIGuide.WHITE),
                                  ))
                            ],
                          ),
                        )
                      ],
                    ),
                    Positioned(
                      top: -90,
                      child: CircleAvatar(
                          radius: 80,
                          backgroundColor: Colors.transparent,
                          child:
                          SvgPicture.asset(UIGuide.somethingWentWrong)),
                    )
                  ],
                ),
              ),
            );
          },
        ));
  }

//-------------------     Razorpay       ---------------------------------

  _startRazorpay(String key, String amount, String name, String description,
      String nameP, String email, String contact, String admno,String readableOrderid,String schoold,String orderId) async {
    Razorpay razorpay = Razorpay();
    print("------------start--------------------");
    var options = {
      'key': key,
      'amount': amount,
      'order_id': orderId,
      'name': name,
      'description': description,
      'retry': {'enabled': false},
      'prefill': {"name": nameP, "email": email, "contact": contact},
      'notes' : {
        "admissionNumber": admno,
        "name": name,
        "readableOrderid": readableOrderid,
        "schoold": schoold,

      },
      'modal': {
        "confirm_close": true,
        "animation": true,
        "handleback": true,
        "escape": true,
      }
    };
    print({
      'key': key,
      'amount': amount,
      'order_id': orderId,
      'name': name,
      'description': description,
      'retry': {'enabled': false},
      'prefill': {"name": nameP, "email": email, "contact": contact},
      'notes' : {
        "admissionNumber": admno,
        "name": name,
        "readableOrderid": readableOrderid,
        "schoold": schoold,

      },
      'modal': {
        "confirm_close": true,
        "animation": true,
        "handleback": true,
        "escape": true,
      }
    });
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);

    // razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);
    razorpay.open(options);
  }

  void handlePaymentErrorResponse(PaymentFailureResponse response) async {

    print('------------------Failed-----------------------------');
    print("eroror");
    print(response.message);
    String lastresponse11= response.error.toString();
    lastresponse=lastresponse11.replaceAll('{', '').replaceAll('}', '');
    print(lastresponse);

    print("eroror");
    await _showAlertRazorPay(context, readableid!, orderidd!);
  }

  void handlePaymentSuccessResponse(
      PaymentSuccessResponse response,
      ) async {
    print('------------------Success-----------------------------');
    print("success");
    print(response.toString());
    lastresponse= "Order ID:${response.orderId},Payment ID:${response.paymentId},Signature:${response.signature}";
    print(lastresponse);
    print("success");
    await _showAlertRazorPay(context, readableid!, orderidd!);


    print(response.toString());
  }


  //void handleExternalWalletSelected(ExternalWalletResponse response) {}

  _showAlertRazorPay(
      BuildContext context,
      String readable,
      String orderID,
      ) async {
    var size = MediaQuery.of(context).size;
    String order = (readable + "_" + orderID);
    await Provider.of<FinalStatusProvider>(context, listen: false)
        .transactionStatusRazorPay(order,lastresponse.toString());
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Consumer<FinalStatusProvider>(
          builder: (context, razor, child) {
            if (razor.reponseMsgRazor == 'captured') {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                content: Container(
                  height: size.height / 4,
                  width: size.width * 3,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: AlignmentDirectional.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: size.height / 10,
                          ),
                          const Text(
                            "TRANSACTION SUCCESS",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 20,
                                color: UIGuide.light_Purple),
                          ),
                          kheight20,
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                      MaterialStateProperty.all(
                                          UIGuide.light_Purple),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder:
                                                  (context) =>
                                                  StudentHome()),
                                              (Route<dynamic> route) =>
                                          false);
                                    },
                                    child: const Text(
                                      'Back to Home',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 18,
                                          color: UIGuide.WHITE),
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                      Positioned(
                        top: -190,
                        child: CircleAvatar(
                            radius: 165,
                            backgroundColor: Colors.transparent,
                            child: LottieBuilder.asset(
                              'assets/89618-gopay-succesfull-payment.json',
                            )),
                      )
                    ],
                  ),
                ),
              );
            } else if (razor.reponseMsgRazor == 'failed') {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                content: Container(
                  height: size.height / 4,
                  width: size.width * 3,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: AlignmentDirectional.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: size.height / 10,
                          ),
                          const Text(
                            "TRANSACTION FAILED",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 20,
                                color: UIGuide.light_Purple),
                          ),
                          kheight20,
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                      MaterialStateProperty.all(
                                          UIGuide.light_Purple),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder:
                                                  (context) =>
                                                  StudentHome()),
                                              (Route<dynamic> route) =>
                                          false);
                                    },
                                    child: const Text(
                                      'Back to Home',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 18,
                                          color: UIGuide.WHITE),
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                      Positioned(
                        top: -80,
                        child: CircleAvatar(
                            radius: 70,
                            backgroundColor: Colors.white,
                            child: SvgPicture.asset(UIGuide.failed)),
                      )
                    ],
                  ),
                ),
              );
            } else if (razor.reponseCode == null) {
              AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                content: Container(
                  height: size.height / 4,
                  width: size.width * 3,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: AlignmentDirectional.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: size.height / 10,
                          ),
                          const Text(
                            "TRANSACTION PENDING",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 20,
                                color: UIGuide.light_Purple),
                          ),
                          kheight20,
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                      MaterialStateProperty.all(
                                          UIGuide.light_Purple),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder:
                                                  (context) =>
                                                  StudentHome()),
                                              (Route<dynamic> route) =>
                                          false);
                                    },
                                    child: const Text(
                                      'Back to Home',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 18,
                                          color: UIGuide.WHITE),
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                      Positioned(
                        top: -90,
                        child: CircleAvatar(
                            radius: 80,
                            backgroundColor: Colors.transparent,
                            child: SvgPicture.asset(UIGuide.pending)),
                      )
                    ],
                  ),
                ),
              );
            } else {
              AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                content: Container(
                  height: size.height / 4,
                  width: size.width * 3,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: AlignmentDirectional.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: size.height / 10,
                          ),
                          const Text(
                            "Something went wrong",
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 20,
                                color: UIGuide.light_Purple),
                          ),
                          kheight20,
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                      MaterialStateProperty.all(
                                          UIGuide.light_Purple),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder:
                                                  (context) =>
                                                  StudentHome()),
                                              (Route<dynamic> route) =>
                                          false);
                                    },
                                    child: const Text(
                                      'Back to Home',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 18,
                                          color: UIGuide.WHITE),
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                      Positioned(
                        top: -90,
                        child: CircleAvatar(
                            radius: 80,
                            backgroundColor: Colors.transparent,
                            child: SvgPicture.asset(
                                UIGuide.somethingWentWrong)),
                      )
                    ],
                  ),
                ),
              );
            }
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              content: Container(
                height: size.height / 4,
                width: size.width * 3,
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: AlignmentDirectional.center,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: size.height / 10,
                        ),
                        const Text(
                          "Something went wrong",
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 20,
                              color: UIGuide.light_Purple),
                        ),
                        kheight20,
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                    MaterialStateProperty.all(
                                        UIGuide.light_Purple),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                StudentHome()),
                                            (Route<dynamic> route) =>
                                        false);
                                  },
                                  child: const Text(
                                    'Back to Home',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 18,
                                        color: UIGuide.WHITE),
                                  ))
                            ],
                          ),
                        )
                      ],
                    ),
                    Positioned(
                      top: -90,
                      child: CircleAvatar(
                          radius: 80,
                          backgroundColor: Colors.transparent,
                          child:
                          SvgPicture.asset(UIGuide.somethingWentWrong)),
                    )
                  ],
                ),
              ),
            );
          },
        ));
  }

//////////////----------------------------  TrakNpay    ---------------------
  _startTrakNPay(
      String orderId,
      String amount,
      String currency,
      String description,
      String name,
      String email,
      String phone,
      String address1,
      String address2,
      String city,
      String state,
      String country,
      String zipcode,
      String udf1,
      String udf2,
      String udf3,
      String udf4,
      String udf5,
      String apiKey,
      String saltKey,
      String returnUrl) async {
    Map<String, dynamic>? paymentRequestDictionary = {
      "orderId": orderId,
      "amount": amount,
      "currency": currency,
      "description": description.isEmpty ? "Online Fees Payment" : description,
      "name": name.isEmpty ? "demo" : name,
      "email": email.isEmpty ? "gjinfotech@gmail.com" : email,
      "phone": phone.isEmpty ? "7356642999" : phone,
      "addressLine1": address1.isEmpty ? "address" : address1,
      "addressLine2": address2.isEmpty ? "address" : address2,
      "city": city.isEmpty ? "Irinjalakkuda" : city,
      "state": state.isEmpty ? "Kerala" : state,
      "country": country.isEmpty ? "India" : country,
      "zipCode": zipcode.isEmpty ? "680125" : zipcode,
      "udf1": udf1.isEmpty ? "udf1" : udf1,
      "udf2": udf2.isEmpty ? "udf2" : udf2,
      "udf3": udf3.isEmpty ? "udf3" : udf3,
      "udf4": udf4.isEmpty ? "udf4" : udf4,
      "udf5": udf5.isEmpty ? "udf5" : udf5,
    };
    print(
        "******************            $paymentRequestDictionary        ***********************");
    // try {
    //   var response = Basispaysdk.startTransaction(
    //       apiKey, //[API-KEY From Basispay team]
    //       saltKey, //[SALT-KEY From Basispay team]
    //       returnUrl, //[YOUR- RETURN URL to get the response]
    //       false,
    //       paymentRequestDictionary);
    //   response.then((value) {
    //     print(value);
    //     print("=======================================================");
    //     setState(() {});
    //     showAlertTrakNPay(context, orderId);
    //   }).catchError((onError) {
    //     if (onError is PlatformException) {
    //       print('-------------------Failed-----------------');
    //       showAlertTrakNPay(context, orderId);
    //       setState(() {
    //         print(onError.message! + " \n  " + onError.details.toString());
    //       });
    //     } else {
    //       setState(() {
    //         showAlertTrakNPay(context, orderId);
    //         print('-------------------Pending-----------------');
    //         print(onError.toString());
    //       });
    //     }
    //   });
    // } catch (err) {
    //   showAlertTrakNPay(context, orderId);
    //   print('-------------------ERROR-----------------');
    //   print(err.toString());
    // }
  }

  //////////////////

  String cutStringAfterLetter(String originalString, String letter) {
    int index = originalString.indexOf(letter);
    if (index != -1) {
      return originalString.substring(index + 1, originalString.length);
    } else {
      return originalString;
    }
  }

  showAlertTrakNPay(
      BuildContext context,
      String orderID,
      ) async {
    var size = MediaQuery.of(context).size;
    String order = orderID;
    String underScore = '_';
    String cutString = cutStringAfterLetter(order, underScore);

    print(cutString);
    log(cutString.toString());
    await Provider.of<FeesProvider>(context, listen: false)
        .payStatusButton(cutString.toString());
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Consumer<FeesProvider>(
          builder: (contex, trak, child) {
            print(trak.statusss);
            print('----------');
            if (trak.statusss == 'Success') {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                content: Container(
                  height: size.height / 4,
                  width: size.width * 3,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: AlignmentDirectional.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: size.height / 10,
                          ),
                          const Text(
                            "TRANSACTION SUCCESS",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 20,
                                color: UIGuide.light_Purple),
                          ),
                          kheight20,
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                      MaterialStateProperty.all(
                                          UIGuide.light_Purple),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder:
                                                  (context) =>
                                                  StudentHome()),
                                              (Route<dynamic> route) =>
                                          false);
                                    },
                                    child: const Text(
                                      'Back to Home',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 18,
                                          color: UIGuide.WHITE),
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                      Positioned(
                        top: -190,
                        child: CircleAvatar(
                            radius: 165,
                            backgroundColor: Colors.transparent,
                            child: LottieBuilder.asset(
                              'assets/89618-gopay-succesfull-payment.json',
                            )),
                      )
                    ],
                  ),
                ),
              );
            } else if (trak.statusss == 'Failed') {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                content: Container(
                  height: size.height / 4,
                  width: size.width * 3,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: AlignmentDirectional.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: size.height / 10,
                          ),
                          const Text(
                            "TRANSACTION FAILED",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 20,
                                color: UIGuide.light_Purple),
                          ),
                          kheight20,
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                      MaterialStateProperty.all(
                                          UIGuide.light_Purple),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder:
                                                  (context) =>
                                                  StudentHome()),
                                              (Route<dynamic> route) =>
                                          false);
                                    },
                                    child: const Text(
                                      'Back to Home',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 18,
                                          color: UIGuide.WHITE),
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                      Positioned(
                        top: -80,
                        child: CircleAvatar(
                            radius: 70,
                            backgroundColor: Colors.white,
                            child: SvgPicture.asset(UIGuide.failed)),
                      )
                    ],
                  ),
                ),
              );
            } else if (trak.statusss == "Processing") {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                content: Container(
                  height: size.height / 4,
                  width: size.width * 3,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: AlignmentDirectional.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: size.height / 10,
                          ),
                          const Text(
                            "TRANSACTION PROCESSING",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                                color: UIGuide.light_Purple),
                          ),
                          kheight20,
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                      MaterialStateProperty.all(
                                          UIGuide.light_Purple),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder:
                                                  (context) =>
                                                  StudentHome()),
                                              (Route<dynamic> route) =>
                                          false);
                                    },
                                    child: const Text(
                                      'Back to Home',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 18,
                                          color: UIGuide.WHITE),
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                      Positioned(
                        top: -90,
                        child: CircleAvatar(
                            radius: 80,
                            backgroundColor: Colors.transparent,
                            child: SvgPicture.asset(UIGuide.pending)),
                      )
                    ],
                  ),
                ),
              );
            } else if (trak.statusss == "Pending") {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                content: Container(
                  height: size.height / 4,
                  width: size.width * 3,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: AlignmentDirectional.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: size.height / 10,
                          ),
                          const Text(
                            "TRANSACTION PENDING",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 20,
                                color: UIGuide.light_Purple),
                          ),
                          kheight20,
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                      MaterialStateProperty.all(
                                          UIGuide.light_Purple),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder:
                                                  (context) =>
                                                  StudentHome()),
                                              (Route<dynamic> route) =>
                                          false);
                                    },
                                    child: const Text(
                                      'Back to Home',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 18,
                                          color: UIGuide.WHITE),
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                      Positioned(
                        top: -90,
                        child: CircleAvatar(
                            radius: 80,
                            backgroundColor: Colors.transparent,
                            child: SvgPicture.asset(UIGuide.pending)),
                      )
                    ],
                  ),
                ),
              );
            } else if (trak.statusss == null) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                content: Container(
                  height: size.height / 4,
                  width: size.width * 3,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: AlignmentDirectional.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: size.height / 10,
                          ),
                          const Text(
                            "TRANSACTION PENDING",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 20,
                                color: UIGuide.light_Purple),
                          ),
                          kheight20,
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                      MaterialStateProperty.all(
                                          UIGuide.light_Purple),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder:
                                                  (context) =>
                                                  StudentHome()),
                                              (Route<dynamic> route) =>
                                          false);
                                    },
                                    child: const Text(
                                      'Back to Home',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 18,
                                          color: UIGuide.WHITE),
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                      Positioned(
                        top: -90,
                        child: CircleAvatar(
                            radius: 80,
                            backgroundColor: Colors.transparent,
                            child: SvgPicture.asset(UIGuide.pending)),
                      )
                    ],
                  ),
                ),
              );
            } else {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                content: Container(
                  height: size.height / 4,
                  width: size.width * 3,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: AlignmentDirectional.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: size.height / 10,
                          ),
                          const Text(
                            "Something went wrong",
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 20,
                                color: UIGuide.light_Purple),
                          ),
                          kheight20,
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                      MaterialStateProperty.all(
                                          UIGuide.light_Purple),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder:
                                                  (context) =>
                                                  StudentHome()),
                                              (Route<dynamic> route) =>
                                          false);
                                    },
                                    child: const Text(
                                      'Back to Home',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 18,
                                          color: UIGuide.WHITE),
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                      Positioned(
                        top: -90,
                        child: CircleAvatar(
                            radius: 80,
                            backgroundColor: Colors.transparent,
                            child: SvgPicture.asset(
                                UIGuide.somethingWentWrong)),
                      )
                    ],
                  ),
                ),
              );
            }
          },
        ));
  }

//         ----------------------------------------------------------------------------------------            //
//         ***********************                WORLDLINE              *************************            //
//         ----------------------------------------------------------------------------------------          //
  String deviceID = "";
  _startWorldLine(
      bool enableExpressPay,
      String token,
      String paymentMode,
      String merchantId,
      String currency,
      String consumerId,
      String consumerMobileNo,
      String consumerEmailId,
      String txnIdd,
      List items,
      String cartDescrip) {
    try {
      if (Platform.isAndroid) {
        deviceID =
        "AndroidSH2"; // Android-specific deviceId, supported options are "AndroidSH1" & "AndroidSH2"
      } else if (Platform.isIOS) {
        deviceID =
        "iOSSH2"; // iOS-specific deviceId, supported options are "iOSSH1" & "iOSSH2"
      }

      var reqJson = {
        "features": {
          "enableAbortResponse": true,
          "enableExpressPay": enableExpressPay,
          "enableInstrumentDeRegistration": true,
          "enableMerTxnDetails": true
        },
        "consumerData": {
          "deviceId": deviceID,
          "token": token,
          "paymentMode": paymentMode,
          "merchantLogoUrl":
          "https://www.paynimo.com/CompanyDocs/company-logo-vertical.png", //provided merchant logo will be displayed
          "merchantId": merchantId,
          "currency": currency,
          "consumerId": consumerId,
          "consumerMobileNo": consumerMobileNo,
          "consumerEmailId": consumerEmailId,
          "txnId": txnIdd, //Unique merchant transaction ID
          "cartDescription": cartDescrip,
          "items": items,
          "customStyle": {
            "PRIMARY_COLOR_CODE": "#45beaa", //merchant primary color code
            "SECONDARY_COLOR_CODE":
            "#FFFFFF", //provide merchant"s suitable color code
            "BUTTON_COLOR_CODE_1":
            "#aa7de8", //merchant"s button background color code
            "BUTTON_COLOR_CODE_2":
            "#FFFFFF" //provide merchant"s suitable color code for button text
          }
        }
      };
      print(
          "-------------------------------****    $reqJson    ----------------");
      wlCheckoutFlutter.on(WeiplCheckoutFlutter.wlResponse, handleResponse);
      wlCheckoutFlutter.open(reqJson);
    } catch (e) {
      print('-------------------ERROR-----------------');
      wlCheckoutFlutter.on(WeiplCheckoutFlutter.wlResponse, handleResponse);
    }
  }

/////////////--------------- Show Alert WORLDLine
  void handleResponse(Map<dynamic, dynamic> response) async {
    print("------------correct-------------");
    print("----------------------$response");
    await showAlertWORLDLine(context, txnId, response.toString());
    print("worldddddddd");
    print(response);
  }

  Future showAlertWORLDLine(
      BuildContext contex, String orderID, String response) async {
    var size = MediaQuery.of(context).size;
    List words = [];
    words.clear();
    words = response.split("|");
    print(words);
    print(words[5]);
    String paymentGatewayTransactionId = words[5];
    await Future.delayed(const Duration(seconds: 5));
    await Provider.of<FinalStatusProvider>(contex, listen: false)
        .transactionStatusWorldLine(orderID, paymentGatewayTransactionId,response.toString());
    // await Provider.of<FinalStatusProvider>(contex, listen: false)
    //     .transactionStatusWorldLine(orderID, paymentGatewayTransactionId);
    await showDialog(
        context: contex,
        barrierDismissible: false,
        builder: (context) => Consumer<FinalStatusProvider>(
          builder: (contex, trak, _) {
            print('-------${trak.reponseCodeWorldLine}');
            if (trak.reponseCodeWorldLine == '0300') {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                content: Container(
                  height: size.height / 4,
                  width: size.width * 3,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: AlignmentDirectional.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: size.height / 10,
                          ),
                          const Text(
                            "TRANSACTION SUCCESS",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 20,
                                color: UIGuide.light_Purple),
                          ),
                          kheight20,
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                    MaterialStateProperty.all(
                                        UIGuide.light_Purple),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                StudentHome()),
                                            (Route<dynamic> route) =>
                                        false);
                                  },
                                  child: const Text(
                                    'Back to Home',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 18,
                                        color: UIGuide.WHITE),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Positioned(
                        top: -190,
                        child: CircleAvatar(
                            radius: 165,
                            backgroundColor: Colors.transparent,
                            child: LottieBuilder.asset(
                              'assets/89618-gopay-succesfull-payment.json',
                            )),
                      )
                    ],
                  ),
                ),
              );
            } else if (trak.reponseCodeWorldLine == '0399') {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                content: Container(
                  height: size.height / 4,
                  width: size.width * 3,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: AlignmentDirectional.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: size.height / 10,
                          ),
                          const Text(
                            "TRANSACTION FAILED",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 20,
                                color: UIGuide.light_Purple),
                          ),
                          kheight20,
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                    MaterialStateProperty.all(
                                        UIGuide.light_Purple),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                StudentHome()),
                                            (Route<dynamic> route) =>
                                        false);
                                  },
                                  child: const Text(
                                    'Back to Home',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 18,
                                        color: UIGuide.WHITE),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Positioned(
                        top: -80,
                        child: CircleAvatar(
                            radius: 70,
                            backgroundColor: Colors.white,
                            child: SvgPicture.asset(UIGuide.failed)),
                      )
                    ],
                  ),
                ),
              );
            } else if (trak.reponseCodeWorldLine == '0396' ||
                trak.reponseCodeWorldLine == '9999') {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                content: Container(
                  height: size.height / 4,
                  width: size.width * 3,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: AlignmentDirectional.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: size.height / 10,
                          ),
                          const Text(
                            "TRANSACTION PROCESSING",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                                color: UIGuide.light_Purple),
                          ),
                          kheight20,
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                      MaterialStateProperty.all(
                                          UIGuide.light_Purple),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder:
                                                  (context) =>
                                                  StudentHome()),
                                              (Route<dynamic> route) =>
                                          false);
                                    },
                                    child: const Text(
                                      'Back to Home',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 18,
                                          color: UIGuide.WHITE),
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                      Positioned(
                        top: -90,
                        child: CircleAvatar(
                            radius: 80,
                            backgroundColor: Colors.transparent,
                            child: SvgPicture.asset(UIGuide.pending)),
                      )
                    ],
                  ),
                ),
              );
            } else if (trak.reponseCodeWorldLine == '0398') {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                content: Container(
                  height: size.height / 4,
                  width: size.width * 3,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: AlignmentDirectional.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: size.height / 10,
                          ),
                          const Text(
                            "TRANSACTION PENDING",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 20,
                                color: UIGuide.light_Purple),
                          ),
                          kheight20,
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                      MaterialStateProperty.all(
                                          UIGuide.light_Purple),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder:
                                                  (context) =>
                                                  StudentHome()),
                                              (Route<dynamic> route) =>
                                          false);
                                    },
                                    child: const Text(
                                      'Back to Home',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 18,
                                          color: UIGuide.WHITE),
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                      Positioned(
                        top: -90,
                        child: CircleAvatar(
                            radius: 80,
                            backgroundColor: Colors.transparent,
                            child: SvgPicture.asset(UIGuide.pending)),
                      )
                    ],
                  ),
                ),
              );
            } else if (trak.reponseCodeWorldLine == '0392') {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                content: Container(
                  height: size.height / 4,
                  width: size.width * 3,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: AlignmentDirectional.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: size.height / 10,
                          ),
                          const Text(
                            "TRANSACTION  CANCELLED",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 17,
                                color: UIGuide.light_Purple),
                          ),
                          kheight20,
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                      MaterialStateProperty.all(
                                          UIGuide.light_Purple),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder:
                                                  (context) =>
                                                  StudentHome()),
                                              (Route<dynamic> route) =>
                                          false);
                                    },
                                    child: const Text(
                                      'Back to Home',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 18,
                                          color: UIGuide.WHITE),
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                      Positioned(
                        top: -90,
                        child: CircleAvatar(
                            radius: 80,
                            backgroundColor: Colors.transparent,
                            child: SvgPicture.asset(UIGuide.pending)),
                      )
                    ],
                  ),
                ),
              );
            } else {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                content: Container(
                  height: size.height / 4,
                  width: size.width * 3,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: AlignmentDirectional.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: size.height / 10,
                          ),
                          const Text(
                            "Something went wrong",
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 20,
                                color: UIGuide.light_Purple),
                          ),
                          kheight20,
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                      MaterialStateProperty.all(
                                          UIGuide.light_Purple),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder:
                                                  (context) =>
                                                  StudentHome()),
                                              (Route<dynamic> route) =>
                                          false);
                                    },
                                    child: const Text(
                                      'Back to Home',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 18,
                                          color: UIGuide.WHITE),
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                      Positioned(
                        top: -90,
                        child: CircleAvatar(
                            radius: 80,
                            backgroundColor: Colors.transparent,
                            child: SvgPicture.asset(
                                UIGuide.somethingWentWrong)),
                      )
                    ],
                  ),
                ),
              );
            }
          },
        ));
  }
}
