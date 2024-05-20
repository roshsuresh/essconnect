import 'dart:developer';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:essconnect/Constants.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:essconnect/utils/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../Application/Staff_Providers/RemarksEntry.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';

class RemarksEntry extends StatefulWidget {
  const RemarksEntry({Key? key}) : super(key: key);

  @override
  State<RemarksEntry> createState() => _RemarksEntryState();
}

class _RemarksEntryState extends State<RemarksEntry> {
  final List<TextEditingController> _controllers = [];
  List<TextEditingController> teacherremarkController = [];
  List<TextEditingController> principalremarkController = [];
  List<TextEditingController> remarkListController = [];
  List<TextEditingController> remarkListController1 = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var p = Provider.of<RemarksEntryProvider>(context, listen: false);
      await p.courseClear();
      await p.divisionClear();
      await p.removeAllTermClear();
      await p.removeAllAssessmentClear();
      p.clearStuentList();
      p.isTerminated = false;
      p.setLoading(false);
      await p.getRemarkEntryInitialValues(context);
    });
  }

  bool attend = false;
  String courseId = '';
  String termId = '';
  String categoryId = '';
  String category = '';
  String divisionId = '';
  String exam = '';
  String instaId = '';
  String assessmentId = '';
  String? attendancee;
  String? assessment = '';

  final remarkEntryInitialValuesController = TextEditingController();
  final remarkEntryInitialValuesController1 = TextEditingController();
  final remarkEntryDivisionListController = TextEditingController();
  final remarkEntryDivisionListController1 = TextEditingController();
  final remarkEntryCategoryController = TextEditingController();
  final remarkEntryCategoryController1 = TextEditingController();
  final remarkEntryTermController = TextEditingController();
  final remarkEntryTermController1 = TextEditingController();
  final markEntryExamListController = TextEditingController();
  final markEntryExamListController1 = TextEditingController();
  final markfieldController = TextEditingController();
  final markfieldController1 = TextEditingController();
  final remarkEntryAssessmentListController = TextEditingController();
  final remarkEntryAssessmentListController1 = TextEditingController();

  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          title: Row(
            children: [
              const Spacer(),
              const Text('Remarks Entry'),
              const Spacer(),
              Consumer<RemarksEntryProvider>(
                builder: (context, val, _) => val.loading
                    ? const SizedBox(
                        height: 0,
                        width: 0,
                      )
                    : IconButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RemarksEntry()));
                        },
                        icon: const Icon(Icons.refresh)),
              )
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
      body: Consumer<RemarksEntryProvider>(builder: (context, value, _) {
        return Stack(
          children: [
            Column(children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: [
                    kWidth,
                    SizedBox(
                      height: 40,
                      width: MediaQuery.of(context).size.width * 0.46,
                      child: Consumer<RemarksEntryProvider>(
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
                                            itemCount: snapshot
                                                .remarksEntryInitialValues
                                                .length,
                                            itemBuilder: (context, index) {
                                              return ListTile(
                                                onTap: () async {
                                                  Navigator.of(context).pop();
                                                  remarkEntryInitialValuesController
                                                      .text = snapshot
                                                          .remarksEntryInitialValues[
                                                              index]
                                                          .value ??
                                                      '--';
                                                  remarkEntryInitialValuesController1
                                                      .text = snapshot
                                                          .remarksEntryInitialValues[
                                                              index]
                                                          .text ??
                                                      '--';
                                                  courseId =
                                                      remarkEntryInitialValuesController
                                                          .text
                                                          .toString();
                                                  instaId = snapshot
                                                      .remarksEntryInitialValues[
                                                          index]
                                                      .installationId
                                                      .toString();

                                                  //div
                                                  remarkEntryDivisionListController
                                                      .clear();
                                                  remarkEntryDivisionListController1
                                                      .clear();
                                                  await snapshot
                                                      .divisionClear();

                                                  //category

                                                  remarkEntryCategoryController
                                                      .clear();
                                                  remarkEntryCategoryController1
                                                      .clear();

                                                  // term

                                                  remarkEntryTermController
                                                      .clear();
                                                  remarkEntryTermController1
                                                      .clear();

                                                  await snapshot
                                                      .removeAllTermClear();

                                                  await snapshot
                                                      .getRemarkEntryDivisionValues(
                                                          courseId,
                                                          instaId,
                                                          context);
                                                  await value.clearStuentList();
                                                },
                                                title: Text(
                                                  snapshot
                                                          .remarksEntryInitialValues[
                                                              index]
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
                            controller: remarkEntryInitialValuesController1,
                            decoration: const InputDecoration(
                              filled: true,
                              contentPadding: EdgeInsets.only(left: 0, top: 0),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              fillColor: Colors.transparent,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    style: BorderStyle.none, width: 0),
                              ),
                              labelText: "  Select Course",
                              hintText: "Course",
                            ),
                            enabled: false,
                          ),
                        );
                      }),
                    ),
                    const Spacer(),
                    SizedBox(
                      height: 40,
                      width: MediaQuery.of(context).size.width * 0.46,
                      child: Consumer<RemarksEntryProvider>(
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
                                            itemCount: snapshot
                                                .remarkEntryDivisionList.length,
                                            itemBuilder: (context, index) {
                                              return ListTile(
                                                selectedTileColor:
                                                    Colors.blue.shade100,
                                                onTap: () async {
                                                  Navigator.of(context).pop();
                                                  snapshot.clearStuentList();
                                                  remarkEntryTermController1
                                                      .clear();
                                                  remarkEntryTermController
                                                      .clear();
                                                  snapshot.remarkTermList
                                                      .clear();

                                                  snapshot.remarkCategoryList
                                                      .clear();

                                                  remarkEntryDivisionListController
                                                      .clear();
                                                  remarkEntryCategoryController1
                                                      .clear();
                                                  remarkEntryDivisionListController
                                                      .text = snapshot
                                                          .remarkEntryDivisionList[
                                                              index]
                                                          .value ??
                                                      '---';
                                                  remarkEntryDivisionListController1
                                                      .text = snapshot
                                                          .remarkEntryDivisionList[
                                                              index]
                                                          .text ??
                                                      '---';

                                                  divisionId =
                                                      remarkEntryDivisionListController
                                                          .text
                                                          .toString();
                                                  courseId =
                                                      remarkEntryInitialValuesController
                                                          .text
                                                          .toString();
                                                  //category

                                                  remarkEntryCategoryController
                                                      .clear();
                                                  remarkEntryCategoryController1
                                                      .clear();

                                                  // sub

                                                  remarkEntryTermController
                                                      .clear();
                                                  remarkEntryTermController1
                                                      .clear();
                                                  await snapshot
                                                      .removeAllAssessmentClear();
                                                  if (snapshot.tabmethod ==
                                                      "PBT") {
                                                    snapshot
                                                        .getRemarkEntryTermValues(
                                                            divisionId,
                                                            null,
                                                            instaId,
                                                            snapshot.tabmethod
                                                                .toString(),
                                                            context);
                                                  } else {
                                                    snapshot
                                                        .getRemarkEntryCategoryValues(
                                                            divisionId,
                                                            instaId,
                                                            context);
                                                  }

                                                  //option sub

                                                  //
                                                  // await snapshot
                                                  //     .getRemarkEntryDivisionValues(
                                                  //     courseId,instaId);
                                                },
                                                title: Text(
                                                  snapshot
                                                          .remarkEntryDivisionList[
                                                              index]
                                                          .text ??
                                                      '---',
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
                            controller: remarkEntryDivisionListController1,
                            decoration: const InputDecoration(
                              filled: true,
                              contentPadding: EdgeInsets.only(left: 0, top: 0),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              fillColor: Colors.transparent,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    style: BorderStyle.none, width: 0),
                              ),
                              labelText: "  Select Division",
                              hintText: "Division",
                            ),
                            enabled: false,
                          ),
                        );
                      }),
                    ),
                    kWidth,
                  ],
                ),
              ),

              value.tabmethod == "PBT"
                  ? Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        children: [
                          kWidth,
                          SizedBox(
                            height: 40,
                            width: MediaQuery.of(context).size.width * 0.46,
                            child: Consumer<RemarksEntryProvider>(
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
                                                  itemCount: snapshot
                                                      .remarkTermList.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    print(snapshot
                                                        .remarkterm.length);
                                                    return ListTile(
                                                      selectedTileColor:
                                                          Colors.blue.shade100,
                                                      onTap: () async {
                                                        Navigator.of(context)
                                                            .pop();
                                                        remarkEntryTermController
                                                            .text = snapshot
                                                                .remarkTermList[
                                                                    index]
                                                                .value ??
                                                            '---';
                                                        remarkEntryTermController1
                                                            .text = snapshot
                                                                .remarkTermList[
                                                                    index]
                                                                .text ??
                                                            '---';

                                                        termId =
                                                            remarkEntryTermController
                                                                .text;

                                                        divisionId =
                                                            remarkEntryDivisionListController
                                                                .text
                                                                .toString();
                                                        categoryId =
                                                            remarkEntryCategoryController
                                                                .text
                                                                .toString();
                                                        category =
                                                            remarkEntryCategoryController1
                                                                .text
                                                                .toString();

                                                        //option sub

                                                        // exam

                                                        // await snapshot
                                                        //     .getRemarkEntryAssessmentValues(
                                                        //         divisionId,
                                                        //         categoryId,
                                                        //         termId,
                                                        //         instaId);

                                                        await value
                                                            .clearStuentList();
                                                      },
                                                      title: Text(
                                                        snapshot
                                                            .remarkTermList[
                                                                index]
                                                            .text
                                                            .toString(),
                                                        textAlign:
                                                            TextAlign.center,
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
                                  controller: remarkEntryTermController1,
                                  decoration: const InputDecoration(
                                    filled: true,
                                    contentPadding:
                                        EdgeInsets.only(left: 0, top: 0),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    fillColor: Colors.transparent,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          style: BorderStyle.none, width: 0),
                                    ),
                                    labelText: "  Select Term",
                                    hintText: "Term",
                                  ),
                                  enabled: false,
                                ),
                              );
                            }),
                          ),
                          kWidth,
                        ],
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        children: [
                          kWidth,
                          SizedBox(
                            height: 40,
                            width: MediaQuery.of(context).size.width * 0.46,
                            child: Consumer<RemarksEntryProvider>(
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
                                                  itemCount: snapshot
                                                      .remarkCategoryList
                                                      .length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    print(snapshot
                                                        .remarkCategoryList
                                                        .length);
                                                    return ListTile(
                                                      selectedTileColor:
                                                          Colors.blue.shade100,
                                                      onTap: () async {
                                                        Navigator.of(context)
                                                            .pop();
                                                        value.remarkTermList
                                                            .clear();
                                                        value.clearStuentList();
                                                        termId = "";
                                                        remarkEntryCategoryController
                                                            .text = snapshot
                                                                .remarkCategoryList[
                                                                    index]
                                                                .value ??
                                                            '--';
                                                        remarkEntryCategoryController1
                                                            .text = snapshot
                                                                .remarkCategoryList[
                                                                    index]
                                                                .text ??
                                                            '--';
                                                        //
                                                        // categoryItems = snapshot
                                                        //     .remarkCategoryList[index]
                                                        //     .toJson();

                                                        divisionId =
                                                            remarkEntryDivisionListController
                                                                .text
                                                                .toString();
                                                        categoryId =
                                                            remarkEntryCategoryController
                                                                .text
                                                                .toString();
                                                        category =
                                                            remarkEntryCategoryController1
                                                                .text
                                                                .toString();

                                                        remarkEntryTermController
                                                            .clear();
                                                        remarkEntryTermController1
                                                            .clear();

                                                        await snapshot
                                                            .removeAllAssessmentClear();
                                                        //option sub

                                                        remarkEntryAssessmentListController
                                                            .clear();
                                                        remarkEntryAssessmentListController1
                                                            .clear();

                                                        // exam

                                                        markEntryExamListController
                                                            .clear();
                                                        markEntryExamListController1
                                                            .clear();
                                                        print(category);

                                                        await snapshot
                                                            .getRemarkEntryTermValues(
                                                                divisionId,
                                                                categoryId,
                                                                instaId,
                                                                value.tabmethod
                                                                    .toString(),
                                                                context);
                                                        await value
                                                            .clearStuentList();
                                                      },
                                                      title: Text(
                                                        snapshot
                                                                .remarkCategoryList[
                                                                    index]
                                                                .text ??
                                                            '---',
                                                        textAlign:
                                                            TextAlign.center,
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
                                  controller: remarkEntryCategoryController1,
                                  decoration: const InputDecoration(
                                    filled: true,
                                    contentPadding:
                                        EdgeInsets.only(left: 0, top: 0),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    fillColor: Colors.transparent,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          style: BorderStyle.none, width: 0),
                                    ),
                                    labelText: "  Remarks Category ",
                                    hintText: "Remark",
                                  ),
                                  enabled: false,
                                ),
                              );
                            }),
                          ),
                          const Spacer(),
                          category == "Final"
                              ? const SizedBox(
                                  height: 0,
                                  width: 0,
                                )
                              : SizedBox(
                                  height: 40,
                                  width:
                                      MediaQuery.of(context).size.width * 0.46,
                                  child: Consumer<RemarksEntryProvider>(
                                      builder: (context, snapshot, child) {
                                    return ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        elevation: 3,
                                        foregroundColor: UIGuide.light_Purple,
                                        backgroundColor: UIGuide.ButtonBlue,
                                        padding: const EdgeInsets.all(0),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                                                          BorderRadius.circular(
                                                              15)),
                                                  child: LimitedBox(
                                                    maxHeight:
                                                        size.height - 300,
                                                    child: ListView.builder(
                                                        shrinkWrap: true,
                                                        itemCount: snapshot
                                                            .remarkTermList
                                                            .length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return ListTile(
                                                            selectedTileColor:
                                                                Colors.blue
                                                                    .shade100,
                                                            onTap: () async {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                              assessmentId = "";
                                                              remarkEntryAssessmentListController1
                                                                  .clear();
                                                              remarkEntryAssessmentListController
                                                                  .clear();
                                                              await value
                                                                  .removeAllAssessmentClear();
                                                              value
                                                                  .clearStuentList();

                                                              remarkEntryTermController
                                                                  .text = snapshot
                                                                      .remarkTermList[
                                                                          index]
                                                                      .value ??
                                                                  '---';
                                                              remarkEntryTermController1
                                                                  .text = snapshot
                                                                      .remarkTermList[
                                                                          index]
                                                                      .text ??
                                                                  '---';

                                                              termId =
                                                                  remarkEntryTermController
                                                                      .text;

                                                              divisionId =
                                                                  remarkEntryDivisionListController
                                                                      .text
                                                                      .toString();
                                                              categoryId =
                                                                  remarkEntryCategoryController
                                                                      .text
                                                                      .toString();
                                                              category =
                                                                  remarkEntryCategoryController1
                                                                      .text
                                                                      .toString();

                                                              //option sub

                                                              // exam

                                                              await snapshot
                                                                  .getRemarkEntryAssessmentValues(
                                                                      divisionId,
                                                                      categoryId,
                                                                      termId,
                                                                      instaId,
                                                                      context);

                                                              await value
                                                                  .clearStuentList();
                                                            },
                                                            title: Text(
                                                              snapshot
                                                                  .remarkTermList[
                                                                      index]
                                                                  .text
                                                                  .toString(),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
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
                                        controller: remarkEntryTermController1,
                                        decoration: const InputDecoration(
                                          filled: true,
                                          contentPadding:
                                              EdgeInsets.only(left: 0, top: 0),
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.never,
                                          fillColor: Colors.transparent,
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                style: BorderStyle.none,
                                                width: 0),
                                          ),
                                          labelText: "  Select Term",
                                          hintText: "Term",
                                        ),
                                        enabled: false,
                                      ),
                                    );
                                  }),
                                ),
                          kWidth,
                        ],
                      ),
                    ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: [
                    //  Spacer(),
                    kWidth,
                    Consumer<RemarksEntryProvider>(
                      builder: (context, snapshot, child) {
                        if (remarkEntryCategoryController1.text !=
                            "Assessment") {
                          return const SizedBox(
                            height: 0,
                            width: 0,
                          );
                        }
                        return SizedBox(
                            height: 40,
                            width: MediaQuery.of(context).size.width * 0.46,
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
                                                itemCount: snapshot
                                                        .remarkEntryAssessmentList
                                                        .isEmpty
                                                    ? 0
                                                    : snapshot
                                                        .remarkEntryAssessmentList
                                                        .length,
                                                itemBuilder: (context, index) {
                                                  return ListTile(
                                                    selectedTileColor:
                                                        Colors.blue.shade100,
                                                    onTap: () async {
                                                      Navigator.of(context)
                                                          .pop();
                                                      print("Assessmentttt");
                                                      snapshot
                                                          .clearStuentList();
                                                      remarkEntryAssessmentListController
                                                          .text = snapshot
                                                              .remarkEntryAssessmentList[
                                                                  index]
                                                              .text ??
                                                          '--';
                                                      remarkEntryAssessmentListController1
                                                          .text = snapshot
                                                              .remarkEntryAssessmentList[
                                                                  index]
                                                              .value ??
                                                          '--';
                                                      assessment = snapshot
                                                          .remarkEntryAssessmentList[
                                                              index]
                                                          .text
                                                          .toString();
                                                      assessmentId =
                                                          remarkEntryAssessmentListController
                                                              .text;

                                                      print("list clearrrrr");
                                                    },
                                                    title: Text(
                                                      snapshot
                                                              .remarkEntryAssessmentList[
                                                                  index]
                                                              .text ??
                                                          '--',
                                                      textAlign:
                                                          TextAlign.center,
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
                                controller: remarkEntryAssessmentListController,
                                decoration: const InputDecoration(
                                  filled: true,
                                  contentPadding:
                                      EdgeInsets.only(left: 0, top: 0),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  fillColor: Colors.transparent,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        style: BorderStyle.none, width: 0),
                                  ),
                                  labelText: "  Select Assessment",
                                  hintText: "Assessment",
                                ),
                                enabled: false,
                              ),
                            ));
                      },
                    ),
                    //const Spacer(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    kWidth,
                    SizedBox(
                      width: size.width * 0.46,
                      child: InkWell(
                          onTap: () async {
                            await value.clearStuentList();
                            await value.terminatedCheckbox();
                          },
                          child: Row(
                            children: [
                              Checkbox(
                                activeColor: UIGuide.light_Purple,
                                value: value.isTerminated,
                                onChanged: (newValue) async {
                                  await value.clearStuentList();
                                  await value.terminatedCheckbox();
                                },
                              ),
                              const Expanded(
                                //  width: size.width * .35,
                                child: Text(
                                  "Include Terminated Students",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: UIGuide.BLACK, fontSize: 12),
                                ),
                              )
                            ],
                          )),
                    ),
                    const Spacer(),
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
                        : SizedBox(
                            width: size.width * .46,
                            child: MaterialButton(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                              color: UIGuide.light_Purple,
                              onPressed: (() async {
                                value.clearStuentList();
                                value.id = "";

                                String course =
                                    remarkEntryInitialValuesController.text
                                        .toString();
                                String division =
                                    remarkEntryDivisionListController.text
                                        .toString();
                                String category = remarkEntryCategoryController1
                                    .text
                                    .toString();
                                print("Category: $category");
                                print(value.tabmethod);

                                _controllers.clear();
                                teacherremarkController.clear();
                                principalremarkController.clear();

                                remarkListController1.clear();
                                remarkListController.clear();
                                // value.clearStuentList();
                                if (value.tabmethod == "UAS") {
                                  if (category == "Assessment") {
                                    if (courseId.isEmpty ||
                                        divisionId.isEmpty ||
                                        categoryId.isEmpty ||
                                        termId.isEmpty ||
                                        assessmentId.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        elevation: 10,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
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
                                      await value.getRemarksEntryView(
                                          courseId,
                                          divisionId,
                                          categoryId,
                                          termId,
                                          category == "Assessment"
                                              ? assessmentId
                                              : "",
                                          value.isTerminated,
                                          true,
                                          true,
                                          value.tabmethod.toString());
                                    }
                                  } else if (category == "Term") {
                                    if (courseId.isEmpty ||
                                        divisionId.isEmpty ||
                                        categoryId.isEmpty ||
                                        termId.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        elevation: 10,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
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
                                      await value.getRemarksEntryView(
                                          courseId,
                                          divisionId,
                                          categoryId,
                                          termId,
                                          category == "Assessment"
                                              ? assessmentId
                                              : "",
                                          value.isTerminated,
                                          false,
                                          true,
                                          value.tabmethod.toString());
                                    }
                                  } else {
                                    if (courseId.isEmpty ||
                                        divisionId.isEmpty ||
                                        categoryId.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        elevation: 10,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
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
                                      await value.getRemarksEntryView(
                                          courseId,
                                          divisionId,
                                          categoryId,
                                          category == "Final" ? "" : termId,
                                          category == "Assessment"
                                              ? assessmentId
                                              : "",
                                          value.isTerminated,
                                          false,
                                          false,
                                          value.tabmethod.toString());
                                    }
                                  }
                                } else {
                                  if (courseId.isEmpty ||
                                      divisionId.isEmpty ||
                                      termId.isEmpty) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      elevation: 10,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
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
                                    print("pub saveeee");
                                    await value.getRemarksEntryView(
                                        courseId,
                                        divisionId,
                                        categoryId,
                                        termId,
                                        category == "Assessment"
                                            ? assessmentId
                                            : "",
                                        value.isTerminated,
                                        false,
                                        true,
                                        value.tabmethod.toString());
                                    print("pub saveeeedddddd");
                                    if (value.studListRemarks.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        elevation: 10,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        duration: Duration(seconds: 3),
                                        margin: EdgeInsets.only(
                                            bottom: 80, left: 30, right: 30),
                                        behavior: SnackBarBehavior.floating,
                                        content: Text(
                                          "No data Found..!",
                                          textAlign: TextAlign.center,
                                        ),
                                      ));
                                    }
                                  }
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
                    kWidth
                  ],
                ),
              ),

              //UAS -- Remarks Entry
              //---------------------

              Consumer<RemarksEntryProvider>(builder: (context, provider, _) {
                // if (provider.loading) {
                //   return Expanded(
                //     // maxHeight: size.height / 1.85,
                //     child: spinkitLoader(),
                //   );
                // } else

                if (value.tabmethod == "UAS") {
                  return Expanded(
                      // maxHeight: remarkEntryCategoryController1.text != "Assessment"
                      //     ? size.height / 1.60
                      //     : size.height / 1.75,
                      child: Scrollbar(
                    thickness: 5,
                    controller: _scrollController,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: provider.studListRemarks.length,
                          itemBuilder: ((context, index) {
                            _controllers.add(TextEditingController());

                            _controllers[index].text.isEmpty
                                ? _controllers[index].text = provider
                                            .studListRemarks[index].remarks ==
                                        null
                                    ? _controllers[index].text
                                    : provider.studListRemarks[index].remarks
                                        .toString()
                                : _controllers[index].text;

                            remarkListController.add(TextEditingController());
                            remarkListController1.add(TextEditingController());

                            remarkListController[index].text.isEmpty
                                ? remarkListController[index].text = provider
                                            .studListRemarks[index]
                                            .remarksCaption ==
                                        null
                                    ? remarkListController[index].text
                                    : provider
                                        .studListRemarks[index].remarksCaption
                                        .toString()
                                : remarkListController[index].text;

                            remarkListController1[index].text.isEmpty
                                ? remarkListController1[index].text = provider
                                            .studListRemarks[index]
                                            .remarksMasterId ==
                                        null
                                    ? remarkListController1[index].text
                                    : provider
                                        .studListRemarks[index].remarksMasterId
                                        .toString()
                                : remarkListController1[index].text;

                            return Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                width: size.width,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: UIGuide.light_Purple,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Row(
                                        children: [
                                          kWidth,
                                          const Text(
                                            'Roll No: ',
                                            style: TextStyle(),
                                          ),
                                          provider.studListRemarks[index]
                                                      .rollNo ==
                                                  null
                                              ? const Text(
                                                  '',
                                                  style: TextStyle(
                                                      color:
                                                          UIGuide.light_Purple),
                                                )
                                              : Text(
                                                  provider
                                                      .studListRemarks[index]
                                                      .rollNo
                                                      .toString(),
                                                  style: const TextStyle(
                                                      color:
                                                          UIGuide.light_Purple),
                                                ),
                                          kWidth,
                                          kWidth,
                                          kWidth,
                                          const Text(
                                            'Name: ',
                                            style: TextStyle(),
                                          ),
                                          Flexible(
                                            child: RichText(
                                              overflow: TextOverflow.ellipsis,
                                              strutStyle: const StrutStyle(
                                                  fontSize: 12.0),
                                              text: TextSpan(
                                                style: const TextStyle(
                                                    color:
                                                        UIGuide.light_Purple),
                                                text: provider
                                                    .studListRemarks[index]
                                                    .name,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Row(
                                        children: [
                                          kWidth,
                                          const Text(
                                            'Remarks: ',
                                            style: TextStyle(),
                                          ),
                                          kWidth,
                                          SizedBox(
                                            // height: 20,
                                            width: size.width / 2,
                                            child:
                                                Consumer<RemarksEntryProvider>(
                                                    builder: (context, snapshot,
                                                        child) {
                                              return InkWell(
                                                onTap: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return Dialog(
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15)),
                                                            child: LimitedBox(
                                                              maxHeight:
                                                                  size.height /
                                                                      2,
                                                              child: ListView
                                                                  .builder(
                                                                      shrinkWrap:
                                                                          true,
                                                                      itemCount: snapshot
                                                                          .remarksMaster
                                                                          .length,
                                                                      itemBuilder:
                                                                          (context,
                                                                              indx) {
                                                                        return ListTile(
                                                                          selectedTileColor: Colors
                                                                              .blue
                                                                              .shade100,
                                                                          onTap:
                                                                              () {
                                                                            remarkListController[index].text =
                                                                                snapshot.remarksMaster[indx].text ?? '--';
                                                                            remarkListController1[index].text =
                                                                                snapshot.remarksMaster[indx].value ?? '--';
                                                                            provider.studListRemarks[index].remarksMasterId =
                                                                                remarkListController1[index].text;
                                                                            //     provider.studListUAS[index].teGrade = gradeListController[index].text;
                                                                            //provider.studListRemarks[index].remarksMasterId = provider.studListRemarks[index].remarksMasterId;
                                                                            Navigator.of(context).pop();
                                                                          },
                                                                          title:
                                                                              Text(
                                                                            snapshot.remarksMaster[indx].text ??
                                                                                '--',
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                          ),
                                                                        );
                                                                      }),
                                                            ));
                                                      });
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
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
                                                          style: const TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color:
                                                                  UIGuide.BLACK,
                                                              overflow:
                                                                  TextOverflow
                                                                      .clip),
                                                          textAlign:
                                                              TextAlign.center,
                                                          controller:
                                                              remarkListController[
                                                                  index],
                                                          decoration:
                                                              const InputDecoration(
                                                            filled: true,
                                                            contentPadding:
                                                                EdgeInsets.only(
                                                                    left: 0,
                                                                    top: 0),
                                                            floatingLabelBehavior:
                                                                FloatingLabelBehavior
                                                                    .never,
                                                            fillColor:
                                                                Color.fromARGB(
                                                                    255,
                                                                    255,
                                                                    255,
                                                                    255),
                                                            border:
                                                                OutlineInputBorder(),
                                                            labelText:
                                                                " Select Remark ",
                                                            hintText: "Remarks",
                                                          ),
                                                          enabled: false,
                                                          onChanged: (value1) {
                                                            remarkListController1[
                                                                        index]
                                                                    .text =
                                                                provider
                                                                    .studListRemarks[
                                                                        index]
                                                                    .remarksMasterId
                                                                    .toString();
                                                            remarkListController1[
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
                                          const Spacer(),
                                          Consumer<RemarksEntryProvider>(
                                            builder:
                                                (context, snapshot, child) {
                                              return InkWell(
                                                  onTap: () async {
                                                    print("viewwwwwwwww");

                                                    await snapshot.markHistoryAttachment(
                                                        value
                                                            .studListRemarks[
                                                                index]
                                                            .rollNo
                                                            .toString(),
                                                        value
                                                            .studListRemarks[
                                                                index]
                                                            .studentId
                                                            .toString(),
                                                        value
                                                            .studListRemarks[
                                                                index]
                                                            .name
                                                            .toString(),
                                                        value
                                                            .studListRemarks[
                                                                index]
                                                            .remarks
                                                            .toString(),
                                                        value
                                                            .studListRemarks[
                                                                index]
                                                            .remarksMasterId
                                                            .toString(),
                                                        value
                                                            .studListRemarks[
                                                                index]
                                                            .fileId
                                                            .toString(),
                                                        value
                                                            .studListRemarks[
                                                                index]
                                                            .remarksEntryId
                                                            .toString(),
                                                        value
                                                            .studListRemarks[
                                                                index]
                                                            .remarksEntryDetId
                                                            .toString());
                                                    if (value
                                                            .studListRemarks[
                                                                index]
                                                            .fileId ==
                                                        null) {
                                                      await Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const NoMarkEntry()));
                                                    } else {
                                                      await Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const MarkView()));
                                                    }
                                                  },
                                                  child: const Text(
                                                    "View",
                                                    style: TextStyle(
                                                      color:
                                                          UIGuide.light_Purple,
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      backgroundColor:
                                                          UIGuide.light_black,
                                                      // decoration: TextDecoration
                                                      //     .underline,
                                                      decorationThickness: 1.5,
                                                      decorationStyle:
                                                          TextDecorationStyle
                                                              .solid,
                                                    ),
                                                  ));
                                            },
                                          ),
                                          kWidth
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: SizedBox(
                                        height: 50,
                                        width: size.width,
                                        child: TextField(
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(
                                                255)
                                          ],

                                          // textAlign: TextAlign.center,
                                          //  focusNode: FocusNode(),
                                          controller: _controllers[index],
                                          enabled: true,
                                          cursorColor: UIGuide.light_Purple,
                                          decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      left: 10),
                                              focusColor: const Color.fromARGB(
                                                  255, 213, 215, 218),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: UIGuide.light_Purple,
                                                    width: 1.0),
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              fillColor: Colors.grey,
                                              hintStyle: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 16,
                                                fontFamily: "verdana_regular",
                                                fontWeight: FontWeight.w400,
                                              ),
                                              labelText: 'Description',
                                              labelStyle: const TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 106, 107, 109))),
                                          onChanged: (value1) {
                                            _controllers[index].addListener(() {
                                              value1;
                                            });
                                            _controllers[index].text.isEmpty
                                                ? provider
                                                    .studListRemarks[index]
                                                    .remarks = null
                                                : _controllers[index].text;
                                            print(
                                                "***************${_controllers[index].text}");
                                          },
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          })),
                    ),
                  ));
                }

                //Public Tabulation-- Remark Entry
                //--------------------------------
                else if (value.tabmethod == "PBT") {
                  return Expanded(
                      //  maxHeight: size.height / 1.60,
                      child: Scrollbar(
                    thickness: 5,
                    controller: _scrollController,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: provider.studListRemarks.length,
                          itemBuilder: ((context, index) {
                            teacherremarkController
                                .add(TextEditingController());
                            principalremarkController
                                .add(TextEditingController());

                            teacherremarkController[index].text.isEmpty
                                ? teacherremarkController[index].text =
                                    value.studListRemarks[index].remarks == null
                                        ? teacherremarkController[index].text
                                        : value.studListRemarks[index].remarks
                                            .toString()
                                : teacherremarkController[index].text;
                            print("***********");

                            print(
                                value.studListRemarks[index].principalRemarks);

                            principalremarkController[index].text.isEmpty
                                ? principalremarkController[index].text = value
                                            .studListRemarks[index]
                                            .principalRemarks ==
                                        null
                                    ? principalremarkController[index].text
                                    : value
                                        .studListRemarks[index].principalRemarks
                                        .toString()
                                : principalremarkController[index].text;

                            return Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                width: size.width,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: UIGuide.light_Purple,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Row(
                                        children: [
                                          kWidth,
                                          const Text(
                                            'Roll No: ',
                                            style: TextStyle(),
                                          ),
                                          provider.studListRemarks[index]
                                                      .rollNo ==
                                                  null
                                              ? const Text(
                                                  '',
                                                  style: TextStyle(
                                                      color:
                                                          UIGuide.light_Purple),
                                                )
                                              : Text(
                                                  provider
                                                      .studListRemarks[index]
                                                      .rollNo
                                                      .toString(),
                                                  style: const TextStyle(
                                                      color:
                                                          UIGuide.light_Purple),
                                                ),
                                          kWidth,
                                          const Text(
                                            'Name: ',
                                            style: TextStyle(),
                                          ),
                                          Expanded(
                                              //width: size.width * 0.5,
                                              child: Text(
                                            provider.studListRemarks[index]
                                                    .name ??
                                                "-",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: const TextStyle(
                                                color: UIGuide.light_Purple),
                                          )),
                                          kWidth,
                                          InkWell(
                                              onTap: () async {
                                                await provider
                                                    .markHistoryAttachment(
                                                        value
                                                            .studListRemarks[
                                                                index]
                                                            .rollNo
                                                            .toString(),
                                                        value
                                                            .studListRemarks[
                                                                index]
                                                            .studentId
                                                            .toString(),
                                                        value
                                                            .studListRemarks[
                                                                index]
                                                            .name
                                                            .toString(),
                                                        value
                                                            .studListRemarks[
                                                                index]
                                                            .remarks
                                                            .toString(),
                                                        value
                                                            .studListRemarks[
                                                                index]
                                                            .remarksMasterId
                                                            .toString(),
                                                        value
                                                            .studListRemarks[
                                                                index]
                                                            .fileId
                                                            .toString(),
                                                        value
                                                            .studListRemarks[
                                                                index]
                                                            .remarksEntryId
                                                            .toString(),
                                                        value
                                                            .studListRemarks[
                                                                index]
                                                            .remarksEntryDetId
                                                            .toString());
                                                if (value.studListRemarks[index]
                                                        .fileId ==
                                                    null) {
                                                  await Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const NoMarkEntry()));
                                                } else {
                                                  await Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const MarkView()));
                                                }
                                              },
                                              child: const Text(
                                                "View",
                                                style: TextStyle(
                                                  color: UIGuide.light_Purple,
                                                  fontWeight: FontWeight.w900,
                                                  // decoration:
                                                  //     TextDecoration.underline,
                                                  backgroundColor:
                                                      UIGuide.light_black,
                                                  decorationThickness: 1.5,
                                                  decorationStyle:
                                                      TextDecorationStyle.solid,
                                                ),
                                              )),
                                          const SizedBox(
                                            width: 5,
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: SizedBox(
                                        height: 50,
                                        width: size.width,
                                        child: TextField(
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(
                                                255)
                                          ],

                                          // textAlign: TextAlign.center,
                                          //  focusNode: FocusNode(),

                                          controller:
                                              teacherremarkController[index],
                                          enabled: true,
                                          cursorColor: UIGuide.light_Purple,

                                          decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      left: 10),
                                              focusColor: const Color.fromARGB(
                                                  255, 213, 215, 218),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: UIGuide.light_Purple,
                                                    width: 1.0),
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              fillColor: Colors.grey,
                                              hintStyle: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 16,
                                                fontFamily: "verdana_regular",
                                                fontWeight: FontWeight.w400,
                                              ),
                                              labelText: 'Teacher Remarks',
                                              labelStyle: const TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 106, 107, 109))),
                                          onChanged: (value1) {
                                            teacherremarkController[index]
                                                .addListener(() {
                                              value1;
                                            });
                                            teacherremarkController[index]
                                                    .text
                                                    .isEmpty
                                                ? provider
                                                    .studListRemarks[index]
                                                    .remarks = null
                                                : teacherremarkController[index]
                                                    .text;
                                            print(
                                                "***************${teacherremarkController[index].text}");
                                          },
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4),
                                      child: SizedBox(
                                        height: 50,
                                        width: size.width,
                                        child: TextField(
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(
                                                255)
                                          ],

                                          // textAlign: TextAlign.center,
                                          //  focusNode: FocusNode(),

                                          controller:
                                              principalremarkController[index],
                                          enabled: true,
                                          cursorColor: UIGuide.light_Purple,

                                          decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      left: 10),
                                              focusColor: const Color.fromARGB(
                                                  255, 213, 215, 218),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: UIGuide.light_Purple,
                                                    width: 1.0),
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              fillColor: Colors.grey,
                                              hintStyle: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 16,
                                                fontFamily: "verdana_regular",
                                                fontWeight: FontWeight.w400,
                                              ),
                                              labelText: 'Principal Remarks',
                                              labelStyle: const TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 106, 107, 109))),
                                          onChanged: (value2) {
                                            principalremarkController[index]
                                                .addListener(() {
                                              value2;
                                            });
                                            principalremarkController[index]
                                                    .text
                                                    .isEmpty
                                                ? provider
                                                    .studListRemarks[index]
                                                    .principalRemarks = null
                                                : principalremarkController[
                                                        index]
                                                    .text;
                                            print(
                                                "***************${principalremarkController[index].text}");
                                          },
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          })),
                    ),
                  ));
                } else {
                  return const SizedBox(
                    height: 0,
                    width: 0,
                  );
                }
              })
            ]),
            if (value.loading) pleaseWaitLoader()
          ],
        );
      }),
      bottomNavigationBar: BottomAppBar(
        child: Consumer<RemarksEntryProvider>(
          builder: (context, vall, _) => vall.studListRemarks.isEmpty
              ? const SizedBox(
                  height: 0,
                  width: 0,
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    kWidth,
                    const Spacer(),
                    Consumer<RemarksEntryProvider>(
                        builder: (context, value, child) {
                      return value.loadSave
                          ? MaterialButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              onPressed: () {},
                              color: UIGuide.light_Purple,
                              child: const Text(
                                'Saving...',
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          : MaterialButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              onPressed: value.loadDelete
                                  ? null
                                  : () async {
                                      List obj = [];
                                      List remarrkk = [];
                                      obj.clear();
                                      remarrkk.clear();
                                      print(
                                          "---------------${value.studListRemarks.length}");
                                      print(obj.length);
                                      print(value.tabmethod);

                                      try {
                                        if (value.tabmethod == "UAS") {
                                          for (int i = 0;
                                              i < value.studListRemarks.length;
                                              i++) {
                                            obj.add(
                                              {
                                                "rollNo": value
                                                    .studListRemarks[i].rollNo,
                                                "studentId": value
                                                    .studListRemarks[i]
                                                    .studentId,
                                                "name": value
                                                    .studListRemarks[i].name,
                                                "remarks":
                                                    _controllers[i].text.isEmpty
                                                        ? null
                                                        : _controllers[i]
                                                            .text
                                                            .toString(),
                                                "principalRemarks": null,
                                                "remarksMasterId": value
                                                    .studListRemarks[i]
                                                    .remarksMasterId,
                                                "fileId": null,
                                                // "remarksCaption": value.studListRemarks[i].remarksCaption,
                                                "remarksEntryId": value
                                                    .studListRemarks[i]
                                                    .remarksEntryId,
                                                "remarksEntryDetId": value
                                                    .studListRemarks[i]
                                                    .remarksEntryDetId
                                              },
                                            );
                                            remarrkk.add(_controllers[i]
                                                .text
                                                .toString());
                                            print(obj);
                                            print("""""" """""" "");
                                          }

                                          if (remarrkk.isEmpty) {
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
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              content: Text(
                                                "enter remark...!",
                                                textAlign: TextAlign.center,
                                              ),
                                            ));
                                          }
                                        } else if (value.tabmethod == "PBT") {
                                          for (int i = 0;
                                              i < value.studListRemarks.length;
                                              i++) {
                                            obj.add(
                                              {
                                                "rollNo": value
                                                    .studListRemarks[i].rollNo,
                                                "studentId": value
                                                    .studListRemarks[i]
                                                    .studentId,
                                                "name": value
                                                    .studListRemarks[i].name,
                                                "remarks":
                                                    teacherremarkController[i]
                                                            .text
                                                            .isEmpty
                                                        ? null
                                                        : teacherremarkController[
                                                                i]
                                                            .text
                                                            .toString(),
                                                "principalRemarks":
                                                    principalremarkController[i]
                                                            .text
                                                            .isEmpty
                                                        ? null
                                                        : principalremarkController[
                                                                i]
                                                            .text
                                                            .toString(),
                                                "remarksMasterId": value
                                                    .studListRemarks[i]
                                                    .remarksMasterId,
                                                "fileId": null,
                                                "remarksEntryId": value
                                                    .studListRemarks[i]
                                                    .remarksEntryId,
                                                "remarksEntryDetId": value
                                                    .studListRemarks[i]
                                                    .remarksEntryDetId
                                              },
                                            );
                                            remarrkk.add(
                                                teacherremarkController[i]
                                                    .text
                                                    .toString());

                                            print(obj);
                                            print("""""" """""" "");
                                          }

                                          if (remarrkk.isEmpty) {
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
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              content: Text(
                                                "enter remark...!",
                                                textAlign: TextAlign.center,
                                              ),
                                            ));
                                          }
                                        } else {
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
                                              "Something went wrong...!",
                                              textAlign: TextAlign.center,
                                            ),
                                          ));
                                        }

                                        // //log("Litsssss   $obj");
                                      } catch (e) {
                                        print(e);
                                      }

                                      if (remarkEntryDivisionListController
                                              .text.isEmpty &&
                                          remarkEntryInitialValuesController
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
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                          ),
                                          duration: Duration(seconds: 2),
                                          margin: EdgeInsets.only(
                                              bottom: 80, left: 30, right: 30),
                                          behavior: SnackBarBehavior.floating,
                                          content: Text(
                                            "Please enter remark",
                                            textAlign: TextAlign.center,
                                          ),
                                        ));
                                      } else {
                                        value.loadSave
                                            ? spinkitLoader()
                                            : await value.remarkEntrySave(
                                                courseId,
                                                divisionId,
                                                categoryId,
                                                termId,
                                                assessmentId,
                                                value.isTerminated,
                                                category == "Assessment"
                                                    ? true
                                                    : false,
                                                category == "Final"
                                                    ? false
                                                    : true,
                                                value.tabmethod.toString(),
                                                context,
                                                obj,
                                              );
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

                    Consumer<RemarksEntryProvider>(
                        builder: (context, value, child) {
                      return value.loadDelete
                          ? MaterialButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              onPressed: () {},
                              color: Colors.red,
                              child: const Text(
                                'Deleting...',
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          : MaterialButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              onPressed: value.loadSave
                                  ? null
                                  : () {
                                      value.loadDelete;

                                      showDialog(
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
                                                        value.setLoadDelete(
                                                            false);
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
                                                      if (remarkEntryDivisionListController
                                                              .text.isEmpty &&
                                                          remarkEntryInitialValuesController
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
                                                      } else {
                                                        value.loadDelete
                                                            ? spinkitLoader()
                                                            : await value.remarkEntryDelete(
                                                                remarkEntryInitialValuesController
                                                                    .text
                                                                    .toString(),
                                                                remarkEntryDivisionListController
                                                                    .text
                                                                    .toString(),
                                                                remarkEntryCategoryController
                                                                    .text
                                                                    .toString(),
                                                                remarkEntryTermController1
                                                                    .text
                                                                    .toString(),
                                                                remarkEntryAssessmentListController1
                                                                    .text
                                                                    .toString(),
                                                                value
                                                                    .isTerminated,
                                                                value
                                                                    .studListRemarks[
                                                                        0]
                                                                    .remarksEntryId
                                                                    .toString(),
                                                                value.tabmethod
                                                                    .toString(),
                                                                context);
                                                      }

                                                      Navigator.pop(context);
                                                      // value.setLoadDelete(false);
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
      ),
    );
  }
}

class NoMarkEntry extends StatelessWidget {
  const NoMarkEntry({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mark List'),
        titleSpacing: 00.0,
        centerTitle: true,
        toolbarHeight: 50.2,
        toolbarOpacity: 0.8,
        backgroundColor: UIGuide.light_Purple,
      ),
      body: Center(
        child: LottieBuilder.network(
            'https://assets2.lottiefiles.com/private_files/lf30_lkquf6qz.json'),
      ),
    );
  }
}

class MarkView extends StatefulWidget {
  const MarkView({Key? key}) : super(key: key);
  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
  }

  @override
  State<MarkView> createState() => _MarkViewState();
}

class _MarkViewState extends State<MarkView> {
  final ReceivePort _port = ReceivePort();
  @override
  void initState() {
    super.initState();

    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];

      setState(() {});
    });

    FlutterDownloader.registerCallback(downloadCallback);
  }

  static void downloadCallback(String id, int status, int progress) {
    print('Download task ($id) is in status ($status) and $progress% complete');
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  Future<void> requestDownload(String url, String name) async {
    final dir = await getExternalStorageDirectory();
    String? localPath;
    if (Platform.isAndroid) {
      localPath = '/storage/emulated/0/Download';
    } else if (Platform.isIOS) {
      final dir = await getExternalStorageDirectory();
      localPath = dir!.path;
    }
    print("pathhhh  $localPath");
    final savedDir = Directory(localPath!);
    await savedDir.create(recursive: true).then((value) async {
      String? taskid = await FlutterDownloader.enqueue(
        savedDir: localPath!,
        url: url,
        fileName: "Mark List $name.pdf",
        showNotification: true,
        openFileFromNotification: true,
      );
      log("nweurlll $url");

      print(taskid);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RemarksEntryProvider>(
      builder: (context, value, child) => Scaffold(
          appBar: AppBar(
            title: const Text('Mark List'),
            titleSpacing: 00.0,
            centerTitle: true,
            toolbarHeight: 50.2,
            toolbarOpacity: 0.8,
            backgroundColor: UIGuide.light_Purple,
            actions: [
              Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: IconButton(
                      onPressed: () async {
                        await requestDownload(
                          value.url == null ? '--' : value.url.toString(),
                          value.id == null
                              ? '---'
                              : value.name.toString() + value.id.toString(),
                        );
                      },
                      icon: const Icon(Icons.download_outlined))),
            ],
          ),
          body: SfPdfViewer.network(
            value.url == null ? '--' : value.url.toString(),
          )),
    );
  }
}
