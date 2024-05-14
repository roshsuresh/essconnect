import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:provider/provider.dart';
import '../../../../Application/Staff_Providers/Anecdotal/AncedotalStaffProvider.dart';
import '../../../../Constants.dart';
import '../../../../Debouncer.dart';
import '../../../../Domain/Staff/Anecdotal/InitialSelectionModel.dart';
import '../../../../utils/TextWrap(moreOption).dart';
import '../../../../utils/constants.dart';
import '../../../../utils/spinkit.dart';



class AnecdotalReport extends StatefulWidget {
  const AnecdotalReport({super.key});

  @override
  State<AnecdotalReport> createState() => _AnecdotalReportState();
}

class _AnecdotalReportState extends State<AnecdotalReport> {

  List sectionData = [];
  List courseData = [];
  List divisionData = [];
  List categoryData =[];
  String section = '';
  String course = "";
  String category="";
  String sectionToCourse = '';
  String courseToDiv = '';
  String division = '';



  final ScrollController _scrollController = ScrollController();




  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      _scrollController.addListener(_scrollListener);
      var p = Provider.of<AnecdotalStaffProviders>(context, listen: false);
      await p.setLoading(false);
      await p.clearInitial();
      await p.clearAllDetails();
     await p.getSectionInitial();
      await p.getCategorySubject();
       p.results.clear();
       p.childName='';
       p.childId='';
       p.showDate=false;
       p.setLoadingPage(false);
      p.fromdateselect=DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day) ;
      p.todateselect =DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day) ;
       p.getDateNow();


    });
  }
  void _scrollListener() async {
    final provider =
    Provider.of<AnecdotalStaffProviders>(context, listen: false);
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (provider.hasMoreReportData()) {
        print("object");
         provider.showDate?
           await provider.getReportDataByPaginationbyDate(
               section,
               course, division,
               provider.childId,
               category,
               provider.fromdateSend,
               provider.todateSend,
               provider.isimportant,
               provider.includeterminated)      :



        provider.getReportDataByPagination(
            section,
            course,
            division,
           provider.childId,
            category,
          provider.isimportant,
          provider.includeterminated,
        );
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    var size= MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Consumer<AnecdotalStaffProviders>(
    builder: (context, value, _) =>
    Column(
            children:[
              Row(
              children: [

                Expanded(
                  child: SizedBox(
                    height: 45,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(
                          color: UIGuide.light_black,
                        ),
                      ),
                      elevation: 5,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(

                                value.childName==''?"Select Student":
                            value.childName
                            ,

                            style: const TextStyle(
                                color: UIGuide.BLACK,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                SizedBox(
                  height: 38,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 3,
                        foregroundColor: UIGuide.BLACK,
                        backgroundColor: UIGuide.ButtonBlue,
                        padding: const EdgeInsets.all(0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(
                            color: UIGuide.light_black,
                          ),
                        ),
                      ),
                      onPressed: () {

                            Navigator.push(context, MaterialPageRoute(builder: (context)=> StudentListAnecdotalReport(childId: value.childName)));
                      },
                      child: const Icon(Icons.list_alt)),
                )
              ],
            ),
                 Consumer<AnecdotalStaffProviders>(
               builder: (context, value, _) =>
           Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 45,
                          child:

                          value.childId!=''?
                              TextField(
                                enabled: false,
                                decoration: InputDecoration(
                                  labelText: "Section"
                                ),
                                onTap: (){},
                              ):
                          MultiSelectDialogField(
                            items: value.sectiondropDown,
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
                            decoration: const BoxDecoration(
                              color: UIGuide.ButtonBlue,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0, 2),
                                  blurRadius: 4,
                                  spreadRadius: 0,
                                ),
                              ],
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                            ),
                            buttonIcon: const Icon(
                              Icons.arrow_drop_down_outlined,
                              color: Colors.grey,
                            ),
                            buttonText: value.sectionLen == 0
                                ? const Text(
                              "Select Section",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            )
                                : Text(
                              "   ${value.sectionLen.toString()} Selected",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                            chipDisplay: MultiSelectChipDisplay.none(),
                            onConfirm: (results) async {
                              value.results.clear();
                              sectionData = [];
                              divisionData.clear();
                              courseData.clear();
                              value.courseLen = 0;
                              value.divisionLen = 0;

                              for (var i = 0; i < results.length; i++) {
                                SectionsModel data =
                                results[i] as SectionsModel;
                                print(data.name);
                                print(data.id);
                                sectionData.add(data.id);
                                sectionData.map((e) => data.id);
                                print("${sectionData.map((e) => data.id)}");
                              }
                              section = sectionData
                                  .map((id) => id)
                                  .join(',');
                              await value.clearCourse();
                              await value.clearDivision();
                              course = '';
                              courseToDiv = '';
                              division = '';
                              sectionToCourse = sectionData.join(',');
                              await value.getCourseList(sectionToCourse);

                              print(section);
                              await value.sectionCounter(results.length);
                            },
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 45,
                          child:
                          value.childId!=''?
                          TextField(
                            enabled: false,
                            decoration: InputDecoration(
                                labelText: "Course"
                            ),
                            onTap: (){},
                          ):
                          MultiSelectDialogField(
                            items: value.coursedropDown,
                            listType: MultiSelectListType.CHIP,
                            title: const Text(
                              "Select Course",
                              style: TextStyle(color: Colors.black),
                            ),
                            selectedItemsTextStyle: const TextStyle(
                                fontSize: 12,
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
                            decoration: const BoxDecoration(
                              color: UIGuide.ButtonBlue,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0, 2),
                                  blurRadius: 4,
                                  spreadRadius: 0,
                                ),
                              ],
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                            ),
                            buttonIcon: const Icon(
                              Icons.arrow_drop_down_outlined,
                              color: Colors.grey,
                            ),
                            buttonText: value.courseLen == 0
                                ? const Text(
                              "Select Course",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            )
                                : Text(
                              "   ${value.courseLen.toString()} Selected",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                            chipDisplay: MultiSelectChipDisplay.none(),
                            onConfirm: (results) async {
                              value.results.clear();
                              courseData = [];
                              courseData.clear();
                              value.divisionLen = 0;

                              for (var a = 0; a < results.length; a++) {
                                SectionsModel data =
                                results[a] as SectionsModel;

                                courseData.add(data.id);
                                courseData.map((e) => data.id);
                                print("${courseData.map((e) => data.id)}");
                              }
                              print('courseData course== $courseData');

                              course = courseData
                                  .map((id) => id)
                                  .join(',');
                              print(course);

                              // cousse--Div

                              courseToDiv = courseData
                                  .map((id) => 'getDivisionValues=$id')
                                  .join('&');
                              division = '';

                              await value.courseCounter(results.length);
                              results.clear();
                              await value.clearDivision();
                              await value.getDivisionList(courseToDiv);

                              print("course   $course");
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Consumer<AnecdotalStaffProviders>(
                builder: (context, value, _) =>
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8),
                            child: SizedBox(
                              height: 45,
                              child:
                              value.childId!=''?
                              TextField(
                                enabled: false,
                                decoration: InputDecoration(
                                    labelText: "Division"
                                ),
                                onTap: (){},
                              ):
                              MultiSelectDialogField(
                                items: value.divisiondropDown,
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
                                decoration: const BoxDecoration(
                                  color: UIGuide.ButtonBlue,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      offset: Offset(0, 2),
                                      blurRadius: 4,
                                      spreadRadius: 0,
                                    ),
                                  ],
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                                ),
                                buttonIcon: const Icon(
                                  Icons.arrow_drop_down_outlined,
                                  color: Colors.grey,
                                ),
                                buttonText: value.divisionLen == 0
                                    ? const Text(
                                  "Select Division",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                )
                                    : Text(
                                  "   ${value.divisionLen.toString()} Selected",
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                                chipDisplay: MultiSelectChipDisplay.none(),
                                onConfirm: (results) async {
                                  value.results.clear();
                                  divisionData = [];

                                  for (var i = 0; i < results.length; i++) {
                                    SectionsModel data =
                                    results[i] as SectionsModel;

                                    print(data.id);
                                    divisionData.add(data.id);
                                    divisionData.map((e) => data.id);
                                    print("${divisionData.map((e) => data.id)}");
                                  }
                                  print("divisionDataaaa    $divisionData");
                                  division = divisionData
                                      .map((id) => id)
                                      .join(',');
                                  print(division);
                                  await value.divisionCounter(results.length);
                                  value.studentViewList.clear();
                                  results.clear();
                                  print("data div  $division");
                                },
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 45,
                              child: MultiSelectDialogField(
                                items: value.categorydropDown,
                                listType: MultiSelectListType.CHIP,
                                title: const Text(
                                  "Remarks Category",
                                  style: TextStyle(color: Colors.black),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                selectedItemsTextStyle: const TextStyle(
                                    fontSize: 12,
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
                                decoration: const BoxDecoration(
                                  color: UIGuide.ButtonBlue,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      offset: Offset(0, 2),
                                      blurRadius: 4,
                                      spreadRadius: 0,
                                    ),
                                  ],
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                                ),
                                buttonIcon: const Icon(
                                  Icons.arrow_drop_down_outlined,
                                  color: Colors.grey,
                                ),
                                buttonText: value.categoryLen == 0
                                    ? const Text(
                                  "Category",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                )
                                    : Text(
                                  "   ${value.categoryLen.toString()} Selected",
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                                chipDisplay: MultiSelectChipDisplay.none(),
                                onConfirm: (results) async {
                                  value.results.clear();
                                  categoryData = [];

                                  for (var i = 0; i < results.length; i++) {
                                    CategorySubjectModel data =
                                    results[i] as CategorySubjectModel;

                                    print(data.value);
                                    categoryData.add(data.value);
                                    categoryData.map((e) => data.value);
                                    print("${categoryData.map((e) => data.value)}");
                                  }
                                  print("categorydataaaaa    $categoryData");
                                  category = categoryData
                                      .map((id) => id)
                                      .join(',');
                                  print(division);
                                  print(category);
                                  await value.categoryCounter(results.length);
                                  value.studentViewList.clear();
                                  results.clear();
                                  print("data category  $category");
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

              ),
              Consumer<AnecdotalStaffProviders>(
              builder: (context, value, _) =>
              Container(

               decoration: BoxDecoration(
                 border:Border.all(
                   color: Colors.grey,
                   width: 0.8
                 )
               ),
                child: Row(
                  children: [
                    Checkbox(
                      activeColor: UIGuide.light_Purple,
                      value: value.showDate,
                      onChanged: (newValue) async {
                        value.isshowdateCheckbox();
                        value.results.clear();
                      },
                    ),
                    Expanded(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 3,
                            foregroundColor: UIGuide.BLACK,
                            backgroundColor: value.showDate?
                            UIGuide.ButtonBlue:
                            Colors.white70,
                            padding: const EdgeInsets.all(0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: const BorderSide(
                                  color: UIGuide.light_black,
                                )),
                          ),
                          onPressed: () {
                            value.showDate?
                            value.getfromDate(context):
                            null
                            ;
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.calendar_month_outlined,
                                color: Colors.grey,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              // Text("Date: "),
                              Text(value.fromdateDisplay==''?

                              value.fromdateSend:value.fromdateDisplay),
                              kWidth,
                              const SizedBox(
                                width: 5,
                              ),
                            ],
                          )),
                    ),
                    kWidth,
                    Expanded(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 3,
                            foregroundColor: UIGuide.BLACK,
                            backgroundColor: value.showDate?
                            UIGuide.ButtonBlue:
                            Colors.white70,
                            padding: const EdgeInsets.all(0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: const BorderSide(
                                  color: UIGuide.light_black,
                                )),
                          ),
                          onPressed: () {
                            value.showDate?
                            value.gettoDate(context):
                            null
                            ;
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.calendar_month_outlined,
                                color: Colors.grey,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              // Text("Date: "),
                              Text(value.todateDisplay==''?

                              value.todateSend:value.todateDisplay),
                              kWidth,
                              const SizedBox(
                                width: 5,
                              ),
                            ],
                          )),
                    ),
                    kWidth,

                  ],
                ),
              )
                  ),
                 Consumer<AnecdotalStaffProviders>(
           builder: (context, value, _) =>
               Row(
                 children: [
                   Expanded(
                     child: InkWell(
                         onTap: () async {
                           value.isimportantCheckbox();
                           value.results.clear();
                         },
                         child: Row(
                           children: [
                             Checkbox(
                               activeColor: UIGuide.light_Purple,
                               value: value.isimportant,
                               onChanged: (newValue) async {
                                 value.isimportantCheckbox();
                                 value.results.clear();
                               },
                             ),
                             const Expanded(
                               //  width: size.width * .35,
                               child: Text(
                                 "Show Important Entries Only",
                                 maxLines: 2,
                                 overflow: TextOverflow.ellipsis,
                                 style: TextStyle(
                                     color: UIGuide.BLACK, fontSize: 12),
                               ),
                             )
                           ],
                         )),
                   ),
                   // kWidth,
                   Expanded(
                     child: InkWell(
                         onTap: () async {
                           value.istrminatedCheckbox();
                           value.results.clear();
                         },
                         child: Row(
                           children: [
                             Checkbox(
                               activeColor: UIGuide.light_Purple,
                               value: value.includeterminated,
                               onChanged: (newValue) async {
                                 value.istrminatedCheckbox();
                                 value.results.clear();
                               },
                             ),
                             const Expanded(
                               //  width: size.width * .35,
                               child: Text(
                                 "Include Relieved Students",
                                 maxLines: 2,
                                 overflow: TextOverflow.ellipsis,
                                 style: TextStyle(
                                     color: UIGuide.BLACK, fontSize: 12),
                               ),
                             )
                           ],
                         )),
                   ),
                 ],
               ),
              ),
              Consumer<AnecdotalStaffProviders>(
              builder: (context, value, _) =>
          Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 150,
                      child: value.loadingPage
                          ? Container(
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.circular(10),
                            border: Border.all(
                                color: UIGuide.light_Purple,
                                width: 1),
                          ),
                          child: const Center(
                              child: Text(
                                "Loading...",
                                style: TextStyle(
                                    color: UIGuide.light_Purple,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              )))
                          : ElevatedButton(
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
                          onPressed: () async {
                            value.results.clear();
                         value.currentPage = 2;

                         if( value.showDate ==true)
                         {
                           if(value.fromdateselect!.isAfter(value.todateselect!))
                             {
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
                                       bottom: 80,
                                       left: 30,
                                       right: 30),
                                   behavior: SnackBarBehavior.floating,
                                   content: Text(
                                     'Invalid Date Range...',
                                     textAlign: TextAlign.center,
                                   ),
                                 ),
                               );
                             }
                           else {
                             await value.getReportViewByDate(
                                 section,
                                 course,
                                 division,
                                 value.childId,
                                 category,
                                 value.fromdateSend,
                                 value.todateSend,
                                 value.isimportant,
                                 value.includeterminated);
                           }

                         }
                         else{

                       await    value.getReportView(
                               section,
                               course,
                               division,
                               value.childId,
                               category,
                               value.isimportant,
                               value.includeterminated
                           );
                         }


                            if (value.results.isEmpty) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(
                                const SnackBar(
                                  elevation: 10,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10)),
                                  ),
                                  duration: Duration(seconds: 1),
                                  margin: EdgeInsets.only(
                                      bottom: 80,
                                      left: 30,
                                      right: 30),
                                  behavior: SnackBarBehavior.floating,
                                  content: Text(
                                    'No data for specified condition..!',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              );
                            }


                          },
                          child: const Text("View")),
                    ),
                   kWidth,
                   Row(children: [
                     Container(
                       height: 20,
                         width: 20,
                       color:   Color.fromARGB(255, 252, 249, 208),
                     ),
                     Text("Important")
                   ],)
                  ],
                ),
              ),




              Consumer<AnecdotalStaffProviders>(
                builder: (context, provider, _) =>

                     Expanded(
                      child: ListView.builder(
                        controller: _scrollController,
                        shrinkWrap: true,
                        itemCount: provider.results.length,
                        itemBuilder: (context, index) {
                          DateTime date = DateTime.parse(provider.results[index].date.toString());
                          String formattedDate = DateFormat('dd-MM-yyyy').format(date);
                          return Column(
                            children: [
                               Row(
                                 mainAxisAlignment: MainAxisAlignment.start,
                                 children: [
                                   Container(
                                     child: Padding(
                                       padding: const EdgeInsets.all(3.0),
                                       child: Text(formattedDate),),
                                      decoration: BoxDecoration(
                                        border: Border.all(width: 1, color: Colors.black12),
                                        borderRadius: BorderRadius.all(Radius.circular(8)),
                                        color: UIGuide.THEME_LIGHT),
                                   ),
                                 ],),
                              kheight5,
                              ListView.builder(
                                shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: provider.results[index].diaryList.length,
                                  itemBuilder: (context,ind)=>

                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Container(
                                          decoration: BoxDecoration(

                                              border: Border.all(
                                                  width: 1,
                                                  color: UIGuide.THEME_LIGHT
                                              ),
                                            borderRadius: BorderRadius.all(Radius.circular(8)),
                                            color: provider.results[index].diaryList[ind].isImportant==true?
                                               Color.fromARGB(255, 252, 249, 208)
                                                :Colors.white
                                          ),

                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(4.0),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [

                                                    Row(

                                                      children: [
                                                        Container(

                                                          child:Padding(
                                                            padding: const EdgeInsets.all(2.0),
                                                            child: Text(
                                                                provider.results[index].diaryList[ind].slNo.toString()),
                                                          ),
                                                          decoration: BoxDecoration(

                                                              color: UIGuide.THEME_LIGHT
                                                          ),
                                                        ),


                                                        Text("Name : "),
                                                        Text(provider.results[index].diaryList[ind].name.toString(),
                                                          style: TextStyle(
                                                              color: UIGuide.light_Purple
                                                          ),
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ],
                                                    ),



                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(4.0),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Row(

                                                      children: [

                                                        Text("Admn No: "),
                                                        Text(provider.results[index].diaryList[ind].admissionNo.toString(),
                                                          style: TextStyle(
                                                              color: UIGuide.light_Purple
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(

                                                      children: [
                                                        Text("Class : "),
                                                        Text(
                                                          provider.results[index].diaryList[ind].division==null?"":
                                                          provider.results[index].diaryList[ind].division.toString(),
                                                          style: TextStyle(
                                                              color: UIGuide.light_Purple
                                                          ),),
                                                      ],
                                                    ),
                                                    Row(

                                                      children: [
                                                        Text("Roll No : "),
                                                        Text(
                                                            provider.results[index].diaryList[ind].rollNo==null?"":
                                                          provider.results[index].diaryList[ind].rollNo.toString(),
                                                          style: TextStyle(
                                                              color: UIGuide.light_Purple
                                                          ),),
                                                      ],
                                                    ),

                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 4.0),
                                                child: Row(

                                                  children: [
                                                    Text("Category : "),
                                                    Expanded(
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(top:4.0),
                                                        child: TextWrapper(
                                                          text: provider.results[index].diaryList[ind]
                                                              .remarksCategory ==
                                                              null
                                                              ? '--'
                                                              : provider.results[index].diaryList[ind]
                                                              .remarksCategory
                                                              .toString(),
                                                          fSize: 14,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 4.0),
                                                child: Row(

                                                  children: [
                                                    Text("Subject : "),
                                                    Expanded(
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(top:4.0),
                                                        child: TextWrapper(
                                                          text: provider.results[index].diaryList[ind]
                                                              .subject ==
                                                              null
                                                              ? '--'
                                                              : provider.results[index].diaryList[ind]
                                                              .subject
                                                              .toString(),
                                                          fSize: 14,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                              Padding(
                                                padding: const EdgeInsets.all(4.0),
                                                child: Row(

                                                  children: [
                                                    Text("Remarks By: "),
                                                    Text(provider.results[index].diaryList[ind].remarksBy.toString(),
                                                      style: TextStyle(
                                                          color: UIGuide.light_Purple
                                                      ),
                                                        overflow: TextOverflow.ellipsis
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(4.0),
                                                child: Row(

                                                  children: [
                                                    Text("Created By : "),
                                                    Text(provider.results[index].diaryList[ind].createdBy.toString(),
                                                      style: TextStyle(
                                                          color: UIGuide.light_Purple
                                                      ),
                                                        overflow: TextOverflow.ellipsis
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 4.0),
                                                child: Row(

                                                  children: [
                                                    Text("Remarks : "),
                                                    Expanded(
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(top:4.0),
                                                        child: TextWrapper(
                                                          text: provider.results[index].diaryList[ind]
                                                              .remarks ==
                                                              null
                                                              ? '--'
                                                              : provider.results[index].diaryList[ind]
                                                              .remarks
                                                              .toString(),
                                                          fSize: 14,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )

                              ),
                              kheight10,

                            ],
                          );
                        },
                      ),
                    )

              ),

              ],
          ),
        ),
      ),
    );
  }
}

class StudentListAnecdotalReport extends StatefulWidget {
   StudentListAnecdotalReport({super.key,required this.childId});
  String childId;

  @override
  State<StudentListAnecdotalReport> createState() =>
      _StudentListAnecdotalReportState();
}

class _StudentListAnecdotalReportState extends State<StudentListAnecdotalReport> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      _scrollController.addListener(_scrollListener);
      var p = Provider.of<AnecdotalStaffProviders>(context, listen: false);
      await p.setLoading(false);
      await p.clearAllDetails();
       await p.getStudentReportViewList();



    });
  }

  void _scrollListener() async {
    final provider =
    Provider.of<AnecdotalStaffProviders>(context, listen: false);
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (provider.hasMoreStudentData()) {
        print("object");

        await provider.getStudentReportViewListBypagination();
      }
    }
  }

  List sectionData = [];
  List courseData = [];
  List divisionData = [];
  String section = '';
  String course = "";
  String sectionToCourse = '';
  String courseToDiv = '';
  String division = '';
  final controller = TextEditingController();

  final _debouncer = Debouncer(milliseconds: 1000);

  @override
  Widget build(BuildContext context) {
    var size =MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Consumer<AnecdotalStaffProviders>(
          builder: (context,prov,_)=>
          Column(
            children: [
              kheight10,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.grey,
                        )),
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: TextField(
                          focusNode: FocusNode(),
                          autofocus: true,
                          controller: controller,
                          onChanged: (value) {
                            _debouncer.run(() async {
                              await Provider.of<AnecdotalStaffProviders>(context,
                                  listen: false)
                                  .clearStudList();
                              await Provider.of<AnecdotalStaffProviders>(context,
                                  listen: false)
                                  .getStudentReportViewListByName(value);
                              print('-***--**-*-*-*-*-*');
                            });
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            suffixIcon: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.close),
                                  color: Colors.grey,
                                  onPressed: (() async{
                                    controller.clear();

                                    await Provider.of<AnecdotalStaffProviders>(context,
                                        listen: false)
                                        .clearStudList();
                                    await Provider.of<AnecdotalStaffProviders>(context,
                                        listen: false)
                                        .getStudentReportViewListByName('');
                                  }),
                                ),
                              ],
                            ),
                            hintText: 'Search By Name',
                            hintStyle: const TextStyle(
                              color: Colors.grey,
                              fontSize: 20,
                            ),
                            fillColor: UIGuide.light_black,
                            filled: true,
                            //  contentPadding: EdgeInsets.only(left: 8),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                              const BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: const BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          style: const TextStyle(color: UIGuide.light_Purple),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Consumer<AnecdotalStaffProviders>(
                    builder: (context, provider, child) {

                      if (provider.studentViewListReport.isEmpty) {
                        Future.delayed(const Duration(seconds: 2));
                        return provider.loading
                            ? spinkitLoader()
                            : Center(
                          child: LottieBuilder.network(
                              'https://assets2.lottiefiles.com/private_files/lf30_lkquf6qz.json'),
                        );
                      }
                      return provider.loading
                          ? spinkitLoader()
                          : ListView.builder(
                        controller: _scrollController,
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: provider.studentViewListReport.isEmpty
                            ? 0
                            : provider.studentViewListReport.length,
                        itemBuilder: (context, index) {
                          return Column(
                           // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              kheight10,
                              GestureDetector(
                                onTap: () {
                                  widget.childId=
                                      provider.studentViewListReport[index].id.toString();
                                  provider.childId =  provider.studentViewListReport[index].id.toString();
                                  provider.childName =  provider.studentViewListReport[index].name.toString();
                                  Navigator.pop(context);
                                  Provider.of<AnecdotalStaffProviders>(context,listen: false).getCategorySubject();

                                },
                                child: Container(
                                  width: size.width - 15,
                                  decoration:  BoxDecoration(
                                      color: UIGuide.light_black,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Padding(
                                    padding:  EdgeInsets.all(8.0),
                                    child: Column(
                                      // crossAxisAlignment:
                                      // CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [

                                            Row(
                                              children: [
                                                Text("Name: ",style: TextStyle(
                                                  fontSize: 12
                                                ),),
                                                RichText(
                                                  overflow:
                                                  TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  strutStyle: const StrutStyle(
                                                      fontSize: 8.0),
                                                  text: TextSpan(
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                        color: UIGuide
                                                            .light_Purple,

                                                      ),
                                                      text: provider
                                                          .studentViewListReport[
                                                      index]
                                                          .name ??
                                                          '---'),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text("Adm No: ",style: TextStyle(
                                                    fontSize: 12
                                                ),),
                                                RichText(
                                                  overflow:
                                                  TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  strutStyle: const StrutStyle(
                                                      fontSize: 8.0),
                                                  text: TextSpan(
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                        color: UIGuide
                                                            .light_Purple,

                                                      ),
                                                      text: provider
                                                          .studentViewListReport[
                                                      index]
                                                          .admNo ??
                                                          '---'),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [

                                            Row(
                                              children: [
                                                Text("Div: ",style: TextStyle(
                                                    fontSize: 12
                                                ),),
                                                RichText(
                                                  overflow:
                                                  TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  strutStyle:  StrutStyle(
                                                      fontSize: 8.0),
                                                  text: TextSpan(
                                                    style:  TextStyle(
                                                      fontSize: 11,

                                                      color: UIGuide.light_Purple,
                                                    ),
                                                    text: provider
                                                        .studentViewListReport[
                                                    index]
                                                        .division ??
                                                        '---',
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text("Roll No: ",style: TextStyle(
                                                    fontSize: 12
                                                ),),
                                                RichText(
                                                  overflow:
                                                  TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  strutStyle:  StrutStyle(
                                                      fontSize: 8.0),
                                                  text: TextSpan(
                                                    style:  TextStyle(
                                                      fontSize: 11,

                                                      color: UIGuide.light_Purple,
                                                    ),
                                                    text: provider
                                                        .studentViewListReport[
                                                    index]
                                                        .rollNo ??
                                                        '---',
                                                  ),
                                                ),
                                              ],
                                            ),


                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }),
              ),

              prov.loadingPage
                  ? const Padding(

                padding: EdgeInsets.all(15.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 30,
                      height: 30,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: UIGuide.light_Purple,
                      ),
                    ),
                    kWidth,
                    Text(
                      "Please Wait...",
                      style: TextStyle(
                          color: UIGuide.light_Purple,
                          fontWeight: FontWeight.w700,
                          fontSize: 16),
                    )
                  ],
                ),
              )
                  : const SizedBox(
                height: 0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
