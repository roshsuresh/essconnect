import 'dart:io';
import 'package:essconnect/Application/Staff_Providers/PortionProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:essconnect/Constants.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';

import 'package:essconnect/utils/spinkit.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../../../Debouncer.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart' as path;

import '../../../Application/StudentProviders/CurriculamProviders.dart';
import '../../../utils/constants.dart';
class PortionEntryScreen extends StatefulWidget {
  PortionEntryScreen({super.key});

  @override
  State<PortionEntryScreen> createState() => _PortionEntryScreenState();
}

class _PortionEntryScreenState extends State<PortionEntryScreen> {
  final courseController = TextEditingController();
  final courseIDController = TextEditingController();
  final divisionController = TextEditingController();
  final divisionIDController = TextEditingController();
  final subjectController = TextEditingController();
  final subjectIDController = TextEditingController();
  final coursesubjectIdController = TextEditingController();
  final subSubjectController = TextEditingController();
  final subSubjectIDController = TextEditingController();
  final topicController = TextEditingController();
  final assignmentController = TextEditingController();
  final chapterController = TextEditingController();
  final detailsController = TextEditingController();
  final descriptionController = TextEditingController();

  // final List<StaffList> users=[];

  String? selectedValue;
  String filename='';
  String? optId;
  String? subsubjectId;
  List filesss=[];
  List imges=[];

  String suboroption='';







  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var p = Provider.of<PortionProvider>(context, listen: false);
      await Provider.of<
          Curriculamprovider>(
          context,
          listen: false)
          .getCuriculamAceesstoken();
      await p.setLoading(false);
      await p.clearInitial();
      await p.getPortionCourse();
      await p.timeModel();
      await p.getDateNow();
      optId='';
      subsubjectId='';


    });
  }

  List<File> _selectedFiles=[];
  List<int> _originalSizes=[];
  List<double> _reducedSizes=[];
  List<double> mutableList=[];
  double total = 0;
  double sizeiNkb=0;
  double roundedNumber=0;
  double? percent;
  double? percentConverted;
  double? roundeSize;

  String getImageNameFromPath(String imagePath) {
    return path.basename(imagePath);
  }
  Future<void> _pickFiles() async {
    setState(() {
      Provider.of<PortionProvider>(context, listen: false).setLoading(true);
    });

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg','jpeg','png','pdf'],

      //withData: true,
      allowMultiple: true,
      allowCompression: true,
    );

    if (result != null) {
      List<File> pickedFiles = result.paths.map((path) => File(path!)).toList();
      setState(() {

        _selectedFiles.addAll(pickedFiles);
        _originalSizes = List<int>.filled(_selectedFiles.length, -1);
        _reducedSizes = List<double>.filled(_selectedFiles.length, -1);
        mutableList.clear();
      });

     await _getOriginalSizes();


    }
    setState(() {
      Provider.of<PortionProvider>(context, listen: false).setLoading(false);
    });
  }

  Future<void> _getOriginalSizes() async {
    for (int i = 0; i < _selectedFiles.length; i++) {
      int fileSize = await _selectedFiles[i].length();
      setState(() {
        _originalSizes[i] = fileSize;
      });
    }
    print("selectde file");
    print(_selectedFiles);


   await _reduceFileSizes();
    print("original size");
    print(_originalSizes);

  }

  Future<void> _reduceFileSizes() async {
    for (int i = 0; i < _selectedFiles.length; i++) {
      if (_selectedFiles[i].path.toLowerCase().endsWith('.jpg') ||
          _selectedFiles[i].path.toLowerCase().endsWith('.jpeg')||
          _selectedFiles[i].path.toLowerCase().endsWith('.png')
      ) {
        img.Image image =
        img.decodeImage(_selectedFiles[i].readAsBytesSync())!;
        img.Image resizedImage = img.copyResize(image, width:1200 ,maintainAspect: true);

        File reducedFile = File('${_selectedFiles[i].path}_reduced.jpg')
          ..writeAsBytesSync(img.encodeJpg(resizedImage));

        int reducedFileSize = await reducedFile.length();
        double reducedfile =reducedFileSize/(1024 * 1024).toDouble();
        roundeSize= double.parse(reducedfile.toStringAsFixed(2));
        setState(() {
          _selectedFiles[i] = reducedFile;
          _reducedSizes[i] = roundeSize!;

         // total=0;


          // percent = roundedNumber! /5*100;
          // percentConverted=double.parse(percent!.toStringAsFixed(2));
        });
        print("reduced size");
        print(_reducedSizes);

      } else {
       _reducedSizes[i]=double.parse((_originalSizes[i]/(1024 * 1024)).toStringAsFixed(2));
      }


      mutableList.add(_reducedSizes[i]);
      print("mutable $mutableList");


      
    }
  }
  getTotal(){
    total=0;
    for (int i = 0; i < mutableList.length; i++) {
      total += mutableList[i];
    }

    roundedNumber = double.parse(total.toStringAsFixed(2));
    print("rounded $roundedNumber");
  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Consumer<PortionProvider>(
        builder: (context, value, _) => Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: ListView(
                children: [
                  kheight10,

                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      children: [

                        Expanded(
                          child: SizedBox(
                            height:40,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 3,
                                  foregroundColor: UIGuide.BLACK,
                                  backgroundColor: UIGuide.ButtonBlue,
                                  padding: const EdgeInsets.all(0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),topLeft: Radius.circular(10)),
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
                          ),
                        ),

                        Expanded(
                          child: SizedBox(
                            height: 40,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 3,
                                  foregroundColor: UIGuide.BLACK,
                                  backgroundColor: UIGuide.light_black,
                                  padding: const EdgeInsets.all(0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10)),
                                    side: const BorderSide(
                                      color: UIGuide.light_black,
                                    ),
                                  ),
                                ),
                                onPressed: () {

                                },
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
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      children: [


                        Expanded(

                          child:SizedBox(
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
                                  print("sssss");
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
                                                  value.courseList.length,
                                                  itemBuilder: (context, index) {
                                                    return ListTile(
                                                      onTap: () async {
                                                        Navigator.of(context).pop();
                                                        value.divisionList.clear();
                                                        divisionController.clear();
                                                        divisionIDController.clear();
                                                        value.subjectList.clear();
                                                        subjectController.clear();
                                                        subjectIDController.clear();
                                                        subjectIDController.clear();
                                                        value.subSubjectList.clear();
                                                        value.finalSelectedList.clear();
                                                        value.finalSelectedList.clear();


                                                        courseController.text = value
                                                            .courseList[
                                                        index]
                                                            .name ??
                                                            '--';
                                                        courseIDController
                                                            .text = value
                                                            .courseList[
                                                        index]
                                                            .tblId ??
                                                            '--';
                                                        await value.getDivisionList(courseIDController.text);
                                                      },
                                                      title: Text(
                                                        value.courseList[index]
                                                            .name ??
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
                                  controller: courseController,
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
                                    labelText: "  Select Course *",
                                    labelStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: UIGuide.BLACK,

                                    ),

                                  ),
                                  textAlign: TextAlign.center,
                                  enabled: false,
                                )),
                          ),

                        ),
                        kWidth,
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
                                                  value.divisionList.length,
                                                  itemBuilder: (context, index) {
                                                    return ListTile(
                                                      onTap: () async {
                                                        Navigator.of(context).pop();
                                                        value.subjectList.clear();
                                                        subjectController.clear();
                                                        subjectIDController.clear();
                                                        subSubjectController.clear();
                                                        subjectIDController.clear();
                                                        value.subSubjectList.clear();
                                                        value.finalSelectedList.clear();

                                                        divisionController.text = value
                                                            .divisionList[
                                                        index]
                                                            .text ??
                                                            '--';
                                                        divisionIDController
                                                            .text = value
                                                            .divisionList[
                                                        index]
                                                            .value ??
                                                            '--';
                                                        print(divisionIDController.text);
                                                        await value.getSubjectList(divisionIDController.text);
                                                      },
                                                      title: Text(
                                                        value.divisionList[index]
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
                                  controller: divisionController,
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
                                      labelText: "  Select Division *"
                                          "",
                                      labelStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: UIGuide.BLACK,
                                      )),
                                  textAlign: TextAlign.center,
                                  enabled: false,
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                  kheight5,

                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
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
                                                  value.subjectList.length,
                                                  itemBuilder: (context, index) {
                                                    return ListTile(
                                                      onTap: () async {
                                                        Navigator.of(context).pop();
                                                        value.subSubjectList.clear();
                                                        subSubjectController.clear();
                                                        subjectIDController.clear();
                                                        subjectController.text = value
                                                            .subjectList[
                                                        index]
                                                            .text ??
                                                            '--';
                                                        subjectIDController
                                                            .text = value
                                                            .subjectList[
                                                        index]
                                                            .value ??
                                                            '--';
                                                        coursesubjectIdController.text
                                                        =value.subjectList[index].courseSubjectId??'--';
                                                        print("subject");

                                                        print(coursesubjectIdController.text);
                                                        optId=  value
                                                            .subjectList[
                                                        index]
                                                            .optionSubjectId ??
                                                            '';
                                                        subsubjectId=  value
                                                            .subjectList[
                                                        index]
                                                            .subSubjectId ??
                                                            '';

                                                        value.subSubjectList.clear();


                                                        await    value.getsubSubjectList(subjectIDController.text,
                                                            subjectController.text,
                                                            value.subjectList[index].optionSubjectId.toString(),
                                                            value.subjectList[index].subSubjectId.toString(),
                                                            value.subjectList[index].courseSubjectId.toString(),
                                                            divisionIDController.text);
                                                           if(value.subjectList[index].optionSubjectId!="")
                                                             {
                                                               suboroption="option";

                                                             }
                                                       else if(value.subjectList[index].subSubjectId!="")
                                                        {
                                                          suboroption="sub";

                                                        }
                                                       else{
                                                             suboroption="";
                                                           }

                                                            // suboroption= value.subjectList[index].optionSubjectId!=""?"option":"sub";
                                                             print("suboroptionnnnnnnnnnnnnnnnnnnnnnn  $suboroption");
                                                        print(value.subSubjectList);


                                                      },
                                                      title: Text(
                                                        value.subjectList[index]
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
                                      labelText: "  Select Subject *",
                                      alignLabelWithHint: true,
                                      labelStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: UIGuide.BLACK,
                                      )),
                                  textAlign: TextAlign.center,
                                  enabled: false,
                                )),
                          ),
                        ),
                        kWidth,
                        value.subSubjectList.isNotEmpty?

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
                                                  value.subSubjectList.length,
                                                  itemBuilder: (context, index) {
                                                    return ListTile(
                                                      onTap: () async {
                                                        Navigator.of(context).pop();
                                                        value.finalSelectedList.clear();

                                                        subSubjectController.text = value
                                                            .subSubjectList[
                                                        index]
                                                            .text ??
                                                            '--';
                                                        subSubjectIDController
                                                            .text = value
                                                            .subSubjectList[
                                                        index]
                                                            .value ??
                                                            '--';


                                                        print("not subsubject");
                                                      },
                                                      title: Text(
                                                        value.subSubjectList[index]
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
                                  controller: subSubjectController,
                                  decoration:  InputDecoration(
                                      contentPadding: EdgeInsets.only(left: 5, top: 0),
                                      floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                      filled: true,
                                      fillColor: Colors.transparent,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            style: BorderStyle.none, width: 0),
                                      ),
                                      labelText:
                                      subsubjectId==""?"  Select Option *":
                                      "  Select Sub Subject *"
                                      ,
                                      alignLabelWithHint: true,
                                      labelStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: UIGuide.BLACK,
                                      )),
                                  textAlign: TextAlign.center,
                                  enabled: false,
                                )),
                          ),
                        ):
                        Expanded(
                          child: SizedBox(
                            height: 0,
                            width: 0,
                          ),
                        ),
                      ],
                    ),
                  ),


                  kheight5,
                  kheight5,
                  Text("   Select Students"),
                  Padding(
                    padding: const EdgeInsets.only(right: 4.0),
                    child: Row(
                      children: [

                        Expanded(
                          child: SizedBox(
                            height: 45,
                            child: Card(
                              //color: UIGuide.light_black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8),topLeft: Radius.circular(8)),
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
                                        ? "All"
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

                        SizedBox(
                          height: 38,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 3,
                                foregroundColor: UIGuide.BLACK,
                                backgroundColor: UIGuide.ButtonBlue,
                                padding: const EdgeInsets.all(0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(8),topRight: Radius.circular(8)),
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
                                            StudentListPortionView(
                                              divisonId: divisionIDController.text,
                                              subId: suboroption=="option"? subSubjectIDController.text:"",)));
                              },
                              child: const Icon(Icons.list_alt)),
                        )
                      ],
                    ),
                  ),


                  kheight10,
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: SizedBox(
                      height: 40,
                      child: TextFormField(
                        inputFormatters: [LengthLimitingTextInputFormatter(50)],
                        controller: chapterController,
                        minLines: 1,
                        //maxLines: 2,
                        keyboardType: TextInputType.multiline,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(12.0, 10.0, 20.0, 10.0),
                          labelText: 'Chapter *',
                          hintText: 'Enter Chapter',
                          labelStyle: TextStyle(fontWeight: FontWeight.w500,
                              color: UIGuide.BLACK,fontSize: 14),
                          hintStyle: TextStyle(color: Colors.grey),
                          helperStyle: TextStyle(color: UIGuide.light_Purple),
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
                  ),
                  kheight10,
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: SizedBox(
                      height: 40,
                      child: TextFormField(
                        inputFormatters: [LengthLimitingTextInputFormatter(50)],
                        controller: topicController,
                        minLines: 1,
                        // maxLines: 2,
                        keyboardType: TextInputType.multiline,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(12.0, 10.0, 20.0, 10.0),
                          labelText: 'Topic',
                          hintText: 'Enter Topic',
                          labelStyle: TextStyle(fontWeight: FontWeight.w500,
                              color: UIGuide.BLACK,fontSize: 14),
                          hintStyle: TextStyle(color: Colors.grey),
                          helperStyle: TextStyle(color: UIGuide.light_Purple),
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
                  ),
                  kheight10,
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: SizedBox(
                      height: 40,
                      child: TextFormField(

                        inputFormatters: [LengthLimitingTextInputFormatter(200)],
                        controller: descriptionController,
                        minLines: 1,
                        //  maxLines: 2,
                        keyboardType: TextInputType.multiline,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(12.0, 10.0, 20.0, 10.0),
                          labelText: 'Description',
                          hintText: 'Enter Description',
                          labelStyle: TextStyle(fontWeight: FontWeight.w500,
                              color: UIGuide.BLACK,fontSize: 14),
                          hintStyle: TextStyle(color: Colors.grey,),
                          alignLabelWithHint: false,
                          helperStyle: TextStyle(color: UIGuide.light_Purple),
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
                  ),
                  kheight10,

                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: LimitedBox(
                      maxHeight: 180,
                      child: TextFormField(
                        inputFormatters: [LengthLimitingTextInputFormatter(500)],
                        controller:detailsController ,
                        minLines: 1,
                        maxLines: 15,
                        keyboardType: TextInputType.multiline,
                        decoration: const InputDecoration(
                          labelText: 'Details *',
                          hintText: 'Enter Details',
                          labelStyle: TextStyle(fontWeight: FontWeight.w500,
                              color: UIGuide.BLACK,fontSize: 14),
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
                  ),
                  kheight10,
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: LimitedBox(
                      maxHeight: 60,
                      child: TextFormField(
                        inputFormatters: [LengthLimitingTextInputFormatter(200)],
                        controller: assignmentController,
                        minLines: 1,
                        maxLines: 2,
                        keyboardType: TextInputType.multiline,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(12.0, 10.0, 20.0, 10.0),
                          labelText: 'Assignment',
                          hintText: 'Enter Assignment',
                          labelStyle: TextStyle(fontWeight: FontWeight.w500,
                              color: UIGuide.BLACK,fontSize: 14),
                          hintStyle: TextStyle(color: Colors.grey),
                          helperStyle: TextStyle(color: UIGuide.light_Purple),
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
                  ),
                  kheight10,

                  Padding(
                    padding: const EdgeInsets.only(left: 30.0),
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Attachment:  ",style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),),
                        SizedBox(
                          width: size.width*0.40,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 3,
                              foregroundColor: UIGuide.light_Purple,
                              backgroundColor: Colors.white70,
                              padding: const EdgeInsets.all(0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: const BorderSide(
                                    color: UIGuide.light_black,
                                  )),
                            ),
                            onPressed: (() async {
                              value.loading?null:


                              await _pickFiles();


                              filesss.clear();
                              imges.clear();
                              for (int i = 0; i < _selectedFiles.length; i++) {

                                await value.portionfileSave(
                                    context, _selectedFiles[i].path.toString());

                                filesss.add(
                                    {
                                      "fileId": value.imageid,
                                      "fileorder": i,
                                      //"filename": getImageNameFromPath(_selectedFiles[i].path)
                                    }
                                );
                               imges.add(value.imageid);
                              }

                              await getTotal();

                              print("fileeeee  $filesss");
                              print("imggg $imges");
                              // ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                              //   elevation: 10,
                              //   shape: RoundedRectangleBorder(
                              //     borderRadius: BorderRadius.all(Radius.circular(20)),
                              //   ),
                              //   duration: Duration(seconds: 1),
                              //   margin: EdgeInsets.only(bottom: 80, left: 30, right: 30),
                              //   behavior: SnackBarBehavior.floating,
                              //   content:
                              //   filesss.isNotEmpty?
                              //       roundedNumber<=5?
                              //   Text(
                              //     'Files added...',
                              //     textAlign: TextAlign.center,
                              //   ):Text(
                              //         'File Size Exeeded...',
                              //         textAlign: TextAlign.center,
                              //       ):
                              //   Text(
                              //     'No Files added...',
                              //     textAlign: TextAlign.center,
                              //   )
                              //   ,
                              // )
                              // );

                              Fluttertoast.showToast(
                                msg: filesss.isNotEmpty?
                                roundedNumber<=5?
                                'Files added...'

                                :
                                'File Size Exeeded...'

                                :
                                'No Files added...',



                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black54,
                                textColor: Colors.white,
                                fontSize: 14.0,
                              );

                            }),
                            child:
                            Text(_selectedFiles.isEmpty?"Choose File": "${
                                _selectedFiles.length} files selected",
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),

                        filesss.isNotEmpty?


                            Text(" ${roundedNumber==null?0:roundedNumber} MB"):
                            Text(""),

                      ],
                    ),
                  ),
                  kheight5,

                  Row(
                 mainAxisAlignment:  MainAxisAlignment.center,
                    children: [
                      Center(child:
                      Text("(Allowed Size is 5MB)"),),


                    ],
                  ),
                  kheight5,
                  _selectedFiles.isNotEmpty && mutableList.isNotEmpty?
                  Container(
                    color: UIGuide.light_Purple,
                    child: Column(
                          children: [
                            Table(
                              columnWidths: const {
                                0: FlexColumnWidth(0.5),
                                1: FlexColumnWidth(2),
                                2: FlexColumnWidth(0.8),
                                3: FlexColumnWidth(0.5),
                              },
                              border: TableBorder.all(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10)),
                                  color: const Color.fromARGB(
                                      255, 248, 248, 248)),
                              children: const [
                                TableRow(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10)),
                                      color:UIGuide.THEME_LIGHT
                                      //Color.fromARGB(255, 197, 110, 110),
                                    ),
                                    children: [
                                      TableCell(
                                        verticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                        child: Text(
                                          'Sl No',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      TableCell(
                                        verticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            top: 6.0,
                                            bottom: 6,
                                          ),
                                          child: Text(
                                            'Name',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      TableCell(
                                        verticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                        child: Text(
                                          'Size',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      TableCell(
                                        verticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                        child: Text(
                                          'Delete',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),

                                    ])
                              ],
                            ),
                          ],
                        ),
                  ):
                  SizedBox(height: 0,width: 0,)
                  ,



                  //kheight5,
                  value.loading?
                      SizedBox(
                        height: 0,
                          width: 0,
                      ):
                  _selectedFiles.isNotEmpty && mutableList.isNotEmpty?
                SizedBox(
                  height: 120,
                  child: ListView.builder(
                    itemCount: _selectedFiles.length,
                    itemBuilder: (context, index) {
                     return Table(
                       columnWidths: const {
                         0: FlexColumnWidth(0.5),
                         1: FlexColumnWidth(2),
                         2: FlexColumnWidth(0.8),
                         3: FlexColumnWidth(0.5),
                       },
                       border: TableBorder.all(
                           borderRadius: BorderRadius.only(
                               topLeft: Radius.circular(10),
                               topRight: Radius.circular(10)),
                           color: const Color.fromARGB(
                               255, 248, 248, 248)),
                       children:  [
                         TableRow(
                             decoration: BoxDecoration(
                               borderRadius: BorderRadius.only(
                                   topLeft: Radius.circular(10),
                                   topRight: Radius.circular(10)),
                               color:
                                 UIGuide.THEME_LIGHT,
                               //Color.fromARGB(255, 223, 223, 223),
                             ),
                             children: [
                               TableCell(
                                 verticalAlignment:
                                 TableCellVerticalAlignment.middle,
                                 child: Text(
                                   "${index+1}",
                                   style: TextStyle(
                                       fontWeight: FontWeight.w400),
                                   textAlign: TextAlign.center,
                                 ),
                               ),
                               TableCell(
                                 verticalAlignment:
                                 TableCellVerticalAlignment.middle,
                                 child: Padding(
                                   padding: EdgeInsets.only(
                                     top: 6.0,
                                     bottom: 6,
                                   ),
                                   child: Text(
                                     (getImageNameFromPath( _selectedFiles[index].path)),
                                     style: TextStyle(
                                         fontWeight: FontWeight.w400),
                                     textAlign: TextAlign.center,
                                   ),
                                 ),
                               ),
                               TableCell(
                                 verticalAlignment:
                                 TableCellVerticalAlignment.middle,
                                 child: Text(
                                   "${mutableList[index].toString()} MB",
                                   style: TextStyle(
                                       fontWeight: FontWeight.w400),
                                   textAlign: TextAlign.center,
                                 ),
                               ),
                               TableCell(
                                 verticalAlignment:
                                 TableCellVerticalAlignment.middle,
                                 child:  InkWell(
                                   onTap: () async{

                                     await _selectedFiles.removeAt(index);
                                    await mutableList.removeAt(index);
                                    await filesss.removeAt(index);
                                   await value.portionfileDelete(imges[index]);
                                   if(value.dltstatus==204){

                                     ScaffoldMessenger.of(context).showSnackBar( const SnackBar(
                                       elevation: 10,
                                       shape: RoundedRectangleBorder(
                                         borderRadius: BorderRadius.all(Radius.circular(20)),
                                       ),
                                       duration: Duration(seconds: 1),
                                       margin: EdgeInsets.only(bottom: 80, left: 30, right: 30),
                                       behavior: SnackBarBehavior.floating,
                                       content: Text(
                                         'File Deleted...',
                                         textAlign: TextAlign.center,
                                       ),
                                     ));

                                   }
                                   // else{ScaffoldMessenger.of(context).showSnackBar( const SnackBar(
                                   //   elevation: 10,
                                   //   shape: RoundedRectangleBorder(
                                   //     borderRadius: BorderRadius.all(Radius.circular(20)),
                                   //   ),
                                   //   duration: Duration(seconds: 1),
                                   //   margin: EdgeInsets.only(bottom: 80, left: 30, right: 30),
                                   //   behavior: SnackBarBehavior.floating,
                                   //   content: Text(
                                   //     'Something went wrong...',
                                   //     textAlign: TextAlign.center,
                                   //   ),
                                   // ));}
                                    await getTotal();
                                     print("mutablelast $mutableList");

                                 print("rrrrr $roundedNumber");
                                   },
                                   child: Icon(Icons.delete_forever_outlined,color: UIGuide.button2),
                                 ),
                               ),

                             ])
                       ],
                     );
                      // print(_selectedFiles[0].path);
                      // return Column(
                      //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //
                      //  children: [
                      //    Row(
                      //      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //      children: [
                      //        Text("${index+1}"),
                      //        SizedBox(
                      //            width:size.width*0.5,
                      //            child: Text(getImageNameFromPath( _selectedFiles[index].path))),
                      //        Text("${mutableList[index].toString()} MB"),
                      //
                      //
                      //        Row(
                      //          mainAxisAlignment: MainAxisAlignment.end,
                      //          children: [
                      //             // InkWell(
                      //             //   onTap: (){},
                      //             //   child: Icon(Icons.upload,color: UIGuide.button1,),
                      //             // ),
                      //            InkWell(
                      //              onTap: () async{
                      //
                      //                await _selectedFiles.removeAt(index);
                      //               await mutableList.removeAt(index);
                      //               await filesss.removeAt(index);
                      //             //  await value.portionfileDelete(context,value.imagess[index]);
                      //               await getTotal();
                      //                print("mutablelast $mutableList");
                      //
                      //            print("rrrrr $roundedNumber");
                      //              },
                      //              child: Icon(Icons.delete_forever_outlined,color: UIGuide.button2),
                      //            ),
                      //          ],
                      //        ),
                      //
                      //      ],
                      //    )
                      //  ],
                      // );
                    },
                  ),
                ):
                  SizedBox(height: 0,width: 0,)
                  ,

                  // filesss.isNotEmpty?
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Center(
                  //       child:LinearPercentIndicator(
                  //           width: size.width*0.5,
                  //           lineHeight: 14.0,
                  //           percent: sizeiNkb/5,
                  //           center: Text(
                  //             "$percentConverted %",
                  //             style: TextStyle(fontSize: 12.0,
                  //
                  //             ),
                  //
                  //
                  //           ),
                  //           animation: true,
                  //           animationDuration: 1000,
                  //           barRadius: Radius.circular(10),
                  //           backgroundColor: Colors.black12,
                  //           progressColor: UIGuide.light_Purple
                  //       ),
                  //     ),
                  //   ],
                  // ):Text(""),
                  kheight20,
                ],
              ),
            ),
            if (value.loading) pleaseWaitLoader()
          ],
        ),
      ),
      bottomNavigationBar: Consumer<PortionProvider>
        (builder: (context, value, child)

      =>
          Stack(
            children: [
              BottomAppBar(
                child:   Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: size.width*0.30,
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
                            print("subbbbbbbbbbbbbbb  $suboroption");


                            if (
                            courseIDController.text.trim().isEmpty ||
                                divisionIDController.text.trim().isEmpty ||
                                subjectIDController.text.trim().isEmpty ||
                                chapterController.text.trim().isEmpty||
                                detailsController.text.trim().isEmpty||
                            (suboroption!=""
                                &&subSubjectIDController.text.trim().isEmpty )

                            ) {

                              Fluttertoast.showToast(
                                msg:"Select Mandatory Fields..",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black54,
                                textColor: Colors.white,
                                fontSize: 14.0,
                              );
                            //  if(suboroption=="option"||suboroption=="sub"){
                            //   if(subSubjectIDController.text.trim().isEmpty) {
                            //     Fluttertoast.showToast(
                            //       msg: "Select Mandatory Fields...",
                            //       toastLength: Toast.LENGTH_SHORT,
                            //       gravity: ToastGravity.BOTTOM,
                            //       timeInSecForIosWeb: 1,
                            //       backgroundColor: Colors.black54,
                            //       textColor: Colors.white,
                            //       fontSize: 14.0,
                            //     );
                            //   }
                            //
                            // }

                            }



                            else if(roundedNumber>=5){
                              Fluttertoast.showToast(
                                msg:"File Size Exceed..",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black54,
                                textColor: Colors.white,
                                fontSize: 14.0,
                              );
                            }
                            else {
                              print("ddddnoooo");
                              print(roundedNumber);

                              await value.portionsend(
                                  context,
                                  value.fromdateSend,
                                  courseIDController.text,
                                  divisionIDController.text,
                                  coursesubjectIdController.text,
                                  subSubjectIDController.text ,
                                  suboroption=="option"? "O":"S",
                                  chapterController.text,
                                  topicController.text,
                                  descriptionController.text,
                                  detailsController.text,
                                  assignmentController.text,
                                  value.finalSelectedList,
                                  filesss);


                              await value.portionsendNotification(
                                  value.fromdateSend,
                                  courseIDController.text,
                                  divisionIDController.text,
                                  coursesubjectIdController.text,
                                  subSubjectIDController.text,
                                  suboroption=="option"? "O":"S",
                                  chapterController.text,
                                  topicController.text,
                                  descriptionController.text,
                                  detailsController.text,
                                  assignmentController.text,
                                  value.finalSelectedList,
                                  filesss);



                              // value.showToGuardian==true?
                              // await Provider.of<NotificationToGuardian_Providers>(context,
                              //     listen: false)
                              //     .sendCommonNotification(context,
                              //     courseController.text,
                              //     descriptionController.text,
                              //     value.finalSelectedList,
                              //     sentTo: "Student"):"";

                              if(value.status==200) {
                                _selectedFiles.clear();
                                filesss.clear();
                                courseController.clear();
                                courseIDController.clear();
                                divisionController.clear();
                                divisionIDController.clear();
                                subjectIDController.clear();
                                subjectController.clear();
                                subSubjectIDController.clear();
                                subSubjectController.clear();
                                descriptionController.clear();
                                value.finalSelectedList.clear();
                                chapterController.clear();
                                assignmentController.clear();
                                topicController.clear();
                                descriptionController.clear();
                                detailsController.clear();
                              }
                            }
                          },
                          child: const Text("Save")),
                    ),
                    //if (value.loading) pleaseWaitLoader()
                  ],
                ),
              ),

              if (value.loading)
                Positioned.fill(
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      color: Colors.transparent,
                    ),
                  ),
                ),
            ],
          ),
      ),

    );
  }
}

class StudentListPortionView extends StatefulWidget {
  StudentListPortionView({super.key,this.courseId,this.divisonId,this.subId});
  String? courseId;
  String? divisonId;
  String? subId;
  @override
  State<StudentListPortionView> createState() =>
      _StudentListPortionViewState();
}

class _StudentListPortionViewState extends State<StudentListPortionView> {
  final ScrollController _scrollController = ScrollController();

  final controller = TextEditingController();
  final _debouncer = Debouncer(milliseconds: 1000);
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      _scrollController.addListener(_scrollListener);
      var p = Provider.of<PortionProvider>(context, listen: false);
      await p.setLoading(false);
      p.studentViewList.clear();
      p.currentPage=2;
      await p.getStudentViewList(widget.divisonId! ,widget.subId!);
      p.allSelected = false;


    });
  }

  void _scrollListener() async {
    final provider =
    Provider.of<PortionProvider>(context, listen: false);
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (provider.hasMoreData()) {
        print("object");

        await provider.getStudentViewByPagination(widget.divisonId!,widget.subId!);
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
      body: Consumer<PortionProvider>(
        builder: (context, value, _) => Stack(
          children: [
            Column(
              children: [
                kheight5,
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: TextField(
                            focusNode: FocusNode(),
                            enabled: value.allSelected==true?false:true,

                            controller: controller,
                            onChanged: (value1) {
                              _debouncer.run(() async {
                                await Provider.of<PortionProvider>(context,
                                    listen: false)
                                    .clearStudentList();
                                value.currentPage=2;
                                await Provider.of<PortionProvider>(context,
                                    listen: false)
                                    .getPortionListbyName(value1,widget.divisonId!,widget.subId!);
                                print('-***--**-*-*-*-*-');
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

                                      await Provider.of<PortionProvider>(context,
                                          listen: false)
                                          .clearStudentList();
                                      value.currentPage=2;
                                      await Provider.of<PortionProvider>(context,
                                          listen: false)
                                          .getPortionListbyName('',widget.divisonId!,widget.subId!);

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
                                  widget.divisonId!,widget.subId!);
                              controller.clear();
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
                      await value.selectAll(widget.divisonId!,widget.subId!);
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
                value.loading
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
      bottomNavigationBar: Consumer<PortionProvider>(
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



