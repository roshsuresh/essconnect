import 'dart:developer';
import 'dart:io';
import 'package:essconnect/Application/StudentProviders/OfflineFeeProviders.dart';
import 'package:essconnect/Domain/Admin/OfflineFeesDomain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import '../../../Application/AdminProviders/OfflineFeesCollectionProvider.dart';
import '../../../Constants.dart';
import '../../../Debouncer.dart';
import '../../../utils/TextWrap(moreOption).dart';
import '../../../utils/constants.dart';

class OfflineFeeCollection extends StatefulWidget {
  const OfflineFeeCollection({super.key});

  @override
  State<OfflineFeeCollection> createState() => _OfflineFeeCollectionState();
}

class _OfflineFeeCollectionState extends State<OfflineFeeCollection> {


  List courseData = [];
  List divisionData = [];
  String course = "";
  List crs=[];
  String courseToDiv = '';
  String division = '';
  final _debouncer = Debouncer(milliseconds: 1000);

  List div=[];
  String _selectedValue = 'School Fees';

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var p = Provider.of<OffflineFeesProvider>(context, listen: false);
      await p.setLoading(false);
      p.clearInitial();
      p.getCourseList();
      p.netAmount='';
      p.fromdateselect=DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day) ;
      p.todateselect =DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day) ;
      p.getDateNow();


    });
  }


  Future<void> startLoading() async {
    return await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const SimpleDialog(
          elevation: 0.0,
          backgroundColor: Colors.transparent, // can change this to your prefered color
          children: <Widget>[
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: UIGuide.light_Purple,
                  ),
                  SizedBox(height: 20),
                  Text('Please Wait...',style: TextStyle(
                      fontSize: 14,
                      color: UIGuide.ButtonBlue
                  ),),
                ],
              ),
            )
          ],
        );
      },
    );
  }

  Future<void> stopLoading() async {
    Navigator.of(context).pop();
  }

  Future<void> requestDownload(String _url, String _name,String _id) async {
    var p = Provider.of<OffflineFeesProvider>(context, listen: false);
    var _localPath;

    if (Platform.isAndroid) {
      _localPath = '/storage/emulated/0/Download';
    } else if (Platform.isIOS) {
      final dir = await getApplicationDocumentsDirectory();

      _localPath = dir.path;
    }

    print("pathhhh  $_localPath");
    final savedDir = Directory(_localPath);
    await savedDir.create(recursive: true).then((value) async {
      String? _taskid = await FlutterDownloader.enqueue(
        savedDir: _localPath,
        url: _url,
        fileName: " $_name ${p.fromdateDisplay}to${p.todateDisplay}.xlsx",
        showNotification: true,
        openFileFromNotification: true,
      );
      log("nweurll $_url");

      print(_taskid);
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Download complete'),
      duration: Duration(seconds: 1), // Adjust duration as needed
    ));
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
                  Container(
                    width: size.width*0.5,
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    decoration: BoxDecoration(
                      color: Colors.white, // Background color of the box
                      border: Border.all(color: UIGuide.light_Purple, width: 1), // Border color and width
                      borderRadius: BorderRadius.circular(8), // Rounded corners
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26, // Shadow color
                          blurRadius: 6.0, // Shadow blur effect
                          offset: Offset(0, 2), // Shadow position
                        ),
                      ],
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedValue,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedValue = newValue!;
                            value.collectionlList.clear();
                            value.buscollectionlList.clear();
                            value.netAmount="";
                            value.netAmountBus="";
                            print("seeleeeee $_selectedValue");

                          });
                        },
                        items: <String>['School Fees', 'Bus Fees']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value,style: TextStyle(
                                fontWeight: FontWeight.w600
                            ),),
                          );
                        }).toList(),
                        isExpanded: true,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 45,
                            child:
                            MultiSelectDialogField(
                              items:
                              value.courseDrop,
                              selectedColor: UIGuide.THEME_LIGHT,
                              listType: MultiSelectListType.CHIP,
                              title: const Text(
                                "Select Course",
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

                                courseData.clear();
                                divisionData.clear();
                                div.clear();
                                value.divisionList.clear();
                                value.divisionLen=0;
                                value.collectionlList.clear();
                                value.exportFeesList.clear();
                                value.buscollectionlList.clear();
                                value.exportBusFeesList.clear();
                                value.netAmount="";
                                value.netAmountBus="";

                                for (var i = 0; i < results.length; i++) {
                                  OfflineCourse data =
                                  results[i] as OfflineCourse;

                                  print(data.value);
                                  courseData.add(data.value);
                                  courseData.map((e) => data.value);
                                  print("${courseData.map((e) => data.value)}");
                                }
                                print("course data    $courseData");
                                course = courseData
                                    .map((id) => id)
                                    .join(',');
                                print(course);
                                await value.courseCounter(results.length);
                                await value.getDivisionList(course);
                                //value.studentViewList.clear();
                                // results.clear();

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
                                div= results;

                                divisionData.clear();
                                value.collectionlList.clear();
                                value.exportFeesList.clear();
                                value.buscollectionlList.clear();
                                value.exportBusFeesList.clear();
                                value.netAmount="";
                                value.netAmountBus="";
                                // results.clear();
                                for (var i = 0; i < results.length; i++) {
                                  OfflineFeeDiv data =
                                  div[i] as OfflineFeeDiv;

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
                                //  await value.getDivisionList(course);
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
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
                                        value.collectionlList.clear();
                                        value.exportFeesList.clear();
                                        value.buscollectionlList.clear();
                                        value.exportBusFeesList.clear();
                                        value.netAmount='';
                                        value.netAmountBus='';

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
                                        value.collectionlList.clear();
                                        value.exportFeesList.clear();
                                        value.buscollectionlList.clear();
                                        value.exportBusFeesList.clear();
                                        value.netAmount='';
                                        value.netAmountBus='';

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
                                    value.exportFeesList.clear();
                                    value.buscollectionlList.clear();
                                    value.exportBusFeesList.clear();
                                    //  value.currentPage = 2;

                                    print("daeeeeetee");
                                    print(value.fromdateselect);
                                    print(value.todateselect);


                                    if(value.fromdateselect.isAfter(value.todateselect))
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

                                      if(_selectedValue=="School Fees"){
                                        await value.getFeeCollectionReport(
                                            courseData,
                                            divisionData,
                                            value.fromdateSend,
                                            value.todateSend
                                        );

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
                                      }
                                      else{
                                        await   value.getBusFeeCollectionReport(
                                            courseData,
                                            divisionData,
                                            value.fromdateSend,
                                            value.todateSend
                                        );

                                        if (value.buscollectionlList.isEmpty) {
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
                                      }

                                    }

                                  },
                                  child: const Text("View")),
                            ),
                            kWidth,
                            value.collectionlList.isNotEmpty||value.buscollectionlList.isNotEmpty?

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
                                        "Dowloading...",
                                        style: TextStyle(
                                            color: UIGuide.light_Purple,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      )
                                  )
                              )
                                  : ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 3,
                                    foregroundColor: UIGuide.WHITE,
                                    backgroundColor: UIGuide.button1,
                                    padding: const EdgeInsets.all(0),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        side: const BorderSide(
                                          color: UIGuide.light_black,
                                        )),
                                  ),
                                  onPressed: () async {
                                    startLoading();
                                    if(_selectedValue=="School Fees") {
                                      await value.fesscollectionDownload();
                                      requestDownload(
                                          value.url.toString(),
                                          value.name.toString(),
                                          value.id.toString());
                                    }
                                    else{
                                      await value.busfesscollectionDownload();
                                      requestDownload(
                                          value.url.toString(),
                                          value.name.toString(),
                                          value.id.toString());
                                    }

                                    stopLoading();

                                  },
                                  child: const Text("Export")),
                            ):SizedBox(height: 0,width: 0,),



                          ],
                        ),

                  ),
                  kheight10,




                  Consumer<OffflineFeesProvider>(
                      builder: (context, provider, _) =>

                      _selectedValue=="School Fees"?
                      Expanded(
                        child:
                        ListView(
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
                                                Text("Name : "),
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



                      ):
                      Expanded(
                        child:
                        ListView(
                          children: [


                            Padding(
                              padding: const EdgeInsets.only(left: 8.0,right: 8),
                              child: Row(
                                children: [
                                  value.buscollectionlList.isEmpty?Text(""):
                                  Container(

                                    child: Row(
                                      children: [
                                        Text("  Last Updated Date: ${value.uploadedBusDate}",
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
                                itemCount: provider.buscollectionlList.length,
                                itemBuilder: (context,index) {
                                  //   var date= DateFormat('dd-MMM-yyyy').format(provider.collectionlList[index].billDate!);
                                  DateTime dateTime = DateTime.parse(provider.buscollectionlList[index].billDate.toString());

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
                                                        .buscollectionlList[index]
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
                                                Text("Name : "),
                                                Expanded(
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .only(top: 4.0),
                                                    child: TextWrapper(
                                                      text: provider
                                                          .buscollectionlList[index]
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
                                                .only(left: 4.0),
                                            child: Row(

                                              children: [
                                                Text("Bus Stop : "),
                                                Expanded(
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .only(top: 4.0),
                                                    child: TextWrapper(
                                                      text:
                                                      provider
                                                          .buscollectionlList[index]
                                                          .busStop==null? "":
                                                      provider
                                                          .buscollectionlList[index]
                                                          .busStop.toString(),
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
                                                        .buscollectionlList[index]
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
                                                          .buscollectionlList[index]
                                                          .division ==
                                                          null ? "" :
                                                      provider
                                                          .buscollectionlList[index]
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
                                                          .buscollectionlList[index]
                                                          .rollNo ==
                                                          null ? "" :
                                                      provider
                                                          .buscollectionlList[index]
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
                                                        .buscollectionlList[index]
                                                        .amountPaid
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
                                                          .buscollectionlList[index]
                                                          .fine == null
                                                          ? ""
                                                          :
                                                      provider
                                                          .buscollectionlList[index]
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
                                                          .buscollectionlList[index]
                                                          .discount ==
                                                          null ? "" :
                                                      provider
                                                          .buscollectionlList[index]
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
                                            value.buscollectionlList[index].isCancelled==true ?
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
                                                          .buscollectionlList[index]
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
                child:
                _selectedValue=="School Fees"?
                Text(
                  "Net Total: ${snap.netAmount==null?"":snap.netAmount.toString()}",
                  style: TextStyle(fontSize: 16),
                ) :
                Text(
                  "Net Total: ${snap.netAmountBus==null?"":snap.netAmountBus.toString()}",
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
