import 'dart:async';
import 'package:essconnect/Application/Staff_Providers/SearchProvider.dart';
import 'package:essconnect/Constants.dart';
import 'package:essconnect/Debouncer.dart';
import 'package:essconnect/Domain/Staff/StudentReport_staff.dart';
import 'package:essconnect/Presentation/Staff/StudentInformation/ReportCardView.dart';
import 'package:essconnect/Presentation/Staff/StudentInformation/TimeTableView.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:essconnect/utils/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchStudent_stf extends StatefulWidget {
  const SearchStudent_stf({Key? key}) : super(key: key);

  @override
  State<SearchStudent_stf> createState() => _SearchStudent_stfState();
}

class _SearchStudent_stfState extends State<SearchStudent_stf> {
  TextEditingController clearValue = TextEditingController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var p = Provider.of<Screen_Search_Providers>(context, listen: false);
      p.clearStudentList();
    });
  }

  final _debouncer = Debouncer(milliseconds: 1000);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
       onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              kheight10,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.grey,
                        )),
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: TextField(
                          focusNode: FocusNode(),
                          controller: clearValue,
                          onChanged: (value) {
                            _debouncer.run(() async {
                              await Provider.of<Screen_Search_Providers>(context,
                                      listen: false)
                                  .clearStudentList();
                              await Provider.of<Screen_Search_Providers>(context,
                                      listen: false)
                                  .getSearch_View(value);
                              print('-***--**-*-*-*-*-*');
                            });
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            suffixIcon: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.close),
                                  color: Colors.grey,
                                  onPressed: (() {
                                    clearValue.clear();
                                  }),
                                ),
                              ],
                            ),
                            hintText: 'Search',
                            hintStyle: const TextStyle(
                              color: Colors.grey,
                              fontSize: 20,
                            ),
                            fillColor: UIGuide.light_black,
                            filled: true,
                            //  contentPadding: EdgeInsets.only(left: 8),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: const BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          style: const TextStyle(color: UIGuide.light_Purple),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Consumer<Screen_Search_Providers>(
                    builder: (context, provider, child) {
                  if (clearValue.text.isEmpty) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LottieBuilder.network(
                            'https://assets5.lottiefiles.com/packages/lf20_l5qvxwtf.json'),
                        const Text(
                          "Please enter the name to search",
                          style: TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 122, 121, 121)),
                        )
                      ],
                    );
                  }
                  if (provider.searchStudent.isEmpty) {
                    Future.delayed(const Duration(seconds: 2));
                    return provider.loading
                        ? spinkitLoader()
                        : Center(
                            child: LottieBuilder.network(
                                'https://assets2.lottiefiles.com/private_files/lf30_lkquf6qz.json'),
                          );
                  }
                  return provider.loading
                      ? spinkitLoader()
                      : ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: provider.searchStudent.isEmpty
                              ? 0
                              : provider.searchStudent.length,
                          itemBuilder: (context, index) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                kheight10,
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              StudProfileViewBySearch_Staff(
                                                stud:
                                                    provider.searchStudent[index],
                                              )),
                                    );
                                  },
                                  child: Container(
                                    width: size.width - 15,
                                    decoration: const BoxDecoration(
                                        color: UIGuide.light_black,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        kWidth,
                                        Center(
                                          child: Container(
                                            width: 60,
                                            height: 60,
                                            decoration: BoxDecoration(
                                                color: UIGuide.light_black,
                                                image: DecorationImage(
                                                    image: NetworkImage(provider
                                                            .searchStudent[index]
                                                            .studentPhoto ??
                                                        'https://img.myloview.com/canvas-prints/default-avatar-profile-icon-social-media-user-symbol-image-400-251200038.jpg')),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(10))),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  const Text(
                                                    'Name : ',
                                                    style:
                                                        TextStyle(fontSize: 13),
                                                  ),
                                                  RichText(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    strutStyle: const StrutStyle(
                                                        fontSize: 8.0),
                                                    text: TextSpan(
                                                        style: const TextStyle(
                                                          fontSize: 12,
                                                          color: UIGuide
                                                              .light_Purple,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                        text: provider
                                                                .searchStudent[
                                                                    index]
                                                                .name ??
                                                            '---'),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  const Text(
                                                    'Roll No : ',
                                                    textAlign: TextAlign.start,
                                                    style:
                                                        TextStyle(fontSize: 13),
                                                  ),
                                                  RichText(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    strutStyle: const StrutStyle(
                                                        fontSize: 8.0),
                                                    text: TextSpan(
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.black,
                                                      ),
                                                      text: provider
                                                                  .searchStudent[
                                                                      index]
                                                                  .rollNo ==
                                                              null
                                                          ? '---'
                                                          : provider
                                                              .searchStudent[
                                                                  index]
                                                              .rollNo
                                                              .toString(),
                                                    ),
                                                  ),
                                                  kWidth,
                                                  kWidth,
                                                  Row(
                                                    children: [
                                                      const Text(
                                                        'Division : ',
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: TextStyle(
                                                            fontSize: 13),
                                                      ),
                                                      RichText(
                                                        overflow:
                                                            TextOverflow.ellipsis,
                                                        maxLines: 1,
                                                        strutStyle:
                                                            const StrutStyle(
                                                                fontSize: 8.0),
                                                        text: TextSpan(
                                                          style: const TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Colors.black,
                                                          ),
                                                          text: provider
                                                                  .searchStudent[
                                                                      index]
                                                                  .division ??
                                                              '---',
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  const Text(
                                                    'Adm No : ',
                                                    textAlign: TextAlign.start,
                                                    style:
                                                        TextStyle(fontSize: 13),
                                                  ),
                                                  RichText(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    strutStyle: const StrutStyle(
                                                        fontSize: 8.0),
                                                    text: TextSpan(
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.black,
                                                      ),
                                                      text: provider
                                                              .searchStudent[
                                                                  index]
                                                              .admnNo ??
                                                          '---',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              GestureDetector(
                                                onTap: () async {
                                                  String phn = provider
                                                              .searchStudent[
                                                                  index]
                                                              .mobNo ==
                                                          null
                                                      ? '--'
                                                      : provider
                                                          .searchStudent[index]
                                                          .mobNo
                                                          .toString();
      
                                                  _makingPhoneCall(
                                                      phn.toString());
                                                },
                                                child: Row(
                                                  children: [
                                                    const Text(
                                                      'Phone : ',
                                                      textAlign: TextAlign.start,
                                                      style:
                                                          TextStyle(fontSize: 13),
                                                    ),
                                                    RichText(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                      strutStyle:
                                                          const StrutStyle(
                                                              fontSize: 8.0),
                                                      text: TextSpan(
                                                        style: const TextStyle(
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.black,
                                                        ),
                                                        text: provider
                                                                .searchStudent[
                                                                    index]
                                                                .mobNo ??
                                                            '---',
                                                      ),
                                                    ),
                                                    kWidth,
                                                    const Icon(
                                                      Icons.phone,
                                                      size: 17,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _makingPhoneCall(String phn) async {
    var url = Uri.parse("tel:$phn");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class StudProfileViewBySearch_Staff extends StatefulWidget {
  ViewStudentReport stud;
  StudProfileViewBySearch_Staff({
    Key? key,
    required this.stud,
  }) : super(key: key);

  @override
  State<StudProfileViewBySearch_Staff> createState() =>
      _StudProfileViewBySearch_StaffState();
}

class _StudProfileViewBySearch_StaffState
    extends State<StudProfileViewBySearch_Staff> {
  //final int indexx;
  String? phn;

  String asonDate = '';

  String asonDateFee = '';
  String asonDateReport = '';

  int count = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var p = Provider.of<Screen_Search_Providers>(context, listen: false);
      p.clearStudentList();
      await p.getStudAttendance(widget.stud.studentId.toString());
      await p.geFeesDetails(widget.stud.studentId.toString());
      p.academics.clear();
      p.siblingdata.clear();
      await p.getAcademicPerformance(widget.stud.studentId.toString());
      await p.getTimetable(widget.stud.studentId.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const Color background = Colors.white;
    const Color fill1 = UIGuide.light_Purple;
    const Color fill2 = UIGuide.custom_blue;
    final List<Color> gradient = [
      fill1,
      fill2,
      background,
      background,
    ];
    const double fillPercent = 35;
    const double fillStop = (100 - fillPercent) / 100;
    final List<double> stops = [0.0, fillStop, fillStop, 1.0];

    return SafeArea(child: Scaffold(
      body: Consumer<Screen_Search_Providers>(builder: (context, value, child) {
        return ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Stack(
              children: [
                Container(
                  height: 260,
                  width: size.width,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: gradient,
                      stops: stops,
                      end: Alignment.bottomCenter,
                      begin: Alignment.topCenter,
                    ),
                  ),
                ),
                Positioned(
                  top: 70,
                  left: 30,
                  right: 30,
                  child: Container(
                      decoration: const BoxDecoration(
                        color: UIGuide.WHITE,
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 128, 125, 125),
                            offset: Offset(
                              2,
                              4.0,
                            ),
                            blurRadius: 4.0,
                            spreadRadius: 2.0,
                          ),
                        ],
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      width: size.width - 50,
                      height: 170,
                      child: Column(
                        children: [
                          kheight20,
                          kheight20,
                          kheight20,
                          kheight10,
                          Text(
                            widget.stud.name ?? '---',
                            style: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 13),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Division: ',
                                  style: TextStyle(
                                      fontSize: 14.0, color: Colors.grey)),
                              Text(widget.stud.division ?? '---',
                                  style: const TextStyle(fontSize: 14.0)),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Table(
                              border: TableBorder.all(
                                  color:
                                      const Color.fromARGB(255, 233, 233, 233),
                                  style: BorderStyle.solid,
                                  borderRadius: BorderRadius.circular(10),
                                  width: 2),
                              children: [
                                TableRow(children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 3, bottom: 3),
                                    child: Column(
                                      children: [
                                        const Text('Roll No',
                                            style:
                                                TextStyle(color: Colors.grey)),
                                        Text(
                                            widget.stud.rollNo == null
                                                ? '---'
                                                : widget.stud.rollNo.toString(),
                                            style: const TextStyle(
                                                fontSize: 16.0)),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 3, bottom: 3),
                                    child: Column(
                                      children: [
                                        const Text('Adm No',
                                            style:
                                                TextStyle(color: Colors.grey)),
                                        Text(widget.stud.admnNo ?? '---',
                                            style: const TextStyle(
                                                fontSize: 14.0)),
                                      ],
                                    ),
                                  ),
                                ])
                              ],
                            ),
                          )
                        ],
                      )),
                ),
                Center(
                  child: CircleAvatar(
                    radius: 65,
                    backgroundColor: UIGuide.WHITE,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: CircleAvatar(
                        foregroundColor: Colors.white,
                        foregroundImage: NetworkImage(
                          widget.stud.studentPhoto ??
                              'https://gj-eschool-files-public.s3.ap-south-1.amazonaws.com/ess-connect/student/avathar-02.jpeg',
                        ),
                        radius: 65,
                        backgroundColor: UIGuide.WHITE,
                      ),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.all(10),
                width: size.width,
                decoration: BoxDecoration(
                    color: UIGuide.WHITE,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0, 4),
                        blurRadius: 4,
                        spreadRadius: 0,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        children: [
                          const Text(
                            'Permenent Address: ',
                            style: TextStyle(fontSize: 12),
                          ),
                          Flexible(
                            child: Text(
                              widget.stud.address ?? '---',
                              overflow: TextOverflow.clip,
                              maxLines: 10,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        children: [
                          const Text(
                            'Bus Name : ',
                            style: TextStyle(fontSize: 12),
                          ),
                          Flexible(
                            child: Text(
                              widget.stud.bus ?? '---',
                              overflow: TextOverflow.clip,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        children: [
                          const Text(
                            'Bus Stop : ',
                            style: TextStyle(fontSize: 12),
                          ),
                          Flexible(
                            child: Text(
                              widget.stud.stop ?? '---',
                              overflow: TextOverflow.clip,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _makingPhoneCall(phn.toString());
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          children: [
                            const Text(
                              'Phone No : ',
                              style: TextStyle(fontSize: 13),
                            ),
                            Flexible(
                              child: Text(
                                phn = widget.stud.mobNo ?? '---',
                                overflow: TextOverflow.clip,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.white,
                    builder: (context) {
                      return Wrap(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: size.width,
                              height: 160,
                              margin: const EdgeInsets.all(6.0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: UIGuide.light_Purple, width: .5),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5))),
                              child: Column(
                                children: [
                                  ListTile(
                                    horizontalTitleGap: 1,
                                    title: const Text("Guardian Details"),
                                    titleTextStyle: const TextStyle(
                                      fontSize: 16,
                                      color: UIGuide.light_Purple,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    leadingAndTrailingTextStyle:
                                        const TextStyle(),
                                    trailing: TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text(
                                        " ❌ ",
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                  const Divider(
                                    height: 3,
                                    color: Colors.grey,
                                    thickness: 1,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          width: 80,
                                          height: 80,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              image: DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: NetworkImage(
                                                    value.guardianPhotoId ==
                                                            null
                                                        ? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTLGZsYc8h4Zds-CgwVk_T5ykObxIbZKfvHtQ&usqp=CAU'
                                                        : value
                                                            .guardianPhoto!.url
                                                            .toString(),
                                                  )),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10))),
                                        ),
                                      ),
                                      kWidth,
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          kheight10,
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.person_2_outlined,
                                                size: 20,
                                                color: Colors.grey,
                                              ),
                                              Text(
                                                value.guardianName == null
                                                    ? '  ----'
                                                    : '  ${value.guardianName.toString()}',
                                                style: const TextStyle(
                                                    color:
                                                        UIGuide.light_Purple),
                                              )
                                            ],
                                          ),
                                          kheight10,
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.phone_android_outlined,
                                                size: 20,
                                                color: Colors.grey,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  value.guardianMobile1!
                                                          .isNotEmpty
                                                      ? _makingPhoneCall(value
                                                          .guardianMobile1
                                                          .toString())
                                                      : print("no no");
                                                },
                                                child: Text(
                                                  value.guardianMobile1 == null
                                                      ? '  ----'
                                                      : '  ${value.guardianMobile1.toString()} 📞',
                                                  style: const TextStyle(
                                                      color:
                                                          UIGuide.light_Purple),
                                                ),
                                              )
                                            ],
                                          ),
                                          kheight10,
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.email_outlined,
                                                size: 20,
                                                color: Colors.grey,
                                              ),
                                              Text(
                                                value.guardianEmail == null
                                                    ? '  ----'
                                                    : '  ${value.guardianEmail.toString()}',
                                                style: const TextStyle(
                                                    color:
                                                        UIGuide.light_Purple),
                                              )
                                            ],
                                          ),
                                          kheight10,
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          kheight10,
                        ],
                      );
                    },
                  );
                },
                child: const Row(
                  children: [
                    Icon(
                      Icons.person_outline_outlined,
                      color: UIGuide.light_Purple,
                    ),
                    Text(
                      "  Guardian Details",
                      style: TextStyle(
                          color: UIGuide.light_Purple,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.white,
                    builder: (context) {
                      return Wrap(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: size.width,
                              height: 160,
                              margin: const EdgeInsets.all(6.0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: UIGuide.light_Purple, width: .5),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5))),
                              child: Column(
                                children: [
                                  ListTile(
                                    horizontalTitleGap: 1,
                                    title: const Text("Father Details"),
                                    titleTextStyle: const TextStyle(
                                      fontSize: 16,
                                      color: UIGuide.light_Purple,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    leadingAndTrailingTextStyle:
                                        const TextStyle(),
                                    trailing: TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          " ❌ ",
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                        )),
                                  ),
                                  const Divider(
                                    height: 3,
                                    color: Colors.grey,
                                    thickness: 1,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          width: 80,
                                          height: 80,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              image: DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: NetworkImage(
                                                    value.fatherPhotoId == null
                                                        ? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTLGZsYc8h4Zds-CgwVk_T5ykObxIbZKfvHtQ&usqp=CAU'
                                                        : value.fatherPhoto!.url
                                                            .toString(),
                                                  )),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10))),
                                        ),
                                      ),
                                      kWidth,
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          kheight10,
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.person_2_outlined,
                                                size: 20,
                                                color: Colors.grey,
                                              ),
                                              Text(
                                                value.fatherName == null
                                                    ? '  ----'
                                                    : '  ${value.fatherName.toString()}',
                                                style: const TextStyle(
                                                    color:
                                                        UIGuide.light_Purple),
                                              )
                                            ],
                                          ),
                                          kheight10,
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.phone_android_outlined,
                                                size: 20,
                                                color: Colors.grey,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  value.fatherMobile1!
                                                          .isNotEmpty
                                                      ? _makingPhoneCall(value
                                                          .fatherMobile1
                                                          .toString())
                                                      : print("no no");
                                                },
                                                child: Text(
                                                  value.fatherMobile1 == null
                                                      ? '  ----'
                                                      : '  ${value.fatherMobile1.toString()} 📞',
                                                  style: const TextStyle(
                                                      color:
                                                          UIGuide.light_Purple),
                                                ),
                                              )
                                            ],
                                          ),
                                          kheight10,
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.email_outlined,
                                                size: 20,
                                                color: Colors.grey,
                                              ),
                                              Text(
                                                value.fatherEmail == null
                                                    ? '  ----'
                                                    : '  ${value.fatherEmail.toString()}',
                                                style: const TextStyle(
                                                    color:
                                                        UIGuide.light_Purple),
                                              )
                                            ],
                                          ),
                                          kheight10,
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          kheight10,
                        ],
                      );
                    },
                  );
                },
                child: const Row(
                  children: [
                    Icon(
                      Icons.person_4_outlined,
                      color: UIGuide.light_Purple,
                    ),
                    Text(
                      "  Father Details",
                      style: TextStyle(
                          color: UIGuide.light_Purple,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.white,
                    builder: (context) {
                      return Wrap(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: size.width,
                              margin: const EdgeInsets.all(6.0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: UIGuide.light_Purple, width: .5),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5))),
                              child: Column(
                                children: [
                                  ListTile(
                                    horizontalTitleGap: 1,
                                    title: const Text("Mother Details"),
                                    titleTextStyle: const TextStyle(
                                      fontSize: 16,
                                      color: UIGuide.light_Purple,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    leadingAndTrailingTextStyle:
                                        const TextStyle(),
                                    trailing: TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          " ❌ ",
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                        )),
                                  ),
                                  const Divider(
                                    height: 3,
                                    color: Colors.grey,
                                    thickness: 1,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          width: 80,
                                          height: 80,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              image: DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: NetworkImage(
                                                    value.motherPhotoId == null
                                                        ? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTLGZsYc8h4Zds-CgwVk_T5ykObxIbZKfvHtQ&usqp=CAU'
                                                        : value.motherPhoto!.url
                                                            .toString(),
                                                  )),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10))),
                                        ),
                                      ),
                                      kWidth,
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          kheight10,
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.person_2_outlined,
                                                size: 20,
                                              ),
                                              Text(
                                                value.motherName == null
                                                    ? '  ----'
                                                    : '  ${value.motherName.toString()}',
                                                style: const TextStyle(
                                                    color:
                                                        UIGuide.light_Purple),
                                              )
                                            ],
                                          ),
                                          kheight10,
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.phone_android_outlined,
                                                color: Colors.grey,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  value.motherMobile1!
                                                          .isNotEmpty
                                                      ? _makingPhoneCall(value
                                                          .motherMobile1
                                                          .toString())
                                                      : print("no no");
                                                },
                                                child: Text(
                                                  value.motherMobile1 == null
                                                      ? '  ----'
                                                      : '  ${value.motherMobile1.toString()}',
                                                  style: const TextStyle(
                                                      color:
                                                          UIGuide.light_Purple),
                                                ),
                                              )
                                            ],
                                          ),
                                          kheight10,
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.email_outlined,
                                                size: 20,
                                                color: Colors.grey,
                                              ),
                                              Text(
                                                value.motherEmail == null
                                                    ? '  ----'
                                                    : '  ${value.motherEmail.toString()}',
                                                style: const TextStyle(
                                                    color:
                                                        UIGuide.light_Purple),
                                              )
                                            ],
                                          ),
                                          kheight10,
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          kheight10,
                        ],
                      );
                    },
                  );
                },
                child: const Row(
                  children: [
                    Icon(
                      Icons.person_3_outlined,
                      color: UIGuide.light_Purple,
                    ),
                    Text(
                      "  Mother Details",
                      style: TextStyle(
                          color: UIGuide.light_Purple,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  value.siblingdata.isEmpty
                      ? ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            duration: Duration(seconds: 1),
                            margin: EdgeInsets.only(
                                bottom: 50, left: 30, right: 30),
                            behavior: SnackBarBehavior.floating,
                            content: Text(
                              "No Siblings found....",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      : showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.white,
                          builder: (context) {
                            return Wrap(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Column(
                                    children: [
                                      ListTile(
                                        horizontalTitleGap: 1,
                                        title: const Text("Sibling Details"),
                                        titleTextStyle: const TextStyle(
                                          fontSize: 16,
                                          color: UIGuide.light_Purple,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        leadingAndTrailingTextStyle:
                                            const TextStyle(),
                                        trailing: TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text(
                                              " ❌ ",
                                              style: TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600),
                                            )),
                                      ),
                                      const Divider(
                                        height: 3,
                                        color: Colors.grey,
                                        thickness: 1,
                                      ),
                                      ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: value.siblingdata.length,
                                          itemBuilder: ((context, index) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Container(
                                                // height: 120,
                                                width: size.width,
                                                decoration: BoxDecoration(
                                                    color: const Color.fromARGB(
                                                        255, 240, 240, 243),
                                                    border: Border.all(
                                                      color:
                                                          UIGuide.light_Purple,
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Container(
                                                        height: 80,
                                                        width: 80,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              color: UIGuide
                                                                  .light_Purple),
                                                          shape:
                                                              BoxShape.circle,
                                                          image: DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image: NetworkImage(value
                                                                          .siblingdata[
                                                                              index]
                                                                          .siblingPhoto ==
                                                                      null
                                                                  ? 'https://img.myloview.com/canvas-prints/default-avatar-profile-icon-social-media-user-symbol-image-400-251200038.jpg'
                                                                  : value
                                                                      .siblingdata[
                                                                          index]
                                                                      .siblingPhoto!
                                                                      .url
                                                                      .toString())),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      height: 120,
                                                      width: size.width * 0.7,
                                                      decoration:
                                                          const BoxDecoration(),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Expanded(
                                                            child: Row(
                                                              children: [
                                                                const Text(
                                                                    "Name   : "),
                                                                Text(
                                                                  value
                                                                      .siblingdata[
                                                                          index]
                                                                      .siblingName
                                                                      .toString(),
                                                                  style: const TextStyle(
                                                                      color: UIGuide
                                                                          .light_Purple),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Row(
                                                              children: [
                                                                const Text(
                                                                    "Divison : "),
                                                                Text(
                                                                  value
                                                                      .siblingdata[
                                                                          index]
                                                                      .siblingDivision
                                                                      .toString(),
                                                                  style: const TextStyle(
                                                                      color: UIGuide
                                                                          .light_Purple),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Row(
                                                              children: [
                                                                const Text(
                                                                    "Roll No  : "),
                                                                Text(
                                                                  value
                                                                      .siblingdata[
                                                                          index]
                                                                      .siblingRollNo
                                                                      .toString(),
                                                                  style: const TextStyle(
                                                                      color: UIGuide
                                                                          .light_Purple),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Row(
                                                              children: [
                                                                const Text(
                                                                    "Adm No : "),
                                                                Text(
                                                                  value
                                                                      .siblingdata[
                                                                          index]
                                                                      .siblingAdmNo
                                                                      .toString(),
                                                                  style: const TextStyle(
                                                                      color: UIGuide
                                                                          .light_Purple),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Row(
                                                              children: [
                                                                const Text(
                                                                    "Relation : "),
                                                                Text(
                                                                  value
                                                                      .siblingdata[
                                                                          index]
                                                                      .siblingRelation
                                                                      .toString(),
                                                                  style: const TextStyle(
                                                                      color: UIGuide
                                                                          .light_Purple),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                          })),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                },
                child: const Row(
                  children: [
                    Icon(
                      Icons.group_outlined,
                      color: UIGuide.light_Purple,
                    ),
                    Text(
                      "  Sibling Details",
                      style: TextStyle(
                          color: UIGuide.light_Purple,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Wrap(
                        children: [
                          Column(
                            children: [
                              ListTile(
                                horizontalTitleGap: 1,
                                title: const Text("Health Status"),
                                titleTextStyle: const TextStyle(
                                  fontSize: 16,
                                  color: UIGuide.light_Purple,
                                  fontWeight: FontWeight.bold,
                                ),
                                leadingAndTrailingTextStyle: const TextStyle(),
                                trailing: TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      " ❌ ",
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    )),
                              ),
                              const Divider(
                                height: 3,
                                color: Colors.grey,
                                thickness: 1,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Card(
                                        color: const Color.fromARGB(
                                            249, 239, 239, 245),
                                        elevation: 5.0,
                                        shadowColor: UIGuide.THEME_LIGHT,
                                        semanticContainer: true,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            kheight10,
                                            Center(
                                                child: Text(
                                              value.disability == null
                                                  ? '--'
                                                  : value.disability.toString(),
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: UIGuide.light_Purple,
                                                  fontWeight: FontWeight.w700),
                                            )),
                                            kheight10,
                                            const Center(
                                              child: Text(
                                                "Disability",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black54,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            kheight10,
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Card(
                                        color: const Color.fromARGB(
                                            249, 239, 239, 245),
                                        elevation: 5.0,
                                        shadowColor: UIGuide.THEME_LIGHT,
                                        semanticContainer: true,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            kheight10,
                                            Text(
                                              value.teeth == null
                                                  ? '--'
                                                  : value.teeth.toString(),
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: UIGuide.light_Purple,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            kheight10,
                                            const Text(
                                              "Teeth",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black54,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            kheight10,
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Card(
                                    color: const Color.fromARGB(
                                        249, 239, 239, 245),
                                    elevation: 5.0,
                                    shadowColor: UIGuide.THEME_LIGHT,
                                    semanticContainer: true,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        kheight10,
                                        Center(
                                            child: Text(
                                          value.height == null
                                              ? '--'
                                              : value.height.toString(),
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: UIGuide.light_Purple,
                                              fontWeight: FontWeight.w700),
                                        )),
                                        kheight10,
                                        const Center(
                                          child: Text(
                                            "Height",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black54,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        kheight10,
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Card(
                                    color: const Color.fromARGB(
                                        249, 239, 239, 245),
                                    elevation: 5.0,
                                    shadowColor: UIGuide.THEME_LIGHT,
                                    semanticContainer: true,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        kheight10,
                                        Text(
                                          value.weight == null
                                              ? '--'
                                              : value.weight.toString(),
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: UIGuide.light_Purple,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        kheight10,
                                        const Text(
                                          "Weight",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        kheight10,
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Card(
                                    color: const Color.fromARGB(
                                        249, 239, 239, 245),
                                    elevation: 5.0,
                                    shadowColor: UIGuide.THEME_LIGHT,
                                    semanticContainer: true,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        kheight10,
                                        Center(
                                            child: Text(
                                          value.visionLeft == null
                                              ? '--'
                                              : value.visionLeft.toString(),
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: UIGuide.light_Purple,
                                              fontWeight: FontWeight.w700),
                                        )),
                                        kheight10,
                                        const Center(
                                          child: Text(
                                            "Vision Left",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black54,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        kheight10,
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Card(
                                    color: const Color.fromARGB(
                                        249, 239, 239, 245),
                                    elevation: 5.0,
                                    shadowColor: UIGuide.THEME_LIGHT,
                                    semanticContainer: true,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        kheight10,
                                        Text(
                                          value.visionRight == null
                                              ? '--'
                                              : value.visionRight.toString(),
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: UIGuide.light_Purple,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        kheight10,
                                        const Text(
                                          "Vision Right",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        kheight10,
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Card(
                                    color: const Color.fromARGB(
                                        249, 239, 239, 245),
                                    elevation: 5.0,
                                    shadowColor: UIGuide.THEME_LIGHT,
                                    semanticContainer: true,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        kheight10,
                                        Center(
                                            child: Text(
                                          value.oralHygiene == null
                                              ? '--'
                                              : value.oralHygiene.toString(),
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: UIGuide.light_Purple,
                                              fontWeight: FontWeight.w700),
                                        )),
                                        kheight10,
                                        const Center(
                                          child: Text(
                                            "Oral Hygiene",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black54,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        kheight10,
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Card(
                                    color: const Color.fromARGB(
                                        249, 239, 239, 245),
                                    elevation: 5.0,
                                    shadowColor: UIGuide.THEME_LIGHT,
                                    semanticContainer: true,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        kheight10,
                                        Text(
                                          value.remarks == null
                                              ? '--'
                                              : value.remarks.toString(),
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: UIGuide.light_Purple,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        kheight10,
                                        const Text(
                                          "Ailment Or Remarks If Any",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        kheight10,
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Row(
                  children: [
                    Icon(
                      Icons.monitor_heart_outlined,
                      color: UIGuide.light_Purple,
                    ),
                    Text(
                      "  Health Status",
                      style: TextStyle(
                          color: UIGuide.light_Purple,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  if (value.attendanceAsOnDate == "" ||
                      value.attendanceAsOnDate == null) {
                    print("");
                  } else {
                    DateTime asondt1 = value.attendanceAsOnDate!.isNotEmpty
                        ? DateFormat("yyyy-MM-dd")
                            .parse(value.attendanceAsOnDate!)
                        : DateTime.now();
                    DateFormat dateFormat = DateFormat("dd-MM-yyyy");
                    asonDate = dateFormat.format(asondt1);
                  }

                  //final DateFormat formatter = DateFormat('yyyy-MM-dd');

                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Wrap(
                        children: [
                          ListTile(
                            horizontalTitleGap: 1,
                            leading: const Icon(
                              Icons.calendar_month_outlined,
                              color: UIGuide.light_Purple,
                            ),
                            title: Text("As on Date $asonDate"),
                            titleTextStyle: const TextStyle(
                                fontSize: 16,
                                color: UIGuide.light_Purple,
                                fontWeight: FontWeight.bold),
                            trailing: TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  " ❌ ",
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                )),
                          ),
                          const Divider(
                            height: 3,
                            color: Colors.grey,
                            thickness: 1,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Card(
                              color: const Color.fromARGB(249, 239, 239, 245),
                              elevation: 5.0,
                              shadowColor: UIGuide.THEME_LIGHT,
                              semanticContainer: true,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  kheight10,
                                  Center(
                                      child: Text(
                                    value.workDays.toString(),
                                    style: const TextStyle(
                                        fontSize: 20,
                                        color:
                                            Color.fromARGB(224, 179, 64, 255),
                                        fontWeight: FontWeight.w700),
                                  )),
                                  kheight10,
                                  const Center(
                                    child: Text(
                                      "No.Of Working Days",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: UIGuide.light_Purple,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  kheight10,
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Card(
                              color: const Color.fromARGB(249, 239, 239, 245),
                              elevation: 5.0,
                              shadowColor: UIGuide.THEME_LIGHT,
                              semanticContainer: true,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  kheight10,
                                  Text(
                                    value.presentDays.toString() ?? '0',
                                    style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.green,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  kheight10,
                                  const Text(
                                    "Days Present",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: UIGuide.light_Purple,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  kheight10,
                                  LinearPercentIndicator(
                                    width: 140.0,
                                    lineHeight: 5.0,
                                    percent:
                                        value.attendancePercentage! / 100 ?? 0,
                                    backgroundColor: Colors.grey,
                                    progressColor: Colors.green,
                                    alignment: MainAxisAlignment.center,
                                  ),
                                  kheight10,
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Card(
                              color: const Color.fromARGB(249, 239, 239, 245),
                              elevation: 5.0,
                              shadowColor: UIGuide.THEME_LIGHT,
                              semanticContainer: true,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  kheight10,
                                  Text(
                                    value.absentDays.toString() ?? '--',
                                    style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.red,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  kheight10,
                                  const Text(
                                    "Days Absent",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: UIGuide.light_Purple,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  kheight10,
                                  LinearPercentIndicator(
                                    width: 140.0,
                                    lineHeight: 5.0,
                                    percent: value.absentPercentage! / 100 ?? 0,
                                    backgroundColor: Colors.grey,
                                    progressColor: Colors.red,
                                    alignment: MainAxisAlignment.center,
                                  ),
                                  kheight10,
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Card(
                              color: const Color.fromARGB(249, 239, 239, 245),
                              elevation: 5.0,
                              shadowColor: UIGuide.THEME_LIGHT,
                              semanticContainer: true,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Column(
                                children: <Widget>[
                                  kheight10,
                                  Text(
                                    value.attendancePercentage.toString() ??
                                        '--',
                                    style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.orange,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  kheight10,
                                  const Text(
                                    "% of Attendance",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: UIGuide.light_Purple,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  kheight10,
                                  LinearPercentIndicator(
                                    width: 140.0,
                                    lineHeight: 5.0,
                                    percent:
                                        value.attendancePercentage! / 100 ?? 0,
                                    backgroundColor: Colors.grey,
                                    progressColor: Colors.orange,
                                    alignment: MainAxisAlignment.center,
                                  ),
                                  kheight10,
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Row(
                  children: [
                    Icon(
                      Icons.verified_user_outlined,
                      color: UIGuide.light_Purple,
                    ),
                    Text(
                      "  Attendance",
                      style: TextStyle(
                          color: UIGuide.light_Purple,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  if (value.maxDate == "" || value.maxDate == null) {
                    print("");
                  } else {
                    DateTime asonfeedate = value.maxDate!.isNotEmpty
                        ? DateFormat("yyyy-MM-dd").parse(value.maxDate!)
                        : DateTime.now();
                    DateFormat dateFormatfee = DateFormat("dd-MM-yyyy");
                    asonDateFee = dateFormatfee.format(asonfeedate);
                  }

                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Wrap(
                        children: [
                          ListTile(
                            horizontalTitleGap: 1,
                            leading: const Icon(
                              Icons.calendar_month_outlined,
                              color: UIGuide.light_Purple,
                            ),
                            title: Text(
                              "As on Date $asonDateFee" ?? '--',
                            ),
                            titleTextStyle: const TextStyle(
                              fontSize: 16,
                              color: UIGuide.light_Purple,
                              fontWeight: FontWeight.bold,
                            ),
                            trailing: TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  " ❌ ",
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                )),
                          ),
                          const Divider(
                            height: 3,
                            color: Colors.grey,
                            thickness: 1,
                          ),
                          SizedBox(
                            width: 150,
                            child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: UIGuide.THEME_LIGHT,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                ),
                                child: const Text(
                                  "🏫 School Fees",
                                  style: TextStyle(color: UIGuide.light_Purple),
                                )),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Card(
                                    color: const Color.fromARGB(
                                        249, 239, 239, 245),
                                    elevation: 5.0,
                                    shadowColor: UIGuide.THEME_LIGHT,
                                    semanticContainer: true,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        kheight10,
                                        Center(
                                            child: Text(
                                          "₹ ${value.schoolPaidAmount.toString()}" ??
                                              '0.0',
                                          style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.green,
                                              fontWeight: FontWeight.w700),
                                        )),
                                        kheight10,
                                        const Center(
                                          child: Text(
                                            "Fees Paid through Online",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: UIGuide.light_Purple,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        kheight10,
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Card(
                                    color: const Color.fromARGB(
                                        249, 239, 239, 245),
                                    elevation: 5.0,
                                    shadowColor: UIGuide.THEME_LIGHT,
                                    semanticContainer: true,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        kheight10,
                                        Text(
                                          "₹ ${value.schoolPendingAmount.toString()}" ??
                                              '0.0',
                                          style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.orange,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        kheight10,
                                        const Text(
                                          "Pending Fees",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: UIGuide.light_Purple,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        kheight10,
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 150,
                            child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: UIGuide.THEME_LIGHT,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                ),
                                child: const Text(
                                  "🚌 Bus Fees",
                                  style: TextStyle(color: UIGuide.light_Purple),
                                )),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Card(
                                    color: const Color.fromARGB(
                                        249, 239, 239, 245),
                                    elevation: 5.0,
                                    shadowColor: UIGuide.THEME_LIGHT,
                                    semanticContainer: true,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        kheight10,
                                        Center(
                                            child: Text(
                                          "₹ ${value.busPaidAmount.toString()}" ??
                                              '0.0',
                                          style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.green,
                                              fontWeight: FontWeight.w700),
                                        )),
                                        kheight10,
                                        const Center(
                                          child: Text(
                                            "Fees Paid through Online",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: UIGuide.light_Purple,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        kheight10,
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Card(
                                    color: const Color.fromARGB(
                                        249, 239, 239, 245),
                                    elevation: 5.0,
                                    shadowColor: UIGuide.THEME_LIGHT,
                                    semanticContainer: true,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        kheight10,
                                        Text(
                                          "₹ ${value.busPendingAmount.toString()}" ??
                                              '0.0',
                                          style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.orange,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        kheight10,
                                        const Text(
                                          "Pending Fees",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: UIGuide.light_Purple,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        kheight10,
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Row(
                  children: [
                    Icon(
                      Icons.currency_rupee_outlined,
                      color: UIGuide.light_Purple,
                    ),
                    Text(
                      "  Fees",
                      style: TextStyle(
                          color: UIGuide.light_Purple,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  value.academics.isEmpty
                      ? ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          duration: Duration(seconds: 1),
                          margin:
                              EdgeInsets.only(bottom: 50, left: 30, right: 30),
                          behavior: SnackBarBehavior.floating,
                          content: Text(
                            "No Report cards found....",
                            textAlign: TextAlign.center,
                          ),
                        ))
                      : showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.white,
                          builder: (context) {
                            return Wrap(
                              children: [
                                Column(
                                  children: [
                                    ListTile(
                                      horizontalTitleGap: 1,
                                      title: const Text("Academic Performance"),
                                      titleTextStyle: const TextStyle(
                                        fontSize: 16,
                                        color: UIGuide.light_Purple,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      leadingAndTrailingTextStyle:
                                          const TextStyle(),
                                      trailing: TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text(
                                            " ❌ ",
                                            style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600),
                                          )),
                                    ),
                                    const Divider(
                                      height: 5,
                                      color: Colors.grey,
                                      thickness: 1,
                                    ),
                                    Table(
                                      border: TableBorder.all(
                                          color: const Color.fromARGB(
                                              255, 255, 255, 255)),
                                      columnWidths: const {
                                        0: FlexColumnWidth(3),
                                        1: FlexColumnWidth(5),
                                        2: FlexColumnWidth(2),
                                      },
                                      children: const [
                                        TableRow(
                                          decoration: BoxDecoration(
                                            color: UIGuide.light_black,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(12),
                                              topRight: Radius.circular(12),
                                            ),
                                          ),
                                          children: [
                                            SizedBox(
                                              height: 30,
                                              child: Center(
                                                child: Text(
                                                  'Date',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 30,
                                              child: Center(
                                                child: Text(
                                                  'Description',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 30,
                                              child: Center(
                                                  child: Text(
                                                'View',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w600),
                                              )),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    LimitedBox(
                                      maxHeight: size.height / 2,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: value.academics.length,
                                        itemBuilder: ((context, index) {
                                          //created date

                                          if (value.academics[index]
                                                  .uploadedDate !=
                                              null) {
                                            String createddate = value
                                                    .academics[index]
                                                    .uploadedDate ??
                                                '--';
                                            DateTime parsedDateTime =
                                                DateTime.parse(createddate);
                                            asonDateReport =
                                                DateFormat('dd-MMM-yyyy')
                                                    .format(parsedDateTime);
                                          }

                                          String reAttach =
                                              value.academics[index].fileId ??
                                                  '--';
                                          print(reAttach);
                                          return InkWell(
                                            onTap: () async {
                                              await value
                                                  .getreportCardAttachment(
                                                      reAttach);
                                              if (value.extension.toString() ==
                                                  '.pdf') {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                           AdminReportCard()),
                                                );
                                              } else {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const NoAttachmentScreen()),
                                                );
                                              }
                                            },
                                            child: Table(
                                              border: TableBorder.all(
                                                  color: const Color.fromARGB(
                                                      255, 255, 255, 255)),
                                              columnWidths: const {
                                                0: FlexColumnWidth(3),
                                                1: FlexColumnWidth(5),
                                                2: FlexColumnWidth(2),
                                              },
                                              children: [
                                                TableRow(
                                                    decoration:
                                                        const BoxDecoration(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    246,
                                                                    247,
                                                                    248)),
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          asonDateReport
                                                              .toString(),
                                                          style: const TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: UIGuide
                                                                  .light_Purple),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          value.academics[index]
                                                                  .description ??
                                                              "--",
                                                          style: const TextStyle(
                                                              color: UIGuide
                                                                  .light_Purple,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: SizedBox(
                                                          height: 25,
                                                          width: 25,
                                                          child: LottieBuilder
                                                                  .network(
                                                                      "https://assets2.lottiefiles.com/temp/lf20_D0nz3r.json") ?? const Icon(Icons
                                                                  .remove_red_eye_outlined),
                                                        ),
                                                      ),
                                                    ]),
                                              ],
                                            ),
                                          );
                                        }),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        );
                },
                child: const Row(
                  children: [
                    Icon(
                      Icons.school_outlined,
                      color: UIGuide.light_Purple,
                    ),
                    Text(
                      "  Academic Performance",
                      style: TextStyle(
                          color: UIGuide.light_Purple,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () async {
                  //  value.getTimetable(widget.stud.studentId.toString());
                  if (value.ttextension.toString() == '.pdf') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>  AdminTimeTableView(),
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  TimeTableviewAttachment()),
                    );
                  }
                },
                child: const Row(
                  children: [
                    Icon(Icons.timelapse, color: UIGuide.light_Purple),
                    Text(
                      "  Class TimeTable",
                      style: TextStyle(
                          color: UIGuide.light_Purple,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    ));
  }

  _makingPhoneCall(String phn) async {
    var url = Uri.parse("tel:$phn");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
