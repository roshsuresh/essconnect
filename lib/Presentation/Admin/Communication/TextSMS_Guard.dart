import 'package:essconnect/Application/AdminProviders/SchoolPhotoProviders.dart';
import 'package:essconnect/Domain/Staff/StudentReport_staff.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';

class TextSMSGuardian extends StatelessWidget {
  TextSMSGuardian({Key? key}) : super(key: key);

  List subjectData = [];
  List diviData = [];
  List courseData = [];
  String course = '';

  String section = '';
  String division = '';

  String courseId = '';
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: ListView(
      children: [
        Row(
          children: [
            Consumer<SchoolPhotoProviders>(
              builder: (context, value, child) => Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  width: size.width * .42,
                  height: 50,
                  child: MultiSelectDialogField(
                    items: value.dropDown,
                    listType: MultiSelectListType.CHIP,
                    title: const Text(
                      "Select Section",
                      style: TextStyle(color: Colors.grey),
                    ),
                    selectedItemsTextStyle: const TextStyle(
                        fontWeight: FontWeight.w900,
                        color: UIGuide.light_Purple),
                    confirmText: const Text(
                      'OK',
                      style: TextStyle(color: UIGuide.light_Purple),
                    ),
                    cancelText: const Text(
                      'Cancel',
                      style: TextStyle(color: UIGuide.light_Purple),
                    ),
                    separateSelectedItems: true,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border: Border.all(
                        color: Colors.grey,
                        width: 2,
                      ),
                    ),
                    buttonIcon: const Icon(
                      Icons.arrow_drop_down_outlined,
                      color: Colors.grey,
                    ),
                    buttonText: const Text(
                      "Select Section",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    chipDisplay: MultiSelectChipDisplay.none(),
                    onConfirm: (results) async {
                      subjectData = [];
                      for (var i = 0; i < results.length; i++) {
                        StudReportSectionList data =
                            results[i] as StudReportSectionList;
                        print(data.text);
                        print(data.value);
                        subjectData.add(data.value);
                        subjectData.map((e) => data.value);
                        print("${subjectData.map((e) => data.value)}");
                      }
                      String section = subjectData.join('&');
                      await Provider.of<SchoolPhotoProviders>(context,
                              listen: false)
                          .getCourseList(section);


                    },
                  ),
                ),
              ),
            ),
            const Spacer(),
            Consumer<SchoolPhotoProviders>(
              builder: (context, value, child) => Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  width: size.width * .42,
                  height: 50,
                  child: MultiSelectDialogField(
                    items: value.courseDrop,
                    listType: MultiSelectListType.CHIP,
                    title: const Text(
                      "Select Course",
                      style: TextStyle(color: Colors.black),
                    ),
                    selectedItemsTextStyle: const TextStyle(
                        fontWeight: FontWeight.w900,
                        color: UIGuide.light_Purple),
                    confirmText: const Text(
                      'OK',
                      style: TextStyle(color: UIGuide.light_Purple),
                    ),
                    cancelText: const Text(
                      'Cancel',
                      style: TextStyle(color: UIGuide.light_Purple),
                    ),
                    separateSelectedItems: true,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border: Border.all(
                        color: Colors.grey,
                        width: 2,
                      ),
                    ),
                    buttonIcon: const Icon(
                      Icons.arrow_drop_down_outlined,
                      color: Colors.grey,
                    ),
                    buttonText: const Text(
                      "Select Course",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    chipDisplay: MultiSelectChipDisplay.none(),
                    onConfirm: (results) async {
                      diviData = [];
                      for (var i = 0; i < results.length; i++) {
                        StudReportCourse data = results[i] as StudReportCourse;
                        print(data.value);
                        print(data.text);
                        diviData.add(data.value);
                        diviData.map((e) => data.value);
                        print("${diviData.map((e) => data.value)}");
                      }
                      String course = diviData.join('&');
                      await Provider.of<SchoolPhotoProviders>(context,
                              listen: false)
                          .getDivisionList(course);

                      print(diviData.join('&'));
                    },
                  ),
                ),
              ),
            )
          ],
        ),
        Row(
          children: [
            Consumer<SchoolPhotoProviders>(
              builder: (context, value, child) => Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: SizedBox(
                  width: size.width * .42,
                  height: 50,
                  child: MultiSelectDialogField(
                    items: value.divisionDrop,
                    listType: MultiSelectListType.CHIP,
                    title: const Text(
                      "Select Division",
                      style: TextStyle(color: Colors.grey),
                    ),
                    selectedItemsTextStyle: const TextStyle(
                        fontWeight: FontWeight.w900,
                        color: UIGuide.light_Purple),
                    confirmText: const Text(
                      'OK',
                      style: TextStyle(color: UIGuide.light_Purple),
                    ),
                    cancelText: const Text(
                      'Cancel',
                      style: TextStyle(color: UIGuide.light_Purple),
                    ),
                    separateSelectedItems: true,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border: Border.all(
                        color: Colors.grey,
                        width: 2,
                      ),
                    ),
                    buttonIcon: const Icon(
                      Icons.arrow_drop_down_outlined,
                      color: Colors.grey,
                    ),
                    buttonText: const Text(
                      "Select Division",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    chipDisplay: MultiSelectChipDisplay.none(),
                    onConfirm: (results) {
                      courseData = [];
                      for (var i = 0; i < results.length; i++) {
                        StudReportDivision data =
                            results[i] as StudReportDivision;
                        print(data.text);
                        print(data.value);
                        courseData.add(data.value);
                        courseData.map((e) => data.value);
                        print("${courseData.map((e) => data.value)}");
                      }

                      print(courseData.join('&'));
                    },
                  ),
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: SizedBox(
                width: size.width * .42,
                height: 44,
                child: MaterialButton(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  onPressed: () {},
                  color: UIGuide.THEME_LIGHT,
                  child: const Text('View'),
                ),
              ),
            )
          ],
        ),
      ],
    ));
  }
}
