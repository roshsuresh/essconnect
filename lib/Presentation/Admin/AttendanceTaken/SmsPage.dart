import 'package:essconnect/Application/AdminProviders/Attendanceprovider.dart';
import 'package:essconnect/Constants.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:essconnect/utils/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SMSFormats extends StatefulWidget {
  final List<String> toList;
  String time;
  SMSFormats({Key? key, required this.toList, required this.time})
      : super(key: key);

  @override
  State<SMSFormats> createState() => _SMSFormatsState();
}

class _SMSFormatsState extends State<SMSFormats> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var p = Provider.of<AttendanceReportProvider>(context, listen: false);
      p.clearSMSList();
      p.viewSMSFormat();
      p.smsBody = '';
      smsController.clear();
      formatController.clear();
      formatController1.clear();
    });
  }

  final smsController = TextEditingController();
  final formatController = TextEditingController();
  final formatController1 = TextEditingController();
  bool provcheck = false;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Send SMS',
            style: TextStyle(fontSize: 20),
          ),
          titleSpacing: 00.0,
          centerTitle: true,
          toolbarHeight: 60.2,
          toolbarOpacity: 0.8,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(25),
                bottomLeft: Radius.circular(25)),
          ),
          backgroundColor: UIGuide.light_Purple,
        ),
        body: Consumer<AttendanceReportProvider>(
          builder: (context, val, _) => Stack(
            children: [
              ListView(
                children: [
                  kheight10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.60,
                        child: Consumer<AttendanceReportProvider>(
                            builder: (context, snapshot, child) {
                          return InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Dialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: LimitedBox(
                                          maxHeight: size.height - 300,
                                          child: ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: snapshot
                                                      .formatlist.isEmpty
                                                  ? 0
                                                  : snapshot.formatlist.length,
                                              itemBuilder: (context, index) {
                                                return ListTile(
                                                  onTap: () async {
                                                    provcheck = snapshot
                                                        .formatlist[index]
                                                        .isApproved!;
                                                    formatController1.clear();
                                                    formatController
                                                        .text = snapshot
                                                            .formatlist[index]
                                                            .value ??
                                                        '--';
                                                    formatController1
                                                        .text = snapshot
                                                            .formatlist[index]
                                                            .text ??
                                                        '--';
                                                    await snapshot
                                                        .getSMSContent(
                                                            formatController
                                                                .text);

                                                    Navigator.of(context).pop();
                                                  },
                                                  title: Text(
                                                    snapshot.formatlist[index]
                                                            .text ??
                                                        '--',
                                                    textAlign: TextAlign.center,
                                                  ),
                                                );
                                              }),
                                        ));
                                  });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: UIGuide.light_Purple,
                                          width: 1),
                                    ),
                                    height: 40,
                                    child: TextField(
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: UIGuide.BLACK,
                                          overflow: TextOverflow.clip),
                                      textAlign: TextAlign.center,
                                      controller: formatController1,
                                      decoration: const InputDecoration(
                                        contentPadding:
                                            EdgeInsets.only(left: 0, top: 0),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.never,
                                        filled: true,
                                        fillColor:
                                            Color.fromARGB(255, 238, 237, 237),
                                        border: OutlineInputBorder(),
                                        labelText: "  Select Format",
                                        hintText: "Format",
                                      ),
                                      enabled: false,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 0,
                                    child: TextField(
                                      textAlign: TextAlign.center,
                                      controller: formatController,
                                      decoration: const InputDecoration(
                                        filled: true,
                                        fillColor:
                                            Color.fromARGB(255, 238, 237, 237),
                                        border: OutlineInputBorder(),
                                        labelText: "",
                                        hintText: "",
                                      ),
                                      enabled: false,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                  kheight10,
                  Consumer<AttendanceReportProvider>(
                    builder: (context, value, child) => value.smsBody == ''
                        ? const SizedBox(
                            height: 0,
                            width: 0,
                          )
                        : Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Container(
                                width: size.width,
                                height: 100,
                                decoration: BoxDecoration(
                                    border: Border.all(color: UIGuide.BLACK),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Text(
                                    value.smsBody ?? '',
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )),
                          ),
                  ),
                  kheight20,
                  Center(
                    child: Consumer<AttendanceReportProvider>(
                        builder: (context, value, child) {
                      return SizedBox(
                        width: 140,
                        height: 40,
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: value.selectedsmsList.isEmpty
                                ? 0
                                : value.selectedsmsList.length,
                            itemBuilder: (context, index) {
                              return MaterialButton(
                                onPressed: () async {
                                  if (formatController1.text.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        elevation: 10,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        duration: Duration(seconds: 1),
                                        margin: EdgeInsets.only(
                                            bottom: 80, left: 30, right: 30),
                                        behavior: SnackBarBehavior.floating,
                                        content: Text(
                                          'Please select any format.....!',
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    );
                                  } else {
                                    if (provcheck == true) {
                                      value.sendSmsAttendance(
                                          context,
                                          widget.time,
                                          formatController.text.toString());
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          elevation: 10,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                          ),
                                          duration: Duration(seconds: 1),
                                          margin: EdgeInsets.only(
                                              bottom: 80, left: 30, right: 30),
                                          behavior: SnackBarBehavior.floating,
                                          content: Text(
                                            'Sms format not approved...!',
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      );
                                    }
                                  }
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(0),
                                      bottomLeft: Radius.circular(0),
                                      bottomRight: Radius.circular(20)),
                                  side: BorderSide(
                                      color: Theme.of(context).primaryColor),
                                ),
                                color: UIGuide.light_Purple,
                                child: const Text(
                                  'Send',
                                  style: TextStyle(color: Colors.white),
                                ),
                              );
                            }),
                      );
                    }),
                  )
                ],
              ),
              if (val.loading) pleaseWaitLoader()
            ],
          ),
        ));
  }
}
