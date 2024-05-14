import 'package:essconnect/Application/AdminProviders/AppReviewProvider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../Constants.dart';
import '../../../../utils/TextWrap(moreOption).dart';
import '../../../../utils/constants.dart';
import '../../Domain/Admin/AppReviewModel.dart';


class AppReviewInitial extends StatelessWidget {
  const AppReviewInitial({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              const Spacer(),
              const Text('App Details'),
              const Spacer(),
              IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                            const AppReviewInitial()));
                  },
                  icon: const Icon(Icons.refresh))
            ],
          ),
          titleSpacing: 00.0,
          centerTitle: true,
          toolbarHeight: 45.2,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(25),
                bottomLeft: Radius.circular(25)),
          ),
          bottom: const TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Colors.white,
            indicatorWeight: 5,
            tabs: [
              Tab(
                text: "Installed",
              ),
              Tab(text: "Using"),

            ],
          ),
          backgroundColor: UIGuide.light_Purple,
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            AppInstalledOrNot(),
            AppUsedorNot(),

          ],
        ),
      ),
    );
  }
}
class AppInstalledOrNot extends StatefulWidget {
  const AppInstalledOrNot({super.key});

  @override
  State<AppInstalledOrNot> createState() => _AppInstalledOrNotState();
}

class _AppInstalledOrNotState extends State<AppInstalledOrNot> {

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

  String? types;

  String? phn;




  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
    _scrollController.addListener(_scrollListener);
      var p = Provider.of<AppReviewProvider>(context, listen: false);
      types="Installed";
      await p.setLoading(false);
    await p.setLoadingPage(false);
      // await p.clearInitial();
       await p.clearAllDetails();
      await p.getSectionInitial();

       p.studentViewList.clear();
      await p.getStudentViewList(section, course, division,types.toString());

      //
      // p.results.clear();
      // p.childName='';
      // p.childId='';
      // types='installed';
      // p.showDate=false;
      // p.setLoadingPage(false);
      // p.fromdateselect=DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day) ;
      // p.todateselect =DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day) ;
      // p.getDateNow();


    });
  }
  void _scrollListener() async {
    final provider =
    Provider.of<AppReviewProvider>(context, listen: false);
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (provider.hasMoreData()) {
        print("object");
        provider.getStudentViewListByPagination(
          section,
          course,
          division,
           types.toString()
        );
      }
    }
  }

  _makingPhoneCall(String phn) async {
    var url = Uri.parse("tel:$phn");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    var size= MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Consumer<AppReviewProvider>(
          builder: (context, value, _) =>
              Column(
                children:[

                  Consumer<AppReviewProvider>(
                    builder: (context, value, _) =>
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height: 45,
                                  child:
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
                                 value.studentViewList.clear();
                                      sectionData = [];
                                      divisionData.clear();
                                      courseData.clear();
                                      value.courseLen = 0;
                                      value.divisionLen = 0;

                                      for (var i = 0; i < results.length; i++) {
                                        AppreviewSection data =
                                        results[i] as AppreviewSection;
                                        print(data.text);
                                        print(data.value);
                                        sectionData.add(data.value);
                                        sectionData.map((e) => data.value);
                                        print("${sectionData.map((e) => data.value)}");
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
                                    value.studentViewList.clear();
                                      courseData = [];
                                      courseData.clear();
                                      value.divisionLen = 0;

                                      for (var a = 0; a < results.length; a++) {
                                        AppreviewCourse data =
                                        results[a] as AppreviewCourse;

                                        courseData.add(data.value);
                                        courseData.map((e) => data.value);
                                        print("${courseData.map((e) => data.value)}");
                                      }
                                      print('courseData course== $courseData');

                                      course = courseData
                                          .map((id) => id)
                                          .join(',');
                                      print(course);

                                      // cousse--Div

                                      courseToDiv = courseData
                                          .map((id) => '$id')
                                          .join(',');
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

                  Consumer<AppReviewProvider>(
                    builder: (context, value, _) =>
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0, right: 8),
                                child: SizedBox(
                                  height: 45,
                                  child:

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
                                  value.studentViewList.clear();
                                      divisionData = [];

                                      for (var i = 0; i < results.length; i++) {
                                        AppreviewDivision data =
                                        results[i] as AppreviewDivision;

                                        print(data.value);
                                        divisionData.add(data.value);
                                        divisionData.map((e) => data.value);
                                        print("${divisionData.map((e) => data.value)}");
                                      }
                                      print("divisionDataaaa    $divisionData");
                                      division = divisionData
                                          .map((id) => id)
                                          .join(',');
                                      print(division);
                                      await value.divisionCounter(results.length);
                                     // value.studentViewList.clear();
                                      results.clear();
                                      print("data div  $division");
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0,right: 8),
                                child: SizedBox(
                                 height: 45,
                                  child: value.loading
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
                                       child: Text("View") ,
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
                                        value.studentViewList.clear();
                                        value.currentPage = 2;


                                        await value.getStudentViewList(
                                          section,
                                          course,
                                          division,
                                          types.toString()
                                        );


                                        if (value.studentViewList.isEmpty) {
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
                                              behavior: SnackBarBehavior
                                                  .floating,
                                              content: Text(
                                                'No data for specified condition..!',
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          );
                                        }
                                      }
                                  ),
                                ),
                              ),
                            ),

                          ],
                        ),

                  ),


                  Consumer<AppReviewProvider>(
                    builder: (context, val, _) =>
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            GestureDetector(
                              onTap: () {

                                setState(() {
                                  types = "Installed";
                                  value.studentViewList.clear();
                                  val.currentPage=2;
                                  value.getStudentViewList(section, course, division, types.toString());
                                });
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [

                                  Radio(
                                    activeColor: UIGuide.light_Purple,
                                    value: 'Installed',
                                    groupValue: types,
                                    onChanged: (value) {
                                      setState(() {
                                        types = value.toString();
                                        val.studentViewList.clear();
                                        val.currentPage=2;
                                        val.getStudentViewList(section, course, division, types.toString());
                                      });
                                      print(types);
                                    },
                                  ),

                                  const Text(
                                    "Installed",
                                  ),
                                ],
                              ),
                            ),
                            kWidth,
                            GestureDetector(
                              onTap: () {

                                setState(() {
                                  types = "NotInstalled";
                                  value.studentViewList.clear();
                                  val.currentPage=2;
                                  value.getStudentViewList(section, course, division, types.toString());
                                });
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [

                                  Radio(
                                    activeColor: UIGuide.light_Purple,
                                    value: 'NotInstalled',
                                    groupValue: types,
                                    onChanged: (value) {
                                      setState(() {
                                        types = value.toString();
                                        val.studentViewList.clear();
                                        val.currentPage=2;
                                        val.getStudentViewList(section, course, division, types.toString());
                                      });
                                      print(types);
                                    },
                                  ),

                                  const Text(
                                    "Not Installed",
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),
                  ),



                  Consumer<AppReviewProvider>(
                      builder: (context, provider, _) =>

                          Expanded(

                                child:

                                Scrollbar(
                                      child: ListView.builder(
                                          controller: _scrollController,
                                          shrinkWrap: true,
                                          itemCount: provider.studentViewList.length,
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
                                                      // color: provider.results[index].diaryList[ind].isImportant==true?
                                                      // Color.fromARGB(255, 252, 249, 208)
                                                        //  :Colors.white
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
                                                                    "${ind+1}"
                                                                    ),
                                                                  ),
                                                                  decoration: BoxDecoration(

                                                                      color: UIGuide.THEME_LIGHT
                                                                  ),
                                                                ),
                                      
                                      
                                                                Text("Name : "),
                                                                SizedBox(
                                                                  width: size.width*0.6,
                                                                  child: Text(provider.studentViewList[ind].name.toString(),
                                                                    style: TextStyle(
                                                                        color: UIGuide.light_Purple
                                                                    ),
                                                                    overflow: TextOverflow.ellipsis,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.all(4),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Row(

                                                              children: [

                                                                Text("Admn No : "),
                                                                Text(provider.studentViewList[ind].admNo.toString(),
                                                                  style: TextStyle(
                                                                      color: UIGuide.light_Purple
                                                                  ),
                                                                ),
                                                              ],
                                                            ),

                                      
                                                          ],
                                                        ),
                                                      ),

                                                        Padding(
                                                        padding: const EdgeInsets.all(4),
                                                        child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                        Row(

                                                        children: [

                                                        Text("Class : "),
                                                              Text(
                                                                provider.studentViewList[ind].division==null?"":
                                                                provider.studentViewList[ind].division.toString(),
                                                                style: TextStyle(
                                                                    color: UIGuide.light_Purple
                                                                ),
                                                              overflow: TextOverflow.ellipsis,
                                                              ),
                                                        ],
                                                        )


                                                        ],
                                                        ),
                                                        ),
                                                                                                          Padding(
                                                        padding: const EdgeInsets.all(
                                                          4),
                                                        child: GestureDetector(
                                                          onTap: () async {
                                                            phn = provider
                                                                .studentViewList[
                                                            ind]
                                                                .mobNo ==
                                                                null
                                                                ? '--'
                                                                : provider
                                                                .studentViewList[
                                                            ind]
                                                                .mobNo
                                                                .toString();

                                                            _makingPhoneCall(
                                                                phn.toString());
                                                          },
                                                          child: Row(
                                                            children: [
                                                              const Text(
                                                                'Phone : ',
                                                              ),
                                                              RichText(
                                                                overflow: TextOverflow
                                                                    .ellipsis,
                                                                maxLines: 1,
                                                                strutStyle:
                                                                const StrutStyle(
                                                                    fontSize: 8.0),
                                                                text: TextSpan(
                                                                  style:
                                                                  const TextStyle(
                                                                    fontSize: 13,
                                                                    color: UIGuide.light_Purple,
                                                                  ),
                                                                  text: provider
                                                                      .studentViewList[
                                                                  ind]
                                                                      .mobNo ??
                                                                      '---',
                                                                ),
                                                              ),
                                                              kWidth5,
                                                              const Icon(
                                                                Icons.phone,
                                                                size: 17,

                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                      
                                                    ],
                                                  ),
                                                ),
                                              )
                                      
                                      ),
                                    ),




                          )

                  ),
                  // value.loadingPage
                  //     ? const Padding(
                  //
                  //   padding: EdgeInsets.all(15.0),
                  //   child: Row(
                  //     mainAxisSize: MainAxisSize.min,
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       SizedBox(
                  //         width: 30,
                  //         height: 30,
                  //         child: CircularProgressIndicator(
                  //           strokeWidth: 2,
                  //           color: UIGuide.light_Purple,
                  //         ),
                  //       ),
                  //       kWidth,
                  //       Text(
                  //         "Please Wait...",
                  //         style: TextStyle(
                  //             color: UIGuide.light_Purple,
                  //             fontWeight: FontWeight.w700,
                  //             fontSize: 16),
                  //       )
                  //     ],
                  //   ),
                  // )
                  //     : const SizedBox(
                  //   height: 0,
                  // )

                ],
              ),
        ),
      ),
    );
  }
}






class AppUsedorNot extends StatefulWidget {
  const AppUsedorNot({super.key});

  @override
  State<AppUsedorNot> createState() => _AppUsedorNotState();
}

class _AppUsedorNotState extends State<AppUsedorNot> {

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
 String? phn;




  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      _scrollController.addListener(_scrollListener);
      var p = Provider.of<AppReviewProvider>(context, listen: false);
      await p.setLoading(false);
      await p.setLoadingPage(false);
      // await p.clearInitial();
      await p.clearAllDetails();
      await p.getSectionInitial();

      p.studentViewList.clear();
      p.notused=false;
      p.usedornot ="Used";
      p.fromdateselect=DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day) ;
      p.todateselect =DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day) ;
      p.getDateNow();

    });
  }
  void _scrollListener() async {
    final provider =
    Provider.of<AppReviewProvider>(context, listen: false);
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (provider.hasMoreUserData()) {
        print("object");
        provider.getStudentUserViewListByPagination(
            section,
            course,
            division,
            provider.usedornot.toString()

        );
      }
    }
  }
  _makingPhoneCall(String phn) async {
    var url = Uri.parse("tel:$phn");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    var size= MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Consumer<AppReviewProvider>(
          builder: (context, value, _) =>
              Column(
                children:[

                  Consumer<AppReviewProvider>(
                    builder: (context, value, _) =>
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height: 45,
                                  child:
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
                                      value.studentUserViewList.clear();
                                      sectionData = [];
                                      divisionData.clear();
                                      courseData.clear();
                                      value.courseLen = 0;
                                      value.divisionLen = 0;

                                      for (var i = 0; i < results.length; i++) {
                                        AppreviewSection data =
                                        results[i] as AppreviewSection;
                                        print(data.text);
                                        print(data.value);
                                        sectionData.add(data.value);
                                        sectionData.map((e) => data.value);
                                        print("${sectionData.map((e) => data.value)}");
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
                                      value.studentUserViewList.clear();
                                      courseData = [];
                                      courseData.clear();
                                      value.divisionLen = 0;

                                      for (var a = 0; a < results.length; a++) {
                                        AppreviewCourse data =
                                        results[a] as AppreviewCourse;

                                        courseData.add(data.value);
                                        courseData.map((e) => data.value);
                                        print("${courseData.map((e) => data.value)}");
                                      }
                                      print('courseData course== $courseData');

                                      course = courseData
                                          .map((id) => id)
                                          .join(',');
                                      print(course);

                                      // cousse--Div

                                      courseToDiv = courseData
                                          .map((id) => '$id')
                                          .join(',');
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

                  Consumer<AppReviewProvider>(
                    builder: (context, value, _) =>
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0, right: 8),
                                child: SizedBox(
                                  height: 45,
                                  child:

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
                                      value.studentUserViewList.clear();
                                      divisionData = [];

                                      for (var i = 0; i < results.length; i++) {
                                        AppreviewDivision data =
                                        results[i] as AppreviewDivision;

                                        print(data.value);
                                        divisionData.add(data.value);
                                        divisionData.map((e) => data.value);
                                        print("${divisionData.map((e) => data.value)}");
                                      }
                                      print("divisionDataaaa    $divisionData");
                                      division = divisionData
                                          .map((id) => id)
                                          .join(',');
                                      print(division);
                                      await value.divisionCounter(results.length);
                                      // value.studentViewList.clear();
                                      results.clear();
                                      print("data div  $division");
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                  onTap: () async {
                                    value.notUsedCheckbox();
                                    value.studentUserViewList.clear();
                                  },
                                  child: Row(
                                    children: [
                                      Checkbox(
                                        activeColor: UIGuide.light_Purple,
                                        value: value.notused,
                                        onChanged: (newValue) async {
                                          value.notUsedCheckbox();

                                          value.studentUserViewList.clear();
                                        },
                                      ),
                                      const Expanded(
                                        //  width: size.width * .35,
                                        child: Text(
                                          "Not Used",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: UIGuide.BLACK, fontSize: 16),
                                        ),
                                      )
                                    ],
                                  )),
                            ),

                          ],
                        ),

                  ),
                  kheight10,
                  Row(
                    children: [
                      Text(" Last Updated Date Between",style: TextStyle(

                        color:  Colors.black
                      ),),
                    ],
                  ),
                  Consumer<AppReviewProvider>(
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
                                SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        elevation: 3,
                                        foregroundColor: UIGuide.BLACK,
                                        backgroundColor:
                                        UIGuide.ButtonBlue,
                                        padding: const EdgeInsets.all(0),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            side: const BorderSide(
                                              color: UIGuide.light_black,
                                            )),
                                      ),
                                      onPressed: () {

                                        value.getfromDate(context);
                                        value.studentUserViewList.clear();

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
                                        backgroundColor:
                                        UIGuide.ButtonBlue,
                                        padding: const EdgeInsets.all(0),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            side: const BorderSide(
                                              color: UIGuide.light_black,
                                            )),
                                      ),
                                      onPressed: () {

                                        value.gettoDate(context);
                                        value.studentUserViewList.clear();
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
                kheight10,
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0,right: 8),
                    child: SizedBox(
                      height: 45,
                      width: size.width*0.3,
                      child: value.loading
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
                          child: Text("View") ,
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
                            value.studentUserViewList.clear();
                            value.currentPage = 2;
                           print("date difference------");
                           print("from date ${value.fromdateselect}");
                            print("To date ${value.todateselect}");
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
                              await value.getStudentUserViewList(
                                section,
                                course,
                                division,
                                  value.usedornot.toString()
                              );

                            }


                            // await value.getStudentUserViewList(
                            //     section,
                            //     course,
                            //     division,
                            // );

                            if (value.studentUserViewList.isEmpty) {
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
                                  behavior: SnackBarBehavior
                                      .floating,
                                  content: Text(
                                    'No data for specified condition...!',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              );
                            }
                          }
                      ),
                    ),
                  ),




                  Consumer<AppReviewProvider>(
                      builder: (context, provider, _) =>

                          Expanded(

                            child:

                            Scrollbar(
                              child: ListView.builder(
                                  controller: _scrollController,
                                  shrinkWrap: true,
                                  itemCount: provider.studentUserViewList.length,
                                  itemBuilder: (context,ind) {
                                    DateTime originalDate = DateTime.parse(provider.studentUserViewList[ind].modifiedDate.toString());
                                    String formattedDate = DateFormat('dd-MM-yyyy').format(originalDate);


                                  return  Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Container(
                                        decoration: BoxDecoration(

                                          border: Border.all(
                                              width: 1,
                                              color: UIGuide.THEME_LIGHT
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8)),
                                          // color: provider.results[index].diaryList[ind].isImportant==true?
                                          // Color.fromARGB(255, 252, 249, 208)
                                          //  :Colors.white
                                        ),

                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(
                                                  4.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .spaceBetween,
                                                children: [

                                                  Row(

                                                    children: [
                                                      Container(

                                                        child: Padding(
                                                          padding: const EdgeInsets
                                                              .all(2.0),
                                                          child: Text(
                                                              "${ind + 1}"
                                                          ),
                                                        ),
                                                        decoration: BoxDecoration(

                                                            color: UIGuide
                                                                .THEME_LIGHT
                                                        ),
                                                      ),

                                                      Text("Name : "),
                                                      SizedBox(
                                                        width: size.width *
                                                            0.65,
                                                        child: Text(provider
                                                            .studentUserViewList[ind]
                                                            .name.toString(),
                                                          style: TextStyle(
                                                              color: UIGuide
                                                                  .light_Purple
                                                          ),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(4),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Row(

                                                    children: [

                                                      Text("Admn No : "),
                                                      Text(provider
                                                          .studentUserViewList[ind]
                                                          .admNo.toString(),
                                                        style: TextStyle(
                                                            color: UIGuide
                                                                .light_Purple
                                                        ),
                                                      ),
                                                    ],
                                                  ),


                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(4),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Row(

                                                    children: [

                                                      Text("Class : "),
                                                      Text(
                                                        provider
                                                            .studentUserViewList[ind]
                                                            .division == null
                                                            ? ""
                                                            :
                                                        provider
                                                            .studentUserViewList[ind]
                                                            .division
                                                            .toString(),
                                                        style: TextStyle(
                                                            color: UIGuide
                                                                .light_Purple
                                                        ),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ],
                                                  ),


                                                ],
                                              ),
                                            ),

                                            Padding(
                                              padding: const EdgeInsets.all(
                                                  4),
                                              child: GestureDetector(
                                                onTap: () async {
                                                  phn = provider
                                                      .studentUserViewList[
                                                  ind]
                                                      .mobNo ==
                                                      null
                                                      ? '--'
                                                      : provider
                                                      .studentUserViewList[
                                                  ind]
                                                      .mobNo
                                                      .toString();

                                                  _makingPhoneCall(
                                                      phn.toString());
                                                },
                                                child: Row(
                                                  children: [
                                                    const Text(
                                                      'Phone : ',
                                                    ),
                                                    RichText(
                                                      overflow: TextOverflow
                                                          .ellipsis,
                                                      maxLines: 1,
                                                      strutStyle:
                                                      const StrutStyle(
                                                          fontSize: 8.0),
                                                      text: TextSpan(
                                                        style:
                                                        const TextStyle(
                                                          fontSize: 13,
                                                          color: UIGuide.light_Purple,
                                                        ),
                                                        text: provider
                                                            .studentUserViewList[
                                                        ind]
                                                            .mobNo ??
                                                            '---',
                                                      ),
                                                    ),
                                                    kWidth5,
                                                    const Icon(
                                                      Icons.phone,
                                                      size: 17,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(
                                                  4.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Row(

                                                    children: [
                                                      Text(
                                                          "Last Updated Date : "),
                                                      Text(
                                                        provider
                                                            .studentUserViewList[ind]
                                                            .modifiedDate ==
                                                            null ? "" :
                                                        formattedDate
                                                            .toString(),
                                                        style: TextStyle(
                                                            color: UIGuide
                                                                .light_Purple
                                                        ),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),

                                                    ],
                                                  ),
                                                 value.notused==true?
                                                     SizedBox(height: 0,width: 0,):
                                                  Row(

                                                    children: [

                                                      Text("Count : "),
                                                      Text(provider
                                                          .studentUserViewList[ind]
                                                          .count.toString(),
                                                        style: TextStyle(
                                                            color: UIGuide
                                                                .light_Purple
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }

                              ),
                            ),
                          )

                  ),
                  value.loadingPage
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







