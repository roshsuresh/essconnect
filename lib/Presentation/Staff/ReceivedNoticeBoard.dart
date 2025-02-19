import 'dart:developer';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:essconnect/Application/Staff_Providers/NoticeboardSend.dart';
import 'package:essconnect/Constants.dart';
import 'package:essconnect/utils/TextWrap(moreOption).dart';
import 'package:essconnect/utils/constants.dart';
import 'package:essconnect/utils/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class StaffNoticeBoardReceived extends StatelessWidget {
  StaffNoticeBoardReceived({Key? key}) : super(key: key);
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    Provider.of<StaffNoticeboardSendProviders>(context, listen: false)
        .getnoticeList();
    var size = MediaQuery.of(context).size;
    var width = size.width;
    return Consumer<StaffNoticeboardSendProviders>(builder: (_, value, child) {
      return value.loadingg
          ? spinkitLoader()
          : staffNoticeView == null || staffNoticeView!.isEmpty
              ? Center(
                  child: Container(
                    child: LottieBuilder.network(
                        'https://assets2.lottiefiles.com/private_files/lf30_lkquf6qz.json'),
                  ),
                )
              : ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount:
                      staffNoticeView == null ? 0 : staffNoticeView!.length,
                  itemBuilder: (BuildContext context, index) {
                    var noticeattach =
                        staffNoticeView![index]['noticeId'] == null
                            ? '--'
                            : staffNoticeView![index]['noticeId'].toString();

                    String createddate =
                        staffNoticeView![index]["entryDate"] ?? '--';
                    // var updatedDate = DateFormat('yyyy-MM-dd').parse(createddate);
                    // String newDate = updatedDate.toString();
                    String finalCreatedDate =
                        createddate.replaceRange(11, 19, '');

                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 6.0, right: 6, bottom: 3, top: 3),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 234, 234, 236),
                          border: Border.all(
                            color: const Color.fromARGB(255, 136, 187, 235),
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
                                color: Color.fromARGB(255, 255, 255, 255),
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    bottomLeft: Radius.circular(20))),
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Row(
                                      children: [
                                        const Text('📌  '),
                                        Flexible(
                                          child: RichText(
                                            overflow: TextOverflow.ellipsis,
                                            strutStyle: const StrutStyle(
                                                fontSize: 14.0),
                                            text: TextSpan(
                                              style: const TextStyle(
                                                  color: UIGuide.light_Purple,
                                                  fontWeight: FontWeight.w500),
                                              text: staffNoticeView![index]
                                                          ['title'] ==
                                                      null
                                                  ? '--'
                                                  : staffNoticeView![index]
                                                          ['title']
                                                      .toString(),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  kheight10,

                                  LinkTextWidget(
                                    text: staffNoticeView![index]['matter'] ==
                                        null
                                        ? '--'
                                        : staffNoticeView![index]['matter']
                                        .toString(),
                                    font: 14,

                                  ),
                                  // TextWrapper(
                                  //   text: staffNoticeView![index]['matter'] ==
                                  //           null
                                  //       ? '--'
                                  //       : staffNoticeView![index]['matter']
                                  //           .toString(),
                                  //   fSize: 14,
                                  // ),
                                  kheight10,
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      kWidth,
                                      Text(
                                        finalCreatedDate,
                                        //  value.noticeBoard[index].entryDate ?? '--',
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                      const Spacer(), kWidth, kWidth, kWidth,
                                      kWidth,
                                      Text(
                                        staffNoticeView![index]['staffName'] ==
                                                null
                                            ? '--'
                                            : staffNoticeView![index]
                                                    ['staffName']
                                                .toString(),
                                        //   value.noticeBoard[index].staffName ?? '--',
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                      //kWidth
                                      const Spacer(),
                                      GestureDetector(
                                        onTap: () async {
                                          await Provider.of<
                                                      StaffNoticeboardSendProviders>(
                                                  context,
                                                  listen: false)
                                              .staffNoticeBoardAttach(
                                                  noticeattach.toString());
                                          if (value.extension == '.pdf' ||
                                              value.extension == '.zip' ||
                                              value.extension == '.rar') {
                                            final result = value.url.toString();
                                            final name = value.name.toString();
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const PDFDownloadStaff()),
                                            );
                                          } else {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const PdfViewPageStaff()),
                                            );
                                          }
                                        },
                                        child: SizedBox(
                                          height: 25,
                                          width: 25,
                                          child: LottieBuilder.network(
                                                  "https://assets2.lottiefiles.com/temp/lf20_D0nz3r.json") ?? const Icon(
                                                  Icons.remove_red_eye_outlined),
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
                    );
                  },
                );
    });
  }
}

class PDFDownloadStaff extends StatefulWidget {
  const PDFDownloadStaff({
    Key? key,
  }) : super(key: key);
  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
  }

  @override
  State<PDFDownloadStaff> createState() => _PDFDownloadStaffState();
}

class _PDFDownloadStaffState extends State<PDFDownloadStaff> {
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
        fileName: "$name.pdf",
        showNotification: true,
        openFileFromNotification: true,
      );

      print(taskid);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StaffNoticeboardSendProviders>(
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
          body: value.extension == '.pdf'?
          SfPdfViewer.network(
            value.url == null ? '--' : value.url.toString(),
          ):
          Container(
            child: Center(
              child: SizedBox(
                height: 150,
                child: Image.asset(
                  'assets/zip_file.png',// Replace with the path to your image asset
                  fit: BoxFit.fill,// Adjust as needed (e.g., BoxFit.cover, BoxFit.fill)
                ),
              ),
            ),
          )
      ),
    );
  }
}

class PdfViewPageStaff extends StatefulWidget {
  const PdfViewPageStaff({Key? key}) : super(key: key);
  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
  }

  @override
  State<PdfViewPageStaff> createState() => _PdfViewPageStaffState();
}

class _PdfViewPageStaffState extends State<PdfViewPageStaff> {
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
        fileName: " $name",
        showNotification: true,
        openFileFromNotification: true,
      );
      log("nweurlll $url");

      print(taskid);
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
                backgroundDecoration: const BoxDecoration(color: UIGuide.WHITE),
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
    return Consumer<StaffNoticeboardSendProviders>(
        builder: (context, provider, _) {
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
