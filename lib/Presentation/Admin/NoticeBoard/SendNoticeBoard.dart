import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:essconnect/Application/AdminProviders/NoticeBoardadmin.dart';

import 'package:essconnect/Constants.dart';
import 'package:essconnect/Domain/Staff/StudentReport_staff.dart';
import 'package:essconnect/Presentation/Admin/NoticeBoard/AddCategory.dart';
import 'package:essconnect/utils/spinkit.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../../../Domain/Admin/Course&DivsionList.dart';
import '../../../utils/constants.dart';

class SendNoticeBoardAdmin extends StatefulWidget {
  const SendNoticeBoardAdmin({Key? key}) : super(key: key);

  @override
  State<SendNoticeBoardAdmin> createState() => _SendNoticeBoardAdminState();
}

class _SendNoticeBoardAdminState extends State<SendNoticeBoardAdmin> {
  String? datee;
  String division = '';
  String course = '';
  DateTime? _mydatetimeFrom;
  DateTime? _mydatetimeTo;
  String time = '🗓️';
  String timeNow = '🗓️';
  String checkname = '';
  List courseData = [];
  List divisionData = [];
  final categoryvalueController = TextEditingController();
  final categoryvalueController1 = TextEditingController();
  final titleController = TextEditingController();
  final mattercontroller = TextEditingController();
  String attach = '';
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var p = Provider.of<NoticeBoardAdminProvider>(context, listen: false);
      p.courseDropDown.clear();
      // p.toggleVal == 'All';
      // p.indval = 0;
      p.courseList.clear();
      p.divisionList.clear();
      p.divisionDropDown.clear();
      p.dropDown.clear();
      p.stdReportInitialValues.clear();
      await p.getCourseList();
      await p.noticeboardCategory();

      p.stdReportSectionStaff();
      await p.sectionCounter(0);
      await p.courseCounter(0);
      await p.divisionCounter(0);

      titleController.clear();
      attachmentid.clear();
      p.indval = 0;
      p.toggleVal = 'All';
      // var m = Provider.of<SchoolPhotoProviders>(context, listen: false);
      // await m.stdReportSectionStaff();

      // m.dropDown.clear();
      // m.stdReportInitialValues.clear();
    });
  }

  List subjectData = [];

  String section = '';

  final attachmentid = TextEditingController();
  @override
  Widget build(BuildContext context) {
    attachmentid.clear();
    var size = MediaQuery.of(context).size;
    datee = DateFormat('dd/MMM/yyyy').format(DateTime.now());

    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(top: 3.0),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: UIGuide.light_Purple, width: 2)),
                height: 40,
                width: size.width * 0.38,
                child: MaterialButton(
                    //  minWidth: size.width - 250,
                    color: Colors.white70,
                    child: Text("🗓️  ${datee.toString()}"),
                    onPressed: () async {
                      return;
                    }),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                height: 55,
                width: MediaQuery.of(context).size.width * 0.44,
                child: Consumer<NoticeBoardAdminProvider>(
                    builder: (context, snapshot, child) {
                  return InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                                child: LimitedBox(
                              maxHeight: size.height - 300,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: noticeCategoryAdmin!.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      onTap: () async {
                                        print({noticeCategoryAdmin![index]});
                                        categoryvalueController.text =
                                            await noticeCategoryAdmin![index]
                                                    ['value'] ??
                                                '--';
                                        categoryvalueController1.text =
                                            await noticeCategoryAdmin![index]
                                                    ['text'] ??
                                                '--';

                                        Navigator.of(context).pop();
                                      },
                                      title: Text(
                                        noticeCategoryAdmin![index]['text'] ??
                                            '--',
                                        textAlign: TextAlign.center,
                                      ),
                                    );
                                  }),
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
                                  color: UIGuide.light_Purple, width: 2),
                            ),
                            height: 40,
                            child: TextField(
                              textAlign: TextAlign.center,
                              controller: categoryvalueController1,
                              decoration: const InputDecoration(
                                contentPadding:
                                    EdgeInsets.only(left: 0, top: 0),
                                filled: true,
                                fillColor: Color.fromARGB(255, 238, 237, 237),
                                border: OutlineInputBorder(),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                labelText: "  Select Category",
                                labelStyle: TextStyle(color: UIGuide.BLACK),
                              ),
                              enabled: false,
                            ),
                          ),
                          SizedBox(
                            height: 0,
                            child: TextField(
                              textAlign: TextAlign.center,
                              controller: categoryvalueController,
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
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddCategory()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child: Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width * 0.10,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(0),
                    border: Border.all(color: UIGuide.light_Purple, width: 2),
                    color: Color.fromARGB(255, 218, 218, 221),
                  ),
                  child: Icon(Icons.category_outlined),
                ),
              ),
            ),
            Spacer()
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: titleController,
            minLines: 1,
            inputFormatters: [LengthLimitingTextInputFormatter(50)],
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
                      const BorderSide(color: UIGuide.light_Purple, width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                )),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            inputFormatters: [LengthLimitingTextInputFormatter(400)],
            controller: mattercontroller,
            minLines: 1,
            maxLines: 5,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
                labelText: 'Matter*',
                labelStyle: const TextStyle(color: UIGuide.light_Purple),
                hintText: 'Enter Matter',
                hintStyle: const TextStyle(color: Colors.grey),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: UIGuide.light_Purple, width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                )),
          ),
        ),
        Row(
          children: [
            const Spacer(),
            Center(
              child: SizedBox(
                width: size.width / 2.4,
                child: Consumer<NoticeBoardAdminProvider>(
                  builder: (context, value, child) => value.loaddg
                      ? spinkitLoader()
                      : MaterialButton(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0))),

                          // minWidth: size.width - 200,
                          color: Colors.white,
                          onPressed: (() async {
                            final result = await FilePicker.platform.pickFiles(
                                type: FileType.custom,
                                allowedExtensions: [
                                  'pdf',
                                  'png',
                                  'jpeg',
                                  'jpg'
                                ]);
                            if (result == null) {
                              return;
                            }
                            final file = result.files.first;
                            print('Name: ${file.name}');
                            print('Path: ${file.path}');
                            print('Extension: ${file.extension}');

                            int sizee = file.size;
                            print(file.size);

                            if (file.size <= 200000) {
                              await Provider.of<NoticeBoardAdminProvider>(
                                      context,
                                      listen: false)
                                  .noticeImageSave(
                                      context, file.path.toString());

                              attach = await value.id.toString();
                              // openFile(file);
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
                                "Size Exceed(Less than 200KB allowed)",
                                textAlign: TextAlign.center,
                              )));
                            }
                          }),
                          // minWidth: size.width - 200,
                          child: Text(checkname.isEmpty
                              ? '📁  Choose File'
                              : checkname),
                        ),
                ),
              ),
            ),
            const Spacer()
          ],
        ),
        const Center(
            child: Text(
          'Maximum allowed file size is 200 KB',
          style:
              TextStyle(fontSize: 9, color: Color.fromARGB(255, 241, 104, 94)),
        )),
        kheight20,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: UIGuide.light_Purple, width: 1),
                  borderRadius: BorderRadius.circular(5)),
              width: size.width * .45,
              height: 35,
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),

                // minWidth: size.width - 250,
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
                // minWidth: size.width - 250,
                child: Center(child: Text('From  $time')),
              ),
            ),
            const Spacer(),
            //  kWidth, kWidth,
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: UIGuide.light_Purple, width: 1),
                  borderRadius: BorderRadius.circular(5)),
              width: size.width * .45,
              height: 35,
              child: MaterialButton(
                //   minWidth: size.width - 250,
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

                child: Center(child: Text('To  $timeNow')),
              ),
            ),
            const Spacer()
          ],
        ),
        kheight20,
        Consumer<NoticeBoardAdminProvider>(
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
        Consumer<NoticeBoardAdminProvider>(builder: (context, value, child) {
          if (value.toggleVal == "All") {
            return Container(
              // color: Colors.red,
              height: 0,
              width: 0,
            );
          } else if (value.toggleVal == "staff") {
            return Consumer<NoticeBoardAdminProvider>(
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
                        await Provider.of<NoticeBoardAdminProvider>(context,
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
                Consumer<NoticeBoardAdminProvider>(
                  builder: (context, val, child) => Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      width: size.width * .43,
                      height: 50,
                      child: MultiSelectDialogField(
                        items: val.courseDropDown,
                        listType: MultiSelectListType.CHIP,
                        title: const Text(
                          "Select Course",
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
                        searchable: true,
                        buttonText: val.courseLen == 0
                            ? const Text(
                                "Select Course",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              )
                            : Text(
                                "   ${val.courseLen.toString()} Selected",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                        chipDisplay: MultiSelectChipDisplay.none(),
                        onConfirm: (result) async {
                          courseData = [];
                          courseData.clear();
                          value.divisionLen = 0;
                          await Provider.of<NoticeBoardAdminProvider>(context,
                                  listen: false)
                              .divisionClear();
                          for (var i = 0; i < result.length; i++) {
                            CourseListModel data = result[i] as CourseListModel;
                            print(data.name);
                            print(data.courseId);
                            courseData.add(data.courseId);
                            courseData.map((e) => data.courseId);
                            print("${courseData.map((e) => data.courseId)}");
                          }

                          print("courseData${courseData}");
                          course = courseData.join(',');

                          await Provider.of<NoticeBoardAdminProvider>(context,
                                  listen: false)
                              .courseCounter(result.length);

                          // await Provider.of<NoticeBoardAdminProvider>(context,
                          //         listen: false)
                          //     .divisionClear();
                          await Provider.of<NoticeBoardAdminProvider>(context,
                                  listen: false)
                              .getDivisionList(course);
                          print(courseData.join('","'));
                        },
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Consumer<NoticeBoardAdminProvider>(
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
                        searchable: true,
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
                        onConfirm: (result) async {
                          for (var a = 0; a < result.length; a++) {
                            DivisionListModel data =
                                result[a] as DivisionListModel;
                            print(data.text);
                            print(data.value);
                            divisionData.add(data.value);
                            divisionData.map((e) => data.value);
                            print("${divisionData.map((e) => data.value)}");
                          }
                          division = divisionData.join(',');
                          await Provider.of<NoticeBoardAdminProvider>(context,
                                  listen: false)
                              .divisionCounter(result.length);
                          result.clear();

                          print(divisionData.join(','));
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
        kheight10,
        Center(
          child: SizedBox(
            width: size.width / 2.4,
            child: Consumer<NoticeBoardAdminProvider>(
              builder: (context, value, child) => MaterialButton(
                minWidth: size.width - 150,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                color: UIGuide.light_Purple,
                onPressed: (() async {
                  // print(attachmentid);
                  // if (checkname.isEmpty) {
                  // attachmentid.clear();
                  // } else {
                  attachmentid.text = attach;
                  //}

                  if (value.toggleVal == 'student') {
                    if (titleController.text.isNotEmpty &&
                        course.toString().isNotEmpty &&
                        division.toString().isNotEmpty &&
                        mattercontroller.text.isNotEmpty &&
                        categoryvalueController.text.isNotEmpty &&
                        categoryvalueController1.text.isNotEmpty) {
                      await Provider.of<NoticeBoardAdminProvider>(context,
                              listen: false)
                          .noticeBoardSave(
                              context,
                              datee.toString(),
                              time,
                              timeNow,
                              titleController.text,
                              mattercontroller.text,
                              value.toggleVal,
                              courseData,
                              divisionData,
                              null,
                              categoryvalueController.text,
                              attachmentid.text.toString());
                    } else {
                      AwesomeDialog(
                              context: context,
                              dialogType: DialogType.error,
                              animType: AnimType.rightSlide,
                              headerAnimationLoop: false,
                              title: 'Error',
                              desc: 'Select mandatory fields',
                              btnOkOnPress: () {
                                return;
                              },
                              btnOkIcon: Icons.cancel,
                              btnOkColor: Colors.red)
                          .show();
                    }
                  } else if (value.toggleVal == "staff") {
                    if (titleController.text.isNotEmpty &&
                        section.toString().isNotEmpty &&
                        mattercontroller.text.isNotEmpty &&
                        categoryvalueController.text.isNotEmpty &&
                        categoryvalueController1.text.isNotEmpty) {
                      await Provider.of<NoticeBoardAdminProvider>(context,
                              listen: false)
                          .noticeBoardSave(
                              context,
                              datee.toString(),
                              time,
                              timeNow,
                              titleController.text,
                              mattercontroller.text,
                              value.toggleVal,
                              null,
                              null,
                              subjectData,
                              categoryvalueController.text,
                              attachmentid.text.toString());
                    } else {
                      AwesomeDialog(
                              context: context,
                              dialogType: DialogType.error,
                              animType: AnimType.rightSlide,
                              headerAnimationLoop: false,
                              title: 'Error',
                              desc: 'Select mandatory fields',
                              btnOkOnPress: () {
                                return;
                              },
                              btnOkIcon: Icons.cancel,
                              btnOkColor: Colors.red)
                          .show();
                    }
                  } else {
                    if (titleController.text.isNotEmpty &&
                        mattercontroller.text.isNotEmpty &&
                        categoryvalueController.text.isNotEmpty &&
                        categoryvalueController1.text.isNotEmpty) {
                      await Provider.of<NoticeBoardAdminProvider>(context,
                              listen: false)
                          .noticeBoardSave(
                              context,
                              datee.toString(),
                              time,
                              timeNow,
                              titleController.text,
                              mattercontroller.text,
                              value.toggleVal,
                              null,
                              null,
                              null,
                              categoryvalueController.text,
                              attachmentid.text.toString());
                    } else {
                      AwesomeDialog(
                              context: context,
                              dialogType: DialogType.error,
                              animType: AnimType.rightSlide,
                              headerAnimationLoop: false,
                              title: 'Error',
                              desc: 'Select mandatory fields',
                              btnOkOnPress: () {
                                return;
                              },
                              btnOkIcon: Icons.cancel,
                              btnOkColor: Colors.red)
                          .show();
                    }
                  }
                }),
                child: const Text(
                  'Save',
                  style: TextStyle(color: UIGuide.WHITE),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // void openFile(PlatformFile file) {
  //   OpenFile.open(file.path);
  // }
}
