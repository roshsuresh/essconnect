import 'dart:developer';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:essconnect/Application/Staff_Providers/GallerySendProviderStaff.dart';
import 'package:essconnect/Constants.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:essconnect/utils/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';

class StaffGalleryView extends StatelessWidget {
  const StaffGalleryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var p = Provider.of<GallerySendProvider_Stf>(context, listen: false);
      p.galleryReceived.clear();
      p.getGalleyReceived();
    });
    return Consumer<GallerySendProvider_Stf>(
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
                                            bottomRight: Radius.circular(40.0),
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
                                                    value.galleryReceived[index]
                                                            .url ??
                                                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQgOinP1I4DJR8UXKbif9pXj4UTa1dar-CfGBr4mmSXNfOySMXxPfwa023_n0gvkdK4mig&usqp=CAU',
                                                  ),
                                                  fit: BoxFit.fill),
                                              color: Colors.white12,
                                              border: Border.all(
                                                  color: const Color.fromARGB(
                                                      255, 219, 215, 215)),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(40),
                                                      bottomRight:
                                                          Radius.circular(40),
                                                      topRight:
                                                          Radius.circular(0),
                                                      bottomLeft:
                                                          Radius.circular(0)),
                                            ),
                                          )),
                                          kWidth,
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  value.galleryReceived[index]
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
                                                  value.galleryReceived[index]
                                                                  .caption ==
                                                              null ||
                                                          value
                                                                  .galleryReceived[
                                                                      index]
                                                                  .caption ==
                                                              "null"
                                                      ? ''
                                                      : value
                                                          .galleryReceived[
                                                              index]
                                                          .caption
                                                          .toString(),
                                                  maxLines: 3,
                                                ),
                                                kheight10,
                                              ],
                                            ),
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
                                      await Navigator.push(
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
    );
  }
}

class GalleryonTapStaff extends StatelessWidget {
  GalleryonTapStaff({Key? key, required String id}) : super(key: key);
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gallery'),
        titleSpacing: 00.0,
        centerTitle: true,
        toolbarHeight: 50.2,
        toolbarOpacity: 0.8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
        ),
        backgroundColor: UIGuide.light_Purple,
      ),
      body: Consumer<GallerySendProvider_Stf>(
        builder: (context, value, child) => value.load
            ? spinkitLoader()
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.count(
                  crossAxisCount: 3,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 4,
                  children: List.generate(
                      value.galleryAttachResponse == null
                          ? 0
                          : value.galleryAttachResponse!.length, (index) {
                    return GestureDetector(
                      child: isLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : Container(
                              height: 100,
                              width: 50,
                              decoration: BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          value.galleryAttachResponse![index]
                                                  ['url'] ??
                                              const AssetImage(
                                                  'assets/noimages.png')))),
                            ),
                      onTap: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewImageOntapStaff(
                                    currentIndex: index,
                                  )),
                        );
                      },
                    );
                  }),
                ),
              ),
      ),
    );
  }
}

class ViewImageOntapStaff extends StatefulWidget {
  late int currentIndex;
  ViewImageOntapStaff({Key? key, required this.currentIndex}) : super(key: key);
  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
  }

  @override
  State<ViewImageOntapStaff> createState() => _ViewImageOntapStaffState();
}

class _ViewImageOntapStaffState extends State<ViewImageOntapStaff> {
  final ReceivePort _port = ReceivePort();
  @override
  void initState() {
    super.initState();

    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];

      setState(() {});
    });

    FlutterDownloader.registerCallback(downloadCallback);
  }

  static void downloadCallback(String id, int status, int progress) {
    print('Download task ($id) is in status ($status) and $progress% complete');
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  Future<void> requestDownload(String url, String name) async {
    final dir = await getApplicationDocumentsDirectory();
    String? localPath;

    //dir!.path;

    // Directory downloadsDir;

    // Check platform
    if (Platform.isAndroid) {
      localPath = '/storage/emulated/0/Download';
    } else if (Platform.isIOS) {
      final dir = await getApplicationDocumentsDirectory();
      localPath = dir.path;
    }
    print("pathhhh  $localPath");
    final savedDir = Directory(localPath!);
    await savedDir.create(recursive: true).then((value) async {
      String? taskid = await FlutterDownloader.enqueue(
        savedDir: localPath!,
        url: url,
        fileName: "image $name.jpeg",
        showNotification: true,
        openFileFromNotification: true,
      );
      log("nweurlll $url");

      print(taskid);
    });
  }

  bool isLoading = false;

  void onPageChanged(int index) {
    setState(() {
      widget.currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GallerySendProvider_Stf>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: const Text('Gallery'),
          titleSpacing: 00.0,
          centerTitle: true,
          toolbarHeight: 50.2,
          toolbarOpacity: 0.8,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(25),
                bottomLeft: Radius.circular(25)),
          ),
          backgroundColor: UIGuide.light_Purple,
          actions: [
            Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: IconButton(
                    onPressed: () async {
                      await requestDownload(
                        value.galleryAttachResponse![widget.currentIndex]
                                    ['url'] ==
                                null
                            ? '--'
                            : value.galleryAttachResponse![widget.currentIndex]
                                    ['url']
                                .toString(),
                        value.id == null
                            ? '--- ${widget.currentIndex}'
                            : '${value.id}${widget.currentIndex}',
                      );
                    },
                    icon: const Icon(Icons.download_outlined))),
          ],
        ),
        body: PhotoViewGallery.builder(
            backgroundDecoration: const BoxDecoration(color: UIGuide.WHITE),
            scrollPhysics: const BouncingScrollPhysics(),
            enableRotation: false,
            onPageChanged: onPageChanged,
            itemCount: value.galleryAttachResponse!.isEmpty
                ? 0
                : value.galleryAttachResponse!.length,
            builder: ((context, inde) {
              final imgUrl =
                  value.galleryAttachResponse![widget.currentIndex]['url'];
              return PhotoViewGalleryPageOptions(
                  imageProvider: NetworkImage(
                      imgUrl ?? const AssetImage('assets/noimages.png')),
                  initialScale: PhotoViewComputedScale.contained * 0.8,
                  heroAttributes: PhotoViewHeroAttributes(
                      tag: value.galleryAttachResponse![widget.currentIndex]
                          ['url']));
            }),
            loadingBuilder: (context, event) => spinkitLoader()),
      ),
    );
  }
}
