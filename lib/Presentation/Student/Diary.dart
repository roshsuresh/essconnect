import 'package:essconnect/Application/StudentProviders/DiaryProviders.dart';
import 'package:essconnect/utils/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../Constants.dart';
import '../../utils/TextWrap(moreOption).dart';
import '../../utils/constants.dart';

class Diary extends StatelessWidget {
  const Diary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var p = Provider.of<DiaryProvidersstud>(context, listen: false);
      await p.clearDiary();
      await p.getDiaryList();
    });

    var size = MediaQuery.of(context).size;

    var width = size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Diary',
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
      body: Consumer<DiaryProvidersstud>(
        builder: (_, value, child) {
          return value.loading
              ? spinkitLoader()
              : value.diarylist.isEmpty
                  ? Container(
                      child: LottieBuilder.network(
                          'https://assets2.lottiefiles.com/private_files/lf30_lkquf6qz.json'),
                    )
                  : AnimationLimiter(
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        itemCount: value.diarylist.isEmpty
                            ? 0
                            : value.diarylist.length,
                        itemBuilder: (BuildContext context, int index) {
                          String finalCreatedDate = "";

                          if (value.diarylist[index].remarksDate != null) {
                            String createddate =
                                value.diarylist[index].remarksDate ?? '--';
                            DateTime parsedDateTime =
                                DateTime.parse(createddate);
                            finalCreatedDate = DateFormat('dd/MMM/yyyy')
                                .format(parsedDateTime);
                          }

                          return AnimationConfiguration.staggeredList(
                            position: index,
                            delay: const Duration(milliseconds: 100),
                            child: SlideAnimation(
                              duration: const Duration(milliseconds: 2500),
                              curve: Curves.fastLinearToSlowEaseIn,
                              child: FadeInAnimation(
                                curve: Curves.fastLinearToSlowEaseIn,
                                duration: const Duration(milliseconds: 2500),
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Container(
                                        width: width,
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 234, 234, 236),
                                          border: Border.all(
                                              color: UIGuide.light_Purple),
                                          borderRadius: const BorderRadius.only(
                                            topRight: Radius.circular(20),
                                            bottomLeft: Radius.circular(20),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Container(
                                            width: width,
                                            decoration: const BoxDecoration(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(5),
                                              ),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: Row(
                                                    children: [
                                                      //  kWidth,
                                                      const Text('📒  '),
                                                      Flexible(
                                                        child: RichText(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          strutStyle:
                                                              const StrutStyle(
                                                                  fontSize:
                                                                      15.0),
                                                          text: TextSpan(
                                                            style: const TextStyle(
                                                                color: UIGuide
                                                                    .light_Purple,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                            text: value
                                                                        .diarylist[
                                                                            index]
                                                                        .category ==
                                                                    null
                                                                ? '--'
                                                                : value
                                                                    .diarylist[
                                                                        index]
                                                                    .category
                                                                    .toString(),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: TextWrapper(
                                                    text: value.diarylist[index]
                                                                .remarks ==
                                                            null
                                                        ? '--'
                                                        : value.diarylist[index]
                                                            .remarks
                                                            .toString(),
                                                    fSize: 14,
                                                  ),
                                                ),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    const Spacer(),
                                                    Text(
                                                      finalCreatedDate
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.grey),
                                                    ),
                                                    kWidth,
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
        },
      ),
    );
  }
}
