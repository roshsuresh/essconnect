import 'dart:developer';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:essconnect/utils/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../Application/StudentProviders/NoticProvider.dart';
import '../../Application/StudentProviders/NotificationCountProviders.dart';
import '../../Constants.dart';
import '../../utils/TextWrap(moreOption).dart';
import '../../utils/constants.dart';

class NoticeBoard extends StatelessWidget {
  const NoticeBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var p = Provider.of<NoticeProvider>(context,
          listen: false);

      await p.getnoticeList();
      await Provider.of<NoticeProvider>(context, listen: false)
          .seeNoticeBoard();
      await Provider.of<StudNotificationCountProviders>(context, listen: false)
          .getnotificationCount();
    });
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   Provider.of<NoticeProvider>(context, listen: false).getnoticeList();
    //   Provider.of<NoticeProvider>(context, listen: false).seeNoticeBoard();
    //    Provider.of<StudNotificationCountProviders>(context, listen: false)
    //       .getnotificationCount();
    // });
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notice Board',
        ),
        titleSpacing: 00.0,
        centerTitle: true,
        toolbarHeight: 60.2,
        toolbarOpacity: 0.8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(25),
            bottomLeft: Radius.circular(25),
          ),
        ),
        backgroundColor: UIGuide.light_Purple,
      ),
      body: Consumer<NoticeProvider>(
        builder: (_, value, child) {
          return value.loading
              ? spinkitLoader()
              : noticeresponse == null || noticeresponse!.isEmpty
              ? Container(
            child: LottieBuilder.network(
                'https://assets2.lottiefiles.com/private_files/lf30_lkquf6qz.json'),
          )
              : AnimationLimiter(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              itemCount:
              noticeresponse == null ? 0 : noticeresponse!.length,
              itemBuilder: (BuildContext context, int index) {
                //created date
                String finalCreatedDate = "";

                if (noticeresponse![index]['entryDate'] != null) {
                  String createddate =
                      noticeresponse![index]['entryDate'] ?? '--';
                  DateTime parsedDateTime =
                  DateTime.parse(createddate);
                  finalCreatedDate = DateFormat('dd-MMM-yyyy')
                      .format(parsedDateTime);
                }

                var noticeattach = noticeresponse![index]['noticeId'];
                return AnimationConfiguration.staggeredList(
                  position: index,
                  delay: const Duration(milliseconds: 100),
                  child: SlideAnimation(
                    duration: const Duration(milliseconds: 2500),
                    curve: Curves.fastLinearToSlowEaseIn,
                    child: FadeInAnimation(
                      curve: Curves.fastLinearToSlowEaseIn,
                      duration: const Duration(milliseconds: 2500),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 6.0, right: 6, bottom: 3, top: 3),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(
                                255, 234, 234, 236),
                            border: Border.all(
                              color: const Color.fromARGB(
                                  255, 136, 187, 235),
                            ),
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                            ),
                          ),
                          width: size.width,
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Container(
                              width: size.width - 4,
                              decoration: const BoxDecoration(
                                  color: Color.fromARGB(
                                      255, 255, 255, 255),
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20),
                                      bottomLeft:
                                      Radius.circular(20))),
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                      const EdgeInsets.all(4.0),
                                      child: Row(
                                        children: [
                                          const Text('📌  '),
                                          Flexible(
                                            child: RichText(
                                              overflow: TextOverflow
                                                  .ellipsis,
                                              maxLines: 2,
                                              strutStyle:
                                              const StrutStyle(
                                                  fontSize: 14.0),
                                              text: TextSpan(
                                                style: const TextStyle(
                                                    color: UIGuide
                                                        .light_Purple,
                                                    fontWeight:
                                                    FontWeight
                                                        .w500),
                                                text: noticeresponse![
                                                index]
                                                [
                                                'title'] ==
                                                    null
                                                    ? '---'
                                                    : noticeresponse![
                                                index]
                                                ['title']
                                                    .toString(),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    kheight10,
                                    TextWrapper(
                                      text: noticeresponse![index]
                                      ['matter'] ==
                                          null
                                          ? '------'
                                          : noticeresponse![index]
                                      ['matter']
                                          .toString(),
                                      fSize: 16,
                                    ),
                                    kheight10,
                                    Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .spaceEvenly,
                                      children: [
                                        kWidth,
                                        Text(
                                          finalCreatedDate,
                                          style: const TextStyle(
                                              fontSize: 12),
                                        ),
                                        const Spacer(),
                                        Row(
                                          children: [
                                            const Text(
                                              'Sent by: ',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12),
                                            ),
                                            Text(
                                              noticeresponse![index][
                                              'staffName'] ==
                                                  null
                                                  ? '--'
                                                  : noticeresponse![
                                              index][
                                              'staffName']
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontSize: 12),
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        GestureDetector(
                                          onTap: () async {
                                            var newProvider =
                                            await Provider.of<
                                                NoticeProvider>(
                                                context,
                                                listen: false)
                                                .noticeAttachement(
                                                noticeattach);
                                            if (value.extension
                                                .toString() ==
                                                '.pdf') {
                                              final result = value.url
                                                  .toString();
                                              final name = value.name
                                                  .toString();

                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      PDFDownload(),
                                                ),
                                              );
                                            } else {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        PdfViewPage()),
                                              );
                                            }
                                          },
                                          child: Container(
                                            height: 25,
                                            width: 25,
                                            child: LottieBuilder.network(
                                                "https://assets2.lottiefiles.com/temp/lf20_D0nz3r.json") ==
                                                null
                                                ? Icon(Icons
                                                .remove_red_eye_outlined)
                                                : LottieBuilder.network(
                                                "https://assets2.lottiefiles.com/temp/lf20_D0nz3r.json"),
                                          ),
                                        ),
                                        kWidth,
                                      ],
                                    )
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
          );
        },
      ),
    );
  }
}

class PDFDownload extends StatefulWidget {
  PDFDownload({
    Key? key,
  }) : super(key: key);
  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort send =
    IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
  }

  @override
  State<PDFDownload> createState() => _PDFDownloadState();
}

class _PDFDownloadState extends State<PDFDownload> {
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

  Future<void> requestDownload(String _url, String _name) async {
    var _localPath;

    if (Platform.isAndroid) {
      _localPath = '/storage/emulated/0/Download';
    } else if (Platform.isIOS) {
      final dir = await getApplicationDocumentsDirectory();
      _localPath = dir.path;
    }
    print("pathhhh  $_localPath");
    final savedDir = Directory(_localPath);
    await savedDir.create(recursive: true).then((value) async {
      String? _taskid = await FlutterDownloader.enqueue(
        savedDir: _localPath,
        url: _url,
        fileName: _name,
        showNotification: true,
        openFileFromNotification: true,
      );

      print(_taskid);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NoticeProvider>(
      builder: (context, value, child) => Scaffold(
          appBar: AppBar(
            title: const Text(''),
            titleSpacing: 00.0,
            centerTitle: true,
            toolbarHeight: 50.2,
            toolbarOpacity: 0.8,
            backgroundColor: UIGuide.light_Purple,
            actions: [
              Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: IconButton(
                      onPressed: () async {
                        await requestDownload(
                          value.url == null ? '--' : value.url.toString(),
                          value.idd == null
                              ? '---'
                              : value.idd.toString() + value.name.toString(),
                        );
                      },
                      icon: const Icon(Icons.download_outlined))),
            ],
          ),
          body: SfPdfViewer.network(
            value.url == null ? '--' : value.url.toString(),
          )),
    );
  }
}

class PdfViewPage extends StatefulWidget {
  PdfViewPage({Key? key}) : super(key: key);
  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort send =
    IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
  }

  @override
  State<PdfViewPage> createState() => _PdfViewPageState();
}

class _PdfViewPageState extends State<PdfViewPage> {
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

  Future<void> requestDownload(String _url, String _name) async {
    var _localPath;

    if (Platform.isAndroid) {
      _localPath = '/storage/emulated/0/Download';
    } else if (Platform.isIOS) {
      final dir = await getApplicationDocumentsDirectory();
      _localPath = dir.path;
    }
    print("pathhhh  $_localPath");
    final savedDir = Directory(_localPath);
    await savedDir.create(recursive: true).then((value) async {
      String? _taskid = await FlutterDownloader.enqueue(
        savedDir: _localPath,
        url: _url,
        fileName: " $_name",
        showNotification: true,
        openFileFromNotification: true,
      );
      log("nweurlll $_url");

      print(_taskid);
    });
  }

  bool isLoading = false;

  imageview(String result, String name) {
    return Scaffold(
      backgroundColor: UIGuide.WHITE,
      appBar: AppBar(
        title: const Text('Notice Board'),
        titleSpacing: 00.0,
        centerTitle: true,
        toolbarHeight: 50.2,
        toolbarOpacity: 0.8,
        backgroundColor: UIGuide.light_Purple,
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: IconButton(
                  onPressed: () async {
                    await requestDownload(
                      result == null ? '--' : result.toString(),
                      name == null ? '---' : name.toString(),
                    );
                  },
                  icon: const Icon(Icons.download_outlined))),
        ],
      ),
      body: isLoading
          ? spinkitLoader()
          : Center(
        child: Container(
            child: PhotoView(
              backgroundDecoration: BoxDecoration(color: UIGuide.WHITE),
              loadingBuilder: (context, event) {
                return spinkitLoader();
              },
              imageProvider: NetworkImage(
                result == null
                    ? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSlmeGlXoJwwpbCE9jGgHgZ2XaE5nnPUSomkZz_vZT7&s'
                    : result.toString(),
              ),
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NoticeProvider>(builder: (context, provider, _) {
      if (provider.extension.toString() == '.jpg') {
        final imgResult = provider.url.toString();
        final name = provider.name.toString();
        return imageview(imgResult, name);
      } else if (provider.extension.toString() == '.png') {
        final imgResult2 = provider.url.toString();
        final name = provider.name.toString();
        return imageview(imgResult2, name);
      } else if (provider.extension.toString() == '.jpeg') {
        final imgResult3 = provider.url.toString();
        final name = provider.name.toString();
        return imageview(imgResult3, name);
      } else if (provider.extension.toString() == '.jfif') {
        final imgResult4 = provider.url.toString();
        final name = provider.name.toString();
        return imageview(imgResult4, name);
      } else {
        return const Scaffold(
          body: Center(
            child: Text(
              'No Attachment ',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ),
        );
      }
    });
  }
}
