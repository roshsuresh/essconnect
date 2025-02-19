
import 'package:essconnect/Application/Staff_Providers/Anecdotal/AnecdotalStaffListProvider.dart';
import 'package:essconnect/Constants.dart';
import 'package:essconnect/Domain/Staff/Anecdotal/InitialSelectionModel.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:essconnect/utils/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:provider/provider.dart';
import '../../../../Application/Staff_Providers/Anecdotal/AncedotalStaffProvider.dart';
import '../../../../Debouncer.dart';
import '../../../../Domain/Staff/Anecdotal/StudListviewAnectdotal.dart';
import 'AnecdotalInitialScreen.dart';
class AnecdotalEditScreen extends StatefulWidget {
  String id;
  AnecdotalEditScreen({super.key,required this.id});

  @override
  State<AnecdotalEditScreen> createState() => _AnecdotalEditScreenState();
}

class _AnecdotalEditScreenState extends State<AnecdotalEditScreen> {
  final categoryController = TextEditingController();

  final categoryIDController = TextEditingController();

  final subjectController = TextEditingController();

  final subjectIDController = TextEditingController();
  final List<StaffList> users=[];
  final remarkController = TextEditingController();
  String? selectedValue;
  String staffname='';
  String staffId='';

  String formattedDate='';
  String formattedDateSend='';
  String time='';
  String? userId;
  bool? showgaurdian;
  bool important=false;
  String dateTodisplay='';

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {

      var p = Provider.of<AnecdotalStaffListProviders>(context, listen: false);

      await p.setLoading(false);
      await p.clearInitial();
      await p.getInitialRow(widget.id);
      await p.getId();
      time=p.time.toString();
      remarkController.text=p.remarks.toString();
      categoryController.text =p.category.toString();
      categoryIDController.text =p.categoryId.toString();
      subjectController.text = p.subject.toString();
      subjectIDController.text = p.subjectId.toString();
      remarkController.text =p.remarks.toString();

      DateTime originalDate = DateTime.parse(p.date.toString());
      DateFormat formatter = DateFormat('dd-MM-yyyy');
      DateFormat sendformatter = DateFormat('yyyy-MM-dd');
      formattedDateSend = sendformatter.format(originalDate);
      formattedDate = formatter.format(originalDate);
      p.dateDisplay=formattedDate;
      p.dateSend =formattedDateSend;


      print("daaaaaaaaa");
      print(p.dateDisplay);
      Provider.of<AnecdotalStaffProviders>(context, listen: false).staffname='';
      staffname= p.staffName.toString();
      staffId =p.staffid.toString();
      userId =p.userId;




      // c.isimportantCheckbox();
      // c.isShownToGuardian();
      // c.isImportant;
      // c.showToGuardian;




    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: UIGuide.light_Purple,
        title:Row(
          children: [
            const Spacer(),
            const Text('Anecdotal'),
            const Spacer(),
            IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                          const AnecdotalInitialScreen()));
                },
                icon: const Icon(Icons.refresh))
          ],
        ),
      ),
      body: Consumer<AnecdotalStaffListProviders>(
        builder: (context, value, _) => Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: ListView(

                children: [
                  kheight10,

                  SizedBox(
                    height: 45,
                    child: Card(
                      color: Colors.white60,
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
                            "${value.admNo} , ${value.name}",
                            style: const TextStyle(
                                color: UIGuide.BLACK,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                  ),
                  kheight20,

                  SizedBox(
                    height: 40,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 3,
                          foregroundColor: UIGuide.BLACK,
                          backgroundColor:  value.createdStaffid!= userId?
                          Colors.white60:
                          UIGuide.ButtonBlue,
                          padding: const EdgeInsets.all(0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(
                                color: UIGuide.light_black,
                              )),
                        ),
                        onPressed: () {
                          print(userId);

                          value.createdStaffid!= userId?
                              null:
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
                                                   value.category.toString();
                                                categoryIDController
                                                    .text = value
                                                    .remarksCategoryList[
                                                index]
                                                    .value ??
                                                   value.categoryId.toString();
                                              },
                                              title: Text(
                                                value.remarksCategoryList[index]
                                                    .text ??
                                                    value.category.toString(),
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
                          decoration:  InputDecoration(
                              contentPadding: const EdgeInsets.only(left: 15, top: 0),
                              floatingLabelBehavior:
                              FloatingLabelBehavior.never,
                              filled: true,
                              fillColor: Colors.transparent,
                              border: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    style: BorderStyle.none, width: 0),
                              ),
                              labelText:  value.category.toString(),
                              labelStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: UIGuide.BLACK,
                              )),
                          enabled: false,
                          // onChanged: (value1){
                          //   value1=categoryIDController.text;
                          //   value.categoryId = value1;
                          // },
                        )),
                  ),
                  kheight20,

                  SizedBox(
                    height: 40,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 3,
                          foregroundColor: UIGuide.BLACK,
                          backgroundColor: value.createdStaffid!= userId?
                          Colors.white60:
                          UIGuide.ButtonBlue,
                          padding: const EdgeInsets.all(0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(
                                color: UIGuide.light_black,
                              )),
                        ),
                        onPressed: () {
                          value.createdStaffid!= userId?
                              null:
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
                                                    value.subject.toString();
                                                subjectIDController.text = value
                                                    .dairySubjectList[index]
                                                    .value ??
                                                    value.subjectId.toString();

                                              },
                                              title: Text(
                                                value.dairySubjectList[index]
                                                    .text ??
                                                   value.subject.toString(),
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
                          decoration:  InputDecoration(
                              contentPadding: const EdgeInsets.only(left: 15 ,top: 0),
                              floatingLabelBehavior:
                              FloatingLabelBehavior.never,
                              filled: true,
                              fillColor: Colors.transparent,
                              border: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    style: BorderStyle.none, width: 0),
                              ),
                              labelText: " ${value.subject==null||value.subject==''?"Select Subject":value.subject.toString()}",

                              labelStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: UIGuide.BLACK,

                              )),
                          enabled: false,
                        )
                    ),
                  ),
                  kheight20,
                  Consumer<AnecdotalStaffProviders>(
                    builder: (context, snap, _)=>
                        Row(
                          children: [
                            Expanded(
                              child:

                              SizedBox(
                                height: 45,
                                child: Card(
                               color: value.createdStaffid!= userId?
                               Colors.white60:
                               Colors.white,
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
                                        snap.staffname==''?
                                        staffname: snap.staffname,
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
                                      backgroundColor: value.createdStaffid!= userId?
                                      Colors.white60:
                                      UIGuide.ButtonBlue,
                                      padding: const EdgeInsets.all(0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        side: const BorderSide(
                                          color: UIGuide.light_black,
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      value.createdStaffid!= userId?null:
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=> StaffSelection(staffId: snap.staffname)));
                                      print(snap.staffname);


                                    },
                                    child: const Icon(Icons.list_alt)
                                )

                            ),

                          ],
                        ),
                  ),
                  kheight10,

                      Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            width: size.width / 2.5,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 3,
                                  foregroundColor: UIGuide.BLACK,
                                  backgroundColor: value.createdStaffid!= userId?
                                  Colors.white60:
                                  UIGuide.ButtonBlue,
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
                                      const Icon(
                                        Icons.schedule_outlined,
                                        color: Colors.grey,
                                      ),
                                      kWidth,
                                      Text(
                                        time,

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
                                backgroundColor:
                                value.createdStaffid!= userId?
                                Colors.white60:
                                UIGuide.ButtonBlue,
                                padding: const EdgeInsets.all(0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: const BorderSide(
                                      color: UIGuide.light_black,
                                    )),
                              ),
                              onPressed: () {
                                value.createdStaffid!= userId?null:
                                value.getDate(context);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Icon(
                                    Icons.calendar_month_outlined,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  // Text("Date: "),
                                  Text(value.dateDisplay==''?
                                  value.dateSend:value.dateDisplay),
                                  kWidth,
                                  const SizedBox(
                                    width: 5,
                                  ),
                                ],
                              )),
                        )
                      ],
                    ),

                  kheight20,
                  value.createdStaffid!= userId?
                  LimitedBox(
                    maxHeight: 180,
                    child: TextFormField(
                      controller: remarkController,
                    maxLines: 3,



                    decoration: const InputDecoration(
                      filled: true,


                      fillColor:Colors.black12,
                      labelStyle: TextStyle(

                          color: Colors.black54
                      ),
                      labelText: 'Remarks'

                    ),
                    enabled: false,
                    style: const TextStyle(

                        color: UIGuide.BLACK,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  ):
                  LimitedBox(
                    maxHeight: 180,
                    child: TextFormField(
                      inputFormatters: [LengthLimitingTextInputFormatter(200),
                        FilteringTextInputFormatter.deny(RegExp(r'^\s')),
                      ],
                      controller: remarkController,
                      minLines: 1,
                      maxLines: 15,
                      keyboardType: TextInputType.multiline,
                      decoration:  const InputDecoration(
                        labelText: 'Remarks',
                        hintText: 'Enter Remarks',

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
                  // value.createdStaffid!=staffId?
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: Row(
                  //         children: [
                  //           Checkbox(
                  //             activeColor: UIGuide.light_Purple,
                  //             value: value.isimportant,
                  //             onChanged: (newValue) async {
                  //               // // value.isimportantCheckbox();
                  //               // print(value.isimportant);
                  //             },
                  //           ),
                  //           const Expanded(
                  //             //  width: size.width * .35,
                  //             child: Text(
                  //               "Is Important Entry",
                  //               maxLines: 2,
                  //               overflow: TextOverflow.ellipsis,
                  //               style: TextStyle(
                  //                   color: UIGuide.BLACK, fontSize: 12),
                  //             ),
                  //           )
                  //         ],
                  //       ),
                  //     ),
                  //     // kWidth,
                  //     Expanded(
                  //       child: Row(
                  //         children: [
                  //           Checkbox(
                  //             activeColor: UIGuide.light_Purple,
                  //             value: value.showGuardian,
                  //             onChanged: (newValue) async {
                  //              // value.isShownToGuardian();
                  //
                  //             },
                  //           ),
                  //           const Expanded(
                  //             //  width: size.width * .35,
                  //             child: Text(
                  //               "Show In Guardian Login",
                  //               maxLines: 2,
                  //               overflow: TextOverflow.ellipsis,
                  //               style: TextStyle(
                  //                   color: UIGuide.BLACK, fontSize: 12),
                  //             ),
                  //           )
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  // ):

                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                            onTap: () async {
                              value.createdStaffid== userId?
                              value.isimportantCheckbox():
                              null;
                            },
                            child: Row(
                              children: [
                                Checkbox(
                                  activeColor: UIGuide.light_Purple,
                                  value: value.isimportant,
                                  onChanged: (newValue) async {
                                    value.createdStaffid== userId?
                                      value.isimportantCheckbox():
                                   null;


                                    print(value.isimportant);
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
                              value.createdStaffid== userId?
                              value.isShownToGuardian():
                                  null;
                            },
                            child: Row(
                              children: [
                                Checkbox(
                                  activeColor: UIGuide.light_Purple,
                                  value: value.showGuardian,
                                  onChanged: (newValue) async {
                                    value.createdStaffid== userId?
                                    value.isShownToGuardian():
                                    null;

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
                  value.createdStaffid!= userId?
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 150,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 3,
                                  foregroundColor: UIGuide.WHITE,
                                  backgroundColor: Colors.grey,
                                  padding: const EdgeInsets.all(0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: const BorderSide(
                                        color: UIGuide.light_black,
                                      )),
                                ),
                                onPressed: () async {
                                },
                                child: const Text("Update",style: TextStyle(
                                  color: Colors.black
                                ),)),
                          ),
                        ],
                      ):
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

                              if(remarkController.text.isEmpty){
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
                                      'Enter mandatory fields..!',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                );
                              }



                                else {
                                  await value.updateAnecdotal(
                                      widget.id,
                                      categoryIDController.text,
                                      subjectIDController.text,
                                      remarkController.text,
                                      value.studId.toString(),
                                      Provider
                                          .of<AnecdotalStaffProviders>(context,
                                          listen: false)
                                          .staffId == '' ? staffId :
                                      Provider
                                          .of<AnecdotalStaffProviders>(context,
                                          listen: false)
                                          .staffId,
                                      context);
                                  value.status==200?
                                  value.showGuardian==true?
                                  await value.sendanecdotalUpdateNotiication(
                                      widget.id,
                                      categoryIDController.text,
                                      subjectIDController.text,
                                      remarkController.text,
                                      value.studId.toString(),
                                      value.studId.toString(),
                                      Provider
                                          .of<AnecdotalStaffProviders>(context,
                                          listen: false)
                                          .staffId == '' ? staffId :
                                      Provider
                                          .of<AnecdotalStaffProviders>(context,
                                          listen: false)
                                          .staffId,
                                      context)
                                     :
                                  print("not send"):
                                  print("error");
                                 // if(value.status==200){
                                 //
                                 //  await Navigator.pushReplacement(context,
                                 //      MaterialPageRoute(builder: (context) =>
                                 //          AnecdotalInitialScreen()));
                                 //  }

                              }

                            },
                            child: const Text("Update")),
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
  TextEditingController searchController=TextEditingController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      _scrollController.addListener(_scrollListener);
      var p = Provider.of<AnecdotalStaffProviders>(context, listen: false);
      await p.setLoading(false);
      await p.clearAllDetails();
      await p.getStudentViewList(section, course, division,searchController.text);
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
                             value.currentPage = 0;
                              await value.getStudentViewList(
                                  section, course, division,searchController.text);
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
                      child: SizedBox(height: 25),
                    ),
                    kWidth,
                    Expanded(
                      child: Hero(
                        tag: "tagSelect",
                        child: SizedBox(
                          height: 35,
                          child: InkWell(
                            onTap: () async {
                              await value.selectAll(
                                  section, course, division,searchController.text);
                              // await value.getSelectAllStudents(
                              //     section, course, division);
                            },
                            child: Card(
                              elevation: 5,
                              child:
                              //  value.allSelected == true
                              //     ? Row(
                              //         mainAxisSize: MainAxisSize.min,
                              //         mainAxisAlignment: MainAxisAlignment.center,
                              //         children: [
                              //           Text(
                              //             ' ${value.allStudentID.length} ',
                              //             style: const TextStyle(
                              //                 color: UIGuide.light_Purple,
                              //                 fontWeight: FontWeight.w600),
                              //           ),
                              //           Text(" Students selected  "),
                              //         ],
                              //       )
                              //     :
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
                      await value.selectAll(section, course, division,searchController.text);
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
        body: Column(
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
                          hintText: 'Search by name',
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
          ],
        ),
      ),
    );
  }
}
