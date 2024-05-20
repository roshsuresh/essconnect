import 'package:essconnect/Application/Staff_Providers/StudentReportProvidersStaff.dart';
import 'package:essconnect/Constants.dart';
import 'package:essconnect/Debouncer.dart';
import 'package:essconnect/Presentation/Staff/Searchstudent.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:essconnect/utils/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchStudentByStaff extends StatefulWidget {
  const SearchStudentByStaff({Key? key}) : super(key: key);

  @override
  State<SearchStudentByStaff> createState() => _SearchStudentByStaffState();
}

class _SearchStudentByStaffState extends State<SearchStudentByStaff> {
  TextEditingController clearValue = TextEditingController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var p = Provider.of<StudentReportProviderStaff>(context, listen: false);
      p.setLoading(false);
      await p.initialClear();
      await p.getInitialList();

      List sectionL = p.sectionList.map((item) => item.value).toList();
      sectionId = sectionL.join(",");
      List courseL = p.initialCourseList.map((item) => item.value).toList();
      courseId = courseL.join(",");
      List divisionL = p.initialDivisionList.map((item) => item.value).toList();
      divisionId = divisionL.join(",");
    });
  }

  String sectionId = '';
  String courseId = '';
  String divisionId = '';
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
                            await Provider.of<StudentReportProviderStaff>(
                                    context,
                                    listen: false)
                                .searchStudentReportListStaff(
                                    sectionId, courseId, divisionId, value);
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
              child: Consumer<StudentReportProviderStaff>(
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
                if (provider.viewStudReportListt.isEmpty) {
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
                        itemCount: provider.viewStudReportListt.isEmpty
                            ? 0
                            : provider.viewStudReportListt.length,
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
                                              stud: provider
                                                  .viewStudReportListt[index],
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
                                                          .viewStudReportListt[
                                                              index]
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
                                                              .viewStudReportListt[
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
                                                                .viewStudReportListt[
                                                                    index]
                                                                .rollNo ==
                                                            null
                                                        ? '---'
                                                        : provider
                                                            .viewStudReportListt[
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
                                                                .viewStudReportListt[
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
                                                            .viewStudReportListt[
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
                                                            .viewStudReportListt[
                                                                index]
                                                            .mobNo ==
                                                        null
                                                    ? '--'
                                                    : provider
                                                        .viewStudReportListt[
                                                            index]
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
                                                              .viewStudReportListt[
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
