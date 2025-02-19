import 'package:essconnect/Application/Staff_Providers/NotificationCount.dart';
import 'package:essconnect/Application/Staff_Providers/StaffNotificationScreen.dart';
import 'package:essconnect/Constants.dart';
import 'package:essconnect/Presentation/Student/Stud_Notification.dart';
import 'package:essconnect/utils/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../utils/TextWrap(moreOption).dart';
import '../../utils/constants.dart';

class StaffNotificationScreen extends StatelessWidget {
  const StaffNotificationScreen({Key? key}) : super(key: key);

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
    var size = MediaQuery.of(context).size;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var p =
          Provider.of<StaffNotificationScreenProvider>(context, listen: false);
      await Provider.of<StaffNotificationCountProviders>(context, listen: false)
          .seeNotification();
      await Provider.of<StaffNotificationCountProviders>(context, listen: false)
          .getnotificationCount();
      p.notificationList.clear();

      p.getNotificationReceived();
    });

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
                    String finalCreatedDate = "";

                    if (value.notificationList[index].sentOn != null) {
                      String startdate =
                          value.notificationList[index].sentOn ?? '--';
                      DateTime parsedDateTime = DateTime.parse(startdate);

                      finalCreatedDate =
                          DateFormat('dd-MMM-yyyy').format(parsedDateTime);
                    }

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
                                color: const Color.fromARGB(255, 136, 187, 235),
                              ),
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                              ),
                            ),
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
                                          SizedBox(
                                            width: size.width - 90,
                                            child: Text(
                                              value.notificationList[index]
                                                      .title ??
                                                  '--',
                                              style: const TextStyle(
                                                  color: UIGuide.light_Purple,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                        ],
                                      ),
                                      kheight,
                                      LinkTextWidget(
                                        text:  value.notificationList[index]
                                            .message ==
                                            null
                                            ? '--'
                                            : value.notificationList[index]
                                            .message
                                            .toString(),

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
                                                    .sendStaff ??
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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var p =
          Provider.of<StaffNotificationScreenProvider>(context, listen: false);
      p.historyList.clear();
      await p.getNotificationHistory();
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
                        horizontalOffset: -300,
                        verticalOffset: -850,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 6.0, right: 6, bottom: 3, top: 3),
                          child: Container(
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 238, 238, 245),
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
                                            child: Icon(Icons.notifications,
                                              color: Color.fromARGB(
                                                  213, 231, 210, 30),),
                                          ),
                                          SizedBox(
                                            width: size.width - 90,
                                            child: Text(
                                              value.historyList[index].title ==
                                                      null
                                                  ? '--'
                                                  : value
                                                      .historyList[index].title
                                                      .toString(),
                                              style: const TextStyle(
                                                  color: UIGuide.light_Purple,
                                                  fontWeight: FontWeight.w700),
                                              //textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      ),
                                      kheight10,
                                      TextWrapper(
                                          text: value.historyList[index].body ??
                                              '--',
                                          fSize: 13),
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
                    );
                  },
                ),
              ),
            ),
    );
  }
}
