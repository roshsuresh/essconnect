import 'package:essconnect/Application/AdminProviders/BirthdayListProviders.dart';
import 'package:essconnect/Presentation/Admin/Birthday/StaffBirthdayScreen.dart';
import 'package:essconnect/Presentation/Admin/Birthday/StudentBirthdayScreen.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BirthdayInitialScreen extends StatefulWidget {
  const BirthdayInitialScreen({Key? key}) : super(key: key);

  @override
  State<BirthdayInitialScreen> createState() => _BirthdayInitialScreenState();
}

class _BirthdayInitialScreenState extends State<BirthdayInitialScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var p = Provider.of<BirthdayListProviders>(context, listen: false);
      await p.setLoading(true);
      await p.clearList();
      await p.getBirthdayList();
      p.indval = 0;
      p.toggleVal = 'all';
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              const Spacer(),
              const Text('Birthday'),
              const Spacer(),
              IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const BirthdayInitialScreen()));
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
