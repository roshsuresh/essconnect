import 'package:essconnect/Application/AdminProviders/TimeTableStaff.dart';
import 'package:essconnect/Constants.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TeacherTimeTable extends StatelessWidget {
  TeacherTimeTable({Key? key}) : super(key: key);
  final sectionController = TextEditingController();
  final sectionController1 = TextEditingController();
  String? sectionId;
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var p = Provider.of<TimetableStaffProviders>(context, listen: false);
      p.sectionList.clear();
      p.stdReportSectionStaff();
    });
    return ListView(
      children: [
        kheight10,
        Row(
          children: [
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.49,
              child: Consumer<TimetableStaffProviders>(
                  builder: (context, snapshot, child) {
                return InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                              child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: snapshot.sectionList.isEmpty
                                      ? 0
                                      : snapshot.sectionList.length,
                                  itemBuilder: (context, index) {
                                    snapshot.removeSectionAll();
                                    return ListTile(
                                      selectedTileColor: Colors.blue.shade100,
                                      selectedColor: UIGuide.PRIMARY2,
                                      // selected:
                                      //     studReportinitvalues_stf![index],
                                      onTap: () async {
                                        sectionController.text =
                                            snapshot.sectionList[index].value ??
                                                '--';
                                        sectionController1.text =
                                            snapshot.sectionList[index].text ??
                                                '--';
                                        sectionId =
                                            sectionController.text.toString();

                                        // snapshot.addSelectedCourse(
                                        //     attendecourse![index]);
                                        print(sectionId);

                                        Navigator.of(context).pop();
                                      },
                                      title: Text(
                                        snapshot.sectionList[index].text ??
                                            '--',
                                        textAlign: TextAlign.center,
                                      ),
                                    );
                                  }),
                            ],
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
                            controller: sectionController1,
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Color.fromARGB(255, 238, 237, 237),
                              border: OutlineInputBorder(),
                              labelText: "Select Section",
                              hintText: "Section",
                            ),
                            enabled: false,
                          ),
                        ),
                        SizedBox(
                          height: 0,
                          child: TextField(
                            textAlign: TextAlign.center,
                            controller: sectionController,
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
              height: 40,
              width: MediaQuery.of(context).size.width * 0.40,
              child: MaterialButton(
                onPressed: () {},
                color: UIGuide.light_Purple,
                child: const Text(
                  'View',
                  style: TextStyle(color: UIGuide.WHITE),
                ),
              ),
            ),
            const Spacer()
          ],
        ),
      ],
    );
  }
}
