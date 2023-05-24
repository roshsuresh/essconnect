import 'package:awesome_dialog/awesome_dialog.dart';
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
  StaffNoticeBoard({Key? key}) : super(key: key);

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
                                builder: (context) => StaffNoticeBoard()));
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
                    return StaffNoticeBoard_sent();
                  } else {
                    return Container(
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
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
  StaffNoticeBoard_sent({Key? key}) : super(key: key);

  @override
  State<StaffNoticeBoard_sent> createState() => _StaffNoticeBoard_sentState();
}

class _StaffNoticeBoard_sentState extends State<StaffNoticeBoard_sent> {
  DateTime? _mydatetime;

  String? datee;

  DateTime? _mydatetimeFrom;

  DateTime? _mydatetimeTo;

  String time = '🗓️';

  String timeNow = '🗓️';

  String? checkname;

  final coursevalueController = TextEditingController();
  final coursevalueController1 = TextEditingController();
  final categoryvalueController = TextEditingController();
  final categoryvalueController1 = TextEditingController();
  final divisionvalueController = TextEditingController();
  final divisionvalueController1 = TextEditingController();
  final titleController = TextEditingController();
  final mattercontroller = TextEditingController();

  String attachmentid = '';
  @override
  Widget build(BuildContext context) {
    Provider.of<StaffNoticeboardSendProviders>(context, listen: false)
        .sendNoticeboard();
    var size = MediaQuery.of(context).size;
    datee = DateFormat('dd/MMM/yyyy').format(DateTime.now());

    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        kheight10,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(top: 1.0),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: UIGuide.light_Purple, width: 2)),
                height: 40,
                width: size.width * 0.45,
                child: MaterialButton(
                    color: Colors.white70,
                    child: Text('🗓️  ${datee.toString()}'),
                    onPressed: () async {
                      return;
                    }),
              ),
            ),
            const Spacer(),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.45,
              child: Consumer<StaffNoticeboardSendProviders>(
                  builder: (context, snapshot, child) {
                return InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                              child: Container(
                            child: LimitedBox(
                              maxHeight: size.height - 300,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: noticeCategoryStf!.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      selectedTileColor: Colors.blue.shade100,
                                      selectedColor: UIGuide.PRIMARY2,
                                      onTap: () async {
                                        print({noticeCategoryStf![index]});
                                        categoryvalueController.text =
                                            await noticeCategoryStf![index]
                                                    ['value'] ??
                                                '--';
                                        categoryvalueController1.text =
                                            await noticeCategoryStf![index]
                                                    ['text'] ??
                                                '--';

                                        Navigator.of(context).pop();
                                      },
                                      title: Text(
                                        noticeCategoryStf![index]['text'] ??
                                            '--',
                                        textAlign: TextAlign.center,
                                      ),
                                    );
                                  }),
                            ),
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
                                color: UIGuide.light_Purple, width: 2),
                          ),
                          height: 40,
                          child: TextField(
                            textAlign: TextAlign.center,
                            controller: categoryvalueController1,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(left: 0, top: 0),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              filled: true,
                              fillColor: Color.fromARGB(255, 238, 237, 237),
                              border: OutlineInputBorder(),
                              labelText: "  Select Category",
                              hintText: "Category",
                            ),
                            enabled: false,
                          ),
                        ),
                        SizedBox(
                          height: 0,
                          child: TextField(
                            textAlign: TextAlign.center,
                            controller: categoryvalueController,
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Color.fromARGB(255, 238, 237, 237),
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
            const Spacer(),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
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
          padding: const EdgeInsets.all(8.0),
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
            width: size.width / 2.4,
            child: Consumer<StaffNoticeboardSendProviders>(
              builder: (context, value, child) => value.loadingg
                  ? spinkitLoader()
                  : MaterialButton(
                      elevation: 5,
                      // minWidth: size.width - 200,
                      color: Colors.white,
                      onPressed: (() async {
                        final result = await FilePicker.platform.pickFiles(
                            type: FileType.custom,
                            allowedExtensions: ['pdf', 'png', 'jpeg', 'jpg']);
                        if (result == null) {
                          return;
                        }
                        final file = result.files.first;
                        print('Name: ${file.name}');
                        print('Path: ${file.path}');
                        print('Extension: ${file.extension}');

                        int sizee = file.size;

                        if (sizee <= 200000) {
                          await Provider.of<StaffNoticeboardSendProviders>(
                                  context,
                                  listen: false)
                              .noticeImageSave(context, file.path.toString());
                          attachmentid = value.id ?? '';
                          //openFile(file);
                          if (file.name.length >= 6) {
                            setState(() {
                              checkname = file.name
                                  .replaceRange(6, file.name.length, '');
                            });

                            print(checkname);
                          }
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
                              "Size Exceed(Less than 200KB allowed)",
                              textAlign: TextAlign.center,
                            ),
                          ));
                        }
                      }),
                      // minWidth: size.width - 200,
                      child: Text(checkname == null
                          ? '📁   Choose File'
                          : checkname.toString()),
                    ),
            ),
          ),
        ),
        const Center(
            child: Text(
          'Maximum allowed file size is 200 KB',
          style:
              TextStyle(fontSize: 9, color: Color.fromARGB(255, 241, 104, 94)),
        )),
        kheight10,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.46,
              child: MaterialButton(
                elevation: 5,
                color: Colors.white,
                onPressed: (() async {
                  _mydatetimeFrom = await showDatePicker(
                    context: context,
                    initialDate: _mydatetimeFrom ?? DateTime.now(),
                    firstDate: DateTime.now().subtract(const Duration(days: 0)),
                    lastDate: DateTime(2030),
                    builder: (context, child) {
                      return Theme(
                          data: ThemeData.light().copyWith(
                            primaryColor: UIGuide.light_Purple,
                            colorScheme: const ColorScheme.light(
                              primary: UIGuide.light_Purple,
                            ),
                            buttonTheme: const ButtonThemeData(
                                textTheme: ButtonTextTheme.primary),
                          ),
                          child: child!);
                    },
                  );
                  setState(() {
                    time = DateFormat('dd/MMM/yyyy').format(_mydatetimeFrom!);
                    print(time);
                  });
                }),
                child: Center(child: Text('From  $time')),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.46,
              child: MaterialButton(
                elevation: 5,
                color: Colors.white,
                onPressed: (() async {
                  _mydatetimeTo = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now().subtract(const Duration(days: 0)),
                    lastDate: DateTime(2100),
                    builder: (context, child) {
                      return Theme(
                          data: ThemeData.light().copyWith(
                            primaryColor: UIGuide.light_Purple,
                            colorScheme: const ColorScheme.light(
                              primary: UIGuide.light_Purple,
                            ),
                            buttonTheme: const ButtonThemeData(
                                textTheme: ButtonTextTheme.primary),
                          ),
                          child: child!);
                    },
                  );

                  setState(() {
                    timeNow = DateFormat('dd/MMM/yyyy').format(_mydatetimeTo!);
                    print(timeNow);
                  });
                }),
                child: Center(child: Text('To  $timeNow')),
              ),
            ),
            const Spacer()
          ],
        ),
        kheight10,
        Row(
          children: [
            const Spacer(),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.49,
              child: Consumer<StaffNoticeboardSendProviders>(
                  builder: (context, snapshot, child) {
                return InkWell(
                  onTap: () async {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                              child: Container(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: noticeCourseStf!.length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        selectedTileColor: Colors.blue.shade100,
                                        selectedColor: UIGuide.PRIMARY2,
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
                                          await Provider.of<
                                                      StaffNoticeboardSendProviders>(
                                                  context,
                                                  listen: false)
                                              .divisionClear();
                                          await Provider.of<
                                                      StaffNoticeboardSendProviders>(
                                                  context,
                                                  listen: false)
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
                              ],
                            ),
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
                                color: UIGuide.light_Purple, width: 1),
                          ),
                          height: 40,
                          child: TextField(
                            textAlign: TextAlign.center,
                            controller: coursevalueController1,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(left: 0, top: 0),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              filled: true,
                              fillColor: Color.fromARGB(255, 238, 237, 237),
                              border: OutlineInputBorder(),
                              labelText: "  Select Course",
                              hintText: "Course",
                            ),
                            enabled: false,
                          ),
                        ),
                        SizedBox(
                          height: 0,
                          child: TextField(
                            textAlign: TextAlign.center,
                            controller: coursevalueController,
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Color.fromARGB(255, 238, 237, 237),
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
            const Spacer(),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.49,
              child: Consumer<StaffNoticeboardSendProviders>(
                  builder: (context, snapshot, child) {
                return InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                              child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: snapshot.divisionlistt.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      onTap: () async {
                                        divisionvalueController.text = snapshot
                                                .divisionlistt[index].value ??
                                            '--';

                                        print(divisionvalueController.text);
                                        divisionvalueController1.text = snapshot
                                                .divisionlistt[index].text ??
                                            '--';
                                        String divisionId =
                                            divisionvalueController.text
                                                .toString();

                                        Navigator.of(context).pop();
                                      },
                                      title: Text(
                                        snapshot.divisionlistt[index].text ??
                                            '--',
                                        textAlign: TextAlign.center,
                                      ),
                                    );
                                  }),
                            ],
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
                                color: UIGuide.light_Purple, width: 1),
                          ),
                          height: 40,
                          child: TextField(
                            textAlign: TextAlign.center,
                            controller: divisionvalueController1,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(left: 0, top: 0),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              filled: true,
                              fillColor: Color.fromARGB(255, 238, 237, 237),
                              border: OutlineInputBorder(),
                              labelText: "  Select Division",
                              hintText: "Division",
                            ),
                            enabled: false,
                          ),
                        ),
                        SizedBox(
                          height: 0,
                          child: TextField(
                            textAlign: TextAlign.center,
                            controller: divisionvalueController,
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Color.fromARGB(255, 238, 237, 237),
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
            const Spacer()
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
                if (titleController.text.isEmpty ||
                    mattercontroller.text.isEmpty ||
                    coursevalueController.text.isEmpty ||
                    divisionvalueController.text.isEmpty ||
                    categoryvalueController.text.isEmpty) {
                  return await AwesomeDialog(
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.rightSlide,
                          headerAnimationLoop: false,
                          title: 'Error',
                          desc: 'Select mandatory fields',
                          btnOkOnPress: () {
                            return;
                          },
                          btnOkIcon: Icons.cancel,
                          btnOkColor: Colors.red)
                      .show();
                } else {
                  await Provider.of<StaffNoticeboardSendProviders>(context,
                          listen: false)
                      .noticeBoardSave(
                          context,
                          datee.toString(),
                          time,
                          timeNow,
                          titleController.text,
                          mattercontroller.text,
                          coursevalueController.text,
                          divisionvalueController.text,
                          categoryvalueController.text,
                          attachmentid);
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
    );
  }
}
