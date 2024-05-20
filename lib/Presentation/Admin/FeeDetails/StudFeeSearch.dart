import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:essconnect/Application/AdminProviders/FeeDetailsProvider.dart';
import 'package:essconnect/Presentation/Admin/FeeDetails/StudFeeDetails.dart';
import 'package:essconnect/utils/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Constants.dart';
import '../../../utils/constants.dart';

class StudentFeeSearch extends StatefulWidget {
  const StudentFeeSearch({Key? key}) : super(key: key);

  @override
  State<StudentFeeSearch> createState() => _StudentFeeSearchState();
}

class _StudentFeeSearchState extends State<StudentFeeSearch> {
  final textControllerr = TextEditingController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var p = Provider.of<FeeDetailsProvider>(context, listen: false);
      p.clearStudentList();
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Fee Report'),
        titleSpacing: 20.0,
        centerTitle: true,
        toolbarHeight: 50.2,
        toolbarOpacity: 0.8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
        ),
        backgroundColor: UIGuide.light_Purple,
      ),
      body: Column(
        // physics: const BouncingScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8),
            child: AnimSearchBar(
              width: size.width,
              textController: textControllerr,
              helpText: 'Enter student name...',
              color: UIGuide.THEME_LIGHT,
              autoFocus: false,
              animationDurationInMilli: 900,
              closeSearchOnSuffixTap: false,
              suffixIcon: const Icon(
                Icons.search_sharp,
                color: UIGuide.light_Purple,
              ),
              onSuffixTap: () async {
                print('object');

                Provider.of<FeeDetailsProvider>(context, listen: false)
                    .clearStudentList();
                Provider.of<FeeDetailsProvider>(context, listen: false)
                    .getSearchView(textControllerr.text.toString());
                print(textControllerr.text.toString());
              },
              onSubmitted: (String s) async {
                print('Str $s');

                Provider.of<FeeDetailsProvider>(context, listen: false)
                    .clearStudentList();
                Provider.of<FeeDetailsProvider>(context, listen: false)
                    .getSearchView(textControllerr.text.toString());
                print(textControllerr.text.toString());
              },
            ),
          ),
          Expanded(
            //   maxHeight: size.height - 210,
            child: Consumer<FeeDetailsProvider>(
                builder: (context, provider, child) {
              return provider.loading
                  ? Center(child: spinkitLoader())
                  : Scrollbar(
                      child: ListView.builder(
                        // physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: provider.searchStudent.isEmpty
                            ? 0
                            : provider.searchStudent.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              kheight10,
                              GestureDetector(
                                onTap: () async {
                                  await Provider.of<FeeDetailsProvider>(context,
                                          listen: false)
                                      .generalDueListClear();
                                  String id =
                                      provider.searchStudent[index].studentId ??
                                          '---';
                                  String name =
                                      provider.searchStudent[index].name ??
                                          '---';
                                  String rollno =
                                      provider.searchStudent[index].rollNo ==
                                              null
                                          ? '---'
                                          : provider.searchStudent[index].rollNo
                                              .toString();
                                  String division = provider
                                              .searchStudent[index].division ==
                                          null
                                      ? '---'
                                      : provider.searchStudent[index].division
                                          .toString();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => StudFeeDetails(
                                              studid: id,
                                              name: name,
                                              roll: rollno,
                                              division: division,
                                            )),
                                  );
                                },
                                child: Container(
                                  width: size.width - 15,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: UIGuide.light_black),
                                      color: const Color.fromARGB(255, 248, 248, 248),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      kWidth,
                                      Center(
                                        child: Container(
                                          width: 40,
                                          height: 40,
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
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 13),
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
                                                        color: Colors.black,
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
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 13),
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
                                                          fontWeight:
                                                              FontWeight.w500,
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
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 13),
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
                      ),
                    );
            }),
          )
        ],
      ),
    );
  }
}
