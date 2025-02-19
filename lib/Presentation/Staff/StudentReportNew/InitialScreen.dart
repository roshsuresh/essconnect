import 'package:essconnect/Application/Staff_Providers/StudentReportProvidersStaff.dart';
import 'package:essconnect/Presentation/Staff/StudentReportNew/BothStudReportScreen.dart';
import 'package:essconnect/Presentation/Staff/StudentReportNew/SearchStudentStaff.dart';
import 'package:essconnect/Presentation/Staff/StudentReportNew/StudReportScreen.dart';
import 'package:essconnect/Presentation/Staff/StudentReportNew/TerminatedStudReport.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StudReportStaff extends StatefulWidget {
  const StudReportStaff({Key? key}) : super(key: key);

  @override
  State<StudReportStaff> createState() => _StudReportStaffState();
}

class _StudReportStaffState extends State<StudReportStaff> {
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
                              builder: (context) => const StudReportStaff()));
                    },
                    icon: const Icon(Icons.refresh)),
                Consumer<StudentReportProviderStaff>(
                  builder: (context, value, child) => value.sectionList.isEmpty
                      ? const SizedBox(
                          height: 0,
                          width: 0,
                        )
                      : IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SearchStudentByStaff()),
                            );
                          },
                          icon: const Icon(Icons.search)),
                )
              ],
            ),
            body: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  StudReportStaffScreen(),
                  StudReportTerminatedStaffScreen(),
                  StudReportBothStaffScreen(),
                ])));
  }
}
