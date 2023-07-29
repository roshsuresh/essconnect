import 'package:essconnect/Application/Staff_Providers/MarkEntryNewProvider.dart';
import 'package:essconnect/Constants.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:essconnect/utils/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class MarkEntryNew extends StatefulWidget {
  const MarkEntryNew({Key? key}) : super(key: key);

  @override
  State<MarkEntryNew> createState() => _MarkEntryNewState();
}

class _MarkEntryNewState extends State<MarkEntryNew> {
  List<TextEditingController> _controllers = [];
  List<TextEditingController> teMarkController = [];
  List<TextEditingController> practicalMarkController = [];
  List<TextEditingController> ceMarkController = [];
  List<TextEditingController> gradeListController = [];
  List<TextEditingController> gradeListController1 = [];
  List<TextEditingController> publicGradeController = [];
  List<TextEditingController> publicGradeController1 = [];

  List<TextEditingController> teGradeController = [];
  List<TextEditingController> teGradeController1 = [];
  List<TextEditingController> ceGradeController = [];
  List<TextEditingController> ceGradeController1 = [];
  List<TextEditingController> praticalGradeController = [];
  List<TextEditingController> praticalGradeController1 = [];
  List<String> selectedItemValue = [];
  String? date;
  String? subsubject;
  String? optionSub;
  String? subDescription;

  double? maxScrore;

  var partItems;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var p = Provider.of<MarkEntryNewProvider>(context, listen: false);

      await p.courseClear();
      await p.divisionClear();
      await p.removeAllpartClear();
      await p.removeAllSubjectClear();
      await p.removeAllOptionSubjectListClear();
      await p.removeAllExamClear();
      await p.clearStudentMEList();
      await p.getMarkEntryInitialValues();
      p.isTerminated = false;
    });
  }

  bool attend = false;
  String courseId = '';
  String partId = '';
  String subjectId = '';
  String divisionId = '';
  String exam = '';
  String? attendancee;

  final markEntryInitialValuesController = TextEditingController();
  final markEntryInitialValuesController1 = TextEditingController();
  final markEntryDivisionListController = TextEditingController();
  final markEntryDivisionListController1 = TextEditingController();
  final markEntryPartListController = TextEditingController();
  final markEntryPartListController1 = TextEditingController();
  final markEntrySubjectListController = TextEditingController();
  final markEntrySubjectListController1 = TextEditingController();
  final markEntryExamListController = TextEditingController();
  final markEntryExamListController1 = TextEditingController();
  final markfieldController = TextEditingController();
  final markfieldController1 = TextEditingController();
  final markEntryOptionSubListController = TextEditingController();
  final markEntryOptionSubListController1 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          title: Row(
            children: [
              const Spacer(),
              const Text('Mark Entry'),
              const Spacer(),
              IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MarkEntryNew()));
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
          backgroundColor: UIGuide.light_Purple),
      body: Consumer<MarkEntryNewProvider>(builder: (context, value, _) {
        return value.isLocked == true
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  LottieBuilder.network(
                    'https://assets1.lottiefiles.com/packages/lf20_6ZeYZ9ZcjI.json',
                    // height: size.height / 2,
                    // width: size.width / 2,
                  ),
                  const Center(
                    child: Text(
                      'Mark Entry Locked',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                ],
              )
            : ListView(physics: const BouncingScrollPhysics(), children: [
                Row(
                  children: [
                    const Spacer(),
                    SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.49,
                      child: Consumer<MarkEntryNewProvider>(
                          builder: (context, snapshot, child) {
                        return InkWell(
                          onTap: () async {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                      child: LimitedBox(
                                    maxHeight: size.height - 300,
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: snapshot
                                            .markEntryInitialValues.length,
                                        itemBuilder: (context, index) {
                                          return ListTile(
                                            onTap: () async {
                                              markEntryInitialValuesController
                                                  .text = snapshot
                                                      .markEntryInitialValues[
                                                          index]
                                                      .id ??
                                                  '--';
                                              markEntryInitialValuesController1
                                                  .text = snapshot
                                                      .markEntryInitialValues[
                                                          index]
                                                      .courseName ??
                                                  '--';
                                              courseId =
                                                  markEntryInitialValuesController
                                                      .text
                                                      .toString();

                                              //div
                                              markEntryDivisionListController
                                                  .clear();
                                              markEntryDivisionListController1
                                                  .clear();
                                              await snapshot.divisionClear();

                                              //part

                                              markEntryPartListController
                                                  .clear();
                                              markEntryPartListController1
                                                  .clear();

                                              await snapshot
                                                  .removeAllpartClear();

                                              // sub

                                              markEntrySubjectListController
                                                  .clear();
                                              markEntrySubjectListController1
                                                  .clear();

                                              await snapshot
                                                  .removeAllSubjectClear();

                                              //option sub

                                              markEntryOptionSubListController
                                                  .clear();
                                              markEntryOptionSubListController1
                                                  .clear();
                                              await snapshot
                                                  .removeAllOptionSubjectListClear();

                                              // exam

                                              markEntryExamListController
                                                  .clear();
                                              markEntryExamListController1
                                                  .clear();
                                              await snapshot
                                                  .removeAllExamClear();

                                              await snapshot
                                                  .getMarkEntryDivisionValues(
                                                      courseId);
                                              Navigator.of(context).pop();
                                            },
                                            title: Text(
                                              snapshot
                                                      .markEntryInitialValues[
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
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: UIGuide.BLACK,
                                        overflow: TextOverflow.clip),
                                    textAlign: TextAlign.center,
                                    controller:
                                        markEntryInitialValuesController1,
                                    decoration: const InputDecoration(
                                      filled: true,
                                      contentPadding:
                                          EdgeInsets.only(left: 0, top: 0),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      fillColor:
                                          Color.fromARGB(255, 238, 237, 237),
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
                                    controller:
                                        markEntryInitialValuesController,
                                    decoration: const InputDecoration(
                                      filled: true,
                                      fillColor:
                                          Color.fromARGB(255, 238, 237, 237),
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
                      child: Consumer<MarkEntryNewProvider>(
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
                                            itemCount: snapshot
                                                .markEntryDivisionList.length,
                                            itemBuilder: (context, index) {
                                              return ListTile(
                                                selectedTileColor:
                                                    Colors.blue.shade100,
                                                selectedColor: UIGuide.PRIMARY2,
                                                onTap: () async {
                                                  markEntryDivisionListController
                                                      .text = snapshot
                                                          .markEntryDivisionList[
                                                              index]
                                                          .value ??
                                                      '---';
                                                  markEntryDivisionListController1
                                                      .text = snapshot
                                                          .markEntryDivisionList[
                                                              index]
                                                          .text ??
                                                      '---';

                                                  divisionId =
                                                      markEntryDivisionListController
                                                          .text
                                                          .toString();
                                                  courseId =
                                                      markEntryInitialValuesController
                                                          .text
                                                          .toString();
                                                  //part

                                                  markEntryPartListController
                                                      .clear();
                                                  markEntryPartListController1
                                                      .clear();

                                                  await snapshot
                                                      .removeAllpartClear();

                                                  // sub

                                                  markEntrySubjectListController
                                                      .clear();
                                                  markEntrySubjectListController1
                                                      .clear();

                                                  await snapshot
                                                      .removeAllSubjectClear();

                                                  //option sub

                                                  markEntryOptionSubListController
                                                      .clear();
                                                  markEntryOptionSubListController1
                                                      .clear();
                                                  await snapshot
                                                      .removeAllOptionSubjectListClear();

                                                  // exam

                                                  markEntryExamListController
                                                      .clear();
                                                  markEntryExamListController1
                                                      .clear();
                                                  await snapshot
                                                      .removeAllExamClear();

                                                  await snapshot
                                                      .getMarkEntryPartValues(
                                                          courseId, divisionId);

                                                  Navigator.of(context).pop();
                                                },
                                                title: Text(
                                                  snapshot
                                                          .markEntryDivisionList[
                                                              index]
                                                          .text ??
                                                      '---',
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
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: UIGuide.BLACK,
                                        overflow: TextOverflow.clip),
                                    textAlign: TextAlign.center,
                                    controller:
                                        markEntryDivisionListController1,
                                    decoration: const InputDecoration(
                                      filled: true,
                                      contentPadding:
                                          EdgeInsets.only(left: 0, top: 0),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      fillColor:
                                          Color.fromARGB(255, 238, 237, 237),
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
                                    controller: markEntryDivisionListController,
                                    decoration: const InputDecoration(
                                      filled: true,
                                      fillColor:
                                          Color.fromARGB(255, 238, 237, 237),
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
                  ],
                ),
                Row(
                  children: [
                    const Spacer(),
                    SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.49,
                      child: Consumer<MarkEntryNewProvider>(
                          builder: (context, snapshot, child) {
                        return InkWell(
                          onTap: () {
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
                                            itemCount: snapshot
                                                .markEntryPartList.length,
                                            itemBuilder: (context, index) {
                                              return ListTile(
                                                selectedTileColor:
                                                    Colors.blue.shade100,
                                                selectedColor: UIGuide.PRIMARY2,
                                                onTap: () async {
                                                  markEntryPartListController
                                                      .text = snapshot
                                                          .markEntryPartList[
                                                              index]
                                                          .value ??
                                                      '--';
                                                  markEntryPartListController1
                                                      .text = snapshot
                                                          .markEntryPartList[
                                                              index]
                                                          .text ??
                                                      '--';

                                                  partItems = snapshot
                                                      .markEntryPartList[index]
                                                      .toJson();
                                                  print(partItems);

                                                  divisionId =
                                                      markEntryDivisionListController
                                                          .text
                                                          .toString();
                                                  partId =
                                                      markEntryPartListController
                                                          .text
                                                          .toString();

                                                  markEntrySubjectListController
                                                      .clear();
                                                  markEntrySubjectListController1
                                                      .clear();

                                                  await snapshot
                                                      .removeAllSubjectClear();
                                                  //option sub

                                                  markEntryOptionSubListController
                                                      .clear();
                                                  markEntryOptionSubListController1
                                                      .clear();
                                                  await snapshot
                                                      .removeAllOptionSubjectListClear();

                                                  // exam

                                                  markEntryExamListController
                                                      .clear();
                                                  markEntryExamListController1
                                                      .clear();
                                                  await snapshot
                                                      .removeAllExamClear();

                                                  await snapshot
                                                      .getMarkEntrySubjectValues(
                                                          divisionId, partId);

                                                  Navigator.of(context).pop();
                                                },
                                                title: Text(
                                                  snapshot
                                                          .markEntryPartList[
                                                              index]
                                                          .text ??
                                                      '---',
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
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: UIGuide.light_Purple, width: 1),
                                  ),
                                  height: 40,
                                  child: TextField(
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: UIGuide.BLACK,
                                        overflow: TextOverflow.clip),
                                    textAlign: TextAlign.center,
                                    controller: markEntryPartListController1,
                                    decoration: const InputDecoration(
                                      filled: true,
                                      contentPadding:
                                          EdgeInsets.only(left: 0, top: 0),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      fillColor:
                                          Color.fromARGB(255, 238, 237, 237),
                                      border: OutlineInputBorder(),
                                      labelText: "  Select Part",
                                      hintText: "Part",
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
                      child: Consumer<MarkEntryNewProvider>(
                          builder: (context, snapshot, child) {
                        return InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Container(
                                    child: Dialog(
                                        child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: snapshot
                                                .markEntrySubjectList.length,
                                            itemBuilder: (context, index) {
                                              return ListTile(
                                                selectedTileColor:
                                                    Colors.blue.shade100,
                                                selectedColor: UIGuide.PRIMARY2,
                                                onTap: () async {
                                                  markEntrySubjectListController
                                                      .text = snapshot
                                                          .markEntrySubjectList[
                                                              index]
                                                          .value ??
                                                      '---';
                                                  markEntrySubjectListController1
                                                      .text = snapshot
                                                          .markEntrySubjectList[
                                                              index]
                                                          .text ??
                                                      '---';

                                                  divisionId =
                                                      markEntryDivisionListController
                                                          .text
                                                          .toString();
                                                  partId =
                                                      markEntryPartListController
                                                          .text
                                                          .toString();
                                                  subjectId =
                                                      markEntrySubjectListController
                                                          .text
                                                          .toString();

                                                  //option sub

                                                  markEntryOptionSubListController
                                                      .clear();
                                                  markEntryOptionSubListController1
                                                      .clear();
                                                  await snapshot
                                                      .removeAllOptionSubjectListClear();

                                                  // exam

                                                  markEntryExamListController
                                                      .clear();
                                                  markEntryExamListController1
                                                      .clear();
                                                  await snapshot
                                                      .removeAllExamClear();
                                                  subsubject = null;
                                                  optionSub = null;
                                                  subDescription = null;

                                                  await snapshot
                                                      .getMarkEntryOptionSubject(
                                                          subjectId,
                                                          divisionId,
                                                          partId);
                                                  await snapshot
                                                      .getMarkEntryExamValues(
                                                          subjectId,
                                                          divisionId,
                                                          partId);

                                                  Navigator.of(context).pop();
                                                },
                                                title: Text(
                                                  snapshot
                                                      .markEntrySubjectList[
                                                          index]
                                                      .text
                                                      .toString(),
                                                  textAlign: TextAlign.center,
                                                ),
                                              );
                                            }),
                                      ],
                                    )),
                                  );
                                });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: UIGuide.light_Purple, width: 1),
                                  ),
                                  child: TextField(
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: UIGuide.BLACK,
                                        overflow: TextOverflow.clip),
                                    textAlign: TextAlign.center,
                                    controller: markEntrySubjectListController1,
                                    decoration: const InputDecoration(
                                      filled: true,
                                      contentPadding:
                                          EdgeInsets.only(left: 0, top: 0),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      fillColor:
                                          Color.fromARGB(255, 238, 237, 237),
                                      border: OutlineInputBorder(),
                                      labelText: "  Select Subject",
                                      hintText: "Subject",
                                    ),
                                    enabled: false,
                                  ),
                                ),
                                SizedBox(
                                  height: 0,
                                  child: TextField(
                                    textAlign: TextAlign.center,
                                    controller: markEntrySubjectListController,
                                    decoration: const InputDecoration(
                                      filled: true,
                                      fillColor:
                                          Color.fromARGB(255, 238, 237, 237),
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
                  ],
                ),
                Row(
                  children: [
                    //  Spacer(),
                    Consumer<MarkEntryNewProvider>(
                      builder: (context, snapshot, child) {
                        if (snapshot.markEntryOptionSubjectList.isEmpty ||
                            snapshot.markEntryOptionSubjectList == null) {
                          return Container(
                            height: 0,
                            width: 0,
                          );
                        }
                        return SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.499,
                            child: InkWell(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Dialog(
                                          child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: snapshot
                                                      .markEntryOptionSubjectList
                                                      .isEmpty
                                                  ? 0
                                                  : snapshot
                                                      .markEntryOptionSubjectList
                                                      .length,
                                              itemBuilder: (context, index) {
                                                return ListTile(
                                                  selectedTileColor:
                                                      Colors.blue.shade100,
                                                  selectedColor:
                                                      UIGuide.PRIMARY2,
                                                  onTap: () {
                                                    markEntryOptionSubListController
                                                        .text = snapshot
                                                            .markEntryOptionSubjectList[
                                                                index]
                                                            .subjectName ??
                                                        '--';
                                                    markEntryOptionSubListController1
                                                        .text = snapshot
                                                            .markEntryOptionSubjectList[
                                                                index]
                                                            .id ??
                                                        '--';
                                                    subDescription = snapshot
                                                        .markEntryOptionSubjectList[
                                                            index]
                                                        .subjectDescription
                                                        .toString();
                                                    snapshot
                                                                .markEntryOptionSubjectList[
                                                                    index]
                                                                .subjectDescription ==
                                                            'Option Subject'
                                                        ? optionSub =
                                                            markEntryOptionSubListController1
                                                                .text
                                                                .toString()
                                                        : subsubject =
                                                            markEntryOptionSubListController1
                                                                .text;

                                                    print(optionSub);
                                                    print(subsubject);

                                                    Navigator.of(context).pop();
                                                  },
                                                  title: Text(
                                                    snapshot
                                                            .markEntryOptionSubjectList[
                                                                index]
                                                            .subjectName ??
                                                        '--',
                                                    textAlign: TextAlign.center,
                                                  ),
                                                );
                                              }),
                                        ],
                                      ));
                                    });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      height: 40,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: UIGuide.light_Purple,
                                            width: 1),
                                      ),
                                      child: TextField(
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: UIGuide.BLACK,
                                            overflow: TextOverflow.clip),
                                        textAlign: TextAlign.center,
                                        controller:
                                            markEntryOptionSubListController,
                                        decoration: InputDecoration(
                                          filled: true,
                                          contentPadding: const EdgeInsets.only(
                                              left: 0, top: 0),
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.never,
                                          fillColor: const Color.fromARGB(
                                              255, 238, 237, 237),
                                          border: const OutlineInputBorder(),
                                          labelText: snapshot
                                                  .markEntryOptionSubjectList
                                                  .isEmpty
                                              ? ""
                                              : snapshot.markEntryOptionSubjectList[0]
                                                          .subjectDescription ==
                                                      "Sub Subject"
                                                  ? "Select Sub Subject"
                                                  : "Select Option Subject",
                                          hintText: snapshot
                                                  .markEntryOptionSubjectList
                                                  .isEmpty
                                              ? ""
                                              : snapshot.markEntryOptionSubjectList[0]
                                                          .subjectDescription ==
                                                      "Sub Subject"
                                                  ? "Sub Subject"
                                                  : "Option Subject",
                                        ),
                                        enabled: false,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 0,
                                      child: TextField(
                                        textAlign: TextAlign.center,
                                        controller:
                                            markEntryOptionSubListController1,
                                        decoration: const InputDecoration(
                                          filled: true,
                                          fillColor: Color.fromARGB(
                                              255, 238, 237, 237),
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
                            ));
                      },
                    ),
                    const Spacer(),
                    SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.49,
                      child: Consumer<MarkEntryNewProvider>(
                          builder: (context, snapshot, child) {
                        return InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                      child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ListView.builder(
                                          shrinkWrap: true,
                                          itemCount:
                                              snapshot.markEntryExamList.length,
                                          itemBuilder: (context, index) {
                                            return ListTile(
                                              selectedTileColor:
                                                  Colors.blue.shade100,
                                              selectedColor: UIGuide.PRIMARY2,
                                              onTap: () {
                                                markEntryExamListController
                                                    .text = snapshot
                                                        .markEntryExamList[
                                                            index]
                                                        .text ??
                                                    '--';

                                                markEntryExamListController1
                                                    .text = snapshot
                                                        .markEntryExamList[
                                                            index]
                                                        .value ??
                                                    '--';

                                                Navigator.of(context).pop();
                                              },
                                              title: Text(
                                                snapshot
                                                        .markEntryExamList[
                                                            index]
                                                        .text ??
                                                    '--',
                                                textAlign: TextAlign.center,
                                              ),
                                            );
                                          }),
                                    ],
                                  ));
                                });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: UIGuide.light_Purple, width: 1),
                                  ),
                                  child: TextField(
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: UIGuide.BLACK,
                                        overflow: TextOverflow.clip),
                                    textAlign: TextAlign.center,
                                    controller: markEntryExamListController,
                                    decoration: const InputDecoration(
                                      filled: true,
                                      contentPadding:
                                          EdgeInsets.only(left: 0, top: 0),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      fillColor:
                                          Color.fromARGB(255, 238, 237, 237),
                                      border: OutlineInputBorder(),
                                      labelText: "  Select Exam",
                                      hintText: "Exam",
                                    ),
                                    enabled: false,
                                  ),
                                ),
                                SizedBox(
                                  height: 0,
                                  child: TextField(
                                    textAlign: TextAlign.center,
                                    controller: markEntryExamListController1,
                                    decoration: const InputDecoration(
                                      filled: true,
                                      fillColor:
                                          Color.fromARGB(255, 238, 237, 237),
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
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: () => value.terminatedCheckbox(),
                        child: SizedBox(
                          //width: size.width / 2.5,
                          // Change this value as per your requirements
                          child: Row(
                            children: [
                              Checkbox(
                                activeColor: UIGuide.light_Purple,
                                value: value.isTerminated,
                                onChanged: (newValue) {
                                  setState(() {
                                    value.isTerminated = newValue!;
                                  });
                                },
                              ),
                              SizedBox(
                                width: size.width * .35,
                                child: Text(
                                  "Include Terminated Students",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: UIGuide.PRIMARY,
                                  ),
                                ),
                              )
                            ],
                          ),
                        )),
                    value.loading
                        ? SizedBox(
                            width: size.width * .40,
                            child: MaterialButton(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                              onPressed: () {},
                              color: UIGuide.light_Purple,
                              child: const Text(
                                'Loading...',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                        : SizedBox(
                            width: size.width * .40,
                            child: MaterialButton(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                              color: UIGuide.light_Purple,
                              onPressed: (() async {
                                date = DateFormat('yyyy-MM-dd')
                                    .format(DateTime.now());
                                print(DateFormat('yyyy-MM-dd')
                                    .format(DateTime.now()));

                                String course = markEntryInitialValuesController
                                    .text
                                    .toString();
                                String division =
                                    markEntryDivisionListController.text
                                        .toString();
                                String part =
                                    markEntryPartListController.text.toString();
                                String subject = markEntrySubjectListController
                                    .text
                                    .toString();
                                String exam =
                                    markEntryExamListController.text.toString();

                                _controllers.clear();
                                teMarkController.clear();
                                practicalMarkController.clear();
                                ceMarkController.clear();
                                teGradeController.clear();
                                praticalGradeController.clear();
                                ceGradeController.clear();
                                teGradeController1.clear();
                                praticalGradeController1.clear();
                                ceGradeController1.clear();
                                gradeListController1.clear();
                                gradeListController.clear();
                                publicGradeController.clear();
                                publicGradeController1.clear();

                                value.studListUAS.clear();
                                value.gradeListUAS.clear();
                                await value.getMarkEntryUASView(
                                    course,
                                    division,
                                    exam,
                                    part,
                                    subject,
                                    subsubject.toString(),
                                    optionSub.toString(),
                                    value.typeCode.toString(),
                                    partItems,
                                    subDescription.toString(),
                                    value.isTerminated);

                                print("Maxscore $maxScrore");
                              }),
                              child: const Text(
                                'View',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                  ],
                ),
                Consumer<MarkEntryNewProvider>(builder: (context, provider, _) {
                  if (provider.loading) {
                    return LimitedBox(
                      maxHeight: size.height / 1.85,
                      child: Container(
                        height: size.height / 1.95,
                        child: spinkitLoader(),
                      ),
                    );
                  }
////-----------    ----------    ---------    ----------    ---------     ----------    ---------
////-----------    ----------          Mark  Entry --[ UAS ]--     -----------        -----------
////-----------    ----------    ---------    ----------    ---------     ----------    ---------

                  else if (provider.tabulationTypeCode == "UAS" &&
                      provider.teCaptionUAS == "Mark") {
                    maxScrore = double.parse(provider.teMax.toString());
                    return LimitedBox(
                        maxHeight: size.height / 1.85,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: provider.studListUAS.length,
                              itemBuilder: ((context, index) {
                                String pre = 'P';
                                markfieldController.text = pre;
                                _controllers.add(TextEditingController());

                                _controllers[index].text.isEmpty
                                    ? _controllers[index].text =
                                        provider.studListUAS[index].teMark ==
                                                null
                                            ? _controllers[index].text
                                            : provider.studListUAS[index].teMark
                                                .toString()
                                    : _controllers[index].text;

                                return Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Container(
                                    height: 100,
                                    width: size.width,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: UIGuide.light_Purple,
                                          width: 1,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Row(
                                            children: [
                                              const Text(
                                                'Roll No: ',
                                                style: TextStyle(),
                                              ),
                                              provider.studListUAS[index]
                                                          .rollNo ==
                                                      null
                                                  ? const Text(
                                                      '0',
                                                      style: TextStyle(
                                                          color: UIGuide
                                                              .light_Purple),
                                                    )
                                                  : Text(
                                                      provider
                                                          .studListUAS[index]
                                                          .rollNo
                                                          .toString(),
                                                      style: const TextStyle(
                                                          color: UIGuide
                                                              .light_Purple),
                                                    ),
                                              const Spacer(),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Row(
                                            children: [
                                              const Text(
                                                'Name: ',
                                                style: TextStyle(),
                                              ),
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
                                                    text: provider
                                                        .studListUAS[index]
                                                        .studentName,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      if (provider
                                                              .studListUAS[
                                                                  index]
                                                              .attendance ==
                                                          'A') {
                                                        provider
                                                            .studListUAS[index]
                                                            .attendance = 'P';
                                                      } else {
                                                        provider
                                                            .studListUAS[index]
                                                            .attendance = 'A';
                                                        provider
                                                            .studListUAS[index]
                                                            .teMark = null;
                                                        _controllers[index]
                                                            .clear();
                                                      }
                                                      attendancee = provider
                                                          .studListUAS[index]
                                                          .attendance;

                                                      print(
                                                          "attendace   $attendancee");
                                                    });
                                                  },
                                                  child: Container(
                                                    color: Colors.transparent,
                                                    width: 28,
                                                    height: 26,
                                                    child: SizedBox(
                                                        width: 28,
                                                        height: 26,
                                                        child: provider
                                                                    .studListUAS[
                                                                        index]
                                                                    .attendance ==
                                                                'A'
                                                            ? SvgPicture.asset(
                                                                UIGuide.absent)
                                                            : SvgPicture.asset(
                                                                UIGuide
                                                                    .present)),
                                                  ),
                                                ),
                                              ),
                                              kWidth,
                                              kWidth,
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: SizedBox(
                                                  height: 30,
                                                  width: 80,
                                                  child: TextField(
                                                    focusNode: FocusNode(),
                                                    controller:
                                                        _controllers[index],
                                                    enabled: provider
                                                                .studListUAS[
                                                                    index]
                                                                .attendance ==
                                                            'A'
                                                        ? false
                                                        : true,
                                                    cursorColor:
                                                        UIGuide.light_Purple,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter
                                                          .allow(RegExp(
                                                              r"[0-9.]")),
                                                      TextInputFormatter
                                                          .withFunction(
                                                              (oldValue,
                                                                  newValue) {
                                                        try {
                                                          final text =
                                                              newValue.text;
                                                          if (text.isNotEmpty)
                                                            double.parse(text);
                                                          return newValue;
                                                        } catch (e) {}
                                                        return oldValue;
                                                      }),
                                                      LengthLimitingTextInputFormatter(
                                                          5),
                                                    ],
                                                    decoration: InputDecoration(
                                                        focusColor: const Color
                                                                .fromARGB(255,
                                                            213, 215, 218),
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                                  color: UIGuide
                                                                      .light_Purple,
                                                                  width: 1.0),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                        fillColor: Colors.grey,
                                                        hintStyle:
                                                            const TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 16,
                                                          fontFamily:
                                                              "verdana_regular",
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                        labelText: 'Mark',
                                                        labelStyle:
                                                            const TextStyle(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        106,
                                                                        107,
                                                                        109))),
                                                    onChanged: (value1) {
                                                      _controllers[index]
                                                          .addListener(() {
                                                        value1;
                                                      });

                                                      _controllers[index]
                                                              .selection =
                                                          TextSelection.collapsed(
                                                              offset:
                                                                  _controllers[
                                                                          index]
                                                                      .text
                                                                      .length);

                                                      if (double.parse(
                                                              _controllers[
                                                                      index]
                                                                  .text) >
                                                          maxScrore!) {
                                                        _controllers[index]
                                                            .clear();
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 2.0),
                                                child: SizedBox(
                                                    height: 30,
                                                    width: 50,
                                                    child: Center(
                                                        child: Text(
                                                      "($maxScrore)",
                                                      style: const TextStyle(
                                                        fontSize: 15,
                                                      ),
                                                    ))),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              })),
                        ));
                  } else {
                    return SizedBox(
                      height: 0,
                      width: 0,
                    );
                  }
                })
              ]);
      }),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            kWidth,
            const Spacer(),
            Consumer<MarkEntryNewProvider>(builder: (context, value, child) {
              return value.loadSave
                  ? MaterialButton(
                      onPressed: () {},
                      color: UIGuide.light_Purple,
                      child: const Text(
                        'Saving...',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  : MaterialButton(
                      onPressed: () async {
                        List obj = [];
                        obj.clear();

                        if (value.tabulationTypeCode == "UAS" &&
                            value.teCaptionUAS == "Mark") {
                          for (int i = 0; i < value.studListUAS.length; i++) {
                            obj.add(
                              {
                                "attendance":
                                    value.studListUAS[i].attendance.toString(),
                                "studentName":
                                    value.studListUAS[i].studentName.toString(),
                                "rollNo": value.studListUAS[i].rollNo,
                                "studentId":
                                    value.studListUAS[i].studentId.toString(),
                                "markEntryDetId": null,
                                //  value
                                //     .studListUAS[i].markEntryDetId
                                //     .toString(),
                                "teMark": _controllers[i].text.isEmpty
                                    ? null
                                    : _controllers[i].text.toString(),
                                "peMark": null,
                                "ceMark": null,
                                "teGrade": null,
                                "peGrade": null,
                                "ceGrade": null,
                                "total": _controllers[i].text.isEmpty
                                    ? null
                                    : _controllers[i].text.toString(),
                                "teGradeId": null,
                                "peGradeId": null,
                                "ceGradeId": null,
                                "tabMarkEntryId": null,
                                "isEdited": false,
                                "isDisabled": false
                              },
                            );
                          }
                        }

                        //else if (value.maxmarkList[0].entryMethod ==
                        //         "Grade" &&
                        //     (value.typecode == "UAS")) {
                        //   for (int i = 0; i < value.studentMEList.length; i++) {
                        //     obj.add(
                        //       {
                        //         "name": value.studentMEList[i].name.toString(),
                        //         "rollNo":
                        //             value.studentMEList[i].rollNo.toString(),
                        //         "studentPresentDetailsId": value
                        //             .studentMEList[i].studentPresentDetailsId
                        //             .toString(),
                        //         "teMark": null,
                        //         "peMark": null,
                        //         "ceMark": null,
                        //         "teGrade": value.studentMEList[i].teGrade,
                        //         "peGrade": null,
                        //         "ceGrade": null,
                        //         "totalMark": null,
                        //         "markInPer": null,
                        //         "grade": null,
                        //         "gradeId": null,
                        //         "teGradeId": value.studentMEList[i].teGradeId,
                        //         "peGradeId": null,
                        //         "ceGradeId": null,
                        //         "attendance": "P",
                        //         "description": null,
                        //         "disableAbsentRow": false
                        //       },
                        //     );
                        //   }
                        // } else if (value.maxmarkList[0].entryMethod ==
                        //         "Grade" &&
                        //     (value.typecode == "PBT")) {
                        //   for (int i = 0; i < value.studentMEList.length; i++) {
                        //     print('------------------------');
                        //     obj.add(
                        //       {
                        //         "name": value.studentMEList[i].name.toString(),
                        //         "rollNo":
                        //             value.studentMEList[i].rollNo.toString(),
                        //         "studentPresentDetailsId": value
                        //             .studentMEList[i].studentPresentDetailsId
                        //             .toString(),
                        //         "teMark": null,
                        //         "peMark": null,
                        //         "ceMark": null,
                        //         "teGrade": value.studentMEList[i].teGrade,
                        //         "peGrade": null,
                        //         "ceGrade": null,
                        //         "totalMark": null,
                        //         "markInPer": null,
                        //         "grade": null,
                        //         "gradeId": null,
                        //         "teGradeId": value.studentMEList[i].teGradeId,
                        //         "peGradeId": null,
                        //         "ceGradeId": null,
                        //         "attendance": value.studentMEList[i].attendance
                        //             .toString(),
                        //         "description": null,
                        //         "disableAbsentRow": false
                        //       },
                        //     );
                        //   }
                        // } else if (value.maxmarkList[0].entryMethod == "Mark" &&
                        //     (value.typecode == "PBT" ||
                        //         value.typecode == "STATE")) {
                        //   for (int i = 0; i < value.studentMEList.length; i++) {
                        //     print(double.tryParse(teMarkController[i].text));
                        //     print(double.tryParse(
                        //         practicalMarkController[i].text));
                        //     obj.add(
                        //       {
                        //         "name": value.studentMEList[i].name.toString(),
                        //         "rollNo":
                        //             value.studentMEList[i].rollNo.toString(),
                        //         "studentPresentDetailsId": value
                        //             .studentMEList[i].studentPresentDetailsId
                        //             .toString(),
                        //         "teMark": teMarkController[i].text.isEmpty
                        //             ? null
                        //             : teMarkController[i].text.toString(),
                        //         "peMark":
                        //             practicalMarkController[i].text.isEmpty
                        //                 ? null
                        //                 : practicalMarkController[i]
                        //                     .text
                        //                     .toString(),
                        //         "ceMark": ceMarkController[i].text.isEmpty
                        //             ? null
                        //             : ceMarkController[i].text.toString(),
                        //         "teGrade": null,
                        //         "peGrade": null,
                        //         "ceGrade": null,
                        //         "totalMark": "",
                        //         "markInPer": null,
                        //         "grade": null,
                        //         "gradeId": null,
                        //         "teGradeId": null,
                        //         "peGradeId": null,
                        //         "ceGradeId": null,
                        //         "attendance": value.studentMEList[i].attendance
                        //             .toString(),
                        //         "description": null,
                        //         "disableAbsentRow": false
                        //       },
                        //     );
                        //   }
                        // } else if (value.maxmarkList[0].entryMethod ==
                        //         "Grade" &&
                        //     (value.typecode == "STATE")) {
                        //   print('-------------------');
                        //   for (int i = 0; i < value.studentMEList.length; i++) {
                        //     obj.add(
                        //       {
                        //         "name": value.studentMEList[i].name.toString(),
                        //         "rollNo":
                        //             value.studentMEList[i].rollNo.toString(),
                        //         "studentPresentDetailsId": value
                        //             .studentMEList[i].studentPresentDetailsId
                        //             .toString(),
                        //         "teMark": null,
                        //         "peMark": null,
                        //         "ceMark": null,
                        //         "teGrade": value.studentMEList[i].teGrade,
                        //         "peGrade": value.studentMEList[i].peGrade,
                        //         "ceGrade": value.studentMEList[i].ceGrade,
                        //         "totalMark": null,
                        //         "markInPer": null,
                        //         "grade": null,
                        //         "gradeId": null,
                        //         "teGradeId": value.studentMEList[i].teGradeId,
                        //         "peGradeId": value.studentMEList[i].peGradeId,
                        //         "ceGradeId": value.studentMEList[i].ceGradeId,
                        //         "attendance": value.studentMEList[i].attendance
                        //             .toString(),
                        //         "description": null,
                        //         "disableAbsentRow": false
                        //       },
                        //     );
                        //   }
                        // } else {
                        //   ScaffoldMessenger.of(context)
                        //       .showSnackBar(const SnackBar(
                        //     elevation: 10,
                        //     shape: RoundedRectangleBorder(
                        //       borderRadius:
                        //           BorderRadius.all(Radius.circular(10)),
                        //     ),
                        //     duration: Duration(seconds: 1),
                        //     margin: EdgeInsets.only(
                        //         bottom: 80, left: 30, right: 30),
                        //     behavior: SnackBarBehavior.floating,
                        //     content: Text(
                        //       "Something went wrong...!",
                        //       textAlign: TextAlign.center,
                        //     ),
                        //   ));
                        // }

                        // //log("Litsssss   $obj");

                        if (markEntryDivisionListController.text.isEmpty &&
                            markEntryInitialValuesController.text.isEmpty) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            duration: Duration(seconds: 1),
                            margin: EdgeInsets.only(
                                bottom: 80, left: 30, right: 30),
                            behavior: SnackBarBehavior.floating,
                            content: Text(
                              "Select mandatory fields...!",
                              textAlign: TextAlign.center,
                            ),
                          ));
                        } else {
                          value.loadSave
                              ? spinkitLoader()
                              : await value.markEntrySave(
                                  value.markEntryIdUAS.toString(),
                                  value.schoolIdUAS.toString(),
                                  value.tabulationTypeCode.toString(),
                                  value.subjectCaptionUAS.toString(),
                                  value.divisionUAS.toString(),
                                  value.courseUAS.toString(),
                                  value.partUAS.toString(),
                                  value.subjectUAS.toString(),
                                  value.subSubjectUAS.toString(),
                                  value.optionSubjectUAS.toString(),
                                  value.staffIdUAS.toString(),
                                  value.staffNameUAS.toString(),
                                  value.entryMethodUAS.toString(),
                                  value.examUAS.toString(),
                                  value.includeTerminatedStudentsUAS,
                                  value.teMax.toString(),
                                  value.peMaxUAS.toString(),
                                  value.ceMaxUAS.toString(),
                                  value.teCaptionUAS.toString(),
                                  value.peCaptionUAS.toString(),
                                  value.ceCaptionUAS.toString(),
                                  value.examStatusUAS.toString(),
                                  context,
                                  date!,
                                  obj,
                                  value.gradeListUAS,
                                  value.partsUAS);
                          value.examStatus = "Entered";
                        }
                      },
                      color: UIGuide.light_Purple,
                      child: const Text(
                        'Save',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
            }),
            kWidth,
            Consumer<MarkEntryNewProvider>(builder: (context, value, child) {
              return value.loading
                  ? MaterialButton(
                      onPressed: () {},
                      color: Colors.green,
                      child: const Text(
                        'Verifying...',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  : MaterialButton(
                      onPressed: () {
                        value.examStatus == "Pending" &&
                                _controllers[0].text.isEmpty
                            ? ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                duration: Duration(seconds: 1),
                                margin: EdgeInsets.only(
                                    bottom: 80, left: 30, right: 30),
                                behavior: SnackBarBehavior.floating,
                                content: Text(
                                  'No data to Verify....',
                                  textAlign: TextAlign.center,
                                ),
                              ))
                            : showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Center(
                                      child: Text(
                                        "Are You Sure Want To Verify",
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    actions: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: OutlinedButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              style: ButtonStyle(
                                                  side:
                                                      MaterialStateProperty.all(
                                                          const BorderSide(
                                                              color: UIGuide
                                                                  .light_Purple,
                                                              width: 1.0,
                                                              style: BorderStyle
                                                                  .solid))),
                                              child: const Text(
                                                '  Cancel  ',
                                                style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 201, 13, 13),
                                                ),
                                              ),
                                            ),
                                          ),
                                          OutlinedButton(
                                            onPressed: () async {
                                              List obj = [];
                                              obj.clear();

                                              if (value.tabulationTypeCode ==
                                                      "UAS" &&
                                                  value.teCaptionUAS ==
                                                      "Mark") {
                                                for (int i = 0;
                                                    i <
                                                        value
                                                            .studListUAS.length;
                                                    i++) {
                                                  obj.add(
                                                    {
                                                      "attendance": value
                                                          .studListUAS[i]
                                                          .attendance
                                                          .toString(),
                                                      "studentName": value
                                                          .studListUAS[i]
                                                          .studentName
                                                          .toString(),
                                                      "rollNo": value
                                                          .studListUAS[i]
                                                          .rollNo,
                                                      "studentId": value
                                                          .studListUAS[i]
                                                          .studentId
                                                          .toString(),
                                                      "markEntryDetId": value
                                                          .studListUAS[i]
                                                          .markEntryDetId
                                                          .toString(),
                                                      "teMark": value
                                                          .studListUAS[i]
                                                          .teMark,
                                                      "peMark": value
                                                          .studListUAS[i]
                                                          .peMark,
                                                      "ceMark": value
                                                          .studListUAS[i]
                                                          .ceMark,
                                                      "teGrade": value
                                                          .studListUAS[i]
                                                          .teGrade
                                                          .toString(),
                                                      "peGrade": value
                                                          .studListUAS[i]
                                                          .peGrade
                                                          .toString(),
                                                      "ceGrade": value
                                                          .studListUAS[i]
                                                          .ceGrade
                                                          .toString(),
                                                      "total": value
                                                          .studListUAS[i].total,
                                                      "teGradeId": value
                                                          .studListUAS[i]
                                                          .teGradeId
                                                          .toString(),
                                                      "peGradeId": value
                                                          .studListUAS[i]
                                                          .peGradeId
                                                          .toString(),
                                                      "ceGradeId": value
                                                          .studListUAS[i]
                                                          .ceGradeId
                                                          .toString(),
                                                      "tabMarkEntryId": value
                                                          .studListUAS[i]
                                                          .tabMarkEntryId
                                                          .toString(),
                                                      "isEdited": false,
                                                      "isDisabled": false
                                                    },
                                                  );
                                                }
                                              }
                                              // List obj = [];
                                              // obj.clear();
                                              // print(
                                              //     "length:  ${value.studentMEList.length}");
                                              // for (int i = 0;
                                              //     i <
                                              //         value
                                              //             .studentMEList.length;
                                              //     i++) {
                                              //   obj.add(
                                              //     {
                                              //       "name": value
                                              //           .studentMEList[i].name
                                              //           .toString(),
                                              //       "rollNo": value
                                              //           .studentMEList[i].rollNo
                                              //           .toString(),
                                              //       "studentPresentDetailsId": value
                                              //           .studentMEList[i]
                                              //           .studentPresentDetailsId
                                              //           .toString(),
                                              //       "teMark": value
                                              //           .studentMEList[i]
                                              //           .teMark,
                                              //       "peMark": value
                                              //           .studentMEList[i]
                                              //           .peMark,
                                              //       "ceMark": value
                                              //           .studentMEList[i]
                                              //           .ceMark,
                                              //       "teGrade": value
                                              //           .studentMEList[i]
                                              //           .teGrade,
                                              //       "peGrade": value
                                              //           .studentMEList[i]
                                              //           .peGrade,
                                              //       "ceGrade": value
                                              //           .studentMEList[i]
                                              //           .ceGrade,
                                              //       "totalMark": value
                                              //           .studentMEList[i]
                                              //           .totalMark,
                                              //       "markInPer": value
                                              //           .studentMEList[i]
                                              //           .markInPer,
                                              //       "grade": value
                                              //           .studentMEList[i].grade,
                                              //       "gradeId": value
                                              //           .studentMEList[i]
                                              //           .gradeId,
                                              //       "teGradeId": value
                                              //           .studentMEList[i]
                                              //           .teGradeId,
                                              //       "peGradeId": value
                                              //           .studentMEList[i]
                                              //           .peGradeId,
                                              //       "ceGradeId": value
                                              //           .studentMEList[i]
                                              //           .ceGradeId,
                                              //       "attendance": value
                                              //           .studentMEList[i]
                                              //           .attendance
                                              //           .toString(),
                                              //       "description": null,
                                              //       "disableAbsentRow": false
                                              //     },
                                              //   );
                                              // }

                                              if (markEntryDivisionListController
                                                      .text.isEmpty &&
                                                  markEntryInitialValuesController
                                                      .text.isEmpty) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                        const SnackBar(
                                                  elevation: 10,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                  ),
                                                  duration:
                                                      Duration(seconds: 1),
                                                  margin: EdgeInsets.only(
                                                      bottom: 80,
                                                      left: 30,
                                                      right: 30),
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                  content: Text(
                                                    "Select mandatory fields...!",
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ));
                                              } else if (obj.isEmpty) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                        const SnackBar(
                                                  elevation: 10,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                  ),
                                                  duration:
                                                      Duration(seconds: 1),
                                                  margin: EdgeInsets.only(
                                                      bottom: 80,
                                                      left: 30,
                                                      right: 30),
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                  content: Text(
                                                    "No data to Verify"
                                                    "...",
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ));
                                              } else {
                                                value.loading
                                                    ? spinkitLoader()
                                                    :
                                                    //await value.markEntrySave(courseId,divisionId,partId,subjectId,date!,markEntryExamListController.text.toString(),context, obj);
                                                    await value.markEntryVerify(
                                                        value.markEntryIdUAS
                                                            .toString(),
                                                        value.schoolIdUAS
                                                            .toString(),
                                                        value.tabulationTypeCode
                                                            .toString(),
                                                        value.subjectCaptionUAS
                                                            .toString(),
                                                        value.divisionUAS
                                                            .toString(),
                                                        value.courseUAS
                                                            .toString(),
                                                        value.partUAS
                                                            .toString(),
                                                        value.subjectUAS
                                                            .toString(),
                                                        value.subSubjectUAS
                                                            .toString(),
                                                        value.optionSubjectUAS
                                                            .toString(),
                                                        value.staffIdUAS
                                                            .toString(),
                                                        value.staffNameUAS
                                                            .toString(),
                                                        value.entryMethodUAS
                                                            .toString(),
                                                        value.examUAS
                                                            .toString(),
                                                        value
                                                            .includeTerminatedStudentsUAS,
                                                        value.teMax.toString(),
                                                        value.peMaxUAS
                                                            .toString(),
                                                        value.ceMaxUAS
                                                            .toString(),
                                                        value.teCaptionUAS
                                                            .toString(),
                                                        value.peCaptionUAS
                                                            .toString(),
                                                        value.ceCaptionUAS
                                                            .toString(),
                                                        value.examStatusUAS
                                                            .toString(),
                                                        context,
                                                        value.updatedAtUAS
                                                            .toString(),
                                                        obj,
                                                        value.gradeListUAS,
                                                        value.partsUAS);
                                                value.examStatus = "Verified";
                                              }
                                            },
                                            style: ButtonStyle(
                                                side: MaterialStateProperty.all(
                                                    const BorderSide(
                                                        color: UIGuide
                                                            .light_Purple,
                                                        width: 1.0,
                                                        style: BorderStyle
                                                            .solid))),
                                            child: const Text(
                                              'Confirm',
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 12, 162, 46),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  );
                                },
                              );
                      },
                      color: Colors.green,
                      child: const Text(
                        "Verify",
                        style: TextStyle(color: Colors.white),
                      ),
                    );
            }),
            kWidth,
            Consumer<MarkEntryNewProvider>(builder: (context, value, child) {
              return MaterialButton(
                onPressed: () {
                  value.examStatus == "Pending"
                      ? ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          duration: Duration(seconds: 1),
                          margin:
                              EdgeInsets.only(bottom: 80, left: 30, right: 30),
                          behavior: SnackBarBehavior.floating,
                          content: Text(
                            'No data to Delete....',
                            textAlign: TextAlign.center,
                          ),
                        ))
                      : showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Center(
                                child: Text(
                                  "Are You Sure Want To Delete",
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              actions: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: OutlinedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        style: ButtonStyle(
                                            side: MaterialStateProperty.all(
                                                const BorderSide(
                                                    color: UIGuide.light_Purple,
                                                    width: 1.0,
                                                    style: BorderStyle.solid))),
                                        child: const Text(
                                          '  Cancel  ',
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 201, 13, 13),
                                          ),
                                        ),
                                      ),
                                    ),
                                    OutlinedButton(
                                      onPressed: () async {
                                        // List obj = [];
                                        // obj.clear();
                                        // print(
                                        //     "length:  ${value.studentMEList.length}");
                                        // for (int i = 0;
                                        //     i < value.studentMEList.length;
                                        //     i++) {
                                        //   obj.add(
                                        //     {
                                        //       "name": value
                                        //           .studentMEList[i].name
                                        //           .toString(),
                                        //       "rollNo": value
                                        //           .studentMEList[i].rollNo
                                        //           .toString(),
                                        //       "studentPresentDetailsId": value
                                        //           .studentMEList[i]
                                        //           .studentPresentDetailsId
                                        //           .toString(),
                                        //       "teMark":
                                        //           value.studentMEList[i].teMark,
                                        //       "peMark":
                                        //           value.studentMEList[i].peMark,
                                        //       "ceMark":
                                        //           value.studentMEList[i].ceMark,
                                        //       "teGrade": value
                                        //           .studentMEList[i].teGrade,
                                        //       "peGrade": value
                                        //           .studentMEList[i].peGrade,
                                        //       "ceGrade": value
                                        //           .studentMEList[i].ceGrade,
                                        //       "totalMark": value
                                        //           .studentMEList[i].totalMark,
                                        //       "markInPer": value
                                        //           .studentMEList[i].markInPer,
                                        //       "grade":
                                        //           value.studentMEList[i].grade,
                                        //       "gradeId": value
                                        //           .studentMEList[i].gradeId,
                                        //       "teGradeId": value
                                        //           .studentMEList[i].teGradeId,
                                        //       "peGradeId": value
                                        //           .studentMEList[i].peGradeId,
                                        //       "ceGradeId": value
                                        //           .studentMEList[i].ceGradeId,
                                        //       "attendance": value
                                        //           .studentMEList[i].attendance
                                        //           .toString(),
                                        //       "description": null,
                                        //       "disableAbsentRow": false
                                        //     },
                                        //   );
                                        // }

                                        // if (markEntryDivisionListController
                                        //         .text.isEmpty &&
                                        //     markEntryInitialValuesController
                                        //         .text.isEmpty) {
                                        //   ScaffoldMessenger.of(context)
                                        //       .showSnackBar(const SnackBar(
                                        //     elevation: 10,
                                        //     shape: RoundedRectangleBorder(
                                        //       borderRadius: BorderRadius.all(
                                        //           Radius.circular(10)),
                                        //     ),
                                        //     duration: Duration(seconds: 1),
                                        //     margin: EdgeInsets.only(
                                        //         bottom: 80,
                                        //         left: 30,
                                        //         right: 30),
                                        //     behavior: SnackBarBehavior.floating,
                                        //     content: Text(
                                        //       "Select mandatory fields...!",
                                        //       textAlign: TextAlign.center,
                                        //     ),
                                        //   ));
                                        // } else if (obj.isEmpty) {
                                        //   ScaffoldMessenger.of(context)
                                        //       .showSnackBar(const SnackBar(
                                        //     elevation: 10,
                                        //     shape: RoundedRectangleBorder(
                                        //       borderRadius: BorderRadius.all(
                                        //           Radius.circular(10)),
                                        //     ),
                                        //     duration: Duration(seconds: 1),
                                        //     margin: EdgeInsets.only(
                                        //         bottom: 80,
                                        //         left: 30,
                                        //         right: 30),
                                        //     behavior: SnackBarBehavior.floating,
                                        //     content: Text(
                                        //       "No data to Delete...",
                                        //       textAlign: TextAlign.center,
                                        //     ),
                                        //   ));
                                        // } else {
                                        //   value.loading
                                        //       ? spinkitLoader()
                                        //       :
                                        //       //await value.markEntrySave(courseId,divisionId,partId,subjectId,date!,markEntryExamListController.text.toString(),context, obj);
                                        //       await value.markEntryDelete(
                                        //           courseId,
                                        //           divisionId,
                                        //           partId,
                                        //           markEntryOptionSubListController1
                                        //               .text,
                                        //           subjectId,
                                        //           markEntryExamListController
                                        //               .text
                                        //               .toString(),
                                        //           date!,
                                        //           context,
                                        //           obj);
                                        //   value.examStatus = "Pending";
                                        // }
                                      },
                                      style: ButtonStyle(
                                          side: MaterialStateProperty.all(
                                              const BorderSide(
                                                  color: UIGuide.light_Purple,
                                                  width: 1.0,
                                                  style: BorderStyle.solid))),
                                      child: const Text(
                                        'Confirm',
                                        style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 12, 162, 46),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            );
                          },
                        );
                },
                color: Colors.red,
                child: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.white),
                ),
              );
            }),
            kWidth
          ],
        ),
      ),
    );
  }
}
