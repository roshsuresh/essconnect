import 'package:essconnect/Application/AdminProviders/chatProviders.dart';
import 'package:essconnect/Constants.dart';
import 'package:essconnect/Presentation/Admin/Chat/ChatPage.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatSearch extends StatelessWidget {
  ChatSearch({Key? key}) : super(key: key);
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Consumer<ChatProviders>(builder: (context, search, child) {
          return Column(
            children: [
              TextField(
                controller: searchController,
                onChanged: (value) {},
                decoration: const InputDecoration(
                    labelText: "Search",
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: search.initialList.length,
                  itemBuilder: ((context, index) {
                    return Padding(
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
                                            search.initialList[index].name ??
                                                '--',
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: UIGuide.light_Purple),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        ),

                                        // SizedBox(
                                        //   height: 20,
                                        //   width: size.width / 1.6,
                                        //   child: Text(
                                        //     contact.contactList[index]
                                        //             .receiveUserRole ??
                                        //         '--',
                                        //     style:
                                        //         TextStyle(color: Colors.grey),
                                        //     overflow: TextOverflow.ellipsis,
                                        //     maxLines: 1,
                                        //   ),
                                        // ),
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
                        ));
                  }))
            ],
          );
        }),
      ),
    );
  }
}
