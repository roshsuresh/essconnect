import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:essconnect/Application/Staff_Providers/ExamTTProviderStaff.dart';
import 'package:essconnect/Constants.dart';
import 'package:essconnect/Domain/Staff/ExamTTModelStaff.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';

class ExamTTUploadStaff extends StatefulWidget {
  ExamTTUploadStaff({Key? key}) : super(key: key);

  @override
  State<ExamTTUploadStaff> createState() => _ExamTTUploadStaffState();
}

class _ExamTTUploadStaffState extends State<ExamTTUploadStaff> {
  String? datee;
  DateTime? _mydatetimeFrom;
  DateTime? _mydatetimeTo;
  DateTime? _mydisplayFrom;
  String? checkname;
  String time = '--';
  List divisionData = [];
  String division = '';
  String timeNow = '--';
  String displayFrom = 'Exam start date';
  String? courseId;
  String attach = '';

  final attachmentid = TextEditingController();
  final descriptioncontroller = TextEditingController();
  final studReportcourseController = TextEditingController();
  final studReportcourseController1 = TextEditingController();
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var p = Provider.of<ExamTTAdmProvidersStaff>(context, listen: false);
      p.courseList.clear();
      p.getCourseList();
      p.divisionCounter(0);
      p.divisionDropDown.clear();
      p.divisionList.clear();
      attachmentid.clear();
      descriptioncontroller.clear();
      studReportcourseController.clear();
      studReportcourseController1.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      physics:
          const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(13.0),
            child: TextFormField(
              controller: descriptioncontroller,
              minLines: 1,
              inputFormatters: [LengthLimitingTextInputFormatter(50)],
              maxLines: 1,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                labelText: 'Exam Description*',
                labelStyle: const TextStyle(color: UIGuide.light_Purple),
                hintText: 'Description',
                hintStyle: const TextStyle(color: Colors.grey),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: UIGuide.light_Purple, width: 1.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
            ),
          ),
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
                    _mydisplayFrom = await showDatePicker(
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
                      displayFrom =
                          DateFormat('yyyy-MM-dd').format(_mydisplayFrom!);
                    });
                  }),
                  //  minWidth: size.width - 216,
                  child: Center(child: Text(displayFrom)),
                ),
              ),
              Spacer(),
              SizedBox(
                width: size.width * .45,
                height: 35,
                child: Consumer<ExamTTAdmProvidersStaff>(
                  builder: (context, value, child) => value.loading
                      ? Container(
                          child: const Center(
                              child: Text(
                          'Uploading File....',
                          style: TextStyle(color: UIGuide.light_Purple),
                        )))
                      : MaterialButton(
                          color: Colors.white,
                          onPressed: (() async {
                            final result = await FilePicker.platform.pickFiles(
                                type: FileType.custom,
                                allowedExtensions: [
                                  'png',
                                  'jpeg',
                                  'jpg',
                                  'pdf'
                                ]);
                            if (result == null) {
                              return;
                            }
                            final file = result.files.first;
                            print('Name: ${file.name}');
                            print('Path: ${file.path}');
                            print('Extension: ${file.extension}');

                            int sizee = file.size;

                            if (sizee <= 200000) {
                              await Provider.of<ExamTTAdmProvidersStaff>(
                                      context,
                                      listen: false)
                                  .examImageSave(context, file.path.toString());
                              attach = value.id.toString();
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
              Spacer()
            ],
          ),
          const SizedBox(
            height: 3,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: size.width * .45,
                child: const Text(
                  'Maximum allowed file size is 200 KB',
                  style: TextStyle(
                      fontSize: 9, color: Color.fromARGB(255, 241, 104, 94)),
                ),
              ),
            ],
          ),
          kheight10,
          Row(
            children: [
              const Spacer(),
              SizedBox(
                width: size.width * .45,
                height: 35,
                child: MaterialButton(
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
                      time = DateFormat('yyyy-MM-dd').format(_mydatetimeFrom!);
                      print(time);
                    });
                  }),
                  child: Center(child: Text('From  $time')),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: size.width * .45,
                height: 35,
                child: MaterialButton(
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
                      timeNow = DateFormat('yyyy-MM-dd').format(_mydatetimeTo!);
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
          Row(
            children: [
              Spacer(),
              SizedBox(
                // decoration: BoxDecoration(
                //     border: Border.all(color: Colors.grey, width: 1),
                //     borderRadius: BorderRadius.circular(10)),
                height: 50,
                width: MediaQuery.of(context).size.width * 0.46,
                child: Consumer<ExamTTAdmProvidersStaff>(
                    builder: (context, snapshot, child) {
                  return InkWell(
                    onTap: () async {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                                child: Container(
                              child: LimitedBox(
                                maxHeight: size.height - 300,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: snapshot.courseList.length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        onTap: () async {
                                          studReportcourseController.text =
                                              snapshot.courseList[index].id ??
                                                  '---';
                                          studReportcourseController1.text =
                                              snapshot.courseList[index]
                                                          .courseName ==
                                                      null
                                                  ? '---'
                                                  : snapshot.courseList[index]
                                                      .courseName
                                                      .toString();

                                          courseId = studReportcourseController
                                              .text
                                              .toString();
                                          print(
                                              studReportcourseController.text);
                                          divisionData.clear();
                                          snapshot.divisionLen = 0;
                                          snapshot.divisionClear();

                                          await Provider.of<
                                                      ExamTTAdmProvidersStaff>(
                                                  context,
                                                  listen: false)
                                              .getDivisionList(courseId!);

                                          Navigator.of(context).pop();
                                        },
                                        title: Text(
                                          snapshot.courseList[index]
                                                      .courseName ==
                                                  null
                                              ? '---'
                                              : snapshot
                                                  .courseList[index].courseName
                                                  .toString(),
                                          textAlign: TextAlign.center,
                                        ),
                                      );
                                    }),
                              ),
                            ));
                          });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(0),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 2),
                                borderRadius: BorderRadius.circular(10)),
                            height: 50.0,
                            child: TextField(
                              textAlign: TextAlign.center,
                              controller: studReportcourseController1,
                              decoration: InputDecoration(
                                filled: true,
                                contentPadding:
                                    EdgeInsets.only(left: 0, top: 0),
                                fillColor: UIGuide.WHITE,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                labelText: "  Select Course",
                                labelStyle: TextStyle(color: UIGuide.BLACK),
                                hintText: "Course",
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 2.0),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 2.0,
                                  ),
                                ),
                              ),
                              enabled: false,
                            ),
                          ),
                          // SizedBox(
                          //   height: 0,
                          //   child: TextField(
                          //     controller: studReportcourseController,
                          //     decoration: const InputDecoration(
                          //       filled: true,
                          //       fillColor: UIGuide.WHITE,
                          //       border: OutlineInputBorder(),
                          //       labelText: "",
                          //       hintText: "",
                          //     ),
                          //     enabled: false,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
              Spacer(),
              Consumer<ExamTTAdmProvidersStaff>(
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
                        // value.divisionLen = 0;
                        for (var i = 0; i < results.length; i++) {
                          DivisionsExam data = results[i] as DivisionsExam;
                          print(data.text);
                          print(data.value);
                          divisionData.add(data.value);
                          divisionData.map((e) => data.value);
                          print("${divisionData.map((e) => data.value)}");
                        }
                        division = divisionData.join(',');
                        await Provider.of<ExamTTAdmProvidersStaff>(context,
                                listen: false)
                            .divisionCounter(results.length);
                        results.clear();

                        print(divisionData.join(','));
                      },
                    ),
                  ),
                ),
              ),
              Spacer()
            ],
          ),
          kheight20,
          Center(
            child: SizedBox(
              width: 150,
              child: MaterialButton(
                minWidth: size.width - 150,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                color: UIGuide.light_Purple,
                onPressed: (() async {
                  attachmentid.text = attach;

                  if (attachmentid.toString().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                        'Select File..',
                        textAlign: TextAlign.center,
                      ),
                      duration: Duration(seconds: 1),
                    ));
                  }
                  // if (checkname!.isEmpty) {
                  //   attachmentid.clear();
                  // } else {
                  //   attachmentid.text = attach;
                  // }
                  if (descriptioncontroller.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                        'Enter Description...',
                        textAlign: TextAlign.center,
                      ),
                      duration: Duration(seconds: 1),
                    ));
                  } else if (descriptioncontroller.text.isNotEmpty &&
                      studReportcourseController.text.isNotEmpty &&
                      division.toString().isNotEmpty) {
                    print('object');
                    print("attachmentid   $attachmentid");
                    await Provider.of<ExamTTAdmProvidersStaff>(context,
                            listen: false)
                        .examSave(
                            context,
                            displayFrom,
                            time,
                            timeNow,
                            descriptioncontroller.text,
                            studReportcourseController.text,
                            divisionData,
                            attachmentid.text);
                  } else {
                    await AwesomeDialog(
                            context: context,
                            dialogType: DialogType.warning,
                            animType: AnimType.rightSlide,
                            headerAnimationLoop: false,
                            desc: 'Enter mandatory fileds',
                            btnOkOnPress: () {},
                            btnOkIcon: Icons.cancel,
                            btnOkColor: Colors.red)
                        .show();
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
          kheight20,
          kheight20,
          Center(
            child: Container(
              height: size.width / 2,
              width: size.width / 2,
              child: LottieBuilder.network(
                'https://assets6.lottiefiles.com/private_files/lf30_njyaxxst.json',
                filterQuality: FilterQuality.low,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
