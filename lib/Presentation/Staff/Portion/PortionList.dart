import 'package:auto_height_grid_view/auto_height_grid_view.dart';
import 'package:essconnect/utils/spinkit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Application/Staff_Providers/PortionProvider.dart';
import '../../../Application/StudentProviders/CurriculamProviders.dart';
import '../../../Constants.dart';
import '../../../utils/TextWrap(moreOption).dart';
import '../../../utils/constants.dart';
import 'PortionEdit.dart';


class PortionList extends StatefulWidget {
  const PortionList({Key? key}) : super(key: key);

  @override
  State<PortionList> createState() => _PortionListState();
}

class _PortionListState extends State<PortionList> {
  //final _textFieldController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  String? phn;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var p = Provider.of<PortionProvider>(context, listen: false);
      _scrollController.addListener(_scrollListener);
      // await Provider.of<
      //     Curriculamprovider>(
      //     context,
      //     listen: false)
      //     .getCuriculamAceesstoken();
      await p.setLoading(false);
      await p.setLoadingPage(false);
      await p.clearInitial();
      await p.getPortionList();
      p.currentPage=2;


    });
  }
  void _scrollListener() async {
    final provider =
    Provider.of<PortionProvider>(context, listen: false);
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (provider.hasMoreListData()) {
        print("object");
        provider.loading
            ? const Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: UIGuide.light_Purple,
                ),
              ),
              kWidth,
              Text(
                "Please Wait...",
                style: TextStyle(
                    color: UIGuide.light_Purple,
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
              )
            ],
          ),
        ):


        await provider.getPortionListBypagination();

      }
    }
  }

  _makingPhoneCall(String phn) async {
    var url = Uri.parse("tel:$phn");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    var size =MediaQuery.of(context).size;
   // final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    return Scaffold(


        body: Consumer<PortionProvider>(
          builder: (context, provider, child)=>

          provider.loading?
              Center(child: spinkitLoader()):
              provider.portionList.isEmpty?
                  Center(child: Text("No Data Found",style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600
                  ),)):
              Column(

                children: [
                  Expanded(
                    child: AnimationLimiter(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: AutoHeightGridView(
                          controller: _scrollController,
                          itemCount: provider.portionList.length,
                          crossAxisCount: 2,
                          mainAxisSpacing: 1,
                          crossAxisSpacing: 1,
                          padding: const EdgeInsets.all(4),
                          shrinkWrap: true,
                    
                          builder: (BuildContext context, int index) {
                    
                            DateFormat inputFormat = DateFormat("MM/dd/yyyy HH:mm:ss");
                            DateTime dateTime = inputFormat.parse(provider.portionList[index].date!);
                            DateFormat outputFormat  = DateFormat("dd/MM/yyyy");
                            String dateOnly = outputFormat.format(dateTime);
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
                                          borderRadius: BorderRadius.circular(10.0),
                                        ),
                                        clipBehavior: Clip.antiAlias,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                    
                    
                                            Row(
                                             // mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Expanded(child:
                                                SizedBox(
                                                  width: itemWidth*0.4,
                                                  child: ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                        backgroundColor: UIGuide.THEME_LIGHT
                                                    ),
                                                    onPressed: () {
                                                      showDialog<void>(
                                                        context: context,
                                                        barrierDismissible: true, // User can dismiss the dialog by tapping outside of it.
                                                        builder: (BuildContext context) {
                                                          return AlertDialog(
                    
                                                            title: Text('Viewed Students'),
                                                            content: Container(
                                                              // Specify a height for the ListView
                                                              height: size.height*0.5,
                                                              width: double.maxFinite,
                                                              child: ListView.builder(
                                                                shrinkWrap: true,
                                                                itemCount: provider.portionList[index].viewedList!.length, // Specify the number of items
                                                                itemBuilder: (BuildContext context, int intx) {
                                                                  return ListTile(
                                                                    leading: Text("${intx+1}",style: TextStyle(color: UIGuide.light_Purple,fontWeight: FontWeight.w500)),
                                                                    title: Text('${provider.portionList[index].viewedList![intx].name}',style: TextStyle(color: UIGuide.light_Purple,
                                                                    fontWeight: FontWeight.w400
                                                                    ),),
                                                                    trailing: IconButton(onPressed: ()async {
                                                                      phn = provider.portionList[index].viewedList![intx].mobile ==
                                                                          null
                                                                          ? '--'
                                                                          : provider.portionList[index].viewedList![intx].mobile
                                                                          .toString();
                    
                                                                      await _makingPhoneCall(phn!);
                    
                    
                                                                    }, icon: Icon(Icons.phone,color: UIGuide.light_Purple,)),
                                                                  );
                                                                },
                                                              ),
                                                            ),
                                                            actions: <Widget>[
                                                              TextButton(
                                                                child: Text('Close',style: TextStyle(color: UIGuide.light_Purple)),
                                                                onPressed: () {
                                                                  Navigator.of(context).pop();
                                                                },
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      );
                                                    },
                                                    child: Row(
                                                      // mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        Icon(Icons.visibility,color: UIGuide.light_Purple,), // Rep
                                                        // SizedBox(width: 1), // Adjust the spacing between icon and text
                                                        Text('${provider.portionList[index].seenCount}',style: TextStyle(
                                                            color: UIGuide.light_Purple
                                                        ),),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                      ),
                    
                                                Expanded(
                                                  child: SizedBox(
                                                    width: itemWidth*0.4,
                                                    child: ElevatedButton(
                                                      style: ElevatedButton.styleFrom(
                                                          backgroundColor: UIGuide.light_black
                                                      ),
                                                      onPressed: () {
                                                        showDialog<void>(
                                                          context: context,
                                                          barrierDismissible: true, // User can dismiss the dialog by tapping outside of it.
                                                          builder: (BuildContext context) {
                                                            return AlertDialog(
                                                              title: Text('Not Viewed Students'),
                                                              content: Container(
                                                                // Specify a height for the ListView
                                                                height: size.height*0.5,
                                                                width: double.maxFinite,
                                                                child: ListView.builder(
                                                                  shrinkWrap: true,
                                                                  itemCount: provider.portionList[index].notViewedList!.length, // Specify the number of items
                                                                  itemBuilder: (BuildContext context, int intx) {
                                                                    return ListTile(
                                                                      leading: Text("${intx+1}",style: TextStyle(
                                                                        color: UIGuide.light_Purple
                                                                      ),),
                    
                                                                      title: Text('${provider.portionList[index].notViewedList![intx].name}',style: TextStyle(color: UIGuide.light_Purple,
                                                                          fontWeight: FontWeight.w400
                                                                      ),),
                                                                      trailing: IconButton(onPressed: ()async {
                                                                        phn = provider.portionList[index].notViewedList![intx].mobile ==
                                                                            null
                                                                            ? '--'
                                                                            : provider.portionList[index].notViewedList![intx].mobile
                                                                            .toString();
                    
                                                                        await _makingPhoneCall(phn!);
                    
                    
                                                                      }, icon: Icon(Icons.phone,color: UIGuide.light_Purple,)),
                                                                    );
                                                                  },
                                                                ),
                                                              ),
                                                              actions: <Widget>[
                                                                TextButton(
                                                                  child: Text('Close',style: TextStyle(color: UIGuide.light_Purple)),
                                                                  onPressed: () {
                                                                    Navigator.of(context).pop();
                                                                  },
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      },
                                                      child: Row(
                    
                                                        children: [
                                                          Icon(Icons.visibility_off,color: Colors.black54,), // Rep
                                                           // Adjust the spacing between icon and text
                                                          Text('${provider.portionList[index].unSeenCount}',style: TextStyle(
                                                              color: Colors.black
                                                          ),),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                    
                    
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 4.0),
                                              child: Text(
                                                dateOnly,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: UIGuide.light_Purple,
                                                    fontWeight: FontWeight.w500
                                                ),),
                                            ),
                                            kheight10,
                                            Padding(
                                              padding: const EdgeInsets.only(left:4.0),
                                              child: Text(
                                                provider.portionList[index].division.toString(),
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: UIGuide.light_Purple,
                                                    fontWeight: FontWeight.w500
                                                ),
                                              overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            kheight10,
                                            Padding(
                                              padding: const EdgeInsets.only(left:4.0),
                                              child: Text(
                                                provider.portionList[index].subject.toString(),
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: UIGuide.light_Purple,
                                                    fontWeight: FontWeight.w500
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            kheight10,
                                            Padding(
                                              padding: const EdgeInsets.only(left:4.0),
                                              child: Text(
                                                "Chapter",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: UIGuide.light_Purple,
                                                    fontWeight: FontWeight.w500
                                                ),),
                                            ),
                                            kheight5,
                                            Padding(
                                              padding: const EdgeInsets.only(left:6.0,right: 4),
                                              child: TextWrapper(
                                                text:  provider.portionList[index].chapter.toString(),
                                                fSize: 14,
                                              ),
                                            ),
                    
                                            kheight10,
                                            Padding(
                                              padding: const EdgeInsets.only(left:4.0),
                                              child: Text(
                                                "Topic" ,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: UIGuide.light_Purple,
                                                    fontWeight: FontWeight.w500
                                                ),
                                               // overflow: TextOverflow.ellipsis, // Display ellipsis (...) when overflowed
                                                //maxLines: 2,
                    
                                              ),
                                            ),
                                            kheight5,
                                            Padding(
                                              padding: const EdgeInsets.only(left:4.0,right: 4),
                                              child:
                                              TextWrapper(
                                                text:  provider.portionList[index].topic==null ?'':provider.portionList[index].topic.toString() ,
                                                fSize: 14,
                                              ),
                                            ),
                    
                    
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                IconButton(
                                                    onPressed: (){
                                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>PortionEditScreen(id: provider.portionList[index].tblId.toString())));
                                                    },
                                                    icon: Icon(Icons.edit_sharp,color: UIGuide.button1,)),

                                                provider.isApproval==true?
                                                Row(
                                                  children: [
                                                  provider.portionList[index].status=="Approved"?
                                                      Text("Approved",style: TextStyle(
                                                        color: Colors.green,
                                                        fontWeight: FontWeight.w500
                                                      ),):
                                                      Text("")
                                                  ],
                                                ):
                                                SizedBox(height: 0,width: 0,),
                                                IconButton(
                                                    onPressed: (){
                    
                    
                                                      showDialog(
                                                        context: context,
                                                        builder: (
                                                            BuildContext context) {
                                                          return AlertDialog(
                                                            title: Text(
                                                                'Are you sure want to delete'),
                                                            content: Text(
                                                                'You wont be able to revert this!'),
                                                            actions: <Widget>[
                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment
                                                                    .spaceAround,
                                                                children: [
                    
                                                                  TextButton(
                                                                    onPressed: () {
                                                                      // Close the dialog
                                                                      Navigator
                                                                          .of(
                                                                          context)
                                                                          .pop();
                                                                    },
                    
                                                                    child: Text(
                                                                      'Cancel',
                                                                      style: TextStyle(
                                                                          color: UIGuide
                                                                              .light_Purple
                                                                      ),),
                                                                    style: ButtonStyle(
                                                                      backgroundColor: MaterialStateProperty
                                                                          .all(
                                                                          UIGuide
                                                                              .THEME_LIGHT),
                                                                      padding: MaterialStateProperty
                                                                          .all(
                                                                        EdgeInsets
                                                                            .symmetric(
                                                                            horizontal: 20.0,
                                                                            vertical: 10.0),
                                                                      ),
                                                                      textStyle: MaterialStateProperty
                                                                          .all(
                                                                        TextStyle(
                                                                            fontSize: 12.0),
                                                                      ),
                    
                                                                      shape: MaterialStateProperty
                                                                          .all(
                                                                        RoundedRectangleBorder(
                                                                          borderRadius: BorderRadius
                                                                              .circular(
                                                                              8.0),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  TextButton(
                                                                    onPressed: () {
                                                                      provider
                                                                          .portionDelete(
                                                                          context,
                                                                          provider
                                                                              .portionList[index]
                                                                              .tblId
                                                                              .toString(),
                                                                          index);
                                                                     // Navigator.pop(context);
                                                                    },
                    
                                                                    child: Text(
                                                                      'OK',
                                                                      style: TextStyle(
                                                                          color: UIGuide
                                                                              .light_Purple
                                                                      ),),
                                                                    style: ButtonStyle(
                                                                      backgroundColor: MaterialStateProperty
                                                                          .all(
                                                                          UIGuide
                                                                              .THEME_LIGHT),
                                                                      padding: MaterialStateProperty
                                                                          .all(
                                                                        EdgeInsets
                                                                            .symmetric(
                                                                            horizontal: 20.0,
                                                                            vertical: 10.0),
                                                                      ),
                                                                      textStyle: MaterialStateProperty
                                                                          .all(
                                                                        TextStyle(
                                                                            fontSize: 12.0),
                                                                      ),
                    
                                                                      shape: MaterialStateProperty
                                                                          .all(
                                                                        RoundedRectangleBorder(
                                                                          borderRadius: BorderRadius
                                                                              .circular(
                                                                              8.0),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      );
                    
                                                    },
                                                    icon: Icon(Icons.delete_forever_sharp,color: UIGuide.button2,))
                    
                                              ],
                                            ),
                    
                    
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
                  ),
                  provider.loadingPage
                      ? const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 30,
                          height: 30,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: UIGuide.light_Purple,
                          ),
                        ),
                        kWidth,
                        Text(
                          "Please Wait...",
                          style: TextStyle(
                              color: UIGuide.light_Purple,
                              fontWeight: FontWeight.w700,
                              fontSize: 16),
                        )
                      ],
                    ),
                  )
                      : const SizedBox(
                    height: 0,
                  )


                ],
              ),
        )
    );
  }
}
