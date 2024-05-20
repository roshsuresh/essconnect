// import 'package:essconnect/Application/AdminProviders/NotificationToGuardian.dart';
// import 'package:essconnect/Constants.dart';
// import 'package:essconnect/Domain/Staff/ToGuardian.dart';
// import 'package:essconnect/utils/constants.dart';
// import 'package:essconnect/utils/spinkit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:lottie/lottie.dart';
// import 'package:multi_select_flutter/multi_select_flutter.dart';
// import 'package:provider/provider.dart';
// import '../../../Application/AdminProviders/SchoolPhotoProviders.dart';
// import '../../../Application/Staff_Providers/Notification_ToGuardianProvider.dart';
// import '../../../Domain/Staff/StudentReport_staff.dart';
// import '../../../Domain/Staff/ToGuardian_TextSMS.dart';
//
// class AdminToGuardian extends StatelessWidget {
//   AdminToGuardian({Key? key}) : super(key: key);
//   String? valuee;
//   bool checked = true;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Row(
//           children: [
//             const Spacer(),
//             const Text(
//               'Communication to Guardian',
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//             ),
//             const Spacer(),
//             IconButton(
//                 onPressed: () {
//                   Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => AdminToGuardian()));
//                 },
//                 icon: const Icon(Icons.refresh_outlined)),
//             kWidth
//           ],
//         ),
//         titleSpacing: 5.0,
//         centerTitle: true,
//         toolbarHeight: 60,
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//               bottomRight: Radius.circular(25),
//               bottomLeft: Radius.circular(25)),
//         ),
//         backgroundColor: UIGuide.light_Purple,
//       ),
//       body: Notification_AdminToGuardain(),
//     );
//   }
// }
//
// //Notification To guard
//
// class Notification_AdminToGuardain extends StatefulWidget {
//   Notification_AdminToGuardain({Key? key}) : super(key: key);
//
//   @override
//   State<Notification_AdminToGuardain> createState() =>
//       _Notification_AdminToGuardainState();
// }
//
// class _Notification_AdminToGuardainState
//     extends State<Notification_AdminToGuardain> {
//   // @override
//   List subjectData = [];
//
//   List diviData = [];
//
//   List courseData = [];
//
//   String course = '';
//
//   String section = '';
//   int length = 0;
//   String division = '';
//
//   String types = "sms";
//   String courseSection = '';
//   String sectionData = '';
//   String divisionSection = '';
//
//
//   divClearr() {
//     diviData.clear();
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
//       var p = await Provider.of<SchoolPhotoProviders>(context, listen: false);
//       p.stdReportSectionStaff();
//       p.courseDrop.clear();
//       p.divisionDrop.clear();
//       p.dropDown.clear();
//       p.stdReportInitialValues.clear();
//       p.courselist.clear();
//       p.divisionlist.clear();
//       p.courseCounter(0);
//
//       p.divisionCounter(0);
//       p.sectionCounter(0);
//       section='';
//       division = '';
//       course = '';
//       courseSection = '';
//       sectionData = '';
//       divisionSection = '';
//
//       await Provider.of<NotificationToGuardianAdmin>(context, listen: false)
//           .clearStudentList();
//     });
//   }
//
//   final ScrollController _scrollController = ScrollController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Consumer<NotificationToGuardianAdmin>(
//         builder: (context, val, _) => Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Consumer<SchoolPhotoProviders>(
//
//                   builder: (context, value, child) => value.loadingSection
//                       ? const Expanded(child: Center(child: Text('Loading...')))
//                       : Expanded(
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: SizedBox(
//                               height: 45,
//                               child: MultiSelectDialogField(
//                                 items: value.dropDown,
//                                 listType: MultiSelectListType.CHIP,
//                                 title: const Text(
//                                   "Select Section",
//                                   style: TextStyle(color: Colors.grey),
//                                 ),
//                                 selectedItemsTextStyle: const TextStyle(
//                                     fontWeight: FontWeight.w900,
//                                     color: UIGuide.light_Purple),
//                                 confirmText: const Text(
//                                   'OK',
//                                   style: TextStyle(color: UIGuide.light_Purple),
//                                 ),
//                                 cancelText: const Text(
//                                   'Cancel',
//                                   style: TextStyle(color: UIGuide.light_Purple),
//                                 ),
//                                 separateSelectedItems: true,
//                                 decoration: const BoxDecoration(
//                                   color: UIGuide.ButtonBlue,
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: Colors.grey,
//                                       offset: Offset(0, 2),
//                                       blurRadius: 4,
//                                       spreadRadius: 0,
//                                     ),
//                                   ],
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(10)),
//                                 ),
//                                 buttonIcon: const Icon(
//                                   Icons.arrow_drop_down_outlined,
//                                   color: Colors.grey,
//                                 ),
//                                 buttonText: value.sectionLen == 0
//                                     ? const Text(
//                                         "Select Section",
//                                         style: TextStyle(
//                                           color: Colors.black,
//                                           fontSize: 16,
//                                         ),
//                                       )
//                                     : Text(
//                                         "   ${value.sectionLen.toString()} Selected",
//                                         style: const TextStyle(
//                                           color: Colors.black,
//                                           fontSize: 16,
//                                         ),
//                                       ),
//                                 chipDisplay: MultiSelectChipDisplay.none(),
//                                 onConfirm: (results) async {
//                                   value.stdReportInitialValues.clear();
//                                   subjectData = [];
//                                   value.dropDown.clear();
//                                   section='';
//                                   diviData.clear();
//                                   courseData.clear();
//
//                                   value.courseLen = 0;
//                                   value.divisionLen = 0;
//                                   await Provider.of<SchoolPhotoProviders>(
//                                           context,
//                                           listen: false)
//                                       .clearCourse();
//                                   await Provider.of<SchoolPhotoProviders>(
//                                           context,
//                                           listen: false)
//                                       .clearDivision();
//
//                                   await Provider.of<
//                                               NotificationToGuardianAdmin>(
//                                           context,
//                                           listen: false)
//                                       .clearStudentList();
//
//                                   for (var i = 0; i < results.length; i++) {
//                                     StudReportSectionList data =
//                                         results[i] as StudReportSectionList;
//                                     print(data.text);
//                                     print(data.value);
//                                     subjectData.add(data.value);
//                                     subjectData.map((e) => data.value);
//                                     print(
//                                         "${subjectData.map((e) => data.value)}");
//                                   }
//                                   section = subjectData.join(',');
//                                   await Provider.of<SchoolPhotoProviders>(
//                                           context,
//                                           listen: false)
//                                       .sectionCounter(results.length);
//
//                                   await Provider.of<SchoolPhotoProviders>(
//                                           context,
//                                           listen: false)
//                                       .getCourseList(section);
//                                   await Provider.of<SchoolPhotoProviders>(
//                                       context,
//                                       listen: false)
//                                       .getDivisonSectionList(section);
//                                   print("data $section");
//
//                                   print(subjectData.join(','));
//
//
//
//                                   List crs=[];
//                                   for (var k = 0; k < value.courselist.length; k++) {
//
//                                     crs.add(value.courselist[k].value);
//
//                                   }
//                                   print(crs);
//                                   course='';
//                                   course = crs.join(',');
//                                   print(course);
//
//
//                                   List dvnss=[];
//                                   dvnss.clear();
//                                   print('linniiiii');
//                                   print(dvnss);
//                                   print(value.divisionSectionlist.length);
//
//                                   for (var j = 0; j < value.divisionSectionlist.length; j++)
//                                   {
//
//                                     dvnss.add(value.divisionSectionlist[j].value);
//
//                                   }
//                                   print("rossshhh");
//                                   print(dvnss);
//                                   division='';
//                                   division = dvnss.join(',');
//                                   print(division);
//
//
//                                   print(subjectData.join(','));
//                                   // value.setLoading(false);
//
//                                   print("data $subjectData");
//
//                                   print(subjectData.join(','));
//
//                                 },
//                               ),
//                             ),
//                           ),
//                         ),
//                 ),
//                 // kWidth,
//                 Consumer<SchoolPhotoProviders>(
//                   builder: (context, value, child) => value.loadingCourse
//                       ? const Expanded(
//                           // width: size.width * .43,
//                           // height: 50,
//                           child: Center(child: Text('Loading...')))
//                       : Expanded(
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: SizedBox(
//                               height: 45,
//                               child: MultiSelectDialogField(
//                                 items: value.courseDrop,
//                                 listType: MultiSelectListType.CHIP,
//                                 title: const Text(
//                                   "Select Course",
//                                   style: TextStyle(color: Colors.black),
//                                 ),
//                                 selectedItemsTextStyle: const TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w900,
//                                     color: UIGuide.light_Purple),
//                                 confirmText: const Text(
//                                   'OK',
//                                   style: TextStyle(color: UIGuide.light_Purple),
//                                 ),
//                                 cancelText: const Text(
//                                   'Cancel',
//                                   style: TextStyle(color: UIGuide.light_Purple),
//                                 ),
//                                 separateSelectedItems: true,
//                                 decoration: const BoxDecoration(
//                                   color: UIGuide.ButtonBlue,
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: Colors.grey,
//                                       offset: Offset(0, 2),
//                                       blurRadius: 4,
//                                       spreadRadius: 0,
//                                     ),
//                                   ],
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(10)),
//                                 ),
//                                 buttonIcon: const Icon(
//                                   Icons.arrow_drop_down_outlined,
//                                   color: Colors.grey,
//                                 ),
//                                 buttonText: value.courseLen == 0
//                                     ? const Text(
//                                         "Select Course",
//                                         style: TextStyle(
//                                           color: Colors.black,
//                                           fontSize: 16,
//                                         ),
//                                       )
//                                     : Text(
//                                         "   ${value.courseLen.toString()} Selected",
//                                         style: const TextStyle(
//                                           color: Colors.black,
//                                           fontSize: 16,
//                                         ),
//                                       ),
//                                 chipDisplay: MultiSelectChipDisplay.none(),
//                                 onConfirm: (results) async {
//                                   diviData = [];
//                                   courseData.clear();
//                                   value.divisionLen = 0;
//                                   print("coursddeleteeee   $courseData");
//                                   await Provider.of<SchoolPhotoProviders>(
//                                           context,
//                                           listen: false)
//                                       .clearDivision();
//
//                                   await Provider.of<
//                                               NotificationToGuardianAdmin>(
//                                           context,
//                                           listen: false)
//                                       .clearStudentList();
//                                   for (var a = 0; a < results.length; a++) {
//                                     StudReportCourse data =
//                                         results[a] as StudReportCourse;
//
//                                     diviData.add(data.value);
//                                     diviData.map((e) => data.value);
//                                     print("${diviData.map((e) => data.value)}");
//                                   }
//                                   print('diviData course== $diviData');
//                                   course = '';
//                                   course = diviData.join(',');
//                                   await Provider.of<SchoolPhotoProviders>(
//                                           context,
//                                           listen: false)
//                                       .courseCounter(results.length);
//                                   results.clear();
//                                   await Provider.of<SchoolPhotoProviders>(
//                                           context,
//                                           listen: false)
//                                       .getDivisionList(course);
//
//                                   print("course   $course");
//                                 },
//                               ),
//                             ),
//                           ),
//                         ),
//                 )
//               ],
//             ),
//             Row(
//               children: [
//                 Consumer<SchoolPhotoProviders>(
//                   builder: (context, value, child) => value.loadingDivision
//                       ? const Expanded(child: Center(child: Text('Loading...')))
//                       : Expanded(
//                           child: Padding(
//                             padding: const EdgeInsets.only(left: 8.0, right: 8),
//                             child: SizedBox(
//                               height: 45,
//                               child: MultiSelectDialogField(
//                                 items: value.divisionDrop,
//                                 listType: MultiSelectListType.CHIP,
//                                 title: const Text(
//                                   "Select Division",
//                                   style: TextStyle(color: Colors.grey),
//                                 ),
//                                 selectedItemsTextStyle: const TextStyle(
//                                     fontWeight: FontWeight.w900,
//                                     color: UIGuide.light_Purple),
//                                 confirmText: const Text(
//                                   'OK',
//                                   style: TextStyle(color: UIGuide.light_Purple),
//                                 ),
//                                 cancelText: const Text(
//                                   'Cancel',
//                                   style: TextStyle(color: UIGuide.light_Purple),
//                                 ),
//                                 separateSelectedItems: true,
//                                 decoration: const BoxDecoration(
//                                   color: UIGuide.ButtonBlue,
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: Colors.grey,
//                                       offset: Offset(0, 2),
//                                       blurRadius: 4,
//                                       spreadRadius: 0,
//                                     ),
//                                   ],
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(10)),
//                                 ),
//                                 buttonIcon: const Icon(
//                                   Icons.arrow_drop_down_outlined,
//                                   color: Colors.grey,
//                                 ),
//                                 buttonText: value.divisionLen == 0
//                                     ? const Text(
//                                         "Select Division",
//                                         style: TextStyle(
//                                           color: Colors.black,
//                                           fontSize: 16,
//                                         ),
//                                       )
//                                     : Text(
//                                         "   ${value.divisionLen.toString()} Selected",
//                                         style: const TextStyle(
//                                           color: Colors.black,
//                                           fontSize: 16,
//                                         ),
//                                       ),
//                                 chipDisplay: MultiSelectChipDisplay.none(),
//                                 onConfirm: (results) async {
//                                   courseData = [];
//                                   await Provider.of<
//                                               NotificationToGuardianAdmin>(
//                                           context,
//                                           listen: false)
//                                       .clearStudentList();
//
//
//                                   for (var i = 0; i < results.length; i++) {
//                                     StudReportDivision data =
//                                         results[i] as StudReportDivision;
//                                     print(data.text);
//                                     print(data.value);
//                                     courseData.add(data.value);
//                                     courseData.map((e) => data.value);
//                                     print(
//                                         "${courseData.map((e) => data.value)}");
//                                   }
//                                   print("Coursedataaaa    $courseData");
//                                   division = courseData.join(',');
//                                   Provider.of<SchoolPhotoProviders>(context,
//                                           listen: false)
//                                       .divisionCounter(results.length);
//                                   results.clear();
//                                   print("data div  $division");
//                                 },
//                               ),
//                             ),
//                           ),
//                         ),
//                 ),
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.only(left: 10.0, right: 10),
//                     child: SizedBox(
//                       height: 45,
//                       child: Consumer<NotificationToGuardianAdmin>(
//                         builder: (context, val, child) => val.loading
//                             ? const Center(
//                                 child: Text(
//                                 'Loading...',
//                                 style: TextStyle(
//                                     color: UIGuide.light_Purple, fontSize: 16),
//                               ))
//                             : ElevatedButton(
//                                 style: ElevatedButton.styleFrom(
//                                   elevation: 3,
//                                   foregroundColor: UIGuide.WHITE,
//                                   backgroundColor: UIGuide.light_Purple,
//                                   padding: const EdgeInsets.all(0),
//                                   shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(10),
//                                       side: const BorderSide(
//                                         color: UIGuide.light_black,
//                                       )),
//                                 ),
//                                 onPressed: () async {
//                                   await val.clearStudentList();
//                                   var p = await Provider.of<SchoolPhotoProviders>(
//                                       context,listen: false);
//                                   p.stdReportSectionStaff();
//
//                                   if(section ==''){
//
//                                     List secs=[];
//                                     for (var i = 0; i < p.stdReportInitialValues.length; i++) {
//
//                                       secs.add(p.stdReportInitialValues[i].value);
//
//                                     }
//                                     print("anjuuuuu");
//                                     print(secs);
//                                     sectionData='';
//                                     sectionData = secs.join(',');
//                                     print(sectionData);
//
//                                     //course
//
//                                     List crss=[];
//                                     for (var j= 0; j < p.courselist.length; j++) {
//
//                                       crss.add(p.courselist[j].value);
//
//                                     }
//                                     print(crss);
//                                     courseSection='';
//                                     courseSection = crss.join(',');
//                                     print(courseSection);
//
//                                     //divison
//                                     List divss=[];
//                                     for (var k= 0; k < p.divisionSectionlist.length; k++) {
//
//                                       divss.add(p.divisionSectionlist[k].value);
//
//                                     }
//                                     print(divss);
//                                     divisionSection='';
//                                     divisionSection = divss.join(',');
//                                     print(divisionSection);
//
//                                     //view
//                                     await val.getNotificationView(
//                                         sectionData.toLowerCase(),
//                                         courseSection.toLowerCase(),
//                                         divisionSection.toLowerCase(),
//                                         types,
//                                         ""
//                                     );
//
//                                   }
//                                   else {
//                                     await val.getNotificationView(
//                                         section.toLowerCase(),
//                                         course.toLowerCase(),
//                                         division.toLowerCase(),
//                                         types, '');
//                                   }
//                                   if (val.notificationView.isEmpty) {
//                                     ScaffoldMessenger.of(context).showSnackBar(
//                                       const SnackBar(
//                                         elevation: 10,
//                                         shape: RoundedRectangleBorder(
//                                           borderRadius: BorderRadius.all(
//                                               Radius.circular(10)),
//                                         ),
//                                         duration: Duration(seconds: 1),
//                                         margin: EdgeInsets.only(
//                                             bottom: 80, left: 30, right: 30),
//                                         behavior: SnackBarBehavior.floating,
//                                         content: Text(
//                                           "No data for specified condition..!",
//                                           textAlign: TextAlign.center,
//                                         ),
//                                       ),
//                                     );
//                                   }
//                                 },
//                                 child: const Text(
//                                   'View',
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 16),
//                                 ),
//                               ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       border: Border.all(color: UIGuide.light_black, width: 1)),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       // Spacer(),
//                       GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             types = "sms";
//                           });
//                         },
//                         child: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Radio(
//                               activeColor: UIGuide.light_Purple,
//                               value: 'sms',
//                               groupValue: types,
//                               onChanged: (value) {
//                                 setState(() {
//                                   types = value.toString();
//                                 });
//                                 print(types);
//                               },
//                             ),
//                             const Text(
//                               "SMS",
//                             ),
//                           ],
//                         ),
//                       ),
//
//                       // Spacer(),
//                       GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             types = "email";
//                           });
//                         },
//                         child: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Radio(
//                               activeColor: UIGuide.light_Purple,
//                               value: 'email',
//                               groupValue: types,
//                               onChanged: (value) {
//                                 setState(() {
//                                   types = value.toString();
//                                 });
//                                 print(types);
//                               },
//                             ),
//                             const Text(
//                               "E-mail",
//                             ),
//                           ],
//                         ),
//                       ),
//
//                       // Spacer(),
//                       GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             types = "notification";
//                           });
//                         },
//                         child: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Radio(
//                               activeColor: UIGuide.light_Purple,
//                               value: 'notification',
//                               groupValue: types,
//                               onChanged: (value) {
//                                 setState(() {
//                                   types = value.toString();
//                                 });
//                                 print(types);
//                               },
//                             ),
//                             const Text(
//                               "Notification",
//                             ),
//                           ],
//                         ),
//                       ),
//
//                       // Spacer(),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             val.notificationView.isEmpty
//                 ? const SizedBox(
//                     height: 0,
//                     width: 0,
//                   )
//                 : Container(
//                     decoration: BoxDecoration(
//                         color: const Color.fromARGB(255, 241, 243, 245),
//                         border:
//                             Border.all(color: UIGuide.light_black, width: 1)),
//                     child: Padding(
//                       padding: const EdgeInsets.only(top: 2.0, bottom: 2),
//                       child: Table(
//                         columnWidths: const {
//                           0: FlexColumnWidth(1.3),
//                           1: FlexColumnWidth(4),
//                           2: FlexColumnWidth(1.3),
//                         },
//                         children: [
//                           TableRow(children: [
//                             const Text(
//                               ' Sl.No.',
//                               style: TextStyle(
//                                   fontSize: 15, fontWeight: FontWeight.bold),
//                             ),
//                             const Text(
//                               'Name',
//                               style: TextStyle(
//                                   fontSize: 15, fontWeight: FontWeight.bold),
//                             ),
//                             Consumer<NotificationToGuardianAdmin>(
//                               builder: (context, value, child) =>
//                                   GestureDetector(
//                                       onTap: () {
//                                         value.selectAll();
//                                       },
//                                       child: value.isselectAll
//                                           ? Padding(
//                                               padding: const EdgeInsets.only(
//                                                   left: 15),
//                                               child: SvgPicture.asset(
//                                                 UIGuide.check,
//                                                 color: UIGuide.light_Purple,
//                                               ),
//                                             )
//                                           : const Text(
//                                               'Select All',
//                                               style: TextStyle(
//                                                   fontSize: 15,
//                                                   fontWeight: FontWeight.bold,
//                                                   color: UIGuide.light_Purple),
//                                             )),
//                             )
//                           ])
//                         ],
//                       ),
//                     ),
//                   ),
//             Consumer<NotificationToGuardianAdmin>(
//               builder: (context, value, child) {
//                 return value.loading
//                     ? Expanded(
//                         child: Center(child: spinkitLoader()),
//                       )
//                     : Expanded(
//                         child: Scrollbar(
//                           thickness: 5,
//                           controller: _scrollController,
//                           child: ListView.builder(
//                             scrollDirection: Axis.vertical,
//                             itemCount: value.notificationView.isEmpty
//                                 ? 0
//                                 : value.notificationView.length,
//                             itemBuilder: ((context, index) {
//                               return Container(
//                                 decoration: BoxDecoration(
//                                   color: index.isEven
//                                       ? Colors.white
//                                       : const Color.fromARGB(
//                                           255, 241, 243, 245),
//                                   border: Border.all(
//                                       color: UIGuide.light_black, width: 1),
//                                 ),
//                                 child: Notification_StudListAdmin(
//                                   viewStud: value.notificationView[index],
//                                   indexx: index,
//                                 ),
//                               );
//                             }),
//                           ),
//                         ),
//                       );
//               },
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: BottomAppBar(
//         elevation: 3.0,
//         child: Padding(
//           padding: const EdgeInsets.only(left: 12, right: 12),
//           child: Consumer<NotificationToGuardianAdmin>(
//             builder: (context, value, child) => value.loading
//                 ? MaterialButton(
//                     shape: const RoundedRectangleBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(10.0))),
//                     color: UIGuide.light_Purple,
//                     onPressed: () {},
//                     child: const Text('Please Wait...',
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 16,
//                             fontWeight: FontWeight.w400)),
//                   )
//                 : value.notificationView.isEmpty
//                     ? const SizedBox(
//                         height: 0,
//                         width: 0,
//                       )
//                     : MaterialButton(
//                         shape: const RoundedRectangleBorder(
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(10.0))),
//                         color: UIGuide.light_Purple,
//                         onPressed: () async {
//                           if (types == 'notification') {
//                             await value.submitStudent(context);
//                           } else {
//                             await value.getProvider();
//                             value.types = types;
//                             if (types == "email") {
//                               await value.submitSmsStudent(context);
//                             } else if (types == "sms") {
//                               if (value.providerName == null) {
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   const SnackBar(
//                                     elevation: 10,
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius:
//                                           BorderRadius.all(Radius.circular(10)),
//                                     ),
//                                     duration: Duration(seconds: 1),
//                                     margin: EdgeInsets.only(
//                                         bottom: 80, left: 30, right: 30),
//                                     behavior: SnackBarBehavior.floating,
//                                     content: Text(
//                                       'Sms Provider Not Found..!',
//                                       textAlign: TextAlign.center,
//                                     ),
//                                   ),
//                                 );
//                               } else {
//                                 await value.submitSmsStudent(context);
//                               }
//                             } else {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 const SnackBar(
//                                   elevation: 10,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(10)),
//                                   ),
//                                   duration: Duration(seconds: 1),
//                                   margin: EdgeInsets.only(
//                                       bottom: 80, left: 30, right: 30),
//                                   behavior: SnackBarBehavior.floating,
//                                   content: Text(
//                                     'Something went wrong..!',
//                                     textAlign: TextAlign.center,
//                                   ),
//                                 ),
//                               );
//                             }
//                           }
//                         },
//                         child: const Text('Proceed',
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w400)),
//                       ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class Notification_StudListAdmin extends StatelessWidget {
//   final StudentView viewStud;
//   const Notification_StudListAdmin(
//       {Key? key, required this.viewStud, required this.indexx})
//       : super(key: key);
//   final int indexx;
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<NotificationToGuardianAdmin>(
//       builder: (context, value, child) => ListTile(
//         dense: true,
//         titleAlignment: ListTileTitleAlignment.center,
//         shape: const RoundedRectangleBorder(),
//         leading: Text(
//           (indexx + 1).toString(),
//           textAlign: TextAlign.center,
//         ),
//         onTap: () {
//           value.selectItem(viewStud);
//         },
//         title: Text(
//           viewStud.name == null ? '---' : viewStud.name,
//           style: const TextStyle(
//               fontSize: 14, fontWeight: FontWeight.w600, color: UIGuide.BLACK),
//         ),
//         subtitle: Row(
//           children: [
//             const Text("Adm no: "),
//             Text(viewStud.admNo ?? '---'),
//           ],
//         ),
//         trailing: viewStud.selected != null && viewStud.selected!
//             ? SvgPicture.asset(
//                 UIGuide.check,
//                 color: UIGuide.light_Purple,
//               )
//             : SvgPicture.asset(
//                 UIGuide.notcheck,
//                 color: UIGuide.light_Purple,
//               ),
//       ),
//     );
//   }
// }
//
// class Text_Matter_NotificationAdmin extends StatelessWidget {
//   final List<String> toList;
//   final String type;
//
//   String? provider;
//   Text_Matter_NotificationAdmin(
//       {Key? key, required this.toList, required this.type})
//       : super(key: key);
//   final titleController = TextEditingController();
//   final matterController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: const Text('Send Notification'),
//         titleSpacing: 00.0,
//         centerTitle: true,
//         toolbarHeight: 60.2,
//         toolbarOpacity: 0.8,
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//               bottomRight: Radius.circular(25),
//               bottomLeft: Radius.circular(25)),
//         ),
//         backgroundColor: UIGuide.light_Purple,
//       ),
//       body: Consumer<NotificationToGuardian_Providers>(
//         builder: (context, val, _) => Stack(
//           children: [
//             SingleChildScrollView(
//               child: Column(
//                 // crossAxisAlignment: CrossAxisAlignment.center,
//                 // mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   LottieBuilder.network(
//                       'https://assets10.lottiefiles.com/private_files/lf30_kBx3K1.json'),
//                   kheight20,
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: LimitedBox(
//                       maxHeight: 80,
//                       child: TextFormField(
//                         inputFormatters: [LengthLimitingTextInputFormatter(50)],
//                         controller: titleController,
//                         minLines: 1,
//                         maxLines: 4,
//                         keyboardType: TextInputType.multiline,
//                         decoration: const InputDecoration(
//                           labelText: 'Title*',
//                           hintText: 'Enter Title',
//                           labelStyle: TextStyle(color: UIGuide.light_Purple),
//                           hintStyle: TextStyle(color: Colors.grey),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.only(
//                                 topLeft: Radius.circular(20),
//                                 topRight: Radius.circular(0),
//                                 bottomLeft: Radius.circular(0),
//                                 bottomRight: Radius.circular(20)),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                                 color: UIGuide.light_Purple, width: 1.0),
//                             borderRadius: BorderRadius.only(
//                                 topLeft: Radius.circular(20),
//                                 topRight: Radius.circular(0),
//                                 bottomLeft: Radius.circular(0),
//                                 bottomRight: Radius.circular(20)),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: LimitedBox(
//                       maxHeight: 150,
//                       child: TextFormField(
//                         inputFormatters: [
//                           LengthLimitingTextInputFormatter(1000)
//                         ],
//                         controller: matterController,
//                         minLines: 1,
//                         maxLines: 15,
//                         keyboardType: TextInputType.multiline,
//                         decoration: const InputDecoration(
//                           labelText: 'Matter*',
//                           hintText: 'Enter Matter',
//                           labelStyle: TextStyle(color: UIGuide.light_Purple),
//                           hintStyle: TextStyle(color: Colors.grey),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.only(
//                                 topLeft: Radius.circular(20),
//                                 topRight: Radius.circular(0),
//                                 bottomLeft: Radius.circular(0),
//                                 bottomRight: Radius.circular(20)),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                                 color: UIGuide.light_Purple, width: 1.0),
//                             borderRadius: BorderRadius.only(
//                                 topLeft: Radius.circular(20),
//                                 topRight: Radius.circular(0),
//                                 bottomLeft: Radius.circular(0),
//                                 bottomRight: Radius.circular(20)),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   kheight20,
//                   SizedBox(
//                     width: 150,
//                     height: 40,
//                     child: MaterialButton(
//                       onPressed: () async {
//                         if (titleController.text.trim().isNotEmpty &&
//                             matterController.text.trim().isNotEmpty) {
//                           await Provider.of<NotificationToGuardian_Providers>(
//                                   context,
//                                   listen: false)
//                               .sendNotification(context, titleController.text,
//                                   matterController.text, toList,
//                                   sentTo: type);
//                           titleController.clear();
//                           matterController.clear();
//                         } else {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(
//                               elevation: 10,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(10)),
//                               ),
//                               duration: Duration(seconds: 1),
//                               margin: EdgeInsets.only(
//                                   bottom: 80, left: 30, right: 30),
//                               behavior: SnackBarBehavior.floating,
//                               content: Text(
//                                 'Enter Title & Matter!',
//                                 textAlign: TextAlign.center,
//                               ),
//                             ),
//                           );
//                         }
//                       },
//                       shape: RoundedRectangleBorder(
//                         borderRadius: const BorderRadius.only(
//                             topLeft: Radius.circular(20),
//                             topRight: Radius.circular(0),
//                             bottomLeft: Radius.circular(0),
//                             bottomRight: Radius.circular(20)),
//                         side: BorderSide(color: Theme.of(context).primaryColor),
//                       ),
//                       color: UIGuide.light_Purple,
//                       child: const Text(
//                         'Send',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             if (val.loading) pleaseWaitLoader()
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:essconnect/Constants.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:essconnect/utils/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';
import '../../../Application/Staff_Providers/Notification_ToGuardianProvider.dart';
import '../../../Application/Staff_Providers/TextSMS_ToGuardian.dart';
import '../../../Domain/Staff/ToGuardian_TextSMS.dart';


class Notification_AdminToGuardain extends StatefulWidget {
  Notification_AdminToGuardain({
    Key? key,

  }) : super(key: key);



  @override
  State<Notification_AdminToGuardain> createState() =>
      _Notification_AdminToGuardainState();
}

class _Notification_AdminToGuardainState
    extends State<Notification_AdminToGuardain> {

  // @override
  List subjectData = [];

  List diviData = [];

  List courseData = [];

  String course = '';

  String section = '';
  int length = 0;
  String division = '';

  String courseSection = '';
  String sectionData = '';
  String divisionSection = '';

  String? types ;

  divClearr() {
    diviData.clear();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var p = await Provider.of<TextSMS_ToGuardian_Providers>(context, listen: false);
      // p.stdReportSectionStaff();

      // p.sectionList.clear();

      p.courseDrop.clear();
      p.divisionDrop.clear();
      types='sms';
      p.sectionList.clear();
      p.courseList.clear();
      p.divisionlist.clear();
      p.divisionSectionlist.clear();
      p.isselectAll=false;
      p.courseCounter(0);
      p.notificationView.clear();
      p.divisionCounter(0);
      p.sectionCounter(0);
      section='';
      division = '';
      course = '';
      courseSection = '';
      sectionData = '';
      divisionSection = '';
      p.getInitialCommunication();


      await Provider.of<TextSMS_ToGuardian_Providers>(context, listen: false)
          .clearStudentList();
    });
  }

  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Spacer(),
            const Text(
              'Communication to Guardian',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
            ),
            const Spacer(),
            Consumer<TextSMS_ToGuardian_Providers>(
              builder: (context, value, child) => value.loading
                  ? const SizedBox(
                height: 0,
                width: 0,
              )
                  : IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Notification_AdminToGuardain()));
                  },
                  icon: const Icon(Icons.refresh_outlined)),
            ),
            kWidth
          ],
        ),
        titleSpacing: 00.0,
        centerTitle: true,
        toolbarHeight: 60,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
        ),
        backgroundColor: UIGuide.light_Purple,
      ),

      body: Consumer<TextSMS_ToGuardian_Providers>(
        builder: (context, val, _) =>
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Consumer<TextSMS_ToGuardian_Providers>(

                  builder: (context, value, child) =>

                  value.loadingSection
                      ? const Expanded(child: Center(child: Text('Loading...')))
                      : Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 45,
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
                            val.setLoading(true);
                            value.divisionlist.clear();
                            division='';
                            course='';


                            val.courseDrop.clear();
                            val.divisionDrop.clear();
                            subjectData = [];
                            courseData.clear();
                            diviData.clear();

                            value.courseLen = 0;
                            value.divisionLen = 0;

                            await Provider.of<TextSMS_ToGuardian_Providers>(
                                context,
                                listen: false)
                                .clearCourse();
                            await Provider.of<TextSMS_ToGuardian_Providers>(
                                context,
                                listen: false)
                                .clearDivision();
                            await Provider.of<TextSMS_ToGuardian_Providers>(
                                context,
                                listen: false)
                                .clearSectionDivision();

                            await Provider.of<
                                TextSMS_ToGuardian_Providers>(
                                context,
                                listen: false)
                                .clearStudentList();


                            for (var i = 0; i < results.length; i++) {
                              SectionsforCommunication data =
                              results[i] as SectionsforCommunication;
                              print(data.text);
                              print(data.value);
                              subjectData.add(data.value);
                              subjectData.map((e) => data.value);
                              print(
                                  "${subjectData.map((e) => data.value)}");
                            }
                            section='';
                            section = subjectData.join(',');
                            await Provider.of<TextSMS_ToGuardian_Providers>(
                                context,
                                listen: false)
                                .sectionCounter(results.length);

                            await Provider.of<TextSMS_ToGuardian_Providers>(
                                context,
                                listen: false)
                                .getCourseList(section);


                            await Provider.of<TextSMS_ToGuardian_Providers>(
                                context,
                                listen: false)
                                .getDivisonSectionList(section);






                            val.setLoading(false);
                          },
                        ),
                      ),
                    ),
                  ),

                ),
                // kWidth,
                Consumer<TextSMS_ToGuardian_Providers>(
                  builder: (context, value, child) => value.loadingCourse
                      ? const Expanded(
                    // width: size.width * .43,
                    // height: 50,
                      child: Center(child: Text('Loading...')))
                      : Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                      SizedBox(
                        height: 45,
                        child: MultiSelectDialogField(
                          items: value.courseDrop,
                          listType: MultiSelectListType.CHIP,
                          title: const Text(
                            "Select Course",
                            style: TextStyle(color: Colors.grey),
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
                            diviData = [];
                            courseData.clear();
                            value.divisionLen = 0;
                            print("coursddeleteeee   $courseData");
                            await Provider.of<TextSMS_ToGuardian_Providers>(
                                context,
                                listen: false)
                                .clearDivision();
                            await Provider.of<TextSMS_ToGuardian_Providers>(
                                context,
                                listen: false)
                                .clearSectionDivision();

                            await Provider.of<
                                TextSMS_ToGuardian_Providers>(
                                context,
                                listen: false)
                                .clearStudentList();
                            for (var a = 0; a < results.length; a++) {
                              CourseInCommnunication data =
                              results[a] as CourseInCommnunication;

                              diviData.add(data.value);
                              diviData.map((e) => data.value);
                              print("${diviData.map((e) => data.value)}");

                              print("rossshhhsur");
                              print(courseData);
                            }
                            print('diviData course== $diviData');
                            course = '';
                            course = diviData.join(',');
                            await Provider.of<TextSMS_ToGuardian_Providers>(
                                context,
                                listen: false)
                                .courseCounter(results.length);
                            results.clear();
                            await Provider.of<TextSMS_ToGuardian_Providers>(
                                context,
                                listen: false)
                                .getDivisionList(course);

                            // for(int i=0;i<=value.divisionlist.length;i++) {
                            //   courseData.add(value.divisionlist[i].value);
                            //   courseData.map((e) => value.divisionlist[i].value);
                            // }
                            print("rohsdivi");
                            print(courseData);

                            print("course   $course");
                          },
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Consumer<TextSMS_ToGuardian_Providers>(
                  builder: (context, value, child) => value.loadingDivision
                      ? const Expanded(child: Center(child: Text('Loading...')))
                      : Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: SizedBox(
                        height: 45,
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
                            courseData = [];
                            await Provider.of<
                                TextSMS_ToGuardian_Providers>(
                                context,
                                listen: false)
                                .clearStudentList();
                            for (var i = 0; i < results.length; i++) {
                              DivisionInCommnunication data =
                              results[i] as DivisionInCommnunication;

                              print(data.text);
                              print(data.value);
                              print("coursedataaaaaaa");
                              courseData.add(data.value);
                              courseData.map((e) => data.value);
                              print(courseData);
                              print(
                                  "${courseData.map((e) => data.value)}");
                            }

                            print("Coursedataaaa    $courseData");
                            division = courseData.join(',');
                            Provider.of<TextSMS_ToGuardian_Providers>(context,
                                listen: false)
                                .divisionCounter(results.length);
                            results.clear();
                            print("data div  $division");
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10),
                    child: SizedBox(
                      height: 45,
                      child: Consumer<TextSMS_ToGuardian_Providers>(
                        builder: (context, val, child) => val.loading
                            ? const Center(
                            child: Text(
                              'Loading...',
                              style: TextStyle(
                                  color: UIGuide.light_Purple, fontSize: 16),
                            ))
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


                            await val.clearStudentList();

                              await val.getStudentsView(
                                  section.toLowerCase(),
                                  course.toLowerCase(),
                                  division.toLowerCase(),
                                  types!,
                                  ""
                              );

                            val.isselectAll=false;
                            if (val.notificationView.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  elevation: 10,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10)),
                                  ),
                                  duration: Duration(seconds: 1),
                                  margin: EdgeInsets.only(
                                      bottom: 80, left: 30, right: 30),
                                  behavior: SnackBarBehavior.floating,
                                  content: Text(
                                    "No data for specified condition..!",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              );
                            }
                          },
                          child: const Text(
                            'View',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: UIGuide.light_black, width: 1)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                   Spacer(),
                      GestureDetector(
                        onTap: () {

                          setState(() {
                            types = "sms";
                          });
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [

                            Radio(
                              activeColor: UIGuide.light_Purple,
                              value: 'sms',
                              groupValue: types,
                              onChanged: (value) {
                                setState(() {
                                  types = value.toString();
                                });
                                print(types);
                              },
                            ),

                            Text(
                              "SMS",
                            ),
                          ],
                        ),
                      ),

                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            types = "email";
                          });
                        },
                        child:

                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [

                            Radio(
                              activeColor: UIGuide.light_Purple,
                              value: 'email',
                              groupValue: types,
                              onChanged: (value) {
                                setState(() {
                                  types = value.toString();
                                });
                                print(types);
                              },
                            ),
                             Text(
                              "E-mail",
                            ),
                          ],
                        ),
                      ),

                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            types = "notification";
                          });
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [

                            Radio(
                              activeColor: UIGuide.light_Purple,
                              value: 'notification',
                              groupValue: types,
                              onChanged: (value) {
                                setState(() {
                                  types = value.toString();
                                });
                                print(types);
                              },
                            ),
                         Text(
                              "Notification",
                            ),
                          ],
                        ),
                      ),
                      Spacer(),



                    ],
                  ),
                ),
              ),
            ),
            val.notificationView.isEmpty
                ? const SizedBox(
              height: 0,
              width: 0,
            )
                : Container(
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 241, 243, 245),
                  border:
                  Border.all(color: UIGuide.light_black, width: 1)),
              child: Padding(
                padding: const EdgeInsets.only(top: 2.0, bottom: 2),
                child: Table(
                  columnWidths: const {
                    0: FlexColumnWidth(1.3),
                    1: FlexColumnWidth(4),
                    2: FlexColumnWidth(1.3),
                  },
                  children: [
                    TableRow(children: [
                      const Text(
                        ' Sl.No.',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        'Name',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Consumer<TextSMS_ToGuardian_Providers>(
                        builder: (context, value, child) =>
                            GestureDetector(
                                onTap: () {
                                  value.selectAll();
                                },
                                child: value.isselectAll
                                    ? Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15),
                                  child: SvgPicture.asset(
                                    UIGuide.check,
                                    color: UIGuide.light_Purple,
                                  ),
                                )
                                    : const Text(
                                  'Select All',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: UIGuide.light_Purple),
                                )),
                      )
                    ])
                  ],
                ),
              ),
            ),
            Consumer<TextSMS_ToGuardian_Providers>(
              builder: (context, value, child) {
                return value.loading
                    ? Expanded(
                  child: Center(child: spinkitLoader()),
                )
                    : Expanded(
                  child: Scrollbar(
                    thickness: 5,
                    controller: _scrollController,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: value.notificationView.isEmpty
                          ? 0
                          : value.notificationView.length,
                      itemBuilder: ((context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            color: index.isEven
                                ? Colors.white
                                : const Color.fromARGB(
                                255, 241, 243, 245),
                            border: Border.all(
                                color: UIGuide.light_black, width: 1),
                          ),
                          child: Notification_StudListStaff(
                            viewStud: value.notificationView[index],
                            indexx: index,
                          ),
                        );
                      }),
                    ),
                  ),
                );
              },
            ),
          ],
        ),


      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 3.0,
        child: Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: Consumer<TextSMS_ToGuardian_Providers>(
            builder: (context, value, child) => value
                .notificationView.isEmpty ||
                value.loading || types==""
                ? const SizedBox(
              height: 0,
              width: 0,
            )
                : MaterialButton(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              color: UIGuide.light_Purple,
              onPressed: () async {
                if (types == 'notification') {
                  await Provider.of<TextSMS_ToGuardian_Providers>(
                      context,
                      listen: false)
                      .submitStudent(context);
                } else {
                  await Provider.of<TextSMS_ToGuardian_Providers>(
                      context,
                      listen: false)
                      .getProvider();
                  value.type = types;
                  if (types == 'email') {
                    await Provider.of<TextSMS_ToGuardian_Providers>(
                        context,
                        listen: false)
                        .submitSmsStudent(context);
                  } else if (types == "sms") {
                    if (value.providerName == null) {
                      await ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10)),
                          ),
                          duration: Duration(seconds: 1),
                          margin: EdgeInsets.only(
                              bottom: 80, left: 30, right: 30),
                          behavior: SnackBarBehavior.floating,
                          content: Text(
                            'Sms Provider Not Found.....!',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    } else {
                      await Provider.of<TextSMS_ToGuardian_Providers>(
                          context,
                          listen: false)
                          .submitSmsStudent(context);
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(10)),
                        ),
                        duration: Duration(seconds: 1),
                        margin: EdgeInsets.only(
                            bottom: 80, left: 30, right: 30),
                        behavior: SnackBarBehavior.floating,
                        content: Text(
                          'Something went wrong.....!',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }
                }
              },
              child: const Text('Proceed',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400)),
            ),
          ),
        ),
      ),
    );
  }
}

class Notification_StudListStaff extends StatelessWidget {
  final StudentView viewStud;
  const Notification_StudListStaff(
      {Key? key, required this.viewStud, required this.indexx})
      : super(key: key);
  final int indexx;

  @override
  Widget build(BuildContext context) {
    return Consumer<TextSMS_ToGuardian_Providers>(
      builder: (context, value, child) => ListTile(
        dense: true,
        titleAlignment: ListTileTitleAlignment.center,
        shape: const RoundedRectangleBorder(),
        leading: Text(
          (indexx + 1).toString(),
          textAlign: TextAlign.center,
        ),
        onTap: () {
          value.selectItem(viewStud);
        },
        title: Text(
          viewStud.name == null ? '---' : viewStud.name,
          style: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.w600, color: UIGuide.BLACK),
        ),
        subtitle: Row(
          children: [
            const Text("Adm no: "),
            Text(viewStud.admNo ?? '---'),
          ],
        ),
        trailing: viewStud.selected != null && viewStud.selected!
            ? SvgPicture.asset(
          UIGuide.check,
          color: UIGuide.light_Purple,
        )
            : SvgPicture.asset(
          UIGuide.notcheck,
          color: UIGuide.light_Purple,
        ),
      ),
    );
  }
}

class Text_Matter_NotificationAdmin extends StatelessWidget {
  final List<String> toList;
  final String type;

  String? provider;
  Text_Matter_NotificationAdmin(
      {Key? key, required this.toList, required this.type})
      : super(key: key);
  final titleController = TextEditingController();
  final matterController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Send Notification'),
        titleSpacing: 00.0,
        centerTitle: true,
        toolbarHeight: 60.2,
        toolbarOpacity: 0.8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
        ),
        backgroundColor: UIGuide.light_Purple,
      ),
      body: Consumer<NotificationToGuardian_Providers>(
        builder: (context, val, _) => Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LottieBuilder.network(
                      'https://assets10.lottiefiles.com/private_files/lf30_kBx3K1.json'),
                  kheight20,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: LimitedBox(
                      maxHeight: 80,
                      child: TextFormField(
                        inputFormatters: [LengthLimitingTextInputFormatter(50)],
                        controller: titleController,
                        minLines: 1,
                        maxLines: 4,
                        keyboardType: TextInputType.multiline,
                        decoration: const InputDecoration(
                          labelText: 'Title*',
                          hintText: 'Enter Title',
                          labelStyle: TextStyle(color: UIGuide.light_Purple),
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(0),
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(20)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: UIGuide.light_Purple, width: 1.0),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(0),
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(20)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: LimitedBox(
                      maxHeight: 150,
                      child: TextFormField(
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1000)
                        ],
                        controller: matterController,
                        minLines: 1,
                        maxLines: 15,
                        keyboardType: TextInputType.multiline,
                        decoration: const InputDecoration(
                          labelText: 'Matter*',
                          hintText: 'Enter Matter',
                          labelStyle: TextStyle(color: UIGuide.light_Purple),
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(0),
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(20)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: UIGuide.light_Purple, width: 1.0),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(0),
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(20)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  kheight20,
                  SizedBox(
                    width: 150,
                    height: 40,
                    child: MaterialButton(
                      onPressed: () async {
                        if (titleController.text.trim().isNotEmpty &&
                            matterController.text.trim().isNotEmpty) {
                          await Provider.of<NotificationToGuardian_Providers>(
                              context,
                              listen: false)
                              .sendNotification(context, titleController.text,
                              matterController.text, toList,
                              sentTo: type);
                          titleController.clear();
                          matterController.clear();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10)),
                              ),
                              duration: Duration(seconds: 1),
                              margin: EdgeInsets.only(
                                  bottom: 80, left: 30, right: 30),
                              behavior: SnackBarBehavior.floating,
                              content: Text(
                                'Enter Title & Matter!',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        }
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(0),
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(20)),
                        side: BorderSide(color: Theme.of(context).primaryColor),
                      ),
                      color: UIGuide.light_Purple,
                      child: const Text(
                        'Send',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (val.loading) pleaseWaitLoader()
          ],
        ),
      ),
    );
  }
}
class Text_Matter_Notification extends StatelessWidget {
  final List<String> toList;
  final String type;
  Text_Matter_Notification({Key? key, required this.toList, required this.type})
      : super(key: key);
  final titleController = TextEditingController();
  final matterController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Notification'),
        titleSpacing: 00.0,
        centerTitle: true,
        toolbarHeight: 60.2,
        toolbarOpacity: 0.8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
        ),
        backgroundColor: UIGuide.light_Purple,
      ),
      body: Consumer<NotificationToGuardian_Providers>(
        builder: (context, val, _) => Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  LottieBuilder.network(
                      'https://assets10.lottiefiles.com/private_files/lf30_kBx3K1.json'),
                  kheight20,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: LimitedBox(
                      maxHeight: 80,
                      child: TextFormField(
                        inputFormatters: [LengthLimitingTextInputFormatter(50)],
                        controller: titleController,
                        minLines: 1,
                        maxLines: 4,
                        keyboardType: TextInputType.multiline,
                        decoration: const InputDecoration(
                          labelText: 'Title*',
                          hintText: 'Enter Title',
                          labelStyle: TextStyle(color: UIGuide.light_Purple),
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(0),
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(20)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: UIGuide.light_Purple, width: 1.0),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(0),
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(20)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: LimitedBox(
                      maxHeight: 150,
                      child: TextFormField(
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1000)
                        ],
                        controller: matterController,
                        minLines: 1,
                        maxLines: 15,
                        keyboardType: TextInputType.multiline,
                        decoration: const InputDecoration(
                          labelText: 'Matter*',
                          hintText: 'Enter Matter',
                          labelStyle: TextStyle(color: UIGuide.light_Purple),
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(0),
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(20)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: UIGuide.light_Purple, width: 1.0),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(0),
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(20)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  kheight20,
                  Consumer<NotificationToGuardian_Providers>(
                    builder: (context, value, _) => SizedBox(
                      width: 150,
                      height: 40,
                      child: MaterialButton(
                        onPressed: () async {
                          if (titleController.text.trim().isNotEmpty &&
                              matterController.text.trim().isNotEmpty) {
                            await Provider.of<NotificationToGuardian_Providers>(
                                context,
                                listen: false)
                                .sendNotification(context, titleController.text,
                                matterController.text, toList,
                                sentTo: type);
                            titleController.clear();
                            matterController.clear();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                                ),
                                duration: Duration(seconds: 1),
                                margin: EdgeInsets.only(
                                    bottom: 80, left: 30, right: 30),
                                behavior: SnackBarBehavior.floating,
                                content: Text(
                                  'Enter Title & Matter!',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                          }
                        },
                        color: UIGuide.light_Purple,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(0),
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(20)),
                        ),
                        child: const Text(
                          'Send',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            if (val.loading) pleaseWaitLoader()
          ],
        ),
      ),
    );
  }
}