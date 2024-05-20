import 'package:essconnect/Application/StudentProviders/DiaryProviders.dart';
import 'package:essconnect/utils/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../Application/StudentProviders/AnecDotalProvider.dart';
import '../../Constants.dart';
import '../../utils/TextWrap(moreOption).dart';
import '../../utils/constants.dart';
class AnecDotal extends StatefulWidget {
  const AnecDotal({Key? key}) : super(key: key);

  @override
  State<AnecDotal> createState() => _AnecDotalState();
}

class _AnecDotalState extends State<AnecDotal> {



  String toDate = '--';
  String fromDate = '--';
  String course = '';
  String section = '';
  String division = '';
  String type = '';
  String attType = '';

  DateTime? _mydatetime;
  DateTime? _mydatetime2;

  String fromDate1='';
  String toDate1='';

  String maxDate='';

  DateTime? dateTime;

  @override
  void initState() {
    super.initState();
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
        var p = Provider.of<AnecDotalStudViewProvider>(context, listen: false);

        await p.clearanecdotal();
        await p.getanecDotalInitial();
        _mydatetime = DateTime.parse(p.maxDate!);
        _mydatetime2 = DateTime.parse(p.maxDate!);
      });
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    return Scaffold(
      appBar: AppBar(
          title: Row(
            children: [
              const Spacer(),
              const Text('Anecdotal'),
              const Spacer(),
              Consumer<AnecDotalStudViewProvider>(
                builder: (context, val, _) => val.loading
                    ? const SizedBox(
                  height: 0,
                  width: 0,
                )
                    : IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                              const AnecDotal()));
                    },
                    icon: const Icon(Icons.refresh)),
              )
            ],
          ),
          titleSpacing: 00.0,
          centerTitle: true,
          toolbarHeight: 60.2,
          toolbarOpacity: 0.8,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(25),
                bottomLeft: Radius.circular(25)),
          ),
          backgroundColor: UIGuide.light_Purple),
      body: Consumer<AnecDotalStudViewProvider>(
        builder: (_, value, child) {

          if(_mydatetime==null){
          print("demmmo");

          }
          else {
            fromDate = DateFormat('dd-MMM-yyyy')
                .format(_mydatetime2!);
            print(fromDate);
            fromDate1 =
                DateFormat('yyyy-MM-dd').format(_mydatetime2!);
            toDate = DateFormat('dd-MMM-yyyy')
                .format(_mydatetime!);
            print(fromDate);
            toDate1 =
                DateFormat('yyyy-MM-dd').format(_mydatetime!);
          }



         // value.maxDate!=null?
         //  _mydatetime == DateTime.parse(value.maxDate!) &&
         // _mydatetime2 == DateTime.parse(value.maxDate!):
         //     print("");


          // maxDate = DateFormat('dd-MMM-yyyy')
          //     .format(dateTime!);
          // print("ros");
          // print(maxDate);
          // maxDate==''? fromDate='':fromDate=maxDate;
          // maxDate==''? toDate='':toDate=maxDate;



          print(fromDate);
          return value.loading
              ? spinkitLoader()

              : Column(
                children: [
                  kheight10,
                  Row(
                    children: [
                      Spacer(),
                      SizedBox(
                        width: size.width * .43,
                        height: 45,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 3,
                            foregroundColor: UIGuide.light_Purple,
                            backgroundColor: UIGuide.ButtonBlue,
                            padding: const EdgeInsets.all(0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: const BorderSide(
                                  color: UIGuide.light_black,
                                )),
                          ),
                          onPressed: (() async {
                            await Provider.of<AnecDotalStudViewProvider>(context,
                                listen: false)
                                .clearanecdotal();

                            _mydatetime2 = await showDatePicker(
                              context: context,
                              initialDate: _mydatetime2 ?? DateTime.now(),
                              firstDate: DateTime(2022),
                              lastDate: DateTime(2030),
                              builder: (context, child) {
                                return Theme(
                                    data: ThemeData.light().copyWith(
                                      primaryColor: UIGuide.light_Purple,
                                      colorScheme: const ColorScheme.light(
                                        primary: UIGuide.light_Purple,
                                      ),
                                      buttonTheme: const ButtonThemeData(
                                          textTheme: ButtonTextTheme.primary),
                                    ),
                                    child: child!);
                              },
                            );
                            setState(() {
                              fromDate = DateFormat('dd-MMM-yyyy')
                                  .format(_mydatetime2!);
                              print(fromDate);
                              fromDate1 =
                                  DateFormat('yyyy-MM-dd').format(_mydatetime2!);
                            });
                            print("dattttttt");
                            print(fromDate);
                         }
                          ),
                          child: Center(
                              child: Text(
                                fromDate == '--'? "From Date": fromDate,
                                style: const TextStyle(fontSize: 16),
                              )

                          ),
                        ),
                      ),
                      Spacer(),

                      SizedBox(
                        width: size.width * .43,
                        height: 45,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 3,
                            foregroundColor: UIGuide.light_Purple,
                            backgroundColor: UIGuide.ButtonBlue,
                            padding: const EdgeInsets.all(0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: const BorderSide(
                                  color: UIGuide.light_black,
                                )),
                          ),
                          onPressed: (() async {
                              await Provider.of<AnecDotalStudViewProvider>(context,
                                  listen: false)
                                  .clearanecdotal();
                              _mydatetime = await showDatePicker(
                                context: context,
                                initialDate: _mydatetime ?? DateTime.now(),
                                firstDate: DateTime(2022),
                                lastDate: DateTime(2030),
                                builder: (context, child) {
                                  return Theme(
                                      data: ThemeData.light().copyWith(
                                        primaryColor: UIGuide.light_Purple,
                                        colorScheme: const ColorScheme.light(
                                          primary: UIGuide.light_Purple,
                                        ),
                                        buttonTheme: const ButtonThemeData(
                                            textTheme: ButtonTextTheme.primary),
                                      ),
                                      child: child!);
                                },
                              );
                              setState(() {
                                toDate = DateFormat('dd-MMM-yyyy')
                                    .format(_mydatetime!);
                                print(toDate);

                                toDate1 =
                                    DateFormat('yyyy-MM-dd').format(_mydatetime!);
                              });
                          }
                          ),
                          child: Center(
                            child: Text(

                              toDate == '--' ? "To Date" : toDate,
                              style: const TextStyle(fontSize: 16),
                            )

                          ),
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                  kheight10,

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: size.width * .42,
                        height: 40,
                        child: ElevatedButton(
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
                          onPressed: (() async {
                            await Provider.of<AnecDotalStudViewProvider>(context,
                                listen: false)
                                .clearanecdotal();

                            if(fromDate1.compareTo(toDate1) > 0)
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
                              await Provider.of<AnecDotalStudViewProvider>(
                                  context,
                                  listen: false)
                                  .getanecDotalVieList(fromDate1, toDate1);


                              if (value.anecdotallist.isEmpty) {
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
                                      'No data found..!',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                );
                              }
                            }
                          }
                          ),
                          child: const Text(
                            'View',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      kWidth,
                      Row(children: [
                        Container(
                          height: 20,
                          width: 20,
                          color:   Color.fromARGB(255, 252, 249, 208),
                        ),
                        Text(" Important")
                      ],)
                    ],
                  ),

                  Expanded(
                    child: Container(

                      //height: size.height*80,
                      child: AnimationLimiter(
                                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      itemCount: value.anecdotallist.isEmpty
                          ? 0
                          : value.anecdotallist.length,
                      itemBuilder: (BuildContext context, int index) {
                        String finalCreatedDate = "";

                        if (value.anecdotallist[index].remarksDate != null) {
                          String createddate =
                              value.anecdotallist[index].remarksDate ?? '--';
                          DateTime parsedDateTime =
                          DateTime.parse(createddate);
                          finalCreatedDate = DateFormat('dd/MMM/yyyy')
                              .format(parsedDateTime);
                        }

                        return AnimationConfiguration.staggeredList(
                          position: index,
                          delay: const Duration(milliseconds: 100),
                          child: SlideAnimation(
                            duration: const Duration(milliseconds: 2500),
                            curve: Curves.fastLinearToSlowEaseIn,
                            child: FadeInAnimation(
                              curve: Curves.fastLinearToSlowEaseIn,
                              duration: const Duration(milliseconds: 2500),
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Container(
                                      width: width,
                                      decoration: BoxDecoration(

                                        color:

                                         Color.fromARGB(
                                            255, 234, 234, 236),
                                        border: Border.all(
                                            color: UIGuide.light_Purple),
                                        borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(20),
                                          bottomLeft: Radius.circular(20),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Container(
                                          width: width,
                                          decoration:  BoxDecoration(
                                            color:value
                                                .anecdotallist[
                                            index].isImportant!
                                                ?
                                            Color.fromARGB(255, 252, 249, 208):
                                            Color.fromARGB(
                                                255, 255, 255, 255),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(5),
                                            ),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                const EdgeInsets.all(4.0),
                                                child: Row(
                                                  children: [
                                                    //  kWidth,
                                                    const Text('📒  '),
                                                    Flexible(
                                                      child: RichText(
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        strutStyle:
                                                        const StrutStyle(
                                                            fontSize:
                                                            15.0),
                                                        text: TextSpan(
                                                          style: const TextStyle(
                                                              color: UIGuide
                                                                  .light_Purple,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w500),
                                                          text: value
                                                              .anecdotallist[
                                                          index]
                                                              .remarksCategory ==
                                                              null
                                                              ? '--'
                                                              : value
                                                              .anecdotallist[
                                                          index]
                                                              .remarksCategory
                                                              .toString(),
                                                        ),
                                                      ),
                                                    ),
                                                    RichText(
                                                      overflow: TextOverflow
                                                          .ellipsis,
                                                      strutStyle:
                                                      const StrutStyle(
                                                          fontSize:
                                                          15.0),
                                                      text: TextSpan(
                                                        style: const TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                            FontWeight
                                                                .w500),
                                                        text: value
                                                            .anecdotallist[
                                                        index]
                                                            .subject ==
                                                            null
                                                            ? '--'
                                                            :
                                                        ("  (${value
                                                            .anecdotallist[
                                                        index]
                                                            .subject
                                                            .toString()})"),
                                                      ),
                                                    ),

                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets.all(4.0),
                                                child: TextWrapper(
                                                  text: value.anecdotallist[index]
                                                      .remarks ==
                                                      null
                                                      ? '--'
                                                      : value.anecdotallist[index]
                                                      .remarks
                                                      .toString(),
                                                  fSize: 14,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(4.0),
                                                child: Row(

                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [

                                                    Row(
                                                      children: [
                                                        Text("Remarks By: ",
                                                        style: TextStyle(
                                                          color: Colors.grey
                                                        ),
                                                        ),
                                                        RichText(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          strutStyle:
                                                          const StrutStyle(
                                                              fontSize:
                                                              12.0),
                                                          text: TextSpan(
                                                            style: const TextStyle(
                                                                color: Colors.black,

                                                            ),
                                                            text: value
                                                                .anecdotallist[
                                                            index]
                                                                .remarksBy ==
                                                                null
                                                                ? '--'
                                                                :

                                                          value
                                                                .anecdotallist[
                                                            index]
                                                                .remarksBy
                                                                .toString(),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                      finalCreatedDate
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.grey),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                                  ),
                                ),
                    ),
                  ),
                ],
              );
        },
      ),
    );
  }
}
