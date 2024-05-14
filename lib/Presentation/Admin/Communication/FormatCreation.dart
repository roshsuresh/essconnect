
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../Application/Staff_Providers/TextSMS_ToGuardian.dart';
import '../../../Constants.dart';
import '../../../utils/constants.dart';

class FormatCreation extends StatefulWidget {
  const FormatCreation({super.key});

  @override
  State<FormatCreation> createState() => _FormatCreationState();
}

class _FormatCreationState extends State<FormatCreation> {
  final formatnamecontroller = TextEditingController();
  final formatnewnamecontroller = TextEditingController();
  final formatidcontroller = TextEditingController();
  final formattitlecontroller = TextEditingController();
  final formatmattercontroller = TextEditingController();
  String mattervalue = '';
  String? dropdownvalue ;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<String> valuess = [
    'Notification',
    'Sms',

  ];
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var p = await Provider.of<TextSMS_ToGuardian_Providers>(context, listen: false);
      p.clearNotificationList();
      p.getInitialCommunication();
      p.getNotificationFormatList();



    });
  }
  @override
  Widget build(BuildContext context) {
    var size= MediaQuery.of(context).size;
    return  Scaffold(
      appBar:AppBar(
        title: Text(
          "Create Format",
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
        backgroundColor: UIGuide.light_Purple,
      ),
      body: Consumer<TextSMS_ToGuardian_Providers>(
        builder: (context,value,_)=>
        ListView(children: [


          // Container(
          //   alignment: Alignment.bottomLeft,
          //     child: Text("    Format Type")),
          // Row(
          //   children: [
          //     Expanded(
          //       child: Padding(
          //         padding: const EdgeInsets.only(left: 8.0,right: 8,bottom: 8),
          //         child: Container(
          //
          //           padding: EdgeInsets.symmetric(horizontal: 12),
          //           decoration: BoxDecoration(
          //           border: Border.all(color: Colors.grey),
          //           borderRadius: BorderRadius.circular(8),),
          //
          //           child: DropdownButtonHideUnderline(
          //             child: DropdownButton(
          //
          //               // Initial Value
          //               value: dropdownvalue,
          //               style: TextStyle(
          //                 color: UIGuide.light_Purple,
          //                 fontSize: 15,
          //               ),
          //               icon: const Icon(Icons.keyboard_arrow_down),
          //               isExpanded: true,
          //               items: valuess.map((String dropdownvalue) {
          //                 return DropdownMenuItem(
          //
          //
          //                   value: dropdownvalue,
          //                   child: Text(dropdownvalue),
          //                 );
          //               }).toList(),
          //               hint: Text("Select Format Type"),
          //
          //
          //               onChanged: (String? newValue) {
          //                 setState(() {
          //                   dropdownvalue = newValue!;
          //                   print(dropdownvalue);
          //                 });
          //               },
          //
          //             ),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          kheight10,

          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text("Format"),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0,right: 8.0,bottom: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 3,
                      foregroundColor: UIGuide.light_Purple,
                      backgroundColor:
                      const Color.fromARGB(255, 255, 255, 255),
                      padding: const EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10)),
                          side: const BorderSide(
                            color: UIGuide.THEME_LIGHT,
                          ),

                      ),
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
                                  maxHeight: size.height / 1.5,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: value
                                          .notificationFormatList.isEmpty
                                          ? 0
                                          : value.notificationFormatList.length,
                                      itemBuilder: (context, index) {

                                        return ListTile(
                                          onTap: () async {

                                            formatnamecontroller.clear();

                                            formatidcontroller
                                                .text = await value
                                                .notificationFormatList[index]
                                                .id ??
                                                '--';
                                            formatnamecontroller
                                                .text = await value
                                                .notificationFormatList[index]
                                                .notificationFormatName ??
                                                '--';
                                            await value
                                                .getNotificationContent(
                                                formatidcontroller
                                                    .text);

                                            formatidcontroller.text.isNotEmpty?
                                            formattitlecontroller.text= value.notificationFormatList[index].notificationTitle.toString()
                                                :formattitlecontroller.text;
                                            formatidcontroller.text.isNotEmpty?
                                            formatmattercontroller.text= value.notificationFormatList[index].notificationDescription.toString()
                                                :formatmattercontroller.text;




                                            Navigator.of(context).pop();
                                          },
                                          title: Text(
                                            value.notificationFormatList[index]
                                                .notificationFormatName ??
                                                '--',
                                            textAlign: TextAlign.center,
                                          ),
                                        );
                                      }),
                                ));


                          });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: TextField(
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: UIGuide.light_Purple,
                            overflow: TextOverflow.clip),
                        textAlign: TextAlign.start,
                        controller: formatnamecontroller,
                        decoration: const InputDecoration(
                          contentPadding:
                          EdgeInsets.only(left: 0, top: 0),
                          floatingLabelBehavior:
                          FloatingLabelBehavior.never,
                          filled: true,
                          fillColor: Colors.transparent,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                style: BorderStyle.none, width: 0,),
                          ),
                          labelText: " Select Format",
                          hintText: "Format",
                        ),
                        enabled: false,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 48,width: 30,
                  child: ElevatedButton(
                      onPressed: (){
                        formatidcontroller.clear();
                        formatnamecontroller.clear();
                        formattitlecontroller.clear();
                        formatmattercontroller.clear();
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 3,
                        foregroundColor: UIGuide.light_Purple,
                        backgroundColor:
                        const Color.fromARGB(255, 255, 255, 255),
                        padding: const EdgeInsets.all(0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10)),
                            side: const BorderSide(
                              color: UIGuide.THEME_LIGHT,
                            )),
                      ),
                      child: Icon(
                    Icons.close
                  )),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: LimitedBox(
              maxHeight: 180,
              child: TextFormField(
                inputFormatters: [LengthLimitingTextInputFormatter(200),
                  FilteringTextInputFormatter.deny(RegExp(r'^\s'))
                ],
                controller: formattitlecontroller,
                minLines: 1,
                maxLines: 15,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  labelText: 'Title *',
                  hintText: 'Enter Title *',
                  labelStyle: TextStyle(color: UIGuide.light_Purple),
                  hintStyle: TextStyle(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: UIGuide.THEME_LIGHT, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(10),

                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: UIGuide.THEME_LIGHT, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: LimitedBox(
              maxHeight: 180,
              child: TextFormField(
                inputFormatters: [LengthLimitingTextInputFormatter(200),
                  FilteringTextInputFormatter.deny(RegExp(r'^\s'))
                ],
                controller: formatmattercontroller,
                minLines: 1,
                maxLines: 15,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  labelText: 'Description *',
                  hintText: 'Enter Description *',
                  labelStyle: TextStyle(color: UIGuide.light_Purple),
                  hintStyle: TextStyle(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: UIGuide.THEME_LIGHT, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(10),

                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: UIGuide.THEME_LIGHT, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    mattervalue = value;
                  });
                },
              ),
            ),
          ),
          kheight10,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 80,
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
                  onPressed: () async {

                    if(
                    formattitlecontroller.text.isEmpty
                    ){
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
                            'Title is required',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    }
                    else if(
                    formatmattercontroller.text.isEmpty
                    ){
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
                            'Matter is required',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    }
                 else {
                   formatnewnamecontroller.clear();
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Save Notification Format',
                              textAlign: TextAlign.center, style: TextStyle(
                                  color: UIGuide.light_Purple,
                                fontSize: 16
                              ),
                            ),
                            content: Form(
                              key: _formKey,
                              child: TextFormField(
                             autofocus: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Required';
                                  }
                                  return null;
                                },


                                decoration:  InputDecoration(

                                  enabledBorder:  OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                        color: UIGuide.THEME_LIGHT,
                                        width: 1.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color:UIGuide.THEME_LIGHT, width: 1.0),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),

                                ),
                                controller: formatnamecontroller,
                                onChanged: (value1){
                                 formatnamecontroller
                                      .addListener(() {
                                    value1;
                                  });



                                },


                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Cancel', style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500
                                ),),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: const Text('Save', style: TextStyle(
                                    color: UIGuide.light_Purple,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500
                                ),),
                                onPressed: () async {

                                  if (_formKey.currentState!
                                      .validate()) {
                                    if (value.notiformatname.contains(formatnamecontroller.text)) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                         SnackBar(
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
                                            'Format "${formatnamecontroller.text}"'
                                                ' alreay exists',
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      );
                                    }
                                    else {
                                      await value.notificationFormatSave(
                                          context,
                                          formatnamecontroller.text,
                                          formattitlecontroller.text,
                                          formatmattercontroller.text);
                                      formatnamecontroller.clear();
                                      formattitlecontroller.clear();
                                      formatmattercontroller.clear();
                                      value.notificationFormatList.clear();
                                      value.notiformatname.clear();
                                      await value.getNotificationFormatList();
                                    }
                                  }
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }


                  },
                  child: const Text("Save"),
                ),
              ),
              kWidth,
              SizedBox(
                width: 80,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 3,
                    foregroundColor: UIGuide.WHITE,
                    backgroundColor: UIGuide.button2,
                    padding: const EdgeInsets.all(0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(
                          color: UIGuide.light_black,
                        )),
                  ),
                  onPressed: () async {

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
                                  onPressed: ()async {
                                   await value.
                                  notificationFormatlDelete(context,
                                        formatidcontroller.text);

                                 Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>FormatCreation()));
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
                  child: const Text("Delete"),
                ),
              ),
            ],
          ),

          kheight20,



          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                child: Text('Admission Number',style: TextStyle(
                    color: UIGuide.light_Purple
                ),),
                style: OutlinedButton.styleFrom(
                    textStyle: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)))),
                onPressed: () {
                  setState(() {
                    mattervalue += '{{Admission Number}}'; // Add your value here
                    formatmattercontroller.text = mattervalue;
                  });

                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                child: Text('Roll Number',style: TextStyle(
                    color: UIGuide.light_Purple
                ),),
                style: OutlinedButton.styleFrom(
                    textStyle: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)))),
                onPressed: () {
                  setState(() {
                    mattervalue += '{{Roll Number}}'; // Add your value here
                    formatmattercontroller.text = mattervalue;
                  });
                },
              ),
              kWidth5,
              OutlinedButton(
                child: Text('Student',style: TextStyle(
                    color: UIGuide.light_Purple
                ),),
                style: OutlinedButton.styleFrom(
                    textStyle: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)))),
                onPressed: () {
                  setState(() {
                    mattervalue += '{{Student}}'; // Add your value here
                    formatmattercontroller.text = mattervalue;
                  });
                },
              ),
              kWidth5,
              OutlinedButton(
                child: Text('Guardian',style: TextStyle(
                    color: UIGuide.light_Purple
                ),),
                style: OutlinedButton.styleFrom(
                    textStyle: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)))),
                onPressed: () {
                  setState(() {
                    mattervalue += '{{Guardian}}'; // Add your value here
                    formatmattercontroller.text = mattervalue;
                  });
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                child: Text('Course',style: TextStyle(
                    color: UIGuide.light_Purple
                ),),
                style: OutlinedButton.styleFrom(
                    textStyle: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)))),
                onPressed: () {},
              ),
              kWidth5,
              OutlinedButton(
                child: Text('Division',style: TextStyle(
                    color: UIGuide.light_Purple
                ),),
                style: OutlinedButton.styleFrom(
                    textStyle: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)))),
                onPressed: () {
                  setState(() {
                    mattervalue += '{{Division}}'; // Add your value here
                    formatmattercontroller.text = mattervalue;
                  });
                },
              ),
              kWidth5,
              OutlinedButton(
                child: Text('Class Teacher',style: TextStyle(
                    color: UIGuide.light_Purple
                ),),
                style: OutlinedButton.styleFrom(
                    textStyle: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)))),
                onPressed: () {
                  setState(() {
                    mattervalue += '{{Class Teacher}}'; // Add your value here
                    formatmattercontroller.text = mattervalue;
                  });
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                child: Text('Current Date',style: TextStyle(
                    color: UIGuide.light_Purple
                ),),
                style: OutlinedButton.styleFrom(
                    textStyle: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)))),
                onPressed: () {
                  setState(() {
                    mattervalue += '{{Current Date}}'; // Add your value here
                    formatmattercontroller.text = mattervalue;
                  });
                },
              ),
              kWidth5,
              OutlinedButton(
                child: Text('Current Time',style: TextStyle(
                    color: UIGuide.light_Purple
                ),),
                style: OutlinedButton.styleFrom(
                    textStyle: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)))),
                onPressed: () {
                  setState(() {
                    mattervalue += '{{Current Time}}'; // Add your value here
                    formatmattercontroller.text = mattervalue;
                  });
                },
              ),

            ],
          )

        ],),
      ),
    );
  }
}
