import 'package:essconnect/Application/Staff_Providers/MarkReportProvider.dart';
import 'package:essconnect/Constants.dart';
import 'package:essconnect/utils/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UASmarkentryReport extends StatelessWidget {
  const UASmarkentryReport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Consumer<MarkEntryReportProvider_stf>(
      builder: (context, val, child) => val.loading
          ? Column(
              children: [
                const SizedBox(
                  height: 150,
                ),
                spinkitLoader(),
              ],
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Table(
                    columnWidths: const {
                      0: FlexColumnWidth(1),
                      1: FlexColumnWidth(3),
                      2: FlexColumnWidth(1),
                      3: FlexColumnWidth(1),
                    },
                    children: const [
                      TableRow(
                          decoration: BoxDecoration(
                            //  border: Border.all(),
                            color: Color.fromARGB(255, 228, 224, 224),
                          ),
                          children: [
                            SizedBox(
                              height: 30,
                              child: Center(
                                  child: Text(
                                'Roll No.',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 12),
                              )),
                            ),
                            SizedBox(
                              height: 30,
                              child: Center(
                                child: Text(
                                  'Name',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                              child: Center(
                                  child: Text(
                                'Mark',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 12),
                              )),
                            ),
                            SizedBox(
                              height: 30,
                              child: Center(
                                  child: Text(
                                'Total\nMark',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 12),
                              )),
                            ),
                          ]),
                    ],
                  ),
                ),
                Consumer<MarkEntryReportProvider_stf>(
                  builder: (context, provider, child) => LimitedBox(
                      maxHeight: size.height - 300,
                      child: Scrollbar(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: provider.markReportStudList.isEmpty
                                ? 0
                                : provider.markReportStudList.length,
                            itemBuilder: ((context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Column(
                                  children: [
                                    Table(
                                      columnWidths: const {
                                        0: FlexColumnWidth(1),
                                        1: FlexColumnWidth(3),
                                        2: FlexColumnWidth(1),
                                        3: FlexColumnWidth(1),
                                      },
                                      children: [
                                        TableRow(
                                            decoration: const BoxDecoration(),
                                            children: [
                                              Text(
                                                provider
                                                            .markReportStudList[
                                                                index]
                                                            .rollNo ==
                                                        null
                                                    ? '--'
                                                    : provider
                                                        .markReportStudList[
                                                            index]
                                                        .rollNo
                                                        .toString(),
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    fontSize: 12),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 0.0),
                                                child: Text(
                                                  provider
                                                          .markReportStudList[
                                                              index]
                                                          .name ??
                                                      '--',
                                                  textAlign: TextAlign.start,
                                                  style: const TextStyle(
                                                      fontSize: 14),
                                                ),
                                              ),
                                              ListView.builder(
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount: provider
                                                        .markReportStudList
                                                        .isEmpty
                                                    ? 0
                                                    : provider
                                                        .markReportStudList[
                                                            index]
                                                        .subjectMarkDetails!
                                                        .length,
                                                itemBuilder: (context, indexx) {
                                                  return Text(
                                                    provider
                                                                .markReportStudList[
                                                                    index]
                                                                .subjectMarkDetails![
                                                                    indexx]
                                                                .teMark ==
                                                            null
                                                        ? '--'
                                                        : provider
                                                            .markReportStudList[
                                                                index]
                                                            .subjectMarkDetails![
                                                                indexx]
                                                            .teMark
                                                            .toString(),
                                                    textAlign: TextAlign.center,
                                                  );
                                                },
                                              ),
                                              Text(
                                                provider
                                                            .markReportStudList[
                                                                index]
                                                            .totalTEMark ==
                                                        null
                                                    ? '--'
                                                    : provider
                                                        .markReportStudList[
                                                            index]
                                                        .totalTEMark
                                                        .toString(),
                                                textAlign: TextAlign.center,
                                              ),
                                            ]),
                                      ],
                                    ),
                                    kheight20,
                                  ],
                                ),
                              );
                            })),
                      )),
                ),
              ],
            ),
    );
  }
}
