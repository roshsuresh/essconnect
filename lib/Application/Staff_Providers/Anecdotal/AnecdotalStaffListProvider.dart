

import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Constants.dart';
import '../../../Domain/Staff/Anecdotal/InitialSelectionModel.dart';
import '../../../Domain/Staff/Anecdotal/ListviewEditScreen.dart';
import 'package:http/http.dart' as http;

import '../../../Domain/Staff/Anecdotal/StudListviewAnectdotal.dart';
import '../../../utils/constants.dart';
import 'package:jwt_decode/jwt_decode.dart';
class AnecdotalStaffListProviders with ChangeNotifier {




  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  bool hasMoreData() {
    final totalCount = countStud;
    // print("studentView length :  ${studentViewList.length}");
    notifyListeners();
    return anecDotalList.length < totalCount!;
  }

//clear

  clearInitial() {
    remarksCategoryList.clear();
    dairySubjectList.clear();
    isimportant = false;
    showGuardian = false;

  }
  clearAnecdotal(){
    anecDotalList.clear();
    notifyListeners();
  }


  bool _loadingPage = false;
  bool get loadingPage => _loadingPage;
  setLoadingPage(bool value) {
    _loadingPage = value;
    notifyListeners();
  }


  //getId
  Future<String?> getId()async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    String? jwtToken = _pref.getString('accesstoken');

    Map<String, dynamic> payload = Jwt.parseJwt(jwtToken!);
    userId= payload['StaffId'];
    print("iddddddddd");
    print(userId);
  }


  int currentPage = 2;
  int? pageSize;
  int? countStud;
  String? userId;

  //List view
  List<AnecdotalListViewModel> anecDotalList = [];
  Map<String, dynamic> data={};
  Future getAnecdotalList() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var parsedResponse =await parseJWT();
    userId= await parsedResponse['StaffID'];

    setLoadingPage(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    try {
      var request = http.Request(
          'GET',
          Uri.parse(
              '${UIGuide.baseURL}/anecdotal/anecdotal-list/?page=1'));

      request.headers.addAll(headers);
      print(request);
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        setLoadingPage(true);

         data =
        jsonDecode(await response.stream.bytesToString());
        print(data);

        // demoData =
        // jsonDecode(await response.stream.bytesToString());

        List<AnecdotalListViewModel> templist =
        List<AnecdotalListViewModel>.from(data["results"]
            .map((x) => AnecdotalListViewModel.fromJson(x)));

        anecDotalList.addAll(templist);
        print("lisssssssssssss");
        print(templist);
        print(anecDotalList);
        print(data);

        PaginationAnecDotalList pagenata =
        PaginationAnecDotalList.fromJson(data['pagination']);
        pageSize = pagenata.pageSize;
        countStud = pagenata.count;


        setLoadingPage(false);
        notifyListeners();
      } else {
        setLoadingPage(false);
        print('Error in anecDotal list');
      }
    } catch (e) {
      print('Error in anecDotal list');
      setLoadingPage(false);
    }
  }
  Future getAnecdotalListPagination() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var parsedResponse =await parseJWT();
    userId= await parsedResponse['StaffID'];

    setLoadingPage(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    try {
      var request = http.Request(
          'GET',
          Uri.parse(
              '${UIGuide.baseURL}/anecdotal/anecdotal-list/?page=$currentPage'));

      request.headers.addAll(headers);
      print(request);
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        setLoadingPage(true);

        data =
            jsonDecode(await response.stream.bytesToString());
        print(data);

        // demoData =
        // jsonDecode(await response.stream.bytesToString());

        List<AnecdotalListViewModel> templist =
        List<AnecdotalListViewModel>.from(data["results"]
            .map((x) => AnecdotalListViewModel.fromJson(x)));

        anecDotalList.addAll(templist);
        print("lisssssssssssss");
        print(templist);
        print(anecDotalList);
        print(data);

        PaginationAnecDotalList pagenata =
        PaginationAnecDotalList.fromJson(data['pagination']);
        pageSize = pagenata.pageSize;
        countStud = pagenata.count;
        currentPage++;
        print(currentPage);

        setLoadingPage(false);
        notifyListeners();
      } else {
        setLoadingPage(false);
        print('Error in anecDotal list');
      }
    } catch (e) {
      print('Error in anecDotal list');
      setLoadingPage(false);
    }
  }
  //moredata
  bool hasMoreListData() {
    final totalCount = countStud;
    print("anecdotal length :  ${anecDotalList.length}");
    notifyListeners();
    return anecDotalList.length < totalCount!;
  }


//by name
  Future getAnecdotalListbyName(String name) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var parsedResponse =await parseJWT();
    userId= await parsedResponse['StaffID'];

    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    try {
      var request = http.Request(
          'GET',
          Uri.parse(
              '${UIGuide.baseURL}/anecdotal/anecdotal-list/?page=1&searchName=$name'));

      request.headers.addAll(headers);
      print(request);
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        setLoading(true);

        Map<String, dynamic> data =
        jsonDecode(await response.stream.bytesToString());
        print(data);

        List<AnecdotalListViewModel> templist =
        List<AnecdotalListViewModel>.from(data["results"]
            .map((x) => AnecdotalListViewModel.fromJson(x)));
        anecDotalList.addAll(templist);

        PaginationAnecDotalList pagenata =
        PaginationAnecDotalList.fromJson(data['pagination']);
        pageSize = pagenata.pageSize;
        countStud = pagenata.count;
        // currentPage++;
        // print(currentPage);
        // print(countStud);

        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        print('Error in anecDotal list');
      }
    } catch (e) {
      print('Error in anecDotal list');
      setLoading(false);
    }
  }
  Future getAnecdotalListPaginationByName() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var parsedResponse =await parseJWT();
    userId= await parsedResponse['StaffID'];

    setLoadingPage(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    try {
      var request = http.Request(
          'GET',
          Uri.parse(
              '${UIGuide.baseURL}/anecdotal/anecdotal-list/?page=$currentPage'));

      request.headers.addAll(headers);
      print(request);
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        setLoadingPage(true);

        data =
            jsonDecode(await response.stream.bytesToString());
        print(data);

        // demoData =
        // jsonDecode(await response.stream.bytesToString());

        List<AnecdotalListViewModel> templist =
        List<AnecdotalListViewModel>.from(data["results"]
            .map((x) => AnecdotalListViewModel.fromJson(x)));

        anecDotalList.addAll(templist);
        print("lisssssssssssss");
        print(templist);
        print(anecDotalList);
        print(data);

        PaginationAnecDotalList pagenata =
        PaginationAnecDotalList.fromJson(data['pagination']);
        pageSize = pagenata.pageSize;
        countStud = pagenata.count;
        currentPage++;
        print(currentPage);

        setLoadingPage(false);
        notifyListeners();
      } else {
        setLoadingPage(false);
        print('Error in anecDotal list');
      }
    } catch (e) {
      print('Error in anecDotal list');
      setLoadingPage(false);
    }
  }

  //delete

  Future anecdotalDelete(
      BuildContext context, String eventID, int indexx) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    var request = http.Request('DELETE',
        Uri.parse('${UIGuide.baseURL}/anecdotal/delete-event/$eventID'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 204) {
      anecDotalList.removeAt(indexx);

      print(await response.stream.bytesToString());
      print('correct');
      await AwesomeDialog(
          dismissOnTouchOutside: false,
          dismissOnBackKeyPress: false,
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          headerAnimationLoop: false,
          title: 'Deleted Successfully',

          btnOkOnPress: () async {
           Navigator.pop(context);
          },
          btnOkColor: Color.fromRGBO(
              217,62,71,5))
          .show();

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
      print('Error in Anecdotal Delete stf');
    }
  }
//edit
 String? studId;

  String? name;
  String? admNo;
  String? remarks;
  String? date;
  String? time;
  String? category;
  String? categoryId;
  String? subject;
  String? subjectId;
  String? staffid;
  String? createdStaffid;
  String? staffName;
  bool? showGuardian;
  bool? isimportant;

  List<CategorySubjectModel> remarksCategoryList = [];
  List<CategorySubjectModel> dairySubjectList = [];
  Future getInitialRow(String id) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    var response = await http.get(
        Uri.parse("${UIGuide.baseURL}/anecdotal/getData/$id"),
        headers: headers);
    if (response.statusCode == 200) {
      setLoading(true);
      Map<String, dynamic> data = json.decode(response.body);
      Map<String, dynamic> update = data['updateRow'];

      List<CategorySubjectModel> templist =
      List<CategorySubjectModel>.from(data["category"]
          .map((x) => CategorySubjectModel.fromJson(x)));
      remarksCategoryList.addAll(templist);

      List<CategorySubjectModel> templist2 =
      List<CategorySubjectModel>.from(data["subject"]
          .map((x) => CategorySubjectModel.fromJson(x)));
      dairySubjectList.addAll(templist2);

      UpdateRow ur = UpdateRow.fromJson(update);
      admNo=ur.admissionNo;
      studId =ur.studId;
      staffid= ur.staffId;
      staffName= ur.staffName;
      name= ur.studentName;
      category =ur.category;
      categoryId =ur.categoryId;
      subject= ur.subjectName;
      subjectId= ur.subject;
      date =ur.date;
      createdStaffid =ur.createStaffId;
      time= ur.time;
      remarks =ur.remarks;
      showGuardian =ur.showGuardianLogin;
      isimportant=ur.isImportantEntry;
      setLoading(false);
      notifyListeners();
    } else {
      print('Error in getData');
      setLoading(false);
    }
    return response.statusCode;
  }


  isimportantCheckbox() {

    isimportant = !isimportant!;
    notifyListeners();
  }

  //
  isShownToGuardian() {
    showGuardian = !showGuardian!;
    notifyListeners();
  }


  DateTime? dateselect;
  String dateDisplay = '';
  String dateSend = '';
  DateTime? currentDate;

  getDateNow() async {
    currentDate = DateTime.now();
    dateDisplay = DateFormat('dd-MMM-yyyy').format(currentDate!);
    dateSend = DateFormat('yyyy-MM-dd').format(currentDate!);
    print("dateDis:  $dateDisplay");
    print("dateS:  $dateSend");
    notifyListeners();
  }

  //get date

  getDate(BuildContext context) async {
    dateselect = await showDatePicker(
      context: context,
      initialDate: dateselect ?? DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
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
    dateDisplay = DateFormat('dd-MMM-yyyy').format(dateselect!);
    dateSend = DateFormat('yyyy-MM-dd').format(dateselect!);
    print("dateDisplay:  $dateDisplay");
    print("dateSend:  $dateSend");
    notifyListeners();
  }
//update
 int status=0;
  Future updateAnecdotal(String id,String categoryID, String subjectID, String remarks,
      String studId,String staffID, BuildContext context) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoadingPage(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    //try {
    var request =
    http.Request('PATCH', Uri.parse('${UIGuide.baseURL}/anecdotal/$id'));
    request.body = json.encode({
      "categoryId": categoryID,
      "subject": subjectID,
      "createdDate": dateSend,
      "remarks": remarks,
      "isImportant": isimportant,
      "showInGuardianLogin": showGuardian,
      "studId": studId,
      "staffId": staffID
    });
    print(
        json.encode({
          "categoryId": categoryID,
          "subject": subjectID,
          "createdDate": dateSend,
          "remarks": remarks,
          "isImportant": isimportant,
          "showInGuardianLogin": showGuardian,
          "studId": studId,
          "staffId": staffID
        })
    );

    request.headers.addAll(headers);
    print(request.body);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200||response.statusCode == 204)
    {
      setLoadingPage(true);
      await AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          headerAnimationLoop: false,
          title: 'Success',
          desc: 'Updated Successfully',
          btnOkOnPress: () {},
          btnOkIcon: Icons.cancel,
          btnOkColor: Colors.green)
          .show();
     status = 200;

      setLoadingPage(false);
      notifyListeners();
    }
    else if(response.statusCode == 422){
      status=422;
  snackbarWidget(3, 'Remarks already exists.', context);
    }
    else {
      setLoadingPage(false);
      print('Error in getSaveAnecdotal stf');
    }

  }

}