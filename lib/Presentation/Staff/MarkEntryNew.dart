import 'package:essconnect/Constants.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:essconnect/utils/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../Application/Staff_Providers/MarkEntryNewProvider.dart';

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
      p.setLoading(false);
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
                            builder: (context) => const MarkEntryNew()));
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
                                              await value.clearStudentMEList();
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
                                                  await value
                                                      .clearStudentMEList();

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
                                                  await value
                                                      .clearStudentMEList();

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
                                                  await value
                                                      .clearStudentMEList();

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
                                                  onTap: () async {
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
                                                    await value
                                                        .clearStudentMEList();

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
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: InkWell(
                          onTap: () => value.terminatedCheckbox(),
                          child: Row(
                            children: [
                              Checkbox(
                                activeColor: UIGuide.light_Purple,
                                value: value.isTerminated,
                                onChanged: (newValue) {
                                  value.isTerminated = newValue!;
                                },
                              ),
<<<<<<< HEAD
                              Expanded(
                                //   width: size.width * .35,
=======
                              SizedBox(
                                width: size.width * .35,
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
                                child: const Text(
                                  "Include Terminated Students",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
<<<<<<< HEAD
                                      color: UIGuide.BLACK, fontSize: 12),
=======
                                    color: UIGuide.BLACK,
                                  ),
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
                                ),
                              )
                            ],
                          )),
                    ),
                    kWidth,
                    value.loading
                        ? SizedBox(
                            width: size.width * .46,
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
                        : Expanded(
                            // width: size.width * .46,
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

                                if (course.isEmpty ||
                                    division.isEmpty ||
                                    part.isEmpty ||
                                    subject.isEmpty ||
                                    exam.isEmpty) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    duration: Duration(seconds: 3),
                                    margin: EdgeInsets.only(
                                        bottom: 80, left: 30, right: 30),
                                    behavior: SnackBarBehavior.floating,
                                    content: Text(
                                      "Select mandatory fields..!",
                                      textAlign: TextAlign.center,
                                    ),
                                  ));
                                } else {
                                  if (value.typeCode == "UAS") {
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
                                  } else {
                                    await value.getMarkEntrySTATEView(
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
                                  }
                                }

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
                    SizedBox(
                      width: 6,
                    ),
                  ],
                ),
                value.examStatusUAS == "Verified"
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Verified By :",
<<<<<<< HEAD
                              style:
                                  TextStyle(color: Colors.green, fontSize: 13)),
                          Text(value.staffNameUAS ?? "--",
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 13))
=======
                              style: TextStyle(color: Colors.green)),
                          Text(value.staffNameUAS ?? "--",
                              style: const TextStyle(color: Colors.black))
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
                        ],
                      )
                    : const SizedBox(
                        height: 0,
                        width: 0,
                      ),
                Consumer<MarkEntryNewProvider>(builder: (context, provider, _) {
                  if (provider.loading) {
                    return LimitedBox(
                      maxHeight: size.height / 1.81,
                      child: Container(
                        height: size.height / 1.95,
                        child: spinkitLoader(),
                      ),
                    );
                  } else if (provider.isBlockedUAS == true) {
                    return LimitedBox(
                        maxHeight: size.height / 1.81,
                        child: Center(
                          child: const Text(
                            "MarkEntry Blocked",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ));
                  }
////-----------    ----------    ---------    ----------    ---------     ----------    ---------
////-----------    ----------          Mark  Entry --[ UAS ]--     -----------        -----------
////-----------    ----------    ---------    ----------    ---------     ----------    ---------

                  else if (provider.tabulationTypeCode == "UAS" &&
                      provider.teCaptionUAS == "Mark") {
                    maxScrore = double.parse(provider.teMax.toString());
                    return LimitedBox(
                        maxHeight: size.height / 1.81,
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
                                                      '',
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
                                                          "attendaceeeee   $attendancee");
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
                                                    // textAlign: TextAlign.center,
                                                    //  focusNode: FocusNode(),
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    controller:
                                                        _controllers[index],
                                                    enabled: provider
                                                                    .studListUAS[
                                                                        index]
                                                                    .attendance ==
                                                                'A' ||
                                                            value.examStatusUAS ==
                                                                'Synchronized'
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
                                                            .fromARGB(255, 213,
                                                            215, 218),
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
                                                              .text
                                                              .isEmpty
                                                          ? provider
                                                              .studListUAS[
                                                                  index]
                                                              .teMark = null
                                                          : _controllers[index]
                                                              .text;
                                                      print(
                                                          "***************${_controllers[index].text}");

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
                                                      String resultt =
                                                          _controllers[index]
                                                              .text;
                                                      provider
                                                              .studListUAS[index]
                                                              .teMark =
                                                          double.tryParse(
                                                              resultt);
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
                  }

////-----------    ----------    ---------    ----------    ---------     ----------    ---------
////-----------    ----------          Grade Entry --- UAS         -----------        -----------
////-----------    ----------    ---------    ----------    ---------     ----------    ---------

                  else if ((provider.tabulationTypeCode == "UAS") &&
                      provider.teCaptionUAS == "Grade") {
                    return LimitedBox(
<<<<<<< HEAD
                        maxHeight: size.height / 1.81,
=======
                        maxHeight: size.height / 1.85,
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: provider.studListUAS.length,
                              itemBuilder: ((context, index) {
                                gradeListController
                                    .add(TextEditingController());
                                gradeListController1
                                    .add(TextEditingController());

                                gradeListController1[index].text.isEmpty
                                    ? gradeListController1[index].text =
                                        provider.studListUAS[index].teGrade ==
                                                null
                                            ? gradeListController1[index].text
                                            : provider
                                                .studListUAS[index].teGrade
                                                .toString()
                                    : gradeListController1[index].text;
                                gradeListController[index].text.isEmpty
                                    ? gradeListController[index].text = provider
                                                .studListUAS[index].teGrade ==
                                            null
                                        ? gradeListController[index].text
                                        : provider.studListUAS[index].teGrade
                                            .toString()
                                    : gradeListController[index].text;

                                return Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Container(
                                    height: 80,
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
                                              const Text(
                                                'Roll No: ',
                                                style: TextStyle(),
                                              ),
                                              provider.studListUAS[index]
                                                          .rollNo ==
                                                      null
                                                  ? const Text(
<<<<<<< HEAD
                                                      '',
=======
                                                      '0',
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
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
                                              kWidth,
                                              kWidth,
                                              Text(
                                                  '${value.teCaptionUAS ?? ""} : '),
                                              SizedBox(
                                                height: 40,
                                                width: 100,
                                                child: SizedBox(
                                                  height: 40,
                                                  width: 100,
                                                  child: Consumer<
                                                          MarkEntryNewProvider>(
                                                      builder: (context,
                                                          snapshot, child) {
                                                    return InkWell(
                                                      onTap: () {
                                                        showDialog(
                                                            context: context,
                                                            builder: (context) {
                                                              return Dialog(
                                                                  child:
                                                                      LimitedBox(
                                                                maxHeight:
                                                                    size.height /
                                                                        2,
                                                                child: ListView
                                                                    .builder(
                                                                        shrinkWrap:
                                                                            true,
                                                                        itemCount: snapshot
                                                                            .gradeListUAS
                                                                            .length,
                                                                        itemBuilder:
                                                                            (context,
                                                                                indx) {
                                                                          return ListTile(
                                                                            selectedTileColor:
                                                                                Colors.blue.shade100,
                                                                            selectedColor:
                                                                                UIGuide.PRIMARY2,
                                                                            onTap:
                                                                                () {
                                                                              gradeListController[index].text = snapshot.gradeListUAS[indx].text ?? '--';
                                                                              gradeListController1[index].text = snapshot.gradeListUAS[indx].value ?? '--';
                                                                              provider.studListUAS[index].teGrade = gradeListController1[index].text;
                                                                              //     provider.studListUAS[index].teGrade = gradeListController[index].text;
                                                                              provider.studListUAS[index].teGrade = provider.studListUAS[index].teGrade;
                                                                              Navigator.of(context).pop();
                                                                            },
                                                                            title:
                                                                                Text(
                                                                              snapshot.gradeListUAS[indx].text ?? '--',
                                                                              textAlign: TextAlign.center,
                                                                            ),
                                                                          );
                                                                        }),
                                                              ));
                                                            });
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5.0),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Container(
                                                              height: 30,
                                                              decoration:
                                                                  BoxDecoration(
                                                                border: Border.all(
                                                                    color: UIGuide
                                                                        .light_Purple,
                                                                    width: 1),
                                                              ),
                                                              child: TextField(
<<<<<<< HEAD
                                                                textInputAction:
                                                                    TextInputAction
                                                                        .next,
=======
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: UIGuide
                                                                        .BLACK,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                controller:
                                                                    gradeListController[
                                                                        index],
                                                                decoration:
                                                                    const InputDecoration(
                                                                  filled: true,
                                                                  contentPadding:
                                                                      EdgeInsets.only(
                                                                          left:
                                                                              0,
                                                                          top:
                                                                              0),
                                                                  floatingLabelBehavior:
                                                                      FloatingLabelBehavior
                                                                          .never,
                                                                  fillColor: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          255,
                                                                          255,
                                                                          255),
                                                                  border:
                                                                      OutlineInputBorder(),
                                                                  labelText:
<<<<<<< HEAD
                                                                      " Select ",
=======
                                                                      " Select grade",
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
                                                                  hintText:
                                                                      "grade",
                                                                ),
                                                                enabled: false,
                                                                onChanged:
                                                                    (value1) {
                                                                  gradeListController1[
                                                                              index]
                                                                          .text =
                                                                      provider
                                                                          .studListUAS[
                                                                              index]
                                                                          .teGradeId
                                                                          .toString();
                                                                  gradeListController1[
                                                                          index]
                                                                      .text = value1;
                                                                },
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  }),
                                                ),
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
                  }

////-----------    ----------    ---------    ----------    ---------     ----------    ---------
////-----------    ---------- PUBLIC TABULATION  -- Grade Entry      -----------        ---------
////-----------    ----------    ---------    ----------    ---------     ----------    ---------

                  else if (provider.tabulationTypeCode == "PBT" &&
                      provider.teCaptionUAS == "Grade") {
                    return LimitedBox(
<<<<<<< HEAD
                        maxHeight: size.height / 1.81,
=======
                        maxHeight: size.height / 1.85,
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: provider.studListUAS.length,
                              itemBuilder: ((context, index) {
                                //TE Grade
                                publicGradeController
                                    .add(TextEditingController());
                                publicGradeController1
                                    .add(TextEditingController());

                                publicGradeController1[index].text.isEmpty
                                    ? publicGradeController1[index].text =
                                        provider.studListUAS[index].teGrade ==
                                                null
                                            ? publicGradeController1[index].text
                                            : provider
                                                .studListUAS[index].teGrade
                                                .toString()
                                    : publicGradeController1[index].text;
                                publicGradeController[index].text.isEmpty
                                    ? publicGradeController[index].text =
                                        provider.studListUAS[index].teGrade ==
                                                null
                                            ? publicGradeController[index].text
                                            : provider
                                                .studListUAS[index].teGrade
                                                .toString()
                                    : publicGradeController[index].text;

                                return Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Container(
                                    width: size.width,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: UIGuide.light_Purple,
                                          width: 1,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: 80,
                                                child: Text(
<<<<<<< HEAD
                                                  'Roll No: ${provider.studListUAS[index].rollNo == null ? '' : provider.studListUAS[index].rollNo.toString()}',
=======
                                                  'Roll No: ${provider.studListUAS[index].rollNo == null ? '0' : provider.studListUAS[index].rollNo.toString()}',
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              kWidth,
                                              kWidth,
                                              kWidth,
                                              // Padding(
                                              //   padding: const EdgeInsets.only(
                                              //       left: 10.0),
                                              //   child: GestureDetector(
                                              //     onTap: () {
                                              //       setState(() {
                                              //         if (provider
                                              //                 .studListUAS[
                                              //                     index]
                                              //                 .attendance ==
                                              //             'A') {
                                              //           provider
                                              //               .studListUAS[index]
                                              //               .attendance = 'P';
                                              //         } else {
                                              //           provider
                                              //               .studListUAS[index]
                                              //               .attendance = 'A';

                                              //           provider
                                              //               .studListUAS[index]
                                              //               .teGrade = null;
                                              //           provider
                                              //               .studListUAS[index]
                                              //               .teGradeId = null;

                                              //           publicGradeController[
                                              //                   index]
                                              //               .clear();
                                              //           publicGradeController1[
                                              //                   index]
                                              //               .clear();
                                              //         }
                                              //         attendancee = provider
                                              //             .studListUAS[index]
                                              //             .attendance;

                                              //         print(
                                              //             "attendace   $attendancee");
                                              //       });
                                              //     },
                                              //     child: Container(
                                              //       color: Colors.transparent,
                                              //       width: 28,
                                              //       height: 26,
                                              //       child: SizedBox(
                                              //           width: 28,
                                              //           height: 26,
                                              //           child: provider
                                              //                       .studListUAS[
                                              //                           index]
                                              //                       .attendance ==
                                              //                   'A'
                                              //               ? SvgPicture.asset(
                                              //                   UIGuide.absent)
                                              //               : SvgPicture.asset(
                                              //                   UIGuide
                                              //                       .present)),
                                              //     ),
                                              //   ),
                                              // ),
                                              kWidth,
                                              kWidth,
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
                                                            .studentName ??
                                                        '--',
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                LimitedBox(
                                                  maxWidth: 80,
                                                  child: Text(
                                                    '${value.teCaptionUAS ?? ""} : ',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 40,
                                                  width: 100,
                                                  child: SizedBox(
                                                    height: 40,
                                                    width: 100,
                                                    child: Consumer<
                                                            MarkEntryNewProvider>(
                                                        builder: (context,
                                                            snapshot, child) {
                                                      return InkWell(
                                                        onTap: () {
                                                          showDialog(
                                                              context: context,
                                                              builder:
                                                                  (context) {
                                                                return Dialog(
                                                                    child:
                                                                        LimitedBox(
                                                                  maxHeight:
                                                                      size.height /
                                                                          2,
                                                                  child: ListView
                                                                      .builder(
                                                                          shrinkWrap:
                                                                              true,
                                                                          itemCount: snapshot
                                                                              .gradeListUAS
                                                                              .length,
                                                                          itemBuilder:
                                                                              (context, indx) {
                                                                            return ListTile(
                                                                              selectedTileColor: Colors.blue.shade100,
                                                                              selectedColor: UIGuide.PRIMARY2,
                                                                              onTap: () {
                                                                                publicGradeController[index].text = snapshot.gradeListUAS[indx].text ?? '--';
                                                                                publicGradeController1[index].text = snapshot.gradeListUAS[indx].value ?? '--';
                                                                                provider.studListUAS[index].teGrade = publicGradeController1[index].text;
                                                                                //     provider.studListUAS[index].teGrade = publicGradeController[index].text;
                                                                                provider.studListUAS[index].teGrade = provider.studListUAS[index].teGrade;
                                                                                Navigator.of(context).pop();
                                                                              },
                                                                              title: Text(
                                                                                snapshot.gradeListUAS[indx].text ?? '--',
                                                                                textAlign: TextAlign.center,
                                                                              ),
                                                                            );
                                                                          }),
                                                                ));
                                                              });
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(5.0),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              Container(
                                                                height: 30,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  border: Border.all(
                                                                      color: UIGuide
                                                                          .light_Purple,
                                                                      width: 1),
                                                                ),
                                                                child:
                                                                    TextField(
<<<<<<< HEAD
                                                                  textInputAction:
                                                                      TextInputAction
                                                                          .next,
                                                                  enabled: provider.studListUAS[index].attendance ==
                                                                              'A' ||
                                                                          value.examStatusUAS ==
                                                                              'Synchronized'
=======
                                                                  enabled: provider
                                                                              .studListUAS[index]
                                                                              .attendance ==
                                                                          'A'
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
                                                                      ? true
                                                                      : false,
                                                                  readOnly:
                                                                      true,
                                                                  style: const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color: UIGuide
                                                                          .BLACK,
                                                                      fontSize:
                                                                          14,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .clip),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  controller:
                                                                      publicGradeController[
                                                                          index],
                                                                  decoration:
                                                                      const InputDecoration(
                                                                    filled:
                                                                        true,
                                                                    contentPadding:
                                                                        EdgeInsets.only(
                                                                            left:
                                                                                0,
                                                                            top:
                                                                                0),
                                                                    floatingLabelBehavior:
                                                                        FloatingLabelBehavior
                                                                            .never,
                                                                    fillColor: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            255,
                                                                            255,
                                                                            255),
                                                                    border:
                                                                        OutlineInputBorder(),
                                                                    labelText:
<<<<<<< HEAD
                                                                        " Select ",
=======
                                                                        " Select grade",
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
                                                                    hintText:
                                                                        "grade",
                                                                  ),
                                                                  onChanged:
                                                                      (value1) {
                                                                    publicGradeController1[index].text = provider
                                                                        .studListUAS[
                                                                            index]
                                                                        .teGrade
                                                                        .toString();
                                                                    publicGradeController1[index]
                                                                            .text =
                                                                        value1;
                                                                  },
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    }),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              })),
                        ));
                  }

////-----------    ----------    ---------    ----------    ---------     ----------    ---------
////-----------    ---------- PUBLIC TABULATION  --- STATE (Mark)    -----------        ---------
////-----------    ----------    ---------    ----------    ---------     ----------    ---------

                  else if ((provider.tabulationTypeCode == "PBT" ||
                          provider.tabulationTypeCode == "STATE") &&
                      provider.entryMethodUAS == "Mark") {
///////////////-------------------------------------------------------------------------------------///////////////
///////////////-----------------------     TE MARK  --  PE MARK --  CE MARK  ----------------------///////////////
///////////////-----------------------------------------------------------------------------------///////////////

                    if (provider.teMax != null &&
                        provider.peMax != null &&
                        provider.ceMax != null) {
                      return LimitedBox(
<<<<<<< HEAD
                          maxHeight: size.height / 1.81,
=======
                          maxHeight: size.height / 1.85,
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Scrollbar(
                              child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: value.studListUAS.length,
                                  itemBuilder: ((context, index) {
                                    String pre = 'P';
                                    markfieldController.text = pre;
                                    teMarkController
                                        .add(new TextEditingController());
                                    ceMarkController
                                        .add(new TextEditingController());
                                    practicalMarkController
                                        .add(new TextEditingController());

                                    teMarkController[index].text.isEmpty
                                        ? teMarkController[index].text = value
                                                    .studListUAS[index]
                                                    .teMark ==
                                                null
                                            ? teMarkController[index].text
                                            : value.studListUAS[index].teMark
                                                .toString()
                                        : teMarkController[index].text;
                                    practicalMarkController[index].text.isEmpty
                                        ? practicalMarkController[index].text =
                                            value.studListUAS[index].peMark ==
                                                    null
                                                ? practicalMarkController[index]
                                                    .text
                                                : value
                                                    .studListUAS[index].peMark
                                                    .toString()
                                        : practicalMarkController[index].text;
                                    ceMarkController[index].text.isEmpty
                                        ? ceMarkController[index].text = value
                                                    .studListUAS[index]
                                                    .ceMark ==
                                                null
                                            ? ceMarkController[index].text
                                            : value.studListUAS[index].ceMark
                                                .toString()
                                        : ceMarkController[index].text;

                                    print('fn called------------');

                                    return Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Container(
                                        // height: 100,
                                        width: size.width,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                              color: UIGuide.light_Purple,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Row(
                                                children: [
                                                  const Text(
                                                    'Roll No: ',
                                                    style: TextStyle(),
                                                  ),
                                                  value.studListUAS[index]
                                                              .rollNo ==
                                                          null
                                                      ? const Text(
<<<<<<< HEAD
                                                          '',
=======
                                                          '0',
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
                                                          style: TextStyle(
                                                              color: UIGuide
                                                                  .light_Purple),
                                                        )
                                                      : Text(
                                                          value
                                                              .studListUAS[
                                                                  index]
                                                              .rollNo
                                                              .toString(),
                                                          style: const TextStyle(
                                                              color: UIGuide
                                                                  .light_Purple),
                                                        ),
                                                  const Spacer()
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
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
                                                      strutStyle:
                                                          const StrutStyle(
                                                              fontSize: 12.0),
                                                      text: TextSpan(
                                                        style: const TextStyle(
                                                            color: UIGuide
                                                                .light_Purple),
                                                        text: value
                                                                .studListUAS[
                                                                    index]
                                                                .studentName ??
                                                            '--',
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10.0),
                                                    child: GestureDetector(
                                                      onTap: () async {
                                                        setState(() {
                                                          if (value
                                                                  .studListUAS[
                                                                      index]
                                                                  .attendance ==
                                                              'A') {
                                                            value
                                                                .studListUAS[
                                                                    index]
                                                                .attendance = 'P';
                                                          } else {
                                                            value
                                                                .studListUAS[
                                                                    index]
                                                                .attendance = 'A';
                                                            value
                                                                .studListUAS[
                                                                    index]
                                                                .teMark = null;
                                                            value
                                                                .studListUAS[
                                                                    index]
                                                                .ceMark = null;
                                                            value
                                                                .studListUAS[
                                                                    index]
                                                                .peMark = null;
                                                            teMarkController[
                                                                    index]
                                                                .clear();
                                                            practicalMarkController[
                                                                    index]
                                                                .clear();
                                                            ceMarkController[
                                                                    index]
                                                                .clear();
                                                          }
                                                          attendancee = value
                                                              .studListUAS[
                                                                  index]
                                                              .attendance;

                                                          print(
                                                              "attendace   $attendancee");
                                                        });
                                                      },
                                                      child: Container(
                                                        color:
                                                            Colors.transparent,
                                                        width: 28,
                                                        height: 26,
                                                        child: SizedBox(
                                                            width: 28,
                                                            height: 26,
                                                            child: value
                                                                        .studListUAS[
                                                                            index]
                                                                        .attendance ==
                                                                    'A'
                                                                ? SvgPicture
                                                                    .asset(UIGuide
                                                                        .absent)
                                                                : SvgPicture
                                                                    .asset(UIGuide
                                                                        .present)),
                                                      ),
                                                    ),
                                                  ),
                                                  kWidth,
                                                  kWidth,
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: SizedBox(
                                                      height: 30,
                                                      width: 80,
                                                      child: TextField(
<<<<<<< HEAD
                                                        textInputAction:
                                                            TextInputAction
                                                                .next,
                                                        controller:
                                                            teMarkController[
                                                                index],
                                                        //focusNode: FocusNode(),
                                                        enabled: value
                                                                        .studListUAS[
                                                                            index]
                                                                        .attendance ==
                                                                    'A' ||
                                                                value.examStatusUAS ==
                                                                    'Synchronized'
=======
                                                        controller:
                                                            teMarkController[
                                                                index],
                                                        focusNode: FocusNode(),
                                                        enabled: value
                                                                    .studListUAS[
                                                                        index]
                                                                    .attendance ==
                                                                'A'
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
                                                            ? false
                                                            : true,
                                                        cursorColor: UIGuide
                                                            .light_Purple,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
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
                                                              if (text
                                                                  .isNotEmpty)
                                                                double.parse(
                                                                    text);
                                                              return newValue;
                                                            } catch (e) {}
                                                            return oldValue;
                                                          }),
                                                          LengthLimitingTextInputFormatter(
                                                              5),
                                                        ],
                                                        decoration:
                                                            InputDecoration(
<<<<<<< HEAD
                                                                focusColor: const Color
                                                                    .fromARGB(
                                                                    255,
                                                                    213,
                                                                    215,
                                                                    218),
=======
                                                                focusColor:
                                                                    const Color.fromARGB(
                                                                        255,
                                                                        213,
                                                                        215,
                                                                        218),
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
                                                                border:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.0),
                                                                ),
                                                                focusedBorder:
                                                                    OutlineInputBorder(
                                                                  borderSide: const BorderSide(
                                                                      color: UIGuide
                                                                          .light_Purple,
                                                                      width:
                                                                          1.0),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.0),
                                                                ),
                                                                fillColor:
                                                                    Colors.grey,
                                                                hintStyle:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize: 16,
                                                                  fontFamily:
                                                                      "verdana_regular",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ),
                                                                labelText: value
                                                                        .teCaptionUAS ??
                                                                    "",
                                                                labelStyle: const TextStyle(
                                                                    fontSize:
                                                                        13,
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            106,
                                                                            107,
                                                                            109))),
                                                        onChanged: (value1) {
                                                          teMarkController[
                                                                  index]
                                                              .addListener(() {
                                                            value1;
                                                          });

                                                          teMarkController[
                                                                      index]
                                                                  .text
                                                                  .isEmpty
                                                              ? value
                                                                  .studListUAS[
                                                                      index]
                                                                  .teMark = null
                                                              : teMarkController[
                                                                      index]
                                                                  .text;

                                                          teMarkController[
                                                                      index]
                                                                  .selection =
                                                              TextSelection.collapsed(
                                                                  offset: teMarkController[
                                                                          index]
                                                                      .text
                                                                      .length);

                                                          if (double.parse(
                                                                  teMarkController[
                                                                          index]
                                                                      .text) >
                                                              double.parse(value
                                                                  .teMax
                                                                  .toString())) {
                                                            teMarkController[
                                                                    index]
                                                                .clear();
                                                          }
                                                          String resultt =
                                                              teMarkController[
                                                                      index]
                                                                  .text;
                                                          value
                                                                  .studListUAS[
                                                                      index]
                                                                  .teMark =
                                                              double.tryParse(
                                                                  resultt);
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 2.0),
                                                    child: SizedBox(
                                                        height: 30,
                                                        width: 50,
                                                        child: Center(
                                                            child: Text(
                                                          "(${value.teMax})",
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 15,
                                                          ),
                                                        ))),
                                                  ),
                                                  kWidth,
                                                  kWidth,
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: SizedBox(
                                                      height: 30,
                                                      width: 80,
                                                      child: TextField(
<<<<<<< HEAD
                                                        textInputAction:
                                                            TextInputAction
                                                                .next,
                                                        controller:
                                                            practicalMarkController[
                                                                index],
                                                        //  focusNode: FocusNode(),
                                                        enabled: value
                                                                        .studListUAS[
                                                                            index]
                                                                        .attendance ==
                                                                    'A' ||
                                                                value.examStatusUAS ==
                                                                    'Synchronized'
=======
                                                        controller:
                                                            practicalMarkController[
                                                                index],
                                                        focusNode: FocusNode(),
                                                        enabled: value
                                                                    .studListUAS[
                                                                        index]
                                                                    .attendance ==
                                                                'A'
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
                                                            ? false
                                                            : true,
                                                        cursorColor: UIGuide
                                                            .light_Purple,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
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
                                                              if (text
                                                                  .isNotEmpty)
                                                                double.parse(
                                                                    text);
                                                              return newValue;
                                                            } catch (e) {}
                                                            return oldValue;
                                                          }),
                                                          LengthLimitingTextInputFormatter(
                                                              5),
                                                        ],
                                                        decoration:
                                                            InputDecoration(
<<<<<<< HEAD
                                                                focusColor: const Color
                                                                    .fromARGB(
                                                                    255,
                                                                    213,
                                                                    215,
                                                                    218),
=======
                                                                focusColor:
                                                                    const Color.fromARGB(
                                                                        255,
                                                                        213,
                                                                        215,
                                                                        218),
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
                                                                border:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.0),
                                                                ),
                                                                focusedBorder:
                                                                    OutlineInputBorder(
                                                                  borderSide: const BorderSide(
                                                                      color: UIGuide
                                                                          .light_Purple,
                                                                      width:
                                                                          1.0),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.0),
                                                                ),
                                                                fillColor:
                                                                    Colors.grey,
                                                                hintStyle:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize: 16,
                                                                  fontFamily:
                                                                      "verdana_regular",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ),
                                                                labelText: value
                                                                        .peCaptionUAS ??
                                                                    "",
                                                                labelStyle: const TextStyle(
                                                                    fontSize:
                                                                        13,
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            106,
                                                                            107,
                                                                            109))),
                                                        onChanged: (value1) {
                                                          practicalMarkController[
                                                                  index]
                                                              .addListener(() {
                                                            value1;
                                                          });

                                                          practicalMarkController[
                                                                      index]
                                                                  .text
                                                                  .isEmpty
                                                              ? value
                                                                  .studListUAS[
                                                                      index]
                                                                  .peMark = null
                                                              : practicalMarkController[
                                                                      index]
                                                                  .text;

                                                          practicalMarkController[
                                                                      index]
                                                                  .selection =
                                                              TextSelection.collapsed(
                                                                  offset: practicalMarkController[
                                                                          index]
                                                                      .text
                                                                      .length);

                                                          if (double.parse(
                                                                  practicalMarkController[
                                                                          index]
                                                                      .text) >
                                                              double.parse(provider
                                                                  .peMax
                                                                  .toString())) {
                                                            practicalMarkController[
                                                                    index]
                                                                .clear();
                                                          }
                                                          String resultt =
                                                              practicalMarkController[
                                                                      index]
                                                                  .text;
                                                          value
                                                                  .studListUAS[
                                                                      index]
                                                                  .peMark =
                                                              double.tryParse(
                                                                  resultt);
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 2.0),
                                                    child: SizedBox(
                                                        height: 30,
                                                        width: 50,
                                                        child: Center(
                                                            child: Text(
                                                          "(${value.peMax})",
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 15,
                                                          ),
                                                        ))),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                const SizedBox(
                                                  width: 58,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: SizedBox(
                                                    height: 30,
                                                    width: 80,
                                                    child: TextField(
<<<<<<< HEAD
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      controller:
                                                          ceMarkController[
                                                              index],
                                                      //   focusNode: FocusNode(),
                                                      enabled: value
                                                                      .studListUAS[
                                                                          index]
                                                                      .attendance ==
                                                                  'A' ||
                                                              value.examStatusUAS ==
                                                                  'Synchronized'
=======
                                                      controller:
                                                          ceMarkController[
                                                              index],
                                                      focusNode: FocusNode(),
                                                      enabled: value
                                                                  .studListUAS[
                                                                      index]
                                                                  .attendance ==
                                                              'A'
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
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
                                                              double.parse(
                                                                  text);
                                                            return newValue;
                                                          } catch (e) {}
                                                          return oldValue;
                                                        }),
                                                        LengthLimitingTextInputFormatter(
                                                            5),
                                                      ],
                                                      decoration:
                                                          InputDecoration(
                                                              focusColor:
                                                                  const Color.fromARGB(
                                                                      255,
                                                                      213,
                                                                      215,
                                                                      218),
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0),
                                                              ),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide: const BorderSide(
                                                                    color: UIGuide
                                                                        .light_Purple,
                                                                    width: 1.0),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0),
                                                              ),
                                                              fillColor:
                                                                  Colors.grey,
                                                              hintStyle:
                                                                  const TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 16,
                                                                fontFamily:
                                                                    "verdana_regular",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                              labelText: value
                                                                      .ceCaptionUAS ??
                                                                  "",
                                                              labelStyle: const TextStyle(
                                                                  fontSize: 13,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          106,
                                                                          107,
                                                                          109))),
                                                      onChanged: (value1) {
                                                        ceMarkController[index]
                                                            .addListener(() {
                                                          value1;
                                                        });

                                                        ceMarkController[index]
                                                                .text
                                                                .isEmpty
                                                            ? value
                                                                .studListUAS[
                                                                    index]
                                                                .ceMark = null
                                                            : ceMarkController[
                                                                    index]
                                                                .text;
                                                        ceMarkController[index]
                                                                .selection =
                                                            TextSelection.collapsed(
                                                                offset:
                                                                    ceMarkController[
                                                                            index]
                                                                        .text
                                                                        .length);

                                                        if (double.parse(
                                                                ceMarkController[
                                                                        index]
                                                                    .text) >
                                                            double.parse(provider
                                                                .peMax
                                                                .toString())) {
                                                          ceMarkController[
                                                                  index]
                                                              .clear();
                                                        }
                                                        String resultt =
                                                            ceMarkController[
                                                                    index]
                                                                .text;
                                                        value.studListUAS[index]
                                                                .ceMark =
                                                            double.tryParse(
                                                                resultt);
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 2.0),
                                                  child: SizedBox(
                                                      height: 30,
                                                      width: 50,
                                                      child: Center(
                                                          child: Text(
                                                        "(${value.ceMax})",
                                                        style: const TextStyle(
                                                          fontSize: 15,
                                                        ),
                                                      ))),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  })),
                            ),
                          ));
                    }

///////////////----------------------------------------------------------------------///////////////
//////////////--------------------------     TE MARK  --  PE MARK -------------------///////////////
///////////////----------------------------------------------------------------------///////////////

                    else if (provider.teMax != null &&
                        provider.peMax != null &&
                        provider.ceMax == null) {
                      return LimitedBox(
<<<<<<< HEAD
                          maxHeight: size.height / 1.81,
=======
                          maxHeight: size.height / 1.85,
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: value.studListUAS.length,
                                itemBuilder: ((context, index) {
                                  String pre = 'P';
                                  markfieldController.text = pre;
                                  teMarkController
                                      .add(new TextEditingController());
                                  ceMarkController
                                      .add(new TextEditingController());
                                  practicalMarkController
                                      .add(new TextEditingController());
                                  teMarkController[index].text.isEmpty
                                      ? teMarkController[index].text =
                                          value.studListUAS[index].teMark ==
                                                  null
                                              ? teMarkController[index].text
                                              : value.studListUAS[index].teMark
                                                  .toString()
                                      : teMarkController[index].text;
                                  practicalMarkController[index].text.isEmpty
                                      ? practicalMarkController[index].text =
                                          value.studListUAS[index].peMark ==
                                                  null
                                              ? practicalMarkController[index]
                                                  .text
                                              : value.studListUAS[index].peMark
                                                  .toString()
                                      : practicalMarkController[index].text;

                                  return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      // height: 100,
                                      width: size.width,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: UIGuide.light_Purple,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Row(
                                              children: [
                                                const Text(
                                                  'Roll No: ',
                                                  style: TextStyle(),
                                                ),
                                                value.studListUAS[index]
                                                            .rollNo ==
                                                        null
                                                    ? const Text(
<<<<<<< HEAD
                                                        '',
=======
                                                        '0',
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
                                                        style: TextStyle(
                                                            color: UIGuide
                                                                .light_Purple),
                                                      )
                                                    : Text(
                                                        value.studListUAS[index]
                                                            .rollNo
                                                            .toString(),
                                                        style: const TextStyle(
                                                            color: UIGuide
                                                                .light_Purple),
                                                      ),
                                                const Spacer()
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
                                                    strutStyle:
                                                        const StrutStyle(
                                                            fontSize: 12.0),
                                                    text: TextSpan(
                                                      style: const TextStyle(
                                                          color: UIGuide
                                                              .light_Purple),
                                                      text: value
                                                              .studListUAS[
                                                                  index]
                                                              .studentName ??
                                                          '',
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10.0),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        if (value
                                                                .studListUAS[
                                                                    index]
                                                                .attendance ==
                                                            'A') {
                                                          value
                                                              .studListUAS[
                                                                  index]
                                                              .attendance = 'P';
                                                        } else {
                                                          value
                                                              .studListUAS[
                                                                  index]
                                                              .attendance = 'A';
                                                          value
                                                              .studListUAS[
                                                                  index]
                                                              .teMark = null;

                                                          value
                                                              .studListUAS[
                                                                  index]
                                                              .peMark = null;
                                                          teMarkController[
                                                                  index]
                                                              .clear();
                                                          practicalMarkController[
                                                                  index]
                                                              .clear();
                                                        }
                                                        attendancee = value
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
                                                          child: value
                                                                      .studListUAS[
                                                                          index]
                                                                      .attendance ==
                                                                  'A'
                                                              ? SvgPicture
                                                                  .asset(UIGuide
                                                                      .absent)
                                                              : SvgPicture
                                                                  .asset(UIGuide
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
<<<<<<< HEAD
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      controller:
                                                          teMarkController[
                                                              index],
                                                      //  focusNode: FocusNode(),
                                                      enabled: value
                                                                      .studListUAS[
                                                                          index]
                                                                      .attendance ==
                                                                  'A' ||
                                                              value.examStatusUAS ==
                                                                  'Synchronized'
=======
                                                      controller:
                                                          teMarkController[
                                                              index],
                                                      focusNode: FocusNode(),
                                                      enabled: value
                                                                  .studListUAS[
                                                                      index]
                                                                  .attendance ==
                                                              'A'
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
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
                                                              double.parse(
                                                                  text);
                                                            return newValue;
                                                          } catch (e) {}
                                                          return oldValue;
                                                        }),
                                                        LengthLimitingTextInputFormatter(
                                                            5),
                                                      ],
                                                      decoration:
                                                          InputDecoration(
                                                              focusColor:
                                                                  const Color.fromARGB(
                                                                      255,
                                                                      213,
                                                                      215,
                                                                      218),
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0),
                                                              ),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide: const BorderSide(
                                                                    color: UIGuide
                                                                        .light_Purple,
                                                                    width: 1.0),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0),
                                                              ),
                                                              fillColor:
                                                                  Colors.grey,
                                                              hintStyle:
                                                                  const TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 16,
                                                                fontFamily:
                                                                    "verdana_regular",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                              labelText: value
                                                                      .teCaptionUAS ??
                                                                  "",
                                                              labelStyle: const TextStyle(
                                                                  fontSize: 13,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          106,
                                                                          107,
                                                                          109))),
                                                      onChanged: (value1) {
                                                        teMarkController[index]
                                                            .addListener(() {
                                                          value1;
                                                        });

                                                        teMarkController[index]
                                                                .text
                                                                .isEmpty
                                                            ? value
                                                                .studListUAS[
                                                                    index]
                                                                .teMark = null
                                                            : teMarkController[
                                                                    index]
                                                                .text;

                                                        teMarkController[index]
                                                                .selection =
                                                            TextSelection.collapsed(
                                                                offset:
                                                                    teMarkController[
                                                                            index]
                                                                        .text
                                                                        .length);

                                                        if (double.parse(
                                                                teMarkController[
                                                                        index]
                                                                    .text) >
                                                            double.parse(value
                                                                .teMax
                                                                .toString())) {
                                                          teMarkController[
                                                                  index]
                                                              .clear();
                                                        }
                                                        String resultt =
                                                            teMarkController[
                                                                    index]
                                                                .text;
                                                        value.studListUAS[index]
                                                                .teMark =
                                                            double.tryParse(
                                                                resultt);
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 2.0),
                                                  child: SizedBox(
                                                      height: 30,
                                                      width: 50,
                                                      child: Center(
                                                          child: Text(
                                                        "(${value.teMax})",
                                                        style: const TextStyle(
                                                          fontSize: 15,
                                                        ),
                                                      ))),
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
<<<<<<< HEAD
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      controller:
                                                          practicalMarkController[
                                                              index],
                                                      //  focusNode: FocusNode(),
                                                      enabled: value
                                                                      .studListUAS[
                                                                          index]
                                                                      .attendance ==
                                                                  'A' ||
                                                              value.examStatusUAS ==
                                                                  'Synchronized'
=======
                                                      controller:
                                                          practicalMarkController[
                                                              index],
                                                      focusNode: FocusNode(),
                                                      enabled: value
                                                                  .studListUAS[
                                                                      index]
                                                                  .attendance ==
                                                              'A'
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
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
                                                              double.parse(
                                                                  text);
                                                            return newValue;
                                                          } catch (e) {}
                                                          return oldValue;
                                                        }),
                                                        LengthLimitingTextInputFormatter(
                                                            5),
                                                      ],
                                                      decoration:
                                                          InputDecoration(
                                                              focusColor:
                                                                  const Color.fromARGB(
                                                                      255,
                                                                      213,
                                                                      215,
                                                                      218),
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0),
                                                              ),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide: const BorderSide(
                                                                    color: UIGuide
                                                                        .light_Purple,
                                                                    width: 1.0),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0),
                                                              ),
                                                              fillColor:
                                                                  Colors.grey,
                                                              hintStyle:
                                                                  const TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 16,
                                                                fontFamily:
                                                                    "verdana_regular",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                              labelText: value
                                                                      .peCaptionUAS ??
                                                                  "",
                                                              labelStyle: const TextStyle(
                                                                  fontSize: 13,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          106,
                                                                          107,
                                                                          109))),
                                                      onChanged: (value1) {
                                                        practicalMarkController[
                                                                index]
                                                            .addListener(() {
                                                          value1;
                                                        });

                                                        practicalMarkController[
                                                                    index]
                                                                .text
                                                                .isEmpty
                                                            ? value
                                                                .studListUAS[
                                                                    index]
                                                                .peMark = null
                                                            : practicalMarkController[
                                                                    index]
                                                                .text;

                                                        practicalMarkController[
                                                                    index]
                                                                .selection =
                                                            TextSelection.collapsed(
                                                                offset:
                                                                    practicalMarkController[
                                                                            index]
                                                                        .text
                                                                        .length);

                                                        if (double.parse(
                                                                practicalMarkController[
                                                                        index]
                                                                    .text) >
                                                            double.parse(provider
                                                                .peMax
                                                                .toString())) {
                                                          practicalMarkController[
                                                                  index]
                                                              .clear();
                                                        }

                                                        String resultt =
                                                            practicalMarkController[
                                                                    index]
                                                                .text;
                                                        value.studListUAS[index]
                                                                .peMark =
                                                            double.tryParse(
                                                                resultt);
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 2.0),
                                                  child: SizedBox(
                                                      height: 30,
                                                      width: 50,
                                                      child: Center(
                                                          child: Text(
                                                        "(${value.peMax})",
                                                        style: const TextStyle(
                                                          fontSize: 15,
                                                        ),
                                                      ))),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                })),
                          ));
                    }

///////////////----------------------------------------------------------------------///////////////
//////////////--------------------------     TE MARK  --  CE MARK -------------------///////////////
///////////////----------------------------------------------------------------------///////////////

                    else if (provider.teMax != null &&
                        provider.ceMax != null &&
                        provider.peMax == null) {
                      return LimitedBox(
<<<<<<< HEAD
                          maxHeight: size.height / 1.81,
=======
                          maxHeight: size.height / 1.85,
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: value.studListUAS.length,
                                itemBuilder: ((context, index) {
                                  String pre = 'P';
                                  markfieldController.text = pre;
                                  teMarkController
                                      .add(new TextEditingController());
                                  ceMarkController
                                      .add(new TextEditingController());
                                  practicalMarkController
                                      .add(new TextEditingController());

                                  teMarkController[index].text.isEmpty
                                      ? teMarkController[index].text =
                                          value.studListUAS[index].teMark ==
                                                  null
                                              ? teMarkController[index].text
                                              : value.studListUAS[index].teMark
                                                  .toString()
                                      : teMarkController[index].text;

                                  ceMarkController[index].text.isEmpty
                                      ? ceMarkController[index].text =
                                          value.studListUAS[index].ceMark ==
                                                  null
                                              ? ceMarkController[index].text
                                              : value.studListUAS[index].ceMark
                                                  .toString()
                                      : ceMarkController[index].text;

                                  return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      // height: 100,
                                      width: size.width,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: UIGuide.light_Purple,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Row(
                                              children: [
                                                const Text(
                                                  'Roll No: ',
                                                  style: TextStyle(),
                                                ),
                                                value.studListUAS[index]
                                                            .rollNo ==
                                                        null
                                                    ? const Text(
<<<<<<< HEAD
                                                        '',
=======
                                                        '0',
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
                                                        style: TextStyle(
                                                            color: UIGuide
                                                                .light_Purple),
                                                      )
                                                    : Text(
                                                        value.studListUAS[index]
                                                            .rollNo
                                                            .toString(),
                                                        style: const TextStyle(
                                                            color: UIGuide
                                                                .light_Purple),
                                                      ),
                                                const Spacer()
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
                                                    strutStyle:
                                                        const StrutStyle(
                                                            fontSize: 12.0),
                                                    text: TextSpan(
                                                      style: const TextStyle(
                                                          color: UIGuide
                                                              .light_Purple),
                                                      text: value
                                                              .studListUAS[
                                                                  index]
                                                              .studentName ??
                                                          '',
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10.0),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        if (value
                                                                .studListUAS[
                                                                    index]
                                                                .attendance ==
                                                            'A') {
                                                          value
                                                              .studListUAS[
                                                                  index]
                                                              .attendance = 'P';
                                                        } else {
                                                          value
                                                              .studListUAS[
                                                                  index]
                                                              .attendance = 'A';

                                                          value
                                                              .studListUAS[
                                                                  index]
                                                              .teMark = null;
                                                          value
                                                              .studListUAS[
                                                                  index]
                                                              .ceMark = null;

                                                          teMarkController[
                                                                  index]
                                                              .clear();
                                                          ceMarkController[
                                                                  index]
                                                              .clear();
                                                        }
                                                        attendancee = value
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
                                                          child: value
                                                                      .studListUAS[
                                                                          index]
                                                                      .attendance ==
                                                                  'A'
                                                              ? SvgPicture
                                                                  .asset(UIGuide
                                                                      .absent)
                                                              : SvgPicture
                                                                  .asset(UIGuide
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
<<<<<<< HEAD
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      controller:
                                                          teMarkController[
                                                              index],
                                                      // focusNode: FocusNode(),
                                                      enabled: value
                                                                      .studListUAS[
                                                                          index]
                                                                      .attendance ==
                                                                  'A' ||
                                                              value.examStatusUAS ==
                                                                  'Synchronized'
=======
                                                      controller:
                                                          teMarkController[
                                                              index],
                                                      focusNode: FocusNode(),
                                                      enabled: value
                                                                  .studListUAS[
                                                                      index]
                                                                  .attendance ==
                                                              'A'
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
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
                                                              double.parse(
                                                                  text);
                                                            return newValue;
                                                          } catch (e) {}
                                                          return oldValue;
                                                        }),
                                                        LengthLimitingTextInputFormatter(
                                                            5),
                                                      ],
                                                      decoration:
                                                          InputDecoration(
                                                              focusColor:
                                                                  const Color.fromARGB(
                                                                      255,
                                                                      213,
                                                                      215,
                                                                      218),
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0),
                                                              ),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide: const BorderSide(
                                                                    color: UIGuide
                                                                        .light_Purple,
                                                                    width: 1.0),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0),
                                                              ),
                                                              fillColor:
                                                                  Colors.grey,
                                                              hintStyle:
                                                                  const TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 16,
                                                                fontFamily:
                                                                    "verdana_regular",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                              labelText: value
                                                                      .teCaptionUAS ??
                                                                  "",
                                                              labelStyle: const TextStyle(
                                                                  fontSize: 13,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          106,
                                                                          107,
                                                                          109))),
                                                      onChanged: (value1) {
                                                        teMarkController[index]
                                                            .addListener(() {
                                                          value1;
                                                        });

                                                        teMarkController[index]
                                                                .text
                                                                .isEmpty
                                                            ? value
                                                                .studListUAS[
                                                                    index]
                                                                .teMark = null
                                                            : teMarkController[
                                                                    index]
                                                                .text;

                                                        teMarkController[index]
                                                                .selection =
                                                            TextSelection.collapsed(
                                                                offset:
                                                                    teMarkController[
                                                                            index]
                                                                        .text
                                                                        .length);

                                                        if (double.parse(
                                                                teMarkController[
                                                                        index]
                                                                    .text) >
                                                            double.parse(provider
                                                                .teMax
                                                                .toString())) {
                                                          teMarkController[
                                                                  index]
                                                              .clear();
                                                        }
                                                        String resultt =
                                                            teMarkController[
                                                                    index]
                                                                .text;
                                                        value.studListUAS[index]
                                                                .teMark =
                                                            double.tryParse(
                                                                resultt);
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 2.0),
                                                  child: SizedBox(
                                                      height: 30,
                                                      width: 50,
                                                      child: Center(
                                                          child: Text(
                                                        "(${value.teMax ?? ""})",
                                                        style: const TextStyle(
                                                          fontSize: 15,
                                                        ),
                                                      ))),
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
<<<<<<< HEAD
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      controller:
                                                          ceMarkController[
                                                              index],
                                                      //   focusNode: FocusNode(),
                                                      enabled: value
                                                                      .studListUAS[
                                                                          index]
                                                                      .attendance ==
                                                                  'A' ||
                                                              value.examStatusUAS ==
                                                                  'Synchronized'
=======
                                                      controller:
                                                          ceMarkController[
                                                              index],
                                                      focusNode: FocusNode(),
                                                      enabled: value
                                                                  .studListUAS[
                                                                      index]
                                                                  .attendance ==
                                                              'A'
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
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
                                                              double.parse(
                                                                  text);
                                                            return newValue;
                                                          } catch (e) {}
                                                          return oldValue;
                                                        }),
                                                        LengthLimitingTextInputFormatter(
                                                            5),
                                                      ],
                                                      decoration:
                                                          InputDecoration(
                                                              focusColor:
                                                                  const Color.fromARGB(
                                                                      255,
                                                                      213,
                                                                      215,
                                                                      218),
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0),
                                                              ),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide: const BorderSide(
                                                                    color: UIGuide
                                                                        .light_Purple,
                                                                    width: 1.0),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0),
                                                              ),
                                                              fillColor:
                                                                  Colors.grey,
                                                              hintStyle:
                                                                  const TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 16,
                                                                fontFamily:
                                                                    "verdana_regular",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                              labelText: value
                                                                      .ceCaptionUAS ??
                                                                  "",
                                                              labelStyle: const TextStyle(
                                                                  fontSize: 13,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          106,
                                                                          107,
                                                                          109))),
                                                      onChanged: (value1) {
                                                        ceMarkController[index]
                                                            .addListener(() {
                                                          value1;
                                                        });

                                                        ceMarkController[index]
                                                                .text
                                                                .isEmpty
                                                            ? value
                                                                .studListUAS[
                                                                    index]
                                                                .ceMark = null
                                                            : ceMarkController[
                                                                    index]
                                                                .text;

                                                        ceMarkController[index]
                                                                .selection =
                                                            TextSelection.collapsed(
                                                                offset:
                                                                    ceMarkController[
                                                                            index]
                                                                        .text
                                                                        .length);

                                                        if (double.parse(
                                                                ceMarkController[
                                                                        index]
                                                                    .text) >
                                                            double.parse(provider
                                                                .ceMax
                                                                .toString())) {
                                                          ceMarkController[
                                                                  index]
                                                              .clear();
                                                        }
                                                        String resultt =
                                                            ceMarkController[
                                                                    index]
                                                                .text;
                                                        value.studListUAS[index]
                                                                .ceMark =
                                                            double.tryParse(
                                                                resultt);
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 2.0),
                                                  child: SizedBox(
                                                      height: 30,
                                                      width: 50,
                                                      child: Center(
                                                          child: Text(
                                                        "(${value.ceMax ?? ""})",
                                                        style: const TextStyle(
                                                          fontSize: 15,
                                                        ),
                                                      ))),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                })),
                          ));
                    }

///////////////----------------------------------------------------------------------///////////////
//////////////--------------------------     PE MARK  --  CE MARK -------------------///////////////
///////////////----------------------------------------------------------------------///////////////

                    else if (provider.ceMax != null &&
                        provider.peMax != null &&
                        provider.teMax == null) {
                      return LimitedBox(
<<<<<<< HEAD
                          maxHeight: size.height / 1.81,
=======
                          maxHeight: size.height / 1.85,
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: value.studListUAS.length,
                                itemBuilder: ((context, index) {
                                  String pre = 'P';
                                  markfieldController.text = pre;

                                  teMarkController
                                      .add(new TextEditingController());
                                  ceMarkController
                                      .add(new TextEditingController());
                                  practicalMarkController
                                      .add(new TextEditingController());

                                  practicalMarkController[index].text.isEmpty
                                      ? practicalMarkController[index].text =
                                          value.studListUAS[index].peMark ==
                                                  null
                                              ? practicalMarkController[index]
                                                  .text
                                              : value.studListUAS[index].peMark
                                                  .toString()
                                      : practicalMarkController[index].text;

                                  ceMarkController[index].text.isEmpty
                                      ? ceMarkController[index].text =
                                          value.studListUAS[index].ceMark ==
                                                  null
                                              ? ceMarkController[index].text
                                              : value.studListUAS[index].ceMark
                                                  .toString()
                                      : ceMarkController[index].text;

                                  return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      // height: 100,
                                      width: size.width,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: UIGuide.light_Purple,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Row(
                                              children: [
                                                const Text(
                                                  'Roll No: ',
                                                  style: TextStyle(),
                                                ),
                                                value.studListUAS[index]
                                                            .rollNo ==
                                                        null
                                                    ? const Text(
<<<<<<< HEAD
                                                        '',
=======
                                                        '0',
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
                                                        style: TextStyle(
                                                            color: UIGuide
                                                                .light_Purple),
                                                      )
                                                    : Text(
                                                        value.studListUAS[index]
                                                            .rollNo
                                                            .toString(),
                                                        style: const TextStyle(
                                                            color: UIGuide
                                                                .light_Purple),
                                                      ),
                                                const Spacer()
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
                                                    strutStyle:
                                                        const StrutStyle(
                                                            fontSize: 12.0),
                                                    text: TextSpan(
                                                      style: const TextStyle(
                                                          color: UIGuide
                                                              .light_Purple),
                                                      text: value
                                                              .studListUAS[
                                                                  index]
                                                              .studentName ??
                                                          "",
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10.0),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        if (value
                                                                .studListUAS[
                                                                    index]
                                                                .attendance ==
                                                            'A') {
                                                          value
                                                              .studListUAS[
                                                                  index]
                                                              .attendance = 'P';
                                                        } else {
                                                          value
                                                              .studListUAS[
                                                                  index]
                                                              .attendance = 'A';

                                                          value
                                                              .studListUAS[
                                                                  index]
                                                              .ceMark = null;
                                                          value
                                                              .studListUAS[
                                                                  index]
                                                              .peMark = null;
                                                          ceMarkController[
                                                                  index]
                                                              .clear();
                                                          practicalMarkController[
                                                                  index]
                                                              .clear();
                                                        }
                                                        attendancee = value
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
                                                          child: value
                                                                      .studListUAS[
                                                                          index]
                                                                      .attendance ==
                                                                  'A'
                                                              ? SvgPicture
                                                                  .asset(UIGuide
                                                                      .absent)
                                                              : SvgPicture
                                                                  .asset(UIGuide
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
<<<<<<< HEAD
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      controller:
                                                          practicalMarkController[
                                                              index],
                                                      //  focusNode: FocusNode(),
                                                      enabled: value
                                                                      .studListUAS[
                                                                          index]
                                                                      .attendance ==
                                                                  'A' ||
                                                              value.examStatusUAS ==
                                                                  'Synchronized'
=======
                                                      controller:
                                                          practicalMarkController[
                                                              index],
                                                      focusNode: FocusNode(),
                                                      enabled: value
                                                                  .studListUAS[
                                                                      index]
                                                                  .attendance ==
                                                              'A'
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
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
                                                              double.parse(
                                                                  text);
                                                            return newValue;
                                                          } catch (e) {}
                                                          return oldValue;
                                                        }),
                                                        LengthLimitingTextInputFormatter(
                                                            5),
                                                      ],
                                                      decoration:
                                                          InputDecoration(
                                                              focusColor:
                                                                  const Color.fromARGB(
                                                                      255,
                                                                      213,
                                                                      215,
                                                                      218),
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0),
                                                              ),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide: const BorderSide(
                                                                    color: UIGuide
                                                                        .light_Purple,
                                                                    width: 1.0),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0),
                                                              ),
                                                              fillColor:
                                                                  Colors.grey,
                                                              hintStyle:
                                                                  const TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 16,
                                                                fontFamily:
                                                                    "verdana_regular",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                              labelText: value
                                                                      .peCaptionUAS ??
                                                                  "",
                                                              labelStyle: const TextStyle(
                                                                  fontSize: 13,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          106,
                                                                          107,
                                                                          109))),
                                                      onChanged: (value1) {
                                                        practicalMarkController[
                                                                index]
                                                            .addListener(() {
                                                          value1;
                                                        });

                                                        practicalMarkController[
                                                                    index]
                                                                .text
                                                                .isEmpty
                                                            ? value
                                                                .studListUAS[
                                                                    index]
                                                                .peMark = null
                                                            : practicalMarkController[
                                                                    index]
                                                                .text;

                                                        practicalMarkController[
                                                                    index]
                                                                .selection =
                                                            TextSelection.collapsed(
                                                                offset:
                                                                    practicalMarkController[
                                                                            index]
                                                                        .text
                                                                        .length);

                                                        if (double.parse(
                                                                practicalMarkController[
                                                                        index]
                                                                    .text) >
                                                            double.parse(provider
                                                                .peMax
                                                                .toString())) {
                                                          practicalMarkController[
                                                                  index]
                                                              .clear();
                                                        }
                                                        String resultt =
                                                            practicalMarkController[
                                                                    index]
                                                                .text;
                                                        value.studListUAS[index]
                                                                .peMark =
                                                            double.tryParse(
                                                                resultt);
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 2.0),
                                                  child: SizedBox(
                                                      height: 30,
                                                      width: 50,
                                                      child: Center(
                                                          child: Text(
                                                        "(${value.peMax ?? ''})",
                                                        style: const TextStyle(
                                                          fontSize: 15,
                                                        ),
                                                      ))),
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
<<<<<<< HEAD
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      controller:
                                                          ceMarkController[
                                                              index],
                                                      //  focusNode: FocusNode(),
                                                      enabled: value
                                                                      .studListUAS[
                                                                          index]
                                                                      .attendance ==
                                                                  'A' ||
                                                              value.examStatusUAS ==
                                                                  'Synchronized'
=======
                                                      controller:
                                                          ceMarkController[
                                                              index],
                                                      focusNode: FocusNode(),
                                                      enabled: value
                                                                  .studListUAS[
                                                                      index]
                                                                  .attendance ==
                                                              'A'
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
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
                                                              double.parse(
                                                                  text);
                                                            return newValue;
                                                          } catch (e) {}
                                                          return oldValue;
                                                        }),
                                                        LengthLimitingTextInputFormatter(
                                                            5),
                                                      ],
                                                      decoration:
                                                          InputDecoration(
                                                              focusColor:
                                                                  const Color.fromARGB(
                                                                      255,
                                                                      213,
                                                                      215,
                                                                      218),
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0),
                                                              ),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide: const BorderSide(
                                                                    color: UIGuide
                                                                        .light_Purple,
                                                                    width: 1.0),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0),
                                                              ),
                                                              fillColor:
                                                                  Colors.grey,
                                                              hintStyle:
                                                                  const TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 16,
                                                                fontFamily:
                                                                    "verdana_regular",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                              labelText: value
                                                                      .ceCaptionUAS ??
                                                                  "",
                                                              labelStyle: const TextStyle(
                                                                  fontSize: 13,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          106,
                                                                          107,
                                                                          109))),
                                                      onChanged: (value1) {
                                                        ceMarkController[index]
                                                            .addListener(() {
                                                          value1;
                                                        });

                                                        ceMarkController[index]
                                                                .text
                                                                .isEmpty
                                                            ? value
                                                                .studListUAS[
                                                                    index]
                                                                .ceMark = null
                                                            : ceMarkController[
                                                                    index]
                                                                .text;

                                                        ceMarkController[index]
                                                                .selection =
                                                            TextSelection.collapsed(
                                                                offset:
                                                                    ceMarkController[
                                                                            index]
                                                                        .text
                                                                        .length);

                                                        if (double.parse(
                                                                ceMarkController[
                                                                        index]
                                                                    .text) >
                                                            double.parse(provider
                                                                .ceMax
                                                                .toString())) {
                                                          ceMarkController[
                                                                  index]
                                                              .clear();
                                                        }
                                                        String resultt =
                                                            ceMarkController[
                                                                    index]
                                                                .text;
                                                        value.studListUAS[index]
                                                                .ceMark =
                                                            double.tryParse(
                                                                resultt);
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 2.0),
                                                  child: SizedBox(
                                                      height: 30,
                                                      width: 50,
                                                      child: Center(
                                                          child: Text(
                                                        "(${value.ceMax ?? ""})",
                                                        style: const TextStyle(
                                                          fontSize: 15,
                                                        ),
                                                      ))),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                })),
                          ));
                    }
///////////////----------------------------------------------------------------------///////////////
///////////////-----------------------     TE MARK  --------------------------------///////////////
///////////////--------------------------------------------------------------------///////////////

                    else if (provider.teMax != null &&
                        provider.peMax == null &&
                        provider.ceMax == null) {
                      return LimitedBox(
<<<<<<< HEAD
                          maxHeight: size.height / 1.81,
=======
                          maxHeight: size.height / 1.85,
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: value.studListUAS.length,
                                itemBuilder: ((context, index) {
                                  String pre = 'P';
                                  markfieldController.text = pre;
                                  teMarkController
                                      .add(new TextEditingController());
                                  ceMarkController
                                      .add(new TextEditingController());
                                  practicalMarkController
                                      .add(new TextEditingController());
                                  teMarkController[index].text.isEmpty
                                      ? teMarkController[index].text =
                                          value.studListUAS[index].teMark ==
                                                  null
                                              ? teMarkController[index].text
                                              : value.studListUAS[index].teMark
                                                  .toString()
                                      : teMarkController[index].text;

                                  return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      // height: 100,
                                      width: size.width,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: UIGuide.light_Purple,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Row(
                                              children: [
                                                const Text(
                                                  'Roll No: ',
                                                  style: TextStyle(),
                                                ),
                                                value.studListUAS[index]
                                                            .rollNo ==
                                                        null
                                                    ? const Text(
<<<<<<< HEAD
                                                        '',
=======
                                                        '0',
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
                                                        style: TextStyle(
                                                            color: UIGuide
                                                                .light_Purple),
                                                      )
                                                    : Text(
                                                        value.studListUAS[index]
                                                            .rollNo
                                                            .toString(),
                                                        style: const TextStyle(
                                                            color: UIGuide
                                                                .light_Purple),
                                                      ),
                                                const Spacer()
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
                                                    strutStyle:
                                                        const StrutStyle(
                                                            fontSize: 12.0),
                                                    text: TextSpan(
                                                      style: const TextStyle(
                                                          color: UIGuide
                                                              .light_Purple),
                                                      text: value
                                                              .studListUAS[
                                                                  index]
                                                              .studentName ??
                                                          "",
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10.0),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        if (value
                                                                .studListUAS[
                                                                    index]
                                                                .attendance ==
                                                            'A') {
                                                          value
                                                              .studListUAS[
                                                                  index]
                                                              .attendance = 'P';
                                                        } else {
                                                          value
                                                              .studListUAS[
                                                                  index]
                                                              .attendance = 'A';
                                                          value
                                                              .studListUAS[
                                                                  index]
                                                              .teMark = null;

                                                          teMarkController[
                                                                  index]
                                                              .clear();
                                                        }
                                                        attendancee = value
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
                                                          child: value
                                                                      .studListUAS[
                                                                          index]
                                                                      .attendance ==
                                                                  'A'
                                                              ? SvgPicture
                                                                  .asset(UIGuide
                                                                      .absent)
                                                              : SvgPicture
                                                                  .asset(UIGuide
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
<<<<<<< HEAD
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      controller:
                                                          teMarkController[
                                                              index],
                                                      // focusNode: FocusNode(),
                                                      enabled: value
                                                                      .studListUAS[
                                                                          index]
                                                                      .attendance ==
                                                                  'A' ||
                                                              value.examStatusUAS ==
                                                                  'Synchronized'
=======
                                                      controller:
                                                          teMarkController[
                                                              index],
                                                      focusNode: FocusNode(),
                                                      enabled: value
                                                                  .studListUAS[
                                                                      index]
                                                                  .attendance ==
                                                              'A'
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
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
                                                              double.parse(
                                                                  text);
                                                            return newValue;
                                                          } catch (e) {}
                                                          return oldValue;
                                                        }),
                                                        LengthLimitingTextInputFormatter(
                                                            5),
                                                      ],
                                                      decoration:
                                                          InputDecoration(
                                                              focusColor:
                                                                  const Color.fromARGB(
                                                                      255,
                                                                      213,
                                                                      215,
                                                                      218),
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0),
                                                              ),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide: const BorderSide(
                                                                    color: UIGuide
                                                                        .light_Purple,
                                                                    width: 1.0),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0),
                                                              ),
                                                              fillColor:
                                                                  Colors.grey,
                                                              hintStyle:
                                                                  const TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 16,
                                                                fontFamily:
                                                                    "verdana_regular",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                              labelText: value
                                                                      .teCaptionUAS ??
                                                                  "",
                                                              labelStyle: const TextStyle(
                                                                  fontSize: 13,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          106,
                                                                          107,
                                                                          109))),
                                                      onChanged: (value1) {
                                                        teMarkController[index]
                                                            .addListener(() {
                                                          value1;
                                                        });

                                                        teMarkController[index]
                                                                .text
                                                                .isEmpty
                                                            ? value
                                                                .studListUAS[
                                                                    index]
                                                                .teMark = null
                                                            : teMarkController[
                                                                    index]
                                                                .text;
                                                        teMarkController[index]
                                                                .selection =
                                                            TextSelection.collapsed(
                                                                offset:
                                                                    teMarkController[
                                                                            index]
                                                                        .text
                                                                        .length);

                                                        if (double.parse(
                                                                teMarkController[
                                                                        index]
                                                                    .text) >
                                                            double.parse(provider
                                                                .teMax
                                                                .toString())) {
                                                          teMarkController[
                                                                  index]
                                                              .clear();
                                                        }
                                                        String resultt =
                                                            teMarkController[
                                                                    index]
                                                                .text;
                                                        value.studListUAS[index]
                                                                .teMark =
                                                            double.tryParse(
                                                                resultt);
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 2.0),
                                                  child: SizedBox(
                                                      height: 30,
                                                      width: 50,
                                                      child: Center(
                                                          child: Text(
                                                        "(${value.teMax ?? ""})",
                                                        style: const TextStyle(
                                                          fontSize: 15,
                                                        ),
                                                      ))),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                })),
                          ));
                    }
///////////////----------------------------------------------------------------------///////////////
///////////////-----------------------     PE MARK  ---------------------------------///////////////
///////////////----------------------------------------------------------------------///////////////

                    else if (provider.teMax == null &&
                        provider.peMax != null &&
                        provider.ceMax == null) {
                      return LimitedBox(
<<<<<<< HEAD
                          maxHeight: size.height / 1.81,
=======
                          maxHeight: size.height / 1.85,
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: value.studListUAS.length,
                                itemBuilder: ((context, index) {
                                  String pre = 'P';
                                  markfieldController.text = pre;

                                  teMarkController
                                      .add(new TextEditingController());
                                  ceMarkController
                                      .add(new TextEditingController());
                                  practicalMarkController
                                      .add(new TextEditingController());
                                  practicalMarkController[index].text.isEmpty
                                      ? practicalMarkController[index].text =
                                          value.studListUAS[index].peMark ==
                                                  null
                                              ? practicalMarkController[index]
                                                  .text
                                              : value.studListUAS[index].peMark
                                                  .toString()
                                      : practicalMarkController[index].text;

                                  return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      // height: 100,
                                      width: size.width,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: UIGuide.light_Purple,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Row(
                                              children: [
                                                const Text(
                                                  'Roll No: ',
                                                  style: TextStyle(),
                                                ),
                                                value.studListUAS[index]
                                                            .rollNo ==
                                                        null
                                                    ? const Text(
<<<<<<< HEAD
                                                        '',
=======
                                                        '0',
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
                                                        style: TextStyle(
                                                            color: UIGuide
                                                                .light_Purple),
                                                      )
                                                    : Text(
                                                        value.studListUAS[index]
                                                            .rollNo
                                                            .toString(),
                                                        style: const TextStyle(
                                                            color: UIGuide
                                                                .light_Purple),
                                                      ),
                                                const Spacer()
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
                                                    strutStyle:
                                                        const StrutStyle(
                                                            fontSize: 12.0),
                                                    text: TextSpan(
                                                      style: const TextStyle(
                                                          color: UIGuide
                                                              .light_Purple),
                                                      text: value
                                                              .studListUAS[
                                                                  index]
                                                              .studentName ??
                                                          "",
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10.0),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        if (value
                                                                .studListUAS[
                                                                    index]
                                                                .attendance ==
                                                            'A') {
                                                          value
                                                              .studListUAS[
                                                                  index]
                                                              .attendance = 'P';
                                                        } else {
                                                          value
                                                              .studListUAS[
                                                                  index]
                                                              .attendance = 'A';

                                                          value
                                                              .studListUAS[
                                                                  index]
                                                              .peMark = null;
                                                          practicalMarkController[
                                                                  index]
                                                              .clear();
                                                        }
                                                        attendancee = value
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
                                                          child: value
                                                                      .studListUAS[
                                                                          index]
                                                                      .attendance ==
                                                                  'A'
                                                              ? SvgPicture
                                                                  .asset(UIGuide
                                                                      .absent)
                                                              : SvgPicture
                                                                  .asset(UIGuide
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
<<<<<<< HEAD
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      controller:
                                                          practicalMarkController[
                                                              index],
                                                      //  focusNode: FocusNode(),
                                                      enabled: value
                                                                      .studListUAS[
                                                                          index]
                                                                      .attendance ==
                                                                  'A' ||
                                                              value.examStatusUAS ==
                                                                  'Synchronized'
=======
                                                      controller:
                                                          practicalMarkController[
                                                              index],
                                                      focusNode: FocusNode(),
                                                      enabled: value
                                                                  .studListUAS[
                                                                      index]
                                                                  .attendance ==
                                                              'A'
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
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
                                                              double.parse(
                                                                  text);
                                                            return newValue;
                                                          } catch (e) {}
                                                          return oldValue;
                                                        }),
                                                        LengthLimitingTextInputFormatter(
                                                            5),
                                                      ],
                                                      decoration:
                                                          InputDecoration(
                                                              focusColor:
                                                                  const Color.fromARGB(
                                                                      255,
                                                                      213,
                                                                      215,
                                                                      218),
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0),
                                                              ),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide: const BorderSide(
                                                                    color: UIGuide
                                                                        .light_Purple,
                                                                    width: 1.0),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0),
                                                              ),
                                                              fillColor:
                                                                  Colors.grey,
                                                              hintStyle:
                                                                  const TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 16,
                                                                fontFamily:
                                                                    "verdana_regular",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                              labelText: value
                                                                      .peCaptionUAS ??
                                                                  "",
                                                              labelStyle: const TextStyle(
                                                                  fontSize: 13,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          106,
                                                                          107,
                                                                          109))),
                                                      onChanged: (value1) {
                                                        practicalMarkController[
                                                                index]
                                                            .addListener(() {
                                                          value1;
                                                        });

                                                        practicalMarkController[
                                                                    index]
                                                                .text
                                                                .isEmpty
                                                            ? value
                                                                .studListUAS[
                                                                    index]
                                                                .peMark = null
                                                            : practicalMarkController[
                                                                    index]
                                                                .text;

                                                        practicalMarkController[
                                                                    index]
                                                                .selection =
                                                            TextSelection.collapsed(
                                                                offset:
                                                                    practicalMarkController[
                                                                            index]
                                                                        .text
                                                                        .length);

                                                        if (double.parse(
                                                                practicalMarkController[
                                                                        index]
                                                                    .text) >
                                                            double.parse(provider
                                                                .peMax
                                                                .toString())) {
                                                          practicalMarkController[
                                                                  index]
                                                              .clear();
                                                        }
                                                        String resultt =
                                                            practicalMarkController[
                                                                    index]
                                                                .text;
                                                        value.studListUAS[index]
                                                                .peMark =
                                                            double.tryParse(
                                                                resultt);
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 2.0),
                                                  child: SizedBox(
                                                      height: 30,
                                                      width: 50,
                                                      child: Center(
                                                          child: Text(
                                                        "(${value.peMax ?? ""})",
                                                        style: const TextStyle(
                                                          fontSize: 15,
                                                        ),
                                                      ))),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                })),
                          ));
                    }
///////////////----------------------------------------------------------------------///////////////
///////////////-----------------------     CE MARK  ---------------------------------///////////////
///////////////----------------------------------------------------------------------///////////////

                    else if (provider.teMax == null &&
                        provider.peMax == null &&
                        provider.ceMax != null) {
                      return LimitedBox(
<<<<<<< HEAD
                          maxHeight: size.height / 1.81,
=======
                          maxHeight: size.height / 1.85,
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: value.studListUAS.length,
                                itemBuilder: ((context, index) {
                                  String pre = 'P';
                                  markfieldController.text = pre;

                                  teMarkController
                                      .add(new TextEditingController());
                                  ceMarkController
                                      .add(new TextEditingController());
                                  practicalMarkController
                                      .add(new TextEditingController());

                                  ceMarkController[index].text.isEmpty
                                      ? ceMarkController[index].text =
                                          value.studListUAS[index].ceMark ==
                                                  null
                                              ? ceMarkController[index].text
                                              : value.studListUAS[index].ceMark
                                                  .toString()
                                      : ceMarkController[index].text;

                                  return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      // height: 100,
                                      width: size.width,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: UIGuide.light_Purple,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Row(
                                              children: [
                                                const Text(
                                                  'Roll No: ',
                                                  style: TextStyle(),
                                                ),
                                                value.studListUAS[index]
                                                            .rollNo ==
                                                        null
                                                    ? const Text(
<<<<<<< HEAD
                                                        '',
=======
                                                        '0',
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
                                                        style: TextStyle(
                                                            color: UIGuide
                                                                .light_Purple),
                                                      )
                                                    : Text(
                                                        value.studListUAS[index]
                                                            .rollNo
                                                            .toString(),
                                                        style: const TextStyle(
                                                            color: UIGuide
                                                                .light_Purple),
                                                      ),
                                                const Spacer()
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
                                                    strutStyle:
                                                        const StrutStyle(
                                                            fontSize: 12.0),
                                                    text: TextSpan(
                                                      style: const TextStyle(
                                                          color: UIGuide
                                                              .light_Purple),
                                                      text: value
                                                              .studListUAS[
                                                                  index]
                                                              .studentName ??
                                                          "",
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10.0),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        if (value
                                                                .studListUAS[
                                                                    index]
                                                                .attendance ==
                                                            'A') {
                                                          value
                                                              .studListUAS[
                                                                  index]
                                                              .attendance = 'P';
                                                        } else {
                                                          value
                                                              .studListUAS[
                                                                  index]
                                                              .attendance = 'A';

                                                          value
                                                              .studListUAS[
                                                                  index]
                                                              .ceMark = null;

                                                          ceMarkController
                                                              .clear();
                                                        }
                                                        attendancee = value
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
                                                          child: value
                                                                      .studListUAS[
                                                                          index]
                                                                      .attendance ==
                                                                  'A'
                                                              ? SvgPicture
                                                                  .asset(UIGuide
                                                                      .absent)
                                                              : SvgPicture
                                                                  .asset(UIGuide
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
<<<<<<< HEAD
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      controller:
                                                          ceMarkController[
                                                              index],
                                                      //  focusNode: FocusNode(),
                                                      enabled: value
                                                                      .studListUAS[
                                                                          index]
                                                                      .attendance ==
                                                                  'A' ||
                                                              value.examStatusUAS ==
                                                                  'Synchronized'
=======
                                                      controller:
                                                          ceMarkController[
                                                              index],
                                                      focusNode: FocusNode(),
                                                      enabled: value
                                                                  .studListUAS[
                                                                      index]
                                                                  .attendance ==
                                                              'A'
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
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
                                                              double.parse(
                                                                  text);
                                                            return newValue;
                                                          } catch (e) {}
                                                          return oldValue;
                                                        }),
                                                        LengthLimitingTextInputFormatter(
                                                            5),
                                                      ],
                                                      decoration:
                                                          InputDecoration(
                                                              focusColor:
                                                                  const Color.fromARGB(
                                                                      255,
                                                                      213,
                                                                      215,
                                                                      218),
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0),
                                                              ),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide: const BorderSide(
                                                                    color: UIGuide
                                                                        .light_Purple,
                                                                    width: 1.0),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0),
                                                              ),
                                                              fillColor:
                                                                  Colors.grey,
                                                              hintStyle:
                                                                  const TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 16,
                                                                fontFamily:
                                                                    "verdana_regular",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                              labelText: value
                                                                      .ceCaptionUAS ??
                                                                  "",
                                                              labelStyle: const TextStyle(
                                                                  fontSize: 13,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          106,
                                                                          107,
                                                                          109))),
                                                      onChanged: (value1) {
                                                        ceMarkController[index]
                                                            .addListener(() {
                                                          value1;
                                                        });

                                                        ceMarkController[index]
                                                                .text
                                                                .isEmpty
                                                            ? value
                                                                .studListUAS[
                                                                    index]
                                                                .ceMark = null
                                                            : ceMarkController[
                                                                    index]
                                                                .text;

                                                        ceMarkController[index]
                                                                .selection =
                                                            TextSelection.collapsed(
                                                                offset:
                                                                    ceMarkController[
                                                                            index]
                                                                        .text
                                                                        .length);

                                                        if (double.parse(
                                                                ceMarkController[
                                                                        index]
                                                                    .text) >
                                                            double.parse(provider
                                                                .ceMax
                                                                .toString())) {
                                                          ceMarkController[
                                                                  index]
                                                              .clear();
                                                        }
                                                        String resultt =
                                                            ceMarkController[
                                                                    index]
                                                                .text;
                                                        value.studListUAS[index]
                                                                .ceMark =
                                                            double.tryParse(
                                                                resultt);
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 2.0),
                                                  child: SizedBox(
                                                      height: 30,
                                                      width: 50,
                                                      child: Center(
                                                          child: Text(
                                                        "(${value.ceMax ?? ""})",
                                                        style: const TextStyle(
                                                          fontSize: 15,
                                                        ),
                                                      ))),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                })),
                          ));
                    } else {
                      return Container(
                        height: 0,
                        width: 0,
                      );
                    }
                  }
////-----------    ----------    ---------    ----------    ---------     ----------    ---------
////-----------    ----------     STATE TABULATION  ---------        -----------        ---------
////-----------    ----------    ---------    ----------    ---------     ----------    ---------

                  else if (provider.tabulationTypeCode == "STATE" &&
                      provider.entryMethodUAS == "Grade") {
///////////////-------------------------------------------------------------------------------------///////////////
///////////////-----------------------     TE Grade  --  PE Grade --  CE Grade  -------------------///////////////
///////////////-----------------------------------------------------------------------------------///////////////
                    if (provider.teCaptionUAS != null &&
                        provider.peCaptionUAS != null &&
                        provider.ceCaptionUAS != null) {
                      return LimitedBox(
<<<<<<< HEAD
                          maxHeight: size.height / 1.81,
=======
                          maxHeight: size.height / 1.85,
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: value.studListUAS.length,
                                itemBuilder: ((context, index) {
                                  //TE Grade
                                  teGradeController
                                      .add(TextEditingController());
                                  teGradeController1
                                      .add(TextEditingController());

                                  teGradeController1[index].text.isEmpty
                                      ? teGradeController1[index].text =
                                          value.studListUAS[index].teGrade ==
                                                  null
                                              ? teGradeController1[index].text
                                              : value.studListUAS[index].teGrade
                                                  .toString()
                                      : teGradeController1[index].text;
                                  teGradeController[index].text.isEmpty
                                      ? teGradeController[index].text =
                                          value.studListUAS[index].teGrade ==
                                                  null
                                              ? teGradeController[index].text
                                              : value.studListUAS[index].teGrade
                                                  .toString()
                                      : teGradeController[index].text;

                                  //Practical Grade
                                  praticalGradeController
                                      .add(TextEditingController());
                                  praticalGradeController1
                                      .add(TextEditingController());

                                  praticalGradeController1[index].text.isEmpty
                                      ? praticalGradeController1[index].text =
                                          value.studListUAS[index].peGrade ==
                                                  null
                                              ? praticalGradeController1[index]
                                                  .text
                                              : value.studListUAS[index].peGrade
                                                  .toString()
                                      : praticalGradeController1[index].text;
                                  praticalGradeController[index].text.isEmpty
                                      ? praticalGradeController[index].text =
                                          value.studListUAS[index].peGrade ==
                                                  null
                                              ? praticalGradeController[index]
                                                  .text
                                              : value.studListUAS[index].peGrade
                                                  .toString()
                                      : praticalGradeController[index].text;

                                  //CE Grade
                                  ceGradeController
                                      .add(TextEditingController());
                                  ceGradeController1
                                      .add(TextEditingController());

                                  ceGradeController1[index].text.isEmpty
                                      ? ceGradeController1[index].text =
                                          value.studListUAS[index].ceGrade ==
                                                  null
                                              ? ceGradeController1[index].text
                                              : value.studListUAS[index].ceGrade
                                                  .toString()
                                      : ceGradeController1[index].text;
                                  ceGradeController[index].text.isEmpty
                                      ? ceGradeController[index].text =
                                          value.studListUAS[index].ceGrade ==
                                                  null
                                              ? ceGradeController[index].text
                                              : value.studListUAS[index].ceGrade
                                                  .toString()
                                      : ceGradeController[index].text;

                                  return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      width: size.width,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: UIGuide.light_Purple,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: 80,
                                                  child: Text(
<<<<<<< HEAD
                                                    'Roll No: ${value.studListUAS[index].rollNo == null ? '' : value.studListUAS[index].rollNo.toString()}',
=======
                                                    'Roll No: ${value.studListUAS[index].rollNo == null ? '0' : value.studListUAS[index].rollNo.toString()}',
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                kWidth,
                                                kWidth,
                                                kWidth,
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10.0),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        if (value
                                                                .studListUAS[
                                                                    index]
                                                                .attendance ==
                                                            'A') {
                                                          value
                                                              .studListUAS[
                                                                  index]
                                                              .attendance = 'P';
                                                        } else {
                                                          value
                                                              .studListUAS[
                                                                  index]
                                                              .attendance = 'A';

                                                          value
                                                              .studListUAS[
                                                                  index]
                                                              .ceGrade = null;
                                                          value
                                                              .studListUAS[
                                                                  index]
                                                              .ceGradeId = null;

                                                          ceGradeController[
                                                                  index]
                                                              .clear();
                                                          ceGradeController1[
                                                                  index]
                                                              .clear();

                                                          value
                                                              .studListUAS[
                                                                  index]
                                                              .teGrade = null;
                                                          value
                                                              .studListUAS[
                                                                  index]
                                                              .teGradeId = null;

                                                          teGradeController[
                                                                  index]
                                                              .clear();
                                                          teGradeController1[
                                                                  index]
                                                              .clear();

                                                          value
                                                              .studListUAS[
                                                                  index]
                                                              .peGrade = null;
                                                          value
                                                              .studListUAS[
                                                                  index]
                                                              .peGradeId = null;

                                                          praticalGradeController[
                                                                  index]
                                                              .clear();
                                                          praticalGradeController1[
                                                                  index]
                                                              .clear();
                                                        }
                                                        attendancee = value
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
                                                          child: value
                                                                      .studListUAS[
                                                                          index]
                                                                      .attendance ==
                                                                  'A'
                                                              ? SvgPicture
                                                                  .asset(UIGuide
                                                                      .absent)
                                                              : SvgPicture
                                                                  .asset(UIGuide
                                                                      .present)),
                                                    ),
                                                  ),
                                                ),
                                                kWidth,
                                                kWidth,
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
                                                    strutStyle:
                                                        const StrutStyle(
                                                            fontSize: 12.0),
                                                    text: TextSpan(
                                                      style: const TextStyle(
                                                          color: UIGuide
                                                              .light_Purple),
                                                      text: value
                                                              .studListUAS[
                                                                  index]
                                                              .studentName ??
                                                          "",
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  LimitedBox(
                                                    maxWidth: 80,
                                                    child: Text(
                                                      '${value.teCaptionUAS ?? ""} : ',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 40,
                                                    width: 80,
                                                    child: SizedBox(
                                                      height: 40,
                                                      width: 100,
                                                      child: Consumer<
                                                              MarkEntryNewProvider>(
                                                          builder: (context,
                                                              snapshot, child) {
                                                        return InkWell(
                                                          onTap: () {
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return Dialog(
                                                                      child:
                                                                          LimitedBox(
                                                                    maxHeight:
                                                                        size.height /
                                                                            2,
                                                                    child: ListView.builder(
                                                                        shrinkWrap: true,
                                                                        itemCount: snapshot.gradeListUAS.length,
                                                                        itemBuilder: (context, indx) {
                                                                          return ListTile(
                                                                            selectedTileColor:
                                                                                Colors.blue.shade100,
                                                                            selectedColor:
                                                                                UIGuide.PRIMARY2,
                                                                            onTap:
                                                                                () {
                                                                              teGradeController[index].text = snapshot.gradeListUAS[indx].value ?? '--';
                                                                              teGradeController1[index].text = snapshot.gradeListUAS[indx].value ?? '--';
                                                                              value.studListUAS[index].teGrade = teGradeController1[index].text;
                                                                              value.studListUAS[index].teGrade = teGradeController[index].text;
                                                                              value.studListUAS[index].teGrade = value.studListUAS[index].teGrade;
                                                                              Navigator.of(context).pop();
                                                                            },
                                                                            title:
                                                                                Text(
                                                                              snapshot.gradeListUAS[indx].text ?? '--',
                                                                              textAlign: TextAlign.center,
                                                                            ),
                                                                          );
                                                                        }),
                                                                  ));
                                                                });
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(5.0),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Container(
                                                                  height: 30,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    border: Border.all(
                                                                        color: UIGuide
                                                                            .light_Purple,
                                                                        width:
                                                                            1),
                                                                  ),
                                                                  child:
                                                                      TextField(
<<<<<<< HEAD
                                                                    textInputAction:
                                                                        TextInputAction
                                                                            .next,
                                                                    enabled: value.studListUAS[index].attendance ==
                                                                                'A' ||
                                                                            value.examStatusUAS ==
                                                                                'Synchronized'
=======
                                                                    enabled: value.studListUAS[index].attendance ==
                                                                            'A'
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
                                                                        ? true
                                                                        : false,
                                                                    readOnly:
                                                                        true,
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        color: UIGuide
                                                                            .BLACK,
                                                                        overflow:
                                                                            TextOverflow.clip),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    controller:
                                                                        teGradeController[
                                                                            index],
                                                                    decoration:
                                                                        const InputDecoration(
                                                                      filled:
                                                                          true,
                                                                      contentPadding: EdgeInsets.only(
                                                                          left:
                                                                              0,
                                                                          top:
                                                                              0),
                                                                      floatingLabelBehavior:
                                                                          FloatingLabelBehavior
                                                                              .never,
                                                                      fillColor: Color.fromARGB(
                                                                          255,
                                                                          255,
                                                                          255,
                                                                          255),
                                                                      border:
                                                                          OutlineInputBorder(),
                                                                      labelText:
                                                                          "  Select ",
                                                                      hintText:
                                                                          "grade",
                                                                    ),
                                                                    onChanged:
                                                                        (value1) {
                                                                      teGradeController1[index].text = value
                                                                          .studListUAS[
                                                                              index]
                                                                          .teGrade
                                                                          .toString();
                                                                      teGradeController1[index]
                                                                              .text =
                                                                          value1;
                                                                    },
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      }),
                                                    ),
                                                  ),
                                                  kWidth,
                                                  LimitedBox(
                                                    maxWidth: 80,
                                                    child: Text(
                                                      '${value.ceCaptionUAS ?? ""} : ',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 40,
                                                    width: 80,
                                                    child: SizedBox(
                                                      height: 40,
                                                      width: 100,
                                                      child: Consumer<
                                                              MarkEntryNewProvider>(
                                                          builder: (context,
                                                              snapshot, child) {
                                                        return InkWell(
                                                          onTap: () {
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return Dialog(
                                                                      child:
                                                                          LimitedBox(
                                                                    maxHeight:
                                                                        size.height /
                                                                            2,
                                                                    child: ListView.builder(
                                                                        shrinkWrap: true,
                                                                        itemCount: snapshot.gradeListUAS.length,
                                                                        itemBuilder: (context, indx) {
                                                                          return ListTile(
                                                                            selectedTileColor:
                                                                                Colors.blue.shade100,
                                                                            selectedColor:
                                                                                UIGuide.PRIMARY2,
                                                                            onTap:
                                                                                () {
                                                                              ceGradeController[index].text = snapshot.gradeListUAS[indx].value ?? '--';
                                                                              ceGradeController1[index].text = snapshot.gradeListUAS[indx].value ?? '--';
                                                                              value.studListUAS[index].ceGrade = ceGradeController1[index].text;
                                                                              value.studListUAS[index].ceGrade = ceGradeController[index].text;
                                                                              value.studListUAS[index].ceGrade = value.studListUAS[index].ceGrade;
                                                                              Navigator.of(context).pop();
                                                                            },
                                                                            title:
                                                                                Text(
                                                                              snapshot.gradeListUAS[indx].text ?? '--',
                                                                              textAlign: TextAlign.center,
                                                                            ),
                                                                          );
                                                                        }),
                                                                  ));
                                                                });
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(5.0),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Container(
                                                                  height: 30,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    border: Border.all(
                                                                        color: UIGuide
                                                                            .light_Purple,
                                                                        width:
                                                                            1),
                                                                  ),
                                                                  child:
                                                                      TextField(
<<<<<<< HEAD
                                                                    textInputAction:
                                                                        TextInputAction
                                                                            .next,
=======
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        color: UIGuide
                                                                            .BLACK,
                                                                        overflow:
                                                                            TextOverflow.clip),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    controller:
                                                                        ceGradeController[
                                                                            index],
                                                                    decoration:
                                                                        const InputDecoration(
                                                                      filled:
                                                                          true,
                                                                      contentPadding: EdgeInsets.only(
                                                                          left:
                                                                              0,
                                                                          top:
                                                                              0),
                                                                      floatingLabelBehavior:
                                                                          FloatingLabelBehavior
                                                                              .never,
                                                                      fillColor: Color.fromARGB(
                                                                          255,
                                                                          255,
                                                                          255,
                                                                          255),
                                                                      border:
                                                                          OutlineInputBorder(),
                                                                      labelText:
<<<<<<< HEAD
                                                                          "  Select ",
=======
                                                                          "  Select grade",
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
                                                                      hintText:
                                                                          "grade",
                                                                    ),
                                                                    enabled: value.studListUAS[index].attendance ==
<<<<<<< HEAD
                                                                                'A' ||
                                                                            value.examStatusUAS ==
                                                                                'Synchronized'
=======
                                                                            'A'
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
                                                                        ? true
                                                                        : false,
                                                                    readOnly:
                                                                        true,
                                                                    onChanged:
                                                                        (value1) {
                                                                      ceGradeController1[index].text = value
                                                                          .studListUAS[
                                                                              index]
                                                                          .ceGrade
                                                                          .toString();
                                                                      ceGradeController1[index]
                                                                              .text =
                                                                          value1;
                                                                    },
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      }),
                                                    ),
                                                  ),
                                                  kWidth,
                                                  LimitedBox(
                                                    maxWidth: 80,
                                                    child: Text(
                                                      '${value.peCaptionUAS ?? ""} : ',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 40,
                                                    width: 80,
                                                    child: SizedBox(
                                                      height: 40,
                                                      width: 100,
                                                      child: Consumer<
                                                              MarkEntryNewProvider>(
                                                          builder: (context,
                                                              snapshot, child) {
                                                        return InkWell(
                                                          onTap: () {
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return Dialog(
                                                                      child:
                                                                          LimitedBox(
                                                                    maxHeight:
                                                                        size.height /
                                                                            2,
                                                                    child: ListView.builder(
                                                                        shrinkWrap: true,
                                                                        itemCount: snapshot.gradeListUAS.length,
                                                                        itemBuilder: (context, indx) {
                                                                          return ListTile(
                                                                            selectedTileColor:
                                                                                Colors.blue.shade100,
                                                                            selectedColor:
                                                                                UIGuide.PRIMARY2,
                                                                            onTap:
                                                                                () {
                                                                              praticalGradeController[index].text = snapshot.gradeListUAS[indx].value ?? '--';
                                                                              praticalGradeController1[index].text = snapshot.gradeListUAS[indx].value ?? '--';
                                                                              value.studListUAS[index].peGrade = praticalGradeController1[index].text;
                                                                              value.studListUAS[index].peGrade = praticalGradeController[index].text;
                                                                              value.studListUAS[index].peGrade = value.studListUAS[index].peGrade;
                                                                              Navigator.of(context).pop();
                                                                            },
                                                                            title:
                                                                                Text(
                                                                              snapshot.gradeListUAS[indx].text ?? '--',
                                                                              textAlign: TextAlign.center,
                                                                            ),
                                                                          );
                                                                        }),
                                                                  ));
                                                                });
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(5.0),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Container(
                                                                  height: 30,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    border: Border.all(
                                                                        color: UIGuide
                                                                            .light_Purple,
                                                                        width:
                                                                            1),
                                                                  ),
                                                                  child:
                                                                      TextField(
<<<<<<< HEAD
                                                                    textInputAction:
                                                                        TextInputAction
                                                                            .next,
=======
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        color: UIGuide
                                                                            .BLACK,
                                                                        overflow:
                                                                            TextOverflow.clip),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    controller:
                                                                        praticalGradeController[
                                                                            index],
                                                                    decoration:
                                                                        const InputDecoration(
                                                                      filled:
                                                                          true,
                                                                      contentPadding: EdgeInsets.only(
                                                                          left:
                                                                              0,
                                                                          top:
                                                                              0),
                                                                      floatingLabelBehavior:
                                                                          FloatingLabelBehavior
                                                                              .never,
                                                                      fillColor: Color.fromARGB(
                                                                          255,
                                                                          255,
                                                                          255,
                                                                          255),
                                                                      border:
                                                                          OutlineInputBorder(),
                                                                      labelText:
<<<<<<< HEAD
                                                                          "  Select ",
=======
                                                                          "  Select grade",
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
                                                                      hintText:
                                                                          "grade",
                                                                    ),
                                                                    enabled: value.studListUAS[index].attendance ==
<<<<<<< HEAD
                                                                                'A' ||
                                                                            value.examStatusUAS ==
                                                                                'Synchronized'
=======
                                                                            'A'
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
                                                                        ? true
                                                                        : false,
                                                                    readOnly:
                                                                        true,
                                                                    onChanged:
                                                                        (value1) {
                                                                      praticalGradeController1[index].text = value
                                                                          .studListUAS[
                                                                              index]
                                                                          .peGrade
                                                                          .toString();
                                                                      praticalGradeController1[index]
                                                                              .text =
                                                                          value1;
                                                                    },
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      }),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                })),
                          ));
                    }

///////////////-------------------------------------------------------------------------------------///////////////
///////////////-----------------------     TE Grade   --  CE Grade  -------------------------------///////////////
///////////////-----------------------------------------------------------------------------------///////////////
                    if (provider.teCaptionUAS != null &&
                        provider.peCaptionUAS == null &&
                        provider.ceCaptionUAS != null) {
                      return LimitedBox(
<<<<<<< HEAD
                          maxHeight: size.height / 1.81,
=======
                          maxHeight: size.height / 1.85,
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: value.studListUAS.length,
                                itemBuilder: ((context, index) {
                                  //TE Grade
                                  teGradeController
                                      .add(TextEditingController());
                                  teGradeController1
                                      .add(TextEditingController());

                                  teGradeController1[index].text.isEmpty
                                      ? teGradeController1[index].text =
                                          value.studListUAS[index].teGrade ==
                                                  null
                                              ? teGradeController1[index].text
                                              : value.studListUAS[index].teGrade
                                                  .toString()
                                      : teGradeController1[index].text;
                                  teGradeController[index].text.isEmpty
                                      ? teGradeController[index].text =
                                          value.studListUAS[index].teGrade ==
                                                  null
                                              ? teGradeController[index].text
                                              : value.studListUAS[index].teGrade
                                                  .toString()
                                      : teGradeController[index].text;

                                  //CE Grade
                                  ceGradeController
                                      .add(TextEditingController());
                                  ceGradeController1
                                      .add(TextEditingController());

                                  ceGradeController1[index].text.isEmpty
                                      ? ceGradeController1[index].text =
                                          value.studListUAS[index].ceGrade ==
                                                  null
                                              ? ceGradeController1[index].text
                                              : value.studListUAS[index].ceGrade
                                                  .toString()
                                      : ceGradeController1[index].text;
                                  ceGradeController[index].text.isEmpty
                                      ? ceGradeController[index].text =
                                          value.studListUAS[index].ceGrade ==
                                                  null
                                              ? ceGradeController[index].text
                                              : value.studListUAS[index].ceGrade
                                                  .toString()
                                      : ceGradeController[index].text;

                                  return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      width: size.width,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: UIGuide.light_Purple,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: 80,
                                                  child: Text(
<<<<<<< HEAD
                                                    'Roll No: ${value.studListUAS[index].rollNo == null ? '' : value.studListUAS[index].rollNo.toString()}',
=======
                                                    'Roll No: ${value.studListUAS[index].rollNo == null ? '0' : value.studListUAS[index].rollNo.toString()}',
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                kWidth,
                                                kWidth,
                                                kWidth,
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10.0),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        if (value
                                                                .studListUAS[
                                                                    index]
                                                                .attendance ==
                                                            'A') {
                                                          value
                                                              .studListUAS[
                                                                  index]
                                                              .attendance = 'P';
                                                        } else {
                                                          value
                                                              .studListUAS[
                                                                  index]
                                                              .attendance = 'A';

                                                          value
                                                              .studListUAS[
                                                                  index]
                                                              .ceGrade = null;
                                                          value
                                                              .studListUAS[
                                                                  index]
                                                              .ceGradeId = null;

                                                          ceGradeController[
                                                                  index]
                                                              .clear();
                                                          ceGradeController1[
                                                                  index]
                                                              .clear();

                                                          value
                                                              .studListUAS[
                                                                  index]
                                                              .teGrade = null;
                                                          value
                                                              .studListUAS[
                                                                  index]
                                                              .teGradeId = null;

                                                          teGradeController[
                                                                  index]
                                                              .clear();
                                                          teGradeController1[
                                                                  index]
                                                              .clear();
                                                        }
                                                        attendancee = value
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
                                                          child: value
                                                                      .studListUAS[
                                                                          index]
                                                                      .attendance ==
                                                                  'A'
                                                              ? SvgPicture
                                                                  .asset(UIGuide
                                                                      .absent)
                                                              : SvgPicture
                                                                  .asset(UIGuide
                                                                      .present)),
                                                    ),
                                                  ),
                                                ),
                                                kWidth,
                                                kWidth,
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
                                                    strutStyle:
                                                        const StrutStyle(
                                                            fontSize: 12.0),
                                                    text: TextSpan(
                                                      style: const TextStyle(
                                                          color: UIGuide
                                                              .light_Purple),
                                                      text: value
                                                              .studListUAS[
                                                                  index]
                                                              .studentName ??
                                                          "",
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  LimitedBox(
                                                    maxWidth: 80,
                                                    child: Text(
                                                      '${value.teCaptionUAS ?? ""} : ',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 40,
                                                    width: 80,
                                                    child: SizedBox(
                                                      height: 40,
                                                      width: 100,
                                                      child: Consumer<
                                                              MarkEntryNewProvider>(
                                                          builder: (context,
                                                              snapshot, child) {
                                                        return InkWell(
                                                          onTap: () {
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return Dialog(
                                                                      child:
                                                                          LimitedBox(
                                                                    maxHeight:
                                                                        size.height /
                                                                            2,
                                                                    child: ListView.builder(
                                                                        shrinkWrap: true,
                                                                        itemCount: snapshot.gradeListUAS.length,
                                                                        itemBuilder: (context, indx) {
                                                                          return ListTile(
                                                                            selectedTileColor:
                                                                                Colors.blue.shade100,
                                                                            selectedColor:
                                                                                UIGuide.PRIMARY2,
                                                                            onTap:
                                                                                () {
                                                                              teGradeController[index].text = snapshot.gradeListUAS[indx].value ?? '--';
                                                                              teGradeController1[index].text = snapshot.gradeListUAS[indx].value ?? '--';
                                                                              value.studListUAS[index].teGrade = teGradeController1[index].text;
                                                                              // value.studListUAS[index].teGrade = teGradeController[index].text;
                                                                              value.studListUAS[index].teGrade = value.studListUAS[index].teGrade;
                                                                              Navigator.of(context).pop();
                                                                            },
                                                                            title:
                                                                                Text(
                                                                              snapshot.gradeListUAS[indx].text ?? '--',
                                                                              textAlign: TextAlign.center,
                                                                            ),
                                                                          );
                                                                        }),
                                                                  ));
                                                                });
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(5.0),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Container(
                                                                  height: 30,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    border: Border.all(
                                                                        color: UIGuide
                                                                            .light_Purple,
                                                                        width:
                                                                            1),
                                                                  ),
                                                                  child:
                                                                      TextField(
<<<<<<< HEAD
                                                                    textInputAction:
                                                                        TextInputAction
                                                                            .next,
                                                                    enabled: value.studListUAS[index].attendance ==
                                                                                'A' ||
                                                                            value.examStatusUAS ==
                                                                                'Synchronized'
=======
                                                                    enabled: value.studListUAS[index].attendance ==
                                                                            'A'
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
                                                                        ? true
                                                                        : false,
                                                                    readOnly:
                                                                        true,
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        color: UIGuide
                                                                            .BLACK,
                                                                        overflow:
                                                                            TextOverflow.clip),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    controller:
                                                                        teGradeController[
                                                                            index],
                                                                    decoration:
                                                                        const InputDecoration(
                                                                      filled:
                                                                          true,
                                                                      contentPadding: EdgeInsets.only(
                                                                          left:
                                                                              0,
                                                                          top:
                                                                              0),
                                                                      floatingLabelBehavior:
                                                                          FloatingLabelBehavior
                                                                              .never,
                                                                      fillColor: Color.fromARGB(
                                                                          255,
                                                                          255,
                                                                          255,
                                                                          255),
                                                                      border:
                                                                          OutlineInputBorder(),
                                                                      labelText:
<<<<<<< HEAD
                                                                          "  Select ",
=======
                                                                          "  Select grade",
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
                                                                      hintText:
                                                                          "grade",
                                                                    ),
                                                                    onChanged:
                                                                        (value1) {
                                                                      teGradeController1[index].text = value
                                                                          .studListUAS[
                                                                              index]
                                                                          .teGrade
                                                                          .toString();
                                                                      teGradeController1[index]
                                                                              .text =
                                                                          value1;
                                                                    },
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      }),
                                                    ),
                                                  ),
                                                  kWidth,
                                                  LimitedBox(
                                                    maxWidth: 80,
                                                    child: Text(
                                                      '${value.ceCaptionUAS ?? ""} : ',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 40,
                                                    width: 80,
                                                    child: SizedBox(
                                                      height: 40,
                                                      width: 100,
                                                      child: Consumer<
                                                              MarkEntryNewProvider>(
                                                          builder: (context,
                                                              snapshot, child) {
                                                        return InkWell(
                                                          onTap: () {
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return Dialog(
                                                                      child:
                                                                          LimitedBox(
                                                                    maxHeight:
                                                                        size.height /
                                                                            2,
                                                                    child: ListView.builder(
                                                                        shrinkWrap: true,
                                                                        itemCount: snapshot.gradeListUAS.length,
                                                                        itemBuilder: (context, indx) {
                                                                          return ListTile(
                                                                            selectedTileColor:
                                                                                Colors.blue.shade100,
                                                                            selectedColor:
                                                                                UIGuide.PRIMARY2,
                                                                            onTap:
                                                                                () {
                                                                              ceGradeController[index].text = snapshot.gradeListUAS[indx].value ?? '--';
                                                                              ceGradeController1[index].text = snapshot.gradeListUAS[indx].value ?? '--';
                                                                              value.studListUAS[index].ceGrade = ceGradeController1[index].text;
                                                                              //   value.studListUAS[index].ceGrade = ceGradeController[index].text;
                                                                              value.studListUAS[index].ceGrade = value.studListUAS[index].ceGrade;
                                                                              print(provider.studListUAS[index].peGrade);
                                                                              Navigator.of(context).pop();
                                                                            },
                                                                            title:
                                                                                Text(
                                                                              snapshot.gradeListUAS[indx].text ?? '--',
                                                                              textAlign: TextAlign.center,
                                                                            ),
                                                                          );
                                                                        }),
                                                                  ));
                                                                });
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(5.0),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Container(
                                                                  height: 30,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    border: Border.all(
                                                                        color: UIGuide
                                                                            .light_Purple,
                                                                        width:
                                                                            1),
                                                                  ),
                                                                  child:
                                                                      TextField(
<<<<<<< HEAD
                                                                    textInputAction:
                                                                        TextInputAction
                                                                            .next,
=======
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        color: UIGuide
                                                                            .BLACK,
                                                                        overflow:
                                                                            TextOverflow.clip),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    controller:
                                                                        ceGradeController[
                                                                            index],
                                                                    decoration:
                                                                        const InputDecoration(
                                                                      filled:
                                                                          true,
                                                                      contentPadding: EdgeInsets.only(
                                                                          left:
                                                                              0,
                                                                          top:
                                                                              0),
                                                                      floatingLabelBehavior:
                                                                          FloatingLabelBehavior
                                                                              .never,
                                                                      fillColor: Color.fromARGB(
                                                                          255,
                                                                          255,
                                                                          255,
                                                                          255),
                                                                      border:
                                                                          OutlineInputBorder(),
                                                                      labelText:
<<<<<<< HEAD
                                                                          "  Select ",
=======
                                                                          "  Select grade",
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
                                                                      hintText:
                                                                          "grade",
                                                                    ),
                                                                    enabled: value.studListUAS[index].attendance ==
<<<<<<< HEAD
                                                                                'A' ||
                                                                            value.examStatusUAS ==
                                                                                'Synchronized'
=======
                                                                            'A'
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
                                                                        ? true
                                                                        : false,
                                                                    readOnly:
                                                                        true,
                                                                    onChanged:
                                                                        (value1) {
                                                                      ceGradeController1[index].text = value
                                                                          .studListUAS[
                                                                              index]
                                                                          .ceGrade
                                                                          .toString();
                                                                      ceGradeController1[index]
                                                                              .text =
                                                                          value1;
                                                                    },
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      }),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                })),
                          ));
                    }

///////////////-------------------------------------------------------------------------------------///////////////
///////////////-----------------------     TE Grade  --  PE Grade ---------------------------------///////////////
///////////////-----------------------------------------------------------------------------------///////////////
                    if (provider.teCaptionUAS != null &&
                        provider.peCaptionUAS != null &&
                        provider.ceCaptionUAS == null) {
                      return LimitedBox(
<<<<<<< HEAD
                          maxHeight: size.height / 1.81,
=======
                          maxHeight: size.height / 1.85,
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: value.studListUAS.length,
                                itemBuilder: ((context, index) {
                                  //TE Grade
                                  teGradeController
                                      .add(TextEditingController());
                                  teGradeController1
                                      .add(TextEditingController());

                                  teGradeController1[index].text.isEmpty
                                      ? teGradeController1[index].text =
                                          value.studListUAS[index].teGrade ==
                                                  null
                                              ? teGradeController1[index].text
                                              : value.studListUAS[index].teGrade
                                                  .toString()
                                      : teGradeController1[index].text;
                                  teGradeController[index].text.isEmpty
                                      ? teGradeController[index].text =
                                          value.studListUAS[index].teGrade ==
                                                  null
                                              ? teGradeController[index].text
                                              : value.studListUAS[index].teGrade
                                                  .toString()
                                      : teGradeController[index].text;

                                  //Practical Grade
                                  praticalGradeController
                                      .add(TextEditingController());
                                  praticalGradeController1
                                      .add(TextEditingController());

                                  praticalGradeController1[index].text.isEmpty
                                      ? praticalGradeController1[index].text =
                                          value.studListUAS[index].peGrade ==
                                                  null
                                              ? praticalGradeController1[index]
                                                  .text
                                              : value.studListUAS[index].peGrade
                                                  .toString()
                                      : praticalGradeController1[index].text;
                                  praticalGradeController[index].text.isEmpty
                                      ? praticalGradeController[index].text =
                                          value.studListUAS[index].peGrade ==
                                                  null
                                              ? praticalGradeController[index]
                                                  .text
                                              : value.studListUAS[index].peGrade
                                                  .toString()
                                      : praticalGradeController[index].text;

                                  return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      width: size.width,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: UIGuide.light_Purple,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: 80,
                                                  child: Text(
<<<<<<< HEAD
                                                    'Roll No: ${value.studListUAS[index].rollNo == null ? '' : value.studListUAS[index].rollNo.toString()}',
=======
                                                    'Roll No: ${value.studListUAS[index].rollNo == null ? '0' : value.studListUAS[index].rollNo.toString()}',
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                kWidth,
                                                kWidth,
                                                kWidth,
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10.0),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        if (value
                                                                .studListUAS[
                                                                    index]
                                                                .attendance ==
                                                            'A') {
                                                          value
                                                              .studListUAS[
                                                                  index]
                                                              .attendance = 'P';
                                                        } else {
                                                          value
                                                              .studListUAS[
                                                                  index]
                                                              .attendance = 'A';

                                                          value
                                                              .studListUAS[
                                                                  index]
                                                              .teGrade = null;
                                                          value
                                                              .studListUAS[
                                                                  index]
                                                              .teGradeId = null;

                                                          teGradeController[
                                                                  index]
                                                              .clear();
                                                          teGradeController1[
                                                                  index]
                                                              .clear();

                                                          value
                                                              .studListUAS[
                                                                  index]
                                                              .peGrade = null;
                                                          value
                                                              .studListUAS[
                                                                  index]
                                                              .peGradeId = null;

                                                          praticalGradeController[
                                                                  index]
                                                              .clear();
                                                          praticalGradeController1[
                                                                  index]
                                                              .clear();
                                                        }
                                                        attendancee = value
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
                                                          child: value
                                                                      .studListUAS[
                                                                          index]
                                                                      .attendance ==
                                                                  'A'
                                                              ? SvgPicture
                                                                  .asset(UIGuide
                                                                      .absent)
                                                              : SvgPicture
                                                                  .asset(UIGuide
                                                                      .present)),
                                                    ),
                                                  ),
                                                ),
                                                kWidth,
                                                kWidth,
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
                                                    strutStyle:
                                                        const StrutStyle(
                                                            fontSize: 12.0),
                                                    text: TextSpan(
                                                      style: const TextStyle(
                                                          color: UIGuide
                                                              .light_Purple),
                                                      text: value
                                                              .studListUAS[
                                                                  index]
                                                              .studentName ??
                                                          "",
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  LimitedBox(
                                                    maxWidth: 80,
                                                    child: Text(
                                                      '${value.teCaptionUAS ?? ""} : ',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 40,
                                                    width: 80,
                                                    child: SizedBox(
                                                      height: 40,
                                                      width: 100,
                                                      child: Consumer<
                                                              MarkEntryNewProvider>(
                                                          builder: (context,
                                                              snapshot, child) {
                                                        return InkWell(
                                                          onTap: () {
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return Dialog(
                                                                      child:
                                                                          LimitedBox(
                                                                    maxHeight:
                                                                        size.height /
                                                                            2,
                                                                    child: ListView.builder(
                                                                        shrinkWrap: true,
                                                                        itemCount: snapshot.gradeListUAS.length,
                                                                        itemBuilder: (context, indx) {
                                                                          return ListTile(
                                                                            selectedTileColor:
                                                                                Colors.blue.shade100,
                                                                            selectedColor:
                                                                                UIGuide.PRIMARY2,
                                                                            onTap:
                                                                                () {
                                                                              teGradeController[index].text = snapshot.gradeListUAS[indx].value ?? '--';
                                                                              teGradeController1[index].text = snapshot.gradeListUAS[indx].value ?? '--';
                                                                              value.studListUAS[index].teGrade = teGradeController1[index].text;
                                                                              value.studListUAS[index].teGrade = teGradeController[index].text;
                                                                              value.studListUAS[index].teGrade = value.studListUAS[index].teGrade;
                                                                              Navigator.of(context).pop();
                                                                            },
                                                                            title:
                                                                                Text(
                                                                              snapshot.gradeListUAS[indx].text ?? '--',
                                                                              textAlign: TextAlign.center,
                                                                            ),
                                                                          );
                                                                        }),
                                                                  ));
                                                                });
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(5.0),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Container(
                                                                  height: 30,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    border: Border.all(
                                                                        color: UIGuide
                                                                            .light_Purple,
                                                                        width:
                                                                            1),
                                                                  ),
                                                                  child:
                                                                      TextField(
<<<<<<< HEAD
                                                                    textInputAction:
                                                                        TextInputAction
                                                                            .next,
                                                                    enabled: value.studListUAS[index].attendance ==
                                                                                'A' ||
                                                                            value.examStatusUAS ==
                                                                                'Synchronized'
=======
                                                                    enabled: value.studListUAS[index].attendance ==
                                                                            'A'
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
                                                                        ? true
                                                                        : false,
                                                                    readOnly:
                                                                        true,
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        color: UIGuide
                                                                            .BLACK,
                                                                        overflow:
                                                                            TextOverflow.clip),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    controller:
                                                                        teGradeController[
                                                                            index],
                                                                    decoration:
                                                                        const InputDecoration(
                                                                      filled:
                                                                          true,
                                                                      contentPadding: EdgeInsets.only(
                                                                          left:
                                                                              0,
                                                                          top:
                                                                              0),
                                                                      floatingLabelBehavior:
                                                                          FloatingLabelBehavior
                                                                              .never,
                                                                      fillColor: Color.fromARGB(
                                                                          255,
                                                                          255,
                                                                          255,
                                                                          255),
                                                                      border:
                                                                          OutlineInputBorder(),
                                                                      labelText:
<<<<<<< HEAD
                                                                          "  Select ",
=======
                                                                          "  Select grade",
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
                                                                      hintText:
                                                                          "grade",
                                                                    ),
                                                                    onChanged:
                                                                        (value1) {
                                                                      teGradeController1[index].text = value
                                                                          .studListUAS[
                                                                              index]
                                                                          .teGrade
                                                                          .toString();
                                                                      teGradeController1[index]
                                                                              .text =
                                                                          value1;
                                                                    },
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      }),
                                                    ),
                                                  ),
                                                  kWidth,
                                                  LimitedBox(
                                                    maxWidth: 80,
                                                    child: Text(
                                                      '${value.peCaptionUAS ?? ""} : ',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 40,
                                                    width: 80,
                                                    child: SizedBox(
                                                      height: 40,
                                                      width: 100,
                                                      child: Consumer<
                                                              MarkEntryNewProvider>(
                                                          builder: (context,
                                                              snapshot, child) {
                                                        return InkWell(
                                                          onTap: () {
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return Dialog(
                                                                      child:
                                                                          LimitedBox(
                                                                    maxHeight:
                                                                        size.height /
                                                                            2,
                                                                    child: ListView.builder(
                                                                        shrinkWrap: true,
                                                                        itemCount: snapshot.gradeListUAS.length,
                                                                        itemBuilder: (context, indx) {
                                                                          return ListTile(
                                                                            selectedTileColor:
                                                                                Colors.blue.shade100,
                                                                            selectedColor:
                                                                                UIGuide.PRIMARY2,
                                                                            onTap:
                                                                                () {
                                                                              praticalGradeController[index].text = snapshot.gradeListUAS[indx].value ?? '--';
                                                                              praticalGradeController1[index].text = snapshot.gradeListUAS[indx].value ?? '--';
                                                                              value.studListUAS[index].peGrade = praticalGradeController1[index].text;
                                                                              value.studListUAS[index].peGrade = praticalGradeController[index].text;
                                                                              value.studListUAS[index].peGrade = value.studListUAS[index].peGrade;
                                                                              Navigator.of(context).pop();
                                                                            },
                                                                            title:
                                                                                Text(
                                                                              snapshot.gradeListUAS[indx].text ?? '--',
                                                                              textAlign: TextAlign.center,
                                                                            ),
                                                                          );
                                                                        }),
                                                                  ));
                                                                });
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(5.0),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Container(
                                                                  height: 30,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    border: Border.all(
                                                                        color: UIGuide
                                                                            .light_Purple,
                                                                        width:
                                                                            1),
                                                                  ),
                                                                  child:
                                                                      TextField(
<<<<<<< HEAD
                                                                    textInputAction:
                                                                        TextInputAction
                                                                            .next,
=======
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        color: UIGuide
                                                                            .BLACK,
                                                                        overflow:
                                                                            TextOverflow.clip),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    controller:
                                                                        praticalGradeController[
                                                                            index],
                                                                    decoration:
                                                                        const InputDecoration(
                                                                      filled:
                                                                          true,
                                                                      contentPadding: EdgeInsets.only(
                                                                          left:
                                                                              0,
                                                                          top:
                                                                              0),
                                                                      floatingLabelBehavior:
                                                                          FloatingLabelBehavior
                                                                              .never,
                                                                      fillColor: Color.fromARGB(
                                                                          255,
                                                                          255,
                                                                          255,
                                                                          255),
                                                                      border:
                                                                          OutlineInputBorder(),
                                                                      labelText:
<<<<<<< HEAD
                                                                          "  Select ",
=======
                                                                          "  Select grade",
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
                                                                      hintText:
                                                                          "grade",
                                                                    ),
                                                                    enabled: value.studListUAS[index].attendance ==
<<<<<<< HEAD
                                                                                'A' ||
                                                                            value.examStatusUAS ==
                                                                                'Synchronized'
=======
                                                                            'A'
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
                                                                        ? true
                                                                        : false,
                                                                    readOnly:
                                                                        true,
                                                                    onChanged:
                                                                        (value1) {
                                                                      praticalGradeController1[index].text = value
                                                                          .studListUAS[
                                                                              index]
                                                                          .peGrade
                                                                          .toString();
                                                                      praticalGradeController1[index]
                                                                              .text =
                                                                          value1;
                                                                    },
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      }),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                })),
                          ));
                    }

///////////////-------------------------------------------------------------------------------------///////////////
///////////////-----------------------      PE Grade --  CE Grade  --------------------------------///////////////
///////////////-----------------------------------------------------------------------------------///////////////
                    if (provider.teCaptionUAS == null &&
                        provider.peCaptionUAS != null &&
                        provider.ceCaptionUAS != null) {
                      return LimitedBox(
<<<<<<< HEAD
                          maxHeight: size.height / 1.81,
=======
                          maxHeight: size.height / 1.85,
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: value.studListUAS.length,
                                itemBuilder: ((context, index) {
                                  //Practical Grade
                                  praticalGradeController
                                      .add(TextEditingController());
                                  praticalGradeController1
                                      .add(TextEditingController());

                                  praticalGradeController1[index].text.isEmpty
                                      ? praticalGradeController1[index].text =
                                          value.studListUAS[index].peGrade ==
                                                  null
                                              ? praticalGradeController1[index]
                                                  .text
                                              : value.studListUAS[index].peGrade
                                                  .toString()
                                      : praticalGradeController1[index].text;
                                  praticalGradeController[index].text.isEmpty
                                      ? praticalGradeController[index].text =
                                          value.studListUAS[index].peGrade ==
                                                  null
                                              ? praticalGradeController[index]
                                                  .text
                                              : value.studListUAS[index].peGrade
                                                  .toString()
                                      : praticalGradeController[index].text;

                                  //CE Grade
                                  ceGradeController
                                      .add(TextEditingController());
                                  ceGradeController1
                                      .add(TextEditingController());

                                  ceGradeController1[index].text.isEmpty
                                      ? ceGradeController1[index].text =
                                          value.studListUAS[index].ceGrade ==
                                                  null
                                              ? ceGradeController1[index].text
                                              : value.studListUAS[index].ceGrade
                                                  .toString()
                                      : ceGradeController1[index].text;
                                  ceGradeController[index].text.isEmpty
                                      ? ceGradeController[index].text =
                                          value.studListUAS[index].ceGrade ==
                                                  null
                                              ? ceGradeController[index].text
                                              : value.studListUAS[index].ceGrade
                                                  .toString()
                                      : ceGradeController[index].text;

                                  return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      width: size.width,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: UIGuide.light_Purple,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: 80,
                                                  child: Text(
<<<<<<< HEAD
                                                    'Roll No: ${value.studListUAS[index].rollNo == null ? '' : value.studListUAS[index].rollNo.toString()}',
=======
                                                    'Roll No: ${value.studListUAS[index].rollNo == null ? '0' : value.studListUAS[index].rollNo.toString()}',
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                kWidth,
                                                kWidth,
                                                kWidth,
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10.0),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        if (value
                                                                .studListUAS[
                                                                    index]
                                                                .attendance ==
                                                            'A') {
                                                          value
                                                              .studListUAS[
                                                                  index]
                                                              .attendance = 'P';
                                                        } else {
                                                          value
                                                              .studListUAS[
                                                                  index]
                                                              .attendance = 'A';

                                                          value
                                                              .studListUAS[
                                                                  index]
                                                              .ceGrade = null;
                                                          value
                                                              .studListUAS[
                                                                  index]
                                                              .ceGradeId = null;

                                                          ceGradeController[
                                                                  index]
                                                              .clear();
                                                          ceGradeController1[
                                                                  index]
                                                              .clear();

                                                          value
                                                              .studListUAS[
                                                                  index]
                                                              .peGrade = null;
                                                          value
                                                              .studListUAS[
                                                                  index]
                                                              .peGradeId = null;

                                                          praticalGradeController[
                                                                  index]
                                                              .clear();
                                                          praticalGradeController1[
                                                                  index]
                                                              .clear();
                                                        }
                                                        attendancee = value
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
                                                          child: value
                                                                      .studListUAS[
                                                                          index]
                                                                      .attendance ==
                                                                  'A'
                                                              ? SvgPicture
                                                                  .asset(UIGuide
                                                                      .absent)
                                                              : SvgPicture
                                                                  .asset(UIGuide
                                                                      .present)),
                                                    ),
                                                  ),
                                                ),
                                                kWidth,
                                                kWidth,
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
                                                    strutStyle:
                                                        const StrutStyle(
                                                            fontSize: 12.0),
                                                    text: TextSpan(
                                                      style: const TextStyle(
                                                          color: UIGuide
                                                              .light_Purple),
                                                      text: value
                                                              .studListUAS[
                                                                  index]
                                                              .studentName ??
                                                          "",
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  LimitedBox(
                                                    maxWidth: 80,
                                                    child: Text(
                                                      '${value.ceCaptionUAS ?? ""} : ',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 40,
                                                    width: 80,
                                                    child: SizedBox(
                                                      height: 40,
                                                      width: 100,
                                                      child: Consumer<
                                                              MarkEntryNewProvider>(
                                                          builder: (context,
                                                              snapshot, child) {
                                                        return InkWell(
                                                          onTap: () {
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return Dialog(
                                                                      child:
                                                                          LimitedBox(
                                                                    maxHeight:
                                                                        size.height /
                                                                            2,
                                                                    child: ListView.builder(
                                                                        shrinkWrap: true,
                                                                        itemCount: snapshot.gradeListUAS.length,
                                                                        itemBuilder: (context, indx) {
                                                                          return ListTile(
                                                                            selectedTileColor:
                                                                                Colors.blue.shade100,
                                                                            selectedColor:
                                                                                UIGuide.PRIMARY2,
                                                                            onTap:
                                                                                () {
                                                                              ceGradeController[index].text = snapshot.gradeListUAS[indx].value ?? '--';
                                                                              ceGradeController1[index].text = snapshot.gradeListUAS[indx].value ?? '--';
                                                                              value.studListUAS[index].ceGrade = ceGradeController1[index].text;
                                                                              value.studListUAS[index].ceGrade = ceGradeController[index].text;
                                                                              value.studListUAS[index].ceGrade = value.studListUAS[index].ceGrade;
                                                                              Navigator.of(context).pop();
                                                                            },
                                                                            title:
                                                                                Text(
                                                                              snapshot.gradeListUAS[indx].text ?? '--',
                                                                              textAlign: TextAlign.center,
                                                                            ),
                                                                          );
                                                                        }),
                                                                  ));
                                                                });
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(5.0),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Container(
                                                                  height: 30,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    border: Border.all(
                                                                        color: UIGuide
                                                                            .light_Purple,
                                                                        width:
                                                                            1),
                                                                  ),
                                                                  child:
                                                                      TextField(
<<<<<<< HEAD
                                                                    textInputAction:
                                                                        TextInputAction
                                                                            .next,
=======
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        color: UIGuide
                                                                            .BLACK,
                                                                        overflow:
                                                                            TextOverflow.clip),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    controller:
                                                                        ceGradeController[
                                                                            index],
                                                                    decoration:
                                                                        const InputDecoration(
                                                                      filled:
                                                                          true,
                                                                      contentPadding: EdgeInsets.only(
                                                                          left:
                                                                              0,
                                                                          top:
                                                                              0),
                                                                      floatingLabelBehavior:
                                                                          FloatingLabelBehavior
                                                                              .never,
                                                                      fillColor: Color.fromARGB(
                                                                          255,
                                                                          255,
                                                                          255,
                                                                          255),
                                                                      border:
                                                                          OutlineInputBorder(),
                                                                      labelText:
<<<<<<< HEAD
                                                                          "  Select ",
=======
                                                                          "  Select grade",
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
                                                                      hintText:
                                                                          "grade",
                                                                    ),
                                                                    enabled: value.studListUAS[index].attendance ==
<<<<<<< HEAD
                                                                                'A' ||
                                                                            value.examStatusUAS ==
                                                                                'Synchronized'
=======
                                                                            'A'
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
                                                                        ? true
                                                                        : false,
                                                                    readOnly:
                                                                        true,
                                                                    onChanged:
                                                                        (value1) {
                                                                      ceGradeController1[index].text = value
                                                                          .studListUAS[
                                                                              index]
                                                                          .ceGrade
                                                                          .toString();
                                                                      ceGradeController1[index]
                                                                              .text =
                                                                          value1;
                                                                    },
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      }),
                                                    ),
                                                  ),
                                                  kWidth,
                                                  LimitedBox(
                                                    maxWidth: 80,
                                                    child: Text(
                                                      '${value.peCaptionUAS ?? ""} : ',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 40,
                                                    width: 80,
                                                    child: SizedBox(
                                                      height: 40,
                                                      width: 100,
                                                      child: Consumer<
                                                              MarkEntryNewProvider>(
                                                          builder: (context,
                                                              snapshot, child) {
                                                        return InkWell(
                                                          onTap: () {
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return Dialog(
                                                                      child:
                                                                          LimitedBox(
                                                                    maxHeight:
                                                                        size.height /
                                                                            2,
                                                                    child: ListView.builder(
                                                                        shrinkWrap: true,
                                                                        itemCount: snapshot.gradeListUAS.length,
                                                                        itemBuilder: (context, indx) {
                                                                          return ListTile(
                                                                            selectedTileColor:
                                                                                Colors.blue.shade100,
                                                                            selectedColor:
                                                                                UIGuide.PRIMARY2,
                                                                            onTap:
                                                                                () {
                                                                              praticalGradeController[index].text = snapshot.gradeListUAS[indx].value ?? '--';
                                                                              praticalGradeController1[index].text = snapshot.gradeListUAS[indx].value ?? '--';
                                                                              value.studListUAS[index].peGrade = praticalGradeController1[index].text;
                                                                              value.studListUAS[index].peGrade = praticalGradeController[index].text;
                                                                              value.studListUAS[index].peGrade = value.studListUAS[index].peGrade;
                                                                              Navigator.of(context).pop();
                                                                            },
                                                                            title:
                                                                                Text(
                                                                              snapshot.gradeListUAS[indx].text ?? '--',
                                                                              textAlign: TextAlign.center,
                                                                            ),
                                                                          );
                                                                        }),
                                                                  ));
                                                                });
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(5.0),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Container(
                                                                  height: 30,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    border: Border.all(
                                                                        color: UIGuide
                                                                            .light_Purple,
                                                                        width:
                                                                            1),
                                                                  ),
                                                                  child:
                                                                      TextField(
<<<<<<< HEAD
                                                                    textInputAction:
                                                                        TextInputAction
                                                                            .next,
=======
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        color: UIGuide
                                                                            .BLACK,
                                                                        overflow:
                                                                            TextOverflow.clip),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    controller:
                                                                        praticalGradeController[
                                                                            index],
                                                                    decoration:
                                                                        const InputDecoration(
                                                                      filled:
                                                                          true,
                                                                      contentPadding: EdgeInsets.only(
                                                                          left:
                                                                              0,
                                                                          top:
                                                                              0),
                                                                      floatingLabelBehavior:
                                                                          FloatingLabelBehavior
                                                                              .never,
                                                                      fillColor: Color.fromARGB(
                                                                          255,
                                                                          255,
                                                                          255,
                                                                          255),
                                                                      border:
                                                                          OutlineInputBorder(),
                                                                      labelText:
<<<<<<< HEAD
                                                                          "  Select ",
=======
                                                                          "  Select grade",
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
                                                                      hintText:
                                                                          "grade",
                                                                    ),
                                                                    enabled: value.studListUAS[index].attendance ==
<<<<<<< HEAD
                                                                                'A' ||
                                                                            value.examStatusUAS ==
                                                                                'Synchronized'
=======
                                                                            'A'
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
                                                                        ? true
                                                                        : false,
                                                                    readOnly:
                                                                        true,
                                                                    onChanged:
                                                                        (value1) {
                                                                      praticalGradeController1[index].text = value
                                                                          .studListUAS[
                                                                              index]
                                                                          .peGrade
                                                                          .toString();
                                                                      praticalGradeController1[index]
                                                                              .text =
                                                                          value1;
                                                                    },
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      }),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                })),
                          ));
                    }
///////////////-------------------------------------------------------------------------------------///////////////
///////////////-----------------------     TE Grade  ----------------------------------------------///////////////
///////////////-----------------------------------------------------------------------------------///////////////
                    if (provider.teCaptionUAS != null &&
                        provider.peCaptionUAS == null &&
                        provider.ceCaptionUAS == null) {
                      return LimitedBox(
<<<<<<< HEAD
                          maxHeight: size.height / 1.81,
=======
                          maxHeight: size.height / 1.85,
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: value.studListUAS.length,
                                itemBuilder: ((context, index) {
                                  //TE Grade
                                  teGradeController
                                      .add(TextEditingController());
                                  teGradeController1
                                      .add(TextEditingController());

                                  teGradeController1[index].text.isEmpty
                                      ? teGradeController1[index].text =
                                          value.studListUAS[index].teGrade ==
                                                  null
                                              ? teGradeController1[index].text
                                              : value.studListUAS[index].teGrade
                                                  .toString()
                                      : teGradeController1[index].text;
                                  teGradeController[index].text.isEmpty
                                      ? teGradeController[index].text =
                                          value.studListUAS[index].teGrade ==
                                                  null
                                              ? teGradeController[index].text
                                              : value.studListUAS[index].teGrade
                                                  .toString()
                                      : teGradeController[index].text;

                                  return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      width: size.width,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: UIGuide.light_Purple,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: 80,
                                                  child: Text(
<<<<<<< HEAD
                                                    'Roll No: ${value.studListUAS[index].rollNo == null ? '' : value.studListUAS[index].rollNo.toString()}',
=======
                                                    'Roll No: ${value.studListUAS[index].rollNo == null ? '0' : value.studListUAS[index].rollNo.toString()}',
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                kWidth,
                                                kWidth,
                                                kWidth,
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10.0),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        if (value
                                                                .studListUAS[
                                                                    index]
                                                                .attendance ==
                                                            'A') {
                                                          value
                                                              .studListUAS[
                                                                  index]
                                                              .attendance = 'P';
                                                        } else {
                                                          value
                                                              .studListUAS[
                                                                  index]
                                                              .attendance = 'A';

                                                          value
                                                              .studListUAS[
                                                                  index]
                                                              .teGrade = null;
                                                          value
                                                              .studListUAS[
                                                                  index]
                                                              .teGradeId = null;

                                                          teGradeController[
                                                                  index]
                                                              .clear();
                                                          teGradeController1[
                                                                  index]
                                                              .clear();
                                                        }
                                                        attendancee = value
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
                                                          child: value
                                                                      .studListUAS[
                                                                          index]
                                                                      .attendance ==
                                                                  'A'
                                                              ? SvgPicture
                                                                  .asset(UIGuide
                                                                      .absent)
                                                              : SvgPicture
                                                                  .asset(UIGuide
                                                                      .present)),
                                                    ),
                                                  ),
                                                ),
                                                kWidth,
                                                kWidth,
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
                                                    strutStyle:
                                                        const StrutStyle(
                                                            fontSize: 12.0),
                                                    text: TextSpan(
                                                      style: const TextStyle(
                                                          color: UIGuide
                                                              .light_Purple),
                                                      text: value
                                                              .studListUAS[
                                                                  index]
                                                              .studentName ??
                                                          "",
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  LimitedBox(
                                                    maxWidth: 80,
                                                    child: Text(
                                                      '${value.teCaptionUAS ?? ""} : ',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 40,
                                                    width: 80,
                                                    child: SizedBox(
                                                      height: 40,
                                                      width: 100,
                                                      child: Consumer<
                                                              MarkEntryNewProvider>(
                                                          builder: (context,
                                                              snapshot, child) {
                                                        return InkWell(
                                                          onTap: () {
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return Dialog(
                                                                      child:
                                                                          LimitedBox(
                                                                    maxHeight:
                                                                        size.height /
                                                                            2,
                                                                    child: ListView.builder(
                                                                        shrinkWrap: true,
                                                                        itemCount: snapshot.gradeListUAS.length,
                                                                        itemBuilder: (context, indx) {
                                                                          return ListTile(
                                                                            selectedTileColor:
                                                                                Colors.blue.shade100,
                                                                            selectedColor:
                                                                                UIGuide.PRIMARY2,
                                                                            onTap:
                                                                                () {
                                                                              teGradeController[index].text = snapshot.gradeListUAS[indx].value ?? '--';
                                                                              teGradeController1[index].text = snapshot.gradeListUAS[indx].value ?? '--';
                                                                              value.studListUAS[index].teGrade = teGradeController1[index].text;
                                                                              value.studListUAS[index].teGrade = teGradeController[index].text;
                                                                              value.studListUAS[index].teGrade = value.studListUAS[index].teGrade;
                                                                              Navigator.of(context).pop();
                                                                            },
                                                                            title:
                                                                                Text(
                                                                              snapshot.gradeListUAS[indx].value ?? '--',
                                                                              textAlign: TextAlign.center,
                                                                            ),
                                                                          );
                                                                        }),
                                                                  ));
                                                                });
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(5.0),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Container(
                                                                  height: 30,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    border: Border.all(
                                                                        color: UIGuide
                                                                            .light_Purple,
                                                                        width:
                                                                            1),
                                                                  ),
                                                                  child:
                                                                      TextField(
<<<<<<< HEAD
                                                                    textInputAction:
                                                                        TextInputAction
                                                                            .next,
                                                                    enabled: value.studListUAS[index].attendance ==
                                                                                'A' ||
                                                                            value.examStatusUAS ==
                                                                                'Synchronized'
=======
                                                                    enabled: value.studListUAS[index].attendance ==
                                                                            'A'
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
                                                                        ? true
                                                                        : false,
                                                                    readOnly:
                                                                        true,
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        color: UIGuide
                                                                            .BLACK,
                                                                        overflow:
                                                                            TextOverflow.clip),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    controller:
                                                                        teGradeController[
                                                                            index],
                                                                    decoration:
                                                                        const InputDecoration(
                                                                      filled:
                                                                          true,
                                                                      contentPadding: EdgeInsets.only(
                                                                          left:
                                                                              0,
                                                                          top:
                                                                              0),
                                                                      floatingLabelBehavior:
                                                                          FloatingLabelBehavior
                                                                              .never,
                                                                      fillColor: Color.fromARGB(
                                                                          255,
                                                                          255,
                                                                          255,
                                                                          255),
                                                                      border:
                                                                          OutlineInputBorder(),
                                                                      labelText:
<<<<<<< HEAD
                                                                          "  Select ",
=======
                                                                          "  Select grade",
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
                                                                      hintText:
                                                                          "grade",
                                                                    ),
                                                                    onChanged:
                                                                        (value1) {
                                                                      teGradeController1[index].text = value
                                                                          .studListUAS[
                                                                              index]
                                                                          .teGrade
                                                                          .toString();
                                                                      teGradeController1[index]
                                                                              .text =
                                                                          value1;
                                                                    },
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      }),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                })),
                          ));
                    }

////\\\\\\\\\//-------------------------------------------------------------------------------------///////////////
///////////////-----------------------     PE Grade -----------------------------------------------///////////////
///////////////-----------------------------------------------------------------------------------///////////////
                    if (provider.teCaptionUAS == null &&
                        provider.peCaptionUAS != null &&
                        provider.ceCaptionUAS == null) {
                      return LimitedBox(
<<<<<<< HEAD
                          maxHeight: size.height / 1.81,
=======
                          maxHeight: size.height / 1.85,
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: value.studListUAS.length,
                                itemBuilder: ((context, index) {
                                  //Practical Grade
                                  praticalGradeController
                                      .add(TextEditingController());
                                  praticalGradeController1
                                      .add(TextEditingController());

                                  praticalGradeController1[index].text.isEmpty
                                      ? praticalGradeController1[index].text =
                                          value.studListUAS[index].peGrade ==
                                                  null
                                              ? praticalGradeController1[index]
                                                  .text
                                              : value.studListUAS[index].peGrade
                                                  .toString()
                                      : praticalGradeController1[index].text;
                                  praticalGradeController[index].text.isEmpty
                                      ? praticalGradeController[index].text =
                                          value.studListUAS[index].peGrade ==
                                                  null
                                              ? praticalGradeController[index]
                                                  .text
                                              : value.studListUAS[index].peGrade
                                                  .toString()
                                      : praticalGradeController[index].text;

                                  return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      width: size.width,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: UIGuide.light_Purple,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: 80,
                                                  child: Text(
<<<<<<< HEAD
                                                    'Roll No: ${value.studListUAS[index].rollNo == null ? '' : value.studListUAS[index].rollNo.toString()}',
=======
                                                    'Roll No: ${value.studListUAS[index].rollNo == null ? '0' : value.studListUAS[index].rollNo.toString()}',
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                kWidth,
                                                kWidth,
                                                kWidth,
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10.0),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        if (value
                                                                .studListUAS[
                                                                    index]
                                                                .attendance ==
                                                            'A') {
                                                          value
                                                              .studListUAS[
                                                                  index]
                                                              .attendance = 'P';
                                                        } else {
                                                          value
                                                              .studListUAS[
                                                                  index]
                                                              .attendance = 'A';

                                                          value
                                                              .studListUAS[
                                                                  index]
                                                              .peGrade = null;
                                                          value
                                                              .studListUAS[
                                                                  index]
                                                              .peGradeId = null;

                                                          praticalGradeController[
                                                                  index]
                                                              .clear();
                                                          praticalGradeController1[
                                                                  index]
                                                              .clear();
                                                        }
                                                        attendancee = value
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
                                                          child: value
                                                                      .studListUAS[
                                                                          index]
                                                                      .attendance ==
                                                                  'A'
                                                              ? SvgPicture
                                                                  .asset(UIGuide
                                                                      .absent)
                                                              : SvgPicture
                                                                  .asset(UIGuide
                                                                      .present)),
                                                    ),
                                                  ),
                                                ),
                                                kWidth,
                                                kWidth,
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
                                                    strutStyle:
                                                        const StrutStyle(
                                                            fontSize: 12.0),
                                                    text: TextSpan(
                                                      style: const TextStyle(
                                                          color: UIGuide
                                                              .light_Purple),
                                                      text: value
                                                              .studListUAS[
                                                                  index]
                                                              .studentName ??
                                                          "",
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  LimitedBox(
                                                    maxWidth: 80,
                                                    child: Text(
                                                      '${value.peCaptionUAS ?? ""} : ',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 40,
                                                    width: 80,
                                                    child: SizedBox(
                                                      height: 40,
                                                      width: 100,
                                                      child: Consumer<
                                                              MarkEntryNewProvider>(
                                                          builder: (context,
                                                              snapshot, child) {
                                                        return InkWell(
                                                          onTap: () {
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return Dialog(
                                                                      child:
                                                                          LimitedBox(
                                                                    maxHeight:
                                                                        size.height /
                                                                            2,
                                                                    child: ListView.builder(
                                                                        shrinkWrap: true,
                                                                        itemCount: snapshot.gradeListUAS.length,
                                                                        itemBuilder: (context, indx) {
                                                                          return ListTile(
                                                                            selectedTileColor:
                                                                                Colors.blue.shade100,
                                                                            selectedColor:
                                                                                UIGuide.PRIMARY2,
                                                                            onTap:
                                                                                () {
                                                                              praticalGradeController[index].text = snapshot.gradeListUAS[indx].value ?? '--';
                                                                              praticalGradeController1[index].text = snapshot.gradeListUAS[indx].value ?? '--';
                                                                              value.studListUAS[index].peGrade = praticalGradeController1[index].text;
                                                                              value.studListUAS[index].peGrade = praticalGradeController[index].text;
                                                                              value.studListUAS[index].peGrade = value.studListUAS[index].peGrade;
                                                                              Navigator.of(context).pop();
                                                                            },
                                                                            title:
                                                                                Text(
                                                                              snapshot.gradeListUAS[indx].text ?? '--',
                                                                              textAlign: TextAlign.center,
                                                                            ),
                                                                          );
                                                                        }),
                                                                  ));
                                                                });
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(5.0),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Container(
                                                                  height: 30,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    border: Border.all(
                                                                        color: UIGuide
                                                                            .light_Purple,
                                                                        width:
                                                                            1),
                                                                  ),
                                                                  child:
                                                                      TextField(
<<<<<<< HEAD
                                                                    textInputAction:
                                                                        TextInputAction
                                                                            .next,
=======
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        color: UIGuide
                                                                            .BLACK,
                                                                        overflow:
                                                                            TextOverflow.clip),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    controller:
                                                                        praticalGradeController[
                                                                            index],
                                                                    decoration:
                                                                        const InputDecoration(
                                                                      filled:
                                                                          true,
                                                                      contentPadding: EdgeInsets.only(
                                                                          left:
                                                                              0,
                                                                          top:
                                                                              0),
                                                                      floatingLabelBehavior:
                                                                          FloatingLabelBehavior
                                                                              .never,
                                                                      fillColor: Color.fromARGB(
                                                                          255,
                                                                          255,
                                                                          255,
                                                                          255),
                                                                      border:
                                                                          OutlineInputBorder(),
                                                                      labelText:
<<<<<<< HEAD
                                                                          "  Select ",
=======
                                                                          "  Select grade",
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
                                                                      hintText:
                                                                          "grade",
                                                                    ),
                                                                    enabled: value.studListUAS[index].attendance ==
<<<<<<< HEAD
                                                                                'A' ||
                                                                            value.examStatusUAS ==
                                                                                'Synchronized'
=======
                                                                            'A'
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
                                                                        ? true
                                                                        : false,
                                                                    readOnly:
                                                                        true,
                                                                    onChanged:
                                                                        (value1) {
                                                                      praticalGradeController1[index].text = value
                                                                          .studListUAS[
                                                                              index]
                                                                          .peGrade
                                                                          .toString();
                                                                      praticalGradeController1[index]
                                                                              .text =
                                                                          value1;
                                                                    },
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      }),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                })),
                          ));
                    }

///////////////-------------------------------------------------------------------------------------///////////////
///////////////-----------------------       CE Grade  --------------------------------------------///////////////
///////////////-----------------------------------------------------------------------------------///////////////
                    if (provider.teCaptionUAS == null &&
                        provider.peCaptionUAS == null &&
                        provider.ceCaptionUAS != null) {
                      return LimitedBox(
<<<<<<< HEAD
                          maxHeight: size.height / 1.81,
=======
                          maxHeight: size.height / 1.85,
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: value.studListUAS.length,
                                itemBuilder: ((context, index) {
                                  //CE Grade
                                  ceGradeController
                                      .add(TextEditingController());
                                  ceGradeController1
                                      .add(TextEditingController());

                                  ceGradeController1[index].text.isEmpty
                                      ? ceGradeController1[index].text =
                                          value.studListUAS[index].ceGrade ==
                                                  null
                                              ? ceGradeController1[index].text
                                              : value.studListUAS[index].ceGrade
                                                  .toString()
                                      : ceGradeController1[index].text;
                                  ceGradeController[index].text.isEmpty
                                      ? ceGradeController[index].text =
                                          value.studListUAS[index].ceGrade ==
                                                  null
                                              ? ceGradeController[index].text
                                              : value.studListUAS[index].ceGrade
                                                  .toString()
                                      : ceGradeController[index].text;

                                  return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      width: size.width,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: UIGuide.light_Purple,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: 80,
                                                  child: Text(
<<<<<<< HEAD
                                                    'Roll No: ${value.studListUAS[index].rollNo == null ? '' : value.studListUAS[index].rollNo.toString()}',
=======
                                                    'Roll No: ${value.studListUAS[index].rollNo == null ? '0' : value.studListUAS[index].rollNo.toString()}',
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                kWidth,
                                                kWidth,
                                                kWidth,
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10.0),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        if (value
                                                                .studListUAS[
                                                                    index]
                                                                .attendance ==
                                                            'A') {
                                                          value
                                                              .studListUAS[
                                                                  index]
                                                              .attendance = 'P';
                                                        } else {
                                                          value
                                                              .studListUAS[
                                                                  index]
                                                              .attendance = 'A';

                                                          value
                                                              .studListUAS[
                                                                  index]
                                                              .ceGrade = null;
                                                          value
                                                              .studListUAS[
                                                                  index]
                                                              .ceGradeId = null;

                                                          ceGradeController[
                                                                  index]
                                                              .clear();
                                                          ceGradeController1[
                                                                  index]
                                                              .clear();
                                                        }
                                                        attendancee = value
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
                                                          child: value
                                                                      .studListUAS[
                                                                          index]
                                                                      .attendance ==
                                                                  'A'
                                                              ? SvgPicture
                                                                  .asset(UIGuide
                                                                      .absent)
                                                              : SvgPicture
                                                                  .asset(UIGuide
                                                                      .present)),
                                                    ),
                                                  ),
                                                ),
                                                kWidth,
                                                kWidth,
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
                                                    strutStyle:
                                                        const StrutStyle(
                                                            fontSize: 12.0),
                                                    text: TextSpan(
                                                      style: const TextStyle(
                                                          color: UIGuide
                                                              .light_Purple),
                                                      text: value
                                                              .studListUAS[
                                                                  index]
                                                              .studentName ??
                                                          "",
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  LimitedBox(
                                                    maxWidth: 80,
                                                    child: Text(
                                                      '${value.ceCaptionUAS ?? ""} : ',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 40,
                                                    width: 80,
                                                    child: SizedBox(
                                                      height: 40,
                                                      width: 100,
                                                      child: Consumer<
                                                              MarkEntryNewProvider>(
                                                          builder: (context,
                                                              snapshot, child) {
                                                        return InkWell(
                                                          onTap: () {
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return Dialog(
                                                                      child:
                                                                          LimitedBox(
                                                                    maxHeight:
                                                                        size.height /
                                                                            2,
                                                                    child: ListView.builder(
                                                                        shrinkWrap: true,
                                                                        itemCount: snapshot.gradeListUAS.length,
                                                                        itemBuilder: (context, indx) {
                                                                          return ListTile(
                                                                            selectedTileColor:
                                                                                Colors.blue.shade100,
                                                                            selectedColor:
                                                                                UIGuide.PRIMARY2,
                                                                            onTap:
                                                                                () {
                                                                              ceGradeController[index].text = snapshot.gradeListUAS[indx].value ?? '--';
                                                                              ceGradeController1[index].text = snapshot.gradeListUAS[indx].value ?? '--';
                                                                              value.studListUAS[index].ceGrade = ceGradeController1[index].text;
                                                                              value.studListUAS[index].ceGrade = ceGradeController[index].text;
                                                                              value.studListUAS[index].ceGrade = value.studListUAS[index].ceGrade;
                                                                              Navigator.of(context).pop();
                                                                            },
                                                                            title:
                                                                                Text(
                                                                              snapshot.gradeListUAS[indx].text ?? '--',
                                                                              textAlign: TextAlign.center,
                                                                            ),
                                                                          );
                                                                        }),
                                                                  ));
                                                                });
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(5.0),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Container(
                                                                  height: 30,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    border: Border.all(
                                                                        color: UIGuide
                                                                            .light_Purple,
                                                                        width:
                                                                            1),
                                                                  ),
                                                                  child:
                                                                      TextField(
<<<<<<< HEAD
                                                                    textInputAction:
                                                                        TextInputAction
                                                                            .next,
=======
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        color: UIGuide
                                                                            .BLACK,
                                                                        overflow:
                                                                            TextOverflow.clip),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    controller:
                                                                        ceGradeController[
                                                                            index],
                                                                    decoration:
                                                                        const InputDecoration(
                                                                      filled:
                                                                          true,
                                                                      contentPadding: EdgeInsets.only(
                                                                          left:
                                                                              0,
                                                                          top:
                                                                              0),
                                                                      floatingLabelBehavior:
                                                                          FloatingLabelBehavior
                                                                              .never,
                                                                      fillColor: Color.fromARGB(
                                                                          255,
                                                                          255,
                                                                          255,
                                                                          255),
                                                                      border:
                                                                          OutlineInputBorder(),
                                                                      labelText:
<<<<<<< HEAD
                                                                          "  Select ",
=======
                                                                          "  Select grade",
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
                                                                      hintText:
                                                                          "grade",
                                                                    ),
                                                                    enabled: value.studListUAS[index].attendance ==
<<<<<<< HEAD
                                                                                'A' ||
                                                                            value.examStatusUAS ==
                                                                                'Synchronized'
=======
                                                                            'A'
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
                                                                        ? true
                                                                        : false,
                                                                    readOnly:
                                                                        true,
                                                                    onChanged:
                                                                        (value1) {
                                                                      ceGradeController1[index].text = value
                                                                          .studListUAS[
                                                                              index]
                                                                          .ceGrade
                                                                          .toString();
                                                                      ceGradeController1[index]
                                                                              .text =
                                                                          value1;
                                                                    },
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      }),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                })),
                          ));
                    } else {
                      return Container(
                        height: 0,
                        width: 0,
                      );
                    }
                  } else {
                    return const SizedBox(
                      height: 0,
                      width: 0,
                    );
                  }
                })
              ]);
      }),
      bottomNavigationBar: BottomAppBar(
<<<<<<< HEAD
        child: Consumer<MarkEntryNewProvider>(
          builder: (context, sync, _) => sync.examStatusUAS == "Synchronized"
              ? SizedBox(
                  height: 50,
                  child: Center(
                    child: Text(
                      "Mark Entry Downloaded",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: UIGuide.light_Purple),
                    ),
                  ),
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    kWidth,
                    const Spacer(),
                    Consumer<MarkEntryNewProvider>(
                        builder: (context, value, child) {
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
                                List marrkk = [];
                                obj.clear();
                                marrkk.clear();
                                print(
                                    "---------------${value.studListUAS.length}");
                                print(obj.length);
                                print(value.tabulationTypeCode);
                                print(value.entryMethodUAS);

                                if (value.tabulationTypeCode == "UAS" &&
                                    value.teCaptionUAS == "Mark") {
                                  for (int i = 0;
                                      i < value.studListUAS.length;
                                      i++) {
                                    obj.add(
                                      {
                                        "attendance":
                                            value.studListUAS[i].attendance,
                                        "studentName":
                                            value.studListUAS[i].studentName,
                                        "rollNo": value.studListUAS[i].rollNo,
                                        "studentId":
                                            value.studListUAS[i].studentId,
                                        "markEntryDetId":
                                            value.studListUAS[i].markEntryDetId,
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
                                        "tabMarkEntryId":
                                            value.studListUAS[i].tabMarkEntryId,
                                        "isEdited": false,
                                        "isDisabled": false
                                      },
                                    );
                                    marrkk.add(_controllers[i].text.toString());
                                    print("""""" """""" "");
                                  }
                                  if (marrkk.isEmpty) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      elevation: 10,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      duration: Duration(seconds: 1),
                                      margin: EdgeInsets.only(
                                          bottom: 80, left: 30, right: 30),
                                      behavior: SnackBarBehavior.floating,
                                      content: Text(
                                        "enter mark...!",
                                        textAlign: TextAlign.center,
                                      ),
                                    ));
                                  }
                                } else if (value.tabulationTypeCode == "UAS" &&
                                    value.teCaptionUAS == "Grade") {
                                  for (int i = 0;
                                      i < value.studListUAS.length;
                                      i++) {
                                    obj.add(
                                      {
                                        "attendance":
                                            value.studListUAS[i].attendance,
                                        "studentName":
                                            value.studListUAS[i].studentName,
                                        "rollNo": value.studListUAS[i].rollNo,
                                        "studentId":
                                            value.studListUAS[i].studentId,
                                        "markEntryDetId":
                                            value.studListUAS[i].markEntryDetId,
                                        "teMark": null,
                                        "peMark": null,
                                        "ceMark": null,
                                        "teGrade": value.studListUAS[i].teGrade,
                                        "peGrade": null,
                                        "ceGrade": null,
                                        "total": null,
                                        "teGradeId": null,
                                        "peGradeId": null,
                                        "ceGradeId": null,
                                        "tabMarkEntryId":
                                            value.studListUAS[i].tabMarkEntryId,
                                        "isEdited": false,
                                        "isDisabled": false
                                      },
                                    );
                                  }
                                } else if (value.tabulationTypeCode == "PBT" &&
                                    value.teCaptionUAS == "Grade") {
                                  for (int i = 0;
                                      i < value.studListUAS.length;
                                      i++) {
                                    obj.add(
                                      {
                                        "attendance":
                                            value.studListUAS[i].attendance,
                                        "studentName":
                                            value.studListUAS[i].studentName,
                                        "rollNo": value.studListUAS[i].rollNo,
                                        "studentId":
                                            value.studListUAS[i].studentId,
                                        "markEntryDetId":
                                            value.studListUAS[i].markEntryDetId,
                                        "teMark": null,
                                        "peMark": null,
                                        "ceMark": null,
                                        "teGrade": value.studListUAS[i].teGrade,
                                        "peGrade": null,
                                        "ceGrade": null,
                                        "total": null,
                                        "teGradeId": null,
                                        "peGradeId": null,
                                        "ceGradeId": null,
                                        "tabMarkEntryId":
                                            value.studListUAS[i].tabMarkEntryId,
                                        "isEdited": false,
                                        "isDisabled": false
                                      },
                                    );
                                  }
                                } else if ((value.tabulationTypeCode == "PBT" ||
                                        value.tabulationTypeCode == "STATE") &&
                                    value.entryMethodUAS == "Mark") {
                                  for (int i = 0;
                                      i < value.studListUAS.length;
                                      i++) {
                                    obj.add(
                                      {
                                        "attendance":
                                            value.studListUAS[i].attendance,
                                        "studentName":
                                            value.studListUAS[i].studentName,
                                        "rollNo": value.studListUAS[i].rollNo,
                                        "studentId":
                                            value.studListUAS[i].studentId,
                                        "markEntryDetId":
                                            value.studListUAS[i].markEntryDetId,
                                        "teMark":
                                            teMarkController[i].text.isEmpty
                                                ? null
                                                : teMarkController[i]
                                                    .text
                                                    .toString(),
                                        "peMark": practicalMarkController[i]
                                                .text
                                                .isEmpty
                                            ? null
                                            : practicalMarkController[i]
                                                .text
                                                .toString(),
                                        "ceMark":
                                            ceMarkController[i].text.isEmpty
                                                ? null
                                                : ceMarkController[i]
                                                    .text
                                                    .toString(),
                                        "teGrade": value.studListUAS[i].teGrade,
                                        "peGrade": null,
                                        "ceGrade": null,
                                        "total": "",
                                        "teGradeId": null,
                                        "peGradeId": null,
                                        "ceGradeId": null,
                                        "tabMarkEntryId":
                                            value.studListUAS[i].tabMarkEntryId,
                                        "isEdited": false,
                                        "isDisabled": false
                                      },
                                    );
                                  }
                                } else if ((value.tabulationTypeCode ==
                                        "STATE") &&
                                    value.entryMethodUAS == "Grade") {
                                  for (int i = 0;
                                      i < value.studListUAS.length;
                                      i++) {
                                    obj.add(
                                      {
                                        "attendance":
                                            value.studListUAS[i].attendance,
                                        "studentName":
                                            value.studListUAS[i].studentName,
                                        "rollNo": value.studListUAS[i].rollNo,
                                        "studentId":
                                            value.studListUAS[i].studentId,
                                        "markEntryDetId":
                                            value.studListUAS[i].markEntryDetId,
                                        "teMark": null,
                                        "peMark": null,
                                        "ceMark": null,
                                        "teGrade": value.studListUAS[i].teGrade,
                                        "peGrade": value.studListUAS[i].peGrade,
                                        "ceGrade": value.studListUAS[i].ceGrade,
                                        "total": null,
                                        "teGradeId": null,
                                        "peGradeId": null,
                                        "ceGradeId": null,
                                        "tabMarkEntryId":
                                            value.studListUAS[i].tabMarkEntryId,
                                        "isEdited": false,
                                        "isDisabled": false
                                      },
                                    );
                                  }
                                } else {
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
                                      "Something went wrong...!",
                                      textAlign: TextAlign.center,
                                    ),
                                  ));
                                }

                                // //log("Litsssss   $obj");

                                if (markEntryDivisionListController
                                        .text.isEmpty &&
                                    markEntryInitialValuesController
                                        .text.isEmpty) {
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
                                } else if (obj.isEmpty) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    duration: Duration(seconds: 2),
                                    margin: EdgeInsets.only(
                                        bottom: 80, left: 30, right: 30),
                                    behavior: SnackBarBehavior.floating,
                                    content: Text(
                                      "Please enter mark",
                                      textAlign: TextAlign.center,
                                    ),
                                  ));
                                } else {
                                  if (value.tabulationTypeCode == "UAS") {
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
                                            value.peMax.toString(),
                                            value.ceMax.toString(),
                                            value.teCaptionUAS.toString(),
                                            value.peCaptionUAS.toString(),
                                            value.ceCaptionUAS.toString(),
                                            value.examStatusUAS.toString(),
                                            context,
                                            date!,
                                            obj,
                                            value.gradeListUAS,
                                            value.partsUAS);
                                    value.examStatusUAS = "Entered";
                                  } else {
                                    value.loadSave
                                        ? spinkitLoader()
                                        : await value.markEntrySTATESave(
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
                                            value.peMax.toString(),
                                            value.ceMax.toString(),
                                            value.teCaptionUAS.toString(),
                                            value.peCaptionUAS.toString(),
                                            value.ceCaptionUAS.toString(),
                                            value.examStatusUAS.toString(),
                                            context,
                                            date!,
                                            obj,
                                            value.gradeListUAS,
                                            value.partsUAS);
                                    value.examStatusUAS = "Entered";
                                  }
                                }
=======
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
                        print("---------------${value.studListUAS.length}");
                        print(obj.length);
                        print(value.tabulationTypeCode);
                        print(value.entryMethodUAS);

                        if (value.tabulationTypeCode == "UAS" &&
                            value.teCaptionUAS == "Mark") {
                          for (int i = 0; i < value.studListUAS.length; i++) {
                            obj.add(
                              {
                                "attendance": value.studListUAS[i].attendance,
                                "studentName": value.studListUAS[i].studentName,
                                "rollNo": value.studListUAS[i].rollNo,
                                "studentId": value.studListUAS[i].studentId,
                                "markEntryDetId":
                                    value.studListUAS[i].markEntryDetId,
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
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
                              },
                              color: UIGuide.light_Purple,
                              child: const Text(
                                'Save',
                                style: TextStyle(color: Colors.white),
                              ),
                            );
<<<<<<< HEAD
                    }),
                    kWidth,
                    //  Consumer<MarkEntryNewProvider>(builder: (context, value, child) {

                    kWidth,
                    Consumer<MarkEntryNewProvider>(
                        builder: (context, value, child) {
                      return value.loadVerify
                          ? MaterialButton(
                              onPressed: () {},
                              color: UIGuide.light_Purple,
                              child: const Text(
                                'Verifying...',
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          : MaterialButton(
                              disabledColor: UIGuide.THEME_LIGHT,
                              onPressed: () {
                                value.examStatusUAS == "Verified" ||
                                        value.examStatusUAS == "Pending"
                                    ? ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                        elevation: 10,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
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
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    child: OutlinedButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      style: ButtonStyle(
                                                          side: MaterialStateProperty
                                                              .all(const BorderSide(
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

                                                      // if (value.tabulationTypeCode ==
                                                      //         "UAS" &&
                                                      //     value.teCaptionUAS ==
                                                      //         "Mark") {
                                                      for (int i = 0;
                                                          i <
                                                              value.studListUAS
                                                                  .length;
                                                          i++) {
                                                        obj.add(
                                                          {
                                                            "attendance": value
                                                                .studListUAS[i]
                                                                .attendance,
                                                            "studentName": value
                                                                .studListUAS[i]
                                                                .studentName,
                                                            "rollNo": value
                                                                .studListUAS[i]
                                                                .rollNo,
                                                            "studentId": value
                                                                .studListUAS[i]
                                                                .studentId,
                                                            "markEntryDetId": value
                                                                .studListUAS[i]
                                                                .markEntryDetId,
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
                                                                .teGrade,
                                                            "peGrade": value
                                                                .studListUAS[i]
                                                                .peGrade,
                                                            "ceGrade": value
                                                                .studListUAS[i]
                                                                .ceGrade,
                                                            "total": value
                                                                .studListUAS[i]
                                                                .total,
                                                            "teGradeId": value
                                                                .studListUAS[i]
                                                                .teGradeId,
                                                            "peGradeId": value
                                                                .studListUAS[i]
                                                                .peGradeId,
                                                            "ceGradeId": value
                                                                .studListUAS[i]
                                                                .ceGradeId,
                                                            "tabMarkEntryId": value
                                                                .studListUAS[i]
                                                                .tabMarkEntryId,
                                                            "isEdited": false,
                                                            "isDisabled": false
                                                          },
                                                        );
                                                      }
                                                      // }

                                                      if (markEntryDivisionListController
                                                              .text.isEmpty &&
                                                          markEntryInitialValuesController
                                                              .text.isEmpty) {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                const SnackBar(
                                                          elevation: 10,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            10)),
                                                          ),
                                                          duration: Duration(
                                                              seconds: 1),
                                                          margin:
                                                              EdgeInsets.only(
                                                                  bottom: 80,
                                                                  left: 30,
                                                                  right: 30),
                                                          behavior:
                                                              SnackBarBehavior
                                                                  .floating,
                                                          content: Text(
                                                            "Select mandatory fields...!",
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ));
                                                      } else if (obj.isEmpty) {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                const SnackBar(
                                                          elevation: 10,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            10)),
                                                          ),
                                                          duration: Duration(
                                                              seconds: 2),
                                                          margin:
                                                              EdgeInsets.only(
                                                                  bottom: 80,
                                                                  left: 30,
                                                                  right: 30),
                                                          behavior:
                                                              SnackBarBehavior
                                                                  .floating,
                                                          content: Text(
                                                            "No data to verify",
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ));
                                                      } else {
                                                        value.loadVerify
                                                            ? spinkitLoader()
                                                            : await value.markEntryVerify(
                                                                value
                                                                    .markEntryIdUAS
                                                                    .toString(),
                                                                value
                                                                    .schoolIdUAS
                                                                    .toString(),
                                                                value
                                                                    .tabulationTypeCode
                                                                    .toString(),
                                                                value
                                                                    .subjectCaptionUAS
                                                                    .toString(),
                                                                value
                                                                    .divisionUAS
                                                                    .toString(),
                                                                value.courseUAS
                                                                    .toString(),
                                                                value.partUAS
                                                                    .toString(),
                                                                value.subjectUAS
                                                                    .toString(),
                                                                value
                                                                    .subSubjectUAS
                                                                    .toString(),
                                                                value
                                                                    .optionSubjectUAS
                                                                    .toString(),
                                                                value
                                                                    .staffIdUAS
                                                                    .toString(),
                                                                value
                                                                    .staffNameUAS
                                                                    .toString(),
                                                                value
                                                                    .entryMethodUAS
                                                                    .toString(),
                                                                value
                                                                    .examUAS
                                                                    .toString(),
                                                                value
                                                                    .includeTerminatedStudentsUAS,
                                                                value
                                                                    .teMax
                                                                    .toString(),
                                                                value
                                                                    .peMax
                                                                    .toString(),
                                                                value.ceMax
                                                                    .toString(),
                                                                value
                                                                    .teCaptionUAS
                                                                    .toString(),
                                                                value
                                                                    .peCaptionUAS
                                                                    .toString(),
                                                                value
                                                                    .ceCaptionUAS
                                                                    .toString(),
                                                                value
                                                                    .examStatusUAS
                                                                    .toString(),
                                                                context,
                                                                date!,
                                                                obj,
                                                                value
                                                                    .gradeListUAS,
                                                                value.partsUAS);
                                                        value.examStatusUAS =
                                                            "Verified";
                                                      }
                                                      Navigator.pop(context);
                                                    },
                                                    style: ButtonStyle(
                                                        side: MaterialStateProperty
                                                            .all(const BorderSide(
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
                                'Verify',
                                style: TextStyle(color: Colors.white),
                              ),
                            );
                    }),
                    kWidth,
                    Consumer<MarkEntryNewProvider>(
                        builder: (context, value, child) {
                      return MaterialButton(
                        onPressed: () {
                          value.examStatusUAS == "Pending"
                              ? ScaffoldMessenger.of(context)
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
=======
                          }
                        } else if (value.tabulationTypeCode == "UAS" &&
                            value.teCaptionUAS == "Grade") {
                          for (int i = 0; i < value.studListUAS.length; i++) {
                            obj.add(
                              {
                                "attendance": value.studListUAS[i].attendance,
                                "studentName": value.studListUAS[i].studentName,
                                "rollNo": value.studListUAS[i].rollNo,
                                "studentId": value.studListUAS[i].studentId,
                                "markEntryDetId":
                                    value.studListUAS[i].markEntryDetId,
                                "teMark": null,
                                "peMark": null,
                                "ceMark": null,
                                "teGrade": value.studListUAS[i].teGrade,
                                "peGrade": null,
                                "ceGrade": null,
                                "total": null,
                                "teGradeId": null,
                                "peGradeId": null,
                                "ceGradeId": null,
                                "tabMarkEntryId": null,
                                "isEdited": false,
                                "isDisabled": false
                              },
                            );
                          }
                        } else if (value.tabulationTypeCode == "PBT" &&
                            value.teCaptionUAS == "Grade") {
                          for (int i = 0; i < value.studListUAS.length; i++) {
                            obj.add(
                              {
                                "attendance": value.studListUAS[i].attendance,
                                "studentName": value.studListUAS[i].studentName,
                                "rollNo": value.studListUAS[i].rollNo,
                                "studentId": value.studListUAS[i].studentId,
                                "markEntryDetId":
                                    value.studListUAS[i].markEntryDetId,
                                "teMark": null,
                                "peMark": null,
                                "ceMark": null,
                                "teGrade": value.studListUAS[i].teGrade,
                                "peGrade": null,
                                "ceGrade": null,
                                "total": null,
                                "teGradeId": null,
                                "peGradeId": null,
                                "ceGradeId": null,
                                "tabMarkEntryId": null,
                                "isEdited": false,
                                "isDisabled": false
                              },
                            );
                          }
                        } else if ((value.tabulationTypeCode == "PBT" ||
                                value.tabulationTypeCode == "STATE") &&
                            value.entryMethodUAS == "Mark") {
                          for (int i = 0; i < value.studListUAS.length; i++) {
                            obj.add(
                              {
                                "attendance": value.studListUAS[i].attendance,
                                "studentName": value.studListUAS[i].studentName,
                                "rollNo": value.studListUAS[i].rollNo,
                                "studentId": value.studListUAS[i].studentId,
                                "markEntryDetId":
                                    value.studListUAS[i].markEntryDetId,
                                "teMark": teMarkController[i].text.isEmpty
                                    ? null
                                    : teMarkController[i].text.toString(),
                                "peMark":
                                    practicalMarkController[i].text.isEmpty
                                        ? null
                                        : practicalMarkController[i]
                                            .text
                                            .toString(),
                                "ceMark": ceMarkController[i].text.isEmpty
                                    ? null
                                    : ceMarkController[i].text.toString(),
                                "teGrade": value.studListUAS[i].teGrade,
                                "peGrade": null,
                                "ceGrade": null,
                                "total": "",
                                "teGradeId": null,
                                "peGradeId": null,
                                "ceGradeId": null,
                                "tabMarkEntryId": null,
                                "isEdited": false,
                                "isDisabled": false
                              },
                            );
                          }
                        } else if ((value.tabulationTypeCode == "STATE") &&
                            value.entryMethodUAS == "Grade") {
                          for (int i = 0; i < value.studListUAS.length; i++) {
                            obj.add(
                              {
                                "attendance": value.studListUAS[i].attendance,
                                "studentName": value.studListUAS[i].studentName,
                                "rollNo": value.studListUAS[i].rollNo,
                                "studentId": value.studListUAS[i].studentId,
                                "markEntryDetId":
                                    value.studListUAS[i].markEntryDetId,
                                "teMark": null,
                                "peMark": null,
                                "ceMark": null,
                                "teGrade": value.studListUAS[i].teGrade,
                                "peGrade": value.studListUAS[i].peGrade,
                                "ceGrade": value.studListUAS[i].ceGrade,
                                "total": null,
                                "teGradeId": null,
                                "peGradeId": null,
                                "ceGradeId": null,
                                "tabMarkEntryId": null,
                                "isEdited": false,
                                "isDisabled": false
                              },
                            );
                          }
                        } else {
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
                              "Something went wrong...!",
                              textAlign: TextAlign.center,
                            ),
                          ));
                        }

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
                        } else if (obj.isEmpty) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            duration: Duration(seconds: 2),
                            margin: EdgeInsets.only(
                                bottom: 80, left: 30, right: 30),
                            behavior: SnackBarBehavior.floating,
                            content: Text(
                              "Please enter mark",
                              textAlign: TextAlign.center,
                            ),
                          ));
                        } else {
                          if (value.tabulationTypeCode == "UAS") {
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
                                    value.peMax.toString(),
                                    value.ceMax.toString(),
                                    value.teCaptionUAS.toString(),
                                    value.peCaptionUAS.toString(),
                                    value.ceCaptionUAS.toString(),
                                    value.examStatusUAS.toString(),
                                    context,
                                    date!,
                                    obj,
                                    value.gradeListUAS,
                                    value.partsUAS);
                            value.examStatusUAS = "Entered";
                          } else {
                            value.loadSave
                                ? spinkitLoader()
                                : await value.markEntrySTATESave(
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
                                    value.peMax.toString(),
                                    value.ceMax.toString(),
                                    value.teCaptionUAS.toString(),
                                    value.peCaptionUAS.toString(),
                                    value.ceCaptionUAS.toString(),
                                    value.examStatusUAS.toString(),
                                    context,
                                    date!,
                                    obj,
                                    value.gradeListUAS,
                                    value.partsUAS);
                            value.examStatusUAS = "Entered";
                          }
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
            //  Consumer<MarkEntryNewProvider>(builder: (context, value, child) {

            kWidth,
            Consumer<MarkEntryNewProvider>(builder: (context, value, child) {
              return value.loadVerify
                  ? MaterialButton(
                      onPressed: () {},
                      color: UIGuide.light_Purple,
                      child: const Text(
                        'Verifying...',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  : MaterialButton(
                      onPressed: () {
                        value.examStatusUAS == "Verified"
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
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
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
                                                    side: MaterialStateProperty
                                                        .all(const BorderSide(
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

                                                for (int i = 0;
                                                    i <
                                                        value
                                                            .studListUAS.length;
                                                    i++) {
                                                  obj.add(
                                                    {
                                                      "attendance": value
                                                          .studListUAS[i]
                                                          .attendance,
                                                      "studentName": value
                                                          .studListUAS[i]
                                                          .studentName,
                                                      "rollNo": value
                                                          .studListUAS[i]
                                                          .rollNo,
                                                      "studentId": value
                                                          .studListUAS[i]
                                                          .studentId,
                                                      "markEntryDetId": value
                                                          .studListUAS[i]
                                                          .markEntryDetId,
                                                      "teMark": value
                                                          .studListUAS[i]
                                                          .teMark,
                                                      "peMark": null,
                                                      "ceMark": null,
                                                      "teGrade": null,
                                                      "peGrade": null,
                                                      "ceGrade": null,
                                                      "total": value
                                                          .studListUAS[i].total,
                                                      "teGradeId": null,
                                                      "peGradeId": null,
                                                      "ceGradeId": null,
                                                      "tabMarkEntryId": null,
                                                      "isEdited": false,
                                                      "isDisabled": false
                                                    },
                                                  );
                                                }

                                                if (markEntryDivisionListController
                                                        .text.isEmpty &&
                                                    markEntryInitialValuesController
                                                        .text.isEmpty) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                          const SnackBar(
                                                    elevation: 10,
                                                    shape:
                                                        RoundedRectangleBorder(
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
                                                    behavior: SnackBarBehavior
                                                        .floating,
                                                    content: Text(
                                                      "Select mandatory fields...!",
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ));
                                                } else if (obj.isEmpty) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                          const SnackBar(
                                                    elevation: 10,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10)),
                                                    ),
                                                    duration:
                                                        Duration(seconds: 2),
                                                    margin: EdgeInsets.only(
                                                        bottom: 80,
                                                        left: 30,
                                                        right: 30),
                                                    behavior: SnackBarBehavior
                                                        .floating,
                                                    content: Text(
                                                      "No data to delete",
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ));
                                                } else {
                                                  if (value
                                                          .tabulationTypeCode ==
                                                      "UAS") {
                                                    value.loadDelete
                                                        ? spinkitLoader()
                                                        : await value.markEntryUASDelete(
                                                            value.markEntryIdUAS
                                                                .toString(),
                                                            value.schoolIdUAS
                                                                .toString(),
                                                            value.tabulationTypeCode
                                                                .toString(),
                                                            value
                                                                .subjectCaptionUAS
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
                                                            value
                                                                .optionSubjectUAS
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
                                                            value.teMax
                                                                .toString(),
                                                            value.peMax
                                                                .toString(),
                                                            value.ceMax
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
                                                            date!,
                                                            obj,
                                                            value.gradeListUAS,
                                                            value.partsUAS);
                                                    value.examStatusUAS =
                                                        "Pending";
                                                  } else {
                                                    value.loadDelete
                                                        ? spinkitLoader()
                                                        : await value.markEntrySTATEDelete(
                                                            value.markEntryIdUAS
                                                                .toString(),
                                                            value.schoolIdUAS
                                                                .toString(),
                                                            value.tabulationTypeCode
                                                                .toString(),
                                                            value
                                                                .subjectCaptionUAS
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
                                                            value
                                                                .optionSubjectUAS
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
                                                            value.teMax
                                                                .toString(),
                                                            value.peMax
                                                                .toString(),
                                                            value.ceMax
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
                                                            date!,
                                                            obj,
                                                            value.gradeListUAS,
                                                            value.partsUAS);
                                                    value.examStatusUAS =
                                                        "Pending";
                                                  }
                                                }

                                                Navigator.pop(context);
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
                                                'Confirm',
                                                style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 12, 162, 46),
                                                ),
                                              ),
                                            ),
<<<<<<< HEAD
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
=======
                                          ),
                                          OutlinedButton(
                                            onPressed: () async {
                                              List obj = [];
                                              obj.clear();

                                              // if (value.tabulationTypeCode ==
                                              //         "UAS" &&
                                              //     value.teCaptionUAS ==
                                              //         "Mark") {
                                              for (int i = 0;
                                                  i < value.studListUAS.length;
                                                  i++) {
                                                obj.add(
                                                  {
                                                    "attendance": value
                                                        .studListUAS[i]
                                                        .attendance,
                                                    "studentName": value
                                                        .studListUAS[i]
                                                        .studentName,
                                                    "rollNo": value
                                                        .studListUAS[i].rollNo,
                                                    "studentId": value
                                                        .studListUAS[i]
                                                        .studentId,
                                                    "markEntryDetId": value
                                                        .studListUAS[i]
                                                        .markEntryDetId,
                                                    "teMark": value
                                                        .studListUAS[i].teMark,
                                                    "peMark": value
                                                        .studListUAS[i].peMark,
                                                    "ceMark": value
                                                        .studListUAS[i].ceMark,
                                                    "teGrade": value
                                                        .studListUAS[i].teGrade,
                                                    "peGrade": value
                                                        .studListUAS[i].peGrade,
                                                    "ceGrade": value
                                                        .studListUAS[i].ceGrade,
                                                    "total": value
                                                        .studListUAS[i].total,
                                                    "teGradeId": value
                                                        .studListUAS[i]
                                                        .teGradeId,
                                                    "peGradeId": value
                                                        .studListUAS[i]
                                                        .peGradeId,
                                                    "ceGradeId": value
                                                        .studListUAS[i]
                                                        .ceGradeId,
                                                    "tabMarkEntryId": value
                                                        .studListUAS[i]
                                                        .tabMarkEntryId,
                                                    "isEdited": false,
                                                    "isDisabled": false
                                                  },
                                                );
                                              }
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
                                                      Duration(seconds: 2),
                                                  margin: EdgeInsets.only(
                                                      bottom: 80,
                                                      left: 30,
                                                      right: 30),
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                  content: Text(
                                                    "No data to verify",
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ));
                                              } else {
                                                value.loadVerify
                                                    ? spinkitLoader()
                                                    : await value.markEntryVerify(
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
                                                        value.peMax.toString(),
                                                        value.ceMax.toString(),
                                                        value.teCaptionUAS
                                                            .toString(),
                                                        value.peCaptionUAS
                                                            .toString(),
                                                        value.ceCaptionUAS
                                                            .toString(),
                                                        value.examStatusUAS
                                                            .toString(),
                                                        context,
                                                        date!,
                                                        obj,
                                                        value.gradeListUAS,
                                                        value.partsUAS);
                                                value.examStatusUAS =
                                                    "Verified";
                                              }
                                              Navigator.pop(context);
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
                        'Verify',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
            }),
            kWidth,
            Consumer<MarkEntryNewProvider>(builder: (context, value, child) {
              return MaterialButton(
                onPressed: () {
                  value.examStatusUAS == "Pending"
                      ? ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          duration: Duration(seconds: 3),
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
                                        List obj = [];
                                        obj.clear();

                                        for (int i = 0;
                                            i < value.studListUAS.length;
                                            i++) {
                                          obj.add(
                                            {
                                              "attendance": value
                                                  .studListUAS[i].attendance,
                                              "studentName": value
                                                  .studListUAS[i].studentName,
                                              "rollNo":
                                                  value.studListUAS[i].rollNo,
                                              "studentId": value
                                                  .studListUAS[i].studentId,
                                              "markEntryDetId": value
                                                  .studListUAS[i]
                                                  .markEntryDetId,
                                              "teMark":
                                                  value.studListUAS[i].teMark,
                                              "peMark": null,
                                              "ceMark": null,
                                              "teGrade": null,
                                              "peGrade": null,
                                              "ceGrade": null,
                                              "total":
                                                  value.studListUAS[i].total,
                                              "teGradeId": null,
                                              "peGradeId": null,
                                              "ceGradeId": null,
                                              "tabMarkEntryId": null,
                                              "isEdited": false,
                                              "isDisabled": false
                                            },
                                          );
                                        }

                                        if (markEntryDivisionListController
                                                .text.isEmpty &&
                                            markEntryInitialValuesController
                                                .text.isEmpty) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            elevation: 10,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                            ),
                                            duration: Duration(seconds: 1),
                                            margin: EdgeInsets.only(
                                                bottom: 80,
                                                left: 30,
                                                right: 30),
                                            behavior: SnackBarBehavior.floating,
                                            content: Text(
                                              "Select mandatory fields...!",
                                              textAlign: TextAlign.center,
                                            ),
                                          ));
                                        } else if (obj.isEmpty) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            elevation: 10,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                            ),
                                            duration: Duration(seconds: 2),
                                            margin: EdgeInsets.only(
                                                bottom: 80,
                                                left: 30,
                                                right: 30),
                                            behavior: SnackBarBehavior.floating,
                                            content: Text(
                                              "No data to delete",
                                              textAlign: TextAlign.center,
                                            ),
                                          ));
                                        } else {
                                          if (value.tabulationTypeCode ==
                                              "UAS") {
                                            value.loadDelete
                                                ? spinkitLoader()
                                                : await value.markEntryUASDelete(
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
                                                    value.courseUAS.toString(),
                                                    value.partUAS.toString(),
                                                    value.subjectUAS.toString(),
                                                    value.subSubjectUAS
                                                        .toString(),
                                                    value.optionSubjectUAS
                                                        .toString(),
                                                    value.staffIdUAS.toString(),
                                                    value.staffNameUAS
                                                        .toString(),
                                                    value.entryMethodUAS
                                                        .toString(),
                                                    value.examUAS.toString(),
                                                    value
                                                        .includeTerminatedStudentsUAS,
                                                    value.teMax.toString(),
                                                    value.peMax.toString(),
                                                    value.ceMax.toString(),
                                                    value.teCaptionUAS
                                                        .toString(),
                                                    value.peCaptionUAS
                                                        .toString(),
                                                    value.ceCaptionUAS
                                                        .toString(),
                                                    value.examStatusUAS
                                                        .toString(),
                                                    context,
                                                    date!,
                                                    obj,
                                                    value.gradeListUAS,
                                                    value.partsUAS);
                                            value.examStatusUAS = "Pending";
                                          } else {
                                            value.loadDelete
                                                ? spinkitLoader()
                                                : await value.markEntrySTATEDelete(
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
                                                    value.courseUAS.toString(),
                                                    value.partUAS.toString(),
                                                    value.subjectUAS.toString(),
                                                    value.subSubjectUAS
                                                        .toString(),
                                                    value.optionSubjectUAS
                                                        .toString(),
                                                    value.staffIdUAS.toString(),
                                                    value.staffNameUAS
                                                        .toString(),
                                                    value.entryMethodUAS
                                                        .toString(),
                                                    value.examUAS.toString(),
                                                    value
                                                        .includeTerminatedStudentsUAS,
                                                    value.teMax.toString(),
                                                    value.peMax.toString(),
                                                    value.ceMax.toString(),
                                                    value.teCaptionUAS
                                                        .toString(),
                                                    value.peCaptionUAS
                                                        .toString(),
                                                    value.ceCaptionUAS
                                                        .toString(),
                                                    value.examStatusUAS
                                                        .toString(),
                                                    context,
                                                    date!,
                                                    obj,
                                                    value.gradeListUAS,
                                                    value.partsUAS);
                                            value.examStatusUAS = "Pending";
                                          }
                                        }

                                        Navigator.pop(context);
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
>>>>>>> 5872e73fddbd8f1c6a4bca392a2d613ed3c57989
                ),
        ),
      ),
    );
  }
}
