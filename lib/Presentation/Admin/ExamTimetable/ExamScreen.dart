import 'package:essconnect/Presentation/Admin/ExamTimetable/ExamList.dart';
import 'package:essconnect/Presentation/Admin/ExamTimetable/ExamUpload.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:flutter/material.dart';

class ExamTimetable extends StatelessWidget {
  const ExamTimetable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                            builder: (context) => const ExamTimetable()));
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
        body: const TabBarView(
          children: [ExamTTUpload(), ExamTTHistory()],
        ),
      ),
    );
  }
}
