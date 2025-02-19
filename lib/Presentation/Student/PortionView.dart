import 'package:auto_height_grid_view/auto_height_grid_view.dart';

import 'package:essconnect/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../Application/StudentProviders/CurriculamProviders.dart';
import '../../Application/StudentProviders/NotificationCountProviders.dart';
import '../../Application/StudentProviders/PortionProvider.dart';
import '../../Constants.dart';
import '../../utils/spinkit.dart';
import 'PortionDetailView.dart';
class PortionView extends StatefulWidget {
  const PortionView({super.key});

  @override
  State<PortionView> createState() => _PortionViewState();
}

class _PortionViewState extends State<PortionView>with SingleTickerProviderStateMixin {
  String status='';

  late AnimationController _controller;
  String viewprev='';

  Duration? difference;


  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var p = Provider.of<StudentPortionProvider>(context, listen: false);
      await Provider.of<
          Curriculamprovider>(
          context,
          listen: false)
          .getCuriculamAceesstoken();

      p.studportionList.clear();
      p.studportionListpre.clear();
      await p.setLoading(false);


     await p.getStudentPortionList();
     await p.updatePortionCount();
      await Provider.of<StudNotificationCountProviders>(context, listen: false)
          .getnotificationCount();


    });


    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    )..repeat(reverse: true);
  }

  void _clearDate() {
    var c = Provider.of<StudentPortionProvider>(context, listen: false);
    setState(() {
      c.fromdateselect = null;
      c.todateselect=null;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size =MediaQuery.of(context).size;
    final double itemWidth = size.width / 2;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inbox'),
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

      body:
    Consumer<StudentPortionProvider>(
    builder: (context, value, _) =>
     ListView(
        children: [
          Consumer<StudentPortionProvider>(
          builder: (context, value, _) =>
          value.loading
              ? Center(child: spinkitLoader())
              :value.studportionList.isNotEmpty?
               Column(
                children: [
                  kheight10,
                  AnimationLimiter(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 2.0),
                      child: AutoHeightGridView(

                        itemCount: 1,
                        crossAxisCount: 2,
                        mainAxisSpacing: 1,
                        crossAxisSpacing: 0.5,
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.all(4),
                        shrinkWrap: true,

                        builder: (BuildContext context, int index) {

                          DateTime dateTime = DateFormat('dd/MMM/yyyy').parse(value.studportionList[0].date!);
                          print("date time  $dateTime");
                          String formattedDate = DateFormat("yyyy-MM-dd'T'00:00:00.000'Z'").format(dateTime);
                          print("date time  after $formattedDate");
                          return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 1000),
                            child: SlideAnimation(
                              verticalOffset: 50.0,
                              child: FadeInAnimation(
                                curve: Curves.bounceOut,
                                child: Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Card(
                                      elevation: 15.0,
                                      shadowColor: UIGuide.THEME_LIGHT,
                                      semanticContainer: true,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
                                      ),
                                      clipBehavior: Clip.antiAlias,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          kheight10,



                                          Padding(
                                            padding: const EdgeInsets.only(left: 4.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                               "${value.studportionList[0].caption=="Todays"?
                                               "Today's": value.studportionList[0].caption
                                               }",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: UIGuide.light_Purple,
                                                      fontWeight: FontWeight.w600,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            ),
                                          ),
                                          kheight10,

                                          Table(
                                            border: TableBorder.all(color: UIGuide.THEME_LIGHT),
                                            children: [
                                              TableRow(
                                                decoration: BoxDecoration(
                                                  color: UIGuide.ButtonBlue, // Set background color for the row
                                                ),
                                                children: [
                                                  TableCell(
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(left: 4),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Text(' New'),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            width: 70,
                                                            height: 40,

                                                            child: ElevatedButton(onPressed: (){
                                                              status= "new";
                                                              value.studportionList[0].newCount==0?"":


                                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>StudentPortions(date: formattedDate,status: status,)));
                                                            },
                                                                style: ElevatedButton.styleFrom(
                                                                  backgroundColor: UIGuide.THEME_PRIMARY

                                                                ),
                                                                child:
                                                                value.studportionList[0].newCount!=0?
                                                              AnimatedBuilder(
                                                              animation: _controller,
                                                              builder: (context, child) {
                                                                return Opacity(
                                                                  opacity: _controller
                                                                      .value,
                                                                  child: Text(
                                                                    '${value.studportionList[0].newCount}',
                                                                    style: TextStyle(

                                                                        fontWeight: FontWeight
                                                                            .bold),
                                                                  ),
                                                                );
                                                              }
                                                              ):
                                                                Text(

                                                              "${value.studportionList[0].newCount}",
                                                                  textAlign:TextAlign.center,style: TextStyle(color: Colors.white),
                                                            )

                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),

                                                ],
                                              ),
                                              TableRow(
                                                decoration: BoxDecoration(
                                                  color: UIGuide.ButtonBlue, // Set background color for the row
                                                ),
                                                children: [
                                                  TableCell(
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(left: 4),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Text(' Viewed'),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            width: 70,
                                                            height: 40,

                                                            child: ElevatedButton(onPressed: (){
                                                              status= "viewed";
                                                              value.studportionList[0].viewedCount==0?"":


                                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>StudentPortions(date: formattedDate,status: status,viewPrev: viewprev,)));

                                                            },
                                                                style: ElevatedButton.styleFrom(
                                                                    backgroundColor: UIGuide.THEME_PRIMARY

                                                                ),
                                                                child: Text(
                                                                  "${value.studportionList[0].viewedCount}",
                                                                  textAlign:TextAlign.center,style: TextStyle(color: Colors.white),
                                                                )),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),

                                                ],
                                              ),

                                              ]),






                                        ],
                                      ),
                                    )
                                ),),
                            ),
                          );


                        },
                      ),
                    ),
                  ),  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:viewprev=="previous"?
                              UIGuide.light_Purple:
                              UIGuide.THEME_PRIMARY
                          ),
                          onPressed: ()async {
                            viewprev="previous";
                        value.studportionListpre.clear();
                        await value.getStudentPortionListPrevious(viewprev);

                            if(value.studportionListpre.isEmpty){
                              Fluttertoast.showToast(
                                msg:"No Data Found..",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black54,
                                textColor: Colors.white,
                                fontSize: 14.0,

                              );
                            }

                      }, child: Text("<< Previous")),
                      kWidth5,
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:viewprev=="upcoming"?
                              UIGuide.light_Purple:
                              UIGuide.THEME_PRIMARY
                          ),
                          onPressed: ()async{
                            viewprev="upcoming";


                        value.studportionListpre.clear();


                        await value.getStudentPortionListPrevious(viewprev);
                            if(value.studportionListpre.isEmpty){
                              Fluttertoast.showToast(
                                msg:"No Data Found..",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black54,
                                textColor: Colors.white,
                                fontSize: 14.0,

                              );
                            }
                      }, child: Text("Upcoming >>")),
                      kWidth5,
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:viewprev=="more"?
                              UIGuide.light_Purple:
                              UIGuide.THEME_PRIMARY
                          ),
                          onPressed: ()async{
                            setState(() {
                              viewprev="more";
                              print("ststussssssss $viewprev");
                              value.studportionListByDate.clear();
                            value.clearDate();
                            print("from date select  ${value.fromdateselect}");
                              print("to date select  ${value.todateselect}");
                              value.fromdateDisplay="";
                              value.todateDisplay="";
                              value.fromdateSend="";
                              value.todateSend="";
                            });

                           // await value.getStudentPortionListByDate();

                          }, child: Text("More >>")
                      )
                    ],
                  )



                ],
              ):
            SizedBox(height: 0,width: 0,),
            ),

          viewprev!="more"?

                    Consumer<StudentPortionProvider>(
                 builder: (context, value, _) =>

                 value.studportionListpre.isNotEmpty?

           AnimationLimiter(
              child: Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child: AutoHeightGridView(

                  itemCount: value.studportionListpre.length,
                  crossAxisCount: 2,
                  mainAxisSpacing: 1,
                  crossAxisSpacing: 0.5,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(4),
                  shrinkWrap: true,

                  builder: (BuildContext context, int index) {

                    DateTime dateTime = DateFormat('dd/MMM/yyyy').parse(value.studportionListpre[index].date!);
                    print("date time  $dateTime");
                    String formattedDate = DateFormat("yyyy-MM-dd'T'00:00:00.000'Z'").format(dateTime);
                    print("date time  after $formattedDate");
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 1000),
                      child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(
                          curve: Curves.bounceOut,
                          child: Padding(
                              padding: EdgeInsets.all(5),
                              child: Card(
                                elevation: 15.0,
                                shadowColor: UIGuide.THEME_LIGHT,
                                semanticContainer: true,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
                                ),
                                clipBehavior: Clip.antiAlias,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    kheight10,

                                    Padding(
                                      padding: const EdgeInsets.only(left: 4.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "${value.studportionListpre[index].caption}",

                                            style: TextStyle(
                                              fontSize: 15,
                                              color: UIGuide.light_Purple,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                    kheight10,

                                    Table(
                                        border: TableBorder.all(color: UIGuide.THEME_LIGHT),
                                        children: [
                                          TableRow(
                                            decoration: BoxDecoration(
                                              color: UIGuide.ButtonBlue, // Set background color for the row
                                            ),
                                            children: [
                                              TableCell(
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 4),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(' New'),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        width: 70,
                                                        height: 40,

                                                        child: ElevatedButton(onPressed: (){
                                                          status= "new";
                                                          value.studportionListpre[index].newCount==0?"":


                                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>StudentPortions(date: formattedDate,status: status,viewPrev: viewprev,)));
                                                        },
                                                            style: ElevatedButton.styleFrom(
                                                                backgroundColor: UIGuide.THEME_PRIMARY

                                                            ),
                                                            child:
                                                            value.studportionListpre[index].newCount!=0?
                                                            AnimatedBuilder(
                                                                animation: _controller,
                                                                builder: (context, child) {
                                                                  return Opacity(
                                                                    opacity: _controller
                                                                        .value,
                                                                    child: Text(
                                                                      '${value.studportionListpre[index].newCount}',
                                                                      style: TextStyle(

                                                                          fontWeight: FontWeight
                                                                              .bold),
                                                                    ),
                                                                  );
                                                                }
                                                            ):

                                                            Text(
                                                              "${value.studportionListpre[index].newCount}",
                                                              textAlign:TextAlign.center,style: TextStyle(color: Colors.white),
                                                            )),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),

                                            ],
                                          ),
                                          TableRow(
                                            decoration: BoxDecoration(
                                              color: UIGuide.ButtonBlue, // Set background color for the row
                                            ),
                                            children: [
                                              TableCell(
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 4),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(' Viewed'),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        width: 70,
                                                        height: 40,

                                                        child: ElevatedButton(onPressed: (){
                                                          status= "viewed";
                                                          value.studportionListpre[index].viewedCount==0?"":


                                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>StudentPortions(date: formattedDate,status: status,viewPrev: viewprev,)));

                                                        },
                                                            style: ElevatedButton.styleFrom(
                                                                backgroundColor: UIGuide.THEME_PRIMARY

                                                            ),
                                                            child: Text(
                                                              "${value.studportionListpre[index].viewedCount}",
                                                              textAlign:TextAlign.center,style: TextStyle(color: Colors.white),
                                                            )),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),

                                            ],
                                          ),

                                        ]),






                                  ],
                                ),
                              )
                          ),),
                      ),
                    );


                  },
                ),
              ),
            ):
                     SizedBox(height: 0,width: 0,)
          ):
                  Column(
                    children: [
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

                      "From Date":value.fromdateDisplay),
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

                      "To Date":value.todateDisplay),
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

                      SizedBox(
                        width: 100,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 3,
                              foregroundColor: UIGuide.BLACK,
                              backgroundColor:
                              UIGuide.light_Purple,
                              padding: const EdgeInsets.all(0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: const BorderSide(
                                    color: UIGuide.light_black,
                                  )),
                            ),
                            onPressed: () async {
                              if (value.fromdateselect != null &&
                                  value.todateselect != null) {
                                difference = value.fromdateselect!.difference(
                                    value.todateselect!).abs();
                              }


                              if (value.fromdateDisplay == "" ||
                                  value.todateDisplay == "") {
                                Fluttertoast.showToast(
                                  msg: "Select Date..",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.black54,
                                  textColor: Colors.white,
                                  fontSize: 14.0,

                                );
                              }
                              else if (value.fromdateselect!.isAfter(value
                                  .todateselect!)) {
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
                              else if (difference! > Duration(days: 30)) {
                                Fluttertoast.showToast(
                                  msg: "Time period should not exceed 30 days",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.black54,
                                  textColor: Colors.white,
                                  fontSize: 14.0,

                                );
                              }

                              else {
                                value.studportionListByDate.clear();
                                await value.getStudentPortionListByDate();


                                if (value.studportionListByDate.isEmpty) {
                                  Fluttertoast.showToast(
                                    msg: "No Data Found..",
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
                            child:Text("View",style: TextStyle(
                              color: Colors.white
                            ),)
                        ),
                      ),


                      value.studportionListByDate.isNotEmpty?

                      AnimationLimiter(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 2.0),
                          child: AutoHeightGridView(

                            itemCount: value.studportionListByDate.length,
                            crossAxisCount: 2,
                            mainAxisSpacing: 1,
                            crossAxisSpacing: 0.5,
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.all(4),
                            shrinkWrap: true,

                            builder: (BuildContext context, int index) {

                              DateTime dateTime = DateFormat('dd/MMM/yyyy').parse(value.studportionListByDate[index].date!);
                              print("date time  $dateTime");
                              String formattedDate = DateFormat("yyyy-MM-dd'T'00:00:00.000'Z'").format(dateTime);
                              print("date time  after $formattedDate");
                              return AnimationConfiguration.staggeredList(
                                position: index,
                                duration: const Duration(milliseconds: 1000),
                                child: SlideAnimation(
                                  verticalOffset: 50.0,
                                  child: FadeInAnimation(
                                    curve: Curves.bounceOut,
                                    child: Padding(
                                        padding: EdgeInsets.all(5),
                                        child: Card(
                                          elevation: 15.0,
                                          shadowColor: UIGuide.THEME_LIGHT,
                                          semanticContainer: true,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
                                          ),
                                          clipBehavior: Clip.antiAlias,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              kheight10,

                                              Padding(
                                                padding: const EdgeInsets.only(left: 4.0),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "${value.studportionListByDate[index].caption}",

                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        color: UIGuide.light_Purple,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              kheight10,

                                              Table(
                                                  border: TableBorder.all(color: UIGuide.THEME_LIGHT),
                                                  children: [
                                                    TableRow(
                                                      decoration: BoxDecoration(
                                                        color: UIGuide.ButtonBlue, // Set background color for the row
                                                      ),
                                                      children: [
                                                        TableCell(
                                                          child: Padding(
                                                            padding: const EdgeInsets.only(left: 4),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Text(' New'),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  width: 70,
                                                                  height: 40,

                                                                  child: ElevatedButton(onPressed: (){
                                                                    status= "new";
                                                                    value.studportionListByDate[index].newCount==0?"":


                                                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>StudentPortions(date: formattedDate,status: status,viewPrev: viewprev,)));
                                                                  },
                                                                      style: ElevatedButton.styleFrom(
                                                                          backgroundColor: UIGuide.THEME_PRIMARY

                                                                      ),
                                                                      child:
                                                                      value.studportionListByDate[index].newCount!=0?
                                                                      AnimatedBuilder(
                                                                          animation: _controller,
                                                                          builder: (context, child) {
                                                                            return Opacity(
                                                                              opacity: _controller
                                                                                  .value,
                                                                              child: Text(
                                                                                '${value.studportionListByDate[index].newCount}',
                                                                                style: TextStyle(

                                                                                    fontWeight: FontWeight
                                                                                        .bold),
                                                                              ),
                                                                            );
                                                                          }
                                                                      ):

                                                                      Text(
                                                                        "${value.studportionListByDate[index].newCount}",
                                                                        textAlign:TextAlign.center,style: TextStyle(color: Colors.white),
                                                                      )),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),

                                                      ],
                                                    ),
                                                    TableRow(
                                                      decoration: BoxDecoration(
                                                        color: UIGuide.ButtonBlue, // Set background color for the row
                                                      ),
                                                      children: [
                                                        TableCell(
                                                          child: Padding(
                                                            padding: const EdgeInsets.only(left: 4),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Text(' Viewed'),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  width: 70,
                                                                  height: 40,

                                                                  child: ElevatedButton(onPressed: (){
                                                                    status= "viewed";
                                                                    value.studportionListByDate[index].viewedCount==0?"":


                                                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>StudentPortions(date: formattedDate,status: status,viewPrev: viewprev,)));

                                                                  },
                                                                      style: ElevatedButton.styleFrom(
                                                                          backgroundColor: UIGuide.THEME_PRIMARY

                                                                      ),
                                                                      child: Text(
                                                                        "${value.studportionListByDate[index].viewedCount}",
                                                                        textAlign:TextAlign.center,style: TextStyle(color: Colors.white),
                                                                      )),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),

                                                      ],
                                                    ),

                                                  ]),

                                            ],
                                          ),
                                        )
                                    ),),
                                ),
                              );


                            },
                          ),
                        ),
                      ):
                      SizedBox(height: 0,width: 0,)



                    ],
                  ),


        ],
      ),
    ),

    );
  }
}
