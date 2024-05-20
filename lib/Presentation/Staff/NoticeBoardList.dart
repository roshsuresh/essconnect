import 'package:essconnect/Application/Staff_Providers/NoticeboardSend.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:essconnect/utils/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class NoticeBoardListstaff extends StatefulWidget {
  const NoticeBoardListstaff({Key? key}) : super(key: key);

  @override
  State<NoticeBoardListstaff> createState() => _NoticeBoardListstaffState();
}

class _NoticeBoardListstaffState extends State<NoticeBoardListstaff> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var p =
          Provider.of<StaffNoticeboardSendProviders>(context, listen: false);
      p.noticeList.clear();
      p.noticeBoardSendList();
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Consumer<StaffNoticeboardSendProviders>(
      builder: (context, provider, child) {
        return provider.loadList
            ? spinkitLoader()
            : provider.noticeList.isEmpty
                ? Center(
                    child: Container(
                      child: LottieBuilder.network(
                          'https://assets2.lottiefiles.com/private_files/lf30_lkquf6qz.json'),
                    ),
                  )
                : ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: provider.noticeList.isEmpty
                        ? 0
                        : provider.noticeList.length,
                    itemBuilder: (context, index) {
                      if (provider.noticeList.isEmpty) {
                        return Center(
                          child: Container(
                            child: LottieBuilder.network(
                                'https://assets2.lottiefiles.com/private_files/lf30_lkquf6qz.json'),
                          ),
                        );
                      } else {
                        //created date
                        String finalCreatedDate = "";

                        if (provider.noticeList[index].createdAt != null) {
                          String createddate =
                              provider.noticeList[index].createdAt ?? '--';
                          DateTime parsedDateTime = DateTime.parse(createddate);
                          finalCreatedDate =
                              DateFormat('dd/MMM/yyyy').format(parsedDateTime);
                        }
                        return Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Container(
                            width: size.width,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: UIGuide.light_Purple, width: 1),
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
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
                                      InkWell(
                                        onTap: () async {
                                          String event = provider
                                              .noticeList[index].id
                                              .toString();
                                          await provider.noticeDeleteStaff(
                                              context, event, index);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                  255, 236, 239, 253),
                                              border: Border.all(
                                                  color: UIGuide.THEME_LIGHT),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topRight:
                                                          Radius.circular(10),
                                                      bottomLeft:
                                                          Radius.circular(10))),
                                          child: const Padding(
                                            padding: EdgeInsets.only(
                                                left: 8,
                                                right: 8,
                                                top: 3,
                                                bottom: 2),
                                            child: Icon(
                                              Icons.delete_forever_outlined,
                                              color: Colors.red,
                                              size: 22,
                                            ),
                                          ),
                                        ),
                                      )
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
                                          provider.noticeList[index].title ??
                                              '--',
                                          overflow: TextOverflow.clip,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 13),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 5, top: 5),
                                  child: Row(
                                    children: [
                                      const Text('Created By: '),
                                      Flexible(
                                        child: Text(
                                          provider.noticeList[index]
                                                  .createStaffName ??
                                              '--',
                                          overflow: TextOverflow.clip,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 13),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Consumer<StaffNoticeboardSendProviders>(
                                  builder: (context, value, child) {
                                    if (value.noticeList[index].approved ==
                                            true &&
                                        value.noticeList[index].cancelled ==
                                            false) {
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
                                    } else if (value
                                                .noticeList[index].approved ==
                                            false &&
                                        value.noticeList[index].cancelled ==
                                            true) {
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
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    },
                  );
      },
    );
  }
}
