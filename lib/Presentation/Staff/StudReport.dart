import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:essconnect/Presentation/Staff/Searchstudent.dart';
import 'package:essconnect/utils/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Application/Staff_Providers/StudListProvider.dart';
import '../../Constants.dart';
import '../../utils/constants.dart';

class StudReport extends StatelessWidget {
  const StudReport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Student Report'),
              titleSpacing: 20.0,
              centerTitle: true,
              toolbarHeight: 40.2,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25)),
              ),
              bottom: const TabBar(
                physics: NeverScrollableScrollPhysics(),
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: Colors.white,
                indicatorWeight: 5,
                tabs: [
                  Tab(
                    text: "Studying",
                  ),
                  Tab(text: "Relieved"),
                  Tab(text: 'Both')
                ],
              ),
              backgroundColor: UIGuide.light_Purple,
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const StudReport()));
                    },
                    icon: const Icon(Icons.refresh)),
                IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchStudent_stf()),
                      );
                    },
                    icon: const Icon(Icons.search))
              ],
            ),
            body: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  StudCurrentStudying(
                    status: "true",
                  ),
                  StudCurrentStudying(
                    status: "false",
                  ),
                  StudCurrentStudying(status: ''),
                ])));
  }
}

class StudCurrentStudying extends StatefulWidget {
  final String status;
  StudCurrentStudying({Key? key, required this.status}) : super(key: key);

  @override
  State<StudCurrentStudying> createState() => _StudCurrentStudyingState();
}

class _StudCurrentStudyingState extends State<StudCurrentStudying> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var p = Provider.of<StudReportListProvider_stf>(context, listen: false);
      p.stdReportSectionStaff();
      p.clearAllFilters();
      p.removeSectionAll();
      p.courseClear();
      p.divisionClear();
      p.sectionClear();
      p.removeSectionAll();
      p.removeDivisionAll();
      p.removeCourseAll();
      p.clearViewList();
    });
  }

  String? phn;
  String sectionId = '';
  String courseId = '';
  String divisionId = '';
  final studReportInitialValuesController = TextEditingController();
  final studReportInitialValuesController1 = TextEditingController();
  final studReportcourseController = TextEditingController();
  final studReportcourseController1 = TextEditingController();
  final studReportDivisionController = TextEditingController();
  final studReportDivisionController1 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Consumer<StudReportListProvider_stf>(
      builder: (context, value, child) => Column(
        children: [
          kheight10,
          Row(
            children: [
              kWidth,
              Expanded(
                child: SizedBox(
                  height: 45,
                  child: Consumer<StudReportListProvider_stf>(
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
                                      borderRadius: BorderRadius.circular(15)),
                                  child: LimitedBox(
                                    maxHeight: size.height - 300,
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount:
                                            studReportinitvalues_stf!.length,
                                        itemBuilder: (context, index) {
                                          //  value.removeSectionAll();
                                          return ListTile(
                                            selectedTileColor:
                                                Colors.blue.shade100,
                                            onTap: () async {
                                              await value.removeDivisionAll();

                                              studReportDivisionController1
                                                  .clear();

                                              value.divisionClear();
                                              await value.removeCourseAll();
                                              await value.removeDivisionAll();
                                              await value.clearViewList();
                                              studReportcourseController1
                                                  .clear();
                                              studReportDivisionController1
                                                  .clear();

                                              studReportInitialValuesController
                                                      .text =
                                                  await studReportinitvalues_stf![
                                                          index]['value'] ??
                                                      '--';
                                              studReportInitialValuesController1
                                                      .text =
                                                  await studReportinitvalues_stf![
                                                          index]['text'] ??
                                                      '--';
                                              sectionId =
                                                  studReportInitialValuesController
                                                      .text
                                                      .toString();
                                              await value.clearViewList();

                                              await value.courseClear();
                                              await value
                                                  .getCourseList(sectionId);
                                              Navigator.of(context).pop();
                                            },
                                            title: Text(
                                              studReportinitvalues_stf![index]
                                                      ['text'] ??
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
                        controller: studReportInitialValuesController1,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(left: 1, top: 0),
                          filled: true,
                          fillColor: Colors.transparent,
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(style: BorderStyle.none, width: 0),
                          ),
                          labelText: "  Select Section",
                          hintText: "Section",
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                        ),
                        enabled: false,
                      ),
                    );
                  }),
                ),
              ),
              kWidth,
              Expanded(
                child: SizedBox(
                  height: 45,
                  child: Consumer<StudReportListProvider_stf>(
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
                                      borderRadius: BorderRadius.circular(15)),
                                  child: LimitedBox(
                                    maxHeight: size.height - 300,
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: snapshot.courselist.length,
                                        itemBuilder: (context, index) {
                                          return ListTile(
                                            onTap: () async {
                                              await value.removeDivisionAll();
                                              await value.clearViewList();
                                              studReportDivisionController1
                                                  .clear();
                                              print(snapshot.courselist.length);
                                              studReportcourseController.text =
                                                  snapshot.courselist[index]
                                                          .value ??
                                                      '---';
                                              studReportcourseController1.text =
                                                  snapshot.courselist[index]
                                                              .text ==
                                                          null
                                                      ? '---'
                                                      : snapshot
                                                          .courselist[index]
                                                          .text;
                                              snapshot.addSelectedCourse(
                                                  snapshot.courselist[index]);
                                              courseId =
                                                  studReportcourseController
                                                      .text
                                                      .toString();
                                              print(studReportcourseController
                                                  .text);
                                              sectionId =
                                                  studReportInitialValuesController
                                                      .text
                                                      .toString();
                                              await value.divisionClear();

                                              await value
                                                  .getDivisionList(courseId);

                                              Navigator.of(context).pop();
                                            },
                                            title: Text(
                                              snapshot.courselist[index].text ==
                                                      null
                                                  ? '---'
                                                  : snapshot
                                                      .courselist[index].text,
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
                        controller: studReportcourseController1,
                        decoration: const InputDecoration(
                          filled: true,
                          contentPadding: EdgeInsets.only(left: 1, top: 0),
                          fillColor: Colors.transparent,
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(style: BorderStyle.none, width: 0),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          labelText: "   Select Course",
                          hintText: "Course",
                        ),
                        enabled: false,
                      ),
                    );
                  }),
                ),
              ),
              kWidth,
            ],
          ),
          kheight10,
          Row(
            children: [
              kWidth,
              Expanded(
                child: SizedBox(
                  height: 45,
                  child: Consumer<StudReportListProvider_stf>(
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
                                      borderRadius: BorderRadius.circular(15)),
                                  child: LimitedBox(
                                    maxHeight: size.height - 300,
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: snapshot.divisionlist.length,
                                        itemBuilder: (context, index) {
                                          return Column(
                                            children: [
                                              ListTile(
                                                selected: snapshot
                                                    .isDivisionSelected(snapshot
                                                        .divisionlist[index]),
                                                onTap: () async {
                                                  print(snapshot
                                                      .divisionlist.length);
                                                  studReportDivisionController
                                                      .text = snapshot
                                                          .divisionlist[index]
                                                          .value ??
                                                      '---';
                                                  studReportDivisionController1
                                                      .text = snapshot
                                                          .divisionlist[index]
                                                          .text ??
                                                      '---';
                                                  snapshot.addSelectedDivision(
                                                      snapshot
                                                          .divisionlist[index]);

                                                  print(
                                                      studReportDivisionController
                                                          .text);
                                                  divisionId =
                                                      studReportDivisionController
                                                          .text
                                                          .toString();
                                                  Navigator.of(context).pop();
                                                },
                                                title: Text(
                                                  snapshot.divisionlist[index]
                                                          .text ??
                                                      '---',
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ],
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
                        controller: studReportDivisionController1,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(left: 1, top: 0),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          filled: true,
                          fillColor: Colors.transparent,
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(style: BorderStyle.none, width: 0),
                          ),
                          labelText: "  Select Division",
                          hintText: "Division",
                        ),
                        enabled: false,
                      ),
                    );
                  }),
                ),
              ),
              kWidth,
              Consumer<StudReportListProvider_stf>(
                builder: (context, value, child) => value.loading
                    ? const Expanded(
                        child: SizedBox(
                          height: 45,
                          child: Center(
                            child: Text(
                              'Loading...',
                              style: TextStyle(color: UIGuide.light_Purple),
                            ),
                          ),
                        ),
                      )
                    : Expanded(
                        child: SizedBox(
                          height: 45,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 3,
                              foregroundColor: UIGuide.WHITE,
                              backgroundColor: UIGuide.light_Purple,
                              padding: const EdgeInsets.all(0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: const BorderSide(
                                    color: UIGuide.light_black,
                                  )),
                            ),
                            onPressed: (() async {
                              if (studReportInitialValuesController
                                  .text.isEmpty) {
                                snackbarWidget(
                                    2, "Select Section to continue..", context);
                                // return AwesomeDialog(
                                //         context: context,
                                //         dialogType: DialogType.warning,
                                //         animType: AnimType.rightSlide,
                                //         headerAnimationLoop: false,
                                //         title: 'Warning',
                                //         desc: 'Select mandatory fields',
                                //         btnOkOnPress: () {
                                //           return;
                                //         },
                                //         btnOkIcon: Icons.cancel,
                                //         btnOkColor: Colors.red)
                                //     .show();
                              } else {
                                courseId =
                                    studReportcourseController.text.toString();
                                print(courseId);
                                divisionId = studReportDivisionController.text
                                    .toString();
                                print(divisionId);
                                print(sectionId);
                                sectionId = studReportInitialValuesController
                                    .text
                                    .toString();

                                await value.removeSectionAll();

                                await value.removeCourseAll();

                                await value.removeDivisionAll();
                                await value.clearViewList();
                                await value.viewStudentReportList(
                                    sectionId, courseId, divisionId);
                                if (value.viewStudReportListt.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      elevation: 10,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                      ),
                                      duration: Duration(seconds: 2),
                                      margin: EdgeInsets.only(
                                          bottom: 80, left: 30, right: 30),
                                      behavior: SnackBarBehavior.floating,
                                      content: Text(
                                        'Data not foumd',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  );
                                }
                              }
                            }),
                            child: const Text('View'),
                          ),
                        ),
                      ),
              ),
              kWidth
            ],
          ),
          kheight10,
          Expanded(
            child: Consumer<StudReportListProvider_stf>(
              builder: (context, provider, child) => provider.loading
                  ? spinkitLoader()
                  : Scrollbar(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: provider.viewStudReportListt.isEmpty
                            ? 0
                            : provider.viewStudReportListt.length,
                        itemBuilder: (context, index) {
                          return provider.viewStudReportListt[index]
                                      .terminationStatus
                                      .toString() ==
                                  widget.status
                              ? const SizedBox(
                                  height: 0,
                                  width: 0,
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, top: 4, bottom: 4),
                                  child: Container(
                                    width: size.width - 4,
                                    height: 93,
                                    decoration: const BoxDecoration(
                                        color: UIGuide.light_Purple,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const SizedBox(
                                          height: 2.5,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      StudProfileViewBySearch_Staff(
                                                        stud: provider
                                                                .viewStudReportListt[
                                                            index],
                                                      )
                                                  // StudProfileView_Staff(
                                                  //   indexx: index,
                                                  // )
                                                  ),
                                            );
                                          },
                                          child: Container(
                                            width: size.width - 6,
                                            height: 90,
                                            decoration: const BoxDecoration(
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                kWidth,
                                                Center(
                                                  child: Container(
                                                    width: 70,
                                                    height: 70,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              236,
                                                              233,
                                                              233),
                                                      image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: NetworkImage(provider
                                                                  .viewStudReportListt[
                                                                      index]
                                                                  .studentPhoto ??
                                                              'https://gj-eschool-files-public.s3.ap-south-1.amazonaws.com/ess-connect/student/avathar-01.jpeg')),
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                        Radius.circular(10),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            const Text(
                                                              'Name : ',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize: 13),
                                                            ),
                                                            Expanded(
                                                              child: Text(
                                                                provider
                                                                        .viewStudReportListt[
                                                                            index]
                                                                        .name ??
                                                                    '---',
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 12,
                                                                  color: UIGuide
                                                                      .light_Purple,
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            const Text(
                                                              'Roll No : ',
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize: 13),
                                                            ),
                                                            RichText(
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              maxLines: 1,
                                                              strutStyle:
                                                                  const StrutStyle(
                                                                      fontSize:
                                                                          8.0),
                                                              text: TextSpan(
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                                text: provider
                                                                            .viewStudReportListt[
                                                                                index]
                                                                            .rollNo ==
                                                                        null
                                                                    ? '---'
                                                                    : provider
                                                                        .viewStudReportListt[
                                                                            index]
                                                                        .rollNo
                                                                        .toString(),
                                                              ),
                                                            ),
                                                            kWidth,
                                                            kWidth,
                                                            Row(
                                                              children: [
                                                                const Text(
                                                                  'Division : ',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontSize:
                                                                          13),
                                                                ),
                                                                RichText(
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  maxLines: 1,
                                                                  strutStyle:
                                                                      const StrutStyle(
                                                                          fontSize:
                                                                              8.0),
                                                                  text:
                                                                      TextSpan(
                                                                    style:
                                                                        const TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                    text: provider
                                                                            .viewStudReportListt[index]
                                                                            .division ??
                                                                        '---',
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            const Text(
                                                              'Adm No : ',
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize: 13),
                                                            ),
                                                            RichText(
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              maxLines: 1,
                                                              strutStyle:
                                                                  const StrutStyle(
                                                                      fontSize:
                                                                          8.0),
                                                              text: TextSpan(
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                                text: provider
                                                                        .viewStudReportListt[
                                                                            index]
                                                                        .admnNo ??
                                                                    '---',
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        GestureDetector(
                                                          onTap: () async {
                                                            phn = provider
                                                                        .viewStudReportListt[
                                                                            index]
                                                                        .mobNo ==
                                                                    null
                                                                ? '--'
                                                                : provider
                                                                    .viewStudReportListt[
                                                                        index]
                                                                    .mobNo
                                                                    .toString();

                                                            _makingPhoneCall(
                                                                phn.toString());
                                                          },
                                                          child: Row(
                                                            children: [
                                                              const Text(
                                                                'Phone : ',
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontSize:
                                                                        13),
                                                              ),
                                                              RichText(
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                maxLines: 1,
                                                                strutStyle:
                                                                    const StrutStyle(
                                                                        fontSize:
                                                                            8.0),
                                                                text: TextSpan(
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        13,
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                  text: provider
                                                                          .viewStudReportListt[
                                                                              index]
                                                                          .mobNo ??
                                                                      '---',
                                                                ),
                                                              ),
                                                              const Icon(
                                                                Icons.phone,
                                                                size: 17,
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
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
                        },
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  _makingPhoneCall(String phn) async {
    var url = Uri.parse("tel:$phn");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

// class StudProfileView_Staff extends StatelessWidget {
//   StudProfileView_Staff({Key? key, required this.indexx}) : super(key: key);
//   final int indexx;
//   String? phn;
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;

//     const Color background = Colors.white;
//     const Color fill1 = UIGuide.light_Purple;
//     const Color fill2 = UIGuide.custom_blue;
//     final List<Color> gradient = [
//       fill1,
//       fill2,
//       background,
//       background,
//     ];
//     const double fillPercent = 35;
//     const double fillStop = (100 - fillPercent) / 100;
//     final List<double> stops = [0.0, fillStop, fillStop, 1.0];

//     return Scaffold(
//       appBar: AppBar(
//         toolbarHeight: 0,
//         backgroundColor: UIGuide.light_Purple,
//       ),
//       body: Consumer<StudReportListProvider_stf>(
//         builder: (context, value, child) => ListView(
//           physics: const BouncingScrollPhysics(),
//           children: [
//             Stack(
//               children: [
//                 Container(
//                   height: 260,
//                   width: size.width,
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: gradient,
//                       stops: stops,
//                       end: Alignment.bottomCenter,
//                       begin: Alignment.topCenter,
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   top: 70,
//                   left: 30,
//                   right: 30,
//                   child: Container(
//                       decoration: const BoxDecoration(
//                           color: UIGuide.WHITE,
//                           boxShadow: [
//                             BoxShadow(
//                               color: Color.fromARGB(255, 128, 125, 125),
//                               offset: Offset(
//                                 2,
//                                 5.0,
//                               ),
//                               blurRadius: 5.0,
//                               spreadRadius: 2.0,
//                             ),
//                           ],
//                           borderRadius: BorderRadius.all(Radius.circular(10))),
//                       width: size.width - 50,
//                       height: 170,
//                       child: Column(
//                         children: [
//                           kheight20,
//                           kheight20,
//                           kheight20,
//                           kheight10,
//                           Text(
//                             value.viewStudReportListt[indexx].name ?? '---',
//                             style: const TextStyle(
//                                 fontWeight: FontWeight.w500, fontSize: 13),
//                           ),
//                           const SizedBox(
//                             height: 4,
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               const Text('Division : ',
//                                   style: TextStyle(
//                                       fontSize: 14.0, color: Colors.grey)),
//                               Text(
//                                   value.viewStudReportListt[indexx].division ??
//                                       '---',
//                                   style: const TextStyle(fontSize: 14.0)),
//                             ],
//                           ),
//                           kheight10,
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Table(
//                               border: TableBorder.all(
//                                   color:
//                                       const Color.fromARGB(255, 233, 233, 245),
//                                   style: BorderStyle.solid,
//                                   width: 2),
//                               children: [
//                                 TableRow(children: [
//                                   Column(
//                                     children: [
//                                       const Text('Roll No',
//                                           style: TextStyle(color: Colors.grey)),
//                                       Text(
//                                           value.viewStudReportListt[indexx]
//                                                       .rollNo ==
//                                                   null
//                                               ? '---'
//                                               : value
//                                                   .viewStudReportListt[indexx]
//                                                   .rollNo
//                                                   .toString(),
//                                           style:
//                                               const TextStyle(fontSize: 14.0)),
//                                     ],
//                                   ),
//                                   Column(
//                                     children: [
//                                       const Text('Adm No',
//                                           style: TextStyle(color: Colors.grey)),
//                                       Text(
//                                           value.viewStudReportListt[indexx]
//                                                   .admnNo ??
//                                               '---',
//                                           style:
//                                               const TextStyle(fontSize: 14.0)),
//                                     ],
//                                   ),
//                                 ])
//                               ],
//                             ),
//                           )
//                         ],
//                       )),
//                 ),
//                 Center(
//                   child: CircleAvatar(
//                     foregroundColor: Colors.white,
//                     foregroundImage: NetworkImage(
//                       value.viewStudReportListt[indexx].studentPhoto ??
//                           'https://gj-eschool-files-public.s3.ap-south-1.amazonaws.com/ess-connect/student/avathar-02.jpeg',
//                     ),
//                     radius: 65,
//                     backgroundColor: UIGuide.WHITE,
//                   ),
//                 )
//               ],
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Container(
//                 padding: const EdgeInsets.all(10),
//                 width: size.width,
//                 decoration: BoxDecoration(
//                     color: UIGuide.light_black,
//                     borderRadius: BorderRadius.circular(10)),
//                 child: Column(
//                   children: [
//                     Container(
//                       decoration: const BoxDecoration(
//                         color: UIGuide.light_black,
//                       ),
//                       width: size.width,
//                       height: 85,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text(
//                             'Permanent Address',
//                             style: TextStyle(
//                                 fontSize: 14, fontWeight: FontWeight.w700),
//                           ),
//                           const SizedBox(
//                             height: 5,
//                           ),
//                           Flexible(
//                             child: RichText(
//                               overflow: TextOverflow.ellipsis,
//                               strutStyle: const StrutStyle(fontSize: 13),
//                               maxLines: 3,
//                               text: TextSpan(
//                                 style: const TextStyle(
//                                     fontSize: 15,
//                                     color: Color.fromARGB(255, 44, 43, 43)),
//                                 text:
//                                     value.viewStudReportListt[indexx].address ??
//                                         '---',
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Row(
//                       children: [
//                         const Text(
//                           'Bus Name : ',
//                           style: TextStyle(
//                               fontWeight: FontWeight.w500, fontSize: 13),
//                         ),
//                         Flexible(
//                           child: Text(
//                             value.viewStudReportListt[indexx].bus ?? '---',
//                             overflow: TextOverflow.clip,
//                             style: const TextStyle(fontSize: 12),
//                           ),
//                         )
//                       ],
//                     ),
//                     kheight10,
//                     Row(
//                       children: [
//                         const Text(
//                           'Bus Stop : ',
//                           style: TextStyle(
//                               fontWeight: FontWeight.w500, fontSize: 13),
//                         ),
//                         Flexible(
//                           child: Text(
//                             value.viewStudReportListt[indexx].stop ?? '---',
//                             overflow: TextOverflow.clip,
//                             style: const TextStyle(fontSize: 12),
//                           ),
//                         )
//                       ],
//                     ),
//                     kheight10,
//                     GestureDetector(
//                       onTap: () {
//                         _makingPhoneCall(phn.toString());
//                       },
//                       child: Row(
//                         children: [
//                           const Text(
//                             'Phone No : ',
//                             style: TextStyle(
//                                 fontWeight: FontWeight.w500, fontSize: 13),
//                           ),
//                           Flexible(
//                             child: Text(
//                               phn = value.viewStudReportListt[indexx].mobNo ??
//                                   '---',
//                               overflow: TextOverflow.clip,
//                               style: const TextStyle(fontSize: 12),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   _makingPhoneCall(String phn) async {
//     var url = Uri.parse("tel:$phn");
//     if (await canLaunchUrl(url)) {
//       await launchUrl(url);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }
// }
