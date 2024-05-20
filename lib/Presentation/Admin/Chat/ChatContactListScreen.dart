import 'package:essconnect/Application/AdminProviders/ChatProviders.dart';
import 'package:essconnect/Constants.dart';
import 'package:essconnect/Presentation/Admin/Chat/ChatPage.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';

class ChatContactListScreen extends StatefulWidget {
  const ChatContactListScreen({Key? key}) : super(key: key);

  @override
  State<ChatContactListScreen> createState() => _ChatContactListScreenState();
}

class _ChatContactListScreenState extends State<ChatContactListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var p = Provider.of<ChatProviders>(context, listen: false);
      // await p.clearcontactList();
      // p.currentList.clear();
      await p.getChatcontactList();
      await p.chatViewList();
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: UIGuide.light_Purple,
        title: const Text('Contacts'),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
        ),
      ),
      body: Consumer<ChatProviders>(
        builder: (context, contact, child) => Scrollbar(
          child: AnimationLimiter(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              itemCount:
                  contact.contactList.isEmpty ? 0 : contact.contactList.length,
              shrinkWrap: false,
              itemBuilder: (BuildContext context, int index) {
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
                                        builder: (context) => const ChatPage()));
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
                                            'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80'),
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
                                                contact.contactList[index]
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
                                                contact.contactList[index]
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
                                      const SizedBox(
                                        height: 60,
                                        width: 50,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Yesterday',
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 117, 117, 117),
                                                  fontSize: 10),
                                            ),
                                            SizedBox(
                                              height: 3,
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
        ),
      ),
    );
  }
}
