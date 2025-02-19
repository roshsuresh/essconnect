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

  List courseData = [];
  List divisionData = [];
  final categoryvalueController = TextEditingController();
  final categoryvalueController1 = TextEditingController();
  final titleController = TextEditingController();
  final mattercontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    datee = DateFormat('dd/MMM/yyyy').format(DateTime.now());
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var p = Provider.of<NoticeBoardAdminProvider>(context, listen: false);
      p.courseDropDown.clear();
      p.getVariables();
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

      p.indval = 0;
      p.toggleVal = 'all';
    });
  }

  List subjectData = [];

  String section = '';

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Consumer<NoticeBoardAdminProvider>(
      builder: (context, val, _) => ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
                        onPressed: () {},
                        child: Text(
                          '🗓️  ${datee.toString()}',
                          style: const TextStyle(
                              color: UIGuide.BLACK, fontSize: 14),
                        )),
                  ),
                ),
                kWidth,
                Expanded(
                  child: Consumer<NoticeBoardAdminProvider>(
                      builder: (context, snapshot, child) {
                    return SizedBox(
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
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: LimitedBox(
                                      maxHeight: size.height - 300,
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount:
                                              noticeCategoryAdmin!.length,
                                          itemBuilder: (context, index) {
                                            return ListTile(
                                              onTap: () async {
                                                print({
                                                  noticeCategoryAdmin![index]
                                                });
                                                categoryvalueController.text =
                                                    await noticeCategoryAdmin![
                                                            index]['value'] ??
                                                        '--';
                                                categoryvalueController1.text =
                                                    await noticeCategoryAdmin![
                                                            index]['text'] ??
                                                        '--';
                                                Navigator.of(context).pop();
                                              },
                                              title: Text(
                                                noticeCategoryAdmin![index]
                                                        ['text'] ??
                                                    '--',
                                                textAlign: TextAlign.center,
                                              ),
                                            );
                                          }),
                                    ));
                              });
                        },
                        child: TextField(
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: UIGuide.BLACK,
                              overflow: TextOverflow.clip),
                          textAlign: TextAlign.center,
                          controller: categoryvalueController1,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(left: 0, top: 0),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            filled: true,
                            fillColor: Colors.transparent,
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(style: BorderStyle.none, width: 0),
                            ),
                            labelText: "  Select Category",
                          ),
                          enabled: false,
                        ),
                      ),
                    );
                  }),
                ),
                kWidth,
                SizedBox(
                  width: 40,
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
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const AddCategory()),
                      );
                    },
                    child: const Icon(Icons.category_outlined),
                  ),
                ),
                kWidth
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
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
                    borderSide: const BorderSide(
                        color: UIGuide.light_Purple, width: 2.0),
                    borderRadius: BorderRadius.circular(10.0),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0, left: 10, right: 10),
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
                    borderSide: const BorderSide(
                        color: UIGuide.light_Purple, width: 2.0),
                    borderRadius: BorderRadius.circular(10.0),
                  )),
            ),
          ),
          Row(
            children: [
              const Spacer(),
              Center(
                child: SizedBox(
                  width: size.width / 2,
                  child: Consumer<NoticeBoardAdminProvider>(
                    builder: (context, value, child) => value.loaddg
                        ? spinkitLoader()
                        : ElevatedButton(
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
                            onPressed: (() async {
                              final result = await FilePicker.platform
                                  .pickFiles(
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

                              if (file.size <= 200000) {
                                await val.noticeImageSave(
                                    context, file.path.toString());
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
                            child: Text(val.imageid == "" || val.imageid == null
                                ? '📁   Choose File'
                                : "File Added"),
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
            style: TextStyle(
                fontSize: 9, color: Color.fromARGB(255, 241, 104, 94)),
          )),
          kheight20,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              kWidth,
              Expanded(
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
                  onPressed: (() async {
                    val.getFromDate(context);
                  }),
                  child: Center(
                      child: val.fromDateDis.isEmpty
                          ? const Text(
                              'From  🗓️ ',
                              style: TextStyle(color: Colors.black87),
                            )
                          : Text("From ${val.fromDateDis}")),
                ),
              ),
              kWidth,
              Expanded(
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
                  onPressed: (() async {
                    await val.getToDate(context);
                  }),
                  child: Center(
                      child: val.toDateDis.isEmpty
                          ? const Text(
                              'To  🗓️ ',
                              style: TextStyle(color: Colors.black87),
                            )
                          : Text("To ${val.toDateDis}")),
                ),
              ),
              kWidth
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
                inactiveBgColor: const Color.fromARGB(255, 212, 212, 212),
                activeBgColor: const [UIGuide.light_Purple],
              ),
            ),
          ),
          kheight10,
          Consumer<NoticeBoardAdminProvider>(builder: (context, value, child) {
            if (value.toggleVal == "all") {
              return const SizedBox(
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

                        listType: MultiSelectListType.CHIP, searchable: true,
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
                              CourseListModel data =
                                  result[i] as CourseListModel;
                              print(data.name);
                              print(data.courseId);
                              courseData.add(data.courseId);
                              courseData.map((e) => data.courseId);
                              print("${courseData.map((e) => data.courseId)}");
                            }

                            print("courseData$courseData");
                            course = courseData.join(',');
                            divisionData.clear();

                            await val.courseCounter(result.length);

                            await val.getDivisionList(course);
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
                builder: (context, value, child) => value.loadSave
                    ? spinkitLoader()
                    : MaterialButton(
                        minWidth: size.width - 150,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        color: UIGuide.light_Purple,
                        onPressed: (() async {
                          if (value.toggleVal == 'student') {
                            if (titleController.text.trim().isEmpty ||
                                mattercontroller.text.trim().isEmpty) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text(
                                  'Enter title & matter',
                                  textAlign: TextAlign.center,
                                ),
                                duration: Duration(seconds: 1),
                              ));
                            } else if (val.fromDateDis.isEmpty ||
                                val.toDateDis.isEmpty ||
                                categoryvalueController.text.isEmpty) {
                              snackbarWidget(
                                  2, "Select mandatory fields...", context);
                            } else if (val.fromDateCheck
                                .isAfter(val.toDateCheck)) {
                              snackbarWidget(2,
                                  'From date is greater than to date', context);
                            } else {
                              await val.noticeBoardSave(
                                  context,
                                  datee.toString(),
                                  val.fromDateDis,
                                  val.toDateDis,
                                  titleController.text,
                                  mattercontroller.text,
                                  value.toggleVal,
                                  courseData,
                                  divisionData,
                                  subjectData,
                                  categoryvalueController.text,
                                  val.imageid ?? "");
                            }
                          } else if (value.toggleVal == "staff") {
                            if (titleController.text.trim().isEmpty ||
                                mattercontroller.text.trim().isEmpty) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text(
                                  'Enter title & matter',
                                  textAlign: TextAlign.center,
                                ),
                                duration: Duration(seconds: 1),
                              ));
                            } else if (val.fromDateDis.isEmpty ||
                                val.toDateDis.isEmpty ||
                                categoryvalueController.text.isEmpty) {
                              snackbarWidget(
                                  2, "Select mandatory fields...", context);
                            } else if (val.fromDateCheck
                                .isAfter(val.toDateCheck)) {
                              snackbarWidget(2,
                                  'From date is greater than to date', context);
                            } else {
                              await val.noticeBoardSave(
                                  context,
                                  datee.toString(),
                                  val.fromDateDis,
                                  val.toDateDis,
                                  titleController.text,
                                  mattercontroller.text,
                                  value.toggleVal,
                                  courseData,
                                  divisionData,
                                  subjectData,
                                  categoryvalueController.text,
                                  val.imageid ?? "");

                              await val.noticeBoardSendNotification(datee.toString(),
                                  val.fromDateDis,
                                  val.toDateDis,
                                  titleController.text,
                                  mattercontroller.text,
                                  value.toggleVal,
                                  courseData,
                                  divisionData,
                                  subjectData,
                                  categoryvalueController.text,
                                  val.imageid ?? "",
                                  val.noticeBoardId.toString()
                              );
                            }
                          } else {
                            if (titleController.text.trim().isEmpty ||
                                mattercontroller.text.trim().isEmpty) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text(
                                  'Enter title & matter',
                                  textAlign: TextAlign.center,
                                ),
                                duration: Duration(seconds: 1),
                              ));
                            } else if (val.fromDateDis.isEmpty ||
                                val.toDateDis.isEmpty ||
                                categoryvalueController.text.isEmpty) {
                              snackbarWidget(
                                  2, "Select mandatory fields...", context);
                            } else if (val.fromDateCheck
                                .isAfter(val.toDateCheck)) {
                              snackbarWidget(2,
                                  'From date is greater than to date', context);
                            } else {
                              await val.noticeBoardSave(
                                  context,
                                  datee.toString(),
                                  val.fromDateDis,
                                  val.toDateDis,
                                  titleController.text,
                                  mattercontroller.text,
                                  value.toggleVal,
                                  courseData,
                                  divisionData,
                                  subjectData,
                                  categoryvalueController.text,
                                  val.imageid ?? "");

                              await val.noticeBoardSendNotification(datee.toString(),
                                  val.fromDateDis,
                                  val.toDateDis,
                                  titleController.text,
                                  mattercontroller.text,
                                  value.toggleVal,
                                  courseData,
                                  divisionData,
                                  subjectData,
                                  categoryvalueController.text,
                                  val.imageid ?? "",
                                  val.noticeBoardId.toString()
                              );
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
      ),
    );
  }
}
