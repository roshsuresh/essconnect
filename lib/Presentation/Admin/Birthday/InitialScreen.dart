import 'package:essconnect/Presentation/Admin/Birthday/StaffBirthdayScreen.dart';
import 'package:essconnect/Presentation/Admin/Birthday/StudentBirthdayScreen.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:flutter/material.dart';

class BirthdayInitialScreen extends StatelessWidget {
  const BirthdayInitialScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Birthday'),
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
                text: "Student",
              ),
              Tab(text: "Staff"),
            ],
          ),
          backgroundColor: UIGuide.light_Purple,
        ),
        body: TabBarView(
          children: [StudentBirthdayScreenAdmin(), StaffBirthdayScreenAdmin()],
        ),
      ),
    );
  }
}
