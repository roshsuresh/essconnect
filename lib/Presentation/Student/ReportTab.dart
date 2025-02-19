import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Application/Module Providers.dart/Module.dart';
import '../../Application/StudentProviders/InternetConnection.dart';
import '../../Application/StudentProviders/ReportCardProvider.dart';
import '../../utils/constants.dart';
import 'HpcReportCard.dart';
import 'NoInternetScreen.dart';
import 'Reportcard.dart';

class ReportTab extends StatelessWidget {
  const ReportTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ConnectivityProvider>(context, listen: false);
    });

    return Consumer<ModuleProviders>(
      builder: (context, pro, child) {
        // Build the tabs list based on the condition
        List<Widget> tabs = [
          const Tab(text: "Academics"),
        ];

        if (pro.hpc) {
          tabs.add(const Tab(text: 'HPC'));
        }

        // Build the TabBarView children based on the condition
        List<Widget> tabViews = [
          const ReportCard(),
        ];

        if (pro.hpc) {
          tabViews.add(const HpcReportCard());
        }

        return Consumer<ConnectivityProvider>(
          builder: (context, connection, child) => connection.isOnline == false
              ? const NoInternetConnection()
              : DefaultTabController(
            length: tabs.length,
            child: Scaffold(
              appBar: AppBar(
                title: const Text('Report Card'),
                titleSpacing: 0.0,
                centerTitle: true,
                toolbarHeight: 50.2,
                toolbarOpacity: 0.8,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25),
                  ),
                ),
                backgroundColor: UIGuide.light_Purple,
                bottom: tabs.length > 1
                    ? TabBar(
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorColor: UIGuide.light_Purple,
                  indicatorWeight: 2.0, // Adjusted for better visibility
                  tabs: tabs,
                )
                    : null, // No TabBar when there's only one tab
              ),
              body: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: tabViews,
              ),
            ),
          ),
        );
      },
    );
  }
}




class NotAvailable extends StatelessWidget {
  const NotAvailable({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "This facility is not available",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: UIGuide.light_Purple),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
