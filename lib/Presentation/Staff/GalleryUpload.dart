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
              toolbarHeight: 50,
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
              const StaffGalleryView(),
              Consumer<GallerySendProvider_Stf>(
                builder: (context, value, child) {
                  if (value.isClassTeacher != false) {
                    return const StaffGalleryUPload();
                  } else {
                    return const Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
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
  String? datee;

  String? checkname;

  final coursevalueController = TextEditingController();
  final coursevalueController1 = TextEditingController();
  final divisionvalueController = TextEditingController();
  final divisionvalueController1 = TextEditingController();
  final titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    datee = DateFormat('dd/MMM/yyyy').format(DateTime.now());
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var p = Provider.of<GallerySendProvider_Stf>(context, listen: false);
      await p.getVariables();
      await p.removeCourseAll();
      await p.removeDivisionAll();
      p.imageIDList.clear();
      await p.sendGallery();
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Consumer<GallerySendProvider_Stf>(
      builder: (context, val, _) => ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 3,
                    foregroundColor: UIGuide.BLACK,
                    disabledBackgroundColor:
                        const Color.fromARGB(255, 241, 241, 241),
                    padding: const EdgeInsets.all(0),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                          color: Color.fromARGB(255, 206, 206, 206)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: null,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10),
                    child: Text(
                      'Date: ${datee.toString()}',
                      style:
                          const TextStyle(color: UIGuide.BLACK, fontSize: 14),
                    ),
                  )),
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
              child: Consumer<GallerySendProvider_Stf>(
                builder: (context, value, child) => value.loading
                    ? spinkitLoader()
                    : SizedBox(
                        width: size.width / 2,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 3,
                            foregroundColor: UIGuide.BLACK,
                            backgroundColor:
                                const Color.fromARGB(255, 246, 248, 255),
                            padding: const EdgeInsets.all(0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: const BorderSide(
                                  color: UIGuide.light_black,
                                )),
                          ),
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
                              filePaths = result.paths
                                  .map((path) => File(path!))
                                  .toList();
                              for (File file in filePaths) {
                                print(
                                    'File size: ${await file.length()} bytes');
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
                              await val.galleryImageSave(context, fileP);
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
                          }),
                          child: Text(
                              value.imageIDList.isEmpty
                                  ? 'Choose Image 🖼️'
                                  : "${value.imageIDList.length} Image added",
                              style: const TextStyle(
                                  color: Colors.black87, fontSize: 14)),
                        ),
                      ),
              ),
            ),
          ),
          const Center(
              child: Text(
            'Maximum allowed image size is 200 KB',
            style: TextStyle(
                fontSize: 9, color: Color.fromARGB(255, 241, 104, 94)),
          )),
          kheight10,
          Row(
            children: [
              kWidth,
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 3,
                      foregroundColor: UIGuide.light_Purple,
                      backgroundColor: UIGuide.ButtonBlue,
                      padding: const EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(
                            color: UIGuide.light_black,
                          )),
                    ),
                    onPressed: () async {
                      await val.getFromDate(context);
                    },
                    child: Center(
                        child: val.fromDateDis.isEmpty
                            ? const Text(
                                'From Date 🗓️ ',
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 13),
                              )
                            : Text("From ${val.fromDateDis}")),
                  ),
                ),
              ),
              kWidth,
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 3,
                      foregroundColor: UIGuide.light_Purple,
                      backgroundColor: UIGuide.ButtonBlue,
                      padding: const EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(
                            color: UIGuide.light_black,
                          )),
                    ),
                    onPressed: () async {
                      val.getToDate(context);
                    },
                    child: Center(
                        child: val.toDateDis.isEmpty
                            ? const Text(
                                'To Date 🗓️ ',
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 13),
                              )
                            : Text("To ${val.toDateDis}")),
                  ),
                ),
              ),
              kWidth
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              kWidth,
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: Consumer<GallerySendProvider_Stf>(
                      builder: (context, snapshot, _) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 3,
                        foregroundColor: UIGuide.light_Purple,
                        backgroundColor: UIGuide.ButtonBlue,
                        padding: const EdgeInsets.all(0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(
                              color: UIGuide.light_black,
                            )),
                      ),
                      onPressed: () async {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  child: LimitedBox(
                                    maxHeight: size.height - 400,
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: snapshot.courselistt.length,
                                        itemBuilder: (context, index) {
                                          return ListTile(
                                            selectedTileColor:
                                                Colors.blue.shade100,
                                            onTap: () async {
                                              divisionvalueController1.clear();
                                              coursevalueController.text =
                                                  snapshot.courselistt[index]
                                                          .value ??
                                                      '--';
                                              coursevalueController1.text =
                                                  snapshot.courselistt[index]
                                                          .text ??
                                                      '--';
                                              String courseId =
                                                  coursevalueController.text
                                                      .toString();

                                              await val.removeDivisionAll();

                                              await val
                                                  .getDivisionList(courseId);
                                              Navigator.of(context).pop();
                                            },
                                            title: Text(
                                              snapshot.courselistt[index]
                                                      .text ??
                                                  '--',
                                              textAlign: TextAlign.center,
                                            ),
                                          );
                                        }),
                                  ));
                            });
                      },
                      child: SizedBox(
                        height: 40,
                        child: TextField(
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: UIGuide.BLACK,
                              overflow: TextOverflow.clip),
                          textAlign: TextAlign.center,
                          controller: coursevalueController1,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(left: 0, top: 0),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            filled: true,
                            fillColor: Colors.transparent,
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(style: BorderStyle.none, width: 0),
                            ),
                            labelText: "  Select Course",
                            hintText: "Course",
                          ),
                          enabled: false,
                        ),
                      ),
                    );
                  }),
                ),
              ),
              kWidth,
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: Consumer<GallerySendProvider_Stf>(
                      builder: (context, snapshot, child) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 3,
                        foregroundColor: UIGuide.light_Purple,
                        backgroundColor: UIGuide.ButtonBlue,
                        padding: const EdgeInsets.all(0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(
                              color: UIGuide.light_black,
                            )),
                      ),
                      onPressed: () async {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  child: LimitedBox(
                                    maxHeight: size.height - 300,
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount:
                                            snapshot.divisionlistt.length,
                                        itemBuilder: (context, index) {
                                          return ListTile(
                                            onTap: () async {
                                              divisionvalueController.text =
                                                  snapshot.divisionlistt[index]
                                                          .value ??
                                                      '--';

                                              divisionvalueController1.text =
                                                  snapshot.divisionlistt[index]
                                                          .text ??
                                                      '--';

                                              Navigator.of(context).pop();
                                            },
                                            title: Text(
                                              snapshot.divisionlistt[index]
                                                      .text ??
                                                  '--',
                                              textAlign: TextAlign.center,
                                            ),
                                          );
                                        }),
                                  ));
                            });
                      },
                      child: SizedBox(
                        height: 40,
                        child: TextField(
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: UIGuide.BLACK,
                              overflow: TextOverflow.clip),
                          textAlign: TextAlign.center,
                          controller: divisionvalueController1,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(left: 0, top: 0),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            filled: true,
                            fillColor: Colors.transparent,
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(style: BorderStyle.none, width: 0),
                            ),
                            labelText: "  Select Division",
                            hintText: "Division",
                          ),
                          enabled: false,
                        ),
                      ),
                    );
                  }),
                ),
              ),
              kWidth
            ],
          ),
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
                        margin:
                            EdgeInsets.only(bottom: 80, left: 30, right: 30),
                        behavior: SnackBarBehavior.floating,
                        content: Text(
                          'Select Image..',
                          textAlign: TextAlign.center,
                        ),
                      ));
                    } else if (titleController.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        duration: Duration(seconds: 1),
                        margin:
                            EdgeInsets.only(bottom: 80, left: 30, right: 30),
                        behavior: SnackBarBehavior.floating,
                        content: Text(
                          'Enter Title..',
                          textAlign: TextAlign.center,
                        ),
                      ));
                    } else if (coursevalueController.text.isEmpty ||
                        divisionvalueController.text.isEmpty ||
                        val.fromDateDis.isEmpty ||
                        val.toDateDis.isEmpty ||
                        titleController.text.trim().isEmpty ||
                        value.imageIDList.isEmpty) {
                      snackbarWidget(2, "Select mandatory fields...", context);
                    } else if (val.fromDateCheck.isAfter(val.toDateCheck)) {
                      snackbarWidget(
                          2, 'From date is greater than to date', context);
                    } else {
                      await val.gallerySave(
                          context,
                          datee.toString(),
                          val.fromDateDis,
                          val.toDateDis,
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

                      await value.removeDivisionAll();
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
      ),
    );
  }
}
