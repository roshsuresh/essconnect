import 'package:essconnect/Application/AdminProviders/NoticeBoardList.dart';
import 'package:essconnect/Constants.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:essconnect/utils/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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
                  String createddate =
                      provider.noticeList[index].createdAt ?? '--';
                  var updatedDate = DateFormat('yyyy-MM-dd').parse(createddate);
                  String newDate = updatedDate.toString();
                  String finalCreatedDate = newDate.replaceRange(10, 23, '');

                  String even = provider.noticeList[index].id.toString();
                  return Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Container(
                      width: size.width,
                      height: 90,
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: UIGuide.light_Purple, width: 1),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Text('Created Date: '),
                                Text(
                                  finalCreatedDate == null
                                      ? '--'
                                      : finalCreatedDate.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13),
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () async {
                                    provider.editNoticeList(even);
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Dialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            elevation: 16,
                                            child: Consumer<
                                                    NoticeBoardListAdminProvider>(
                                                builder:
                                                    (context, snap, child) {
                                              return Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  kheight10,
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Row(
                                                      children: [
                                                        const Text(
                                                          'Entry Date: ',
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: UIGuide
                                                                  .light_Purple),
                                                        ),
                                                        Text(
                                                          snap.createdDate ??
                                                              '--',
                                                          style:
                                                              const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Row(
                                                      children: [
                                                        const Text(
                                                          'Title: ',
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: UIGuide
                                                                  .light_Purple),
                                                        ),
                                                        Flexible(
                                                          child: RichText(
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            strutStyle:
                                                                const StrutStyle(
                                                                    fontSize:
                                                                        13),
                                                            maxLines: 1,
                                                            text: TextSpan(
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            44,
                                                                            43,
                                                                            43)),
                                                                text:
                                                                    snap.title ??
                                                                        '--'),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Row(
                                                      children: [
                                                        const Text(
                                                          'Matter: ',
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: UIGuide
                                                                  .light_Purple),
                                                        ),
                                                        Flexible(
                                                          child: RichText(
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            strutStyle:
                                                                const StrutStyle(
                                                                    fontSize:
                                                                        13),
                                                            maxLines: 3,
                                                            text: TextSpan(
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            44,
                                                                            43,
                                                                            43)),
                                                                text:
                                                                    snap.matter ??
                                                                        '--'),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Row(
                                                      children: [
                                                        const Text(
                                                          'Start Date: ',
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: UIGuide
                                                                  .light_Purple),
                                                        ),
                                                        Text(
                                                          snap.displayStartDate ??
                                                              '--',
                                                          style:
                                                              const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Row(
                                                      children: [
                                                        const Text(
                                                          'Start Date: ',
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: UIGuide
                                                                  .light_Purple),
                                                        ),
                                                        Text(
                                                          snap.displayEndDate ??
                                                              '--',
                                                          style:
                                                              const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        MaterialButton(
                                                          onPressed: () async {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: const Text(
                                                              'Cancel'),
                                                          color: Colors.orange,
                                                        ),
                                                        kWidth,
                                                        MaterialButton(
                                                          onPressed: () async {
                                                            await provider
                                                                .noticeAproove(
                                                                    context,
                                                                    even);

                                                            Navigator.pop(
                                                                context);
                                                            provider.noticeList
                                                                .clear();
                                                            await provider
                                                                .getNoticeListView(
                                                                    context);
                                                          },
                                                          color: Colors.green,
                                                          child: const Text(
                                                              'Approve'),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              );
                                            }),
                                          );
                                        });

                                    // provider.noticeList.clear();
                                    // await provider.getNoticeListView(context);
                                  },
                                  child: const Icon(
                                    Icons.mode_edit_outline_outlined,
                                    color: UIGuide.light_Purple,
                                  ),
                                ),
                                kWidth,
                                GestureDetector(
                                  onTap: () async {
                                    String event = provider.noticeList[index].id
                                        .toString();
                                    await provider.noticeDelete(
                                        event, context, index);

                                    // provider.noticeList.clear();
                                    // await provider.getNoticeListView(context);
                                  },
                                  child: const Icon(
                                    Icons.delete_forever_outlined,
                                    color: Colors.red,
                                  ),
                                )
                              ],
                            ),
                            Row(
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
                            Row(
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
                            Consumer<NoticeBoardListAdminProvider>(
                              builder: (context, value, child) {
                                if (value.noticeList[index].approved == true &&
                                    value.noticeList[index].cancelled ==
                                        false) {
                                  return Row(
                                    children: const [
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
                                  );
                                } else if (value.noticeList[index].approved ==
                                        false &&
                                    value.noticeList[index].cancelled == true) {
                                  return Row(
                                    children: const [
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
                                  );
                                } else {
                                  return Row(
                                    children: const [
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
                                  );
                                }
                              },
                              child: Row(
                                children: const [
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
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
      },
    );
  }
}
