import 'package:essconnect/Application/Staff_Providers/MissingReportProviders.dart';
import 'package:essconnect/Constants.dart';
import 'package:essconnect/Domain/Staff/MissingModel.dart/InitialMissingReportModel.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:essconnect/utils/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';

class MissingReport extends StatefulWidget {
  const MissingReport({Key? key}) : super(key: key);

  @override
  State<MissingReport> createState() => _MissingReportState();
}

class _MissingReportState extends State<MissingReport> {
  List divisionData = [];
  List subjectData = [];
  String subject = '';

  String division = '';
  // bool checked = false;
  String courseId = '';
  String partID = '';
  final missingInitialValuesController = TextEditingController();
  final missingInitialValuesController1 = TextEditingController();

  final missingPartController = TextEditingController();
  final missingPartController1 = TextEditingController();

  final missingExamController = TextEditingController();
  final missingExamController1 = TextEditingController();

  String examId = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var p = Provider.of<MissingReportProviders>(context, listen: false);
      await p.courseClear();
      await p.clearDivision();
      await p.clearPart();
      p.divisionDrop.clear();
      await p.divisionCounter(0);
      await p.subjectCounter(0);
      await p.getInitialValues();
      await p.clearSubject();
      await p.subjectCounter(0);
      await p.clearViewStaffList();
      await p.clearViewStudentList();
      p.isShown = false;
    });
  }

  final _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Spacer(),
            const Text('MarkEntry Missing Report'),
            const Spacer(),
            IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MissingReport()));
                },
                icon: const Icon(Icons.refresh))
          ],
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
      body: Consumer<MissingReportProviders>(
        builder: (context, value, child) => Stack(
          children: [
            Column(
              // physics: const PageScrollPhysics(),
              // shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Spacer(),
                      SizedBox(
                        height: 45,
                        width: MediaQuery.of(context).size.width * 0.46,
                        child: Consumer<MissingReportProviders>(
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
                                              itemCount: snapshot
                                                  .missingInitialValues.length,
                                              itemBuilder: (context, index) {
                                                return ListTile(
                                                  onTap: () async {
                                                    Navigator.of(context).pop();
                                                    missingInitialValuesController
                                                        .text = snapshot
                                                            .missingInitialValues[
                                                                index]
                                                            .id ??
                                                        '--';
                                                    missingInitialValuesController1
                                                        .text = snapshot
                                                            .missingInitialValues[
                                                                index]
                                                            .courseName ??
                                                        '--';
                                                    courseId =
                                                        missingInitialValuesController
                                                            .text
                                                            .toString();
                                                    await snapshot
                                                        .clearDivision();
                                                    await snapshot.clearPart();

                                                    snapshot.divisionLen = 0;

                                                    divisionData.clear();

                                                    missingPartController
                                                        .clear();
                                                    missingPartController1
                                                        .clear();

                                                    missingExamController
                                                        .clear();
                                                    missingExamController1
                                                        .clear();

                                                    await snapshot
                                                        .clearSubject();
                                                    subjectData.clear();
                                                    snapshot.subjectLen = 0;

                                                    await snapshot
                                                        .getDivisionList(
                                                            courseId);

                                                    await value
                                                        .clearViewStaffList();
                                                    await value
                                                        .clearViewStudentList();
                                                  },
                                                  title: Text(
                                                    snapshot
                                                            .missingInitialValues[
                                                                index]
                                                            .courseName ??
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
                              controller: missingInitialValuesController1,
                              decoration: InputDecoration(
                                filled: true,
                                contentPadding:
                                    const EdgeInsets.only(left: 0, top: 0),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                fillColor: Colors.transparent,
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      style: BorderStyle.none, width: 0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 2.0),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                    color: Colors.white,
                                    width: 2.0,
                                  ),
                                ),
                                labelText: "  Select Course",
                                hintText: "   Select Course",
                              ),
                              readOnly: true,
                              enabled: false,
                            ),
                          );
                        }),
                      ),
                      const Spacer(),
                      Consumer<MissingReportProviders>(
                        builder: (context, value, child) => SizedBox(
                          width: size.width * .46,
                          height: 45,
                          child: MultiSelectDialogField(
                            items: value.divisionDrop,
                            listType: MultiSelectListType.CHIP,
                            title: const Text(
                              "Select Division",
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            buttonIcon: const Icon(
                              Icons.arrow_drop_down_outlined,
                              color: Colors.grey,
                            ),
                            buttonText: value.divisionLen == 0
                                ? const Text(
                                    "Select Division",
                                    style: TextStyle(
                                      color: Colors.grey,
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
                            searchable: true,
                            chipDisplay: MultiSelectChipDisplay.none(),
                            onConfirm: (results) async {
                              divisionData = [];

                              for (var i = 0; i < results.length; i++) {
                                DivisionListReport data =
                                    results[i] as DivisionListReport;
                                print(data.text);
                                print(data.value);
                                divisionData.add(data.value);
                                divisionData.map((e) => data.value);
                                print("${divisionData.map((e) => data.value)}");
                              }

                              division = divisionData.join(',');
                              await Provider.of<MissingReportProviders>(context,
                                      listen: false)
                                  .divisionCounter(results.length);

                              // await Provider.of<MissingReportProviders>(context,
                              //         listen: false)
                              //     .getDivisionList(courseId);
                              await value.clearSubject();
                              subjectData.clear();
                              value.subjectLen = 0;
                              value.partList.clear();

                              missingPartController.clear();
                              missingPartController1.clear();

                              missingExamController.clear();
                              missingExamController1.clear();

                              await value.clearViewStaffList();

                              await value.clearViewStudentList();
                              results.clear();
                              await value.getPartList(division);

                              print("data $division");
                              print("=====$divisionData");
                            },
                          ),
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8),
                  child: Row(
                    children: [
                      const Spacer(),
                      SizedBox(
                        height: 45,
                        width: MediaQuery.of(context).size.width * 0.46,
                        child: Consumer<MissingReportProviders>(
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
                                              itemCount:
                                                  snapshot.partList.length,
                                              itemBuilder: (context, index) {
                                                return ListTile(
                                                  onTap: () async {
                                                    missingPartController.text =
                                                        snapshot.partList[index]
                                                                .value ??
                                                            '--';
                                                    missingPartController1
                                                        .text = snapshot
                                                            .partList[index]
                                                            .text ??
                                                        '--';
                                                    partID =
                                                        missingPartController
                                                            .text
                                                            .toString();

                                                    missingExamController
                                                        .clear();
                                                    missingExamController1
                                                        .clear();
                                                    await snapshot.examClear();
                                                    await snapshot
                                                        .clearSubject();
                                                    subjectData.clear();
                                                    snapshot.subjectLen = 0;

                                                    await snapshot
                                                        .getExamValues(
                                                            courseId,
                                                            partID,
                                                            divisionData);

                                                    await value
                                                        .clearViewStaffList();

                                                    await value
                                                        .clearViewStudentList();
                                                    Navigator.of(context).pop();
                                                  },
                                                  title: Text(
                                                    snapshot.partList[index]
                                                            .text ??
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
                              controller: missingPartController1,
                              decoration: InputDecoration(
                                filled: true,
                                contentPadding:
                                    const EdgeInsets.only(left: 0, top: 0),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                fillColor: Colors.transparent,
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      style: BorderStyle.none, width: 0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 2.0),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                    color: Colors.white,
                                    width: 2.0,
                                  ),
                                ),
                                labelText: "  Select Part",
                                hintText: "   Select Part",
                              ),
                              readOnly: true,
                              enabled: false,
                            ),
                          );
                        }),
                      ),
                      const Spacer(),
                      SizedBox(
                        height: 45,
                        width: MediaQuery.of(context).size.width * 0.46,
                        child: Consumer<MissingReportProviders>(
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
                                              itemCount:
                                                  snapshot.examList.length,
                                              itemBuilder: (context, index) {
                                                return ListTile(
                                                  onTap: () async {
                                                    Navigator.of(context).pop();
                                                    missingExamController.text =
                                                        snapshot.examList[index]
                                                                .value ??
                                                            '--';
                                                    missingExamController1
                                                        .text = snapshot
                                                            .examList[index]
                                                            .text ??
                                                        '--';

                                                    examId =
                                                        missingExamController
                                                            .text
                                                            .toString();

                                                    await snapshot
                                                        .clearSubject();
                                                    subjectData.clear();
                                                    snapshot.subjectLen = 0;

                                                    await snapshot
                                                        .getSubjectList(
                                                            courseId,
                                                            partID,
                                                            examId,
                                                            divisionData);

                                                    await value
                                                        .clearViewStaffList();
                                                    await value
                                                        .clearViewStudentList();
                                                  },
                                                  title: Text(
                                                    snapshot.examList[index]
                                                            .text ??
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
                              controller: missingExamController1,
                              decoration: InputDecoration(
                                filled: true,
                                contentPadding:
                                    const EdgeInsets.only(left: 0, top: 0),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                fillColor: Colors.transparent,
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      style: BorderStyle.none, width: 0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 2.0),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                    color: Colors.white,
                                    width: 2.0,
                                  ),
                                ),
                                labelText: "  Select Exam",
                                hintText: "   Select Exam",
                              ),
                              readOnly: true,
                              enabled: false,
                            ),
                          );
                        }),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Spacer(),
                      Consumer<MissingReportProviders>(
                        builder: (context, value, child) => SizedBox(
                          width: size.width * .46,
                          height: 45,
                          child: MultiSelectDialogField(
                            items: value.subjectDrop,
                            listType: MultiSelectListType.CHIP,
                            title: const Text(
                              "Select Subject",
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            buttonIcon: const Icon(
                              Icons.arrow_drop_down_outlined,
                              color: Colors.grey,
                            ),
                            buttonText: value.subjectLen == 0
                                ? const Text(
                                    "Select Subject",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                    ),
                                  )
                                : Text(
                                    "   ${value.subjectLen.toString()} Selected",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                            searchable: true,
                            chipDisplay: MultiSelectChipDisplay.none(),
                            onConfirm: (results) async {
                              subjectData = [];
                              for (var i = 0; i < results.length; i++) {
                                SubjectListModel data =
                                    results[i] as SubjectListModel;
                                print(data.text);
                                print(data.value);
                                subjectData.add(data.value);
                                subjectData.map((e) => data.value);
                                print("${subjectData.map((e) => data.value)}");
                              }
                              subject = subjectData.join(',');
                              await Provider.of<MissingReportProviders>(context,
                                      listen: false)
                                  .subjectCounter(results.length);
                              results.clear();

                              print("data $subject");
                              await value.clearViewStaffList();
                              await value.clearViewStudentList();
                              results.clear();
                            },
                          ),
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: size.width * .46,
                        child: InkWell(
                            onTap: () => value.studentWiseCheckbox(),
                            child: Row(
                              children: [
                                Checkbox(
                                  activeColor: UIGuide.light_Purple,
                                  value: value.isShown,
                                  onChanged: (newValue) {
                                    value.studentWiseCheckbox();
                                  },
                                ),
                                const Expanded(
                                  //   width: size.width * .35,
                                  child: Text(
                                    'Show student wise report',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: UIGuide.BLACK, fontSize: 12),
                                  ),
                                )
                              ],
                            )),
                      ),
                      // Checkbox(
                      //   activeColor: UIGuide.WHITE,
                      //   checkColor: UIGuide.light_Purple,
                      //   value: checked,
                      //   onChanged: (value) async {
                      //     setState(() {
                      //       checked = value!;
                      //     });
                      //   },
                      // ),
                      // SizedBox(
                      //   width: size.width * .35,
                      //   height: 46,
                      //   child: const Center(
                      //     child: Text(
                      //       'Show student wise report',
                      //       style: TextStyle(fontSize: 14),
                      //       maxLines: 2,
                      //       overflow: TextOverflow.ellipsis,
                      //     ),
                      //   ),
                      // ),
                      const Spacer()
                    ],
                  ),
                ),
                Center(
                  child: SizedBox(
                    width: size.width * .36,
                    height: 35,
                    child: value.loading
                        ? const Center(
                            child: Text(
                              'Loading...',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: UIGuide.light_Purple,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        : MaterialButton(
                            onPressed: () async {
                              if (missingInitialValuesController.text.isEmpty &&
                                  missingExamController.text.isEmpty &&
                                  missingPartController.text.isEmpty) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  elevation: 10,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                  ),
                                  duration: Duration(seconds: 3),
                                  margin: EdgeInsets.only(
                                      bottom: 80, left: 30, right: 30),
                                  behavior: SnackBarBehavior.floating,
                                  content: Text(
                                    'Enter mandatory fields...',
                                    textAlign: TextAlign.center,
                                  ),
                                ));
                              } else {
                                await value.clearViewStaffList();
                                await value.clearViewStudentList();
                                value.isShown == true
                                    ? await value.getViewStudent(
                                        courseId,
                                        partID,
                                        examId,
                                        divisionData,
                                        subjectData,
                                        value.isShown,
                                        context)
                                    : await value.getView(
                                        courseId,
                                        partID,
                                        examId,
                                        divisionData,
                                        subjectData,
                                        value.isShown,
                                        context);
                              }
                            },
                            color: UIGuide.light_Purple,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            child: const Text(
                              'View',
                              style: TextStyle(
                                  letterSpacing: 2,
                                  color: UIGuide.WHITE,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                  ),
                ),
                kheight10,
                value.isShown == true
                    ? Expanded(
                        //  maxHeight: size.height / 1.69,
                        child: Scrollbar(
                          thickness: 5,
                          controller: _scrollController,
                          child: ListView.builder(
                              itemCount: value.viewStudentList.isEmpty
                                  ? 0
                                  : value.viewStudentList.length,
                              // shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    Container(
                                      // width: size.width,
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 232, 232, 235),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              value.viewStudentList[index]
                                                  .division
                                                  .toString(),
                                              style: const TextStyle(
                                                  color: UIGuide.light_Purple,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            const Text("  ( Total Students :"),
                                            Text(
                                              "${value.viewStudentList[index].divisionWiseStudentsCount.toString()} )",
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: value.viewStudentList[index]
                                                .studentList!.isEmpty
                                            ? 0
                                            : value.viewStudentList[index]
                                                .studentList!.length,
                                        itemBuilder: (context, index1) =>
                                            Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Container(
                                            width: size.width,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color:
                                                        UIGuide.light_Purple),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(0),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(2),
                                                        decoration:
                                                            const BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          10),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          8),
                                                                ),
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        242,
                                                                        244,
                                                                        255)),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(3.0),
                                                          child: Text(
                                                            '${index1 + 1}',
                                                            style: const TextStyle(
                                                                color: UIGuide
                                                                    .light_Purple),
                                                          ),
                                                        ),
                                                      ),
                                                      kWidth,
                                                      const Text("Division: "),
                                                      Flexible(
                                                        child: RichText(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          strutStyle:
                                                              const StrutStyle(
                                                                  fontSize:
                                                                      12.0),
                                                          text: TextSpan(
                                                            style: const TextStyle(
                                                                color: UIGuide
                                                                    .light_Purple),
                                                            text: value
                                                                    .viewStudentList[
                                                                        index]
                                                                    .division ??
                                                                '--',
                                                          ),
                                                        ),
                                                      ),
                                                      kWidth,
                                                      Expanded(
                                                        child: Row(
                                                          children: [
                                                            const Text(
                                                                "Roll No: "),
                                                            Text(
                                                              value
                                                                          .viewStudentList[
                                                                              index]
                                                                          .studentList![
                                                                              index1]
                                                                          .rollNo ==
                                                                      null
                                                                  ? ''
                                                                  : value
                                                                      .viewStudentList[
                                                                          index]
                                                                      .studentList![
                                                                          index1]
                                                                      .rollNo
                                                                      .toString(),
                                                              style: const TextStyle(
                                                                  color: UIGuide
                                                                      .light_Purple),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Row(
                                                          children: [
                                                            const Text(
                                                                " Name: "),
                                                            Flexible(
                                                              child: RichText(
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                maxLines: 2,
                                                                strutStyle:
                                                                    const StrutStyle(
                                                                        fontSize:
                                                                            12.0),
                                                                text: TextSpan(
                                                                  style: const TextStyle(
                                                                      color: UIGuide
                                                                          .light_Purple,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                  text: value
                                                                          .viewStudentList[
                                                                              index]
                                                                          .studentList![
                                                                              index1]
                                                                          .name ??
                                                                      "--",
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: ListView.builder(
                                                        physics:
                                                            const NeverScrollableScrollPhysics(),
                                                        shrinkWrap: true,
                                                        itemCount: value
                                                                .viewStudentList[
                                                                    index]
                                                                .studentList![
                                                                    index1]
                                                                .sUbjectList!
                                                                .isEmpty
                                                            ? 0
                                                            : value
                                                                .viewStudentList[
                                                                    index]
                                                                .studentList![
                                                                    index1]
                                                                .sUbjectList!
                                                                .length,
                                                        itemBuilder:
                                                            (context, index2) {
                                                          return Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(4.0),
                                                            child: Text(
                                                              value
                                                                      .viewStudentList[
                                                                          index]
                                                                      .studentList![
                                                                          index1]
                                                                      .sUbjectList![
                                                                          index2]
                                                                      .subject ??
                                                                  '--',
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              maxLines: 2,
                                                              style: const TextStyle(
                                                                  color: UIGuide
                                                                      .light_Purple),
                                                            ),
                                                          );
                                                        }))
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                        ),
                      )
                    : Expanded(
                        child: Scrollbar(
                          thickness: 5,
                          controller: _scrollController,
                          child: ListView.builder(
                              itemCount: value.viewStaffList.isEmpty
                                  ? 0
                                  : value.viewStaffList.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Container(
                                    width: size.width,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: UIGuide.light_Purple),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Row(
                                            children: [
                                              const Text("Division: "),
                                              Flexible(
                                                child: RichText(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  strutStyle: const StrutStyle(
                                                      fontSize: 12.0),
                                                  text: TextSpan(
                                                    style: const TextStyle(
                                                        color: UIGuide
                                                            .light_Purple),
                                                    text: value
                                                            .viewStaffList[
                                                                index]
                                                            .division ??
                                                        '--',
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: value
                                                    .viewStaffList[index]
                                                    .subjectList!
                                                    .isEmpty
                                                ? 0
                                                : value.viewStaffList[index]
                                                    .subjectList!.length,
                                            itemBuilder: (context, ind) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: size.width * .45,
                                                      child: Row(
                                                        children: [
                                                          const Text(
                                                              "Subject: "),
                                                          Flexible(
                                                            child: RichText(
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              strutStyle:
                                                                  const StrutStyle(
                                                                      fontSize:
                                                                          12.0),
                                                              text: TextSpan(
                                                                style: const TextStyle(
                                                                    color: UIGuide
                                                                        .light_Purple),
                                                                text: value
                                                                        .viewStaffList[
                                                                            index]
                                                                        .subjectList![
                                                                            ind]
                                                                        .subject ??
                                                                    '--',
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: size.width * .45,
                                                      child: Row(
                                                        children: [
                                                          const Text("Name: "),
                                                          Flexible(
                                                            child: RichText(
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              strutStyle:
                                                                  const StrutStyle(
                                                                      fontSize:
                                                                          12.0),
                                                              text: TextSpan(
                                                                style: const TextStyle(
                                                                    color: UIGuide
                                                                        .light_Purple),
                                                                text: value
                                                                        .viewStaffList[
                                                                            index]
                                                                        .subjectList![
                                                                            ind]
                                                                        .user ??
                                                                    '--',
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            })
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                      )
              ],
            ),
            if (value.loading) pleaseWaitLoader()
          ],
        ),
      ),
    );
  }
}
