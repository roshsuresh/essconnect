import 'dart:convert';


import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Constants.dart';
import '../../Domain/Admin/Birthday/BirthdayListModel.dart';
import '../../Presentation/Admin/Communication/ToGuardian.dart';
import '../../utils/constants.dart';
import '../../utils/spinkit.dart';
import '../Staff_Providers/Notification_ToGuardianProvider.dart';

class BirthdayListProviders with ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  clearList() {
    studentBirthdayList.clear();
    classStudentBirthList.clear();
    staffBirthdayList.clear();
    notifyListeners();
  }

  List<StudentBirthdayList> studentBirthdayList = [];
  List<StudentBirthdayList> classStudentBirthList = [];
  List<StaffBirthdayList> staffBirthdayList = [];
  Future getBirthdayList() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };

    try {
      var response = await http.get(
          Uri.parse("${UIGuide.baseURL}/mobileapp/staffdet/birthday_list"),
          headers: headers);

      if (response.statusCode == 200) {
        final data = await json.decode(response.body);
        final stl = data['birthdayList'];

        List<StudentBirthdayList> templist = List<StudentBirthdayList>.from(
            stl["studentBirthdayList"]
                .map((x) => StudentBirthdayList.fromJson(x)));
        studentBirthdayList.addAll(templist);

        List<StudentBirthdayList> templist1 = List<StudentBirthdayList>.from(
            stl["birthdayListforClassTeacher"]
                .map((x) => StudentBirthdayList.fromJson(x)));
        classStudentBirthList.addAll(templist1);

        List<StaffBirthdayList> templist2 = List<StaffBirthdayList>.from(
            stl["staffBirthdayList"].map((x) => StaffBirthdayList.fromJson(x)));
        staffBirthdayList.addAll(templist2);

        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        print("Error in BirthdayList response");
      }
    } catch (e) {
      setLoading(false);
      print(e);
      print("Error in BirthdayList response");
    }
  }

  void selectItem(StudentBirthdayList model) {
    StudentBirthdayList selected = studentBirthdayList
        .firstWhere((element) => element.studentId == model.studentId);
    selected.selectedStud ??= false;
    selected.selectedStud = !selected.selectedStud!;
    print(selected.toJson());

    notifyListeners();
  }

  void selectStudByClass(StudentBirthdayList model) {
    StudentBirthdayList selected = classStudentBirthList
        .firstWhere((element) => element.studentId == model.studentId);
    selected.selectedStud ??= false;
    selected.selectedStud = !selected.selectedStud!;
    print(selected.toJson());

    notifyListeners();
  }

  List<StudentBirthdayList> selectedStudList = [];
  submitStudent(BuildContext context) {
    selectedStudList.clear();
    if (toggleVal == 'classTeacher') {
      selectedStudList = classStudentBirthList
          .where((element) => element.selectedStud == true)
          .toList();
    } else {
      selectedStudList = studentBirthdayList
          .where((element) => element.selectedStud == true)
          .toList();
    }
    if (selectedStudList.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        duration: Duration(seconds: 1),
        margin: EdgeInsets.only(bottom: 80, left: 30, right: 30),
        behavior: SnackBarBehavior.floating,
        content: Text(
          'Select any student...',
          textAlign: TextAlign.center,
        ),
      ));
    } else {
      print('selected.....');
      print(studentBirthdayList
          .where((element) => element.selectedStud == true)
          .toList());
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Text_Matter_BirthdayNotificationAdmin(
              toList: selectedStudList.map((e) => e.studentId!).toList(),
              type: "Student",
            ),
          ));
    }
  }

  // Staff notification

  void selectStaff(StaffBirthdayList model) {
    StaffBirthdayList selected = staffBirthdayList
        .firstWhere((element) => element.staffId == model.staffId);
    selected.selectedStaff ??= false;
    selected.selectedStaff = !selected.selectedStaff!;
    print(selected.toJson());

    notifyListeners();
  }

  List<StaffBirthdayList> selectedStaffList = [];
  submitStaff(BuildContext context) {
    selectedStaffList.clear();
    selectedStaffList = staffBirthdayList
        .where((element) => element.selectedStaff == true)
        .toList();
    if (selectedStaffList.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        duration: Duration(seconds: 1),
        margin: EdgeInsets.only(bottom: 80, left: 30, right: 30),
        behavior: SnackBarBehavior.floating,
        content: Text(
          'Select any staff...',
          textAlign: TextAlign.center,
        ),
      ));
    }
    //
    else {
      print('selected.....');
      print(staffBirthdayList
          .where((element) => element.selectedStaff == true)
          .toList());
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Text_Matter_BirthdayStaffNotificationAdmin(
            toList: selectedStaffList.map((e) => e.staffId!).toList(),
            type: "Staff",
          ),
        ),
      );
    }
  }

  String toggleVal = 'all';
  int indval = 0;
  onToggleChanged(int ind) {
    if (ind == 0) {
      toggleVal = 'all';
      indval = ind;
      print(toggleVal);
      notifyListeners();
    } else {
      toggleVal = 'classTeacher';
      print(toggleVal);
      indval = ind;
      notifyListeners();
    }
  }
}

//Student
class Text_Matter_BirthdayNotificationAdmin extends StatefulWidget {
  final List<String> toList;
  final String type;


  Text_Matter_BirthdayNotificationAdmin(
      {Key? key, required this.toList, required this.type})
      : super(key: key);

  @override
  State<Text_Matter_BirthdayNotificationAdmin> createState() => _Text_Matter_BirthdayNotificationAdminState();
}
class _Text_Matter_BirthdayNotificationAdminState extends State<Text_Matter_BirthdayNotificationAdmin> {
  String? provider;

  final titleController = TextEditingController();

  final matterController = TextEditingController();

  String name="{Name}";

  String div="{Div}";

  String date="{date}";
  String format="";
  bool? formatStatus;
  @override
  void initState() {
    setState(() {

    });
    formatStatus=true;
    matterController.text="🎉 Happy Birthday, $name! 🎉 Wishing you a wonderful day and a year full of happiness. Enjoy your special day! ";
    titleController.text="Birthday wishes🎉🎉";
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Send Notification'),
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
      body: Consumer<NotificationToGuardian_Providers>(
        builder: (context, val, _) => Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LottieBuilder.network(
                      'https://assets10.lottiefiles.com/private_files/lf30_kBx3K1.json'),
                  kheight20,
                  SizedBox(
                    height: 30,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(

                              style:    ElevatedButton.styleFrom(
                                  backgroundColor: UIGuide.WHITE,
                                  foregroundColor: UIGuide.light_Purple
                                // Background color/ Text colo
                                // shadowColor: Colors.black, // Shadow color
                                // elevation: 5, // Elevation (shadow depth)
                                // shape: RoundedRectangleBorder( // Shape of the button
                                //   borderRadius: BorderRadius.circular(12),
                                // )
                              ),
                              onPressed: (){
                                setState(() {
                                  formatStatus=true;
                                  matterController.text="🎉 Happy Birthday, $name! 🎉 Wishing you a wonderful day and a year full of happiness. Enjoy your special day! ";
                                  titleController.text="Birthday wishes🎉🎉";


                                });

                              },


                              child: const Text("Default")),
                          kWidth,
                          ElevatedButton(

                              style:    ElevatedButton.styleFrom(
                                  backgroundColor: UIGuide.WHITE,
                                  foregroundColor: UIGuide.light_Purple
                                // Background color/ Text colo
                                // shadowColor: Colors.black, // Shadow color
                                // elevation: 5, // Elevation (shadow depth)
                                // shape: RoundedRectangleBorder( // Shape of the button
                                //   borderRadius: BorderRadius.circular(12),
                                // )
                              ),
                              onPressed: (){
                                setState(() {
                                  formatStatus=false;
                                  titleController.clear();
                                  matterController.clear();


                                });

                              },


                              child: const Text("Clear ❌")),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: LimitedBox(
                      maxHeight: 80,
                      child: TextFormField(
                        inputFormatters: [LengthLimitingTextInputFormatter(50)],
                        enabled: formatStatus==false?true:false,
                        controller: titleController,
                        minLines: 1,
                        maxLines: 4,
                        keyboardType: TextInputType.multiline,
                        decoration: const InputDecoration(
                          labelText: 'Title*',
                          hintText: 'Enter Title',
                          labelStyle: TextStyle(color: UIGuide.light_Purple),
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(0),
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(20)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: UIGuide.light_Purple, width: 1.0),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(0),
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(20)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: LimitedBox(
                      maxHeight: 150,
                      child: TextFormField(
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1000)
                        ],
                        enabled:  formatStatus==false?true:false,
                        controller: matterController,
                        minLines: 1,
                        maxLines: 15,
                        keyboardType: TextInputType.multiline,
                        decoration: const InputDecoration(
                          labelText: 'Matter*',
                          hintText: 'Enter Matter',
                          labelStyle: TextStyle(color: UIGuide.light_Purple),
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(0),
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(20)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: UIGuide.light_Purple, width: 1.0),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(0),
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(20)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  kheight20,
                  SizedBox(
                    width: 150,
                    height: 40,
                    child: MaterialButton(
                      onPressed: () async {
                        var birth= Provider.of<BirthdayListProviders>(
                            context,
                            listen: false);
                        List studs=[];
                        if (titleController.text.trim().isNotEmpty &&
                            matterController.text.trim().isNotEmpty) {
                          print("studentd list");
print(birth.selectedStudList);
                          for(int i=0;i<birth.selectedStudList.length;i++) {
                            name =birth.selectedStudList[i].studentName.toString();
                            print("nmmmmmmmmmmmmmm  $name");
                            //format="Dear Parent,Your ward $name studying in $div is absent today $date";
                            studs.clear();
                            studs.add(birth.selectedStudList[i].studentId);
                            titleController.text= titleController.text;
                            matterController.text= formatStatus==false? matterController.text:"🎉 Happy Birthday, $name! 🎉 Wishing you a wonderful day and a year full of happiness. Enjoy your special day! ";
                            await Provider.of<NotificationToGuardian_Providers>(
                                context,
                                listen: false)
                                .sendNotification(context, titleController.text,
                                matterController.text,
                                studs,
                                sentTo: widget.type);

                          }
                          // await AwesomeDialog(
                          //     context: context,
                          //     dialogType: DialogType.success,
                          //     animType: AnimType.rightSlide,
                          //     headerAnimationLoop: false,
                          //     title: 'Success',
                          //     desc: 'Notification Sent Successfully',
                          //     btnOkOnPress: () {},
                          //     btnOkIcon: Icons.cancel,
                          //     btnOkColor: Colors.green)
                          //     .show();
                          titleController.clear();
                          matterController.clear();
                          formatStatus=false;
                          Navigator.pop(context);
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
                                'Enter Title & Matter!',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        }
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(0),
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(20)),
                        side: BorderSide(color: Theme.of(context).primaryColor),
                      ),
                      color: UIGuide.light_Purple,
                      child: const Text(
                        'Send',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (val.loading) pleaseWaitLoader()
          ],
        ),
      ),
    );
  }
}
//Staff
class Text_Matter_BirthdayStaffNotificationAdmin extends StatefulWidget {
  final List<String> toList;
  final String type;


  Text_Matter_BirthdayStaffNotificationAdmin(
      {Key? key, required this.toList, required this.type})
      : super(key: key);

  @override
  State<Text_Matter_BirthdayStaffNotificationAdmin> createState() => _Text_Matter_BirthdayStaffNotificationAdminState();
}
class _Text_Matter_BirthdayStaffNotificationAdminState extends State<Text_Matter_BirthdayStaffNotificationAdmin> {
  String? provider;

  final titleController = TextEditingController();

  final matterController = TextEditingController();

  String name="{Name}";

  String div="{Div}";

  String date="{date}";
  String format="";
  bool? formatStatus;
  @override
  void initState() {
    setState(() {

    });
    formatStatus=true;
    matterController.text="🎉 Happy Birthday, $name! 🎉 Wishing you a wonderful day and a year full of happiness. Enjoy your special day! ";
    titleController.text="Birthday wishes🎉🎉";
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Send Notification'),
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
      body: Consumer<NotificationToGuardian_Providers>(
        builder: (context, val, _) => Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LottieBuilder.network(
                      'https://assets10.lottiefiles.com/private_files/lf30_kBx3K1.json'),
                  kheight20,
                  SizedBox(
                    height: 30,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(

                              style:    ElevatedButton.styleFrom(
                                  backgroundColor: UIGuide.WHITE,
                                  foregroundColor: UIGuide.light_Purple
                                // Background color/ Text colo
                                // shadowColor: Colors.black, // Shadow color
                                // elevation: 5, // Elevation (shadow depth)
                                // shape: RoundedRectangleBorder( // Shape of the button
                                //   borderRadius: BorderRadius.circular(12),
                                // )
                              ),
                              onPressed: (){
                                setState(() {
                                  formatStatus=true;
                                  matterController.text="🎉 Happy Birthday, $name! 🎉 Wishing you a wonderful day and a year full of happiness. Enjoy your special day! ";
                                  titleController.text="Birthday wishes🎉🎉";


                                });

                              },


                              child: const Text("Default")),
                          kWidth,
                          ElevatedButton(

                              style:    ElevatedButton.styleFrom(
                                  backgroundColor: UIGuide.WHITE,
                                  foregroundColor: UIGuide.light_Purple
                                // Background color/ Text colo
                                // shadowColor: Colors.black, // Shadow color
                                // elevation: 5, // Elevation (shadow depth)
                                // shape: RoundedRectangleBorder( // Shape of the button
                                //   borderRadius: BorderRadius.circular(12),
                                // )
                              ),
                              onPressed: (){
                                setState(() {
                                  formatStatus=false;
                                  titleController.clear();
                                  matterController.clear();


                                });

                              },


                              child: const Text("Clear ❌")),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: LimitedBox(
                      maxHeight: 80,
                      child: TextFormField(
                        inputFormatters: [LengthLimitingTextInputFormatter(50)],
                        enabled: formatStatus==false?true:false,
                        controller: titleController,
                        minLines: 1,
                        maxLines: 4,
                        keyboardType: TextInputType.multiline,
                        decoration: const InputDecoration(
                          labelText: 'Title*',
                          hintText: 'Enter Title',
                          labelStyle: TextStyle(color: UIGuide.light_Purple),
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(0),
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(20)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: UIGuide.light_Purple, width: 1.0),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(0),
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(20)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: LimitedBox(
                      maxHeight: 150,
                      child: TextFormField(
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1000)
                        ],
                        enabled:  formatStatus==false?true:false,
                        controller: matterController,
                        minLines: 1,
                        maxLines: 15,
                        keyboardType: TextInputType.multiline,
                        decoration: const InputDecoration(
                          labelText: 'Matter*',
                          hintText: 'Enter Matter',
                          labelStyle: TextStyle(color: UIGuide.light_Purple),
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(0),
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(20)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: UIGuide.light_Purple, width: 1.0),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(0),
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(20)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  kheight20,
                  SizedBox(
                    width: 150,
                    height: 40,
                    child: MaterialButton(
                      onPressed: () async {
                        var birth= Provider.of<BirthdayListProviders>(
                            context,
                            listen: false);
                        List studs=[];
                        if (titleController.text.trim().isNotEmpty &&
                            matterController.text.trim().isNotEmpty) {

                          for(int i=0;i<birth.selectedStaffList.length;i++) {
                            name =birth.selectedStaffList[i].staffName.toString();
                            print("nmmmmmmmmmmmmmm  $name");
                            //format="Dear Parent,Your ward $name studying in $div is absent today $date";
                            studs.clear();
                            studs.add(birth.selectedStaffList[i].staffId);
                            titleController.text= titleController.text;
                            matterController.text= formatStatus==false? matterController.text:"🎉 Happy Birthday, $name! 🎉 Wishing you a wonderful day and a year full of happiness. Enjoy your special day! ";
                            await Provider.of<NotificationToGuardian_Providers>(
                                context,
                                listen: false)
                                .sendNotification(context, titleController.text,
                                matterController.text,
                                studs,
                                sentTo: widget.type);

                          }
                          // await AwesomeDialog(
                          //     context: context,
                          //     dialogType: DialogType.success,
                          //     animType: AnimType.rightSlide,
                          //     headerAnimationLoop: false,
                          //     title: 'Success',
                          //     desc: 'Notification Sent Successfully',
                          //     btnOkOnPress: () {},
                          //     btnOkIcon: Icons.cancel,
                          //     btnOkColor: Colors.green)
                          //     .show();
                          titleController.clear();
                          matterController.clear();
                          formatStatus=false;
                          Navigator.pop(context);
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
                                'Enter Title & Matter!',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        }
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(0),
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(20)),
                        side: BorderSide(color: Theme.of(context).primaryColor),
                      ),
                      color: UIGuide.light_Purple,
                      child: const Text(
                        'Send',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (val.loading) pleaseWaitLoader()
          ],
        ),
      ),
    );
  }
}