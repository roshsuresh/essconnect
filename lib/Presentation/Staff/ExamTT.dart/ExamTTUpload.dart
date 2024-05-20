import 'package:essconnect/Application/Staff_Providers/ExamTTProviderStaff.dart';
import 'package:essconnect/Constants.dart';
import 'package:essconnect/Domain/Staff/ExamTTModelStaff.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';

class ExamTTUploadStaff extends StatefulWidget {
  const ExamTTUploadStaff({Key? key}) : super(key: key);

  @override
  State<ExamTTUploadStaff> createState() => _ExamTTUploadStaffState();
}

class _ExamTTUploadStaffState extends State<ExamTTUploadStaff> {
  String? checkname;

  List divisionData = [];
  String division = '';

  String? courseId;

  final descriptioncontroller = TextEditingController();
  final studReportcourseController = TextEditingController();
  final studReportcourseController1 = TextEditingController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var p = Provider.of<ExamTTAdmProvidersStaff>(context, listen: false);
      p.courseList.clear();
      p.divisionCounter(0);
      p.divisionDropDown.clear();
      p.divisionList.clear();
      descriptioncontroller.clear();
      studReportcourseController.clear();
      studReportcourseController1.clear();
      await p.getVariables();
      p.getCourseList();
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      physics:
          const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      child: Consumer<ExamTTAdmProvidersStaff>(
        builder: (context, val, _) => Column(
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
                    borderSide: const BorderSide(
                        color: UIGuide.light_Purple, width: 1.0),
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
                        await val.getExamStartDate(context);
                      },
                      child: Center(
                          child: val.startDateD.isEmpty
                              ? const Text(
                                  'Exam start date',
                                  style: TextStyle(color: Colors.black87),
                                )
                              : Text(val.startDateD)),
                    ),
                  ),
                ),
                kWidth,
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: Consumer<ExamTTAdmProvidersStaff>(
                      builder: (context, value, child) => value.loading
                          ? const SizedBox(
                              child: Center(
                                  child: Text(
                              'Uploading File....',
                              style: TextStyle(color: UIGuide.light_Purple),
                            )))
                          : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 3,
                                foregroundColor: UIGuide.BLACK,
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
                                  await val.examImageSave(
                                      context, file.path.toString());
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
                              child: Text(
                                  val.imageid == "" || val.imageid == null
                                      ? 'Choose File'
                                      : "File Added"),
                            ),
                    ),
                  ),
                ),
                kWidth
              ],
            ),
            const SizedBox(
              height: 4,
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
                                  'From  🗓️ ',
                                  style: TextStyle(color: Colors.black87),
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
                        await val.getToDate(context);
                      },
                      child: Center(
                          child: val.toDateDis.isEmpty
                              ? const Text(
                                  'To  🗓️ ',
                                  style: TextStyle(color: Colors.black87),
                                )
                              : Text("To ${val.toDateDis}")),
                    ),
                  ),
                ),
                kWidth
              ],
            ),
            kheight20,
            Row(
              children: [
                kWidth,
                Expanded(
                  child: SizedBox(
                    height: 45,
                    child: Consumer<ExamTTAdmProvidersStaff>(
                        builder: (context, snapshot, child) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 3,
                          foregroundColor: UIGuide.light_Purple,
                          backgroundColor: UIGuide.ButtonBlue,
                          padding: const EdgeInsets.all(0),
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              color: UIGuide.light_black,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () async {
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
                                          itemCount: snapshot.courseList.length,
                                          itemBuilder: (context, index) {
                                            return ListTile(
                                              onTap: () async {
                                                studReportcourseController
                                                    .text = snapshot
                                                        .courseList[index].id ??
                                                    '---';
                                                studReportcourseController1
                                                    .text = snapshot
                                                            .courseList[index]
                                                            .courseName ==
                                                        null
                                                    ? '---'
                                                    : snapshot.courseList[index]
                                                        .courseName
                                                        .toString();

                                                courseId =
                                                    studReportcourseController
                                                        .text
                                                        .toString();
                                                print(studReportcourseController
                                                    .text);
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
                                                    : snapshot.courseList[index]
                                                        .courseName
                                                        .toString(),
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
                              color: UIGuide.BLACK,
                              overflow: TextOverflow.clip),
                          textAlign: TextAlign.center,
                          controller: studReportcourseController1,
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(left: 0, top: 0),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              filled: true,
                              fillColor: Colors.transparent,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    style: BorderStyle.none, width: 0),
                              ),
                              labelText: "   Select Course",
                              labelStyle: TextStyle(
                                  color: Colors.black87, fontSize: 15)),
                          enabled: false,
                        ),
                      );
                    }),
                  ),
                ),
                kWidth,
                Expanded(
                  child: Consumer<ExamTTAdmProvidersStaff>(
                    builder: (context, value, child) => SizedBox(
                      height: 45,
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
                        buttonText: value.divisionLen == 0
                            ? const Text(
                                "Select Division",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              )
                            : Text(
                                "   ${value.divisionLen.toString()} Selected",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                        chipDisplay: MultiSelectChipDisplay.none(),
                        onConfirm: (results) async {
                          divisionData = [];

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
                kWidth
              ],
            ),
            kheight20,
            Center(
              child: SizedBox(
                width: size.width / 2.4,
                child: val.loadingSave
                    ? const Center(
                        child: CircularProgressIndicator(
                        color: UIGuide.light_Purple,
                        strokeWidth: 2,
                      ))
                    : MaterialButton(
                        elevation: 5,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        color: UIGuide.light_Purple,
                        onPressed: (() async {
                          if (val.imageid!.isEmpty || val.imageid == null) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text(
                                'Select File..',
                                textAlign: TextAlign.center,
                              ),
                              duration: Duration(seconds: 1),
                            ));
                          } else if (descriptioncontroller.text.isEmpty) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text(
                                'Enter Description...',
                                textAlign: TextAlign.center,
                              ),
                              duration: Duration(seconds: 1),
                            ));
                          } else if (val.startDate.isEmpty ||
                              val.fromDateDis.isEmpty ||
                              val.toDateDis.isEmpty ||
                              divisionData.isEmpty ||
                              studReportcourseController.text.isEmpty ||
                              descriptioncontroller.text.trim().isEmpty) {
                            snackbarWidget(
                                2, "Enter mandatory fields...", context);
                          } else if (val.fromDateCheck
                              .isAfter(val.toDateCheck)) {
                            snackbarWidget(2,
                                'From date is greater than to date', context);
                          } else if (val.fromDateCheck
                              .isAfter(val.startDateCheck)) {
                            snackbarWidget(
                                2,
                                'From date should be earlier than the startdate',
                                context);
                          } else {
                            await val.examSave(
                                context,
                                val.startDate,
                                val.fromDate,
                                val.toDate,
                                descriptioncontroller.text,
                                studReportcourseController.text,
                                divisionData,
                                val.imageid ?? "");
                            descriptioncontroller.clear();
                            studReportcourseController.clear();
                            studReportcourseController1.clear();

                            divisionData.clear();
                            val.divisionLen = 0;
                            val.divisionClear();
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
              child: SizedBox(
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
      ),
    );
  }
}
