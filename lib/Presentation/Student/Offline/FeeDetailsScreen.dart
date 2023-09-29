import 'package:essconnect/Application/StudentProviders/OfflineFeeProviders.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:essconnect/utils/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class FeeDetailsScreen extends StatelessWidget {
  const FeeDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var p = Provider.of<OfflineFeeProviders>(context, listen: false);
      await p.clearFEEDetailList();
      await p.getFEEDetailList();
    });
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Consumer<OfflineFeeProviders>(
        builder: (context, value, _) => value.loading
            ? spinkitLoader()
            : value.feesDetailList.isEmpty || value.feesDetailList == null
                ? LottieBuilder.network(
                    'https://assets2.lottiefiles.com/private_files/lf30_lkquf6qz.json')
                : ListView(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: UIGuide.LightBlue),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                      "Last Updated Date : ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: UIGuide.BLACK,
                                      ),
                                    ),
                                    Text(
                                      value.finalFeeDateDetail ?? "--",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: UIGuide.light_Purple,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      LimitedBox(
                        maxHeight: size.height - 300,
                        child: Scrollbar(
                          child: AnimationLimiter(
                            child: ListView.builder(
                                itemCount: value.feesDetailList.length,
                                shrinkWrap: true,
                                itemBuilder: ((context, index) {
                                  String createddate = value
                                          .feesDetailList[index]
                                          .fineStartsFrom ??
                                      '--';
                                  String finalCreatedDate = '';
                                  if (value.feesDetailList[index]
                                          .fineStartsFrom !=
                                      null) {
                                    DateTime parsedDateTime =
                                        DateTime.parse(createddate);

                                    finalCreatedDate = DateFormat('dd-MMM-yyyy')
                                        .format(parsedDateTime);
                                  }

                                  return AnimationConfiguration.staggeredList(
                                    position: index,
                                    delay: const Duration(milliseconds: 100),
                                    child: SlideAnimation(
                                      duration:
                                          const Duration(milliseconds: 2500),
                                      curve: Curves.fastLinearToSlowEaseIn,
                                      child: FadeInAnimation(
                                        curve: Curves.fastLinearToSlowEaseIn,
                                        duration:
                                            const Duration(milliseconds: 2500),
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Container(
                                            width: size.width,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: UIGuide.light_Purple,
                                                  width: .5),
                                            ),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                        decoration: BoxDecoration(
                                                            color: UIGuide
                                                                .LightBlue,
                                                            border: Border.all(
                                                                color: UIGuide
                                                                    .light_Purple,
                                                                width: .2),
                                                            borderRadius: const BorderRadius
                                                                .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        10),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        10))),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(5.0),
                                                          child: Text(
                                                            "${index + 1}",
                                                            style: const TextStyle(
                                                                color: UIGuide
                                                                    .light_Purple,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        )),
                                                    const Text(
                                                        "  Installment: "),
                                                    Expanded(
                                                      child: Text(
                                                        value
                                                                .feesDetailList[
                                                                    index]
                                                                .installment ??
                                                            "--",
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: UIGuide
                                                              .light_Purple,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                value.feesDetailList[index]
                                                            .fineStartsFrom ==
                                                        null
                                                    ? const SizedBox(
                                                        height: 0,
                                                        width: 0,
                                                      )
                                                    : Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 6,
                                                                bottom: 6),
                                                        child: Row(
                                                          children: [
                                                            const Text(
                                                                "Fine starts from: "),
                                                            Expanded(
                                                              child: Text(
                                                                finalCreatedDate,
                                                                style:
                                                                    const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .red,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 6, bottom: 8),
                                                  child: Row(
                                                    children: [
                                                      const Text("Amount: "),
                                                      Expanded(
                                                        child: Text(
                                                          value
                                                                      .feesDetailList[
                                                                          index]
                                                                      .amount ==
                                                                  null
                                                              ? "--"
                                                              : value
                                                                  .feesDetailList[
                                                                      index]
                                                                  .amount!
                                                                  .toStringAsFixed(
                                                                      2),
                                                          style:
                                                              const TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: UIGuide
                                                                .light_Purple,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                value.showConcessionColumnFees ==
                                                        false
                                                    ? const SizedBox(
                                                        height: 0,
                                                        width: 0,
                                                      )
                                                    : value
                                                                .feesDetailList[
                                                                    index]
                                                                .concessionAmount!
                                                                .toStringAsFixed(
                                                                    2) ==
                                                            "0.00"
                                                        ? const SizedBox(
                                                            height: 0,
                                                            width: 0,
                                                          )
                                                        : Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 6,
                                                                    bottom: 6),
                                                            child: Row(
                                                              children: [
                                                                const Text(
                                                                    "Concession Amount: "),
                                                                Expanded(
                                                                  child: Text(
                                                                    value.feesDetailList[index].concessionAmount ==
                                                                            null
                                                                        ? "0.00"
                                                                        : value
                                                                            .feesDetailList[index]
                                                                            .concessionAmount!
                                                                            .toStringAsFixed(2),
                                                                    style:
                                                                        const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      color: UIGuide
                                                                          .light_Purple,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 6, bottom: 8),
                                                  child: Row(
                                                    children: [
                                                      const Text("Paid: "),
                                                      Expanded(
                                                        child: Text(
                                                          value
                                                                      .feesDetailList[
                                                                          index]
                                                                      .paidAmount ==
                                                                  null
                                                              ? "--"
                                                              : value
                                                                  .feesDetailList[
                                                                      index]
                                                                  .paidAmount!
                                                                  .toStringAsFixed(
                                                                      2),
                                                          style:
                                                              const TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: UIGuide
                                                                .light_Purple,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 6, bottom: 6),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(3),
                                                        decoration: BoxDecoration(
                                                            color: UIGuide
                                                                .LightBlue,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            const Text(
                                                                "Balance: "),
                                                            Text(
                                                              value
                                                                          .feesDetailList[
                                                                              index]
                                                                          .balanceAmount ==
                                                                      null
                                                                  ? "--"
                                                                  : value
                                                                      .feesDetailList[
                                                                          index]
                                                                      .balanceAmount!
                                                                      .toStringAsFixed(
                                                                          2),
                                                              style:
                                                                  const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w800,
                                                                color: UIGuide
                                                                    .BLACK,
                                                              ),
                                                            ),
                                                          ],
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
                                    ),
                                  );
                                })),
                          ),
                        ),
                      ),
                      ListView.builder(
                          padding: const EdgeInsets.all(0),
                          shrinkWrap: true,
                          itemCount: value.totalListFee.length,
                          itemBuilder: ((context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                width: size.width,
                                // height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)),
                                  border: Border.all(
                                      color: UIGuide.BLACK,
                                      width: .9,
                                      style: BorderStyle.solid),
                                ),
                                child: Column(
                                  children: [
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: UIGuide.LightBlue),
                                              padding: const EdgeInsets.all(5),
                                              child: Row(
                                                children: [
                                                  const Text(
                                                    "Total Amount: ",
                                                    style: TextStyle(
                                                        color: UIGuide.BLACK,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  Text(
                                                    " ${value.totalListFee[index].totalAmount!.toStringAsFixed(2)}",
                                                    style: const TextStyle(
                                                        color: UIGuide
                                                            .light_Purple,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: UIGuide.LightBlue),
                                              padding: const EdgeInsets.all(5),
                                              child: Row(
                                                children: [
                                                  const Text(
                                                    "Total Paid Amount: ",
                                                    style: TextStyle(
                                                        color: UIGuide.BLACK,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  Text(
                                                    " ${value.totalListFee[index].totalPaidAmount!.toStringAsFixed(2)}",
                                                    style: const TextStyle(
                                                        color: UIGuide
                                                            .light_Purple,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    value.showConcessionColumnFees == false
                                        ? const SizedBox(
                                            height: 0,
                                            width: 0,
                                          )
                                        : value.totalListFee[index]
                                                    .totalConcessionAmount!
                                                    .toStringAsFixed(2) ==
                                                "0.00"
                                            ? const SizedBox(
                                                height: 0,
                                                width: 0,
                                              )
                                            : Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color: UIGuide
                                                              .LightBlue),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5),
                                                      child: Row(
                                                        children: [
                                                          const Text(
                                                            "Total Concession : ",
                                                            style: TextStyle(
                                                                color: UIGuide
                                                                    .BLACK,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                          Text(
                                                            " ${value.totalListFee[index].totalConcessionAmount!.toStringAsFixed(2)}",
                                                            style: const TextStyle(
                                                                color: UIGuide
                                                                    .light_Purple,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: UIGuide.LightBlue),
                                            padding: const EdgeInsets.all(5),
                                            child: Row(
                                              children: [
                                                const Text(
                                                  "Total Balance Amount: ",
                                                  style: TextStyle(
                                                      color: UIGuide.BLACK,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Text(
                                                  " ${value.totalListFee[index].totalBalanceAmount!.toStringAsFixed(2)}",
                                                  style: const TextStyle(
                                                      color:
                                                          UIGuide.light_Purple,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }))
                    ],
                  ),
      ),
    );
  }
}
