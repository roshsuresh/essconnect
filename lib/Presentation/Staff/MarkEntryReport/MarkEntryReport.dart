import 'package:essconnect/Application/Staff_Providers/MarkReportProvider.dart';
import 'package:essconnect/Domain/Staff/MarkEntryReport.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../../Constants.dart';
import '../../../utils/constants.dart';

class MarkEntryReport extends StatefulWidget {
  MarkEntryReport({Key? key}) : super(key: key);

  @override
  State<MarkEntryReport> createState() => _MarkEntryReportState();
}

class _MarkEntryReportState extends State<MarkEntryReport> {
  String courseId = '';
  String divisionId = '';
  String partId = '';
  String subjectId = '';
  String subText = '';
  String divText = '';
  String examId = '';

  final courseController = TextEditingController();

  final courseController1 = TextEditingController();

  final partController = TextEditingController();

  final partController1 = TextEditingController();

  final examController = TextEditingController();

  final examController1 = TextEditingController();

  List divisionData = [];

  String division = '';

  List subjectData = [];

  String subject = '';

  bool checked = false;
  bool checked1 = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var p = Provider.of<MarkEntryReportProvider_stf>(context, listen: false);
      await p.courseClear();
      await p.divisionClear();
      await p.partClear();
      await p.divisionClear();
      await p.subjectClear();
      subjectData.clear();
      divisionData.clear();
      await p.divisionCounter(0);
      await p.subjectCounter(0);
      p.markReportStudList.clear();
      courseController1.clear();
      courseController.clear();
      divisionData.clear();
      partController.clear();
      partController1.clear();
      examController.clear();
      examController1.clear();
      checked = false;
      checked1 = false;
      await p.markReportcourse();
    });
  }

  Future<void> refresh() async {
    await Future.delayed(Duration(seconds: 1));
    var p = Provider.of<MarkEntryReportProvider_stf>(context, listen: false);

    await p.courseClear();
    await p.divisionClear();
    await p.partClear();
    await p.divisionClear();
    await p.subjectClear();
    subjectData.clear();
    divisionData.clear();
    await p.divisionCounter(0);
    await p.subjectCounter(0);
    p.markReportStudList.clear();
    courseController1.clear();
    courseController.clear();
    divisionData.clear();
    partController.clear();
    partController1.clear();
    examController.clear();
    examController1.clear();
    checked = false;
    checked1 = false;
    await p.markReportcourse();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Spacer(),
            const Text('Mark Entry Report'),
            const Spacer(),
            IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: MarkEntryReport(),
                        duration: const Duration(milliseconds: 300),
                      ));
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
      body: RefreshIndicator(
        strokeWidth: 4,
        color: UIGuide.light_Purple,
        onRefresh: () => refresh(),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.46,
                    child: Consumer<MarkEntryReportProvider_stf>(
                        builder: (context, snapshot, child) {
                      return InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                    child: LimitedBox(
                                  maxHeight: size.height - 300,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount:
                                          snapshot.markReportCourseList.length,
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          onTap: () async {
                                            courseController.text = snapshot
                                                    .markReportCourseList[index]
                                                    .id ??
                                                '--';
                                            courseController1.text = snapshot
                                                    .markReportCourseList[index]
                                                    .courseName ??
                                                '--';
                                            courseId = courseController.text
                                                .toString();
                                            snapshot.divisionClear();
                                            snapshot.divisionLen = 0;
                                            divisionData.clear();

                                            partController.clear();
                                            partController1.clear();
                                            snapshot.partClear();

                                            examController.clear();
                                            examController1.clear();
                                            snapshot.examClear();

                                            snapshot.subjectClear();
                                            subjectData.clear();
                                            snapshot.subjectLen = 0;

                                            await snapshot
                                                .markReportDivisionList(
                                                    courseId);

                                            Navigator.of(context).pop();
                                          },
                                          title: Text(
                                            snapshot.markReportCourseList[index]
                                                    .courseName ??
                                                '--',
                                            textAlign: TextAlign.center,
                                          ),
                                        );
                                      }),
                                ));
                              });
                        },
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: const Color.fromARGB(255, 2, 50, 90),
                                    width: 1),
                              ),
                              height: 50,
                              child: TextField(
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: UIGuide.BLACK,
                                    overflow: TextOverflow.clip),
                                textAlign: TextAlign.center,
                                controller: courseController1,
                                decoration: InputDecoration(
                                  filled: true,
                                  contentPadding:
                                      const EdgeInsets.only(left: 0, top: 0),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  fillColor:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.white, width: 1.0),
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
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                  const Spacer(),
                  Consumer<MarkEntryReportProvider_stf>(
                    builder: (context, value, child) => SizedBox(
                      width: size.width * .46,
                      height: 50,
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
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          border: Border.all(
                            color: UIGuide.light_Purple,
                            width: 1,
                          ),
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
                                  fontSize: 16,
                                ),
                              )
                            : Text(
                                "   ${value.divisionLen.toString()} Selected",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                        searchable: true,
                        chipDisplay: MultiSelectChipDisplay.none(),
                        onConfirm: (results) async {
                          divisionData = [];
                          for (var i = 0; i < results.length; i++) {
                            MarkReportDivisions data =
                                results[i] as MarkReportDivisions;
                            print(data.text);
                            print(data.value);
                            divisionData.add(data.value);
                            divisionData.map((e) => data.value);
                            print("${divisionData.map((e) => data.value)}");
                          }
                          division = divisionData.join(',');
                          await value.divisionCounter(results.length);
                          await value.partClear();
                          partController.clear();
                          partController1.clear();

                          examController.clear();
                          examController1.clear();
                          await value.examClear();

                          await value.subjectClear();
                          subjectData.clear();
                          value.subjectLen = 0;
                          await value.markReportPart(courseId);
                          results.clear();
                          print("data $division");
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.46,
                    child: Consumer<MarkEntryReportProvider_stf>(
                        builder: (context, snapshot, child) {
                      return InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                    child: LimitedBox(
                                  maxHeight: size.height - 300,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount:
                                          snapshot.markReportPartList.length,
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          onTap: () async {
                                            partController.text = snapshot
                                                    .markReportPartList[index]
                                                    .value ??
                                                '--';
                                            partController1.text = snapshot
                                                    .markReportPartList[index]
                                                    .text ??
                                                '--';
                                            partId =
                                                partController.text.toString();
                                            examController.clear();
                                            examController1.clear();
                                            snapshot.examClear();

                                            snapshot.subjectClear();
                                            subjectData.clear();
                                            snapshot.subjectLen = 0;

                                            await snapshot.markReportExam(
                                                courseId,
                                                divisionData,
                                                partId,
                                                subjectData);
                                            Navigator.of(context).pop();
                                          },
                                          title: Text(
                                            snapshot.markReportPartList[index]
                                                    .text ??
                                                '--',
                                            textAlign: TextAlign.center,
                                          ),
                                        );
                                      }),
                                ));
                              });
                        },
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: UIGuide.light_Purple, width: 1),
                              ),
                              height: 50,
                              child: TextField(
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: UIGuide.BLACK,
                                    overflow: TextOverflow.clip),
                                textAlign: TextAlign.center,
                                controller: partController1,
                                decoration: InputDecoration(
                                  filled: true,
                                  contentPadding:
                                      const EdgeInsets.only(left: 0, top: 0),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  fillColor:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
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
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                  const Spacer(),
                  SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.46,
                    child: Consumer<MarkEntryReportProvider_stf>(
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
                                                  .markReportExamList.isEmpty
                                              ? 0
                                              : snapshot
                                                  .markReportExamList.length,
                                          itemBuilder: (context, index) {
                                            return ListTile(
                                              selectedTileColor:
                                                  Colors.blue.shade100,
                                              selectedColor: UIGuide.PRIMARY2,
                                              onTap: () async {
                                                examController1.text = snapshot
                                                        .markReportExamList[
                                                            index]
                                                        .text ??
                                                    '';
                                                examController.text = snapshot
                                                        .markReportExamList[
                                                            index]
                                                        .value ??
                                                    '';
                                                examId = examController.text
                                                    .toString();

                                                snapshot.subjectClear();
                                                subjectData.clear();
                                                snapshot.subjectLen = 0;

                                                await Provider.of<
                                                            MarkEntryReportProvider_stf>(
                                                        context,
                                                        listen: false)
                                                    .markReportSubject(courseId,
                                                        divisionData, partId);
                                                Navigator.of(context).pop();
                                              },
                                              title: Text(
                                                snapshot
                                                        .markReportExamList[
                                                            index]
                                                        .text ??
                                                    '--',
                                                textAlign: TextAlign.center,
                                              ),
                                            );
                                          }),
                                    ],
                                  ),
                                ));
                              });
                        },
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: UIGuide.light_Purple, width: 1),
                              ),
                              height: 50,
                              child: TextField(
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: UIGuide.BLACK,
                                    overflow: TextOverflow.clip),
                                textAlign: TextAlign.center,
                                controller: examController1,
                                decoration: InputDecoration(
                                  filled: true,
                                  contentPadding:
                                      const EdgeInsets.only(left: 0, top: 0),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  fillColor:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.white, width: 1.0),
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
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  Consumer<MarkEntryReportProvider_stf>(
                    builder: (context, value, child) => SizedBox(
                      width: size.width * .46,
                      height: 50,
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
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          border: Border.all(
                            color: UIGuide.light_Purple,
                            width: 1,
                          ),
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
                                  fontSize: 16,
                                ),
                              )
                            : Text(
                                "   ${value.subjectLen.toString()} Selected",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.center,
                              ),
                        searchable: true,
                        chipDisplay: MultiSelectChipDisplay.none(),
                        onConfirm: (results) async {
                          subjectData = [];
                          for (var i = 0; i < results.length; i++) {
                            MarkReportSubjectList data =
                                results[i] as MarkReportSubjectList;
                            print(data.text);
                            print(data.value);
                            subjectData.add(data.value);
                            subjectData.map((e) => data.value);
                            print("${subjectData.map((e) => data.value)}");
                          }
                          subject = subjectData.join(',');
                          await value.subjectCounter(results.length);
                          results.clear();

                          print("data $subject");
                        },
                      ),
                    ),
                  ),
                  const Spacer(),
                  Checkbox(
                    activeColor: UIGuide.WHITE,
                    checkColor: UIGuide.light_Purple,
                    value: checked,
                    onChanged: (value) async {
                      setState(() {
                        checked = value!;
                      });
                    },
                  ),
                  SizedBox(
                    width: size.width * .35,
                    height: 46,
                    child: const Center(
                      child: Text(
                        'Show options Separately',
                        style: TextStyle(fontSize: 14),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  Checkbox(
                    activeColor: UIGuide.WHITE,
                    checkColor: UIGuide.light_Purple,
                    value: checked1,
                    onChanged: (value) async {
                      setState(() {
                        checked1 = value!;
                      });
                    },
                  ),
                  SizedBox(
                    width: size.width * .35,
                    height: 46,
                    child: const Center(
                      child: Text(
                        'Show Subsubjects Separately',
                        style: TextStyle(fontSize: 14),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Spacer(),
                  SizedBox(
                    height: 48,
                    width: MediaQuery.of(context).size.width * 0.46,
                    child: MaterialButton(
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      color: UIGuide.light_Purple,
                      onPressed: () async {
                        Provider.of<MarkEntryReportProvider_stf>(context,
                                listen: false)
                            .markReportStudList
                            .clear();

                        await Provider.of<MarkEntryReportProvider_stf>(context,
                                listen: false)
                            .markReportView(courseId, divisionId, partId,
                                examId, subjectId, subText, divText);
                      },
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
                ],
              ),
            ),
            kheight20,
            //const UASmarkentryReport()
          ],
        ),
      ),
    );
  }
}
