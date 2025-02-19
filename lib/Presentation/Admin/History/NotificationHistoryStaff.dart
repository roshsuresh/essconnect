import 'package:essconnect/Constants.dart';
import 'package:essconnect/Presentation/Admin/History/StaffNotificationHIstory.dart';
import 'package:essconnect/utils/TextWrap(moreOption).dart';
import 'package:essconnect/utils/constants.dart';
import 'package:essconnect/utils/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../../Application/AdminProviders/NotificationToGuardian.dart';

class NotificationHistory extends StatelessWidget {
  const NotificationHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Notification History'),
              titleSpacing: 20.0,
              centerTitle: true,
              toolbarHeight: 39,
              toolbarOpacity: 0.8,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25)),
              ),
              bottom: const TabBar(
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: Colors.white,
                indicatorWeight: 5,
                tabs: [
                  Tab(text: "Student"),
                  Tab(
                    text: "Staff",
                  ),
                ],
              ),
              backgroundColor: UIGuide.light_Purple,
            ),
            body: const TabBarView(children: [
              StudentNotificationHistory(),
              StaffNotificationHistoryy()
            ])));
  }
}

class StudentNotificationHistory extends StatelessWidget {
  const StudentNotificationHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var p = Provider.of<NotificationToGuardianAdmin>(context, listen: false);
      p.historyList.clear();
      await p.getNotificationHistory();
    });
    var size = MediaQuery.of(context).size;
    return Consumer<NotificationToGuardianAdmin>(
      builder: (context, value, child) => value.loading
          ? spinkitLoader()
          : AnimationLimiter(
        child: Scrollbar(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: value.historyList.length,
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            itemBuilder: (BuildContext context, index) {
              //start date
              String finalStartDate = '';

              if (value.historyList[index].createdDate != null) {
                String startdate =
                    value.historyList[index].createdDate ?? '--';
                DateTime parsedDateTime = DateTime.parse(startdate);

                finalStartDate =
                    DateFormat('dd-MMM-yyyy').format(parsedDateTime);
              }
              return AnimationConfiguration.staggeredList(
                position: index,
                delay: const Duration(milliseconds: 100),
                child: SlideAnimation(
                  duration: const Duration(milliseconds: 2500),
                  curve: Curves.fastLinearToSlowEaseIn,
                  horizontalOffset: 30,
                  verticalOffset: 300.0,
                  child: FlipAnimation(
                    duration: const Duration(milliseconds: 3000),
                    curve: Curves.fastLinearToSlowEaseIn,
                    flipAxis: FlipAxis.y,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 6.0, right: 6, bottom: 3, top: 3),
                      child: Container(
                        decoration: BoxDecoration(
                            color:
                            const Color.fromARGB(255, 238, 238, 245),
                            border: Border.all(
                                color: const Color.fromARGB(
                                    255, 136, 187, 235)),
                            borderRadius: const BorderRadius.all(
                                Radius.circular(10))),
                        width: size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            width: size.width - 4,
                            decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 253, 253, 253),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(10))),
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        height: 25,
                                        width: 25,
                                        child: Icon(Icons.notifications,
                                          color: Color.fromARGB(
                                              213, 231, 210, 30),),
                                      ),
                                      SizedBox(
                                        width: size.width - 90,
                                        child: Text(
                                          value.historyList[index]
                                              .title ==
                                              null
                                              ? '--'
                                              : value.historyList[index]
                                              .title
                                              .toString(),
                                          style: const TextStyle(
                                              color: UIGuide.light_Purple,
                                              fontWeight:
                                              FontWeight.w700),
                                          //   textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                  kheight10,
                                  LinkTextWidget(
                                    text:   value.historyList[index].body ??
                                        '--',
                                    font: 13,

                                  ),

                                  // TextWrapper(
                                  //     text:
                                  //         value.historyList[index].body ??
                                  //             '--',
                                  //     fSize: 13),
                                  kheight10,
                                  Row(
                                    children: [
                                      const Spacer(),
                                      const Text(
                                        'Created  date: ',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12),
                                      ),
                                      Text(
                                        finalStartDate,
                                        style: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 49, 47, 47),
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
