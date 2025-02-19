import 'package:essconnect/Presentation/Staff/Portion/PortionApproval.dart';
import 'package:essconnect/Presentation/Staff/Portion/PortionList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../../utils/constants.dart';
import 'PortionEntry.dart';
class PortionScreen extends StatelessWidget {
  PortionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  const Spacer(),
                  const Text('Portions'),
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PortionScreen()));
                      },
                      icon: const Icon(Icons.refresh))
                ],
              ),
              titleSpacing: 20.0,
              centerTitle: true,
              toolbarHeight: 50.2,
              toolbarOpacity: 0.8,
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
                  Tab(text: "Entry"),
                  Tab(
                    text: "List",
                  ),
                  Tab(
                    text:
                    "Report",
                  ),
                ],
              ),
              backgroundColor: UIGuide.light_Purple,
            ),
            body: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
              PortionEntryScreen(),
               PortionList(),
              PortionApproval()
            ])));
  }
}