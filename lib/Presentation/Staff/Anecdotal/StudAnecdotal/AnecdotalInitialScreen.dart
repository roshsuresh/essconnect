import 'package:essconnect/Presentation/Staff/Anecdotal/StudAnecdotal/AnecdotalEntryScreen.dart';
import 'package:essconnect/Presentation/Staff/Anecdotal/StudAnecdotal/AnecdotalListscreen.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:flutter/material.dart';

import 'AnecdotalReport.dart';

class AnecdotalInitialScreen extends StatelessWidget {
  const AnecdotalInitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              const Spacer(),
              const Text('Anecdotal'),
              const Spacer(),
              IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const AnecdotalInitialScreen()));
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
              Tab(
                text: "Report",
              ),
            ],
          ),
          backgroundColor: UIGuide.light_Purple,
        ),
        body: const TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            AnecdotalentryScreen(),
            AnectdotalListScreen(),
            AnecdotalReport(),
          ],
        ),
      ),
    );
  }
}
