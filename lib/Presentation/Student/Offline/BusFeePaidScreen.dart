import 'package:essconnect/Application/StudentProviders/OfflineFeeProviders.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:essconnect/utils/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class BusFeePaidScreen extends StatelessWidget {
  const BusFeePaidScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var p = Provider.of<OfflineFeeProviders>(context, listen: false);
      await p.clearBusPAIDList();
      await p.getBusPAIDList();
    });
    var size = MediaQuery.of(context).size;
    return Consumer<OfflineFeeProviders>(
      builder: (context, value, _) => Scaffold(
          body: value.loadingBP
              ? spinkitLoader()
              : value.busPaidList.isEmpty || value.busPaidList == null
                  ? LottieBuilder.network(
                      'https://assets2.lottiefiles.com/private_files/lf30_lkquf6qz.json')
                  : ListView.builder(
                      itemCount: value.busPaidList.length,
                      itemBuilder: ((context, index) {
                        String createddate =
                            value.busPaidList[index].receiptDate ?? '--';
                        DateTime parsedDateTime = DateTime.parse(createddate);

                        String finalCreatedDate =
                            DateFormat('dd-MMM-yyyy').format(parsedDateTime);
                        return Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Container(
                            width: size.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: UIGuide.light_Purple)),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 6, bottom: 4, top: 8),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            const Text("Receipt Date: "),
                                            Expanded(
                                              child: Text(
                                                finalCreatedDate,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: UIGuide.light_Purple,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          children: [
                                            const Text("Receipt Number: "),
                                            Expanded(
                                              child: Text(
                                                value.busPaidList[index]
                                                        .receiptNumber ??
                                                    "--",
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
                                ListView.builder(
                                    itemCount: value.busPaidList[index]
                                        .detailedFeesList?.length,
                                    padding: const EdgeInsets.all(0),
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: ((context, ind) => Padding(
                                          padding: const EdgeInsets.all(3),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: UIGuide.LightBlue,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            3.0),
                                                    child: Row(
                                                      children: [
                                                        const Text(
                                                            "Installment: "),
                                                        Expanded(
                                                          child: Text(
                                                            value
                                                                    .busPaidList[
                                                                        index]
                                                                    .detailedFeesList![
                                                                        ind]
                                                                    .installment ??
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
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            3.0),
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          child: Row(
                                                            children: [
                                                              const Text(
                                                                  "Due Amount: "),
                                                              Expanded(
                                                                child: Text(
                                                                  value.busPaidList[index].detailedFeesList![ind].amount ==
                                                                          null
                                                                      ? "0.00"
                                                                      : value
                                                                          .busPaidList[
                                                                              index]
                                                                          .detailedFeesList![
                                                                              ind]
                                                                          .amount
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
                                                        value.showConcession ==
                                                                false
                                                            ? const SizedBox(
                                                                height: 0,
                                                                width: 0,
                                                              )
                                                            : Expanded(
                                                                child: Row(
                                                                  children: [
                                                                    const Text(
                                                                        "Concession Amount: "),
                                                                    Expanded(
                                                                      child:
                                                                          Text(
                                                                        value.busPaidList[index].detailedFeesList![ind].concessionAmount ==
                                                                                null
                                                                            ? "0.00"
                                                                            : value.busPaidList[index].detailedFeesList![ind].concessionAmount.toString(),
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
                                                ],
                                              ),
                                            ),
                                          ),
                                        ))),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 6,
                                    bottom: 8,
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            const Text("Amount: "),
                                            Expanded(
                                              child: Text(
                                                value.busPaidList[index]
                                                            .totalAmount ==
                                                        null
                                                    ? "0.00"
                                                    : value.busPaidList[index]
                                                        .totalAmount
                                                        .toString(),
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: UIGuide.light_Purple,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      value.showConcession == false
                                          ? const SizedBox(
                                              height: 0,
                                              width: 0,
                                            )
                                          : Expanded(
                                              child: Row(
                                                children: [
                                                  const Expanded(
                                                      child: Text(
                                                          "Total Consession Amount: ")),
                                                  Expanded(
                                                    child: Text(
                                                      value.busPaidList[index]
                                                                  .totalConcessionAmount ==
                                                              null
                                                          ? "0.00"
                                                          : value
                                                              .busPaidList[
                                                                  index]
                                                              .totalConcessionAmount
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
                                    left: 6,
                                    bottom: 8,
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            const Text("Fine: "),
                                            Expanded(
                                              child: Text(
                                                value.busPaidList[index].fine ==
                                                        null
                                                    ? "0.00"
                                                    : value
                                                        .busPaidList[index].fine
                                                        .toString(),
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: UIGuide.light_Purple,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          children: [
                                            const Text("Subsidy: "),
                                            Expanded(
                                              child: Text(
                                                value.busPaidList[index]
                                                            .subsidy ==
                                                        null
                                                    ? "0.00"
                                                    : value.busPaidList[index]
                                                        .subsidy
                                                        .toString(),
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
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 6,
                                    bottom: 8,
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            color: UIGuide.LightBlue,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: Row(
                                            children: [
                                              const Text(
                                                "NetAmount: ",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: UIGuide.BLACK,
                                                ),
                                              ),
                                              Text(
                                                value.busPaidList[index]
                                                            .netAmount ==
                                                        null
                                                    ? "0.00"
                                                    : value.busPaidList[index]
                                                        .netAmount
                                                        .toString(),
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  color: UIGuide.light_Purple,
                                                ),
                                              ),
                                            ],
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
                      }))),
    );
  }
}
