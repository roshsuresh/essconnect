import 'package:essconnect/Application/Staff_Providers/TextSMS_ToGuardian.dart';
import 'package:essconnect/Constants.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Text_Matter_SMS extends StatelessWidget {
  Text_Matter_SMS({Key? key}) : super(key: key);

  final smsFormats = TextEditingController();
  final smsFormats1 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send SMS'),
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
      body: ListView(
        children: [
          kheight20,
          Row(
            children: [
              kWidth,
              SizedBox(
                // decoration: BoxDecoration(
                //   borderRadius: BorderRadius.circular(10.0),
                //   //  color: UIGuide.light_Purple,
                //   border: Border.all(
                //       color: UIGuide.light_Purple,
                //       width: 1.0,
                //       style: BorderStyle.solid),
                // ),
                height: 42,
                width: MediaQuery.of(context).size.width * 0.45,
                child: Consumer<TextSMS_ToGuardian_Providers>(
                    builder: (context, snapshot, child) {
                  // attachmentid = snapshot.id ?? '';
                  return InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                                child: Container(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: LimitedBox(
                                  maxHeight: size.height - 300,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: snapshot.formatlist.length,
                                      itemBuilder: (context, index) {
                                        // print(snapshot.attendenceInitialValues.length);// value.removeCourseAll();
                                        return ListTile(
                                          selectedTileColor:
                                              const Color.fromARGB(
                                                  255, 15, 104, 177),

                                          // selected: snapshot.isFormatSelected(
                                          //     snapshot.smsFormats[index]),
                                          onTap: () async {
                                            smsFormats.text = snapshot
                                                    .formatlist[index].value ??
                                                '--';

                                            print(smsFormats.text);
                                            smsFormats1.text = snapshot
                                                    .formatlist[index]
                                                    .text ??
                                                '--';

                                            Navigator.of(context).pop();
                                          },
                                          title: Text(
                                            snapshot.formatlist[index]
                                                    .text ??
                                                '--',
                                            textAlign: TextAlign.center,
                                          ),
                                        );
                                      }),
                                ),
                              ),
                            ));
                          });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 40,
                            child: TextField(
                              textAlign: TextAlign.center,
                              controller: smsFormats1,
                              decoration: InputDecoration(
                                filled: true,
                                focusColor:
                                    const Color.fromARGB(255, 213, 215, 218),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: UIGuide.light_Purple, width: 1.0),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                fillColor:
                                    const Color.fromARGB(255, 238, 237, 237),
                                labelText: "Select SMS Formats",
                                hintText: "SMS Formats",
                              ),
                              enabled: false,
                            ),
                          ),
                          Container(
                            height: 0,
                            width: 0,
                            child: TextField(
                              textAlign: TextAlign.center,
                              controller: smsFormats,
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Color.fromARGB(255, 238, 237, 237),
                                border: OutlineInputBorder(),
                                labelText: "",
                                hintText: "",
                              ),
                              enabled: false,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
              const Spacer(),
              SizedBox(
                height: 38,
                width: MediaQuery.of(context).size.width * 0.30,
                child: MaterialButton(
                  onPressed: () {},
                  color: UIGuide.light_Purple,
                  child: const Text(
                    'Preview',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              kWidth,
              kWidth,
              kWidth,
              kWidth
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: SizedBox(
            width: 120,
            height: 50,
            child: MaterialButton(
              onPressed: () {},
              color: UIGuide.light_Purple,
              child: const Text(
                'Send',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
