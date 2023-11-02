import 'package:essconnect/Application/AdminProviders/GalleryProviders.dart';
import 'package:essconnect/Constants.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:essconnect/utils/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class GalleryListAdmin extends StatelessWidget {
  const GalleryListAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var p = Provider.of<GalleryProviderAdmin>(context, listen: false);
      p.galleryViewListAdmin();
      p.galleryViewList.clear();
    });
    var size = MediaQuery.of(context).size;
    return Consumer<GalleryProviderAdmin>(
      builder: (context, provider, child) {
        return provider.loading
            ? spinkitLoader()
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
                      // height: 99,
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
                                  finalCreatedDate,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13),
                                ),
                                const Spacer(),
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: UIGuide.THEME_LIGHT),
                                      color: const Color.fromARGB(
                                          255, 236, 239, 253),
                                      borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(9),
                                          bottomLeft: Radius.circular(10))),
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                          await provider.clearPhotoList();
                                          String eventt = provider
                                              .galleryViewList[index].id
                                              .toString();
                                          await provider.galleryEdit(eventt);
                                          provider.load
                                              ? spinkitLoader()
                                              : showModalBottomSheet(
                                                  context: context,
                                                  isScrollControlled: true,
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft: Radius
                                                                .circular(30),
                                                            topRight:
                                                                Radius.circular(
                                                                    30)),
                                                  ),
                                                  builder: (_) {
                                                    //created date
                                                    String fCreatedDate = "";

                                                    if (provider.entryDate !=
                                                        null) {
                                                      String createddate =
                                                          provider.entryDate ??
                                                              '--';
                                                      DateTime parsedDateTime =
                                                          DateTime.parse(
                                                              createddate);
                                                      fCreatedDate = DateFormat(
                                                              'dd/MMM/yyyy')
                                                          .format(
                                                              parsedDateTime);
                                                    }
                                                    //start date
                                                    String fStartDate = "";

                                                    if (provider
                                                            .displayStartDate !=
                                                        null) {
                                                      String createddate = provider
                                                              .displayStartDate ??
                                                          '--';
                                                      DateTime parsedDateTime =
                                                          DateTime.parse(
                                                              createddate);
                                                      fStartDate = DateFormat(
                                                              'dd/MMM/yyyy')
                                                          .format(
                                                              parsedDateTime);
                                                    }

                                                    //End date
                                                    String fEndDate = "";

                                                    if (provider
                                                            .displayEndDate !=
                                                        null) {
                                                      String createddate = provider
                                                              .displayEndDate ??
                                                          '--';
                                                      DateTime parsedDateTime =
                                                          DateTime.parse(
                                                              createddate);
                                                      fEndDate = DateFormat(
                                                              'dd/MMM/yyyy')
                                                          .format(
                                                              parsedDateTime);
                                                    }
                                                    return Container(
                                                      child:
                                                          SingleChildScrollView(
                                                        scrollDirection:
                                                            Axis.vertical,
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: SizedBox(
                                                                width:
                                                                    size.width /
                                                                        2.5,
                                                                child:
                                                                    const Divider(
                                                                  thickness: 5,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          188,
                                                                          189,
                                                                          190),
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Row(
                                                                children: [
                                                                  const Text(
                                                                    'Entry Date: ',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: UIGuide
                                                                            .light_Purple),
                                                                  ),
                                                                  Text(
                                                                    fCreatedDate,
                                                                    style:
                                                                        const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          16,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Row(
                                                                children: [
                                                                  const Text(
                                                                    'Title: ',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: UIGuide
                                                                            .light_Purple),
                                                                  ),
                                                                  Flexible(
                                                                    child:
                                                                        RichText(
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      strutStyle:
                                                                          const StrutStyle(
                                                                              fontSize: 13),
                                                                      maxLines:
                                                                          2,
                                                                      text: TextSpan(
                                                                          style: const TextStyle(
                                                                              fontSize:
                                                                                  15,
                                                                              color: Color.fromARGB(255, 44, 43,
                                                                                  43)),
                                                                          text: provider.title ??
                                                                              '--'),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            provider.load
                                                                ? spinkitLoader()
                                                                : GridView
                                                                    .count(
                                                                        shrinkWrap:
                                                                            true,
                                                                        physics:
                                                                            const NeverScrollableScrollPhysics(),
                                                                        crossAxisCount:
                                                                            4,
                                                                        crossAxisSpacing:
                                                                            4.0,
                                                                        mainAxisSpacing:
                                                                            8.0,
                                                                        children: List.generate(
                                                                            provider.galleryList.isEmpty
                                                                                ? 0
                                                                                : provider.galleryList.length,
                                                                            (index) {
                                                                          return Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(2.0),
                                                                            child:
                                                                                Card(
                                                                              child: Image(
                                                                                image: NetworkImage(provider.galleryList[index].file ?? 'https://4.bp.blogspot.com/-OCutvC4wPps/XfNnRz5PvhI/AAAAAAAAEfo/qJ8P1sqLWesMdOSiEoUH85s3hs_vn97HACLcBGAsYHQ/s1600/no-image-found-360x260.png'),
                                                                                fit: BoxFit.cover,
                                                                              ),
                                                                            ),
                                                                          );
                                                                        })),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Row(
                                                                children: [
                                                                  const Text(
                                                                    'Start Date: ',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: UIGuide
                                                                            .light_Purple),
                                                                  ),
                                                                  Text(
                                                                    fStartDate,
                                                                    style:
                                                                        const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          16,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Row(
                                                                children: [
                                                                  const Text(
                                                                    'End Date: ',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: UIGuide
                                                                            .light_Purple),
                                                                  ),
                                                                  Text(
                                                                    fEndDate,
                                                                    style:
                                                                        const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          16,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  MaterialButton(
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8.0),
                                                                      side: const BorderSide(
                                                                          color:
                                                                              UIGuide.light_Purple),
                                                                    ),
                                                                    onPressed:
                                                                        () async {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    color: UIGuide
                                                                        .ButtonBlue,
                                                                    child: const Text(
                                                                        'Cancel'),
                                                                  ),
                                                                  kWidth,
                                                                  MaterialButton(
                                                                    onPressed:
                                                                        () async {
                                                                      await provider.galleryAproove(
                                                                          context,
                                                                          eventt);
                                                                      Navigator.pop(
                                                                          context);
                                                                      provider
                                                                          .galleryViewList
                                                                          .clear();
                                                                      await provider
                                                                          .galleryViewListAdmin();
                                                                    },
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8.0),
                                                                      side: const BorderSide(
                                                                          color:
                                                                              UIGuide.light_Purple),
                                                                    ),
                                                                    color: UIGuide
                                                                        .light_Purple,
                                                                    child:
                                                                        const Text(
                                                                      'Approve',
                                                                      style: TextStyle(
                                                                          color:
                                                                              UIGuide.WHITE),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  });
                                        },
                                        child: const Padding(
                                          padding: EdgeInsets.only(
                                              left: 8,
                                              right: 8,
                                              top: 3,
                                              bottom: 2),
                                          child: Icon(
                                            Icons.mode_edit_outline_outlined,
                                            color: UIGuide.light_Purple,
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          String event = provider
                                              .galleryViewList[index].id
                                              .toString();
                                          await provider.galleryDelete(
                                              event, context, index);
                                        },
                                        child: const Padding(
                                          padding: EdgeInsets.only(
                                              left: 8,
                                              right: 8,
                                              top: 3,
                                              bottom: 2),
                                          child: Icon(
                                            Icons.delete_forever_outlined,
                                            color: Colors.red,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
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
                          Consumer<GalleryProviderAdmin>(
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
                              } else if (value
                                          .galleryViewList[index].approved ==
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
                              padding:
                                  EdgeInsets.only(left: 5, top: 5, bottom: 5),
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
