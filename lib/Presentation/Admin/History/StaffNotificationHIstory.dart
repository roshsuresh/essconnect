import 'package:essconnect/Application/AdminProviders/NotificationStaff.dart';
import 'package:essconnect/Constants.dart';
import 'package:essconnect/utils/TextWrap(moreOption).dart';
import 'package:essconnect/utils/constants.dart';
import 'package:essconnect/utils/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class StaffNotificationHistoryy extends StatelessWidget {
  const StaffNotificationHistoryy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var p = Provider.of<NotificationToStaffAdminProviders>(context,
          listen: false);
      p.historyList.clear();
      await p.getNotificationHistory();
    });
    var size = MediaQuery.of(context).size;
    return Consumer<NotificationToStaffAdminProviders>(
      builder: (context, value, child) => value.loading
          ? spinkitLoader()
          : AnimationLimiter(
              child: Scrollbar(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  itemCount: value.historyList.length,
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
                          flipAxis: FlipAxis.x,
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
                                              child: LottieBuilder.network(
                                                  'https://assets7.lottiefiles.com/private_files/lf30_ggnpo3y5.json'),
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
                                        TextWrapper(
                                            text:
                                                value.historyList[index].body ??
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
                      ),
                    );
                  },
                ),
              ),
            ),
    );
  }
}
