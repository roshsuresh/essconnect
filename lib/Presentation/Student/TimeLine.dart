import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../Application/StudentProviders/PortionProvider.dart';
import '../../Constants.dart';
import '../../Domain/Student/PortionModel.dart';
import '../../utils/TextWrap(moreOption).dart';
import 'package:dots_indicator/dots_indicator.dart';

import '../../utils/spinkit.dart';
class StudentPortions extends StatefulWidget {
   StudentPortions({super.key,required this.date});
  String date;

  @override
  State<StudentPortions> createState() => _StudentPortionsState();
}

class _StudentPortionsState extends State<StudentPortions> {
  int _currentIndex=0;

  List<String> imageUrls = [];
  List<String> imageName = [];
  List<String> imageExtension = [];
  final ReceivePort _port = ReceivePort();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var p = Provider.of<StudentPortionProvider>(context, listen: false);
      // await Provider.of<
      //     Curriculamprovider>(
      //     context,
      //     listen: false)
      //     .getCuriculamAceesstoken();
      await p.setLoading(false);
      p.studportionDetailList.clear();
      p.photoList.clear();
      await p.getStudentPortionDetailList(widget.date);
      print("dateeeedee");
      //print(p.studportionDetailList[0].date);

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

  Future<void> downloadFiles(List<String> fileUrls,List<String> fileName) async {
    var _localPath;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Downloading Started..'),
    ));


      if (Platform.isAndroid) {
        _localPath = '/storage/emulated/0/Download';
      } else if (Platform.isIOS) {
        final dir = await getApplicationDocumentsDirectory();
        _localPath = dir.path;
      }
      print("pathhhhh  $_localPath");
      final savedDir = Directory(_localPath);
    for(int i=0;i<fileUrls.length;i++){
      await savedDir.create(recursive: true).then((value) async {
        String? _taskid = await FlutterDownloader.enqueue(
          savedDir: _localPath,
          url: fileUrls[i],
          fileName:fileName[i],
          showNotification: true,
          openFileFromNotification: true,
          // Open file when download is complete
        );
      });
    }

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Files downloaded successfully'),
    ));


    // Show a snackbar to indicate all files are downloaded
    }




  final CarouselController _carouselController = CarouselController();
  @override
  Widget build(BuildContext context) {
    var size= MediaQuery.of(context).size;
    return Scaffold(
      body:  Consumer<StudentPortionProvider>(
          builder: (context, value, _)=>
          value.loading
              ? spinkitLoader()
              :  Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(begin: Alignment.bottomRight, stops: [
                    0.1,
                    0.9
                  ], colors: [
                    Color.fromARGB(255, 64, 107, 183),
                    Color.fromARGB(255, 137, 157, 194),
                  ])),
              child: Padding(
                padding: const EdgeInsets.only(top: 25.0,bottom: 10),
                child: AnimationLimiter(
                  child: ListView.builder(
                                  // physics: NeverScrollableScrollPhysics(),
                     itemCount: value.studportionDetailList.length,
                    itemBuilder: (context, index) {
                      DateTime dateTime = DateTime.parse(value.studportionDetailList[index].date!);
                      String formattedDate = DateFormat("dd-MM-yyyy").format(dateTime);
                     return AnimationConfiguration.staggeredList(
                          position: index,
                          delay: const Duration(milliseconds: 100),
                          child: SlideAnimation(
                          duration: const Duration(milliseconds: 2500),
                      curve: Curves.fastEaseInToSlowEaseOut,
                      child: FadeInAnimation(
                      curve: Curves.fastEaseInToSlowEaseOut,
                      duration: const Duration(milliseconds: 2500),
                       child: TimelineTile(
                          startChild: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(height: 30,
                              decoration: const BoxDecoration(
                                color: Colors.white70,
                                borderRadius: BorderRadius.all(Radius.circular(10))
                              ),
                              child: Center(child: Text(formattedDate)),

                            ),
                          ),
                          alignment: TimelineAlign.manual,
                          lineXY: 0.25,
                          isFirst: index == 0,
                          isLast: index == 20,
                          indicatorStyle: IndicatorStyle(
                            width: 20,
                            color: Colors.grey,
                            iconStyle: IconStyle(iconData: Icons.menu_book_outlined, color: UIGuide.light_Purple,fontSize: 15),
                          ),
                          endChild: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              constraints: const BoxConstraints(
                                minHeight: 100,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),

                                  color: Colors.white70,

                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              value.studportionDetailList[index].subject.toString(),
                                              style: const TextStyle(
                                                color: UIGuide.light_Purple,
                                                fontWeight: FontWeight.w500
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          kheight10,
                                          const Text("Chapter",
                                            style: TextStyle(
                                                color: UIGuide
                                                    .light_Purple,
                                                fontWeight:
                                                FontWeight
                                                    .w500),),
                                               TextWrapper(text: value.studportionDetailList[index].chapter ?? "--",
                                             fSize: 12),
                                          kheight5,
                                          const Text("Topic",
                                            style: TextStyle(
                                                color: UIGuide
                                                    .light_Purple,
                                                fontWeight:
                                                FontWeight
                                                    .w500),),
                                          TextWrapper(text: value.studportionDetailList[index].topic ?? "--",
                                              fSize: 12),
                                          kheight5,


                                          const Text("Description",
                                            style: TextStyle(
                                                color: UIGuide
                                                    .light_Purple,
                                                fontWeight:
                                                FontWeight
                                                    .w500),),
                                          TextWrapper(text: value.studportionDetailList[index].description ?? "--",
                                              fSize: 12),
                                          kheight5,

                                          const Text("Details",
                                            style: TextStyle(
                                                color: UIGuide
                                                    .light_Purple,
                                                fontWeight:
                                                FontWeight
                                                    .w500),),
                                          TextWrapper(text: value.studportionDetailList[index].details ?? "--",
                                              fSize: 12),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  const Text("Send by: "),
                                                  Text(value.studportionDetailList[index].submittedBy.toString(),
                                                    style: const TextStyle(
                                                    color: UIGuide.light_Purple
                                                  ),
                                                  overflow: TextOverflow.ellipsis,
                                                  )
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  InkWell(
                                                    onTap: (){
                                                      List<PhotoList> photoList = value.studportionDetailList.isNotEmpty ? value.studportionDetailList[index].photoList! : [];
                                                      imageUrls.clear();
                                                      imageName.clear();
                                                      imageExtension.clear();
                                                      if(photoList.isNotEmpty) {
                                                        for (int i = 0; i < photoList.length; i++) {
                                                          imageUrls.add(photoList[i].url!);
                                                          imageName.add(photoList[i].name!);
                                                          imageExtension.add(photoList[i].extension!);

                                                        }
                                                      }
                                                      photoList.isEmpty?
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
                                                            'No Attachments Found..',
                                                            textAlign: TextAlign.center,
                                                          ),
                                                        ),
                                                      ):
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext context) {
                                                       return  CarouselDialog(urlImages: imageUrls,imageName:imageName,ext: imageExtension,);
                                                        },
                                                      );


                                                    },
                                                    child: SizedBox(
                                                      height: 25,width: 25,
                                                      child: Icon(
                                                        Icons.visibility_rounded
                                                      ),
                                                    ),
                                                  ),
                                                 kWidth,
                                                  InkWell(
                                                    onTap: () async{
                                              List<PhotoList> photoList = value.studportionDetailList.isNotEmpty ? value.studportionDetailList[index].photoList! : [];
                                              imageUrls.clear();
                                              imageName.clear();
                                              imageExtension.clear();
                                              if(photoList.isNotEmpty) {
                                              for (int i = 0; i < photoList.length; i++) {
                                                imageUrls.add(
                                                    photoList[i].url!);
                                                imageName.add(
                                                    photoList[i].name!);
                                                imageExtension.add(
                                                    photoList[i].extension!);
                                              }}

                                              if(photoList.isEmpty){
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
                                                'No Attachments Found..',
                                                textAlign: TextAlign.center,
                                                ),
                                                ),
                                                );
                                              }

                                                   else{


                                                    await downloadFiles(imageUrls,imageName);


                                                    }
                                                    },

                                                    child: SizedBox(
                                                      height: 25,width: 25,
                                                      child: Icon(
                                                          Icons.download
                                                      ),
                                                    ),
                                                  ),

                                                ],
                                              )

                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),
                          beforeLineStyle: LineStyle(
                            color: UIGuide.THEME_LIGHT,
                          ),
                          afterLineStyle: LineStyle(
                            color: UIGuide.THEME_LIGHT,
                          ),
                        ),
                     ))
                     );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class CarouselDialog extends StatefulWidget {
  CarouselDialog({super.key,required this.urlImages,required this.imageName,required this.ext});
  List urlImages=[];
  List imageName=[];
  List ext=[];
  @override
  _CarouselDialogState createState() => _CarouselDialogState();
}

class _CarouselDialogState extends State<CarouselDialog> {

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
        fileName: _name,
        showNotification: true,
        openFileFromNotification: true,
      );

      print(_taskid);
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Download complete'),
      duration: Duration(seconds: 1), // Adjust duration as needed
    ));
  }
  int _currentIndex = 0;



  @override
  Widget build(BuildContext context) {
    var size= MediaQuery.of(context).size;
    return AlertDialog(
      //insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      content: Container(

        height: size.height*0.70,
        width: size.width*0.8,
        child: Column(
       mainAxisSize: MainAxisSize.min,
          children: [
            CarouselSlider.builder(
              itemCount: widget.urlImages.length,
              itemBuilder: (BuildContext context, int index, int realIndex) {
                final content = widget.urlImages[index];
                if (widget.ext[index]=='.pdf') {
                  // Display PDF
                  return InkWell(
                    onLongPress: (){
                      requestDownload(widget.urlImages[index], widget.imageName[index]);
                    },

                      child: Image.asset('assets/images1.png'));
                } else  {
                  // Display image from URL
                  return InkWell(
                    onLongPress: (){
                      requestDownload(widget.urlImages[index], widget.imageName[index]);
                    },
                      child: Image.network(content));
                }
              },
              options: CarouselOptions(
                height: size.height*0.6,
                //autoPlay: true,
            enlargeCenterPage: true,
                viewportFraction: 1.0,
                onPageChanged: (index, _) {
                  setState(() {
                    _currentIndex = index;
                    print(widget.ext[index]);
                  });
                },
              ),
            ),

            DotsIndicator(
              dotsCount: widget.urlImages.length,
              position: _currentIndex,
              decorator: DotsDecorator(
                size: Size.square(8.0),
                activeSize: Size(20.0, 8.0),
                activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
              ),
            ),
            kheight5,
            Text('Long Press to Download File')
          ],
        ),
      ),

    );
  }
}