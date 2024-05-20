import 'package:essconnect/Constants.dart';
import 'package:essconnect/Presentation/Staff/GalleryReceived.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../Application/Staff_Providers/GallerySendProviderStaff.dart';
import '../../utils/spinkit.dart';

class GalleryReceivedSAdmin extends StatelessWidget {
  const GalleryReceivedSAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var p =
          Provider.of<GallerySendProvider_Stf>(context, listen: false);
      p.galleryReceived.clear();
      await p.getGalleyReceived();
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gallery'),
        titleSpacing: 00.0,
        centerTitle: true,
        toolbarHeight: 60.2,
        toolbarOpacity: 0.8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
        ),
        backgroundColor: UIGuide.light_Purple,
      ),
      body: Consumer<GallerySendProvider_Stf>(
        builder: (context, value, child) => value.loading
            ? spinkitLoader()
            : ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  value.galleryReceived.isEmpty
                      ? Center(
                          child: Container(
                            child: LottieBuilder.network(
                                'https://assets2.lottiefiles.com/private_files/lf30_lkquf6qz.json'),
                          ),
                        )
                      : ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: value.galleryReceived.isEmpty
                              ? 0
                              : value.galleryReceived.length,
                          itemBuilder: ((context, index) {
                            var idd =
                                value.galleryReceived[index].galleryId ?? '--';
                            return Consumer<GallerySendProvider_Stf>(
                              builder: (context, value, child) {
                                return Column(
                                  children: [
                                    kheight20,
                                    GestureDetector(
                                      child: Container(
                                        height: 120,
                                        width: size.width - 30,
                                        decoration: const BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              offset: Offset(2, 6),
                                              blurRadius: 20,
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 0.16),
                                            )
                                          ],
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(0),
                                              bottomRight:
                                                  Radius.circular(40.0),
                                              topLeft: Radius.circular(40.0),
                                              bottomLeft: Radius.circular(0.0)),
                                        ),
                                        child: Row(
                                          children: [
                                            kWidth,
                                            Center(
                                                child: Container(
                                              width: 120,
                                              height: 100,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                      value
                                                              .galleryReceived[
                                                                  index]
                                                              .url ??
                                                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQgOinP1I4DJR8UXKbif9pXj4UTa1dar-CfGBr4mmSXNfOySMXxPfwa023_n0gvkdK4mig&usqp=CAU',
                                                    ),
                                                    fit: BoxFit.fill),
                                                color: Colors.white12,
                                                border: Border.all(
                                                    color: const Color.fromARGB(
                                                        255, 219, 215, 215)),
                                                borderRadius: const BorderRadius
                                                    .only(
                                                    topRight:
                                                        Radius.circular(0),
                                                    bottomRight:
                                                        Radius.circular(40.0),
                                                    topLeft:
                                                        Radius.circular(40.0),
                                                    bottomLeft:
                                                        Radius.circular(0.0)),
                                              ),
                                            )),
                                            kWidth,
                                            Expanded(
                                              child: SizedBox(
                                                  height: 110,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        value
                                                                .galleryReceived[
                                                                    index]
                                                                .title ??
                                                            '---',
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 12),
                                                        maxLines: 2,
                                                      ),
                                                      kheight10,
                                                      Text(
                                                        value
                                                                .galleryReceived[
                                                                    index]
                                                                .caption ??
                                                            '',
                                                        maxLines: 3,
                                                      ),
                                                      kheight10,
                                                    ],
                                                  )),
                                            )
                                          ],
                                        ),
                                      ),
                                      onTap: () async {
                                        await Provider.of<
                                                    GallerySendProvider_Stf>(
                                                context,
                                                listen: false)
                                            .galleyAttachment(idd);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  GalleryonTapStaff(id: idd)),
                                        );
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          })),
                ],
              ),
      ),
    );
  }
}
