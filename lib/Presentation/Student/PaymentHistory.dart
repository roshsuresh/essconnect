import 'dart:developer';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:essconnect/Application/StudentProviders/PaymentHistory.dart';
import 'package:essconnect/utils/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../Constants.dart';
import '../../utils/constants.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';

class PaymentHistory extends StatelessWidget {
  const PaymentHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var p = Provider.of<PaymentHistoryProvider>(context, listen: false);
      p.getHistoryList();
      p.historyList.clear();
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment History'),
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
      body: Consumer<PaymentHistoryProvider>(builder: (context, value, child) {
        return value.loading
            ? spinkitLoader()
            : value.historyList.isEmpty
            ? Container(
          child: LottieBuilder.network(
              'https://assets2.lottiefiles.com/private_files/lf30_lkquf6qz.json'),
        )
            : Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            children: [
              kheight10,
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Table(
                  border: TableBorder.all(
                      color:
                      const Color.fromARGB(255, 255, 255, 255)),
                  columnWidths: const {
                    0: FlexColumnWidth(.6),
                    1: FlexColumnWidth(2.5),
                    2: FlexColumnWidth(2.3),
                    3: FlexColumnWidth(2.2),
                    4: FlexColumnWidth(1.6)
                  },
                  children: const [
                    TableRow(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 223, 223, 223),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                        ),
                        children: [
                          TableCell(
                            verticalAlignment:
                            TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding:
                              EdgeInsets.only(top: 5, bottom: 5),
                              child: Center(
                                  child: Text(
                                    'Sl.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700),
                                  )),
                            ),
                          ),
                          TableCell(
                            verticalAlignment:
                            TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: EdgeInsets.all(3.0),
                              child: Center(
                                  child: Text(
                                    'Bill Date',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700),
                                  )),
                            ),
                          ),
                          TableCell(
                            verticalAlignment:
                            TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding:
                              EdgeInsets.only(top: 5, bottom: 5),
                              child: Center(
                                  child: Text(
                                    'Payment Mode',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700),
                                  )),
                            ),
                          ),
                          TableCell(
                            verticalAlignment:
                            TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: EdgeInsets.all(3.0),
                              child: Center(
                                  child: Text(
                                    'Amount paid',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700),
                                  )),
                            ),
                          ),
                          TableCell(
                            verticalAlignment:
                            TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: EdgeInsets.all(3.0),
                              child: Center(
                                  child: Text(
                                    'Receipt',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700),
                                  )),
                            ),
                          )
                        ]),
                  ],
                ),
              ),
              Expanded(
                // maxHeight: size.height - 150,
                child: AnimationLimiter(
                  child: Scrollbar(
                    child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: value.historyList.isEmpty
                            ? 0
                            : value.historyList.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          String finalCreatedDate = '';

                          if (value.historyList[index].billDate !=
                              null) {
                            String createddate =
                                value.historyList[index].billDate ??
                                    '--';
                            DateTime parsedDateTime =
                            DateTime.parse(createddate);
                            finalCreatedDate =
                                DateFormat('dd-MMM-yyyy')
                                    .format(parsedDateTime);
                          }

                          return AnimationConfiguration.staggeredList(
                            position: index,
                            delay: const Duration(milliseconds: 100),
                            child: SlideAnimation(
                              duration:
                              const Duration(milliseconds: 3500),
                              curve: Curves.fastLinearToSlowEaseIn,
                              child: FadeInAnimation(
                                curve: Curves.fastLinearToSlowEaseIn,
                                duration: const Duration(
                                    milliseconds: 3500),
                                child: InkWell(
                                  child: Padding(
                                    padding:
                                    const EdgeInsets.all(2.0),
                                    child: Table(
                                      border: TableBorder.all(
                                          color: const Color.fromARGB(
                                              255, 255, 255, 255)),
                                      columnWidths: const {
                                        0: FlexColumnWidth(.6),
                                        1: FlexColumnWidth(2.5),
                                        2: FlexColumnWidth(2.3),
                                        3: FlexColumnWidth(2.2),
                                        4: FlexColumnWidth(1.6)
                                      },
                                      children: [
                                        TableRow(
                                            decoration: BoxDecoration(
                                              color: index.isEven
                                                  ? Colors.white
                                                  : const Color
                                                  .fromARGB(255,
                                                  241, 241, 241),
                                            ),
                                            children: [
                                              TableCell(
                                                verticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                                child: Text(
                                                  (index + 1)
                                                      .toString(),
                                                  textAlign: TextAlign
                                                      .center,
                                                  style:
                                                  const TextStyle(
                                                      fontSize:
                                                      13),
                                                ),
                                              ),
                                              TableCell(
                                                verticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                                child: Center(
                                                    child: Text(
                                                      finalCreatedDate
                                                          .toString(),
                                                      style:
                                                      const TextStyle(
                                                          fontSize:
                                                          13),
                                                    )),
                                              ),
                                              TableCell(
                                                verticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                                child: Center(
                                                    child: Text(
                                                      value
                                                          .historyList[
                                                      index]
                                                          .paymentMode ??
                                                          "",
                                                      style:
                                                      const TextStyle(
                                                          fontSize:
                                                          13),
                                                    )),
                                              ),
                                              TableCell(
                                                verticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                                child: Center(
                                                    child: Text(
                                                      '${value.historyList[index].billAmount ?? ''}',
                                                      style:
                                                      const TextStyle(
                                                          fontSize:
                                                          13),
                                                    )),
                                              ),
                                              TableCell(
                                                verticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                                child: IconButton(
                                                  icon: const Icon(
                                                    Icons
                                                        .remove_red_eye,
                                                    size: 20,
                                                  ),
                                                  onPressed:
                                                      () async {
                                                    String reAttach = value
                                                        .historyList[
                                                    index]
                                                        .orderId
                                                        .toString();
                                                    await Provider.of<
                                                        PaymentHistoryProvider>(
                                                        context,
                                                        listen:
                                                        false)
                                                        .feeHistoryAttachment(
                                                        reAttach);
                                                    if (value
                                                        .extension
                                                        .toString() ==
                                                        '.pdf') {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                              const PdfDownloadFee()));
                                                    } else {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                              const NoAttachmentScreenFee()));
                                                    }
                                                  },
                                                ),
                                              )
                                            ]),
                                      ],
                                    ),
                                  ),
                                  onTap: () async {
                                    String reAttach = value
                                        .historyList[index].orderId
                                        .toString();
                                    await Provider.of<
                                        PaymentHistoryProvider>(
                                        context,
                                        listen: false)
                                        .feeHistoryAttachment(
                                        reAttach);
                                    if (value.extension.toString() ==
                                        '.pdf') {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                              const PdfDownloadFee()));
                                    } else {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                              const NoAttachmentScreenFee()));
                                    }
                                  },
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}



class PdfDownloadFee extends StatefulWidget {
  const PdfDownloadFee({
    Key? key,
  }) : super(key: key);

  @override
  State<PdfDownloadFee> createState() => _PdfDownloadFeeState();
}

class _PdfDownloadFeeState extends State<PdfDownloadFee> {
  final ReceivePort _port = ReceivePort();
  String? _downloadedFilePath;

  @override
  void initState() {
    super.initState();

    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      int status = data[1];
      int progress = data[2];

      print("statsss $status");
      if (status == 3) {
        print("stts $status");
        _showDownloadCompleteSnackBar();
      }

      setState(() {});
    });

    FlutterDownloader.registerCallback(downloadCallback);
  }

  @pragma('vm:entry-point')
  static void downloadCallback(String id, int status, int progress) {
    final SendPort? send = IsolateNameServer.lookupPortByName('downloader_send_port');
    send?.send([id, status, progress]);
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  void _showDownloadCompleteSnackBar() {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Download completed!'),
        duration: const Duration(seconds: 5),
        action: SnackBarAction(
          label: 'Open',
          onPressed: () {
            if (_downloadedFilePath != null) {
              OpenFile.open(_downloadedFilePath!);
            }
          },
        ),
      ),
    );
  }

  Future<void> requestDownload(String url, String name) async {
    if (url == '--') return;

    String localPath = "";
    if (Platform.isAndroid) {
      localPath = '/storage/emulated/0/Download';
    } else if (Platform.isIOS) {
      final dir = await getApplicationDocumentsDirectory();
      localPath = dir.path;
    }

    final fileName = "Payment Receipt $name.pdf";
    _downloadedFilePath = '$localPath/$fileName';

    final savedDir = Directory(localPath);
    await savedDir.create(recursive: true).then((value) async {
      String? taskId = await FlutterDownloader.enqueue(
        savedDir: localPath,
        url: url,
        fileName: fileName,
        showNotification: false,
        // openFileFromNotification: true,
      );
      log("Download task ID: $taskId");
      log("Download URL: $url");
      log("File will be saved to: $_downloadedFilePath");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PaymentHistoryProvider>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: const Text('Receipt'),
          titleSpacing: 00.0,
          centerTitle: true,
          toolbarHeight: 50.2,
          toolbarOpacity: 0.8,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25),
            ),
          ),
          backgroundColor: UIGuide.light_Purple,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: IconButton(
                onPressed: () async {
                  await requestDownload(
                    value.url.toString(),
                    value.id.toString(),
                  );
                },
                icon: const Icon(Icons.download_outlined),
              ),
            ),
          ],
        ),
        body: SfPdfViewer.network(
          value.url ?? '--',
        ),
      ),
    );
  }
}

class NoAttachmentScreenFee extends StatelessWidget {
  const NoAttachmentScreenFee({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Invalid attachment'),
      ),
    );
  }
}
