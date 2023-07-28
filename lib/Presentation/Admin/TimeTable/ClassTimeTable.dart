import 'package:essconnect/Application/AdminProviders/TimeTableProviders.dart';
import 'package:essconnect/Constants.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClassTimeTable extends StatefulWidget {
  ClassTimeTable({Key? key}) : super(key: key);

  @override
  State<ClassTimeTable> createState() => _ClassTimeTableState();
}

class _ClassTimeTableState extends State<ClassTimeTable> {
  String? divId;

  final divisionController = TextEditingController();

  final divisionController1 = TextEditingController();

  String? checkname;
  String? division;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var p = Provider.of<TimeTableClassProvidersAdmin>(context, listen: false);
      p.courselist.clear();
      p.getCourseList();
      p.clearList();
    });
    var size = MediaQuery.of(context).size;
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        kheight10,
        Row(
          children: [
            const Spacer(),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.49,
              child: Consumer<TimeTableClassProvidersAdmin>(
                  builder: (context, snapshot, child) {
                return InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                              child: Container(
                            child: LimitedBox(
                              maxHeight: size.height - 300,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: snapshot.courselist.length == null
                                      ? 0
                                      : snapshot.courselist.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      onTap: () async {
                                        divisionController.text = snapshot
                                                .courselist[index].courseId ??
                                            '--';
                                        divisionController1.text =
                                            snapshot.courselist[index].name ??
                                                '--';
                                        divId =
                                            divisionController.text.toString();

                                        snapshot.addSelectedCourse(
                                            snapshot.courselist[index]);
                                        print(divId);

                                        Navigator.of(context).pop();
                                      },
                                      title: Text(
                                        snapshot.courselist[index].name ?? '--',
                                        textAlign: TextAlign.center,
                                      ),
                                    );
                                  }),
                            ),
                          ));
                        });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 40,
                          child: TextField(
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: UIGuide.BLACK,
                                overflow: TextOverflow.clip),
                            textAlign: TextAlign.center,
                            controller: divisionController1,
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Color.fromARGB(255, 238, 237, 237),
                              border: OutlineInputBorder(),
                              labelText: "Select Course",
                              hintText: "Course",
                            ),
                            enabled: false,
                          ),
                        ),
                        SizedBox(
                          height: 0,
                          child: TextField(
                            style: const TextStyle(
                                fontSize: 0.0, height: 0, color: Colors.black),
                            textAlign: TextAlign.center,
                            controller: divisionController,
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
            Spacer(),
            SizedBox(
                height: 40,
                width: MediaQuery.of(context).size.width * 0.40,
                child: MaterialButton(
                  onPressed: () async {
                    await Provider.of<TimeTableClassProvidersAdmin>(context,
                            listen: false)
                        .clearList();
                    await Provider.of<TimeTableClassProvidersAdmin>(context,
                            listen: false)
                        .viewTimeTable(divId.toString());
                  },
                  child: const Text(
                    'View',
                    style: TextStyle(color: UIGuide.WHITE),
                  ),
                  color: UIGuide.light_Purple,
                )),
            Spacer(),
          ],
        ),
        kheight20,
        LimitedBox(
          maxHeight: size.height - 200,
          child: Consumer<TimeTableClassProvidersAdmin>(
            builder: (context, value, child) => ListView.builder(
                shrinkWrap: true,
                itemCount:
                    value.viewlist.length == null ? 0 : value.viewlist.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      width: size.width,
                      height: 125,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 227, 232, 248),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            kheight10,
                            Row(
                              children: [
                                const Text(
                                  'Division : ',
                                  style: TextStyle(fontSize: 15),
                                ),
                                Text(
                                  value.viewlist[index].text.toString(),
                                  overflow: TextOverflow.clip,
                                  maxLines: 2,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      color: UIGuide.light_Purple,
                                      fontWeight: FontWeight.w500),
                                ),
                                kWidth
                              ],
                            ),
                            kheight10,
                            Row(
                              children: [
                                const Text(
                                  'Upload File : ',
                                  style: TextStyle(fontSize: 15),
                                ),
                                // Text(
                                //   'Selected Division ',
                                //   overflow: TextOverflow.clip,
                                //   maxLines: 2,
                                //   style: TextStyle(
                                //       fontSize: 15,
                                //       color: UIGuide.light_Purple,
                                //       fontWeight: FontWeight.w500),
                                // )
                                SizedBox(
                                  width: 120,
                                  child: MaterialButton(
                                    child: Text(checkname == null
                                        ? 'Choose File'
                                        : checkname.toString()),
                                    color: Colors.white70,
                                    onPressed: (() async {
                                      final result = await FilePicker.platform
                                          .pickFiles(
                                              type: FileType.custom,
                                              allowMultiple: true,
                                              allowedExtensions: [
                                            'png',
                                            'jpeg',
                                            'jpg',
                                            'pdf'
                                          ]);
                                      if (result == null) {
                                        return;
                                      }
                                      final file = result.files.first;
                                      print('Name: ${file.name}');
                                      print('Path: ${file.path}');
                                      print('Extension: ${file.extension}');
                                      await Provider.of<
                                                  TimeTableClassProvidersAdmin>(
                                              context,
                                              listen: false)
                                          .timeTableImageSave(
                                              file.path.toString());

                                      if (file.name.length >= 6) {
                                        setState(() {
                                          checkname = file.name.replaceRange(
                                              6, file.name.length, '');
                                        });

                                        print(checkname);
                                      }
                                    }),
                                  ),
                                ),
                                Spacer(),
                                Consumer<TimeTableClassProvidersAdmin>(
                                  builder: (context, value, child) =>
                                      GestureDetector(
                                    onTap: () async {
                                      division =
                                          await value.viewlist[index].value;
                                      String attachment =
                                          await value.id.toString();
                                      await Provider.of<
                                                  TimeTableClassProvidersAdmin>(
                                              context,
                                              listen: false)
                                          .timetableSave(context,
                                              division.toString(), attachment);
                                    },
                                    child: const Icon(
                                      Icons.file_upload_outlined,
                                      color: UIGuide.light_Purple,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                const Icon(
                                  Icons.visibility_outlined,
                                  color: UIGuide.light_Purple,
                                ),
                                const Spacer(),

                                const Icon(
                                  Icons.delete_forever_outlined,
                                  color: Colors.red,
                                ),
                              ],
                            ),
                            kheight20,
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
        )
      ],
    );
  }
}
