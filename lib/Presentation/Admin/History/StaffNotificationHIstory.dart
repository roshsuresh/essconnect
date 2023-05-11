import 'package:essconnect/Application/AdminProviders/NotificationStaff.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:essconnect/utils/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
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
                            padding: const EdgeInsets.all(4.0),
                            child: LimitedBox(
                              maxHeight: 100,
                              child: Container(
                                width: size.width,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        color: UIGuide.light_Purple)),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          width: 3,
                                        ),
                                        const Text(
                                          'Title: ',
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          width: 3,
                                        ),
                                        const Text(
                                          'Matter: ',
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
                                              text: value.historyList[index]
                                                      .body ??
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          const Text(
                                            'Created: ',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: UIGuide.light_Purple),
                                          ),
                                          Text(
                                            value.historyList[index]
                                                    .createdDate ??
                                                '--',
                                          ),
                                          const SizedBox(
                                            width: 6,
                                          )
                                        ],
                                      ),
                                    )
                                  ],
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
