import 'dart:developer';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:open_file/open_file.dart';
import 'package:essconnect/Application/Staff_Providers/MarkEntryNewProvider.dart';
import 'package:essconnect/Constants.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:essconnect/utils/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class MarkEntryNew extends StatefulWidget {
  const MarkEntryNew({Key? key}) : super(key: key);

  @override
  State<MarkEntryNew> createState() => _MarkEntryNewState();
}

class _MarkEntryNewState extends State<MarkEntryNew> {
  final List<TextEditingController> _controllers = [];
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
  final ReceivePort _port = ReceivePort();
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
      IsolateNameServer.registerPortWithName(_port.sendPort, 'downloader_send_port');
    });

    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = DownloadTaskStatus.values[data[1]];
      int progress = data[2];

      _handleDownloadUpdate(id, status, progress);
    });

    FlutterDownloader.registerCallback(downloadCallback);
  }
  @pragma('vm:entry-point')
  static void downloadCallback(String id, int status, int progress) {
    final SendPort? send = IsolateNameServer.lookupPortByName('downloader_send_port');
    send?.send([id, status, progress]);
  }

  void _handleDownloadUpdate(String taskId, DownloadTaskStatus status, int progress) {
    if (status == DownloadTaskStatus.complete) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("File Downloaded"),
            action: SnackBarAction(
              label: "Open",
              onPressed: () async {
                await OpenFile.open("$localPath/$filename");

                // print("downloaded");
              },
            ),
            duration: Duration(seconds: 10),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(bottom: 40, left: 30, right: 30),
            elevation: 10,
          ),
        );
      });
    } else if (status == DownloadTaskStatus.failed) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Download Failed. Please try again."),
            duration: Duration(seconds: 5),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(bottom: 40, left: 30, right: 30),
            elevation: 10,
          ),
        );
      });
    }
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
  bool absovar = false;
  final GlobalKey<FormFieldState<String>> dropdownKey = GlobalKey<FormFieldState<String>>();
  String? localPath;
  String? filename;
  Future<void> requestDownload(String url) async {

    if (Platform.isAndroid) {
      localPath = '/storage/emulated/0/Download/e-SS Connect';
    } else if (Platform.isIOS) {
      final dir = await getApplicationDocumentsDirectory();
      localPath = dir.path;
    }
    print("pathhhh  $localPath");
    final savedDir = Directory(localPath!);
    await savedDir.create(recursive: true);

    filename = "Mark_Deatils_${DateTime.now().microsecondsSinceEpoch}.pdf";
    String? taskId = await FlutterDownloader.enqueue(
      url: url,
      savedDir: localPath!,
      fileName: filename,
      showNotification: true,
      openFileFromNotification: false,
    );

    if (taskId != null) {
      _trackDownloadStatus(taskId, localPath!, filename!);
    }
  }

  void _trackDownloadStatus(String taskId, String localPath, String filename) {
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = DownloadTaskStatus.values[data[1]];
      int progress = data[2];

      if (id == taskId) {
        if (status == DownloadTaskStatus.complete) {
          // Display SnackBar once download is complete
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("File Downloaded"),
                action: SnackBarAction(
                  label: "Open",
                  onPressed: () async {
                    await OpenFile.open("$localPath/$filename");
                  },
                ),
                duration: Duration(seconds: 10),
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.only(bottom: 40, left: 30, right: 30),
                elevation: 10,
              ),
            );
          });
        } else if (status == DownloadTaskStatus.failed) {
          // Handle download failure
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Download Failed. Please try again."),
                duration: Duration(seconds: 5),
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.only(bottom: 40, left: 30, right: 30),
                elevation: 10,
              ),
            );
          });
        }
      }
    });
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var provider = Provider.of<MarkEntryNewProvider>(context);
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
          String? selectedCourseName = markEntryInitialValuesController1.text.isNotEmpty
              ? markEntryInitialValuesController1.text
              : null;
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
                      GestureDetector(
                        onTap: () async {
                          if (value.studListUAS.any((student) => student.isEdited == true)) {
                            showDialog(context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Unsaved Changes"),
                                  content: Text(
                                      "You have unsaved changes. Do you want to continue without saving?"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(false); // User chose "Cancel"
                                      },
                                      child: Text("Cancel",style: TextStyle(color: Color.fromARGB(255, 7, 68, 126)),),
                                    ),
                                    TextButton(
                                      onPressed: () async {

                                        // for(int i=0;i<value.studListUAS.length;i++){
                                        //   value.studListUAS[i].isEdited = false;
                                        // }
                                        // User chose "Continue"
                                        // markEntryInitialValuesController.text = selectedCourse.id ?? '--';
                                        // markEntryInitialValuesController1.text = selectedCourse.courseName ?? '--';
                                        // courseId = markEntryInitialValuesController.text;

                                        // Clear and update related fields
                                        markEntryDivisionListController.clear();
                                        markEntryDivisionListController1.clear();
                                        await provider.divisionClear();

                                        markEntryPartListController.clear();
                                        markEntryPartListController1.clear();
                                        await provider.removeAllpartClear();

                                        markEntrySubjectListController.clear();
                                        markEntrySubjectListController1.clear();
                                        await provider.removeAllSubjectClear();

                                        markEntryOptionSubListController.clear();
                                        markEntryOptionSubListController1.clear();
                                        await provider.removeAllOptionSubjectListClear();

                                        markEntryExamListController.clear();
                                        markEntryExamListController1.clear();
                                        await provider.removeAllExamClear();

                                        await provider.getMarkEntryDivisionValues(courseId, context);
                                        await value.clearStudentMEList();
                                        Navigator.of(context).pop(true);
                                      },
                                      child: Text("Continue",style: TextStyle(color: Color.fromARGB(255, 7, 68, 126)),),

                                    ),
                                  ],
                                );
                              },);
                          }

                        },
                        child: AbsorbPointer(
                          absorbing:value.studListUAS.any((student) => student.isEdited == true)?true:false,
                          child: SizedBox(
                            width: size.width * .45,
                            height: size.height * .06,
                            child:  DropdownButtonFormField<String>(
                              isExpanded: true,
                              value: markEntryInitialValuesController1.text.isNotEmpty
                                  ? markEntryInitialValuesController1.text
                                  : null,
                              hint: Text("Course",),
                              items:provider.markEntryInitialValues
                                  .map((section) => DropdownMenuItem<String>(
                                value: section.courseName,
                                child: Text(section.courseName!),
                              ))
                                  .toList(),

                              //provider.markEntryInitialValues.map((item) => item.courseName ?? '--').toList(),
                              onChanged: (newValue) async {
                                if (provider.loading) return;

                                final selectedCourse = provider.markEntryInitialValues.firstWhere(
                                      (item) => item.courseName == newValue,
                                );

                                if (selectedCourse != null) {
                                  // Update controllers
                                  markEntryInitialValuesController.text = selectedCourse.id ?? '--';
                                  markEntryInitialValuesController1.text = selectedCourse.courseName ?? '--';
                                  courseId = markEntryInitialValuesController.text;

                                  // Clear and update related fields
                                  markEntryDivisionListController.clear();
                                  markEntryDivisionListController1.clear();
                                  await provider.divisionClear();

                                  markEntryPartListController.clear();
                                  markEntryPartListController1.clear();
                                  await provider.removeAllpartClear();

                                  markEntrySubjectListController.clear();
                                  markEntrySubjectListController1.clear();
                                  await provider.removeAllSubjectClear();

                                  markEntryOptionSubListController.clear();
                                  markEntryOptionSubListController1.clear();
                                  await provider.removeAllOptionSubjectListClear();

                                  markEntryExamListController.clear();
                                  markEntryExamListController1.clear();
                                  await provider.removeAllExamClear();

                                  await provider.getMarkEntryDivisionValues(courseId, context);
                                  await value.clearStudentMEList();
                                }
                              },
                              decoration:customInputDecoration(),
                            ),


                          ),
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () async {
                          if (value.studListUAS.any((student) => student.isEdited == true)) {
                            showDialog(context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Unsaved Changes"),
                                  content: Text(
                                      "You have unsaved changes. Do you want to continue without saving?"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(false); // User chose "Cancel"
                                      },
                                      child: Text("Cancel",style: TextStyle(color: Color.fromARGB(255, 7, 68, 126)),),
                                    ),
                                    TextButton(
                                      onPressed: () async {

                                        // Update controllers
                                        // markEntryDivisionListController.text = selectedDivision.value ?? '---';
                                        // markEntryDivisionListController1.text = selectedDivision.text ?? '---';
                                        divisionId = markEntryDivisionListController.text;
                                        courseId = markEntryInitialValuesController.text;

                                        // Clear and update related fields
                                        markEntryPartListController.clear();
                                        markEntryPartListController1.clear();
                                        await provider.removeAllpartClear();

                                        markEntrySubjectListController.clear();
                                        markEntrySubjectListController1.clear();
                                        await provider.removeAllSubjectClear();

                                        markEntryOptionSubListController.clear();
                                        markEntryOptionSubListController1.clear();
                                        await provider.removeAllOptionSubjectListClear();

                                        markEntryExamListController.clear();
                                        markEntryExamListController1.clear();
                                        await provider.removeAllExamClear();

                                        await provider.getMarkEntryPartValues(courseId, divisionId, context);
                                        await value.clearStudentMEList();
                                        Navigator.of(context).pop(true);
                                      },
                                      child: Text("Continue",style: TextStyle(color: Color.fromARGB(255, 7, 68, 126)),),

                                    ),
                                  ],
                                );
                              },);
                          }

                        },
                        child: AbsorbPointer(
                          absorbing:value.studListUAS.any((student) => student.isEdited == true)?true:false,
                          child: SizedBox(
                            width: size.width * .45,
                            height: size.height * .06,
                            child:  DropdownButtonFormField<String>(
                              isExpanded: true,
                              value: markEntryDivisionListController1.text.isNotEmpty
                                  ? markEntryDivisionListController1.text
                                  : null,
                              hint: Text("Division"),

                              items:
                              provider.markEntryDivisionList
                                  .map((section) => DropdownMenuItem<String>(
                                value: section.text,
                                child: Text(section.text!),
                              ))
                                  .toList(),
                              decoration: customInputDecoration(),


                              onChanged: (newValue) async {
                                if (provider.loading) return;

                                final selectedDivision = provider.markEntryDivisionList.firstWhere(
                                      (item) => item.text == newValue,

                                );

                                if (selectedDivision != null) {
                                  // Update controllers
                                  markEntryDivisionListController.text = selectedDivision.value ?? '---';
                                  markEntryDivisionListController1.text = selectedDivision.text ?? '---';
                                  divisionId = markEntryDivisionListController.text;
                                  courseId = markEntryInitialValuesController.text;

                                  // Clear and update related fields
                                  markEntryPartListController.clear();
                                  markEntryPartListController1.clear();
                                  await provider.removeAllpartClear();

                                  markEntrySubjectListController.clear();
                                  markEntrySubjectListController1.clear();
                                  await provider.removeAllSubjectClear();

                                  markEntryOptionSubListController.clear();
                                  markEntryOptionSubListController1.clear();
                                  await provider.removeAllOptionSubjectListClear();

                                  markEntryExamListController.clear();
                                  markEntryExamListController1.clear();
                                  await provider.removeAllExamClear();

                                  await provider.getMarkEntryPartValues(courseId, divisionId, context);
                                  await value.clearStudentMEList();
                                }
                              },

                            ),

                          ),
                        ),
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
                      GestureDetector(
                        onTap: () async {
                          if (value.studListUAS.any((student) => student.isEdited == true)) {
                            showDialog(context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Unsaved Changes"),
                                  content: Text(
                                      "You have unsaved changes. Do you want to continue without saving?"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(false); // User chose "Cancel"
                                      },
                                      child: Text("Cancel",style: TextStyle(color: Color.fromARGB(255, 7, 68, 126)),),
                                    ),
                                    TextButton(
                                      onPressed: () async {

                                        // partItems = selectedPart.toJson();
                                        // print(partItems);

                                        divisionId = markEntryDivisionListController.text;
                                        partId = markEntryPartListController.text;

                                        // Clear and update related fields
                                        markEntrySubjectListController.clear();
                                        markEntrySubjectListController1.clear();
                                        await provider.removeAllSubjectClear();

                                        markEntryOptionSubListController.clear();
                                        markEntryOptionSubListController1.clear();
                                        await provider.removeAllOptionSubjectListClear();

                                        markEntryExamListController.clear();
                                        markEntryExamListController1.clear();
                                        await provider.removeAllExamClear();

                                        await provider.getMarkEntrySubjectValues(divisionId, partId, context);
                                        await value.clearStudentMEList();
                                        Navigator.of(context).pop(true);
                                      },
                                      child: Text("Continue",style: TextStyle(color: Color.fromARGB(255, 7, 68, 126)),),

                                    ),
                                  ],
                                );
                              },);
                          }

                        },
                        child: AbsorbPointer(
                          absorbing:value.studListUAS.any((student) => student.isEdited == true)?true:false,
                          child: SizedBox(
                            width: size.width * .45,
                            height: size.height * .06,
                            child:  DropdownButtonFormField<String>(
                              isExpanded: true,
                              value: markEntryPartListController1.text.isNotEmpty
                                  ? markEntryPartListController1.text
                                  : null,
                              hint: Text("Part"),
                              items: provider.markEntryPartList
                                  .map((section) => DropdownMenuItem<String>(
                                value: section.text,
                                child: Text(section.text!),
                              ))
                                  .toList(),
                              decoration: customInputDecoration(),
                              //provider.markEntryPartList.map((item) => item.text ?? '---').toList(),
                              onChanged: (newValue) async {
                                if (provider.loading) return;

                                final selectedPart = provider.markEntryPartList.firstWhere(
                                      (item) => item.text == newValue,

                                );

                                if (selectedPart != null) {
                                  // Update controllers
                                  markEntryPartListController.text = selectedPart.value ?? '--';
                                  markEntryPartListController1.text = selectedPart.text ?? '--';
                                  partItems = selectedPart.toJson();
                                  print(partItems);

                                  divisionId = markEntryDivisionListController.text;
                                  partId = markEntryPartListController.text;

                                  // Clear and update related fields
                                  markEntrySubjectListController.clear();
                                  markEntrySubjectListController1.clear();
                                  await provider.removeAllSubjectClear();

                                  markEntryOptionSubListController.clear();
                                  markEntryOptionSubListController1.clear();
                                  await provider.removeAllOptionSubjectListClear();

                                  markEntryExamListController.clear();
                                  markEntryExamListController1.clear();
                                  await provider.removeAllExamClear();

                                  await provider.getMarkEntrySubjectValues(divisionId, partId, context);
                                  await value.clearStudentMEList();
                                }
                              },
                            ),

                          ),
                        ),
                      ),

                      const Spacer(),
                      GestureDetector(
                        onTap: () async {
                          if (value.studListUAS.any((student) => student.isEdited == true)) {
                            showDialog(context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Unsaved Changes"),
                                  content: Text(
                                      "You have unsaved changes. Do you want to continue without saving?"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(false); // User chose "Cancel"
                                      },
                                      child: Text("Cancel",style: TextStyle(color: Color.fromARGB(255, 7, 68, 126)),),
                                    ),
                                    TextButton(
                                      onPressed: () async {

                                        // Fetch IDs
                                        divisionId = markEntryDivisionListController.text;
                                        partId = markEntryPartListController.text;
                                        subjectId = markEntrySubjectListController.text;

                                        // Clear option and exam lists and reload based on selection
                                        markEntryOptionSubListController.clear();
                                        markEntryOptionSubListController1.clear();
                                        await provider.removeAllOptionSubjectListClear();

                                        markEntryExamListController.clear();
                                        markEntryExamListController1.clear();
                                        await provider.removeAllExamClear();

                                        subsubject = null;
                                        optionSub = null;
                                        subDescription = null;

                                        // Load new option subjects and exams
                                        await provider.getMarkEntryOptionSubject(subjectId, divisionId, partId, context);
                                        if (provider.markEntryOptionSubjectList.isEmpty) {
                                          await provider.getMarkEntryExamValues(
                                            subjectId, divisionId, partId, markEntryOptionSubListController1.text, context,
                                          );
                                        }

                                        await value.clearStudentMEList();
                                        Navigator.of(context).pop(true);
                                      },
                                      child: Text("Continue",style: TextStyle(color: Color.fromARGB(255, 7, 68, 126)),),

                                    ),
                                  ],
                                );
                              },);
                          }

                        },
                        child: AbsorbPointer(
                          absorbing:value.studListUAS.any((student) => student.isEdited == true)?true:false,
                          child: SizedBox(
                            width: size.width * .45,
                            height: size.height * .06,
                            child:  DropdownButtonFormField<String>(
                              isExpanded: true,
                              value: markEntrySubjectListController1.text.isNotEmpty
                                  ? markEntrySubjectListController1.text
                                  : null,
                              hint: Text("Subject"),

                              items:provider.markEntrySubjectList
                                  .map((section) => DropdownMenuItem<String>(
                                value: section.text,
                                child: Text(section.text!),
                              ))
                                  .toList(),
                              decoration: customInputDecoration(),
                              //provider.markEntrySubjectList.map((item) => item.text ?? '---').toList(),
                              onChanged: (newValue) async {
                                if (provider.loading) return;

                                final selectedSubject = provider.markEntrySubjectList.firstWhere(
                                      (item) => item.text == newValue,

                                );

                                if (selectedSubject != null) {
                                  // Update controllers with selected subject
                                  markEntrySubjectListController.text = selectedSubject.value ?? '---';
                                  markEntrySubjectListController1.text = selectedSubject.text ?? '---';

                                  // Fetch IDs
                                  divisionId = markEntryDivisionListController.text;
                                  partId = markEntryPartListController.text;
                                  subjectId = markEntrySubjectListController.text;

                                  // Clear option and exam lists and reload based on selection
                                  markEntryOptionSubListController.clear();
                                  markEntryOptionSubListController1.clear();
                                  await provider.removeAllOptionSubjectListClear();

                                  markEntryExamListController.clear();
                                  markEntryExamListController1.clear();
                                  await provider.removeAllExamClear();

                                  subsubject = null;
                                  optionSub = null;
                                  subDescription = null;

                                  // Load new option subjects and exams
                                  await provider.getMarkEntryOptionSubject(subjectId, divisionId, partId, context);
                                  if (provider.markEntryOptionSubjectList.isEmpty) {
                                    await provider.getMarkEntryExamValues(
                                      subjectId, divisionId, partId, markEntryOptionSubListController1.text, context,
                                    );
                                  }

                                  await value.clearStudentMEList();
                                }
                              },
                            ),
                          ),
                        ),
                      ),

                      const Spacer(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    children: [
                      provider.markEntryOptionSubjectList.isEmpty ? SizedBox(
                        height: 0,
                        width: 0,
                      ): Spacer(),
                      provider.markEntryOptionSubjectList.isEmpty ?
                      SizedBox(
                        height: 0,
                        width: 0,
                      ):


                      GestureDetector(
                        onTap: () async {
                          if (value.studListUAS.any((student) => student.isEdited == true)) {
                            showDialog(context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Unsaved Changes"),
                                  content: Text(
                                      "You have unsaved changes. Do you want to continue without saving?"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(false); // User chose "Cancel"
                                      },
                                      child: Text("Cancel",style: TextStyle(color: Color.fromARGB(255, 7, 68, 126)),),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        // Clear previous exam list and update with new options
                                        markEntryExamListController.clear();
                                        markEntryExamListController1.clear();
                                        // await provider.removeAllExamClear();
                                        //
                                        // String descr = selectedOption.subjectDescription == "Sub Subject"
                                        //     ? "subSubject"
                                        //     : "optionSubject";
                                        //
                                        // await provider.getMarkEntryExamValuesOPtion(
                                        //   subjectId,
                                        //   divisionId,
                                        //   partId,
                                        //   markEntryOptionSubListController1.text,
                                        //   descr,
                                        //   context,
                                        // );

                                        await value.clearStudentMEList();
                                        Navigator.of(context).pop(true);
                                      },
                                      child: Text("Continue",style: TextStyle(color: Color.fromARGB(255, 7, 68, 126)),),

                                    ),
                                  ],
                                );
                              },);
                          }

                        },
                        child: AbsorbPointer(
                          absorbing:value.studListUAS.any((student) => student.isEdited == true)?true:false,
                          child: SizedBox(
                            width: size.width * .45,
                            height: size.height * .06,
                            child: DropdownButtonFormField<String>(
                              isExpanded: true,
                              value: markEntryOptionSubListController.text.isNotEmpty
                                  ? markEntryOptionSubListController.text
                                  : null,
                              hint: provider.markEntryOptionSubjectList[0].subjectDescription == "Sub Subject"
                                  ? Text("Select Sub Subject")
                                  : Text("Select Option"),

                              items: provider.markEntryOptionSubjectList
                                  .map((section) => DropdownMenuItem<String>(
                                value: section.subjectName,
                                child: Text(section.subjectName!),
                              ))
                                  .toList(),
                              decoration: customInputDecoration(),
                              onChanged: (newValue) async {
                                final selectedOption = provider.markEntryOptionSubjectList.firstWhere(
                                      (item) => item.subjectName == newValue,

                                );

                                if (selectedOption != null) {
                                  // Update controllers with selected option
                                  markEntryOptionSubListController.text = selectedOption.subjectName ?? '--';
                                  markEntryOptionSubListController1.text = selectedOption.id ?? '--';
                                  subDescription = selectedOption.subjectDescription;

                                  // Set the correct type based on the subject description
                                  if (selectedOption.subjectDescription == 'Option Subject') {
                                    optionSub = markEntryOptionSubListController1.text;
                                    subsubject = null;
                                  } else {
                                    subsubject = markEntryOptionSubListController1.text;
                                    optionSub = null;
                                  }

                                  // Clear previous exam list and update with new options
                                  markEntryExamListController.clear();
                                  markEntryExamListController1.clear();
                                  await provider.removeAllExamClear();

                                  String descr = selectedOption.subjectDescription == "Sub Subject"
                                      ? "subSubject"
                                      : "optionSubject";

                                  await provider.getMarkEntryExamValuesOPtion(
                                    subjectId,
                                    divisionId,
                                    partId,
                                    markEntryOptionSubListController1.text,
                                    descr,
                                    context,
                                  );

                                  await value.clearStudentMEList();
                                }
                              },
                            ),
                          ),
                        ),
                      ),

                      const Spacer(),
                      GestureDetector(
                        onTap: () async {
                          if (value.studListUAS.any((student) => student.isEdited == true)) {
                            showDialog(context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Unsaved Changes"),
                                  content: Text(
                                      "You have unsaved changes. Do you want to continue without saving?"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(false); // User chose "Cancel"
                                      },
                                      child: Text("Cancel",style: TextStyle(color: Color.fromARGB(255, 7, 68, 126)),),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        await value.clearStudentMEList();
                                        Navigator.of(context).pop(true);
                                      },
                                      child: Text("Continue",style: TextStyle(color: Color.fromARGB(255, 7, 68, 126)),),

                                    ),
                                  ],
                                );
                              },);
                          }

                        },
                        child: AbsorbPointer(
                          absorbing:value.studListUAS.any((student) => student.isEdited == true)?true:false,
                          child: SizedBox(
                            width: size.width * .45,
                            height: size.height * .06,
                            child: DropdownButtonFormField<String>(
                              isExpanded: true,
                              value: markEntryExamListController.text.isNotEmpty
                                  ? markEntryExamListController.text
                                  : null,
                              hint: Text("Select Exam"),

                              items: provider.markEntryExamList
                                  .map((section) => DropdownMenuItem<String>(
                                value: section.text,
                                child: Text(section.text!),
                              ))
                                  .toList(),
                              decoration: customInputDecoration(),
                              onChanged: (newValue) async {
                                final selectedExam = provider.markEntryExamList.firstWhere(
                                      (item) => item.text == newValue,

                                );

                                if (selectedExam != null) {
                                  // Update controllers with selected exam
                                  markEntryExamListController.text = selectedExam.text ?? '--';
                                  markEntryExamListController1.text = selectedExam.value ?? '--';

                                  // Clear the student ME list after selecting a new exam
                                  await value.clearStudentMEList();
                                }
                              },
                            ),

                          ),
                        ),
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
                      child: GestureDetector(

                          onTap: () async {
                            print("ediiytt ${value.studListUAS[0].isEdited}");
                            if (value.studListUAS.any((student) => student.isEdited == true)) {
                              showDialog(context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Unsaved Changes"),
                                    content: Text(
                                        "You have unsaved changes. Do you want to continue without saving?"),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(false); // User chose "Cancel"
                                        },
                                        child: Text("Cancel",style: TextStyle(color: Color.fromARGB(255, 7, 68, 126)),),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          await value.clearStudentMEList();
                                          await value.terminatedCheckbox();
                                          Navigator.of(context).pop(true);
                                        },
                                        child: Text("Continue",style: TextStyle(color: Color.fromARGB(255, 7, 68, 126)),),

                                      ),
                                    ],
                                  );
                                },);
                            }
                            else{
                              await value.clearStudentMEList();
                              await value.terminatedCheckbox();
                            }

                          },

                          child: Row(
                            children: [
                              Checkbox(
                                activeColor: UIGuide.light_Purple,
                                value: value.isTerminated,
                                onChanged: (newValue) async {
                                   // print("ediitt ${value.studListUAS[0].isEdited}");
                                  if (value.studListUAS.any((student) => student.isEdited == true)) {
                                    showDialog(context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text("Unsaved Changes"),
                                          content: Text(
                                              "You have unsaved changes. Do you want to continue without saving?"),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop(false); // User chose "Cancel"
                                              },
                                              child: Text("Cancel",style: TextStyle(color: Color.fromARGB(255, 7, 68, 126)),),
                                            ),
                                            TextButton(
                                              onPressed: () async {
                                                await value.clearStudentMEList();
                                                await value.terminatedCheckbox();
                                                Navigator.of(context).pop(true);
                                              },
                                              child: Text("Continue",style: TextStyle(color: Color.fromARGB(255, 7, 68, 126)),),

                                            ),
                                          ],
                                        );
                                      },);
                                  }
                                  else{
                                    await value.clearStudentMEList();
                                    await value.terminatedCheckbox();
                                  }
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
                        : GestureDetector(
                      onTap: () async {
                        if (value.studListUAS.any((student) => student.isEdited == true)) {
                          showDialog(context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Unsaved Changes"),
                                content: Text(
                                    "You have unsaved changes. Do you want to continue without saving?"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(false); // User chose "Cancel"
                                    },
                                    child: Text("Cancel",style: TextStyle(color: Color.fromARGB(255, 7, 68, 126)),),
                                  ),
                                  TextButton(
                                    onPressed: () async {
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
                                              context,
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
                                      Navigator.of(context).pop(true);
                                    },
                                    child: Text("Continue",style: TextStyle(color: Color.fromARGB(255, 7, 68, 126)),),

                                  ),
                                ],
                              );
                            },);
                        }

                      },
                      child: AbsorbPointer(
                        absorbing:value.studListUAS.any((student) => student.isEdited == true)?true:false,
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
                                    context,
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
                          }
                          ),
                          child: const Text(
                            'View',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                  ],
                ),
                value.examStatusUAS == "Entered"||value.examStatusUAS == "Verified"
                    ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Last Entered By : ",
                        style: TextStyle(
                            color: Colors.black54, fontSize: 13)),
                    Text(value.staffNameUAS ?? "--",
                        style: const TextStyle(
                            color: Colors.black, fontSize: 13))
                  ],
                )
                    : const SizedBox(
                  height: 0,
                  width: 0,
                ),

                value.examStatusUAS == "Verified"
                    ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Verified By : ",
                        style: TextStyle(
                            color: Colors.green, fontSize: 13)),
                    Text(value.verifiedStaffName ?? "--",
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
                        return
                          Expanded(
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
                                            ? _controllers[index].text = provider.studListUAS[index].teMark == null
                                            ? _controllers[index].text
                                            : (provider.studListUAS[index].teMark! % 1 == 0
                                            ? provider.studListUAS[index].teMark!.toInt().toString()  // Convert to integer if no decimal part
                                            : provider.studListUAS[index].teMark!.toString())         // Keep as is if it has decimals
                                            : _controllers[index].text;


                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Container(
                                            height: size.height*0.14,
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
                                                              provider
                                                                  .studListUAS[
                                                              index].isEdited=true;
                                                              print("eddditt ${   provider
                                                                  .studListUAS[
                                                              index].isEdited}");

                                                              print(
                                                                  "attendaceeeee   $attendancee");
                                                            });



                                                          },
                                                          child: Container(
                                                            color:
                                                            Colors.transparent,
                                                            width: size.width*0.06,
                                                            height: size.height*0.04,
                                                            child: SizedBox(
                                                                width: size.width*0.06,
                                                                height:  size.height*0.04,
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
                                                          height: size.height*0.042,
                                                          width: size.width*0.25,
                                                          child:
                                                          TextField(
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
                                                              setState(() {
                                                                provider
                                                                    .studListUAS[
                                                                index].isEdited=true;
                                                              });

                                                              print("dsdsdd ${provider
                                                                  .studListUAS[
                                                              index].isEdited=true}");
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
                                                              provider.studListUAS[index].teMark=double.tryParse(_controllers[index].text);

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
                                                            width: 80,
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
                                          height: size.height*0.098,
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
                                                child: SizedBox(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                    children: [
                                                      SizedBox(
                                                        width: size.width*0.3,
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
                                                          ],
                                                        ),
                                                      ),

                                                      kWidth,
                                                      Text(
                                                          '${value.teCaptionUAS ?? ""} : '),
                                                      SizedBox(
                                                        height: size.height * 0.048,
                                                        width: 100,
                                                        child: Consumer<MarkEntryNewProvider>(
                                                          builder: (context, snapshot, child) {
                                                            return DropdownButtonFormField<String>(
                                                              value: provider.studListUAS[index].teGrade?.isNotEmpty == true
                                                                  ? provider.studListUAS[index].teGrade
                                                                  : null,
                                                              items: [
                                                                DropdownMenuItem<String>(
                                                                  value: "-Select-",
                                                                  child: Text(
                                                                    "-Select-",
                                                                    style: TextStyle(color: Colors.grey),
                                                                  ),
                                                                ),
                                                                ...snapshot.gradeListUAS.map((grade) {
                                                                  return DropdownMenuItem<String>(
                                                                    value: grade.value,
                                                                    child: Text(
                                                                      grade.text ?? '--',
                                                                      textAlign: TextAlign.center,
                                                                    ),
                                                                  );
                                                                }).toList(),
                                                              ],
                                                              decoration: InputDecoration(
                                                                contentPadding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
                                                                border: OutlineInputBorder(
                                                                  borderRadius: BorderRadius.circular(8.0),
                                                                ),
                                                                focusedBorder: OutlineInputBorder(
                                                                  borderSide: BorderSide(color: UIGuide.light_Purple),
                                                                ),
                                                                labelText: "Select",
                                                                labelStyle: TextStyle(color: UIGuide.light_Purple),
                                                                filled: true,
                                                                fillColor: Colors.white,
                                                              ),
                                                              onChanged: (value.examStatusUAS != 'Synchronized')
                                                                  ? (newValue) {
                                                                if (newValue == "-Select-" || newValue == null) {
                                                                  provider.studListUAS[index].teGrade = null;
                                                                  gradeListController[index].clear();
                                                                  gradeListController1[index].clear();
                                                                } else {
                                                                  provider.studListUAS[index].teGrade = newValue;
                                                                  gradeListController[index].text = snapshot.gradeListUAS
                                                                      .firstWhere((grade) => grade.value == newValue)
                                                                      .text ?? '--';
                                                                  gradeListController1[index].text = newValue;
                                                                }
                                                                provider.studListUAS[index].isEdited = true;
                                                                print("Updated teGrade: ${provider.studListUAS[index].teGrade}");
                                                              }
                                                                  : null,
                                                            );
                                                          },
                                                        ),
                                                      ),



                                                    ],
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
                                                        child: Consumer<MarkEntryNewProvider>(
                                                          builder: (context, snapshot, child) {
                                                            return Padding(
                                                              padding: const EdgeInsets.all(5.0),
                                                              child: Column(
                                                                mainAxisSize: MainAxisSize.min,
                                                                children: [
                                                                  SizedBox(
                                                                    height: 30,
                                                                    child: DropdownButtonFormField<String>(
                                                                      isExpanded: true,
                                                                      value: publicGradeController[index].text.isEmpty
                                                                          ? null
                                                                          : publicGradeController[index].text, // Default to null if empty
                                                                      decoration: const InputDecoration(
                                                                        filled: true,
                                                                        contentPadding: EdgeInsets.only(left: 0, top: 0),
                                                                        floatingLabelBehavior: FloatingLabelBehavior.never,
                                                                        fillColor: Color.fromARGB(255, 255, 255, 255),
                                                                        border: OutlineInputBorder(),
                                                                        focusedBorder: OutlineInputBorder(
                                                                          borderSide: BorderSide(color: UIGuide.light_Purple),
                                                                        ),
                                                                        labelText: "Select",
                                                                        hintText: "Grade",
                                                                      ),
                                                                      onChanged: value.examStatusUAS != 'Synchronized'
                                                                          ? (newValue) {
                                                                        publicGradeController[index].text = newValue ?? '--';
                                                                        provider.studListUAS[index].teGrade = newValue ?? '--';

                                                                        if (newValue == "-Select-" || newValue == null) {
                                                                          // Handle "-Select-" as null
                                                                          provider.studListUAS[index].teGrade = null;
                                                                          publicGradeController[index].clear();
                                                                          publicGradeController1[index].clear();
                                                                        } else {
                                                                          // Assign the selected grade value
                                                                          publicGradeController[index].text = snapshot.gradeListUAS
                                                                              .firstWhere((grade) => grade.value == newValue)
                                                                              .text ?? '--';
                                                                          publicGradeController1[index].text = newValue ?? '--';
                                                                          provider.studListUAS[index].teGrade = newValue;
                                                                        }
                                                                        provider.studListUAS[index].isEdited = true;
                                                                      }
                                                                          : null,
                                                                      items: [
                                                                        // Add the '-Select-' item at the top of the list as null
                                                                        DropdownMenuItem<String>(
                                                                          value: "-Select-",
                                                                          child: Text(
                                                                            "-Select-",
                                                                            textAlign: TextAlign.center, // Center the text
                                                                            style: TextStyle(color: Colors.grey), // Style for the placeholder
                                                                          ),
                                                                        ),
                                                                        // Add the other items from the snapshot
                                                                        ...snapshot.gradeListUAS.map((grade) {
                                                                          return DropdownMenuItem<String>(
                                                                            value: grade.value,
                                                                            child: Text(
                                                                              grade.text ?? '--',
                                                                              textAlign: TextAlign.center, // Center the text
                                                                            ),
                                                                          );
                                                                        }).toList(),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      )





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
                                              .add(TextEditingController());
                                          ceMarkController
                                              .add(TextEditingController());
                                          practicalMarkController
                                              .add(TextEditingController());

                                          // Helper function to format the marks, removing any trailing ".0"
                                          String formatMark(dynamic mark) {
                                            if (mark == null) return ''; // If mark is null, return an empty string
                                            return (mark % 1 == 0) ? mark.toStringAsFixed(0) : mark.toString();
                                          }

                                          teMarkController[index].text.isEmpty
                                              ? teMarkController[index].text = formatMark(value.studListUAS[index].teMark)
                                              : teMarkController[index].text;

                                          practicalMarkController[index].text.isEmpty
                                              ? practicalMarkController[index].text = formatMark(value.studListUAS[index].peMark)
                                              : practicalMarkController[index].text;

                                          ceMarkController[index].text.isEmpty
                                              ? ceMarkController[index].text = formatMark(value.studListUAS[index].ceMark)
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
                                                                provider
                                                                    .studListUAS[
                                                                index].isEdited=true;

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


                                                                provider
                                                                    .studListUAS[
                                                                index].isEdited=true;
                                                                print("Hellooo ${provider
                                                                    .studListUAS[
                                                                index].isEdited}");



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
                                                                // value.studListUAS[index].isEdited=true;
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
                                                        const SizedBox(height: 0,width: 0,):
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

                                                                provider
                                                                    .studListUAS[
                                                                index].isEdited=true;

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
                                                                value.studListUAS[index].isEdited=true;
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
                                                      const SizedBox(height: 0,width: 38,):
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
                                                              provider
                                                                  .studListUAS[
                                                              index].isEdited=true;

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
                                                              value.studListUAS[index].isEdited=true;

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
                                            .add(TextEditingController());
                                        ceMarkController
                                            .add(TextEditingController());
                                        practicalMarkController
                                            .add(TextEditingController());
                                        // Helper function to format marks, removing any trailing ".0" if present
                                        String formatMark(dynamic mark) {
                                          if (mark == null) return ''; // If mark is null, return an empty string
                                          return (mark % 1 == 0) ? mark.toStringAsFixed(0) : mark.toString();
                                        }

                                        teMarkController[index].text.isEmpty
                                            ? teMarkController[index].text = formatMark(value.studListUAS[index].teMark)
                                            : teMarkController[index].text;

                                        practicalMarkController[index].text.isEmpty
                                            ? practicalMarkController[index].text = formatMark(value.studListUAS[index].peMark)
                                            : practicalMarkController[index].text;

                                        ceMarkController[index].text.isEmpty
                                            ? ceMarkController[index].text = formatMark(value.studListUAS[index].ceMark)
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
                                                              provider
                                                                  .studListUAS[
                                                              index].isEdited=true;

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
                                                              value.studListUAS[index].isEdited=true;

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
                                                              value.studListUAS[index].isEdited=true;
                                                              value.studListUAS[index].total =
                                                                  (value.studListUAS[index].teMark ?? 0.0) +
                                                                      (value.studListUAS[index].peMark ?? 0.0);
                                                              print("tottttt ${value.studListUAS[index].total}");

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
                                                      const SizedBox(height: 0,width: 0,):
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

                                                              provider
                                                                  .studListUAS[
                                                              index].isEdited=true;

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
                                                              value.studListUAS[index].isEdited=true;
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
                                                              value.studListUAS[index].total =
                                                                  (value.studListUAS[index].teMark ?? 0.0) +
                                                                      (value.studListUAS[index].peMark ?? 0.0);
                                                              //  value.studListUAS[index].isEdited=true;
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
                                            .add(TextEditingController());
                                        ceMarkController
                                            .add(TextEditingController());
                                        practicalMarkController
                                            .add(TextEditingController());

                                        String formatMark(dynamic mark) {
                                          if (mark == null) return ''; // Return an empty string if mark is null
                                          return (mark % 1 == 0) ? mark.toStringAsFixed(0) : mark.toString();
                                        }

                                        teMarkController[index].text.isEmpty
                                            ? teMarkController[index].text = formatMark(value.studListUAS[index].teMark)
                                            : teMarkController[index].text;

                                        ceMarkController[index].text.isEmpty
                                            ? ceMarkController[index].text = formatMark(value.studListUAS[index].ceMark)
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

                                                              provider
                                                                  .studListUAS[
                                                              index].isEdited=true;

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
                                                              value.studListUAS[index].isEdited=true;

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
                                                              // value.studListUAS[index].isEdited=true;
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
                                                      const SizedBox(height: 0,width: 0,):
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
                                                              provider
                                                                  .studListUAS[
                                                              index].isEdited=true;

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
                                                              value.studListUAS[index].isEdited=true;

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
                                                              //value.studListUAS[index].isEdited=true;
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
                                            .add(TextEditingController());
                                        ceMarkController
                                            .add(TextEditingController());
                                        practicalMarkController
                                            .add(TextEditingController());


                                        String formatMark(dynamic mark) {
                                          if (mark == null) return '';
                                          return (mark % 1 == 0) ? mark.toStringAsFixed(0) : mark.toString();
                                        }

                                        practicalMarkController[index].text.isEmpty
                                            ? practicalMarkController[index].text = formatMark(value.studListUAS[index].peMark)
                                            : practicalMarkController[index].text;

                                        ceMarkController[index].text.isEmpty
                                            ? ceMarkController[index].text = formatMark(value.studListUAS[index].ceMark)
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
                                                              provider
                                                                  .studListUAS[
                                                              index].isEdited=true;

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
                                                              value.studListUAS[index].isEdited=true;

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
                                                              //value.studListUAS[index].isEdited=true;
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
                                                      const SizedBox(height: 0,width: 0,):
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
                                                              provider
                                                                  .studListUAS[
                                                              index].isEdited=true;

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
                                                              value.studListUAS[index].isEdited=true;

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
                                                              // value.studListUAS[index].isEdited=true;
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

                                        String formatMark(dynamic mark) {
                                          if (mark == null) return '';
                                          return (mark % 1 == 0) ? mark.toStringAsFixed(0) : mark.toString();
                                        }
                                        markfieldController.text = pre;
                                        teMarkController.add(TextEditingController());
                                        ceMarkController.add(TextEditingController());
                                        practicalMarkController.add(TextEditingController());

                                        if (teMarkController[index].text.isEmpty) {
                                          teMarkController[index].text = formatMark(value.studListUAS[index].teMark);
                                        }


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
                                                              provider
                                                                  .studListUAS[
                                                              index].isEdited=true;

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
                                                              value.studListUAS[index].isEdited=true;

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
                                                              // value.studListUAS[index].isEdited=true;
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
                                            .add(TextEditingController());
                                        ceMarkController
                                            .add(TextEditingController());
                                        practicalMarkController
                                            .add(TextEditingController());

                                        String formatMark(dynamic mark) {
                                          if (mark == null) return '';
                                          return (mark % 1 == 0) ? mark.toStringAsFixed(0) : mark.toString();
                                        }
                                        if (practicalMarkController[index].text.isEmpty) {
                                          practicalMarkController[index].text = formatMark(value.studListUAS[index].peMark);
                                        }


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
                                                              provider
                                                                  .studListUAS[
                                                              index].isEdited=true;

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
                                                              value.studListUAS[index].isEdited=true;

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
                                                              //value.studListUAS[index].isEdited=true;
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
                                            .add(TextEditingController());
                                        ceMarkController
                                            .add(TextEditingController());
                                        practicalMarkController
                                            .add(TextEditingController());

                                        String formatMark(dynamic mark) {
                                          if (mark == null) return ''; // Return an empty string if mark is null
                                          return (mark % 1 == 0) ? mark.toStringAsFixed(0) : mark.toString();
                                        }

                                        if (ceMarkController[index].text.isEmpty) {
                                          ceMarkController[index].text = formatMark(value.studListUAS[index].ceMark);
                                        }

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
                                                              provider
                                                                  .studListUAS[
                                                              index].isEdited=true;

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
                                                              value.studListUAS[index].isEdited=true;

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
                                                              //  value.studListUAS[index].isEdited=true;
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
                          return const SizedBox(
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
                                                          width: 100,
                                                          child: Consumer<MarkEntryNewProvider>(
                                                            builder: (context, snapshot, child) {
                                                              return Padding(
                                                                padding: const EdgeInsets.all(5.0),
                                                                child: Column(
                                                                  mainAxisSize: MainAxisSize.min,
                                                                  children: [
                                                                    Container(
                                                                      height: 30,
                                                                      child: DropdownButtonFormField<String>(
                                                                        isExpanded: true,
                                                                        value: value.studListUAS[index].teGrade?.isNotEmpty == true
                                                                            ? value.studListUAS[index].teGrade
                                                                            : null, // Default value is null or previous value
                                                                        decoration: const InputDecoration(
                                                                          filled: true,
                                                                          contentPadding: EdgeInsets.only(left: 5, top: 0),
                                                                          floatingLabelBehavior: FloatingLabelBehavior.never,
                                                                          fillColor: Color.fromARGB(255, 255, 255, 255),
                                                                          focusedBorder: OutlineInputBorder(
                                                                              borderSide: BorderSide(color: UIGuide.light_Purple)
                                                                          ),
                                                                          border: OutlineInputBorder(),
                                                                          labelText: "Select",
                                                                          hintText: "Grade",
                                                                        ),
                                                                        onChanged:
                                                                        value.examStatusUAS != 'Synchronized'
                                                                            ? (newValue) {
                                                                          teGradeController[index]
                                                                              .text =
                                                                              newValue ??
                                                                                  '--';
                                                                          provider
                                                                              .studListUAS[index]
                                                                              .teGrade =
                                                                              newValue ??
                                                                                  '--';

                                                                          if (newValue ==
                                                                              "-Select-" ||
                                                                              newValue ==
                                                                                  null) {
                                                                            // Handle "-Select-" as null
                                                                            provider
                                                                                .studListUAS[index]
                                                                                .teGrade =
                                                                            null;
                                                                            teGradeController[index]
                                                                                .clear();
                                                                            teGradeController1[index]
                                                                                .clear();
                                                                          } else {
                                                                            // Assign the selected grade value
                                                                            teGradeController[index]
                                                                                .text =
                                                                                snapshot
                                                                                    .gradeListUAS
                                                                                    .firstWhere((
                                                                                    grade) =>
                                                                                grade
                                                                                    .value ==
                                                                                    newValue)
                                                                                    .text ??
                                                                                    '--';
                                                                            teGradeController1[index]
                                                                                .text =
                                                                                newValue ??
                                                                                    '--';
                                                                            provider
                                                                                .studListUAS[index]
                                                                                .teGrade =
                                                                                newValue;
                                                                          }
                                                                          provider
                                                                              .studListUAS[index]
                                                                              .isEdited =
                                                                          true;
                                                                        }:null,
                                                                        items: [
                                                                          // Add the '-Select-' item at the top of the list as null
                                                                          DropdownMenuItem<String>(
                                                                            value: null,
                                                                            child: Text(
                                                                              "-Select-",
                                                                              textAlign: TextAlign.center,
                                                                              style: TextStyle(color: Colors.grey),
                                                                            ),
                                                                          ),
                                                                          // Add the other items from the snapshot
                                                                          ...snapshot.gradeListUAS.map((grade) {
                                                                            return DropdownMenuItem<String>(
                                                                              value: grade.value,
                                                                              child: Text(
                                                                                grade.text ?? '--',
                                                                                textAlign: TextAlign.center,
                                                                              ),
                                                                            );
                                                                          }).toList(),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                            },
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
                                                          width: 100,
                                                          child: Consumer<MarkEntryNewProvider>(
                                                            builder: (context, snapshot, child) {
                                                              return Padding(
                                                                padding: const EdgeInsets.all(5.0),
                                                                child: Column(
                                                                  mainAxisSize: MainAxisSize.min,
                                                                  children: [
                                                                    Container(
                                                                      height: 30,

                                                                      child: DropdownButtonFormField<String>(
                                                                        isExpanded: true,
                                                                        value: value.studListUAS[index].ceGrade?.isNotEmpty == true
                                                                            ? value.studListUAS[index].ceGrade
                                                                            : null, // Default value is null or previous value
                                                                        decoration: const InputDecoration(
                                                                          filled: true,
                                                                          contentPadding: EdgeInsets.only(left: 5, top: 0),
                                                                          floatingLabelBehavior: FloatingLabelBehavior.never,
                                                                          fillColor: Color.fromARGB(255, 255, 255, 255),
                                                                          border: OutlineInputBorder(),
                                                                          focusedBorder: OutlineInputBorder(
                                                                              borderSide: BorderSide(
                                                                                  color: UIGuide.light_Purple
                                                                              )
                                                                          ),
                                                                          labelText: "Select",
                                                                          hintText: "Grade",
                                                                        ),
                                                                        onChanged:
                                                                        value.examStatusUAS != 'Synchronized'
                                                                            ? (newValue) {
                                                                          ceGradeController[index]
                                                                              .text =
                                                                              newValue ??
                                                                                  '--';
                                                                          provider
                                                                              .studListUAS[index]
                                                                              .ceGrade =
                                                                              newValue ??
                                                                                  '--';

                                                                          if (newValue ==
                                                                              "-Select-" ||
                                                                              newValue ==
                                                                                  null) {
                                                                            // Handle "-Select-" as null
                                                                            provider
                                                                                .studListUAS[index]
                                                                                .ceGrade =
                                                                            null;
                                                                            ceGradeController[index]
                                                                                .clear();
                                                                            ceGradeController1[index]
                                                                                .clear();
                                                                          } else {
                                                                            // Assign the selected grade value
                                                                            ceGradeController[index]
                                                                                .text =
                                                                                snapshot
                                                                                    .gradeListUAS
                                                                                    .firstWhere((
                                                                                    grade) =>
                                                                                grade
                                                                                    .value ==
                                                                                    newValue)
                                                                                    .text ??
                                                                                    '--';
                                                                            ceGradeController1[index]
                                                                                .text =
                                                                                newValue ??
                                                                                    '--';
                                                                            provider
                                                                                .studListUAS[index]
                                                                                .ceGrade =
                                                                                newValue;
                                                                          }
                                                                          provider
                                                                              .studListUAS[index]
                                                                              .isEdited =
                                                                          true;
                                                                        }:null,
                                                                        items: [
                                                                          // Add the '-Select-' item at the top of the list as null
                                                                          DropdownMenuItem<String>(
                                                                            value: null,
                                                                            child: Text(
                                                                              "-Select-",
                                                                              textAlign: TextAlign.center,
                                                                              style: TextStyle(color: Colors.grey),
                                                                            ),
                                                                          ),
                                                                          // Add the other items from the snapshot
                                                                          ...snapshot.gradeListUAS.map((grade) {
                                                                            return DropdownMenuItem<String>(
                                                                              value: grade.value,
                                                                              child: Text(
                                                                                grade.text ?? '--',
                                                                                textAlign: TextAlign.center,
                                                                              ),
                                                                            );
                                                                          }).toList(),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                            },
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
                                                          width: 100,
                                                          child: Consumer<MarkEntryNewProvider>(
                                                            builder: (context, snapshot, child) {
                                                              return Padding(
                                                                padding: const EdgeInsets.all(5.0),
                                                                child: Column(
                                                                  mainAxisSize: MainAxisSize.min,
                                                                  children: [
                                                                    Container(
                                                                      height: 30,

                                                                      child: DropdownButtonFormField<String>(
                                                                        isExpanded: true,
                                                                        value: value.studListUAS[index].peGrade?.isNotEmpty == true
                                                                            ? value.studListUAS[index].peGrade
                                                                            : null, // Default value is null or previous value
                                                                        decoration: const InputDecoration(
                                                                          filled: true,
                                                                          contentPadding: EdgeInsets.only(left: 3, top: 0),
                                                                          floatingLabelBehavior: FloatingLabelBehavior.never,
                                                                          fillColor: Color.fromARGB(255, 255, 255, 255),
                                                                          border: OutlineInputBorder(),
                                                                          focusedBorder: OutlineInputBorder(
                                                                              borderSide: BorderSide(color: UIGuide.light_Purple)
                                                                          ),
                                                                          labelText: "Select",
                                                                          hintText: "Grade",
                                                                        ),
                                                                        onChanged:
                                                                        value.examStatusUAS != 'Synchronized'
                                                                            ? (newValue) {
                                                                          praticalGradeController[index]
                                                                              .text =
                                                                              newValue ??
                                                                                  '--';
                                                                          provider
                                                                              .studListUAS[index]
                                                                              .peGrade =
                                                                              newValue ??
                                                                                  '--';

                                                                          if (newValue ==
                                                                              "-Select-" ||
                                                                              newValue ==
                                                                                  null) {
                                                                            // Handle "-Select-" as null
                                                                            provider
                                                                                .studListUAS[index]
                                                                                .peGrade =
                                                                            null;
                                                                            praticalGradeController[index]
                                                                                .clear();
                                                                            praticalGradeController1[index]
                                                                                .clear();
                                                                          } else {
                                                                            // Assign the selected grade value
                                                                            praticalGradeController[index]
                                                                                .text =
                                                                                snapshot
                                                                                    .gradeListUAS
                                                                                    .firstWhere((
                                                                                    grade) =>
                                                                                grade
                                                                                    .value ==
                                                                                    newValue)
                                                                                    .text ??
                                                                                    '--';
                                                                            praticalGradeController1[index]
                                                                                .text =
                                                                                newValue ??
                                                                                    '--';
                                                                            provider
                                                                                .studListUAS[index]
                                                                                .peGrade =
                                                                                newValue;
                                                                          }
                                                                          provider
                                                                              .studListUAS[index]
                                                                              .isEdited =
                                                                          true;
                                                                        }:null,
                                                                        // value.examStatusUAS != 'Synchronized'
                                                                        //     ? (newValue) {
                                                                        //   // Update the grade value when a new grade is selected
                                                                        //   praticalGradeController[index].text = newValue ?? '--';
                                                                        //   praticalGradeController1[index].text = newValue ?? '--';
                                                                        //   value.studListUAS[index].peGrade = newValue ?? '--';
                                                                        //   value.studListUAS[index].isEdited = true; // Mark as edited
                                                                        // }
                                                                        //     : null, // Disable dropdown when the condition is not met
                                                                        items: [
                                                                          // Add the '-Select-' item at the top of the list as null
                                                                          DropdownMenuItem<String>(
                                                                            value: null,
                                                                            child: Text(
                                                                              "-Select-",
                                                                              textAlign: TextAlign.center,
                                                                              style: TextStyle(color: Colors.grey),
                                                                            ),
                                                                          ),
                                                                          // Add the other items from the snapshot
                                                                          ...snapshot.gradeListUAS.map((grade) {
                                                                            return DropdownMenuItem<String>(
                                                                              value: grade.value,
                                                                              child: Text(
                                                                                grade.text ?? '--',
                                                                                textAlign: TextAlign.center,
                                                                              ),
                                                                            );
                                                                          }).toList(),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        )

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
                                                          width: 100,
                                                          child: Consumer<MarkEntryNewProvider>(
                                                            builder: (context, snapshot, child) {
                                                              return Padding(
                                                                padding: const EdgeInsets.all(5.0),
                                                                child: Column(
                                                                  mainAxisSize: MainAxisSize.min,
                                                                  children: [
                                                                    Container(
                                                                      height: 30,

                                                                      child: DropdownButtonFormField<String>(
                                                                        isExpanded: true,
                                                                        value: value.studListUAS[index].teGrade?.isNotEmpty == true
                                                                            ? value.studListUAS[index].teGrade
                                                                            : null, // Default to null or previously selected value
                                                                        decoration: const InputDecoration(
                                                                          filled: true,
                                                                          contentPadding: EdgeInsets.only(left: 5, top: 0),
                                                                          floatingLabelBehavior: FloatingLabelBehavior.never,
                                                                          fillColor: Color.fromARGB(255, 255, 255, 255),
                                                                          border: OutlineInputBorder(),
                                                                          focusedBorder:OutlineInputBorder(
                                                                              borderSide: BorderSide(color:  UIGuide.light_Purple)) ,
                                                                          labelText: "Select",
                                                                          hintText: "Grade",
                                                                        ),
                                                                        onChanged:
                                                                        value.examStatusUAS != 'Synchronized'
                                                                            ? (newValue) {
                                                                          teGradeController[index]
                                                                              .text =
                                                                              newValue ??
                                                                                  '--';
                                                                          provider
                                                                              .studListUAS[index]
                                                                              .teGrade =
                                                                              newValue ??
                                                                                  '--';

                                                                          if (newValue ==
                                                                              "-Select-" ||
                                                                              newValue ==
                                                                                  null) {
                                                                            // Handle "-Select-" as null
                                                                            provider
                                                                                .studListUAS[index]
                                                                                .teGrade =
                                                                            null;
                                                                            teGradeController[index]
                                                                                .clear();
                                                                            teGradeController1[index]
                                                                                .clear();
                                                                          } else {
                                                                            // Assign the selected grade value
                                                                            teGradeController[index]
                                                                                .text =
                                                                                snapshot
                                                                                    .gradeListUAS
                                                                                    .firstWhere((
                                                                                    grade) =>
                                                                                grade
                                                                                    .value ==
                                                                                    newValue)
                                                                                    .text ??
                                                                                    '--';
                                                                            teGradeController1[index]
                                                                                .text =
                                                                                newValue ??
                                                                                    '--';
                                                                            provider
                                                                                .studListUAS[index]
                                                                                .teGrade =
                                                                                newValue;
                                                                          }
                                                                          provider
                                                                              .studListUAS[index]
                                                                              .isEdited =
                                                                          true;
                                                                        }:null,
                                                                        // value.examStatusUAS != 'Synchronized'
                                                                        //     ? (newValue) {
                                                                        //   // Update the grade value when a new grade is selected
                                                                        //   teGradeController[index].text = newValue ?? '--';
                                                                        //   teGradeController1[index].text = newValue ?? '--';
                                                                        //   value.studListUAS[index].teGrade = newValue ?? '--';
                                                                        //   value.studListUAS[index].isEdited = true; // Mark as edited
                                                                        // }
                                                                        //     : null, // Disable dropdown based on condition
                                                                        items: [
                                                                          // Add a default '-Select-' option
                                                                          DropdownMenuItem<String>(
                                                                            value: null,
                                                                            child: Text(
                                                                              "-Select-",
                                                                              textAlign: TextAlign.center,
                                                                              style: TextStyle(color: Colors.grey),
                                                                            ),
                                                                          ),
                                                                          // Populate dropdown items from snapshot
                                                                          ...snapshot.gradeListUAS.map((grade) {
                                                                            return DropdownMenuItem<String>(
                                                                              value: grade.value,
                                                                              child: Text(
                                                                                grade.text ?? '--',
                                                                                textAlign: TextAlign.center,
                                                                              ),
                                                                            );
                                                                          }).toList(),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                            },
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
                                                          width: 100,
                                                          child: Consumer<MarkEntryNewProvider>(
                                                            builder: (context, snapshot, child) {
                                                              return Padding(
                                                                padding: const EdgeInsets.all(5.0),
                                                                child: Column(
                                                                  mainAxisSize: MainAxisSize.min,
                                                                  children: [
                                                                    Container(
                                                                      height: 30,
                                                                      child: DropdownButtonFormField<String>(
                                                                        isExpanded: true,
                                                                        value: value.studListUAS[index].ceGrade?.isNotEmpty == true
                                                                            ? value.studListUAS[index].ceGrade
                                                                            : null, // Default to null or previously selected value
                                                                        decoration: const InputDecoration(
                                                                          filled: true,
                                                                          contentPadding: EdgeInsets.only(left: 5, top: 0),
                                                                          floatingLabelBehavior: FloatingLabelBehavior.never,
                                                                          fillColor: Color.fromARGB(255, 255, 255, 255),
                                                                          border: OutlineInputBorder(),
                                                                          focusedBorder: OutlineInputBorder(
                                                                              borderSide: BorderSide(color: UIGuide.light_Purple)
                                                                          ),
                                                                          labelText: "Select",
                                                                          hintText: "Grade",
                                                                        ),
                                                                        onChanged:
                                                                        value.examStatusUAS != 'Synchronized'
                                                                            ? (newValue) {
                                                                          ceGradeController[index]
                                                                              .text =
                                                                              newValue ??
                                                                                  '--';
                                                                          provider
                                                                              .studListUAS[index]
                                                                              .ceGrade =
                                                                              newValue ??
                                                                                  '--';

                                                                          if (newValue ==
                                                                              "-Select-" ||
                                                                              newValue ==
                                                                                  null) {
                                                                            // Handle "-Select-" as null
                                                                            provider
                                                                                .studListUAS[index]
                                                                                .ceGrade =
                                                                            null;
                                                                            ceGradeController[index]
                                                                                .clear();
                                                                            ceGradeController1[index]
                                                                                .clear();
                                                                          } else {
                                                                            // Assign the selected grade value
                                                                            ceGradeController[index]
                                                                                .text =
                                                                                snapshot
                                                                                    .gradeListUAS
                                                                                    .firstWhere((
                                                                                    grade) =>
                                                                                grade
                                                                                    .value ==
                                                                                    newValue)
                                                                                    .text ??
                                                                                    '--';
                                                                            ceGradeController1[index]
                                                                                .text =
                                                                                newValue ??
                                                                                    '--';
                                                                            provider
                                                                                .studListUAS[index]
                                                                                .ceGrade =
                                                                                newValue;
                                                                          }
                                                                          provider
                                                                              .studListUAS[index]
                                                                              .isEdited =
                                                                          true;
                                                                        }:null,

                                                                        //     value.examStatusUAS != 'Synchronized'
                                                                        //     ? (newValue) {
                                                                        //       ceGradeController[index].text == "-Select-"?null: '--';
                                                                        //   // Update the grade values
                                                                        //   ceGradeController[index].text = newValue ?? '--';
                                                                        //   ceGradeController1[index].text = newValue ?? '--';
                                                                        //   value.studListUAS[index].ceGrade = newValue ?? '--';
                                                                        //   value.studListUAS[index].isEdited = true;
                                                                        // }
                                                                        //     : null, // Disable dropdown if conditions are not met
                                                                        items: [
                                                                          // Add a default '-Select-' option
                                                                          DropdownMenuItem<String>(
                                                                            value: null,
                                                                            child: Text(
                                                                              "-Select-",
                                                                              textAlign: TextAlign.center,
                                                                              style: TextStyle(color: Colors.grey),
                                                                            ),
                                                                          ),
                                                                          // Populate dropdown items from the grade list
                                                                          ...snapshot.gradeListUAS.map((grade) {
                                                                            return DropdownMenuItem<String>(
                                                                              value: grade.value,
                                                                              child: Text(
                                                                                grade.text ?? '--',
                                                                                textAlign: TextAlign.center,
                                                                              ),
                                                                            );
                                                                          }).toList(),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                            },
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
                                                          width: 100,
                                                          child: Consumer<MarkEntryNewProvider>(
                                                            builder: (context, snapshot, child) {
                                                              return Padding(
                                                                padding: const EdgeInsets.all(5.0),
                                                                child: Column(
                                                                  mainAxisSize: MainAxisSize.min,
                                                                  children: [
                                                                    Container(
                                                                      height: 30,
                                                                      decoration: BoxDecoration(
                                                                        border: Border.all(
                                                                          color: UIGuide.light_Purple,
                                                                          width: 1,
                                                                        ),
                                                                      ),
                                                                      child: DropdownButtonFormField<String>(
                                                                        isExpanded: true,
                                                                        value: provider.studListUAS[index].teGrade?.isNotEmpty == true
                                                                            ? provider.studListUAS[index].teGrade
                                                                            : null, // Default to null or previously selected value
                                                                        decoration: const InputDecoration(
                                                                          filled: true,
                                                                          contentPadding: EdgeInsets.only(left: 0, top: 0),
                                                                          floatingLabelBehavior: FloatingLabelBehavior.never,
                                                                          fillColor: Color.fromARGB(255, 255, 255, 255),
                                                                          border: OutlineInputBorder(),
                                                                          labelText: "Select",
                                                                          hintText: "Grade",
                                                                        ),
                                                                        onChanged: value.examStatusUAS != 'Synchronized'
                                                                            ? (newValue) {
                                                                          if (newValue == "-Select-" || newValue == null) {
                                                                            // Handle "-Select-" as null
                                                                            provider.studListUAS[index].teGrade = null;
                                                                            teGradeController[index].clear();
                                                                            teGradeController1[index].clear();
                                                                          } else {
                                                                            // Assign the selected grade value
                                                                            teGradeController[index].text = snapshot.gradeListUAS
                                                                                .firstWhere((grade) =>
                                                                            grade.value == newValue)
                                                                                .text ??
                                                                                '--';
                                                                            teGradeController1[index].text = newValue ?? '--';
                                                                            provider.studListUAS[index].teGrade = newValue;
                                                                          }
                                                                          provider.studListUAS[index].isEdited = true;
                                                                        }
                                                                            : null, // Disable dropdown when exam status is synchronized
                                                                        items: [
                                                                          // Add a default "-Select-" option
                                                                          DropdownMenuItem<String>(
                                                                            value: null,
                                                                            child: Text(
                                                                              "-Select-",
                                                                              textAlign: TextAlign.center,
                                                                              style: TextStyle(color: Colors.grey),
                                                                            ),
                                                                          ),
                                                                          // Populate dropdown items from the grade list
                                                                          ...snapshot.gradeListUAS.map((grade) {
                                                                            return DropdownMenuItem<String>(
                                                                              value: grade.value,
                                                                              child: Text(
                                                                                grade.text ?? '--',
                                                                                textAlign: TextAlign.center,
                                                                              ),
                                                                            );
                                                                          }).toList(),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                            },
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
                                                          width: 100,
                                                          child: Consumer<MarkEntryNewProvider>(
                                                            builder: (context, snapshot, child) {
                                                              return Padding(
                                                                padding: const EdgeInsets.all(5.0),
                                                                child: Column(
                                                                  mainAxisSize: MainAxisSize.min,
                                                                  children: [
                                                                    Container(
                                                                      height: 30,

                                                                      child: DropdownButtonFormField<String>(
                                                                        isExpanded: true,
                                                                        value: value.studListUAS[index].peGrade?.isNotEmpty == true
                                                                            ? value.studListUAS[index].peGrade
                                                                            : null, // Default value is null or previous value
                                                                        decoration: const InputDecoration(
                                                                          filled: true,
                                                                          contentPadding: EdgeInsets.only(left: 3, top: 0),
                                                                          floatingLabelBehavior: FloatingLabelBehavior.never,
                                                                          fillColor: Color.fromARGB(255, 255, 255, 255),
                                                                          border: OutlineInputBorder(),
                                                                          focusedBorder: OutlineInputBorder(
                                                                              borderSide: BorderSide(color: UIGuide.light_Purple)
                                                                          ),
                                                                          labelText: "Select",
                                                                          hintText: "Grade",
                                                                        ),
                                                                        onChanged:
                                                                        value.examStatusUAS != 'Synchronized'
                                                                            ? (newValue) {
                                                                          praticalGradeController[index]
                                                                              .text =
                                                                              newValue ??
                                                                                  '--';
                                                                          provider
                                                                              .studListUAS[index]
                                                                              .peGrade =
                                                                              newValue ??
                                                                                  '--';

                                                                          if (newValue ==
                                                                              "-Select-" ||
                                                                              newValue ==
                                                                                  null) {
                                                                            // Handle "-Select-" as null
                                                                            provider
                                                                                .studListUAS[index]
                                                                                .peGrade =
                                                                            null;
                                                                            praticalGradeController[index]
                                                                                .clear();
                                                                            praticalGradeController1[index]
                                                                                .clear();
                                                                          } else {
                                                                            // Assign the selected grade value
                                                                            praticalGradeController[index]
                                                                                .text =
                                                                                snapshot
                                                                                    .gradeListUAS
                                                                                    .firstWhere((
                                                                                    grade) =>
                                                                                grade
                                                                                    .value ==
                                                                                    newValue)
                                                                                    .text ??
                                                                                    '--';
                                                                            praticalGradeController1[index]
                                                                                .text =
                                                                                newValue ??
                                                                                    '--';
                                                                            provider
                                                                                .studListUAS[index]
                                                                                .peGrade =
                                                                                newValue;
                                                                          }
                                                                          provider
                                                                              .studListUAS[index]
                                                                              .isEdited =
                                                                          true;
                                                                        }:null,
                                                                        // value.examStatusUAS != 'Synchronized'
                                                                        //     ? (newValue) {
                                                                        //   // Update the grade value when a new grade is selected
                                                                        //   praticalGradeController[index].text = newValue ?? '--';
                                                                        //   praticalGradeController1[index].text = newValue ?? '--';
                                                                        //   value.studListUAS[index].peGrade = newValue ?? '--';
                                                                        //   value.studListUAS[index].isEdited = true; // Mark as edited
                                                                        // }
                                                                        //     : null, // Disable dropdown when the condition is not met
                                                                        items: [
                                                                          // Add the '-Select-' item at the top of the list as null
                                                                          DropdownMenuItem<String>(
                                                                            value: null,
                                                                            child: Text(
                                                                              "-Select-",
                                                                              textAlign: TextAlign.center,
                                                                              style: TextStyle(color: Colors.grey),
                                                                            ),
                                                                          ),
                                                                          // Add the other items from the snapshot
                                                                          ...snapshot.gradeListUAS.map((grade) {
                                                                            return DropdownMenuItem<String>(
                                                                              value: grade.value,
                                                                              child: Text(
                                                                                grade.text ?? '--',
                                                                                textAlign: TextAlign.center,
                                                                              ),
                                                                            );
                                                                          }).toList(),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        )
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
                                                          width: 100,
                                                          child: Consumer<MarkEntryNewProvider>(
                                                            builder: (context, snapshot, child) {
                                                              return Padding(
                                                                padding: const EdgeInsets.all(5.0),
                                                                child: Column(
                                                                  mainAxisSize: MainAxisSize.min,
                                                                  children: [
                                                                    Container(
                                                                      height: 30,
                                                                      child: DropdownButtonFormField<String>(
                                                                        isExpanded: true,
                                                                        value: value.studListUAS[index].ceGrade?.isNotEmpty == true
                                                                            ? value.studListUAS[index].ceGrade
                                                                            : null, // Default to null or previously selected value
                                                                        decoration: const InputDecoration(
                                                                          filled: true,
                                                                          contentPadding: EdgeInsets.only(left: 5, top: 0),
                                                                          floatingLabelBehavior: FloatingLabelBehavior.never,
                                                                          fillColor: Color.fromARGB(255, 255, 255, 255),
                                                                          border: OutlineInputBorder(),
                                                                          focusedBorder: OutlineInputBorder(
                                                                              borderSide: BorderSide(color: UIGuide.light_Purple)
                                                                          ),
                                                                          labelText: "Select",
                                                                          hintText: "Grade",
                                                                        ),
                                                                        onChanged:
                                                                        value.examStatusUAS != 'Synchronized'
                                                                            ? (newValue) {
                                                                          ceGradeController[index]
                                                                              .text =
                                                                              newValue ??
                                                                                  '--';
                                                                          provider
                                                                              .studListUAS[index]
                                                                              .ceGrade =
                                                                              newValue ??
                                                                                  '--';

                                                                          if (newValue ==
                                                                              "-Select-" ||
                                                                              newValue ==
                                                                                  null) {
                                                                            // Handle "-Select-" as null
                                                                            provider
                                                                                .studListUAS[index]
                                                                                .ceGrade =
                                                                            null;
                                                                            ceGradeController[index]
                                                                                .clear();
                                                                            ceGradeController1[index]
                                                                                .clear();
                                                                          } else {
                                                                            // Assign the selected grade value
                                                                            ceGradeController[index]
                                                                                .text =
                                                                                snapshot
                                                                                    .gradeListUAS
                                                                                    .firstWhere((
                                                                                    grade) =>
                                                                                grade
                                                                                    .value ==
                                                                                    newValue)
                                                                                    .text ??
                                                                                    '--';
                                                                            ceGradeController1[index]
                                                                                .text =
                                                                                newValue ??
                                                                                    '--';
                                                                            provider
                                                                                .studListUAS[index]
                                                                                .ceGrade =
                                                                                newValue;
                                                                          }
                                                                          provider
                                                                              .studListUAS[index]
                                                                              .isEdited =
                                                                          true;
                                                                        }:null,

                                                                        //     value.examStatusUAS != 'Synchronized'
                                                                        //     ? (newValue) {
                                                                        //       ceGradeController[index].text == "-Select-"?null: '--';
                                                                        //   // Update the grade values
                                                                        //   ceGradeController[index].text = newValue ?? '--';
                                                                        //   ceGradeController1[index].text = newValue ?? '--';
                                                                        //   value.studListUAS[index].ceGrade = newValue ?? '--';
                                                                        //   value.studListUAS[index].isEdited = true;
                                                                        // }
                                                                        //     : null, // Disable dropdown if conditions are not met
                                                                        items: [
                                                                          // Add a default '-Select-' option
                                                                          DropdownMenuItem<String>(
                                                                            value: null,
                                                                            child: Text(
                                                                              "-Select-",
                                                                              textAlign: TextAlign.center,
                                                                              style: TextStyle(color: Colors.grey),
                                                                            ),
                                                                          ),
                                                                          // Populate dropdown items from the grade list
                                                                          ...snapshot.gradeListUAS.map((grade) {
                                                                            return DropdownMenuItem<String>(
                                                                              value: grade.value,
                                                                              child: Text(
                                                                                grade.text ?? '--',
                                                                                textAlign: TextAlign.center,
                                                                              ),
                                                                            );
                                                                          }).toList(),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                            },
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
                                                          width: 100,
                                                          child: Consumer<MarkEntryNewProvider>(
                                                            builder: (context, snapshot, child) {
                                                              return Padding(
                                                                padding: const EdgeInsets.all(5.0),
                                                                child: Column(
                                                                  mainAxisSize: MainAxisSize.min,
                                                                  children: [
                                                                    Container(
                                                                      height: 30,

                                                                      child: DropdownButtonFormField<String>(
                                                                        isExpanded: true,
                                                                        value: value.studListUAS[index].peGrade?.isNotEmpty == true
                                                                            ? value.studListUAS[index].peGrade
                                                                            : null, // Default value is null or previous value
                                                                        decoration: const InputDecoration(
                                                                          filled: true,
                                                                          contentPadding: EdgeInsets.only(left: 3, top: 0),
                                                                          floatingLabelBehavior: FloatingLabelBehavior.never,
                                                                          fillColor: Color.fromARGB(255, 255, 255, 255),
                                                                          border: OutlineInputBorder(),
                                                                          focusedBorder: OutlineInputBorder(
                                                                              borderSide: BorderSide(color: UIGuide.light_Purple)
                                                                          ),
                                                                          labelText: "Select",
                                                                          hintText: "Grade",
                                                                        ),
                                                                        onChanged:
                                                                        value.examStatusUAS != 'Synchronized'
                                                                            ? (newValue) {
                                                                          praticalGradeController[index]
                                                                              .text =
                                                                              newValue ??
                                                                                  '--';
                                                                          provider
                                                                              .studListUAS[index]
                                                                              .peGrade =
                                                                              newValue ??
                                                                                  '--';

                                                                          if (newValue ==
                                                                              "-Select-" ||
                                                                              newValue ==
                                                                                  null) {
                                                                            // Handle "-Select-" as null
                                                                            provider
                                                                                .studListUAS[index]
                                                                                .peGrade =
                                                                            null;
                                                                            praticalGradeController[index]
                                                                                .clear();
                                                                            praticalGradeController1[index]
                                                                                .clear();
                                                                          } else {
                                                                            // Assign the selected grade value
                                                                            praticalGradeController[index]
                                                                                .text =
                                                                                snapshot
                                                                                    .gradeListUAS
                                                                                    .firstWhere((
                                                                                    grade) =>
                                                                                grade
                                                                                    .value ==
                                                                                    newValue)
                                                                                    .text ??
                                                                                    '--';
                                                                            praticalGradeController1[index]
                                                                                .text =
                                                                                newValue ??
                                                                                    '--';
                                                                            provider
                                                                                .studListUAS[index]
                                                                                .peGrade =
                                                                                newValue;
                                                                          }
                                                                          provider
                                                                              .studListUAS[index]
                                                                              .isEdited =
                                                                          true;
                                                                        }:null,
                                                                        // value.examStatusUAS != 'Synchronized'
                                                                        //     ? (newValue) {
                                                                        //   // Update the grade value when a new grade is selected
                                                                        //   praticalGradeController[index].text = newValue ?? '--';
                                                                        //   praticalGradeController1[index].text = newValue ?? '--';
                                                                        //   value.studListUAS[index].peGrade = newValue ?? '--';
                                                                        //   value.studListUAS[index].isEdited = true; // Mark as edited
                                                                        // }
                                                                        //     : null, // Disable dropdown when the condition is not met
                                                                        items: [
                                                                          // Add the '-Select-' item at the top of the list as null
                                                                          DropdownMenuItem<String>(
                                                                            value: null,
                                                                            child: Text(
                                                                              "-Select-",
                                                                              textAlign: TextAlign.center,
                                                                              style: TextStyle(color: Colors.grey),
                                                                            ),
                                                                          ),
                                                                          // Add the other items from the snapshot
                                                                          ...snapshot.gradeListUAS.map((grade) {
                                                                            return DropdownMenuItem<String>(
                                                                              value: grade.value,
                                                                              child: Text(
                                                                                grade.text ?? '--',
                                                                                textAlign: TextAlign.center,
                                                                              ),
                                                                            );
                                                                          }).toList(),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        )
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
                                                          width: 100,
                                                          child: Consumer<MarkEntryNewProvider>(
                                                            builder: (context, snapshot, child) {
                                                              return Padding(
                                                                padding: const EdgeInsets.all(5.0),
                                                                child: Column(
                                                                  mainAxisSize: MainAxisSize.min,
                                                                  children: [
                                                                    Container(
                                                                      height: 30,
                                                                      decoration: BoxDecoration(
                                                                        border: Border.all(
                                                                          color: UIGuide.light_Purple,
                                                                          width: 1,
                                                                        ),
                                                                      ),
                                                                      child: DropdownButtonFormField<String>(
                                                                        isExpanded: true,
                                                                        value: provider.studListUAS[index].teGrade?.isNotEmpty == true
                                                                            ? provider.studListUAS[index].teGrade
                                                                            : null, // Default to null or previously selected value
                                                                        decoration: const InputDecoration(
                                                                          filled: true,
                                                                          contentPadding: EdgeInsets.only(left: 0, top: 0),
                                                                          floatingLabelBehavior: FloatingLabelBehavior.never,
                                                                          fillColor: Color.fromARGB(255, 255, 255, 255),
                                                                          border: OutlineInputBorder(),
                                                                          labelText: "Select",
                                                                          hintText: "Grade",
                                                                        ),
                                                                        onChanged: value.examStatusUAS != 'Synchronized'
                                                                            ? (newValue) {
                                                                          if (newValue == "-Select-" || newValue == null) {
                                                                            // Handle "-Select-" as null
                                                                            provider.studListUAS[index].teGrade = null;
                                                                            teGradeController[index].clear();
                                                                            teGradeController1[index].clear();
                                                                          } else {
                                                                            // Assign the selected grade value
                                                                            teGradeController[index].text = snapshot.gradeListUAS
                                                                                .firstWhere((grade) =>
                                                                            grade.value == newValue)
                                                                                .text ??
                                                                                '--';
                                                                            teGradeController1[index].text = newValue ?? '--';
                                                                            provider.studListUAS[index].teGrade = newValue;
                                                                          }
                                                                          provider.studListUAS[index].isEdited = true;
                                                                        }
                                                                            : null, // Disable dropdown when exam status is synchronized
                                                                        items: [
                                                                          // Add a default "-Select-" option
                                                                          DropdownMenuItem<String>(
                                                                            value: null,
                                                                            child: Text(
                                                                              "-Select-",
                                                                              textAlign: TextAlign.center,
                                                                              style: TextStyle(color: Colors.grey),
                                                                            ),
                                                                          ),
                                                                          // Populate dropdown items from the grade list
                                                                          ...snapshot.gradeListUAS.map((grade) {
                                                                            return DropdownMenuItem<String>(
                                                                              value: grade.value,
                                                                              child: Text(
                                                                                grade.text ?? '--',
                                                                                textAlign: TextAlign.center,
                                                                              ),
                                                                            );
                                                                          }).toList(),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                            },
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
                                                          width: 100,
                                                          child: Consumer<MarkEntryNewProvider>(
                                                            builder: (context, snapshot, child) {
                                                              return Padding(
                                                                padding: const EdgeInsets.all(5.0),
                                                                child: Column(
                                                                  mainAxisSize: MainAxisSize.min,
                                                                  children: [
                                                                    Container(
                                                                      height: 30,

                                                                      child: DropdownButtonFormField<String>(
                                                                        isExpanded: true,
                                                                        value: value.studListUAS[index].peGrade?.isNotEmpty == true
                                                                            ? value.studListUAS[index].peGrade
                                                                            : null, // Default value is null or previous value
                                                                        decoration: const InputDecoration(
                                                                          filled: true,
                                                                          contentPadding: EdgeInsets.only(left: 3, top: 0),
                                                                          floatingLabelBehavior: FloatingLabelBehavior.never,
                                                                          fillColor: Color.fromARGB(255, 255, 255, 255),
                                                                          border: OutlineInputBorder(),
                                                                          focusedBorder: OutlineInputBorder(
                                                                              borderSide: BorderSide(color: UIGuide.light_Purple)
                                                                          ),
                                                                          labelText: "Select",
                                                                          hintText: "Grade",
                                                                        ),
                                                                        onChanged:
                                                                        value.examStatusUAS != 'Synchronized'
                                                                            ? (newValue) {
                                                                          praticalGradeController[index]
                                                                              .text =
                                                                              newValue ??
                                                                                  '--';
                                                                          provider
                                                                              .studListUAS[index]
                                                                              .peGrade =
                                                                              newValue ??
                                                                                  '--';

                                                                          if (newValue ==
                                                                              "-Select-" ||
                                                                              newValue ==
                                                                                  null) {
                                                                            // Handle "-Select-" as null
                                                                            provider
                                                                                .studListUAS[index]
                                                                                .peGrade =
                                                                            null;
                                                                            praticalGradeController[index]
                                                                                .clear();
                                                                            praticalGradeController1[index]
                                                                                .clear();
                                                                          } else {
                                                                            // Assign the selected grade value
                                                                            praticalGradeController[index]
                                                                                .text =
                                                                                snapshot
                                                                                    .gradeListUAS
                                                                                    .firstWhere((
                                                                                    grade) =>
                                                                                grade
                                                                                    .value ==
                                                                                    newValue)
                                                                                    .text ??
                                                                                    '--';
                                                                            praticalGradeController1[index]
                                                                                .text =
                                                                                newValue ??
                                                                                    '--';
                                                                            provider
                                                                                .studListUAS[index]
                                                                                .peGrade =
                                                                                newValue;
                                                                          }
                                                                          provider
                                                                              .studListUAS[index]
                                                                              .isEdited =
                                                                          true;
                                                                        }:null,
                                                                        // value.examStatusUAS != 'Synchronized'
                                                                        //     ? (newValue) {
                                                                        //   // Update the grade value when a new grade is selected
                                                                        //   praticalGradeController[index].text = newValue ?? '--';
                                                                        //   praticalGradeController1[index].text = newValue ?? '--';
                                                                        //   value.studListUAS[index].peGrade = newValue ?? '--';
                                                                        //   value.studListUAS[index].isEdited = true; // Mark as edited
                                                                        // }
                                                                        //     : null, // Disable dropdown when the condition is not met
                                                                        items: [
                                                                          // Add the '-Select-' item at the top of the list as null
                                                                          DropdownMenuItem<String>(
                                                                            value: null,
                                                                            child: Text(
                                                                              "-Select-",
                                                                              textAlign: TextAlign.center,
                                                                              style: TextStyle(color: Colors.grey),
                                                                            ),
                                                                          ),
                                                                          // Add the other items from the snapshot
                                                                          ...snapshot.gradeListUAS.map((grade) {
                                                                            return DropdownMenuItem<String>(
                                                                              value: grade.value,
                                                                              child: Text(
                                                                                grade.text ?? '--',
                                                                                textAlign: TextAlign.center,
                                                                              ),
                                                                            );
                                                                          }).toList(),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        )
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
                                                          width: 100,
                                                          child: Consumer<MarkEntryNewProvider>(
                                                            builder: (context, snapshot, child) {
                                                              return Padding(
                                                                padding: const EdgeInsets.all(5.0),
                                                                child: Column(
                                                                  mainAxisSize: MainAxisSize.min,
                                                                  children: [
                                                                    Container(
                                                                      height: 30,
                                                                      child: DropdownButtonFormField<String>(
                                                                        isExpanded: true,
                                                                        value: value.studListUAS[index].ceGrade?.isNotEmpty == true
                                                                            ? value.studListUAS[index].ceGrade
                                                                            : null, // Default to null or previously selected value
                                                                        decoration: const InputDecoration(
                                                                          filled: true,
                                                                          contentPadding: EdgeInsets.only(left: 5, top: 0),
                                                                          floatingLabelBehavior: FloatingLabelBehavior.never,
                                                                          fillColor: Color.fromARGB(255, 255, 255, 255),
                                                                          border: OutlineInputBorder(),
                                                                          focusedBorder: OutlineInputBorder(
                                                                              borderSide: BorderSide(color: UIGuide.light_Purple)
                                                                          ),
                                                                          labelText: "Select",
                                                                          hintText: "Grade",
                                                                        ),
                                                                        onChanged:
                                                                        value.examStatusUAS != 'Synchronized'
                                                                            ? (newValue) {
                                                                          ceGradeController[index]
                                                                              .text =
                                                                              newValue ??
                                                                                  '--';
                                                                          provider
                                                                              .studListUAS[index]
                                                                              .ceGrade =
                                                                              newValue ??
                                                                                  '--';

                                                                          if (newValue ==
                                                                              "-Select-" ||
                                                                              newValue ==
                                                                                  null) {
                                                                            // Handle "-Select-" as null
                                                                            provider
                                                                                .studListUAS[index]
                                                                                .ceGrade =
                                                                            null;
                                                                            ceGradeController[index]
                                                                                .clear();
                                                                            ceGradeController1[index]
                                                                                .clear();
                                                                          } else {
                                                                            // Assign the selected grade value
                                                                            ceGradeController[index]
                                                                                .text =
                                                                                snapshot
                                                                                    .gradeListUAS
                                                                                    .firstWhere((
                                                                                    grade) =>
                                                                                grade
                                                                                    .value ==
                                                                                    newValue)
                                                                                    .text ??
                                                                                    '--';
                                                                            ceGradeController1[index]
                                                                                .text =
                                                                                newValue ??
                                                                                    '--';
                                                                            provider
                                                                                .studListUAS[index]
                                                                                .ceGrade =
                                                                                newValue;
                                                                          }
                                                                          provider
                                                                              .studListUAS[index]
                                                                              .isEdited =
                                                                          true;
                                                                        }:null,

                                                                        //     value.examStatusUAS != 'Synchronized'
                                                                        //     ? (newValue) {
                                                                        //       ceGradeController[index].text == "-Select-"?null: '--';
                                                                        //   // Update the grade values
                                                                        //   ceGradeController[index].text = newValue ?? '--';
                                                                        //   ceGradeController1[index].text = newValue ?? '--';
                                                                        //   value.studListUAS[index].ceGrade = newValue ?? '--';
                                                                        //   value.studListUAS[index].isEdited = true;
                                                                        // }
                                                                        //     : null, // Disable dropdown if conditions are not met
                                                                        items: [
                                                                          // Add a default '-Select-' option
                                                                          DropdownMenuItem<String>(
                                                                            value: null,
                                                                            child: Text(
                                                                              "-Select-",
                                                                              textAlign: TextAlign.center,
                                                                              style: TextStyle(color: Colors.grey),
                                                                            ),
                                                                          ),
                                                                          // Populate dropdown items from the grade list
                                                                          ...snapshot.gradeListUAS.map((grade) {
                                                                            return DropdownMenuItem<String>(
                                                                              value: grade.value,
                                                                              child: Text(
                                                                                grade.text ?? '--',
                                                                                textAlign: TextAlign.center,
                                                                              ),
                                                                            );
                                                                          }).toList(),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                            },
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


                          print(
                              "---------------${value.studListUAS.length}");

                          print(value.tabulationTypeCode);
                          print(value.entryMethodUAS);

                          List<Map<String, dynamic>> studentEntries = provider.studListUAS
                              .where((student) => student.isEdited!)
                              .map((student) {
                            return {
                              "admissionNo": student.admissionNo,
                              "attendance": student.attendance,
                              "ceAttendance": student.ceAttendance,
                              "ceGrade": student.ceGrade,
                              "ceGradeId":student.ceGradeId,
                              "ceMark": student.ceMark,
                              "isAttendanceDisabled":student.isAttendanceDisabled,
                              "isCeDisabled": student.isCeDisabled,
                              "isDisabled": student.isDisabled,
                              "isEdited": student.isEdited,
                              "isPeDisabled": student.isPeDisabled,
                              "markEntryDetId": student.markEntryDetId,
                              "peAttendance": student.peAttendance,
                              "peGrade": student.peGrade,
                              "peGradeId": student.peGradeId,
                              "peMark": student.peMark,
                              "rollNo": student.rollNo,
                              "studentId": student.studentId,
                              "studentName": student.studentName,
                              "tabMarkEntryId": student.tabMarkEntryId,
                              "teGrade": student.teGrade,
                              "teGradeId": student.teGradeId,
                              "teMark": student.teMark,
                              "total": student.total,
                            };
                          }).toList();
                          print("student entries");
                          log(studentEntries.toString());
                          bool allMarksCleared = studentEntries.every((entry) =>
                          (entry['ceMark'] == null || entry['ceMark'] == 0) &&
                              (entry['peMark'] == null || entry['peMark'] == 0) &&
                              (entry['teMark'] == null || entry['teMark'] == 0));

                          if (studentEntries.isEmpty) {
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
                                    "No change in mark entry",
                                    textAlign: TextAlign.center,
                                  ),
                                ));
                          }
                          else if(provider.tabulationTypeCode=="UAS") {
                            await value.markEntrySave(
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
                                studentEntries,
                                value.gradeListUAS,
                                value.partsUAS);
                          }

                          else if(provider.tabulationTypeCode=="PBT"||provider.tabulationTypeCode=="STATE") {
                            await value.markEntrySTATESave(
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
                                studentEntries,
                                value.gradeListUAS,
                                value.partsUAS);
                          }
                          else {
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
                                    "Something went wrong",
                                    textAlign: TextAlign.center,
                                  ),
                                ));
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
                              :
                              () async
                          {

                            if (value.studListUAS.any((student) => student.isEdited == true)) {
                              ScaffoldMessenger.of(context)
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
                                      'Save the changes before verify',
                                      textAlign:
                                      TextAlign.center,
                                    ),
                                  ));

                            }

                            else if( value.examStatusUAS == "Verified" ||
                                value.examStatusUAS ==
                                    "Pending") {
                              ScaffoldMessenger.of(context)
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
                                  ));
                            }



                            else{
                              List obj = [];
                              obj.clear();
                              for (int i = 0; i < value.studListUAS.length; i++) {
                                obj.add(
                                  {
                                    "attendance": value
                                        .studListUAS[i]
                                        .attendance,
                                    "ceAttendance": value.studListUAS[i]
                                        .ceAttendance,
                                    "peAttendance": value.studListUAS[i]
                                        .peAttendance,
                                    "studentName": value
                                        .studListUAS[i]
                                        .studentName,
                                    "admissionNo": value
                                        .studListUAS[i]
                                        .admissionNo,
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
                                    "isPeDisabled": value
                                        .studListUAS[i].isPeDisabled,
                                    "isCeDisabled": value
                                        .studListUAS[i].isCeDisabled,
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
                              }
                              else {
                                value.loadVerify;
                                await value.markEntryVerify(
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
                                  value.partsUAS,
                                  markEntryDivisionListController1.text,
                                  markEntryDivisionListController1.text,
                                  markEntryExamListController1.text,
                                  markEntrySubjectListController1.text,
                                  markEntryOptionSubListController.text,
                                  provider.markEntryOptionSubjectList.isNotEmpty?(provider.markEntryOptionSubjectList[0].subjectDescription == "Sub Subject"?"Sub Subject":"Option Subject"):null,

                                );
                                value.examStatusUAS =
                                "Verified";
                                if(value.blockPdfDownload == false){
                                  await requestDownload(value.printurl.toString());
                                }
                              }
                            }
                          },

                          color: Colors.green,
                          child: const Text(
                            'Verify',
                            style: TextStyle(color:
                            Colors
                                .
                            white
                            )
                            ,
                          )
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
                                              side: WidgetStateProperty.all(const BorderSide(
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
                                            side: WidgetStateProperty.all(const BorderSide(
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
class CustomDropdownsButtonFormField extends StatelessWidget {
  final String? value;
  String? hint;
  final String label;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  CustomDropdownsButtonFormField({
    required this.value,
    this.hint,
    required this.label,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(

      crossAxisAlignment: CrossAxisAlignment.start, // Align the label to the start
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: Text(
            label, // Label for the dropdown
            style: TextStyle(
              fontSize: 12, // Adjust the size as needed
              //ontWeight: FontWeight.bold, // Make the label bold
            ),
          ),
        ),
        SizedBox(height: 0.5),
        DropdownButtonFormField<String>(
          value:value,
          onChanged: onChanged,
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,

              child: Text(item),
            );
          }).toList(),
          isExpanded: true,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: UIGuide.light_Purple
                  )
              )
          ),
        ),
      ],
    );
  }
}
InputDecoration customInputDecoration({
  String? labelText,
  String? hintText,
  EdgeInsets contentPadding = const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
  Color borderColor = Colors.grey,
  Color focusedBorderColor = UIGuide.light_Purple,
  double borderWidth = 1.5,
  double focusedBorderWidth = 2.0,
  double borderRadius = 8.0,
}) {
  return InputDecoration(
    labelText: labelText,
    hintText: hintText,
    contentPadding: contentPadding,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(
        color: borderColor,
        width: borderWidth,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(
        color: borderColor,
        width: borderWidth,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(
        color: focusedBorderColor,
        width: focusedBorderWidth,
      ),
    ),
  );
}


