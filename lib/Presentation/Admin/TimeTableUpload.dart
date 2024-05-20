import 'dart:developer';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:essconnect/Application/AdminProviders/TimeTableProvider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../Constants.dart';
import '../../Domain/Admin/TimeTableUploadModel.dart';
import '../../utils/constants.dart';
import '../../utils/spinkit.dart';


class TimeTableUplaod extends StatelessWidget {
  const TimeTableUplaod({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Upload Timetable'),
            titleSpacing: 25.0,
            centerTitle: true,
            toolbarHeight: 40.2,
            toolbarOpacity: 0.8,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(25),
                  bottomLeft: Radius.circular(25)),
            ),
            bottom: const TabBar(
              physics: NeverScrollableScrollPhysics(),
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: Colors.white,
              indicatorWeight: 5,
              tabs: [
                Tab(
                  text: "Class Timetable",
                ),
                Tab(text: "Staff Timetable"),

              ],
            ),
            backgroundColor: UIGuide.light_Purple,
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TimeTableUplaod()),
                    );
                  },
                  icon: const Icon(Icons.refresh_outlined))
            ],
          ),
          body: const TabBarView(children: [
            TimeTableUplaodClass(),
            TimeTableUplaodStaff(),

          ]),
        ));
  }
}

class TimeTableUplaodClass extends StatefulWidget {
  const TimeTableUplaodClass({super.key});

  @override
  State<TimeTableUplaodClass> createState() => _TimeTableUplaodClassState();
}

class _TimeTableUplaodClassState extends State<TimeTableUplaodClass> {
  List subjectData = [];


  String course ='';

  String filename='';
  String imagePath='';

  List itemImagePaths = [];
  TextEditingController fileController = TextEditingController();
  List<PlatformFile?> imageFiles = List.generate(5, (index) => null);
  int sizee=0;
  final ReceivePort _port = ReceivePort();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var p = Provider.of<TimeTableUploadProvider>(context, listen: false);
      p.getCourseList();
      p.courseCounter(0);
      p.courseDrop.clear();
      p.courseList.clear();
      p.clearList();
      p.setLoading(false);
      p.imageid='';

      IsolateNameServer.registerPortWithName(_port.sendPort, 'downloader_send_port');
      _port.listen((dynamic data) {
        String id = data[0];
       // DownloadTaskStatus status = DownloadTaskStatus(data[1]);
        int progress = data[2];
        setState((){ });

      });

      FlutterDownloader.registerCallback(downloadCallback);


    });
  }
  @pragma('vm:entry-point')
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
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Downloading file...'),
      duration: Duration(seconds: 1), // Adjust duration as needed
    ));

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
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Download complete'),
      duration: Duration(seconds: 1), // Adjust duration as needed
    ));
  }
  Future<void> _downloadFile(BuildContext context,String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final documentDirectory = await getApplicationDocumentsDirectory();
      final file = File('${documentDirectory.path}/file.pdf');
      await file.writeAsBytes(response.bodyBytes);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('File downloaded successfully'),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to download file: ${response.statusCode}'),
      ));
    }
  }


  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    var size= MediaQuery.of(context).size;
    return Scaffold(
       body: Consumer<TimeTableUploadProvider>(
          builder: (context, val, _) => Column(
            children: [
            Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Consumer<TimeTableUploadProvider>(
                builder: (context, value, child) => Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: MultiSelectDialogField(
                      // height: 200,
                      items: value.courseDrop,

                      listType: MultiSelectListType.CHIP,
                      title: const Text(
                        "Select Course",
                        style: TextStyle(color: Colors.grey),
                      ),
                      selectedItemsTextStyle: const TextStyle(
                          fontWeight: FontWeight.w900,
                          color: UIGuide.light_Purple),
                      confirmText: const Text(
                        'OK',
                        style: TextStyle(color: UIGuide.light_Purple),
                      ),
                      cancelText: const Text(
                        'Cancel',
                        style: TextStyle(color: UIGuide.light_Purple),
                      ),
                      separateSelectedItems: true,
                      //  checkColor: Colors.lightBlue,
                      decoration: const BoxDecoration(
                        color: UIGuide.ButtonBlue,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0, 2),
                            blurRadius: 4,
                            spreadRadius: 0,
                          ),
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      buttonIcon: const Icon(
                        Icons.arrow_drop_down_outlined,
                        color: Colors.grey,
                      ),
                      buttonText: value.courseLen == 0
                          ? const Text(
                        "Select Course",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      )
                          : Text(
                        "   ${value.courseLen.toString()} Selected",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      chipDisplay: MultiSelectChipDisplay.none(),
                      onConfirm: (results) async {
                        subjectData = [];
                        for (var i = 0; i < results.length; i++) {
                          Courses data =
                          results[i] as Courses;

                          subjectData.add(data.value);
                          subjectData.map((e) => data.value);
                          print("${subjectData.map((e) => data.value)}");
                        }
                        course = subjectData.join(',');
                        await Provider.of<TimeTableUploadProvider>(context,
                            listen: false)
                            .courseCounter(results.length);
                        await val.clearList();
                        print("data $course");

                        print(subjectData.join(','));
                      },
                    ),
                  ),
                ),
              ),
              //  const Spacer(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10),
                  child: SizedBox(
                    height: 43,
                    child: Consumer<TimeTableUploadProvider>(
                      builder: (context, val, child) => val.loading
                          ? const Center(
                          child: Text(
                            "Loading",
                            style: TextStyle(
                                color: UIGuide.light_Purple, fontSize: 16),
                          ))
                          : ElevatedButton(

                        style: ElevatedButton.styleFrom(
                          elevation: 3,
                          foregroundColor: UIGuide.WHITE,
                          backgroundColor: UIGuide.light_Purple,
                          padding: const EdgeInsets.all(0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(
                                color: UIGuide.light_black,
                              )),
                        ),
                        onPressed: () async {
                          await val.clearList();
                          val.imageid='';

                          await val.getDivisionList(course);

                          if (val.divisionList.isEmpty) {
                            snackbarWidget(
                                2,
                                "No data for specified condition",
                                context);
                          }
                        },
                        child: const Text(
                          'View',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),

              Expanded(
                child: Container(
                  //height: size.height*80,
                  child: AnimationLimiter(
                    child:


                    ListView.builder(
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      itemCount: val.divisionList.isEmpty
                          ? 0
                          : val.divisionList.length,
                      itemBuilder: (BuildContext context, int index) {
                       // List filenames = List.filled(val.divisionList.length, '');


                        return AnimationConfiguration.staggeredList(
                          position: index,
                          delay: const Duration(milliseconds: 100),
                          child: SlideAnimation(
                            duration: const Duration(milliseconds: 2500),
                            curve: Curves.fastLinearToSlowEaseIn,
                            child: FadeInAnimation(
                              curve: Curves.fastLinearToSlowEaseIn,
                              duration: const Duration(milliseconds: 2500),
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Container(
                                      width: size.width,
                                      decoration: BoxDecoration(
                                        // color: const Color.fromARGB(
                                        //     255, 234, 234, 236),
                                        border: Border.all(
                                            color: UIGuide.light_Purple),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Container(
                                          width: size.width,
                                          decoration: const BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(5),
                                            ),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                const EdgeInsets.all(4.0),
                                                child: Row(
                                                  children: [
                                                    //  kWidth,
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.black12,
                                                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(3),topRight: Radius.circular(3)),
                                                      ),


                                                      child: Text((index+1).toString())

                                                    ),
                                                    kWidth,
                                                    Flexible(
                                                      child: RichText(
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        strutStyle:
                                                        const StrutStyle(
                                                            fontSize:
                                                            15.0),
                                                        text: TextSpan(
                                                          style: const TextStyle(
                                                              color: UIGuide
                                                                  .light_Purple,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w500),
                                                          text: val
                                                              .divisionList[
                                                          index]
                                                              .text ==
                                                              null
                                                              ? '--'
                                                              : val
                                                              .divisionList[
                                                          index]
                                                              .text
                                                              .toString(),
                                                        ),
                                                      ),
                                                    ),


                                                  ],
                                                ),
                                              ),
                                              kheight5,


                                              val.divisionList[index].classTTUploadId!= null?
                                              Row(

                                                children:[
                                                  kWidth20,
                                              Padding(
                                                padding: const EdgeInsets.all(4.0),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text("Uploaded",style:
                                                      TextStyle(
                                                        color: Colors.green,
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w500
                                                      )
                                                      ,),
                                                    Row(

                                                      children: [
                                                        IconButton(onPressed: ()async{

                                                         await val.getTimeTableView(val.divisionList[index].value.toString());

                                                         return showDialog<void>(
                                                           context: context,
                                                           barrierDismissible: true, // Allow dismissal by tapping outside the dialog
                                                           builder: (BuildContext context) {
                                                             return Dialog(
                                                               child: SizedBox(
                                                                 height: size.height*0.6,
                                                                 width: size.width*0.8,
                                                                 child:

                                                                 val.extension=='.pdf'?
                                                                 SfPdfViewer.network(

                                                                   val.url == null ? '--' : val.url.toString(),
                                                                 ):
                                                                 PhotoView(
                                                                   backgroundDecoration: const BoxDecoration(color: UIGuide.WHITE),
                                                                   loadingBuilder: (context, event) {
                                                                     return spinkitLoader();
                                                                   },
                                                                   imageProvider: NetworkImage(
                                                                     val.url==''
                                                                         ? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSlmeGlXoJwwpbCE9jGgHgZ2XaE5nnPUSomkZz_vZT7&s'
                                                                         : val.url.toString(),
                                                                   ),
                                                                 ),
                                                               ),
                                                             );
                                                           },
                                                         );


                                                        },
                                                            icon: Icon(Icons.visibility_rounded,
                                                            size: 20,
                                                            color: UIGuide.light_Purple,
                                                            )),

                                                    IconButton(onPressed: ()async {

                                                      await val.getTimeTableView(val.divisionList[index].value.toString());
                                                         print("lini");
                                                          print(val.url);
                                                          print(val.name);
                                                      await requestDownload(val.url.toString(),val.name.toString());

                                                    },
                                                        icon: Icon(Icons.download,
                                                        size: 20,
                                                        color: UIGuide.button1,
                                                        )),
                                                      ],
                                                    ),
                                                    IconButton(onPressed: ()async {
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext context) {
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
                                                                        left: 8.0),
                                                                    child: OutlinedButton(
                                                                      onPressed: () {
                                                                        Navigator.of(
                                                                            context)
                                                                            .pop();
                                                                      },
                                                                      style: ButtonStyle(
                                                                          side: MaterialStateProperty.all(const BorderSide(
                                                                              color: UIGuide
                                                                                  .light_Purple,
                                                                              width: 1.0,
                                                                              style: BorderStyle
                                                                                  .solid))),
                                                                      child: const Text(
                                                                        '  Cancel  ',
                                                                        style: TextStyle(
                                                                          color: Color
                                                                              .fromARGB(
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
                                                                      await val.timtableDelete(
                                                                          context,
                                                                          val.divisionList[index].value.toString(),
                                                                          val.divisionList[index].fileId.toString(),
                                                                          index);

                                                                      Navigator.of(
                                                                          context)
                                                                          .pop();
                                                                      await val.clearList();
                                                                      await val.getDivisionList(course);
                                                                    },
                                                                    style: ButtonStyle(
                                                                        side: MaterialStateProperty.all(const BorderSide(
                                                                            color: UIGuide
                                                                                .light_Purple,
                                                                            width: 1.0,
                                                                            style: BorderStyle
                                                                                .solid))),
                                                                    child: const Text(
                                                                      'Confirm',
                                                                      style: TextStyle(
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
                                                        icon: Icon(Icons.delete_forever_rounded,
                                                          color: UIGuide.button2,
                                                          size: 20,

                                                        )),
                                                  ],
                                                ),
                                              )

                                                ],

                                              ):

                                                Column(

                                                  children: [
                                                    Row(
                                                      children:[

                                                        SizedBox(
                                                          height: 40,
                                                          width: size.width*.40,
                                                          child: Consumer<TimeTableUploadProvider>(
                                                            builder: (context, value, child) =>
                                                            // value.loading
                                                            //     ? const Center(
                                                            //     child: Text(
                                                            //       'Uploading Image....',
                                                            //       style: TextStyle(color: UIGuide.light_Purple),
                                                            //     ))
                                                            //     :
                                                            ElevatedButton(
                                                              style: ElevatedButton.styleFrom(
                                                                elevation: 3,
                                                                foregroundColor: UIGuide.BLACK,
                                                                backgroundColor: UIGuide.ButtonBlue,
                                                                padding: const EdgeInsets.all(0),
                                                                shape: RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.circular(10),
                                                                  side: const BorderSide(
                                                                    color: UIGuide.light_black,
                                                                  ),
                                                                ),
                                                              ),
                                                              onPressed: () async {
                                                                final result = await FilePicker.platform.pickFiles(
                                                                  type: FileType.custom,
                                                                    allowedExtensions: [ 'pdf',
                                                                      'png',
                                                                      'jpeg',
                                                                      'jpg','jfif']
                                                                );

                                                                if (result != null) {
                                                                  final file = result.files.first;
                                                                  setState(() {
                                                                    value.divisionList[index].fileName=file.path;
                                                                    value.divisionList[index].imageName=file.name;

                                                                  });

                                                                  int sizee = file.size;

                                                                  if (sizee <= 200000) {

                                                                     await val.timetableImagesave(context, value.divisionList[index].fileName.toString());
                                                                      print("imageeeeeeeee${val.imageid}");
                                                                    value.divisionList[index].imageId = val.imageid;


                                                                  } else {
                                                                    print('Size Exceed');
                                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                                      const SnackBar(
                                                                        content: Text(
                                                                          "Size Exceed (Less than 200KB allowed)",
                                                                          textAlign: TextAlign.center,
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }
                                                                }
                                                              },
                                                              child: Text(
                                                                value.divisionList[index].imageId==null ? 'Choose File' : 'File Added',
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        val.divisionList[index].imageId==null||val.divisionList[index].imageId=='' ?
                                                            Padding(
                                                              padding: const EdgeInsets.only(left: 8.0),
                                                              child: SizedBox(
                                                                height: 0,width: 0,
                                                              ),
                                                            ):
                                                        IconButton(onPressed: ()async{

                                                           await  val.timeTableUpload(
                                                                context,
                                                                val.divisionList[index].value.toString(),
                                                                val.divisionList[index].text.toString(),
                                                               val.divisionList[index].imageId.toString()
                                                             );
                                                             val.clearList();
                                                             await val.getDivisionList(course);


                                                        },
                                                            icon: Icon(
                                                              Icons.upload,size: 25,color: Colors.green,
                                                            )
                                                        ),
                                                        SizedBox(
                                                          width: size.width*0.4,
                                                          child: Text(
                                                              val.divisionList[index].imageId == "" || val.divisionList[index].imageId == null?
                                                              'No File Chosen' : val.divisionList[index].imageName.toString(),
                                                            maxLines: 1,
                                                            overflow: TextOverflow.ellipsis,
                                                            softWrap: false,
                                                            style: TextStyle(color: Colors.black,fontSize: 14.0),
                                                          ),
                                                        ),


                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets.only(left: 10.0),
                                                          child: Text("(Maximum allowed file(png,jpg,jpeg,pdf,jfif)\n size is 200 KB)",
                                                          overflow: TextOverflow.ellipsis,
                                                          style: TextStyle(
                                                            color: Colors.orangeAccent
                                                          ),
                                                          ),
                                                        ),

                                                      ],
                                                    )
                                                  ],
                                                ),




                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),


          ],),),

    );
  }
}




class TimeTableUplaodStaff extends StatefulWidget {
  const TimeTableUplaodStaff({super.key});

  @override
  State<TimeTableUplaodStaff> createState() => _TimeTableUplaodStaffState();
}

class _TimeTableUplaodStaffState extends State<TimeTableUplaodStaff> {
  List subjectData = [];
  // List<MaterialStatesController> _controllers = [];
  late final MaterialStatesController? _controllers;
  String section ='';

  String filename='';
  String imagePath='';

  List itemImagePaths = [];
  TextEditingController fileController = TextEditingController();
  List<PlatformFile?> imageFiles = List.generate(5, (index) => null);
  int sizee=0;
  final ReceivePort _port = ReceivePort();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var p = Provider.of<TimeTableUploadProvider>(context, listen: false);
      p.getCourseList();
      p.sectionCounter(0);
      p.sectionDrop.clear();
      p.sectionList.clear();
      p.clearStaffList();
      p.setLoading(false);
      p.imageid='';

      IsolateNameServer.registerPortWithName(
          _port.sendPort, 'downloader_send_port');
      _port.listen((dynamic data) {
        String id = data[0];
        DownloadTaskStatus status = data[1];
        int progress = data[2];

        setState(() {});
      });

      FlutterDownloader.registerCallback(downloadCallback);


    });
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
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Downloading file...'),
      duration: Duration(seconds: 2), // Adjust duration as needed
    ));

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
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Download complete'),
      duration: Duration(seconds: 1), // Adjust duration as needed
    ));
  }

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    var size= MediaQuery.of(context).size;
    return Scaffold(
      body: Consumer<TimeTableUploadProvider>(
        builder: (context, val, _) => Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Consumer<TimeTableUploadProvider>(
                  builder: (context, value, child) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: MultiSelectDialogField(
                        // height: 200,
                        items: value.sectionDrop,

                        listType: MultiSelectListType.CHIP,
                        title: const Text(
                          "Select Section",
                          style: TextStyle(color: Colors.grey),
                        ),
                        selectedItemsTextStyle: const TextStyle(
                            fontWeight: FontWeight.w900,
                            color: UIGuide.light_Purple),
                        confirmText: const Text(
                          'OK',
                          style: TextStyle(color: UIGuide.light_Purple),
                        ),
                        cancelText: const Text(
                          'Cancel',
                          style: TextStyle(color: UIGuide.light_Purple),
                        ),
                        separateSelectedItems: true,
                        //  checkColor: Colors.lightBlue,
                        decoration: const BoxDecoration(
                          color: UIGuide.ButtonBlue,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0, 2),
                              blurRadius: 4,
                              spreadRadius: 0,
                            ),
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        buttonIcon: const Icon(
                          Icons.arrow_drop_down_outlined,
                          color: Colors.grey,
                        ),
                        buttonText: value.secLen == 0
                            ? const Text(
                          "Select Setion",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        )
                            : Text(
                          "   ${value.secLen.toString()} Selected",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        chipDisplay: MultiSelectChipDisplay.none(),
                        onConfirm: (results) async {
                          subjectData = [];
                          for (var i = 0; i < results.length; i++) {
                            Sections data =
                            results[i] as Sections;

                            subjectData.add(data.value);
                            subjectData.map((e) => data.value);
                            print("${subjectData.map((e) => data.value)}");
                          }
                          section = subjectData.join(',');
                          await Provider.of<TimeTableUploadProvider>(context,
                              listen: false)
                              .sectionCounter(results.length);
                          await val.clearStaffList();
                          print("data $section");

                          print(subjectData.join(','));
                        },
                      ),
                    ),
                  ),
                ),
                //  const Spacer(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10),
                    child: SizedBox(
                      height: 43,
                      child: Consumer<TimeTableUploadProvider>(
                        builder: (context, val, child) => val.loading
                            ? const Center(
                            child: Text(
                              "Loading",
                              style: TextStyle(
                                  color: UIGuide.light_Purple, fontSize: 16),
                            ))
                            : ElevatedButton(

                          style: ElevatedButton.styleFrom(
                            elevation: 3,
                            foregroundColor: UIGuide.WHITE,
                            backgroundColor: UIGuide.light_Purple,
                            padding: const EdgeInsets.all(0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: const BorderSide(
                                  color: UIGuide.light_black,
                                )),
                          ),
                          onPressed: () async {
                            await val.clearStaffList();
                            val.imageid='';

                            await val.getStaffList(section);


                            if (val.staffList.isEmpty) {
                              snackbarWidget(
                                  2,
                                  "No data for specified condition",
                                  context);
                            }
                          },
                          child: const Text(
                            'View',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),

            Expanded(
              child: Container(
                //height: size.height*80,
                child: AnimationLimiter(
                  child:

                  ListView.builder(
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    itemCount: val.staffList.isEmpty
                        ? 0
                        : val.staffList.length,
                    itemBuilder: (BuildContext context, int index) {



                      return AnimationConfiguration.staggeredList(
                        position: index,
                        delay: const Duration(milliseconds: 100),
                        child: SlideAnimation(
                          duration: const Duration(milliseconds: 2500),
                          curve: Curves.fastLinearToSlowEaseIn,
                          child: FadeInAnimation(
                            curve: Curves.fastLinearToSlowEaseIn,
                            duration: const Duration(milliseconds: 2500),
                            child: Stack(
                              children: [


                                Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Container(
                                    width: size.width,
                                    decoration: BoxDecoration(
                                      // color: const Color.fromARGB(
                                      //     255, 234, 234, 236),
                                      border: Border.all(
                                          color: UIGuide.light_Purple),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(8),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Container(
                                        width: size.width,
                                        decoration: const BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(5),
                                          ),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                              const EdgeInsets.all(4.0),
                                              child: Row(
                                                children: [
                                                  //  kWidth,
                                                  Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.black12,
                                                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(3),topRight: Radius.circular(3)),
                                                      ),


                                                      child: Text((index+1).toString())

                                                  ),
                                                  kWidth,
                                                  Flexible(
                                                    child: RichText(
                                                      overflow: TextOverflow
                                                          .ellipsis,
                                                      strutStyle:
                                                      const StrutStyle(
                                                          fontSize:
                                                          15.0),
                                                      text: TextSpan(
                                                        style: const TextStyle(
                                                            color: UIGuide
                                                                .light_Purple,
                                                            fontWeight:
                                                            FontWeight
                                                                .w500),
                                                        text: val
                                                            .staffList[
                                                        index]
                                                            .text ==
                                                            null
                                                            ? '--'
                                                            : val
                                                            .staffList[
                                                        index]
                                                            .text
                                                            .toString(),
                                                      ),
                                                    ),
                                                  ),


                                                ],
                                              ),
                                            ),
                                            kheight5,


                                            val.staffList[index].teacherTTUploadId!= null?
                                            Row(

                                              children:[
                                                kWidth20,
                                                Padding(
                                                  padding: const EdgeInsets.all(4.0),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text("Uploaded",style:
                                                      TextStyle(
                                                          color: Colors.green,
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w500
                                                      )
                                                        ,),
                                                      Row(

                                                        children: [
                                                          IconButton(onPressed: ()async{

                                                            await val.getStaffTimeTableView(val.staffList[index].value.toString());

                                                            return showDialog<void>(
                                                              context: context,
                                                              barrierDismissible: true, // Allow dismissal by tapping outside the dialog
                                                              builder: (BuildContext context) {
                                                                return Dialog(
                                                                  child: SizedBox(
                                                                    height: size.height*0.6,
                                                                    width: size.width*0.8,
                                                                    child:

                                                                    val.stextension=='.pdf'?
                                                                    SfPdfViewer.network(

                                                                      val.sturl == null ? '--' : val.sturl.toString(),
                                                                    ):
                                                                    PhotoView(
                                                                      backgroundDecoration: const BoxDecoration(color: UIGuide.WHITE),
                                                                      loadingBuilder: (context, event) {
                                                                        return spinkitLoader();
                                                                      },
                                                                      imageProvider: NetworkImage(
                                                                        val.sturl==''
                                                                            ? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSlmeGlXoJwwpbCE9jGgHgZ2XaE5nnPUSomkZz_vZT7&s'
                                                                            : val.sturl.toString(),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            );


                                                          },
                                                              icon: Icon(Icons.visibility_rounded,
                                                                size: 20,
                                                                color: UIGuide.light_Purple,
                                                              )),

                                                          IconButton(onPressed: ()async {
                                                            await val.getStaffTimeTableView(val.staffList[index].value.toString());
                                                            requestDownload(val.sturl.toString(), val.stname.toString());

                                                          },
                                                              icon: Icon(Icons.download,
                                                                size: 20,
                                                                color: UIGuide.button1,
                                                              )),
                                                        ],
                                                      ),
                                                      IconButton(onPressed: ()async {
                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext context) {
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
                                                                          left: 8.0),
                                                                      child: OutlinedButton(
                                                                        onPressed: () {
                                                                          Navigator.of(
                                                                              context)
                                                                              .pop();
                                                                        },
                                                                        style: ButtonStyle(
                                                                            side: MaterialStateProperty.all(const BorderSide(
                                                                                color: UIGuide
                                                                                    .light_Purple,
                                                                                width: 1.0,
                                                                                style: BorderStyle
                                                                                    .solid))),
                                                                        child: const Text(
                                                                          '  Cancel  ',
                                                                          style: TextStyle(
                                                                            color: Color
                                                                                .fromARGB(
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
                                                                        await val.stafftimtableDelete(
                                                                            context,
                                                                            val.staffList[index].value.toString(),
                                                                            val.staffList[index].fileId.toString(),
                                                                            index);

                                                                        Navigator.of(
                                                                            context)
                                                                            .pop();
                                                                        await val.clearStaffList();
                                                                        await val.getStaffList(section);
                                                                      },
                                                                      style: ButtonStyle(
                                                                          side: MaterialStateProperty.all(const BorderSide(
                                                                              color: UIGuide
                                                                                  .light_Purple,
                                                                              width: 1.0,
                                                                              style: BorderStyle
                                                                                  .solid))),
                                                                      child: const Text(
                                                                        'Confirm',
                                                                        style: TextStyle(
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
                                                          icon: Icon(Icons.delete_forever_rounded,
                                                            color: UIGuide.button2,
                                                            size: 20,

                                                          )),
                                                    ],
                                                  ),
                                                )

                                              ],

                                            ):

                                            Column(

                                              children: [
                                                Row(
                                                  children:[

                                                    SizedBox(
                                                      height: 40,
                                                      width: size.width*.40,
                                                      child: Consumer<TimeTableUploadProvider>(
                                                        builder: (context, value, child) =>
                                                        // value.loading
                                                        //     ? const Center(
                                                        //     child: Text(
                                                        //       'Uploading Image....',
                                                        //       style: TextStyle(color: UIGuide.light_Purple),
                                                        //     ))
                                                        //     :
                                                        ElevatedButton(
                                                          style: ElevatedButton.styleFrom(
                                                            elevation: 3,
                                                            foregroundColor: UIGuide.BLACK,
                                                            backgroundColor: UIGuide.ButtonBlue,
                                                            padding: const EdgeInsets.all(0),
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(10),
                                                              side: const BorderSide(
                                                                color: UIGuide.light_black,
                                                              ),
                                                            ),
                                                          ),
                                                          onPressed: () async {
                                                            final result = await FilePicker.platform.pickFiles(
                                                              type: FileType.custom,
                                                                allowedExtensions: [ 'pdf',
                                                                  'png',
                                                                  'jpeg',
                                                                  'jpg','jfif']
                                                            );

                                                            if (result != null) {
                                                              final file = result.files.first;
                                                              setState(() {
                                                                value.staffList[index].fileName=file.path;
                                                                value.staffList[index].imageName=file.name;

                                                              });

                                                              int sizee = file.size;

                                                              if (sizee <= 200000) {

                                                                await val.timetableImagesave(context, value.staffList[index].fileName.toString());
                                                                print("imageeeeeeeee${val.imageid}");
                                                                value.staffList[index].imageId = val.imageid;


                                                              } else {
                                                                print('Size Exceed');
                                                                ScaffoldMessenger.of(context).showSnackBar(
                                                                  const SnackBar(
                                                                    content: Text(
                                                                      "Size Exceed (Less than 200KB allowed)",
                                                                      textAlign: TextAlign.center,
                                                                    ),
                                                                  ),
                                                                );
                                                              }
                                                            }
                                                          },
                                                          child: Text(
                                                            value.staffList[index].imageId==null ? 'Choose File' : 'File Added',
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    val.staffList[index].imageId==null||val.staffList[index].imageId=='' ?
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 8.0),
                                                      child: SizedBox(
                                                        height: 0,width: 0,
                                                      ),
                                                    ):
                                                    IconButton(onPressed: ()async{

                                                      await  val.stafftimeTableUpload(
                                                          context,
                                                          val.staffList[index].value.toString(),
                                                          val.staffList[index].text.toString(),
                                                          val.staffList[index].imageId.toString()
                                                      );
                                                      val.clearStaffList();
                                                      await val.getStaffList(section);


                                                    },
                                                        icon: Icon(
                                                          Icons.upload,size: 25,color: Colors.green,
                                                        )
                                                    ),
                                                    SizedBox(
                                                      width: size.width*0.4,
                                                      child: Text(
                                                        val.staffList[index].imageId == "" || val.staffList[index].imageId == null?
                                                        'No File Chosen' : val.staffList[index].imageName.toString(),
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                        softWrap: false,
                                                        style: TextStyle(color: Colors.black,fontSize: 14.0),
                                                      ),
                                                    ),


                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 10.0),
                                                      child: Text("(Maximum allowed file(png,jpg,jpeg,pdf,jfif)\n size is 200 KB)",
                                                        overflow: TextOverflow.ellipsis,
                                                        style: TextStyle(
                                                            color: Colors.orangeAccent
                                                        ),
                                                      ),
                                                    ),

                                                  ],
                                                )
                                              ],
                                            ),




                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),


          ],),),

    );
  }
}
