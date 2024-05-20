
import 'package:essconnect/Application/Staff_Providers/Anecdotal/AnecdotalStaffListProvider.dart';
import 'package:essconnect/Constants.dart';
import 'package:essconnect/Domain/Staff/Anecdotal/InitialSelectionModel.dart';
import 'package:essconnect/Presentation/Admin/Anecdotal/AddAnecdotalCategory.dart';
import 'package:essconnect/Presentation/Admin/Anecdotal/AddSubjects.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:essconnect/utils/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:provider/provider.dart';

import '../../../../Application/Staff_Providers/Anecdotal/AncedotalStaffProvider.dart';
import '../../../../Application/Staff_Providers/Notification_ToGuardianProvider.dart';
import '../../../../Debouncer.dart';
import '../../../../Domain/Staff/Anecdotal/StudListviewAnectdotal.dart';
class AnecdotalentryScreenAdmin extends StatefulWidget {
  AnecdotalentryScreenAdmin({super.key});

  @override
  State<AnecdotalentryScreenAdmin> createState() => _AnecdotalentryScreenState();
}

class _AnecdotalentryScreenState extends State<AnecdotalentryScreenAdmin> {
  final categoryController = TextEditingController();

  final categoryIDController = TextEditingController();

  final subjectController = TextEditingController();

  final subjectIDController = TextEditingController();
  final List<StaffList> users=[];
  final remarkController = TextEditingController();
  String? selectedValue;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var p = Provider.of<AnecdotalStaffProviders>(context, listen: false);
      var c = Provider.of<AnecdotalStaffListProviders>(context, listen: false);
      await p.setLoading(false);
      await p.clearInitial();
      await p.getCategorySubject();
      await p.getDateNow();
      await p.timeModel();
      c.currentPage = 1;
      c.getAnecdotalList();

    });
  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Consumer<AnecdotalStaffProviders>(
        builder: (context, value, _) => Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: ListView(
                children: [
                  kheight10,
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 45,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(
                                color: UIGuide.light_black,
                              ),
                            ),
                            elevation: 5,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  value.finalSelectedList.isEmpty
                                      ? "Select Student"
                                      : "${value.finalSelectedList.length} Student Selected",
                                  style: const TextStyle(
                                      color: UIGuide.BLACK,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      SizedBox(
                        height: 38,
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
                                ),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const StudentListAnecdotalView()));
                            },
                            child: const Icon(Icons.list_alt)),
                      )
                    ],
                  ),
                  kheight10,
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 40,
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

                                showDialog(
                                    context: context,
                                    builder: (context) {



                                      return Dialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: LimitedBox(
                                            maxHeight: size.height / 1.3,
                                            child: ListView.builder(
                                                shrinkWrap: true,
                                                itemCount:
                                                    value.remarksCategoryList.length,
                                                itemBuilder: (context, index) {
                                                  return ListTile(
                                                    onTap: () async {
                                                      Navigator.of(context).pop();


                                                      categoryController.text = value
                                                              .remarksCategoryList[
                                                                  index]
                                                              .text ??
                                                          '--';
                                                      categoryIDController
                                                          .text = value
                                                              .remarksCategoryList[
                                                                  index]
                                                              .value ??
                                                          '--';
                                                    },
                                                    title: Text(
                                                      value.remarksCategoryList[index]
                                                              .text ??
                                                          '--',
                                                      textAlign: TextAlign.start,
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
                                // textAlign: TextAlign.center,
                                controller: categoryController,
                                decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 5, top: 0),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    filled: true,
                                    fillColor: Colors.transparent,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          style: BorderStyle.none, width: 0),
                                    ),
                                    labelText: "  Select Remarks Category *",
                                    labelStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: UIGuide.BLACK,
                                    )),
                                enabled: false,
                              )),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      SizedBox(
                        height: 38,
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
                                ),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                       AddanecDotalCategory()));
                            },
                            child: const Icon(Icons.settings_outlined)),
                      )
                    ],
                  ),
                  kheight10,
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 40,
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
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Dialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: LimitedBox(
                                            maxHeight: size.height / 1.3,
                                            child: ListView.builder(
                                                shrinkWrap: true,
                                                itemCount:
                                                    value.dairySubjectList.length,
                                                itemBuilder: (context, index) {
                                                  return ListTile(
                                                    onTap: () async {
                                                      Navigator.of(context).pop();

                                                      subjectController.text = value
                                                              .dairySubjectList[index]
                                                              .text ??
                                                          '--';
                                                      subjectIDController.text = value
                                                              .dairySubjectList[index]
                                                              .value ??
                                                          '--';
                                                    },
                                                    title: Text(
                                                      value.dairySubjectList[index]
                                                              .text ??
                                                          '--',
                                                      textAlign: TextAlign.start,
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
                                controller: subjectController,
                                decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 5, top: 0),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    filled: true,
                                    fillColor: Colors.transparent,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          style: BorderStyle.none, width: 0),
                                    ),
                                    labelText: "  Select Dairy Subject",
                                    labelStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: UIGuide.BLACK,
                                    )),
                                enabled: false,
                              )),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      SizedBox(
                        height: 38,
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
                                ),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                       AddSubjects()));
                            },
                            child: const Icon(Icons.settings_outlined)),
                      )
                    ],
                  ),
                  kheight5,
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 45,
                          child:
                          Row(
                            children: [
                              Expanded(
                                child: Card(
                                  color: Colors.white54,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0),bottomLeft: Radius.circular(10.0)),
                                    side: const BorderSide(
                                      color: UIGuide.light_black,
                                    ),
                                  ),
                                  elevation: 5,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        value.staffname==''?
                                       value.userName.toString(): value.staffname,
                                        style: const TextStyle(
                                            color: UIGuide.BLACK,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                              child:Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(10.0),topRight: Radius.circular(10.0)),
                                  side: const BorderSide(
                                    color: UIGuide.light_black,
                                  ),
                                ),
                                elevation: 5,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                          "Select Staff",
                                      style: const TextStyle(
                                          color: Colors.black54,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      SizedBox(
                        height: 38,
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
              ),
            ),
          ),
          onPressed: () {
           Navigator.push(context, MaterialPageRoute(builder: (context)=> StaffSelection(staffId: value.staffname)));
           print(value.staffname);


          },
          child: const Icon(Icons.list_alt)
      )

                        ),

                    ],
                  ),
                  kheight5,
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: size.width / 2.5,
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
                                  ),
                                ),
                              ),
                              onPressed: () {},
                              child: Align(
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.schedule_outlined,
                                      color: Colors.grey,
                                    ),
                                    kWidth,
                                    Text(
                                      value.formattedTime,
                                    ),
                                  ],
                                ),
                              )),
                        ),
                      ),
                      kWidth,
                      Expanded(
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
                                Text(value.fromdateDisplay),
                                kWidth,
                                const SizedBox(
                                  width: 5,
                                ),
                              ],
                            )),
                      )
                    ],
                  ),
                  kheight10,
                  LimitedBox(
                    maxHeight: 180,
                    child: TextFormField(
                      inputFormatters: [LengthLimitingTextInputFormatter(200),
                        FilteringTextInputFormatter.deny(RegExp(r'^\s'))
                      ],
                      controller: remarkController,
                      minLines: 1,
                      maxLines: 15,
                      keyboardType: TextInputType.multiline,
                      decoration: const InputDecoration(
                        labelText: 'Remarks *',
                        hintText: 'Enter Remarks *',
                        labelStyle: TextStyle(color: UIGuide.light_Purple),
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: UIGuide.light_Purple, width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    ),
                  ),
                  kheight10,
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                            onTap: () async {
                              value.isimportantCheckbox();
                            },
                            child: Row(
                              children: [
                                Checkbox(
                                  activeColor: UIGuide.light_Purple,
                                  value: value.isimportant,
                                  onChanged: (newValue) async {
                                    value.isimportantCheckbox();
                                  },
                                ),
                                const Expanded(
                                  //  width: size.width * .35,
                                  child: Text(
                                    "Is Important Entry",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: UIGuide.BLACK, fontSize: 12),
                                  ),
                                )
                              ],
                            )),
                      ),
                      // kWidth,
                      Expanded(
                        child: InkWell(
                            onTap: () async {
                              value.isShownToGuardian();
                            },
                            child: Row(
                              children: [
                                Checkbox(
                                  activeColor: UIGuide.light_Purple,
                                  value: value.showToGuardian,
                                  onChanged: (newValue) async {
                                    value.isShownToGuardian();
                                  },
                                ),
                                const Expanded(
                                  //  width: size.width * .35,
                                  child: Text(
                                    "Show In Guardian Login",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: UIGuide.BLACK, fontSize: 12),
                                  ),
                                )
                              ],
                            )),
                      ),
                    ],
                  ),
                  kheight20,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 150,
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

                              var c=Provider.of<AnecdotalStaffListProviders>(context,listen: false);

                              bool isMatch = false;
                              List obj = [];
                              obj.clear();
                              for (int i =
                              0;
                              i <
                                  value
                                      .finalSelectedList
                                      .length;
                              i++) {
                                obj.add(
                                  {
                                    "studentId": value.finalSelectedList[i],
                                    "id": "",
                                    "createStaffId":value.staffId==""?value.userID.toString():
                                    value.staffId,
                                    "admissionNo": "",
                                    "name": "",
                                    "date": "${value.fromdateSend}T00:00:00",
                                    "createdBy": "",
                                    "remarksCategory": categoryController.text,
                                    "subject": subjectController.text
                                  },
                                );


                              }

                              print("dummy lsit");
                              print(obj);
                              print(value.finalSelectedList.length);
                                 if(value.finalSelectedList.length>1){
                                   print("rosssssss");

                                  for(int j=0;j<c.data['results'].length;j++) {
                                    for (var map in obj) {
                                      // Compare the relevant properties (studentId, remarksCategory, etc.)
                                      if (map['studentId'] ==
                                          c.data['results'][j]['studentId'] &&
                                          map['remarksCategory'] == c
                                              .data['results'][j]['remarksCategory'] &&
                                          map['date'] == c
                                              .data['results'][j]['date'] &&
                                          map['subject'] ==
                                              c.data['results'][j]['subject'] &&
                                          map['createStaffId'] == c
                                              .data['results'][j]['createStaffId']) {
                                        // Set isMatch to true if a match is found
                                        isMatch = true;
                                        break;
                                      }
                                    }
                                  }

                                 }
                                 print(isMatch);

                              if (value.finalSelectedList.isEmpty ||
                                  categoryIDController.text.trim().isEmpty ||
                                  remarkController.text.trim().isEmpty) {
                                snackbarWidget(
                                    3, "Select mandatory fields...", context);
                              }


                             else if(isMatch==true){
                                   showDialog(
                                     context: context,
                                     builder: (BuildContext context) {
                                       return AlertDialog(
                                        //title: Text('Are you sure want to delete'),
                                         content: Text('Remarks of some students already exist. Are you sure you want to update?'),
                                         actions: <Widget>[
                                           Row(
                                             mainAxisAlignment: MainAxisAlignment.spaceAround,
                                             children: [

                                               TextButton(
                                                 onPressed: () {
                                                   // Close the dialog
                                                   Navigator.of(context).pop();
                                                 },

                                                 child: Text('Cancel',style: TextStyle(
                                                     color: UIGuide.light_Purple
                                                 ),),
                                                 style: ButtonStyle(
                                                   backgroundColor: MaterialStateProperty.all(UIGuide.THEME_LIGHT),
                                                   padding: MaterialStateProperty.all(
                                                     EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                                                   ),
                                                   textStyle: MaterialStateProperty.all(
                                                     TextStyle(fontSize: 12.0),
                                                   ),

                                                   shape: MaterialStateProperty.all(
                                                     RoundedRectangleBorder(
                                                       borderRadius: BorderRadius.circular(8.0),
                                                     ),
                                                   ),
                                                 ),
                                               ),
                                               TextButton(
                                                 onPressed: () async{

                                                   await value.getSaveAnecdotal(
                                                       categoryIDController.text,
                                                       subjectIDController.text,
                                                       remarkController.text,
                                                       value.finalSelectedList,
                                                       value.staffId==''?value.userID.toString()
                                                           :value.staffId.toString(),
                                                       context);
                                                   Navigator.pop(context);
                                                   if (value.status == 200) {
                                                     categoryController.clear();
                                                     categoryIDController.clear();
                                                     subjectIDController.clear();
                                                     subjectController.clear();
                                                     remarkController.clear();
                                                     value.staffname='';
                                                     value.staffId='';
                                                     value.finalSelectedList.clear();
                                                   }

                                                 },

                                                 child: Text('Yes',style: TextStyle(
                                                     color: UIGuide.light_Purple
                                                 ),),
                                                 style: ButtonStyle(
                                                   backgroundColor: MaterialStateProperty.all(UIGuide.THEME_LIGHT),
                                                   padding: MaterialStateProperty.all(
                                                     EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                                                   ),
                                                   textStyle: MaterialStateProperty.all(
                                                     TextStyle(fontSize: 12.0),
                                                   ),

                                                   shape: MaterialStateProperty.all(
                                                     RoundedRectangleBorder(
                                                       borderRadius: BorderRadius.circular(8.0),
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
                                 }


                              else {

                                await value.getSaveAnecdotal(
                                    categoryIDController.text,
                                    subjectIDController.text,
                                    remarkController.text,
                                    value.finalSelectedList,
                                    value.staffId==""?value.userID.toString():
                                    value.staffId.toString(),
                                    context);
                                // value.showToGuardian==true?
                                // await Provider.of<NotificationToGuardian_Providers>(context,
                                //     listen: false)
                                //    .sendCommonNotification(context,
                                //     categoryController.text,
                                //     remarkController.text,
                                //     value.finalSelectedList,
                                //     sentTo: "Student"):"";

                                if (value.status == 200) {
                                  categoryController.clear();
                                  categoryIDController.clear();
                                  subjectIDController.clear();
                                  subjectController.clear();
                                  remarkController.clear();
                                  value.staffname='';
                                  value.staffId='';
                                  value.finalSelectedList.clear();
                                }
                              }
                            },
                            child: const Text("Save")),
                      ),
                    ],
                  )
                ],
              ),
            ),
            if (value.loading) pleaseWaitLoader()
          ],
        ),
      ),
    );
  }
}

class StudentListAnecdotalView extends StatefulWidget {
  const StudentListAnecdotalView({super.key});

  @override
  State<StudentListAnecdotalView> createState() =>
      _StudentListAnecdotalViewState();
}

class _StudentListAnecdotalViewState extends State<StudentListAnecdotalView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      _scrollController.addListener(_scrollListener);
      var p = Provider.of<AnecdotalStaffProviders>(context, listen: false);
      await p.setLoading(false);
      await p.clearAllDetails();
      await p.getStudentViewList(section, course, division);
      p.allSelected = false;

      await p.getSectionInitial();
      p.sectionInitialValues.clear();
    });
  }

  void _scrollListener() async {
    final provider =
        Provider.of<AnecdotalStaffProviders>(context, listen: false);
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (provider.hasMoreData()) {
        print("object");
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
        ):

        await provider.getStudentViewByPagination(section, course, division);
      }
    }
  }

  List sectionData = [];
  List courseData = [];
  List divisionData = [];
  String section = '';
  String course = "";
  String sectionToCourse = '';
  String courseToDiv = '';
  String division = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student List'),
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
      body: Consumer<AnecdotalStaffProviders>(
        builder: (context, value, _) => Stack(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 45,
                          child: MultiSelectDialogField(
                            items: value.sectiondropDown,
                            listType: MultiSelectListType.CHIP,
                            title: const Text(
                              "Select Section",
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
                            buttonText: value.sectionLen == 0
                                ? const Text(
                                    "Select Section",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  )
                                : Text(
                                    "   ${value.sectionLen.toString()} Selected",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                            chipDisplay: MultiSelectChipDisplay.none(),
                            onConfirm: (results) async {
                              sectionData = [];
                              divisionData.clear();
                              courseData.clear();
                              value.courseLen = 0;
                              value.divisionLen = 0;

                              for (var i = 0; i < results.length; i++) {
                                SectionsModel data =
                                    results[i] as SectionsModel;
                                print(data.name);
                                print(data.id);
                                sectionData.add(data.id);
                                sectionData.map((e) => data.id);
                                print("${sectionData.map((e) => data.id)}");
                              }
                              section = sectionData
                                  .map((id) => 'getSectionValues=$id')
                                  .join('&');
                              await value.clearCourse();
                              await value.clearDivision();
                              course = '';
                              courseToDiv = '';
                              division = '';
                              sectionToCourse = sectionData.join(',');
                              await value.getCourseList(sectionToCourse);

                              print(section);
                              await value.sectionCounter(results.length);
                            },
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 45,
                          child: MultiSelectDialogField(
                            items: value.coursedropDown,
                            listType: MultiSelectListType.CHIP,
                            title: const Text(
                              "Select Course",
                              style: TextStyle(color: Colors.black),
                            ),
                            selectedItemsTextStyle: const TextStyle(
                                fontSize: 12,
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
                              courseData = [];
                              courseData.clear();
                              value.divisionLen = 0;

                              for (var a = 0; a < results.length; a++) {
                                SectionsModel data =
                                    results[a] as SectionsModel;

                                courseData.add(data.id);
                                courseData.map((e) => data.id);
                                print("${courseData.map((e) => data.id)}");
                              }
                              print('courseData course== $courseData');

                              course = courseData
                                  .map((id) => 'getCourseValues=$id')
                                  .join('&');
                              print(course);

                              // cousse--Div

                              courseToDiv = courseData
                                  .map((id) => 'getDivisionValues=$id')
                                  .join('&');
                              division = '';

                              await value.courseCounter(results.length);
                              results.clear();
                              await value.clearDivision();
                              await value.getDivisionList(courseToDiv);

                              print("course   $course");
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8),
                        child: SizedBox(
                          height: 45,
                          child: MultiSelectDialogField(
                            items: value.divisiondropDown,
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
                              divisionData = [];

                              for (var i = 0; i < results.length; i++) {
                                SectionsModel data =
                                    results[i] as SectionsModel;

                                print(data.id);
                                divisionData.add(data.id);
                                divisionData.map((e) => data.id);
                                print("${divisionData.map((e) => data.id)}");
                              }
                              print("divisionDataaaa    $divisionData");
                              division = divisionData
                                  .map((id) => 'getDivisionValues=$id')
                                  .join('&');
                              print(division);
                              await value.divisionCounter(results.length);
                              value.studentViewList.clear();
                              results.clear();
                              print("data div  $division");
                            },
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 6.0, right: 6),
                        child: SizedBox(
                          height: 45,
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
                              await value.clearStudentViewList();
                              value.currentPage = 2;
                              await value.getStudentViewList(
                                  section, course, division);
                            },
                            child: const Text(
                              'View',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                value.allSelected == true || value.studentViewList.isEmpty
                    ? const SizedBox(
                        width: 0,
                        height: 0,
                      )
                    : Row(
                        children: [
                          const Expanded(
                            child: SizedBox(height: 20),
                          ),

                          Hero(
                            tag: "tagSelect",
                            child: SizedBox(
                              height: 35,
                              child: InkWell(
                                onTap: () async {
                                  await value.selectAll(
                                      section, course, division);
                                  // await value.getSelectAllStudents(
                                  //     section, course, division);
                                },
                                child: Card(
                                  elevation: 5,
                                  child:
                                      Row(
                                    mainAxisSize: MainAxisSize.min,
                                    //mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text("  Select all"),
                                      Text(
                                        ' ${value.countStud == null ? ' ' : value.countStud.toString()} ',
                                        style: const TextStyle(
                                            color: UIGuide.light_Purple,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      const Text("students  "),
                                      SvgPicture.asset(
                                        UIGuide.notcheck,
                                        color: UIGuide.light_Purple,
                                      ),
                                      kWidth
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                value.allSelected == true || value.studentViewList.isEmpty
                    ? const SizedBox(
                        width: 0,
                        height: 0,
                      )
                    : Container(
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 241, 243, 245),
                            border: Border.all(
                                color: UIGuide.light_black, width: 1)),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 2.0, bottom: 2),
                          child: Table(
                            columnWidths: const {
                              0: FlexColumnWidth(1.3),
                              1: FlexColumnWidth(4),
                              2: FlexColumnWidth(1),
                            },
                            children: const [
                              TableRow(children: [
                                Text(
                                  ' Sl.No.',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                Center(
                                  child: Text(
                                    'Name',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 6),
                                  child: Text(
                                    'Select',
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: UIGuide.BLACK),
                                  ),
                                )
                              ])
                            ],
                          ),
                        ),
                      ),
                value.allSelected == true
                    ? Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            await value.selectAll(section, course, division);
                          },
                          child: Center(
                            child: Card(
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      ' ${value.allStudentID.length} ',
                                      style: const TextStyle(
                                          color: UIGuide.light_Purple,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    const Text(
                                      " Students selected  ",
                                      style: TextStyle(fontSize: 17),
                                    ),
                                    SvgPicture.asset(
                                      UIGuide.check,
                                      color: UIGuide.light_Purple,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    : Expanded(
                        child: Scrollbar(
                          child: ListView.builder(
                              controller: _scrollController,
                              itemCount: value.studentViewList.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Container(
                                  decoration: BoxDecoration(
                                    color: index.isEven
                                        ? Colors.white
                                        : const Color.fromARGB(
                                            255, 241, 243, 245),
                                    border: Border.all(
                                        color: UIGuide.light_black, width: 1),
                                  ),
                                  child: ListTile(
                                    dense: true,
                                    titleAlignment:
                                        ListTileTitleAlignment.center,
                                    shape: const RoundedRectangleBorder(),
                                    selectedColor: UIGuide.light_Purple,
                                    leading: Text(
                                      (index + 1).toString(),
                                      textAlign: TextAlign.center,
                                    ),
                                    onTap: () {
                                      value.selectItem(
                                          value.studentViewList[index]);
                                    },
                                    selectedTileColor:
                                        const Color.fromARGB(255, 10, 27, 141),
                                    title: Text(
                                      value.studentViewList[index].name ?? "",
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: UIGuide.BLACK),
                                    ),
                                    subtitle: Row(
                                      children: [
                                        const Text("Adm no: "),
                                        Expanded(
                                          child: Text(
                                            value.studentViewList[index]
                                                    .admNo ??
                                                '---',
                                          ),
                                        ),
                                      ],
                                    ),
                                    trailing:
                                        value.studentViewList[index].selected !=
                                                    null &&
                                                value.studentViewList[index]
                                                    .selected!
                                            ? SvgPicture.asset(
                                                UIGuide.check,
                                                color: UIGuide.light_Purple,
                                              )
                                            : SvgPicture.asset(
                                                UIGuide.notcheck,
                                                color: UIGuide.light_Purple,
                                              ),
                                  ),
                                );
                              }),
                        ),
                      ),
                value.loadingPage
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
            if (value.loading) pleaseWaitLoader()
          ],
        ),
      ),
      bottomNavigationBar: Consumer<AnecdotalStaffProviders>(
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
                        await snap.submitStudent(context);
                      },
                      child: const Text(
                        "Proceed",
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

class StaffSelection extends StatefulWidget {
  String staffId;
   StaffSelection({super.key,required this.staffId});

  @override
  State<StaffSelection> createState() => _StaffSelectionState();
}

class _StaffSelectionState extends State<StaffSelection> {
  final controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final _debouncer = Debouncer(milliseconds: 1000);
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      _scrollController.addListener(_scrollListener);
      var p = Provider.of<AnecdotalStaffProviders>(context, listen: false);
      p.currentPage=2;
  p.getStaffList('');
  p.staffList.clear();
    });
  }
  void _scrollListener() async {
    final provider =
    Provider.of<AnecdotalStaffProviders>(context, listen: false);
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (provider.hasMoreStaffData()) {
        print("object");

        await provider.getStaffListbyPagination(controller.text);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Consumer<AnecdotalStaffProviders>(
          builder: (context,value,_)=>
          Column(
            children: [
              kheight10,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.grey,
                        )),
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: TextField(
                          focusNode: FocusNode(),
                          autofocus: true,
                          controller: controller,
                          onChanged: (value) {
                            _debouncer.run(() async {
                              await Provider.of<AnecdotalStaffProviders>(context,
                                  listen: false)
                                  .clearStaffList();
                              await Provider.of<AnecdotalStaffProviders>(context,
                                  listen: false)
                                  .getStaffList(value);
                              print('-***--**-*-*-*-*-*');
                            });
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            suffixIcon: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.close),
                                  color: Colors.grey,
                                  onPressed: (() async{
                                    controller.clear();

                                    await Provider.of<AnecdotalStaffProviders>(context,
                                        listen: false)
                                      .clearStaffList();
                                    await Provider.of<AnecdotalStaffProviders>(context,
                                        listen: false)
                                        .getStaffList('');
                                  }),
                                ),
                              ],
                            ),
                            hintText: 'Search By Name',
                            hintStyle: const TextStyle(
                              color: Colors.grey,
                              fontSize: 20,
                            ),
                            fillColor: UIGuide.light_black,
                            filled: true,
                            //  contentPadding: EdgeInsets.only(left: 8),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                              const BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: const BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          style: const TextStyle(color: UIGuide.light_Purple),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Consumer<AnecdotalStaffProviders>(
                    builder: (context, provider, child) {

                      if (provider.staffList.isEmpty) {
                        Future.delayed(const Duration(seconds: 2));

                        return provider.loading
                            ? spinkitLoader()
                            : Center(
                          child: LottieBuilder.network(
                              'https://assets2.lottiefiles.com/private_files/lf30_lkquf6qz.json'),
                        );
                      }
                      return provider.loading
                          ? spinkitLoader()
                          : ListView.builder(
                        controller: _scrollController,
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: provider.staffList.isEmpty
                            ? 0
                            : provider.staffList.length,
                        itemBuilder: (context, index) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              kheight10,
                              GestureDetector(
                                onTap: () {
                             widget.staffId=
                             provider.staffList[index].id.toString();
                             provider.staffId =  provider.staffList[index].id.toString();
                             provider.staffname =  provider.staffList[index].name.toString();
                             Navigator.pop(context);

                                },
                                child: Container(
                                  width: size.width - 15,
                                  decoration: const BoxDecoration(
                                      color: UIGuide.light_black,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      kWidth,

                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [

                                                RichText(
                                                  overflow:
                                                  TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  strutStyle: const StrutStyle(
                                                      fontSize: 8.0),
                                                  text: TextSpan(
                                                      style: const TextStyle(
                                                        fontSize: 13,
                                                        color: UIGuide
                                                            .light_Purple,
                                                        fontWeight:
                                                        FontWeight.w500,
                                                      ),
                                                      text: provider
                                                          .staffList[
                                                      index]
                                                          .name ??
                                                          '---'),
                                                ),
                                              ],
                                            ),

                                            Row(
                                              children: [

                                                RichText(
                                                  overflow:
                                                  TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  strutStyle: const StrutStyle(
                                                      fontSize: 8.0),
                                                  text: TextSpan(
                                                    style: const TextStyle(
                                                      fontSize: 11,
                                                      fontWeight:
                                                      FontWeight.w500,
                                                      color: Colors.black,
                                                    ),
                                                    text: provider
                                                        .staffList[
                                                    index]
                                                        .designation ??
                                                        '---',
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }),
              ),
              value.loadingPage
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
        ),
      ),
    );
  }
}
