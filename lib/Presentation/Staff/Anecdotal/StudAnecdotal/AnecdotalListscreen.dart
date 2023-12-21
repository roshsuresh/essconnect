import 'package:essconnect/utils/constants.dart';
import 'package:flutter/material.dart';

class AnectdotalListScreen extends StatelessWidget {
  const AnectdotalListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: ListView.builder(
            itemCount: 3,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  height: 100,
                  padding: EdgeInsets.only(left: 6),
                  width: size.width,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 238, 238, 238),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(children: [
                    Row(
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Text("Date : "),
                                Text(
                                  "12-545",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: UIGuide.light_Purple),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text("Date : "),
                                Text(
                                  "12-545",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: UIGuide.light_Purple),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ]),
                ),
              );
            }));
  }
}
