import 'package:essconnect/Application/AdminProviders/NotificationStaff.dart';
import 'package:essconnect/Application/AdminProviders/SchoolPhotoProviders.dart';
import 'package:essconnect/Constants.dart';
import 'package:essconnect/Domain/Admin/StaffListModel.dart';
import 'package:essconnect/Domain/Staff/StudentReport_staff.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:essconnect/utils/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';

class AdminToStaff extends StatelessWidget {
  AdminToStaff({Key? key}) : super(key: key);
  String? valuee;
  bool checked = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Communication to Staff',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
        ),
        titleSpacing: 00.0,
        centerTitle: true,
        toolbarHeight: 60,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
        ),
        backgroundColor: UIGuide.light_Purple,
      ),
      body: const AdminToStaffNotification(),
    );
  }
}

class AdminToStaffNotification extends StatefulWidget {
  const AdminToStaffNotification({Key? key}) : super(key: key);

  @override
  State<AdminToStaffNotification> createState() =>
      _AdminToStaffNotificationState();
}

class _AdminToStaffNotificationState extends State<AdminToStaffNotification> {
  List subjectData = [];

  String section = '';

  String types = "sms";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var p = Provider.of<SchoolPhotoProviders>(context, listen: false);
      p.stdReportSectionStaff();
      p.sectionCounter(0);
      p.dropDown.clear();
      p.stdReportInitialValues.clear();

      Provider.of<NotificationToStaffAdminProviders>(context, listen: false)
          .clearStaffList();
    });
  }

  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<NotificationToStaffAdminProviders>(
        builder: (context, val, _) => Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Consumer<SchoolPhotoProviders>(
                  builder: (context, value, child) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: MultiSelectDialogField(
                        // height: 200,
                        items: value.dropDown,

                        listType: MultiSelectListType.CHIP,
                        title: const Text(
                          "Select Section",
                          style: TextStyle(color: Colors.grey),
                        ),
                        selectedItemsTextStyle: const TextStyle(
                            fontWeight: FontWeight.w900,
                            color: UIGuide.light_Purple),
                        confirmText: const Text(
                          'OK',
                          style: TextStyle(color: UIGuide.light_Purple),
                        ),
                        cancelText: const Text(
                          'Cancel',
                          style: TextStyle(color: UIGuide.light_Purple),
                        ),
                        separateSelectedItems: true,
                        //  checkColor: Colors.lightBlue,
                        decoration: const BoxDecoration(
                          color: UIGuide.ButtonBlue,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0, 2),
                              blurRadius: 4,
                              spreadRadius: 0,
                            ),
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        buttonIcon: const Icon(
                          Icons.arrow_drop_down_outlined,
                          color: Colors.grey,
                        ),
                        buttonText: value.sectionLen == 0
                            ? const Text(
                                "Select Section",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              )
                            : Text(
                                "   ${value.sectionLen.toString()} Selected",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                        chipDisplay: MultiSelectChipDisplay.none(),
                        onConfirm: (results) async {
                          subjectData = [];
                          for (var i = 0; i < results.length; i++) {
                            StudReportSectionList data =
                                results[i] as StudReportSectionList;

                            subjectData.add(data.value);
                            subjectData.map((e) => data.value);
                            print("${subjectData.map((e) => data.value)}");
                          }
                          section = subjectData.join(',');
                          await Provider.of<SchoolPhotoProviders>(context,
                                  listen: false)
                              .sectionCounter(results.length);
                          await val.clearStaffList();
                          print("data $section");

                          print(subjectData.join(','));
                        },
                      ),
                    ),
                  ),
                ),
                //  const Spacer(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10),
                    child: SizedBox(
                      height: 43,
                      child: Consumer<NotificationToStaffAdminProviders>(
                        builder: (context, val, child) => val.loading
                            ? const Center(
                                child: Text(
                                "Loading",
                                style: TextStyle(
                                    color: UIGuide.light_Purple, fontSize: 16),
                              ))
                            : ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 3,
                                  foregroundColor: UIGuide.WHITE,
                                  backgroundColor: UIGuide.light_Purple,
                                  padding: const EdgeInsets.all(0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: const BorderSide(
                                        color: UIGuide.light_black,
                                      )),
                                ),
                                onPressed: () async {
                                  await val.clearStaffList();

                                  await val.getNotificationView(section);

                                  if (val.stafflist.isEmpty) {
                                    snackbarWidget(
                                        2,
                                        "No data for specified condition",
                                        context);
                                  }
                                },
                                child: const Text(
                                  'View',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: UIGuide.light_black, width: 1)),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Spacer(),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              types = "sms";
                            });
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Radio(
                                activeColor: UIGuide.light_Purple,
                                value: 'sms',
                                groupValue: types,
                                onChanged: (value) {
                                  setState(() {
                                    types = value.toString();
                                  });
                                  print(types);
                                },
                              ),
                              const Text(
                                "SMS",
                              ),
                            ],
                          ),
                        ),

                        // Spacer(),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              types = "email";
                            });
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Radio(
                                activeColor: UIGuide.light_Purple,
                                value: 'email',
                                groupValue: types,
                                onChanged: (value) {
                                  setState(() {
                                    types = value.toString();
                                  });
                                  print(types);
                                },
                              ),
                              const Text(
                                "E-mail",
                              ),
                            ],
                          ),
                        ),

                        // Spacer(),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              types = "notification";
                            });
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Radio(
                                activeColor: UIGuide.light_Purple,
                                value: 'notification',
                                groupValue: types,
                                onChanged: (value) {
                                  setState(() {
                                    types = value.toString();
                                  });
                                  print(types);
                                },
                              ),
                              const Text(
                                "Notification",
                              ),
                            ],
                          ),
                        ),

                        // Spacer(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            kheight10,
            val.stafflist.isEmpty
                ? const SizedBox(
                    height: 0,
                    width: 0,
                  )
                : Container(
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 241, 243, 245),
                        border:
                            Border.all(color: UIGuide.light_black, width: 1)),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 2.0, bottom: 2),
                      child: Table(
                        columnWidths: const {
                          0: FlexColumnWidth(1.3),
                          1: FlexColumnWidth(4),
                          2: FlexColumnWidth(1.4),
                        },
                        children: [
                          TableRow(children: [
                            const Text(
                              ' Sl.No.',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            const Text(
                              'Name',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            Consumer<NotificationToStaffAdminProviders>(
                              builder: (context, value, child) =>
                                  GestureDetector(
                                      onTap: () {
                                        value.selectAllStaff();
                                      },
                                      child: value.isSelectAllStaff
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15),
                                              child: SvgPicture.asset(
                                                UIGuide.check,
                                                color: UIGuide.light_Purple,
                                              ),
                                            )
                                          : const Text(
                                              'Select All',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: UIGuide.light_Purple),
                                            )),
                            )
                          ])
                        ],
                      ),
                    ),
                  ),
            Consumer<NotificationToStaffAdminProviders>(
              builder: (context, value, child) {
                return value.loading
                    ? Expanded(
                        child: Center(child: spinkitLoader()),
                      )
                    : Expanded(
                        child: Scrollbar(
                          thickness: 5,
                          controller: _scrollController,
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: value.stafflist.isEmpty
                                ? 0
                                : value.stafflist.length,
                            itemBuilder: ((context, index) {
                              return Container(
                                decoration: BoxDecoration(
                                  color: index.isEven
                                      ? Colors.white
                                      : const Color.fromARGB(
                                          255, 241, 243, 245),
                                  border: Border.all(
                                      color: UIGuide.light_black, width: 1),
                                ),
                                child: Notification_StudListAdmin(
                                  viewStud: value.stafflist[index],
                                  indexx: index,
                                ),
                              );
                            }),
                          ),
                        ),
                      );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 6,
        child: Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: Consumer<NotificationToStaffAdminProviders>(
              builder: (context, value, child) => value.loading
                  ? MaterialButton(
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      color: UIGuide.light_Purple,
                      onPressed: () {},
                      child: const Text('Please Wait...',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w400)),
                    )
                  : value.stafflist.isEmpty
                      ? const SizedBox(
                          height: 0,
                          width: 0,
                        )
                      : MaterialButton(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          color: UIGuide.light_Purple,
                          onPressed: () async {
                            if (types == 'notification') {
                              await Provider.of<
                                          NotificationToStaffAdminProviders>(
                                      context,
                                      listen: false)
                                  .submitStaff(context);
                            } else {
                              await Provider.of<
                                          NotificationToStaffAdminProviders>(
                                      context,
                                      listen: false)
                                  .getProvider();
                              value.types = types;
                              if (types == 'email') {
                                await Provider.of<
                                            NotificationToStaffAdminProviders>(
                                        context,
                                        listen: false)
                                    .submitSmsStaff(context);
                              } else if (types == 'sms') {
                                if (value.providerName == null) {
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
                                        'Sms Provider Not Found.....!',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  );
                                } else {
                                  await Provider.of<
                                              NotificationToStaffAdminProviders>(
                                          context,
                                          listen: false)
                                      .submitSmsStaff(context);
                                }
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(
                                  const SnackBar(
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
                                      'Something went wrong.....!',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                );
                              }
                            }
                          },
                          child: const Text('Proceed',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400)),
                        )),
        ),
      ),
    );
  }
}

class Notification_StudListAdmin extends StatelessWidget {
  final StaffReportNotification viewStud;
  const Notification_StudListAdmin(
      {Key? key, required this.viewStud, required this.indexx})
      : super(key: key);
  final int indexx;

  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationToStaffAdminProviders>(
      builder: (context, value, child) => ListTile(
        dense: true,
        titleAlignment: ListTileTitleAlignment.center,
        shape: const RoundedRectangleBorder(),
        selectedColor: UIGuide.light_Purple,
        leading: Text(
          (indexx + 1).toString(),
          textAlign: TextAlign.center,
        ),
        onTap: () {
          value.selectItem(viewStud);
        },
        title: Text(
          viewStud.name ?? '---',
          style: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.w600, color: UIGuide.BLACK),
        ),
        subtitle:
            Text(viewStud.staffRole!.isEmpty ? '---' : viewStud.staffRole!),
        trailing: viewStud.selected != null && viewStud.selected!
            ? SvgPicture.asset(
                UIGuide.check,
                color: UIGuide.light_Purple,
              )
            : SvgPicture.asset(
                UIGuide.notcheck,
                color: UIGuide.light_Purple,
              ),
      ),
    );
  }
}

class Text_Matter_NotificationAdminToStaff extends StatelessWidget {
  final List<String> toList;
  final String type;
  Text_Matter_NotificationAdminToStaff(
      {Key? key, required this.toList, required this.type})
      : super(key: key);
  final titleController = TextEditingController();
  final matterController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Send Notification'),
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
      body: SingleChildScrollView(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LottieBuilder.network(
                'https://assets10.lottiefiles.com/private_files/lf30_kBx3K1.json'),
            kheight20,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: LimitedBox(
                maxHeight: 80,
                child: TextFormField(
                  inputFormatters: [LengthLimitingTextInputFormatter(50)],
                  controller: titleController,
                  minLines: 1,
                  maxLines: 4,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    labelText: 'Title*',
                    hintText: 'Enter Title',
                    labelStyle: TextStyle(color: UIGuide.light_Purple),
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(0),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(20)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: UIGuide.light_Purple, width: 1.0),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(0),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(20)),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: LimitedBox(
                maxHeight: 150,
                child: TextFormField(
                  inputFormatters: [LengthLimitingTextInputFormatter(1000)],
                  controller: matterController,
                  minLines: 1,
                  maxLines: 15,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    labelText: 'Matter*',
                    hintText: 'Enter Matter',
                    labelStyle: TextStyle(color: UIGuide.light_Purple),
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(0),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(20)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: UIGuide.light_Purple, width: 1.0),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(0),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(20)),
                    ),
                  ),
                ),
              ),
            ),
            kheight20,
            Consumer<NotificationToStaffAdminProviders>(
              builder: (context, value, _) => value.load
                  ? spinkitLoader()
                  : SizedBox(
                      width: 150,
                      height: 40,
                      child: MaterialButton(
                        onPressed: () async {
                          if (titleController.text.trim().isNotEmpty &&
                              matterController.text.trim().isNotEmpty) {
                            await value.sendNotification(
                                context,
                                titleController.text,
                                matterController.text,
                                toList,
                                sentTo: type);
                            titleController.clear();
                            matterController.clear();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
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
                                  'Enter Title & Matter!',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                          }
                        },
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(0),
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(20)),
                        ),
                        color: UIGuide.light_Purple,
                        child: const Text(
                          'Send',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
