import 'package:essconnect/utils/constants.dart';
import 'package:flutter/material.dart';

import 'FlashNewsHistory.dart';
import 'FlashnewsUpload.dart';

class ScreenFlashNews extends StatelessWidget {
  const ScreenFlashNews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'FlashNews',
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
                text: "Upload",
              ),
              Tab(text: "History"),
            ],
          ),
          backgroundColor: UIGuide.light_Purple,
        ),
        body: const TabBarView(
          children: [FlashNewsUpload(), FlashNewsHistory()],
        ),
      ),
    );
  }
}
