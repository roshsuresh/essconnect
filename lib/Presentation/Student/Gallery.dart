import 'dart:developer';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:essconnect/utils/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';
import '../../Application/StudentProviders/GalleryProvider.dart';
import '../../Constants.dart';
import '../../utils/constants.dart';

class Gallery extends StatefulWidget {
  const Gallery({Key? key}) : super(key: key);

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Provider.of<GalleryProvider>(context, listen: false)
          .getGalleyList(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

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
      body: Consumer<GalleryProvider>(
        builder: (context, value, child) => value.loading
            ? spinkitLoader()
            : galleryResponse == null || galleryResponse!.isEmpty
                ? Container(
                    child: LottieBuilder.network(
                        'https://assets2.lottiefiles.com/private_files/lf30_lkquf6qz.json'),
                  )
                : ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      LimitedBox(
                        maxHeight: size.height - 80,
                        child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: galleryResponse == null
                                ? 0
                                : galleryResponse!.length,
                            itemBuilder: ((context, index) {
                              var idd = galleryResponse![index]['galleryId'];

                              return Consumer<GalleryProvider>(
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
                                                color: Color.fromRGBO(
                                                    0, 0, 0, 0.16),
                                              )
                                            ],
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(0),
                                                bottomRight:
                                                    Radius.circular(40.0),
                                                topLeft: Radius.circular(40.0),
                                                bottomLeft:
                                                    Radius.circular(0.0)),
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
                                                        galleryResponse![index]
                                                                ['url'] ??
                                                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQgOinP1I4DJR8UXKbif9pXj4UTa1dar-CfGBr4mmSXNfOySMXxPfwa023_n0gvkdK4mig&usqp=CAU',
                                                      ),
                                                      fit: BoxFit.fill),
                                                  color: Colors.white12,
                                                  border: Border.all(
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              219,
                                                              215,
                                                              215)),
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                  0),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  40.0),
                                                          topLeft:
                                                              Radius.circular(
                                                                  40.0),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  0.0)),
                                                ),
                                              )),
                                              kWidth,
                                              Expanded(
                                                child: SizedBox(
                                                    // height: 110,
                                                    child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      galleryResponse![index]
                                                              ['title'] ??
                                                          '---',
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 12),
                                                      maxLines: 4,
                                                    ),
                                                    kheight10,
                                                    Text(
                                                      galleryResponse![index][
                                                                      'caption'] ==
                                                                  null ||
                                                              galleryResponse![
                                                                          index]
                                                                      [
                                                                      'caption'] ==
                                                                  "null"
                                                          ? ''
                                                          : galleryResponse![
                                                                      index]
                                                                  ['caption']
                                                              .toString(),
                                                      maxLines: 2,
                                                    ),
                                                    kheight10,
                                                  ],
                                                )),
                                              )
                                            ],
                                          ),
                                        ),
                                        onTap: () async {
                                          await Provider.of<GalleryProvider>(
                                                  context,
                                                  listen: false)
                                              .galleyAttachment(idd);

                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    GalleryonTap(id: idd)),
                                          );
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            })),
                      ),
                    ],
                  ),
      ),
    );
  }
}

class GalleryonTap extends StatelessWidget {
  GalleryonTap({Key? key, required String id}) : super(key: key);
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
      body: Consumer<GalleryProvider>(
        builder: (context, value, child) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.count(
            crossAxisCount: 3,
            mainAxisSpacing: 8,
            crossAxisSpacing: 4,
            children: List.generate(value.galleryList.length, (index) {
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
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                value.galleryList[index]['url'].toString(),
                              ),
                            )),
                      ),
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewImageOntap(
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

class ViewImageOntap extends StatefulWidget {
  late int currentIndex;
  ViewImageOntap({Key? key, required this.currentIndex}) : super(key: key);
  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
  }

  @override
  State<ViewImageOntap> createState() => _ViewImageOntapState();
}

class _ViewImageOntapState extends State<ViewImageOntap> {
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
    String? localPath;

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
    return Consumer<GalleryProvider>(
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
                    value.galleryList[widget.currentIndex]['url'] == null
                        ? '--'
                        : value.galleryList[widget.currentIndex]['url']
                            .toString(),
                    value.galleryList[widget.currentIndex]['title'] ?? '---${widget.currentIndex}',
                  );
                },
                icon: const Icon(Icons.download_outlined),
              ),
            ),
          ],
        ),
        body: PhotoViewGallery.builder(
          backgroundDecoration: const BoxDecoration(color: UIGuide.WHITE),
          scrollPhysics: const BouncingScrollPhysics(),
          enableRotation: false,
          onPageChanged: onPageChanged,
          itemCount: value.galleryList.isEmpty ? 0 : value.galleryList.length,
          builder: ((_, indee) {
            final imgUrl = value.galleryList[widget.currentIndex]['url'];

            return PhotoViewGalleryPageOptions(
              imageProvider: NetworkImage(
                imgUrl ?? const AssetImage('assets/noimages.png'),
              ),
              initialScale: PhotoViewComputedScale.contained * 0.8,
              heroAttributes: PhotoViewHeroAttributes(
                tag: value.galleryList[widget.currentIndex]['url'],
              ),
            );
          }),
          loadingBuilder: (context, event) => spinkitLoader(),
        ),
      ),
    );
  }
}
