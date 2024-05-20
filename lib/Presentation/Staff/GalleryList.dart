import 'package:essconnect/Application/Staff_Providers/GallerySendProviderStaff.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:essconnect/utils/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class GalleryListStaff extends StatelessWidget {
  const GalleryListStaff({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var p = Provider.of<GallerySendProvider_Stf>(context, listen: false);
      p.galleryViewList.clear();
      await p.galleryViewListStaff(context);
    });
    var size = MediaQuery.of(context).size;
    return Consumer<GallerySendProvider_Stf>(
      builder: (context, provider, child) {
        return provider.loading
            ? spinkitLoader()
            : provider.galleryViewList.isEmpty
                ? Center(
                    child: Container(
                      child: LottieBuilder.network(
                          'https://assets2.lottiefiles.com/private_files/lf30_lkquf6qz.json'),
                    ),
                  )
                : ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: provider.galleryViewList.isEmpty
                        ? 0
                        : provider.galleryViewList.length,
                    itemBuilder: (context, index) {
                      //created date
                      String finalCreatedDate = "";

                      if (provider.galleryViewList[index].createdAt != null) {
                        String createddate =
                            provider.galleryViewList[index].createdAt ?? '--';
                        DateTime parsedDateTime = DateTime.parse(createddate);
                        finalCreatedDate =
                            DateFormat('dd/MMM/yyyy').format(parsedDateTime);
                      }
                      return Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Container(
                          width: size.width,
                          // height: 100,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: UIGuide.light_Purple, width: 1),
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
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
                                            .galleryViewList[index].id
                                            .toString();
                                        await provider.galleryDeleteStaff(
                                            context, event, index);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: UIGuide.THEME_LIGHT),
                                            color: const Color.fromARGB(
                                                255, 236, 239, 253),
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
                                        provider.galleryViewList[index].title ??
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
                                padding: const EdgeInsets.only(left: 5, top: 5),
                                child: Row(
                                  children: [
                                    const Text('Created By: '),
                                    Flexible(
                                      child: Text(
                                        provider.galleryViewList[index]
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
                              Consumer<GallerySendProvider_Stf>(
                                builder: (context, value, child) {
                                  if (value.galleryViewList[index].approved ==
                                          true &&
                                      value.galleryViewList[index].cancelled ==
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
                                  } else if (value.galleryViewList[index]
                                              .approved ==
                                          false &&
                                      value.galleryViewList[index].cancelled ==
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
                    },
                  );
      },
    );
  }
}
