import 'package:essconnect/Constants.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../Application/AdminProviders/NotificationStaff.dart';

class SmsFormatToStaff extends StatefulWidget {
  final List toList;
  final String types;

  SmsFormatToStaff({Key? key, required this.toList, required this.types})
      : super(key: key);

  @override
  State<SmsFormatToStaff> createState() => _SmsFormatToStaffState();
}

class _SmsFormatToStaffState extends State<SmsFormatToStaff> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var p = Provider.of<NotificationToStaffAdminProviders>(context,
          listen: false);
      await p.clearSMSList();
      await p.viewSMSFormat();
      p.extractedValuesStaff.clear();
      p.smsBody = '';
    });
  }
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<TextEditingController> _controllers = [];
  final formatController = TextEditingController();
  final formatController1 = TextEditingController();
  bool provcheck = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.types == "sms" ? "Send SMS" : "Send E-mail",
            style: const TextStyle(fontSize: 20),
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
        body: Consumer<NotificationToStaffAdminProviders>(
          builder: (context, value, child) => Stack(
            children: [
              ListView(
                children: [
                  LottieBuilder.network(
                    'https://assets10.lottiefiles.com/private_files/lf30_kBx3K1.json',
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 45,
                        width: MediaQuery.of(context).size.width * 0.60,
                        child: Consumer<NotificationToStaffAdminProviders>(
                            builder: (context, snapshot, child) {
                          return ElevatedButton(
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
                                              itemCount: snapshot
                                                      .formatlists.isEmpty
                                                  ? 0
                                                  : snapshot.formatlists.length,
                                              itemBuilder: (context, index) {
                                                return ListTile(
                                                  onTap: () async {
                                                    provcheck = snapshot
                                                        .formatlists[index]
                                                        .isApproved!;

                                                    formatController
                                                        .text = await snapshot
                                                            .formatlists[index]
                                                            .id ??
                                                        '--';
                                                    formatController1
                                                        .text = await snapshot
                                                            .formatlists[index]
                                                            .name ??
                                                        '--';
                                                    await snapshot
                                                        .getStaffSMSContent(
                                                            formatController
                                                                .text);

                                                    Navigator.of(context).pop();
                                                  },
                                                  title: Text(
                                                    snapshot.formatlists[index]
                                                            .name ??
                                                        '--',
                                                    textAlign: TextAlign.center,
                                                  ),
                                                );
                                              }),
                                        ));
                                  });
                            },
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
                                fillColor: Colors.transparent,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      style: BorderStyle.none, width: 0),
                                ),
                                labelText: "  Select Format",
                                hintText: "Format",
                              ),
                              enabled: false,
                            ),
                          );
                        }),
                      ),

                    ],
                  ),
                  kheight10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: (){

                            value.extractedValuesStaff.isEmpty?
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
                                  'Nothing to edit.....!',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ):

                            showModalBottomSheet(

                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.white,
                              builder: (context) {
                                return Padding(
                                  padding: MediaQuery.of(context).viewInsets,
                                  child: Wrap(
                                      children: [
                                        LimitedBox(
                                          maxHeight: size.height*0.40,
                                          child: Form(
                                            key: _formKey,
                                            child: Column(
                                              children: [

                                                ListTile(

                                                  title: const Text("Edit Content"),
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
                                                            itemCount: value.extractedValuesStaff.length,
                                                            itemBuilder: ((context, index) {

                                                              _controllers.add(TextEditingController());


                                                              _controllers[index].text = value
                                                                  .extractedValuesStaff[index] ;
                                                              print("length");
                                                              print(value.extractedValuesStaff.length);

                                                              return Column(

                                                                children: [

                                                                  Padding(
                                                                    padding: const EdgeInsets.all( 4),
                                                                    child: LimitedBox(
                                                                        maxHeight: 100,
                                                                        maxWidth:size.width,
                                                                        child: TextFormField(
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
                                                                                  color: UIGuide.light_Purple,
                                                                                  width: 1.0),
                                                                            ),
                                                                            focusedBorder: OutlineInputBorder(
                                                                              borderSide: const BorderSide(color:UIGuide.light_Purple, width: 1.0),
                                                                              borderRadius: BorderRadius.circular(10.0),
                                                                            ),

                                                                          ),
                                                                          controller: _controllers[index],
                                                                          onChanged: (value1){
                                                                            _controllers[index]
                                                                                .addListener(() {
                                                                              value1;
                                                                            });
                                                                            value
                                                                                .extractedValuesStaff[
                                                                            index] =_controllers[index].text;


                                                                          },


                                                                        )),
                                                                  ),

                                                                ],
                                                              );

                                                            })),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(4.0),
                                                  child: SizedBox(
                                                    height:40,
                                                    width: size.width*.30 ,
                                                    child: ElevatedButton(

                                                      onPressed: (){

                                                        List changes=[];
                                                        List data=[];
                                                        changes.clear();
                                                        for(int i=0;i< value.extractedValuesStaff.length;i++){
                                                          changes.add(
                                                              {
                                                                "changeableText" : value.extractedValuesStaff[i]
                                                              }
                                                          );

                                                          data.add(value.extractedValuesStaff[i]);
                                                        }
                                                        print("exxxxxxxxxxx");
                                                        print(value.extractedValuesStaff);
                                                        print(changes);
                                                        print(data);


                                                        value.replaceValuesInsideDoubleBrackets(value.smsBody!, value.extractedValuesStaff);
                                                        //*****
                                                        if (_formKey.currentState!
                                                            .validate()) {
                                                          value.smsformatedit(
                                                              context,
                                                              value.smsBody!,
                                                              formatController1.text,
                                                              value.smsBody!,
                                                              provcheck,
                                                              changes,
                                                              formatController.text);
                                                        }

                                                      },



                                                      child: Text("Set"),
                                                      style: ElevatedButton.styleFrom(
                                                          backgroundColor: UIGuide.light_Purple
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ]
                                  ),
                                );
                              },
                            );

                          },
                          child: Container(
                            child: Row(
                              children: [
                                Text("Edit Content ",style: TextStyle(
                                  color: UIGuide.light_Purple,
                                ),),

                                Icon(Icons.edit_sharp,size: 15,color: UIGuide.light_Purple,)

                              ],
                            ),
                          )
                      ),
                    ],
                  ),

                  Consumer<NotificationToStaffAdminProviders>(
                    builder: (context, value, child) => value.smsBody == null ||
                            value.smsBody == ""
                        ? const SizedBox(
                            height: 0,
                            width: 0,
                          )
                        : Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Container(
                                width: size.width,
                                //  height: 100,
                                decoration: BoxDecoration(
                                    border: Border.all(color: UIGuide.BLACK),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Text(
                                    value.smsBody ?? '',
                                    maxLines: 10,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )),
                          ),
                  ),
                  kheight10,
                  Center(
                    child: Consumer<NotificationToStaffAdminProviders>(
                        builder: (context, value, child) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: SizedBox(
                                  width: 150,
                                  height: 40,
                                  child: MaterialButton(
                                    onPressed: () async {
                                      if (formatController1.text.isEmpty) {
                                        snackbarWidget(
                                            2,
                                            "Please select any format",
                                            context);
                                      } else {
                                        print(value.stafflist.length);

                                        if (provcheck == true) {
                                          await value.sendSmstoStaff(
                                              context,
                                              formatController.text.toString(),
                                              widget.toList);
                                        } else {
                                          snackbarWidget(
                                              2,
                                              "SMS format not approved",
                                              context);
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
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                    color: UIGuide.light_Purple,
                                    child: const Text(
                                      'Send',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              widget.types == "email"
                                  ? SizedBox(
                                      height: 0,
                                      width: 0,
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: SizedBox(
                                        width: 150,
                                        height: 40,
                                        child: MaterialButton(
                                          onPressed: () async {
                                            await value.getSMSBalanceStaff();
                                          },
                                          shape: RoundedRectangleBorder(
                                            borderRadius: const BorderRadius
                                                .only(
                                                topLeft: Radius.circular(20),
                                                topRight: Radius.circular(0),
                                                bottomLeft: Radius.circular(0),
                                                bottomRight:
                                                    Radius.circular(20)),
                                            side: BorderSide(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ),
                                          color: UIGuide.light_Purple,
                                          child: Text(
                                            value.balance == null ||
                                                    value.balance!.isEmpty
                                                ? 'Balance'
                                                : "Balance: ${value.balance.toString()}",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
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
              ),
              if (value.loadSMS)
                Container(
                  color: Colors.black.withOpacity(0.2),
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(color: UIGuide.WHITE),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(
                              color: UIGuide.light_Purple,
                            ),
                            kWidth,
                            Text(
                              "Please Wait...",
                              style: TextStyle(
                                  color: UIGuide.light_Purple,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ));
  }
}
