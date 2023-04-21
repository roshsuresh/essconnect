import 'dart:developer';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:essconnect/Application/StudentProviders/PaymentHistory.dart';
import 'package:essconnect/utils/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
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
    var size = MediaQuery.of(context).size;
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
            : value.historyList == null || value.historyList.isEmpty
                ? Container(
                    child: LottieBuilder.network(
                        'https://assets2.lottiefiles.com/private_files/lf30_lkquf6qz.json'),
                  )
                : ListView(
                    children: [
                      kheight10,
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Table(
                          columnWidths: const {
                            0: FlexColumnWidth(.6),
                            1: FlexColumnWidth(2.1),
                            2: FlexColumnWidth(2.3),
                            3: FlexColumnWidth(2.2),
                            4: FlexColumnWidth(1.8)
                          },
                          children: const [
                            TableRow(
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 196, 210, 235),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(3),
                                    topRight: Radius.circular(3),
                                  ),
                                ),
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(3.0),
                                    child: Center(
                                        child: Text(
                                      'Sl.',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700),
                                    )),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(3.0),
                                    child: Center(
                                        child: Text(
                                      'Bill Date',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700),
                                    )),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(3.0),
                                    child: Center(
                                        child: Text(
                                      'Payment \n  Mode',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700),
                                    )),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(3.0),
                                    child: Center(
                                        child: Text(
                                      'Amount \n   paid',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700),
                                    )),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(3.0),
                                    child: Center(
                                        child: Text(
                                      'Receipt',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700),
                                    )),
                                  )
                                ]),
                          ],
                        ),
                      ),
                      LimitedBox(
                        maxHeight: size.height - 150,
                        child: Scrollbar(
                          child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: value.historyList.isEmpty
                                  ? 0
                                  : value.historyList.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                String newtime = value
                                    .historyList[index].billDate
                                    .toString();

                                var updatedDate =
                                    DateFormat('yyyy-MM-dd').parse(newtime);
                                String newDate = updatedDate.toString();
                                String finalCreatedDate =
                                    newDate.replaceRange(10, 23, '');

                                return GestureDetector(
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Table(
                                      columnWidths: const {
                                        0: FlexColumnWidth(.6),
                                        1: FlexColumnWidth(2.1),
                                        2: FlexColumnWidth(2.3),
                                        3: FlexColumnWidth(2.2),
                                        4: FlexColumnWidth(1.8)
                                      },
                                      children: [
                                        TableRow(
                                            decoration: const BoxDecoration(
                                              color: Color.fromARGB(
                                                  255, 238, 235, 235),
                                            ),
                                            children: [
                                              Text(
                                                "\n${(index + 1).toString()}",
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    fontSize: 13),
                                              ),
                                              Center(
                                                  child: Text(
                                                '\n${finalCreatedDate.toString()}',
                                                style: const TextStyle(
                                                    fontSize: 13),
                                              )),
                                              Center(
                                                  child: Text(
                                                '\n${value.historyList[index].paymentMode}',
                                                style: const TextStyle(
                                                    fontSize: 13),
                                              )),
                                              Center(
                                                  child: Text(
                                                '\n${value.historyList[index].billAmount}',
                                                style: const TextStyle(
                                                    fontSize: 13),
                                              )),
                                              IconButton(
                                                icon: const Icon(
                                                  Icons.remove_red_eye,
                                                  size: 20,
                                                ),
                                                onPressed: () async {
                                                  String reAttach = value
                                                      .historyList[index]
                                                      .orderId
                                                      .toString();
                                                  await Provider.of<
                                                              PaymentHistoryProvider>(
                                                          context,
                                                          listen: false)
                                                      .feeHistoryAttachment(
                                                          reAttach);
                                                  if (value.extension
                                                          .toString() ==
                                                      '.pdf') {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                PdfDownloadFee()));
                                                  } else {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                const NoAttachmentScreenFee()));
                                                  }
                                                },
                                              )
                                            ]),
                                      ],
                                    ),
                                  ),
                                  onTap: () async {
                                    String reAttach = value
                                        .historyList[index].orderId
                                        .toString();
                                    await Provider.of<PaymentHistoryProvider>(
                                            context,
                                            listen: false)
                                        .feeHistoryAttachment(reAttach);
                                    if (value.extension.toString() == '.pdf') {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PdfDownloadFee()));
                                    } else {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const NoAttachmentScreenFee()));
                                    }
                                  },
                                );
                              }),
                        ),
                      )
                    ],
                  );
      }),
    );
  }
}

class PdfDownloadFee extends StatefulWidget {
  PdfDownloadFee({
    Key? key,
  }) : super(key: key);
  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
  }

  @override
  State<PdfDownloadFee> createState() => _PdfDownloadFeeState();
}

class _PdfDownloadFeeState extends State<PdfDownloadFee> {
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

    FlutterDownloader.registerCallback(PdfDownloadFee.downloadCallback);
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
        fileName: "Payment Receipt $_name.pdf",
        showNotification: true,
        openFileFromNotification: true,
      );
      log("nweurlll $_url");

      print(_taskid);
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
                              : value.name.toString() + value.id.toString(),
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
