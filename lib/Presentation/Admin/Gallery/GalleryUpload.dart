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
  AdminGalleryUpload({Key? key}) : super(key: key);

  @override
  State<AdminGalleryUpload> createState() => _AdminGalleryUploadState();
}

class _AdminGalleryUploadState extends State<AdminGalleryUpload> {
  List courseData = [];
  List divisionData = [];
  String course = '';
  String division = '';

  String? datee;

  DateTime? _mydatetimeFrom;

  DateTime? _mydatetimeTo;

  String time = '--';

  String timeNow = '--';
  List subjectData = [];

  String section = '';

  String? checkname;
  final titleController = TextEditingController();
  final attachmentid = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var p = Provider.of<GalleryProviderAdmin>(context, listen: false);

      p.courseDropDown.clear();
      p.courseList.clear();
      p.divisionList.clear();
      p.divisionDropDown.clear();
      titleController.clear();
      attachmentid.clear();
      p.dropDown.clear();
      p.stdReportInitialValues.clear();
      // p.toggleVal == 'All';
      // p.indval = 0;

      p.getCourseList();
      p.stdReportSectionStaff();
      await p.sectionCounter(0);
      p.divisionCounter(0);
      p.courseCounter(0);
    });
  }

  String attach = '';
  String toggleVal = 'All';
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    datee = DateFormat('dd/MMM/yyyy').format(DateTime.now());
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
                minWidth: size.width - 250,
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
        Center(
          child: SizedBox(
            width: 120,
            child: Consumer<GalleryProviderAdmin>(
              builder: (context, value, child) => value.loading
                  ? spinkitLoader()
                  : MaterialButton(
                      color: Colors.white70,
                      onPressed: (() async {
                        final result = await FilePicker.platform.pickFiles(
                            type: FileType.custom,
                            allowedExtensions: ['png', 'jpeg', 'jpg']);
                        if (result == null) {
                          return;
                        }
                        final file = result.files.first;
                        print('Name: ${file.name}');
                        print('Path: ${file.path}');
                        print('Extension: ${file.extension}');

                        int sizee = file.size;

                        if (sizee <= 200000) {
                          await Provider.of<GalleryProviderAdmin>(context,
                                  listen: false)
                              .galleryImageSave(context, file.path.toString());

                          attach = await value.id.toString();
                          if (file.name.length >= 6) {
                            setState(() {
                              checkname = file.name
                                  .replaceRange(6, file.name.length, '');
                            });

                            print(checkname);
                          }
                        } else {
                          print('Size Exceed');
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                                  content: Text(
                            "Size Exceed (Less than 200KB allowed)",
                            textAlign: TextAlign.center,
                          )));
                        }
                      }),
                      child: Text(checkname == null
                          ? 'Choose File'
                          : checkname.toString()),
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
            SizedBox(
              width: size.width * .45,
              height: 35,
              child: MaterialButton(
                //  minWidth: size.width - 216,
                color: Colors.white,
                onPressed: (() async {
                  _mydatetimeFrom = await showDatePicker(
                    context: context,
                    initialDate: _mydatetimeFrom ?? DateTime.now(),
                    firstDate: DateTime.now().subtract(const Duration(days: 0)),
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
                //  minWidth: size.width - 216,
                child: Center(child: Text('From  $time')),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: size.width * .45,
              height: 35,
              child: MaterialButton(
                //  minWidth: size.width - 216,
                color: Colors.white,
                onPressed: (() async {
                  _mydatetimeTo = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now().subtract(const Duration(days: 0)),
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
                    timeNow = DateFormat('dd/MMM/yyyy').format(_mydatetimeTo!);
                    print(timeNow);
                  });
                }),
                //  minWidth: size.width - 216,
                child: Center(child: Text('To  $timeNow')),
              ),
            ),
            const Spacer()
          ],
        ),
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
              activeBgColor: const [UIGuide.light_Purple],
            ),
          ),
        ),
        kheight10,
        Consumer<GalleryProviderAdmin>(builder: (context, value, child) {
          if (value.toggleVal == "All") {
            return Container(
              // color: Colors.red,
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
                      items: val.dropDown,

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
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        border: Border.all(
                          color: Colors.grey,
                          width: 2,
                        ),
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
                      width: size.width * .43,
                      height: 50,
                      child: MultiSelectDialogField(
                        // height: 200,
                        items: value.courseDropDown,
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
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          border: Border.all(
                            color: Colors.grey,
                            width: 2,
                          ),
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
                          print("courseData${courseData}");
                          course = courseData.join(',');

                          await Provider.of<GalleryProviderAdmin>(context,
                                  listen: false)
                              .courseCounter(results.length);

                          await Provider.of<GalleryProviderAdmin>(context,
                                  listen: false)
                              .getDivisionList(course);
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
                      width: size.width * .43,
                      height: 50,
                      child: MultiSelectDialogField(
                        items: value.divisionDropDown,
                        listType: MultiSelectListType.CHIP,
                        title: const Text(
                          "Select Division",
                          style: TextStyle(color: Colors.black),
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
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          border: Border.all(
                            color: Colors.grey,
                            width: 2,
                          ),
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
        kheight20,
        Center(
          child: SizedBox(
            width: 100,
            child: Consumer<GalleryProviderAdmin>(
              builder: (context, value, child) => MaterialButton(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                minWidth: size.width - 150,
                color: UIGuide.light_Purple,
                onPressed: (() async {
                  attachmentid.text = attach;
                  print(attachmentid);
                  if (attachmentid.toString().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                        'Select Image..',
                        textAlign: TextAlign.center,
                      ),
                      duration: Duration(seconds: 1),
                    ));
                  }
                  if (titleController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                        'Enter Title..',
                        textAlign: TextAlign.center,
                      ),
                      duration: Duration(seconds: 1),
                    ));
                  }
                  if (value.toggleVal == 'student') {
                    if (titleController.text.isNotEmpty &&
                        course.toString().isNotEmpty &&
                        division.toString().isNotEmpty &&
                        attachmentid.text.isNotEmpty) {
                      await Provider.of<GalleryProviderAdmin>(context,
                              listen: false)
                          .gallerySave(
                              context,
                              datee.toString(),
                              time,
                              timeNow,
                              titleController.text,
                              courseData,
                              divisionData,
                              null,
                              toggleVal.toString(),
                              attachmentid.text.toString());

                      titleController.clear();
                      courseData.clear();
                      divisionData.clear();
                      attachmentid.clear();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                          'Please enter mandatory fields',
                          textAlign: TextAlign.center,
                        ),
                        duration: Duration(seconds: 1),
                      ));
                    }
                  } else if (value.toggleVal == 'staff') {
                    if (titleController.text.isNotEmpty &&
                        section.toString().isNotEmpty &&
                        attachmentid.text.isNotEmpty) {
                      await Provider.of<GalleryProviderAdmin>(context,
                              listen: false)
                          .gallerySave(
                              context,
                              datee.toString(),
                              time,
                              timeNow,
                              titleController.text,
                              null,
                              null,
                              subjectData,
                              toggleVal.toString(),
                              attachmentid.text.toString());

                      titleController.clear();
                      subjectData.clear();
                      attachmentid.clear();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                          'Please enter mandatory fields',
                          textAlign: TextAlign.center,
                        ),
                        duration: Duration(seconds: 1),
                      ));
                    }
                  } else {
                    if (titleController.text.isNotEmpty &&
                        attachmentid.text.isNotEmpty) {
                      print("------------------${attachmentid.toString()}");
                      await Provider.of<GalleryProviderAdmin>(context,
                              listen: false)
                          .gallerySave(
                              context,
                              datee.toString(),
                              time,
                              timeNow,
                              titleController.text,
                              null,
                              null,
                              null,
                              toggleVal.toString(),
                              attachmentid.text.toString());

                      titleController.clear();

                      attachmentid.clear();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                          'Please enter mandatory fields',
                          textAlign: TextAlign.center,
                        ),
                        duration: Duration(seconds: 1),
                      ));
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
    );
  }
}
