import 'dart:developer';

import 'package:essconnect/Application/Staff_Providers/ToolMarkProvider.dart';
import 'package:essconnect/Constants.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../utils/spinkit.dart';

class ToolMarkEntry extends StatefulWidget {
  const ToolMarkEntry({Key? key}) : super(key: key);

  @override
  State<ToolMarkEntry> createState() => _ToolMarkEntryState();
}

class _ToolMarkEntryState extends State<ToolMarkEntry> {
  List<TextEditingController> teMarkController = [];
  List<List<String>> markcontrollers = [];
  List<TextEditingController> gradeController = [];
  List<TextEditingController> gradeControllerID = [];

  double? result;

  List<List<List<int>>> dataList = [];

  double? maxscore;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var p = Provider.of<ToolMarkEntryProviders>(context, listen: false);
      p.examStatus = "";
      await p.courseClear();
      await p.divisionClear();
      await p.removeAllpartClear();
      await p.removeAllSubjectClear();
      await p.removeAllOptionSubjectListClear();
      await p.removeAllExamClear();
      //   await p.clearStudentMEList();
      await p.getToolInitialValues();
      p.studentMEList.clear();
      p.toolListView.clear();
    });
  }

  List<TextEditingController> _controllers = [];
  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  String? attendancee;
  String courseId = '';
  String partId = '';
  String subjectId = '';
  String divisionId = '';
  String exam = '';

  final toolInitialValuesController = TextEditingController();
  final toolInitialValuesController1 = TextEditingController();
  final toolDivisionListController = TextEditingController();
  final toolDivisionListController1 = TextEditingController();
  final toolPartListController = TextEditingController();
  final toolPartListController1 = TextEditingController();
  final toolSubjectListController = TextEditingController();
  final toolSubjectListController1 = TextEditingController();
  final toolExamListController = TextEditingController();
  final toolExamListController1 = TextEditingController();
  final toolOptionSubListController = TextEditingController();
  final toolOptionSubListController1 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tool Mark Entry',
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
      body: Consumer<ToolMarkEntryProviders>(
        builder: (context, value, child) {
          return value.isLocked == true
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    LottieBuilder.network(
                      'https://assets1.lottiefiles.com/packages/lf20_6ZeYZ9ZcjI.json',
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
                  children: [
                    Row(
                      children: [
                        const Spacer(),
                        SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.49,
                          child: Consumer<ToolMarkEntryProviders>(
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
                                                .toolInitialValues.length,
                                            itemBuilder: (context, index) {
                                              return ListTile(
                                                onTap: () async {
                                                  toolInitialValuesController
                                                      .text = snapshot
                                                          .toolInitialValues[
                                                              index]
                                                          .id ??
                                                      '--';
                                                  toolInitialValuesController1
                                                      .text = snapshot
                                                          .toolInitialValues[
                                                              index]
                                                          .courseName ??
                                                      '--';
                                                  courseId =
                                                      toolInitialValuesController
                                                          .text
                                                          .toString();

                                                  //div
                                                  toolDivisionListController
                                                      .clear();
                                                  toolDivisionListController1
                                                      .clear();
                                                  await snapshot
                                                      .divisionClear();

                                                  //part

                                                  toolPartListController
                                                      .clear();
                                                  toolPartListController1
                                                      .clear();

                                                  await snapshot
                                                      .removeAllpartClear();

                                                  // sub

                                                  toolSubjectListController
                                                      .clear();
                                                  toolSubjectListController1
                                                      .clear();

                                                  await snapshot
                                                      .removeAllSubjectClear();

                                                  //option sub

                                                  toolOptionSubListController
                                                      .clear();
                                                  toolOptionSubListController1
                                                      .clear();
                                                  await snapshot
                                                      .removeAllOptionSubjectListClear();

                                                  // exam

                                                  toolExamListController
                                                      .clear();
                                                  toolExamListController1
                                                      .clear();
                                                  await snapshot
                                                      .removeAllExamClear();
                                                  await snapshot
                                                      .clearStudList();

                                                  await snapshot
                                                      .getToolDivisionValues(
                                                          courseId);
                                                  Navigator.of(context).pop();
                                                },
                                                title: Text(
                                                  snapshot
                                                          .toolInitialValues[
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
                                            toolInitialValuesController1,
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
                                        controller: toolInitialValuesController,
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
                          child: Consumer<ToolMarkEntryProviders>(
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
                                                    .toolDivisionList.length,
                                                itemBuilder: (context, index) {
                                                  return ListTile(
                                                    selectedTileColor:
                                                        Colors.blue.shade100,
                                                    selectedColor:
                                                        UIGuide.PRIMARY2,
                                                    onTap: () async {
                                                      // snapshot
                                                      //     .clearStudentMEList();
                                                      toolDivisionListController
                                                          .text = snapshot
                                                              .toolDivisionList[
                                                                  index]
                                                              .value ??
                                                          '---';
                                                      toolDivisionListController1
                                                          .text = snapshot
                                                              .toolDivisionList[
                                                                  index]
                                                              .text ??
                                                          '---';

                                                      divisionId =
                                                          toolDivisionListController
                                                              .text
                                                              .toString();
                                                      courseId =
                                                          toolInitialValuesController
                                                              .text
                                                              .toString();
                                                      //part

                                                      toolPartListController
                                                          .clear();
                                                      toolPartListController1
                                                          .clear();

                                                      await snapshot
                                                          .removeAllpartClear();

                                                      // sub

                                                      toolSubjectListController
                                                          .clear();
                                                      toolSubjectListController1
                                                          .clear();

                                                      await snapshot
                                                          .removeAllSubjectClear();

                                                      //option sub

                                                      toolOptionSubListController
                                                          .clear();
                                                      toolOptionSubListController1
                                                          .clear();
                                                      await snapshot
                                                          .removeAllOptionSubjectListClear();

                                                      // exam

                                                      toolExamListController
                                                          .clear();
                                                      toolExamListController1
                                                          .clear();
                                                      await snapshot
                                                          .removeAllExamClear();
                                                      await snapshot
                                                          .clearStudList();

                                                      await snapshot
                                                          .getToolPartValues(
                                                              courseId,
                                                              divisionId);

                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    title: Text(
                                                      snapshot
                                                              .toolDivisionList[
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
                                        controller: toolDivisionListController1,
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
                                        controller: toolDivisionListController,
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
                          child: Consumer<ToolMarkEntryProviders>(
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
                                                    .toolPartList.length,
                                                itemBuilder: (context, index) {
                                                  return ListTile(
                                                    selectedTileColor:
                                                        Colors.blue.shade100,
                                                    selectedColor:
                                                        UIGuide.PRIMARY2,
                                                    onTap: () async {
                                                      toolPartListController
                                                          .text = snapshot
                                                              .toolPartList[
                                                                  index]
                                                              .value ??
                                                          '--';
                                                      toolPartListController1
                                                          .text = snapshot
                                                              .toolPartList[
                                                                  index]
                                                              .text ??
                                                          '--';

                                                      divisionId =
                                                          toolDivisionListController
                                                              .text
                                                              .toString();
                                                      partId =
                                                          toolPartListController
                                                              .text
                                                              .toString();

                                                      toolSubjectListController
                                                          .clear();
                                                      toolSubjectListController1
                                                          .clear();

                                                      await snapshot
                                                          .removeAllSubjectClear();
                                                      //option sub

                                                      toolOptionSubListController
                                                          .clear();
                                                      toolOptionSubListController1
                                                          .clear();
                                                      await snapshot
                                                          .removeAllOptionSubjectListClear();

                                                      // exam

                                                      toolExamListController
                                                          .clear();
                                                      toolExamListController1
                                                          .clear();
                                                      await snapshot
                                                          .removeAllExamClear();
                                                      await snapshot
                                                          .clearStudList();

                                                      await snapshot
                                                          .getToolSubjectValues(
                                                              divisionId,
                                                              partId);

                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    title: Text(
                                                      snapshot
                                                              .toolPartList[
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
                                        controller: toolPartListController1,
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
                                        controller: toolPartListController,
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
                          child: Consumer<ToolMarkEntryProviders>(
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
                                                    .toolSubjectList.length,
                                                itemBuilder: (context, index) {
                                                  return ListTile(
                                                    selectedTileColor:
                                                        Colors.blue.shade100,
                                                    selectedColor:
                                                        UIGuide.PRIMARY2,
                                                    onTap: () async {
                                                      toolSubjectListController
                                                          .text = snapshot
                                                              .toolSubjectList[
                                                                  index]
                                                              .value ??
                                                          '---';
                                                      toolSubjectListController1
                                                          .text = snapshot
                                                              .toolSubjectList[
                                                                  index]
                                                              .text ??
                                                          '---';

                                                      divisionId =
                                                          toolDivisionListController
                                                              .text
                                                              .toString();
                                                      partId =
                                                          toolPartListController
                                                              .text
                                                              .toString();
                                                      subjectId =
                                                          toolSubjectListController
                                                              .text
                                                              .toString();

                                                      //option sub

                                                      toolOptionSubListController
                                                          .clear();
                                                      toolOptionSubListController1
                                                          .clear();
                                                      await snapshot
                                                          .removeAllOptionSubjectListClear();

                                                      // exam

                                                      toolExamListController
                                                          .clear();
                                                      toolExamListController1
                                                          .clear();
                                                      await snapshot
                                                          .removeAllExamClear();

                                                      await snapshot
                                                          .getToolOptionSubject(
                                                              subjectId,
                                                              divisionId);
                                                      await snapshot
                                                          .getToolExamValues(
                                                              subjectId,
                                                              divisionId,
                                                              partId);
                                                      await snapshot
                                                          .clearStudList();

                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    title: Text(
                                                      snapshot
                                                          .toolSubjectList[
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
                                        controller: toolSubjectListController1,
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
                                        controller: toolSubjectListController,
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
                        Consumer<ToolMarkEntryProviders>(
                          builder: (context, snapshot, child) {
                            if (snapshot.toolOptionSubjectList.isEmpty ||
                                snapshot.toolOptionSubjectList == null) {
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
                                                          .toolOptionSubjectList
                                                          .isEmpty
                                                      ? 0
                                                      : snapshot
                                                          .toolOptionSubjectList
                                                          .length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return ListTile(
                                                      selectedTileColor:
                                                          Colors.blue.shade100,
                                                      selectedColor:
                                                          UIGuide.PRIMARY2,
                                                      onTap: () async {
                                                        toolOptionSubListController
                                                            .text = snapshot
                                                                .toolOptionSubjectList[
                                                                    index]
                                                                .subjectName ??
                                                            '--';
                                                        toolOptionSubListController1
                                                            .text = snapshot
                                                                .toolOptionSubjectList[
                                                                    index]
                                                                .id ??
                                                            '--';
                                                        toolExamListController
                                                            .clear();
                                                        toolExamListController1
                                                            .clear();
                                                        await snapshot
                                                            .clearStudList();

                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      title: Text(
                                                        snapshot
                                                                .toolOptionSubjectList[
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
                                                toolOptionSubListController,
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
                                                      .toolOptionSubjectList
                                                      .isEmpty
                                                  ? ""
                                                  : snapshot.toolOptionSubjectList[0]
                                                              .subjectDescription ==
                                                          "Sub Subject"
                                                      ? "Select Sub Subject"
                                                      : "Select Option Subject",
                                              hintText: snapshot
                                                      .toolOptionSubjectList
                                                      .isEmpty
                                                  ? ""
                                                  : snapshot.toolOptionSubjectList[0]
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
                                                toolOptionSubListController1,
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
                          child: Consumer<ToolMarkEntryProviders>(
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
                                                  snapshot.toolExamList.length,
                                              itemBuilder: (context, index) {
                                                return ListTile(
                                                  selectedTileColor:
                                                      Colors.blue.shade100,
                                                  selectedColor:
                                                      UIGuide.PRIMARY2,
                                                  onTap: () {
                                                    toolExamListController
                                                        .text = snapshot
                                                            .toolExamList[index]
                                                            .text ??
                                                        '--';
                                                    toolExamListController1
                                                        .text = snapshot
                                                            .toolExamList[index]
                                                            .value ??
                                                        '--';

                                                    Navigator.of(context).pop();
                                                  },
                                                  title: Text(
                                                    snapshot.toolExamList[index]
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
                                        controller: toolExamListController,
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
                                        controller: toolExamListController1,
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
                    //kheight10,
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
                                    var date = await DateFormat('dd/MMM/yyyy')
                                        .format(DateTime.now());
                                    print(DateFormat('dd/MMM/yyyy')
                                        .format(DateTime.now()));

                                    String course = toolInitialValuesController
                                        .text
                                        .toString();
                                    String division = toolDivisionListController
                                        .text
                                        .toString();
                                    String part =
                                        toolPartListController.text.toString();
                                    String subject = toolSubjectListController
                                        .text
                                        .toString();
                                    String exam =
                                        toolExamListController.text.toString();
                                    String optional =
                                        toolOptionSubListController1.text
                                            .toString();
                                    value.enteredBy = null;
                                    print(value.toolListView.length);
                                    value.studentMEList.clear();
                                    value.toolListView.clear();
                                    value.gradeList.clear();
                                    if (course.isEmpty ||
                                        division.isEmpty ||
                                        part.isEmpty ||
                                        subject.isEmpty ||
                                        exam.isEmpty) {
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
                                          "Select Mandatory Fields",
                                          textAlign: TextAlign.center,
                                        ),
                                      ));
                                    } else {
                                      await value.getMarkEntryView(
                                          course,
                                          date,
                                          division,
                                          exam,
                                          part,
                                          subject,
                                          optional);
                                      print({
                                        course,
                                        date,
                                        division,
                                        exam,
                                        part,
                                        subject,
                                        optional
                                      });
                                    }
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
                    value.examStatus != "Verified"
                        ? Container(
                            height: 0,
                            width: 0,
                          )
                        : Center(
                            child: Text(
                            "Verified ✔",
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 13,
                            ),
                          )),
                    Consumer<ToolMarkEntryProviders>(
                      builder: (context, value, child) {
                        if (value.loading) {
                          return LimitedBox(
                            maxHeight: size.height / 1.85,
                            child: Container(
                              height: size.height / 1.95,
                              child: spinkitLoader(),
                            ),
                          );
                        } else if (value.isBlocked == true) {
                          return Container(
                              height: size.height / 1.95,
                              child: Center(
                                  child: Text(
                                "Mark Entry Blocked ! ",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 16),
                              )));
                        } else if (value.entryMethod == 'Mark' &&
                            value.typeCode == 'UAS') {
                          return LimitedBox(
                              maxHeight: size.height / 1.8,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: value.studentMEList.length,
                                    itemBuilder: ((context, index) {
                                      teMarkController
                                          .add(TextEditingController());

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
                                                        'Roll No:  ${value.studentMEList[index].rollNo == null ? '0' : value.studentMEList[index].rollNo.toString()}',
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
                                                                .name
                                                                .toString()
                                                            //  value
                                                            //     .studentMEList[
                                                            //         index]
                                                            //     .name,
                                                            ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              ListView.builder(
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemCount:
                                                      value.toolListView.isEmpty
                                                          ? 0
                                                          : value.toolListView
                                                              .length,
                                                  itemBuilder: (context, ind) {
                                                    final controller =
                                                        TextEditingController();

                                                    teMarkController[index]
                                                            .text
                                                            .isEmpty
                                                        ? controller
                                                            .text = value
                                                                    .studentMEList[
                                                                        index]
                                                                    .toolList![
                                                                        ind]
                                                                    .teMark ==
                                                                null
                                                            ? controller.text
                                                            : value
                                                                .studentMEList[
                                                                    index]
                                                                .toolList![ind]
                                                                .teMark
                                                                .toString()
                                                        : controller.text;
                                                    if (value
                                                            .studentMEList[
                                                                index]
                                                            .attendance ==
                                                        'A') {
                                                      value
                                                          .studentMEList[index]
                                                          .toolList![ind]
                                                          .teMark = null;
                                                      teMarkController[index]
                                                          .clear();
                                                    }

                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 5.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          SizedBox(
                                                            width: size.width /
                                                                2.2,
                                                            child: Text(
                                                              value
                                                                  .toolListView[
                                                                      ind]
                                                                  .toolName
                                                                  .toString(),
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                          kWidth,
                                                          kWidth,
                                                          const Text(': '),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(5.0),
                                                            child: SizedBox(
                                                              height: 30,
                                                              width: 80,
                                                              child: TextField(
                                                                focusNode:
                                                                    FocusNode(),
                                                                controller:
                                                                    controller,
                                                                enabled: value
                                                                            .studentMEList[index]
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
                                                                          .isNotEmpty) {
                                                                        double.parse(
                                                                            text);
                                                                      }
                                                                      return newValue;
                                                                    } catch (e) {}
                                                                    return oldValue;
                                                                  }),
                                                                  LengthLimitingTextInputFormatter(
                                                                      5),
                                                                ],
                                                                decoration:
                                                                    InputDecoration(
                                                                        focusColor: const Color.fromARGB(
                                                                            255,
                                                                            213,
                                                                            215,
                                                                            218),
                                                                        border:
                                                                            OutlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(10.0),
                                                                        ),
                                                                        focusedBorder:
                                                                            OutlineInputBorder(
                                                                          borderSide: const BorderSide(
                                                                              color: UIGuide.light_Purple,
                                                                              width: 1.0),
                                                                          borderRadius:
                                                                              BorderRadius.circular(10.0),
                                                                        ),
                                                                        fillColor:
                                                                            Colors
                                                                                .grey,
                                                                        hintStyle:
                                                                            const TextStyle(
                                                                          color:
                                                                              Colors.grey,
                                                                          fontSize:
                                                                              16,
                                                                          fontFamily:
                                                                              "verdana_regular",
                                                                          fontWeight:
                                                                              FontWeight.w400,
                                                                        ),
                                                                        labelText:
                                                                            // value
                                                                            //         .maxmarkList[
                                                                            //             0]
                                                                            //         .teCaption ??
                                                                            "Mark",
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
                                                                  controller
                                                                          .text =
                                                                      value1;

                                                                  // teMarkController[ind].text = controller.text;

                                                                  // result = double.parse(controller.text);

                                                                  //    result.toString();

                                                                  // print(value
                                                                  //     .studentMEList[
                                                                  //         0]
                                                                  //     .toolList![1]
                                                                  //
                                                                  //     .teMark)
                                                                  controller
                                                                          .text
                                                                          .isEmpty
                                                                      ? value
                                                                          .studentMEList[
                                                                              index]
                                                                          .toolList![
                                                                              ind]
                                                                          .teMark = null
                                                                      : controller.text;

                                                                  controller
                                                                          .selection =
                                                                      TextSelection.collapsed(
                                                                          offset: controller
                                                                              .text
                                                                              .length);

                                                                  if (double.parse(
                                                                          controller
                                                                              .text) >
                                                                      value
                                                                          .studentMEList[
                                                                              index]
                                                                          .toolList![
                                                                              ind]
                                                                          .teMaxMark!
                                                                          .toDouble()) {
                                                                    print(
                                                                        "Cleared");

                                                                    controller
                                                                        .clear();
                                                                  }
                                                                  String
                                                                      resultt =
                                                                      controller
                                                                          .text;
                                                                  value
                                                                      .studentMEList[
                                                                          index]
                                                                      .toolList![
                                                                          ind]
                                                                      .teMark = double.tryParse(resultt);
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                          Text(value
                                                              .studentMEList[
                                                                  index]
                                                              .toolList![ind]
                                                              .teMaxMark
                                                              .toString()),
                                                        ],
                                                      ),
                                                    );
                                                  }),
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

                        else if (value.entryMethod == 'Grade' &&
                            value.typeCode == 'UAS') {
                          return LimitedBox(
                              maxHeight: size.height / 1.8,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: value.studentMEList.length,
                                    itemBuilder: ((context, index) {
                                      gradeController
                                          .add(TextEditingController());

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
                                                        'Roll No:  ${value.studentMEList[index].rollNo == null ? '0' : value.studentMEList[index].rollNo.toString()}',
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
                                                              gradeController[
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
                                                                .name
                                                                .toString()
                                                            //  value
                                                            //     .studentMEList[
                                                            //         index]
                                                            //     .name,
                                                            ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              ListView.builder(
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemCount:
                                                      value.toolListView.isEmpty
                                                          ? 0
                                                          : value.toolListView
                                                              .length,
                                                  itemBuilder: (context, ind) {
                                                    final controllers =
                                                        TextEditingController();
                                                    final controllerid =
                                                        TextEditingController();

                                                    controllers.text.isEmpty
                                                        ? controllers
                                                            .text = value
                                                                    .studentMEList[
                                                                        index]
                                                                    .toolList![
                                                                        ind]
                                                                    .teGrade ==
                                                                null
                                                            ? controllers.text
                                                            : value
                                                                .studentMEList[
                                                                    index]
                                                                .toolList![ind]
                                                                .teGrade
                                                                .toString()
                                                        : controllers.text;

                                                    controllers.text.isEmpty
                                                        ? controllerid
                                                            .text = value
                                                                    .studentMEList[
                                                                        index]
                                                                    .toolList![
                                                                        ind]
                                                                    .teGradeId ==
                                                                null
                                                            ? controllerid.text
                                                            : value
                                                                .studentMEList[
                                                                    index]
                                                                .toolList![ind]
                                                                .teGradeId
                                                                .toString()
                                                        : controllerid.text;
                                                    if (value
                                                            .studentMEList[
                                                                index]
                                                            .attendance ==
                                                        'A') {
                                                      value
                                                          .studentMEList[index]
                                                          .toolList![ind]
                                                          .teGrade = null;
                                                      gradeController[index]
                                                          .clear();
                                                      controllers.clear();
                                                      controllerid.clear();
                                                      value
                                                          .studentMEList[index]
                                                          .toolList![ind]
                                                          .teGradeId = null;
                                                      // gradeControllerID[index]
                                                      //     .clear();
                                                    }

                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 5.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          SizedBox(
                                                            width: size.width /
                                                                2.2,
                                                            child: Text(
                                                              value
                                                                  .toolListView[
                                                                      ind]
                                                                  .toolName
                                                                  .toString(),
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                          kWidth,
                                                          kWidth,
                                                          const Text(': '),
                                                          SizedBox(
                                                            height: 40,
                                                            width: 80,
                                                            child: SizedBox(
                                                              height: 40,
                                                              width: 100,
                                                              child: Consumer<
                                                                      ToolMarkEntryProviders>(
                                                                  builder: (context,
                                                                      snapshot,
                                                                      child) {
                                                                return InkWell(
                                                                  onTap: () {
                                                                    snapshot.studentMEList[index].attendance ==
                                                                            "A"
                                                                        ? {}
                                                                        : showDialog(
                                                                            context:
                                                                                context,
                                                                            builder:
                                                                                (context) {
                                                                              return Dialog(
                                                                                  child: LimitedBox(
                                                                                maxHeight: size.height / 2,
                                                                                child: ListView.builder(
                                                                                    shrinkWrap: true,
                                                                                    itemCount: snapshot.gradeList.length,
                                                                                    itemBuilder: (context, indx) {
                                                                                      return ListTile(
                                                                                        selectedTileColor: Colors.blue.shade100,
                                                                                        selectedColor: UIGuide.PRIMARY2,
                                                                                        onTap: () {
                                                                                          controllers.text = snapshot.gradeList[indx].gradeName ?? '--';

                                                                                          print(snapshot.gradeList[indx].gradeName);
                                                                                          value.studentMEList[index].toolList![ind].teGrade = snapshot.gradeList[indx].gradeName;

                                                                                          controllerid.text = snapshot.gradeList[indx].gradeId ?? '--';
                                                                                          print(controllerid.text);
                                                                                          value.studentMEList[index].toolList![ind].teGradeId = controllerid.text;
                                                                                          value.studentMEList[index].toolList![ind].teGrade = value.studentMEList[index].toolList![ind].teGrade;
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
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            5.0),
                                                                    child:
                                                                        Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      children: [
                                                                        Container(
                                                                          height:
                                                                              30,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            border:
                                                                                Border.all(color: UIGuide.light_Purple, width: 1),
                                                                          ),
                                                                          child:
                                                                              TextField(
                                                                            style:
                                                                                const TextStyle(fontSize: 14, overflow: TextOverflow.clip),
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            controller:
                                                                                controllers,
                                                                            decoration:
                                                                                const InputDecoration(
                                                                              filled: true,
                                                                              contentPadding: EdgeInsets.only(left: 0, top: 0),
                                                                              floatingLabelBehavior: FloatingLabelBehavior.never,
                                                                              fillColor: Color.fromARGB(255, 255, 255, 255),
                                                                              border: OutlineInputBorder(),
                                                                              labelText: "  Select grade",
                                                                              hintText: "grade",
                                                                            ),
                                                                            enabled:
                                                                                false,
                                                                            onChanged:
                                                                                (value1) {
                                                                              print(controllers.text);
                                                                              // gradeListController1[index].text = value.studentMEList[index].teGradeId.toString();
                                                                              // gradeListController1[index].text = value1;
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
                                                    );
                                                  }),
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
                      },
                    )

                    //kheight20,

                    // LimitedBox(
                    //     maxHeight: size.height / 1.85,
                    //     child: Padding(
                    //       padding: const EdgeInsets.all(4.0),
                    //       child: ListView.builder(
                    //           shrinkWrap: true,
                    //           itemCount: value.studentMEList.length,
                    //           itemBuilder: ((context, index) {
                    //
                    //             teMarkController.add(TextEditingController());
                    //
                    //             // teMarkController[index].text.isEmpty
                    //             //     ? teMarkController[index].text =
                    //             // value.studentMEList[index].toolList![index].teMark == null
                    //             //     ? teMarkController[index].text
                    //             //     : value.studentMEList[index].toolList![index].teMark
                    //             //     .toString()
                    //             //     : teMarkController[index].text;
                    //
                    //
                    //             // //TE Grade
                    //             // publicGradeController
                    //             //     .add(TextEditingController());
                    //             // publicGradeController1
                    //             //     .add(TextEditingController());
                    //
                    //             // publicGradeController1[index].text.isEmpty
                    //             //     ? publicGradeController1[index]
                    //             //         .text = value.studentMEList[index]
                    //             //                 .teGradeId ==
                    //             //             null
                    //             //         ? publicGradeController1[index].text
                    //             //         : value
                    //             //             .studentMEList[index].teGradeId
                    //             //             .toString()
                    //             //     : publicGradeController1[index].text;
                    //             // publicGradeController[index].text.isEmpty
                    //             //     ? publicGradeController[index]
                    //             //         .text = value.studentMEList[index]
                    //             //                 .teGrade ==
                    //             //             null
                    //             //         ? publicGradeController[index].text
                    //             //         : value.studentMEList[index].teGrade
                    //             //             .toString()
                    //             //     : publicGradeController[index].text;
                    //
                    //             return Padding(
                    //               padding: const EdgeInsets.all(4.0),
                    //               child: Container(
                    //                 width: size.width,
                    //                 decoration: BoxDecoration(
                    //                     border: Border.all(
                    //                       color: UIGuide.light_Purple,
                    //                       width: 1,
                    //                     ),
                    //                     borderRadius:
                    //                         BorderRadius.circular(10)),
                    //                 child: Column(
                    //                   crossAxisAlignment:
                    //                       CrossAxisAlignment.start,
                    //                   mainAxisAlignment:
                    //                       MainAxisAlignment.start,
                    //                   children: [
                    //                     Padding(
                    //                       padding: const EdgeInsets.all(5.0),
                    //                       child: Row(
                    //                         children: [
                    //                           SizedBox(
                    //                             width: 80,
                    //                             child: Text(
                    //                               'Roll No:  ${value.studentMEList[index].rollNo == null ? '0' : value.studentMEList[index].rollNo.toString()}',
                    //                               overflow:
                    //                                   TextOverflow.ellipsis,
                    //                             ),
                    //                           ),
                    //                           kWidth,
                    //                           kWidth,
                    //                           kWidth,
                    //                           Padding(
                    //                             padding: const EdgeInsets.only(
                    //                                 left: 10.0),
                    //                             child: GestureDetector(
                    //                               onTap: () {
                    //                                 setState(() {
                    //                                   if (value
                    //                                           .studentMEList[
                    //                                               index]
                    //                                           .attendance ==
                    //                                       'A') {
                    //                                     value
                    //                                         .studentMEList[
                    //                                             index]
                    //                                         .attendance = 'P';
                    //                                   } else {
                    //                                     value
                    //                                         .studentMEList[
                    //                                             index]
                    //                                         .attendance = 'A';
                    //                               //teMarkController[index].clear();
                    //                                    for(int i=0;i<value.studentMEList[index].toolList!.length;i++)
                    //                                      {
                    //                                        value.studentMEList[index].toolList![i].teMark=0;
                    //
                    //                                      }
                    //                                   }
                    //                                   attendancee = value
                    //                                       .studentMEList[index]
                    //                                       .attendance;
                    //
                    //                                   print(
                    //                                       "attendace   $attendancee");
                    //                                 });
                    //                               },
                    //                               child: Container(
                    //                                 color: Colors.transparent,
                    //                                 width: 28,
                    //                                 height: 26,
                    //                                 child: SizedBox(
                    //                                     width: 28,
                    //                                     height: 26,
                    //                                     child: value
                    //                                                 .studentMEList[
                    //                                                     index]
                    //                                                 .attendance ==
                    //                                             'A'
                    //                                         ? SvgPicture.asset(
                    //                                             UIGuide.absent)
                    //                                         : SvgPicture.asset(
                    //                                             UIGuide
                    //                                                 .present)),
                    //                               ),
                    //                             ),
                    //                           ),
                    //                           kWidth,
                    //                           kWidth,
                    //                         ],
                    //                       ),
                    //                     ),
                    //                     Padding(
                    //                       padding: const EdgeInsets.all(4.0),
                    //                       child: Row(
                    //                         children: [
                    //                           const Text(
                    //                             'Name: ',
                    //                             style: TextStyle(),
                    //                           ),
                    //                           Flexible(
                    //                             child: RichText(
                    //                               overflow:
                    //                                   TextOverflow.ellipsis,
                    //                               strutStyle: const StrutStyle(
                    //                                   fontSize: 12.0),
                    //                               text: TextSpan(
                    //                                   style: const TextStyle(
                    //                                       color: UIGuide
                    //                                           .light_Purple),
                    //                                   text: value.studentMEList[index].name.toString()
                    //                                   //  value
                    //                                   //     .studentMEList[
                    //                                    //         index]
                    //                                   //     .name,
                    //                                   ),
                    //                             ),
                    //                           ),
                    //                         ],
                    //                       ),
                    //                     ),
                    //                     ListView.builder(
                    //                         physics:
                    //                         const NeverScrollableScrollPhysics(),
                    //                         shrinkWrap: true,
                    //                         itemCount:value.toolListView.length,
                    //                         itemBuilder: (context, ind) {
                    //                           int row = value.studentMEList.length;
                    //                           int col = value.toolListView.length;
                    //
                    //
                    //                         final controller =
                    //                          TextEditingController();
                    //
                    //
                    //                           teMarkController[index].text.isEmpty
                    //                               ? controller.text =
                    //                           value.studentMEList[index].toolList![ind].teMark == null
                    //                               ? controller.text
                    //                               : value.studentMEList[index].toolList![ind].teMark.toString()                                                  .toString()
                    //                               : controller.text;
                    //
                    //                           // for (int i = 0;
                    //                           //     i <=
                    //                           //         value.studentMEList[index]
                    //                           //             .toolList!.length;
                    //                           //     i++) {
                    //                     // _controllers
                    //                     //     .add(controller);
                    //                     // _controllers[index]
                    //                     //     .text
                    //                     //     .isEmpty
                    //                     //     ? _controllers[index]
                    //                     //     .text = value
                    //                     //     .studentMEList[
                    //                     // index]
                    //                     //     .toolList![
                    //                     // ind]
                    //                     //     .teMark ==
                    //                     //     null
                    //                     //     ? _controllers[
                    //                     // index]
                    //                     //     .text
                    //                     //     : value
                    //                     //     .studentMEList[
                    //                     // index]
                    //                     //     .toolList![ind]
                    //                     //     .teMark
                    //                     //     .toString()
                    //                     //     : _controllers[index]
                    //                     //     .text;
                    //                     //}
                    //
                    //
                    //
                    //                           return Padding(
                    //                             padding:
                    //                             const EdgeInsets.only(
                    //                                 left: 5.0),
                    //                             child: Row(
                    //                               mainAxisAlignment:
                    //                               MainAxisAlignment
                    //                                   .start,
                    //                               children: [
                    //                                 SizedBox(
                    //                                   width: size.width /
                    //                                       2.2,
                    //                                   child: Text(
                    //                                     value.toolListView[ind].toolName.toString(),
                    //                                     maxLines: 2,
                    //                                     overflow:
                    //                                     TextOverflow
                    //                                         .ellipsis,
                    //                                   ),
                    //                                 ),
                    //                                 kWidth,
                    //                                 kWidth,
                    //
                    //                                 Text(': '),
                    //                                 Padding(
                    //                                   padding:
                    //                                   const EdgeInsets
                    //                                       .all(5.0),
                    //                                   child: SizedBox(
                    //                                     height: 30,
                    //                                     width: 80,
                    //                                     child: TextField(
                    //                                       controller:
                    //                                      controller,
                    //
                    //                                       enabled: value
                    //                                           .studentMEList[index]
                    //                                           .attendance ==
                    //                                           'A'
                    //                                           ? false
                    //                                           : true,
                    //                                       cursorColor: UIGuide
                    //                                           .light_Purple,
                    //                                       keyboardType:
                    //                                       TextInputType
                    //                                           .number,
                    //                                       inputFormatters: [
                    //                                         FilteringTextInputFormatter
                    //                                             .allow(RegExp(
                    //                                             r"[0-9.]")),
                    //                                         TextInputFormatter
                    //                                             .withFunction(
                    //                                                 (oldValue,
                    //                                                 newValue) {
                    //                                               try {
                    //                                                 final text =
                    //                                                     newValue
                    //                                                         .text;
                    //                                                 if (text
                    //                                                     .isNotEmpty) {
                    //                                                   double.parse(
                    //                                                       text);
                    //                                                 }
                    //                                                 return newValue;
                    //                                               } catch (e) {}
                    //                                               return oldValue;
                    //                                             }),
                    //                                         LengthLimitingTextInputFormatter(
                    //                                             5),
                    //                                       ],
                    //                                       decoration:
                    //                                       InputDecoration(
                    //                                           focusColor: const Color.fromARGB(
                    //                                               255,
                    //                                               213,
                    //                                               215,
                    //                                               218),
                    //                                           border:
                    //                                           OutlineInputBorder(
                    //                                             borderRadius:
                    //                                             BorderRadius.circular(10.0),
                    //                                           ),
                    //                                           focusedBorder:
                    //                                           OutlineInputBorder(
                    //                                             borderSide: const BorderSide(
                    //                                                 color: UIGuide.light_Purple,
                    //                                                 width: 1.0),
                    //                                             borderRadius:
                    //                                             BorderRadius.circular(10.0),
                    //                                           ),
                    //                                           fillColor:
                    //                                           Colors
                    //                                               .grey,
                    //                                           hintStyle:
                    //                                           const TextStyle(
                    //                                             color:
                    //                                             Colors.grey,
                    //                                             fontSize:
                    //                                             16,
                    //                                             fontFamily:
                    //                                             "verdana_regular",
                    //                                             fontWeight:
                    //                                             FontWeight.w400,
                    //                                           ),
                    //                                           labelText:
                    //                                           // value
                    //                                           //         .maxmarkList[
                    //                                           //             0]
                    //                                           //         .teCaption ??
                    //                                           "Mark",
                    //                                           labelStyle: const TextStyle(
                    //                                               fontSize:
                    //                                               13,
                    //                                               color: Color.fromARGB(
                    //                                                   255,
                    //                                                   106,
                    //                                                   107,
                    //                                                   109))),
                    //                                       onChanged:
                    //                                           (value1) {
                    //
                    //                                         controller.text=value1;
                    //
                    //                                            // teMarkController[ind].text = controller.text;
                    //
                    //
                    //                                        // result = double.parse(controller.text);
                    //                                             result = double.parse( controller.text);
                    //                                          value.studentMEList[index].toolList![ind].teMark= result;
                    //                                          print("amrl values");
                    //                                          print(  value.studentMEList[0].toolList![1].teMark);
                    //                                             print(  value.studentMEList[1].toolList![0].teMark);
                    //                                                             // double? valuueee =  value.studentMEList[0].toolList![1].teMark;
                    //                                           //   print("valuesss in  $valuueee");
                    //
                    //
                    //
                    //
                    //                                         // _controllers[index]
                    //                                         //         .text =
                    //                                         //     value
                    //                                         //         .studentMEList[
                    //                                         //             index]
                    //                                         //         .toolList![
                    //                                         //             ind]
                    //                                         //         .teMark
                    //                                         //         .toString();
                    //
                    //                                         // teMarkController[
                    //                                         //         index]
                    //                                         //     .text = value1;
                    //                                        controller
                    //                                                 .selection =
                    //                                             TextSelection.collapsed(
                    //                                                 offset: controller
                    //                                                     .text
                    //                                                     .length);
                    //
                    //                                         // if (double.parse(
                    //                                         //         _controllers[index]
                    //                                         //             .text) >
                    //                                         //     value.toolListView[index].teMaxMark
                    //                                         //         ) {
                    //                                         //   teMarkController[
                    //                                         //           index]
                    //                                         //       .clear();
                    //                                         // }
                    //                                       },
                    //                                     ),
                    //                                   ),
                    //                                 ),
                    //                                 Text( value.studentMEList[index].toolList![ind].teMaxMark.toString()),
                    //                               ],
                    //                             ),
                    //                           );
                    //                         }),
                    //                   ],
                    //                 ),
                    //               ),
                    //             );
                    //
                    //           }
                    //
                    //           )),
                    //     ))
                  ],
                );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
          kWidth,
          const Spacer(),
          Consumer<ToolMarkEntryProviders>(builder: (context, value, child) {
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
                      List initialList = [];
                      initialList.clear();

                      if (value.entryMethod == 'Mark' &&
                          value.typeCode == 'UAS') {
                        for (int i = 0; i < value.studentMEList.length; i++) {
                          List toolListt = [];
                          print("ToolList********      $toolListt");
                          toolListt.clear();

                          for (int j = 0;
                              j < value.studentMEList[i].toolList!.length;
                              j++) {
                            // print("ToolList********      $toolListt");
                            // toolListt.clear();
                            // print(value.studentMEList.length);
                            // print(value.studentMEList[i].toolList!.length);
                            toolListt.add({
                              "attendance": value.studentMEList[i].attendance,
                              "ceGrade": null,
                              "ceGradeId": null,
                              "ceMark": null,
                              "markEntryId": value
                                  .studentMEList[i].toolList![j].markEntryId,
                              "peGrade": null,
                              "peGradeId": null,
                              "peMark": null,
                              "presentDetId": value
                                  .studentMEList[i].toolList![j].presentDetId,
                              "teGrade": null,
                              "teGradeId": null,
                              "teMark":
                                  value.studentMEList[i].toolList![j].teMark,
                              "teMaxMark":
                                  value.studentMEList[i].toolList![j].teMaxMark,
                              "toolId":
                                  value.studentMEList[i].toolList![j].toolId
                            });
                          }

                          // log("tooollll  $toolListt");
                          // print("markkkk");
                          // print(value.studentMEList[i].toolList![j].teMark);
                          // initialList.clear();
                          //  log("singletool: $toolListt");

                          initialList.add({
                            "attendance": value.studentMEList[i].attendance,
                            "description": null,
                            "disableAbsentRow": false,
                            "name": value.studentMEList[i].name ?? '',
                            "rollNo": value.studentMEList[i].rollNo ?? '',
                            "studentPresentDetailsId": value
                                    .studentMEList[i].studentPresentDetailsId ??
                                '',
                            "toolList": toolListt,
                            "totalGrade": null,
                            "totalMark": "",
                            "totalPer": null,
                          });
                        }
                      } else if (value.entryMethod == 'Grade' &&
                          value.typeCode == 'UAS') {
                        for (int i = 0; i < value.studentMEList.length; i++) {
                          List toolListt = [];
                          print("ToolList********      $toolListt");
                          toolListt.clear();

                          for (int j = 0;
                              j < value.studentMEList[i].toolList!.length;
                              j++) {
                            // print("ToolList********      $toolListt");

                            toolListt.add({
                              "attendance": value.studentMEList[i].attendance,
                              "ceGrade": null,
                              "ceGradeId": null,
                              "ceMark": null,
                              "markEntryId": value
                                  .studentMEList[i].toolList![j].markEntryId,
                              "peGrade": null,
                              "peGradeId": null,
                              "peMark": null,
                              "presentDetId": value
                                  .studentMEList[i].toolList![j].presentDetId,
                              "teGrade":
                                  value.studentMEList[i].toolList![j].teGrade,
                              "teGradeId":
                                  value.studentMEList[i].toolList![j].teGradeId,
                              "teMark": null,
                              "teMaxMark": 0,
                              "toolId":
                                  value.studentMEList[i].toolList![j].toolId
                            });
                          }

                          // log("tooollll  $toolListt");
                          // print("markkkk");

                          initialList.add({
                            "attendance": value.studentMEList[i].attendance,
                            "description": null,
                            "disableAbsentRow": false,
                            "name": value.studentMEList[i].name ?? '',
                            "rollNo": value.studentMEList[i].rollNo ?? '',
                            "studentPresentDetailsId": value
                                    .studentMEList[i].studentPresentDetailsId ??
                                '',
                            "toolList": toolListt,
                            "totalGrade": null,
                            "totalMark": "",
                            "totalPer": null,
                          });
                        }
                      }

                      log("Litsssss   $initialList");
                      print("--------------------------------");

                      if (toolDivisionListController.text.isEmpty &&
                          toolInitialValuesController1.text.isEmpty) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          duration: Duration(seconds: 1),
                          margin:
                              EdgeInsets.only(bottom: 80, left: 30, right: 30),
                          behavior: SnackBarBehavior.floating,
                          content: Text(
                            "Select mandatory fileds...!",
                            textAlign: TextAlign.center,
                          ),
                        ));
                      } else {
                        String course =
                            toolInitialValuesController.text.toString();
                        String division =
                            toolDivisionListController.text.toString();
                        String part = toolPartListController.text.toString();
                        String subject =
                            toolSubjectListController.text.toString();
                        String exam = toolExamListController.text.toString();
                        String optional =
                            toolOptionSubListController1.text.toString();
                        Map<String, dynamic> criteria = await {
                          "course": course,
                          "division": division,
                          "part": part,
                          "subject": subject,
                          "subOptionSubject":
                              optional.isEmpty ? null : optional,
                          "exam": exam,
                          "search": null
                        };
                        print(criteria);
                        print(value.toolListView);
                        value.loading
                            ? spinkitLoader()
                            : await value.markEntrySave(context,
                                value.toollListView, initialList, criteria);
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
          //verify
          Consumer<ToolMarkEntryProviders>(builder: (context, value, child) {
            if (value.examStatus == 'Synchronized') {
              return Text("");
            } else {
              if (value.loadverify) {
                return MaterialButton(
                  onPressed: () {},
                  color: Colors.green,
                  child: const Text(
                    'Verifying...',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              } else {
                return MaterialButton(
                  onPressed: () {
                    value.examStatus == "Pending"
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
                                title: Center(
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
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: OutlinedButton(
                                          child: Text(
                                            '  Cancel  ',
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 201, 13, 13),
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          style: ButtonStyle(
                                              side: MaterialStateProperty.all(
                                                  BorderSide(
                                                      color:
                                                          UIGuide.light_Purple,
                                                      width: 1.0,
                                                      style:
                                                          BorderStyle.solid))),
                                        ),
                                      ),
                                      OutlinedButton(
                                          child: Text(
                                            'Confirm',
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 12, 162, 46),
                                            ),
                                          ),
                                          onPressed: () async {
                                            print(
                                                "length:  ${value.studentMEList.length}");
                                            List initialList = [];
                                            initialList.clear();
                                            for (int i = 0;
                                                i < value.studentMEList.length;
                                                i++) {
                                              List toolListt = [];
                                              toolListt.clear();

                                              for (int j = 0;
                                                  j <
                                                      value.studentMEList[i]
                                                          .toolList!.length;
                                                  j++) {
                                                print(
                                                    value.studentMEList.length);
                                                print(value.studentMEList[i]
                                                    .toolList!.length);
                                                toolListt.add({
                                                  "attendance": value
                                                      .studentMEList[i]
                                                      .attendance,
                                                  "ceGrade": null,
                                                  "ceGradeId": null,
                                                  "ceMark": null,
                                                  "markEntryId": value
                                                      .studentMEList[i]
                                                      .toolList![j]
                                                      .markEntryId,
                                                  "peGrade": null,
                                                  "peGradeId": null,
                                                  "peMark": null,
                                                  "presentDetId": value
                                                      .studentMEList[i]
                                                      .toolList![j]
                                                      .presentDetId,
                                                  "teGrade": null,
                                                  "teGradeId": null,
                                                  "teMark": value
                                                      .studentMEList[i]
                                                      .toolList![j]
                                                      .teMark,
                                                  "teMaxMark": value
                                                      .studentMEList[i]
                                                      .toolList![j]
                                                      .teMaxMark,
                                                  "toolId": value
                                                      .studentMEList[i]
                                                      .toolList![j]
                                                      .toolId
                                                });
                                              }
                                              initialList.add({
                                                "attendance": value
                                                    .studentMEList[i]
                                                    .attendance,
                                                "description": null,
                                                "disableAbsentRow": false,
                                                "name": value.studentMEList[i]
                                                        .name ??
                                                    '',
                                                "rollNo": value.studentMEList[i]
                                                        .rollNo ??
                                                    '',
                                                "studentPresentDetailsId": value
                                                        .studentMEList[i]
                                                        .studentPresentDetailsId ??
                                                    '',
                                                "toolList": toolListt,
                                                "totalGrade": null,
                                                "totalMark": "",
                                                "totalPer": null,
                                              });
                                            }

                                            if (toolDivisionListController
                                                    .text.isEmpty &&
                                                toolInitialValuesController1
                                                    .text.isEmpty) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                elevation: 10,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10)),
                                                ),
                                                duration: Duration(seconds: 1),
                                                margin: EdgeInsets.only(
                                                    bottom: 80,
                                                    left: 30,
                                                    right: 30),
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                content: Text(
                                                  "Select mandatory fileds...!",
                                                  textAlign: TextAlign.center,
                                                ),
                                              ));
                                            } else if (initialList.isEmpty) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                elevation: 10,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10)),
                                                ),
                                                duration: Duration(seconds: 1),
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
                                              String course =
                                                  toolInitialValuesController
                                                      .text
                                                      .toString();
                                              String division =
                                                  toolDivisionListController
                                                      .text
                                                      .toString();
                                              String part =
                                                  toolPartListController.text
                                                      .toString();
                                              String subject =
                                                  toolSubjectListController.text
                                                      .toString();
                                              String exam =
                                                  toolExamListController.text
                                                      .toString();
                                              String optional =
                                                  toolOptionSubListController1
                                                      .text
                                                      .toString();
                                              Map<String, dynamic> criteria =
                                                  await {
                                                "course": course,
                                                "division": division,
                                                "part": part,
                                                "subject": subject,
                                                "subOptionSubject":
                                                    optional.isEmpty
                                                        ? null
                                                        : optional,
                                                "exam": exam,
                                                "search": null
                                              };
                                              print(criteria);
                                              print(value.toolListView);
                                              value.loading
                                                  ? spinkitLoader()
                                                  : await value.markEntryVerify(
                                                      context,
                                                      value.toolListView,
                                                      initialList,
                                                      criteria);
                                            }

                                            style:
                                            ButtonStyle(
                                                side: MaterialStateProperty.all(
                                                    BorderSide(
                                                        color: UIGuide
                                                            .light_Purple,
                                                        width: 1.0,
                                                        style: BorderStyle
                                                            .solid)));
                                          })
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
              }
            }
          }),
          kWidth,

          Consumer<ToolMarkEntryProviders>(builder: (context, value, child) {
            if (value.examStatus == 'Synchronized') {
              return Text("");
            } else {
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
                                        child: Text(
                                          '  Cancel  ',
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 201, 13, 13),
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        style: ButtonStyle(
                                            side: MaterialStateProperty.all(
                                                BorderSide(
                                                    color: UIGuide.light_Purple,
                                                    width: 1.0,
                                                    style: BorderStyle.solid))),
                                      ),
                                    ),
                                    OutlinedButton(
                                      child: Text(
                                        'Confirm',
                                        style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 12, 162, 46),
                                        ),
                                      ),
                                      onPressed: () async {
                                        List initialList = [];
                                        initialList.clear();
                                        for (int i = 0;
                                            i < value.studentMEList.length;
                                            i++) {
                                          List toolListt = [];
                                          toolListt.clear();

                                          for (int j = 0;
                                              j <
                                                  value.studentMEList[i]
                                                      .toolList!.length;
                                              j++) {
                                            print(value.studentMEList.length);
                                            print(value.studentMEList[i]
                                                .toolList!.length);
                                            toolListt.add({
                                              "attendance": value
                                                  .studentMEList[i].attendance,
                                              "ceGrade": null,
                                              "ceGradeId": null,
                                              "ceMark": null,
                                              "markEntryId": value
                                                  .studentMEList[i]
                                                  .toolList![j]
                                                  .markEntryId,
                                              "peGrade": null,
                                              "peGradeId": null,
                                              "peMark": null,
                                              "presentDetId": value
                                                  .studentMEList[i]
                                                  .toolList![j]
                                                  .presentDetId,
                                              "teGrade": null,
                                              "teGradeId": null,
                                              "teMark": value.studentMEList[i]
                                                  .toolList![j].teMark,
                                              "teMaxMark": value
                                                  .studentMEList[i]
                                                  .toolList![j]
                                                  .teMaxMark,
                                              "toolId": value.studentMEList[i]
                                                  .toolList![j].toolId
                                            });
                                          }
                                          initialList.add({
                                            "attendance": value
                                                .studentMEList[i].attendance,
                                            "description": null,
                                            "disableAbsentRow": false,
                                            "name":
                                                value.studentMEList[i].name ??
                                                    '',
                                            "rollNo":
                                                value.studentMEList[i].rollNo ??
                                                    '',
                                            "studentPresentDetailsId": value
                                                    .studentMEList[i]
                                                    .studentPresentDetailsId ??
                                                '',
                                            "toolList": toolListt,
                                            "totalGrade": null,
                                            "totalMark": "",
                                            "totalPer": null,
                                          });
                                        }

                                        if (toolDivisionListController
                                                .text.isEmpty &&
                                            toolInitialValuesController1
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
                                              "Select mandatory fileds...!",
                                              textAlign: TextAlign.center,
                                            ),
                                          ));
                                        } else if (initialList.isEmpty) {
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
                                              "No data to Delete"
                                              "...",
                                              textAlign: TextAlign.center,
                                            ),
                                          ));
                                        } else {
                                          String course =
                                              toolInitialValuesController.text
                                                  .toString();
                                          String division =
                                              toolDivisionListController.text
                                                  .toString();
                                          String part = toolPartListController
                                              .text
                                              .toString();
                                          String subject =
                                              toolSubjectListController.text
                                                  .toString();
                                          String exam = toolExamListController
                                              .text
                                              .toString();
                                          String optional =
                                              toolOptionSubListController1.text
                                                  .toString();
                                          Map<String, dynamic> criteria =
                                              await {
                                            "course": course,
                                            "division": division,
                                            "part": part,
                                            "subject": subject,
                                            "subOptionSubject": optional.isEmpty
                                                ? null
                                                : optional,
                                            "exam": exam,
                                            "search": null
                                          };
                                          print(criteria);
                                          print(value.toolListView);
                                          value.loading
                                              ? spinkitLoader()
                                              : await value.markEntryDelete(
                                                  context,
                                                  value.toolListView,
                                                  initialList,
                                                  criteria);
                                        }
                                      },
                                      style: ButtonStyle(
                                          side: MaterialStateProperty.all(
                                              BorderSide(
                                                  color: UIGuide.light_Purple,
                                                  width: 1.0,
                                                  style: BorderStyle.solid))),
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
            }
          }),
          kWidth,
        ]),
      ),
    );
  }
}
