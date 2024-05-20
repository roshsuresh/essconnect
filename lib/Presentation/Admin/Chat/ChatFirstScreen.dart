import 'package:badges/badges.dart' as badges;
import 'package:essconnect/Application/AdminProviders/ChatProviders.dart';
import 'package:essconnect/Constants.dart';
import 'package:essconnect/Presentation/Admin/Chat/ChatContactListScreen.dart';
import 'package:essconnect/Presentation/Admin/Chat/ChatPage.dart';
import 'package:essconnect/Presentation/Admin/Chat/ChatSearch.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';

class ChatFirstScreen extends StatefulWidget {
  const ChatFirstScreen({Key? key}) : super(key: key);

  @override
  State<ChatFirstScreen> createState() => _ChatFirstScreenState();
}

class _ChatFirstScreenState extends State<ChatFirstScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var p = Provider.of<ChatProviders>(context, listen: false);
      await p.clearinitialList();
      await p.getChatInitialList();
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 18,
                  )),
              kWidth,
              const Text(
                'Chat',
                // style: GoogleFonts.notoSansBamum(
                //     textStyle: const TextStyle(
                //   fontSize: 25,
                //   fontWeight: FontWeight.w600,
                // )),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ChatSearch()));
                },
                iconSize: 29,
                icon: const Icon(Icons.search_outlined),
                splashColor: UIGuide.THEME_LIGHT,
              ),
              kWidth,
              IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ChatContactListScreen()));
                },
                icon: const Icon(Icons.chat_bubble_outline_rounded),
                splashColor: UIGuide.THEME_LIGHT,
              ),
              kWidth
            ],
          ),
          titleSpacing: 00.0,
          toolbarHeight: 65,
          toolbarOpacity: 0.8,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(25),
                bottomLeft: Radius.circular(25)),
          ),
          backgroundColor: UIGuide.light_Purple,
        ),
        body: Consumer<ChatProviders>(
          builder: (context, initial, child) => AnimationLimiter(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              itemCount:
                  initial.initialList.isEmpty ? 0 : initial.initialList.length,
              shrinkWrap: false,
              itemBuilder: (BuildContext context, int index) {
                int countt = initial.initialList[index].unreadMessageCount ?? 0;
                return AnimationConfiguration.staggeredList(
                  position: index,
                  delay: const Duration(milliseconds: 100),
                  child: SlideAnimation(
                    duration: const Duration(milliseconds: 2500),
                    curve: Curves.fastLinearToSlowEaseIn,
                    child: FadeInAnimation(
                        curve: Curves.fastLinearToSlowEaseIn,
                        duration: const Duration(milliseconds: 2500),
                        child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ChatPage()));
                              },
                              child: Container(
                                height: 70,
                                width: size.width,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black12),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: Row(
                                    children: [
                                      kWidth,
                                      const CircleAvatar(
                                        radius: 25,
                                        backgroundColor: Colors.white,
                                        backgroundImage: NetworkImage(
                                          'https://icons-for-free.com/iconfiles/png/512/profile+profile+page+user+icon-1320186864367220794.png',
                                        ),
                                      ),
                                      kWidth,
                                      kWidth,
                                      Center(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 20,
                                              width: size.width / 2.5,
                                              child: Text(
                                                initial.initialList[index]
                                                        .name ??
                                                    '--',
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        UIGuide.light_Purple),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                              width: size.width / 1.6,
                                              child: Text(
                                                initial.initialList[index]
                                                        .receiveUserRole ??
                                                    '--',
                                                style: const TextStyle(
                                                    color: Colors.grey),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      const Spacer(),
                                      SizedBox(
                                        height: 60,
                                        width: 60,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              initial.initialList[index]
                                                      .lastChatTime ??
                                                  '--',
                                              style: const TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 117, 117, 117),
                                                  fontSize: 10),
                                            ),
                                            const SizedBox(
                                              height: 3,
                                            ),
                                            SizedBox(
                                              height: 20,
                                              width: 33,
                                              child: badges.Badge(
                                                showBadge: countt == 0
                                                    ? false
                                                    : true,
                                                badgeAnimation: const badges
                                                    .BadgeAnimation.rotation(
                                                  animationDuration:
                                                      Duration(seconds: 1),
                                                  colorChangeAnimationDuration:
                                                      Duration(seconds: 1),
                                                  loopAnimation: false,
                                                  curve: Curves.fastOutSlowIn,
                                                  colorChangeAnimationCurve:
                                                      Curves.easeInCubic,
                                                ),
                                                badgeContent: Center(
                                                  child: Text(
                                                    countt.toString(),
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                badgeStyle:
                                                    const badges.BadgeStyle(
                                                        shape: badges
                                                            .BadgeShape.square,
                                                        badgeColor:
                                                            UIGuide.THEME_LIGHT,
                                                        // UIGuide.light_Purple,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20))),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ))),
                  ),
                );
              },
            ),
          ),
        ));
  }
}
