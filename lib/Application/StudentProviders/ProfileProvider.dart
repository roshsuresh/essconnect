import 'dart:convert';
import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:essconnect/Domain/Staff/NoticeboardSendModel.dart';
import 'package:essconnect/Domain/Student/ProfileEditModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../Domain/Student/Flashnews.dart';
import '../../Domain/Student/profileModel.dart';
import '../../utils/constants.dart';

Map? mapResponse;
Map? dataResponse;
Map? studResponse;
List? dataRsponse;
Map? siblingResponse;
List? siblinggResponse;

class ProfileProvider with ChangeNotifier {
  String? studName;
  String? admissionNo;
  String? division;
  String? divisionId;
  String? rollNo;
  dynamic studentDetailsClass;
  dynamic bloodGroup;
  dynamic houseGroup;
  String? classTeacher;
  dynamic dob;
  dynamic studentPhoto;
  dynamic studentPhotoId;
  String? gender;
  String? height;
  String? weight;
  String? address;
  String? fatherName;
  dynamic fatherMail;
  String? fatherMobileno;
  String? motherName;
  dynamic motherMailId;
  String? motherMobileno;
  String? studPhoto;
  String? fatherPhoto;
  String? motherPhoto;
  String? area;

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future profileData() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };

    setLoading(true);
    var response = await http.get(
        Uri.parse("${UIGuide.baseURL}/mobileapp/parent/studentprofile"),
        headers: headers);
    try {
      if (response.statusCode == 200) {
        setLoading(true);

        mapResponse = await json.decode(response.body);
        dataResponse = await mapResponse!['studentDetails'];

        print("corect..........");
        setLoading(true);
        StudentProfileModel std =
            StudentProfileModel.fromJson(mapResponse!['studentDetails']);
        studPhoto = std.studentPhoto;
        studName = std.studentName;
        print(studName);
        admissionNo = std.admissionNo;
        division = std.divisionName;
        divisionId = std.divisionId;
        rollNo = std.rollNo;
        dob = std.dob;
        gender = std.gender;
        height = std.height;
        weight = std.weight;
        address = std.address;
        fatherName = std.fatherName;
        fatherPhoto = std.fatherPhoto;
        motherPhoto = std.motherPhoto;
        fatherMail = std.fatherMailId;
        fatherMobileno = std.fatherMobileno;
        motherName = std.motherName;
        motherMailId = std.motherMailId;
        motherMobileno = std.motherMobileno;
        address = std.address;
        bloodGroup = std.bloodGroup;
        houseGroup = std.houseGroup;
        classTeacher = std.classTeacher;
        area = std.area;
        setLoading(false);
        notifyListeners();
      } else {
        print("Error in profile Response");
      }
    } catch (e) {
      print(e);
    }
  }

  String? flashnews;
  Future flashNewsProvider() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };

    try {
      final response = await http.get(
          Uri.parse("${UIGuide.baseURL}/mobileapp/parent/flashnews"),
          headers: headers);

      if (response.statusCode == 200) {
        final data = json.decode(response.body.toString());
        FlashNewsMode flash = FlashNewsMode.fromJson(data);
        flashnews = flash.flashNews;
        notifyListeners();
      } else {
        print("Something went wrong in flashnews");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future siblingsAPI() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };

    final response = await http.get(
        Uri.parse("${UIGuide.baseURL}/parent-home/get-guardian-children"),
        headers: headers);

    if (response.statusCode == 200) {
      siblinggResponse = json.decode(response.body);
      print(siblinggResponse);
      notifyListeners();
    } else {
      throw ("Something went wrong in siblings Response");
    }
  }

  String? studentIdEdit;
  int? offlineIdEdit;
  int? installationIdEdit;
  String? studentNameEdit;
  String? guardianNameEdit;
  String? userNameEdit;
  String? addressEdit;
  String? emailIdEdit;
  String? mobileNoEdit;
  String? photoIdEdit;
  StudentPhoto? studentPhotoEdit;

  //Offline
  String? idOffline;
  String? studentIdOffline;
  String? guardianNameOffline;
  int? offlineIdOffline;
  int? installationIdOffline;
  String? addressOffline;
  String? emailIdOffline;
  String? mobileNoOffline;
  String? studentPhotoIdOffline;
  StudentPhoto? studentPhotoOffline;

  Future getProfileEdit() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };

    final response = await http.get(
        Uri.parse("${UIGuide.baseURL}/student-profile/profileview"),
        headers: headers);

    if (response.statusCode == 200) {
      var data = await json.decode(response.body);
      InitialValues ini = InitialValues.fromJson(data["initialValues"]);
      studentIdEdit = ini.studentId;
      guardianNameEdit = ini.guardianName;
      emailIdEdit = ini.emailId;
      mobileNoEdit = ini.mobileNo;
      addressEdit = ini.address;
      studentPhotoEdit = ini.studentPhoto;
      offlineIdEdit = ini.offlineId;
      installationIdEdit = ini.installationId;
      print(studentIdEdit);

      OfflineStudentValues off =
          OfflineStudentValues.fromJson(data["offlineStudentValues"]);

      idOffline = off.id;
      studentIdOffline = off.studentId;
      guardianNameOffline = off.guardianName;

      installationIdOffline = off.installationId;
      addressOffline = off.address;
      emailIdOffline = off.emailId;
      mobileNoOffline = off.mobileNo;
      studentPhotoOffline = off.studentPhoto;
      print(idOffline);

      notifyListeners();
    } else {
      throw ("Error in profile edit");
    }
  }

  //Add image
  bool _loadingg = false;
  bool get loadingg => _loadingg;
  setLoadingg(bool value) {
    _loadingg = value;
    notifyListeners();
  }

  File? selectedImage;
  String? attachmentid;
  Future studentImageSave(BuildContext context, String path) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoadingg(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${UIGuide.baseURL}/files/single/Students'));
    request.fields.addAll({'': ''});
    request.files.add(await http.MultipartFile.fromPath('', path));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    setLoadingg(true);
    if (response.statusCode == 200) {
      setLoadingg(true);
      Map<String, dynamic> data =
          jsonDecode(await response.stream.bytesToString());

      NoticeImageId idd = NoticeImageId.fromJson(data);
      attachmentid = idd.id;
      print('...............   $attachmentid');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        duration: Duration(seconds: 1),
        margin: EdgeInsets.only(bottom: 80, left: 30, right: 30),
        behavior: SnackBarBehavior.floating,
        content: Text(
          'File added...',
          textAlign: TextAlign.center,
        ),
      ));
      setLoadingg(false);
    } else {
      selectedImage = null;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        duration: Duration(seconds: 1),
        margin: EdgeInsets.only(bottom: 80, left: 30, right: 30),
        behavior: SnackBarBehavior.floating,
        content: Text(
          'Something went wrong',
          textAlign: TextAlign.center,
        ),
      ));
      print(response.reasonPhrase);

      setLoadingg(false);
      notifyListeners();
    }
  }

  // save profile

  Future getSaveProfile(
    BuildContext context,
    int offlineID,
    int installationId,
    String guardianNa,
    String addressE,
    String emailIDE,
    String mobileNoE,
    String studentPhoId,
  ) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    var request = http.Request(
        'POST', Uri.parse('${UIGuide.baseURL}/student-profile/saveprofile'));
    request.body = json.encode({
      {
        "offlineId": offlineID,
        "installationId": installationId,
        "guardianName": guardianNa,
        "address": addressE,
        "emailId": emailIDE,
        "mobileNo": mobileNoE,
        "studentPhotoId": studentPhoId,
        "isGuardianNameChanged": true,
        "isAddressChanged": true,
        "isEmailIdChanged": true,
        "isMobileNoChanged": true,
        "isPhotoChanged": true
      }
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print(request.body);
    if (response.statusCode == 200) {
      print('Correct........______________________________');
      print(await response.stream.bytesToString());
      await AwesomeDialog(
              context: context,
              dialogType: DialogType.success,
              animType: AnimType.rightSlide,
              headerAnimationLoop: false,
              title: 'Saved Successfully',
              btnOkOnPress: () {
                return;
              },
              btnOkIcon: Icons.cancel,
              btnOkColor: Colors.green)
          .show();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        duration: Duration(seconds: 1),
        margin: EdgeInsets.only(bottom: 80, left: 30, right: 30),
        behavior: SnackBarBehavior.floating,
        content: Text(
          'Something Went Wrong....',
          textAlign: TextAlign.center,
        ),
      ));
      print('Error Response save profile');
    }
  }

  //Update profile

  Future getUpdateProfile(
      BuildContext context,
      int offlineID,
      int installationId,
      String guardianNa,
      String addressE,
      String emailIDE,
      String mobileNoE,
      String studentPhoId,
      String offID) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    print({
      "offlineId": offlineID,
      "installationId": installationId,
      "guardianName": guardianNa,
      "address": addressE,
      "emailId": emailIDE,
      "mobileNo": mobileNoE,
      "studentPhotoId": studentPhoId,
      "isGuardianNameChanged": true,
      "isAddressChanged": true,
      "isEmailIdChanged": true,
      "isMobileNoChanged": true,
      "isPhotoChanged": true
    });
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    var request = http.Request('PATCH',
        Uri.parse('${UIGuide.baseURL}/student-profile/updateprofile/$offID'));
    request.body = json.encode({
      "offlineId": offlineID,
      "installationId": installationId,
      "guardianName": guardianNa,
      "address": addressE,
      "emailId": emailIDE,
      "mobileNo": mobileNoE,
      "studentPhotoId": studentPhoId.isEmpty ? null : studentPhoId,
      "isGuardianNameChanged": true,
      "isAddressChanged": true,
      "isEmailIdChanged": true,
      "isMobileNoChanged": true,
      "isPhotoChanged": true
    });
    // "offlineId": offlineID,
    // "installationId": installationId,
    // "guardianName": guardianNa,
    // "address": addressE,
    // "emailId": emailIDE,
    // "mobileNo": mobileNoE,
    // "studentPhotoId": studentPhoId,
    // "isGuardianNameChanged": true,
    // "isAddressChanged": true,
    // "isEmailIdChanged": true,
    // "isMobileNoChanged": true,
    // "isPhotoChanged": true
    //   }
    // });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print(request.body);
    if (response.statusCode == 200) {
      print('Correct........______   Update   ______________________');
      print(await response.stream.bytesToString());
      await AwesomeDialog(
              context: context,
              dialogType: DialogType.success,
              animType: AnimType.rightSlide,
              headerAnimationLoop: false,
              title: 'Updated Successfully',
              btnOkOnPress: () {
                return;
              },
              btnOkIcon: Icons.cancel,
              btnOkColor: Colors.green)
          .show();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        duration: Duration(seconds: 1),
        margin: EdgeInsets.only(bottom: 80, left: 30, right: 30),
        behavior: SnackBarBehavior.floating,
        content: Text(
          'Something Went Wrong....',
          textAlign: TextAlign.center,
        ),
      ));
      print('Error Response Update profile');
    }
  }
}
