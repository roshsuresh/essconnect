import 'dart:developer';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:essconnect/Application/Staff_Providers/TimetableProvider.dart';
import 'package:essconnect/utils/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../Constants.dart';
import '../../utils/constants.dart';

class Staff_Timetable extends StatelessWidget {
  const Staff_Timetable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<StaffTimetableProvider>(context, listen: false)
          .getTimeTable();
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('TimeTable'),
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
      body: Consumer<StaffTimetableProvider>(
        builder: (context, value, child) => value.loading
            ? spinkitLoader()
            : value.extension == null
                ? LottieBuilder.network(
                    'https://assets2.lottiefiles.com/private_files/lf30_lkquf6qz.json')
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        kheight20,
                        Table(
                          border: TableBorder.all(
                              color: const Color.fromARGB(255, 255, 255, 255)),
                          columnWidths: const {
                            0: FlexColumnWidth(4),
                            1: FlexColumnWidth(2),
                          },
                          children: const [
                            TableRow(
                                decoration: BoxDecoration(
                                    color: UIGuide.light_black,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(12),
                                        topRight: Radius.circular(12))),
                                children: [
                                  SizedBox(
                                    height: 30,
                                    child: Center(
                                      child: Text(
                                        'TimeTable',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                    child: Center(
                                        child: Text(
                                      'View',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    )),
                                  ),
                                ]),
                          ],
                        ),
                        InkWell(
                          child: Table(
                            border: TableBorder.all(
                                color:
                                    const Color.fromARGB(255, 255, 255, 255)),
                            columnWidths: const {
                              0: FlexColumnWidth(4),
                              1: FlexColumnWidth(2),
                            },
                            children: [
                              TableRow(
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 243, 243, 243),
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(12),
                                      bottomRight: Radius.circular(12),
                                    ),
                                  ),
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: Text(
                                          value.name ?? '---',
                                          style: const TextStyle(fontSize: 15),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SizedBox(
                                        height: 25,
                                        width: 25,
                                        child: LottieBuilder.network(
                                                "https://assets2.lottiefiles.com/temp/lf20_D0nz3r.json") ?? const Icon(
                                                Icons.remove_red_eye_outlined),
                                      ),
                                    ),
                                  ]),
                            ],
                          ),
                          onTap: () async {
                            if (value.extension == '.pdf') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const PdfViewStaff()),
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const StaffTimetableimage()),
                              );
                            }
                          },
                        )
                      ],
                    ),
                  ),
      ),
    );
  }
}

// class PdfViewStaff extends StatelessWidget {
//   const PdfViewStaff({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<StaffTimetableProvider>(
//       builder: (context, value, child) => Scaffold(
//           appBar: AppBar(
//             title: const Text('TimeTable'),
//             titleSpacing: 00.0,
//             centerTitle: true,
//             toolbarHeight: 50.2,
//             toolbarOpacity: 0.8,
//             backgroundColor: UIGuide.light_Purple,
//             actions: [
//               Padding(
//                 padding: const EdgeInsets.only(right: 15.0),
//                 child: DownloandPdf(
//                   isUseIcon: true,
//                   pdfUrl: value.url ?? '--',
//                   fileNames: value.name ?? '--',
//                   color: Colors.white,
//                 ),
//               ),
//             ],
//           ),
//           body: SfPdfViewer.network(value.url ?? '--')),
//     );
//   }
// }

class PdfViewStaff extends StatefulWidget {
  const PdfViewStaff({
    Key? key,
  }) : super(key: key);
  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
  }

  @override
  State<PdfViewStaff> createState() => _PdfViewStaffState();
}

class _PdfViewStaffState extends State<PdfViewStaff> {
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
        fileName: "Timetable $name.pdf",
        showNotification: true,
        openFileFromNotification: true,
      );

      print(taskid);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StaffTimetableProvider>(
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

class StaffTimetableimage extends StatefulWidget {
  const StaffTimetableimage({Key? key}) : super(key: key);
  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
  }

  @override
  State<StaffTimetableimage> createState() => _StaffTimetableimageState();
}

class _StaffTimetableimageState extends State<StaffTimetableimage> {
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
        title: const Text('Timetable'),
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
                  result ?? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSlmeGlXoJwwpbCE9jGgHgZ2XaE5nnPUSomkZz_vZT7&s',
                ),
              )),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StaffTimetableProvider>(builder: (context, provider, _) {
      if (provider.extension.toString() == '.jpg') {
        final imgResult = provider.url.toString();
        final name = provider.name.toString();
        return imageview(imgResult, name);
      } else if (provider.extension.toString() == '.png') {
        final imgResult2 = provider.url.toString();
        final name = provider.name.toString();
        return imageview(imgResult2, name);
      } else if (provider.extension.toString() == '.jpeg' ||
          provider.extension.toString() == '.jfif') {
        final imgResult3 = provider.url.toString();
        final name = provider.name.toString();
        return imageview(imgResult3, name);
      } else {
        return const Scaffold(
          body: Center(
            child: Text(
              'No Attachment Provided',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ),
        );
      }
    });
  }
}
