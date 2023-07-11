import 'package:essconnect/Application/AdminProviders/ChatProviders.dart';
import 'package:essconnect/Constants.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // List<types.Message> _messages = [];
  // final _user = const types.User(id: '82091008-a484-4a89-ae75-a22bf8d6f3ac');

  // @override
  // void initState() {
  //   super.initState();
  //   _loadMessages();
  // }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var p = Provider.of<ChatProviders>(context, listen: false);
      p.currentList.clear();
      await p.chatViewList();
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: UIGuide.light_Purple,
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
            const CircleAvatar(
              radius: 20,
              backgroundColor: Colors.grey,
              backgroundImage: NetworkImage(
                  'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80'),
            ),
            kWidth,
            SizedBox(
                width: size.width / 1.6,
                child: const Text(
                  'ABRAHAM LINKON',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                )),
          ],
        ),
      ),
      body: Consumer<ChatProviders>(
        builder: (context, value, child) {
          return Column(
            children: [
              Expanded(
                child: LimitedBox(
                  maxHeight: size.height - 100,
                  child: ListView.builder(
                    itemCount: value.currentList.length,
                    shrinkWrap: true,
                    reverse: true,
                    itemBuilder: (ctx, index) {
                      print(value.currentList.length);
                      print(value.currentList[index].chats![1].messages
                          .toString());
                      // if (index.isEven) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              constraints:
                                  BoxConstraints(maxWidth: size.width / 1.3),
                              // width: size.width / 1.3,
                              decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 191, 191, 194),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                      bottomRight: Radius.circular(20))),
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Text(value
                                    .currentList[index].chats![1].messages
                                    .toString()),
                              ),
                            ),
                            const Spacer()
                          ],
                        ),
                      );
                      // }
                      // return Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Row(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     mainAxisAlignment: MainAxisAlignment.start,
                      //     children: [
                      //       const Spacer(),
                      //       Container(
                      //         constraints:
                      //             BoxConstraints(maxWidth: size.width / 1.3),
                      //         decoration: const BoxDecoration(
                      //             color: Color.fromARGB(255, 232, 232, 235),
                      //             borderRadius: BorderRadius.only(
                      //                 topLeft: Radius.circular(20),
                      //                 topRight: Radius.circular(20),
                      //                 bottomLeft: Radius.circular(20))),
                      //         child: const Padding(
                      //           padding: EdgeInsets.all(6.0),
                      //           child: Text(
                      //               ' userAvatarImageBa ckgroun dColor: UIGuide.PRIMARY, userAvatarIm ageBackgr oundColor: UIGuide.PRIMARY,'),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // );
                    },
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 40,
                        child: TextFormField(
                          cursorColor: Colors.black54,
                          cursorWidth: 1,
                          cursorHeight: 20,
                          autocorrect: false,
                          textAlign: TextAlign.start,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(10),
                            fillColor: const Color.fromARGB(255, 74, 75, 75),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black54, width: 1.0),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black54, width: 1.0),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            border: const OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.black54,
                            )),
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.send)),
                  const SizedBox(
                    width: 5,
                  )
                ],
              )
            ],
          );
        },
      ),

      // Chat(
      //   theme: const DefaultChatTheme(
      //       userAvatarImageBackgroundColor: UIGuide.PRIMARY,
      //       primaryColor: Colors.blue,
      //       inputBorderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      //       deliveredIcon: Icon(Icons.mark_chat_read_outlined),
      //       inputBackgroundColor: UIGuide.light_Purple,
      //       backgroundColor: Colors.white10),

      //   messages: _messages,
      //   //  onAttachmentPressed: _handleAttachmentPressed,
      //   //  onMessageTap: _handleMessageTap,
      //   //onPreviewDataFetched: _handlePreviewDataFetched,
      //   onSendPressed: _handleSendPressed,
      //   showUserAvatars: true,
      //   showUserNames: true,
      //   user: _user,
      // ),
    );
  }

  // void _addMessage(types.Message message) {
  //   setState(() {
  //     _messages.insert(0, message);
  //   });
  // }

  // void _handleSendPressed(types.PartialText message) {
  //   final textMessage = types.TextMessage(
  //     author: _user,
  //     createdAt: DateTime.now().millisecondsSinceEpoch,
  //     id: const Uuid().v4(),
  //     text: message.text,
  //   );

  //   _addMessage(textMessage);
  // }

  // void _loadMessages() async {
  //   final response = await rootBundle.loadString('assets/messages.json');
  //   final messages = (jsonDecode(response) as List)
  //       .map((e) => types.Message.fromJson(e as Map<String, dynamic>))
  //       .toList();

  //   setState(() {
  //     _messages = messages;
  //   });
  // }
}
