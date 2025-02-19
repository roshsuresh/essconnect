import 'package:essconnect/Presentation/Staff/Searchstudent.dart';
import 'package:essconnect/utils/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Application/Staff_Providers/StudListProvider.dart';
import '../../Constants.dart';
import '../../Domain/Staff/StudentReport_staff.dart';
import '../../utils/constants.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';


class StudReport extends StatefulWidget {
  const StudReport({Key? key}) : super(key: key);

  @override
  State<StudReport> createState() => _StudReportState();
}

class _StudReportState extends State<StudReport> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var p = Provider.of<StudReportListProvider_stf>(context, listen: false);
      await p.setLoading(false);
      await p.clearAllFilters();
      await p.removeSectionAll();
      p.sectionList.clear();
      await p.courseClear();
      await p.divisionClear();
      await p.sectionClear();
      await p.removeSectionAll();
      await p.removeDivisionAll();
      await p.removeCourseAll();
      await p.clearViewList();
      await p.stdReportSectionStaff();
      p.getClassTeacherList();
    });
  }

  String? phn;
  String sectionId = '';
  String courseId = '';
  String divisionId = '';
  List<bool> isSelected = [true, false, false];

  List selectedSection=[];
  List selectedCourse=[];
  List selectedDivision=[];
//  bool loading = false;

  List<ViewStudentReport> filteredList = [];
  int selectedStatusIndex = 0;
  List<String> sectionValue = [];
  List<String> courseValue = [];
  List<String> divisionValue = [];
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var snapshot = Provider.of<StudReportListProvider_stf>(context);
    if (selectedStatusIndex == 0) {
      filteredList = snapshot.viewNotTerminatedList;
    } else if (selectedStatusIndex == 1) {
      filteredList = snapshot.viewterminatedList;
    } else {
      filteredList = snapshot.viewStudReportListt;
    }
    return Scaffold(
        appBar: AppBar(
            title: Row(
              children: [
                const Spacer(),
                const Text('Student Report'),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                              const StudReport()));
                    },
                    icon: const Icon(Icons.refresh)),
                IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchStudent_stf()),
                      );
                    },
                    icon: const Icon(Icons.search))

              ],
            ),
            titleSpacing: 00.0,
            centerTitle: true,
            toolbarHeight: 60.2,
            toolbarOpacity: 0.8,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(25),
                  bottomLeft: Radius.circular(25)),
            ),
            backgroundColor: UIGuide.light_Purple),
        body: snapshot.sectionList.isEmpty?
        const Center(
          child:Text("No Access ",style: TextStyle(
              fontSize: 16,fontWeight: FontWeight.w500
          ),) ,
        ):snapshot.loading==true?
        pleaseWaitLoader():
        Stack(
          children: [
            Column(
              children: [
                kheight10,
                Row(
                  children: [
                    kWidth,

                    Expanded(
                      child: SizedBox(
                        width: size.width * .45,
                        height: size.height * .06,
                        child: Stack(
                          children: [
                            MultiSelectDialogField(
                              dialogHeight: size.height * .3,
                              buttonIcon: Icon(
                                Icons.arrow_drop_down_sharp,
                                color: snapshot.sectionList.isEmpty ? Colors.grey : Colors.black54,
                              ),
                              items: snapshot.sectionList
                                  .map((section) => MultiSelectItem<String>(section.text!, section.text!))
                                  .toList(),
                              title: Text("Select Section"),
                              selectedColor: UIGuide.light_Purple,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(color: Colors.grey, width: 1.5),
                              ),
                              separateSelectedItems: true,
                              buttonText: Text(
                                selectedSection == null || selectedSection.isEmpty
                                    ? "Select Section"
                                    : "${selectedSection.length} Selected",
                                style: TextStyle(
                                  color: selectedSection == null || selectedSection.isEmpty
                                      ? Colors.black54
                                      : Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                              chipDisplay: MultiSelectChipDisplay.none(),

                              // Provide the current selected values to initialValue
                              initialValue: selectedSection ?? [],

                              onConfirm: (values) async {
                                setState(() {
                                  // Clear previous selections and update states
                                  selectedCourse.clear();
                                  courseValue.clear();
                                  courseId = "";
                                  selectedDivision.clear();
                                  divisionValue.clear();
                                  divisionId = "";
                                  snapshot.viewStudReportListt.clear();
                                  snapshot.viewterminatedList.clear();
                                  snapshot.viewNotTerminatedList.clear();
                                  filteredList.clear();

                                  selectedSection = values;
                                  sectionValue = snapshot.sectionList
                                      .where((section) => values.contains(section.text))
                                      .map((section) => section.value!)
                                      .toList();
                                });

                                sectionId = sectionValue.join(',');

                                // Fetch updated data
                                snapshot.courselist.clear();
                                snapshot.divisionlist.clear();
                                await snapshot.getCourseList(sectionId);
                              },
                            ),

                          ],
                        ),
                      ),
                    ),



                    kWidth,
                    Expanded(
                      child: SizedBox(
                        width: size.width * .45,
                        height: size.height * .06,
                        child: MultiSelectDialogField(
                          dialogHeight: size.height * .3,
                          buttonIcon: Icon(
                            Icons.arrow_drop_down_sharp,
                            color: snapshot.courselist.isEmpty ? Colors.grey : Colors.black54,
                          ),
                          items: snapshot.courselist
                              .map((section) => MultiSelectItem<String>(section.text!, section.text!))
                              .toList(),
                          title: Text("Select Course"),
                          selectedColor: UIGuide.light_Purple,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(color: Colors.grey, width: 1.5),
                          ),
                          separateSelectedItems: true,
                          buttonText: Text(
                            selectedCourse == null || selectedCourse.isEmpty
                                ? "Select Course"
                                : "${selectedCourse.length} Selected",
                            style: TextStyle(
                              color: selectedCourse == null || selectedCourse.isEmpty
                                  ? Colors.black54
                                  : Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          chipDisplay: MultiSelectChipDisplay.none(),
                          initialValue: selectedCourse ?? [],
                          onConfirm: (values) async {
                            setState(() {
                              selectedDivision.clear();
                              divisionValue.clear();
                              divisionId="";
                              snapshot.viewStudReportListt.clear();
                              snapshot.viewterminatedList.clear();
                              snapshot.viewNotTerminatedList.clear();
                              filteredList.clear();


                              selectedCourse = values;
                              courseValue = snapshot.courselist
                                  .where((section) => values.contains(section.text))
                                  .map((section) => section.value!)
                                  .toList();
                            });

                            courseId = courseValue.join(',');
                            snapshot.divisionlist.clear();

                            await snapshot.getDivisionList(courseId);


                          },
                        ),
                      ),
                    ),
                    kWidth,
                  ],
                ),

                kheight10,
                Row(
                  children: [
                    kWidth,
                    Expanded(
                      child: SizedBox(
                        width: size.width * .45,
                        height: size.height * .06,
                        child:
                        MultiSelectDialogField(
                          dialogHeight: size.height * .3,
                          buttonIcon: Icon(
                            Icons.arrow_drop_down_sharp,
                            color: snapshot.divisionlist.isEmpty ? Colors.grey : Colors.black54,
                          ),
                          items: snapshot.divisionlist
                              .map((section) => MultiSelectItem<String>(section.text!, section.text!))
                              .toList(),
                          title: const Text("Select Division"),
                          selectedColor: UIGuide.light_Purple, // Adjust as needed
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(color: Colors.grey, width: 1.5),
                          ),
                          separateSelectedItems: true,
                          buttonText: Text(
                            selectedDivision == null || selectedDivision.isEmpty
                                ? "Select Division"
                                : "${selectedDivision.length} Selected",
                            style: TextStyle(
                              color: selectedDivision == null || selectedDivision.isEmpty
                                  ? Colors.black54
                                  : Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          chipDisplay: MultiSelectChipDisplay.none(),
                          initialValue: selectedDivision ?? [],
                          onConfirm: (values) async {
                            setState(() {
                              snapshot.viewStudReportListt.clear();
                              snapshot.viewterminatedList.clear();
                              snapshot.viewNotTerminatedList.clear();
                              filteredList.clear();

                              selectedDivision = values;
                              divisionValue = snapshot.divisionlist
                                  .where((section) => values.contains(section.text))
                                  .map((section) => section.value!)
                                  .toList();
                            });

                            divisionId = divisionValue.join(',');

                          },
                        ),
                      ),
                    ),
                    kWidth,
                    Expanded(
                      child: SizedBox(
                        height: 45,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 3,
                            foregroundColor: UIGuide.WHITE,
                            backgroundColor: UIGuide.light_Purple,
                            padding: const EdgeInsets.all(0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: const BorderSide(
                                  color: UIGuide.light_black,
                                )),
                          ),
                          onPressed: (() async {


                            print(divisionId);
                            print(sectionId);


                            await snapshot.removeSectionAll();

                            await snapshot.removeCourseAll();

                            await snapshot.removeDivisionAll();
                            await snapshot.clearViewList();
                            await snapshot.viewStudentReportList(
                                sectionId,
                                courseId,
                                divisionId);
                            if (snapshot.viewStudReportListt.isEmpty) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(
                                const SnackBar(
                                  elevation: 10,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20)),
                                  ),
                                  duration: Duration(seconds: 2),
                                  margin: EdgeInsets.only(
                                      bottom: 80, left: 30, right: 30),
                                  behavior: SnackBarBehavior.floating,
                                  content: Text(
                                    'Data not found',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              );
                            }
                          }
                          ),
                          child: const Text('View'),
                        ),
                      ),
                    ),
                    kWidth
                  ],
                ),
                kheight10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ToggleButtons(
                      borderRadius: BorderRadius.circular(8.0),
                      selectedBorderColor: UIGuide.light_Purple,
                      selectedColor: Colors.white,
                      fillColor: UIGuide.light_Purple,
                      borderColor: UIGuide.light_Purple,
                      color: UIGuide.light_Purple,
                      isSelected: isSelected,
                      onPressed: (int index)async {
                        setState(() {
                          for (int i = 0; i < isSelected.length; i++) {
                            isSelected[i] = i == index;
                          }
                          selectedStatusIndex = index; // Update the selected index
                        });
                      },
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text('Studying'),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text('Relieved'),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text('Both'),
                        ),
                      ],
                    )
                  ],
                ),
                kheight10,



                Expanded(
                  child: Scrollbar(
                    child: AnimationLimiter(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: filteredList.isEmpty ? 0 : filteredList.length,
                        itemBuilder: (context, index) {
                          // Check if it's the first item of a division or the first item of the list
                          bool isNewDivision = index == 0 ||
                              filteredList[index].division != filteredList[index - 1].division;

                          // Find the class teacher name for the current division
                          String? classTeacherName = snapshot.classteacherList
                              .firstWhere(
                                (teacher) => teacher.division == filteredList[index].division,
                            orElse: () => ClassTeachersModel(name: null, division: null), // Default model
                          )
                              .name;

                          // Wrap each item in an `AnimationConfiguration`
                          return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 200), // Animation duration
                            child: SlideAnimation(
                              delay: Duration(milliseconds: 200),
                              curve: Curves.slowMiddle,
                              verticalOffset: 50.0, // Animation starts offset from 50 pixels
                              child: FadeInAnimation(
                                delay: Duration(milliseconds: 200),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Add a header for the new division
                                    if (isNewDivision)
                                      Padding(
                                        padding: const EdgeInsets.only(top: 15, left: 15),
                                        child: Row(
                                          children: [
                                            Text(
                                              filteredList[index].division ?? '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: UIGuide.light_Purple,
                                              ),
                                            ),
                                            kWidth5,
                                            Flexible(
                                              child: Text(
                                                classTeacherName != null ? "- $classTeacherName" : '',
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: UIGuide.light_Purple,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                softWrap: true,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    // Add the student item
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10, right: 10, top: 4, bottom: 4),
                                      child: Container(
                                        width: size.width - 4,
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.5),
                                              spreadRadius: 0.5,
                                              blurRadius: 3,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                          color: UIGuide.light_Purple,
                                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            const SizedBox(height: 1.5),
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => StudProfileViewBySearch_Staff(
                                                      stud: filteredList[index],
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                width: size.width - 6,
                                                decoration: const BoxDecoration(
                                                  color: Color.fromARGB(255, 255, 255, 255),
                                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                                ),
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    // Student Photo
                                                    Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Center(
                                                        child: Container(

                                                          width: 70,
                                                          height: 70,
                                                          decoration: BoxDecoration(

                                                            color: const Color.fromARGB(255, 236, 233, 233),
                                                            image: DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image: NetworkImage(
                                                                filteredList[index].studentPhoto ??
                                                                    'https://gj-eschool-files-public.s3.ap-south-1.amazonaws.com/ess-connect/student/avathar-01.jpeg',
                                                              ),
                                                            ),
                                                            borderRadius: const BorderRadius.all(
                                                              Radius.circular(10),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    // Student Details
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          // Name and Index
                                                          Row(
                                                            children: [
                                                              const Text(
                                                                'Name : ',
                                                                style: TextStyle(
                                                                  fontWeight: FontWeight.w500,
                                                                  fontSize: 13,
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: Text(
                                                                  filteredList[index].name ?? '---',
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: const TextStyle(
                                                                    fontSize: 12,
                                                                    color: UIGuide.light_Purple,
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(
                                                                padding: const EdgeInsets.all(3),
                                                                decoration: BoxDecoration(
                                                                  borderRadius: const BorderRadius.only(
                                                                    topRight: Radius.circular(10),
                                                                    bottomLeft: Radius.circular(10),
                                                                  ),
                                                                  border: Border.all(
                                                                    color: const Color.fromARGB(
                                                                      255,
                                                                      224,
                                                                      224,
                                                                      224,
                                                                    ),
                                                                  ),
                                                                  color: const Color.fromARGB(
                                                                    255,
                                                                    255,
                                                                    251,
                                                                    251,
                                                                  ),
                                                                ),
                                                                child: Text(
                                                                  " ${index + 1} ",
                                                                  style: const TextStyle(fontSize: 12),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          // Roll No and Division
                                                          Padding(
                                                            padding: const EdgeInsets.only(top: 1),
                                                            child: Row(
                                                              children: [
                                                                const Text(
                                                                  'Roll No : ',
                                                                  style: TextStyle(
                                                                    fontWeight: FontWeight.w500,
                                                                    fontSize: 13,
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child: Text(
                                                                    filteredList[index].rollNo?.toString() ??
                                                                        '---',
                                                                    maxLines: 1,
                                                                    style: const TextStyle(
                                                                      fontSize: 12,
                                                                      color: Colors.black,
                                                                    ),
                                                                  ),
                                                                ),
                                                                kWidth,
                                                                const Text(
                                                                  'Division : ',
                                                                  style: TextStyle(
                                                                    fontWeight: FontWeight.w500,
                                                                    fontSize: 13,
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child: Text(
                                                                    filteredList[index].division ?? '---',
                                                                    maxLines: 1,
                                                                    style: const TextStyle(
                                                                      fontSize: 12,
                                                                      color: Colors.black,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          // Admission Number
                                                          Padding(
                                                            padding: const EdgeInsets.only(top: 4),
                                                            child: Row(
                                                              children: [
                                                                const Text(
                                                                  'Adm No : ',
                                                                  style: TextStyle(
                                                                    fontWeight: FontWeight.w500,
                                                                    fontSize: 13,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  filteredList[index].admnNo ?? '---',
                                                                  style: const TextStyle(
                                                                    fontSize: 12,
                                                                    color: Colors.black,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          // Phone Number
                                                          Padding(
                                                            padding: const EdgeInsets.only(top: 4),
                                                            child: GestureDetector(
                                                              onTap: () async {
                                                                phn = filteredList[index].mobNo ?? '--';
                                                                _makingPhoneCall(phn.toString());
                                                              },
                                                              child: Row(
                                                                children: [
                                                                  const Text(
                                                                    'Phone : ',
                                                                    style: TextStyle(
                                                                      fontWeight: FontWeight.w500,
                                                                      fontSize: 13,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    filteredList[index].mobNo ?? '---',
                                                                    style: const TextStyle(
                                                                      fontSize: 13,
                                                                      color: Colors.black,
                                                                    ),
                                                                  ),
                                                                  const Icon(
                                                                    Icons.phone,
                                                                    size: 17,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),




              ],
            ),

          ],
        )
    );
  }

  _makingPhoneCall(String phn) async {
    var url = Uri.parse("tel:$phn");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

