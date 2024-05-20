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
                            builder: (context) => const SearchStudent_stf()),
                      );
                    },
                    icon: const Icon(Icons.search))
              ],
            ),
            body: const TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  StudCurrentStudying(),
                  StudReportTerminatedScreen(),
                  StudReportBothScreen(),
                ])));
  }
}

class StudCurrentStudying extends StatefulWidget {
  const StudCurrentStudying({Key? key}) : super(key: key);

  @override
  State<StudCurrentStudying> createState() => _StudCurrentStudyingState();
}

class _StudCurrentStudyingState extends State<StudCurrentStudying> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var p = Provider.of<StudReportListProvider_stf>(context, listen: false);
      await p.setLoading(false);
      await p.clearAllFilters();
      await p.removeSectionAll();
      await p.courseClear();
      await p.divisionClear();
      await p.sectionClear();
      await p.removeSectionAll();
      await p.removeDivisionAll();
      await p.removeCourseAll();
      await p.clearViewList();
      await p.stdReportSectionStaff();
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
      builder: (context, value, child) => Stack(
        children: [
          Column(
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
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: LimitedBox(
                                        maxHeight: size.height - 300,
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: studReportinitvalues_stf!
                                                .length,
                                            itemBuilder: (context, index) {
                                              //  value.removeSectionAll();
                                              return ListTile(
                                                selectedTileColor:
                                                    Colors.blue.shade100,
                                                onTap: () async {
                                                  Navigator.of(context).pop();
                                                  await value
                                                      .removeDivisionAll();

                                                  studReportDivisionController1
                                                      .clear();

                                                  value.divisionClear();
                                                  await value.removeCourseAll();
                                                  await value
                                                      .removeDivisionAll();
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
                                                },
                                                title: Text(
                                                  studReportinitvalues_stf![
                                                          index]['text'] ??
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
                                borderSide: BorderSide(
                                    style: BorderStyle.none, width: 0),
                              ),
                              labelText: "  Select Section",
                              hintText: "Section",
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
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
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: LimitedBox(
                                        maxHeight: size.height - 300,
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount:
                                                snapshot.courselist.length,
                                            itemBuilder: (context, index) {
                                              return ListTile(
                                                onTap: () async {
                                                  Navigator.of(context).pop();
                                                  await value
                                                      .removeDivisionAll();
                                                  await value.clearViewList();
                                                  studReportDivisionController1
                                                      .clear();
                                                  print(snapshot
                                                      .courselist.length);
                                                  studReportcourseController
                                                      .text = snapshot
                                                          .courselist[index]
                                                          .value ??
                                                      '---';
                                                  studReportcourseController1
                                                      .text = snapshot
                                                          .courselist[index]
                                                          .text ??
                                                      "";
                                                  snapshot.addSelectedCourse(
                                                      snapshot
                                                          .courselist[index]);
                                                  courseId =
                                                      studReportcourseController
                                                          .text
                                                          .toString();
                                                  print(
                                                      studReportcourseController
                                                          .text);
                                                  sectionId =
                                                      studReportInitialValuesController
                                                          .text
                                                          .toString();
                                                  await value.divisionClear();

                                                  await value.getDivisionList(
                                                      courseId);
                                                },
                                                title: Text(
                                                  snapshot.courselist[index]
                                                          .text ??
                                                      "",
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
                                borderSide: BorderSide(
                                    style: BorderStyle.none, width: 0),
                              ),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
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
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: LimitedBox(
                                        maxHeight: size.height - 300,
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount:
                                                snapshot.divisionlist.length,
                                            itemBuilder: (context, index) {
                                              return Column(
                                                children: [
                                                  ListTile(
                                                    selected: snapshot
                                                        .isDivisionSelected(
                                                            snapshot.divisionlist[
                                                                index]),
                                                    onTap: () async {
                                                      Navigator.of(context)
                                                          .pop();
                                                      print(snapshot
                                                          .divisionlist.length);
                                                      studReportDivisionController
                                                          .text = snapshot
                                                              .divisionlist[
                                                                  index]
                                                              .value ??
                                                          '---';
                                                      studReportDivisionController1
                                                          .text = snapshot
                                                              .divisionlist[
                                                                  index]
                                                              .text ??
                                                          '---';
                                                      snapshot.addSelectedDivision(
                                                          snapshot.divisionlist[
                                                              index]);

                                                      print(
                                                          studReportDivisionController
                                                              .text);
                                                      divisionId =
                                                          studReportDivisionController
                                                              .text
                                                              .toString();
                                                      await value
                                                          .clearViewList();
                                                    },
                                                    title: Text(
                                                      snapshot
                                                              .divisionlist[
                                                                  index]
                                                              .text ??
                                                          '---',
                                                      textAlign:
                                                          TextAlign.center,
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
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              filled: true,
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
                                        2,
                                        "Select Section to continue..",
                                        context);
                                  } else {
                                    courseId = studReportcourseController.text
                                        .toString();
                                    print(courseId);
                                    divisionId = studReportDivisionController
                                        .text
                                        .toString();
                                    print(divisionId);
                                    print(sectionId);
                                    sectionId =
                                        studReportInitialValuesController.text
                                            .toString();

                                    await value.removeSectionAll();

                                    await value.removeCourseAll();

                                    await value.removeDivisionAll();
                                    await value.clearViewList();
                                    await value.viewStudentReportList(
                                        sectionId, courseId, divisionId);
                                    if (value.viewNotTerminatedList.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
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
                  builder: (context, provider, child) => Scrollbar(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: provider.viewNotTerminatedList.isEmpty
                          ? 0
                          : provider.viewNotTerminatedList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 4, bottom: 4),
                          child: Container(
                            width: size.width - 4,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 0.5,
                                    blurRadius: 3,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                                color: UIGuide.light_Purple,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 1.5,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              StudProfileViewBySearch_Staff(
                                                stud: provider
                                                        .viewNotTerminatedList[
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
                                    //  height: 90,
                                    decoration: const BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Center(
                                            child: Container(
                                              width: 70,
                                              height: 70,
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    255, 236, 233, 233),
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(provider
                                                            .viewNotTerminatedList[
                                                                index]
                                                            .studentPhoto ??
                                                        'https://gj-eschool-files-public.s3.ap-south-1.amazonaws.com/ess-connect/student/avathar-01.jpeg')),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  const Text(
                                                    'Name : ',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 13),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      provider
                                                              .viewNotTerminatedList[
                                                                  index]
                                                              .name ??
                                                          '---',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                        color: UIGuide
                                                            .light_Purple,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(3),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            const BorderRadius
                                                                .only(
                                                          topRight:
                                                              Radius.circular(
                                                                  10),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  10),
                                                        ),
                                                        border: Border.all(
                                                            color: const Color
                                                                .fromARGB(255,
                                                                224, 224, 224)),
                                                        color: const Color
                                                            .fromARGB(255, 255,
                                                            251, 251)),
                                                    child: Text(
                                                      " ${index + 1} ",
                                                      style: const TextStyle(
                                                          fontSize: 12),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 1),
                                                child: Row(
                                                  children: [
                                                    const Text(
                                                      'Roll No : ',
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 13),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        provider
                                                                    .viewNotTerminatedList[
                                                                        index]
                                                                    .rollNo ==
                                                                null
                                                            ? '---'
                                                            : provider
                                                                .viewNotTerminatedList[
                                                                    index]
                                                                .rollNo
                                                                .toString(),
                                                        maxLines: 1,
                                                        style: const TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                    kWidth,
                                                    const Text(
                                                      'Division : ',
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 13),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        provider
                                                                .viewNotTerminatedList[
                                                                    index]
                                                                .division ??
                                                            '---',
                                                        maxLines: 1,
                                                        style: const TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 4),
                                                child: Row(
                                                  children: [
                                                    const Text(
                                                      'Adm No : ',
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 13),
                                                    ),
                                                    RichText(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                      strutStyle:
                                                          const StrutStyle(
                                                              fontSize: 8.0),
                                                      text: TextSpan(
                                                        style: const TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.black,
                                                        ),
                                                        text: provider
                                                                .viewNotTerminatedList[
                                                                    index]
                                                                .admnNo ??
                                                            '---',
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 4),
                                                child: GestureDetector(
                                                  onTap: () async {
                                                    phn = provider
                                                                .viewNotTerminatedList[
                                                                    index]
                                                                .mobNo ==
                                                            null
                                                        ? '--'
                                                        : provider
                                                            .viewNotTerminatedList[
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
                                                            TextAlign.start,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 13),
                                                      ),
                                                      RichText(
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 1,
                                                        strutStyle:
                                                            const StrutStyle(
                                                                fontSize: 8.0),
                                                        text: TextSpan(
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 13,
                                                            color: Colors.black,
                                                          ),
                                                          text: provider
                                                                  .viewNotTerminatedList[
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
                                              ),
                                            ],
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
          if (value.loading) pleaseWaitLoader()
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

class StudReportTerminatedScreen extends StatefulWidget {
  const StudReportTerminatedScreen({Key? key}) : super(key: key);

  @override
  State<StudReportTerminatedScreen> createState() =>
      _StudReportTerminatedScreenState();
}

class _StudReportTerminatedScreenState
    extends State<StudReportTerminatedScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var p = Provider.of<StudReportListProvider_stf>(context, listen: false);
      await p.setLoading(false);
      await p.clearAllFilters();
      await p.removeSectionAll();
      await p.courseClear();
      await p.divisionClear();
      await p.sectionClear();
      await p.removeSectionAll();
      await p.removeDivisionAll();
      await p.removeCourseAll();
      await p.clearViewList();
      await p.stdReportSectionStaff();
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
      builder: (context, value, child) => Stack(
        children: [
          Column(
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
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: LimitedBox(
                                        maxHeight: size.height - 300,
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: studReportinitvalues_stf!
                                                .length,
                                            itemBuilder: (context, index) {
                                              //  value.removeSectionAll();
                                              return ListTile(
                                                selectedTileColor:
                                                    Colors.blue.shade100,
                                                onTap: () async {
                                                  Navigator.of(context).pop();
                                                  await value
                                                      .removeDivisionAll();

                                                  studReportDivisionController1
                                                      .clear();

                                                  value.divisionClear();
                                                  await value.removeCourseAll();
                                                  await value
                                                      .removeDivisionAll();
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
                                                },
                                                title: Text(
                                                  studReportinitvalues_stf![
                                                          index]['text'] ??
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
                                borderSide: BorderSide(
                                    style: BorderStyle.none, width: 0),
                              ),
                              labelText: "  Select Section",
                              hintText: "Section",
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
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
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: LimitedBox(
                                        maxHeight: size.height - 300,
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount:
                                                snapshot.courselist.length,
                                            itemBuilder: (context, index) {
                                              return ListTile(
                                                onTap: () async {
                                                  Navigator.of(context).pop();
                                                  await value
                                                      .removeDivisionAll();
                                                  await value.clearViewList();
                                                  studReportDivisionController1
                                                      .clear();
                                                  print(snapshot
                                                      .courselist.length);
                                                  studReportcourseController
                                                      .text = snapshot
                                                          .courselist[index]
                                                          .value ??
                                                      '---';
                                                  studReportcourseController1
                                                      .text = snapshot
                                                          .courselist[index]
                                                          .text ??
                                                      "";
                                                  snapshot.addSelectedCourse(
                                                      snapshot
                                                          .courselist[index]);
                                                  courseId =
                                                      studReportcourseController
                                                          .text
                                                          .toString();
                                                  print(
                                                      studReportcourseController
                                                          .text);
                                                  sectionId =
                                                      studReportInitialValuesController
                                                          .text
                                                          .toString();
                                                  await value.divisionClear();

                                                  await value.getDivisionList(
                                                      courseId);
                                                },
                                                title: Text(
                                                  snapshot.courselist[index]
                                                          .text ??
                                                      "",
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
                                borderSide: BorderSide(
                                    style: BorderStyle.none, width: 0),
                              ),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
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
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: LimitedBox(
                                        maxHeight: size.height - 300,
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount:
                                                snapshot.divisionlist.length,
                                            itemBuilder: (context, index) {
                                              return Column(
                                                children: [
                                                  ListTile(
                                                    selected: snapshot
                                                        .isDivisionSelected(
                                                            snapshot.divisionlist[
                                                                index]),
                                                    onTap: () async {
                                                      Navigator.of(context)
                                                          .pop();
                                                      print(snapshot
                                                          .divisionlist.length);
                                                      studReportDivisionController
                                                          .text = snapshot
                                                              .divisionlist[
                                                                  index]
                                                              .value ??
                                                          '---';
                                                      studReportDivisionController1
                                                          .text = snapshot
                                                              .divisionlist[
                                                                  index]
                                                              .text ??
                                                          '---';
                                                      snapshot.addSelectedDivision(
                                                          snapshot.divisionlist[
                                                              index]);

                                                      print(
                                                          studReportDivisionController
                                                              .text);
                                                      divisionId =
                                                          studReportDivisionController
                                                              .text
                                                              .toString();
                                                      await value
                                                          .clearViewList();
                                                    },
                                                    title: Text(
                                                      snapshot
                                                              .divisionlist[
                                                                  index]
                                                              .text ??
                                                          '---',
                                                      textAlign:
                                                          TextAlign.center,
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
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              filled: true,
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
                                        2,
                                        "Select Section to continue..",
                                        context);
                                  } else {
                                    courseId = studReportcourseController.text
                                        .toString();
                                    print(courseId);
                                    divisionId = studReportDivisionController
                                        .text
                                        .toString();
                                    print(divisionId);
                                    print(sectionId);
                                    sectionId =
                                        studReportInitialValuesController.text
                                            .toString();

                                    await value.removeSectionAll();

                                    await value.removeCourseAll();

                                    await value.removeDivisionAll();
                                    await value.clearViewList();
                                    await value.viewStudentReportList(
                                        sectionId, courseId, divisionId);
                                    if (value.viewterminatedList.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
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
                  builder: (context, provider, child) => Scrollbar(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: provider.viewterminatedList.isEmpty
                          ? 0
                          : provider.viewterminatedList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 4, bottom: 4),
                          child: Container(
                            width: size.width - 4,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 0.5,
                                    blurRadius: 3,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                                color: UIGuide.light_Purple,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 1.5,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              StudProfileViewBySearch_Staff(
                                                stud: provider
                                                    .viewterminatedList[index],
                                              )
                                          // StudProfileView_Staff(
                                          //   indexx: index,
                                          // )
                                          ),
                                    );
                                  },
                                  child: Container(
                                    width: size.width - 6,
                                    //  height: 90,
                                    decoration: const BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Center(
                                            child: Container(
                                              width: 70,
                                              height: 70,
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    255, 236, 233, 233),
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(provider
                                                            .viewterminatedList[
                                                                index]
                                                            .studentPhoto ??
                                                        'https://gj-eschool-files-public.s3.ap-south-1.amazonaws.com/ess-connect/student/avathar-01.jpeg')),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  const Text(
                                                    'Name : ',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 13),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      provider
                                                              .viewterminatedList[
                                                                  index]
                                                              .name ??
                                                          '---',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                        color: UIGuide
                                                            .light_Purple,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(3),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            const BorderRadius
                                                                .only(
                                                          topRight:
                                                              Radius.circular(
                                                                  10),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  10),
                                                        ),
                                                        border: Border.all(
                                                            color: const Color
                                                                .fromARGB(255,
                                                                224, 224, 224)),
                                                        color: const Color
                                                            .fromARGB(255, 255,
                                                            251, 251)),
                                                    child: Text(
                                                      " ${index + 1} ",
                                                      style: const TextStyle(
                                                          fontSize: 12),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 1),
                                                child: Row(
                                                  children: [
                                                    const Text(
                                                      'Roll No : ',
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 13),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        provider
                                                                    .viewterminatedList[
                                                                        index]
                                                                    .rollNo ==
                                                                null
                                                            ? '---'
                                                            : provider
                                                                .viewterminatedList[
                                                                    index]
                                                                .rollNo
                                                                .toString(),
                                                        maxLines: 1,
                                                        style: const TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                    kWidth,
                                                    const Text(
                                                      'Division : ',
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 13),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        provider
                                                                .viewterminatedList[
                                                                    index]
                                                                .division ??
                                                            '---',
                                                        maxLines: 1,
                                                        style: const TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 4),
                                                child: Row(
                                                  children: [
                                                    const Text(
                                                      'Adm No : ',
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 13),
                                                    ),
                                                    RichText(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                      strutStyle:
                                                          const StrutStyle(
                                                              fontSize: 8.0),
                                                      text: TextSpan(
                                                        style: const TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.black,
                                                        ),
                                                        text: provider
                                                                .viewterminatedList[
                                                                    index]
                                                                .admnNo ??
                                                            '---',
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 4),
                                                child: GestureDetector(
                                                  onTap: () async {
                                                    phn = provider
                                                                .viewterminatedList[
                                                                    index]
                                                                .mobNo ==
                                                            null
                                                        ? '--'
                                                        : provider
                                                            .viewterminatedList[
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
                                                            TextAlign.start,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 13),
                                                      ),
                                                      RichText(
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 1,
                                                        strutStyle:
                                                            const StrutStyle(
                                                                fontSize: 8.0),
                                                        text: TextSpan(
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 13,
                                                            color: Colors.black,
                                                          ),
                                                          text: provider
                                                                  .viewterminatedList[
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
                                              ),
                                            ],
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
          if (value.loading) pleaseWaitLoader()
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

class StudReportBothScreen extends StatefulWidget {
  const StudReportBothScreen({Key? key}) : super(key: key);

  @override
  State<StudReportBothScreen> createState() => _StudReportBothScreenState();
}

class _StudReportBothScreenState extends State<StudReportBothScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var p = Provider.of<StudReportListProvider_stf>(context, listen: false);
      await p.setLoading(false);
      await p.clearAllFilters();
      await p.removeSectionAll();
      await p.courseClear();
      await p.divisionClear();
      await p.sectionClear();
      await p.removeSectionAll();
      await p.removeDivisionAll();
      await p.removeCourseAll();
      await p.clearViewList();
      await p.stdReportSectionStaff();
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
      builder: (context, value, child) => Stack(
        children: [
          Column(
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
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: LimitedBox(
                                        maxHeight: size.height - 300,
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: studReportinitvalues_stf!
                                                .length,
                                            itemBuilder: (context, index) {
                                              //  value.removeSectionAll();
                                              return ListTile(
                                                selectedTileColor:
                                                    Colors.blue.shade100,
                                                onTap: () async {
                                                  Navigator.of(context).pop();
                                                  await value
                                                      .removeDivisionAll();

                                                  studReportDivisionController1
                                                      .clear();

                                                  value.divisionClear();
                                                  await value.removeCourseAll();
                                                  await value
                                                      .removeDivisionAll();
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
                                                },
                                                title: Text(
                                                  studReportinitvalues_stf![
                                                          index]['text'] ??
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
                                borderSide: BorderSide(
                                    style: BorderStyle.none, width: 0),
                              ),
                              labelText: "  Select Section",
                              hintText: "Section",
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
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
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: LimitedBox(
                                        maxHeight: size.height - 300,
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount:
                                                snapshot.courselist.length,
                                            itemBuilder: (context, index) {
                                              return ListTile(
                                                onTap: () async {
                                                  Navigator.of(context).pop();
                                                  await value
                                                      .removeDivisionAll();
                                                  await value.clearViewList();
                                                  studReportDivisionController1
                                                      .clear();
                                                  print(snapshot
                                                      .courselist.length);
                                                  studReportcourseController
                                                      .text = snapshot
                                                          .courselist[index]
                                                          .value ??
                                                      '---';
                                                  studReportcourseController1
                                                      .text = snapshot
                                                          .courselist[index]
                                                          .text ??
                                                      "";
                                                  snapshot.addSelectedCourse(
                                                      snapshot
                                                          .courselist[index]);
                                                  courseId =
                                                      studReportcourseController
                                                          .text
                                                          .toString();
                                                  print(
                                                      studReportcourseController
                                                          .text);
                                                  sectionId =
                                                      studReportInitialValuesController
                                                          .text
                                                          .toString();
                                                  await value.divisionClear();

                                                  await value.getDivisionList(
                                                      courseId);
                                                },
                                                title: Text(
                                                  snapshot.courselist[index]
                                                          .text ??
                                                      "",
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
                                borderSide: BorderSide(
                                    style: BorderStyle.none, width: 0),
                              ),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
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
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: LimitedBox(
                                        maxHeight: size.height - 300,
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount:
                                                snapshot.divisionlist.length,
                                            itemBuilder: (context, index) {
                                              return Column(
                                                children: [
                                                  ListTile(
                                                    selected: snapshot
                                                        .isDivisionSelected(
                                                            snapshot.divisionlist[
                                                                index]),
                                                    onTap: () async {
                                                      Navigator.of(context)
                                                          .pop();
                                                      print(snapshot
                                                          .divisionlist.length);
                                                      studReportDivisionController
                                                          .text = snapshot
                                                              .divisionlist[
                                                                  index]
                                                              .value ??
                                                          '---';
                                                      studReportDivisionController1
                                                          .text = snapshot
                                                              .divisionlist[
                                                                  index]
                                                              .text ??
                                                          '---';
                                                      snapshot.addSelectedDivision(
                                                          snapshot.divisionlist[
                                                              index]);

                                                      print(
                                                          studReportDivisionController
                                                              .text);
                                                      divisionId =
                                                          studReportDivisionController
                                                              .text
                                                              .toString();
                                                      await value
                                                          .clearViewList();
                                                    },
                                                    title: Text(
                                                      snapshot
                                                              .divisionlist[
                                                                  index]
                                                              .text ??
                                                          '---',
                                                      textAlign:
                                                          TextAlign.center,
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
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              filled: true,
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
                                        2,
                                        "Select Section to continue..",
                                        context);
                                  } else {
                                    courseId = studReportcourseController.text
                                        .toString();
                                    print(courseId);
                                    divisionId = studReportDivisionController
                                        .text
                                        .toString();
                                    print(divisionId);
                                    print(sectionId);
                                    sectionId =
                                        studReportInitialValuesController.text
                                            .toString();

                                    await value.removeSectionAll();

                                    await value.removeCourseAll();

                                    await value.removeDivisionAll();
                                    await value.clearViewList();
                                    await value.viewStudentReportList(
                                        sectionId, courseId, divisionId);
                                    if (value.viewStudReportListt.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
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
                  builder: (context, provider, child) => Scrollbar(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: provider.viewStudReportListt.isEmpty
                          ? 0
                          : provider.viewStudReportListt.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 4, bottom: 4),
                          child: Container(
                            width: size.width - 4,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 0.5,
                                    blurRadius: 3,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                                color: UIGuide.light_Purple,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 1.5,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              StudProfileViewBySearch_Staff(
                                                stud: provider
                                                    .viewStudReportListt[index],
                                              )
                                          // StudProfileView_Staff(
                                          //   indexx: index,
                                          // )
                                          ),
                                    );
                                  },
                                  child: Container(
                                    width: size.width - 6,
                                    //  height: 90,
                                    decoration: const BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Center(
                                            child: Container(
                                              width: 70,
                                              height: 70,
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    255, 236, 233, 233),
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(provider
                                                            .viewStudReportListt[
                                                                index]
                                                            .studentPhoto ??
                                                        'https://gj-eschool-files-public.s3.ap-south-1.amazonaws.com/ess-connect/student/avathar-01.jpeg')),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  const Text(
                                                    'Name : ',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
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
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                        color: UIGuide
                                                            .light_Purple,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(3),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            const BorderRadius
                                                                .only(
                                                          topRight:
                                                              Radius.circular(
                                                                  10),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  10),
                                                        ),
                                                        border: Border.all(
                                                            color: const Color
                                                                .fromARGB(255,
                                                                224, 224, 224)),
                                                        color: const Color
                                                            .fromARGB(255, 255,
                                                            251, 251)),
                                                    child: Text(
                                                      " ${index + 1} ",
                                                      style: const TextStyle(
                                                          fontSize: 12),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 1),
                                                child: Row(
                                                  children: [
                                                    const Text(
                                                      'Roll No : ',
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 13),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        provider
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
                                                        maxLines: 1,
                                                        style: const TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                    kWidth,
                                                    const Text(
                                                      'Division : ',
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 13),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        provider
                                                                .viewStudReportListt[
                                                                    index]
                                                                .division ??
                                                            '---',
                                                        maxLines: 1,
                                                        style: const TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 4),
                                                child: Row(
                                                  children: [
                                                    const Text(
                                                      'Adm No : ',
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 13),
                                                    ),
                                                    RichText(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                      strutStyle:
                                                          const StrutStyle(
                                                              fontSize: 8.0),
                                                      text: TextSpan(
                                                        style: const TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.black,
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
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 4),
                                                child: GestureDetector(
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
                                                            TextAlign.start,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 13),
                                                      ),
                                                      RichText(
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 1,
                                                        strutStyle:
                                                            const StrutStyle(
                                                                fontSize: 8.0),
                                                        text: TextSpan(
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 13,
                                                            color: Colors.black,
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
                                              ),
                                            ],
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
          if (value.loading) pleaseWaitLoader()
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
