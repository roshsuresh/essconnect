import 'package:essconnect/Application/StudentProviders/OfflineFeeProviders.dart';
import 'package:essconnect/Constants.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:essconnect/utils/spinkit.dart';
import 'package:flutter/material.dart';
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
                      LimitedBox(
                        maxHeight: size.height - 240,
                        child: Scrollbar(
                          child: ListView.builder(
                              itemCount: value.feesDetailList.length,
                              shrinkWrap: true,
                              itemBuilder: ((context, index) {
                                String createddate = value
                                        .feesDetailList[index].fineStartsFrom ??
                                    '--';
                                String finalCreatedDate = '';
                                if (value
                                        .feesDetailList[index].fineStartsFrom !=
                                    null) {
                                  DateTime parsedDateTime =
                                      DateTime.parse(createddate);

                                  finalCreatedDate = DateFormat('dd-MMM-yyyy')
                                      .format(parsedDateTime);
                                }

                                return Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Container(
                                    width: size.width,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
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
                                                    color: UIGuide.LightBlue,
                                                    border: Border.all(
                                                        color: UIGuide
                                                            .light_Purple,
                                                        width: .2),
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    10),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10))),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Text(
                                                    "${index + 1}",
                                                    style: const TextStyle(
                                                        color: UIGuide
                                                            .light_Purple,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                )),
                                            const Text("  Installment: "),
                                            Expanded(
                                              child: Text(
                                                value.feesDetailList[index]
                                                        .installment ??
                                                    "--",
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: UIGuide.light_Purple,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 6, bottom: 6),
                                          child: Row(
                                            children: [
                                              value.feesDetailList[index]
                                                          .fineStartsFrom ==
                                                      null
                                                  ? const SizedBox(
                                                      height: 0,
                                                      width: 0,
                                                    )
                                                  : Expanded(
                                                      child: Row(
                                                        children: [
                                                          const Expanded(
                                                            child: Text(
                                                                "Fine starts from: "),
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              finalCreatedDate,
                                                              style:
                                                                  const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color:
                                                                    Colors.red,
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
                                                  : Expanded(
                                                      child: Row(
                                                        children: [
                                                          const Expanded(
                                                            child: Text(
                                                                "Consession Amount: "),
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              value
                                                                          .feesDetailList[
                                                                              index]
                                                                          .concessionAmount ==
                                                                      null
                                                                  ? "0.00"
                                                                  : value
                                                                      .feesDetailList[
                                                                          index]
                                                                      .concessionAmount
                                                                      .toString(),
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
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 6, bottom: 8),
                                          child: Row(
                                            children: [
                                              Expanded(
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
                                                                .amount
                                                                .toString(),
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
                                              ),
                                              Expanded(
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
                                                                .paidAmount
                                                                .toString(),
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
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 6, bottom: 6),
                                          child: Row(
                                            children: [
                                              const Text("Balance: "),
                                              Expanded(
                                                child: Text(
                                                  value.feesDetailList[index]
                                                              .balanceAmount ==
                                                          null
                                                      ? "--"
                                                      : value
                                                          .feesDetailList[index]
                                                          .balanceAmount
                                                          .toString(),
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w800,
                                                    color: UIGuide.BLACK,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              })),
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
                                                    " ${value.totalListFee[index].totalAmount}",
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
                                                    " ${value.totalListFee[index].totalPaidAmount}",
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
                                                color: const Color.fromARGB(
                                                    255, 234, 237, 250)),
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
                                                  " ${value.totalListFee[index].totalBalanceAmount}",
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
