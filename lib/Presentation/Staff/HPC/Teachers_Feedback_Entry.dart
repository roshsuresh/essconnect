import 'package:essconnect/utils/constants.dart';
import 'package:essconnect/utils/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:collection/collection.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';

import '../../../Application/Staff_Providers/HPC/FeedbackProvider.dart';
import '../../../Domain/Staff/HPC/HPc_Feedback_Model.dart';








class HpcEntry extends StatefulWidget {
  const HpcEntry({super.key});

  @override
  State<HpcEntry> createState() => _HpcEntryState();
}

class _HpcEntryState extends State<HpcEntry> {
  String? selectedStage;
  String stageValue = "";

  String? selectedterm;
  String termValue = "";

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
      var c = Provider.of<Hpcprovider>(context, listen: false);
      c.stagelist.clear();
      c.courselist.clear();
      c.termlist.clear();
      c.divisionslist.clear();
      c.domainlist.clear();
      c.activitylist.clear();
      c.feedbackentry=null;
      await c.stagelistfn(context);

    });
  }
  void _reset() {
    var provider = Provider.of<Hpcprovider>(context, listen: false);
    setState(() {
      selectedStage = null;
      selectedCourse = null;
      selectedDomain = null;
      selectedDivision = null;
      selectedterm = null;
      selectedActivity = null;
      selectedterm=null;

      provider.courselist.clear();
      provider.domainlist.clear();
      provider.divisionslist.clear();
      provider.activitylist.clear();
      provider.termlist.clear();
      provider.studententrieslist.clear();
      showListView=false;
      // showListView = false;
      stageValue = "";
      courseValue = "";
      domainValue = "";
      coursedomainvalue = "";
      divisionValue = "";
      activityValue = "";
      termValue = "";

      relived_status = false;
      // provider.sectionlistfn(context);
      // Reinitialize with one card by default
    });
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var provider = Provider.of<Hpcprovider>(context);
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 7, 68, 126),
        title: Text(
          "Teacher's Feedback Entry",
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

                              selectedCourse = null;
                              courseValue = "";
                              selectedDomain = null;
                              domainValue = "";
                              coursedomainvalue = "";
                              selectedDivision = null;
                              divisionValue = "";
                              selectedActivity = null;
                              activityValue = "";
                              termValue = "";
                              selectedterm = null;
                              provider.studententrieslist.clear();
                              showListView = false;
                              selectedStage = value;

                              print("valueeeeeee");
                              print(courseValue);
                              print(divisionValue);
                              print(domainValue);
                              print(activityValue);
                              print(termValue);
                            });

                            stageValue = provider.stagelist
                                .firstWhere((section) => section.text == value)
                                .value!;
                            provider.courselist.clear();
                            provider.divisionslist.clear();
                            provider.domainlist.clear();
                            provider.activitylist.clear();
                            provider.termlist.clear();
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
                              termValue="";
                              selectedterm=null;
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
                            provider.termlist.clear();
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
                              termValue="";
                              selectedterm=null;
                              provider.studententrieslist.clear();
                              showListView=false;
                              selectedDivision = value;
                            });

                            divisionValue = provider.divisionslist
                                .firstWhere((section) => section.text == value)
                                .value!;
                            provider.domainlist.clear();
                            provider.activitylist.clear();
                            provider.termlist.clear();

                            await provider.domainlistfn(context, courseValue,divisionValue);

                          },
                        ),
                      ),// Division Dropdown
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
                              termValue="";
                              selectedterm=null;
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
                            provider.termlist.clear();
                            await provider.activitylistfn(context, coursedomainvalue);
                          },
                        ),
                      ),// Domain Dropdown
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
                              termValue="";
                              selectedterm=null;
                              provider.studententrieslist.clear();
                              showListView=false;
                            });

                            activityValue = provider.activitylist
                                .firstWhere((section) => section.text == value)
                                .value!;
                            provider.termlist.clear();
                            await provider.termlistfn(
                                stageValue,
                                courseValue,
                                divisionValue,
                                domainValue,
                                activityValue,
                                false,
                                coursedomainvalue);

                          },
                        ),
                      ),// Activity Dropdown
                      SizedBox(
                        width: size.width * .45,
                        height: size.height * .06,
                        child: DropdownButtonFormField<String>(
                          isExpanded: true,
                          value:  selectedterm,
                          hint: Text('Select Term'),
                          items: provider.termlist
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
                              selectedterm=value;
                              provider.studententrieslist.clear();
                              showListView=false;
                            });

                            termValue = provider.termlist
                                .firstWhere((section) => section.text == value)
                                .value!;

                          },
                        ),
                      ),// Term Dropdown
                    ],
                  ),
                  SizedBox(height: 6),
                  provider.feedbackentry == null || provider.feedbackentry!.updatedStaff == null||showListView==false
                      ? SizedBox(height: 0, width: 0)
                      : Text(
                    "Entered By: ${provider.feedbackentry!.updatedStaff.toString()}",
                    style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
                    overflow: TextOverflow.ellipsis,
                  ),

                  provider.feedbackentry != null&&showListView==true && (provider.feedbackentry!.entryStatus == "Verified" ||provider.feedbackentry!.entryStatus == "Synchronized")
                      ? Text(
                    "Verified By: ${provider.feedbackentry!.verifyStaff.toString()}",
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
                                selectedterm==null
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
                                      termValue,
                                      divisionValue,
                                      search,
                                      relived_status,
                                      coursedomainvalue);
                                  setState(() {
                                    showListView = true;
                                  });
                                  print(provider.feedbackentry!.entryDate);
                                  _selectedDate=DateTime.now();

                                  if (provider.feedbackentry!.entryDate !=
                                      null) {
                                    DateTime dateTime = DateTime.parse(
                                        provider.feedbackentry!.entryDate
                                            .toString());
                                    print("dddsasasrrrrr $dateTime");

                                    _selectedDate = dateTime;
                                  }
                                  print("erntry dateeeee $_selectedDate");
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
                               return Padding(
                                 padding: const EdgeInsets.symmetric(vertical: 8.0),
                                 child: Container(
                                   padding: EdgeInsets.all(8),
                                   decoration: BoxDecoration(
                                     border: Border.all(color: Colors.grey.withOpacity(0.5)),
                                     borderRadius: BorderRadius.circular(10),
                                   ),
                                   child: Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
                                       Row(
                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                         children: [
                                           Row(
                                             children: [
                                               Text(
                                                 provider.studententrieslist[index].rollNo==null?"":
                                                 provider.studententrieslist[index].rollNo.toString() ,
                                               style: TextStyle(
                                                   fontWeight: FontWeight.w500
                                               ),
                                               ),
                                               SizedBox(width: 10),
                                               SizedBox(
                                                 width: size.width*0.7,
                                                 child: Text(
                                                   provider.studententrieslist[index].studentName.toString(),
                                                   style: TextStyle(color: UIGuide.light_Purple,
                                                   fontWeight: FontWeight.w500
                                                   ),
                                                   overflow: TextOverflow.ellipsis,
                                                 ),
                                               ),
                                             ],
                                           ),
                                           Padding(
                                             padding: const EdgeInsets.only(left: 10.0),
                                             child: GestureDetector(
                                               onTap: () {
                                                 setState(() {
                                                   // Toggle attendance
                                                   provider.studententrieslist[index].attendance =
                                                   provider.studententrieslist[index].attendance == 'A' ? 'P' : 'A';

                                                   // Mark as edited
                                                   provider.studententrieslist[index].isEdited = true;
                                                 });
                                               },
                                               child: Container(
                                                 width: 28,
                                                 height: 26,
                                                 child: provider.studententrieslist[index].attendance == 'A'
                                                     ? SvgPicture.asset("assets/aa.svg")
                                                     : SvgPicture.asset("assets/ppp.svg"),
                                               ),
                                             ),
                                           ),
                                         ],
                                       ),
                                       SizedBox(
                                         width: size.width * 0.85,
                                         child: Wrap(
                                           spacing: 16.0,
                                           runSpacing: 16.0,
                                           children: List.generate(provider.abilitylist.length, (ind) {
                                             Ablities? studentAbility = provider.studententrieslist[index].studentAblity?.firstWhereOrNull(
                                                   (ability) => ability.ablityId == provider.abilitylist[ind].ablityId,
                                             );

                                             String? selectedAbilityResponse;
                                             if (studentAbility != null && studentAbility.responseLevelId != null) {
                                               selectedAbilityResponse = provider.responseslist
                                                   .firstWhere(
                                                     (response) => response.value == studentAbility.responseLevelId,
                                                 orElse: () => Responses(value: '', text: ''),
                                               )
                                                   .text;
                                             }

                                             // Check if the student is absent
                                             bool isAbsent = provider.studententrieslist[index].attendance == 'A';

                                             return SizedBox(
                                               width: size.width * 0.4,
                                               child: CustomDropdownsButtonFormField(
                                                 value: isAbsent ? null : selectedAbilityResponse, // Clear value if absent
                                                 label: provider.abilitylist[ind].ablityName.toString(),
                                                 items: isAbsent
                                                     ? [] // No items if the student is absent
                                                     : provider.responseslist.map((response) => response.text!).toList(),
                                                 onChanged: isAbsent
                                                     ? (value) {} // No-op function if the dropdown is disabled
                                                     : (value) {
                                                   setState(() {
                                                     if (studentAbility != null) {
                                                       // Update the responseLevelId based on the selected dropdown value
                                                       studentAbility.responseLevelId = provider.responseslist
                                                           .firstWhere((response) => response.text == value)
                                                           .value;

                                                       // Mark as edited
                                                       provider.studententrieslist[index].isEdited = true;
                                                     }
                                                   });
                                                 },
                                               ),
                                             );
                                           })
                                           // Add Note Button aligned with the dropdowns
                                             ..add(
                                               Padding(
                                                 padding: const EdgeInsets.only(top: 15.0),
                                                 child: SizedBox(
                                                   width: size.width * 0.4,
                                                   // Same width as dropdowns for alignment
                                                   child: IconButton(
                                                     icon: Icon(Icons.note_alt_outlined),
                                                     color: provider.studententrieslist[index].attendance == 'A'?
                                                     UIGuide.THEME_LIGHT:
                                                     UIGuide.light_Purple,
                                                     onPressed: () {
                                                      if(provider.studententrieslist[index].attendance == 'A'){
                                                        null;
                                                      }
                                                      else {
                                                        // Initialize the controller with the student's existing note (if any)
                                                        TextEditingController noteController = TextEditingController(
                                                          text: provider
                                                              .studententrieslist[index]
                                                              .teacherObservation ??
                                                              '', // Load existing note
                                                        );

                                                        showDialog(
                                                          context: context,
                                                          builder: (
                                                              BuildContext context) {
                                                            return AlertDialog(
                                                              title: const Text(
                                                                  'Add Note',
                                                                  style: TextStyle(
                                                                      fontWeight: FontWeight
                                                                          .w500,
                                                                      fontSize: 18)),
                                                              content: Container(
                                                                width: double
                                                                    .maxFinite,
                                                                child: TextField(
                                                                  controller: noteController,
                                                                  // Attach controller with current note value
                                                                  maxLines: 3,
                                                                  decoration: InputDecoration(
                                                                    hintText: 'Enter your note here',
                                                                    border: OutlineInputBorder(),
                                                                    contentPadding: const EdgeInsets
                                                                        .all(
                                                                        8.0),

                                                                    focusedBorder: OutlineInputBorder(
                                                                      borderSide: BorderSide(
                                                                        color: UIGuide.light_Purple
                                                                      )
                                                                    )
                                                                  ),
                                                                ),
                                                              ),
                                                              actions: [
                                                                TextButton(


                                                                 child: Text(
                                                                      'OK',style: TextStyle(
                                                                    color: Colors.white
                                                                  ),),
                                                                  onPressed: () async {
                                                                    setState(() {
                                                                      // Save the note for the current student
                                                                      provider
                                                                          .studententrieslist[index]
                                                                          .teacherObservation =
                                                                          noteController
                                                                              .text;

                                                                      // Mark as edited
                                                                      provider
                                                                          .studententrieslist[index]
                                                                          .isEdited =
                                                                      true;
                                                                    });

                                                                    // Close the dialog after saving the note
                                                                    Navigator
                                                                        .of(
                                                                        context)
                                                                        .pop();
                                                                  },
                                                                  style: TextButton.styleFrom(
                                                                    backgroundColor: UIGuide.light_Purple
                                                                  )
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      }
                                                     },
                                                   ),
                                                 ),
                                               ),
                                             ),
                                         ),
                                       )

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
        provider.feedbackentry?.entryStatus == "Synchronized"?
        SizedBox(
          height: 50,
          child:
          Padding(
            padding: const EdgeInsets.only(left: 10.0,right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat('dd-MM-yyyy').format(_selectedDate),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                Text("Feedback Entry Downloaded",style: TextStyle(
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
                child:

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          DateFormat('dd-MM-yyyy').format(_selectedDate),
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
                          String term = termValue;
                          String division = divisionValue;
                          String courseDomain = coursedomainvalue;

                          // Filter only edited students
                          List<Map<String, dynamic>> studentEntries = provider.studententrieslist
                              .where((student) => student.isEdited!)
                              .map((student) {
                            return {
                              "teacherObservation": student.teacherObservation,
                              "rollNo": student.rollNo,
                              "studentName": student.studentName,
                              "admissionNo": student.admissionNo,
                              "studentId": student.studentId,
                              "attendance": student.attendance,
                              "teacherFeedbackEntryStudentId": student.teacherFeedbackEntryStudentId,
                              "studentAblity": student.studentAblity?.map((ability) {
                                final Ablities abilityDetails = provider.abilitylist.firstWhere(
                                      (a) => a.ablityId == ability.ablityId,
                                  orElse: () => Ablities(ablityId: ability.ablityId, ablityName: 'Unknown', ablityOrder: 0),
                                );
                                return {
                                  "ablityId": ability.ablityId,
                                  "ablityName": abilityDetails.ablityName,
                                  "ablityOrder": abilityDetails.ablityOrder,
                                  "responseLevelId": ability.responseLevelId,
                                };
                              }).toList(),
                            };
                          }).toList();

                          // Check for no absent students and all responseLevelId being null
                          bool hasNoAbsentStudents = provider.studententrieslist.every((student) => student.attendance == 'P');
                          bool allStudentsHaveNullResponse = provider.studententrieslist.every((student) =>
                          student.studentAblity?.every((ability) => ability.responseLevelId == null) ?? true);

                          if (hasNoAbsentStudents && allStudentsHaveNullResponse) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('No data to save...'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                            return;
                          }

                          print("Edited student entries: $studentEntries");

                          if (studentEntries.isNotEmpty) {
                            await provider.saveFeedbackEntry(
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
                              provider.feedbackentry!.teacherFeedBackEntryId == null ? "" : provider.feedbackentry!.teacherFeedBackEntryId.toString(),
                            );

                            // Reset isEdited flag after saving
                            for (var student in provider.studententrieslist) {
                              student.isEdited = false;
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('No change in feedback entry'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          }
                        },
                        child: Text('Save', style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 7, 68, 126),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),



                    ),

                    // Conditionally rendered buttons
                    if (provider.feedbackentry?.entryStatus == "Entered") ...[
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
                            String term = termValue;
                            String division = divisionValue;
                            String courseDomain = coursedomainvalue;

                            List<Map<String, dynamic>> studentEntries = provider.studententrieslist.map((student) {
                              return {
                                "teacherObservation": student.teacherObservation,
                                "rollNo": student.rollNo,
                                "studentName": student.studentName,
                                "admissionNo": student.admissionNo,
                                "studentId": student.studentId,
                                "attendance": student.attendance,
                                "teacherFeedbackEntryStudentId": student.teacherFeedbackEntryStudentId,
                                "studentAblity": student.studentAblity?.map((ability) {
                                  final Ablities abilityDetails = provider.abilitylist.firstWhere(
                                        (a) => a.ablityId == ability.ablityId,
                                    orElse: () => Ablities(ablityId: ability.ablityId, ablityName: 'Unknown', ablityOrder: 0),
                                  );
                                  return {
                                    "ablityId": ability.ablityId,
                                    "ablityName": abilityDetails.ablityName,
                                    "ablityOrder": abilityDetails.ablityOrder,
                                    "responseLevelId": ability.responseLevelId,
                                  };
                                }).toList(),
                              };
                            }).toList();

                            try {
                              await provider.verifyFeedbackEntry(
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
                                provider.feedbackentry!.teacherFeedBackEntryId ?? "",
                                provider.feedbackentry!.updatedStaff ?? "",
                              );
                            } catch (error) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Failed to verify feedback entry.')),
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


                    if (provider.feedbackentry?.entryStatus == "Entered" || provider.feedbackentry?.entryStatus == "Verified") ...[
                      SizedBox(
                        width: size.width*0.2,
                        child: ElevatedButton(
                          onPressed: () async {
                            String stage = stageValue;
                            String course = courseValue;
                            String domain = domainValue;
                            String activity = activityValue;
                            String term = termValue;
                            String division = divisionValue;
                            String courseDomain = coursedomainvalue;

                            List<Map<String, dynamic>> studentEntries = provider.studententrieslist.map((student) {
                              return {
                                "teacherObservation": student.teacherObservation,
                                "rollNo": student.rollNo,
                                "studentName": student.studentName,
                                "admissionNo": student.admissionNo,
                                "studentId": student.studentId,
                                "attendance": student.attendance,
                                "teacherFeedbackEntryStudentId": student.teacherFeedbackEntryStudentId,
                                "studentAblity": student.studentAblity?.map((ability) {
                                  final Ablities abilityDetails = provider.abilitylist.firstWhere(
                                        (a) => a.ablityId == ability.ablityId,
                                    orElse: () => Ablities(ablityId: ability.ablityId, ablityName: 'Unknown', ablityOrder: 0),
                                  );
                                  return {
                                    "ablityId": ability.ablityId,
                                    "ablityName": abilityDetails != null ? abilityDetails.ablityName : null,
                                    "ablityOrder": abilityDetails != null ? abilityDetails.ablityOrder : null,
                                    "responseLevelId": ability.responseLevelId,
                                  };
                                }).toList(),
                              };
                            }).toList();

                            await provider.deleteFeedbackEntry(
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
                              provider.feedbackentry!.teacherFeedBackEntryId.toString(),
                              provider.feedbackentry!.updatedStaff.toString(),
                              provider.feedbackentry!.verifyStaff.toString(),
                              provider.feedbackentry!.entryStatus.toString(),
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
