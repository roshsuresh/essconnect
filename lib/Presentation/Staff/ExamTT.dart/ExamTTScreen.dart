import 'package:essconnect/Application/Staff_Providers/ExamTTProviderStaff.dart';
import 'package:essconnect/Constants.dart';
import 'package:essconnect/Presentation/Staff/ExamTT.dart/ExamTTList.dart';
import 'package:essconnect/Presentation/Staff/ExamTT.dart/ExamTTUpload.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExamTimetableStaff extends StatelessWidget {
  const ExamTimetableStaff({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var p = Provider.of<ExamTTAdmProvidersStaff>(context, listen: false);
      // p.courseList.clear();
      // await p.getCourseList();
      // print(p.isClassTeacher);

    });
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              const Spacer(),
              const Text('Exam Timetable'),
              const Spacer(),
              IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ExamTimetableStaff()));
                  },
                  icon: const Icon(Icons.refresh))
            ],
          ),
          titleSpacing: 00.0,
          centerTitle: true,
          toolbarHeight: 45.2,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(25),
                bottomLeft: Radius.circular(25)),
          ),
          bottom: const TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Colors.white,
            indicatorWeight: 5,
            tabs: [
              Tab(
                text: "Entry",
              ),
              Tab(text: "List"),
            ],
          ),
          backgroundColor: UIGuide.light_Purple,
        ),
        body: TabBarView(
          children: [
            const ExamTTUploadStaff(),
            // Consumer<ExamTTAdmProvidersStaff>(
            //   builder: (context, value, child) {
            //     if (value.isClassTeacher != false) {
            //       return ExamTTHistoryStaff();
            //     } else {
            //       return Container(
            //         child: Center(
            //           child: Column(
            //             crossAxisAlignment: CrossAxisAlignment.center,
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: const [
            //               Icon(
            //                 Icons.sentiment_dissatisfied_outlined,
            //                 size: 60,
            //                 color: Colors.grey,
            //               ),
            //               kheight10,
            //               Text(
            //                 "Sorry you don't have access",
            //                 style: TextStyle(
            //                     fontSize: 20,
            //                     fontWeight: FontWeight.w600,
            //                     color: Colors.grey),
            //               ),
            //             ],
            //           ),
            //         ),
            //       );
            //     }
            //   },
            // ),
            const ExamTTHistoryStaff()
          ],
        ),
      ),
    );
  }
}
