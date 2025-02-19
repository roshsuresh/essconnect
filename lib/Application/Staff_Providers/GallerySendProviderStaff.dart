import 'dart:convert';
import 'dart:developer';
import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Domain/Staff/GalleryListViewStaff.dart';
import '../../Domain/Staff/GallerySendStaff.dart';
import '../../utils/constants.dart';

class GallerySendProvider_Stf with ChangeNotifier {
  DateTime? fromexam;
  String fromDateDis = '';
  late DateTime fromDateCheck;

  getVariables() {
    fromDateDis = '';
    toDateDis = '';
    imageIDList.clear();
    notifyListeners();
  }

  //Get From date

  getFromDate(BuildContext context) async {
    fromexam = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 0)),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: UIGuide.light_Purple,
              colorScheme: const ColorScheme.light(
                primary: UIGuide.light_Purple,
              ),
              buttonTheme:
                  const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child!);
      },
    );

    fromDateDis = DateFormat('dd/MMM/yyyy').format(fromexam!);
    fromDateCheck = DateTime(fromexam!.year, fromexam!.month, fromexam!.day);
    print(fromDateDis);
    notifyListeners();
  }

  // Get To date

  DateTime? toexam;
  String toDateDis = '';
  late DateTime toDateCheck;

  getToDate(BuildContext context) async {
    toexam = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 0)),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: UIGuide.light_Purple,
              colorScheme: const ColorScheme.light(
                primary: UIGuide.light_Purple,
              ),
              buttonTheme:
                  const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child!);
      },
    );
    toDateDis = DateFormat('dd/MMM/yyyy').format(toexam!);
    toDateCheck = DateTime(toexam!.year, toexam!.month, toexam!.day);
    print(toDateDis);
    notifyListeners();
  }

  bool? isClassTeacher;

  List<GalleryCourseListStaff> galleryCourse = [];

  removeCourseAll() {
    courselistt.clear();
    notifyListeners();
  }

  List<GalleryCourseListStaff> courselistt = [];
  Future<bool> sendGallery() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };

    var response = await http.get(
        Uri.parse(
            "${UIGuide.baseURL}/mobileapp/staffdet/noticeBoard/initialValues"),
        headers: headers);

    if (response.statusCode == 200) {
      Map<String, dynamic> data = await json.decode(response.body);
      GallerySendStaffInitialvalues sd =
          GallerySendStaffInitialvalues.fromJson(data['initialValues']);

      isClassTeacher = sd.isClassTeacher;
      Map<String, dynamic> galleryiniti = await data['initialValues'];

      List<GalleryCourseListStaff> templist = List<GalleryCourseListStaff>.from(
          galleryiniti["courseList"]
              .map((x) => GalleryCourseListStaff.fromJson(x)));
      courselistt.addAll(templist);
      notifyListeners();
    } else {
      print('Error in gallerycourse stf');
    }
    return true;
  }

  //Division List

  List<GalleryDivisionListStaff> galleryDivision = [];

  removeDivisionAll() {
    divisionlistt.clear();
    notifyListeners();
  }

  List<GalleryDivisionListStaff> divisionlistt = [];

  Future<bool> getDivisionList(String courseId) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            '${UIGuide.baseURL}/mobileapp/staffdet/noticeboard/divisions/$courseId'));
    request.body = json.encode({"SchoolId": pref.getString('schoolId')});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Map<String, dynamic> data =
          jsonDecode(await response.stream.bytesToString());

      log(data.toString());

      List<GalleryDivisionListStaff> templist =
          List<GalleryDivisionListStaff>.from(data["divisions"]
              .map((x) => GalleryDivisionListStaff.fromJson(x)));
      divisionlistt.addAll(templist);

      notifyListeners();
    } else {
      print('Error in DivisionNotice stf');
    }
    return true;
  }
//find image id

  String? id;
  List<String> imageIDList = [];
  Future galleryImageSave(BuildContext context, List<String> path) async {
    imageIDList.clear();
    for (String filePath in path) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      setLoadingg(true);
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${pref.getString('accesstoken')}'
      };
      var request = http.MultipartRequest(
          'POST', Uri.parse('${UIGuide.baseURL}/files/single/School'));
      request.fields.addAll({'': ''});
      request.files.add(await http.MultipartFile.fromPath('file', filePath));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      setLoadingg(true);
      if (response.statusCode == 200) {
        Map<String, dynamic> data =
            jsonDecode(await response.stream.bytesToString());
        setLoadingg(true);
        GalleryImageId idd = GalleryImageId.fromJson(data);
        id = idd.id;
        imageIDList.add(id!);
        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        //   elevation: 10,
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.all(Radius.circular(20)),
        //   ),
        //   duration: Duration(seconds: 1),
        //   margin: EdgeInsets.only(bottom: 80, left: 30, right: 30),
        //   behavior: SnackBarBehavior.floating,
        //   content: Text(
        //     'Image added...',
        //     textAlign: TextAlign.center,
        //   ),
        // ));
        setLoadingg(false);
        print('Image ID............$id');
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
        print(response.reasonPhrase);
        setLoadingg(false);
      }
    }
    print("imageIDList--------$imageIDList");
  }

  //gallery save

  Future gallerySave(
      context,
      String entryDate,
      String DisplayStartDate,
      String DisplayEndDate,
      String Titlee,
      String CourseId,
      String DivisionId,
      List<String> imgID) async {
    List imgg = [];
    print("imageIDList=====$imageIDList");
    for (String imggID in imageIDList) {
      imgg.add({"fileId": imggID, "isMaster": true});
    }
    print("imgg ---===  $imgg");
    SharedPreferences pref = await SharedPreferences.getInstance();

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    var request =
        http.Request('POST', Uri.parse('${UIGuide.baseURL}/gallery/create'));
    request.body = json.encode({
      "EntryDate": entryDate,
      "DisplayStartDate": DisplayStartDate,
      "DisplayEndDate": DisplayEndDate,
      "Title": Titlee,
      "CourseId": [CourseId],
      "DivisionId": [DivisionId],
      "ForClassTeacherOnly": "false",
      "DisplayTo": "student",
      "StaffRole": "null",
      "PhotoList": imgg
    });
    request.headers.addAll(headers);

    print(request.body);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200 || response.statusCode == 204) {
      print('Correct...______________________________');

      AwesomeDialog(
              context: context,
              dialogType: DialogType.success,
              animType: AnimType.rightSlide,
              headerAnimationLoop: false,
              title: 'Success',
              desc: 'Uploaded Successfully',
              btnOkOnPress: () {},
              btnOkIcon: Icons.cancel,
              btnOkColor: Colors.green)
          .show();
      getVariables();
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
      print('Error in gallery save respo');
    }
  }

  //gallery view staff
  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  List<GalleryViewList_staff> galleryViewList = [];
  Future<bool> galleryViewListStaff(BuildContext context) async {
    setLoading(true);

    SharedPreferences pref = await SharedPreferences.getInstance();

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    var request = http.Request(
        'GET', Uri.parse('${UIGuide.baseURL}/mobileapp/staffdet/gallery-list'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Map<String, dynamic> data =
          jsonDecode(await response.stream.bytesToString());

      log(data.toString());

      List<GalleryViewList_staff> templist = List<GalleryViewList_staff>.from(
          data["galleryView"].map((x) => GalleryViewList_staff.fromJson(x)));
      galleryViewList.addAll(templist);
      setLoading(false);
      notifyListeners();
    } else {
      setLoading(false);
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
      print('Error in galleryViewList stf');
    }
    return true;
  }

//delete gallery

  Future galleryDeleteStaff(
      BuildContext context, String eventID, int indexx) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    var request = http.Request('DELETE',
        Uri.parse('${UIGuide.baseURL}/gallery/delete-event/$eventID'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 204) {
      galleryViewList.removeAt(indexx);
      print(await response.stream.bytesToString());
      print('correct');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        duration: Duration(seconds: 1),
        margin: EdgeInsets.only(bottom: 80, left: 30, right: 30),
        behavior: SnackBarBehavior.floating,
        content: Text(
          'Deleted Successfully',
          textAlign: TextAlign.center,
        ),
      ));
      notifyListeners();
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
      print('Error in galleryDelete stf');
    }
  }

//Gallery Received

  final bool _loadingg = false;
  bool get loadingg => _loading;
  setLoadingg(bool value) {
    _loading = value;
    notifyListeners();
  }

//Gallery Received
  List<GalleryEventListReceived> galleryReceived = [];
  Future getGalleyReceived() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoadingg(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };

    setLoadingg(true);
    var response = await http.get(
        Uri.parse("${UIGuide.baseURL}/mobileapp/staffdet/getgalleryview"),
        headers: headers);
    //print(response);
    try {
      if (response.statusCode == 200) {
        setLoadingg(true);
        print("corect");
        final data = json.decode(response.body);
        print(data);
        List<GalleryEventListReceived> templist =
            List<GalleryEventListReceived>.from(data["galleryEventList"]
                .map((x) => GalleryEventListReceived.fromJson(x)));
        galleryReceived.addAll(templist);

        setLoadingg(false);
        notifyListeners();
      } else {
        setLoadingg(false);
        print("Error in galleryEventList Response");
      }
    } catch (e) {
      setLoading(false);
      print(e);
    }
  }

  bool _load = false;
  bool get load => _load;
  setLoad(bool value) {
    _load = value;
    notifyListeners();
  }

  List? galleryAttachResponse;
  Future galleyAttachment(String galleryId) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoad(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    var response = await http.get(
        Uri.parse(
            "${UIGuide.baseURL}/systemadmindashboard/gallery-photos/$galleryId"),
        headers: headers);
    setLoad(true);
    try {
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(data);
        galleryAttachResponse = data;

        setLoad(false);
        notifyListeners();
      } else {
        setLoad(false);
        print("error in gallery response");
      }
    } catch (e) {
      setLoad(false);
      print(e);
    }
  }
}
