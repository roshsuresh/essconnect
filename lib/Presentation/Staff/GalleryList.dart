import 'package:essconnect/Application/Staff_Providers/GallerySendProviderStaff.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:essconnect/utils/spinkit.dart';
import 'package:flutter/material.dart';
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
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: size.width,
                          // height: 100,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: UIGuide.light_Purple, width: 1),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const Text('Created Date: '),
                                    Text(
                                      provider.galleryViewList[index]
                                              .createdAt ??
                                          '--',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13),
                                    ),
                                    const Spacer(),
                                    GestureDetector(
                                      onTap: () async {
                                        String event = provider
                                            .galleryViewList[index].id
                                            .toString();
                                        await provider.galleryDeleteStaff(
                                            context, event, index);

                                        // provider.galleryViewList.clear();

                                        // await provider
                                        //     .galleryViewListStaff(context);
                                      },
                                      child: const Icon(
                                        Icons.delete_forever_outlined,
                                        color: Colors.red,
                                      ),
                                    )
                                  ],
                                ),
                                Row(
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
                                Row(
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
                                Consumer<GallerySendProvider_Stf>(
                                  builder: (context, value, child) {
                                    if (value.galleryViewList[index].approved ==
                                            true &&
                                        value.galleryViewList[index]
                                                .cancelled ==
                                            false) {
                                      return Row(
                                        children: const [
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
                                      );
                                    } else if (value.galleryViewList[index]
                                                .approved ==
                                            false &&
                                        value.galleryViewList[index]
                                                .cancelled ==
                                            true) {
                                      return Row(
                                        children: const [
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
                                      );
                                    } else {
                                      return Row(
                                        children: const [
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
                                      );
                                    }
                                  },
                                  child: Row(
                                    children: const [
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
