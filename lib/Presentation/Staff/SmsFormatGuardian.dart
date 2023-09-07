
import 'package:essconnect/Constants.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Application/Staff_Providers/Notification_ToGuardianProvider.dart';

class SmsFormatGuardian extends StatefulWidget {
  final List<String> toList;
  final String types;

  SmsFormatGuardian({Key? key, required this.toList,required this.types})
      : super(key: key);

  @override
  State<SmsFormatGuardian> createState() => _SmsFormatGuardianState();
}

class _SmsFormatGuardianState extends State<SmsFormatGuardian> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var p = Provider.of<NotificationToGuardian_Providers>(context, listen: false);
      p.clearSMSList();
      p.viewSMSFormat();
      p.smsBody = '';

      formatController.clear();
      formatController1.clear();
    });
  }


  final formatController = TextEditingController();
  final formatController1 = TextEditingController();
  bool provcheck = false;
  bool avoid = false;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Send SMS',
            style: TextStyle(fontSize: 20),
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
        body: ListView(
          children: [
            kheight10,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.60,
                  child: Consumer<NotificationToGuardian_Providers>(
                      builder: (context, snapshot, child) {
                        return InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                      child: LimitedBox(
                                        maxHeight: size.height/1.5,
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: snapshot.formatlist.isEmpty
                                                ? 0
                                                : snapshot.formatlist.length,
                                            itemBuilder: (context, index) {
                                              return ListTile(
                                                onTap: () async {
                                                  provcheck = snapshot
                                                      .formatlist[index]
                                                      .isApproved!;
                                                  formatController1.clear();
                                                  formatController.text =
                                                      await snapshot
                                                          .formatlist[index]
                                                          .value ??
                                                          '--';
                                                  formatController1.text =
                                                      await snapshot
                                                          .formatlist[index]
                                                          .text ??
                                                          '--';
                                                  await snapshot.getSMSContent(
                                                      formatController.text);

                                                  Navigator.of(context).pop();
                                                },
                                                title: Text(
                                                  snapshot.formatlist[index].text ??
                                                      '--',
                                                  textAlign: TextAlign.center,
                                                ),
                                              );
                                            }),
                                      ));
                                });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: UIGuide.light_Purple, width: 1),
                                  ),
                                  height: 40,
                                  child: TextField(
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: UIGuide.BLACK,
                                        overflow: TextOverflow.clip),
                                    textAlign: TextAlign.center,
                                    controller: formatController1,
                                    decoration: const InputDecoration(
                                      contentPadding:
                                      EdgeInsets.only(left: 0, top: 0),
                                      floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                      filled: true,
                                      fillColor: Color.fromARGB(255, 238, 237, 237),
                                      border: OutlineInputBorder(),
                                      labelText: "  Select Format",
                                      hintText: "Format",
                                    ),
                                    enabled: false,
                                  ),
                                ),
                                SizedBox(
                                  height: 0,
                                  child: TextField(
                                    textAlign: TextAlign.center,
                                    controller: formatController,
                                    decoration: const InputDecoration(
                                      filled: true,
                                      fillColor: Color.fromARGB(255, 238, 237, 237),
                                      border: OutlineInputBorder(),
                                      labelText: "",
                                      hintText: "",
                                    ),
                                    enabled: false,
                                  ),
                                ),

                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
            kheight10,
            Consumer<NotificationToGuardian_Providers>(
              builder: (context, value, child) => value.smsBody!.isEmpty
                  ? Container(
                height: 0,
                width: 0,
              )
                  : Padding(
                padding: const EdgeInsets.all(3.0),
                child: Container(
                    width: size.width,
                    height: 100,
                    decoration: BoxDecoration(
                        border: Border.all(color: UIGuide.BLACK),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text(
                        value.smsBody ?? '',
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )),
              ),
            ),
            kheight10,
            Center(child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Avoid Repeated ${widget.types}"),
                Checkbox(
                  activeColor: UIGuide.light_Purple,
                  checkColor: UIGuide.THEME_LIGHT,
                  value: this.avoid,
                  onChanged: (bool? value) {
                    setState(() {
                      this.avoid = value!;
                      print(value);
                    });
                  },
                ),


              ],
            )),

            Center(
              child: Consumer<NotificationToGuardian_Providers>(
                  builder: (context, value, child) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: 150,
                              height: 40,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: value.selectedSmsList.isEmpty
                                      ? 0
                                      : value.selectedSmsList.length,
                                  itemBuilder: (context, index) {
                                    return MaterialButton(
                                      onPressed: () async {
                                        if(value.numbList.isEmpty){

                                        }
                                        if (formatController1.text.isEmpty) {
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
                                                'Please select any format.....!',
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          );
                                        } else {
                                          List obj = [];
                                          obj.clear();
                                          print(obj);
                                          print(value.numbList.length);


                                          if (provcheck == true) {
                                            value.numbList.clear();
                                           await value.getNumbers(widget.toList, avoid);


                                            for (int i = 0; i < value.numbList.length; i++) {
                                              obj.add(
                                                {
                                                  "phone": value.numbList[i].guardianMobile,
                                                  "email": value.numbList[i].guardianEmail,
                                                  "relation":"guardian" ,
                                                  "id": value.numbList[i].studentId,
                                                  "admNo": value.numbList[i].admNo,
                                                  "classTeacher": value.numbList[i].classTeacher,
                                                  "name": value.numbList[i].name,
                                                  "course": value.numbList[i].course,
                                                  "division": value.numbList[i].division,
                                                  "rollNo": value.numbList[i].rollNo,
                                                  "fatherName": value.numbList[i].fatherName,
                                                  "motherName": value.numbList[i].motherName,
                                                  "guardianName": value.numbList[i].guardianName
                                                },
                                              );

                                            }
                                            await value.sendSms(context, obj, formatController.text.toString());
                                            // formatController1.clear();
                                            // formatController.clear();
                                            //  value.smsBody="";



                                          } else {
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
                                                  'Sms format not approved...!',
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            );
                                          }
                                        }
                                      },
                                      shape: RoundedRectangleBorder(
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(0),
                                            bottomLeft: Radius.circular(0),
                                            bottomRight: Radius.circular(20)),
                                        side: BorderSide(
                                            color: Theme.of(context).primaryColor),
                                      ),
                                      color: UIGuide.light_Purple,
                                      child: const Text(
                                        'Send',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    );

                                  }),
                            ),
                            widget.types=="email"?SizedBox(
                              height: 0,
                                width: 0,
                            ):
                            SizedBox(
                              width: 150,
                              height: 40,
                              child:
                              MaterialButton(
                                      onPressed: () async {
                                      await  value.getSMSBalance();

                                      },
                                      shape: RoundedRectangleBorder(
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(0),
                                            bottomLeft: Radius.circular(0),
                                            bottomRight: Radius.circular(20)),
                                        side: BorderSide(
                                            color: Theme.of(context).primaryColor),
                                      ),
                                      color: UIGuide.light_Purple,
                                      child:  Text(
                                        value.balance==null||value.balance!.isEmpty ?
                                        'Balance': "Balance: ${value.balance.toString()}",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                            ),
                          ],
                        ),




                      ],

                    );
                  }),
            )
          ],
        ));
  }
}
