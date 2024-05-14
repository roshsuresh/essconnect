import 'package:auto_height_grid_view/auto_height_grid_view.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../Constants.dart';
class HomeWorkInbox extends StatefulWidget {
  const HomeWorkInbox({super.key});

  @override
  State<HomeWorkInbox> createState() => _HomeWorkInboxState();
}

class _HomeWorkInboxState extends State<HomeWorkInbox> {
  @override
  Widget build(BuildContext context) {
    var size =MediaQuery.of(context).size;
    final double itemWidth = size.width / 2;
    return Scaffold(


        body:
              ListView(
                children: [
                  AnimationLimiter(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 2.0),
                      child: AutoHeightGridView(
                     //   controller: _scrollController,
                        itemCount: 10,
                        crossAxisCount: 1,
                        mainAxisSpacing: 1,
                        //crossAxisSpacing: 1,
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.all(4),
                        shrinkWrap: true,

                        builder: (BuildContext context, int index) {

                          return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 1000),
                            child: SlideAnimation(

                              verticalOffset: 40.0,
                              child: FadeInAnimation(
                                curve: Curves.bounceOut,
                                child: Padding(
                                    padding: EdgeInsets.all(2),
                                    child: Card(
                                      elevation: 15.0,
                                      shadowColor: UIGuide.THEME_LIGHT,
                                      semanticContainer: true,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      clipBehavior: Clip.antiAlias,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[


                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [

                                              Padding(
                                                padding: const EdgeInsets.only(left:4.0),
                                                child: Text(
                                                  "English",
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.black87,
                                                      fontWeight: FontWeight.w600
                                                  ),),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(right: 8.0),
                                                child: Row(
                                                   mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    SizedBox(
                                                      width: itemWidth*0.5,
                                                      child: ElevatedButton(
                                                        style: ElevatedButton.styleFrom(
                                                            backgroundColor: UIGuide.ButtonBlue,

                                                          side: BorderSide(color: UIGuide.THEME_LIGHT)
                                                        ),
                                                        onPressed: () {
                                                          // Add your button click logic here
                                                        },
                                                        child: Row(
                                                          // mainAxisSize: MainAxisSize.min,
                                                          children: [
                                                           Text("New*",style: TextStyle(
                                                             color: UIGuide.light_Purple,
                                                           ),),
                                                            kWidth5,// Rep
                                                            // SizedBox(width: 1), // Adjust the spacing between icon and text
                                                            Container(
                                                              color: UIGuide.THEME_LIGHT,
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(2.0),
                                                                child: Center(
                                                                  child: Text('5',style: TextStyle(
                                                                      color: UIGuide.light_Purple
                                                                  ),),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),

                                                    SizedBox(
                                                      width: itemWidth*0.5,
                                                      child: ElevatedButton(
                                                        style: ElevatedButton.styleFrom(


                                                            backgroundColor: UIGuide.ButtonBlue,

                                                            side: BorderSide(color: UIGuide.THEME_LIGHT)
                                                        ),
                                                        onPressed: () {
                                                          // Add your button click logic here
                                                        },
                                                        child: Row(


                                                          children: [
                                                            const Text("Draft",style:TextStyle(
                                                                color: Colors.black87
                                                            ),),
                                                            kWidth5,// Rep
                                                            // Adjust the spacing between icon and text
                                                            Container(
                                                              color: UIGuide.THEME_LIGHT,
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(2.0),
                                                                child: Center(
                                                                  child: Text('3',style: TextStyle(
                                                                      color: UIGuide.light_Purple
                                                                  ),),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),


                                                  ],
                                                ),
                                              ),

                                            ],
                                          ),
                                          kheight5,



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

    );
  }
}
