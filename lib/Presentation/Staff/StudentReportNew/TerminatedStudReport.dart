import 'package:essconnect/Application/Staff_Providers/StudentReportProvidersStaff.dart';
import 'package:essconnect/Constants.dart';
import 'package:essconnect/Presentation/Staff/Searchstudent.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:essconnect/utils/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class StudReportTerminatedStaffScreen extends StatefulWidget {
  StudReportTerminatedStaffScreen({Key? key}) : super(key: key);

  @override
  State<StudReportTerminatedStaffScreen> createState() =>
      _StudReportTerminatedStaffScreenState();
}

class _StudReportTerminatedStaffScreenState
    extends State<StudReportTerminatedStaffScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var p = Provider.of<StudentReportProviderStaff>(context, listen: false);
      p.setLoading(false);
      await p.initialClear();
      await p.getInitialList();

      // List<String?> sectionL = p.sectionList.map((item) => item.value).toList();
      // sectionId = sectionL.join(",");
      // List courseL = p.initialCourseList.map((item) => item.value).toList();
      // courseId = courseL.join(",");
      // List divisionL = p.initialDivisionList.map((item) => item.value).toList();
      // divisionId = divisionL.join(",");
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
    return Consumer<StudentReportProviderStaff>(
      builder: (context, value, child) =>
      value.sectionList.isEmpty?
      Center(
        child:Text("No Access ",style: TextStyle(
            fontSize: 16,fontWeight: FontWeight.w500
        ),) ,
      ):
          Stack(
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
                      child: Consumer<StudentReportProviderStaff>(
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
                                                snapshot.sectionList.length,
                                            itemBuilder: (context, index) {
                                              return ListTile(
                                                selectedTileColor:
                                                    Colors.blue.shade100,
                                                onTap: () async {
                                                  Navigator.of(context).pop();
                                                  studReportDivisionController1
                                                      .clear();
                                                  studReportcourseController1
                                                      .clear();
                                                  studReportInitialValuesController
                                                      .text = value
                                                          .sectionList[index]
                                                          .value ??
                                                      '--';
                                                  studReportInitialValuesController1
                                                      .text = value
                                                          .sectionList[index]
                                                          .text ??
                                                      '--';
                                                  sectionId =
                                                      studReportInitialValuesController
                                                          .text
                                                          .toString();
                                                  await value
                                                      .getCourseList(sectionId);
                                                  await value
                                                      .getDivisionBySectionList(
                                                          sectionId);

                                                  List courseL = value
                                                      .initialCourseList
                                                      .map((item) => item.value)
                                                      .toList();
                                                  courseId = courseL.join(",");
                                                  List divisionL = value
                                                      .initialDivisionList
                                                      .map((item) => item.value)
                                                      .toList();
                                                  divisionId =
                                                      divisionL.join(",");
                                                },
                                                title: Text(
                                                  snapshot.sectionList[index]
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
                      child: Consumer<StudentReportProviderStaff>(
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
                                                .initialCourseList.length,
                                            itemBuilder: (context, index) {
                                              return ListTile(
                                                onTap: () async {
                                                  Navigator.of(context).pop();
                                                  studReportDivisionController1
                                                      .clear();

                                                  studReportcourseController
                                                      .text = snapshot
                                                          .initialCourseList[
                                                              index]
                                                          .value ??
                                                      '---';

                                                  studReportcourseController1
                                                      .text = snapshot
                                                          .initialCourseList[
                                                              index]
                                                          .text ??
                                                      '---';

                                                  courseId =
                                                      studReportcourseController
                                                          .text
                                                          .toString();

                                                  await value.getDivisionList(
                                                      courseId);

                                                  List divisionL = value
                                                      .initialDivisionList
                                                      .map((item) => item.value)
                                                      .toList();
                                                  divisionId =
                                                      divisionL.join(",");
                                                },
                                                title: Text(
                                                  snapshot
                                                          .initialCourseList[
                                                              index]
                                                          .text ??
                                                      "--",
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
                      child: Consumer<StudentReportProviderStaff>(
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
                                                .initialDivisionList.length,
                                            itemBuilder: (context, index) {
                                              return Column(
                                                children: [
                                                  ListTile(
                                                    onTap: () async {
                                                      Navigator.of(context)
                                                          .pop();

                                                      studReportDivisionController
                                                          .text = snapshot
                                                              .initialDivisionList[
                                                                  index]
                                                              .value ??
                                                          '---';

                                                      studReportDivisionController1
                                                          .text = snapshot
                                                              .initialDivisionList[
                                                                  index]
                                                              .text ??
                                                          '---';

                                                      divisionId =
                                                          studReportDivisionController
                                                              .text
                                                              .toString();
                                                    },
                                                    title: Text(
                                                      snapshot
                                                              .initialDivisionList[
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
                  Expanded(
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
                          if (studReportInitialValuesController.text.isEmpty) {
                            snackbarWidget(
                                2, "Select Section to continue..", context);
                          } else {
                            await value.viewStudentReportList(
                                sectionId.toString(), courseId, divisionId);

                            if (value.viewterminatedList.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  elevation: 10,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
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
                  kWidth
                ],
              ),
              kheight10,
              Expanded(
                child: Consumer<StudentReportProviderStaff>(
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
                            // height: 93,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 0.5,
                                    blurRadius: 3,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                                color: UIGuide.light_Purple,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
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
                                              )),
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
                                                color: Color.fromARGB(
                                                    255, 224, 224, 224),
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
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
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
