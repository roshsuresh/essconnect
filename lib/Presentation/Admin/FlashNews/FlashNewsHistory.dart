import 'package:essconnect/Application/AdminProviders/FlashNewsProviders.dart';
import 'package:essconnect/Constants.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:essconnect/utils/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FlashNewsHistory extends StatelessWidget {
  const FlashNewsHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var p = Provider.of<FlashNewsProviderAdmin>(context, listen: false);
      p.flashlist.clear();
      p.getFlashnewsList();
    });
    var size = MediaQuery.of(context).size;
    return Consumer<FlashNewsProviderAdmin>(
      builder: (context, provider, child) {
        return provider.loading
            ? spinkitLoader()
            : ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount:
                    provider.flashlist.isEmpty ? 0 : provider.flashlist.length,
                itemBuilder: (context, index) {
                  //created date
                  String createddate =
                      provider.flashlist[index].createdAt ?? '--';
                  var updatedDate = DateFormat('yyyy-MM-dd').parse(createddate);
                  String newDate = updatedDate.toString();
                  String finalCreatedDate = newDate.replaceRange(10, 23, '');

                  //start date
                  String startdate =
                      provider.flashlist[index].startDate ?? '--';
                  var updateStartDate =
                      DateFormat('yyyy-MM-dd').parse(startdate);
                  String newstartDate = updateStartDate.toString();
                  String finalStartDate = newstartDate.replaceRange(10, 23, '');

                  //end date

                  String enddate = provider.flashlist[index].endDate ?? '--';
                  var updateendDate = DateFormat('yyyy-MM-dd').parse(enddate);
                  String newendDate = updateendDate.toString();
                  String finalendDate = newendDate.replaceRange(10, 23, '');

                  ////
                  String even = provider.flashlist[index].id.toString();
                  ////
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: size.width,
                      height: 105,
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: UIGuide.light_Purple, width: 1),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Row(
                                children: [
                                  const Text('Created Date: '),
                                  Text(
                                    finalCreatedDate.isEmpty
                                        ? '--'
                                        : finalCreatedDate,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13),
                                  ),
                                  const Spacer(),
                                  kWidth,
                                  GestureDetector(
                                    onTap: () async {
                                      String event = provider
                                          .flashlist[index].id
                                          .toString();
                                      await provider.flashnewsDelete(
                                          event, context, index);

                                      // provider.flashlist.clear();
                                      // await provider.getFlashnewsList();
                                    },
                                    child: Container(
                                      width: 40,
                                      color: Colors.transparent,
                                      child: const Icon(
                                        Icons.delete_forever_outlined,
                                        color: Colors.red,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Row(
                                children: [
                                  const Text('News: '),
                                  Flexible(
                                    child: Text(
                                      provider.flashlist[index].news ?? '--',
                                      overflow: TextOverflow.clip,
                                      maxLines: 1,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Row(
                                children: [
                                  const Text('Start Date: '),
                                  Flexible(
                                    child: Text(
                                      finalStartDate.isEmpty
                                          ? '--'
                                          : finalStartDate,
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
                              padding: const EdgeInsets.all(2.0),
                              child: Row(
                                children: [
                                  const Text('End Date: '),
                                  Flexible(
                                    child: Text(
                                      finalendDate.isEmpty
                                          ? '--'
                                          : finalendDate,
                                      overflow: TextOverflow.clip,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13),
                                    ),
                                  )
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
