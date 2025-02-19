
import 'package:collection/collection.dart';
import 'package:essconnect/utils/spinkit.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../Application/Staff_Providers/HPC/SelfAssessmentProvider.dart';
import '../../../Application/Staff_Providers/HPC/SelfLearningProvider.dart';
import '../../../Domain/Staff/HPC/HPC-SelfAssessment_Model.dart';
import '../../../Domain/Staff/HPC/HPC_SelfLearning_Model.dart';
import '../../../utils/constants.dart';




class SelfLearningEntry extends StatefulWidget {
  const SelfLearningEntry({super.key});

  @override
  State<SelfLearningEntry> createState() => _SelfLearningEntryState();
}

class _SelfLearningEntryState extends State<SelfLearningEntry> {
  String? selectedStage;
  String stageValue = "";

  String? selectedPart;
  String partValue = "";

  String? selectedCourse;
  String courseValue = "";

  String? selectedDomain;
  String domainValue = "";
  String coursedomainvalue = "";

  String? selectedDivision;
  String divisionValue = "";

  String? selectedActivity;
  String activityValue = "";
  DateTime _selectedDate = DateTime.now();

  bool relived_status = false;
  bool showListView = false;

  DateTime selectedDate = DateTime.now();

  bool _isLoading = false;




  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var c = Provider.of<HPC_SelfLearning_Provider>(context, listen: false);
      c.stagelist.clear();
      c.courselist.clear();
      c.partlist.clear();
      c.divisionslist.clear();
      c.domainlist.clear();
      c.activitylist.clear();
      c.selfassessmententry=null;
      await c.stagelistfn(context);

    });
  }
  void _reset() {
    var provider = Provider.of<HPC_SelfLearning_Provider>(context, listen: false);
    setState(() {
      selectedStage = null;
      selectedCourse = null;
      selectedDomain = null;
      selectedDivision = null;
      selectedPart = null;
      selectedActivity = null;
      selectedPart=null;

      provider.courselist.clear();
      provider.domainlist.clear();
      provider.divisionslist.clear();
      provider.activitylist.clear();
      provider.partlist.clear();
      provider.studententrieslist.clear();
      showListView=false;
      // showListView = false;
      stageValue = "";
      courseValue = "";
      domainValue = "";
      coursedomainvalue = "";
      divisionValue = "";
      activityValue = "";
      partValue = "";

      relived_status = false;
      // provider.sectionlistfn(context);
      // Reinitialize with one card by default
    });
  }
  String _formatDate(String? dateString) {
    // Check if the dateString is null
    if (dateString == null || dateString.isEmpty) {
      return ""; // or return an empty string ""
    }

    DateTime dateTime = DateTime.parse(dateString);
    // Format the date as dd-MM-yyyy
    return DateFormat('dd-MM-yyyy').format(dateTime);
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var provider = Provider.of<HPC_SelfLearning_Provider>(context);
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 7, 68, 126),
        title: Text(
          "Self Learning Entry",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
        ),
      ),
      body: ListView(
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: size.width * .45,
                        height: size.height * .06,
                        child: DropdownButtonFormField<String>(
                          isExpanded: true,
                          value: selectedStage,
                          hint: Text('Select Stage'),
                          items: provider.stagelist
                              .map((section) => DropdownMenuItem<String>(
                            value: section.text!,
                            child: Text(section.text!),
                          ))
                              .toList(),
                          onChanged: (value) async {
                            setState(() {
                              selectedStage = value;
                              selectedCourse = null;
                              courseValue = "";
                              selectedDomain = null;
                              domainValue = "";
                              coursedomainvalue = "";
                              selectedDivision = null;
                              divisionValue = "";
                              selectedActivity = null;
                              activityValue = "";
                              partValue = "";
                              selectedPart = null;
                              provider.studententrieslist.clear();
                              showListView = false;


                              print("valueeeeeee");

                              print(courseValue);
                              print(divisionValue);
                              print(domainValue);
                              print(activityValue);
                              print(partValue);
                            });

                            stageValue = provider.stagelist
                                .firstWhere((section) => section.text == value)
                                .value!;
                            provider.courselist.clear();
                            provider.divisionslist.clear();
                            provider.domainlist.clear();
                            provider.activitylist.clear();
                            provider.partlist.clear();
                            print(stageValue);
                            await provider.courselistfn(context, stageValue);
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0), // Rounded corners
                              borderSide: BorderSide(
                                color: Colors.grey, // Set your desired border color here
                                width: 1.5,        // Border thickness
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(
                                color: Colors.grey, // Border color when not focused
                                width: 1.5,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(
                                color: UIGuide.light_Purple, // Border color when focused
                                width: 2.0,        // Border thickness when focused
                              ),
                            ),
                          ),
                        ),

                      ),// Stage Dropdown
                      SizedBox(
                        width: size.width * .45,
                        height: size.height * .06,
                        child: DropdownButtonFormField<String>(
                          isExpanded: true,
                          value:  selectedCourse,
                          hint: Text('Select Course'),
                          items:  provider.courselist
                              .map((section) => DropdownMenuItem<String>(
                            value: section.text!,
                            child: Text(section.text!),
                          ))
                              .toList(),

                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0), // Rounded corners
                              borderSide: BorderSide(
                                color: Colors.grey, // Set your desired border color here
                                width: 1.5,        // Border thickness
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(
                                color: Colors.grey, // Border color when not focused
                                width: 1.5,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(
                                color: UIGuide.light_Purple, // Border color when focused
                                width: 2.0,        // Border thickness when focused
                              ),
                            ),
                          ),
                          onChanged: (value) async {
                            setState(() {

                              selectedDomain = null;
                              domainValue = "";
                              coursedomainvalue = "";
                              selectedDivision = null;
                              divisionValue = "";
                              selectedActivity = null;
                              activityValue = "";
                              provider.studententrieslist.clear();
                              showListView=false;
                              selectedCourse = value;
                            });

                            courseValue = provider.courselist
                                .firstWhere((section) => section.text == value)
                                .value!;
                            provider.domainlist.clear();
                            provider.divisionslist.clear();
                            provider.activitylist.clear();
                            //   provider.partlist.clear();
                            await provider.divisionlistfn(context, courseValue);
                          },
                        ),
                      ),// Course Dropdown
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: size.width * .45,
                        height: size.height * .06,
                        child: DropdownButtonFormField<String>(
                          isExpanded: true,
                          value:  selectedDivision,
                          hint: Text('Select Division'),
                          items: provider.divisionslist
                              .map((section) => DropdownMenuItem<String>(
                            value: section.text!,
                            child: Text(section.text!),
                          ))
                              .toList(),

                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0), // Rounded corners
                              borderSide: BorderSide(
                                color: Colors.grey, // Set your desired border color here
                                width: 1.5,        // Border thickness
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(
                                color: Colors.grey, // Border color when not focused
                                width: 1.5,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(
                                color: UIGuide.light_Purple, // Border color when focused
                                width: 2.0,        // Border thickness when focused
                              ),
                            ),
                          ),
                          onChanged: (value) async {
                            setState(() {

                              selectedDomain = null;
                              domainValue = "";
                              coursedomainvalue = "";
                              selectedDivision = null;
                              divisionValue = "";
                              selectedActivity = null;
                              activityValue = "";
                              // partValue="";
                              // selectedPart=null;
                              provider.studententrieslist.clear();
                              showListView=false;
                              selectedDivision = value;
                            });

                            divisionValue = provider.divisionslist
                                .firstWhere((section) => section.text == value)
                                .value!;
                            provider.domainlist.clear();
                            provider.activitylist.clear();
                            // provider.partlist.clear();

                            await provider.domainlistfn(context, courseValue,divisionValue);

                          },
                        ),
                      ),// Division Dropdown
                      SizedBox(
                        width: size.width * .45,
                        height: size.height * .06,
                        child: DropdownButtonFormField<String>(
                          isExpanded: true,
                          value:  selectedPart,
                          hint: Text('Select Part'),
                          items: provider.partlist
                              .map((section) => DropdownMenuItem<String>(
                            value: section.text!,
                            child: Text(section.text!),
                          ))
                              .toList(),

                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0), // Rounded corners
                              borderSide: BorderSide(
                                color: Colors.grey, // Set your desired border color here
                                width: 1.5,        // Border thickness
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(
                                color: Colors.grey, // Border color when not focused
                                width: 1.5,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(
                                color: UIGuide.light_Purple, // Border color when focused
                                width: 2.0,        // Border thickness when focused
                              ),
                            ),
                          ),
                          onChanged: (value) async {
                            setState(() {
                              selectedPart=value;
                              provider.studententrieslist.clear();
                              showListView=false;
                            });

                            partValue = provider.partlist
                                .firstWhere((section) => section.text == value)
                                .value!;

                          },
                        ),
                      ),

                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      SizedBox(
                        width: size.width * .45,
                        height: size.height * .06,
                        child: DropdownButtonFormField<String>(
                          isExpanded: true,
                          value:  selectedDomain,
                          hint: Text('Select Domain'),
                          items: provider.domainlist
                              .map((section) => DropdownMenuItem<String>(
                            value: section.text!,
                            child: Text(section.text!),
                          ))
                              .toList(),

                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0), // Rounded corners
                              borderSide: BorderSide(
                                color: Colors.grey, // Set your desired border color here
                                width: 1.5,        // Border thickness
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(
                                color: Colors.grey, // Border color when not focused
                                width: 1.5,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(
                                color: UIGuide.light_Purple, // Border color when focused
                                width: 2.0,        // Border thickness when focused
                              ),
                            ),
                          ),
                          onChanged: (value) async {
                            setState(() {
                              selectedDomain = value;
                              selectedActivity = null;
                              activityValue = "";
                              provider.studententrieslist.clear();
                              showListView=false;
                            });
                            domainValue = provider.domainlist
                                .firstWhere((section) => section.text == value)
                                .value!;
                            coursedomainvalue = provider.domainlist
                                .firstWhere((section) => section.text == value)
                                .courseDomainId!;

                            print("crsdmaaaaa $coursedomainvalue");
                            provider.activitylist.clear();
                            await provider.activitylistfn(context, coursedomainvalue);
                          },
                        ),
                      ),
                      SizedBox(
                        width: size.width * .45,
                        height: size.height * .06,
                        child: DropdownButtonFormField<String>(
                          isExpanded: true,
                          value:  selectedActivity,
                          hint: Text('Select Activity'),
                          items:  provider.activitylist
                              .map((section) => DropdownMenuItem<String>(
                            value: section.text!,
                            child: Text(section.text!),
                          ))
                              .toList(),

                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0), // Rounded corners
                              borderSide: BorderSide(
                                color: Colors.grey, // Set your desired border color here
                                width: 1.5,        // Border thickness
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(
                                color: Colors.grey, // Border color when not focused
                                width: 1.5,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(
                                color: UIGuide.light_Purple, // Border color when focused
                                width: 2.0,        // Border thickness when focused
                              ),
                            ),
                          ),
                          onChanged: (value) async {
                            setState(() {
                              selectedActivity = value;
                              provider.studententrieslist.clear();
                              showListView=false;
                            });

                            activityValue = provider.activitylist
                                .firstWhere((section) => section.text == value)
                                .value!;


                          },
                        ),
                      ),// Activity Dropdown

                    ],
                  ),
                  SizedBox(height: 6),
                  provider.selfassessmententry != null && provider.selfassessmententry!.entryStatus == "Verified" && showListView==true
                      ? Text(
                    "Verified By: ${provider.selfassessmententry!.verifyStaff.toString()}",
                    style: TextStyle(color: Colors.green, fontWeight: FontWeight.w500),
                    overflow: TextOverflow.ellipsis,
                  )
                      : SizedBox(height: 0, width: 0),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: relived_status,
                            onChanged: (bool? value) {
                              provider.studententrieslist.clear();
                              showListView=false;
                              setState(() {
                                relived_status = value!;
                              });
                            },
                            checkColor: UIGuide.light_Purple,
                          ),
                          GestureDetector(
                            onTap: () {
                              provider.studententrieslist.clear();
                              showListView=false;
                              // Toggle the checkbox when the text is tapped
                              setState(() {
                                relived_status = !relived_status;
                              });
                            },
                            child: Text("Include Relieved"),
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          SizedBox(
                            // width: size.width * .45,
                            // height: size.height * .06,
                            child:ElevatedButton(
                              onPressed: () async {
                                if(selectedStage==null||
                                    selectedCourse==null||
                                    selectedDivision==null||
                                    selectedDomain==null||
                                    selectedActivity==null||
                                    selectedPart==null
                                ){


                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                    ),
                                    duration: Duration(seconds: 1),
                                    margin: EdgeInsets.only(bottom: 20, left: 30, right: 30),
                                    behavior: SnackBarBehavior.floating,
                                    content: Text(
                                      'Please select all fields',
                                      textAlign: TextAlign.center,
                                    ),
                                  ));
                                }
                                else {
                                  String search = "";
                                  provider.clearlistfn();
                                  await provider.viewfn(
                                      context,
                                      stageValue,
                                      courseValue,
                                      domainValue,
                                      activityValue,
                                      partValue,
                                      divisionValue,
                                      search,
                                      relived_status,
                                      coursedomainvalue);
                                  setState(() {
                                    showListView = true;
                                  });


                                  // if (provider.feedbackentry!.entryDate !=
                                  //     null) {
                                  //   DateTime dateTime = DateTime.parse(
                                  //       provider.feedbackentry!.entryDate
                                  //           .toString());
                                  //   print("dddsasasrrrrr $dateTime");
                                  //   _selectedDate = dateTime;
                                  // }
                                  print("entry stsssssssssss");
                                  print(provider.selfassessmententry?.entryStatus);
                                  print(provider.selfassessmententry?.verifyStaff);
                                }
                              },
                              child: Text('View'),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: UIGuide.light_Purple
                              ),
                            ),

                          ),
                          SizedBox(width: 10),
                          SizedBox(
                            // width: size.width * .45,
                            // height: size.height * .06,
                            child:ElevatedButton(
                              onPressed: _reset,
                              child: Text('Reset'),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: UIGuide.THEME_PRIMARY
                              ),
                            ),
                          ),
                        ],
                      ),

                    ],
                  ),

                  provider.loading
                      ? Container(
                      height: size.height * 0.4,
                      child: Center(child: spinkitLoader())):

                  Row
                    (
                    children: [

                      showListView
                          ?
                      Expanded(
                        child: Container(
                          height: size.height * 0.5,
                          width: size.width,
                          child: ListView.builder(
                            itemCount: provider.studententrieslist.length,
                            itemBuilder: (context, index) {
                              final studentEntry = provider.studententrieslist[index];
                              final studentLearningsMap = studentEntry.studentLearnings;
                              final List<String> learningIds = studentLearningsMap!.keys.toList();

                              // Count missing entries
                              final missingEntriesCount = learningIds.where((id) =>
                              studentLearningsMap![id]?.remarks == null || studentLearningsMap![id]!.remarks!.isEmpty).length;

                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey.withOpacity(0.5)),
                                    borderRadius: BorderRadius.circular(10),
                                    // Change background color if the entry is edited
                                    color: studentEntry.isEdited! ? Colors.yellow.withOpacity(0.3) : Colors.white,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Row for Student name and roll number
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                studentEntry.rollNo?.toString() ?? "",
                                                style: TextStyle(fontWeight: FontWeight.w500),
                                              ),
                                              SizedBox(width: 10),
                                              SizedBox(
                                                width: size.width * 0.6,
                                                child: Text(
                                                  studentEntry.studentName.toString(),
                                                  style: TextStyle(
                                                    color: UIGuide.light_Purple,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                          // IconButton for viewing statements
                                          IconButton(
                                            icon: Icon(Icons.visibility, color: UIGuide.light_Purple),
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return AlertDialog(
                                                    title: Text('Statements'),
                                                    content: SingleChildScrollView(
                                                      child: SizedBox(
                                                        width: size.width * 0.85,
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: List.generate(learningIds.length, (ind) {
                                                            String learningId = learningIds[ind];
                                                            final studentLearning = studentLearningsMap[learningId];
                                                            String? selectedAbilityResponse = studentLearning?.remarks;
                                                            final TextEditingController _remarksController = TextEditingController(text: selectedAbilityResponse);

                                                            return Padding(
                                                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                                                              child: Column(
                                                                children: [
                                                                  Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    children: [
                                                                      Expanded(
                                                                        child: Text(
                                                                          provider.learninglist
                                                                              .firstWhere((learning) => learning.learningId == learningId)
                                                                              .learningName ?? 'Learning Name',
                                                                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      SizedBox(
                                                                        width: size.width * 0.65,
                                                                        child: TextField(
                                                                          maxLines: 2,
                                                                          controller: _remarksController,
                                                                          decoration: InputDecoration(
                                                                            border: OutlineInputBorder(
                                                                              borderSide: BorderSide(color: UIGuide.light_Purple),
                                                                            ),
                                                                            focusedBorder: OutlineInputBorder(
                                                                              borderSide: BorderSide(color: UIGuide.light_Purple),
                                                                            ),
                                                                          ),
                                                                          onChanged: (value) {
                                                                            // Check and prevent initial space
                                                                            if (value.startsWith(' ')) {
                                                                              value = value.trimLeft(); // Remove leading space
                                                                              // Update the text field's controller
                                                                              _remarksController.text = value;
                                                                              // Set the cursor position at the end of the input
                                                                              _remarksController.selection = TextSelection.fromPosition(
                                                                                TextPosition(offset: value.length),
                                                                              );
                                                                            }

                                                                            studentLearning?.remarks = value;
                                                                            provider.studententrieslist[index].isEdited = true; // Update remarks on change
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            );
                                                          }),
                                                        ),
                                                      ),
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                        child: Text('OK', style: TextStyle(color: UIGuide.light_Purple)),
                                                        onPressed: () {
                                                          Navigator.of(context).pop();
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: size.width * 0.8,
                                            child: Text(
                                              "Entry Staff: ${studentEntry.entryStaffName ?? ""}",
                                              style: TextStyle(
                                                color: UIGuide.light_Purple,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),

                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      // Display message for missing entries
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: size.width * 0.5,
                                            child: Text(
                                              "Entry Date: ${_formatDate(studentEntry.entryDate)}",
                                              style: TextStyle(
                                                color: UIGuide.light_Purple,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                     if (missingEntriesCount == 1)
                                      Text(
                                      '$missingEntriesCount entry missing',
                                      style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
                                    )
                                       else   if (missingEntriesCount > 1)
                                            Text(
                                              '$missingEntriesCount entries missing',
                                              style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
                                            )

                                          else
                                            Text(
                                              'Completed',
                                              style: TextStyle(color: Colors.green, fontWeight: FontWeight.w500),
                                            ),
                                        ],
                                      )

                                      // Indicate if the entry is edited

                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      )


                          :Container(),

                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: showListView
            ?
        provider.selfassessmententry?.entryStatus == "Synchronized"?
        SizedBox(
          height: 50,
          child:
          Padding(
            padding: const EdgeInsets.only(left: 10.0,right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat('dd-MM-yyyy').format(_selectedDate ?? DateTime.now()),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                Text("Self Learning Entry Downloaded",style: TextStyle(
                    fontSize: 16,fontWeight: FontWeight.w600
                ),)
              ],
            ),
          ),
        ):

            provider.loading?
                SizedBox(width: 0,):
        SizedBox(
          width: size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min, // Ensures the BottomAppBar doesn't expand unnecessarily
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0,right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          DateFormat('dd-MM-yyyy').format(_selectedDate ?? DateTime.now()),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(width: 2),
                    SizedBox(
                      width: size.width*0.2,
                      child:
                      ElevatedButton(
                        onPressed: () async {
                          String stage = stageValue;
                          String course = courseValue;
                          String domain = domainValue;
                          String activity = activityValue;
                          String term = partValue;
                          String division = divisionValue;
                          String courseDomain = coursedomainvalue;

                          List<Map<String, dynamic>> studentEntries = provider.studententrieslist
                              .where((student) => student.isEdited! || student.learningEntryId != null)
                              .map((student) {
                            bool hasMarkChanged = student.studentLearnings!.values.any((studentLearning) {
                              return studentLearning.remarks != null && studentLearning.remarks!.isNotEmpty;
                            });

                            return {
                              "peerStudents": null,
                              "peerStudentId": student.peerStudentId,
                              "learningEntryId": student.learningEntryId,
                              "rollNo": student.rollNo,
                              "studentName": student.studentName,
                              "entryStaffName": student.entryStaffName,
                              "admissionNo": student.admissionNo,
                              "studentId": student.studentId,
                              "entryStatus": "Entered",
                              "isAttendanceDisabled": student.isAttendanceDisabled,
                              "isDisabled": student.isDisabled,
                              "isEdited": student.isEdited,
                              "entryDate": _selectedDate.toIso8601String(),
                              "studentLearnings": student.studentLearnings!.map((learningId, studentLearning) {
                                return MapEntry(
                                  learningId,
                                  {
                                    "remarks": studentLearning.remarks ?? "",
                                  },
                                );
                              }), // Flag to indicate mark change
                            };
                          }).toList();

                          // Check if there are any edited entries or if marks have changed
                          bool hasAnyChange = studentEntries.any((entry) =>
                          entry["isEdited"] == true );

                          if(studentEntries.isEmpty || hasAnyChange==false) {
                          // Show a message if there are no changes to save
                          ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                          content: Text(
                          'No change in self learning entry'),
                          duration: Duration(seconds: 2),
                          ),
                          );
                          }
                         else {
                            await provider.saveSelfLearningEntry(
                              context,
                              stage,
                              course,
                              domain,
                              activity,
                              term,
                              division,
                              courseDomain,
                              studentEntries,
                              _selectedDate.toIso8601String(),
                              relived_status,
                            );

                            // Reset isEdited flag after saving
                            for (var student in provider.studententrieslist) {
                              student.isEdited = false;
                            }
                            print("Entry status: ${provider.selfassessmententry?.entryStatus}");
                          }
                        },
                        child: Text('Save', style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: UIGuide.light_Purple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      )
                    ),

                    if (provider.selfassessmententry?.entryStatus == "Entered") ...[
                      SizedBox(width: 2),
                      SizedBox(
                        width: size.width*0.2,
                        child: ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              _isLoading = true;
                            });

                            String stage = stageValue;
                            String course = courseValue;
                            String domain = domainValue;
                            String activity = activityValue;
                            String term = partValue;
                            String division = divisionValue;
                            String courseDomain = coursedomainvalue;
                            List<Map<String, dynamic>> studentEntries = provider.studententrieslist
                                .where((student) =>  student.entryStatus == "Entered")
                                .map((student) {
                              return {
                                "peerStudents": null,
                                "peerStudentId": student.peerStudentId,
                                "learningEntryId": student.learningEntryId,
                                "rollNo": student.rollNo,
                                "studentName": student.studentName,
                                "entryStaffName": student.entryStaffName,
                                "admissionNo": student.admissionNo,
                                "studentId": student.studentId,
                                "entryStatus": "Verified",
                                "isAttendanceDisabled": student.isAttendanceDisabled,
                                "isDisabled": student.isDisabled,
                                "isEdited": student.isEdited,
                                "entryDate": _selectedDate.toIso8601String(), // Format the date appropriately
                                "studentLearnings": student.studentLearnings!.map((learningId, studentLearning) {
                                  // Transform each learning entry into a map
                                  return MapEntry(
                                    learningId,
                                    {
                                      "learningId": studentLearning.learningId.toString(),
                                      "remarks": studentLearning.remarks.toString()  // Handle null remarks
                                    },
                                  );
                                }), // Now passing as a Map
                              };
                            }).toList();


                            try {
                              await provider.verifySelfLearningEntry(
                                context,
                                stage,
                                course,
                                domain,
                                activity,
                                term,
                                division,
                                courseDomain,
                                studentEntries,
                                _selectedDate.toString(),
                                relived_status,
                                provider.selfassessmententry!.updatedStaff ?? "",
                              );
                            } catch (error) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Failed to verify selfassessment entry.')),
                              );
                            } finally {
                              setState(() {
                                _isLoading = false;
                              });
                            }
                          },
                          child: Text('Verify', style: TextStyle(color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 2),
                    ],


                    if (provider.selfassessmententry?.entryStatus == "Entered" || provider.selfassessmententry?.entryStatus == "Verified") ...[
                      SizedBox(
                        width: size.width * 0.2,
                        child: ElevatedButton(
                          onPressed: () async {
                            String stage = stageValue;
                            String course = courseValue;
                            String domain = domainValue;
                            String activity = activityValue;
                            String term = partValue;
                            String division = divisionValue;
                            String courseDomain = coursedomainvalue;

                            // Filter students whose statements have valid responseLevelId
                            List<Map<String, dynamic>> studentEntries = provider.studententrieslist
                                .where((student) =>  student.entryStatus == "Entered" || student.entryStatus == "Verified")
                                .map((student) {
                              return {
                                "peerStudents": null,
                                "peerStudentId": student.peerStudentId,
                                "learningEntryId": student.learningEntryId,
                                "rollNo": student.rollNo,
                                "studentName": student.studentName,
                                "entryStaffName": student.entryStaffName,
                                "admissionNo": student.admissionNo,
                                "studentId": student.studentId,
                                "entryStatus": "",
                                "isAttendanceDisabled": student.isAttendanceDisabled,
                                "isDisabled": student.isDisabled,
                                "isEdited": student.isEdited,
                                "entryDate": _selectedDate.toIso8601String(), // Format the date appropriately
                                "studentLearnings": student.studentLearnings!.map((learningId, studentLearning) {
                                  // Transform each learning entry into a map
                                  return MapEntry(
                                    learningId,
                                    {
                                      "learningId": studentLearning.learningId.toString(),
                                      "remarks": studentLearning.remarks.toString()  // Handle null remarks
                                    },
                                  );
                                }), // Now passing as a Map
                              };
                            }).toList();


                            await provider.deleteSelfLearningEntry(
                              context,
                              stage,
                              course,
                              domain,
                              activity,
                              term,
                              division,
                              courseDomain,
                              studentEntries,
                              _selectedDate.toString(),
                              relived_status,
                            );
                          },
                          child: Text('Delete', style: TextStyle(color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                      ),


                      SizedBox(width: 5),
                    ],
                  ],
                ),
              ),
            ],
          ),
        )
            : SizedBox.shrink(),
     ),

    );
  }
}
class CustomDropdownsButtonFormField extends StatelessWidget {
  final String? value;
  String? hint;
  final String label;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  CustomDropdownsButtonFormField({
    required this.value,
    this.hint,
    required this.label,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(

      crossAxisAlignment: CrossAxisAlignment.start, // Align the label to the start
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: Text(
            label, // Label for the dropdown
            style: TextStyle(
              fontSize: 12, // Adjust the size as needed
              //ontWeight: FontWeight.bold, // Make the label bold
            ),
          ),
        ),
        SizedBox(height: 0.5),
        DropdownButtonFormField<String>(
          value:value,
          onChanged: onChanged,
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,

              child: Text(item),
            );
          }).toList(),
          isExpanded: true,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: UIGuide.light_Purple
                  )
              )
          ),
        ),
      ],
    );
  }
}
