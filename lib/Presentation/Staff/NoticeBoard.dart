import 'package:essconnect/Application/Staff_Providers/NoticeboardSend.dart';
import 'package:essconnect/Presentation/Staff/NoticeBoardList.dart';
import 'package:essconnect/Presentation/Staff/ReceivedNoticeBoard.dart';
import 'package:essconnect/utils/spinkit.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../Constants.dart';
import '../../utils/constants.dart';

class StaffNoticeBoard extends StatelessWidget {
  const StaffNoticeBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  const Spacer(),
                  const Text('NoticeBoard'),
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const StaffNoticeBoard()));
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
                  Tab(text: "Received"),
                  Tab(
                    text: "Send",
                  ),
                  Tab(
                    text: "List",
                  ),
                ],
              ),
              backgroundColor: UIGuide.light_Purple,
            ),
            body: TabBarView(children: [
              StaffNoticeBoardReceived(),
              Consumer<StaffNoticeboardSendProviders>(
                builder: (context, value, child) {
                  if (value.isClassTeacher != false) {
                    return const StaffNoticeBoard_sent();
                  } else {
                    return const Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.sentiment_dissatisfied_outlined,
                            size: 60,
                            color: Colors.grey,
                          ),
                          kheight10,
                          Text(
                            "Sorry you don't have access",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
              const NoticeBoardListstaff()
            ])));
  }
}

class StaffNoticeBoard_sent extends StatefulWidget {
  const StaffNoticeBoard_sent({Key? key}) : super(key: key);

  @override
  State<StaffNoticeBoard_sent> createState() => _StaffNoticeBoard_sentState();
}

class _StaffNoticeBoard_sentState extends State<StaffNoticeBoard_sent> {
  String? datee;

  final coursevalueController = TextEditingController();

  final coursevalueController1 = TextEditingController();

  final categoryvalueController = TextEditingController();

  final categoryvalueController1 = TextEditingController();

  final divisionvalueController = TextEditingController();

  final divisionvalueController1 = TextEditingController();

  final titleController = TextEditingController();

  final mattercontroller = TextEditingController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var p =
          Provider.of<StaffNoticeboardSendProviders>(context, listen: false);
      await p.getVariables();
      await p.sendNoticeboard();
      datee = DateFormat('dd/MMM/yyyy').format(DateTime.now());
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Consumer<StaffNoticeboardSendProviders>(
      builder: (context, val, _) => ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          kheight10,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              kWidth,
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 3,
                      foregroundColor: UIGuide.light_Purple,
                      backgroundColor: UIGuide.ButtonBlue,
                      padding: const EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(
                          color: UIGuide.light_black,
                        ),
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      '🗓️  ${datee.toString()}',
                      style:
                          const TextStyle(color: UIGuide.BLACK, fontSize: 14),
                    ),
                  ),
                ),
              ),
              kWidth,
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: Consumer<StaffNoticeboardSendProviders>(
                      builder: (context, snapshot, child) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 3,
                        foregroundColor: UIGuide.light_Purple,
                        backgroundColor: UIGuide.ButtonBlue,
                        padding: const EdgeInsets.all(0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(
                            color: UIGuide.light_black,
                          ),
                        ),
                      ),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: LimitedBox(
                                    maxHeight: size.height - 300,
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: noticeCategoryStf!.length,
                                        itemBuilder: (context, index) {
                                          return ListTile(
                                            selectedTileColor:
                                                Colors.blue.shade100,
                                            onTap: () async {
                                              print(
                                                  {noticeCategoryStf![index]});

                                              categoryvalueController.text =
                                                  await noticeCategoryStf![
                                                          index]['value'] ??
                                                      '--';

                                              categoryvalueController1.text =
                                                  await noticeCategoryStf![
                                                          index]['text'] ??
                                                      '--';

                                              Navigator.of(context).pop();
                                            },
                                            title: Text(
                                              noticeCategoryStf![index]
                                                      ['text'] ??
                                                  '--',
                                              textAlign: TextAlign.center,
                                            ),
                                          );
                                        }),
                                  ));
                            });
                      },
                      child: TextField(
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: UIGuide.BLACK,
                            overflow: TextOverflow.clip),
                        textAlign: TextAlign.center,
                        controller: categoryvalueController1,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(left: 0, top: 0),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          filled: true,
                          fillColor: Colors.transparent,
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(style: BorderStyle.none, width: 0),
                          ),
                          labelText: "  Select Category",
                        ),
                        enabled: false,
                      ),
                    );
                  }),
                ),
              ),
              kWidth
            ],
          ),
          kheight10,
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              inputFormatters: [LengthLimitingTextInputFormatter(40)],
              controller: titleController,
              minLines: 1,
              maxLines: 1,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                labelText: 'Title*',
                labelStyle: const TextStyle(color: UIGuide.light_Purple),
                hintText: 'Enter Title',
                hintStyle: const TextStyle(color: Colors.grey),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: UIGuide.light_Purple, width: 1.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0, left: 10, right: 10),
            child: TextFormField(
              controller: mattercontroller,
              minLines: 1,
              inputFormatters: [LengthLimitingTextInputFormatter(400)],
              maxLines: 5,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                labelText: 'Matter*',
                labelStyle: const TextStyle(color: UIGuide.light_Purple),
                hintText: 'Enter Matter',
                hintStyle: const TextStyle(color: Colors.grey),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: UIGuide.light_Purple, width: 1.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          Center(
            child: SizedBox(
              width: size.width / 2,
              child: Consumer<StaffNoticeboardSendProviders>(
                builder: (context, value, child) => value.loadingg
                    ? spinkitLoader()
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 3,
                          foregroundColor: UIGuide.light_Purple,
                          backgroundColor: UIGuide.ButtonBlue,
                          padding: const EdgeInsets.all(0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(
                                color: UIGuide.light_black,
                              )),
                        ),
                        onPressed: (() async {
                          final result = await FilePicker.platform.pickFiles(
                              type: FileType.custom,
                              allowedExtensions: ['pdf', 'png', 'jpeg', 'jpg','zip','rar']);
                          if (result == null) {
                            return;
                          }
                          final file = result.files.first;
                          print('Name: ${file.name}');
                          print('Path: ${file.path}');
                          print('Extension: ${file.extension}');

                          int sizee = file.size;

                          if (sizee <= 5242880) {
                            await val.noticeImageSave(
                                context, file.path.toString());
                          } else {
                            print('Size Exceed');
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              duration: Duration(seconds: 1),
                              margin: EdgeInsets.only(
                                  bottom: 80, left: 30, right: 30),
                              behavior: SnackBarBehavior.floating,
                              content: Text(
                                "Size Exceeded(Less than 5Mb allowed)",
                                textAlign: TextAlign.center,
                              ),
                            ));
                          }
                        }),
                        child: Text(val.imageid == "" || val.imageid == null
                            ? '📁   Choose File'
                            : "File Added"),
                      ),
              ),
            ),
          ),
          const Center(
              child: Text(
            'Maximum allowed file size is 5Mb',
            style: TextStyle(
                fontSize: 9, color: Color.fromARGB(255, 241, 104, 94)),
          )),
          kheight10,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              kWidth,
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 3,
                    foregroundColor: UIGuide.light_Purple,
                    backgroundColor: UIGuide.ButtonBlue,
                    padding: const EdgeInsets.all(0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(
                          color: UIGuide.light_black,
                        )),
                  ),
                  onPressed: () async {
                    await val.getFromDate(context);
                  },
                  child: Center(
                      child: val.fromDateDis.isEmpty
                          ? const Text(
                              'From  🗓️ ',
                              style: TextStyle(color: Colors.black87),
                            )
                          : Text("From ${val.fromDateDis}")),
                ),
              ),
              kWidth,
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 3,
                    foregroundColor: UIGuide.light_Purple,
                    backgroundColor: UIGuide.ButtonBlue,
                    padding: const EdgeInsets.all(0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(
                          color: UIGuide.light_black,
                        )),
                  ),
                  onPressed: () async {
                    val.getToDate(context);
                  },
                  child: Center(
                      child: val.toDateDis.isEmpty
                          ? const Text(
                              'To  🗓️ ',
                              style: TextStyle(color: Colors.black87),
                            )
                          : Text("To ${val.toDateDis}")),
                ),
              ),
              kWidth
            ],
          ),
          kheight10,
          Row(
            children: [
              kWidth,
              Expanded(
                child: SizedBox(
                  height: 45,
                  child: Consumer<StaffNoticeboardSendProviders>(
                      builder: (context, snapshot, child) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 3,
                        foregroundColor: UIGuide.light_Purple,
                        backgroundColor: UIGuide.ButtonBlue,
                        padding: const EdgeInsets.all(0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(
                              color: UIGuide.light_black,
                            )),
                      ),
                      onPressed: () async {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  child: LimitedBox(
                                    maxHeight: size.height - 400,
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: noticeCourseStf!.length,
                                        itemBuilder: (context, index) {
                                          return ListTile(
                                            selectedTileColor:
                                                Colors.blue.shade100,
                                            onTap: () async {
                                              divisionvalueController1.clear();
                                              coursevalueController.text =
                                                  await noticeCourseStf![index]
                                                          ['value'] ??
                                                      '--';
                                              coursevalueController1.text =
                                                  await noticeCourseStf![index]
                                                          ['text'] ??
                                                      '--';
                                              String courseId =
                                                  coursevalueController.text
                                                      .toString();

                                              print(courseId);
                                              await snapshot.divisionClear();
                                              await snapshot
                                                  .getDivisionList(courseId);
                                              Navigator.of(context).pop();
                                            },
                                            title: Text(
                                              noticeCourseStf![index]['text'] ??
                                                  '--',
                                              textAlign: TextAlign.center,
                                            ),
                                          );
                                        }),
                                  ));
                            });
                      },
                      child: TextField(
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: UIGuide.BLACK,
                            overflow: TextOverflow.clip),
                        textAlign: TextAlign.center,
                        controller: coursevalueController1,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(left: 0, top: 0),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          filled: true,
                          fillColor: Colors.transparent,
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(style: BorderStyle.none, width: 0),
                          ),
                          labelText: "  Select Course",
                          hintText: "Course",
                        ),
                        enabled: false,
                      ),
                    );
                  }),
                ),
              ),
              kWidth,
              Expanded(
                child: SizedBox(
                  height: 45,
                  child: Consumer<StaffNoticeboardSendProviders>(
                      builder: (context, snapshot, child) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 3,
                        foregroundColor: UIGuide.light_Purple,
                        backgroundColor: UIGuide.ButtonBlue,
                        padding: const EdgeInsets.all(0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(
                              color: UIGuide.light_black,
                            )),
                      ),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ListView.builder(
                                          shrinkWrap: true,
                                          itemCount:
                                              snapshot.divisionlistt.length,
                                          itemBuilder: (context, index) {
                                            return ListTile(
                                              onTap: () async {
                                                divisionvalueController
                                                    .text = snapshot
                                                        .divisionlistt[index]
                                                        .value ??
                                                    '--';

                                                print(divisionvalueController
                                                    .text);
                                                divisionvalueController1
                                                    .text = snapshot
                                                        .divisionlistt[index]
                                                        .text ??
                                                    '--';

                                                Navigator.of(context).pop();
                                              },
                                              title: Text(
                                                snapshot.divisionlistt[index]
                                                        .text ??
                                                    '--',
                                                textAlign: TextAlign.center,
                                              ),
                                            );
                                          }),
                                    ],
                                  ));
                            });
                      },
                      child: TextField(
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: UIGuide.BLACK,
                            overflow: TextOverflow.clip),
                        textAlign: TextAlign.center,
                        controller: divisionvalueController1,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(left: 0, top: 0),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          filled: true,
                          fillColor: Colors.transparent,
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(style: BorderStyle.none, width: 0),
                          ),
                          labelText: "  Select Division",
                          hintText: "Division",
                        ),
                        enabled: false,
                      ),
                    );
                  }),
                ),
              ),
              kWidth
            ],
          ),
          kheight20,
          kheight10,
          Center(
            child: SizedBox(
              width: size.width / 2.4,
              child: MaterialButton(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                color: UIGuide.light_Purple,
                onPressed: (() async {
                  if (titleController.text.trim().isEmpty ||
                      mattercontroller.text.trim().isEmpty ||
                      coursevalueController.text.isEmpty ||
                      divisionvalueController.text.isEmpty ||
                      val.fromDateDis.isEmpty ||
                      val.toDateDis.isEmpty ||
                      categoryvalueController.text.isEmpty) {
                    snackbarWidget(2, "Select mandatory fields...", context);
                  } else if (val.fromDateCheck.isAfter(val.toDateCheck)) {
                    snackbarWidget(
                        2, 'From date is greater than to date', context);
                  } else {
                    await val.noticeBoardSave(
                        context,
                        datee.toString(),
                        val.fromDateDis,
                        val.toDateDis,
                        titleController.text,
                        mattercontroller.text,
                        coursevalueController.text,
                        divisionvalueController.text,
                        categoryvalueController.text,
                        val.imageid);

                    categoryvalueController1.clear();
                    titleController.clear();
                    mattercontroller.clear();
                    coursevalueController.clear();
                    categoryvalueController1.clear();
                    categoryvalueController.clear();
                    coursevalueController1.clear();
                    divisionvalueController.clear();
                    divisionvalueController1.clear();
                  }
                }),
                child: const Text(
                  'Save',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
