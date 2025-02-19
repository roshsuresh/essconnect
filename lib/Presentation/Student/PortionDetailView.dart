import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';


import 'package:carousel_slider/carousel_slider.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../Application/StudentProviders/CurriculamProviders.dart';
import '../../Application/StudentProviders/PortionProvider.dart';
import '../../Constants.dart';
import '../../Domain/Student/PortionModel.dart';
import '../../utils/TextWrap(moreOption).dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../utils/spinkit.dart';
class StudentPortions extends StatefulWidget {
   StudentPortions({super.key,required this.date,required this.status,this.viewPrev});
  String date;
  String status;
  String? viewPrev;


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
      await Provider.of<
          Curriculamprovider>(
          context,
          listen: false)
          .getCuriculamAceesstoken();
      await p.setLoading(false);
      p.studportionDetailList.clear();
      p.photoList.clear();
      await p.getStudentPortionDetailList(widget.date,widget.status);
      print("dateeeedee");
      p.studportionList.clear();
      p.studportionListpre.clear();
      p.studportionListByDate.clear();

      await p.getStudentPortionList();
      await p.getStudentPortionListPrevious(widget.viewPrev!);
      await p.getStudentPortionListByDate();
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

  Future<Image> _loadImage(BuildContext context, String imageUrl) async {
    // Simulate a network request to load the image
    final Image image = Image.network(imageUrl);
    final Completer<void> completer = Completer();
    final ImageStreamListener listener = ImageStreamListener(
          (ImageInfo info, bool _) {
        completer.complete();
      },
      onError: (dynamic error, StackTrace? stackTrace) {
        completer.completeError(error);
      },
    );

    image.image.resolve(ImageConfiguration()).addListener(listener);
    await completer.future;
    return image;
  }
  Future<void> showPhotoDialog(BuildContext context,String photo,String ext) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        var size= MediaQuery.of(context).size;
        return AlertDialog(
          content: Container(

            height:size.height*0.6,
            child: Center(
              child: CircularProgressIndicator(
                color: UIGuide.light_Purple,
              ),
            ),
          ),
        );
      },
    );

    try {
      Image image = await _loadImage(context, photo);
      Navigator.of(context).pop(); // Remove the loading dialog

      showDialog(
        context: context,
        builder: (BuildContext context) {
          var size= MediaQuery.of(context).size;
          return AlertDialog(
            content: Container(

              height: size.height*0.6,
              child: image,
            ),
          );
        },
      );
    } catch (e) {
      Navigator.of(context).pop(); // Remove the loading dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          var size= MediaQuery.of(context).size;

          return
            Dialog(
              child: Container(
                padding: EdgeInsets.all(4.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ext==".pdf"?
                    SizedBox(
                        height:size.height*0.6 ,
                        child: SfPdfViewer.network(photo)):
                    SizedBox(
                      height:size.height*0.6 ,
                      child: Image.network(
                        photo,
                      ),
                    ),
                    //  SizedBox(height: size),
                    //   ElevatedButton(
                    //     style: ElevatedButton.styleFrom(
                    //       backgroundColor: UIGuide.light_Purple,
                    //     ),
                    //     onPressed: () {
                    //       Navigator.of(context).pop();
                    //
                    //     },
                    //     child: Text('Close'),
                    //   ),
                  ],
                ),
              ),
            );

        },
      );
    }
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
    Fluttertoast.showToast(
      msg: "Downloading Started..",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      fontSize: 14.0,
    );


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

    Fluttertoast.showToast(
      msg: "Downloaded Successfully..",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      fontSize: 14.0,
    );

    // Show a snackbar to indicate all files are downloaded
    }





  @override
  Widget build(BuildContext context) {
    var size= MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Portion'),
        titleSpacing: 00.0,
        centerTitle: true,
        toolbarHeight: 60.2,
        toolbarOpacity: 0.8,
        // shape: const RoundedRectangleBorder(
        //   borderRadius: BorderRadius.only(
        //       bottomRight: Radius.circular(25),
        //       bottomLeft: Radius.circular(25)),
        // ),
        backgroundColor: UIGuide.light_Purple,
      ),


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
                          lineXY: 0.30,
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
                                          LinkTextWidget(text: value.studportionDetailList[index].details ?? "--"),

                                          // TextWrapper(text: value.studportionDetailList[index].details ?? "--",
                                          //     fSize: 12),
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
                                          value.studportionDetailList[index].photoList!.isEmpty?
                                          SizedBox(height: 0,):kheight10,

                                          value.studportionDetailList[index].photoList!.isEmpty?
                                          const SizedBox(height: 0,width: 0,):
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


                                                  showDialog(
                                                    context: context,
                                                    builder: (BuildContext context) {
                                                      return  CarouselDialog(urlImages: imageUrls,imageName:imageName,ext: imageExtension,);
                                                    },
                                                  );


                                                },
                                                child: const SizedBox(
                                                  height: 25,width: 25,
                                                  child: Icon(
                                                      Icons.visibility_rounded
                                                  ),
                                                ),
                                              ),
                                              kWidth20,
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

                                                child: const SizedBox(
                                                  height: 25,width: 25,
                                                  child: Icon(
                                                      Icons.download
                                                  ),
                                                ),
                                              ),

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
    Fluttertoast.showToast(
      msg: "Downloading Started..",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      fontSize: 14.0,
    );

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
    Fluttertoast.showToast(
      msg: "Downloading Finished..",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      fontSize: 14.0,
    );
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
                  return SfPdfViewer.network(content);
                } else  {
                  // Display image from URL
                  return Image.network(content,

                    loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            color: UIGuide.light_Purple,
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                                : null,
                          ),
                        );
                      }
                    },
                  );
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
            GestureDetector(
                onTap: ()async{
                  await requestDownload(widget.urlImages[_currentIndex], widget.imageName[_currentIndex]);
                },
                child: Container(
                    color: UIGuide.THEME_LIGHT,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Press here to Download File '),
                        Icon(Icons.download)
                      ],
                    )))
          ],
        ),
      ),

    );
  }
}