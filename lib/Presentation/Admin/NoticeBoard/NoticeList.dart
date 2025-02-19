import 'package:essconnect/Application/AdminProviders/NoticeBoardList.dart';
import 'package:essconnect/Constants.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:essconnect/utils/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../Application/AdminProviders/NoticeBoardadmin.dart';

class NoticeBoardListAdmin extends StatelessWidget {
  const NoticeBoardListAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var p = Provider.of<NoticeBoardListAdminProvider>(context, listen: false);
      p.getNoticeListView(context);
      p.noticeList.clear();
    });
    var size = MediaQuery.of(context).size;
    return Consumer<NoticeBoardListAdminProvider>(
      builder: (context, provider, child) {
        return provider.loading
            ? spinkitLoader()
            : ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: provider.noticeList.isEmpty
                    ? 0
                    : provider.noticeList.length,
                itemBuilder: (context, index) {
                  //created date
                  String finalCreatedDate = "";

                  if (provider.noticeList[index].createdAt != null) {
                    String createddate =
                        provider.noticeList[index].createdAt ?? '--';
                    DateTime parsedDateTime = DateTime.parse(createddate);
                    finalCreatedDate =
                        DateFormat('dd/MMM/yyyy').format(parsedDateTime);
                  }

                  String even = provider.noticeList[index].id.toString();
                  return Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Container(
                      width: size.width,
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: UIGuide.light_Purple, width: 1),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Row(
                              children: [
                                const Text('Created Date: '),
                                Text(
                                  finalCreatedDate,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13),
                                ),
                                const Spacer(),
                                Container(
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 236, 239, 253),
                                      border: Border.all(
                                          color: UIGuide.THEME_LIGHT),
                                      borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(8),
                                          bottomLeft: Radius.circular(10))),
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                          provider.editNoticeList(even);
                                          showModalBottomSheet(
                                              context: context,
                                              isScrollControlled: true,
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(30),
                                                    topRight:
                                                        Radius.circular(30)),
                                              ),
                                              builder: (_) {
                                                //created date
                                                String fCreatedDate = "";

                                                if (provider.createdDate !=
                                                    null) {
                                                  String createddate =
                                                      provider.createdDate ??
                                                          '--';
                                                  DateTime parsedDateTime =
                                                      DateTime.parse(
                                                          createddate);
                                                  fCreatedDate = DateFormat(
                                                          'dd/MMM/yyyy')
                                                      .format(parsedDateTime);
                                                }
                                                //start date
                                                String fStartDate = "";

                                                if (provider.displayStartDate !=
                                                    null) {
                                                  String createddate = provider
                                                          .displayStartDate ??
                                                      '--';
                                                  DateTime parsedDateTime =
                                                      DateTime.parse(
                                                          createddate);
                                                  fStartDate = DateFormat(
                                                          'dd/MMM/yyyy')
                                                      .format(parsedDateTime);
                                                }

                                                //End date
                                                String fEndDate = "";

                                                if (provider.displayEndDate !=
                                                    null) {
                                                  String createddate =
                                                      provider.displayEndDate ??
                                                          '--';
                                                  DateTime parsedDateTime =
                                                      DateTime.parse(
                                                          createddate);
                                                  fEndDate = DateFormat(
                                                          'dd/MMM/yyyy')
                                                      .format(parsedDateTime);
                                                }
                                                return Consumer<
                                                        NoticeBoardListAdminProvider>(
                                                    builder:
                                                        (context, snap, child) {
                                                  return Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: SizedBox(
                                                          width:
                                                              size.width / 2.5,
                                                          child: const Divider(
                                                            thickness: 5,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    188,
                                                                    189,
                                                                    190),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Row(
                                                          children: [
                                                            const Text(
                                                              'Entry Date: ',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: UIGuide
                                                                      .light_Purple),
                                                            ),
                                                            Text(
                                                              fCreatedDate,
                                                              style:
                                                                  const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 16,
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
                                                              'Title: ',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: UIGuide
                                                                      .light_Purple),
                                                            ),
                                                            Expanded(
                                                                child: Text(
                                                                    snap.title ??
                                                                        '--',
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            15,
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            44,
                                                                            43,
                                                                            43)))),
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
                                                              'Matter: ',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: UIGuide
                                                                      .light_Purple),
                                                            ),
                                                            Expanded(
                                                                child: Text(
                                                                    snap.matter ??
                                                                        '--',
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            15,
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            44,
                                                                            43,
                                                                            43)))),
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
                                                              'Start Date: ',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: UIGuide
                                                                      .light_Purple),
                                                            ),
                                                            Text(
                                                              fStartDate,
                                                              style:
                                                                  const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
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
                                                              'End Date: ',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: UIGuide
                                                                      .light_Purple),
                                                            ),
                                                            Text(
                                                              fEndDate,
                                                              style:
                                                                  const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
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
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          children: [
                                                            MaterialButton(
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.0),
                                                                side: const BorderSide(
                                                                    color: UIGuide
                                                                        .light_Purple),
                                                              ),
                                                              onPressed:
                                                                  () async {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              color: UIGuide
                                                                  .ButtonBlue,
                                                              child: const Text(
                                                                  'Cancel'),
                                                            ),
                                                            kWidth,
                                                            MaterialButton(
                                                              onPressed:
                                                                  () async {
                                                                await provider
                                                                    .noticeAproove(
                                                                        context,
                                                                        even);

                                                                Navigator.pop(
                                                                    context);
                                                                await Provider.of<NoticeBoardAdminProvider>(context,listen: false).
                                                                noticeBoardApproveNotification(
                                                                    provider.id.toString(),
                                                                    provider.createdDate.toString(),
                                                                    provider.displayStartDate.toString(),
                                                                    provider.displayEndDate.toString(),
                                                                    provider.title.toString(),
                                                                    provider.matter.toString(),
                                                                    'student',
                                                                    provider.course,
                                                                    provider.divisions,
                                                                    provider.categoryId.toString(),
                                                                    provider.attachmentId.toString(),
                                                                    provider.id.toString());
                                                                provider
                                                                    .noticeList
                                                                    .clear();
                                                                await provider
                                                                    .getNoticeListView(
                                                                        context);
                                                              },
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.0),
                                                                side: const BorderSide(
                                                                    color: UIGuide
                                                                        .light_Purple),
                                                              ),
                                                              color: UIGuide
                                                                  .light_Purple,
                                                              child: const Text(
                                                                'Approve',
                                                                style: TextStyle(
                                                                    color: UIGuide
                                                                        .WHITE),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  );
                                                });
                                              });
                                        },
                                        child: const Padding(
                                          padding: EdgeInsets.only(
                                              left: 8,
                                              right: 8,
                                              top: 3,
                                              bottom: 2),
                                          child: Icon(
                                            Icons.mode_edit_outline_outlined,
                                            color: UIGuide.light_Purple,
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          String event = provider
                                              .noticeList[index].id
                                              .toString();
                                          await provider.noticeDelete(
                                              event, context, index);
                                        },
                                        child: const Padding(
                                          padding: EdgeInsets.only(
                                              left: 8,
                                              right: 8,
                                              top: 3,
                                              bottom: 2),
                                          child: Icon(
                                            Icons.delete_forever_outlined,
                                            color: Colors.red,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Row(
                              children: [
                                const Text('Title: '),
                                Flexible(
                                  child: Text(
                                    provider.noticeList[index].title ?? '--',
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5, top: 5),
                            child: Row(
                              children: [
                                const Text('Created By: '),
                                Flexible(
                                  child: Text(
                                    provider.noticeList[index]
                                            .createStaffName ??
                                        '--',
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Consumer<NoticeBoardListAdminProvider>(
                            builder: (context, value, child) {
                              if (value.noticeList[index].approved == true &&
                                  value.noticeList[index].cancelled == false) {
                                return const Padding(
                                  padding: EdgeInsets.only(
                                      left: 5, top: 5, bottom: 5),
                                  child: Row(
                                    children: [
                                      Text('Status : '),
                                      Text(
                                        'Approved',
                                        overflow: TextOverflow.clip,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 13,
                                            color: Colors.green),
                                      ),
                                    ],
                                  ),
                                );
                              } else if (value.noticeList[index].approved ==
                                      false &&
                                  value.noticeList[index].cancelled == true) {
                                return const Padding(
                                  padding: EdgeInsets.only(
                                      left: 5, top: 5, bottom: 5),
                                  child: Row(
                                    children: [
                                      Text('Status : '),
                                      Text(
                                        'Cancelled',
                                        overflow: TextOverflow.clip,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 13,
                                            color: Colors.red),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                return const Padding(
                                  padding: EdgeInsets.only(
                                      left: 5, top: 5, bottom: 5),
                                  child: Row(
                                    children: [
                                      Text('Status : '),
                                      Text(
                                        'Pending',
                                        overflow: TextOverflow.clip,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 13,
                                            color: Colors.orange),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                            child: const Padding(
                              padding:
                                  EdgeInsets.only(left: 5, top: 5, bottom: 5),
                              child: Row(
                                children: [
                                  Text('Status : '),
                                  Text(
                                    'Approved',
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13,
                                        color: Colors.green),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
      },
    );
  }
}
