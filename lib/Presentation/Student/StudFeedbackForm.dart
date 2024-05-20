import 'package:essconnect/Constants.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StudFeedbackFormScreen extends StatefulWidget {
  const StudFeedbackFormScreen({super.key});

  @override
  State<StudFeedbackFormScreen> createState() => _StudFeedbackFormScreenState();
}

class _StudFeedbackFormScreenState extends State<StudFeedbackFormScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Feedback Form'),
          titleSpacing: 00.0,
          centerTitle: true,
          toolbarHeight: 60.2,
          toolbarOpacity: 0.8,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
          ),
          backgroundColor: UIGuide.light_Purple,
        ),
        body: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      border: Border.all(color: UIGuide.light_Purple),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "✱ ",
                            style: TextStyle(
                                color: UIGuide.light_Purple,
                                fontWeight: FontWeight.w600),
                          ),
                          Expanded(
                            child: Text(
                              "Reloaded 2 of 3373 libraries in 172,965ms (compile: 81 ms, reload: 1376 ms, reassemble: 1532 ms).",
                              style: TextStyle(
                                  color: UIGuide.light_Purple,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                      kheight10,
                      kheight5,
                      GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(0),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing: 8.0,
                                  mainAxisSpacing: 8.0,
                                  crossAxisCount: 2,
                                  childAspectRatio: 3),
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    width: size.width * 0.4,
                                    padding: const EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                        color: UIGuide.WHITE,
                                        border: Border.all(
                                            color: const Color.fromARGB(
                                                255, 190, 190, 190)),
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            topRight: Radius.circular(8))),
                                    child: const Text(
                                      "Teacher Name",
                                      style: TextStyle(
                                        fontSize: 10,
                                      ),
                                      maxLines: 1,
                                    )),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: size.width * 0.30,
                                      height: 40,
                                      child: TextField(
                                        textInputAction: TextInputAction.next,
                                        // controller: teMarkController[index],

                                        cursorColor: UIGuide.light_Purple,

                                        keyboardType: const TextInputType
                                            .numberWithOptions(decimal: true),
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                            RegExp(r'^[0-9.]$|^\d+\.?\d{0,2}$'),
                                          ),
                                          TextInputFormatter.withFunction(
                                            (oldValue, newValue) {
                                              try {
                                                final text = newValue.text;
                                                if (text.isNotEmpty) {
                                                  double.parse(text);
                                                }
                                                return newValue;
                                              } catch (e) {}
                                              return oldValue;
                                            },
                                          ),
                                          LengthLimitingTextInputFormatter(5),
                                        ],
                                        decoration: const InputDecoration(
                                            contentPadding: EdgeInsets.only(
                                                bottom: 2, left: 6),
                                            focusColor: Color.fromARGB(
                                                255, 213, 215, 218),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  bottomLeft:
                                                      Radius.circular(10)),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: UIGuide.light_Purple,
                                                  width: 1.0),
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  bottomLeft:
                                                      Radius.circular(10)),
                                            ),
                                            fillColor: Colors.grey,
                                            hintStyle: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 16,
                                              fontFamily: "verdana_regular",
                                              fontWeight: FontWeight.w400,
                                            ),
                                            hintText: "Enter Mark"),
                                        onChanged: (value1) {
                                          // if (double.parse(
                                          //         teMarkController[
                                          //                 index]
                                          //             .text) >
                                          //     double.parse(value
                                          //         .teMax
                                          //         .toString())) {
                                          //   teMarkController[
                                          //           index]
                                          //       .clear();
                                          // }
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      height: 40,
                                      width: size.width * 0.16,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 221, 220, 220),
                                          border: Border.all(
                                              color: const Color.fromARGB(
                                                  255, 180, 182, 184),
                                              width: 1.5),
                                          borderRadius: const BorderRadius.only(
                                            topRight: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
                                          ),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            "ENG",
                                            style: TextStyle(
                                                color: UIGuide.light_Purple,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            );
                          }),
                    ],
                  ),
                ),
              );
            }));
  }
}
