import 'package:essconnect/Application/StudentProviders/NotificationReceived.dart';
import 'package:essconnect/utils/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../utils/TextWrap(moreOption).dart';
import '../../utils/constants.dart';

class Stud_Notification extends StatelessWidget {
  Stud_Notification({Key? key}) : super(key: key);
  var kheight = const SizedBox(
    height: 8,
  );
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var p = Provider.of<NotificationReceivedProviderStudent>(context,
          listen: false);
      p.clearReceivedList();
      await p.getNotificationReceived();
    });
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        titleSpacing: 00.0,
        centerTitle: true,
        toolbarHeight: 60.2,
        toolbarOpacity: 0.8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
        ),
        backgroundColor: UIGuide.light_Purple,
      ),
      body: Consumer<NotificationReceivedProviderStudent>(
        builder: (context, value, child) => value.loading
            ? spinkitLoader()
            : value.receivedList.isEmpty || value.receivedList == null
                ? LottieBuilder.network(
                    'https://assets2.lottiefiles.com/private_files/lf30_lkquf6qz.json')
                : Scrollbar(
                    child: AnimationLimiter(
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        itemCount: value.receivedList.isEmpty
                            ? 0
                            : value.receivedList.length,
                        itemBuilder: (BuildContext context, int index) {
                          String createddate =
                              value.receivedList[index].createdDate ?? '--';
                          var updatedDate =
                              DateFormat('yyyy-MM-dd').parse(createddate);
                          String newDate = updatedDate.toString();
                          String finalCreatedDate =
                              newDate.replaceRange(10, 23, '');
                          return AnimationConfiguration.staggeredList(
                            position: index,
                            delay: const Duration(milliseconds: 50),
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
                                      color: const Color.fromARGB(
                                          255, 238, 238, 245),
                                      border: Border.all(
                                          color: const Color.fromARGB(
                                              255, 136, 187, 235)),
                                      borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(20),
                                          bottomLeft: Radius.circular(20))),
                                  width: size.width,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Container(
                                      width: size.width - 4,
                                      decoration: const BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 253, 253, 253),
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
                                                Container(
                                                  height: 25,
                                                  width: 25,
                                                  child: LottieBuilder.network(
                                                      'https://assets7.lottiefiles.com/packages/lf20_0skurerf.json'),
                                                ),
                                                Text(
                                                  value.receivedList[index]
                                                              .title ==
                                                          null
                                                      ? '--'
                                                      : value
                                                          .receivedList[index]
                                                          .title
                                                          .toString(),
                                                  style: const TextStyle(
                                                      color:
                                                          UIGuide.light_Purple,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            ),
                                            kheight,
                                            TextWrapper(
                                              text: value.receivedList[index]
                                                          .body ==
                                                      null
                                                  ? '--'
                                                  : value
                                                      .receivedList[index].body
                                                      .toString(),
                                              fSize: 14,
                                            ),
                                            kheight,
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
                                                      : finalCreatedDate
                                                          .toString(),
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
                                                  value.receivedList[index]
                                                              .fromStaff ==
                                                          null
                                                      ? '--'
                                                      : value
                                                          .receivedList[index]
                                                          .fromStaff
                                                          .toString(),
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
      ),
    );
  }
}
