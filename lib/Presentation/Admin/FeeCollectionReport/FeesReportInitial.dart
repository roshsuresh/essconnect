
import 'package:essconnect/Presentation/Admin/FeeCollectionReport/OfflineFeesCollection.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:flutter/material.dart';

import 'FeeReport.dart';



class FeeReportInitial extends StatelessWidget {
  const FeeReportInitial({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              const Spacer(),
              const Text('Fees Collection Report'),
              const Spacer(),
              IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                            const FeeReportInitial()));
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
                text: "Online",
              ),
              Tab(text: "Offline"),

            ],
          ),
          backgroundColor: UIGuide.light_Purple,
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            FeeReport(),
            OfflineFeeCollection(),

          ],
        ),
      ),
    );
  }
}
