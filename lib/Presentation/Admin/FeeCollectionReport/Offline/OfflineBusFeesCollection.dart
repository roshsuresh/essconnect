import 'package:essconnect/Application/StudentProviders/OfflineFeeProviders.dart';
import 'package:essconnect/Domain/Admin/OfflineFeesDomain.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:provider/provider.dart';
import '../../../../Application/AdminProviders/OfflineFeesCollectionProvider.dart';
import '../../../../Application/Staff_Providers/Anecdotal/AncedotalStaffProvider.dart';
import '../../../../Constants.dart';
import '../../../../Debouncer.dart';
import '../../../../Domain/Staff/Anecdotal/InitialSelectionModel.dart';
import '../../../../utils/TextWrap(moreOption).dart';
import '../../../../utils/constants.dart';
import '../../../../utils/spinkit.dart';



class OfflineFeeCollection extends StatefulWidget {
  const OfflineFeeCollection({super.key});

  @override
  State<OfflineFeeCollection> createState() => _OfflineFeeCollectionState();
}

class _OfflineFeeCollectionState extends State<OfflineFeeCollection> {


  List courseData = [];
  List divisionData = [];
  String course = "";
  String courseToDiv = '';
  String division = '';
  final ScrollController _scrollController = ScrollController();
  final _debouncer = Debouncer(milliseconds: 1000);


  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      _scrollController.addListener(_scrollListener);
      var p = Provider.of<OffflineFeesProvider>(context, listen: false);
      await p.setLoading(false);
      p.clearInitial();
      p.getCourseList();
      p.netAmount='';
      p.getDateNow();


    });
  }
  void _scrollListener() async {
    final provider =
    Provider.of<OffflineFeesProvider>(context, listen: false);
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (provider.hasMoreData()) {

        provider.getFeeCollectionPagination(
            course,
            division,
            provider.fromdateSend,
            provider.todateSend);
        print("object");

      }
    }
  }


  @override
  Widget build(BuildContext context) {
    var size= MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8,top: 8),
        child: Consumer<OffflineFeesProvider>(
          builder: (context, value, _) =>
              Column(

                children:[
                  kheight20,
                  Consumer<OffflineFeesProvider>(
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
                                    items: value.courseDrop,
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
                                      value.collectionlList.clear();
                                      courseData = [];
                                      courseData.clear();
                                      value.divisionLen = 0;

                                      for (var a = 0; a < results.length; a++) {
                                        OfflineCourse data =
                                        results[a] as OfflineCourse;

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
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0, right: 8),
                                child: SizedBox(
                                  height: 45,
                                  child:
                                  MultiSelectDialogField(
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
                                      value.collectionlList.clear();
                                      divisionData = [];

                                      for (var i = 0; i < results.length; i++) {
                                        OfflineFeeDiv data =
                                        results[i] as OfflineFeeDiv;

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
                                      value.collectionlList.clear();
                                      results.clear();
                                      print("data div  $division");
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                  ),
                  Consumer<OffflineFeesProvider>(
                      builder: (context, value, _) =>
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 4),
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        elevation: 3,
                                        foregroundColor: UIGuide.BLACK,
                                        backgroundColor:UIGuide.ButtonBlue,
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
                                  padding: const EdgeInsets.only(left: 4),
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
                              kWidth,

                            ],
                          )
                  ),

                  Consumer<OffflineFeesProvider>(
                    builder: (context, value, _) =>
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 150,
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
                                    value.collectionlList.clear();
                                  //  value.currentPage = 2;


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

                                    else{
                                      value.currentPage=2;

                                      await    value.getFeeCollectionReport(
                                          context,
                                          course,
                                          division,
                                          value.fromdateSend,
                                          value.todateSend
                                      );
                                    }


                                    if (value.collectionlList.isEmpty) {
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
                            kheight10,


                          ],
                        ),

                  ),




                  Consumer<OffflineFeesProvider>(
                      builder: (context, provider, _) =>

                          Expanded(
                            child:
                                    ListView(
                                      controller: _scrollController,
                                      children: [


                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0,right: 8),
                                          child: Row(
                                            children: [
                                              value.collectionlList.isEmpty?Text(""):
                                              Container(

                                                  child: Row(
                                                    children: [
                                                      Text("  Last Updated Date: ${value.uploadedDate}",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w500,
                                                        color: UIGuide.light_Purple
                                                      ),
                                                      ),
                                                    ],
                                                  ),
                                                     ),
                                            ],
                                          ),
                                        ),

                                        ListView.builder(

                                            shrinkWrap: true,
                                            physics: NeverScrollableScrollPhysics(),
                                            itemCount: provider.collectionlList.length,
                                            itemBuilder: (context,index) {
                                           //   var date= DateFormat('dd-MMM-yyyy').format(provider.collectionlList[index].billDate!);
                                              DateTime dateTime = DateTime.parse(provider.collectionlList[index].billDate.toString());

                                              String billDate = DateFormat('dd-MM-yyyy').format(dateTime);

                                              return Padding(
                                                padding:  EdgeInsets.all(4.0),
                                                child: Container(
                                                  decoration: BoxDecoration(

                                                      border: Border.all(
                                                          width: 1,
                                                          color: UIGuide.THEME_LIGHT
                                                      ),
                                                      borderRadius: BorderRadius
                                                          .all(Radius.circular(8)),
                                                      color: Colors.white
                                                  ),

                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets
                                                            .all(4.0),
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
                                                                      (index + 1).toString(),),
                                                                  ),
                                                                  decoration: BoxDecoration(

                                                                      color: UIGuide.THEME_LIGHT
                                                                  ),
                                                                ),

                                                                Text("Bill No: "),
                                                                Text(provider
                                                                    .collectionlList[index]
                                                                    .billNo
                                                                    .toString(),
                                                                  style: TextStyle(
                                                                      color: UIGuide
                                                                          .light_Purple
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(

                                                              children: [
                                                                Text("Date : "),
                                                                Text(
                                                                  billDate,
                                                                  style: TextStyle(
                                                                      color: UIGuide
                                                                          .light_Purple
                                                                  ),),
                                                              ],
                                                            ),

                                                          ],
                                                        ),
                                                      ),

                                                      Padding(
                                                        padding: const EdgeInsets
                                                            .only(left: 4.0),
                                                        child: Row(

                                                          children: [
                                                            Text("name : "),
                                                            Expanded(
                                                              child: Padding(
                                                                padding: const EdgeInsets
                                                                    .only(top: 4.0),
                                                                child: TextWrapper(
                                                                  text: provider
                                                                      .collectionlList[index]
                                                                      .studentName
                                                                      .toString(),
                                                                  fSize: 14,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets
                                                            .all(4.0),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment
                                                              .spaceBetween,
                                                          children: [
                                                            Row(

                                                              children: [

                                                                Text("Admn No: "),
                                                                Text(provider
                                                                    .collectionlList[index]
                                                                    .admnNo
                                                                    .toString(),
                                                                  style: TextStyle(
                                                                      color: UIGuide
                                                                          .light_Purple
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(

                                                              children: [
                                                                Text("Class : "),
                                                                Text(
                                                                  provider
                                                                      .collectionlList[index]
                                                                      .division ==
                                                                      null ? "" :
                                                                  provider
                                                                      .collectionlList[index]
                                                                      .division
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      color: UIGuide
                                                                          .light_Purple
                                                                  ),),
                                                              ],
                                                            ),
                                                            Row(

                                                              children: [
                                                                Text("Roll No : "),
                                                                Text(
                                                                  provider
                                                                      .collectionlList[index]
                                                                      .rollNo ==
                                                                      null ? "" :
                                                                  provider
                                                                      .collectionlList[index]
                                                                      .rollNo
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      color: UIGuide
                                                                          .light_Purple
                                                                  ),),
                                                              ],
                                                            ),

                                                          ],
                                                        ),
                                                      ),

                                                      Padding(
                                                        padding: const EdgeInsets
                                                            .all(4.0),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment
                                                              .spaceBetween,
                                                          children: [
                                                            Row(

                                                              children: [

                                                                Text("Amount : "),
                                                                Text(provider
                                                                    .collectionlList[index]
                                                                    .amount
                                                                    .toString(),
                                                                  style: TextStyle(
                                                                      color: UIGuide
                                                                          .light_Purple
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(

                                                              children: [
                                                                Text("Fine : "),
                                                                Text(
                                                                  provider
                                                                      .collectionlList[index]
                                                                      .fine == null
                                                                      ? ""
                                                                      :
                                                                  provider
                                                                      .collectionlList[index]
                                                                      .fine
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      color: UIGuide
                                                                          .light_Purple
                                                                  ),),
                                                              ],
                                                            ),
                                                            Row(

                                                              children: [
                                                                Text("Subsidy : "),
                                                                Text(
                                                                  provider
                                                                      .collectionlList[index]
                                                                      .discount ==
                                                                      null ? "" :
                                                                  provider
                                                                      .collectionlList[index]
                                                                      .discount
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      color: UIGuide
                                                                          .light_Purple
                                                                  ),),
                                                              ],
                                                            ),

                                                          ],
                                                        ),
                                                      ),

                                                      Padding(
                                                        padding: const EdgeInsets
                                                            .only(left: 4.0),
                                                        child:
                                                        value.collectionlList[index].isCancelled==true ?
                                                        Row(
                                                          children: [
                                                            Text("Cancelled",
                                                              style:TextStyle(
                                                                  color: Colors.red
                                                              ) ,),
                                                          ],
                                                        ):
                                                        Row(

                                                          children: [

                                                            Text("Total : "),
                                                            Expanded(
                                                              child: Padding(
                                                                padding: const EdgeInsets
                                                                    .only(top: 4.0),
                                                                child: Text(
                                                                  provider
                                                                      .collectionlList[index]
                                                                      .totalAmount
                                                                      .toString(),
                                                                ),
                                                              ),
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
                                      ],
                                    ),



                          )

                  ),

                ],
              ),
        ),
      ),
      bottomNavigationBar: Consumer<OffflineFeesProvider>(
        builder: (context, snap, _) => snap.loading
            ? const SizedBox(
          height: 0,
          width: 0,
        )
            : BottomAppBar(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 10, right: 10, top: 5, bottom: 5),
            child: SizedBox(
              height: 35,
              child:

               // Text("Net Total: ${snap.netAmount}")
              ElevatedButton(
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
                },
                child:  Text(
                  "Net Total: ${snap.netAmount==null?"":snap.netAmount.toString()}",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
