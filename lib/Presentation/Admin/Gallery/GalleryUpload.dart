import 'dart:io';

import 'package:essconnect/Application/AdminProviders/GalleryProviders.dart';
import 'package:essconnect/Constants.dart';
import 'package:essconnect/Domain/Admin/Course&DivsionList.dart';
import 'package:essconnect/Domain/Staff/StudentReport_staff.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:essconnect/utils/spinkit.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

class AdminGalleryUpload extends StatefulWidget {
  const AdminGalleryUpload({Key? key}) : super(key: key);

  @override
  State<AdminGalleryUpload> createState() => _AdminGalleryUploadState();
}

class _AdminGalleryUploadState extends State<AdminGalleryUpload> {
  List courseData = [];
  List divisionData = [];
  String course = '';
  String division = '';
  String? datee;
  List subjectData = [];
  String section = '';
  final titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    datee = DateFormat('dd/MMM/yyyy').format(DateTime.now());
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var p = Provider.of<GalleryProviderAdmin>(context, listen: false);
      p.getVariables();
      p.courseDropDown.clear();
      p.courseList.clear();
      p.divisionList.clear();
      p.divisionDropDown.clear();
      titleController.clear();
      p.imageIDList.clear();
      p.dropDown.clear();
      p.stdReportInitialValues.clear();
      await p.getCourseList();
      await p.stdReportSectionStaff();
      await p.sectionCounter(0);
      await p.divisionCounter(0);
      await p.courseCounter(0);
      p.indval = 0;
      p.courseLen = 0;
      p.divisionLen = 0;
      p.toggleVal = 'all';
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Consumer<GalleryProviderAdmin>(
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
              minLines: 1,
              maxLines: 1,
              inputFormatters: [LengthLimitingTextInputFormatter(50)],
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
                      const BorderSide(color: UIGuide.light_Purple, width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          kheight10,
          Center(
            child: SizedBox(
              height: 40,
              child: Consumer<GalleryProviderAdmin>(
                builder: (context, value, child) => value.loading
                    ? spinkitLoader()
                    : SizedBox(
                        height: 40,
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
                              print("object");
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
                              await Provider.of<GalleryProviderAdmin>(context,
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
          const SizedBox(
            height: 4,
          ),
          const Center(
              child: Text(
            'Maximum allowed image size is 200 KB',
            style: TextStyle(
                fontSize: 9,
                color: Color.fromARGB(255, 241, 104, 94),
                fontWeight: FontWeight.w600),
          )),
          const SizedBox(
            height: 15,
          ),
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
          kheight20,
          kheight10,
          Consumer<GalleryProviderAdmin>(
            builder: (context, value, child) => Center(
              child: ToggleSwitch(
                initialLabelIndex: value.indval,
                labels: const ['All', "Students", 'Staff'],
                onToggle: (inde) async {
                  print('Swiched index $inde');
                  await value.onToggleChanged(inde!);
                },
                fontSize: 14,
                minHeight: 30,
                minWidth: 150,
                inactiveBgColor: const Color.fromARGB(255, 212, 212, 212),
                activeBgColor: const [UIGuide.light_Purple],
              ),
            ),
          ),
          kheight10,
          Consumer<GalleryProviderAdmin>(builder: (context, value, child) {
            if (value.toggleVal == "all") {
              return const SizedBox(
                height: 0,
                width: 0,
              );
            } else if (value.toggleVal == "staff") {
              return Consumer<GalleryProviderAdmin>(
                builder: (context, val, child) => Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0, right: 12),
                    child: SizedBox(
                      width: size.width * .42,
                      height: 50,
                      child: MultiSelectDialogField(
                        // height: 200,
                        items: val.dropDown, searchable: true,

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
                        buttonText: val.sectionLen == 0
                            ? const Text(
                                "Select Section",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              )
                            : Text(
                                "   ${val.sectionLen.toString()} Selected",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                        chipDisplay: MultiSelectChipDisplay.none(),
                        onConfirm: (results) async {
                          subjectData = [];
                          for (var i = 0; i < results.length; i++) {
                            StudReportSectionList data =
                                results[i] as StudReportSectionList;
                            print(data.text);
                            print(data.value);
                            subjectData.add(data.value);
                            subjectData.map((e) => data.value);
                            print("${subjectData.map((e) => data.value)}");
                          }
                          section = subjectData.join(',');
                          await Provider.of<GalleryProviderAdmin>(context,
                                  listen: false)
                              .sectionCounter(results.length);
                          print("data $section");

                          print(subjectData.join(','));
                        },
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return Row(
                children: [
                  const Spacer(),
                  Consumer<GalleryProviderAdmin>(
                    builder: (context, value, child) => Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        width: size.width * .45,
                        height: 50,
                        child: MultiSelectDialogField(
                          // height: 200,
                          items: value.courseDropDown, searchable: true,
                          listType: MultiSelectListType.CHIP,
                          title: const Text(
                            "Select Course",
                            style: TextStyle(color: Colors.black),
                          ),
                          // selectedColor: Color.fromARGB(255, 157, 232, 241),
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
                            courseData = [];
                            courseData.clear();
                            value.divisionLen = 0;
                            print("coursddeleteeee   $courseData");
                            await Provider.of<GalleryProviderAdmin>(context,
                                    listen: false)
                                .divisionClear();
                            for (var i = 0; i < results.length; i++) {
                              CourseListModel data =
                                  results[i] as CourseListModel;
                              print(data.name);
                              print(data.courseId);
                              courseData.add(data.courseId);
                              courseData.map((e) => data.courseId);
                              print("${courseData.map((e) => data.courseId)}");
                            }
                            print("courseData$courseData");
                            course = courseData.join(',');

                            await val.courseCounter(results.length);

                            await val.getDivisionList(course);
                          },
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Consumer<GalleryProviderAdmin>(
                    builder: (context, value, child) => Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        width: size.width * .45,
                        height: 50,
                        child: MultiSelectDialogField(
                          items: value.divisionDropDown,
                          listType: MultiSelectListType.CHIP,
                          title: const Text(
                            "Select Division",
                            style: TextStyle(color: Colors.black),
                          ),
                          searchable: true,
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
                          buttonText: value.divisionLen == 0
                              ? const Text(
                                  "Select Division",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                )
                              : Text(
                                  "   ${value.divisionLen.toString()} Selected",
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                          chipDisplay: MultiSelectChipDisplay.none(),
                          onConfirm: (results) async {
                            divisionData = [];
                            for (var i = 0; i < results.length; i++) {
                              DivisionListModel data =
                                  results[i] as DivisionListModel;
                              print(data.text);
                              print(data.value);
                              divisionData.add(data.value);
                              divisionData.map((e) => data.value);
                              print("${divisionData.map((e) => data.value)}");
                            }
                            division = divisionData.join(',');
                            await Provider.of<GalleryProviderAdmin>(context,
                                    listen: false)
                                .divisionCounter(results.length);
                            results.clear();
                            print(divisionData.join(','));
                            //  attach = value.id.toString();
                          },
                        ),
                      ),
                    ),
                  ),
                  const Spacer()
                ],
              );
            }
          }),
          kheight10,
          Center(
            child: SizedBox(
              width: size.width / 2.3,
              child: Consumer<GalleryProviderAdmin>(
                builder: (context, value, child) => MaterialButton(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  minWidth: size.width - 150,
                  color: UIGuide.light_Purple,
                  onPressed: (() async {
                    if (value.toggleVal == 'student') {
                      if (value.imageIDList.isEmpty) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                            'Select Image..',
                            textAlign: TextAlign.center,
                          ),
                          duration: Duration(seconds: 1),
                        ));
                      } else if (titleController.text.trim().isEmpty) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                            'Enter Title..',
                            textAlign: TextAlign.center,
                          ),
                          duration: Duration(seconds: 1),
                        ));
                      } else if (val.fromDateDis.isEmpty ||
                          val.toDateDis.isEmpty ||
                          value.imageIDList.isEmpty) {
                        snackbarWidget(
                            2, "Select mandatory fields...", context);
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
                            courseData,
                            divisionData,
                            null,
                            val.toggleVal,
                            value.imageIDList);
                      }
                    } else if (value.toggleVal == 'staff') {
                      if (value.imageIDList.isEmpty) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                            'Select Image..',
                            textAlign: TextAlign.center,
                          ),
                          duration: Duration(seconds: 1),
                        ));
                      } else if (titleController.text.trim().isEmpty) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                            'Enter Title..',
                            textAlign: TextAlign.center,
                          ),
                          duration: Duration(seconds: 1),
                        ));
                      } else if (val.fromDateDis.isEmpty ||
                          val.toDateDis.isEmpty ||
                          value.imageIDList.isEmpty) {
                        snackbarWidget(
                            2, "Select mandatory fields...", context);
                      } else if (val.fromDateCheck.isAfter(val.toDateCheck)) {
                        snackbarWidget(
                            2, 'From date is greater than to date', context);
                      } else {
                        await Provider.of<GalleryProviderAdmin>(context,
                                listen: false)
                            .gallerySave(
                                context,
                                datee.toString(),
                                val.fromDateDis,
                                val.toDateDis,
                                titleController.text,
                                null,
                                null,
                                subjectData,
                                val.toggleVal,
                                value.imageIDList);
                      }
                    } else {
                      if (value.imageIDList.isEmpty) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                            'Select Image..',
                            textAlign: TextAlign.center,
                          ),
                          duration: Duration(seconds: 1),
                        ));
                      } else if (titleController.text.trim().isEmpty) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                            'Enter Title..',
                            textAlign: TextAlign.center,
                          ),
                          duration: Duration(seconds: 1),
                        ));
                      } else if (val.fromDateDis.isEmpty ||
                          val.toDateDis.isEmpty ||
                          value.imageIDList.isEmpty) {
                        snackbarWidget(
                            2, "Select mandatory fields...", context);
                      } else if (val.fromDateCheck.isAfter(val.toDateCheck)) {
                        snackbarWidget(
                            2, 'From date is greater than to date', context);
                      } else {
                        await Provider.of<GalleryProviderAdmin>(context,
                                listen: false)
                            .gallerySave(
                                context,
                                datee.toString(),
                                val.fromDateDis,
                                val.toDateDis,
                                titleController.text,
                                null,
                                null,
                                null,
                                val.toggleVal,
                                value.imageIDList);
                      }
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
