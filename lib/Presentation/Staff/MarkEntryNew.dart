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
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var p = Provider.of<MarkEntryNewProvider>(context, listen: false);
      await p.setLoading(false);
      await p.courseClear();
      await p.divisionClear();
      await p.removeAllpartClear();
      await p.removeAllSubjectClear();
      await p.removeAllOptionSubjectListClear();
      await p.removeAllExamClear();
       p.booleanList.clear();
      await p.clearStudentMEList();
      await p.getMarkEntryInitialValues(context);
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
  String? peAttendance;
  String? ceAttendance;

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
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
            title: Row(
              children: [
                const Spacer(),
                const Text('Mark Entry'),
                const Spacer(),
                Consumer<MarkEntryNewProvider>(
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
                                    builder: (context) =>
                                        const MarkEntryNew()));
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
        body: Consumer<MarkEntryNewProvider>(builder: (context, value, _) {
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
              : Stack(
                  children: [
                    Column(children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          children: [
                            const Spacer(),
                            SizedBox(
                              height: 40,
                              width: MediaQuery.of(context).size.width * 0.48,
                              child: Consumer<MarkEntryNewProvider>(
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
                                                      BorderRadius.circular(
                                                          15)),
                                              child: LimitedBox(
                                                maxHeight: size.height - 300,
                                                child: ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount: snapshot
                                                        .markEntryInitialValues
                                                        .length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return ListTile(
                                                        onTap: snapshot.loading
                                                            ? null
                                                            : () async {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
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
                                                                        courseId,
                                                                        context);
                                                                await value
                                                                    .clearStudentMEList();
                                                              },
                                                        title: Text(
                                                          snapshot
                                                                  .markEntryInitialValues[
                                                                      index]
                                                                  .courseName ??
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
                                    controller:
                                        markEntryInitialValuesController1,
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
                              width: MediaQuery.of(context).size.width * 0.48,
                              child: Consumer<MarkEntryNewProvider>(
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
                                                      BorderRadius.circular(
                                                          15)),
                                              child: LimitedBox(
                                                maxHeight: size.height - 300,
                                                child: ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount: snapshot
                                                        .markEntryDivisionList
                                                        .length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return ListTile(
                                                        selectedTileColor:
                                                            Colors
                                                                .blue.shade100,
                                                        onTap: snapshot.loading
                                                            ? null
                                                            : () async {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();

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
                                                                        divisionId,
                                                                        context);
                                                                await value
                                                                    .clearStudentMEList();
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
                                    controller:
                                        markEntryDivisionListController1,
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
                                      labelText: "  Select Division",
                                      hintText: "Division",
                                    ),
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
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          children: [
                            const Spacer(),
                            SizedBox(
                              height: 40,
                              width: MediaQuery.of(context).size.width * 0.48,
                              child: Consumer<MarkEntryNewProvider>(
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
                                                      BorderRadius.circular(
                                                          15)),
                                              child: LimitedBox(
                                                maxHeight: size.height - 300,
                                                child: ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount: snapshot
                                                        .markEntryPartList
                                                        .length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return ListTile(
                                                        selectedTileColor:
                                                            Colors
                                                                .blue.shade100,
                                                        onTap: snapshot.loading
                                                            ? null
                                                            : () async {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();

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
                                                                    .markEntryPartList[
                                                                        index]
                                                                    .toJson();
                                                                print(
                                                                    partItems);

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
                                                                        partId,
                                                                        context);
                                                                await value
                                                                    .clearStudentMEList();
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
                                    controller: markEntryPartListController1,
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
                                      labelText: "  Select Part",
                                      hintText: "Part",
                                    ),
                                    enabled: false,
                                  ),
                                );
                              }),
                            ),
                            const Spacer(),
                            SizedBox(
                              height: 40,
                              width: MediaQuery.of(context).size.width * 0.48,
                              child: Consumer<MarkEntryNewProvider>(
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
                                                      BorderRadius.circular(
                                                          15)),
                                              child: LimitedBox(
                                                maxHeight: size.height - 300,
                                                child: ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount: snapshot
                                                        .markEntrySubjectList
                                                        .length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return ListTile(
                                                        selectedTileColor:
                                                            Colors
                                                                .blue.shade100,
                                                        onTap: snapshot.loading
                                                            ? null
                                                            : () async {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();

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
                                                                subsubject =
                                                                    null;
                                                                optionSub =
                                                                    null;
                                                                subDescription =
                                                                    null;

                                                                await snapshot
                                                                    .getMarkEntryOptionSubject(
                                                                        subjectId,
                                                                        divisionId,
                                                                        partId,
                                                                        context);
                                                                if (snapshot
                                                                        .markEntryOptionSubjectList
                                                                        .isEmpty ||
                                                                    snapshot.markEntryOptionSubjectList ==
                                                                        null) {
                                                                  await snapshot.getMarkEntryExamValues(
                                                                      subjectId,
                                                                      divisionId,
                                                                      partId,
                                                                      markEntryOptionSubListController1
                                                                          .text,
                                                                      context);
                                                                }

                                                                await value
                                                                    .clearStudentMEList();
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
                                    controller: markEntrySubjectListController1,
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
                                      labelText: "  Select Subject",
                                      hintText: "Subject",
                                    ),
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
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          children: [
                            //  Spacer(),
                            Consumer<MarkEntryNewProvider>(
                              builder: (context, snapshot, child) {
                                if (snapshot
                                        .markEntryOptionSubjectList.isEmpty ||
                                    snapshot.markEntryOptionSubjectList ==
                                        null) {
                                  return const SizedBox(
                                    height: 0,
                                    width: 0,
                                  );
                                }
                                return SizedBox(
                                    height: 40,
                                    width: MediaQuery.of(context).size.width *
                                        0.488,
                                    child: ElevatedButton(
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
                                                                Colors.blue
                                                                    .shade100,
                                                            onTap: () async {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();

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
                                                              markEntryExamListController
                                                                  .clear();
                                                              markEntryExamListController1
                                                                  .clear();
                                                              await snapshot
                                                                  .removeAllExamClear();
                                                              String descr = '';
                                                              descr = snapshot
                                                                      .markEntryOptionSubjectList
                                                                      .isEmpty
                                                                  ? ""
                                                                  : snapshot.markEntryOptionSubjectList[0]
                                                                              .subjectDescription ==
                                                                          "Sub Subject"
                                                                      ? "subSubject"
                                                                      : "optionSubject";
                                                              await snapshot
                                                                  .getMarkEntryExamValuesOPtion(
                                                                      subjectId,
                                                                      divisionId,
                                                                      partId,
                                                                      markEntryOptionSubListController1
                                                                          .text,
                                                                      descr,
                                                                      context);
                                                              print(subsubject);
                                                              await value
                                                                  .clearStudentMEList();
                                                            },
                                                            title: Text(
                                                              snapshot
                                                                      .markEntryOptionSubjectList[
                                                                          index]
                                                                      .subjectName ??
                                                                  '--',
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
                                        controller:
                                            markEntryOptionSubListController,
                                        decoration: InputDecoration(
                                          filled: true,
                                          contentPadding: const EdgeInsets.only(
                                              left: 0, top: 0),
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.never,
                                          fillColor: Colors.transparent,
                                          border: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                style: BorderStyle.none,
                                                width: 0),
                                          ),
                                          labelText: snapshot
                                                  .markEntryOptionSubjectList
                                                  .isEmpty
                                              ? ""
                                              : snapshot.markEntryOptionSubjectList[0]
                                                          .subjectDescription ==
                                                      "Sub Subject"
                                                  ? "  Select Sub Subject"
                                                  : "  Select Option Subject",
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
                                    ));
                              },
                            ),
                            const Spacer(),
                            SizedBox(
                              height: 40,
                              width: MediaQuery.of(context).size.width * 0.48,
                              child: Consumer<MarkEntryNewProvider>(
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
                                                      BorderRadius.circular(
                                                          15)),
                                              child: LimitedBox(
                                                maxHeight: size.height - 300,
                                                child: ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount: snapshot
                                                        .markEntryExamList
                                                        .length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return ListTile(
                                                        selectedTileColor:
                                                            Colors
                                                                .blue.shade100,
                                                        onTap: () async {
                                                          Navigator.of(context)
                                                              .pop();
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
                                                          await value
                                                              .clearStudentMEList();
                                                        },
                                                        title: Text(
                                                          snapshot
                                                                  .markEntryExamList[
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
                                    controller: markEntryExamListController,
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
                                      labelText: "  Select Exam",
                                      hintText: "Exam",
                                    ),
                                    enabled: false,
                                  ),
                                );
                              }),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: InkWell(
                                onTap: () async {
                                  await value.clearStudentMEList();
                                  await value.terminatedCheckbox();
                                },
                                child: Row(
                                  children: [
                                    Checkbox(
                                      activeColor: UIGuide.light_Purple,
                                      value: value.isTerminated,
                                      onChanged: (newValue) async {
                                        await value.clearStudentMEList();
                                        await value.terminatedCheckbox();
                                        // setState(() {
                                        //   value.isTerminated = newValue!;
                                        // });
                                      },
                                    ),
                                    const Expanded(
                                      //   width: size.width * .35,
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
                          kWidth,
                          value.loading
                              ? Expanded(
                                  //  width: size.width * .46,
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
                              : Expanded(
                                  child: MaterialButton(
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0))),
                                    color: UIGuide.light_Purple,
                                    onPressed: (() async {
                                      date = DateFormat('yyyy-MM-dd')
                                          .format(DateTime.now());
                                      print(DateFormat('yyyy-MM-dd')
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
                                      value.booleanList.clear();

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
                          const SizedBox(
                            width: 6,
                          ),
                        ],
                      ),
                      value.examStatusUAS == "Verified"
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Verified By :",
                                    style: TextStyle(
                                        color: Colors.green, fontSize: 13)),
                                Text(value.staffNameUAS ?? "--",
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 13))
                              ],
                            )
                          : const SizedBox(
                              height: 0,
                              width: 0,
                            ),
                      Consumer<MarkEntryNewProvider>(
                          builder: (context, provider, _) {
                        // if (provider.loading) {
                        //   return LimitedBox(
                        //     maxHeight: size.height / 1.81,
                        //     child: spinkitLoader(),
                        //   );
                        // } else
                        if (provider.isBlockedUAS == true) {
                          return LimitedBox(
                              maxHeight: size.height / 1.81,
                              child: const Center(
                                child: Text(
                                  "MarkEntry Blocked",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ));
                        }
                        ////-----------    ----------    ---------    ----------    ---------     ----------    ---------
                        ////-----------    ----------          Mark  Entry --[ UAS ]--     -----------        -----------
                        ////-----------    ----------    ---------    ----------    ---------     ----------    ---------

                        else if (provider.tabulationTypeCode == "UAS" &&
                            provider.teCaptionUAS == "Mark") {
                          maxScrore = double.parse(provider.teMax.toString());
                          return Expanded(
                              // maxHeight: size.height / 1.81,
                              child: Scrollbar(
                            thickness: 5,
                            controller: _scrollController,
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
                                        ? _controllers[index].text = provider
                                                    .studListUAS[index]
                                                    .teMark ==
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
                                              padding:
                                                  const EdgeInsets.all(4.0),
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
                                                              .studListUAS[
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
                                                          if (provider
                                                                  .studListUAS[
                                                                      index]
                                                                  .attendance ==
                                                              'A') {
                                                            provider
                                                                .studListUAS[
                                                                    index]
                                                                .attendance = 'P';
                                                          } else {
                                                            provider
                                                                .studListUAS[
                                                                    index]
                                                                .attendance = 'A';
                                                            provider
                                                                .studListUAS[
                                                                    index]
                                                                .teMark = null;
                                                            _controllers[index]
                                                                .clear();
                                                          }
                                                          attendancee = provider
                                                              .studListUAS[
                                                                  index]
                                                              .attendance;

                                                          print(
                                                              "attendaceeeee   $attendancee");
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
                                                            child: provider
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
                                                        // textAlign: TextAlign.center,
                                                        //  focusNode: FocusNode(),
                                                        textInputAction:
                                                            TextInputAction
                                                                .next,
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
                                                        cursorColor: UIGuide
                                                            .light_Purple,
                                                        keyboardType:
                                                            const TextInputType
                                                                .numberWithOptions(
                                                                decimal: true),
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
                                                                focusColor: const Color
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
                                                                  .text
                                                                  .isEmpty
                                                              ? provider
                                                                  .studListUAS[
                                                                      index]
                                                                  .teMark = null
                                                              : _controllers[
                                                                      index]
                                                                  .text;
                                                          print(
                                                              "***************${_controllers[index].text}");

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
                                                          String resultt =
                                                              _controllers[
                                                                      index]
                                                                  .text;
                                                          provider
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
                            ),
                          ));
                        }

                        ////-----------    ----------    ---------    ----------    ---------     ----------    ---------
                        ////-----------    ----------          Grade Entry --- UAS         -----------        -----------
                        ////-----------    ----------    ---------    ----------    ---------     ----------    ---------

                        else if ((provider.tabulationTypeCode == "UAS") &&
                            provider.teCaptionUAS == "Grade") {
                          return Expanded(
                              child: Scrollbar(
                            thickness: 5,
                            controller: _scrollController,
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
                                        ? gradeListController1[index]
                                            .text = provider.studListUAS[index]
                                                    .teGrade ==
                                                null
                                            ? gradeListController1[index].text
                                            : provider
                                                .studListUAS[index].teGrade
                                                .toString()
                                        : gradeListController1[index].text;
                                    gradeListController[index].text.isEmpty
                                        ? gradeListController[index]
                                            .text = provider.studListUAS[index]
                                                    .teGrade ==
                                                null
                                            ? gradeListController[index].text
                                            : provider
                                                .studListUAS[index].teGrade
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
                                                              .studListUAS[
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
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return Dialog(
                                                                      shape: RoundedRectangleBorder(
                                                                          borderRadius: BorderRadius.circular(
                                                                              15)),
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
                                                                                selectedTileColor: Colors.blue.shade100,
                                                                                onTap: () {
                                                                                  gradeListController[index].text = snapshot.gradeListUAS[indx].text ?? '--';
                                                                                  gradeListController1[index].text = snapshot.gradeListUAS[indx].value ?? '--';
                                                                                  provider.studListUAS[index].teGrade = gradeListController1[index].text;
                                                                                  //     provider.studListUAS[index].teGrade = gradeListController[index].text;
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
                                                                        width:
                                                                            1),
                                                                  ),
                                                                  child:
                                                                      TextField(
                                                                    textInputAction:
                                                                        TextInputAction
                                                                            .next,
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
                                                                          " Select ",
                                                                      hintText:
                                                                          "grade",
                                                                    ),
                                                                    enabled:
                                                                        false,
                                                                    onChanged:
                                                                        (value1) {
                                                                      gradeListController1[index].text = provider
                                                                          .studListUAS[
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
                            ),
                          ));
                        }

                        ////-----------    ----------    ---------    ----------    ---------     ----------    ---------
                        ////-----------    ---------- PUBLIC TABULATION  -- Grade Entry      -----------        ---------
                        ////-----------    ----------    ---------    ----------    ---------     ----------    ---------

                        else if (provider.tabulationTypeCode == "PBT" &&
                            provider.teCaptionUAS == "Grade") {
                          return Expanded(
                              // maxHeight: size.height / 1.81,
                              child: Scrollbar(
                            thickness: 5,
                            controller: _scrollController,
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
                                        ? publicGradeController1[index]
                                            .text = provider.studListUAS[index]
                                                    .teGrade ==
                                                null
                                            ? publicGradeController1[index].text
                                            : provider
                                                .studListUAS[index].teGrade
                                                .toString()
                                        : publicGradeController1[index].text;
                                    publicGradeController[index].text.isEmpty
                                        ? publicGradeController[index]
                                            .text = provider.studListUAS[index]
                                                    .teGrade ==
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
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: 80,
                                                    child: Text(
                                                      'Roll No: ${provider.studListUAS[index].rollNo == null ? '' : provider.studListUAS[index].rollNo.toString()}',
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
                                                        text: provider
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
                                                        '${value.teCaptionUAS ?? ""} : ',
                                                        overflow: TextOverflow
                                                            .ellipsis,
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
                                                                        shape: RoundedRectangleBorder(
                                                                            borderRadius: BorderRadius.circular(
                                                                                15)),
                                                                        child:
                                                                            LimitedBox(
                                                                          maxHeight:
                                                                              size.height / 2,
                                                                          child: ListView.builder(
                                                                              shrinkWrap: true,
                                                                              itemCount: snapshot.gradeListUAS.length,
                                                                              itemBuilder: (context, indx) {
                                                                                return ListTile(
                                                                                  selectedTileColor: Colors.blue.shade100,
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
                                                                          width:
                                                                              1),
                                                                    ),
                                                                    child:
                                                                        TextField(
                                                                      textInputAction:
                                                                          TextInputAction
                                                                              .next,
                                                                      enabled: provider.studListUAS[index].attendance == 'A' ||
                                                                              value.examStatusUAS == 'Synchronized'
                                                                          ? true
                                                                          : false,
                                                                      readOnly:
                                                                          true,
                                                                      style: const TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          color: UIGuide
                                                                              .BLACK,
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
                                                                            " Select ",
                                                                        hintText:
                                                                            "grade",
                                                                      ),
                                                                      onChanged:
                                                                          (value1) {
                                                                        publicGradeController1[index].text = provider
                                                                            .studListUAS[index]
                                                                            .teGrade
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
                            ),
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
                            return Expanded(
                                // maxHeight: size.height / 1.81,
                                child: Scrollbar(
                              thickness: 5,
                              controller: _scrollController,
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
                                            ? teMarkController[index]
                                                .text = value.studListUAS[index]
                                                        .teMark ==
                                                    null
                                                ? teMarkController[index].text
                                                : value
                                                    .studListUAS[index].teMark
                                                    .toString()
                                            : teMarkController[index].text;
                                        practicalMarkController[index]
                                                .text
                                                .isEmpty
                                            ? practicalMarkController[index]
                                                .text = value.studListUAS[index]
                                                        .peMark ==
                                                    null
                                                ? practicalMarkController[index]
                                                    .text
                                                : value
                                                    .studListUAS[index].peMark
                                                    .toString()
                                            : practicalMarkController[index]
                                                .text;
                                        ceMarkController[index].text.isEmpty
                                            ? ceMarkController[index]
                                                .text = value.studListUAS[index]
                                                        .ceMark ==
                                                    null
                                                ? ceMarkController[index].text
                                                : value
                                                    .studListUAS[index].ceMark
                                                    .toString()
                                            : ceMarkController[index].text;

                                        print('fn called------------ffff');

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
                                                              '',
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
                                                            value.booleanList[index]=true;
                                                            print("ssassasasasasasaasaa");
                                                            print(value.booleanList);

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

                                                                value.existCeAttendance==false?
                                                                value
                                                                    .studListUAS[
                                                                        index]
                                                                    .ceMark = null:"";
                                                                value.existPeAttendance==false?
                                                                value
                                                                    .studListUAS[
                                                                        index]
                                                                    .peMark = null:"";
                                                                teMarkController[
                                                                        index]
                                                                    .clear();
                                                                value.existPeAttendance==false?
                                                                practicalMarkController[
                                                                        index]
                                                                    .clear():"";
                                                                value.existCeAttendance==false?
                                                                ceMarkController[
                                                                        index]
                                                                    .clear():"";
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
                                                            color: Colors
                                                                .transparent,
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

                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: SizedBox(
                                                          height: 30,
                                                          width: 80,
                                                          child: TextField(
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
                                                                ? false
                                                                : true,
                                                            cursorColor: UIGuide
                                                                .light_Purple,
                                                            keyboardType:
                                                                const TextInputType
                                                                    .numberWithOptions(
                                                                    decimal:
                                                                        true),
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
                                                                    labelText:
                                                                        value.teCaptionUAS ??
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
                                                                  .addListener(
                                                                      () {
                                                                value1;
                                                              });

                                                              teMarkController[
                                                                          index]
                                                                      .text
                                                                      .isEmpty
                                                                  ? value
                                                                          .studListUAS[
                                                                              index]
                                                                          .teMark =
                                                                      null
                                                                  : teMarkController[
                                                                          index]
                                                                      .text;

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
                                                              value.booleanList[index]=true;
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
                                                              "(${value.teMax})",
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 15,
                                                              ),
                                                            ))),
                                                      ),
                                                      kWidth,
                                                      value.existPeAttendance==false ?
                                                          SizedBox(height: 0,width: 0,):
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets.only(
                                                            left: 10.0),
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              value.booleanList[index]=true;
                                                              if (value
                                                                  .studListUAS[
                                                              index]
                                                                  .peAttendance ==
                                                                  'A') {
                                                                value
                                                                    .studListUAS[
                                                                index]
                                                                    .peAttendance = 'P';
                                                              } else {
                                                                value
                                                                    .studListUAS[
                                                                index]
                                                                    .peAttendance = 'A';
                                                                value
                                                                    .studListUAS[
                                                                index]
                                                                    .peMark = null;

                                                                practicalMarkController[
                                                                index]
                                                                    .clear();

                                                              }
                                                              peAttendance = value
                                                                  .studListUAS[
                                                              index]
                                                                  .peAttendance;

                                                              print(
                                                                  "peattendace   $peAttendance");
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
                                                                child: value.studListUAS[index].peAttendance ==
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
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: SizedBox(
                                                          height: 30,
                                                          width: 80,
                                                          child: TextField(
                                                            textInputAction:
                                                                TextInputAction
                                                                    .next,
                                                            controller:
                                                                practicalMarkController[
                                                                    index],
                                                            //  focusNode: FocusNode(),
                                                            enabled: value.existPeAttendance==true?
                                                            value
                                                                .studListUAS[
                                                            index]
                                                                .peAttendance ==
                                                                'A' ||
                                                                value.examStatusUAS ==
                                                                    'Synchronized'
                                                                ? false
                                                                : true
                                                                :
                                                            value
                                                                .studListUAS[
                                                            index]
                                                                .attendance ==
                                                                'A' ||
                                                                value.examStatusUAS ==
                                                                    'Synchronized' ? false
                                                                : true,
                                                            cursorColor: UIGuide
                                                                .light_Purple,
                                                            keyboardType:
                                                                const TextInputType
                                                                    .numberWithOptions(
                                                                    decimal:
                                                                        true),
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
                                                                    labelText:
                                                                        value.peCaptionUAS ??
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
                                                                  .addListener(
                                                                      () {
                                                                value1;
                                                              });

                                                              practicalMarkController[index]
                                                                      .text
                                                                      .isEmpty
                                                                  ? value
                                                                          .studListUAS[
                                                                              index]
                                                                          .peMark =
                                                                      null
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
                                                                  double.parse(
                                                                      provider
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
                                                              value.booleanList[index]=true;
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
                                                    // const SizedBox(
                                                    //   width: 58,
                                                    // ),
                                                    value.existCeAttendance==false ?
                                                    SizedBox(height: 0,width: 38,):
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.only(
                                                          left: 10.0),
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            value.booleanList[index]=true;
                                                            if (value
                                                                .studListUAS[
                                                            index]
                                                                .ceAttendance ==
                                                                'A') {
                                                              value
                                                                  .studListUAS[
                                                              index]
                                                                  .ceAttendance = 'P';
                                                            } else {
                                                              value
                                                                  .studListUAS[
                                                              index]
                                                                  .ceAttendance = 'A';
                                                              value
                                                                  .studListUAS[
                                                              index]
                                                                  .ceMark = null;

                                                              ceMarkController[
                                                              index]
                                                                  .clear();

                                                            }
                                                            ceAttendance = value
                                                                .studListUAS[
                                                            index]
                                                                .ceAttendance;

                                                            print(
                                                                "ceattendace   $ceAttendance");
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
                                                              child: value.studListUAS[index].ceAttendance ==
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

                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: SizedBox(
                                                        height: 30,
                                                        width: 80,
                                                        child: TextField(
                                                          textInputAction:
                                                              TextInputAction
                                                                  .next,
                                                          controller:
                                                              ceMarkController[
                                                                  index],
                                                          //   focusNode: FocusNode(),
                                                          enabled: value.existCeAttendance==true?
                                                          value
                                                              .studListUAS[
                                                          index]
                                                              .ceAttendance ==
                                                              'A' ||
                                                              value.examStatusUAS ==
                                                                  'Synchronized'
                                                              ? false
                                                              : true
                                                              :
                                                          value
                                                              .studListUAS[
                                                          index]
                                                              .attendance ==
                                                              'A' ||
                                                              value.examStatusUAS ==
                                                                  'Synchronized' ? false
                                                              : true,
                                                          cursorColor: UIGuide
                                                              .light_Purple,
                                                          keyboardType:
                                                              const TextInputType
                                                                  .numberWithOptions(
                                                                  decimal:
                                                                      true),
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
                                                                  focusColor: const Color
                                                                      .fromARGB(
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
                                                                  labelText:
                                                                      value.ceCaptionUAS ??
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
                                                                .addListener(
                                                                    () {
                                                              value1;
                                                            });

                                                            ceMarkController[
                                                                        index]
                                                                    .text
                                                                    .isEmpty
                                                                ? value
                                                                        .studListUAS[
                                                                            index]
                                                                        .ceMark =
                                                                    null
                                                                : ceMarkController[
                                                                        index]
                                                                    .text;
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
                                                                double.parse(
                                                                    provider
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
                                                            value
                                                                    .studListUAS[
                                                                        index]
                                                                    .ceMark =
                                                                double.tryParse(
                                                                    resultt);
                                                            value.booleanList[index]=true;
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
                              ),
                            ));
                          }

                          ///////////////----------------------------------------------------------------------///////////////
                          //////////////--------------------------     TE MARK  --  PE MARK -------------------///////////////
                          ///////////////----------------------------------------------------------------------///////////////

                          else if (provider.teMax != null &&
                              provider.peMax != null &&
                              provider.ceMax == null) {
                            return Expanded(
                                // maxHeight: size.height / 1.81,
                                child: Scrollbar(
                              thickness: 5,
                              controller: _scrollController,
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
                                          ? teMarkController[index].text = value
                                                      .studListUAS[index]
                                                      .teMark ==
                                                  null
                                              ? teMarkController[index].text
                                              : value.studListUAS[index].teMark
                                                  .toString()
                                          : teMarkController[index].text;
                                      practicalMarkController[index]
                                              .text
                                              .isEmpty
                                          ? practicalMarkController[index]
                                              .text = value.studListUAS[index]
                                                      .peMark ==
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
                                                            '',
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
                                                          value.booleanList[index]=true;
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

                                                              value.existPeAttendance==false?
                                                              value.studListUAS[
                                                              index]
                                                                  .teMark = null:"";

                                                              value.existPeAttendance==false?
                                                              teMarkController[
                                                              index]
                                                                  .clear():"";

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
                                                          color: Colors
                                                              .transparent,
                                                          width: 28,
                                                          height: 26,
                                                          child: SizedBox(
                                                              width: 28,
                                                              height: 26,
                                                              child: value.studListUAS[index].attendance ==
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

                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: SizedBox(
                                                        height: 30,
                                                        width: 80,
                                                        child: TextField(
                                                          textInputAction:
                                                              TextInputAction
                                                                  .next,
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
                                                              ? false
                                                              : true,
                                                          cursorColor: UIGuide
                                                              .light_Purple,
                                                          keyboardType:
                                                              const TextInputType
                                                                  .numberWithOptions(
                                                                  decimal:
                                                                      true),
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
                                                                  focusColor: const Color
                                                                      .fromARGB(
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
                                                                  labelText:
                                                                      value.teCaptionUAS ??
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
                                                                .addListener(
                                                                    () {
                                                              value1;
                                                            });

                                                            teMarkController[
                                                                        index]
                                                                    .text
                                                                    .isEmpty
                                                                ? value
                                                                        .studListUAS[
                                                                            index]
                                                                        .teMark =
                                                                    null
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
                                                            value.booleanList[index]=true;
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
                                                    value.existPeAttendance==false ?
                                                    SizedBox(height: 0,width: 0,):
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.only(
                                                          left: 10.0),
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          value.booleanList[index]=true;
                                                          setState(() {
                                                            if (value
                                                                .studListUAS[
                                                            index]
                                                                .peAttendance ==
                                                                'A') {
                                                              value
                                                                  .studListUAS[
                                                              index]
                                                                  .peAttendance = 'P';
                                                            } else {
                                                              value
                                                                  .studListUAS[
                                                              index]
                                                                  .peAttendance = 'A';
                                                              value
                                                                  .studListUAS[
                                                              index]
                                                                  .peMark = null;

                                                              practicalMarkController[
                                                              index]
                                                                  .clear();

                                                            }
                                                            peAttendance = value
                                                                .studListUAS[
                                                            index]
                                                                .peAttendance;

                                                            print(
                                                                "peattendace   $peAttendance");
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
                                                              child: value.studListUAS[index].peAttendance ==
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
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: SizedBox(
                                                        height: 30,
                                                        width: 80,
                                                        child: TextField(
                                                          textInputAction:
                                                              TextInputAction
                                                                  .next,
                                                          controller:
                                                              practicalMarkController[
                                                                  index],
                                                          //  focusNode: FocusNode(),
                                                          enabled:  value.existPeAttendance==true?
                                                          value
                                                              .studListUAS[
                                                          index]
                                                              .peAttendance ==
                                                              'A' ||
                                                              value.examStatusUAS ==
                                                                  'Synchronized'
                                                              ? false
                                                              : true
                                                              :
                                                          value
                                                              .studListUAS[
                                                          index]
                                                              .attendance ==
                                                              'A' ||
                                                              value.examStatusUAS ==
                                                                  'Synchronized' ? false
                                                              : true,
                                                          cursorColor: UIGuide
                                                              .light_Purple,
                                                          keyboardType:
                                                              const TextInputType
                                                                  .numberWithOptions(
                                                                  decimal:
                                                                      true),
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
                                                                  focusColor: const Color
                                                                      .fromARGB(
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
                                                                  labelText:
                                                                      value.peCaptionUAS ??
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
                                                                .addListener(
                                                                    () {
                                                              value1;
                                                            });

                                                            practicalMarkController[index]
                                                                    .text
                                                                    .isEmpty
                                                                ? value
                                                                        .studListUAS[
                                                                            index]
                                                                        .peMark =
                                                                    null
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
                                                                double.parse(
                                                                    provider
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
                                                            value.booleanList[index]=true;
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
                                            ],
                                          ),
                                        ),
                                      );
                                    })),
                              ),
                            ));
                          }

                          ///////////////----------------------------------------------------------------------///////////////
                          //////////////--------------------------     TE MARK  --  CE MARK -------------------///////////////
                          ///////////////----------------------------------------------------------------------///////////////

                          else if (provider.teMax != null &&
                              provider.ceMax != null &&
                              provider.peMax == null) {
                            return Expanded(
                                //  maxHeight: size.height / 1.81,
                                child: Scrollbar(
                              thickness: 5,
                              controller: _scrollController,
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
                                          ? teMarkController[index].text = value
                                                      .studListUAS[index]
                                                      .teMark ==
                                                  null
                                              ? teMarkController[index].text
                                              : value.studListUAS[index].teMark
                                                  .toString()
                                          : teMarkController[index].text;

                                      ceMarkController[index].text.isEmpty
                                          ? ceMarkController[index].text = value
                                                      .studListUAS[index]
                                                      .ceMark ==
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
                                                            '',
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
                                                          value.booleanList[index]=true;
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


                                                              value.existCeAttendance==false?
                                                              value.studListUAS[
                                                              index]
                                                                  .ceMark = null:"";

                                                              value.existCeAttendance==false?
                                                              ceMarkController[
                                                              index]
                                                                  .clear():"";

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
                                                          color: Colors
                                                              .transparent,
                                                          width: 28,
                                                          height: 26,
                                                          child: SizedBox(
                                                              width: 28,
                                                              height: 26,
                                                              child: value.studListUAS[index].attendance ==
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
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: SizedBox(
                                                        height: 30,
                                                        width: 80,
                                                        child: TextField(
                                                          textInputAction:
                                                              TextInputAction
                                                                  .next,
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
                                                              ? false
                                                              : true,
                                                          cursorColor: UIGuide
                                                              .light_Purple,
                                                          keyboardType:
                                                              const TextInputType
                                                                  .numberWithOptions(
                                                                  decimal:
                                                                      true),
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
                                                                  focusColor: const Color
                                                                      .fromARGB(
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
                                                                  labelText:
                                                                      value.teCaptionUAS ??
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
                                                                .addListener(
                                                                    () {
                                                              value1;
                                                            });

                                                            teMarkController[
                                                                        index]
                                                                    .text
                                                                    .isEmpty
                                                                ? value
                                                                        .studListUAS[
                                                                            index]
                                                                        .teMark =
                                                                    null
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
                                                                double.parse(
                                                                    provider
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
                                                            value.booleanList[index]=true;
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
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 15,
                                                            ),
                                                          ))),
                                                    ),
                                                    kWidth,
                                                    value.existCeAttendance==false ?
                                                    SizedBox(height: 0,width: 0,):
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.only(
                                                          left: 10.0),
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          value.booleanList[index]=true;
                                                          setState(() {
                                                            if (value
                                                                .studListUAS[
                                                            index]
                                                                .ceAttendance ==
                                                                'A') {
                                                              value
                                                                  .studListUAS[
                                                              index]
                                                                  .ceAttendance = 'P';
                                                            } else {
                                                              value
                                                                  .studListUAS[
                                                              index]
                                                                  .ceAttendance = 'A';
                                                              value
                                                                  .studListUAS[
                                                              index]
                                                                  .ceMark = null;

                                                              ceMarkController[
                                                              index]
                                                                  .clear();

                                                            }
                                                            ceAttendance = value
                                                                .studListUAS[
                                                            index]
                                                                .ceAttendance;

                                                            print(
                                                                "ceattendace   $ceAttendance");
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
                                                              child: value.studListUAS[index].ceAttendance ==
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
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: SizedBox(
                                                        height: 30,
                                                        width: 80,
                                                        child: TextField(
                                                          textInputAction:
                                                              TextInputAction
                                                                  .next,
                                                          controller:
                                                              ceMarkController[
                                                                  index],
                                                          //   focusNode: FocusNode(),
                                                          enabled:
                                                          value.existCeAttendance==true?
                                                          value
                                                                          .studListUAS[
                                                                              index]
                                                                          .ceAttendance ==
                                                                      'A' ||
                                                                  value.examStatusUAS ==
                                                                      'Synchronized'
                                                              ? false
                                                              : true
                                                          :
                                                          value
                                                              .studListUAS[
                                                          index]
                                                              .attendance ==
                                                              'A' ||
                                                              value.examStatusUAS ==
                                                                  'Synchronized' ? false
                                                              : true
                                                          ,
                                                          cursorColor: UIGuide
                                                              .light_Purple,
                                                          keyboardType:
                                                              const TextInputType
                                                                  .numberWithOptions(
                                                                  decimal:
                                                                      true),
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
                                                                  focusColor: const Color
                                                                      .fromARGB(
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
                                                                  labelText:
                                                                      value.ceCaptionUAS ??
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
                                                                .addListener(
                                                                    () {
                                                              value1;
                                                            });

                                                            ceMarkController[
                                                                        index]
                                                                    .text
                                                                    .isEmpty
                                                                ? value
                                                                        .studListUAS[
                                                                            index]
                                                                        .ceMark =
                                                                    null
                                                                : ceMarkController[
                                                                        index]
                                                                    .text;

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
                                                                double.parse(
                                                                    provider
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
                                                            value
                                                                    .studListUAS[
                                                                        index]
                                                                    .ceMark =
                                                                double.tryParse(
                                                                    resultt);
                                                            value.booleanList[index]=true;
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
                              ),
                            ));
                          }

                          ///////////////----------------------------------------------------------------------///////////////
                          //////////////--------------------------     PE MARK  --  CE MARK -------------------///////////////
                          ///////////////----------------------------------------------------------------------///////////////

                          else if (provider.ceMax != null &&
                              provider.peMax != null &&
                              provider.teMax == null) {
                            return Expanded(
                                //maxHeight: size.height / 1.81,
                                child: Scrollbar(
                              thickness: 5,
                              controller: _scrollController,
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

                                      practicalMarkController[index]
                                              .text
                                              .isEmpty
                                          ? practicalMarkController[index]
                                              .text = value.studListUAS[index]
                                                      .peMark ==
                                                  null
                                              ? practicalMarkController[index]
                                                  .text
                                              : value.studListUAS[index].peMark
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
                                                            '',
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
                                                          value.booleanList[index]=true;
                                                          setState(() {
                                                            if (value
                                                                    .studListUAS[
                                                                        index]
                                                                    .peAttendance ==
                                                                'A') {
                                                              value
                                                                  .studListUAS[
                                                                      index]
                                                                  .peAttendance = 'P';
                                                            } else {
                                                              value
                                                                  .studListUAS[
                                                                      index]
                                                                  .attendance = 'A';

                                                            value.existCeAttendance==false ?value
                                                                  .studListUAS[
                                                                      index]
                                                                  .ceMark = null:"";
                                                              value
                                                                  .studListUAS[
                                                                      index]
                                                                  .peMark = null;
                                                              value.existPeAttendance==false?
                                                              ceMarkController[
                                                                      index]
                                                                  .clear():"";
                                                              practicalMarkController[
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
                                                          color: Colors
                                                              .transparent,
                                                          width: 28,
                                                          height: 26,
                                                          child: SizedBox(
                                                              width: 28,
                                                              height: 26,
                                                              child: value.studListUAS[index].attendance ==
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
                                                              ? false
                                                              : true,
                                                          cursorColor: UIGuide
                                                              .light_Purple,
                                                          keyboardType:
                                                              const TextInputType
                                                                  .numberWithOptions(
                                                                  decimal:
                                                                      true),
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
                                                                  focusColor: const Color
                                                                      .fromARGB(
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
                                                                  labelText:
                                                                      value.peCaptionUAS ??
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
                                                                .addListener(
                                                                    () {
                                                              value1;
                                                            });

                                                            practicalMarkController[index]
                                                                    .text
                                                                    .isEmpty
                                                                ? value
                                                                        .studListUAS[
                                                                            index]
                                                                        .peMark =
                                                                    null
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
                                                                double.parse(
                                                                    provider
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
                                                            value.booleanList[index]=true;
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
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 15,
                                                            ),
                                                          ))),
                                                    ),
                                                    kWidth,
                                                    value.existCeAttendance==false ?
                                                    SizedBox(height: 0,width: 0,):
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.only(
                                                          left: 10.0),
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          value.booleanList[index]=true;
                                                          setState(() {
                                                            if (value
                                                                .studListUAS[
                                                            index]
                                                                .ceAttendance ==
                                                                'A') {
                                                              value
                                                                  .studListUAS[
                                                              index]
                                                                  .ceAttendance = 'P';
                                                            } else {
                                                              value
                                                                  .studListUAS[
                                                              index]
                                                                  .ceAttendance = 'A';
                                                              value
                                                                  .studListUAS[
                                                              index]
                                                                  .ceMark = null;

                                                              ceMarkController[
                                                              index]
                                                                  .clear();

                                                            }
                                                            ceAttendance = value
                                                                .studListUAS[
                                                            index]
                                                                .ceAttendance;

                                                            print(
                                                                "ceattendace   $ceAttendance");
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
                                                              child: value.studListUAS[index].ceAttendance ==
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
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: SizedBox(
                                                        height: 30,
                                                        width: 80,
                                                        child: TextField(
                                                          textInputAction:
                                                              TextInputAction
                                                                  .next,
                                                          controller:
                                                              ceMarkController[
                                                                  index],
                                                          //  focusNode: FocusNode(),
                                                          enabled: value
                                                                          .studListUAS[
                                                                              index]
                                                                          .ceAttendance ==
                                                                      'A' ||
                                                                  value.examStatusUAS ==
                                                                      'Synchronized'
                                                              ? false
                                                              : true,
                                                          cursorColor: UIGuide
                                                              .light_Purple,
                                                          keyboardType:
                                                              const TextInputType
                                                                  .numberWithOptions(
                                                                  decimal:
                                                                      true),
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
                                                                  focusColor: const Color
                                                                      .fromARGB(
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
                                                                  labelText:
                                                                      value.ceCaptionUAS ??
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
                                                                .addListener(
                                                                    () {
                                                              value1;
                                                            });

                                                            ceMarkController[
                                                                        index]
                                                                    .text
                                                                    .isEmpty
                                                                ? value
                                                                        .studListUAS[
                                                                            index]
                                                                        .ceMark =
                                                                    null
                                                                : ceMarkController[
                                                                        index]
                                                                    .text;

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
                                                                double.parse(
                                                                    provider
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
                                                            value
                                                                    .studListUAS[
                                                                        index]
                                                                    .ceMark =
                                                                double.tryParse(
                                                                    resultt);
                                                            value.booleanList[index]=true;
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
                              ),
                            ));
                          }
                          ///////////////----------------------------------------------------------------------///////////////
                          ///////////////-----------------------     TE MARK  --------------------------------///////////////
                          ///////////////--------------------------------------------------------------------///////////////

                          else if (provider.teMax != null &&
                              provider.peMax == null &&
                              provider.ceMax == null) {
                            return Expanded(
                                //  maxHeight: size.height / 1.81,
                                child: Scrollbar(
                              thickness: 5,
                              controller: _scrollController,
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
                                          ? teMarkController[index].text = value
                                                      .studListUAS[index]
                                                      .teMark ==
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
                                                            '',
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
                                                          value.booleanList[index]=true;
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
                                                                .studListUAS[
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
                                                              child: value.studListUAS[index].attendance ==
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
                                                          textInputAction:
                                                              TextInputAction
                                                                  .next,
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
                                                              ? false
                                                              : true,
                                                          cursorColor: UIGuide
                                                              .light_Purple,
                                                          keyboardType:
                                                              const TextInputType
                                                                  .numberWithOptions(
                                                                  decimal:
                                                                      true),
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
                                                                  focusColor: const Color
                                                                      .fromARGB(
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
                                                                  labelText:
                                                                      value.teCaptionUAS ??
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
                                                                .addListener(
                                                                    () {
                                                              value1;
                                                            });

                                                            teMarkController[
                                                                        index]
                                                                    .text
                                                                    .isEmpty
                                                                ? value
                                                                        .studListUAS[
                                                                            index]
                                                                        .teMark =
                                                                    null
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
                                                                double.parse(
                                                                    provider
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
                                                            value.booleanList[index]=true;
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
                              ),
                            ));
                          }
                          ///////////////----------------------------------------------------------------------///////////////
                          ///////////////-----------------------     PE MARK  ---------------------------------///////////////
                          ///////////////----------------------------------------------------------------------///////////////

                          else if (provider.teMax == null &&
                              provider.peMax != null &&
                              provider.ceMax == null) {
                            return Expanded(
                                //  maxHeight: size.height / 1.81,
                                child: Scrollbar(
                              thickness: 5,
                              controller: _scrollController,
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
                                      practicalMarkController[index]
                                              .text
                                              .isEmpty
                                          ? practicalMarkController[index]
                                              .text = value.studListUAS[index]
                                                      .peMark ==
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
                                                            '',
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
                                                          value.booleanList[index]=true;
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
                                                                .studListUAS[
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
                                                              child: value.studListUAS[index].attendance ==
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
                                                              ? false
                                                              : true,
                                                          cursorColor: UIGuide
                                                              .light_Purple,
                                                          keyboardType:
                                                              const TextInputType
                                                                  .numberWithOptions(
                                                                  decimal:
                                                                      true),
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
                                                                  focusColor: const Color
                                                                      .fromARGB(
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
                                                                  labelText:
                                                                      value.peCaptionUAS ??
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
                                                                .addListener(
                                                                    () {
                                                              value1;
                                                            });

                                                            practicalMarkController[index]
                                                                    .text
                                                                    .isEmpty
                                                                ? value
                                                                        .studListUAS[
                                                                            index]
                                                                        .peMark =
                                                                    null
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
                                                                double.parse(
                                                                    provider
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
                                                            value.booleanList[index]=true;
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
                              ),
                            ));
                          }
                          ///////////////----------------------------------------------------------------------///////////////
                          ///////////////-----------------------     CE MARK  ---------------------------------///////////////
                          ///////////////----------------------------------------------------------------------///////////////

                          else if (provider.teMax == null &&
                              provider.peMax == null &&
                              provider.ceMax != null) {
                            return Expanded(
                                //maxHeight: size.height / 1.81,
                                child: Scrollbar(
                              thickness: 5,
                              controller: _scrollController,
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
                                          ? ceMarkController[index].text = value
                                                      .studListUAS[index]
                                                      .ceMark ==
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
                                                            '',
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
                                                          value.booleanList[index]=true;
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
                                                                .studListUAS[
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
                                                              child: value.studListUAS[index].attendance ==
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
                                                          textInputAction:
                                                              TextInputAction
                                                                  .next,
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
                                                              ? false
                                                              : true,
                                                          cursorColor: UIGuide
                                                              .light_Purple,
                                                          keyboardType:
                                                              const TextInputType
                                                                  .numberWithOptions(
                                                                  decimal:
                                                                      true),
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
                                                                  focusColor: const Color
                                                                      .fromARGB(
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
                                                                  labelText:
                                                                      value.ceCaptionUAS ??
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
                                                                .addListener(
                                                                    () {
                                                              value1;
                                                            });

                                                            ceMarkController[
                                                                        index]
                                                                    .text
                                                                    .isEmpty
                                                                ? value
                                                                        .studListUAS[
                                                                            index]
                                                                        .ceMark =
                                                                    null
                                                                : ceMarkController[
                                                                        index]
                                                                    .text;

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
                                                                double.parse(
                                                                    provider
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
                                                            value
                                                                    .studListUAS[
                                                                        index]
                                                                    .ceMark =
                                                                double.tryParse(
                                                                    resultt);
                                                            value.booleanList[index]=true;
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
                              ),
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
                            return Expanded(
                                //  maxHeight: size.height / 1.81,
                                child: Scrollbar(
                              thickness: 5,
                              controller: _scrollController,
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
                                          ? teGradeController1[index]
                                              .text = value.studListUAS[index]
                                                      .teGrade ==
                                                  null
                                              ? teGradeController1[index].text
                                              : value.studListUAS[index].teGrade
                                                  .toString()
                                          : teGradeController1[index].text;
                                      teGradeController[index].text.isEmpty
                                          ? teGradeController[index]
                                              .text = value.studListUAS[index]
                                                      .teGrade ==
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

                                      praticalGradeController1[index]
                                              .text
                                              .isEmpty
                                          ? praticalGradeController1[index]
                                              .text = value.studListUAS[index]
                                                      .peGrade ==
                                                  null
                                              ? praticalGradeController1[index]
                                                  .text
                                              : value.studListUAS[index].peGrade
                                                  .toString()
                                          : praticalGradeController1[index]
                                              .text;
                                      praticalGradeController[index]
                                              .text
                                              .isEmpty
                                          ? praticalGradeController[index]
                                              .text = value.studListUAS[index]
                                                      .peGrade ==
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
                                          ? ceGradeController1[index]
                                              .text = value.studListUAS[index]
                                                      .ceGrade ==
                                                  null
                                              ? ceGradeController1[index].text
                                              : value.studListUAS[index].ceGrade
                                                  .toString()
                                          : ceGradeController1[index].text;
                                      ceGradeController[index].text.isEmpty
                                          ? ceGradeController[index]
                                              .text = value.studListUAS[index]
                                                      .ceGrade ==
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
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 80,
                                                      child: Text(
                                                        'Roll No: ${value.studListUAS[index].rollNo == null ? '' : value.studListUAS[index].rollNo.toString()}',
                                                      ),
                                                    ),
                                                    kWidth,
                                                    kWidth,
                                                    kWidth,
                                                    //  Padding(
                                                    //           padding:
                                                    //               const EdgeInsets
                                                    //                   .only(
                                                    //                   left: 10.0),
                                                    //           child:
                                                    //               GestureDetector(
                                                    //             onTap: () {
                                                    //               setState(() {
                                                    //                 if (value
                                                    //                         .studListUAS[
                                                    //                             index]
                                                    //                         .attendance ==
                                                    //                     'A') {
                                                    //                   value
                                                    //                       .studListUAS[
                                                    //                           index]
                                                    //                       .attendance = 'P';
                                                    //                 } else {
                                                    //                   value
                                                    //                       .studListUAS[
                                                    //                           index]
                                                    //                       .attendance = 'A';

                                                    //                   value
                                                    //                       .studListUAS[
                                                    //                           index]
                                                    //                       .ceGrade = null;
                                                    //                   value
                                                    //                       .studListUAS[
                                                    //                           index]
                                                    //                       .ceGradeId = null;

                                                    //                   ceGradeController[
                                                    //                           index]
                                                    //                       .clear();
                                                    //                   ceGradeController1[
                                                    //                           index]
                                                    //                       .clear();

                                                    //                   value
                                                    //                       .studListUAS[
                                                    //                           index]
                                                    //                       .teGrade = null;
                                                    //                   value
                                                    //                       .studListUAS[
                                                    //                           index]
                                                    //                       .teGradeId = null;

                                                    //                   teGradeController[
                                                    //                           index]
                                                    //                       .clear();
                                                    //                   teGradeController1[
                                                    //                           index]
                                                    //                       .clear();

                                                    //                   value
                                                    //                       .studListUAS[
                                                    //                           index]
                                                    //                       .peGrade = null;
                                                    //                   value
                                                    //                       .studListUAS[
                                                    //                           index]
                                                    //                       .peGradeId = null;

                                                    //                   praticalGradeController[
                                                    //                           index]
                                                    //                       .clear();
                                                    //                   praticalGradeController1[
                                                    //                           index]
                                                    //                       .clear();
                                                    //                 }
                                                    //                 attendancee = value
                                                    //                     .studListUAS[
                                                    //                         index]
                                                    //                     .attendance;

                                                    //                 print(
                                                    //                     "attendace   $attendancee");
                                                    //               });
                                                    //             },
                                                    //             child: Container(
                                                    //               color: Colors
                                                    //                   .transparent,
                                                    //               width: 28,
                                                    //               height: 26,
                                                    //               child: SizedBox(
                                                    //                   width: 28,
                                                    //                   height: 26,
                                                    //                   child: value.studListUAS[index].attendance ==
                                                    //                           'A'
                                                    //                       ? SvgPicture.asset(
                                                    //                           UIGuide
                                                    //                               .absent)
                                                    //                       : SvgPicture.asset(
                                                    //                           UIGuide
                                                    //                               .present)),
                                                    //             ),
                                                    //           ),
                                                    //         ),
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
                                                          '${value.teCaptionUAS ?? ""} : ',
                                                          style:
                                                              const TextStyle(
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
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
                                                                          shape:
                                                                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                                                          child: LimitedBox(
                                                                            maxHeight:
                                                                                size.height / 2,
                                                                            child: ListView.builder(
                                                                                shrinkWrap: true,
                                                                                itemCount: snapshot.gradeListUAS.length,
                                                                                itemBuilder: (context, indx) {
                                                                                  return ListTile(
                                                                                    selectedTileColor: Colors.blue.shade100,
                                                                                    onTap: () {
                                                                                      teGradeController[index].text = snapshot.gradeListUAS[indx].value ?? '--';
                                                                                      teGradeController1[index].text = snapshot.gradeListUAS[indx].value ?? '--';
                                                                                      value.studListUAS[index].teGrade = teGradeController1[index].text;
                                                                                      value.studListUAS[index].teGrade = teGradeController[index].text;
                                                                                      value.studListUAS[index].teGrade = value.studListUAS[index].teGrade;
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
                                                                        textInputAction:
                                                                            TextInputAction.next,
                                                                        enabled: value.studListUAS[index].attendance == 'A' ||
                                                                                value.examStatusUAS == 'Synchronized'
                                                                            ? true
                                                                            : false,
                                                                        readOnly:
                                                                            true,
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            color: UIGuide.BLACK,
                                                                            overflow: TextOverflow.clip),
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
                                                                              "  Select ",
                                                                          hintText:
                                                                              "grade",
                                                                        ),
                                                                        onChanged:
                                                                            (value1) {
                                                                          teGradeController1[index].text = value
                                                                              .studListUAS[index]
                                                                              .teGrade
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
                                                          '${value.ceCaptionUAS ?? ""} : ',
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
                                                                  MarkEntryNewProvider>(
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
                                                                          shape:
                                                                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                                                          child: LimitedBox(
                                                                            maxHeight:
                                                                                size.height / 2,
                                                                            child: ListView.builder(
                                                                                shrinkWrap: true,
                                                                                itemCount: snapshot.gradeListUAS.length,
                                                                                itemBuilder: (context, indx) {
                                                                                  return ListTile(
                                                                                    selectedTileColor: Colors.blue.shade100,
                                                                                    onTap: () {
                                                                                      ceGradeController[index].text = snapshot.gradeListUAS[indx].value ?? '--';
                                                                                      ceGradeController1[index].text = snapshot.gradeListUAS[indx].value ?? '--';
                                                                                      value.studListUAS[index].ceGrade = ceGradeController1[index].text;
                                                                                      value.studListUAS[index].ceGrade = ceGradeController[index].text;
                                                                                      value.studListUAS[index].ceGrade = value.studListUAS[index].ceGrade;
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
                                                                        textInputAction:
                                                                            TextInputAction.next,
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            color: UIGuide.BLACK,
                                                                            overflow: TextOverflow.clip),
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
                                                                              "  Select ",
                                                                          hintText:
                                                                              "grade",
                                                                        ),
                                                                        enabled: value.studListUAS[index].attendance == 'A' ||
                                                                                value.examStatusUAS == 'Synchronized'
                                                                            ? true
                                                                            : false,
                                                                        readOnly:
                                                                            true,
                                                                        onChanged:
                                                                            (value1) {
                                                                          ceGradeController1[index].text = value
                                                                              .studListUAS[index]
                                                                              .ceGrade
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
                                                          '${value.peCaptionUAS ?? ""} : ',
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
                                                                  MarkEntryNewProvider>(
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
                                                                          shape:
                                                                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                                                          child: LimitedBox(
                                                                            maxHeight:
                                                                                size.height / 2,
                                                                            child: ListView.builder(
                                                                                shrinkWrap: true,
                                                                                itemCount: snapshot.gradeListUAS.length,
                                                                                itemBuilder: (context, indx) {
                                                                                  return ListTile(
                                                                                    selectedTileColor: Colors.blue.shade100,
                                                                                    onTap: () {
                                                                                      praticalGradeController[index].text = snapshot.gradeListUAS[indx].value ?? '--';
                                                                                      praticalGradeController1[index].text = snapshot.gradeListUAS[indx].value ?? '--';
                                                                                      value.studListUAS[index].peGrade = praticalGradeController1[index].text;
                                                                                      value.studListUAS[index].peGrade = praticalGradeController[index].text;
                                                                                      value.studListUAS[index].peGrade = value.studListUAS[index].peGrade;
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
                                                                        textInputAction:
                                                                            TextInputAction.next,
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            color: UIGuide.BLACK,
                                                                            overflow: TextOverflow.clip),
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
                                                                              "  Select ",
                                                                          hintText:
                                                                              "grade",
                                                                        ),
                                                                        enabled: value.studListUAS[index].attendance == 'A' ||
                                                                                value.examStatusUAS == 'Synchronized'
                                                                            ? true
                                                                            : false,
                                                                        readOnly:
                                                                            true,
                                                                        onChanged:
                                                                            (value1) {
                                                                          praticalGradeController1[index].text = value
                                                                              .studListUAS[index]
                                                                              .peGrade
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
                              ),
                            ));
                          }

                          ///////////////-------------------------------------------------------------------------------------///////////////
                          ///////////////-----------------------     TE Grade   --  CE Grade  -------------------------------///////////////
                          ///////////////-----------------------------------------------------------------------------------///////////////
                          if (provider.teCaptionUAS != null &&
                              provider.peCaptionUAS == null &&
                              provider.ceCaptionUAS != null) {
                            return Expanded(
                                // maxHeight: size.height / 1.81,
                                child: Scrollbar(
                              thickness: 5,
                              controller: _scrollController,
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
                                          ? teGradeController1[index]
                                              .text = value.studListUAS[index]
                                                      .teGrade ==
                                                  null
                                              ? teGradeController1[index].text
                                              : value.studListUAS[index].teGrade
                                                  .toString()
                                          : teGradeController1[index].text;
                                      teGradeController[index].text.isEmpty
                                          ? teGradeController[index]
                                              .text = value.studListUAS[index]
                                                      .teGrade ==
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
                                          ? ceGradeController1[index]
                                              .text = value.studListUAS[index]
                                                      .ceGrade ==
                                                  null
                                              ? ceGradeController1[index].text
                                              : value.studListUAS[index].ceGrade
                                                  .toString()
                                          : ceGradeController1[index].text;
                                      ceGradeController[index].text.isEmpty
                                          ? ceGradeController[index]
                                              .text = value.studListUAS[index]
                                                      .ceGrade ==
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
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 80,
                                                      child: Text(
                                                        'Roll No: ${value.studListUAS[index].rollNo == null ? '' : value.studListUAS[index].rollNo.toString()}',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                    kWidth,
                                                    kWidth,
                                                    kWidth,
                                                    // value.studListUAS[index]
                                                    //             .isAttendanceDisabled ==
                                                    //         true
                                                    //     ? SizedBox(
                                                    //         height: 0,
                                                    //         width: 0,
                                                    //       )
                                                    //     : Padding(
                                                    //         padding:
                                                    //             const EdgeInsets
                                                    //                 .only(
                                                    //                 left: 10.0),
                                                    //         child:
                                                    //             GestureDetector(
                                                    //           onTap: () {
                                                    //             setState(() {
                                                    //               if (value
                                                    //                       .studListUAS[
                                                    //                           index]
                                                    //                       .attendance ==
                                                    //                   'A') {
                                                    //                 value
                                                    //                     .studListUAS[
                                                    //                         index]
                                                    //                     .attendance = 'P';
                                                    //               } else {
                                                    //                 value
                                                    //                     .studListUAS[
                                                    //                         index]
                                                    //                     .attendance = 'A';

                                                    //                 value
                                                    //                     .studListUAS[
                                                    //                         index]
                                                    //                     .ceGrade = null;
                                                    //                 value
                                                    //                     .studListUAS[
                                                    //                         index]
                                                    //                     .ceGradeId = null;

                                                    //                 ceGradeController[
                                                    //                         index]
                                                    //                     .clear();
                                                    //                 ceGradeController1[
                                                    //                         index]
                                                    //                     .clear();

                                                    //                 value
                                                    //                     .studListUAS[
                                                    //                         index]
                                                    //                     .teGrade = null;
                                                    //                 value
                                                    //                     .studListUAS[
                                                    //                         index]
                                                    //                     .teGradeId = null;

                                                    //                 teGradeController[
                                                    //                         index]
                                                    //                     .clear();
                                                    //                 teGradeController1[
                                                    //                         index]
                                                    //                     .clear();
                                                    //               }
                                                    //               attendancee = value
                                                    //                   .studListUAS[
                                                    //                       index]
                                                    //                   .attendance;

                                                    //               print(
                                                    //                   "attendace   $attendancee");
                                                    //             });
                                                    //           },
                                                    //           child: Container(
                                                    //             color: Colors
                                                    //                 .transparent,
                                                    //             width: 28,
                                                    //             height: 26,
                                                    //             child: SizedBox(
                                                    //                 width: 28,
                                                    //                 height: 26,
                                                    //                 child: value.studListUAS[index].attendance ==
                                                    //                         'A'
                                                    //                     ? SvgPicture.asset(
                                                    //                         UIGuide
                                                    //                             .absent)
                                                    //                     : SvgPicture.asset(
                                                    //                         UIGuide
                                                    //                             .present)),
                                                    //           ),
                                                    //         ),
                                                    //       ),
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
                                                          '${value.teCaptionUAS ?? ""} : ',
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
                                                                  MarkEntryNewProvider>(
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
                                                                          shape:
                                                                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                                                          child: LimitedBox(
                                                                            maxHeight:
                                                                                size.height / 2,
                                                                            child: ListView.builder(
                                                                                shrinkWrap: true,
                                                                                itemCount: snapshot.gradeListUAS.length,
                                                                                itemBuilder: (context, indx) {
                                                                                  return ListTile(
                                                                                    selectedTileColor: Colors.blue.shade100,
                                                                                    onTap: () {
                                                                                      teGradeController[index].text = snapshot.gradeListUAS[indx].value ?? '--';
                                                                                      teGradeController1[index].text = snapshot.gradeListUAS[indx].value ?? '--';
                                                                                      value.studListUAS[index].teGrade = teGradeController1[index].text;
                                                                                      // value.studListUAS[index].teGrade = teGradeController[index].text;
                                                                                      value.studListUAS[index].teGrade = value.studListUAS[index].teGrade;
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
                                                                        textInputAction:
                                                                            TextInputAction.next,
                                                                        enabled: value.studListUAS[index].attendance == 'A' ||
                                                                                value.examStatusUAS == 'Synchronized'
                                                                            ? true
                                                                            : false,
                                                                        readOnly:
                                                                            true,
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            color: UIGuide.BLACK,
                                                                            overflow: TextOverflow.clip),
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
                                                                              "  Select ",
                                                                          hintText:
                                                                              "grade",
                                                                        ),
                                                                        onChanged:
                                                                            (value1) {
                                                                          teGradeController1[index].text = value
                                                                              .studListUAS[index]
                                                                              .teGrade
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
                                                          '${value.ceCaptionUAS ?? ""} : ',
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
                                                                  MarkEntryNewProvider>(
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
                                                                          shape:
                                                                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                                                          child: LimitedBox(
                                                                            maxHeight:
                                                                                size.height / 2,
                                                                            child: ListView.builder(
                                                                                shrinkWrap: true,
                                                                                itemCount: snapshot.gradeListUAS.length,
                                                                                itemBuilder: (context, indx) {
                                                                                  return ListTile(
                                                                                    selectedTileColor: Colors.blue.shade100,
                                                                                    onTap: () {
                                                                                      ceGradeController[index].text = snapshot.gradeListUAS[indx].value ?? '--';
                                                                                      ceGradeController1[index].text = snapshot.gradeListUAS[indx].value ?? '--';
                                                                                      value.studListUAS[index].ceGrade = ceGradeController1[index].text;
                                                                                      //   value.studListUAS[index].ceGrade = ceGradeController[index].text;
                                                                                      value.studListUAS[index].ceGrade = value.studListUAS[index].ceGrade;
                                                                                      print(provider.studListUAS[index].peGrade);
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
                                                                        textInputAction:
                                                                            TextInputAction.next,
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            color: UIGuide.BLACK,
                                                                            overflow: TextOverflow.clip),
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
                                                                              "  Select ",
                                                                          hintText:
                                                                              "grade",
                                                                        ),
                                                                        enabled: value.studListUAS[index].attendance == 'A' ||
                                                                                value.examStatusUAS == 'Synchronized'
                                                                            ? true
                                                                            : false,
                                                                        readOnly:
                                                                            true,
                                                                        onChanged:
                                                                            (value1) {
                                                                          ceGradeController1[index].text = value
                                                                              .studListUAS[index]
                                                                              .ceGrade
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
                              ),
                            ));
                          }

                          ///////////////-------------------------------------------------------------------------------------///////////////
                          ///////////////-----------------------     TE Grade  --  PE Grade ---------------------------------///////////////
                          ///////////////-----------------------------------------------------------------------------------///////////////
                          if (provider.teCaptionUAS != null &&
                              provider.peCaptionUAS != null &&
                              provider.ceCaptionUAS == null) {
                            return Expanded(
                                // maxHeight: size.height / 1.81,
                                child: Scrollbar(
                              thickness: 5,
                              controller: _scrollController,
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
                                          ? teGradeController1[index]
                                              .text = value.studListUAS[index]
                                                      .teGrade ==
                                                  null
                                              ? teGradeController1[index].text
                                              : value.studListUAS[index].teGrade
                                                  .toString()
                                          : teGradeController1[index].text;
                                      teGradeController[index].text.isEmpty
                                          ? teGradeController[index]
                                              .text = value.studListUAS[index]
                                                      .teGrade ==
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

                                      praticalGradeController1[index]
                                              .text
                                              .isEmpty
                                          ? praticalGradeController1[index]
                                              .text = value.studListUAS[index]
                                                      .peGrade ==
                                                  null
                                              ? praticalGradeController1[index]
                                                  .text
                                              : value.studListUAS[index].peGrade
                                                  .toString()
                                          : praticalGradeController1[index]
                                              .text;
                                      praticalGradeController[index]
                                              .text
                                              .isEmpty
                                          ? praticalGradeController[index]
                                              .text = value.studListUAS[index]
                                                      .peGrade ==
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
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 80,
                                                      child: Text(
                                                        'Roll No: ${value.studListUAS[index].rollNo == null ? '' : value.studListUAS[index].rollNo.toString()}',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                    kWidth,
                                                    kWidth,
                                                    kWidth,
                                                    // value.studListUAS[index]
                                                    //             .isAttendanceDisabled ==
                                                    //         true
                                                    //     ? SizedBox(
                                                    //         height: 0,
                                                    //         width: 0,
                                                    //       )
                                                    //     : Padding(
                                                    //         padding:
                                                    //             const EdgeInsets
                                                    //                 .only(
                                                    //                 left: 10.0),
                                                    //         child:
                                                    //             GestureDetector(
                                                    //           onTap: () {
                                                    //             setState(() {
                                                    //               if (value
                                                    //                       .studListUAS[
                                                    //                           index]
                                                    //                       .attendance ==
                                                    //                   'A') {
                                                    //                 value
                                                    //                     .studListUAS[
                                                    //                         index]
                                                    //                     .attendance = 'P';
                                                    //               } else {
                                                    //                 value
                                                    //                     .studListUAS[
                                                    //                         index]
                                                    //                     .attendance = 'A';

                                                    //                 value
                                                    //                     .studListUAS[
                                                    //                         index]
                                                    //                     .teGrade = null;
                                                    //                 value
                                                    //                     .studListUAS[
                                                    //                         index]
                                                    //                     .teGradeId = null;

                                                    //                 teGradeController[
                                                    //                         index]
                                                    //                     .clear();
                                                    //                 teGradeController1[
                                                    //                         index]
                                                    //                     .clear();

                                                    //                 value
                                                    //                     .studListUAS[
                                                    //                         index]
                                                    //                     .peGrade = null;
                                                    //                 value
                                                    //                     .studListUAS[
                                                    //                         index]
                                                    //                     .peGradeId = null;

                                                    //                 praticalGradeController[
                                                    //                         index]
                                                    //                     .clear();
                                                    //                 praticalGradeController1[
                                                    //                         index]
                                                    //                     .clear();
                                                    //               }
                                                    //               attendancee = value
                                                    //                   .studListUAS[
                                                    //                       index]
                                                    //                   .attendance;

                                                    //               print(
                                                    //                   "attendace   $attendancee");
                                                    //             });
                                                    //           },
                                                    //           child: Container(
                                                    //             color: Colors
                                                    //                 .transparent,
                                                    //             width: 28,
                                                    //             height: 26,
                                                    //             child: SizedBox(
                                                    //                 width: 28,
                                                    //                 height: 26,
                                                    //                 child: value.studListUAS[index].attendance ==
                                                    //                         'A'
                                                    //                     ? SvgPicture.asset(
                                                    //                         UIGuide
                                                    //                             .absent)
                                                    //                     : SvgPicture.asset(
                                                    //                         UIGuide
                                                    //                             .present)),
                                                    //           ),
                                                    //         ),
                                                    //       ),
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
                                                          '${value.teCaptionUAS ?? ""} : ',
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
                                                                  MarkEntryNewProvider>(
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
                                                                          shape:
                                                                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                                                          child: LimitedBox(
                                                                            maxHeight:
                                                                                size.height / 2,
                                                                            child: ListView.builder(
                                                                                shrinkWrap: true,
                                                                                itemCount: snapshot.gradeListUAS.length,
                                                                                itemBuilder: (context, indx) {
                                                                                  return ListTile(
                                                                                    selectedTileColor: Colors.blue.shade100,
                                                                                    onTap: () {
                                                                                      teGradeController[index].text = snapshot.gradeListUAS[indx].value ?? '--';
                                                                                      teGradeController1[index].text = snapshot.gradeListUAS[indx].value ?? '--';
                                                                                      value.studListUAS[index].teGrade = teGradeController1[index].text;
                                                                                      value.studListUAS[index].teGrade = teGradeController[index].text;
                                                                                      value.studListUAS[index].teGrade = value.studListUAS[index].teGrade;
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
                                                                        textInputAction:
                                                                            TextInputAction.next,
                                                                        enabled: value.studListUAS[index].attendance == 'A' ||
                                                                                value.examStatusUAS == 'Synchronized'
                                                                            ? true
                                                                            : false,
                                                                        readOnly:
                                                                            true,
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            color: UIGuide.BLACK,
                                                                            overflow: TextOverflow.clip),
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
                                                                              "  Select ",
                                                                          hintText:
                                                                              "grade",
                                                                        ),
                                                                        onChanged:
                                                                            (value1) {
                                                                          teGradeController1[index].text = value
                                                                              .studListUAS[index]
                                                                              .teGrade
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
                                                          '${value.peCaptionUAS ?? ""} : ',
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
                                                                  MarkEntryNewProvider>(
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
                                                                          shape:
                                                                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                                                          child: LimitedBox(
                                                                            maxHeight:
                                                                                size.height / 2,
                                                                            child: ListView.builder(
                                                                                shrinkWrap: true,
                                                                                itemCount: snapshot.gradeListUAS.length,
                                                                                itemBuilder: (context, indx) {
                                                                                  return ListTile(
                                                                                    selectedTileColor: Colors.blue.shade100,
                                                                                    onTap: () {
                                                                                      praticalGradeController[index].text = snapshot.gradeListUAS[indx].value ?? '--';
                                                                                      praticalGradeController1[index].text = snapshot.gradeListUAS[indx].value ?? '--';
                                                                                      value.studListUAS[index].peGrade = praticalGradeController1[index].text;
                                                                                      value.studListUAS[index].peGrade = praticalGradeController[index].text;
                                                                                      value.studListUAS[index].peGrade = value.studListUAS[index].peGrade;
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
                                                                        textInputAction:
                                                                            TextInputAction.next,
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            color: UIGuide.BLACK,
                                                                            overflow: TextOverflow.clip),
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
                                                                              "  Select ",
                                                                          hintText:
                                                                              "grade",
                                                                        ),
                                                                        enabled: value.studListUAS[index].attendance == 'A' ||
                                                                                value.examStatusUAS == 'Synchronized'
                                                                            ? true
                                                                            : false,
                                                                        readOnly:
                                                                            true,
                                                                        onChanged:
                                                                            (value1) {
                                                                          praticalGradeController1[index].text = value
                                                                              .studListUAS[index]
                                                                              .peGrade
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
                              ),
                            ));
                          }

                          ///////////////-------------------------------------------------------------------------------------///////////////
                          ///////////////-----------------------      PE Grade --  CE Grade  --------------------------------///////////////
                          ///////////////-----------------------------------------------------------------------------------///////////////
                          if (provider.teCaptionUAS == null &&
                              provider.peCaptionUAS != null &&
                              provider.ceCaptionUAS != null) {
                            return Expanded(
                                // maxHeight: size.height / 1.81,
                                child: Scrollbar(
                              thickness: 5,
                              controller: _scrollController,
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

                                      praticalGradeController1[index]
                                              .text
                                              .isEmpty
                                          ? praticalGradeController1[index]
                                              .text = value.studListUAS[index]
                                                      .peGrade ==
                                                  null
                                              ? praticalGradeController1[index]
                                                  .text
                                              : value.studListUAS[index].peGrade
                                                  .toString()
                                          : praticalGradeController1[index]
                                              .text;
                                      praticalGradeController[index]
                                              .text
                                              .isEmpty
                                          ? praticalGradeController[index]
                                              .text = value.studListUAS[index]
                                                      .peGrade ==
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
                                          ? ceGradeController1[index]
                                              .text = value.studListUAS[index]
                                                      .ceGrade ==
                                                  null
                                              ? ceGradeController1[index].text
                                              : value.studListUAS[index].ceGrade
                                                  .toString()
                                          : ceGradeController1[index].text;
                                      ceGradeController[index].text.isEmpty
                                          ? ceGradeController[index]
                                              .text = value.studListUAS[index]
                                                      .ceGrade ==
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
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 80,
                                                      child: Text(
                                                        'Roll No: ${value.studListUAS[index].rollNo == null ? '' : value.studListUAS[index].rollNo.toString()}',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                    kWidth,
                                                    kWidth,
                                                    kWidth,
                                                    // value.studListUAS[index]
                                                    //             .isAttendanceDisabled ==
                                                    //         true
                                                    //     ? SizedBox(
                                                    //         height: 0,
                                                    //         width: 0,
                                                    //       )
                                                    //     : Padding(
                                                    //         padding:
                                                    //             const EdgeInsets
                                                    //                 .only(
                                                    //                 left: 10.0),
                                                    //         child:
                                                    //             GestureDetector(
                                                    //           onTap: () {
                                                    //             setState(() {
                                                    //               if (value
                                                    //                       .studListUAS[
                                                    //                           index]
                                                    //                       .attendance ==
                                                    //                   'A') {
                                                    //                 value
                                                    //                     .studListUAS[
                                                    //                         index]
                                                    //                     .attendance = 'P';
                                                    //               } else {
                                                    //                 value
                                                    //                     .studListUAS[
                                                    //                         index]
                                                    //                     .attendance = 'A';

                                                    //                 value
                                                    //                     .studListUAS[
                                                    //                         index]
                                                    //                     .ceGrade = null;
                                                    //                 value
                                                    //                     .studListUAS[
                                                    //                         index]
                                                    //                     .ceGradeId = null;

                                                    //                 ceGradeController[
                                                    //                         index]
                                                    //                     .clear();
                                                    //                 ceGradeController1[
                                                    //                         index]
                                                    //                     .clear();

                                                    //                 value
                                                    //                     .studListUAS[
                                                    //                         index]
                                                    //                     .peGrade = null;
                                                    //                 value
                                                    //                     .studListUAS[
                                                    //                         index]
                                                    //                     .peGradeId = null;

                                                    //                 praticalGradeController[
                                                    //                         index]
                                                    //                     .clear();
                                                    //                 praticalGradeController1[
                                                    //                         index]
                                                    //                     .clear();
                                                    //               }
                                                    //               attendancee = value
                                                    //                   .studListUAS[
                                                    //                       index]
                                                    //                   .attendance;

                                                    //               print(
                                                    //                   "attendace   $attendancee");
                                                    //             });
                                                    //           },
                                                    //           child: Container(
                                                    //             color: Colors
                                                    //                 .transparent,
                                                    //             width: 28,
                                                    //             height: 26,
                                                    //             child: SizedBox(
                                                    //                 width: 28,
                                                    //                 height: 26,
                                                    //                 child: value.studListUAS[index].attendance ==
                                                    //                         'A'
                                                    //                     ? SvgPicture.asset(
                                                    //                         UIGuide
                                                    //                             .absent)
                                                    //                     : SvgPicture.asset(
                                                    //                         UIGuide
                                                    //                             .present)),
                                                    //           ),
                                                    //         ),
                                                    //       ),
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
                                                          '${value.ceCaptionUAS ?? ""} : ',
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
                                                                  MarkEntryNewProvider>(
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
                                                                          shape:
                                                                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                                                          child: LimitedBox(
                                                                            maxHeight:
                                                                                size.height / 2,
                                                                            child: ListView.builder(
                                                                                shrinkWrap: true,
                                                                                itemCount: snapshot.gradeListUAS.length,
                                                                                itemBuilder: (context, indx) {
                                                                                  return ListTile(
                                                                                    selectedTileColor: Colors.blue.shade100,
                                                                                    onTap: () {
                                                                                      ceGradeController[index].text = snapshot.gradeListUAS[indx].value ?? '--';
                                                                                      ceGradeController1[index].text = snapshot.gradeListUAS[indx].value ?? '--';
                                                                                      value.studListUAS[index].ceGrade = ceGradeController1[index].text;
                                                                                      value.studListUAS[index].ceGrade = ceGradeController[index].text;
                                                                                      value.studListUAS[index].ceGrade = value.studListUAS[index].ceGrade;
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
                                                                        textInputAction:
                                                                            TextInputAction.next,
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            color: UIGuide.BLACK,
                                                                            overflow: TextOverflow.clip),
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
                                                                              "  Select ",
                                                                          hintText:
                                                                              "grade",
                                                                        ),
                                                                        enabled: value.studListUAS[index].attendance == 'A' ||
                                                                                value.examStatusUAS == 'Synchronized'
                                                                            ? true
                                                                            : false,
                                                                        readOnly:
                                                                            true,
                                                                        onChanged:
                                                                            (value1) {
                                                                          ceGradeController1[index].text = value
                                                                              .studListUAS[index]
                                                                              .ceGrade
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
                                                          '${value.peCaptionUAS ?? ""} : ',
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
                                                                  MarkEntryNewProvider>(
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
                                                                          shape:
                                                                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                                                          child: LimitedBox(
                                                                            maxHeight:
                                                                                size.height / 2,
                                                                            child: ListView.builder(
                                                                                shrinkWrap: true,
                                                                                itemCount: snapshot.gradeListUAS.length,
                                                                                itemBuilder: (context, indx) {
                                                                                  return ListTile(
                                                                                    selectedTileColor: Colors.blue.shade100,
                                                                                    onTap: () {
                                                                                      praticalGradeController[index].text = snapshot.gradeListUAS[indx].value ?? '--';
                                                                                      praticalGradeController1[index].text = snapshot.gradeListUAS[indx].value ?? '--';
                                                                                      value.studListUAS[index].peGrade = praticalGradeController1[index].text;
                                                                                      value.studListUAS[index].peGrade = praticalGradeController[index].text;
                                                                                      value.studListUAS[index].peGrade = value.studListUAS[index].peGrade;
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
                                                                        textInputAction:
                                                                            TextInputAction.next,
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            color: UIGuide.BLACK,
                                                                            overflow: TextOverflow.clip),
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
                                                                              "  Select ",
                                                                          hintText:
                                                                              "grade",
                                                                        ),
                                                                        enabled: value.studListUAS[index].attendance == 'A' ||
                                                                                value.examStatusUAS == 'Synchronized'
                                                                            ? true
                                                                            : false,
                                                                        readOnly:
                                                                            true,
                                                                        onChanged:
                                                                            (value1) {
                                                                          praticalGradeController1[index].text = value
                                                                              .studListUAS[index]
                                                                              .peGrade
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
                              ),
                            ));
                          }
                          ///////////////-------------------------------------------------------------------------------------///////////////
                          ///////////////-----------------------     TE Grade  ----------------------------------------------///////////////
                          ///////////////-----------------------------------------------------------------------------------///////////////
                          if (provider.teCaptionUAS != null &&
                              provider.peCaptionUAS == null &&
                              provider.ceCaptionUAS == null) {
                            return Expanded(
                                // maxHeight: size.height / 1.81,
                                child: Scrollbar(
                              thickness: 5,
                              controller: _scrollController,
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
                                          ? teGradeController1[index]
                                              .text = value.studListUAS[index]
                                                      .teGrade ==
                                                  null
                                              ? teGradeController1[index].text
                                              : value.studListUAS[index].teGrade
                                                  .toString()
                                          : teGradeController1[index].text;
                                      teGradeController[index].text.isEmpty
                                          ? teGradeController[index]
                                              .text = value.studListUAS[index]
                                                      .teGrade ==
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
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 80,
                                                      child: Text(
                                                        'Roll No: ${value.studListUAS[index].rollNo == null ? '' : value.studListUAS[index].rollNo.toString()}',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                    kWidth,
                                                    kWidth,
                                                    kWidth,
                                                    // value.studListUAS[index]
                                                    //             .isAttendanceDisabled ==
                                                    //         true
                                                    //     ? SizedBox(
                                                    //         height: 0,
                                                    //         width: 0,
                                                    //       )
                                                    //     : Padding(
                                                    //         padding:
                                                    //             const EdgeInsets
                                                    //                 .only(
                                                    //                 left: 10.0),
                                                    //         child:
                                                    //             GestureDetector(
                                                    //           onTap: () {
                                                    //             setState(() {
                                                    //               if (value
                                                    //                       .studListUAS[
                                                    //                           index]
                                                    //                       .attendance ==
                                                    //                   'A') {
                                                    //                 value
                                                    //                     .studListUAS[
                                                    //                         index]
                                                    //                     .attendance = 'P';
                                                    //               } else {
                                                    //                 value
                                                    //                     .studListUAS[
                                                    //                         index]
                                                    //                     .attendance = 'A';

                                                    //                 value
                                                    //                     .studListUAS[
                                                    //                         index]
                                                    //                     .teGrade = null;
                                                    //                 value
                                                    //                     .studListUAS[
                                                    //                         index]
                                                    //                     .teGradeId = null;

                                                    //                 teGradeController[
                                                    //                         index]
                                                    //                     .clear();
                                                    //                 teGradeController1[
                                                    //                         index]
                                                    //                     .clear();
                                                    //               }
                                                    //               attendancee = value
                                                    //                   .studListUAS[
                                                    //                       index]
                                                    //                   .attendance;

                                                    //               print(
                                                    //                   "attendace   $attendancee");
                                                    //             });
                                                    //           },
                                                    //           child: Container(
                                                    //             color: Colors
                                                    //                 .transparent,
                                                    //             width: 28,
                                                    //             height: 26,
                                                    //             child: SizedBox(
                                                    //                 width: 28,
                                                    //                 height: 26,
                                                    //                 child: value.studListUAS[index].attendance ==
                                                    //                         'A'
                                                    //                     ? SvgPicture.asset(
                                                    //                         UIGuide
                                                    //                             .absent)
                                                    //                     : SvgPicture.asset(
                                                    //                         UIGuide
                                                    //                             .present)),
                                                    //           ),
                                                    //         ),
                                                    //       ),
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
                                                          '${value.teCaptionUAS ?? ""} : ',
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
                                                                  MarkEntryNewProvider>(
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
                                                                          shape:
                                                                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                                                          child: LimitedBox(
                                                                            maxHeight:
                                                                                size.height / 2,
                                                                            child: ListView.builder(
                                                                                shrinkWrap: true,
                                                                                itemCount: snapshot.gradeListUAS.length,
                                                                                itemBuilder: (context, indx) {
                                                                                  return ListTile(
                                                                                    selectedTileColor: Colors.blue.shade100,
                                                                                    onTap: () {
                                                                                      teGradeController[index].text = snapshot.gradeListUAS[indx].value ?? '--';
                                                                                      teGradeController1[index].text = snapshot.gradeListUAS[indx].value ?? '--';
                                                                                      value.studListUAS[index].teGrade = teGradeController1[index].text;
                                                                                      value.studListUAS[index].teGrade = teGradeController[index].text;
                                                                                      value.studListUAS[index].teGrade = value.studListUAS[index].teGrade;
                                                                                      Navigator.of(context).pop();
                                                                                    },
                                                                                    title: Text(
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
                                                                        textInputAction:
                                                                            TextInputAction.next,
                                                                        enabled: value.studListUAS[index].attendance == 'A' ||
                                                                                value.examStatusUAS == 'Synchronized'
                                                                            ? true
                                                                            : false,
                                                                        readOnly:
                                                                            true,
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            color: UIGuide.BLACK,
                                                                            overflow: TextOverflow.clip),
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
                                                                              "  Select ",
                                                                          hintText:
                                                                              "grade",
                                                                        ),
                                                                        onChanged:
                                                                            (value1) {
                                                                          teGradeController1[index].text = value
                                                                              .studListUAS[index]
                                                                              .teGrade
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
                              ),
                            ));
                          }

                          ////\\\\\\\\\//-------------------------------------------------------------------------------------///////////////
                          ///////////////-----------------------     PE Grade -----------------------------------------------///////////////
                          ///////////////-----------------------------------------------------------------------------------///////////////
                          if (provider.teCaptionUAS == null &&
                              provider.peCaptionUAS != null &&
                              provider.ceCaptionUAS == null) {
                            return Expanded(
                                //maxHeight: size.height / 1.81,
                                child: Scrollbar(
                              thickness: 5,
                              controller: _scrollController,
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

                                      praticalGradeController1[index]
                                              .text
                                              .isEmpty
                                          ? praticalGradeController1[index]
                                              .text = value.studListUAS[index]
                                                      .peGrade ==
                                                  null
                                              ? praticalGradeController1[index]
                                                  .text
                                              : value.studListUAS[index].peGrade
                                                  .toString()
                                          : praticalGradeController1[index]
                                              .text;
                                      praticalGradeController[index]
                                              .text
                                              .isEmpty
                                          ? praticalGradeController[index]
                                              .text = value.studListUAS[index]
                                                      .peGrade ==
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
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 80,
                                                      child: Text(
                                                        'Roll No: ${value.studListUAS[index].rollNo == null ? '' : value.studListUAS[index].rollNo.toString()}',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                    kWidth,
                                                    kWidth,
                                                    kWidth,
                                                    // value.studListUAS[index]
                                                    //             .isAttendanceDisabled ==
                                                    //         true
                                                    //     ? SizedBox(
                                                    //         height: 0,
                                                    //         width: 0,
                                                    //       )
                                                    //     : Padding(
                                                    //         padding:
                                                    //             const EdgeInsets
                                                    //                 .only(
                                                    //                 left: 10.0),
                                                    //         child:
                                                    //             GestureDetector(
                                                    //           onTap: () {
                                                    //             setState(() {
                                                    //               if (value
                                                    //                       .studListUAS[
                                                    //                           index]
                                                    //                       .attendance ==
                                                    //                   'A') {
                                                    //                 value
                                                    //                     .studListUAS[
                                                    //                         index]
                                                    //                     .attendance = 'P';
                                                    //               } else {
                                                    //                 value
                                                    //                     .studListUAS[
                                                    //                         index]
                                                    //                     .attendance = 'A';

                                                    //                 value
                                                    //                     .studListUAS[
                                                    //                         index]
                                                    //                     .peGrade = null;
                                                    //                 value
                                                    //                     .studListUAS[
                                                    //                         index]
                                                    //                     .peGradeId = null;

                                                    //                 praticalGradeController[
                                                    //                         index]
                                                    //                     .clear();
                                                    //                 praticalGradeController1[
                                                    //                         index]
                                                    //                     .clear();
                                                    //               }
                                                    //               attendancee = value
                                                    //                   .studListUAS[
                                                    //                       index]
                                                    //                   .attendance;

                                                    //               print(
                                                    //                   "attendace   $attendancee");
                                                    //             });
                                                    //           },
                                                    //           child: Container(
                                                    //             color: Colors
                                                    //                 .transparent,
                                                    //             width: 28,
                                                    //             height: 26,
                                                    //             child: SizedBox(
                                                    //                 width: 28,
                                                    //                 height: 26,
                                                    //                 child: value.studListUAS[index].attendance ==
                                                    //                         'A'
                                                    //                     ? SvgPicture.asset(
                                                    //                         UIGuide
                                                    //                             .absent)
                                                    //                     : SvgPicture.asset(
                                                    //                         UIGuide
                                                    //                             .present)),
                                                    //           ),
                                                    //         ),
                                                    //       ),
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
                                                          '${value.peCaptionUAS ?? ""} : ',
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
                                                                  MarkEntryNewProvider>(
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
                                                                          shape:
                                                                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                                                          child: LimitedBox(
                                                                            maxHeight:
                                                                                size.height / 2,
                                                                            child: ListView.builder(
                                                                                shrinkWrap: true,
                                                                                itemCount: snapshot.gradeListUAS.length,
                                                                                itemBuilder: (context, indx) {
                                                                                  return ListTile(
                                                                                    selectedTileColor: Colors.blue.shade100,
                                                                                    onTap: () {
                                                                                      praticalGradeController[index].text = snapshot.gradeListUAS[indx].value ?? '--';
                                                                                      praticalGradeController1[index].text = snapshot.gradeListUAS[indx].value ?? '--';
                                                                                      value.studListUAS[index].peGrade = praticalGradeController1[index].text;
                                                                                      value.studListUAS[index].peGrade = praticalGradeController[index].text;
                                                                                      value.studListUAS[index].peGrade = value.studListUAS[index].peGrade;
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
                                                                        textInputAction:
                                                                            TextInputAction.next,
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            color: UIGuide.BLACK,
                                                                            overflow: TextOverflow.clip),
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
                                                                              "  Select ",
                                                                          hintText:
                                                                              "grade",
                                                                        ),
                                                                        enabled: value.studListUAS[index].attendance == 'A' ||
                                                                                value.examStatusUAS == 'Synchronized'
                                                                            ? true
                                                                            : false,
                                                                        readOnly:
                                                                            true,
                                                                        onChanged:
                                                                            (value1) {
                                                                          praticalGradeController1[index].text = value
                                                                              .studListUAS[index]
                                                                              .peGrade
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
                              ),
                            ));
                          }

                          ///////////////-------------------------------------------------------------------------------------///////////////
                          ///////////////-----------------------       CE Grade  --------------------------------------------///////////////
                          ///////////////-----------------------------------------------------------------------------------///////////////
                          if (provider.teCaptionUAS == null &&
                              provider.peCaptionUAS == null &&
                              provider.ceCaptionUAS != null) {
                            return Expanded(
                                // maxHeight: size.height / 1.81,
                                child: Scrollbar(
                              thickness: 5,
                              controller: _scrollController,
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
                                          ? ceGradeController1[index]
                                              .text = value.studListUAS[index]
                                                      .ceGrade ==
                                                  null
                                              ? ceGradeController1[index].text
                                              : value.studListUAS[index].ceGrade
                                                  .toString()
                                          : ceGradeController1[index].text;
                                      ceGradeController[index].text.isEmpty
                                          ? ceGradeController[index]
                                              .text = value.studListUAS[index]
                                                      .ceGrade ==
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
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 80,
                                                      child: Text(
                                                        'Roll No: ${value.studListUAS[index].rollNo == null ? '' : value.studListUAS[index].rollNo.toString()}',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                    kWidth,
                                                    kWidth,
                                                    kWidth,
                                                    // value.studListUAS[index]
                                                    //             .isAttendanceDisabled ==
                                                    //         true
                                                    //     ? SizedBox(
                                                    //         height: 0,
                                                    //         width: 0,
                                                    //       )
                                                    //     : Padding(
                                                    //         padding:
                                                    //             const EdgeInsets
                                                    //                 .only(
                                                    //                 left: 10.0),
                                                    //         child:
                                                    //             GestureDetector(
                                                    //           onTap: () {
                                                    //             setState(() {
                                                    //               if (value
                                                    //                       .studListUAS[
                                                    //                           index]
                                                    //                       .attendance ==
                                                    //                   'A') {
                                                    //                 value
                                                    //                     .studListUAS[
                                                    //                         index]
                                                    //                     .attendance = 'P';
                                                    //               } else {
                                                    //                 value
                                                    //                     .studListUAS[
                                                    //                         index]
                                                    //                     .attendance = 'A';

                                                    //                 value
                                                    //                     .studListUAS[
                                                    //                         index]
                                                    //                     .ceGrade = null;
                                                    //                 value
                                                    //                     .studListUAS[
                                                    //                         index]
                                                    //                     .ceGradeId = null;

                                                    //                 ceGradeController[
                                                    //                         index]
                                                    //                     .clear();
                                                    //                 ceGradeController1[
                                                    //                         index]
                                                    //                     .clear();
                                                    //               }
                                                    //               attendancee = value
                                                    //                   .studListUAS[
                                                    //                       index]
                                                    //                   .attendance;

                                                    //               print(
                                                    //                   "attendace   $attendancee");
                                                    //             });
                                                    //           },
                                                    //           child: Container(
                                                    //             color: Colors
                                                    //                 .transparent,
                                                    //             width: 28,
                                                    //             height: 26,
                                                    //             child: SizedBox(
                                                    //                 width: 28,
                                                    //                 height: 26,
                                                    //                 child: value.studListUAS[index].attendance ==
                                                    //                         'A'
                                                    //                     ? SvgPicture.asset(
                                                    //                         UIGuide
                                                    //                             .absent)
                                                    //                     : SvgPicture.asset(
                                                    //                         UIGuide
                                                    //                             .present)),
                                                    //           ),
                                                    //         ),
                                                    //       ),
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
                                                          '${value.ceCaptionUAS ?? ""} : ',
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
                                                                  MarkEntryNewProvider>(
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
                                                                          shape:
                                                                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                                                          child: LimitedBox(
                                                                            maxHeight:
                                                                                size.height / 2,
                                                                            child: ListView.builder(
                                                                                shrinkWrap: true,
                                                                                itemCount: snapshot.gradeListUAS.length,
                                                                                itemBuilder: (context, indx) {
                                                                                  return ListTile(
                                                                                    selectedTileColor: Colors.blue.shade100,
                                                                                    onTap: () {
                                                                                      ceGradeController[index].text = snapshot.gradeListUAS[indx].value ?? '--';
                                                                                      ceGradeController1[index].text = snapshot.gradeListUAS[indx].value ?? '--';
                                                                                      value.studListUAS[index].ceGrade = ceGradeController1[index].text;
                                                                                      value.studListUAS[index].ceGrade = ceGradeController[index].text;
                                                                                      value.studListUAS[index].ceGrade = value.studListUAS[index].ceGrade;
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
                                                                        textInputAction:
                                                                            TextInputAction.next,
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            color: UIGuide.BLACK,
                                                                            overflow: TextOverflow.clip),
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
                                                                              "  Select ",
                                                                          hintText:
                                                                              "grade",
                                                                        ),
                                                                        enabled: value.studListUAS[index].attendance == 'A' ||
                                                                                value.examStatusUAS == 'Synchronized'
                                                                            ? true
                                                                            : false,
                                                                        readOnly:
                                                                            true,
                                                                        onChanged:
                                                                            (value1) {
                                                                          ceGradeController1[index].text = value
                                                                              .studListUAS[index]
                                                                              .ceGrade
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
                              ),
                            ));
                          } else {
                            return const SizedBox(
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
                    ]),
                    if (value.loading) pleaseWaitLoader()
                  ],
                );
        }),
        bottomNavigationBar: BottomAppBar(
          child: Consumer<MarkEntryNewProvider>(
            builder: (context, sync, _) => sync.studListUAS.isEmpty
                ? const SizedBox(height: 0, width: 0)
                : sync.examStatusUAS == "Synchronized"
                    ? const SizedBox(
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
                                    onPressed: value.loadCommon
                                        ? null
                                        : () async {
                                            try {
                                              List obj = [];
                                              List marrkk = [];
                                              obj.clear();
                                              marrkk.clear();
                                              print(
                                                  "---------------${value.studListUAS.length}");
                                              print(obj.length);
                                              print(value.tabulationTypeCode);
                                              print(value.entryMethodUAS);

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
                                                      "teMark": _controllers[i]
                                                              .text
                                                              .isEmpty
                                                          ? null
                                                          : _controllers[i]
                                                              .text
                                                              .toString(),
                                                      "peMark": null,
                                                      "ceMark": null,
                                                      "teGrade": null,
                                                      "peGrade": null,
                                                      "ceGrade": null,
                                                      "total": _controllers[i]
                                                              .text
                                                              .isEmpty
                                                          ? null
                                                          : _controllers[i]
                                                              .text
                                                              .toString(),
                                                      "teGradeId": null,
                                                      "peGradeId": null,
                                                      "ceGradeId": null,
                                                      "tabMarkEntryId": value
                                                          .studListUAS[i]
                                                          .tabMarkEntryId,
                                                      "isEdited": false,
                                                      "isDisabled": false
                                                    },
                                                  );
                                                  marrkk.add(_controllers[i]
                                                      .text
                                                      .toString());
                                                  print("""""" """""" "");
                                                }
                                                if (marrkk.isEmpty) {
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
                                                      "enter mark...!",
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ));
                                                }
                                              } else if (value
                                                          .tabulationTypeCode ==
                                                      "UAS" &&
                                                  value.teCaptionUAS ==
                                                      "Grade") {
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
                                                      "teMark": null,
                                                      "peMark": null,
                                                      "ceMark": null,
                                                      "teGrade": value
                                                          .studListUAS[i]
                                                          .teGrade,
                                                      "peGrade": null,
                                                      "ceGrade": null,
                                                      "total": null,
                                                      "teGradeId": null,
                                                      "peGradeId": null,
                                                      "ceGradeId": null,
                                                      "tabMarkEntryId": value
                                                          .studListUAS[i]
                                                          .tabMarkEntryId,
                                                      "isEdited": false,
                                                      "isDisabled": false
                                                    },
                                                  );
                                                }
                                              } else if (value
                                                          .tabulationTypeCode ==
                                                      "PBT" &&
                                                  value.teCaptionUAS ==
                                                      "Grade") {
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
                                                      "teMark": null,
                                                      "peMark": null,
                                                      "ceMark": null,
                                                      "teGrade": value
                                                          .studListUAS[i]
                                                          .teGrade,
                                                      "peGrade": null,
                                                      "ceGrade": null,
                                                      "total": null,
                                                      "teGradeId": null,
                                                      "peGradeId": null,
                                                      "ceGradeId": null,
                                                      "tabMarkEntryId": value
                                                          .studListUAS[i]
                                                          .tabMarkEntryId,
                                                      "isEdited": false,
                                                      "isDisabled": false
                                                    },
                                                  );
                                                }
                                              } else if ((value
                                                              .tabulationTypeCode ==
                                                          "PBT" ||
                                                      value.tabulationTypeCode ==
                                                          "STATE") &&
                                                  value.entryMethodUAS ==
                                                      "Mark") {
                                                for (int i = 0;
                                                    i <
                                                        value
                                                            .studListUAS.length;
                                                    i++) {

                                                  if(value.booleanList[i]==true) {
                                                    obj.add(
                                                      {
                                                        "attendance": value
                                                            .studListUAS[i]
                                                            .attendance,
                                                        "ceAttendance": value
                                                            .studListUAS[i]
                                                            .ceAttendance,
                                                        "peAttendance": value
                                                            .studListUAS[i]
                                                            .peAttendance,
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
                                                        "teMark": teMarkController[
                                                        i]
                                                            .text
                                                            .isEmpty
                                                            ? null
                                                            : teMarkController[i]
                                                            .text
                                                            .toString(),
                                                        "peMark":
                                                        practicalMarkController[
                                                        i]
                                                            .text
                                                            .isEmpty
                                                            ? null
                                                            : practicalMarkController[
                                                        i]
                                                            .text
                                                            .toString(),
                                                        "ceMark": ceMarkController[
                                                        i]
                                                            .text
                                                            .isEmpty
                                                            ? null
                                                            : ceMarkController[i]
                                                            .text
                                                            .toString(),
                                                        "teGrade": value
                                                            .studListUAS[i]
                                                            .teGrade,
                                                        "peGrade": null,
                                                        "ceGrade": null,
                                                        "total": "",
                                                        "teGradeId": null,
                                                        "peGradeId": null,
                                                        "ceGradeId": null,
                                                        "tabMarkEntryId": value
                                                            .studListUAS[i]
                                                            .tabMarkEntryId,
                                                        "isEdited": value
                                                            .booleanList[i],
                                                        "isDisabled": false
                                                      },
                                                    );
                                                  }

                                                }
                                              } else if ((value
                                                          .tabulationTypeCode ==
                                                      "STATE") &&
                                                  value.entryMethodUAS ==
                                                      "Grade") {
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
                                                      "teMark": null,
                                                      "peMark": null,
                                                      "ceMark": null,
                                                      "teGrade": value
                                                          .studListUAS[i]
                                                          .teGrade,
                                                      "peGrade": value
                                                          .studListUAS[i]
                                                          .peGrade,
                                                      "ceGrade": value
                                                          .studListUAS[i]
                                                          .ceGrade,
                                                      "total": null,
                                                      "teGradeId": null,
                                                      "peGradeId": null,
                                                      "ceGradeId": null,
                                                      "tabMarkEntryId": value
                                                          .studListUAS[i]
                                                          .tabMarkEntryId,
                                                      "isEdited": false,
                                                      "isDisabled": false
                                                    },
                                                  );
                                                }
                                              } else {
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
                                                    "Please enter mark",
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ));
                                              } else {
                                                if (value.tabulationTypeCode ==
                                                    "UAS") {
                                                  value.loadSave
                                                      ? spinkitLoader()
                                                      : await value.markEntrySave(
                                                          value.markEntryIdUAS
                                                              .toString(),
                                                          value.schoolIdUAS
                                                              .toString(),
                                                          value
                                                              .tabulationTypeCode
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
                                                      "Entered";
                                                } else {
                                                  value.loadSave
                                                      ? spinkitLoader()
                                                      : await value.markEntrySTATESave(
                                                          value.markEntryIdUAS
                                                              .toString(),
                                                          value.schoolIdUAS
                                                              .toString(),
                                                          value
                                                              .tabulationTypeCode
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
                                                      "Entered";
                                                  value.booleanList.clear();
                                                }
                                              }
                                            } catch (e) {
                                              print(e);
                                              if (e is RangeError) {
                                                snackbarWidget(
                                                    3,
                                                    "No change in Mark Entry",
                                                    context);
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

                          Consumer<MarkEntryNewProvider>(
                              builder: (context, value, child) {
                            return value.loadVerify
                                ? MaterialButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    onPressed: () {},
                                    color: Colors.green,
                                    child: const Text(
                                      'Verifying...',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )
                                : MaterialButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    //disabledColor: UIGuide.THEME_LIGHT,
                                    onPressed: value.loadCommon
                                        ? null
                                        : () {
                                            value.examStatusUAS == "Verified" ||
                                                    value.examStatusUAS ==
                                                        "Pending"
                                                ? ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                        const SnackBar(
                                                    elevation: 10,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  20)),
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
                                                      'No data to Verify....',
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ))
                                                : showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
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
                                                                    const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            8.0),
                                                                child:
                                                                    OutlinedButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                  style: ButtonStyle(
                                                                      side: MaterialStateProperty.all(const BorderSide(
                                                                          color: UIGuide
                                                                              .light_Purple,
                                                                          width:
                                                                              1.0,
                                                                          style:
                                                                              BorderStyle.solid))),
                                                                  child:
                                                                      const Text(
                                                                    '  Cancel  ',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          201,
                                                                          13,
                                                                          13),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              OutlinedButton(
                                                                onPressed:
                                                                    () async {
                                                                  List obj = [];
                                                                  obj.clear();

                                                                  // if (value.tabulationTypeCode ==
                                                                  //         "UAS" &&
                                                                  //     value.teCaptionUAS ==
                                                                  //         "Mark") {
                                                                  for (int i =
                                                                          0;
                                                                      i <
                                                                          value
                                                                              .studListUAS
                                                                              .length;
                                                                      i++) {
                                                                    obj.add(
                                                                      {
                                                                        "attendance": value
                                                                            .studListUAS[i]
                                                                            .attendance,
                                                                        "ceAttendance": value.studListUAS[i].ceAttendance,
                                                                        "peAttendance": value.studListUAS[i].peAttendance,
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
                                                                        "isEdited":
                                                                            false,
                                                                        "isDisabled":
                                                                            false,
                                                                        "isPeDisabled": value.existPeAttendance,
                                                                        "isCeDisabled": value.existCeAttendance,
                                                                        "isAttendanceDisabled": false
                                                                      },
                                                                    );
                                                                  }
                                                                  // }

                                                                  if (markEntryDivisionListController
                                                                          .text
                                                                          .isEmpty &&
                                                                      markEntryInitialValuesController
                                                                          .text
                                                                          .isEmpty) {
                                                                    ScaffoldMessenger.of(
                                                                            context)
                                                                        .showSnackBar(
                                                                            const SnackBar(
                                                                      elevation:
                                                                          10,
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.all(Radius.circular(10)),
                                                                      ),
                                                                      duration: Duration(
                                                                          seconds:
                                                                              1),
                                                                      margin: EdgeInsets.only(
                                                                          bottom:
                                                                              80,
                                                                          left:
                                                                              30,
                                                                          right:
                                                                              30),
                                                                      behavior:
                                                                          SnackBarBehavior
                                                                              .floating,
                                                                      content:
                                                                          Text(
                                                                        "Select mandatory fields...!",
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                      ),
                                                                    ));
                                                                  } else if (obj
                                                                      .isEmpty) {
                                                                    ScaffoldMessenger.of(
                                                                            context)
                                                                        .showSnackBar(
                                                                            const SnackBar(
                                                                      elevation:
                                                                          10,
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.all(Radius.circular(10)),
                                                                      ),
                                                                      duration: Duration(
                                                                          seconds:
                                                                              2),
                                                                      margin: EdgeInsets.only(
                                                                          bottom:
                                                                              80,
                                                                          left:
                                                                              30,
                                                                          right:
                                                                              30),
                                                                      behavior:
                                                                          SnackBarBehavior
                                                                              .floating,
                                                                      content:
                                                                          Text(
                                                                        "No data to verify",
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                      ),
                                                                    ));
                                                                  } else {
                                                                    value.loadVerify
                                                                        ? spinkitLoader()
                                                                        : await value.markEntryVerify(
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
                                                                    value.examStatusUAS =
                                                                        "Verified";
                                                                  }
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                style: ButtonStyle(
                                                                    side: MaterialStateProperty.all(const BorderSide(
                                                                        color: UIGuide
                                                                            .light_Purple,
                                                                        width:
                                                                            1.0,
                                                                        style: BorderStyle
                                                                            .solid))),
                                                                child:
                                                                    const Text(
                                                                  'Confirm',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            12,
                                                                            162,
                                                                            46),
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
                                    onPressed: value.loadCommon
                                        ? null
                                        : () {
                                            value.examStatusUAS == "Pending"
                                                ? ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                        const SnackBar(
                                                    elevation: 10,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  20)),
                                                    ),
                                                    duration:
                                                        Duration(seconds: 3),
                                                    margin: EdgeInsets.only(
                                                        bottom: 80,
                                                        left: 30,
                                                        right: 30),
                                                    behavior: SnackBarBehavior
                                                        .floating,
                                                    content: Text(
                                                      'No data to Delete....',
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ))
                                                : showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
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
                                                                    const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            8.0),
                                                                child:
                                                                    OutlinedButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                  style: ButtonStyle(
                                                                      side: MaterialStateProperty.all(const BorderSide(
                                                                          color: UIGuide
                                                                              .light_Purple,
                                                                          width:
                                                                              1.0,
                                                                          style:
                                                                              BorderStyle.solid))),
                                                                  child:
                                                                      const Text(
                                                                    '  Cancel  ',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          201,
                                                                          13,
                                                                          13),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              OutlinedButton(
                                                                onPressed:
                                                                    () async {
                                                                  List obj = [];
                                                                  obj.clear();

                                                                  for (int i =
                                                                          0;
                                                                      i <
                                                                          value
                                                                              .studListUAS
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
                                                                        "peMark":
                                                                            null,
                                                                        "ceMark":
                                                                            null,
                                                                        "teGrade":
                                                                            null,
                                                                        "peGrade":
                                                                            null,
                                                                        "ceGrade":
                                                                            null,
                                                                        "total": value
                                                                            .studListUAS[i]
                                                                            .total,
                                                                        "teGradeId":
                                                                            null,
                                                                        "peGradeId":
                                                                            null,
                                                                        "ceGradeId":
                                                                            null,
                                                                        "tabMarkEntryId":
                                                                            null,
                                                                        "isEdited":
                                                                            false,
                                                                        "isDisabled":
                                                                            false
                                                                      },
                                                                    );
                                                                  }

                                                                  if (markEntryDivisionListController
                                                                          .text
                                                                          .isEmpty &&
                                                                      markEntryInitialValuesController
                                                                          .text
                                                                          .isEmpty) {
                                                                    ScaffoldMessenger.of(
                                                                            context)
                                                                        .showSnackBar(
                                                                            const SnackBar(
                                                                      elevation:
                                                                          10,
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.all(Radius.circular(10)),
                                                                      ),
                                                                      duration: Duration(
                                                                          seconds:
                                                                              1),
                                                                      margin: EdgeInsets.only(
                                                                          bottom:
                                                                              80,
                                                                          left:
                                                                              30,
                                                                          right:
                                                                              30),
                                                                      behavior:
                                                                          SnackBarBehavior
                                                                              .floating,
                                                                      content:
                                                                          Text(
                                                                        "Select mandatory fields...!",
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                      ),
                                                                    ));
                                                                  } else if (obj
                                                                      .isEmpty) {
                                                                    ScaffoldMessenger.of(
                                                                            context)
                                                                        .showSnackBar(
                                                                            const SnackBar(
                                                                      elevation:
                                                                          10,
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.all(Radius.circular(10)),
                                                                      ),
                                                                      duration: Duration(
                                                                          seconds:
                                                                              2),
                                                                      margin: EdgeInsets.only(
                                                                          bottom:
                                                                              80,
                                                                          left:
                                                                              30,
                                                                          right:
                                                                              30),
                                                                      behavior:
                                                                          SnackBarBehavior
                                                                              .floating,
                                                                      content:
                                                                          Text(
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
                                                                      value.examStatusUAS =
                                                                          "Pending";
                                                                    } else {
                                                                      value.loadDelete
                                                                          ? spinkitLoader()
                                                                          : await value.markEntrySTATEDelete(
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
                                                                      value.examStatusUAS =
                                                                          "Pending";
                                                                    }
                                                                  }

                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                style: ButtonStyle(
                                                                    side: MaterialStateProperty.all(const BorderSide(
                                                                        color: UIGuide
                                                                            .light_Purple,
                                                                        width:
                                                                            1.0,
                                                                        style: BorderStyle
                                                                            .solid))),
                                                                child:
                                                                    const Text(
                                                                  'Confirm',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            12,
                                                                            162,
                                                                            46),
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
      ),
    );
  }
}
