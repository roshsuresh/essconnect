

import 'dart:developer';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../Application/Staff_Providers/SearchProvider.dart';
import '../../../utils/constants.dart';

class AdminTimeTableView extends StatefulWidget {
  AdminTimeTableView({
    Key? key,
  }) : super(key: key);
  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort send =
    IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
  }

  @override
  State<AdminTimeTableView> createState() => _AdminTimeTableViewState();
}

class _AdminTimeTableViewState extends State<AdminTimeTableView> {
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
    return Consumer<Screen_Search_Providers>(
      builder: (context, value, child) => Scaffold(
          appBar: AppBar(
            title: const Text('TimeTable'),
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
                          value.tturl == null ? '--' : value.tturl.toString(),
                          value.ttid == null
                              ? '---'
                              : value.ttid.toString() + value.ttname.toString(),
                        );
                      },
                      icon: const Icon(Icons.download_outlined))),
            ],
          ),
          body: SfPdfViewer.network(
            value.tturl == null ? '--' : value.tturl.toString(),
          )),
    );
  }
}

class NoTimeTableScreen extends StatelessWidget {
  const NoTimeTableScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('No Attachment'),
      ),
    );
  }
}
