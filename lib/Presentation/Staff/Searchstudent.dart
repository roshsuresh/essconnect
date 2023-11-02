import 'dart:async';
import 'package:essconnect/Application/Staff_Providers/SearchProvider.dart';
import 'package:essconnect/Constants.dart';
import 'package:essconnect/Debouncer.dart';
import 'package:essconnect/Domain/Staff/SearchStudReport.dart';
import 'package:essconnect/Domain/Staff/StudentReport_staff.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:essconnect/utils/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchStudent_stf extends StatefulWidget {
  SearchStudent_stf({Key? key}) : super(key: key);

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
    return SafeArea(
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

class StudProfileViewBySearch_Staff extends StatelessWidget {
  ViewStudentReport stud;
  StudProfileViewBySearch_Staff({
    Key? key,
    required this.stud,
  }) : super(key: key);

  String? phn;
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

    return SafeArea(
        child: Scaffold(
      body: Consumer<Screen_Search_Providers>(
        builder: (context, value, child) => ListView(
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
                            stud.name ?? '---',
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
                              Text(stud.division ?? '---',
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
                                            stud.rollNo == null
                                                ? '---'
                                                : stud.rollNo.toString(),
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
                                        Text(stud.admnNo ?? '---',
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
                          stud.studentPhoto ??
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
                        color: Colors.grey, // Shadow color
                        offset: Offset(0, 4), // Offset of the shadow
                        blurRadius: 4, // Spread of the shadow
                        spreadRadius: 0, // Spread radius of the shadow
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
                              stud.address ?? '---',
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
                              stud.bus ?? '---',
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
                              stud.stop ?? '---',
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
                                phn = stud.mobNo ?? '---',
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
            )
          ],
        ),
      ),
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
