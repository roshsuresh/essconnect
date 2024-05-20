import 'package:essconnect/Application/StudentProviders/OfflineFeeProviders.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:essconnect/utils/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class FeePaidScreen extends StatelessWidget {
  const FeePaidScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var p = Provider.of<OfflineFeeProviders>(context, listen: false);
      await p.clearFEEPAIDList();
      await p.getFEEsPAIDList();
    });
    var size = MediaQuery.of(context).size;
    return Consumer<OfflineFeeProviders>(
      builder: (context, value, _) => Scaffold(
          body: value.loadingFees
              ? spinkitLoader()
              : value.feePAIDList.isEmpty
                  ? LottieBuilder.network(
                      'https://assets2.lottiefiles.com/private_files/lf30_lkquf6qz.json')
                  : Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4.0),
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
                                    value.finalfeeDatePaid ?? "--",
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
                        Expanded(
                          child: Scrollbar(
                            child: AnimationLimiter(
                              child: ListView.builder(
                                  itemCount: value.feePAIDList.length,
                                  itemBuilder: ((context, index) {
                                    String createddate =
                                        value.feePAIDList[index].receiptDate ??
                                            '--';
                                    DateTime parsedDateTime =
                                        DateTime.parse(createddate);

                                    String finalCreatedDate =
                                        DateFormat('dd-MMM-yyyy')
                                            .format(parsedDateTime);
                                    return AnimationConfiguration.staggeredList(
                                      position: index,
                                      delay: const Duration(milliseconds: 100),
                                      child: SlideAnimation(
                                        duration:
                                            const Duration(milliseconds: 2500),
                                        curve: Curves.fastLinearToSlowEaseIn,
                                        child: FadeInAnimation(
                                          curve: Curves.fastLinearToSlowEaseIn,
                                          duration: const Duration(
                                              milliseconds: 2500),
                                          child: Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: Container(
                                              width: size.width,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                      color: UIGuide
                                                          .light_Purple)),
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0,
                                                            bottom: 4,
                                                            top: 0),
                                                    child: Row(
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
                                                                    bottomRight:
                                                                        Radius.circular(
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
                                                            "  Receipt Date: "),
                                                        Text(
                                                          finalCreatedDate,
                                                          style:
                                                              const TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: UIGuide
                                                                .light_Purple,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 6,
                                                      bottom: 4,
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        const Text(
                                                            "Receipt Number: "),
                                                        Expanded(
                                                          child: Text(
                                                            value
                                                                    .feePAIDList[
                                                                        index]
                                                                    .receiptNumber ??
                                                                "--",
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
                                                  ListView.builder(
                                                      itemCount: value
                                                          .feePAIDList[index]
                                                          .detailedFeesList
                                                          ?.length,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              0),
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      shrinkWrap: true,
                                                      itemBuilder:
                                                          ((context, ind) =>
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(3),
                                                                child:
                                                                    Container(
                                                                  decoration: BoxDecoration(
                                                                      color: UIGuide
                                                                          .LightBlue,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10)),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            5.0),
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        Padding(
                                                                          padding: const EdgeInsets
                                                                              .all(
                                                                              3.0),
                                                                          child:
                                                                              Row(
                                                                            children: [
                                                                              const Text("Installment: "),
                                                                              Expanded(
                                                                                child: Text(
                                                                                  value.feePAIDList[index].detailedFeesList![ind].installment ?? "--",
                                                                                  style: const TextStyle(
                                                                                    fontWeight: FontWeight.w600,
                                                                                    color: UIGuide.light_Purple,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: const EdgeInsets
                                                                              .all(
                                                                              3.0),
                                                                          child:
                                                                              Row(
                                                                            children: [
                                                                              Expanded(
                                                                                child: Row(
                                                                                  children: [
                                                                                    const Text("Amount: "),
                                                                                    Expanded(
                                                                                      child: Text(
                                                                                        value.feePAIDList[index].detailedFeesList![ind].amount == null ? "0.00" : value.feePAIDList[index].detailedFeesList![ind].amount!.toStringAsFixed(2),
                                                                                        style: const TextStyle(
                                                                                          fontWeight: FontWeight.w600,
                                                                                          color: UIGuide.light_Purple,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                              value.showConcessionFEES == false
                                                                                  ? const SizedBox(
                                                                                      height: 0,
                                                                                      width: 0,
                                                                                    )
                                                                                  : value.feePAIDList[index].detailedFeesList![ind].concessionAmount!.toStringAsFixed(2) == "0.00"
                                                                                      ? const SizedBox(
                                                                                          height: 0,
                                                                                          width: 0,
                                                                                        )
                                                                                      : Expanded(
                                                                                          child: Row(
                                                                                            children: [
                                                                                              const Text("Concession: "),
                                                                                              Expanded(
                                                                                                child: Text(
                                                                                                  value.feePAIDList[index].detailedFeesList![ind].concessionAmount == null ? "0.00" : value.feePAIDList[index].detailedFeesList![ind].concessionAmount!.toStringAsFixed(2),
                                                                                                  style: const TextStyle(
                                                                                                    fontWeight: FontWeight.w600,
                                                                                                    color: UIGuide.light_Purple,
                                                                                                  ),
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
                                                              ))),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 6,
                                                            bottom: 8,
                                                            top: 2),
                                                    child: Row(
                                                      children: [
                                                        const Text(
                                                            "Total Amount: "),
                                                        Expanded(
                                                          child: Text(
                                                            value
                                                                        .feePAIDList[
                                                                            index]
                                                                        .totalAmount ==
                                                                    null
                                                                ? "0.00"
                                                                : value
                                                                    .feePAIDList[
                                                                        index]
                                                                    .totalAmount!
                                                                    .toStringAsFixed(
                                                                        2),
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
                                                  value.showConcessionFEES ==
                                                          false
                                                      ? const SizedBox(
                                                          height: 0,
                                                          width: 0,
                                                        )
                                                      : value.feePAIDList[index]
                                                                  .totalConcessionAmount!
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
                                                                bottom: 8,
                                                              ),
                                                              child: Row(
                                                                children: [
                                                                  const Text(
                                                                      "Total Concession Amount: "),
                                                                  Expanded(
                                                                    child: Text(
                                                                      value.feePAIDList[index].totalConcessionAmount ==
                                                                              null
                                                                          ? "0.00"
                                                                          : value
                                                                              .feePAIDList[index]
                                                                              .totalConcessionAmount!
                                                                              .toStringAsFixed(2),
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
                                                      left: 6,
                                                      bottom: 8,
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          child: Row(
                                                            children: [
                                                              const Text(
                                                                  "Fine: "),
                                                              Expanded(
                                                                child: Text(
                                                                  value.feePAIDList[index].fine ==
                                                                          null
                                                                      ? "0.00"
                                                                      : value
                                                                          .feePAIDList[
                                                                              index]
                                                                          .fine!
                                                                          .toStringAsFixed(
                                                                              2),
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
                                                        value.feePAIDList[index]
                                                                    .subsidy!
                                                                    .toStringAsFixed(
                                                                        2) ==
                                                                "0.00"
                                                            ? const SizedBox(
                                                                height: 0,
                                                                width: 0,
                                                              )
                                                            : Expanded(
                                                                child: Row(
                                                                  children: [
                                                                    const Text(
                                                                        "Subsidy: "),
                                                                    Expanded(
                                                                      child:
                                                                          Text(
                                                                        value.feePAIDList[index].subsidy ==
                                                                                null
                                                                            ? "0.00"
                                                                            : value.feePAIDList[index].subsidy!.toStringAsFixed(2),
                                                                        style:
                                                                            const TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          color:
                                                                              UIGuide.light_Purple,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 6,
                                                      bottom: 8,
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          decoration: BoxDecoration(
                                                              color: UIGuide
                                                                  .LightBlue,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(6.0),
                                                            child: Row(
                                                              children: [
                                                                const Text(
                                                                  "NetAmount: ",
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: UIGuide
                                                                        .BLACK,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  value.feePAIDList[index].totalPaidAmount ==
                                                                          null
                                                                      ? "0.00"
                                                                      : value
                                                                          .feePAIDList[
                                                                              index]
                                                                          .totalPaidAmount!
                                                                          .toStringAsFixed(
                                                                              2),
                                                                  style:
                                                                      const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800,
                                                                    color: UIGuide
                                                                        .light_Purple,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        const Spacer(),
                                                        value.feePAIDList[index]
                                                                    .isCancelled ==
                                                                true
                                                            ? const Expanded(
                                                                child: Text(
                                                                  "Cancelled",
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: Colors
                                                                        .red,
                                                                  ),
                                                                ),
                                                              )
                                                            : const SizedBox(
                                                                height: 0,
                                                                width: 0,
                                                              )
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
                      ],
                    )),
    );
  }
}
