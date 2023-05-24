import 'dart:io';
import 'dart:isolate';
import 'dart:math';
import 'dart:ui';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:basispaysdk/basispaysdk.dart';
import 'package:essconnect/Application/StudentProviders/FinalStatusProvider.dart';
import 'package:essconnect/Application/StudentProviders/InternetConnection.dart';
import 'package:essconnect/Presentation/Student/NoInternetScreen.dart';
import 'package:essconnect/Presentation/Student/PartialPay.dart';
import 'package:essconnect/Presentation/Student/Student_home.dart';
import 'package:essconnect/utils/ProgressBarFee.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:paytm_allinonesdk/paytm_allinonesdk.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../Application/StudentProviders/FeesProvider.dart';
import '../../Constants.dart';
import '../../utils/constants.dart';

class PayFee extends StatelessWidget {
  PayFee({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ConnectivityProvider>(context, listen: false);
    });
    return Consumer<ConnectivityProvider>(
      builder: (context, connection, child) => connection.isOnline == false
          ? const NoInternetConnection()
          : DefaultTabController(
              length: 2,
              child: Scaffold(
                  appBar: AppBar(
                    title: Row(
                      children: [
                        const Spacer(),
                        const Text('Payment'),
                        const Spacer(),
                        Provider.of<FeesProvider>(context).loading
                            ? const Text(
                                'Loading...',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              )
                            : IconButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PayFee()));
                                },
                                icon: const Icon(Icons.refresh_outlined))
                      ],
                    ),
                    titleSpacing: 00.0,
                    centerTitle: true,
                    toolbarHeight: 50.2,
                    toolbarOpacity: 0.8,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(25),
                          bottomLeft: Radius.circular(25)),
                    ),
                    backgroundColor: UIGuide.light_Purple,
                    bottom: TabBar(
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorColor: UIGuide.light_Purple,
                      indicatorWeight: 0.1,
                      tabs: [
                        const Tab(
                          text: "Installment",
                        ),
                        Consumer<FeesProvider>(builder: ((context, pro, child) {
                          if (pro.allowPartialPayment != false) {
                            return const Tab(
                              text: 'Partial',
                            );
                          } else {
                            return const Text('');
                          }
                        }))
                      ],
                    ),
                  ),
                  body: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      const FeePayInstallment(),
                      Consumer<FeesProvider>(builder: ((context, snap, child) {
                        if (snap.allowPartialPayment != false) {
                          return FeePartialPayment();
                        }
                        return const Text('');
                      }))
                    ],
                  )),
            ),
    );
  }
}

class FeePayInstallment extends StatefulWidget {
  const FeePayInstallment({Key? key}) : super(key: key);

  @override
  State<FeePayInstallment> createState() => _FeePayInstallmentState();
}

class _FeePayInstallmentState extends State<FeePayInstallment> {
  final ScrollController _controller = ScrollController();
  final ScrollController _controller2 = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var p = Provider.of<FeesProvider>(context, listen: false);
      p.vendorMapping();
      p.gatewayName();
      p.selecteCategorys.clear();
      p.selectedBusFee.clear();
      p.feesData();
      p.busFeeList.clear();
      p.feeList.clear();
      p.totalFees = 0;
      p.total = 0;
      p.totalBusFee = 0;
      p.transactionList.clear();
    });
  }

  String? orderidd;
  String? readableid;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool enable = true;
  @override
  Widget build(BuildContext cont) {
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          Consumer<FeesProvider>(
            builder: (context, value, child) => value.loading
                ? const ProgressBarFee()
                : ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      kheight20,
                      value.feeList.isEmpty
                          ? const SizedBox(
                              height: 0,
                              width: 0,
                            )
                          : Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, bottom: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Text(
                                        'Installment',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w900,
                                            color: UIGuide.light_Purple),
                                      ),
                                      // Consumer<FeesProvider>(
                                      //     builder: (context, snap, child) {
                                      //   //   child:
                                      //   return Padding(
                                      //     padding: const EdgeInsets.only(
                                      //         right: 20.0),
                                      //     child: Checkbox(
                                      //       value: snap.isselectAll,
                                      //       onChanged: (bool? value) {
                                      //         setState(() {
                                      //           value = snap.isselectAll;
                                      //         });
                                      //       },
                                      //       //       },
                                      //     ),
                                      //   );
                                      // }),
                                    ],
                                  ),
                                ),
                                Scrollbar(
                                  controller: _controller,
                                  thumbVisibility: true,
                                  thickness: 10,
                                  radius: const Radius.circular(20),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20.0, right: 8),
                                    child: LimitedBox(
                                        maxHeight: 160,
                                        child: Consumer<FeesProvider>(
                                          builder: (context, value, child) =>
                                              ListView.builder(
                                                  physics:
                                                      const BouncingScrollPhysics(),
                                                  shrinkWrap: true,
                                                  controller: _controller,
                                                  itemCount: value
                                                          .feeList.isEmpty
                                                      ? 0
                                                      : value.feeList.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    print(value.feeList.length);
                                                    return CheckboxListTile(
                                                      activeColor:
                                                          const Color.fromARGB(
                                                              255,
                                                              243,
                                                              243,
                                                              243),
                                                      checkColor:
                                                          UIGuide.light_Purple,
                                                      selectedTileColor:
                                                          UIGuide.light_Purple,
                                                      value: value
                                                          .selecteCategorys
                                                          .contains(value
                                                                  .feeList[
                                                                      index]
                                                                  .installmentName ??
                                                              '--'),
                                                      onChanged: (bool?
                                                          selected) async {
                                                        value.onFeeSelected(
                                                            selected!,
                                                            value.feeList[index]
                                                                .installmentName,
                                                            index,
                                                            value.feeList[index]
                                                                .netDue);
                                                      },
                                                      title: Text(
                                                        value.feeList[index]
                                                                    .netDue ==
                                                                null
                                                            ? '--'
                                                            : value
                                                                .feeList[index]
                                                                .netDue
                                                                .toString(),
                                                        textAlign:
                                                            TextAlign.end,
                                                      ),
                                                      secondary: Text(
                                                        value.feeList[index]
                                                                .installmentName ??
                                                            '--',
                                                      ),
                                                    );
                                                  }),
                                        )),
                                  ),
                                ),
                                Consumer<FeesProvider>(
                                  builder: (context, value, child) => Center(
                                    child: Text(
                                      'TotalFee:  ${value.totalFees}',
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                      Consumer<FeesProvider>(
                        builder: (context, bus, child) {
                          if (bus.busFeeList.isNotEmpty) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
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
                                  controller: _controller2,
                                  thumbVisibility: true,
                                  thickness: 10,
                                  radius: const Radius.circular(20),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 8),
                                    child: LimitedBox(
                                        maxHeight: 160,
                                        child: Consumer<FeesProvider>(
                                          builder: (context, value, child) =>
                                              ListView.builder(
                                                  physics:
                                                      const BouncingScrollPhysics(),
                                                  shrinkWrap: true,
                                                  controller: _controller2,
                                                  itemCount: value
                                                          .busFeeList.isEmpty
                                                      ? 0
                                                      : value.busFeeList.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return CheckboxListTile(
                                                      activeColor:
                                                          const Color.fromARGB(
                                                              255,
                                                              238,
                                                              236,
                                                              236),
                                                      checkColor:
                                                          UIGuide.light_Purple,
                                                      selectedTileColor:
                                                          UIGuide.light_Purple,
                                                      value: value
                                                          .selectedBusFee
                                                          .contains(value
                                                              .busFeeList[index]
                                                              .installmentName),
                                                      onChanged:
                                                          (bool? selected) {
                                                        value.onBusSelected(
                                                            selected!,
                                                            value
                                                                .busFeeList[
                                                                    index]
                                                                .installmentName,
                                                            index,
                                                            value
                                                                .busFeeList[
                                                                    index]
                                                                .netDue);

                                                        print(selected);
                                                      },
                                                      title: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 75),
                                                        child: Text(
                                                          value
                                                              .busFeeList[index]
                                                              .netDue
                                                              .toString(),
                                                          textAlign:
                                                              TextAlign.end,
                                                        ),
                                                      ),
                                                      secondary: Text(value
                                                              .busFeeList[index]
                                                              .installmentName ??
                                                          '--'),
                                                    );
                                                  }),
                                        )),
                                  ),
                                ),
                                Consumer<FeesProvider>(
                                  builder: (context, value, child) => Center(
                                    child: Text(
                                      'TotalBus fee :  ${value.totalBusFee}',
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ),
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
                      Center(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Total : ',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w700),
                            ),
                            // totalFee()
                            Consumer<FeesProvider>(
                              builder: (context, value, child) =>
                                  Text(value.total.toString()),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      GestureDetector(
                        child: const Text(
                          'Last Transaction Details',
                          style: TextStyle(
                            color: UIGuide.light_Purple,
                            decoration: TextDecoration.underline,
                            decorationStyle: TextDecorationStyle.dashed,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        onTap: () async {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  child: Consumer<FeesProvider>(
                                      builder: (context, provider, child) {
                                    String date =
                                        provider.lastTransactionStartDate ??
                                            '--';
                                    var updatedDate =
                                        DateFormat('yyyy-MM-dd').parse(date);
                                    String newDate = updatedDate.toString();
                                    String finalDate =
                                        newDate.replaceRange(10, 23, '');
                                    return SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          kheight10,
                                          const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              'Your last transaction  details',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: UIGuide.light_Purple),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                const Text(
                                                  'Transaction Date: ',
                                                ),
                                                Flexible(
                                                  child: RichText(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    strutStyle:
                                                        const StrutStyle(),
                                                    maxLines: 3,
                                                    text: TextSpan(
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: UIGuide
                                                                .light_Purple),
                                                        text: finalDate),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                const Text(
                                                  'Transaction amount: ',
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
                                                          FontWeight.bold,
                                                      color:
                                                          UIGuide.light_Purple),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                const Text(
                                                  'Transaction Status: ',
                                                ),
                                                Consumer<FeesProvider>(
                                                  builder:
                                                      (context, value, child) {
                                                    String stats =
                                                        provider.lastOrderStatus ==
                                                                null
                                                            ? ''
                                                            : provider
                                                                .lastOrderStatus
                                                                .toString();
                                                    if (stats == "Success") {
                                                      return const Text(
                                                        "Success",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.green),
                                                      );
                                                    } else if (stats ==
                                                        "Failed") {
                                                      return const Text(
                                                        "Failed",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.red),
                                                      );
                                                    } else if (stats ==
                                                        "Cancelled") {
                                                      return const Text(
                                                        "Cancelled",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Color.fromARGB(
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
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.orange),
                                                      );
                                                    } else if (stats ==
                                                        "Pending") {
                                                      return const Text(
                                                        "Pending",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.orange),
                                                      );
                                                    } else {
                                                      return const Text(
                                                        "--",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: UIGuide
                                                                .light_Purple),
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
                                                            FontWeight.bold,
                                                        color: UIGuide
                                                            .light_Purple),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Consumer<FeesProvider>(
                                            builder: (context, value, child) {
                                              String status =
                                                  provider.lastOrderStatus ==
                                                          null
                                                      ? ''
                                                      : provider.lastOrderStatus
                                                          .toString();
                                              if (status == 'Success' ||
                                                  status == 'Failed') {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: [
                                                      const Text(
                                                        'Download receipt: ',
                                                      ),
                                                      GestureDetector(
                                                        onTap: () async {
                                                          String orderID =
                                                              await provider
                                                                          .orderId ==
                                                                      null
                                                                  ? ''
                                                                  : provider
                                                                      .orderId
                                                                      .toString();

                                                          await Provider.of<
                                                                      FeesProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .pdfDownload(
                                                                  orderID);
                                                          String extenstion =
                                                              await provider
                                                                      .extension ??
                                                                  '--';

                                                          SchedulerBinding
                                                              .instance
                                                              .addPostFrameCallback(
                                                                  (_) {
                                                            Navigator
                                                                .pushReplacement(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          PdfDownload()),
                                                            );
                                                          });
                                                        },
                                                        child: const Icon(
                                                            Icons.download,
                                                            color: UIGuide
                                                                .light_Purple),
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
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                kWidth,
                                                MaterialButton(
                                                  height: 30,
                                                  onPressed: () async {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text(
                                                    'OK',
                                                    style: TextStyle(
                                                        color: UIGuide.WHITE),
                                                  ),
                                                  color: UIGuide.light_Purple,
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  }),
                                );
                              });
                        },
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                    ],
                  ),
          ),
          Positioned(
            bottom: 2,
            left: 10,
            right: 10,
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 0, left: 10, right: 10, bottom: 5),
              child: Consumer<FeesProvider>(
                builder: (_, trans, child) {
                  return MaterialButton(
                    height: 50,
                    onPressed: () async {
                      if (trans.gateway == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
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
                          if (trans.lastOrderStatus == 'Success' ||
                              trans.lastOrderStatus == 'Failed' ||
                              trans.lastOrderStatus == 'Cancelled' ||
                              trans.lastOrderStatus == 'Processing' ||
                              trans.lastOrderStatus == null) {
                            if (trans.total != 0) {
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////              get data of one             //////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                              if (trans.transactionList.length == 1 &&
                                  trans.transactionList[0].name.toString() ==
                                      "FEES") {
                                print('1111111111111111');
                                String transType =
                                    trans.transactionList[0].name ?? '--';
                                String transId1 =
                                    trans.transactionList[0].id ?? '--';
                                String gateWay = trans.gateway ?? '--';
                                print(transType);
                                print(transId1);

                                await AwesomeDialog(
                                  context: cont,
                                  animType: AnimType.scale,
                                  dialogType: DialogType.info,
                                  title: 'Do you want to continue the payment',
                                  desc:
                                      "Please don't go 𝐁𝐚𝐜𝐤 once the payment has been initialized!",
                                  btnOkOnPress: () async {
//  --------------------------------------------------------------------------------------------------------------    //
///////////////////  ---------------------------     PAYTM    -------------------------------  ////////////////////////
//  --------------------------------------------------------------------------------------------------------------   //

                                    if (trans.gateway == 'Paytm') {
                                      await Provider.of<FeesProvider>(context,
                                              listen: false)
                                          .getDataOne(
                                              transType,
                                              transId1,
                                              trans.totalFees.toString(),
                                              trans.total.toString(),
                                              gateWay);

                                      String mid1 = trans.mid1 ?? '--';
                                      String orderId1 =
                                          trans.txnorderId1 ?? '--';
                                      String amount1 = trans.txnAmount1 ?? '--';
                                      String txntoken = trans.txnToken1 ?? '';
                                      print(txntoken);
                                      String callbackURL1 =
                                          trans.callbackUrl1 ?? '--';
                                      bool staging1 = trans.isStaging1 ?? true;

                                      if (txntoken.isEmpty) {
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
                                              'Something went wrong...',
                                              textAlign: TextAlign.center,
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
//  -----------------------------------------------------------------------------------------------------------------  //
///////////////////                                 RazorPay                                    ////////////////////////
//  -----------------------------------------------------------------------------------------------------------------  //
                                    else if (trans.gateway == 'RazorPay') {
                                      await Provider.of<FeesProvider>(context,
                                              listen: false)
                                          .getDataOneRAZORPAY(
                                              transType,
                                              transId1,
                                              trans.totalFees.toString(),
                                              trans.total.toString(),
                                              gateWay);

                                      String key1 = trans.key1Razo ?? '';
                                      String orede1 = trans.order1 ?? '';

                                      String amount1R = trans.amount1Razo ?? '';
                                      String name1 = trans.name1Razo ?? '';
                                      String description1 =
                                          trans.description1Razo ?? '';
                                      String customer1 =
                                          trans.customer1Razo ?? '';
                                      String email1 = trans.email1Razo ?? '';
                                      String contact1 =
                                          trans.contact1Razo ?? '';
                                      orderidd = trans.order1;
                                      readableid = trans.readableOrderid1;

                                      print(key1);

                                      if (key1.isEmpty) {
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
                                              'Something went wrong...',
                                              textAlign: TextAlign.center,
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
                                            orede1);
                                      }
                                    }
//  -----------------------------------------------------------------------------------------------------------------  //
///////////////////                                 TrakNPay                                    ////////////////////////
//  -----------------------------------------------------------------------------------------------------------------  //
                                    else if (trans.gateway == 'TrakNPay') {
                                      await Provider.of<FeesProvider>(context,
                                              listen: false)
                                          .getDataOneTpay(
                                              transType,
                                              transId1,
                                              trans.totalFees.toString(),
                                              trans.total.toString(),
                                              gateWay);

                                      String orderId = trans.orderIdTPay1 ?? '';
                                      String addressLine1 =
                                          trans.addressLine1TPay1 ?? '';
                                      String city = trans.cityTPay1 ?? '';
                                      String udf5 = trans.udf1TPay1 ?? '';
                                      String state = trans.stateTPay1 ?? '';
                                      String udf4 = trans.udf4TPay1 ?? '';
                                      String phone = trans.phoneTPay1 ?? '';
                                      String zipCode = trans.zipCodeTPay1 ?? '';
                                      String currency =
                                          trans.currencyTPay1 ?? '';
                                      String email = trans.emailTPay1 ?? '';
                                      String country = trans.countryTPay1 ?? '';

                                      String salt = trans.saltTPay1 ?? '';
                                      String amount = trans.amountTPay1 ?? '';
                                      String name = trans.nameTPay1 ?? '';
                                      String apiKey = trans.apiKeyTPay1 ?? '';
                                      String udf3 = trans.udf3TPay1 ?? '';
                                      String udf2 = trans.udf2TPay1 ?? '';
                                      String returnUrl =
                                          trans.returnUrlTPay1 ?? '';
                                      String description =
                                          trans.descriptionTPay1 ?? '';
                                      String udf1 = trans.udf1TPay1 ?? '';
                                      String addressLine2 =
                                          trans.addressLine2TPay1 ?? '';

                                      if (apiKey.isEmpty) {
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
                                              'Something went wrong...',
                                              textAlign: TextAlign.center,
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
                                    } else {
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
                                              bottom: 80, left: 30, right: 30),
                                          behavior: SnackBarBehavior.floating,
                                          content: Text(
                                            'Payment Gateway Not Provided...',
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  btnCancelOnPress: () {
                                    Navigator.of(_scaffoldKey.currentContext!)
                                        .pop();
                                    //      Navigator.pop(context);
                                  },
                                ).show();
                              }

//////////////////////////////////////////////////////////////////////////////////////////
/////              get data of one            -----------    BUS  FEES
////////////////////////////////////////////////////////////////////////////////////////

                              else if (trans.transactionList.length == 1 &&
                                  trans.transactionList[0].name.toString() ==
                                      "BUS FEES") {
                                print('1111111111111111');
                                String transTypeB =
                                    trans.transactionList[0].name ?? '--';
                                String transId1B =
                                    trans.transactionList[0].id ?? '--';
                                String gateWay = trans.gateway ?? '--';
                                print(transTypeB);
                                print(transId1B);

                                await AwesomeDialog(
                                  context: cont,
                                  animType: AnimType.scale,
                                  dialogType: DialogType.info,
                                  title: 'Do you want to continue the payment',
                                  desc:
                                      "Please don't go 𝐁𝐚𝐜𝐤 once the payment has been initialized!",
                                  btnOkOnPress: () async {
//  --------------------------------------------------------------------------------------------------------------    //
///////////////////  ---------------------------     PAYTM    -------------------------------  ////////////////////////
//  --------------------------------------------------------------------------------------------------------------   //

                                    if (trans.gateway == 'Paytm') {
                                      await Provider.of<FeesProvider>(context,
                                              listen: false)
                                          .getDataOneBus(
                                              transTypeB,
                                              transId1B,
                                              trans.totalBusFee.toString(),
                                              trans.total.toString(),
                                              gateWay);

                                      String mid1B = trans.mid1B ?? '--';
                                      String orderId1B =
                                          trans.txnorderId1B ?? '--';
                                      String amount1B =
                                          trans.txnAmount1B ?? '--';
                                      String txntokenB = trans.txnToken1B ?? '';
                                      print(txntokenB);
                                      String callbackURL1B =
                                          trans.callbackUrl1B ?? '--';
                                      bool staging1B =
                                          trans.isStaging1B ?? true;

                                      if (txntokenB.isEmpty) {
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
                                              'Something went wrong...',
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        );
                                      } else {
                                        await _startTransaction(
                                            txntokenB,
                                            mid1B,
                                            orderId1B,
                                            amount1B,
                                            callbackURL1B,
                                            staging1B);
                                      }
                                    }
//  -----------------------------------------------
////                   RazorPay
//  -----------------------------------------------
                                    else if (trans.gateway == 'RazorPay') {
                                      await Provider.of<FeesProvider>(context,
                                              listen: false)
                                          .getDataOneRAZORPAYBus(
                                              transTypeB,
                                              transId1B,
                                              trans.totalBusFee.toString(),
                                              trans.total.toString(),
                                              gateWay);

                                      String key1 = trans.key1RazoBus ?? '--';
                                      String orede1 = trans.order1Bus ?? '--';

                                      String amount1R =
                                          trans.amount1RazoBus ?? '--';
                                      String name1 = trans.name1RazoBus ?? '';
                                      String description1 =
                                          trans.description1RazoBus ?? '';
                                      String customer1 =
                                          trans.customer1RazoBus ?? '';
                                      String email1 = trans.email1RazoBus ?? '';
                                      String contact1 =
                                          trans.contact1RazoBus ?? '';
                                      orderidd = trans.order1Bus;
                                      readableid = trans.readableOrderid1Bus;

                                      print(key1);

                                      if (key1.isEmpty) {
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
                                              'Something went wrong...',
                                              textAlign: TextAlign.center,
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
                                            orede1);
                                      }
                                    }

//  -----------------------------------------------------------------------------------------------------------------  //
///////////////////                                 TrakNPay                                    ////////////////////////
//  -----------------------------------------------------------------------------------------------------------------  //
                                    else if (trans.gateway == 'TrakNPay') {
                                      await Provider.of<FeesProvider>(context,
                                              listen: false)
                                          .getDataOneBusTpay(
                                              transTypeB,
                                              transId1B,
                                              trans.totalBusFee.toString(),
                                              trans.total.toString(),
                                              gateWay);

                                      String orderId =
                                          trans.orderIdTPay1B ?? '';
                                      String addressLine1 =
                                          trans.addressLine1TPay1B ?? '';
                                      String city = trans.cityTPay1B ?? '';
                                      String udf5 = trans.udf1TPay1B ?? '';
                                      String state = trans.stateTPay1B ?? '';
                                      String udf4 = trans.udf4TPay1B ?? '';
                                      String phone = trans.phoneTPay1B ?? '';
                                      String zipCode =
                                          trans.zipCodeTPay1B ?? '';
                                      String currency =
                                          trans.currencyTPay1B ?? '';
                                      String email = trans.emailTPay1B ?? '';
                                      String country =
                                          trans.countryTPay1B ?? '';

                                      String salt = trans.saltTPay1B ?? '';
                                      String amount = trans.amountTPay1B ?? '';
                                      String name = trans.nameTPay1B ?? '';
                                      String apiKey = trans.apiKeyTPay1B ?? '';
                                      String udf3 = trans.udf3TPay1B ?? '';
                                      String udf2 = trans.udf2TPay1B ?? '';
                                      String returnUrl =
                                          trans.returnUrlTPay1B ?? '';
                                      String description =
                                          trans.descriptionTPay1B ?? '';
                                      String udf1 = trans.udf1TPay1B ?? '';
                                      String addressLine2 =
                                          trans.addressLine2TPay1B ?? '';

                                      if (apiKey.isEmpty) {
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
                                              'Something went wrong...',
                                              textAlign: TextAlign.center,
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
                                    } else {
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
                                              bottom: 80, left: 30, right: 30),
                                          behavior: SnackBarBehavior.floating,
                                          content: Text(
                                            'Payment Gateway Not Provided...',
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  btnCancelOnPress: () {
                                    Navigator.of(_scaffoldKey.currentContext!)
                                        .pop();
                                    //      Navigator.pop(context);
                                  },
                                ).show();
                              }

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////              get data of two             ////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                              else if (trans.transactionList.length == 2) {
                                print(
                                    '-------------22222222-------------------');

                                String transType1 =
                                    trans.transactionList[0].name ?? '--';
                                String transType2 =
                                    trans.transactionList[1].name ?? '--';
                                String transID1 =
                                    trans.transactionList[0].id ?? '--';
                                String transID2 =
                                    trans.transactionList[1].id ?? '--';
                                String gateway = trans.gateway ?? '--';
                                print(transType1);
                                print(transType2);

                                await AwesomeDialog(
                                  context: context,
                                  animType: AnimType.scale,
                                  dialogType: DialogType.info,
                                  title: 'Do you want to continue the payment',
                                  desc:
                                      "Please don't go 𝐁𝐚𝐜𝐤 once the payment has been initialized!",
                                  btnOkOnPress: () async {
                                    if (trans.gateway == 'Paytm') {
                                      await Provider.of<FeesProvider>(context,
                                              listen: false)
                                          .getDataTwo(
                                              transType1,
                                              transID1,
                                              trans.totalFees.toString(),
                                              transType2,
                                              transID2,
                                              trans.totalBusFee.toString(),
                                              trans.total.toString(),
                                              gateway.toString());

                                      String mid2 = await trans.mid2 ?? '--';
                                      String orderId2 =
                                          trans.txnorderId2 ?? '--';
                                      String amount2 = trans.txnAmount2 ?? '--';
                                      String txntoken = trans.txnToken2 ?? '';
                                      print(txntoken);
                                      String callbackURL2 =
                                          trans.callbackUrl2 ?? '--';
                                      bool staging2 = trans.isStaging2 ?? true;

                                      if (txntoken.isEmpty) {
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
                                                bottom: 80,
                                                left: 30,
                                                right: 30),
                                            behavior: SnackBarBehavior.floating,
                                            content: Text(
                                              'Something went wrong...',
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        );
                                      } else {
                                        await _startTransaction(
                                            txntoken,
                                            mid2,
                                            orderId2,
                                            amount2,
                                            callbackURL2,
                                            staging2);
                                      }
                                    }

                                    ///////////////////         RazorPay         ////////////////////////
                                    else if (trans.gateway == 'RazorPay') {
                                      await Provider.of<FeesProvider>(context,
                                              listen: false)
                                          .getDataTwoRAZORPAY(
                                              transType1,
                                              transID1,
                                              trans.totalFees.toString(),
                                              transType2,
                                              transID2,
                                              trans.totalBusFee.toString(),
                                              trans.total.toString(),
                                              gateway.toString());

                                      String key2 = trans.key2Razo ?? '--';
                                      String orede2 = trans.order2 ?? '--';

                                      String amount2R =
                                          trans.amount2Razo ?? '--';
                                      String name2 = trans.name2Razo ?? '';
                                      String description2 =
                                          trans.description2Razo ?? '';
                                      String customer2 =
                                          trans.customer2Razo ?? '';
                                      String email2 = trans.email2Razo ?? '';
                                      String contact2 =
                                          trans.contact2Razo ?? '';
                                      orderidd = trans.order2;
                                      readableid = trans.readableOrderid2;

                                      print(key2);

                                      if (key2.isEmpty) {
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
                                              'Something went wrong...',
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        );
                                      } else {
                                        await _startRazorpay(
                                            key2,
                                            amount2R,
                                            name2,
                                            description2,
                                            customer2,
                                            email2,
                                            contact2,
                                            orede2);
                                      }
                                    }

//  -----------------------------------------------------------------------------------------------------------------  //
///////////////////                                 TrakNPay                                    ////////////////////////
//  -----------------------------------------------------------------------------------------------------------------  //
                                    else if (trans.gateway == 'TrakNPay') {
                                      await Provider.of<FeesProvider>(context,
                                              listen: false)
                                          .getDataTwoTpay(
                                              transType1,
                                              transID1,
                                              trans.totalFees.toString(),
                                              transType2,
                                              transID2,
                                              trans.totalBusFee.toString(),
                                              trans.total.toString(),
                                              gateway.toString());

                                      String orderId = trans.orderIdTPay2 ?? '';
                                      String addressLine1 =
                                          trans.addressLine1TPay2 ?? '';
                                      String city = trans.cityTPay2 ?? '';
                                      String udf5 = trans.udf1TPay2 ?? '';
                                      String state = trans.stateTPay2 ?? '';
                                      String udf4 = trans.udf4TPay2 ?? '';
                                      String phone = trans.phoneTPay2 ?? '';
                                      String zipCode = trans.zipCodeTPay2 ?? '';
                                      String currency =
                                          trans.currencyTPay2 ?? '';
                                      String email = trans.emailTPay2 ?? '';
                                      String country = trans.countryTPay2 ?? '';

                                      String salt = trans.saltTPay2 ?? '';
                                      String amount = trans.amountTPay2 ?? '';
                                      String name = trans.nameTPay2 ?? '';
                                      String apiKey = trans.apiKeyTPay2 ?? '';
                                      String udf3 = trans.udf3TPay2 ?? '';
                                      String udf2 = trans.udf2TPay2 ?? '';
                                      String returnUrl =
                                          trans.returnUrlTPay2 ?? '';
                                      String description =
                                          trans.descriptionTPay2 ?? '';
                                      String udf1 = trans.udf1TPay2 ?? '';
                                      String addressLine2 =
                                          trans.addressLine2TPay2 ?? '';

                                      if (apiKey.isEmpty) {
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
                                              'Something went wrong...',
                                              textAlign: TextAlign.center,
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
                                    } else {
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
                                              bottom: 80, left: 30, right: 30),
                                          behavior: SnackBarBehavior.floating,
                                          content: Text(
                                            'Payment Gateway Not Provided...',
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  btnCancelOnPress: () {
                                    Navigator.of(_scaffoldKey.currentContext!)
                                        .pop();
                                  },
                                ).show();
                              } else if (trans.transactionList.length == 0) {
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
                                      'Something Went Wrong.....!',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                );
                              } else {
                                print(
                                  trans.transactionList.length,
                                );
                                print('Something Went wrong');
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
                                      'Something Went Wrong.....!',
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
                                        BorderRadius.all(Radius.circular(20)),
                                  ),
                                  duration: Duration(seconds: 1),
                                  margin: EdgeInsets.only(
                                      bottom: 80, left: 30, right: 30),
                                  behavior: SnackBarBehavior.floating,
                                  content: Text(
                                    'Select Fees.....!',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              );
                            }
                          } else if (trans.lastOrderStatus == 'Processing') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                duration: Duration(seconds: 5),
                                margin: EdgeInsets.only(
                                    bottom: 80, left: 30, right: 30),
                                behavior: SnackBarBehavior.floating,
                                content: Text(
                                  'Please wait for 30 minutes...\n Your payment is under 𝗣𝗿𝗼𝗰𝗲𝘀𝘀𝗶𝗻𝗴',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                          } else if (trans.lastOrderStatus == 'Pending') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                duration: Duration(seconds: 5),
                                margin: EdgeInsets.only(
                                    bottom: 80, left: 30, right: 30),
                                behavior: SnackBarBehavior.floating,
                                content: Text(
                                  'Please wait for 30 minutes...\n Your payment is under 𝐏𝐞𝐧𝐝𝐢𝐧𝐠',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                duration: Duration(seconds: 5),
                                margin: EdgeInsets.only(
                                    bottom: 80, left: 30, right: 30),
                                behavior: SnackBarBehavior.floating,
                                content: Text(
                                  'Please wait for 30 minutes...\n Your payment is under 𝐏𝐫𝐨𝐜𝐞𝐬𝐬𝐢𝐧𝐠 / 𝐒𝐮𝐜𝐜𝐞𝐬𝐬 / 𝐅𝐚𝐢𝐥𝐞𝐝 / 𝐂𝐚𝐧𝐜𝐞𝐥𝐥𝐞𝐝',
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
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              duration: Duration(seconds: 5),
                              margin: EdgeInsets.only(
                                  bottom: 80, left: 30, right: 30),
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
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

//         ----------------------------------------------------------------------------------------            //
//         ***********************                paytm                    ************************            //
//         ----------------------------------------------------------------------------------------            //
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

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Consumer<FinalStatusProvider>(
              builder: (context, paytm, child) {
                if (paytm.reponseCode == '01') {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    content: Container(
                      height: size.height / 4.5,
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
                      height: size.height / 4.5,
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
                      height: size.height / 4.5,
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
                      height: size.height / 4.5,
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
                          const Positioned(
                            top: -80,
                            child: CircleAvatar(
                              radius: 70,
                              backgroundColor: Colors.orange,
                              child: Icon(
                                Icons.warning,
                                size: 80,
                                color: UIGuide.BLACK,
                              ),
                            ),
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
                    height: size.height / 4.5,
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
                        const Positioned(
                          top: -80,
                          child: CircleAvatar(
                            radius: 70,
                            backgroundColor: Colors.orange,
                            child: Icon(
                              Icons.warning,
                              size: 80,
                              color: UIGuide.BLACK,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ));
  }

//         ----------------------------------------------------------------------------------------            //
//         ***********************                Razorpay                *************************            //
//         ----------------------------------------------------------------------------------------            //

  _startRazorpay(String key, String amount, String name, String description,
      String nameP, String email, String contact, String orderId) async {
    Razorpay razorpay = Razorpay();
    var options = {
      'key': key,
      'amount': amount,
      'order_id': orderId,
      'name': name,
      'description': description,
      'prefill': {"name": nameP, "email": email, "contact": contact},
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
      'prefill': {"name": nameP, "email": email, "contact": contact},
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
    await _showAlertRazorPay(context, readableid!, orderidd!);
  }

  void handlePaymentSuccessResponse(
    PaymentSuccessResponse response,
  ) async {
    await _showAlertRazorPay(context, readableid!, orderidd!);
    print('------------------Success-----------------------------');
  }

///////////////////////////////////////////////
  ///

  _showAlertRazorPay(
    BuildContext context,
    String readable,
    String orderID,
  ) async {
    var size = MediaQuery.of(context).size;
    String order = (readable + "_" + orderID);
    await Provider.of<FinalStatusProvider>(context, listen: false)
        .transactionStatusRazorPay(order);
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Consumer<FinalStatusProvider>(
              builder: (context, razor, child) {
                if (razor.reponseMsgRazor == 'captured') {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    content: Container(
                      height: size.height / 4.5,
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
                      height: size.height / 4.5,
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
                      height: size.height / 4.5,
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
                      height: size.height / 4.5,
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
                    height: size.height / 4.5,
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
      "udf2": udf2.isEmpty ? "MobileApp" : udf2,
      "udf3": udf3.isEmpty ? "MobileApp" : udf3,
      "udf4": udf4.isEmpty ? "udf4" : udf4,
      "udf5": udf5.isEmpty ? "udf5" : udf5,
    };
    print(
        "******************            $paymentRequestDictionary        ***********************");
    try {
      var response = Basispaysdk.startTransaction(
          apiKey, //[API-KEY From Basispay team]
          saltKey, //[SALT-KEY From Basispay team]
          returnUrl, //[YOUR- RETURN URL to get the response]
          true,
          paymentRequestDictionary);
      response.then((value) {
        print(value);
        print("=======================================================");
        setState(() {});
        showAlertTrakNPay(context, orderId);
      }).catchError((onError) {
        if (onError is PlatformException) {
          print('-------------------Failed-----------------');
          showAlertTrakNPay(context, orderId);
          setState(() {
            print(onError.message! + " \n  " + onError.details.toString());
          });
        } else {
          setState(() {
            print('-------------------Pending-----------------');
            print(onError.toString());
            showAlertTrakNPay(context, orderId);
          });
        }
      });
    } catch (err) {
      showAlertTrakNPay(context, orderId);
      print('-------------------ERROR-----------------');
      print(err.toString());
    }
  }
}

String cutStringAfterLetter(String originalString, String letter) {
  int index = originalString.indexOf(letter);
  if (index != -1) {
    // If the letter is found in the string
    return originalString.substring(index + 1, originalString.length);
  } else {
    // If the letter is not found in the string
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

  await Provider.of<FeesProvider>(context, listen: false)
      .payStatusButton(cutString);
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Consumer<FeesProvider>(
            builder: (context, trak, child) {
              if (trak.statusss == 'Success') {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  content: Container(
                    height: size.height / 4.5,
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
                    height: size.height / 4.5,
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
              } else if (trak.statusss == "Processing" ||
                  trak.statusss == "Pending") {
                AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  content: Container(
                    height: size.height / 4.5,
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
                              child: SvgPicture.asset(UIGuide.pending)),
                        )
                      ],
                    ),
                  ),
                );
              } else if (trak.statusss == null) {
                AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  content: Container(
                    height: size.height / 4.5,
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
                    height: size.height / 4.5,
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
              }
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                content: Container(
                  height: size.height / 4.5,
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
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  StudentHome()),
                                          (Route<dynamic> route) => false);
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

// //pdf download

// class PdfDownload extends StatelessWidget {
//   PdfDownload({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<FeesProvider>(
//       builder: (context, value, child) => WillPopScope(
//         onWillPop: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => StudentHome()),
//           );
//           throw (e);
//         },
//         child: Scaffold(
//             appBar: AppBar(
//               automaticallyImplyLeading: false,
//               title: Row(
//                 children: [
//                   kWidth,
//                   GestureDetector(
//                       onTap: () {
//                         Navigator.of(context).pushAndRemoveUntil(
//                             MaterialPageRoute(
//                                 builder: (context) => StudentHome()),
//                             (Route<dynamic> route) => false);
//                       },
//                       child: const Icon(Icons.arrow_back_ios)),
//                   kWidth,
//                   kWidth,
//                   kWidth,
//                   const Text('Payment'),
//                 ],
//               ),
//               titleSpacing: 00.0,
//               centerTitle: true,
//               toolbarHeight: 50.2,
//               toolbarOpacity: 0.8,
//               backgroundColor: UIGuide.light_Purple,
//               actions: [
//                 Padding(
//                   padding: const EdgeInsets.only(right: 15.0),
//                   child: DownloandPdf(
//                     isUseIcon: true,
//                     pdfUrl: value.url.toString() == null
//                         ? '--'
//                         : value.url.toString(),
//                     fileNames: value.name.toString() == null
//                         ? '---'
//                         : value.name.toString(),
//                     color: Colors.white,
//                   ),
//                 ),
//               ],
//             ),
//             body: SfPdfViewer.network(
//               value.url.toString() == null ? '--' : value.url.toString(),
//             )),
//       ),
//     );
//   }
// }

class PdfDownload extends StatefulWidget {
  PdfDownload({
    Key? key,
  }) : super(key: key);
  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
  }

  @override
  State<PdfDownload> createState() => _PdfDownloadState();
}

class _PdfDownloadState extends State<PdfDownload> {
  final ReceivePort _port = ReceivePort();
  @override
  void initState() {
    super.initState();

    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];

      setState(() {});
    });

    FlutterDownloader.registerCallback(PdfDownload.downloadCallback);
  }

  @pragma('vm:entry-point')
  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send!.send([id, status, progress]);
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  Future<void> requestDownload(String _url, String _name) async {
    final dir = await getExternalStorageDirectory();
    var _localPath;
    if (Platform.isAndroid) {
      _localPath = '/storage/emulated/0/Download';
    } else if (Platform.isIOS) {
      final dir = await getExternalStorageDirectory();
      _localPath = dir!.path;
    }
    print("pathhhh  $_localPath");
    final savedDir = Directory(_localPath);
    await savedDir.create(recursive: true).then((value) async {
      String? _taskid = await FlutterDownloader.enqueue(
        savedDir: _localPath,
        url: _url,
        fileName: "Payment Receipt $_name.pdf",
        showNotification: true,
        openFileFromNotification: true,
      );

      print(_taskid);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FeesProvider>(
      builder: (context, value, child) => WillPopScope(
        onWillPop: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => StudentHome()),
          );
          throw (e);
        },
        child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Row(
                children: [
                  kWidth,
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => StudentHome()),
                            (Route<dynamic> route) => false);
                      },
                      child: const Icon(Icons.arrow_back_ios)),
                  kWidth,
                  kWidth,
                  kWidth,
                  const Text('Payment'),
                ],
              ),
              titleSpacing: 00.0,
              centerTitle: true,
              toolbarHeight: 50.2,
              toolbarOpacity: 0.8,
              backgroundColor: UIGuide.light_Purple,
              actions: [
                Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: IconButton(
                        onPressed: () async {
                          await requestDownload(
                            value.url.toString() == null
                                ? '--'
                                : value.url.toString(),
                            value.idd.toString() == null
                                ? '---'
                                : value.idd.toString() + value.name.toString(),
                          );
                        },
                        icon: const Icon(Icons.download_outlined))),
              ],
            ),
            body: SfPdfViewer.network(
              value.url.toString() == null ? '--' : value.url.toString(),
            )),
      ),
    );
    // Consumer<Timetableprovider>(
    //   builder: (context, value, child) => Scaffold(
    //       appBar: AppBar(
    //         title: const Text('TimeTable'),
    //         titleSpacing: 00.0,
    //         centerTitle: true,
    //         toolbarHeight: 50.2,
    //         toolbarOpacity: 0.8,
    //         backgroundColor: UIGuide.light_Purple,
    //         actions: [
    //           Padding(
    //               padding: const EdgeInsets.only(right: 15.0),
    //               child: IconButton(
    //                   onPressed: () async {
    //                     await requestDownload(
    //                      value.urlExam.toString().isEmpty
    //                   ? '--'
    //                   : value.urlExam.toString(),
    //                        value.nameExam.toString().isEmpty
    //                   ? '---'
    //                   : value.nameExam.toString(),
    //                     );
    //                   },
    //                   icon: const Icon(Icons.download_outlined))),
    //         ],
    //       ),
    //       body: SfPdfViewer.network(
    //          value.urlExam == null ? '--' : value.urlExam.toString(),
    //       )),
    // );
  }
}
