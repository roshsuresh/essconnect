import 'package:essconnect/Application/Staff_Providers/MarkEntryNewProvider.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
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
      // await p.clearStudentMEList();
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
        body: Consumer<MarkEntryNewProvider>(builder: (context, value, child) {
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
                                                  selectedColor:
                                                      UIGuide.PRIMARY2,
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
                                                            courseId,
                                                            divisionId);

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
                                      controller:
                                          markEntryDivisionListController,
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

                                                    partItems = snapshot
                                                        .markEntryPartList[
                                                            index]
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
                                          color: UIGuide.light_Purple,
                                          width: 1),
                                    ),
                                    height: 40,
                                    child: TextField(
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
                                      controller:
                                          markEntrySubjectListController,
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
                                                                  .text
                                                                  .toString();

                                                      print(optionSub);
                                                      print(subsubject);

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
                                            itemCount: snapshot
                                                .markEntryExamList.length,
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
                                  date = DateFormat('dd/MMM/yyyy')
                                      .format(DateTime.now());
                                  print(DateFormat('dd/MMM/yyyy')
                                      .format(DateTime.now()));

                                  String course =
                                      markEntryInitialValuesController.text
                                          .toString();
                                  String division =
                                      markEntryDivisionListController.text
                                          .toString();
                                  String part = markEntryPartListController.text
                                      .toString();
                                  String subject =
                                      markEntrySubjectListController.text
                                          .toString();
                                  String exam = markEntryExamListController.text
                                      .toString();

                                  // await Provider.of<MarkEntryNewProvider>(context,
                                  //         listen: false)
                                  //     .clearStudentMEList();

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
                                  // value.gradeList.clear();

                                  await value.getMarkEntryView(
                                      course,
                                      date!,
                                      division,
                                      exam,
                                      part,
                                      subject,
                                      subsubject.toString(),
                                      optionSub.toString(),
                                      value.typecode.toString(),
                                      partItems);

                                  // await value.getMarkEntryView(course, date!,
                                  //     division, exam, part, subject);
                                  // maxScrore = value.maxmarkList[0].teMax;

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
                ]);
        }));
  }
}
