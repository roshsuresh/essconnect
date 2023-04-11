import 'package:essconnect/Application/Staff_Providers/StaffNotificationScreen.dart';
import 'package:essconnect/Constants.dart';
import 'package:essconnect/utils/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../utils/TextWrap(moreOption).dart';
import '../../utils/constants.dart';

class StaffNotificationScreen extends StatelessWidget {
  StaffNotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Notification'),
              titleSpacing: 20.0,
              centerTitle: true,
              toolbarHeight: 30.2,
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
                  Tab(
                    text: "Received",
                  ),
                  Tab(text: "Sent History"),
                ],
              ),
              backgroundColor: UIGuide.light_Purple,
            ),
            body: TabBarView(children: [
              StaffNotificationReceived(),
              const StaffNotificationSendHistory(),
            ])));
  }
}

class StaffNotificationReceived extends StatelessWidget {
  StaffNotificationReceived({Key? key}) : super(key: key);
  var size, height, width;
  var kheight = const SizedBox(
    height: 8,
  );

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var p =
          Provider.of<StaffNotificationScreenProvider>(context, listen: false);
      p.notificationList.clear();
      p.getNotificationReceived();
    });
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Consumer<StaffNotificationScreenProvider>(
      builder: (context, value, child) => value.loading
          ? spinkitLoader()
          : Scrollbar(
              child: AnimationLimiter(
                child: ListView.builder(
                  padding: EdgeInsets.all(size.width / 70),
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  itemCount: value.notificationList.isEmpty
                      ? 0
                      : value.notificationList.length,
                  itemBuilder: (BuildContext context, int index) {
                    String createddate =
                        value.notificationList[index].createdDate ?? '--';
                    var updatedDate =
                        DateFormat('yyyy-MM-dd').parse(createddate);
                    String newDate = updatedDate.toString();
                    String finalCreatedDate = newDate.replaceRange(10, 23, '');
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      delay: const Duration(milliseconds: 100),
                      child: SlideAnimation(
                        duration: const Duration(milliseconds: 2500),
                        curve: Curves.fastLinearToSlowEaseIn,
                        horizontalOffset: -300,
                        verticalOffset: -850,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 6.0, right: 6, bottom: 3, top: 3),
                          child: Container(
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 234, 234, 236),
                                border: Border.all(
                                    color: const Color.fromARGB(
                                        255, 136, 187, 235)),
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    bottomLeft: Radius.circular(20))),
                            width: size.width,
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Container(
                                width: size.width - 4,
                                decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
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
                                            child: LottieBuilder.network(
                                                'https://assets7.lottiefiles.com/packages/lf20_0skurerf.json'),
                                          ),
                                          // Text('🔔'),
                                          Text(
                                            value.notificationList[index]
                                                    .title ??
                                                '--',
                                            style: const TextStyle(
                                                color: UIGuide.light_Purple,
                                                fontWeight: FontWeight.w700),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                      kheight,
                                      TextWrapper(
                                        text: value
                                                .notificationList[index].body ??
                                            '--',
                                        fSize: 14,
                                      ),
                                      kheight10,
                                      Row(
                                        children: [
                                          const Text(
                                            'Date: ',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12),
                                          ),
                                          Text(
                                            finalCreatedDate == null
                                                ? '--'
                                                : finalCreatedDate.toString(),
                                            style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 49, 47, 47),
                                                fontSize: 12),
                                          ),
                                          const Spacer(),
                                          const Text(
                                            'Sent by: ',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12),
                                          ),
                                          Text(
                                            value.notificationList[index]
                                                    .fromStaff ??
                                                '--',
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
                        //Column( coloumn end poin
                        //   children: [
                        //     kheight,
                        //     Container(
                        //       width: width - 4,
                        //       decoration: const BoxDecoration(
                        //           boxShadow: [
                        //             BoxShadow(
                        //               blurRadius: 2,
                        //             )
                        //           ],
                        //           color: Color.fromARGB(255, 245, 246, 248),
                        //           borderRadius:
                        //               BorderRadius.all(Radius.circular(10))),
                        //       child: Padding(
                        //         padding: const EdgeInsets.all(6.0),
                        //         child: Column(
                        //           crossAxisAlignment: CrossAxisAlignment.start,
                        //           children: [
                        //             Text(
                        //               value.notificationList[index].title ??
                        //                   '--',
                        //               style: const TextStyle(
                        //                   fontWeight: FontWeight.w700),
                        //               textAlign: TextAlign.center,
                        //             ),
                        //             kheight,
                        //             TextWrapper(
                        //               text:
                        //                   value.notificationList[index].body ??
                        //                       '--',
                        //               fSize: 14,
                        //             ),
                        //             kheight,
                        //             Row(
                        //               children: [
                        //                 const Text(
                        //                   'Date',
                        //                   style: TextStyle(
                        //                       color: Colors.grey, fontSize: 12),
                        //                 ),
                        //                 Text(
                        //                   finalCreatedDate == null
                        //                       ? '--'
                        //                       : finalCreatedDate,
                        //                   style: const TextStyle(
                        //                       color: Color.fromARGB(
                        //                           255, 49, 47, 47),
                        //                       fontSize: 12),
                        //                 ),
                        //                 const Spacer(),
                        //                 const Text(
                        //                   'Send by ',
                        //                   style: TextStyle(
                        //                       color: Colors.grey, fontSize: 12),
                        //                 ),
                        //                 Text(
                        //                   value.notificationList[index]
                        //                           .fromStaff ??
                        //                       '--',
                        //                   style: const TextStyle(
                        //                       color: Color.fromARGB(
                        //                           255, 49, 47, 47),
                        //                       fontSize: 12),
                        //                 ),
                        //               ],
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ),
                    );
                  },
                ),
              ),
            ),
    );
  }
}

//send history

class StaffNotificationSendHistory extends StatelessWidget {
  const StaffNotificationSendHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var p =
          Provider.of<StaffNotificationScreenProvider>(context, listen: false);
      p.getNotificationHistory();
      p.historyList.clear();
    });
    var size = MediaQuery.of(context).size;

    return Consumer<StaffNotificationScreenProvider>(
      builder: (context, value, child) => value.loading
          ? spinkitLoader()
          : Scrollbar(
              child: AnimationLimiter(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  itemCount:
                      value.historyList.isEmpty ? 0 : value.historyList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      delay: const Duration(milliseconds: 100),
                      child: SlideAnimation(
                        duration: const Duration(milliseconds: 2500),
                        curve: Curves.fastLinearToSlowEaseIn,
                        horizontalOffset: -300,
                        verticalOffset: -850,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: LimitedBox(
                            maxHeight: 100,
                            child: Container(
                              width: size.width,
                              // height: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border:
                                      Border.all(color: UIGuide.light_Purple)),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Text(
                                        '  Title: ',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: UIGuide.light_Purple),
                                      ),
                                      Flexible(
                                        child: Text(
                                          value.historyList[index].title ??
                                              '--',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Text(
                                        '  Matter: ',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: UIGuide.light_Purple),
                                      ),
                                      Flexible(
                                        child: RichText(
                                          overflow: TextOverflow.ellipsis,
                                          strutStyle:
                                              const StrutStyle(fontSize: 13),
                                          maxLines: 3,
                                          text: TextSpan(
                                            style: const TextStyle(
                                                fontSize: 15,
                                                color: Color.fromARGB(
                                                    255, 44, 43, 43)),
                                            text:
                                                value.historyList[index].body ??
                                                    '--',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        const Text(
                                          'Created At: ',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: UIGuide.light_Purple),
                                        ),
                                        Text(
                                          value.historyList[index]
                                                  .createdDate ??
                                              '--',
                                        ),
                                      ],
                                    ),
                                  )
                                ],
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
