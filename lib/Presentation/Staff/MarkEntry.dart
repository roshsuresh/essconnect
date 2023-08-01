import 'dart:ffi';

import 'package:essconnect/utils/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../Application/Staff_Providers/MarkEntryProvider.dart';
import '../../Constants.dart';
import '../../utils/constants.dart';

class MarkEntry extends StatefulWidget {
  const MarkEntry({Key? key}) : super(key: key);

  @override
  State<MarkEntry> createState() => _MarkEntryState();
}

class _MarkEntryState extends State<MarkEntry> {
  double maxscore = 0;
  String? attendancee;

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

  double? maxScrore;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var p = Provider.of<MarkEntryProvider>(context, listen: false);

      await p.courseClear();
      await p.divisionClear();
      await p.removeAllpartClear();
      await p.removeAllSubjectClear();
      await p.removeAllOptionSubjectListClear();
      await p.removeAllExamClear();
      await p.clearStudentMEList();
      await p.getMarkEntryInitialValues();
    });
  }

  bool attend = false;
  String courseId = '';
  String partId = '';
  String subjectId = '';
  String divisionId = '';
  String exam = '';

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
          title: const Text(
            'Mark Entry',
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
      body: Consumer<MarkEntryProvider>(
        builder: (context, value, child) {
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
              : ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Row(
                      children: [
                        const Spacer(),
                        SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.49,
                          child: Consumer<MarkEntryProvider>(
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
                                                  snapshot.clearStudentMEList();

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
                                                  await snapshot
                                                      .divisionClear();

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
                                            color: UIGuide.light_Purple,
                                            width: 1),
                                      ),
                                      height: 40,
                                      child: TextField(
                                        textAlign: TextAlign.center,
                                        controller:
                                            markEntryInitialValuesController1,
                                        decoration: const InputDecoration(
                                          filled: true,
                                          contentPadding:
                                              EdgeInsets.only(left: 0, top: 0),
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.never,
                                          fillColor: Color.fromARGB(
                                              255, 238, 237, 237),
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
                            );
                          }),
                        ),
                        const Spacer(),
                        SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.49,
                          child: Consumer<MarkEntryProvider>(
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
                                                    .markEntryDivisionList
                                                    .length,
                                                itemBuilder: (context, index) {
                                                  return ListTile(
                                                    selectedTileColor:
                                                        Colors.blue.shade100,
                                                    selectedColor:
                                                        UIGuide.PRIMARY2,
                                                    onTap: () async {
                                                      snapshot
                                                          .clearStudentMEList();
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
                                                              courseId,
                                                              divisionId);

                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    title: Text(
                                                      snapshot
                                                              .markEntryDivisionList[
                                                                  index]
                                                              .text ??
                                                          '---',
                                                      textAlign:
                                                          TextAlign.center,
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
                                            color: UIGuide.light_Purple,
                                            width: 1),
                                      ),
                                      height: 40,
                                      child: TextField(
                                        textAlign: TextAlign.center,
                                        controller:
                                            markEntryDivisionListController1,
                                        decoration: const InputDecoration(
                                          filled: true,
                                          contentPadding:
                                              EdgeInsets.only(left: 0, top: 0),
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.never,
                                          fillColor: Color.fromARGB(
                                              255, 238, 237, 237),
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
                                        controller:
                                            markEntryDivisionListController,
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
                          child: Consumer<MarkEntryProvider>(
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
                                                    selectedColor:
                                                        UIGuide.PRIMARY2,
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
                                                              divisionId,
                                                              partId);

                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    title: Text(
                                                      snapshot
                                                              .markEntryPartList[
                                                                  index]
                                                              .text ??
                                                          '---',
                                                      textAlign:
                                                          TextAlign.center,
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
                                            color: UIGuide.light_Purple,
                                            width: 1),
                                      ),
                                      height: 40,
                                      child: TextField(
                                        textAlign: TextAlign.center,
                                        controller:
                                            markEntryPartListController1,
                                        decoration: const InputDecoration(
                                          filled: true,
                                          contentPadding:
                                              EdgeInsets.only(left: 0, top: 0),
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.never,
                                          fillColor: Color.fromARGB(
                                              255, 238, 237, 237),
                                          border: OutlineInputBorder(),
                                          labelText: "  Select Part",
                                          hintText: "Part",
                                        ),
                                        enabled: false,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 0,
                                      height: 0,
                                      child: TextField(
                                        controller: markEntryPartListController,
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
                            );
                          }),
                        ),
                        const Spacer(),
                        SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.49,
                          child: Consumer<MarkEntryProvider>(
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
                                                    .markEntrySubjectList
                                                    .length,
                                                itemBuilder: (context, index) {
                                                  return ListTile(
                                                    selectedTileColor:
                                                        Colors.blue.shade100,
                                                    selectedColor:
                                                        UIGuide.PRIMARY2,
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

                                                      await snapshot
                                                          .getMarkEntryOptionSubject(
                                                              subjectId,
                                                              divisionId);
                                                      await snapshot
                                                          .getMarkEntryExamValues(
                                                              subjectId,
                                                              divisionId,
                                                              partId);

                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    title: Text(
                                                      snapshot
                                                          .markEntrySubjectList[
                                                              index]
                                                          .text
                                                          .toString(),
                                                      textAlign:
                                                          TextAlign.center,
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
                                            color: UIGuide.light_Purple,
                                            width: 1),
                                      ),
                                      child: TextField(
                                        style: const TextStyle(
                                            fontSize: 14,
                                            overflow: TextOverflow.clip),
                                        textAlign: TextAlign.center,
                                        controller:
                                            markEntrySubjectListController1,
                                        decoration: const InputDecoration(
                                          filled: true,
                                          contentPadding:
                                              EdgeInsets.only(left: 0, top: 0),
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.never,
                                          fillColor: Color.fromARGB(
                                              255, 238, 237, 237),
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
                                        controller:
                                            markEntrySubjectListController,
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
                            );
                          }),
                        ),
                        const Spacer(),
                      ],
                    ),
                    Row(
                      children: [
                        // Spacer(),
                        Consumer<MarkEntryProvider>(
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
                                width:
                                    MediaQuery.of(context).size.width * 0.499,
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
                                                  itemBuilder:
                                                      (context, index) {
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

                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      title: Text(
                                                        snapshot
                                                                .markEntryOptionSubjectList[
                                                                    index]
                                                                .subjectName ??
                                                            '--',
                                                        textAlign:
                                                            TextAlign.center,
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
                                                overflow: TextOverflow.clip),
                                            textAlign: TextAlign.center,
                                            controller:
                                                markEntryOptionSubListController,
                                            decoration: InputDecoration(
                                              filled: true,
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      left: 0, top: 0),
                                              floatingLabelBehavior:
                                                  FloatingLabelBehavior.never,
                                              fillColor: const Color.fromARGB(
                                                  255, 238, 237, 237),
                                              border:
                                                  const OutlineInputBorder(),
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
                          child: Consumer<MarkEntryProvider>(
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
                                              itemCount: snapshot
                                                  .markEntryExamList.length,
                                              itemBuilder: (context, index) {
                                                return ListTile(
                                                  selectedTileColor:
                                                      Colors.blue.shade100,
                                                  selectedColor:
                                                      UIGuide.PRIMARY2,
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
                                            color: UIGuide.light_Purple,
                                            width: 1),
                                      ),
                                      child: TextField(
                                        style: const TextStyle(
                                            fontSize: 14,
                                            overflow: TextOverflow.clip),
                                        textAlign: TextAlign.center,
                                        controller: markEntryExamListController,
                                        decoration: const InputDecoration(
                                          filled: true,
                                          contentPadding:
                                              EdgeInsets.only(left: 0, top: 0),
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.never,
                                          fillColor: Color.fromARGB(
                                              255, 238, 237, 237),
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
                                        controller:
                                            markEntryExamListController1,
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
                        value.loading
                            ? SizedBox(
                                width: size.width / 2.5,
                                child: MaterialButton(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0))),
                                  onPressed: () {},
                                  color: UIGuide.light_Purple,
                                  child: const Text(
                                    'Loading...',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              )
                            : SizedBox(
                                width: size.width / 2.5,
                                child: MaterialButton(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0))),
                                  color: UIGuide.light_Purple,
                                  onPressed: (() async {
                                    date = await DateFormat('dd/MMM/yyyy')
                                        .format(DateTime.now());
                                    print(DateFormat('dd/MMM/yyyy')
                                        .format(DateTime.now()));

                                    String course =
                                        markEntryInitialValuesController.text
                                            .toString();
                                    String division =
                                        markEntryDivisionListController.text
                                            .toString();
                                    String part = markEntryPartListController
                                        .text
                                        .toString();
                                    String subject =
                                        markEntrySubjectListController.text
                                            .toString();
                                    String exam = markEntryExamListController
                                        .text
                                        .toString();
                                    await Provider.of<MarkEntryProvider>(
                                            context,
                                            listen: false)
                                        .clearStudentMEList();

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
                                    value.gradeList.clear();

                                    await Provider.of<MarkEntryProvider>(
                                            context,
                                            listen: false)
                                        .getMarkEntryView(course, date!,
                                            division, exam, part, subject);
                                    maxScrore = value.maxmarkList[0].teMax;

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
                    //  kheight20,
                    Consumer<MarkEntryProvider>(
                        builder: (context, providerr, child) {
                      if (providerr.loading) {
                        return LimitedBox(
                          maxHeight: size.height / 1.85,
                          child: Container(
                            height: size.height / 1.95,
                            child: spinkitLoader(),
                          ),
                        );
                      } else if (providerr.maxmarkList.isEmpty ||
                          providerr.maxmarkList == null) {
                        return Container(
                          width: 0,
                          height: 0,
                        );
                      }

////-----------    ----------    ---------    ----------    ---------     ----------    ---------
////-----------    ----------          Mark  Entry --[ UAS ]--     -----------        -----------
////-----------    ----------    ---------    ----------    ---------     ----------    ---------

                      else if (providerr.typecode == "UAS" &&
                          providerr.maxmarkList[0].entryMethod == "Mark") {
                        return LimitedBox(
                            maxHeight: size.height / 1.85,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: value.studentMEList.length,
                                  itemBuilder: ((context, index) {
                                    String pre = 'P';
                                    markfieldController.text = pre;
                                    _controllers.add(TextEditingController());

                                    _controllers[index].text.isEmpty
                                        ? _controllers[index].text = value
                                                    .studentMEList[index]
                                                    .teMark ==
                                                null
                                            ? _controllers[index].text
                                            : value.studentMEList[index].teMark
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
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Row(
                                                children: [
                                                  const Text(
                                                    'Roll No: ',
                                                    style: TextStyle(),
                                                  ),
                                                  value.studentMEList[index]
                                                              .rollNo ==
                                                          null
                                                      ? const Text(
                                                          '0',
                                                          style: TextStyle(
                                                              color: UIGuide
                                                                  .light_Purple),
                                                        )
                                                      : Text(
                                                          value
                                                              .studentMEList[
                                                                  index]
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
                                                            .studentMEList[
                                                                index]
                                                            .name,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10.0),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          if (value
                                                                  .studentMEList[
                                                                      index]
                                                                  .attendance ==
                                                              'A') {
                                                            value
                                                                .studentMEList[
                                                                    index]
                                                                .attendance = 'P';
                                                          } else {
                                                            value
                                                                .studentMEList[
                                                                    index]
                                                                .attendance = 'A';
                                                            value
                                                                .studentMEList[
                                                                    index]
                                                                .teMark = null;
                                                            _controllers[index]
                                                                .clear();
                                                          }
                                                          attendancee = value
                                                              .studentMEList[
                                                                  index]
                                                              .attendance;

                                                          print(
                                                              "atte  $attendancee");
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
                                                                        .studentMEList[
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
                                                        // focusNode: FocusNode(),
                                                        controller:
                                                            _controllers[index],
                                                        enabled: value
                                                                    .studentMEList[
                                                                        index]
                                                                    .attendance ==
                                                                'A'
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
                                                                focusColor:
                                                                    const Color
                                                                            .fromARGB(
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
                                                                labelText:
                                                                    'Mark',
                                                                labelStyle: const TextStyle(
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
                                                                  offset: _controllers[
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
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 2.0),
                                                    child: SizedBox(
                                                        height: 30,
                                                        width: 50,
                                                        child: Center(
                                                            child: Text(
                                                          "($maxScrore)",
                                                          style:
                                                              const TextStyle(
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

                      else if ((providerr.typecode == "UAS") &&
                          providerr.maxmarkList[0].entryMethod == "Grade") {
                        return LimitedBox(
                            maxHeight: size.height / 1.85,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: value.studentMEList.length,
                                  itemBuilder: ((context, index) {
                                    gradeListController
                                        .add(TextEditingController());
                                    gradeListController1
                                        .add(TextEditingController());

                                    gradeListController1[index].text.isEmpty
                                        ? gradeListController1[index]
                                            .text = value.studentMEList[index]
                                                    .teGradeId ==
                                                null
                                            ? gradeListController1[index].text
                                            : value
                                                .studentMEList[index].teGradeId
                                                .toString()
                                        : gradeListController1[index].text;
                                    gradeListController[index].text.isEmpty
                                        ? gradeListController[index]
                                            .text = value.studentMEList[index]
                                                    .teGrade ==
                                                null
                                            ? gradeListController[index].text
                                            : value.studentMEList[index].teGrade
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
                                                            .studentMEList[
                                                                index]
                                                            .name,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    'Roll No: ',
                                                    style: TextStyle(),
                                                  ),
                                                  value.studentMEList[index]
                                                              .rollNo ==
                                                          null
                                                      ? const Text(
                                                          '0',
                                                          style: TextStyle(
                                                              color: UIGuide
                                                                  .light_Purple),
                                                        )
                                                      : Text(
                                                          value
                                                              .studentMEList[
                                                                  index]
                                                              .rollNo
                                                              .toString(),
                                                          style: const TextStyle(
                                                              color: UIGuide
                                                                  .light_Purple),
                                                        ),
                                                  kWidth,
                                                  kWidth,
                                                  Text(
                                                      '${value.maxmarkList[0].teCaption ?? ""} : '),
                                                  SizedBox(
                                                    height: 40,
                                                    width: 80,
                                                    child: SizedBox(
                                                      height: 40,
                                                      width: 100,
                                                      child: Consumer<
                                                              MarkEntryProvider>(
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
                                                                        itemCount: snapshot.gradeList.length,
                                                                        itemBuilder: (context, indx) {
                                                                          return ListTile(
                                                                            selectedTileColor:
                                                                                Colors.blue.shade100,
                                                                            selectedColor:
                                                                                UIGuide.PRIMARY2,
                                                                            onTap:
                                                                                () {
                                                                              gradeListController[index].text = snapshot.gradeList[indx].gradeName ?? '--';
                                                                              gradeListController1[index].text = snapshot.gradeList[indx].gradeId ?? '--';
                                                                              value.studentMEList[index].teGradeId = gradeListController1[index].text;
                                                                              value.studentMEList[index].teGrade = value.studentMEList[index].teGrade;
                                                                              Navigator.of(context).pop();
                                                                            },
                                                                            title:
                                                                                Text(
                                                                              snapshot.gradeList[indx].gradeName ?? '--',
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
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        overflow:
                                                                            TextOverflow.clip),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    controller:
                                                                        gradeListController[
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
                                                                          "  Select grade",
                                                                      hintText:
                                                                          "grade",
                                                                    ),
                                                                    enabled:
                                                                        false,
                                                                    onChanged:
                                                                        (value1) {
                                                                      gradeListController1[index].text = value
                                                                          .studentMEList[
                                                                              index]
                                                                          .teGradeId
                                                                          .toString();
                                                                      gradeListController1[index]
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

                      else if (providerr.typecode == "PBT" &&
                          providerr.maxmarkList[0].entryMethod == "Grade") {
                        return LimitedBox(
                            maxHeight: size.height / 1.85,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: value.studentMEList.length,
                                  itemBuilder: ((context, index) {
                                    //TE Grade
                                    publicGradeController
                                        .add(TextEditingController());
                                    publicGradeController1
                                        .add(TextEditingController());

                                    publicGradeController1[index].text.isEmpty
                                        ? publicGradeController1[index]
                                            .text = value.studentMEList[index]
                                                    .teGradeId ==
                                                null
                                            ? publicGradeController1[index].text
                                            : value
                                                .studentMEList[index].teGradeId
                                                .toString()
                                        : publicGradeController1[index].text;
                                    publicGradeController[index].text.isEmpty
                                        ? publicGradeController[index]
                                            .text = value.studentMEList[index]
                                                    .teGrade ==
                                                null
                                            ? publicGradeController[index].text
                                            : value.studentMEList[index].teGrade
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
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: 80,
                                                    child: Text(
                                                      'Roll No: ${value.studentMEList[index].rollNo == null ? '0' : value.studentMEList[index].rollNo.toString()}',
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
                                                                  .studentMEList[
                                                                      index]
                                                                  .attendance ==
                                                              'A') {
                                                            value
                                                                .studentMEList[
                                                                    index]
                                                                .attendance = 'P';
                                                          } else {
                                                            value
                                                                .studentMEList[
                                                                    index]
                                                                .attendance = 'A';

                                                            value
                                                                .studentMEList[
                                                                    index]
                                                                .teGrade = null;
                                                            value
                                                                .studentMEList[
                                                                    index]
                                                                .teGradeId = null;

                                                            publicGradeController[
                                                                    index]
                                                                .clear();
                                                            publicGradeController1[
                                                                    index]
                                                                .clear();
                                                          }
                                                          attendancee = value
                                                              .studentMEList[
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
                                                                        .studentMEList[
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
                                                            .studentMEList[
                                                                index]
                                                            .name,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    LimitedBox(
                                                      maxWidth: 80,
                                                      child: Text(
                                                        '${value.maxmarkList[0].teCaption ?? ""} : ',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 40,
                                                      width: 80,
                                                      child: SizedBox(
                                                        height: 40,
                                                        width: 100,
                                                        child: Consumer<
                                                                MarkEntryProvider>(
                                                            builder: (context,
                                                                snapshot,
                                                                child) {
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
                                                                          itemCount: snapshot.gradeList.length,
                                                                          itemBuilder: (context, indx) {
                                                                            return ListTile(
                                                                              selectedTileColor: Colors.blue.shade100,
                                                                              selectedColor: UIGuide.PRIMARY2,
                                                                              onTap: () {
                                                                                publicGradeController[index].text = snapshot.gradeList[indx].gradeName ?? '--';
                                                                                publicGradeController1[index].text = snapshot.gradeList[indx].gradeId ?? '--';
                                                                                value.studentMEList[index].teGradeId = publicGradeController1[index].text;
                                                                                value.studentMEList[index].teGrade = publicGradeController[index].text;
                                                                                value.studentMEList[index].teGrade = value.studentMEList[index].teGrade;
                                                                                Navigator.of(context).pop();
                                                                              },
                                                                              title: Text(
                                                                                snapshot.gradeList[indx].gradeName ?? '--',
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
                                                                      enabled: value.studentMEList[index].attendance ==
                                                                              'A'
                                                                          ? true
                                                                          : false,
                                                                      readOnly:
                                                                          true,
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          overflow:
                                                                              TextOverflow.clip),
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
                                                                        contentPadding: EdgeInsets.only(
                                                                            left:
                                                                                0,
                                                                            top:
                                                                                0),
                                                                        floatingLabelBehavior:
                                                                            FloatingLabelBehavior.never,
                                                                        fillColor: Color.fromARGB(
                                                                            255,
                                                                            255,
                                                                            255,
                                                                            255),
                                                                        border:
                                                                            OutlineInputBorder(),
                                                                        labelText:
                                                                            "  Select grade",
                                                                        hintText:
                                                                            "grade",
                                                                      ),
                                                                      onChanged:
                                                                          (value1) {
                                                                        publicGradeController1[index].text = value
                                                                            .studentMEList[index]
                                                                            .teGradeId
                                                                            .toString();
                                                                        publicGradeController1[index].text =
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

                      else if ((providerr.typecode == "PBT" ||
                              providerr.typecode == "STATE") &&
                          providerr.maxmarkList[0].entryMethod == "Mark") {
///////////////-------------------------------------------------------------------------------------///////////////
///////////////-----------------------     TE MARK  --  PE MARK --  CE MARK  ----------------------///////////////
///////////////-----------------------------------------------------------------------------------///////////////

                        if (providerr.maxmarkList[0].teMax != null &&
                            providerr.maxmarkList[0].peMax != null &&
                            providerr.maxmarkList[0].ceMax != null) {
                          return LimitedBox(
                              maxHeight: size.height / 1.85,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Scrollbar(
                                  child: ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemCount: value.studentMEList.length,
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
                                            ? teMarkController[index]
                                                .text = value
                                                        .studentMEList[index]
                                                        .teMark ==
                                                    null
                                                ? teMarkController[index].text
                                                : value
                                                    .studentMEList[index].teMark
                                                    .toString()
                                            : teMarkController[index].text;
                                        practicalMarkController[index]
                                                .text
                                                .isEmpty
                                            ? practicalMarkController[index]
                                                .text = value
                                                        .studentMEList[index]
                                                        .peMark ==
                                                    null
                                                ? practicalMarkController[index]
                                                    .text
                                                : value
                                                    .studentMEList[index].peMark
                                                    .toString()
                                            : practicalMarkController[index]
                                                .text;
                                        ceMarkController[index].text.isEmpty
                                            ? ceMarkController[index]
                                                .text = value
                                                        .studentMEList[index]
                                                        .ceMark ==
                                                    null
                                                ? ceMarkController[index].text
                                                : value
                                                    .studentMEList[index].ceMark
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
                                                      value.studentMEList[index]
                                                                  .rollNo ==
                                                              null
                                                          ? const Text(
                                                              '0',
                                                              style: TextStyle(
                                                                  color: UIGuide
                                                                      .light_Purple),
                                                            )
                                                          : Text(
                                                              value
                                                                  .studentMEList[
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
                                                                .studentMEList[
                                                                    index]
                                                                .name,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 10.0),
                                                        child: GestureDetector(
                                                          onTap: () async {
                                                            setState(() {
                                                              if (value
                                                                      .studentMEList[
                                                                          index]
                                                                      .attendance ==
                                                                  'A') {
                                                                value
                                                                    .studentMEList[
                                                                        index]
                                                                    .attendance = 'P';
                                                              } else {
                                                                value
                                                                    .studentMEList[
                                                                        index]
                                                                    .attendance = 'A';
                                                                value
                                                                    .studentMEList[
                                                                        index]
                                                                    .teMark = null;
                                                                value
                                                                    .studentMEList[
                                                                        index]
                                                                    .ceMark = null;
                                                                value
                                                                    .studentMEList[
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
                                                                  .studentMEList[
                                                                      index]
                                                                  .attendance;

                                                              print(
                                                                  "attendace   $attendancee");
                                                            });
                                                          },
                                                          child: Container(
                                                            color: Colors
                                                                .transparent,
                                                            width: 28,
                                                            height: 26,
                                                            child: SizedBox(
                                                                width: 28,
                                                                height: 26,
                                                                child: value
                                                                            .studentMEList[
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
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: SizedBox(
                                                          height: 30,
                                                          width: 80,
                                                          child: TextField(
                                                            controller:
                                                                teMarkController[
                                                                    index],
                                                            focusNode:
                                                                FocusNode(),
                                                            enabled: value
                                                                        .studentMEList[
                                                                            index]
                                                                        .attendance ==
                                                                    'A'
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
                                                                      newValue
                                                                          .text;
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
                                                                    focusColor:
                                                                        const Color.fromARGB(
                                                                            255,
                                                                            213,
                                                                            215,
                                                                            218),
                                                                    border:
                                                                        OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
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
                                                                          BorderRadius.circular(
                                                                              10.0),
                                                                    ),
                                                                    fillColor:
                                                                        Colors
                                                                            .grey,
                                                                    hintStyle:
                                                                        const TextStyle(
                                                                      color: Colors
                                                                          .grey,
                                                                      fontSize:
                                                                          16,
                                                                      fontFamily:
                                                                          "verdana_regular",
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                    ),
                                                                    labelText: value
                                                                            .maxmarkList[
                                                                                0]
                                                                            .teCaption ??
                                                                        "",
                                                                    labelStyle: const TextStyle(
                                                                        fontSize:
                                                                            13,
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            106,
                                                                            107,
                                                                            109))),
                                                            onChanged:
                                                                (value1) {
                                                              teMarkController[
                                                                          index]
                                                                      .text =
                                                                  value
                                                                      .studentMEList[
                                                                          index]
                                                                      .teMark
                                                                      .toString();
                                                              teMarkController[
                                                                          index]
                                                                      .text =
                                                                  value1;

                                                              teMarkController[
                                                                          index]
                                                                      .selection =
                                                                  TextSelection
                                                                      .collapsed(
                                                                          offset: teMarkController[index]
                                                                              .text
                                                                              .length);

                                                              if (double.parse(
                                                                      teMarkController[
                                                                              index]
                                                                          .text) >
                                                                  value
                                                                      .maxmarkList[
                                                                          0]
                                                                      .teMax!) {
                                                                teMarkController[
                                                                        index]
                                                                    .clear();
                                                              }
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 2.0),
                                                        child: SizedBox(
                                                            height: 30,
                                                            width: 50,
                                                            child: Center(
                                                                child: Text(
                                                              "(${value.maxmarkList[0].teMax})",
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
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: SizedBox(
                                                          height: 30,
                                                          width: 80,
                                                          child: TextField(
                                                            controller:
                                                                practicalMarkController[
                                                                    index],
                                                            focusNode:
                                                                FocusNode(),
                                                            enabled: value
                                                                        .studentMEList[
                                                                            index]
                                                                        .attendance ==
                                                                    'A'
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
                                                                      newValue
                                                                          .text;
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
                                                                    focusColor:
                                                                        const Color.fromARGB(
                                                                            255,
                                                                            213,
                                                                            215,
                                                                            218),
                                                                    border:
                                                                        OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
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
                                                                          BorderRadius.circular(
                                                                              10.0),
                                                                    ),
                                                                    fillColor:
                                                                        Colors
                                                                            .grey,
                                                                    hintStyle:
                                                                        const TextStyle(
                                                                      color: Colors
                                                                          .grey,
                                                                      fontSize:
                                                                          16,
                                                                      fontFamily:
                                                                          "verdana_regular",
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                    ),
                                                                    labelText: value
                                                                            .maxmarkList[
                                                                                0]
                                                                            .peCaption ??
                                                                        "",
                                                                    labelStyle: const TextStyle(
                                                                        fontSize:
                                                                            13,
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            106,
                                                                            107,
                                                                            109))),
                                                            onChanged:
                                                                (value1) {
                                                              practicalMarkController[
                                                                          index]
                                                                      .text =
                                                                  value
                                                                      .studentMEList[
                                                                          index]
                                                                      .peMark
                                                                      .toString();
                                                              practicalMarkController[
                                                                          index]
                                                                      .text =
                                                                  value1;
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
                                                                  value
                                                                      .maxmarkList[
                                                                          0]
                                                                      .peMax!) {
                                                                practicalMarkController[
                                                                        index]
                                                                    .clear();
                                                              }
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 2.0),
                                                        child: SizedBox(
                                                            height: 30,
                                                            width: 50,
                                                            child: Center(
                                                                child: Text(
                                                              "(${value.maxmarkList[0].peMax})",
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
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: SizedBox(
                                                        height: 30,
                                                        width: 80,
                                                        child: TextField(
                                                          controller:
                                                              ceMarkController[
                                                                  index],
                                                          focusNode:
                                                              FocusNode(),
                                                          enabled: value
                                                                      .studentMEList[
                                                                          index]
                                                                      .attendance ==
                                                                  'A'
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
                                                                    newValue
                                                                        .text;
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
                                                                  focusColor:
                                                                      const Color.fromARGB(
                                                                          255,
                                                                          213,
                                                                          215,
                                                                          218),
                                                                  border:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
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
                                                                        BorderRadius.circular(
                                                                            10.0),
                                                                  ),
                                                                  fillColor:
                                                                      Colors
                                                                          .grey,
                                                                  hintStyle:
                                                                      const TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontSize:
                                                                        16,
                                                                    fontFamily:
                                                                        "verdana_regular",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                  ),
                                                                  labelText: value
                                                                          .maxmarkList[
                                                                              0]
                                                                          .ceCaption ??
                                                                      "",
                                                                  labelStyle: const TextStyle(
                                                                      fontSize:
                                                                          13,
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          106,
                                                                          107,
                                                                          109))),
                                                          onChanged: (value1) {
                                                            ceMarkController[
                                                                        index]
                                                                    .text =
                                                                value
                                                                    .studentMEList[
                                                                        index]
                                                                    .ceMark
                                                                    .toString();
                                                            ceMarkController[
                                                                    index]
                                                                .text = value1;
                                                            ceMarkController[
                                                                        index]
                                                                    .selection =
                                                                TextSelection.collapsed(
                                                                    offset: ceMarkController[
                                                                            index]
                                                                        .text
                                                                        .length);

                                                            if (double.parse(
                                                                    ceMarkController[
                                                                            index]
                                                                        .text) >
                                                                value
                                                                    .maxmarkList[
                                                                        0]
                                                                    .peMax!) {
                                                              ceMarkController[
                                                                      index]
                                                                  .clear();
                                                            }
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
                                                            "(${value.maxmarkList[0].ceMax})",
                                                            style:
                                                                const TextStyle(
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

                        else if (providerr.maxmarkList[0].teMax != null &&
                            providerr.maxmarkList[0].peMax != null) {
                          return LimitedBox(
                              maxHeight: size.height / 1.85,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: value.studentMEList.length,
                                    itemBuilder: ((context, index) {
                                      String pre = 'P';
                                      markfieldController.text = pre;
                                      teMarkController
                                          .add(new TextEditingController());

                                      practicalMarkController
                                          .add(new TextEditingController());
                                      teMarkController[index].text.isEmpty
                                          ? teMarkController[index].text = value
                                                      .studentMEList[index]
                                                      .teMark ==
                                                  null
                                              ? teMarkController[index].text
                                              : value
                                                  .studentMEList[index].teMark
                                                  .toString()
                                          : teMarkController[index].text;
                                      practicalMarkController[index]
                                              .text
                                              .isEmpty
                                          ? practicalMarkController[index]
                                              .text = value.studentMEList[index]
                                                      .peMark ==
                                                  null
                                              ? practicalMarkController[index]
                                                  .text
                                              : value
                                                  .studentMEList[index].peMark
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
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Row(
                                                  children: [
                                                    const Text(
                                                      'Roll No: ',
                                                      style: TextStyle(),
                                                    ),
                                                    value.studentMEList[index]
                                                                .rollNo ==
                                                            null
                                                        ? const Text(
                                                            '0',
                                                            style: TextStyle(
                                                                color: UIGuide
                                                                    .light_Purple),
                                                          )
                                                        : Text(
                                                            value
                                                                .studentMEList[
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
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        strutStyle:
                                                            const StrutStyle(
                                                                fontSize: 12.0),
                                                        text: TextSpan(
                                                          style: const TextStyle(
                                                              color: UIGuide
                                                                  .light_Purple),
                                                          text: value
                                                              .studentMEList[
                                                                  index]
                                                              .name,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
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
                                                                    .studentMEList[
                                                                        index]
                                                                    .attendance ==
                                                                'A') {
                                                              value
                                                                  .studentMEList[
                                                                      index]
                                                                  .attendance = 'P';
                                                            } else {
                                                              value
                                                                  .studentMEList[
                                                                      index]
                                                                  .attendance = 'A';
                                                              value
                                                                  .studentMEList[
                                                                      index]
                                                                  .teMark = null;

                                                              value
                                                                  .studentMEList[
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
                                                                .studentMEList[
                                                                    index]
                                                                .attendance;

                                                            print(
                                                                "attendace   $attendancee");
                                                          });
                                                        },
                                                        child: Container(
                                                          color: Colors
                                                              .transparent,
                                                          width: 28,
                                                          height: 26,
                                                          child: SizedBox(
                                                              width: 28,
                                                              height: 26,
                                                              child: value.studentMEList[index].attendance ==
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
                                                          controller:
                                                              teMarkController[
                                                                  index],
                                                          focusNode:
                                                              FocusNode(),
                                                          enabled: value
                                                                      .studentMEList[
                                                                          index]
                                                                      .attendance ==
                                                                  'A'
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
                                                                    newValue
                                                                        .text;
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
                                                                  focusColor:
                                                                      const Color.fromARGB(
                                                                          255,
                                                                          213,
                                                                          215,
                                                                          218),
                                                                  border:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
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
                                                                        BorderRadius.circular(
                                                                            10.0),
                                                                  ),
                                                                  fillColor:
                                                                      Colors
                                                                          .grey,
                                                                  hintStyle:
                                                                      const TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontSize:
                                                                        16,
                                                                    fontFamily:
                                                                        "verdana_regular",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                  ),
                                                                  labelText: value
                                                                          .maxmarkList[
                                                                              0]
                                                                          .teCaption ??
                                                                      "",
                                                                  labelStyle: const TextStyle(
                                                                      fontSize:
                                                                          13,
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          106,
                                                                          107,
                                                                          109))),
                                                          onChanged: (value1) {
                                                            teMarkController[
                                                                        index]
                                                                    .text =
                                                                value
                                                                    .studentMEList[
                                                                        index]
                                                                    .teMark
                                                                    .toString();
                                                            teMarkController[
                                                                    index]
                                                                .text = value1;
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
                                                                value
                                                                    .maxmarkList[
                                                                        0]
                                                                    .teMax!) {
                                                              teMarkController[
                                                                      index]
                                                                  .clear();
                                                            }
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
                                                            "(${value.maxmarkList[0].teMax})",
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
                                                          controller:
                                                              practicalMarkController[
                                                                  index],
                                                          focusNode:
                                                              FocusNode(),
                                                          enabled: value
                                                                      .studentMEList[
                                                                          index]
                                                                      .attendance ==
                                                                  'A'
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
                                                                    newValue
                                                                        .text;
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
                                                                  focusColor:
                                                                      const Color.fromARGB(
                                                                          255,
                                                                          213,
                                                                          215,
                                                                          218),
                                                                  border:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
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
                                                                        BorderRadius.circular(
                                                                            10.0),
                                                                  ),
                                                                  fillColor:
                                                                      Colors
                                                                          .grey,
                                                                  hintStyle:
                                                                      const TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontSize:
                                                                        16,
                                                                    fontFamily:
                                                                        "verdana_regular",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                  ),
                                                                  labelText: value
                                                                          .maxmarkList[
                                                                              0]
                                                                          .peCaption ??
                                                                      "",
                                                                  labelStyle: const TextStyle(
                                                                      fontSize:
                                                                          13,
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          106,
                                                                          107,
                                                                          109))),
                                                          onChanged: (value1) {
                                                            practicalMarkController[
                                                                        index]
                                                                    .text =
                                                                value
                                                                    .studentMEList[
                                                                        index]
                                                                    .peMark
                                                                    .toString();
                                                            practicalMarkController[
                                                                    index]
                                                                .text = value1;
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
                                                                value
                                                                    .maxmarkList[
                                                                        0]
                                                                    .peMax!) {
                                                              practicalMarkController[
                                                                      index]
                                                                  .clear();
                                                            }
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
                                                            "(${value.maxmarkList[0].peMax})",
                                                            style:
                                                                const TextStyle(
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

                        else if (providerr.maxmarkList[0].teMax != null &&
                            providerr.maxmarkList[0].ceMax != null) {
                          return LimitedBox(
                              maxHeight: size.height / 1.85,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: value.studentMEList.length,
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
                                                      .studentMEList[index]
                                                      .teMark ==
                                                  null
                                              ? teMarkController[index].text
                                              : value
                                                  .studentMEList[index].teMark
                                                  .toString()
                                          : teMarkController[index].text;

                                      ceMarkController[index].text.isEmpty
                                          ? ceMarkController[index].text = value
                                                      .studentMEList[index]
                                                      .ceMark ==
                                                  null
                                              ? ceMarkController[index].text
                                              : value
                                                  .studentMEList[index].ceMark
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
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Row(
                                                  children: [
                                                    const Text(
                                                      'Roll No: ',
                                                      style: TextStyle(),
                                                    ),
                                                    value.studentMEList[index]
                                                                .rollNo ==
                                                            null
                                                        ? const Text(
                                                            '0',
                                                            style: TextStyle(
                                                                color: UIGuide
                                                                    .light_Purple),
                                                          )
                                                        : Text(
                                                            value
                                                                .studentMEList[
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
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        strutStyle:
                                                            const StrutStyle(
                                                                fontSize: 12.0),
                                                        text: TextSpan(
                                                          style: const TextStyle(
                                                              color: UIGuide
                                                                  .light_Purple),
                                                          text: value
                                                              .studentMEList[
                                                                  index]
                                                              .name,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
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
                                                                    .studentMEList[
                                                                        index]
                                                                    .attendance ==
                                                                'A') {
                                                              value
                                                                  .studentMEList[
                                                                      index]
                                                                  .attendance = 'P';
                                                            } else {
                                                              value
                                                                  .studentMEList[
                                                                      index]
                                                                  .attendance = 'A';

                                                              value
                                                                  .studentMEList[
                                                                      index]
                                                                  .teMark = null;
                                                              value
                                                                  .studentMEList[
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
                                                                .studentMEList[
                                                                    index]
                                                                .attendance;

                                                            print(
                                                                "attendace   $attendancee");
                                                          });
                                                        },
                                                        child: Container(
                                                          color: Colors
                                                              .transparent,
                                                          width: 28,
                                                          height: 26,
                                                          child: SizedBox(
                                                              width: 28,
                                                              height: 26,
                                                              child: value.studentMEList[index].attendance ==
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
                                                          controller:
                                                              teMarkController[
                                                                  index],
                                                          focusNode:
                                                              FocusNode(),
                                                          enabled: value
                                                                      .studentMEList[
                                                                          index]
                                                                      .attendance ==
                                                                  'A'
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
                                                                    newValue
                                                                        .text;
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
                                                                  focusColor:
                                                                      const Color.fromARGB(
                                                                          255,
                                                                          213,
                                                                          215,
                                                                          218),
                                                                  border:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
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
                                                                        BorderRadius.circular(
                                                                            10.0),
                                                                  ),
                                                                  fillColor:
                                                                      Colors
                                                                          .grey,
                                                                  hintStyle:
                                                                      const TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontSize:
                                                                        16,
                                                                    fontFamily:
                                                                        "verdana_regular",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                  ),
                                                                  labelText: value
                                                                          .maxmarkList[
                                                                              0]
                                                                          .teCaption ??
                                                                      "",
                                                                  labelStyle: const TextStyle(
                                                                      fontSize:
                                                                          13,
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          106,
                                                                          107,
                                                                          109))),
                                                          onChanged: (value1) {
                                                            teMarkController[
                                                                        index]
                                                                    .text =
                                                                value
                                                                    .studentMEList[
                                                                        index]
                                                                    .teMark
                                                                    .toString();
                                                            teMarkController[
                                                                    index]
                                                                .text = value1;
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
                                                                value
                                                                    .maxmarkList[
                                                                        0]
                                                                    .teMax!) {
                                                              teMarkController[
                                                                      index]
                                                                  .clear();
                                                            }
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
                                                            "(${value.maxmarkList[0].teMax})",
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
                                                          controller:
                                                              ceMarkController[
                                                                  index],
                                                          focusNode:
                                                              FocusNode(),
                                                          enabled: value
                                                                      .studentMEList[
                                                                          index]
                                                                      .attendance ==
                                                                  'A'
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
                                                                    newValue
                                                                        .text;
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
                                                                  focusColor:
                                                                      const Color.fromARGB(
                                                                          255,
                                                                          213,
                                                                          215,
                                                                          218),
                                                                  border:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
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
                                                                        BorderRadius.circular(
                                                                            10.0),
                                                                  ),
                                                                  fillColor:
                                                                      Colors
                                                                          .grey,
                                                                  hintStyle:
                                                                      const TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontSize:
                                                                        16,
                                                                    fontFamily:
                                                                        "verdana_regular",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                  ),
                                                                  labelText: value
                                                                          .maxmarkList[
                                                                              0]
                                                                          .ceCaption ??
                                                                      "",
                                                                  labelStyle: const TextStyle(
                                                                      fontSize:
                                                                          13,
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          106,
                                                                          107,
                                                                          109))),
                                                          onChanged: (value1) {
                                                            ceMarkController[
                                                                        index]
                                                                    .text =
                                                                value
                                                                    .studentMEList[
                                                                        index]
                                                                    .ceMark
                                                                    .toString();
                                                            ceMarkController[
                                                                    index]
                                                                .text = value1;
                                                            ceMarkController[
                                                                        index]
                                                                    .selection =
                                                                TextSelection.collapsed(
                                                                    offset: ceMarkController[
                                                                            index]
                                                                        .text
                                                                        .length);

                                                            if (double.parse(
                                                                    ceMarkController[
                                                                            index]
                                                                        .text) >
                                                                value
                                                                    .maxmarkList[
                                                                        0]
                                                                    .ceMax!) {
                                                              ceMarkController[
                                                                      index]
                                                                  .clear();
                                                            }
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
                                                            "(${value.maxmarkList[0].ceMax})",
                                                            style:
                                                                const TextStyle(
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

                        else if (providerr.maxmarkList[0].ceMax != null &&
                            providerr.maxmarkList[0].peMax != null) {
                          return LimitedBox(
                              maxHeight: size.height / 1.85,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: value.studentMEList.length,
                                    itemBuilder: ((context, index) {
                                      String pre = 'P';
                                      markfieldController.text = pre;

                                      ceMarkController
                                          .add(new TextEditingController());
                                      practicalMarkController
                                          .add(new TextEditingController());

                                      practicalMarkController[index]
                                              .text
                                              .isEmpty
                                          ? practicalMarkController[index]
                                              .text = value.studentMEList[index]
                                                      .peMark ==
                                                  null
                                              ? practicalMarkController[index]
                                                  .text
                                              : value
                                                  .studentMEList[index].peMark
                                                  .toString()
                                          : practicalMarkController[index].text;

                                      ceMarkController[index].text.isEmpty
                                          ? ceMarkController[index].text = value
                                                      .studentMEList[index]
                                                      .ceMark ==
                                                  null
                                              ? ceMarkController[index].text
                                              : value
                                                  .studentMEList[index].ceMark
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
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Row(
                                                  children: [
                                                    const Text(
                                                      'Roll No: ',
                                                      style: TextStyle(),
                                                    ),
                                                    value.studentMEList[index]
                                                                .rollNo ==
                                                            null
                                                        ? const Text(
                                                            '0',
                                                            style: TextStyle(
                                                                color: UIGuide
                                                                    .light_Purple),
                                                          )
                                                        : Text(
                                                            value
                                                                .studentMEList[
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
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        strutStyle:
                                                            const StrutStyle(
                                                                fontSize: 12.0),
                                                        text: TextSpan(
                                                          style: const TextStyle(
                                                              color: UIGuide
                                                                  .light_Purple),
                                                          text: value
                                                              .studentMEList[
                                                                  index]
                                                              .name,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
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
                                                                    .studentMEList[
                                                                        index]
                                                                    .attendance ==
                                                                'A') {
                                                              value
                                                                  .studentMEList[
                                                                      index]
                                                                  .attendance = 'P';
                                                            } else {
                                                              value
                                                                  .studentMEList[
                                                                      index]
                                                                  .attendance = 'A';

                                                              value
                                                                  .studentMEList[
                                                                      index]
                                                                  .ceMark = null;
                                                              value
                                                                  .studentMEList[
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
                                                                .studentMEList[
                                                                    index]
                                                                .attendance;

                                                            print(
                                                                "attendace   $attendancee");
                                                          });
                                                        },
                                                        child: Container(
                                                          color: Colors
                                                              .transparent,
                                                          width: 28,
                                                          height: 26,
                                                          child: SizedBox(
                                                              width: 28,
                                                              height: 26,
                                                              child: value.studentMEList[index].attendance ==
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
                                                          controller:
                                                              practicalMarkController[
                                                                  index],
                                                          focusNode:
                                                              FocusNode(),
                                                          enabled: value
                                                                      .studentMEList[
                                                                          index]
                                                                      .attendance ==
                                                                  'A'
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
                                                                    newValue
                                                                        .text;
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
                                                                  focusColor:
                                                                      const Color.fromARGB(
                                                                          255,
                                                                          213,
                                                                          215,
                                                                          218),
                                                                  border:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
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
                                                                        BorderRadius.circular(
                                                                            10.0),
                                                                  ),
                                                                  fillColor:
                                                                      Colors
                                                                          .grey,
                                                                  hintStyle:
                                                                      const TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontSize:
                                                                        16,
                                                                    fontFamily:
                                                                        "verdana_regular",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                  ),
                                                                  labelText: value
                                                                          .maxmarkList[
                                                                              0]
                                                                          .peCaption ??
                                                                      "",
                                                                  labelStyle: const TextStyle(
                                                                      fontSize:
                                                                          13,
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          106,
                                                                          107,
                                                                          109))),
                                                          onChanged: (value1) {
                                                            practicalMarkController[
                                                                        index]
                                                                    .text =
                                                                value
                                                                    .studentMEList[
                                                                        index]
                                                                    .peMark
                                                                    .toString();
                                                            practicalMarkController[
                                                                    index]
                                                                .text = value1;
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
                                                                value
                                                                    .maxmarkList[
                                                                        0]
                                                                    .peMax!) {
                                                              practicalMarkController[
                                                                      index]
                                                                  .clear();
                                                            }
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
                                                            "(${value.maxmarkList[0].peMax})",
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
                                                          controller:
                                                              ceMarkController[
                                                                  index],
                                                          focusNode:
                                                              FocusNode(),
                                                          enabled: value
                                                                      .studentMEList[
                                                                          index]
                                                                      .attendance ==
                                                                  'A'
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
                                                                    newValue
                                                                        .text;
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
                                                                  focusColor:
                                                                      const Color.fromARGB(
                                                                          255,
                                                                          213,
                                                                          215,
                                                                          218),
                                                                  border:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
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
                                                                        BorderRadius.circular(
                                                                            10.0),
                                                                  ),
                                                                  fillColor:
                                                                      Colors
                                                                          .grey,
                                                                  hintStyle:
                                                                      const TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontSize:
                                                                        16,
                                                                    fontFamily:
                                                                        "verdana_regular",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                  ),
                                                                  labelText: value
                                                                          .maxmarkList[
                                                                              0]
                                                                          .ceCaption ??
                                                                      "",
                                                                  labelStyle: const TextStyle(
                                                                      fontSize:
                                                                          13,
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          106,
                                                                          107,
                                                                          109))),
                                                          onChanged: (value1) {
                                                            ceMarkController[
                                                                        index]
                                                                    .text =
                                                                value
                                                                    .studentMEList[
                                                                        index]
                                                                    .ceMark
                                                                    .toString();
                                                            ceMarkController[
                                                                    index]
                                                                .text = value1;
                                                            ceMarkController[
                                                                        index]
                                                                    .selection =
                                                                TextSelection.collapsed(
                                                                    offset: ceMarkController[
                                                                            index]
                                                                        .text
                                                                        .length);

                                                            if (double.parse(
                                                                    ceMarkController[
                                                                            index]
                                                                        .text) >
                                                                value
                                                                    .maxmarkList[
                                                                        0]
                                                                    .ceMax!) {
                                                              ceMarkController[
                                                                      index]
                                                                  .clear();
                                                            }
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
                                                            "(${value.maxmarkList[0].ceMax})",
                                                            style:
                                                                const TextStyle(
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

                        else if (providerr.maxmarkList[0].teMax != null &&
                            providerr.maxmarkList[0].peMax == null &&
                            providerr.maxmarkList[0].ceMax == null) {
                          return LimitedBox(
                              maxHeight: size.height / 1.85,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: value.studentMEList.length,
                                    itemBuilder: ((context, index) {
                                      String pre = 'P';
                                      markfieldController.text = pre;
                                      teMarkController
                                          .add(new TextEditingController());

                                      teMarkController[index].text.isEmpty
                                          ? teMarkController[index].text = value
                                                      .studentMEList[index]
                                                      .teMark ==
                                                  null
                                              ? teMarkController[index].text
                                              : value
                                                  .studentMEList[index].teMark
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
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Row(
                                                  children: [
                                                    const Text(
                                                      'Roll No: ',
                                                      style: TextStyle(),
                                                    ),
                                                    value.studentMEList[index]
                                                                .rollNo ==
                                                            null
                                                        ? const Text(
                                                            '0',
                                                            style: TextStyle(
                                                                color: UIGuide
                                                                    .light_Purple),
                                                          )
                                                        : Text(
                                                            value
                                                                .studentMEList[
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
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        strutStyle:
                                                            const StrutStyle(
                                                                fontSize: 12.0),
                                                        text: TextSpan(
                                                          style: const TextStyle(
                                                              color: UIGuide
                                                                  .light_Purple),
                                                          text: value
                                                              .studentMEList[
                                                                  index]
                                                              .name,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
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
                                                                    .studentMEList[
                                                                        index]
                                                                    .attendance ==
                                                                'A') {
                                                              value
                                                                  .studentMEList[
                                                                      index]
                                                                  .attendance = 'P';
                                                            } else {
                                                              value
                                                                  .studentMEList[
                                                                      index]
                                                                  .attendance = 'A';
                                                              value
                                                                  .studentMEList[
                                                                      index]
                                                                  .teMark = null;

                                                              teMarkController[
                                                                      index]
                                                                  .clear();
                                                            }
                                                            attendancee = value
                                                                .studentMEList[
                                                                    index]
                                                                .attendance;

                                                            print(
                                                                "attendace   $attendancee");
                                                          });
                                                        },
                                                        child: Container(
                                                          color: Colors
                                                              .transparent,
                                                          width: 28,
                                                          height: 26,
                                                          child: SizedBox(
                                                              width: 28,
                                                              height: 26,
                                                              child: value.studentMEList[index].attendance ==
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
                                                          controller:
                                                              teMarkController[
                                                                  index],
                                                          focusNode:
                                                              FocusNode(),
                                                          enabled: value
                                                                      .studentMEList[
                                                                          index]
                                                                      .attendance ==
                                                                  'A'
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
                                                                    newValue
                                                                        .text;
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
                                                                  focusColor:
                                                                      const Color.fromARGB(
                                                                          255,
                                                                          213,
                                                                          215,
                                                                          218),
                                                                  border:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
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
                                                                        BorderRadius.circular(
                                                                            10.0),
                                                                  ),
                                                                  fillColor:
                                                                      Colors
                                                                          .grey,
                                                                  hintStyle:
                                                                      const TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontSize:
                                                                        16,
                                                                    fontFamily:
                                                                        "verdana_regular",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                  ),
                                                                  labelText: value
                                                                          .maxmarkList[
                                                                              0]
                                                                          .teCaption ??
                                                                      "",
                                                                  labelStyle: const TextStyle(
                                                                      fontSize:
                                                                          13,
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          106,
                                                                          107,
                                                                          109))),
                                                          onChanged: (value1) {
                                                            teMarkController[
                                                                        index]
                                                                    .text =
                                                                value
                                                                    .studentMEList[
                                                                        index]
                                                                    .teMark
                                                                    .toString();
                                                            teMarkController[
                                                                    index]
                                                                .text = value1;
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
                                                                value
                                                                    .maxmarkList[
                                                                        0]
                                                                    .teMax!) {
                                                              teMarkController[
                                                                      index]
                                                                  .clear();
                                                            }
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
                                                            "(${value.maxmarkList[0].teMax})",
                                                            style:
                                                                const TextStyle(
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

                        else if (providerr.maxmarkList[0].teMax == null &&
                            providerr.maxmarkList[0].peMax != null &&
                            providerr.maxmarkList[0].ceMax == null) {
                          return LimitedBox(
                              maxHeight: size.height / 1.85,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: value.studentMEList.length,
                                    itemBuilder: ((context, index) {
                                      String pre = 'P';
                                      markfieldController.text = pre;

                                      practicalMarkController
                                          .add(new TextEditingController());

                                      practicalMarkController[index]
                                              .text
                                              .isEmpty
                                          ? practicalMarkController[index]
                                              .text = value.studentMEList[index]
                                                      .peMark ==
                                                  null
                                              ? practicalMarkController[index]
                                                  .text
                                              : value
                                                  .studentMEList[index].peMark
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
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Row(
                                                  children: [
                                                    const Text(
                                                      'Roll No: ',
                                                      style: TextStyle(),
                                                    ),
                                                    value.studentMEList[index]
                                                                .rollNo ==
                                                            null
                                                        ? const Text(
                                                            '0',
                                                            style: TextStyle(
                                                                color: UIGuide
                                                                    .light_Purple),
                                                          )
                                                        : Text(
                                                            value
                                                                .studentMEList[
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
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        strutStyle:
                                                            const StrutStyle(
                                                                fontSize: 12.0),
                                                        text: TextSpan(
                                                          style: const TextStyle(
                                                              color: UIGuide
                                                                  .light_Purple),
                                                          text: value
                                                              .studentMEList[
                                                                  index]
                                                              .name,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
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
                                                                    .studentMEList[
                                                                        index]
                                                                    .attendance ==
                                                                'A') {
                                                              value
                                                                  .studentMEList[
                                                                      index]
                                                                  .attendance = 'P';
                                                            } else {
                                                              value
                                                                  .studentMEList[
                                                                      index]
                                                                  .attendance = 'A';

                                                              value
                                                                  .studentMEList[
                                                                      index]
                                                                  .peMark = null;
                                                              practicalMarkController[
                                                                      index]
                                                                  .clear();
                                                            }
                                                            attendancee = value
                                                                .studentMEList[
                                                                    index]
                                                                .attendance;

                                                            print(
                                                                "attendace   $attendancee");
                                                          });
                                                        },
                                                        child: Container(
                                                          color: Colors
                                                              .transparent,
                                                          width: 28,
                                                          height: 26,
                                                          child: SizedBox(
                                                              width: 28,
                                                              height: 26,
                                                              child: value.studentMEList[index].attendance ==
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
                                                          controller:
                                                              practicalMarkController[
                                                                  index],
                                                          focusNode:
                                                              FocusNode(),
                                                          enabled: value
                                                                      .studentMEList[
                                                                          index]
                                                                      .attendance ==
                                                                  'A'
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
                                                                    newValue
                                                                        .text;
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
                                                                  focusColor:
                                                                      const Color.fromARGB(
                                                                          255,
                                                                          213,
                                                                          215,
                                                                          218),
                                                                  border:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
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
                                                                        BorderRadius.circular(
                                                                            10.0),
                                                                  ),
                                                                  fillColor:
                                                                      Colors
                                                                          .grey,
                                                                  hintStyle:
                                                                      const TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontSize:
                                                                        16,
                                                                    fontFamily:
                                                                        "verdana_regular",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                  ),
                                                                  labelText: value
                                                                          .maxmarkList[
                                                                              0]
                                                                          .peCaption ??
                                                                      "",
                                                                  labelStyle: const TextStyle(
                                                                      fontSize:
                                                                          13,
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          106,
                                                                          107,
                                                                          109))),
                                                          onChanged: (value1) {
                                                            practicalMarkController[
                                                                        index]
                                                                    .text =
                                                                value
                                                                    .studentMEList[
                                                                        index]
                                                                    .peMark
                                                                    .toString();
                                                            practicalMarkController[
                                                                    index]
                                                                .text = value1;
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
                                                                value
                                                                    .maxmarkList[
                                                                        0]
                                                                    .peMax!) {
                                                              practicalMarkController[
                                                                      index]
                                                                  .clear();
                                                            }
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
                                                            "(${value.maxmarkList[0].peMax})",
                                                            style:
                                                                const TextStyle(
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

                        else if (providerr.maxmarkList[0].teMax == null &&
                            providerr.maxmarkList[0].peMax == null &&
                            providerr.maxmarkList[0].ceMax != null) {
                          return LimitedBox(
                              maxHeight: size.height / 1.85,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: value.studentMEList.length,
                                    itemBuilder: ((context, index) {
                                      String pre = 'P';
                                      markfieldController.text = pre;

                                      ceMarkController
                                          .add(new TextEditingController());

                                      ceMarkController[index].text.isEmpty
                                          ? ceMarkController[index].text = value
                                                      .studentMEList[index]
                                                      .ceMark ==
                                                  null
                                              ? ceMarkController[index].text
                                              : value
                                                  .studentMEList[index].ceMark
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
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Row(
                                                  children: [
                                                    const Text(
                                                      'Roll No: ',
                                                      style: TextStyle(),
                                                    ),
                                                    value.studentMEList[index]
                                                                .rollNo ==
                                                            null
                                                        ? const Text(
                                                            '0',
                                                            style: TextStyle(
                                                                color: UIGuide
                                                                    .light_Purple),
                                                          )
                                                        : Text(
                                                            value
                                                                .studentMEList[
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
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        strutStyle:
                                                            const StrutStyle(
                                                                fontSize: 12.0),
                                                        text: TextSpan(
                                                          style: const TextStyle(
                                                              color: UIGuide
                                                                  .light_Purple),
                                                          text: value
                                                              .studentMEList[
                                                                  index]
                                                              .name,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
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
                                                                    .studentMEList[
                                                                        index]
                                                                    .attendance ==
                                                                'A') {
                                                              value
                                                                  .studentMEList[
                                                                      index]
                                                                  .attendance = 'P';
                                                            } else {
                                                              value
                                                                  .studentMEList[
                                                                      index]
                                                                  .attendance = 'A';

                                                              value
                                                                  .studentMEList[
                                                                      index]
                                                                  .ceMark = null;

                                                              ceMarkController
                                                                  .clear();
                                                            }
                                                            attendancee = value
                                                                .studentMEList[
                                                                    index]
                                                                .attendance;

                                                            print(
                                                                "attendace   $attendancee");
                                                          });
                                                        },
                                                        child: Container(
                                                          color: Colors
                                                              .transparent,
                                                          width: 28,
                                                          height: 26,
                                                          child: SizedBox(
                                                              width: 28,
                                                              height: 26,
                                                              child: value.studentMEList[index].attendance ==
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
                                                          controller:
                                                              ceMarkController[
                                                                  index],
                                                          focusNode:
                                                              FocusNode(),
                                                          enabled: value
                                                                      .studentMEList[
                                                                          index]
                                                                      .attendance ==
                                                                  'A'
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
                                                                    newValue
                                                                        .text;
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
                                                                  focusColor:
                                                                      const Color.fromARGB(
                                                                          255,
                                                                          213,
                                                                          215,
                                                                          218),
                                                                  border:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
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
                                                                        BorderRadius.circular(
                                                                            10.0),
                                                                  ),
                                                                  fillColor:
                                                                      Colors
                                                                          .grey,
                                                                  hintStyle:
                                                                      const TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontSize:
                                                                        16,
                                                                    fontFamily:
                                                                        "verdana_regular",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                  ),
                                                                  labelText: value
                                                                          .maxmarkList[
                                                                              0]
                                                                          .ceCaption ??
                                                                      "",
                                                                  labelStyle: const TextStyle(
                                                                      fontSize:
                                                                          13,
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          106,
                                                                          107,
                                                                          109))),
                                                          onChanged: (value1) {
                                                            ceMarkController[
                                                                        index]
                                                                    .text =
                                                                value
                                                                    .studentMEList[
                                                                        index]
                                                                    .ceMark
                                                                    .toString();
                                                            ceMarkController[
                                                                    index]
                                                                .text = value1;
                                                            ceMarkController[
                                                                        index]
                                                                    .selection =
                                                                TextSelection.collapsed(
                                                                    offset: ceMarkController[
                                                                            index]
                                                                        .text
                                                                        .length);

                                                            if (double.parse(
                                                                    ceMarkController[
                                                                            index]
                                                                        .text) >
                                                                value
                                                                    .maxmarkList[
                                                                        0]
                                                                    .ceMax!) {
                                                              ceMarkController[
                                                                      index]
                                                                  .clear();
                                                            }
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
                                                            "(${value.maxmarkList[0].ceMax})",
                                                            style:
                                                                const TextStyle(
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

                      else if (providerr.typecode == "STATE" &&
                          providerr.maxmarkList[0].entryMethod == "Grade") {
///////////////-------------------------------------------------------------------------------------///////////////
///////////////-----------------------     TE Grade  --  PE Grade --  CE Grade  -------------------///////////////
///////////////-----------------------------------------------------------------------------------///////////////
                        if (providerr.maxmarkList[0].teCaption != null &&
                            providerr.maxmarkList[0].peCaption != null &&
                            providerr.maxmarkList[0].ceCaption != null) {
                          return LimitedBox(
                              maxHeight: size.height / 1.85,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: value.studentMEList.length,
                                    itemBuilder: ((context, index) {
                                      //TE Grade
                                      teGradeController
                                          .add(TextEditingController());
                                      teGradeController1
                                          .add(TextEditingController());

                                      teGradeController1[index].text.isEmpty
                                          ? teGradeController1[index]
                                              .text = value.studentMEList[index]
                                                      .teGradeId ==
                                                  null
                                              ? teGradeController1[index].text
                                              : value.studentMEList[index]
                                                  .teGradeId
                                                  .toString()
                                          : teGradeController1[index].text;
                                      teGradeController[index].text.isEmpty
                                          ? teGradeController[index]
                                              .text = value.studentMEList[index]
                                                      .teGrade ==
                                                  null
                                              ? teGradeController[index].text
                                              : value
                                                  .studentMEList[index].teGrade
                                                  .toString()
                                          : teGradeController[index].text;

                                      //Practical Grade
                                      praticalGradeController
                                          .add(TextEditingController());
                                      praticalGradeController1
                                          .add(TextEditingController());

                                      praticalGradeController1[index]
                                              .text
                                              .isEmpty
                                          ? praticalGradeController1[index]
                                              .text = value.studentMEList[index]
                                                      .peGradeId ==
                                                  null
                                              ? praticalGradeController1[index]
                                                  .text
                                              : value.studentMEList[index]
                                                  .peGradeId
                                                  .toString()
                                          : praticalGradeController1[index]
                                              .text;
                                      praticalGradeController[index]
                                              .text
                                              .isEmpty
                                          ? praticalGradeController[index]
                                              .text = value.studentMEList[index]
                                                      .peGrade ==
                                                  null
                                              ? praticalGradeController[index]
                                                  .text
                                              : value
                                                  .studentMEList[index].peGrade
                                                  .toString()
                                          : praticalGradeController[index].text;

                                      //CE Grade
                                      ceGradeController
                                          .add(TextEditingController());
                                      ceGradeController1
                                          .add(TextEditingController());

                                      ceGradeController1[index].text.isEmpty
                                          ? ceGradeController1[index]
                                              .text = value.studentMEList[index]
                                                      .ceGradeId ==
                                                  null
                                              ? ceGradeController1[index].text
                                              : value.studentMEList[index]
                                                  .ceGradeId
                                                  .toString()
                                          : ceGradeController1[index].text;
                                      ceGradeController[index].text.isEmpty
                                          ? ceGradeController[index]
                                              .text = value.studentMEList[index]
                                                      .ceGrade ==
                                                  null
                                              ? ceGradeController[index].text
                                              : value
                                                  .studentMEList[index].ceGrade
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
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 80,
                                                      child: Text(
                                                        'Roll No: ${value.studentMEList[index].rollNo == null ? '0' : value.studentMEList[index].rollNo.toString()}',
                                                        overflow: TextOverflow
                                                            .ellipsis,
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
                                                                    .studentMEList[
                                                                        index]
                                                                    .attendance ==
                                                                'A') {
                                                              value
                                                                  .studentMEList[
                                                                      index]
                                                                  .attendance = 'P';
                                                            } else {
                                                              value
                                                                  .studentMEList[
                                                                      index]
                                                                  .attendance = 'A';

                                                              value
                                                                  .studentMEList[
                                                                      index]
                                                                  .ceGrade = null;
                                                              value
                                                                  .studentMEList[
                                                                      index]
                                                                  .ceGradeId = null;

                                                              ceGradeController[
                                                                      index]
                                                                  .clear();
                                                              ceGradeController1[
                                                                      index]
                                                                  .clear();

                                                              value
                                                                  .studentMEList[
                                                                      index]
                                                                  .teGrade = null;
                                                              value
                                                                  .studentMEList[
                                                                      index]
                                                                  .teGradeId = null;

                                                              teGradeController[
                                                                      index]
                                                                  .clear();
                                                              teGradeController1[
                                                                      index]
                                                                  .clear();

                                                              value
                                                                  .studentMEList[
                                                                      index]
                                                                  .peGrade = null;
                                                              value
                                                                  .studentMEList[
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
                                                                .studentMEList[
                                                                    index]
                                                                .attendance;

                                                            print(
                                                                "attendace   $attendancee");
                                                          });
                                                        },
                                                        child: Container(
                                                          color: Colors
                                                              .transparent,
                                                          width: 28,
                                                          height: 26,
                                                          child: SizedBox(
                                                              width: 28,
                                                              height: 26,
                                                              child: value.studentMEList[index].attendance ==
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
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        strutStyle:
                                                            const StrutStyle(
                                                                fontSize: 12.0),
                                                        text: TextSpan(
                                                          style: const TextStyle(
                                                              color: UIGuide
                                                                  .light_Purple),
                                                          text: value
                                                              .studentMEList[
                                                                  index]
                                                              .name,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      LimitedBox(
                                                        maxWidth: 80,
                                                        child: Text(
                                                          '${value.maxmarkList[0].teCaption ?? ""} : ',
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 40,
                                                        width: 80,
                                                        child: SizedBox(
                                                          height: 40,
                                                          width: 100,
                                                          child: Consumer<
                                                                  MarkEntryProvider>(
                                                              builder: (context,
                                                                  snapshot,
                                                                  child) {
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
                                                                            itemCount: snapshot.gradeList.length,
                                                                            itemBuilder: (context, indx) {
                                                                              return ListTile(
                                                                                selectedTileColor: Colors.blue.shade100,
                                                                                selectedColor: UIGuide.PRIMARY2,
                                                                                onTap: () {
                                                                                  teGradeController[index].text = snapshot.gradeList[indx].gradeName ?? '--';
                                                                                  teGradeController1[index].text = snapshot.gradeList[indx].gradeId ?? '--';
                                                                                  value.studentMEList[index].teGradeId = teGradeController1[index].text;
                                                                                  value.studentMEList[index].teGrade = teGradeController[index].text;
                                                                                  value.studentMEList[index].teGrade = value.studentMEList[index].teGrade;
                                                                                  Navigator.of(context).pop();
                                                                                },
                                                                                title: Text(
                                                                                  snapshot.gradeList[indx].gradeName ?? '--',
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
                                                                            .all(
                                                                        5.0),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  children: [
                                                                    Container(
                                                                      height:
                                                                          30,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        border: Border.all(
                                                                            color:
                                                                                UIGuide.light_Purple,
                                                                            width: 1),
                                                                      ),
                                                                      child:
                                                                          TextField(
                                                                        enabled: value.studentMEList[index].attendance ==
                                                                                'A'
                                                                            ? true
                                                                            : false,
                                                                        readOnly:
                                                                            true,
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                14,
                                                                            overflow:
                                                                                TextOverflow.clip),
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        controller:
                                                                            teGradeController[index],
                                                                        decoration:
                                                                            const InputDecoration(
                                                                          filled:
                                                                              true,
                                                                          contentPadding: EdgeInsets.only(
                                                                              left: 0,
                                                                              top: 0),
                                                                          floatingLabelBehavior:
                                                                              FloatingLabelBehavior.never,
                                                                          fillColor: Color.fromARGB(
                                                                              255,
                                                                              255,
                                                                              255,
                                                                              255),
                                                                          border:
                                                                              OutlineInputBorder(),
                                                                          labelText:
                                                                              "  Select grade",
                                                                          hintText:
                                                                              "grade",
                                                                        ),
                                                                        onChanged:
                                                                            (value1) {
                                                                          teGradeController1[index].text = value
                                                                              .studentMEList[index]
                                                                              .teGradeId
                                                                              .toString();
                                                                          teGradeController1[index].text =
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
                                                          '${value.maxmarkList[0].ceCaption ?? ""} : ',
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 40,
                                                        width: 80,
                                                        child: SizedBox(
                                                          height: 40,
                                                          width: 100,
                                                          child: Consumer<
                                                                  MarkEntryProvider>(
                                                              builder: (context,
                                                                  snapshot,
                                                                  child) {
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
                                                                            itemCount: snapshot.gradeList.length,
                                                                            itemBuilder: (context, indx) {
                                                                              return ListTile(
                                                                                selectedTileColor: Colors.blue.shade100,
                                                                                selectedColor: UIGuide.PRIMARY2,
                                                                                onTap: () {
                                                                                  ceGradeController[index].text = snapshot.gradeList[indx].gradeName ?? '--';
                                                                                  ceGradeController1[index].text = snapshot.gradeList[indx].gradeId ?? '--';
                                                                                  value.studentMEList[index].ceGradeId = ceGradeController1[index].text;
                                                                                  value.studentMEList[index].ceGrade = ceGradeController[index].text;
                                                                                  value.studentMEList[index].ceGrade = value.studentMEList[index].ceGrade;
                                                                                  Navigator.of(context).pop();
                                                                                },
                                                                                title: Text(
                                                                                  snapshot.gradeList[indx].gradeName ?? '--',
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
                                                                            .all(
                                                                        5.0),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  children: [
                                                                    Container(
                                                                      height:
                                                                          30,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        border: Border.all(
                                                                            color:
                                                                                UIGuide.light_Purple,
                                                                            width: 1),
                                                                      ),
                                                                      child:
                                                                          TextField(
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                14,
                                                                            overflow:
                                                                                TextOverflow.clip),
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        controller:
                                                                            ceGradeController[index],
                                                                        decoration:
                                                                            const InputDecoration(
                                                                          filled:
                                                                              true,
                                                                          contentPadding: EdgeInsets.only(
                                                                              left: 0,
                                                                              top: 0),
                                                                          floatingLabelBehavior:
                                                                              FloatingLabelBehavior.never,
                                                                          fillColor: Color.fromARGB(
                                                                              255,
                                                                              255,
                                                                              255,
                                                                              255),
                                                                          border:
                                                                              OutlineInputBorder(),
                                                                          labelText:
                                                                              "  Select grade",
                                                                          hintText:
                                                                              "grade",
                                                                        ),
                                                                        enabled: value.studentMEList[index].attendance ==
                                                                                'A'
                                                                            ? true
                                                                            : false,
                                                                        readOnly:
                                                                            true,
                                                                        onChanged:
                                                                            (value1) {
                                                                          ceGradeController1[index].text = value
                                                                              .studentMEList[index]
                                                                              .ceGradeId
                                                                              .toString();
                                                                          ceGradeController1[index].text =
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
                                                          '${value.maxmarkList[0].peCaption ?? ""} : ',
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 40,
                                                        width: 80,
                                                        child: SizedBox(
                                                          height: 40,
                                                          width: 100,
                                                          child: Consumer<
                                                                  MarkEntryProvider>(
                                                              builder: (context,
                                                                  snapshot,
                                                                  child) {
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
                                                                            itemCount: snapshot.gradeList.length,
                                                                            itemBuilder: (context, indx) {
                                                                              return ListTile(
                                                                                selectedTileColor: Colors.blue.shade100,
                                                                                selectedColor: UIGuide.PRIMARY2,
                                                                                onTap: () {
                                                                                  praticalGradeController[index].text = snapshot.gradeList[indx].gradeName ?? '--';
                                                                                  praticalGradeController1[index].text = snapshot.gradeList[indx].gradeId ?? '--';
                                                                                  value.studentMEList[index].peGradeId = praticalGradeController1[index].text;
                                                                                  value.studentMEList[index].peGrade = praticalGradeController[index].text;
                                                                                  value.studentMEList[index].peGrade = value.studentMEList[index].peGrade;
                                                                                  Navigator.of(context).pop();
                                                                                },
                                                                                title: Text(
                                                                                  snapshot.gradeList[indx].gradeName ?? '--',
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
                                                                            .all(
                                                                        5.0),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  children: [
                                                                    Container(
                                                                      height:
                                                                          30,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        border: Border.all(
                                                                            color:
                                                                                UIGuide.light_Purple,
                                                                            width: 1),
                                                                      ),
                                                                      child:
                                                                          TextField(
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                14,
                                                                            overflow:
                                                                                TextOverflow.clip),
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        controller:
                                                                            praticalGradeController[index],
                                                                        decoration:
                                                                            const InputDecoration(
                                                                          filled:
                                                                              true,
                                                                          contentPadding: EdgeInsets.only(
                                                                              left: 0,
                                                                              top: 0),
                                                                          floatingLabelBehavior:
                                                                              FloatingLabelBehavior.never,
                                                                          fillColor: Color.fromARGB(
                                                                              255,
                                                                              255,
                                                                              255,
                                                                              255),
                                                                          border:
                                                                              OutlineInputBorder(),
                                                                          labelText:
                                                                              "  Select grade",
                                                                          hintText:
                                                                              "grade",
                                                                        ),
                                                                        enabled: value.studentMEList[index].attendance ==
                                                                                'A'
                                                                            ? true
                                                                            : false,
                                                                        readOnly:
                                                                            true,
                                                                        onChanged:
                                                                            (value1) {
                                                                          praticalGradeController1[index].text = value
                                                                              .studentMEList[index]
                                                                              .peGradeId
                                                                              .toString();
                                                                          praticalGradeController1[index].text =
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
                        if (providerr.maxmarkList[0].teCaption != null &&
                            providerr.maxmarkList[0].peCaption == null &&
                            providerr.maxmarkList[0].ceCaption != null) {
                          return LimitedBox(
                              maxHeight: size.height / 1.85,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: value.studentMEList.length,
                                    itemBuilder: ((context, index) {
                                      //TE Grade
                                      teGradeController
                                          .add(TextEditingController());
                                      teGradeController1
                                          .add(TextEditingController());

                                      teGradeController1[index].text.isEmpty
                                          ? teGradeController1[index]
                                              .text = value.studentMEList[index]
                                                      .teGradeId ==
                                                  null
                                              ? teGradeController1[index].text
                                              : value.studentMEList[index]
                                                  .teGradeId
                                                  .toString()
                                          : teGradeController1[index].text;
                                      teGradeController[index].text.isEmpty
                                          ? teGradeController[index]
                                              .text = value.studentMEList[index]
                                                      .teGrade ==
                                                  null
                                              ? teGradeController[index].text
                                              : value
                                                  .studentMEList[index].teGrade
                                                  .toString()
                                          : teGradeController[index].text;

                                      //CE Grade
                                      ceGradeController
                                          .add(TextEditingController());
                                      ceGradeController1
                                          .add(TextEditingController());

                                      ceGradeController1[index].text.isEmpty
                                          ? ceGradeController1[index]
                                              .text = value.studentMEList[index]
                                                      .ceGradeId ==
                                                  null
                                              ? ceGradeController1[index].text
                                              : value.studentMEList[index]
                                                  .ceGradeId
                                                  .toString()
                                          : ceGradeController1[index].text;
                                      ceGradeController[index].text.isEmpty
                                          ? ceGradeController[index]
                                              .text = value.studentMEList[index]
                                                      .ceGrade ==
                                                  null
                                              ? ceGradeController[index].text
                                              : value
                                                  .studentMEList[index].ceGrade
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
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 80,
                                                      child: Text(
                                                        'Roll No: ${value.studentMEList[index].rollNo == null ? '0' : value.studentMEList[index].rollNo.toString()}',
                                                        overflow: TextOverflow
                                                            .ellipsis,
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
                                                                    .studentMEList[
                                                                        index]
                                                                    .attendance ==
                                                                'A') {
                                                              value
                                                                  .studentMEList[
                                                                      index]
                                                                  .attendance = 'P';
                                                            } else {
                                                              value
                                                                  .studentMEList[
                                                                      index]
                                                                  .attendance = 'A';

                                                              value
                                                                  .studentMEList[
                                                                      index]
                                                                  .ceGrade = null;
                                                              value
                                                                  .studentMEList[
                                                                      index]
                                                                  .ceGradeId = null;

                                                              ceGradeController[
                                                                      index]
                                                                  .clear();
                                                              ceGradeController1[
                                                                      index]
                                                                  .clear();

                                                              value
                                                                  .studentMEList[
                                                                      index]
                                                                  .teGrade = null;
                                                              value
                                                                  .studentMEList[
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
                                                                .studentMEList[
                                                                    index]
                                                                .attendance;

                                                            print(
                                                                "attendace   $attendancee");
                                                          });
                                                        },
                                                        child: Container(
                                                          color: Colors
                                                              .transparent,
                                                          width: 28,
                                                          height: 26,
                                                          child: SizedBox(
                                                              width: 28,
                                                              height: 26,
                                                              child: value.studentMEList[index].attendance ==
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
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        strutStyle:
                                                            const StrutStyle(
                                                                fontSize: 12.0),
                                                        text: TextSpan(
                                                          style: const TextStyle(
                                                              color: UIGuide
                                                                  .light_Purple),
                                                          text: value
                                                              .studentMEList[
                                                                  index]
                                                              .name,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      LimitedBox(
                                                        maxWidth: 80,
                                                        child: Text(
                                                          '${value.maxmarkList[0].teCaption ?? ""} : ',
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 40,
                                                        width: 80,
                                                        child: SizedBox(
                                                          height: 40,
                                                          width: 100,
                                                          child: Consumer<
                                                                  MarkEntryProvider>(
                                                              builder: (context,
                                                                  snapshot,
                                                                  child) {
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
                                                                            itemCount: snapshot.gradeList.length,
                                                                            itemBuilder: (context, indx) {
                                                                              return ListTile(
                                                                                selectedTileColor: Colors.blue.shade100,
                                                                                selectedColor: UIGuide.PRIMARY2,
                                                                                onTap: () {
                                                                                  teGradeController[index].text = snapshot.gradeList[indx].gradeName ?? '--';
                                                                                  teGradeController1[index].text = snapshot.gradeList[indx].gradeId ?? '--';
                                                                                  value.studentMEList[index].teGradeId = teGradeController1[index].text;
                                                                                  value.studentMEList[index].teGrade = teGradeController[index].text;
                                                                                  value.studentMEList[index].teGrade = value.studentMEList[index].teGrade;
                                                                                  Navigator.of(context).pop();
                                                                                },
                                                                                title: Text(
                                                                                  snapshot.gradeList[indx].gradeName ?? '--',
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
                                                                            .all(
                                                                        5.0),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  children: [
                                                                    Container(
                                                                      height:
                                                                          30,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        border: Border.all(
                                                                            color:
                                                                                UIGuide.light_Purple,
                                                                            width: 1),
                                                                      ),
                                                                      child:
                                                                          TextField(
                                                                        enabled: value.studentMEList[index].attendance ==
                                                                                'A'
                                                                            ? true
                                                                            : false,
                                                                        readOnly:
                                                                            true,
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                14,
                                                                            overflow:
                                                                                TextOverflow.clip),
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        controller:
                                                                            teGradeController[index],
                                                                        decoration:
                                                                            const InputDecoration(
                                                                          filled:
                                                                              true,
                                                                          contentPadding: EdgeInsets.only(
                                                                              left: 0,
                                                                              top: 0),
                                                                          floatingLabelBehavior:
                                                                              FloatingLabelBehavior.never,
                                                                          fillColor: Color.fromARGB(
                                                                              255,
                                                                              255,
                                                                              255,
                                                                              255),
                                                                          border:
                                                                              OutlineInputBorder(),
                                                                          labelText:
                                                                              "  Select grade",
                                                                          hintText:
                                                                              "grade",
                                                                        ),
                                                                        onChanged:
                                                                            (value1) {
                                                                          teGradeController1[index].text = value
                                                                              .studentMEList[index]
                                                                              .teGradeId
                                                                              .toString();
                                                                          teGradeController1[index].text =
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
                                                          '${value.maxmarkList[0].ceCaption ?? ""} : ',
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 40,
                                                        width: 80,
                                                        child: SizedBox(
                                                          height: 40,
                                                          width: 100,
                                                          child: Consumer<
                                                                  MarkEntryProvider>(
                                                              builder: (context,
                                                                  snapshot,
                                                                  child) {
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
                                                                            itemCount: snapshot.gradeList.length,
                                                                            itemBuilder: (context, indx) {
                                                                              return ListTile(
                                                                                selectedTileColor: Colors.blue.shade100,
                                                                                selectedColor: UIGuide.PRIMARY2,
                                                                                onTap: () {
                                                                                  ceGradeController[index].text = snapshot.gradeList[indx].gradeName ?? '--';
                                                                                  ceGradeController1[index].text = snapshot.gradeList[indx].gradeId ?? '--';
                                                                                  value.studentMEList[index].ceGradeId = ceGradeController1[index].text;
                                                                                  value.studentMEList[index].ceGrade = ceGradeController[index].text;
                                                                                  value.studentMEList[index].ceGrade = value.studentMEList[index].ceGrade;
                                                                                  Navigator.of(context).pop();
                                                                                },
                                                                                title: Text(
                                                                                  snapshot.gradeList[indx].gradeName ?? '--',
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
                                                                            .all(
                                                                        5.0),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  children: [
                                                                    Container(
                                                                      height:
                                                                          30,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        border: Border.all(
                                                                            color:
                                                                                UIGuide.light_Purple,
                                                                            width: 1),
                                                                      ),
                                                                      child:
                                                                          TextField(
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                14,
                                                                            overflow:
                                                                                TextOverflow.clip),
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        controller:
                                                                            ceGradeController[index],
                                                                        decoration:
                                                                            const InputDecoration(
                                                                          filled:
                                                                              true,
                                                                          contentPadding: EdgeInsets.only(
                                                                              left: 0,
                                                                              top: 0),
                                                                          floatingLabelBehavior:
                                                                              FloatingLabelBehavior.never,
                                                                          fillColor: Color.fromARGB(
                                                                              255,
                                                                              255,
                                                                              255,
                                                                              255),
                                                                          border:
                                                                              OutlineInputBorder(),
                                                                          labelText:
                                                                              "  Select grade",
                                                                          hintText:
                                                                              "grade",
                                                                        ),
                                                                        enabled: value.studentMEList[index].attendance ==
                                                                                'A'
                                                                            ? true
                                                                            : false,
                                                                        readOnly:
                                                                            true,
                                                                        onChanged:
                                                                            (value1) {
                                                                          ceGradeController1[index].text = value
                                                                              .studentMEList[index]
                                                                              .ceGradeId
                                                                              .toString();
                                                                          ceGradeController1[index].text =
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
                        if (providerr.maxmarkList[0].teCaption != null &&
                            providerr.maxmarkList[0].peCaption != null &&
                            providerr.maxmarkList[0].ceCaption == null) {
                          return LimitedBox(
                              maxHeight: size.height / 1.85,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: value.studentMEList.length,
                                    itemBuilder: ((context, index) {
                                      //TE Grade
                                      teGradeController
                                          .add(TextEditingController());
                                      teGradeController1
                                          .add(TextEditingController());

                                      teGradeController1[index].text.isEmpty
                                          ? teGradeController1[index]
                                              .text = value.studentMEList[index]
                                                      .teGradeId ==
                                                  null
                                              ? teGradeController1[index].text
                                              : value.studentMEList[index]
                                                  .teGradeId
                                                  .toString()
                                          : teGradeController1[index].text;
                                      teGradeController[index].text.isEmpty
                                          ? teGradeController[index]
                                              .text = value.studentMEList[index]
                                                      .teGrade ==
                                                  null
                                              ? teGradeController[index].text
                                              : value
                                                  .studentMEList[index].teGrade
                                                  .toString()
                                          : teGradeController[index].text;

                                      //Practical Grade
                                      praticalGradeController
                                          .add(TextEditingController());
                                      praticalGradeController1
                                          .add(TextEditingController());

                                      praticalGradeController1[index]
                                              .text
                                              .isEmpty
                                          ? praticalGradeController1[index]
                                              .text = value.studentMEList[index]
                                                      .peGradeId ==
                                                  null
                                              ? praticalGradeController1[index]
                                                  .text
                                              : value
                                                  .studentMEList[index].peGrade
                                                  .toString()
                                          : praticalGradeController1[index]
                                              .text;
                                      praticalGradeController[index]
                                              .text
                                              .isEmpty
                                          ? praticalGradeController[index]
                                              .text = value.studentMEList[index]
                                                      .peGrade ==
                                                  null
                                              ? praticalGradeController[index]
                                                  .text
                                              : value
                                                  .studentMEList[index].peGrade
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
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 80,
                                                      child: Text(
                                                        'Roll No: ${value.studentMEList[index].rollNo == null ? '0' : value.studentMEList[index].rollNo.toString()}',
                                                        overflow: TextOverflow
                                                            .ellipsis,
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
                                                                    .studentMEList[
                                                                        index]
                                                                    .attendance ==
                                                                'A') {
                                                              value
                                                                  .studentMEList[
                                                                      index]
                                                                  .attendance = 'P';
                                                            } else {
                                                              value
                                                                  .studentMEList[
                                                                      index]
                                                                  .attendance = 'A';

                                                              value
                                                                  .studentMEList[
                                                                      index]
                                                                  .teGrade = null;
                                                              value
                                                                  .studentMEList[
                                                                      index]
                                                                  .teGradeId = null;

                                                              teGradeController[
                                                                      index]
                                                                  .clear();
                                                              teGradeController1[
                                                                      index]
                                                                  .clear();

                                                              value
                                                                  .studentMEList[
                                                                      index]
                                                                  .peGrade = null;
                                                              value
                                                                  .studentMEList[
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
                                                                .studentMEList[
                                                                    index]
                                                                .attendance;

                                                            print(
                                                                "attendace   $attendancee");
                                                          });
                                                        },
                                                        child: Container(
                                                          color: Colors
                                                              .transparent,
                                                          width: 28,
                                                          height: 26,
                                                          child: SizedBox(
                                                              width: 28,
                                                              height: 26,
                                                              child: value.studentMEList[index].attendance ==
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
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        strutStyle:
                                                            const StrutStyle(
                                                                fontSize: 12.0),
                                                        text: TextSpan(
                                                          style: const TextStyle(
                                                              color: UIGuide
                                                                  .light_Purple),
                                                          text: value
                                                              .studentMEList[
                                                                  index]
                                                              .name,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      LimitedBox(
                                                        maxWidth: 80,
                                                        child: Text(
                                                          '${value.maxmarkList[0].teCaption ?? ""} : ',
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 40,
                                                        width: 80,
                                                        child: SizedBox(
                                                          height: 40,
                                                          width: 100,
                                                          child: Consumer<
                                                                  MarkEntryProvider>(
                                                              builder: (context,
                                                                  snapshot,
                                                                  child) {
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
                                                                            itemCount: snapshot.gradeList.length,
                                                                            itemBuilder: (context, indx) {
                                                                              return ListTile(
                                                                                selectedTileColor: Colors.blue.shade100,
                                                                                selectedColor: UIGuide.PRIMARY2,
                                                                                onTap: () {
                                                                                  teGradeController[index].text = snapshot.gradeList[indx].gradeName ?? '--';
                                                                                  teGradeController1[index].text = snapshot.gradeList[indx].gradeId ?? '--';
                                                                                  value.studentMEList[index].teGradeId = teGradeController1[index].text;
                                                                                  value.studentMEList[index].teGrade = teGradeController[index].text;
                                                                                  value.studentMEList[index].teGrade = value.studentMEList[index].teGrade;
                                                                                  Navigator.of(context).pop();
                                                                                },
                                                                                title: Text(
                                                                                  snapshot.gradeList[indx].gradeName ?? '--',
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
                                                                            .all(
                                                                        5.0),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  children: [
                                                                    Container(
                                                                      height:
                                                                          30,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        border: Border.all(
                                                                            color:
                                                                                UIGuide.light_Purple,
                                                                            width: 1),
                                                                      ),
                                                                      child:
                                                                          TextField(
                                                                        enabled: value.studentMEList[index].attendance ==
                                                                                'A'
                                                                            ? true
                                                                            : false,
                                                                        readOnly:
                                                                            true,
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                14,
                                                                            overflow:
                                                                                TextOverflow.clip),
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        controller:
                                                                            teGradeController[index],
                                                                        decoration:
                                                                            const InputDecoration(
                                                                          filled:
                                                                              true,
                                                                          contentPadding: EdgeInsets.only(
                                                                              left: 0,
                                                                              top: 0),
                                                                          floatingLabelBehavior:
                                                                              FloatingLabelBehavior.never,
                                                                          fillColor: Color.fromARGB(
                                                                              255,
                                                                              255,
                                                                              255,
                                                                              255),
                                                                          border:
                                                                              OutlineInputBorder(),
                                                                          labelText:
                                                                              "  Select grade",
                                                                          hintText:
                                                                              "grade",
                                                                        ),
                                                                        onChanged:
                                                                            (value1) {
                                                                          teGradeController1[index].text = value
                                                                              .studentMEList[index]
                                                                              .teGradeId
                                                                              .toString();
                                                                          teGradeController1[index].text =
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
                                                          '${value.maxmarkList[0].peCaption ?? ""} : ',
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 40,
                                                        width: 80,
                                                        child: SizedBox(
                                                          height: 40,
                                                          width: 100,
                                                          child: Consumer<
                                                                  MarkEntryProvider>(
                                                              builder: (context,
                                                                  snapshot,
                                                                  child) {
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
                                                                            itemCount: snapshot.gradeList.length,
                                                                            itemBuilder: (context, indx) {
                                                                              return ListTile(
                                                                                selectedTileColor: Colors.blue.shade100,
                                                                                selectedColor: UIGuide.PRIMARY2,
                                                                                onTap: () {
                                                                                  praticalGradeController[index].text = snapshot.gradeList[indx].gradeName ?? '--';
                                                                                  praticalGradeController1[index].text = snapshot.gradeList[indx].gradeId ?? '--';
                                                                                  value.studentMEList[index].peGradeId = praticalGradeController1[index].text;
                                                                                  value.studentMEList[index].peGrade = praticalGradeController[index].text;
                                                                                  value.studentMEList[index].peGrade = value.studentMEList[index].peGrade;
                                                                                  Navigator.of(context).pop();
                                                                                },
                                                                                title: Text(
                                                                                  snapshot.gradeList[indx].gradeName ?? '--',
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
                                                                            .all(
                                                                        5.0),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  children: [
                                                                    Container(
                                                                      height:
                                                                          30,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        border: Border.all(
                                                                            color:
                                                                                UIGuide.light_Purple,
                                                                            width: 1),
                                                                      ),
                                                                      child:
                                                                          TextField(
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                14,
                                                                            overflow:
                                                                                TextOverflow.clip),
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        controller:
                                                                            praticalGradeController[index],
                                                                        decoration:
                                                                            const InputDecoration(
                                                                          filled:
                                                                              true,
                                                                          contentPadding: EdgeInsets.only(
                                                                              left: 0,
                                                                              top: 0),
                                                                          floatingLabelBehavior:
                                                                              FloatingLabelBehavior.never,
                                                                          fillColor: Color.fromARGB(
                                                                              255,
                                                                              255,
                                                                              255,
                                                                              255),
                                                                          border:
                                                                              OutlineInputBorder(),
                                                                          labelText:
                                                                              "  Select grade",
                                                                          hintText:
                                                                              "grade",
                                                                        ),
                                                                        enabled: value.studentMEList[index].attendance ==
                                                                                'A'
                                                                            ? true
                                                                            : false,
                                                                        readOnly:
                                                                            true,
                                                                        onChanged:
                                                                            (value1) {
                                                                          praticalGradeController1[index].text = value
                                                                              .studentMEList[index]
                                                                              .peGradeId
                                                                              .toString();
                                                                          praticalGradeController1[index].text =
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
                        if (providerr.maxmarkList[0].teCaption == null &&
                            providerr.maxmarkList[0].peCaption != null &&
                            providerr.maxmarkList[0].ceCaption != null) {
                          return LimitedBox(
                              maxHeight: size.height / 1.85,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: value.studentMEList.length,
                                    itemBuilder: ((context, index) {
                                      //Practical Grade
                                      praticalGradeController
                                          .add(TextEditingController());
                                      praticalGradeController1
                                          .add(TextEditingController());

                                      praticalGradeController1[index]
                                              .text
                                              .isEmpty
                                          ? praticalGradeController1[index]
                                              .text = value.studentMEList[index]
                                                      .peGradeId ==
                                                  null
                                              ? praticalGradeController1[index]
                                                  .text
                                              : value.studentMEList[index]
                                                  .peGradeId
                                                  .toString()
                                          : praticalGradeController1[index]
                                              .text;
                                      praticalGradeController[index]
                                              .text
                                              .isEmpty
                                          ? praticalGradeController[index]
                                              .text = value.studentMEList[index]
                                                      .peGrade ==
                                                  null
                                              ? praticalGradeController[index]
                                                  .text
                                              : value
                                                  .studentMEList[index].peGrade
                                                  .toString()
                                          : praticalGradeController[index].text;

                                      //CE Grade
                                      ceGradeController
                                          .add(TextEditingController());
                                      ceGradeController1
                                          .add(TextEditingController());

                                      ceGradeController1[index].text.isEmpty
                                          ? ceGradeController1[index]
                                              .text = value.studentMEList[index]
                                                      .ceGradeId ==
                                                  null
                                              ? ceGradeController1[index].text
                                              : value.studentMEList[index]
                                                  .ceGradeId
                                                  .toString()
                                          : ceGradeController1[index].text;
                                      ceGradeController[index].text.isEmpty
                                          ? ceGradeController[index]
                                              .text = value.studentMEList[index]
                                                      .ceGrade ==
                                                  null
                                              ? ceGradeController[index].text
                                              : value
                                                  .studentMEList[index].ceGrade
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
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 80,
                                                      child: Text(
                                                        'Roll No: ${value.studentMEList[index].rollNo == null ? '0' : value.studentMEList[index].rollNo.toString()}',
                                                        overflow: TextOverflow
                                                            .ellipsis,
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
                                                                    .studentMEList[
                                                                        index]
                                                                    .attendance ==
                                                                'A') {
                                                              value
                                                                  .studentMEList[
                                                                      index]
                                                                  .attendance = 'P';
                                                            } else {
                                                              value
                                                                  .studentMEList[
                                                                      index]
                                                                  .attendance = 'A';

                                                              value
                                                                  .studentMEList[
                                                                      index]
                                                                  .ceGrade = null;
                                                              value
                                                                  .studentMEList[
                                                                      index]
                                                                  .ceGradeId = null;

                                                              ceGradeController[
                                                                      index]
                                                                  .clear();
                                                              ceGradeController1[
                                                                      index]
                                                                  .clear();

                                                              value
                                                                  .studentMEList[
                                                                      index]
                                                                  .peGrade = null;
                                                              value
                                                                  .studentMEList[
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
                                                                .studentMEList[
                                                                    index]
                                                                .attendance;

                                                            print(
                                                                "attendace   $attendancee");
                                                          });
                                                        },
                                                        child: Container(
                                                          color: Colors
                                                              .transparent,
                                                          width: 28,
                                                          height: 26,
                                                          child: SizedBox(
                                                              width: 28,
                                                              height: 26,
                                                              child: value.studentMEList[index].attendance ==
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
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        strutStyle:
                                                            const StrutStyle(
                                                                fontSize: 12.0),
                                                        text: TextSpan(
                                                          style: const TextStyle(
                                                              color: UIGuide
                                                                  .light_Purple),
                                                          text: value
                                                              .studentMEList[
                                                                  index]
                                                              .name,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      LimitedBox(
                                                        maxWidth: 80,
                                                        child: Text(
                                                          '${value.maxmarkList[0].ceCaption ?? ""} : ',
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 40,
                                                        width: 80,
                                                        child: SizedBox(
                                                          height: 40,
                                                          width: 100,
                                                          child: Consumer<
                                                                  MarkEntryProvider>(
                                                              builder: (context,
                                                                  snapshot,
                                                                  child) {
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
                                                                            itemCount: snapshot.gradeList.length,
                                                                            itemBuilder: (context, indx) {
                                                                              return ListTile(
                                                                                selectedTileColor: Colors.blue.shade100,
                                                                                selectedColor: UIGuide.PRIMARY2,
                                                                                onTap: () {
                                                                                  ceGradeController[index].text = snapshot.gradeList[indx].gradeName ?? '--';
                                                                                  ceGradeController1[index].text = snapshot.gradeList[indx].gradeId ?? '--';
                                                                                  value.studentMEList[index].ceGradeId = ceGradeController1[index].text;
                                                                                  value.studentMEList[index].ceGrade = ceGradeController[index].text;
                                                                                  value.studentMEList[index].ceGrade = value.studentMEList[index].ceGrade;
                                                                                  Navigator.of(context).pop();
                                                                                },
                                                                                title: Text(
                                                                                  snapshot.gradeList[indx].gradeName ?? '--',
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
                                                                            .all(
                                                                        5.0),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  children: [
                                                                    Container(
                                                                      height:
                                                                          30,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        border: Border.all(
                                                                            color:
                                                                                UIGuide.light_Purple,
                                                                            width: 1),
                                                                      ),
                                                                      child:
                                                                          TextField(
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                14,
                                                                            overflow:
                                                                                TextOverflow.clip),
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        controller:
                                                                            ceGradeController[index],
                                                                        decoration:
                                                                            const InputDecoration(
                                                                          filled:
                                                                              true,
                                                                          contentPadding: EdgeInsets.only(
                                                                              left: 0,
                                                                              top: 0),
                                                                          floatingLabelBehavior:
                                                                              FloatingLabelBehavior.never,
                                                                          fillColor: Color.fromARGB(
                                                                              255,
                                                                              255,
                                                                              255,
                                                                              255),
                                                                          border:
                                                                              OutlineInputBorder(),
                                                                          labelText:
                                                                              "  Select grade",
                                                                          hintText:
                                                                              "grade",
                                                                        ),
                                                                        enabled: value.studentMEList[index].attendance ==
                                                                                'A'
                                                                            ? true
                                                                            : false,
                                                                        readOnly:
                                                                            true,
                                                                        onChanged:
                                                                            (value1) {
                                                                          ceGradeController1[index].text = value
                                                                              .studentMEList[index]
                                                                              .ceGradeId
                                                                              .toString();
                                                                          ceGradeController1[index].text =
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
                                                          '${value.maxmarkList[0].peCaption ?? ""} : ',
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 40,
                                                        width: 80,
                                                        child: SizedBox(
                                                          height: 40,
                                                          width: 100,
                                                          child: Consumer<
                                                                  MarkEntryProvider>(
                                                              builder: (context,
                                                                  snapshot,
                                                                  child) {
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
                                                                            itemCount: snapshot.gradeList.length,
                                                                            itemBuilder: (context, indx) {
                                                                              return ListTile(
                                                                                selectedTileColor: Colors.blue.shade100,
                                                                                selectedColor: UIGuide.PRIMARY2,
                                                                                onTap: () {
                                                                                  praticalGradeController[index].text = snapshot.gradeList[indx].gradeName ?? '--';
                                                                                  praticalGradeController1[index].text = snapshot.gradeList[indx].gradeId ?? '--';
                                                                                  value.studentMEList[index].peGradeId = praticalGradeController1[index].text;
                                                                                  value.studentMEList[index].peGrade = praticalGradeController[index].text;
                                                                                  value.studentMEList[index].peGrade = value.studentMEList[index].peGrade;
                                                                                  Navigator.of(context).pop();
                                                                                },
                                                                                title: Text(
                                                                                  snapshot.gradeList[indx].gradeName ?? '--',
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
                                                                            .all(
                                                                        5.0),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  children: [
                                                                    Container(
                                                                      height:
                                                                          30,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        border: Border.all(
                                                                            color:
                                                                                UIGuide.light_Purple,
                                                                            width: 1),
                                                                      ),
                                                                      child:
                                                                          TextField(
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                14,
                                                                            overflow:
                                                                                TextOverflow.clip),
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        controller:
                                                                            praticalGradeController[index],
                                                                        decoration:
                                                                            const InputDecoration(
                                                                          filled:
                                                                              true,
                                                                          contentPadding: EdgeInsets.only(
                                                                              left: 0,
                                                                              top: 0),
                                                                          floatingLabelBehavior:
                                                                              FloatingLabelBehavior.never,
                                                                          fillColor: Color.fromARGB(
                                                                              255,
                                                                              255,
                                                                              255,
                                                                              255),
                                                                          border:
                                                                              OutlineInputBorder(),
                                                                          labelText:
                                                                              "  Select grade",
                                                                          hintText:
                                                                              "grade",
                                                                        ),
                                                                        enabled: value.studentMEList[index].attendance ==
                                                                                'A'
                                                                            ? true
                                                                            : false,
                                                                        readOnly:
                                                                            true,
                                                                        onChanged:
                                                                            (value1) {
                                                                          praticalGradeController1[index].text = value
                                                                              .studentMEList[index]
                                                                              .peGradeId
                                                                              .toString();
                                                                          praticalGradeController1[index].text =
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
                        if (providerr.maxmarkList[0].teCaption != null &&
                            providerr.maxmarkList[0].peCaption == null &&
                            providerr.maxmarkList[0].ceCaption == null) {
                          return LimitedBox(
                              maxHeight: size.height / 1.85,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: value.studentMEList.length,
                                    itemBuilder: ((context, index) {
                                      //TE Grade
                                      teGradeController
                                          .add(TextEditingController());
                                      teGradeController1
                                          .add(TextEditingController());

                                      teGradeController1[index].text.isEmpty
                                          ? teGradeController1[index]
                                              .text = value.studentMEList[index]
                                                      .teGradeId ==
                                                  null
                                              ? teGradeController1[index].text
                                              : value.studentMEList[index]
                                                  .teGradeId
                                                  .toString()
                                          : teGradeController1[index].text;
                                      teGradeController[index].text.isEmpty
                                          ? teGradeController[index]
                                              .text = value.studentMEList[index]
                                                      .teGrade ==
                                                  null
                                              ? teGradeController[index].text
                                              : value
                                                  .studentMEList[index].teGrade
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
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 80,
                                                      child: Text(
                                                        'Roll No: ${value.studentMEList[index].rollNo == null ? '0' : value.studentMEList[index].rollNo.toString()}',
                                                        overflow: TextOverflow
                                                            .ellipsis,
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
                                                                    .studentMEList[
                                                                        index]
                                                                    .attendance ==
                                                                'A') {
                                                              value
                                                                  .studentMEList[
                                                                      index]
                                                                  .attendance = 'P';
                                                            } else {
                                                              value
                                                                  .studentMEList[
                                                                      index]
                                                                  .attendance = 'A';

                                                              value
                                                                  .studentMEList[
                                                                      index]
                                                                  .teGrade = null;
                                                              value
                                                                  .studentMEList[
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
                                                                .studentMEList[
                                                                    index]
                                                                .attendance;

                                                            print(
                                                                "attendace   $attendancee");
                                                          });
                                                        },
                                                        child: Container(
                                                          color: Colors
                                                              .transparent,
                                                          width: 28,
                                                          height: 26,
                                                          child: SizedBox(
                                                              width: 28,
                                                              height: 26,
                                                              child: value.studentMEList[index].attendance ==
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
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        strutStyle:
                                                            const StrutStyle(
                                                                fontSize: 12.0),
                                                        text: TextSpan(
                                                          style: const TextStyle(
                                                              color: UIGuide
                                                                  .light_Purple),
                                                          text: value
                                                              .studentMEList[
                                                                  index]
                                                              .name,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      LimitedBox(
                                                        maxWidth: 80,
                                                        child: Text(
                                                          '${value.maxmarkList[0].teCaption ?? ""} : ',
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 40,
                                                        width: 80,
                                                        child: SizedBox(
                                                          height: 40,
                                                          width: 100,
                                                          child: Consumer<
                                                                  MarkEntryProvider>(
                                                              builder: (context,
                                                                  snapshot,
                                                                  child) {
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
                                                                            itemCount: snapshot.gradeList.length,
                                                                            itemBuilder: (context, indx) {
                                                                              return ListTile(
                                                                                selectedTileColor: Colors.blue.shade100,
                                                                                selectedColor: UIGuide.PRIMARY2,
                                                                                onTap: () {
                                                                                  teGradeController[index].text = snapshot.gradeList[indx].gradeName ?? '--';
                                                                                  teGradeController1[index].text = snapshot.gradeList[indx].gradeId ?? '--';
                                                                                  value.studentMEList[index].teGradeId = teGradeController1[index].text;
                                                                                  value.studentMEList[index].teGrade = teGradeController[index].text;
                                                                                  value.studentMEList[index].teGrade = value.studentMEList[index].teGrade;
                                                                                  Navigator.of(context).pop();
                                                                                },
                                                                                title: Text(
                                                                                  snapshot.gradeList[indx].gradeName ?? '--',
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
                                                                            .all(
                                                                        5.0),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  children: [
                                                                    Container(
                                                                      height:
                                                                          30,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        border: Border.all(
                                                                            color:
                                                                                UIGuide.light_Purple,
                                                                            width: 1),
                                                                      ),
                                                                      child:
                                                                          TextField(
                                                                        enabled: value.studentMEList[index].attendance ==
                                                                                'A'
                                                                            ? true
                                                                            : false,
                                                                        readOnly:
                                                                            true,
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                14,
                                                                            overflow:
                                                                                TextOverflow.clip),
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        controller:
                                                                            teGradeController[index],
                                                                        decoration:
                                                                            const InputDecoration(
                                                                          filled:
                                                                              true,
                                                                          contentPadding: EdgeInsets.only(
                                                                              left: 0,
                                                                              top: 0),
                                                                          floatingLabelBehavior:
                                                                              FloatingLabelBehavior.never,
                                                                          fillColor: Color.fromARGB(
                                                                              255,
                                                                              255,
                                                                              255,
                                                                              255),
                                                                          border:
                                                                              OutlineInputBorder(),
                                                                          labelText:
                                                                              "  Select grade",
                                                                          hintText:
                                                                              "grade",
                                                                        ),
                                                                        onChanged:
                                                                            (value1) {
                                                                          teGradeController1[index].text = value
                                                                              .studentMEList[index]
                                                                              .teGradeId
                                                                              .toString();
                                                                          teGradeController1[index].text =
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
                        if (providerr.maxmarkList[0].teCaption == null &&
                            providerr.maxmarkList[0].peCaption != null &&
                            providerr.maxmarkList[0].ceCaption == null) {
                          return LimitedBox(
                              maxHeight: size.height / 1.85,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: value.studentMEList.length,
                                    itemBuilder: ((context, index) {
                                      //Practical Grade
                                      praticalGradeController
                                          .add(TextEditingController());
                                      praticalGradeController1
                                          .add(TextEditingController());

                                      praticalGradeController1[index]
                                              .text
                                              .isEmpty
                                          ? praticalGradeController1[index]
                                              .text = value.studentMEList[index]
                                                      .peGradeId ==
                                                  null
                                              ? praticalGradeController1[index]
                                                  .text
                                              : value.studentMEList[index]
                                                  .peGradeId
                                                  .toString()
                                          : praticalGradeController1[index]
                                              .text;
                                      praticalGradeController[index]
                                              .text
                                              .isEmpty
                                          ? praticalGradeController[index]
                                              .text = value.studentMEList[index]
                                                      .peGrade ==
                                                  null
                                              ? praticalGradeController[index]
                                                  .text
                                              : value
                                                  .studentMEList[index].peGrade
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
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 80,
                                                      child: Text(
                                                        'Roll No: ${value.studentMEList[index].rollNo == null ? '0' : value.studentMEList[index].rollNo.toString()}',
                                                        overflow: TextOverflow
                                                            .ellipsis,
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
                                                                    .studentMEList[
                                                                        index]
                                                                    .attendance ==
                                                                'A') {
                                                              value
                                                                  .studentMEList[
                                                                      index]
                                                                  .attendance = 'P';
                                                            } else {
                                                              value
                                                                  .studentMEList[
                                                                      index]
                                                                  .attendance = 'A';

                                                              value
                                                                  .studentMEList[
                                                                      index]
                                                                  .peGrade = null;
                                                              value
                                                                  .studentMEList[
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
                                                                .studentMEList[
                                                                    index]
                                                                .attendance;

                                                            print(
                                                                "attendace   $attendancee");
                                                          });
                                                        },
                                                        child: Container(
                                                          color: Colors
                                                              .transparent,
                                                          width: 28,
                                                          height: 26,
                                                          child: SizedBox(
                                                              width: 28,
                                                              height: 26,
                                                              child: value.studentMEList[index].attendance ==
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
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        strutStyle:
                                                            const StrutStyle(
                                                                fontSize: 12.0),
                                                        text: TextSpan(
                                                          style: const TextStyle(
                                                              color: UIGuide
                                                                  .light_Purple),
                                                          text: value
                                                              .studentMEList[
                                                                  index]
                                                              .name,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      LimitedBox(
                                                        maxWidth: 80,
                                                        child: Text(
                                                          '${value.maxmarkList[0].peCaption ?? ""} : ',
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 40,
                                                        width: 80,
                                                        child: SizedBox(
                                                          height: 40,
                                                          width: 100,
                                                          child: Consumer<
                                                                  MarkEntryProvider>(
                                                              builder: (context,
                                                                  snapshot,
                                                                  child) {
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
                                                                            itemCount: snapshot.gradeList.length,
                                                                            itemBuilder: (context, indx) {
                                                                              return ListTile(
                                                                                selectedTileColor: Colors.blue.shade100,
                                                                                selectedColor: UIGuide.PRIMARY2,
                                                                                onTap: () {
                                                                                  praticalGradeController[index].text = snapshot.gradeList[indx].gradeName ?? '--';
                                                                                  praticalGradeController1[index].text = snapshot.gradeList[indx].gradeId ?? '--';
                                                                                  value.studentMEList[index].peGradeId = praticalGradeController1[index].text;
                                                                                  value.studentMEList[index].peGrade = praticalGradeController[index].text;
                                                                                  value.studentMEList[index].peGrade = value.studentMEList[index].peGrade;
                                                                                  Navigator.of(context).pop();
                                                                                },
                                                                                title: Text(
                                                                                  snapshot.gradeList[indx].gradeName ?? '--',
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
                                                                            .all(
                                                                        5.0),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  children: [
                                                                    Container(
                                                                      height:
                                                                          30,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        border: Border.all(
                                                                            color:
                                                                                UIGuide.light_Purple,
                                                                            width: 1),
                                                                      ),
                                                                      child:
                                                                          TextField(
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                14,
                                                                            overflow:
                                                                                TextOverflow.clip),
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        controller:
                                                                            praticalGradeController[index],
                                                                        decoration:
                                                                            const InputDecoration(
                                                                          filled:
                                                                              true,
                                                                          contentPadding: EdgeInsets.only(
                                                                              left: 0,
                                                                              top: 0),
                                                                          floatingLabelBehavior:
                                                                              FloatingLabelBehavior.never,
                                                                          fillColor: Color.fromARGB(
                                                                              255,
                                                                              255,
                                                                              255,
                                                                              255),
                                                                          border:
                                                                              OutlineInputBorder(),
                                                                          labelText:
                                                                              "  Select grade",
                                                                          hintText:
                                                                              "grade",
                                                                        ),
                                                                        enabled: value.studentMEList[index].attendance ==
                                                                                'A'
                                                                            ? true
                                                                            : false,
                                                                        readOnly:
                                                                            true,
                                                                        onChanged:
                                                                            (value1) {
                                                                          praticalGradeController1[index].text = value
                                                                              .studentMEList[index]
                                                                              .peGradeId
                                                                              .toString();
                                                                          praticalGradeController1[index].text =
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
                        if (providerr.maxmarkList[0].teCaption == null &&
                            providerr.maxmarkList[0].peCaption == null &&
                            providerr.maxmarkList[0].ceCaption != null) {
                          return LimitedBox(
                              maxHeight: size.height / 1.85,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: value.studentMEList.length,
                                    itemBuilder: ((context, index) {
                                      //CE Grade
                                      ceGradeController
                                          .add(TextEditingController());
                                      ceGradeController1
                                          .add(TextEditingController());

                                      ceGradeController1[index].text.isEmpty
                                          ? ceGradeController1[index]
                                              .text = value.studentMEList[index]
                                                      .ceGradeId ==
                                                  null
                                              ? ceGradeController1[index].text
                                              : value.studentMEList[index]
                                                  .ceGradeId
                                                  .toString()
                                          : ceGradeController1[index].text;
                                      ceGradeController[index].text.isEmpty
                                          ? ceGradeController[index]
                                              .text = value.studentMEList[index]
                                                      .ceGrade ==
                                                  null
                                              ? ceGradeController[index].text
                                              : value
                                                  .studentMEList[index].ceGrade
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
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 80,
                                                      child: Text(
                                                        'Roll No: ${value.studentMEList[index].rollNo == null ? '0' : value.studentMEList[index].rollNo.toString()}',
                                                        overflow: TextOverflow
                                                            .ellipsis,
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
                                                                    .studentMEList[
                                                                        index]
                                                                    .attendance ==
                                                                'A') {
                                                              value
                                                                  .studentMEList[
                                                                      index]
                                                                  .attendance = 'P';
                                                            } else {
                                                              value
                                                                  .studentMEList[
                                                                      index]
                                                                  .attendance = 'A';

                                                              value
                                                                  .studentMEList[
                                                                      index]
                                                                  .ceGrade = null;
                                                              value
                                                                  .studentMEList[
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
                                                                .studentMEList[
                                                                    index]
                                                                .attendance;

                                                            print(
                                                                "attendace   $attendancee");
                                                          });
                                                        },
                                                        child: Container(
                                                          color: Colors
                                                              .transparent,
                                                          width: 28,
                                                          height: 26,
                                                          child: SizedBox(
                                                              width: 28,
                                                              height: 26,
                                                              child: value.studentMEList[index].attendance ==
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
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        strutStyle:
                                                            const StrutStyle(
                                                                fontSize: 12.0),
                                                        text: TextSpan(
                                                          style: const TextStyle(
                                                              color: UIGuide
                                                                  .light_Purple),
                                                          text: value
                                                              .studentMEList[
                                                                  index]
                                                              .name,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      LimitedBox(
                                                        maxWidth: 80,
                                                        child: Text(
                                                          '${value.maxmarkList[0].ceCaption ?? ""} : ',
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 40,
                                                        width: 80,
                                                        child: SizedBox(
                                                          height: 40,
                                                          width: 100,
                                                          child: Consumer<
                                                                  MarkEntryProvider>(
                                                              builder: (context,
                                                                  snapshot,
                                                                  child) {
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
                                                                            itemCount: snapshot.gradeList.length,
                                                                            itemBuilder: (context, indx) {
                                                                              return ListTile(
                                                                                selectedTileColor: Colors.blue.shade100,
                                                                                selectedColor: UIGuide.PRIMARY2,
                                                                                onTap: () {
                                                                                  ceGradeController[index].text = snapshot.gradeList[indx].gradeName ?? '--';
                                                                                  ceGradeController1[index].text = snapshot.gradeList[indx].gradeId ?? '--';
                                                                                  value.studentMEList[index].ceGradeId = ceGradeController1[index].text;
                                                                                  value.studentMEList[index].ceGrade = ceGradeController[index].text;
                                                                                  value.studentMEList[index].ceGrade = value.studentMEList[index].ceGrade;
                                                                                  Navigator.of(context).pop();
                                                                                },
                                                                                title: Text(
                                                                                  snapshot.gradeList[indx].gradeName ?? '--',
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
                                                                            .all(
                                                                        5.0),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  children: [
                                                                    Container(
                                                                      height:
                                                                          30,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        border: Border.all(
                                                                            color:
                                                                                UIGuide.light_Purple,
                                                                            width: 1),
                                                                      ),
                                                                      child:
                                                                          TextField(
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                14,
                                                                            overflow:
                                                                                TextOverflow.clip),
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        controller:
                                                                            ceGradeController[index],
                                                                        decoration:
                                                                            const InputDecoration(
                                                                          filled:
                                                                              true,
                                                                          contentPadding: EdgeInsets.only(
                                                                              left: 0,
                                                                              top: 0),
                                                                          floatingLabelBehavior:
                                                                              FloatingLabelBehavior.never,
                                                                          fillColor: Color.fromARGB(
                                                                              255,
                                                                              255,
                                                                              255,
                                                                              255),
                                                                          border:
                                                                              OutlineInputBorder(),
                                                                          labelText:
                                                                              "  Select grade",
                                                                          hintText:
                                                                              "grade",
                                                                        ),
                                                                        enabled: value.studentMEList[index].attendance ==
                                                                                'A'
                                                                            ? true
                                                                            : false,
                                                                        readOnly:
                                                                            true,
                                                                        onChanged:
                                                                            (value1) {
                                                                          ceGradeController1[index].text = value
                                                                              .studentMEList[index]
                                                                              .ceGradeId
                                                                              .toString();
                                                                          ceGradeController1[index].text =
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
                      }

                      ///////////////////////////////

                      else {
                        return Container(
                          height: 0,
                          width: 0,
                        );
                      }
                    }),

                    value.examStatus == "Verified"
                        ? Row(
                            children: [
                              Spacer(),
                              const Text(
                                'Verified ',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: UIGuide.light_Purple,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: LottieBuilder.network(
                                      'https://assets4.lottiefiles.com/packages/lf20_s3tatv3q.json')),
                              Spacer(),
                            ],
                          )
                        : SizedBox(
                            height: 0,
                            width: 0,
                          )
                  ],
                );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            kWidth,
            const Spacer(),
            Consumer<MarkEntryProvider>(builder: (context, value, child) {
              return value.load
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
                        print("length:  ${value.studentMEList.length}");
                        if (value.maxmarkList[0].entryMethod == "Mark" &&
                            value.typecode == "UAS") {
                          for (int i = 0; i < value.studentMEList.length; i++) {
                            obj.add(
                              {
                                "name": value.studentMEList[i].name.toString(),
                                "rollNo":
                                    value.studentMEList[i].rollNo.toString(),
                                "studentPresentDetailsId": value
                                    .studentMEList[i].studentPresentDetailsId
                                    .toString(),
                                "teMark": _controllers[i].text.isEmpty
                                    ? null
                                    : _controllers[i].text.toString(),
                                "peMark": null,
                                "ceMark": null,
                                "teGrade": null,
                                "peGrade": null,
                                "ceGrade": null,
                                "totalMark": _controllers[i].text.isEmpty
                                    ? null
                                    : _controllers[i].text.toString(),
                                "markInPer": null,
                                "grade": null,
                                "gradeId": null,
                                "teGradeId": null,
                                "peGradeId": null,
                                "ceGradeId": null,
                                "attendance": value.studentMEList[i].attendance
                                    .toString(),
                                "description": null,
                                "disableAbsentRow": false
                              },
                            );
                          }
                        } else if (value.maxmarkList[0].entryMethod ==
                                "Grade" &&
                            (value.typecode == "UAS")) {
                          for (int i = 0; i < value.studentMEList.length; i++) {
                            obj.add(
                              {
                                "name": value.studentMEList[i].name.toString(),
                                "rollNo":
                                    value.studentMEList[i].rollNo.toString(),
                                "studentPresentDetailsId": value
                                    .studentMEList[i].studentPresentDetailsId
                                    .toString(),
                                "teMark": null,
                                "peMark": null,
                                "ceMark": null,
                                "teGrade": value.studentMEList[i].teGrade,
                                "peGrade": null,
                                "ceGrade": null,
                                "totalMark": null,
                                "markInPer": null,
                                "grade": null,
                                "gradeId": null,
                                "teGradeId": value.studentMEList[i].teGradeId,
                                "peGradeId": null,
                                "ceGradeId": null,
                                "attendance": "P",
                                "description": null,
                                "disableAbsentRow": false
                              },
                            );
                          }
                        } else if (value.maxmarkList[0].entryMethod ==
                                "Grade" &&
                            (value.typecode == "PBT")) {
                          for (int i = 0; i < value.studentMEList.length; i++) {
                            print('------------------------');
                            obj.add(
                              {
                                "name": value.studentMEList[i].name.toString(),
                                "rollNo":
                                    value.studentMEList[i].rollNo.toString(),
                                "studentPresentDetailsId": value
                                    .studentMEList[i].studentPresentDetailsId
                                    .toString(),
                                "teMark": null,
                                "peMark": null,
                                "ceMark": null,
                                "teGrade": value.studentMEList[i].teGrade,
                                "peGrade": null,
                                "ceGrade": null,
                                "totalMark": null,
                                "markInPer": null,
                                "grade": null,
                                "gradeId": null,
                                "teGradeId": value.studentMEList[i].teGradeId,
                                "peGradeId": null,
                                "ceGradeId": null,
                                "attendance": value.studentMEList[i].attendance
                                    .toString(),
                                "description": null,
                                "disableAbsentRow": false
                              },
                            );
                          }
                        } else if (value.maxmarkList[0].entryMethod == "Mark" &&
                            (value.typecode == "PBT" ||
                                value.typecode == "STATE")) {
                          for (int i = 0; i < value.studentMEList.length; i++) {
                            print(double.tryParse(teMarkController[i].text));
                            print(double.tryParse(
                                practicalMarkController[i].text));
                            obj.add(
                              {
                                "name": value.studentMEList[i].name.toString(),
                                "rollNo":
                                    value.studentMEList[i].rollNo.toString(),
                                "studentPresentDetailsId": value
                                    .studentMEList[i].studentPresentDetailsId
                                    .toString(),
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
                                "teGrade": null,
                                "peGrade": null,
                                "ceGrade": null,
                                "totalMark": "",
                                "markInPer": null,
                                "grade": null,
                                "gradeId": null,
                                "teGradeId": null,
                                "peGradeId": null,
                                "ceGradeId": null,
                                "attendance": value.studentMEList[i].attendance
                                    .toString(),
                                "description": null,
                                "disableAbsentRow": false
                              },
                            );
                          }
                        } else if (value.maxmarkList[0].entryMethod ==
                                "Grade" &&
                            (value.typecode == "STATE")) {
                          print('-------------------');
                          for (int i = 0; i < value.studentMEList.length; i++) {
                            obj.add(
                              {
                                "name": value.studentMEList[i].name.toString(),
                                "rollNo":
                                    value.studentMEList[i].rollNo.toString(),
                                "studentPresentDetailsId": value
                                    .studentMEList[i].studentPresentDetailsId
                                    .toString(),
                                "teMark": null,
                                "peMark": null,
                                "ceMark": null,
                                "teGrade": value.studentMEList[i].teGrade,
                                "peGrade": value.studentMEList[i].peGrade,
                                "ceGrade": value.studentMEList[i].ceGrade,
                                "totalMark": null,
                                "markInPer": null,
                                "grade": null,
                                "gradeId": null,
                                "teGradeId": value.studentMEList[i].teGradeId,
                                "peGradeId": value.studentMEList[i].peGradeId,
                                "ceGradeId": value.studentMEList[i].ceGradeId,
                                "attendance": value.studentMEList[i].attendance
                                    .toString(),
                                "description": null,
                                "disableAbsentRow": false
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

                        //log("Litsssss   $obj");

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
                          value.loading
                              ? spinkitLoader()
                              : await value.markEntrySave(
                                  courseId,
                                  divisionId,
                                  partId,
                                  markEntryOptionSubListController1.text,
                                  subjectId,
                                  markEntryExamListController.text.toString(),
                                  date!,
                                  context,
                                  obj);
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
            Consumer<MarkEntryProvider>(builder: (context, value, child) {
              return value.loadVerify
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
                                              print(
                                                  "length:  ${value.studentMEList.length}");
                                              for (int i = 0;
                                                  i <
                                                      value
                                                          .studentMEList.length;
                                                  i++) {
                                                obj.add(
                                                  {
                                                    "name": value
                                                        .studentMEList[i].name
                                                        .toString(),
                                                    "rollNo": value
                                                        .studentMEList[i].rollNo
                                                        .toString(),
                                                    "studentPresentDetailsId": value
                                                        .studentMEList[i]
                                                        .studentPresentDetailsId
                                                        .toString(),
                                                    "teMark": value
                                                        .studentMEList[i]
                                                        .teMark,
                                                    "peMark": value
                                                        .studentMEList[i]
                                                        .peMark,
                                                    "ceMark": value
                                                        .studentMEList[i]
                                                        .ceMark,
                                                    "teGrade": value
                                                        .studentMEList[i]
                                                        .teGrade,
                                                    "peGrade": value
                                                        .studentMEList[i]
                                                        .peGrade,
                                                    "ceGrade": value
                                                        .studentMEList[i]
                                                        .ceGrade,
                                                    "totalMark": value
                                                        .studentMEList[i]
                                                        .totalMark,
                                                    "markInPer": value
                                                        .studentMEList[i]
                                                        .markInPer,
                                                    "grade": value
                                                        .studentMEList[i].grade,
                                                    "gradeId": value
                                                        .studentMEList[i]
                                                        .gradeId,
                                                    "teGradeId": value
                                                        .studentMEList[i]
                                                        .teGradeId,
                                                    "peGradeId": value
                                                        .studentMEList[i]
                                                        .peGradeId,
                                                    "ceGradeId": value
                                                        .studentMEList[i]
                                                        .ceGradeId,
                                                    "attendance": value
                                                        .studentMEList[i]
                                                        .attendance
                                                        .toString(),
                                                    "description": null,
                                                    "disableAbsentRow": false
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
                                                        courseId,
                                                        divisionId,
                                                        partId,
                                                        markEntryOptionSubListController1
                                                            .text,
                                                        subjectId,
                                                        markEntryExamListController
                                                            .text
                                                            .toString(),
                                                        date!,
                                                        context,
                                                        obj);
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
            Consumer<MarkEntryProvider>(builder: (context, value, child) {
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
                                        List obj = [];
                                        obj.clear();
                                        print(
                                            "length:  ${value.studentMEList.length}");
                                        for (int i = 0;
                                            i < value.studentMEList.length;
                                            i++) {
                                          obj.add(
                                            {
                                              "name": value
                                                  .studentMEList[i].name
                                                  .toString(),
                                              "rollNo": value
                                                  .studentMEList[i].rollNo
                                                  .toString(),
                                              "studentPresentDetailsId": value
                                                  .studentMEList[i]
                                                  .studentPresentDetailsId
                                                  .toString(),
                                              "teMark":
                                                  value.studentMEList[i].teMark,
                                              "peMark":
                                                  value.studentMEList[i].peMark,
                                              "ceMark":
                                                  value.studentMEList[i].ceMark,
                                              "teGrade": value
                                                  .studentMEList[i].teGrade,
                                              "peGrade": value
                                                  .studentMEList[i].peGrade,
                                              "ceGrade": value
                                                  .studentMEList[i].ceGrade,
                                              "totalMark": value
                                                  .studentMEList[i].totalMark,
                                              "markInPer": value
                                                  .studentMEList[i].markInPer,
                                              "grade":
                                                  value.studentMEList[i].grade,
                                              "gradeId": value
                                                  .studentMEList[i].gradeId,
                                              "teGradeId": value
                                                  .studentMEList[i].teGradeId,
                                              "peGradeId": value
                                                  .studentMEList[i].peGradeId,
                                              "ceGradeId": value
                                                  .studentMEList[i].ceGradeId,
                                              "attendance": value
                                                  .studentMEList[i].attendance
                                                  .toString(),
                                              "description": null,
                                              "disableAbsentRow": false
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
                                            duration: Duration(seconds: 1),
                                            margin: EdgeInsets.only(
                                                bottom: 80,
                                                left: 30,
                                                right: 30),
                                            behavior: SnackBarBehavior.floating,
                                            content: Text(
                                              "No data to Delete...",
                                              textAlign: TextAlign.center,
                                            ),
                                          ));
                                        } else {
                                          value.loading
                                              ? spinkitLoader()
                                              :
                                              //await value.markEntrySave(courseId,divisionId,partId,subjectId,date!,markEntryExamListController.text.toString(),context, obj);
                                              await value.markEntryDelete(
                                                  courseId,
                                                  divisionId,
                                                  partId,
                                                  markEntryOptionSubListController1
                                                      .text,
                                                  subjectId,
                                                  markEntryExamListController
                                                      .text
                                                      .toString(),
                                                  date!,
                                                  context,
                                                  obj);
                                          value.examStatus = "Pending";
                                        }
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
