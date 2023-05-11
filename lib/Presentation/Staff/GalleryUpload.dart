import 'dart:io';

import 'package:essconnect/Application/Staff_Providers/GallerySendProviderStaff.dart';
import 'package:essconnect/utils/spinkit.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../Constants.dart';
import '../../utils/constants.dart';
import 'GalleryList.dart';
import 'GalleryReceived.dart';

class StaffGallery extends StatelessWidget {
  const StaffGallery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  const Spacer(),
                  const Text('Gallery'),
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const StaffGallery()));
                      },
                      icon: const Icon(Icons.refresh))
                ],
              ),
              bottom: const TabBar(
                physics: NeverScrollableScrollPhysics(),
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: Colors.white,
                indicatorWeight: 5,
                tabs: [
                  Tab(text: "Received"),
                  Tab(
                    text: "Send",
                  ),
                  Tab(
                    text: "List",
                  ),
                ],
              ),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25)),
              ),
              backgroundColor: UIGuide.light_Purple,
            ),
            body: TabBarView(children: [
              StaffGalleryView(),
              Consumer<GallerySendProvider_Stf>(
                builder: (context, value, child) {
                  if (value.isClassTeacher != false) {
                    return StaffGalleryUPload();
                  } else {
                    return Container(
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.sentiment_dissatisfied_outlined,
                              size: 60,
                              color: Colors.grey,
                            ),
                            kheight10,
                            Text(
                              "Sorry you don't have access",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
              const GalleryListStaff(),
            ])));
  }
}

class StaffGalleryUPload extends StatefulWidget {
  const StaffGalleryUPload({Key? key}) : super(key: key);

  @override
  State<StaffGalleryUPload> createState() => _StaffGalleryUPloadState();
}

class _StaffGalleryUPloadState extends State<StaffGalleryUPload> {
  // DateTime? _mydatetime;

  String? datee;

  DateTime? _mydatetimeFrom;

  DateTime? _mydatetimeTo;

  String time = '🗓️';

  String timeNow = '🗓️';

  String? checkname;

  final coursevalueController = TextEditingController();
  final coursevalueController1 = TextEditingController();
  final divisionvalueController = TextEditingController();
  final divisionvalueController1 = TextEditingController();
  final titleController = TextEditingController();
  String attachmentid = '';

  void initState() {
    super.initState();
    datee = DateFormat('dd/MMM/yyyy').format(DateTime.now());
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var p = Provider.of<GallerySendProvider_Stf>(context, listen: false);
      p.sendGallery();
      p.clearAllFilters();
      p.galleryCourse.clear();
      p.courseClear();
      p.divisionClear();
      p.removeCourseAll();
      p.removeDivisionAll();
      p.imageIDList.clear();
      // titleController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
                height: 35,
                highlightColor: UIGuide.THEME_LIGHT,
                minWidth: size.width / 2.4,
                color: Colors.white70,
                child: Text('Date: ${datee.toString()}'),
                onPressed: () async {
                  return;
                }),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: titleController,
            inputFormatters: [LengthLimitingTextInputFormatter(50)],
            minLines: 1,
            maxLines: 1,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              labelText: 'Title*',
              labelStyle: const TextStyle(color: UIGuide.light_Purple),
              hintText: 'Enter Title',
              hintStyle: const TextStyle(color: Colors.grey),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: UIGuide.light_Purple, width: 1.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ),
        Center(
          child: SizedBox(
            // width: 140,
            child: Consumer<GallerySendProvider_Stf>(
              builder: (context, value, child) => value.loading
                  ? spinkitLoader()
                  : MaterialButton(
                      // minWidth: size.width - 200,
                      height: 35,
                      highlightColor: UIGuide.THEME_LIGHT,
                      minWidth: size.width / 2.4,
                      color: Colors.white70,
                      onPressed: (() async {
                        List<File> filePaths = [];
                        List<String> fileP = [];
                        final result = await FilePicker.platform.pickFiles(
                            type: FileType.custom,
                            allowMultiple: true,
                            allowedExtensions: ['png', 'jpeg', 'jpg']);
                        if (result == null) {
                          return;
                        } else if (result.count <= 10) {
                          filePaths =
                              result.paths.map((path) => File(path!)).toList();
                          for (File file in filePaths) {
                            print('File size: ${await file.length()} bytes');
                            if (await file.length() <= 200000) {
                              fileP.add(file.path);
                              print("---------------$fileP");
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                      content: Text(
                                "Size Exceed (Less than 200KB allowed)",
                                textAlign: TextAlign.center,
                              )));
                            }
                          }
                          await Provider.of<GallerySendProvider_Stf>(context,
                                  listen: false)
                              .galleryImageSave(context, fileP);
                          print(fileP);
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                                  duration: Duration(seconds: 4),
                                  content: Text(
                                    "Can't upload more than 10 files",
                                    textAlign: TextAlign.center,
                                  )));
                        }

                        // final file = result.files.first;
                        // print('Name: ${file.name}');
                        // print('Path: ${file.path}');
                        // print('Extension: ${file.extension}');
                        // print('Size : ${file.size}');
                        // int sizee = file.size;

                        // if (sizee <= 200000) {
                        // await Provider.of<GallerySendProvider_Stf>(context,
                        // listen: false)
                        // .galleryImageSave(context, file.path.toString());
                        // attachmentid = value.id ?? '';
                        // if (file.name.length >= 6) {
                        // setState(() {
                        // checkname = file.name
                        // .replaceRange(6, file.name.length, '');
                        // });

                        // print(checkname);
                        // }
                        // } else {
                        // print('Size Exceed');
                        // ScaffoldMessenger.of(context)
                        // .showSnackBar(const SnackBar(
                        // elevation: 10,
                        // shape: RoundedRectangleBorder(
                        // borderRadius:
                        // BorderRadius.all(Radius.circular(10)),
                        // ),
                        // duration: Duration(seconds: 1),
                        // margin: EdgeInsets.only(
                        // bottom: 80, left: 30, right: 30),
                        // behavior: SnackBarBehavior.floating,
                        // content: Text(
                        // "Size Exceed(Less than 200KB allowed)",
                        // textAlign: TextAlign.center,
                        // ),
                        // ));
                        // }
                      }),
                      child: Text(value.imageIDList.isEmpty
                          ? 'Choose Image'
                          : "${value.imageIDList.length} Image added"),
                    ),
            ),
          ),
        ),
        const Center(
            child: Text(
          'Maximum allowed file size is 200 KB',
          style:
              TextStyle(fontSize: 9, color: Color.fromARGB(255, 241, 104, 94)),
        )),
        kheight10,
        Row(
          children: [
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: UIGuide.light_Purple, width: 1)),
                width: MediaQuery.of(context).size.width * 0.464,
                height: 40,
                child: MaterialButton(
                  // minWidth: size.width - 216,
                  color: Colors.white,
                  onPressed: (() async {
                    _mydatetimeFrom = await showDatePicker(
                      context: context,
                      initialDate: _mydatetimeFrom ?? DateTime.now(),
                      firstDate:
                          DateTime.now().subtract(const Duration(days: 0)),
                      lastDate: DateTime(2030),
                      builder: (context, child) {
                        return Theme(
                            data: ThemeData.light().copyWith(
                              primaryColor: UIGuide.light_Purple,
                              colorScheme: const ColorScheme.light(
                                primary: UIGuide.light_Purple,
                              ),
                              buttonTheme: const ButtonThemeData(
                                  textTheme: ButtonTextTheme.primary),
                            ),
                            child: child!);
                      },
                    );
                    setState(() {
                      time = DateFormat('dd/MMM/yyyy').format(_mydatetimeFrom!);
                      print(time);
                    });
                  }),
                  // minWidth: size.width - 216,
                  child: Center(child: Text('From  $time')),
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: UIGuide.light_Purple, width: 1)),
                width: MediaQuery.of(context).size.width * 0.464,
                height: 40,
                child: MaterialButton(
                  //  minWidth: size.width - 216,
                  color: Colors.white,
                  onPressed: (() async {
                    _mydatetimeTo = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate:
                          DateTime.now().subtract(const Duration(days: 0)),
                      lastDate: DateTime(2100),
                      builder: (context, child) {
                        return Theme(
                            data: ThemeData.light().copyWith(
                              primaryColor: UIGuide.light_Purple,
                              colorScheme: const ColorScheme.light(
                                primary: UIGuide.light_Purple,
                              ),
                              buttonTheme: const ButtonThemeData(
                                  textTheme: ButtonTextTheme.primary),
                            ),
                            child: child!);
                      },
                    );

                    setState(() {
                      timeNow =
                          DateFormat('dd/MMM/yyyy').format(_mydatetimeTo!);
                      print(timeNow);
                    });
                  }),
                  //  minWidth: size.width - 216,
                  child: Center(child: Text('To  $timeNow')),
                ),
              ),
            ),
            const Spacer()
          ],
        ),
        kheight10,
        Row(
          children: [
            const Spacer(),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.49,
              child: Consumer<GallerySendProvider_Stf>(
                  builder: (context, snapshot, child) {
                return InkWell(
                  onTap: () async {
                    await Provider.of<GallerySendProvider_Stf>(context,
                            listen: false)
                        .courseClear();
                    await Provider.of<GallerySendProvider_Stf>(context,
                            listen: false)
                        .sendGallery();
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                              child: Container(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: snapshot.courselistt.length,
                                    itemBuilder: (context, index) {
                                      print(snapshot.courselistt[index].value);

                                      return ListTile(
                                        selectedTileColor: Colors.blue.shade100,
                                        selectedColor: UIGuide.PRIMARY2,
                                        onTap: () async {
                                          divisionvalueController1.clear();
                                          coursevalueController.text =
                                              await snapshot.courselistt[index]
                                                      .value ??
                                                  '--';
                                          coursevalueController1.text =
                                              await snapshot.courselistt[index]
                                                      .text ??
                                                  '--';
                                          String courseId =
                                              coursevalueController.text
                                                  .toString();
                                          await snapshot.addSelectedCourse(
                                              snapshot.courselistt[index]);
                                          print(courseId);
                                          await Provider.of<
                                                      GallerySendProvider_Stf>(
                                                  context,
                                                  listen: false)
                                              .divisionClear();
                                          await Provider.of<
                                                      GallerySendProvider_Stf>(
                                                  context,
                                                  listen: false)
                                              .getDivisionList(courseId);
                                          Navigator.of(context).pop();
                                        },
                                        title: Text(
                                          snapshot.courselistt[index].text ??
                                              '--',
                                          textAlign: TextAlign.center,
                                        ),
                                      );
                                    }),
                              ],
                            ),
                          ));
                        });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: UIGuide.light_Purple, width: 1),
                          ),
                          height: 40,
                          child: TextField(
                            textAlign: TextAlign.center,
                            controller: coursevalueController1,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(left: 0, top: 0),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              filled: true,
                              fillColor: Color.fromARGB(255, 238, 237, 237),
                              border: OutlineInputBorder(),
                              labelText: "  Select Course",
                              hintText: "Course",
                            ),
                            enabled: false,
                          ),
                        ),
                        SizedBox(
                          height: 0,
                          child: TextField(
                            textAlign: TextAlign.center,
                            controller: coursevalueController,
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Color.fromARGB(255, 238, 237, 237),
                              border: OutlineInputBorder(),
                              labelText: "",
                              hintText: "",
                            ),
                            enabled: false,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
            const Spacer(),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.49,
              child: Consumer<GallerySendProvider_Stf>(
                  builder: (context, snapshot, child) {
                return InkWell(
                  onTap: () async {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                              child: Container(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: snapshot.divisionlistt.length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        onTap: () async {
                                          divisionvalueController.text =
                                              snapshot.divisionlistt[index]
                                                      .value ??
                                                  '--';

                                          print(divisionvalueController.text);
                                          divisionvalueController1.text =
                                              snapshot.divisionlistt[index]
                                                      .text ??
                                                  '--';
                                          String divisionId =
                                              divisionvalueController.text
                                                  .toString();

                                          Navigator.of(context).pop();
                                        },
                                        title: Text(
                                          snapshot.divisionlistt[index].text ??
                                              '--',
                                          textAlign: TextAlign.center,
                                        ),
                                      );
                                    }),
                              ],
                            ),
                          ));
                        });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: UIGuide.light_Purple, width: 1),
                          ),
                          height: 40,
                          child: TextField(
                            textAlign: TextAlign.center,
                            controller: divisionvalueController1,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(left: 0, top: 0),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              filled: true,
                              fillColor: Color.fromARGB(255, 238, 237, 237),
                              border: OutlineInputBorder(),
                              labelText: "  Select Division",
                              hintText: "Division",
                            ),
                            enabled: false,
                          ),
                        ),
                        SizedBox(
                          height: 0,
                          child: TextField(
                            textAlign: TextAlign.center,
                            controller: divisionvalueController,
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Color.fromARGB(255, 238, 237, 237),
                              border: OutlineInputBorder(),
                              labelText: "",
                              hintText: "",
                            ),
                            enabled: false,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
            const Spacer()
          ],
        ),
        kheight20,
        kheight20,
        Center(
          child: SizedBox(
            width: 150,
            child: Consumer<GallerySendProvider_Stf>(
              builder: (context, value, child) => MaterialButton(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                minWidth: size.width - 150,
                color: UIGuide.light_Purple,
                onPressed: (() async {
                  if (value.imageIDList.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      duration: Duration(seconds: 1),
                      margin: EdgeInsets.only(bottom: 80, left: 30, right: 30),
                      behavior: SnackBarBehavior.floating,
                      content: Text(
                        'Select Image..',
                        textAlign: TextAlign.center,
                      ),
                    ));
                  }
                  if (titleController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      duration: Duration(seconds: 1),
                      margin: EdgeInsets.only(bottom: 80, left: 30, right: 30),
                      behavior: SnackBarBehavior.floating,
                      content: Text(
                        'Enter Title..',
                        textAlign: TextAlign.center,
                      ),
                    ));
                  }
                  if (titleController.text.isNotEmpty &&
                      coursevalueController.text.isNotEmpty &&
                      divisionvalueController.text.isNotEmpty &&
                      value.imageIDList.isNotEmpty) {
                    await Provider.of<GallerySendProvider_Stf>(context,
                            listen: false)
                        .gallerySave(
                            context,
                            datee.toString(),
                            time,
                            timeNow,
                            titleController.text,
                            coursevalueController.text,
                            divisionvalueController.text,
                            value.imageIDList);

                    coursevalueController.clear();
                    titleController.clear();
                    divisionvalueController.clear();
                    divisionvalueController1.clear();
                    coursevalueController1.clear();
                    value.imageIDList.clear();
                    await value.removeCourseAll();
                    await value.courseClear();
                    await value.removeDivisionAll();
                    await value.divisionClear();
                  }
                }),
                child: const Text(
                  'Save',
                  style: TextStyle(color: UIGuide.WHITE, fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
