import 'package:essconnect/Presentation/Student/Offline/BusFeeDetailsScreen.dart';
import 'package:essconnect/Presentation/Student/Offline/BusFeePaidScreen.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:flutter/material.dart';

class BusFeeInitialScreen extends StatelessWidget {
  const BusFeeInitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Bus Fees'),
          backgroundColor: UIGuide.light_Purple,
          titleSpacing: 00.0,
          centerTitle: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(25),
                bottomLeft: Radius.circular(25)),
          ),
          toolbarHeight: 45,
          toolbarOpacity: 0.8,
          bottom: const TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Colors.white,
            indicatorWeight: 5,
            tabs: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Tab(
                  text: "Bus Fees Details",
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Tab(
                  text: "Bus Fees Paid",
                ),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            BusFeeDetails(),
            BusFeePaidScreen(),
          ],
        ),
      ),
    );
  }
}
