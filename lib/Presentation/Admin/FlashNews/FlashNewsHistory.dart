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
                  String finalCreatedDate = "";

                  if (provider.flashlist[index].createdAt != null) {
                    String createddate =
                        provider.flashlist[index].createdAt ?? '--';
                    DateTime parsedDateTime = DateTime.parse(createddate);
                    finalCreatedDate =
                        DateFormat('dd/MMM/yyyy').format(parsedDateTime);
                  }

                  //start date
                  String finalStartDate = "";

                  if (provider.flashlist[index].startDate != null) {
                    String createddate =
                        provider.flashlist[index].startDate ?? '--';
                    DateTime parsedDateTime = DateTime.parse(createddate);
                    finalStartDate =
                        DateFormat('dd/MMM/yyyy').format(parsedDateTime);
                  }

                  //end date
                  String finalendDate = "";

                  if (provider.flashlist[index].endDate != null) {
                    String createddate =
                        provider.flashlist[index].endDate ?? '--';
                    DateTime parsedDateTime = DateTime.parse(createddate);
                    finalendDate =
                        DateFormat('dd/MMM/yyyy').format(parsedDateTime);
                  }

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
                                    String event =
                                        provider.flashlist[index].id.toString();
                                    await provider.flashnewsDelete(
                                        event, context, index);

                                    // provider.flashlist.clear();
                                    // await provider.getFlashnewsList();
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: UIGuide.THEME_LIGHT),
                                        color: const Color.fromARGB(
                                            255, 236, 239, 253),
                                        borderRadius: const BorderRadius.only(
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10))),
                                    child: const Padding(
                                      padding: EdgeInsets.only(
                                          left: 8, right: 8, top: 3, bottom: 2),
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
                                const Text('News: '),
                                Flexible(
                                  child: Text(
                                    provider.flashlist[index].news ?? '--',
                                    overflow: TextOverflow.clip,
                                    maxLines: 5,
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
                            padding: const EdgeInsets.only(
                                left: 5, top: 5, bottom: 5),
                            child: Row(
                              children: [
                                const Text('End Date: '),
                                Flexible(
                                  child: Text(
                                    finalendDate.isEmpty ? '--' : finalendDate,
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
                  );
                },
              );
      },
    );
  }
}
