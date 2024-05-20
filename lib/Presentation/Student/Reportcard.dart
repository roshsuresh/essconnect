import 'dart:developer';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:essconnect/utils/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../Application/StudentProviders/ReportCardProvider.dart';
import '../../Constants.dart';
import '../../utils/constants.dart';

class ReportCard extends StatelessWidget {
  const ReportCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final provider = Provider.of<ReportCardProvider>(context, listen: false);
      await provider.clearReportCard();
      await provider.getReportCard();
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Report card'),
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<ReportCardProvider>(
          builder: (context, value, child) => value.loading
              ? spinkitLoader()
              : value.isLocked == true
                  ? const Center(
                      child: Text(
                        "Report Card Locked",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: UIGuide.light_Purple,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                    )
                  : value.reportcardList.isEmpty
                      ? LottieBuilder.network(
                          'https://assets2.lottiefiles.com/private_files/lf30_lkquf6qz.json')
                      : Column(
                          children: [
                            kheight20,
                            Table(
                              border: TableBorder.all(
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255)),
                              columnWidths: const {
                                0: FlexColumnWidth(3),
                                1: FlexColumnWidth(5),
                                2: FlexColumnWidth(2),
                              },
                              children: const [
                                TableRow(
                                  decoration: BoxDecoration(
                                    color: UIGuide.light_black,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      topRight: Radius.circular(12),
                                    ),
                                  ),
                                  children: [
                                    SizedBox(
                                      height: 30,
                                      child: Center(
                                        child: Text(
                                          'Date',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                      child: Center(
                                        child: Text(
                                          'Description',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                      child: Center(
                                          child: Text(
                                        'View',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      )),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Expanded(
                              child: Consumer<ReportCardProvider>(
                                builder: (context, provider, child) {
                                  return ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: value.reportcardList.isEmpty
                                          ? 0
                                          : value.reportcardList.length,
                                      itemBuilder: ((context, index) {
                                        //created date
                                        String corectTym = "";

                                        if (value.reportcardList[index]
                                                .uploadedDate !=
                                            null) {
                                          String createddate = value
                                                  .reportcardList[index]
                                                  .uploadedDate ??
                                              '--';
                                          DateTime parsedDateTime =
                                              DateTime.parse(createddate);
                                          corectTym = DateFormat('dd-MMM-yyyy')
                                              .format(parsedDateTime);
                                        }
                                        print('dob $corectTym');
                                        String reAttach = value
                                                .reportcardList[index].fileId ??
                                            '--';
                                        print(reAttach);
                                        return InkWell(
                                          onTap: () async {
                                            await provider
                                                .reportCardAttachment(reAttach);
                                            if (provider.extension.toString() ==
                                                '.pdf') {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const PdfDownload()),
                                              );
                                            } else {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const NoAttachmentScreen()),
                                              );
                                            }
                                          },
                                          child: Table(
                                            border: TableBorder.all(
                                                color: const Color.fromARGB(
                                                    255, 255, 255, 255)),
                                            columnWidths: const {
                                              0: FlexColumnWidth(3),
                                              1: FlexColumnWidth(5),
                                              2: FlexColumnWidth(2),
                                            },
                                            children: [
                                              TableRow(
                                                  decoration:
                                                      const BoxDecoration(
                                                          color: Color.fromARGB(
                                                              255,
                                                              246,
                                                              247,
                                                              248)),
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        corectTym == null
                                                            ? '---'
                                                            : corectTym
                                                                .toString(),
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: UIGuide
                                                                .light_Purple),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        value
                                                                    .reportcardList[
                                                                        index]
                                                                    .description ==
                                                                null
                                                            ? '----'
                                                            : value
                                                                .reportcardList[
                                                                    index]
                                                                .description
                                                                .toString(),
                                                        style: const TextStyle(
                                                            color: UIGuide
                                                                .light_Purple,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: SizedBox(
                                                        height: 25,
                                                        width: 25,
                                                        child: LottieBuilder.network(
                                                                "https://assets2.lottiefiles.com/temp/lf20_D0nz3r.json") ?? const Icon(Icons
                                                                .remove_red_eye_outlined),
                                                      ),
                                                    ),
                                                  ]),
                                            ],
                                          ),
                                        );
                                      }));
                                },
                              ),
                            )
                          ],
                        ),
        ),
      ),
    );
  }
}

class PdfDownload extends StatefulWidget {
  const PdfDownload({
    Key? key,
  }) : super(key: key);
  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
  }

  @override
  State<PdfDownload> createState() => _PdfDownloadState();
}

class _PdfDownloadState extends State<PdfDownload> {
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
        fileName: "Report Card $name.pdf",
        showNotification: true,
        openFileFromNotification: true,
      );
      log("nweurlll $url");

      print(taskid);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ReportCardProvider>(
      builder: (context, value, child) => Scaffold(
          appBar: AppBar(
            title: const Text('Report card'),
            titleSpacing: 00.0,
            centerTitle: true,
            toolbarHeight: 50.2,
            toolbarOpacity: 0.8,
            backgroundColor: UIGuide.light_Purple,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(25),
                  bottomLeft: Radius.circular(25)),
            ),
            actions: [
              Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: IconButton(
                      onPressed: () async {
                        await requestDownload(
                          value.url == null ? '--' : value.url.toString(),
                          value.id == null
                              ? '---'
                              : value.id.toString() + value.name.toString(),
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

class NoAttachmentScreen extends StatelessWidget {
  const NoAttachmentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Invalid attachment'),
      ),
    );
  }
}
