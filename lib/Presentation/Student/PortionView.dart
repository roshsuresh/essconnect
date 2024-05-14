import 'package:auto_height_grid_view/auto_height_grid_view.dart';
import 'package:essconnect/Presentation/Student/TimeLine.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../Application/StudentProviders/CurriculamProviders.dart';
import '../../Application/StudentProviders/PortionProvider.dart';
import '../../Constants.dart';
import '../../utils/spinkit.dart';
class PortionView extends StatefulWidget {
  const PortionView({super.key});

  @override
  State<PortionView> createState() => _PortionViewState();
}

class _PortionViewState extends State<PortionView> {

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
      await p.setLoading(false);
      p.studportionList.clear();
     await p.getStudentPortionList();

    });
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
    value.loading
        ? spinkitLoader()
        :
         Column(
          children: [
            kheight10,
            AnimationLimiter(
              child: Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child: AutoHeightGridView(

                  itemCount: value.studportionList.length,
                  crossAxisCount: 2,
                  mainAxisSpacing: 1,
                  crossAxisSpacing: 0.5,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(4),
                  shrinkWrap: true,

                  builder: (BuildContext context, int index) {

                    DateTime dateTime = DateFormat('dd/MMM/yyyy').parse(value.studportionList[index].date!);
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
                                         "${value.studportionList[index].caption}",

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

                                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>StudentPortions(date: formattedDate)));
                                                      },
                                                          style: ElevatedButton.styleFrom(
                                                            backgroundColor: UIGuide.THEME_PRIMARY

                                                          ),
                                                          child: Text(
                                                        "${value.studportionList[index].newCount}",
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

                                                      child: ElevatedButton(onPressed: (){},
                                                          style: ElevatedButton.styleFrom(
                                                              backgroundColor: UIGuide.THEME_PRIMARY

                                                          ),
                                                          child: Text(
                                                            "${value.studportionList[index].viewedCount}",
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
            ),

          ],
        ),
      ),

    );
  }
}
