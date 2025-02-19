import 'package:essconnect/Application/Staff_Providers/ExamTTProviderStaff.dart';
import 'package:essconnect/Constants.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:essconnect/utils/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../Application/AdminProviders/ExamTTPtoviders.dart';
import '../../Admin/ExamTimetable/ExamEdit.dart';
import '../../Admin/ExamTimetable/ExamList.dart';
import 'ExamEditStaff.dart';

class ExamTTHistoryStaff extends StatefulWidget {
  const ExamTTHistoryStaff({Key? key}) : super(key: key);

  @override
  State<ExamTTHistoryStaff> createState() => _ExamTTHistoryStaffState();
}

class _ExamTTHistoryStaffState extends State<ExamTTHistoryStaff> {
  var parsedResponse;
  var parsedStaff;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var p = Provider.of<ExamTTAdmProvidersStaff>(context, listen: false);
      // p.courseList.clear();
      await p.clearTTexamList();
      await p.getExamTimeTableList();
      parsedResponse = await parseJWT();
      parsedStaff = await parsedResponse['StaffId'];
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Consumer<ExamTTAdmProvidersStaff>(
      builder: (context, provider, child) {
        return provider.loading
            ? spinkitLoader()
            : provider.examlist.isEmpty
                ? Center(
                    child: Container(
                      child: LottieBuilder.network(
                          'https://assets2.lottiefiles.com/private_files/lf30_lkquf6qz.json'),
                    ),
                  )
                : ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: provider.examlist.isEmpty
                        ? 0
                        : provider.examlist.length,
                    itemBuilder: (context, index) {
                      //created date
                      String finalCreatedDate = "";

                      if (provider.examlist[index].createdAt != null) {
                        String createddate =
                            provider.examlist[index].createdAt ?? '--';
                        DateTime parsedDateTime = DateTime.parse(createddate);
                        finalCreatedDate =
                            DateFormat('dd-MMM-yyyy').format(parsedDateTime);
                      }

                      //start date
                      String finalStartDate = '';

                      if (provider.examlist[index].examStartDate != null) {
                        String startdate =
                            provider.examlist[index].examStartDate ?? '--';
                        DateTime parsedDateTime = DateTime.parse(startdate);

                        finalStartDate =
                            DateFormat('dd-MMM-yyyy').format(parsedDateTime);
                      }
                      String staffid =
                          provider.examlist[index].createdStaffId ?? '--';
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            width: size.width,
                            // height: 140,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: UIGuide.light_Purple, width: 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Row(
                                    children: [
                                      const Text('Created Date: '),
                                      Text(
                                        finalCreatedDate.isEmpty
                                            ? '--'
                                            : finalCreatedDate,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: UIGuide.light_Purple,
                                            fontSize: 13),
                                      ),
                                      const Spacer(),
                                      kWidth,
                                      //Edit
                                      GestureDetector(
                                        onTap: () async {
                                          String staffid = provider
                                              .examlist[index].createdStaffId ??
                                              '--';

                                          var parsedResponse = await parseJWT();
                                          if (parsedResponse['StaffId'] ==
                                              staffid && provider.courseList.isNotEmpty) {
                                            String event = provider
                                                .examlist[index].id
                                                .toString();
                                            await Navigator.push(context, MaterialPageRoute(builder: (context)=>  ExamTTEditStaff(eventId: event,)));
                                            // await provider.clearTTexamList();
                                            // await provider.getExamTimeTableList();
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
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
                                                  'Sorry, you have no access to edit ',
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                        child: const Padding(
                                          padding: EdgeInsets.only(
                                              left: 8,
                                              right: 8,
                                              top: 3,
                                              bottom: 2),
                                          child: Icon(
                                            Icons.edit,
                                            color: UIGuide.button1,
                                            size: 22,
                                          ),
                                        ),
                                      ),
                                      kWidth,
                                      //view Eye
                                      Consumer<ExamTTAdmProviders>(
                                builder: (context, val, child) => GestureDetector(
                                          onTap: () async {
                                            String att =
                                                provider.examlist[index].id ?? '--';
                                            await val.viewAttachmentAdmin(att);
                                            if (val.extensionExam ==
                                                '.pdf') {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                    const ExamPdfViewAdmin()),
                                              );
                                            } else {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                    const ImageViewExamAdmin()),
                                              );
                                            }
                                          },
                                          child: Padding(
                                            padding:
                                            const EdgeInsets.only(top: 8,bottom: 8,),
                                            child: SizedBox(
                                              height: 25,
                                              width: 25,
                                              child: LottieBuilder.network(
                                                  "https://assets2.lottiefiles.com/temp/lf20_D0nz3r.json") ?? const Icon(Icons
                                                  .remove_red_eye_outlined),
                                            ),
                                          ),
                                        ),
                                      ),
                                      kWidth,
                                      //Delete
                                      InkWell(
                                        onTap: () async {
                                          showDialog(
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
                                                        onPressed: () async {
                                                          String staffid = provider
                                                              .examlist[index]
                                                              .createdStaffId ??
                                                              '--';

                                                          //   var parsedResponse = await parseJWT();
                                                          if (parsedStaff == staffid && provider.courseList.isNotEmpty) {
                                                            String event = provider
                                                                .examlist[index].id
                                                                .toString();
                                                            await provider.examTTDelete(
                                                                event, context, index);
                                                            // await provider.clearTTexamList();
                                                            // await provider
                                                            //     .getExamTimeTableList();
                                                          } else {
                                                            ScaffoldMessenger.of(context)
                                                                .showSnackBar(
                                                              const SnackBar(
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
                                                                  'Sorry, you have no access to delete ',
                                                                  textAlign: TextAlign.center,
                                                                ),
                                                              ),
                                                            );
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
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: UIGuide.THEME_LIGHT),
                                              color: const Color.fromARGB(
                                                  255, 236, 239, 253),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topRight:
                                                          Radius.circular(10),
                                                      bottomLeft:
                                                          Radius.circular(10))),
                                          child: const Padding(
                                            padding: EdgeInsets.only(
                                                left: 8,
                                                right: 8,
                                                top: 3,
                                                bottom: 2),
                                            child: Icon(
                                              Icons.delete_forever_outlined,
                                              color: Colors.red,
                                              size: 22,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Row(
                                    children: [
                                      const Text('Exam Description: '),
                                      Flexible(
                                        child: Text(
                                          provider.examlist[index]
                                                  .description ??
                                              '--',
                                          overflow: TextOverflow.clip,
                                          maxLines: 1,
                                          style: const TextStyle(
                                              color: UIGuide.light_Purple,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 13),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 5, top: 5),
                                  child: Row(
                                    children: [
                                      const Text('Start Date: '),
                                      Flexible(
                                        child: Text(
                                          finalStartDate.isEmpty
                                              ? '--'
                                              : finalStartDate,
                                          overflow: TextOverflow.clip,
                                          style: const TextStyle(
                                              color: UIGuide.light_Purple,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 13),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 5, top: 5),
                                  child: Row(
                                    children: [
                                      const Text('Course: '),
                                      Flexible(
                                        child: Text(
                                          provider.examlist[index].course ??
                                              '--',
                                          overflow: TextOverflow.clip,
                                          style: const TextStyle(
                                              color: UIGuide.light_Purple,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 13),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 5, top: 5),
                                  child: Row(
                                    children: [
                                      const Text('Division: '),
                                      Flexible(
                                        child: Text(
                                          provider.examlist[index].division ??
                                              '--',
                                          overflow: TextOverflow.clip,
                                          style: const TextStyle(
                                              color: UIGuide.light_Purple,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 13),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 5, top: 5, bottom: 5),
                                  child: Row(
                                    children: [
                                      const Text('Created by: '),
                                      Flexible(
                                        child: Text(
                                          provider.examlist[index]
                                                  .createStaffName ??
                                              '--',
                                          overflow: TextOverflow.clip,
                                          style: const TextStyle(
                                              color: UIGuide.light_Purple,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 13),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                    });
      },
    );
  }
}
