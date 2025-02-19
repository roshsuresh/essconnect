import 'dart:developer';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:essconnect/Application/AdminProviders/ExamTTPtoviders.dart';
import 'package:essconnect/Constants.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:essconnect/utils/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../Staff/ExamTT.dart/ExamEditStaff.dart';
import 'ExamEdit.dart';

class ExamTTHistory extends StatelessWidget {
  const ExamTTHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var p = Provider.of<ExamTTAdmProviders>(context, listen: false);
      p.courseList.clear();
      await p.clearTTexamList();
      await p.getExamTimeTableList();
    });
    var size = MediaQuery.of(context).size;
    return Consumer<ExamTTAdmProviders>(
      builder: (context, provider, child) {
        return provider.loading
            ? spinkitLoader()
            : Scrollbar(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount:
                      provider.examlist.isEmpty ? 0 : provider.examlist.length,
                  itemBuilder: (context, index) {
                    //created date
                    String finalCreatedDate = "";

                    if (provider.examlist[index].createdAt != null) {
                      String createddate =
                          provider.examlist[index].createdAt ?? '--';
                      DateTime parsedDateTime = DateTime.parse(createddate);
                      finalCreatedDate =
                          DateFormat('dd-MMM-yyyy').format(parsedDateTime);
                    }

                    //start date
                    String finalStartDate = '';

                    if (provider.examlist[index].examStartDate != null) {
                      String startdate =
                          provider.examlist[index].examStartDate ?? '--';
                      DateTime parsedDateTime = DateTime.parse(startdate);

                      finalStartDate =
                          DateFormat('dd-MMM-yyyy').format(parsedDateTime);
                    }

                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        width: size.width,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: UIGuide.light_Purple, width: 1),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Row(
                                children: [
                                  const Text('Created Date: '),
                                  Text(
                                    finalCreatedDate.isEmpty
                                        ? '--'
                                        : finalCreatedDate,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: UIGuide.light_Purple,
                                        fontSize: 13),
                                  ),
                                  const Spacer(),
                                  kWidth,
                                  //Edit
                                  GestureDetector(
                                    onTap: () async {
                                      String staffid = provider
                                          .examlist[index].createdStaffId ??
                                          '--';

                                      var parsedResponse = await parseJWT();
                                      if (parsedResponse['StaffId'] ==
                                          staffid) {
                                        String event = provider
                                            .examlist[index].id
                                            .toString();
                                        await Navigator.push(context, MaterialPageRoute(builder: (context)=>  ExamTTEdit(eventId: event,)));
                                        // await provider.clearTTexamList();
                                        // await provider.getExamTimeTableList();
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            elevation: 10,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                            ),
                                            duration: Duration(seconds: 1),
                                            margin: EdgeInsets.only(
                                                bottom: 80,
                                                left: 30,
                                                right: 30),
                                            behavior: SnackBarBehavior.floating,
                                            content: Text(
                                              'Sorry, you have no access to edit ',
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.only(
                                          left: 8,
                                          right: 8,
                                          top: 3,
                                          bottom: 2),
                                      child: Icon(
                                        Icons.edit,
                                        color: UIGuide.button1,
                                        size: 22,
                                      ),
                                    ),
                                  ),
                                  kWidth,
                                  //View Eye
                                  GestureDetector(
                                      onTap: () async {
                                        String att =
                                            provider.examlist[index].id ?? '--';
                                        await provider.viewAttachmentAdmin(att);
                                        if (provider.extensionExam ==
                                            '.pdf') {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                const ExamPdfViewAdmin()),
                                          );
                                        } else {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                const ImageViewExamAdmin()),
                                          );
                                        }
                                      },
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.only(top: 8,bottom: 8,),
                                      child: SizedBox(
                                        height: 25,
                                        width: 25,
                                        child: LottieBuilder.network(
                                            "https://assets2.lottiefiles.com/temp/lf20_D0nz3r.json") ?? const Icon(Icons
                                            .remove_red_eye_outlined),
                                      ),
                                    ),
                                  ),
                                  kWidth,
                                  //Delete
                                  GestureDetector(
                                    onTap: () async {
                                      showDialog(
                                        context: context,
                                        builder:
                                            (BuildContext context) {
                                          return AlertDialog(
                                            title: const Center(
                                              child: Text(
                                                "Are You Sure Want To Delete",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                            actions: <Widget>[
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceEvenly,
                                                children: [
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets
                                                        .only(
                                                        left:
                                                        8.0),
                                                    child:
                                                    OutlinedButton(
                                                      onPressed:
                                                          () {
                                                        Navigator.of(
                                                            context)
                                                            .pop();
                                                      },
                                                      style: ButtonStyle(
                                                          side: WidgetStateProperty.all(const BorderSide(
                                                              color: UIGuide
                                                                  .light_Purple,
                                                              width:
                                                              1.0,
                                                              style:
                                                              BorderStyle.solid))),
                                                      child:
                                                      const Text(
                                                        '  Cancel  ',
                                                        style:
                                                        TextStyle(
                                                          color: Color.fromARGB(
                                                              255,
                                                              201,
                                                              13,
                                                              13),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  OutlinedButton(
                                                    onPressed: () async {
                                                      String staffid = provider
                                                          .examlist[index].createdStaffId ??
                                                          '--';

                                                      var parsedResponse = await parseJWT();
                                                      if (parsedResponse['StaffId'] ==
                                                          staffid) {
                                                        String event = provider
                                                            .examlist[index].id
                                                            .toString();
                                                        await provider.examTTDelete(
                                                            event, context, index);
                                                        // await provider.clearTTexamList();
                                                        // await provider.getExamTimeTableList();
                                                      } else {
                                                        ScaffoldMessenger.of(context)
                                                            .showSnackBar(
                                                          const SnackBar(
                                                            elevation: 10,
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.all(
                                                                  Radius.circular(10)),
                                                            ),
                                                            duration: Duration(seconds: 1),
                                                            margin: EdgeInsets.only(
                                                                bottom: 80,
                                                                left: 30,
                                                                right: 30),
                                                            behavior: SnackBarBehavior.floating,
                                                            content: Text(
                                                              'Sorry, you have no access to delete ',
                                                              textAlign: TextAlign.center,
                                                            ),
                                                          ),
                                                        );
                                                      }


                                                      Navigator.pop(
                                                          context);
                                                    },
                                                    style: ButtonStyle(
                                                        side: WidgetStateProperty.all(const BorderSide(
                                                            color: UIGuide
                                                                .light_Purple,
                                                            width:
                                                            1.0,
                                                            style: BorderStyle
                                                                .solid))),
                                                    child:
                                                    const Text(
                                                      'Confirm',
                                                      style:
                                                      TextStyle(
                                                        color: Color
                                                            .fromARGB(
                                                            255,
                                                            12,
                                                            162,
                                                            46),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.only(
                                          left: 8,
                                          right: 8,
                                          top: 3,
                                          bottom: 2),
                                      child: Icon(
                                        Icons.delete_forever_outlined,
                                        color: Colors.red,
                                        size: 22,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Row(
                                children: [
                                  const Text('Exam Description: '),
                                  Flexible(
                                    child: Text(
                                      provider.examlist[index].description ??
                                          '--',
                                      overflow: TextOverflow.clip,
                                      maxLines: 1,
                                      style: const TextStyle(
                                          color: UIGuide.light_Purple,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5, top: 5),
                              child: Row(
                                children: [
                                  const Text('Start Date: '),
                                  Flexible(
                                    child: Text(
                                      finalStartDate.isEmpty
                                          ? '--'
                                          : finalStartDate,
                                      overflow: TextOverflow.clip,
                                      style: const TextStyle(
                                          color: UIGuide.light_Purple,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5, top: 5),
                              child: Row(
                                children: [
                                  const Text('Course: '),
                                  Flexible(
                                    child: Text(
                                      provider.examlist[index].course ?? '--',
                                      overflow: TextOverflow.clip,
                                      style: const TextStyle(
                                          color: UIGuide.light_Purple,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5, top: 5),
                              child: Row(
                                children: [
                                  const Text('Division: '),
                                  Flexible(
                                    child: Text(
                                      provider.examlist[index].division ?? '--',
                                      overflow: TextOverflow.clip,
                                      style: const TextStyle(
                                          color: UIGuide.light_Purple,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 5, top: 5, bottom: 5),
                              child: Row(
                                children: [
                                  const Text('Created by: '),
                                  Flexible(
                                    child: Text(
                                      provider.examlist[index]
                                              .createStaffName ??
                                          '--',
                                      overflow: TextOverflow.clip,
                                      style: const TextStyle(
                                          color: UIGuide.light_Purple,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
      },
    );
  }
}
////////Exam

class ExamPdfViewAdmin extends StatefulWidget {
  const ExamPdfViewAdmin({
    Key? key,
  }) : super(key: key);
  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort send =
    IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
  }

  @override
  State<ExamPdfViewAdmin> createState() => _ExamPdfViewAdminState();
}

class _ExamPdfViewAdminState extends State<ExamPdfViewAdmin> {
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
        fileName: "Exam Timetable $name.pdf",
        showNotification: true,
        openFileFromNotification: true,
      );
      log("nweurlll $url");

      print(taskid);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExamTTAdmProviders>(
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
                        value.urlExam.toString().isEmpty
                            ? '--'
                            : value.urlExam.toString(),
                        value.idExam.toString().isEmpty
                            ? '---'
                            : value.idExam.toString() +
                            value.nameExam.toString(),
                      );
                    },
                    icon: const Icon(Icons.download_outlined))),
          ],
        ),
        body: SfPdfViewer.network(
          value.urlExam == null ? '--' : value.urlExam.toString(),
        ),
      ),
    );
  }
}

class ImageViewExamAdmin extends StatefulWidget {
  const ImageViewExamAdmin({Key? key}) : super(key: key);
  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort send =
    IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
  }

  @override
  State<ImageViewExamAdmin> createState() => _ImageViewExamAdminState();
}

class _ImageViewExamAdminState extends State<ImageViewExamAdmin> {
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
        title: const Text('Exam Timetable'),
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
        child: PhotoView(
          backgroundDecoration: const BoxDecoration(color: UIGuide.WHITE),
          loadingBuilder: (context, event) {
            return spinkitLoader();
          },
          imageProvider: NetworkImage(
            result.isEmpty
                ? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSlmeGlXoJwwpbCE9jGgHgZ2XaE5nnPUSomkZz_vZT7&s'
                : result,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExamTTAdmProviders>(builder: (context, provider, _) {
      if (provider.extensionExam.toString() == '.jpg') {
        final imgResult = provider.urlExam.toString();
        final name = provider.nameExam.toString();
        return imageview(imgResult, name);
      } else if (provider.extensionExam.toString() == '.png') {
        final imgResult2 = provider.urlExam.toString();
        final name = provider.nameExam.toString();
        return imageview(imgResult2, name);
      } else if (provider.extensionExam.toString() == '.jpeg' ||
          provider.extensionExam.toString() == '.jfif') {
        final imgResult3 = provider.urlExam.toString();
        final name = provider.nameExam.toString();
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