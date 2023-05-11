import 'package:essconnect/Application/AdminProviders/FlashNewsProviders.dart';
import 'package:essconnect/Constants.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FlashNewsUpload extends StatefulWidget {
  FlashNewsUpload({Key? key}) : super(key: key);

  @override
  State<FlashNewsUpload> createState() => _FlashNewsUploadState();
}

class _FlashNewsUploadState extends State<FlashNewsUpload> {
  String? datee;

  DateTime? _mydatetimeFrom;

  DateTime? _mydatetimeTo;

  String time = '🗓️';

  String timeNow = '🗓️';

  final titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    datee = DateFormat('dd/MMM/yyyy').format(DateTime.now());

    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
                elevation: 5,
                minWidth: size.width / 2.4,
                color: Colors.white70,
                child: Text('🗓️  Date: ${datee.toString()}'),
                onPressed: () async {
                  return;
                }),
          ],
        ),
        kheight20,
        Padding(
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
                borderSide:
                    const BorderSide(color: UIGuide.light_Purple, width: 1.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
          ),
        ),
        kheight20,
        kheight10,
        Row(
          children: [
            Spacer(),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: UIGuide.light_Purple, width: 1),
                  borderRadius: BorderRadius.circular(5)),
              width: size.width * .45,
              height: 35,
              child: MaterialButton(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),

                //minWidth: size.width - 216,
                color: Colors.white,
                onPressed: (() async {
                  _mydatetimeFrom = await showDatePicker(
                    context: context,
                    initialDate: _mydatetimeFrom ?? DateTime.now(),
                    firstDate: DateTime.now().subtract(const Duration(days: 0)),
                    lastDate: DateTime(2030),
                    builder: (context, child) {
                      return Theme(
                          data: ThemeData.light().copyWith(
                            primaryColor: UIGuide.light_Purple,
                            colorScheme: const ColorScheme.light(
                              primary: UIGuide.light_Purple,
                            ),
                            buttonTheme: const ButtonThemeData(
                                textTheme: ButtonTextTheme.primary),
                          ),
                          child: child!);
                    },
                  );
                  setState(() {
                    time = DateFormat('dd/MMM/yyyy').format(_mydatetimeFrom!);
                    print(time);
                  });
                }),
                child: Center(child: Text('From  $time')),
              ),
            ),
            const Spacer(),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: UIGuide.light_Purple, width: 1),
                  borderRadius: BorderRadius.circular(5)),
              width: size.width * .45,
              height: 35,
              child: MaterialButton(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
                minWidth: size.width - 216,
                color: Colors.white,
                onPressed: (() async {
                  _mydatetimeTo = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now().subtract(const Duration(days: 0)),
                    lastDate: DateTime(2100),
                    builder: (context, child) {
                      return Theme(
                          data: ThemeData.light().copyWith(
                            primaryColor: UIGuide.light_Purple,
                            colorScheme: const ColorScheme.light(
                              primary: UIGuide.light_Purple,
                            ),
                            buttonTheme: const ButtonThemeData(
                                textTheme: ButtonTextTheme.primary),
                          ),
                          child: child!);
                    },
                  );

                  setState(() {
                    timeNow = DateFormat('dd/MMM/yyyy').format(_mydatetimeTo!);
                    print(timeNow);
                  });
                }),
                child: Center(child: Text('To  $timeNow')),
              ),
            ),
            Spacer()
          ],
        ),
        kheight20,
        kheight10,
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
                  } else {
                    await Provider.of<FlashNewsProviderAdmin>(context,
                            listen: false)
                        .flashNewsUpload(
                            context,
                            datee.toString(),
                            time.toString(),
                            timeNow.toString(),
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
    );
  }
}
