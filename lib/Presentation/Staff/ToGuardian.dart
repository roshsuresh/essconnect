// import 'package:essconnect/Application/Staff_Providers/Notification_ToGuardianProvider.dart';
// import 'package:essconnect/Domain/Staff/ToGuardian.dart';
// import 'package:essconnect/utils/spinkit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:lottie/lottie.dart';
// import 'package:provider/provider.dart';
// import '../../Constants.dart';
// import '../../utils/constants.dart';
//
// class Staff_ToGuardian extends StatelessWidget {
//   Staff_ToGuardian({Key? key}) : super(key: key);
//   String? valuee;
//   bool checked = true;
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         title: Row(
//           children: [
//             const Spacer(),
//             const Text(
//               'Communication to Guardian',
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
//             ),
//             const Spacer(),
//             Consumer<NotificationToGuardian_Providers>(
//               builder: (context, value, child) => value.loading
//                   ? const SizedBox(
//                       height: 0,
//                       width: 0,
//                     )
//                   : IconButton(
//                       onPressed: () {
//                         Navigator.pushReplacement(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => Staff_ToGuardian()));
//                       },
//                       icon: const Icon(Icons.refresh_outlined)),
//             ),
//             kWidth
//           ],
//         ),
//         titleSpacing: 00.0,
//         centerTitle: true,
//         toolbarHeight: 60,
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//               bottomRight: Radius.circular(25),
//               bottomLeft: Radius.circular(25)),
//         ),
//         backgroundColor: UIGuide.light_Purple,
//       ),
//       body: Consumer<NotificationToGuardian_Providers>(
//         builder: (context, value, child) {
//           if (value.isClassTeacher != false) {
//             return Notification_StaffToGuardain(
//                 size: size, valuee: valuee, checked: checked);
//           } else {
//             return const Center(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(
//                     Icons.sentiment_dissatisfied_outlined,
//                     size: 60,
//                     color: Colors.grey,
//                   ),
//                   kheight10,
//                   Text(
//                     "Sorry you don't have access",
//                     style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.grey),
//                   ),
//                 ],
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
// }
//
// class Notification_StaffToGuardain extends StatefulWidget {
//   const Notification_StaffToGuardain({
//     Key? key,
//     required this.size,
//     required this.valuee,
//     required this.checked,
//   }) : super(key: key);
//
//   final Size size;
//   final String? valuee;
//   final bool checked;
//
//   @override
//   State<Notification_StaffToGuardain> createState() =>
//       _Notification_StaffToGuardainState();
// }
//
// class _Notification_StaffToGuardainState
//     extends State<Notification_StaffToGuardain> {
//   String courseId = '';
//
//   String divisionId = '';
//
//   final notificationCourseController = TextEditingController();
//
//   final notificationCourseController1 = TextEditingController();
//
//   final notificationDivisionListController = TextEditingController();
//
//   final notificationDivisionListController1 = TextEditingController();
//
//   String type = 'sms';
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
//       var p =
//           Provider.of<NotificationToGuardian_Providers>(context, listen: false);
//
//       await p.courseClear();
//       await p.divisionClear();
//       await p.clearStudentList();
//       p.selectedList.clear();
//       p.isselectAll = false;
//       await p.communicationToGuardianCourseStaff();
//     });
//   }
//
//   final _scrollController = ScrollController();
//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     return Scaffold(
//       body: Consumer<NotificationToGuardian_Providers>(
//         builder: (context, value, child) => Stack(
//           children: [
//             Column(
//               children: [
//                 const SizedBox(
//                   height: 3,
//                 ),
//                 Row(
//                   children: [
//                     kWidth,
//                     Expanded(
//                       child: SizedBox(
//                         height: 45,
//                         child: Consumer<NotificationToGuardian_Providers>(
//                             builder: (context, snapshot, child) {
//                           return ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                               elevation: 3,
//                               foregroundColor: UIGuide.light_Purple,
//                               backgroundColor: UIGuide.ButtonBlue,
//                               padding: const EdgeInsets.all(0),
//                               shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                   side: const BorderSide(
//                                     color: UIGuide.light_black,
//                                   )),
//                             ),
//                             onPressed: () {
//                               showDialog(
//                                   context: context,
//                                   builder: (context) {
//                                     return Dialog(
//                                         shape: RoundedRectangleBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(15)),
//                                         child: LimitedBox(
//                                           maxHeight: size.height - 300,
//                                           child: ListView.builder(
//                                               shrinkWrap: true,
//                                               itemCount: snapshot
//                                                   .communicationToGuardianInitialValues
//                                                   .length,
//                                               itemBuilder: (context, index) {
//                                                 return ListTile(
//                                                   selectedTileColor:
//                                                       Colors.blue.shade100,
//                                                   onTap: () async {
//                                                     Navigator.of(context).pop();
//                                                     notificationCourseController
//                                                         .text = snapshot
//                                                             .communicationToGuardianInitialValues[
//                                                                 index]
//                                                             .value ??
//                                                         '--';
//                                                     notificationCourseController1
//                                                         .text = snapshot
//                                                             .communicationToGuardianInitialValues[
//                                                                 index]
//                                                             .text ??
//                                                         '--';
//                                                     courseId =
//                                                         notificationCourseController
//                                                             .text
//                                                             .toString();
//                                                     notificationDivisionListController
//                                                         .clear();
//                                                     notificationDivisionListController1
//                                                         .clear();
//                                                     snapshot.divisionClear();
//                                                     await snapshot
//                                                         .clearStudentList();
//                                                     await Provider.of<
//                                                                 NotificationToGuardian_Providers>(
//                                                             context,
//                                                             listen: false)
//                                                         .communicationToGuardianDivisionStaff(
//                                                             courseId);
//                                                   },
//                                                   title: Text(
//                                                     snapshot
//                                                             .communicationToGuardianInitialValues[
//                                                                 index]
//                                                             .text ??
//                                                         '--',
//                                                     textAlign: TextAlign.center,
//                                                   ),
//                                                 );
//                                               }),
//                                         ));
//                                   });
//                             },
//                             child: TextField(
//                               style: const TextStyle(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w500,
//                                   color: UIGuide.BLACK,
//                                   overflow: TextOverflow.clip),
//                               textAlign: TextAlign.center,
//                               controller: notificationCourseController1,
//                               decoration: const InputDecoration(
//                                 contentPadding:
//                                     EdgeInsets.only(left: 0, top: 0),
//                                 floatingLabelBehavior:
//                                     FloatingLabelBehavior.never,
//                                 filled: true,
//                                 fillColor: Colors.transparent,
//                                 border: OutlineInputBorder(
//                                   borderSide: BorderSide(
//                                       style: BorderStyle.none, width: 0),
//                                 ),
//                                 labelText: "  Select Course",
//                                 hintText: "Course",
//                               ),
//                               enabled: false,
//                             ),
//                           );
//                         }),
//                       ),
//                     ),
//                     kWidth,
//                     Expanded(
//                       child: SizedBox(
//                         height: 45,
//                         child: Consumer<NotificationToGuardian_Providers>(
//                             builder: (context, snapshot, child) {
//                           return ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                               elevation: 3,
//                               foregroundColor: UIGuide.light_Purple,
//                               backgroundColor: UIGuide.ButtonBlue,
//                               padding: const EdgeInsets.all(0),
//                               shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                   side: const BorderSide(
//                                     color: UIGuide.light_black,
//                                   )),
//                             ),
//                             onPressed: () async {
//                               showDialog(
//                                   context: context,
//                                   builder: (context) {
//                                     return Dialog(
//                                         shape: RoundedRectangleBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(15)),
//                                         child: LimitedBox(
//                                           maxHeight: size.height - 300,
//                                           child: ListView.builder(
//                                               shrinkWrap: true,
//                                               itemCount: snapshot
//                                                   .notificationDivisionList
//                                                   .length,
//                                               itemBuilder: (context, index) {
//                                                 return ListTile(
//                                                   onTap: () async {
//                                                     Navigator.of(context).pop();
//                                                     await snapshot
//                                                         .clearStudentList();
//                                                     notificationDivisionListController
//                                                         .text = snapshot
//                                                             .notificationDivisionList[
//                                                                 index]
//                                                             .value ??
//                                                         '---';
//                                                     notificationDivisionListController1
//                                                         .text = snapshot
//                                                             .notificationDivisionList[
//                                                                 index]
//                                                             .text ??
//                                                         '---';
//
//                                                     divisionId =
//                                                         notificationDivisionListController
//                                                             .text
//                                                             .toString();
//                                                     courseId =
//                                                         notificationCourseController1
//                                                             .text
//                                                             .toString();
//                                                   },
//                                                   title: Text(
//                                                     snapshot
//                                                             .notificationDivisionList[
//                                                                 index]
//                                                             .text ??
//                                                         '---',
//                                                     textAlign: TextAlign.center,
//                                                   ),
//                                                 );
//                                               }),
//                                         ));
//                                   });
//                             },
//                             child: TextField(
//                               style: const TextStyle(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w500,
//                                   color: UIGuide.BLACK,
//                                   overflow: TextOverflow.clip),
//                               textAlign: TextAlign.center,
//                               controller: notificationDivisionListController1,
//                               decoration: const InputDecoration(
//                                 contentPadding:
//                                     EdgeInsets.only(left: 0, top: 0),
//                                 floatingLabelBehavior:
//                                     FloatingLabelBehavior.never,
//                                 filled: true,
//                                 fillColor: Colors.transparent,
//                                 border: OutlineInputBorder(
//                                   borderSide: BorderSide(
//                                       style: BorderStyle.none, width: 0),
//                                 ),
//                                 labelText: "  Select Division",
//                                 hintText: "Division",
//                               ),
//                               enabled: false,
//                             ),
//                           );
//                         }),
//                       ),
//                     ),
//                     kWidth
//                   ],
//                 ),
//                 SingleChildScrollView(
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Container(
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           border:
//                               Border.all(color: UIGuide.light_black, width: 1)),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           // Spacer(),
//                           GestureDetector(
//                             onTap: () {
//                               setState(() {
//                                 type = "sms";
//                               });
//                             },
//                             child: Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 Radio(
//                                   activeColor: UIGuide.light_Purple,
//                                   value: 'sms',
//                                   groupValue: type,
//                                   onChanged: (value) {
//                                     setState(() {
//                                       type = value.toString();
//                                     });
//                                     print(type);
//                                   },
//                                 ),
//                                 const Text(
//                                   "SMS",
//                                 ),
//                               ],
//                             ),
//                           ),
//
//                           // Spacer(),
//                           GestureDetector(
//                             onTap: () {
//                               setState(() {
//                                 type = "email";
//                               });
//                             },
//                             child: Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 Radio(
//                                   activeColor: UIGuide.light_Purple,
//                                   value: 'email',
//                                   groupValue: type,
//                                   onChanged: (value) {
//                                     setState(() {
//                                       type = value.toString();
//                                     });
//                                     print(type);
//                                   },
//                                 ),
//                                 const Text(
//                                   "E-mail",
//                                 ),
//                               ],
//                             ),
//                           ),
//
//                           // Spacer(),
//                           GestureDetector(
//                             onTap: () {
//                               setState(() {
//                                 type = "notification";
//                               });
//                             },
//                             child: Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 Radio(
//                                   activeColor: UIGuide.light_Purple,
//                                   value: 'notification',
//                                   groupValue: type,
//                                   onChanged: (value) {
//                                     setState(() {
//                                       type = value.toString();
//                                     });
//                                     print(type);
//                                   },
//                                 ),
//                                 const Text(
//                                   "Notification",
//                                 ),
//                               ],
//                             ),
//                           ),
//
//                           // Spacer(),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     SizedBox(
//                       width: 120,
//                       height: 35,
//                       child: Consumer<NotificationToGuardian_Providers>(
//                         builder: (context, val, child) => val.loading
//                             ? const Center(
//                                 child: Text(
//                                 "Loading",
//                                 style: TextStyle(
//                                     color: UIGuide.light_Purple, fontSize: 16),
//                               ))
//                             : MaterialButton(
//                                 color: UIGuide.light_Purple,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(10.0),
//                                 ),
//                                 child: const Text(
//                                   'View',
//                                   style: TextStyle(
//                                       color: UIGuide.WHITE,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                                 onPressed: () async {
//                                   if (notificationCourseController
//                                           .text.isEmpty ||
//                                       notificationDivisionListController
//                                           .text.isEmpty) {
//                                     snackbarWidget(
//                                         2, 'Select Course & Division', context);
//                                   } else {
//                                     await Provider.of<
//                                                 NotificationToGuardian_Providers>(
//                                             context,
//                                             listen: false)
//                                         .clearStudentList();
//
//                                     divisionId =
//                                         notificationDivisionListController.text
//                                             .toString();
//                                     courseId = notificationCourseController.text
//                                         .toString();
//
//                                     await Provider.of<
//                                                 NotificationToGuardian_Providers>(
//                                             context,
//                                             listen: false)
//                                         .getNotificationView(
//                                             courseId, divisionId);
//                                   }
//                                 }),
//                       ),
//                     ),
//                   ],
//                 ),
//                 kheight10,
//                 value.notificationView.isEmpty
//                     ? const SizedBox(
//                         height: 0,
//                         width: 0,
//                       )
//                     : Container(
//                         decoration: BoxDecoration(
//                             color: const Color.fromARGB(255, 241, 243, 245),
//                             border: Border.all(
//                                 color: UIGuide.light_black, width: 1)),
//                         child: Padding(
//                           padding: const EdgeInsets.only(top: 2.0, bottom: 2),
//                           child: Table(
//                             columnWidths: const {
//                               0: FlexColumnWidth(1.3),
//                               1: FlexColumnWidth(4),
//                               2: FlexColumnWidth(1.4),
//                             },
//                             children: [
//                               TableRow(children: [
//                                 const Text(
//                                   ' Sl.No.',
//                                   style: TextStyle(
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                                 const Center(
//                                   child: Text(
//                                     'Name',
//                                     style: TextStyle(
//                                         fontSize: 15,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                 ),
//                                 Consumer<NotificationToGuardian_Providers>(
//                                   builder: (context, value, child) =>
//                                       GestureDetector(
//                                           onTap: () {
//                                             value.selectAll();
//                                           },
//                                           child: value.isselectAll
//                                               ? Padding(
//                                                   padding:
//                                                       const EdgeInsets.only(
//                                                           left: 15),
//                                                   child: SvgPicture.asset(
//                                                     UIGuide.check,
//                                                     color: UIGuide.light_Purple,
//                                                   ),
//                                                 )
//                                               : const Text(
//                                                   '  Select All',
//                                                   style: TextStyle(
//                                                       fontSize: 15,
//                                                       fontWeight:
//                                                           FontWeight.bold,
//                                                       color:
//                                                           UIGuide.light_Purple),
//                                                 )),
//                                 )
//                               ])
//                             ],
//                           ),
//                         ),
//                       ),
//                 Consumer<NotificationToGuardian_Providers>(
//                   builder: (context, value, child) {
//                     return Expanded(
//                       child: Scrollbar(
//                         thickness: 5,
//                         controller: _scrollController,
//                         child: ListView.builder(
//                           scrollDirection: Axis.vertical,
//                           itemCount: value.notificationView.isEmpty
//                               ? 0
//                               : value.notificationView.length,
//                           itemBuilder: ((context, index) {
//                             return Container(
//                               decoration: BoxDecoration(
//                                 color: index.isEven
//                                     ? Colors.white
//                                     : const Color.fromARGB(255, 241, 243, 245),
//                                 border: Border.all(
//                                     color: UIGuide.light_black, width: 1),
//                               ),
//                               child: Notification_StudList(
//                                 viewStud: value.notificationView[index],
//                                 indexx: index,
//                               ),
//                             );
//                           }),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ],
//             ),
//             if (value.loading) pleaseWaitLoader()
//             // WillPopScope(
//             //   onWillPop: () async {
//             //     return false;
//             //   },
//             //   child: Container(
//             //     color: Colors.black.withOpacity(0.2),
//             //     child: Center(
//             //       child: Container(
//             //         decoration: const BoxDecoration(color: UIGuide.WHITE),
//             //         child: const Padding(
//             //           padding: EdgeInsets.all(15.0),
//             //           child: Row(
//             //             mainAxisSize: MainAxisSize.min,
//             //             mainAxisAlignment: MainAxisAlignment.center,
//             //             children: [
//             //               CircularProgressIndicator(
//             //                 color: UIGuide.light_Purple,
//             //                 strokeWidth: 2,
//             //               ),
//             //               kWidth,
//             //               Text(
//             //                 "Please Wait...",
//             //                 style: TextStyle(
//             //                     color: UIGuide.light_Purple,
//             //                     fontWeight: FontWeight.w700,
//             //                     fontSize: 18),
//             //               )
//             //             ],
//             //           ),
//             //         ),
//             //       ),
//             //     ),
//             //   ),
//             // ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: BottomAppBar(
//         elevation: 3.0,
//         child: Padding(
//           padding: const EdgeInsets.only(left: 12, right: 12),
//           child: Consumer<NotificationToGuardian_Providers>(
//             builder: (context, value, child) => value
//                         .notificationView.isEmpty ||
//                     value.loading
//                 ? const SizedBox(
//                     height: 0,
//                     width: 0,
//                   )
//                 : MaterialButton(
//                     shape: const RoundedRectangleBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(10.0))),
//                     color: UIGuide.light_Purple,
//                     onPressed: () async {
//                       if (type == 'notification') {
//                         await Provider.of<NotificationToGuardian_Providers>(
//                                 context,
//                                 listen: false)
//                             .submitStudent(context);
//                       } else {
//                         await Provider.of<NotificationToGuardian_Providers>(
//                                 context,
//                                 listen: false)
//                             .getProvider();
//                         value.type = type;
//                         if (type == 'email') {
//                           await Provider.of<NotificationToGuardian_Providers>(
//                                   context,
//                                   listen: false)
//                               .submitSmsStudent(context);
//                         } else if (type == "sms") {
//                           if (value.providerName == null) {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(
//                                 elevation: 10,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(10)),
//                                 ),
//                                 duration: Duration(seconds: 1),
//                                 margin: EdgeInsets.only(
//                                     bottom: 80, left: 30, right: 30),
//                                 behavior: SnackBarBehavior.floating,
//                                 content: Text(
//                                   'Sms Provider Not Found.....!',
//                                   textAlign: TextAlign.center,
//                                 ),
//                               ),
//                             );
//                           } else {
//                             await Provider.of<NotificationToGuardian_Providers>(
//                                     context,
//                                     listen: false)
//                                 .submitSmsStudent(context);
//                           }
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
//                                 'Something went wrong.....!',
//                                 textAlign: TextAlign.center,
//                               ),
//                             ),
//                           );
//                         }
//                       }
//                     },
//                     child: const Text('Proceed',
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 16,
//                             fontWeight: FontWeight.w400)),
//                   ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class Notification_StudList extends StatelessWidget {
//   final StudentViewbyCourseDivision_notification_Stf viewStud;
//   const Notification_StudList(
//       {Key? key, required this.viewStud, required this.indexx})
//       : super(key: key);
//   final int indexx;
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<NotificationToGuardian_Providers>(
//       builder: (context, value, child) => ListTile(
//         dense: true,
//         titleAlignment: ListTileTitleAlignment.center,
//         shape: const RoundedRectangleBorder(),
//         selectedColor: UIGuide.light_Purple,
//         leading: Text(
//           (indexx + 1).toString(),
//           textAlign: TextAlign.center,
//         ),
//         onTap: () {
//           value.selectItem(viewStud);
//         },
//         selectedTileColor: const Color.fromARGB(255, 10, 27, 141),
//         title: Text(
//           viewStud.name == null ? '---' : viewStud.name.toString(),
//           style: const TextStyle(
//               fontSize: 14, fontWeight: FontWeight.w600, color: UIGuide.BLACK),
//         ),
//         subtitle: Row(
//           children: [
//             const Text("Adm no: "),
//             Expanded(child: Text(viewStud.admnNo ?? '---')),
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
// class Text_Matter_Notification extends StatelessWidget {
//   final List<String> toList;
//   final String type;
//   Text_Matter_Notification({Key? key, required this.toList, required this.type})
//       : super(key: key);
//   final titleController = TextEditingController();
//   final matterController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
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
//                   Consumer<NotificationToGuardian_Providers>(
//                     builder: (context, value, _) => SizedBox(
//                       width: 150,
//                       height: 40,
//                       child: MaterialButton(
//                         onPressed: () async {
//                           if (titleController.text.trim().isNotEmpty &&
//                               matterController.text.trim().isNotEmpty) {
//                             await Provider.of<NotificationToGuardian_Providers>(
//                                     context,
//                                     listen: false)
//                                 .sendNotification(context, titleController.text,
//                                     matterController.text, toList,
//                                     sentTo: type);
//                             titleController.clear();
//                             matterController.clear();
//                           } else {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(
//                                 elevation: 10,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(10)),
//                                 ),
//                                 duration: Duration(seconds: 1),
//                                 margin: EdgeInsets.only(
//                                     bottom: 80, left: 30, right: 30),
//                                 behavior: SnackBarBehavior.floating,
//                                 content: Text(
//                                   'Enter Title & Matter!',
//                                   textAlign: TextAlign.center,
//                                 ),
//                               ),
//                             );
//                           }
//                         },
//                         color: UIGuide.light_Purple,
//                         shape: const RoundedRectangleBorder(
//                           borderRadius: BorderRadius.only(
//                               topLeft: Radius.circular(20),
//                               topRight: Radius.circular(0),
//                               bottomLeft: Radius.circular(0),
//                               bottomRight: Radius.circular(20)),
//                         ),
//                         child: const Text(
//                           'Send',
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ),
//                     ),
//                   )
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
