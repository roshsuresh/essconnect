
import 'package:essconnect/Domain/Staff/HPC/HPC_SelfProgressGrid_Model.dart';
import 'package:essconnect/utils/spinkit.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';


import 'package:provider/provider.dart';


import '../../../Application/Staff_Providers/HPC/SelfProgressGridProvider.dart';

import '../../../utils/constants.dart';


class SelfProgressGridEntry extends StatefulWidget {
  const SelfProgressGridEntry({super.key});

  @override
  State<SelfProgressGridEntry> createState() => _SelfProgressGridEntryState();
}

class _SelfProgressGridEntryState extends State<SelfProgressGridEntry> {
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

  List<ProgressGridProgressGridList> selectedItems = [];






  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var c = Provider.of<HPC_SelfProgressGrid_Provider>(context, listen: false);
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
    var provider = Provider.of<HPC_SelfProgressGrid_Provider>(context, listen: false);
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
    var provider = Provider.of<HPC_SelfProgressGrid_Provider>(context);
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 7, 68, 126),
        title: Text(
          "Self Progress Grid Entry",
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
                                  await provider.viewProgressGrid(
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
                          height: MediaQuery.of(context).size.height * 0.5,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                            itemCount: provider.studententrieslist.length,
                            itemBuilder: (context, index) {
                              final studentEntries = provider.studententrieslist[index];
                              final studentGridMap = studentEntries.progressGrids;
                              final List<String> learningIds = studentGridMap!.keys.toList();

                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey.withOpacity(0.5)),
                                    borderRadius: BorderRadius.circular(10),
                                    color: studentEntries.isEdited! ? Colors.yellow.withOpacity(0.3) : Colors.white,
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
                                                studentEntries.rollNo?.toString() ?? "",
                                                style: TextStyle(fontWeight: FontWeight.w500),
                                              ),
                                              SizedBox(width: 10),
                                              SizedBox(
                                                width: MediaQuery.of(context).size.width * 0.6,
                                                child: Text(
                                                  studentEntries.studentName ?? '',
                                                  style: TextStyle(
                                                    color: UIGuide.light_Purple,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.visibility, color: UIGuide.light_Purple),
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  final currentStudentId = studentEntries.studentId.toString();

                                                  Map<String, ValueNotifier<List<ProgressGridProgressGridList>>> selectedGridsMap = {};

                                                  for (var ability in provider.abilitylist) {
                                                    final preselectedGrids = provider.studententrieslist
                                                        .where((entry) => entry.studentId == currentStudentId)
                                                        .expand<ProgressGridProgressGridList>((entry) {
                                                      var studentAbility = entry.progressGrids![ability.ablityId];
                                                      final preselectedIds = studentAbility?.progressGridIdList ?? [];
                                                      return studentAbility?.progressGridList
                                                          ?.where((grid) => preselectedIds.contains(grid.progressGridId)) ??
                                                          <ProgressGridProgressGridList>[];
                                                    })
                                                        .toSet()
                                                        .toList();

                                                    selectedGridsMap[ability.ablityId!] = ValueNotifier<List<ProgressGridProgressGridList>>(preselectedGrids);
                                                  }


                                                  return AlertDialog(
                                                    title: Text('Statements'),
                                                    content: SingleChildScrollView(
                                                      child: Container(
                                                        width: double.maxFinite,
                                                        child: DefaultTabController(
                                                          length: provider.abilitylist.length,
                                                          child: Column(
                                                            mainAxisSize: MainAxisSize.min,
                                                            children: [
                                                              TabBar(
                                                                isScrollable: true,
                                                                indicatorColor: UIGuide.light_Purple,
                                                                labelColor: UIGuide.light_Purple,
                                                                unselectedLabelColor: Colors.grey,
                                                                tabs: provider.abilitylist.map((ability) {
                                                                  return Tab(
                                                                    child: Text(
                                                                      ability.ablityName ?? 'Unknown',
                                                                      textAlign: TextAlign.center,
                                                                    ),
                                                                  );
                                                                }).toList(),
                                                              ),
                                                              SizedBox(
                                                                height: 300.0,
                                                                child: TabBarView(
                                                                  children: provider.abilitylist.map((ability) {
                                                                    final progressGrids = provider.studententrieslist
                                                                        .where((entry) => entry.studentId == currentStudentId)
                                                                        .expand((entry) {
                                                                      var studentAbility = entry.progressGrids![ability.ablityId];
                                                                      return studentAbility?.progressGridList ?? [];
                                                                    }).toSet().toList();

                                                                    return SingleChildScrollView(
                                                                      child: Column(
                                                                        children: [
                                                                          SizedBox(height: 10),
                                                                          if (progressGrids.isEmpty)
                                                                            Text('No Progress Grids available for this ability.')
                                                                          else
                                                                            ...progressGrids.map((grid) {
                                                                              return ValueListenableBuilder<List<ProgressGridProgressGridList>>(
                                                                                valueListenable: selectedGridsMap[ability.ablityId!]!,
                                                                                builder: (context, selectedList, _) {
                                                                                  return CheckboxListTile(
                                                                                    checkColor: UIGuide.light_Purple ,
                                                                                    title: Text(grid.progressGridName ?? ''),
                                                                                    value: selectedList.contains(grid),
                                                                                    onChanged: (bool? checked) {
                                                                                      if (checked == true) {
                                                                                        selectedList.add(grid);
                                                                                      } else {
                                                                                        selectedList.remove(grid);
                                                                                      }

                                                                                      selectedGridsMap[ability.ablityId!]!.value = List.from(selectedList);

                                                                                      // Update the student's progress grids
                                                                                      final abilityId = ability.ablityId!;
                                                                                      final progressGrid = studentEntries.progressGrids![abilityId];

                                                                                      studentEntries.progressGrids![abilityId] = ProgressGrid(
                                                                                        abilityId: progressGrid!.abilityId,
                                                                                        progressGridIdList: selectedList.map((g) => g.progressGridId!).toList(),
                                                                                        progressGridList: progressGrid.progressGridList,
                                                                                      );

                                                                                      // Mark the entry as edited
                                                                                      studentEntries.isEdited = true;
                                                                                      provider.notifyListeners();  // Notify the provider to trigger UI updates
                                                                                    },
                                                                                  );
                                                                                },
                                                                              );
                                                                            }).toList(),
                                                                        ],
                                                                      ),
                                                                    );
                                                                  }).toList(),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
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
                                            width: MediaQuery.of(context).size.width * 0.8,
                                            child: Text(
                                              "Entry Staff : ${studentEntries.entryStaffName ?? ""}",
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
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width * 0.5,
                                            child: Text(
                                              "Entry Date : ${_formatDate(studentEntries.entryDate)}",
                                              style: TextStyle(
                                                color: UIGuide.light_Purple,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
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
                Text("Self Progress Grid Entry Downloaded",style: TextStyle(
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

                          // Filter only edited students
                          List<Map<String, dynamic>> studentEntries = provider.studententrieslist
                              .where((student) => student.isEdited!|| student.progressGridEntryId!=null)
                              .map((student) {
                            return {
                              "peerStudents": null,
                              "peerStudentId": student.peerStudentId,
                              "progressGridEntryId": student.progressGridEntryId,
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
                              "progressGrids": student.progressGrids!.map((ability, studentAbility) {
                                return MapEntry(
                                  ability,
                                  {
                                    "abilityId": studentAbility.abilityId ?? "",
                                    "progressGridIdList": studentAbility.progressGridIdList ?? [], // Ensure we're getting the complete list
                                    "progressGridList": studentAbility.progressGridList!.map((grid) => grid.toJson()).toList(),
                                  },
                                );
                              }),
                            };
                          }).toList();



                          print("Edited studenst engrtries: $studentEntries");

                          if (studentEntries.isNotEmpty) {
                            await provider.saveSelfProgressGridEntry(
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
                              relived_status, // Make sure relived_status is defined in your context
                            );

                            // Reset isEdited flag after saving
                            for (var student in provider.studententrieslist) {
                              student.isEdited = false;
                            }
                            print("entry statusssssssssssss");
                            print(provider.selfassessmententry?.entryStatus);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('No change in self progress grid entry'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          }
                        },
                        child: Text('Save',style: TextStyle(
                            color: Colors.white
                        ),),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:UIGuide.light_Purple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),



                    ),


                    // Conditionally rendered buttons
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

                            List<Map<String, dynamic>> studentEntries = provider.studententrieslist.map((student) {
                              return {
                                "peerStudents": null,
                                "peerStudentId": student.peerStudentId,
                                "progressGridEntryId": student.progressGridEntryId,
                                "rollNo": student.rollNo,
                                "studentName": student.studentName,
                                "entryStaffName": student.entryStaffName,
                                "admissionNo": student.admissionNo,
                                "studentId": student.studentId,
                                "entryStatus": "Verified",
                                "isAttendanceDisabled": student.isAttendanceDisabled,
                                "isDisabled": student.isDisabled,
                                "isEdited": student.isEdited,
                                "entryDate": _selectedDate.toIso8601String(),
                                "progressGrids": student.progressGrids!.map((ability, studentAbility) {
                                  return MapEntry(
                                    ability,
                                    {
                                      "abilityId": studentAbility.abilityId ?? "",
                                      "progressGridIdList": studentAbility.progressGridIdList ?? [], // Ensure we're getting the complete list
                                      "progressGridList": studentAbility.progressGridList!.map((grid) => grid.toJson()).toList(),
                                    },
                                  );
                                }),
                              };
                            }).toList();

                            try {
                              await provider.verifySelfProgressGridEntry(
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
                    //
                    //
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
                                "progressGridEntryId": student.progressGridEntryId,
                                "rollNo": student.rollNo,
                                "studentName": student.studentName,
                                "entryStaffName": student.entryStaffName,
                                "admissionNo": student.admissionNo,
                                "studentId": student.studentId,
                                "entryStatus": "",
                                "isAttendanceDisabled": student.isAttendanceDisabled,
                                "isDisabled": student.isDisabled,
                                "isEdited": student.isEdited,
                                "entryDate": _selectedDate.toIso8601String(),
                                "progressGrids": student.progressGrids!.map((ability, studentAbility) {
                                  return MapEntry(
                                    ability,
                                    {
                                      "abilityId": studentAbility.abilityId ?? "",
                                      "progressGridIdList": studentAbility.progressGridIdList ?? [], // Ensure we're getting the complete list
                                      "progressGridList": studentAbility.progressGridList!.map((grid) => grid.toJson()).toList(),
                                    },
                                  );
                                }),
                              };
                            }).toList();

                            await provider.deleteSelfProgressGridEntry(
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
                    //
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
  void _showProgressGridDialog(BuildContext context, int index) {
    var provider = Provider.of<HPC_SelfProgressGrid_Provider>(context, listen: false);
    Map<String, ProgressGrid>? progressGridMap = provider.studententrieslist[index].progressGrids;
    List<ProgressGrid>? progressGridList = progressGridMap?.values.toList();

    if (progressGridList == null || progressGridList.isEmpty) {
      print("No progress grids available.");
      return;
    }

    List<String> progressGridList1 = progressGridList[index].progressGridIdList ?? [];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Progress Grids'),
          content: Container(
            width: double.maxFinite,
            child: DefaultTabController(
              length: progressGridList.length,
              child: Column(
                children: [
                  TabBar(
                    tabs: progressGridList.map((grid) => Tab(text: grid.abilityId ?? '')).toList(),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: progressGridList.map((grid) {
                        // Prepare items for MultiSelectDropdown
                        List<MultiSelectItem> dropdownItems = grid.progressGridList?.map((item) {
                          return MultiSelectItem(item.progressGridId ?? "", item.progressGridName ?? "");
                        }).toList() ?? [];

                        return MultiSelectDropdown(
                          items: dropdownItems,
                          initialValue: progressGridList1,
                          onChanged: (List<String> selectedValues) {
                            // Check if any selected value matches with progressGridList1
                            final matchingValues = selectedValues.where((value) => progressGridList1.contains(value)).toList();
                            if (matchingValues.isNotEmpty) {
                              print("Matching Values: $matchingValues for ${grid.abilityId}");
                            } else {
                              print("No matching values found for ${grid.abilityId}.");
                            }
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
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
class MultiSelectDropdown extends StatefulWidget {
  final List<MultiSelectItem> items;
  final List<String> initialValue;
  final Function(List<String>) onChanged;

  MultiSelectDropdown({
    required this.items,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  _MultiSelectDropdownState createState() => _MultiSelectDropdownState();
}

class _MultiSelectDropdownState extends State<MultiSelectDropdown> {
  List<String> selectedValues = [];

  @override
  void initState() {
    super.initState();
    // Set the initial selected values
    selectedValues = List.from(widget.initialValue);
  }

  void _showMultiSelectDialog(BuildContext context) async {
    final result = await showDialog<List<String>>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Items'),
          content: Container(
            width: double.maxFinite,
            child: ListView(
              children: widget.items.map((item) {
                return CheckboxListTile(
                  title: Text(item.name),
                  value: selectedValues.contains(item.id),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value == true) {
                        selectedValues.add(item.id);
                      } else {
                        selectedValues.remove(item.id);
                      }
                    });
                  },
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              child: Text('Done'),
              onPressed: () {
                Navigator.of(context).pop(selectedValues);
              },
            ),
          ],
        );
      },
    );

    if (result != null) {
      widget.onChanged(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showMultiSelectDialog(context),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: 'Select Items',
          border: OutlineInputBorder(),
        ),
        child: Text(selectedValues.isNotEmpty
            ? selectedValues.join(', ')
            : 'No items selected'),
      ),
    );
  }
}

class MultiSelectItem {
  final String id;
  final String name;

  MultiSelectItem(this.id, this.name);
}