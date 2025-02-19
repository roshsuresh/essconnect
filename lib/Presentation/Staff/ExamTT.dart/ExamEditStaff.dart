import 'package:essconnect/Application/AdminProviders/ExamTTPtoviders.dart';
import 'package:essconnect/Constants.dart';
import 'package:essconnect/Domain/Admin/Course&DivsionList.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
// import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:multiselect_dropdown_with_select_all/multiselect_dropdown_with_select_all.dart';
import 'package:provider/provider.dart';

import '../../../Application/Staff_Providers/ExamTTProviderStaff.dart';
import '../../../utils/spinkit.dart';

class ExamTTEditStaff extends StatefulWidget {
  String? eventId;
  ExamTTEditStaff({super.key, this.eventId});

  @override
  State<ExamTTEditStaff> createState() => _ExamTTEditStaffState();
}

class _ExamTTEditStaffState extends State<ExamTTEditStaff> {
  List<String> divisionData = [];
  List div=[];
  String division = '';
  String? courseId;
  late TextEditingController descriptioncontroller;
  late TextEditingController studReportcourseController;
  late TextEditingController studReportcourseController1;
  @override
  void initState() {
    super.initState();

    // Initialize controllers with empty values to avoid late initialization errors
    descriptioncontroller = TextEditingController();
    studReportcourseController = TextEditingController();
    studReportcourseController1 = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var p = Provider.of<ExamTTAdmProviders>(context, listen: false);
      var pstaff = Provider.of<ExamTTAdmProvidersStaff>(context, listen: false);
      p.EditUploadExamtimetables = null;
      await p.examTTEdit(context, widget.eventId);
      pstaff.courseList.clear();

      pstaff.divisionCounter(0);
      pstaff.divisionDropDown.clear();
      pstaff.divisionList.clear();
      descriptioncontroller.clear();
      studReportcourseController.clear();
      studReportcourseController1.clear();
      await p.getVariables();
      p.imageid = p.EditUploadExamtimetables?.attachmentId;
      await pstaff.getCourseList();
      // Update the controller after the data is fetched
        descriptioncontroller.text = p.EditUploadExamtimetables?.description ?? "";
        studReportcourseController.text = p.EditUploadExamtimetables?.courseId ?? "";
        var selectedCourseName = pstaff.courseList
            .firstWhere(
                (course) => course.id == p.EditUploadExamtimetables?.courseId,)
            ?.courseName;
        studReportcourseController1.text = selectedCourseName ?? "";
        await pstaff.getDivisionList(p.EditUploadExamtimetables!.courseId!);
        divisionData = p.EditUploadExamtimetables!.divisionId!;
        print("division Data");
        print(divisionData);
        pstaff.divisionLen = divisionData.length;
        // div = divisionData;

        division='(${divisionData.join(', ')})';
        print(div);
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var pstaff = Provider.of<ExamTTAdmProvidersStaff>(context, listen: false);
    return
      Scaffold(
        appBar: AppBar(
          title: const Text(
            'Exam Timetable [Edit]',
          ),
          titleSpacing: 00.0,
          centerTitle: true,
          toolbarHeight: 60.2,
          toolbarOpacity: 0.8,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(25),
                bottomLeft: Radius.circular(25)),
          ),
          backgroundColor: UIGuide.light_Purple,
        ),
        body:
        Consumer<ExamTTAdmProviders>(
          builder: (context, val, _) =>
          val.loading?Center(child: spinkitLoader()):
          SingleChildScrollView(
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
                          onPressed: (() async {
                            await val.getExamStartDateEdit(context);
                          }),
                          child: Center(
                              child: val.startDateDEdit.isEmpty
                                  ? const Text(
                                'Exam start date',
                                style: TextStyle(color: Colors.black87),
                              )
                                  : Text( "Start Date ${val.startDateDEdit}")),
                        ),
                      ),
                    ),
                    kWidth,
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        child: Consumer<ExamTTAdmProviders>(
                          builder: (context, value, child) => value.loaddg
                              ? const Center(
                              child: Text(
                                'Uploading Image....',
                                style: TextStyle(color: UIGuide.light_Purple),
                              ))
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
                                await Provider.of<ExamTTAdmProviders>(context,
                                    listen: false)
                                    .examImageSave(
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
                          onPressed: (() async {
                            await val.getFromDateEdit(context);
                          }),
                          child: Center(
                              child: val.fromDateDisEdit.isEmpty
                                  ? const Text(
                                'From  🗓️ ',
                                style: TextStyle(color: Colors.black87),
                              )
                                  : Text("From ${val.fromDateDisEdit}")),
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
                          onPressed: (() async {
                            await val.getToDateEdit(context);
                          }),
                          child: Center(
                              child: val.toDateDisEdit.isEmpty
                                  ? const Text(
                                'To  🗓️ ',
                                style: TextStyle(color: Colors.black87),
                              )
                                  : Text("To ${val.toDateDisEdit}")),
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
                        child: Consumer<ExamTTAdmProviders>(
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
                                                borderRadius:
                                                BorderRadius.circular(15)),
                                            child: LimitedBox(
                                              maxHeight: size.height - 300,
                                              child: ListView.builder(
                                                  shrinkWrap: true,
                                                  itemCount: pstaff.courseList.length,
                                                  itemBuilder: (context, index) {
                                                    return ListTile(
                                                      onTap: () async {
                                                        await pstaff.divisionClear();
                                                        setState(() {
                                                          snapshot.divisionDropDown.clear();
                                                          courseId="";
                                                          studReportcourseController
                                                              .text = "";
                                                          studReportcourseController1.text = "";
                                                          divisionData=[];
                                                          division ="";
                                                          pstaff.divisionList.clear();
                                                          pstaff.divisionLen = 0;
                                                          print("Division Data  =====");
                                                          print(divisionData);

                                                        });

                                                        studReportcourseController
                                                            .text = pstaff
                                                            .courseList[index]
                                                            .id ??
                                                            '---';
                                                        studReportcourseController1
                                                            .text = pstaff
                                                            .courseList[index]
                                                            .courseName ==
                                                            null
                                                            ? '---'
                                                            : pstaff
                                                            .courseList[index].courseName
                                                            .toString();

                                                        courseId =
                                                            studReportcourseController
                                                                .text
                                                                .toString();
                                                        print(studReportcourseController
                                                            .text);

                                                        await pstaff
                                                            .getDivisionList(courseId!);

                                                        Navigator.of(context).pop();
                                                      },
                                                      title: Text(
                                                        pstaff.courseList[index]
                                                            .courseName ==
                                                            null
                                                            ? '---'
                                                            : pstaff
                                                            .courseList[index].courseName
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
                          height: 60,
                          child:
                          // MultiSelectDialogField(
                          //   initialValue: divisionData,
                          //   items: value.divisionDropDown,
                          //   listType: MultiSelectListType.CHIP,
                          //   title: const Text(
                          //     "Select Division",
                          //     style: TextStyle(color: Colors.black),
                          //   ),
                          //   selectedItemsTextStyle: const TextStyle(
                          //       fontWeight: FontWeight.w900,
                          //       color: UIGuide.light_Purple),
                          //   confirmText: const Text(
                          //     'OK',
                          //     style: TextStyle(color: UIGuide.light_Purple),
                          //   ),
                          //   cancelText: const Text(
                          //     'Cancel',
                          //     style: TextStyle(color: UIGuide.light_Purple),
                          //   ),
                          //   separateSelectedItems: true,
                          //   decoration: const BoxDecoration(
                          //     color: UIGuide.ButtonBlue,
                          //     boxShadow: [
                          //       BoxShadow(
                          //         color: Colors.grey,
                          //         offset: Offset(0, 2),
                          //         blurRadius: 4,
                          //         spreadRadius: 0,
                          //       ),
                          //     ],
                          //     borderRadius: BorderRadius.all(Radius.circular(10)),
                          //   ),
                          //   buttonIcon: const Icon(
                          //     Icons.arrow_drop_down_outlined,
                          //     color: Colors.grey,
                          //   ),
                          //   buttonText: value.divisionLen == 0
                          //       ? const Text(
                          //     "Select Division",
                          //     style: TextStyle(
                          //       color: Colors.black,
                          //       fontSize: 14,
                          //     ),
                          //   )
                          //       : Text(
                          //     "   ${value.divisionLen.toString()} Selected",
                          //     style: const TextStyle(
                          //       color: Colors.black,
                          //       fontSize: 14,
                          //     ),
                          //   ),
                          //   chipDisplay: MultiSelectChipDisplay.none(),
                          //   onConfirm: (results) async {
                          //     divisionData = [];
                          //     for (var i = 0; i < results.length; i++) {
                          //       DivisionListModel data =
                          //       results[i] as DivisionListModel;
                          //       print(data.text);
                          //       print(data.value);
                          //       divisionData.add(data.value);
                          //       divisionData.map((e) => data.value);
                          //       print("${divisionData.map((e) => data.value)}");
                          //     }
                          //     division = divisionData.join(',');
                          //     await Provider.of<ExamTTAdmProviders>(context,
                          //         listen: false)
                          //         .divisionCounter(results.length);
                          //     results.clear();
                          //     print(divisionData.join(','));
                          //   },
                          // ),
                          // MultiSelectDialogField(
                          //   initialValue: divisionData,
                          //   items: value.divisionDropDown,
                          //   selectedColor:UIGuide.THEME_LIGHT,
                          //   listType: MultiSelectListType.CHIP,
                          //   title: const Text(
                          //         "Select Division",
                          //         style: TextStyle(color: Colors.black),
                          //       ),
                          //   separateSelectedItems:true,
                          //   selectedItemsTextStyle: const TextStyle(
                          //       fontWeight: FontWeight.w900,
                          //       color: UIGuide.light_Purple),
                          //   confirmText: const Text(
                          //     'OK',
                          //     style: TextStyle(color: UIGuide.light_Purple),
                          //   ),
                          //   cancelText: const Text(
                          //     'Cancel',
                          //     style: TextStyle(color: UIGuide.light_Purple),
                          //   ),
                          //   decoration: const BoxDecoration(
                          //     color: UIGuide.ButtonBlue,
                          //     boxShadow: [
                          //       BoxShadow(
                          //         color: Colors.grey,
                          //         offset: Offset(0, 2),
                          //         blurRadius: 4,
                          //         spreadRadius: 0,
                          //       ),
                          //     ],
                          //     borderRadius:
                          //     BorderRadius.all(Radius.circular(10)),
                          //   ),
                          //   buttonIcon: const Icon(
                          //     Icons.arrow_drop_down_outlined,
                          //     color: Colors.grey,
                          //   ),
                          //   buttonText: value.divisionLen == 0
                          //       ? const Text(
                          //     "Select Division",
                          //     style: TextStyle(
                          //       color: Colors.black,
                          //       fontSize: 16,
                          //     ),
                          //   )
                          //       : Text(
                          //     "   ${value.divisionLen.toString()} Selected",
                          //     style: const TextStyle(
                          //       color: Colors.black,
                          //       fontSize: 16,
                          //     ),
                          //   ),
                          //
                          //
                          //   // onConfirm: (results) async {
                          //   //   divisionData = [];
                          //   //   for (var i = 0; i < results.length; i++) {
                          //   //     DivisionListModel data =
                          //   //     results[i] as DivisionListModel;
                          //   //     print(data.text);
                          //   //     print(data.value);
                          //   //     divisionData.add(data.value);
                          //   //     divisionData.map((e) => data.value);
                          //   //     print("${divisionData.map((e) => data.value)}");
                          //   //   }
                          //   //   division = divisionData.join(',');
                          //   //   await Provider.of<ExamTTAdmProviders>(context,
                          //   //       listen: false)
                          //   //       .divisionCounter(results.length);
                          //   //   results.clear();
                          //   //   print(divisionData.join(','));
                          //   // },
                          //   onConfirm: (results) async {
                          //     // value.results.clear();
                          //     print("results");
                          //     print(results);
                          //     div= results;
                          //
                          //     divisionData.clear();
                          //     // results.clear();
                          //     for (var i = 0; i < results.length; i++) {
                          //       DivisionListModel data =
                          //       div[i] as DivisionListModel;
                          //
                          //       print(data.value);
                          //       divisionData.add(data.value);
                          //       divisionData.map((e) => data.value);
                          //       print("${divisionData.map((e) => data.value)}");
                          //     }
                          //     print("divisionDataaa    $divisionData");
                          //     division = divisionData
                          //         .map((id) => id)
                          //         .join(',');
                          //     print(division);
                          //     await value.divisionCounter(divisionData.length);
                          //     //value.studentViewList.clear();
                          //
                          //     print("data division  $division");
                          //   },
                          //   chipDisplay:
                          //   MultiSelectChipDisplay.none(),
                          //
                          //
                          // ),
                          SizedBox(
                            width: 325,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Theme(
                                data: ThemeData.light().copyWith(
                                ),
                                child:MultiSelectDropdown(
                                  items: value.divisionList
                                      .map((division) => MultiSelectItem(
                                      division.value!, division.text!))
                                      .toList(),
                                  initialSelectedValues: divisionData,
                                  hint: 'Division',
                                  isMultiSelect: true,
                                  selectAllflag: true,
                                  colorHeading: Color.fromARGB(255, 7, 68, 126),
                                  colorPlaceholder: Colors.grey,
                                  colorDropdownIcon: Color.fromARGB(255, 7, 68, 126),
                                  radius: 10,
                                  borderColor: Color.fromARGB(255, 7, 68, 126),
                                  onChanged: (values) {
                                    setState(() {
                                      divisionData.clear();
                                      divisionData = values;
                                    });
                                  },
                                ),),
                            ),
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
                    width: 150,
                    child: MaterialButton(
                      minWidth: size.width - 150,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0))),
                      color: UIGuide.light_Purple,
                      onPressed: (() async {
                        print(val.startDate.isEmpty);
                        print(val.fromDateDis.isEmpty);
                        print(val.toDateDis.isEmpty);
                        print( divisionData.isEmpty);
                        print(val.startDate.isEmpty);
                        print(val.startDate.isEmpty);
                        var parsedResponse = await parseJWT();
                        print(parsedResponse['StaffId']);
                        if (parsedResponse['StaffId'] == val.createdstaff) {
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
                                'Enter Description..',
                                textAlign: TextAlign.center,
                              ),
                              duration: Duration(seconds: 1),
                            ));
                          } else if (val.startDateEdit.isEmpty ||
                              val.fromDateDisEdit.isEmpty ||
                              val.toDateDisEdit.isEmpty ||
                              divisionData.isEmpty ||
                              studReportcourseController.text.isEmpty ||
                              descriptioncontroller.text.trim().isEmpty) {
                            snackbarWidget(2, "Enter mandatory fields...", context);
                          } else if (val.fromDateCheckEdit.isAfter(val.toDateCheckEdit)) {
                            snackbarWidget(
                                2, 'From date is greater than to date', context);
                          } else if (val.fromDateCheckEdit
                              .isAfter(val.startDateCheckEdit)) {
                            snackbarWidget(
                                2,
                                'From date should be earlier than the startdate',
                                context);
                          } else {
                            await val.examUpdate(
                                context,
                                val.startDateEdit,
                                val.fromDateEdit,
                                val.toDateEdit,
                                descriptioncontroller.text,
                                studReportcourseController.text,
                                divisionData,
                                val.imageid ?? "",
                              widget.eventId
                            );

                            descriptioncontroller.clear();
                            studReportcourseController.clear();
                            studReportcourseController1.clear();

                            divisionData.clear();
                            pstaff.divisionLen = 0;
                            pstaff.divisionClear();

                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                              ),
                              duration: Duration(seconds: 3),
                              margin:
                              EdgeInsets.only(bottom: 80, left: 30, right: 30),
                              behavior: SnackBarBehavior.floating,
                              content: Text(
                                "Sorry, you don't have access",
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        }
                      }),
                      child: const Text(
                        'Update',
                        style: TextStyle(color: UIGuide.WHITE, fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
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
        ),
      );
  }
}
