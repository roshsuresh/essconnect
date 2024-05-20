import 'package:essconnect/Application/AdminProviders/FlashNewsProviders.dart';
import 'package:essconnect/Constants.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FlashNewsUpload extends StatefulWidget {
  const FlashNewsUpload({Key? key}) : super(key: key);

  @override
  State<FlashNewsUpload> createState() => _FlashNewsUploadState();
}

class _FlashNewsUploadState extends State<FlashNewsUpload> {
  String? datee;

  final titleController = TextEditingController();
  @override
  void initState() {
    super.initState();
    datee = DateFormat('dd/MMM/yyyy').format(DateTime.now());
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var p = Provider.of<FlashNewsProviderAdmin>(context, listen: false);
      await p.getVariables();
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Consumer<FlashNewsProviderAdmin>(
      builder: (context, val, _) => Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 3,
                    foregroundColor: UIGuide.BLACK,
                    disabledBackgroundColor:
                        const Color.fromARGB(255, 241, 241, 241),
                    padding: const EdgeInsets.all(0),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                          color: Color.fromARGB(255, 206, 206, 206)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: null,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10),
                    child: Text(
                      'Date: ${datee.toString()}',
                      style:
                          const TextStyle(color: UIGuide.BLACK, fontSize: 14),
                    ),
                  )),
            ],
          ),
          kheight10,
          SizedBox(
            height: 70,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: titleController,
                minLines: 1,
                inputFormatters: [LengthLimitingTextInputFormatter(80)],
                maxLines: 1,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  labelText: 'News*',
                  labelStyle: const TextStyle(color: UIGuide.light_Purple),
                  hintText: 'Enter News',
                  hintStyle: const TextStyle(color: Colors.grey),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: UIGuide.light_Purple, width: 1.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
              ),
            ),
          ),
          kheight20,
          Row(
            children: [
              kWidth,
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 3,
                    foregroundColor: UIGuide.light_Purple,
                    backgroundColor: UIGuide.ButtonBlue,
                    padding: const EdgeInsets.all(0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(
                          color: UIGuide.light_black,
                        )),
                  ),
                  onPressed: (() async {
                    await val.getFromDate(context);
                  }),
                  child: Center(
                      child: val.fromDateDis.isEmpty
                          ? const Text(
                              'From Date 🗓️ ',
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 13),
                            )
                          : Text("From ${val.fromDateDis}")),
                ),
              ),
              kWidth,
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 3,
                    foregroundColor: UIGuide.light_Purple,
                    backgroundColor: UIGuide.ButtonBlue,
                    padding: const EdgeInsets.all(0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(
                          color: UIGuide.light_black,
                        )),
                  ),
                  onPressed: (() async {
                    await val.getToDate(context);
                  }),
                  child: Center(
                      child: val.toDateDis.isEmpty
                          ? const Text(
                              'To Date 🗓️ ',
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 13),
                            )
                          : Text("To ${val.toDateDis}")),
                ),
              ),
              kWidth
            ],
          ),
          kheight20,
          Center(
            child: Consumer<FlashNewsProviderAdmin>(
              builder: (context, value, child) => SizedBox(
                width: size.width / 2.4,
                child: MaterialButton(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  color: UIGuide.light_Purple,
                  onPressed: (() async {
                    print(titleController);

                    if (titleController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                          'Enter Title..',
                          textAlign: TextAlign.center,
                        ),
                        duration: Duration(seconds: 1),
                      ));
                    } else if (val.fromDateDis.isEmpty ||
                        val.toDateDis.isEmpty) {
                      snackbarWidget(2, "Select mandatory fields...", context);
                    } else if (val.fromDateCheck.isAfter(val.toDateCheck)) {
                      snackbarWidget(
                          2, 'From date is greater than to date', context);
                    } else {
                      await val.flashNewsUpload(
                          context,
                          datee.toString(),
                          val.fromDateDis,
                          val.toDateDis,
                          titleController.text.toString());
                    }
                  }),
                  child: const Text(
                    'Save',
                    style: TextStyle(color: UIGuide.WHITE, fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
