import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import 'package:provider/provider.dart';

import '../../Application/StudentProviders/MarkSheetProvider.dart';
import '../../Constants.dart';
import '../../utils/constants.dart';
import '../../utils/spinkit.dart';

class MarkSheetView extends StatefulWidget {
  const MarkSheetView({Key? key}) : super(key: key);

  @override
  State<MarkSheetView> createState() => _MarkSheetViewState();
}

class _MarkSheetViewState extends State<MarkSheetView> {


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var p = await Provider.of<MarksheetProvider>(context, listen: false);
      p.marksheetList.clear();
      p.marksheetValues.clear();
      p.getMarkLit();

    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mark Sheet'),
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<MarksheetProvider>(
          builder: (context, value, child) => value.loading
              ? spinkitLoader()

              : value.marksheetList.isEmpty || value.marksheetList == null
              ? LottieBuilder.network(
              'https://assets2.lottiefiles.com/private_files/lf30_lkquf6qz.json')
              : Column(
            children: [
              kheight20,
              Table(
                border: TableBorder.all(
                    color:
                    const Color.fromARGB(255, 255, 255, 255)),
                columnWidths: const {
                  0: FlexColumnWidth(3),
                  1: FlexColumnWidth(5),
                  2: FlexColumnWidth(2),
                },
                children: const [
                  TableRow(
                    decoration: BoxDecoration(
                      color: UIGuide.light_black,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                    ),
                    children: [
                      SizedBox(
                        height: 30,
                        child: Center(
                          child: Text(
                            'Date',
                            style: TextStyle(
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                        child: Center(
                          child: Text(
                            'Exam Name',
                            style: TextStyle(
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                        child: Center(
                            child: Text(
                              'View',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600),
                            )),
                      ),
                    ],
                  ),
                ],
              ),
              Expanded(
                child: Consumer<MarksheetProvider>(
                  builder: (context, provider, child) {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: value.marksheetList.isEmpty
                            ? 0
                            : value.marksheetList.length,
                        itemBuilder: ((context, index) {
                          //created date
                          String Corect_tym = "";

                          if (value.marksheetList[index]
                              .uploadedDate !=
                              null) {
                            String createddate = value
                                .marksheetList[index]
                                .uploadedDate ??
                                '--';
                            DateTime parsedDateTime =
                            DateTime.parse(createddate);
                            Corect_tym = DateFormat('dd-MMM-yyyy')
                                .format(parsedDateTime);
                          }
                          print('dob $Corect_tym');
                          String reAttach = value
                              .marksheetList[index].marksheetId ??
                              '--';

                          print(reAttach);
                          return InkWell(
                            onTap: () async {
                               value.marksheetValues.clear();
                             await  Provider.of<MarksheetProvider>(context, listen: false).
                              markSheetView(reAttach);
                               String totalMarkValue  = provider.marksheetList[index].totalMark.toString();
                               String totalpercentageValue  = provider.marksheetList[index].totalPercentage.toString();
                               String totalconvertedmark =(totalMarkValue.endsWith('.0')) ? totalMarkValue.split('.').first : totalMarkValue;
                               String totalpercentage = (totalpercentageValue.endsWith('.0')) ? totalpercentageValue.split('.').first : totalpercentageValue;
                              showModalBottomSheet(
                                
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.white,
                                builder: (context) {
                                  return Wrap(
                                    children: [
                                      LimitedBox(
                                        maxHeight: size.height*0.75,
                                        child: Column(
                                          children: [
                                        
                                            ListTile(
                                              horizontalTitleGap: 1,
                                              title: const Text("Mark Sheet"),
                                              titleTextStyle: const TextStyle(
                                                fontSize: 16,
                                                color: UIGuide.light_Purple,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              leadingAndTrailingTextStyle:
                                              const TextStyle(),
                                              trailing: TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text(
                                                    " ❌ ",
                                                    style: TextStyle(
                                                        color: Colors.black87,
                                                        fontSize: 10,
                                                        fontWeight: FontWeight.w600),
                                                  )),
                                            ),
                                        
                                            Padding(
                                              padding: const EdgeInsets.only(left: 4.0,right: 8),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  ElevatedButton(
                                                      onPressed: () {},
                                                      style: ElevatedButton.styleFrom(
                                                        backgroundColor: UIGuide.THEME_LIGHT,
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(15.0),
                                                        ),
                                                      ),
                                                      child:  SizedBox(
                                                        width: size.width*0.50,
                                                        child: Text(

                                                          provider.marksheetList[index].examName.toString(),
                                                          style: TextStyle(color: UIGuide.light_Purple),
                                                          maxLines: 3,
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ),
                                                  ),
                                                  ElevatedButton(
                                                      onPressed: () {},
                                                      style: ElevatedButton.styleFrom(
                                                        backgroundColor: UIGuide.THEME_LIGHT,
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(15.0),
                                                        ),
                                                      ),
                                                      child:  Text(
                                                        "Rank: ${provider.marksheetList[index].examRank}",
                                                        style: TextStyle(color: UIGuide.light_Purple),
                                                      )),
                                                ],
                                              ),
                                            ),
                                             const Divider(
                                              height: 5,
                                              color: Colors.grey,
                                              thickness: 1,
                                            ),
                                        
                                        
                                                                          Expanded(
                                                                            child: ListView(
                                                                            children: [
                                                                               Padding(
                                                                                                                    padding: const EdgeInsets.all(4.0),
                                                                                                                    child: ListView.builder(
                                                                                                                        shrinkWrap: true,
                                                                                                                        physics: NeverScrollableScrollPhysics(),
                                                                                                                        itemCount: provider.marksheetValues.length,
                                                                                                                        itemBuilder: ((context, index) {
                                                                                                                           String scoreValue = provider.marksheetValues[index].score.toString();
                                                                                                                           String maxScoreValue  = provider.marksheetValues[index].maxScore.toString();
                                                                                                                           String convertValue  = provider.marksheetValues[index].convertedScore.toString();
                                                                                                                           String convertMaxValue  = provider.marksheetValues[index].convertedMaxScore.toString();
                                                                                                                           String percentageValue  = provider.marksheetValues[index].percentage.toString();
                                                                                                                    
                                                                                                                           String mark =  (scoreValue.endsWith('.0')) ? scoreValue.split('.').first : scoreValue;
                                                                                                                           String maxMark = (maxScoreValue.endsWith('.0')) ? maxScoreValue.split('.').first : maxScoreValue;
                                                                                                                           String convert = (convertValue.endsWith('.0')) ? convertValue.split('.').first : convertValue;
                                                                                                                           String convertMax = (convertMaxValue.endsWith('.0')) ? convertMaxValue.split('.').first : convertMaxValue;
                                                                                                                           String percentage = (percentageValue.endsWith('.0')) ? percentageValue.split('.').first : percentageValue;
                                                                                                                    
                                                                                                                    
                                                                                                                          return Padding(
                                                                                                                            padding: const EdgeInsets.all(4.0),
                                                                                                                            child: Container(
                                                                                                                              height: 80,
                                                                                                                              width: size.width,
                                                                                                                              decoration: BoxDecoration(
                                                                                                                                  border: Border.all(
                                                                                                                                    color: UIGuide.light_Purple,
                                                                                                                                    width: 1,
                                                                                                                                  ),
                                                                                                                                  borderRadius:
                                                                                                                                  BorderRadius.circular(10)),
                                                                                                                              child: Column(
                                                                                                                                children: [
                                                                                                                                  Padding(
                                                                                                                                    padding:
                                                                                                                                     EdgeInsets.all(4.0),
                                                                                                                                    child: Row(

                                                                                                                                      children: [
                                                                                                                                        Container(
                                                                                                                                             decoration: BoxDecoration(
                                                                                                                                               color: Colors.black12,
                                                                                                                                               borderRadius: BorderRadius.only(bottomLeft: Radius.circular(3),topRight: Radius.circular(3)),
                                                                                                                                             ),

                                                                                                                                         child: Text((index+1).toString()),

                                                                                                                                        ),
                                                                                                                                        kWidth,

                                                                                                                                        provider.marksheetValues[index]
                                                                                                                                            .subject ==
                                                                                                                                            null
                                                                                                                                            ? const Text(
                                                                                                                                          '',
                                                                                                                                          style: TextStyle(
                                                                                                                                              color: UIGuide
                                                                                                                                                  .light_Purple),
                                                                                                                                        )
                                                                                                                                            : Text(
                                                                                                                                          provider
                                                                                                                                              .marksheetValues[
                                                                                                                                          index]
                                                                                                                                              .subject
                                                                                                                                              .toString(),
                                                                                                                                          style: const TextStyle(
                                                                                                                                              color: UIGuide
                                                                                                                                                  .light_Purple,
                                                                                                                                          fontSize: 14),
                                                                                                                                        ),
                                                                                                                                        const Spacer(),
                                                                                                                                      ],
                                                                                                                                    ),
                                                                                                                                  ),
                                                                                                                                  Padding(
                                                                                                                                    padding:
                                                                                                                                     EdgeInsets.only(top: 4.0,left:4,bottom:4,right: 30),
                                                                                                                                    child: Row(
                                                                                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                                                      children: [
                                                                                                                    
                                                                                                                                      provider.marksheetValues[index].attendance=='A'?
                                                                                                                                         Row(
                                                                                                                                           children: [
                                                                                                                                             Text("Mark:"),
                                                                                                                                             Text(" A ",style: TextStyle(
                                                                                                                                                 color: Colors.red,
                                                                                                                                               fontWeight: FontWeight.bold
                                                                                                                                             ),)
                                                                                                                                           ],
                                                                                                                                         ):
                                                                                                                                      Row(
                                                                                                                    
                                                                                                                                        children: [
                                                                                                                                          Text("Mark: "),
                                                                                                                                          Text(provider.marksheetValues[index].score==null?
                                                                                                                                          "":
                                                                                                                                          "$mark/$maxMark",
                                                                                                                                            style: TextStyle(color: UIGuide.light_Purple),
                                                                                                                                          )
                                                                                                                                        ],
                                                                                                                                      ),
                                                                                                                                        provider.marksheetValues[index].attendance=='A' && provider.marksheetValues[index].convertedMaxScore!=null ?
                                                                                                                                        Row(
                                                                                                                                          children: [
                                                                                                                                            Text("Converted Mark:"),
                                                                                                                                            Text(" A ",style: TextStyle(
                                                                                                                                                color: Colors.red,
                                                                                                                                                fontWeight: FontWeight.bold
                                                                                                                                            ),)
                                                                                                                                          ],
                                                                                                                                        ):
                                                                                                                                             provider.marksheetValues[index].convertedMaxScore==null ?Text(""):
                                                                                                                                             Row(
                                                                                                                                               children: [
                                                                                                                                                 Text("Converted Mark: "),
                                                                                                                                                 Text(provider.marksheetValues[index].convertedScore==null?
                                                                                                                                                 "":
                                                                                                                                                 "$convert/$convertMax",
                                                                                                                                                   style: TextStyle(color: UIGuide.light_Purple),
                                                                                                                                                 )
                                                                                                                                               ],
                                                                                                                                             ),
                                                                                                                    
                                                                                                                                      ],
                                                                                                                                    ),
                                                                                                                                  ),
                                                                                                                                  Padding(
                                                                                                                                    padding:
                                                                                                                                     EdgeInsets.only(top: 4.0,left:4,bottom:4,right: 30),
                                                                                                                                    child: Row(
                                                                                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                                                      children: [
                                                                                                                                        provider.marksheetValues[index].attendance=='A'?
                                                                                                                                        Row(
                                                                                                                                          children: [
                                                                                                                                            Text("Percentage: "),
                                                                                                                                            Text(" A ",style: TextStyle(
                                                                                                                                                color: Colors.red,
                                                                                                                                                fontWeight: FontWeight.bold
                                                                                                                                            ),)
                                                                                                                                          ],
                                                                                                                                        ):
                                                                                                                                        Row(
                                                                                                                                          children: [
                                                                                                                                            Text("Percentage: "),
                                                                                                                                            Text(provider.marksheetValues[index].percentage==null?
                                                                                                                                            "":
                                                                                                                                            "$percentage%",
                                                                                                                                              style: TextStyle(color: UIGuide.light_Purple),
                                                                                                                                            )
                                                                                                                                          ],
                                                                                                                                        ),
                                                                                                                                        provider.marksheetValues[index].attendance=='A'?
                                                                                                                                        Row(
                                                                                                                                          children: [
                                                                                                                                            Text("Grade:"),
                                                                                                                                            Text(" A ",style: TextStyle(
                                                                                                                                                color: Colors.red,
                                                                                                                                                fontWeight: FontWeight.bold
                                                                                                                                            ),)
                                                                                                                                          ],
                                                                                                                                        ):
                                                                                                                                        Row(
                                                                                                                    
                                                                                                                                          children: [
                                                                                                                                            Text("Grade: "),
                                                                                                                                            Text(provider.marksheetValues[index].grade==null?
                                                                                                                                            "":
                                                                                                                                            provider.marksheetValues[index].grade.toString(),
                                                                                                                                              style: TextStyle(color: UIGuide.light_Purple),
                                                                                                                                            )
                                                                                                                                          ],
                                                                                                                                        ),
                                                                                                                                        provider.marksheetValues[index].attendance=='A'?
                                                                                                                                        Row(
                                                                                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                                                                                          children: [
                                                                                                                                            Text("Rank:"),
                                                                                                                                            Text(" A ",style: TextStyle(
                                                                                                                                                color: Colors.red,
                                                                                                                                                fontWeight: FontWeight.bold
                                                                                                                                            ),)
                                                                                                                                          ],
                                                                                                                                        ):
                                                                                                                                       Row(
                                                                                                                                         children: [
                                                                                                                                           Text("Rank: "),
                                                                                                                                          Text(provider.marksheetValues[index].subjectRank==null?
                                                                                                                                          "":
                                                                                                                                          provider.marksheetValues[index].subjectRank.toString(),
                                                                                                                                            style: TextStyle(color: UIGuide.light_Purple),
                                                                                                                                          )
                                                                                                                                         ],
                                                                                                                                       )
                                                                                                                                      ],
                                                                                                                                    ),
                                                                                                                                  ),
                                                                                                                                ],
                                                                                                                              ),
                                                                                                                            ),
                                                                                                                          );
                                                                                                                        })),
                                                                              ),
                                                                                                                      ],
                                                                            ),
                                                                          ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: UIGuide.THEME_LIGHT,
                                                  border: Border.all(width: 1,color: UIGuide.light_Purple ),
                                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                                ),
                                                width: size.width,
                                                height: 60,
                                                child: Column(
                                                  children: [
                                                    kheight10,
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Text(("Total"),style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight: FontWeight.bold
                                                        ),)
                                                      ],
                                                    ),
                                                    kheight10,

                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 2,right: 2),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                        children: [
                                                          provider.marksheetList[index].totalMark==null?
                                                              SizedBox(
                                                                height: 0,
                                                                  width: 0,
                                                              ):
                                                          Row(
                                                            children: [
                                                                kWidth,
                                                              Text("Converted Mark: "),
                                                              Text(provider.marksheetList[index].totalMark==null?
                                                              "":
                                                              totalconvertedmark,
                                                                style: TextStyle(color: UIGuide.light_Purple,
                                                                fontWeight: FontWeight.bold
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          Spacer(),
                                                          Row(
                                                            children: [
                                                              Text("Percentage: "),
                                                              Text(provider.marksheetList[index].totalPercentage==null?
                                                              "":
                                                              totalpercentage,
                                                                style: TextStyle(color: UIGuide.light_Purple,
                                                                    fontWeight: FontWeight.bold
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          Spacer(),
                                                          Row(
                                                            children: [
                                                              Text("Grade: "),
                                                              Text(provider.marksheetList[index].totalGrade==null?
                                                              "":
                                                              provider.marksheetList[index].totalGrade.toString(),
                                                                style: TextStyle(color: UIGuide.light_Purple,
                                                                    fontWeight: FontWeight.bold
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          Spacer(),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                                                            ],
                                                                          ),
                                      )
                                  ]
                                  );
                                },
                              );

                            },
                            child: Table(
                              border: TableBorder.all(
                                  color: const Color.fromARGB(
                                      255, 255, 255, 255)),
                              columnWidths: const {
                                0: FlexColumnWidth(3),
                                1: FlexColumnWidth(5),
                                2: FlexColumnWidth(2),
                              },
                              children: [
                                TableRow(
                                    decoration:
                                    const BoxDecoration(
                                        color: Color.fromARGB(
                                            255,
                                            246,
                                            247,
                                            248)),
                                    children: [
                                      Padding(
                                        padding:
                                        const EdgeInsets.all(
                                            8.0),
                                        child: Text(
                                          Corect_tym == null
                                              ? '---'
                                              : Corect_tym
                                              .toString(),
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight:
                                              FontWeight.w400,
                                              color: UIGuide
                                                  .light_Purple),
                                          textAlign:
                                          TextAlign.center,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                        const EdgeInsets.all(
                                            8.0),
                                        child: Text(
                                          value
                                              .marksheetList[
                                          index]
                                              .examName ==
                                              null
                                              ? '----'
                                              : value
                                              .marksheetList[
                                          index]
                                              .examName
                                              .toString(),
                                          style: const TextStyle(
                                              color: UIGuide
                                                  .light_Purple,
                                              fontSize: 14,
                                              fontWeight:
                                              FontWeight
                                                  .w400),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                        const EdgeInsets.all(
                                            8.0),
                                        child: SizedBox(
                                          height: 25,
                                          width: 25,
                                          child: LottieBuilder
                                              .network(
                                              "https://assets2.lottiefiles.com/temp/lf20_D0nz3r.json") ==
                                              null
                                              ? const Icon(Icons
                                              .remove_red_eye_outlined)
                                              : LottieBuilder.network(
                                              "https://assets2.lottiefiles.com/temp/lf20_D0nz3r.json"),
                                        ),
                                      ),
                                    ]),
                              ],
                            ),
                          );
                        }));
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
class NoAttachmentScreen extends StatelessWidget {
  const NoAttachmentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Invalid attachment'),
      ),
    );
  }
}