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

  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //     var p = Provider.of<FeesProvider>(context, listen: false);
  //     p.busFeeList.clear();
  //     p.feeList.clear();
  //     p.feesData();
  //     totalPartial = 0;
  //     totallPartial = 0;
  //     totalFeeCollect = 0;
  //     partialBUS = 0;
  //     partialFee = 0;
  //     p.transactionList.clear();
  //     p.gatewayName();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final _provider = Provider.of<ReportCardProvider>(context, listen: false);
      await _provider.clearReportCard();
      await _provider.getReportCard();
    });
    var size = MediaQuery.of(context).size;
    var height = size.height;

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
                  : value.reportcardList.isEmpty || value.reportcardList == null
                      ? LottieBuilder.network(
                          'https://assets2.lottiefiles.com/private_files/lf30_lkquf6qz.json')
                      : ListView(
                          physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          children: [
                            kheight20,
                            Table(
                              border: TableBorder.all(
                                  color:
                                      const Color.fromRGBO(245, 243, 243, 1)),
                              columnWidths: const {
                                0: FlexColumnWidth(3),
                                1: FlexColumnWidth(5),
                                2: FlexColumnWidth(2),
                              },
                              children: const [
                                TableRow(
                                    decoration: BoxDecoration(
                                      color: UIGuide.light_black,
                                    ),
                                    children: [
                                      SizedBox(
                                        height: 30,
                                        child: Center(
                                            child: Text(
                                          'Date',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                        )),
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
                                    ]),
                              ],
                            ),
                            LimitedBox(
                              maxHeight: size.height - 30,
                              child: Consumer<ReportCardProvider>(
                                builder: (context, provider, child) {
                                  return ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: value.reportcardList.isEmpty
                                          ? 0
                                          : value.reportcardList.length,
                                      itemBuilder: ((context, index) {
                                        String time = value
                                                .reportcardList[index]
                                                .uploadedDate ??
                                            '--';
                                        var updatedDate =
                                            DateFormat('yyyy-MM-dd')
                                                .parse(time);
                                        String newDate = updatedDate.toString();
                                        String Corect_tym =
                                            newDate.replaceRange(10, 23, '');

                                        // String Corect_tym =
                                        //     time.replaceRange(10, 20, '');
                                        print('dob $Corect_tym');
                                        String reAttach = value
                                                .reportcardList[index].fileId ??
                                            '--';
                                        print(reAttach);
                                        return GestureDetector(
                                          onTap: () async {
                                            final attch = await Provider.of<
                                                        ReportCardProvider>(
                                                    context,
                                                    listen: false)
                                                .reportCardAttachment(reAttach);
                                            if (provider.extension.toString() ==
                                                '.pdf') {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        PdfDownload()),
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
                                                    255, 245, 243, 243)),
                                            columnWidths: const {
                                              0: FlexColumnWidth(3),
                                              1: FlexColumnWidth(5),
                                              2: FlexColumnWidth(2),
                                            },
                                            children: [
                                              TableRow(
                                                  decoration:
                                                      const BoxDecoration(),
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        Corect_tym == null
                                                            ? '---'
                                                            : Corect_tym
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
                                                        child: LottieBuilder
                                                                    .network(
                                                                        "https://assets2.lottiefiles.com/temp/lf20_D0nz3r.json") ==
                                                                null
                                                            ? const Icon(Icons
                                                                .remove_red_eye_outlined)
                                                            : LottieBuilder.network(
                                                                "https://assets2.lottiefiles.com/temp/lf20_D0nz3r.json"),
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
  PdfDownload({
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

    FlutterDownloader.registerCallback(PdfDownload.downloadCallback);
  }

  @pragma('vm:entry-point')
  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send!.send([id, status, progress]);
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  Future<void> requestDownload(String _url, String _name) async {
    final dir = await getExternalStorageDirectory();
    var _localPath;

    //dir!.path;

    // Directory downloadsDir;

    // Check platform
    if (Platform.isAndroid) {
      _localPath = '/storage/emulated/0/Download';
    } else if (Platform.isIOS) {
      final dir = await getExternalStorageDirectory();
      _localPath = dir!.path;
    }
    print("pathhhh  $_localPath");
    final savedDir = Directory(_localPath);
    await savedDir.create(recursive: true).then((value) async {
      String? _taskid = await FlutterDownloader.enqueue(
        savedDir: _localPath,
        url: _url,
        fileName: "Report Card $_name.pdf",
        showNotification: true,
        openFileFromNotification: true,
      );
      log("nweurlll $_url");

      print(_taskid);
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
