
import 'dart:async';
import 'dart:developer';

import 'package:essconnect/Application/Staff_Providers/PortionProvider.dart';
import 'package:essconnect/Domain/Staff/PortionModel.dart';
import 'package:essconnect/utils/TextWrap(moreOption).dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../Constants.dart';
import '../../../utils/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';
class PortionApproval extends StatefulWidget {
  const PortionApproval({super.key});

  @override
  State<PortionApproval> createState() => _PortionApprovalState();
}

class _PortionApprovalState extends State<PortionApproval> {

  final courseController = TextEditingController();
  final courseIDController = TextEditingController();
  List divisionData = [];
  List subjectData =[];
  String division = '';
  String subject = "";
  String courseToDiv = '';
  String divisiontoSubject = '';

  List div=[];
  List sub=[];

  int? types;
  int? approveTypes;

  final remarksController = TextEditingController();

  String? selectedOption;
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
     // _scrollController.addListener(_scrollListener);
      var p = Provider.of<PortionProvider>(context, listen: false);
      await p.setLoading(false);
      await p.clearAllDetails();
      await p.getPortionApproveCourse();
      p.setLoading(false);
      p.fromdateselect=DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day) ;
      p.todateselect =DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day) ;
      p.getDateNow();
      courseIDController.clear();
      types=1;
      approveTypes=0;
      print("approve status");
      print(p.isApproval);
      // p.clearDivision();
      // p.clearSubject();


    });
  }

  Future<Image> _loadImage(BuildContext context, String imageUrl) async {
    // Simulate a network request to load the image
    final Image image = Image.network(imageUrl);
    final Completer<void> completer = Completer();
    final ImageStreamListener listener = ImageStreamListener(
          (ImageInfo info, bool _) {
        completer.complete();
      },
      onError: (dynamic error, StackTrace? stackTrace) {
        completer.completeError(error);
      },
    );

    image.image.resolve(ImageConfiguration()).addListener(listener);
    await completer.future;
    return image;
  }

  Future<void> showPhotoDialog(BuildContext context,String photo,String ext) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        var size= MediaQuery.of(context).size;
        return AlertDialog(
          content: Container(

            height:size.height*0.6,
            child: Center(
              child: CircularProgressIndicator(
                color: UIGuide.light_Purple,
              ),
            ),
          ),
        );
      },
    );

    try {
      Image image = await _loadImage(context, photo);
      Navigator.of(context).pop(); // Remove the loading dialog

      showDialog(
        context: context,
        builder: (BuildContext context) {
          var size= MediaQuery.of(context).size;
          return AlertDialog(
            content: Container(

              height: size.height*0.6,
              child: image,
            ),
          );
        },
      );
    } catch (e) {
      Navigator.of(context).pop(); // Remove the loading dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            var size= MediaQuery.of(context).size;

            return
                 Dialog(
                child: Container(
                  padding: EdgeInsets.all(4.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                  ext==".pdf"?
                  SizedBox(
                      height:size.height*0.6 ,
                      child: SfPdfViewer.network(photo)):
                    SizedBox(
                      height:size.height*0.6 ,
                      child: Image.network(
                      photo,
                      ),
                    ),
                    //  SizedBox(height: size),
                    //   ElevatedButton(
                    //     style: ElevatedButton.styleFrom(
                    //       backgroundColor: UIGuide.light_Purple,
                    //     ),
                    //     onPressed: () {
                    //       Navigator.of(context).pop();
                    //
                    //     },
                    //     child: Text('Close'),
                    //   ),
                    ],
                  ),
                ),
              );

          },
        );
    }
  }

  // Future showPhotoDialog(BuildContext context,String photo,String ext) async {
  //   // Sample photo URL
  //
  //
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       var size= MediaQuery.of(context).size;
  //
  //       return Consumer<PortionProvider>(
  //         builder: (context, value, _) =>
  //         value.loading?
  //             CircularProgressIndicator(
  //               color: UIGuide.light_Purple,
  //             ):
  //            Dialog(
  //           child: Container(
  //
  //             padding: EdgeInsets.all(4.0),
  //             child: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //             ext==".pdf"?
  //             SizedBox(
  //                 height:size.height*0.6 ,
  //                 child: SfPdfViewer.network(photo)):
  //               SizedBox(
  //                 height:size.height*0.6 ,
  //                 child: Image.network(
  //                 photo,
  //                 ),
  //               ),
  //               //  SizedBox(height: size),
  //                 ElevatedButton(
  //                   style: ElevatedButton.styleFrom(
  //                     backgroundColor: UIGuide.light_Purple,
  //                   ),
  //                   onPressed: () {
  //                     Navigator.of(context).pop();
  //
  //                   },
  //                   child: Text('Close'),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    var size= MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Consumer<PortionProvider>(
          builder: (context, value, _) =>
              Column(
                children:[
                  kheight5,

                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left:8.0),
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
                      ),
                      kWidth,
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
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
                      ),


                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 45,
                            child:

                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 3,
                                  foregroundColor: UIGuide.BLACK,
                                  backgroundColor: UIGuide.ButtonBlue,
                                  padding: const EdgeInsets.all(0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: const BorderSide(
                                        color: UIGuide.light_black,
                                      )),
                                ),
                                onPressed: () {

                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Dialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(15)),
                                            child: LimitedBox(
                                              maxHeight: size.height / 1.3,
                                              child: ListView.builder(
                                                  shrinkWrap: true,
                                                  itemCount:
                                                  value.approvecourseList.length,
                                                  itemBuilder: (context, index) {
                                                    return ListTile(
                                                      onTap: () async {
                                                        Navigator.of(context).pop();
                                                       await value.clearDivision();
                                                       await value.clearSubject();
                                                       divisionData.clear();
                                                       div.clear();
                                                       sub.clear();
                                                       division='';
                                                       subject='';
                                                       value.reportView.clear();
                                                        // value.subjectListApproval.clear();
                                                        // value.subSubjectList.clear();
                                                       //value.finalSelectedList.clear();



                                                        courseController.text = value
                                                            .approvecourseList[
                                                        index]
                                                            .text ??
                                                            '--';
                                                        courseIDController
                                                            .text = value
                                                            .approvecourseList[
                                                        index]
                                                            .value ??
                                                            '--';
                                                        await value.getDivisionListApproval(courseIDController.text);
                                                      },
                                                      title: Text(
                                                        value.approvecourseList[index]
                                                            .text ??
                                                            '--',
                                                        textAlign: TextAlign.start,
                                                      ),
                                                    );
                                                  }),
                                            ));
                                      });
                                },
                                child: TextField(
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: UIGuide.BLACK,
                                      overflow: TextOverflow.clip),
                                  // textAlign: TextAlign.center,
                                  controller: courseController,
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 5, top: 0),
                                    floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                    filled: true,
                                    fillColor: Colors.transparent,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          style: BorderStyle.none, width: 0),
                                    ),
                                    labelText: "  Select Course *",
                                    labelStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: UIGuide.BLACK,

                                    ),

                                  ),
                                  textAlign: TextAlign.center,
                                  enabled: false,
                                )),
                          ),
                        ),
                      ),


                      Expanded(

                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8),
                          child: SizedBox(
                            height: 45,

                            child:
                            Padding(
                              padding: const EdgeInsets.all(.0),
                              child: MultiSelectDialogField(



                                items: value.divisiondropDown,
                           selectedColor:UIGuide.THEME_LIGHT,
                                listType: MultiSelectListType.CHIP,
                                title: courseIDController.text.isEmpty?
                                Text(
                                  "Select Course",
                                  style: TextStyle(color: Colors.grey),
                                ):
                                Text(
                                  "Select Division",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                 // separateSelectedItems:true,
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


                                onConfirm: (results) async {
                                  // value.results.clear();
                                  div= results;

                                  divisionData.clear();
                                  value.reportView.clear();
                                 // results.clear();
                                  for (var i = 0; i < results.length; i++) {
                                    PortionDivisions data =
                                    div[i] as PortionDivisions;

                                    print(data.value);
                                    divisionData.add(data.value);
                                    divisionData.map((e) => data.value);
                                    print("${divisionData.map((e) => data.value)}");
                                  }
                                  print("divisionDataaa    $divisionData");
                                  division = divisionData
                                      .map((id) => id)
                                      .join(',');
                                  print(division);
                                  await value.divisionCounter(divisionData.length);
                                  //value.studentViewList.clear();

                                  print("data division  $division");
                                },
                                chipDisplay:  MultiSelectChipDisplay.none(),

                            ),
                          ),
                        ),
                      ),
                      ),
                    ],
                  ),
                  kheight5,

                  Consumer<PortionProvider>(
                    builder: (context, value, _) =>
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8),
                            child: SizedBox(
                              height: 45,
                              width: size.width*0.45,
                              child:
                              MultiSelectDialogField(
                                items:
                                value.subjectdropDown,
                                selectedColor: UIGuide.THEME_LIGHT,
                                listType: MultiSelectListType.CHIP,
                                title: const Text(
                                  "Select Subject",
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
                                buttonText: value.subjLen == 0
                                    ? const Text(
                                  "Select Subject",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                )
                                    : Text(
                                  "   ${value.subjLen.toString()} Selected",
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                                chipDisplay: MultiSelectChipDisplay.none(),
                                onConfirm: (results) async {
                                 // value.results.clear();
                                  sub= results;
                                  subjectData.clear();
                                  value.reportView.clear();

                                  for (var i = 0; i < results.length; i++) {
                                    PortionSubjects data =
                                    results[i] as PortionSubjects;

                                    print(data.value);
                                    subjectData.add(data.value);
                                    subjectData.map((e) => data.value);
                                    print("${subjectData.map((e) => data.value)}");
                                  }
                                  print("subjectDataaaa    $subjectData");
                                  subject = subjectData
                                      .map((id) => id)
                                      .join(',');
                                  print(subject);
                                  await value.subjectCounter(results.length);
                                  //value.studentViewList.clear();
                                 // results.clear();
                                  print("data subject  $subject");
                                },
                              ),
                            ),
                          ),
                        ),
                  ),
                  value.isApproval=="True"?
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
                                value.reportView.clear();

                                setState(() {
                                  types = 1;
                                });
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [

                                  Radio(
                                    activeColor: UIGuide.light_Purple,
                                    value:1,
                                    groupValue: types,
                                    onChanged: (value1) {
                                      value.reportView.clear();
                                      setState(() {
                                        types = value1;
                                      });
                                      print(types);
                                    },
                                  ),

                                  Text(
                                    "Not Approved",
                                  ),
                                ],
                              ),
                            ),

                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                value.reportView.clear();
                                setState(() {
                                  types = 0;
                                });
                              },
                              child:

                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [

                                  Radio(
                                    activeColor: UIGuide.light_Purple,
                                    value: 0,
                                    groupValue: types,
                                    onChanged: (value1) {
                                      value.reportView.clear();
                                      setState(() {

                                        types = value1;
                                      });
                                      print(types);
                                    },
                                  ),
                                  Text(
                                    "Approved",
                                  ),
                                ],
                              ),
                            ),

                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                value.reportView.clear();
                                setState(() {
                                  types = 2;
                                });
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [

                                  Radio(
                                    activeColor: UIGuide.light_Purple,
                                    value: 2,
                                    groupValue: types,
                                    onChanged: (value1) {
                                      value.reportView.clear();
                                      setState(() {

                                        types = value1;
                                      });
                                      print(types);
                                    },
                                  ),
                                  Text(
                                    "Rejected",
                                  ),
                                ],
                              ),
                            ),
                            Spacer(),



                          ],
                        ),
                      ),
                    ),
                  ):
                      SizedBox(
                        height: 0,
                        width: 0,
                      ),


                  Consumer<PortionProvider>(
                    builder: (context, value, _) =>
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 150,
                              child: value.loading
                                  ? Padding(
                                    padding: const EdgeInsets.only(top:8.0),
                                    child: Container(
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
                                        ))),
                                  )
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
                                    print("from date");
                                   print( value.fromdateselect);
                                    print("To date");
                                    print( value.todateselect);

                                     value.reportView.clear();
                                     if(courseIDController.text.isEmpty){
                                       Fluttertoast.showToast(
                                         msg: "Please Select Any Course..",
                                         toastLength: Toast.LENGTH_SHORT,
                                         gravity: ToastGravity.BOTTOM,
                                         timeInSecForIosWeb: 1,
                                         backgroundColor: Colors.black54,
                                         textColor: Colors.white,
                                         fontSize: 14.0,
                                       );

                                     }
                                     else if(value.fromdateselect!.isAfter(value.todateselect!)){
                                       Fluttertoast.showToast(
                                         msg: "Invalid Date Range...",
                                         toastLength: Toast.LENGTH_SHORT,
                                         gravity: ToastGravity.BOTTOM,
                                         timeInSecForIosWeb: 1,
                                         backgroundColor: Colors.black54,
                                         textColor: Colors.white,
                                         fontSize: 14.0,
                                       );
                                     }
                                     else {
                                       await value.getApprovalReport(
                                           courseIDController.text,
                                           division,
                                           subject,
                                           value.fromdateSend,
                                           value.todateSend,
                                           types.toString());

                                       if (value.reportView.isEmpty) {
                                         Fluttertoast.showToast(
                                           msg: "No Data found..",
                                           toastLength: Toast.LENGTH_SHORT,
                                           gravity: ToastGravity.BOTTOM,
                                           timeInSecForIosWeb: 1,
                                           backgroundColor: Colors.black54,
                                           textColor: Colors.white,
                                           fontSize: 14.0,
                                         );
                                       }
                                     }




                                  },
                                  child: const Text("View")),
                            ),
                          ],
                        ),
                  ),




                  Consumer<PortionProvider>(
                      builder: (context, provider, _) =>

                          Expanded(
                            child: ListView.builder(
                             // controller: _scrollController,
                              shrinkWrap: true,
                              itemCount: provider.reportView.length,
                              itemBuilder: (context, index) {
                                DateTime dateTime = DateFormat("MM/dd/yyyy HH:mm:ss").parse(provider.reportView[index].date.toString());
                                String formattedDate = DateFormat('dd-MMM-yyyy').format(dateTime);
                                return Column(
                                  children: [
                                    kheight5,
                                    Padding(
                                              padding: const EdgeInsets.all(4.0),
                                              child: InkWell(
                                                onTap: () async{
                                                  await provider.getApprovalReportDetailView(provider.reportView[index].portionEntryId.toString());
                                                  remarksController.clear();
                                                  showAnimatedDialog(
                                                    animationType: DialogTransitionType.size,
                                                    context: context,
                                                    builder: (BuildContext context) {
                                                      return AlertDialog(
                                                        // title: Text('Portion Entry Details'),
                                                        // content: Text('This is an alert dialog.'),
                                                        actions: <Widget>[
                                                          Column(
                                                            children: [

                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                Text("Portion Entry Details",style:
                                                                  TextStyle(
                                                                    fontWeight: FontWeight.w500,
                                                                    color: UIGuide.light_Purple
                                                                  ),),
                                                                  IconButton(
                                                                    splashRadius: 15.0,
                                                                      onPressed: (){
                                                                        Navigator.pop(context);
                                                                      },

                                                                      icon: Icon(Icons.clear))
                                                                ],
                                                              ),
                                                             const Column(
                                                               children: [
                                                                 Divider(
                                                                   height: 1,
                                                                   thickness: 1.5,
                                                                 )
                                                               ],
                                                             ),
                                                              kheight5,

                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [

                                                                Container(
                                                                  decoration: BoxDecoration(
                                                                    color: UIGuide.THEME_LIGHT,
                                                                    borderRadius: BorderRadius.circular(10)),


                                                                    child: Padding(
                                                                      padding: const EdgeInsets.all(8.0),
                                                                      child: Text("${provider.portionSubject}"),
                                                                    )),
                                                                Container(
                                                                    decoration: BoxDecoration(
                                                                        color: UIGuide.THEME_LIGHT,
                                                                        borderRadius: BorderRadius.circular(10)),


                                                                    child: Padding(
                                                                      padding: const EdgeInsets.all(8.0),
                                                                      child: Text("$formattedDate"),
                                                                    )),
                                                              ],),
                                                              kheight10,

                                                              Row(
                                                                children: [
                                                                  Text("Chapter : "),
                                                                  Flexible(
                                                                    child: Text("${provider.portionChapter}",
                                                                     style: TextStyle(
                                                                       color: UIGuide.light_Purple
                                                                     ),
                                                                   maxLines: 5,
                                                                      overflow: TextOverflow.ellipsis,

                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              kheight10,
                                                              Row(
                                                                children: [
                                                                  Text("Topic     : ",

                                                                  ),
                                                                  Flexible(
                                                                    child: Text(

                                                                        "${provider.portionTopic==null?"":
                                                                        provider.portionTopic
                                                                        }",
                                                                      style: TextStyle(
                                                                          color: UIGuide.light_Purple
                                                                      ),
                                                                      maxLines: 5,
                                                                      overflow: TextOverflow.ellipsis,

                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              kheight10,
                                                              Row(
                                                                children: [
                                                                  Text("Description  : ",

                                                                  ),
                                                                  Flexible(
                                                                    child: Text(

                                                                      "${provider.portionDescription==null?"":
                                                                      provider.portionDescription
                                                                      }",
                                                                      style: TextStyle(
                                                                          color: UIGuide.light_Purple
                                                                      ),
                                                                      maxLines: 5,
                                                                      overflow: TextOverflow.ellipsis,

                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              kheight10,
                                                              Row(
                                                                children: [
                                                                  Text("Details  : ",

                                                                  ),
                                                                  Flexible(
                                                                    child: Text(

                                                                      "${provider.portionDetails==null?"":
                                                                      provider.portionDetails
                                                                      }",
                                                                      style: TextStyle(
                                                                          color: UIGuide.light_Purple
                                                                      ),
                                                                      maxLines: 5,
                                                                      overflow: TextOverflow.ellipsis,

                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              kheight10,
                                                              Row(
                                                                children: [
                                                                  Text("Assignment  : ",

                                                                  ),
                                                                  Flexible(
                                                                    child: Text(

                                                                      "${provider.portionAssignment==null?"":
                                                                      provider.portionAssignment
                                                                      }",
                                                                      style: TextStyle(
                                                                          color: UIGuide.light_Purple
                                                                      ),
                                                                      maxLines: 5,
                                                                      overflow: TextOverflow.ellipsis,

                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              kheight10,
                                                              provider.photoList1.isNotEmpty?
                                                              Row(
                                                                children: [
                                                                  Text("Attachments :"),
                                                                ],
                                                              ):
                                                              SizedBox(height: 0,width: 0),
                                                              provider.photoList1.isNotEmpty?
                                                              SizedBox(
                                                                height: size.height*0.15,
                                                                width: size.width*0.6,

                                                                child: ListView.builder(
                                                                  itemCount:provider.photoList1.length,
                                                                  itemBuilder: (context, index) {
                                                                    return Table(
                                                                      columnWidths: const {
                                                                        0: FlexColumnWidth(0.5),
                                                                        1: FlexColumnWidth(2),
                                                                        2: FlexColumnWidth(0.5),
                                                                        // 3: FlexColumnWidth(0.5),
                                                                      },
                                                                      border: TableBorder.all(
                                                                          borderRadius: BorderRadius.only(
                                                                              topLeft: Radius.circular(10),
                                                                              topRight: Radius.circular(10)),
                                                                          color: const Color.fromARGB(
                                                                              255, 248, 248, 248)),
                                                                      children:  [

                                                                        TableRow(
                                                                            decoration: BoxDecoration(
                                                                              borderRadius: BorderRadius.only(
                                                                                  topLeft: Radius.circular(10),
                                                                                  topRight: Radius.circular(10)),
                                                                              color:
                                                                              UIGuide.ButtonBlue,
                                                                              //Color.fromARGB(255, 223, 223, 223),
                                                                            ),
                                                                            children: [
                                                                              TableCell(
                                                                                verticalAlignment:
                                                                                TableCellVerticalAlignment.middle,
                                                                                child: Text(
                                                                                  "${index+1}",
                                                                                  style: TextStyle(
                                                                                      fontWeight: FontWeight.w400),
                                                                                  textAlign: TextAlign.center,
                                                                                ),
                                                                              ),
                                                                              TableCell(
                                                                                verticalAlignment:
                                                                                TableCellVerticalAlignment.middle,
                                                                                child: Padding(
                                                                                  padding: EdgeInsets.only(
                                                                                    top: 6.0,
                                                                                    bottom: 6,
                                                                                  ),
                                                                                  child: InkWell(
                                                                                    onTap:() async{

                                                                                   await showPhotoDialog(context,  provider.photoList1[index]['file']['url'],provider.photoList1[index]['file']['extension']);

                                                                                   print("------url----");
                                                                                      log( provider.photoList1[index]['file']['url']);
                                                                                    },
                                                                                    child: Text(
                                                                                      provider.photoList1[index]['file']['name'],
                                                                                      style: TextStyle(
                                                                                          fontWeight: FontWeight.w400),
                                                                                      textAlign: TextAlign.center,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              TableCell(
                                                                                verticalAlignment:
                                                                                TableCellVerticalAlignment.middle,
                                                                                child: Padding(
                                                                                  padding: EdgeInsets.only(
                                                                                    top: 6.0,
                                                                                    bottom: 6,
                                                                                  ),
                                                                                  child: InkWell(
                                                                                    onTap:() {
                                                                                      showPhotoDialog(context,  provider.photoList1[index]['file']['url'],provider.photoList1[index]['file']['extension']);

                                                                                    },

                                                                                      child: Icon(Icons.visibility,size: 20,))
                                                                                ),
                                                                              ),



                                                                            ])
                                                                      ],
                                                                    );

                                                                  },

                                                                ),

                                                              ):SizedBox(height: 0,width: 0),

                                                              kheight10,

                                                              value.isApproval==false?
                                                              Padding(
                                                                padding: const EdgeInsets.all(4.0),
                                                                child: SizedBox(
                                                                  height: 40,
                                                                  child: TextFormField(

                                                                    inputFormatters: [LengthLimitingTextInputFormatter(1000)],
                                                                    controller: remarksController,
                                                                    minLines: 1,
                                                                    //  maxLines: 2,
                                                                    keyboardType: TextInputType.multiline,
                                                                    decoration: const InputDecoration(
                                                                      contentPadding: EdgeInsets.fromLTRB(12.0, 10.0, 20.0, 10.0),
                                                                      labelText: 'Remarks',
                                                                      hintText: 'Enter Remarks',
                                                                      labelStyle: TextStyle(
                                                                          color: UIGuide.BLACK,fontSize: 12),
                                                                      hintStyle: TextStyle(color: Colors.grey,),
                                                                      alignLabelWithHint: false,
                                                                      helperStyle: TextStyle(color: UIGuide.light_Purple),
                                                                      border: OutlineInputBorder(
                                                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                                                      ),
                                                                      focusedBorder: OutlineInputBorder(
                                                                        borderSide: BorderSide(
                                                                            color: UIGuide.light_Purple, width: 1.0),
                                                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ):
                                                              SizedBox(
                                                                height: 0,
                                                                width: 0,
                                                              ),
                                                              kheight10,

                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                children: [

                                                                  value.isApproval==true?
                                                                  TextButton(
                                                                    onPressed: () async {
                                                                      provider.portionStatus!.isNotEmpty?
                                                                      await   provider.portionApprovalConfirmUpdate(
                                                                          context,
                                                                          provider.portionEntryId.toString(),
                                                                          "1",
                                                                          remarksController.text):
                                                                      await   provider.portionApprovalConfirm(
                                                                          context,
                                                                          provider.portionEntryId.toString(),
                                                                          "1",
                                                                          remarksController.text);
                                                                      Navigator.of(context).pop();
                                                                      provider.reportView.clear();
                                                                      await value.getApprovalReport(
                                                                          courseIDController.text,
                                                                          division,
                                                                          subject,
                                                                          value.fromdateSend,
                                                                          value.todateSend,
                                                                          types.toString());
                                                                    },
                                                                    child: Text('Reject',style: TextStyle(
                                                                      color: UIGuide.button2
                                                                    ),),
                                                                  ):
                                                                  SizedBox(
                                                                    height: 0,
                                                                    width: 0,
                                                                  ),

                                                                  value.isApproval==true?
                                                                  TextButton(
                                                                    onPressed: () async {

                                                                      provider.portionStatus!.isNotEmpty?
                                                                   await   provider.portionApprovalConfirmUpdate(
                                                                          context,
                                                                          provider.portionEntryId.toString(),
                                                                          "0",
                                                                          remarksController.text.isEmpty?"null": remarksController.text):
                                                                      await provider.portionApprovalConfirm(
                                                                          context,
                                                                          provider.portionEntryId.toString(),
                                                                          "0",
                                                                          remarksController.text.isEmpty?"null": remarksController.text);
                                                                       Navigator.of(context).pop();
                                                                      provider.reportView.clear();
                                                                      await value.getApprovalReport(
                                                                          courseIDController.text,
                                                                          division,
                                                                          subject,
                                                                          value.fromdateSend,
                                                                          value.todateSend,
                                                                          types.toString());
                                                                    },
                                                                    child: Text('Approve',style: TextStyle(
                                                      color: UIGuide.button1),
                                                                  ),
                                                                  ):
                                                                      SizedBox(
                                                                        height: 0,
                                                                        width: 0,
                                                                      )
                                                                ],
                                                              ),

                                                            ],
                                                          )
                                                        ],
                                                      );
                                                    },
                                                  );

                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(

                                                      border: Border.all(
                                                          width: 1,
                                                          color: UIGuide.THEME_LIGHT
                                                      ),
                                                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),topRight:Radius.circular(20) ),
                                                      color: UIGuide.ButtonBlue
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
                                                                    "${index+1}"
                                                                    ),
                                                                  ),
                                                                  decoration: BoxDecoration(

                                                                      color: UIGuide.THEME_LIGHT
                                                                  ),
                                                                ),
                                                                kWidth5,

                                                                Container(

                                                                  child:Padding(
                                                                    padding: const EdgeInsets.all(4.0),
                                                                    child: Text(
                                                                       formattedDate
                                                                    ),
                                                                  ),
                                                                  decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.only(
                                                                        topRight: Radius.circular(40.0),
                                                                        bottomRight: Radius.circular(40.0),
                                                                        topLeft: Radius.circular(40.0),
                                                                        bottomLeft: Radius.circular(40.0)),


                                                                      color: UIGuide.THEME_LIGHT
                                                                  ),
                                                                ),

                                                              ],
                                                            ),

                                                            Icon(Icons.visibility,color: UIGuide.light_Purple,)



                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.all(4.0),
                                                        child: Row(

                                                          children: [

                                                            Text("Staff       : ",style: TextStyle(
                                                                color: UIGuide.light_Purple
                                                            ),),
                                                            Flexible(
                                                              child: Text(provider.reportView[index].staff.toString(),

                                                                overflow: TextOverflow.ellipsis,

                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.all(4.0),
                                                        child: Row(

                                                          children: [

                                                            Text("Subject  : ",style:
                                                              TextStyle(
                                                                  color: UIGuide.light_Purple
                                                              ),),
                                                            Flexible(
                                                              child: Text(provider.reportView[index].subject.toString(),

                                                                overflow: TextOverflow.ellipsis,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.all(4.0),
                                                        child: Row(

                                                          children: [

                                                            Text("Chapter : ", style: TextStyle(
                                                                color: UIGuide.light_Purple
                                                            ),),
                                                            // TextWrapper(text:provider.reportView[index].chapter.toString() ,
                                                            //     fSize: 12)
                                                            //


                                                            Flexible(
                                                              child: Text(provider.reportView[index].chapter.toString(),

                                                                softWrap: true,
                                                                maxLines: 2,
                                                                overflow: TextOverflow.ellipsis,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.all(4.0),
                                                        child: Row(

                                                          children: [

                                                            Text("Topic     : ", style: TextStyle(
                                                            color: UIGuide.light_Purple
                                                        ),),
                                                            // TextWrapper(text:provider.reportView[index].chapter.toString() ,
                                                            //     fSize: 12)
                                                            //

                                                            Flexible(
                                                              child:
                                                              Text(
                                                                provider.reportView[index].topic==null?"":provider.reportView[index].topic.toString(),

                                                                softWrap: true,
                                                                maxLines: 2,
                                                                overflow: TextOverflow.ellipsis,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),




                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )




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
