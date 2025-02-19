import 'dart:convert';
import 'dart:developer';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Constants.dart';
import '../../Domain/Student/LoginModel.dart';
import '../../Domain/Student/activation_model.dart';
import '../../Presentation/Admin/AdminHome.dart';
import '../../Presentation/ChildLogin/ChildHomeScreen.dart';
import '../../Presentation/SchoolHead/SchoolHeadHome.dart';
import '../../Presentation/SchoolSuperAdmin/SuperAdminHome.dart';
import '../../Presentation/Staff/StaffHome.dart';
import '../../Presentation/StaffAsGuardian.dart/StaffHomeScreen.dart';
import '../../Presentation/Student/Student_home.dart';
import '../../utils/constants.dart';
import 'SiblingsProvider.dart';

class LoginProvider with ChangeNotifier {
  bool isLoginned = false;
  String imageUrl = "";
  String schoolName = "";
  String schoolid = "";
  String subDomain = "";
  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<int> getActivation(String key) async {
    // String res;
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
    };
    var params = {
      "code": key,
    };

    var response = await http.post(
        Uri.parse("${UIGuide.baseURL}/mobileapp/common/get-schooldomain"),
        body: json.encode(params),
        headers: headers);
    if (response.statusCode == 200) {
      setLoading(true);
      print("corect");
      var jsonData = json.decode(response.body);

      ActivationModel ac = ActivationModel.fromJson(jsonData);
      schoolName = ac.schoolName!;
      subDomain = ac.subDomain!;
      schoolid = ac.schoolId!;
      print(schoolName);
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString("schoolId", ac.schoolId!);
      pref.setString("subDomain", ac.subDomain!);
      print(pref.getString('subDomain'));
      print('-----');
      setLoading(false);
      notifyListeners();
    } else {
      setLoading(false);
      print("Error in API calling");
    }

    return response.statusCode;
  }

  bool _loadingLogin = false;
  bool get loadingLogin => _loadingLogin;
  setLoadingLogin(bool value) {
    _loadingLogin = value;
    notifyListeners();
  }

  // -----------  LOGIN  -----------

  checkLogin(String username, String password, BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoadingLogin(true);
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST',
        Uri.parse(
            '${UIGuide.baseURL}/login?id=${pref.getString('schoolId')}'));
    request.body = json.encode({"email": username, "password": password});
    print(request.body);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200 || response.statusCode == 201) {
      setLoadingLogin(true);
      var data = jsonDecode(await response.stream.bytesToString());
      LoginModel res = LoginModel.fromJson(data);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('accesstoken', res.accessToken);
      SharedPreferences user = await SharedPreferences.getInstance();
      await user.setString('username', username);
      SharedPreferences pass = await SharedPreferences.getInstance();
      await pass.setString('password', password);

      await getToken(context);
      // await getMobileViewerId();
      // await getsavemobileViewer(context);
      // await sendUserDetails(context);
      var parsedResponse = await parseJWT();
      List<dynamic> roleList = [];
      print(parsedResponse['role'] is List);
      if (parsedResponse['role'] is List) {
        roleList = await parsedResponse['role'];
        print(roleList);
      }

      if (parsedResponse['role'] == "Guardian") {
        setLoadingLogin(true);
        var p = Provider.of<SibingsProvider>(context, listen: false);
        await p.clearSiblingsList();
        await p.getSiblingName();
        print("------------${p.siblingList.length}");

        if (p.siblingList.isNotEmpty) {
          for (int i = 0; i < p.siblingList.length; i++) {
            print(p.siblingList[i].name);
            print('------------$i');
            await p.getToken(p.siblingList[i].id.toString());
          }

          setLoadingLogin(false);
          return await Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const StudentHome()));
        } else {
          setLoadingLogin(false);

          await Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const StudentHome()));
        }
      } else if (parsedResponse['role'] == "SystemAdmin" ||
          roleList.contains("SystemAdmin")) {
        setLoadingLogin(false);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const AdminHome()));
      } else if (parsedResponse['role'] == "Teacher" ||
          parsedResponse['role'] == "NonTeachingStaff") {
        setLoadingLogin(false);

        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => const StaffHome()));
      } else if ((roleList.contains("Guardian") &&
              roleList.contains("Teacher")) ||
          (roleList.contains("NonTeachingStaff") &&
              roleList.contains("Guardian"))) {
        setLoadingLogin(false);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const StaffHomeScreen()));
      }
      //SchoolSuperAdmin
      else if (parsedResponse['role'] == "SchoolSuperAdmin" ||
          roleList.contains("SchoolSuperAdmin")) {
        setLoadingLogin(false);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const SuperAdminHome()));
      } else if (parsedResponse['role'] == "SchoolHead") {
        setLoadingLogin(false);

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const SchoolHeadHomeScreen()));
      } else if (parsedResponse['role'] == "Student") {
        setLoadingLogin(false);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) =>  ChildHome()));
      } else {
        setLoadingLogin(false);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            duration: Duration(seconds: 3),
            margin: EdgeInsets.only(bottom: 45, left: 30, right: 30),
            behavior: SnackBarBehavior.floating,
            content: Text(
              "Login credentials mismatch \n Please contact your School Admin... ",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            )));
      }
    } else if (response.statusCode == 401) {
      setLoadingLogin(false);
      var dataa = await response.stream.bytesToString();
      print(dataa);
      snackbarWidget(3, dataa, context);
    } else {
      setLoadingLogin(false);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          duration: Duration(seconds: 1),
          margin: EdgeInsets.only(bottom: 45, left: 30, right: 30),
          behavior: SnackBarBehavior.floating,
          content: Text(
            "Invalid Username or Password...!",
            textAlign: TextAlign.center,
          )));
    }
  }

  Future getToken(BuildContext context) async {
    Map<String, dynamic> data = await parseJWT();
    SharedPreferences pref = await SharedPreferences.getInstance();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    String? token = await FirebaseMessaging.instance.getToken();
    print("firebase token");
    print(token);
    var request = http.Request(
        'POST', Uri.parse('${UIGuide.baseURL}/mobileapp/token/saveusertoken'));
    request.body = json.encode({
      "MobileToken": token,
      "StaffId": data.containsKey('StaffId') ? data['StaffId'] : null,
      "GuardianId": data['GuardianId'],
      "StudentId": data['ChildId'],
      "Type": data['role'] == "Guardian" || data['role'] == "Student"
          ? "Student"
          : "Staff"
    });
    print('Responde body  ${request.body}');
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      log("student Token added");
    } else {
      log("student not added.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-!");
      debugPrint(response.reasonPhrase);
    }
  }

  bool _load = false;
  bool get load => _load;
  setLoad(bool value) {
    _load = value;
    notifyListeners();
  }

  //forgot pssword
  String? item2;
  Future forgotPassword(BuildContext context, String uname) async {
    //  Map<String, dynamic> data = await parseJWT();
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoad(true);
    var headers = {
      'Content-Type': 'application/json',
    };

    var response = await http.post(
        Uri.parse(
            "${UIGuide.baseURL}/request-forgot-password?id=${pref.getString('schoolId')}"),
        body: json.encode({"username": uname}),
        headers: headers);

    setLoad(true);

    print(response);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      ForgotPassword fp = ForgotPassword.fromJson(jsonData);
      setLoad(true);
      item2 = fp.item2;
      print(item2);

      await AwesomeDialog(
              dismissOnTouchOutside: false,
              dismissOnBackKeyPress: false,
              context: context,
              dialogType: DialogType.success,
              animType: AnimType.rightSlide,
              headerAnimationLoop: false,
              title: 'Success',
              desc: item2 == "Email"
                  ? "You can reset your password using the link send on your registered Mail id"
                  : "Your new Username and password will be sent on your registered Mobile no.",
              btnOkOnPress: () async {},
              btnOkColor: Colors.green)
          .show();
      setLoad(false);
      notifyListeners();
    } else if (response.statusCode == 404) {
      await AwesomeDialog(
              dismissOnTouchOutside: false,
              dismissOnBackKeyPress: false,
              context: context,
              dialogType: DialogType.warning,
              animType: AnimType.rightSlide,
              headerAnimationLoop: false,
              title: 'Invalid',
              desc: "Cannot find user with this Username",
              btnOkOnPress: () async {},
              btnOkColor: Colors.orange)
          .show();
      setLoad(false);
    } else {
      await AwesomeDialog(
              dismissOnTouchOutside: false,
              dismissOnBackKeyPress: false,
              context: context,
              dialogType: DialogType.error,
              animType: AnimType.rightSlide,
              headerAnimationLoop: false,
              title: 'Error',
              desc: "Something went wrong",
              btnOkOnPress: () async {},
              btnOkColor: Colors.orange)
          .show();
      setLoad(false);
    }
  }

  //App Review

  //get id
  String? currentMobileViewID;

  Future getMobileViewerId() async {
    Map<String, dynamic> data = await parseJWT();
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    var response = await http.get(
        Uri.parse("${UIGuide.baseURL}/mobileapp/installedUser/getViewId?studentId=${data['ChildId']}"),
        headers: headers);
    try {
      if (response.statusCode == 200) {
        setLoading(true);
        final data = json.decode(response.body);
        log(data.toString());
        GetUserMobielViewId mob = GetUserMobielViewId.fromJson(data);
        currentMobileViewID =mob.viewId;
        print("Current mobileviewid  = $currentMobileViewID");

        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        print(response.statusCode);
        print("Error in Notification Response");
      }
    } catch (e) {
      setLoading(false);
      print(e);
    }
  }



  String? mobileAppViewersId;
  Future getsavemobileViewer(BuildContext context) async {
    Map<String, dynamic> data = await parseJWT();
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    String? token = await FirebaseMessaging.instance.getToken();
    print("firebase token");
    print(token);
    var request = http.Request(
        'POST', Uri.parse('${UIGuide.baseURL}/mobileapp/installedUser/savemobileViewer'));
    request.body = json.encode(
        {    "StudentId": data['ChildId'],
          "MobileToken": token
        }

    );
    print('Responde body  ${request.body}');
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final String dataa = await response.stream.bytesToString();
      print(dataa);
      mobileAppViewersId = dataa.replaceAll('"', '');
      print(mobileAppViewersId);
      print("student added");
    } else {
      log("student not added.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-!");
      debugPrint(response.reasonPhrase);
    }
  }

  String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
  Future sendUserDetails(BuildContext context) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    String? token = await FirebaseMessaging.instance.getToken();
    print("firebase token");
    print(token);
    var request = http.Request(
        'POST', Uri.parse('${UIGuide.baseURL}/mobileapp/installedUser/savemobileViewerDetails'));
    request.body = json.encode(
        {
          "MobileAppViewersId": currentMobileViewID=="00000000-0000-0000-0000-000000000000" ?(mobileAppViewersId=="00000000-0000-0000-0000-000000000000"?
          null:mobileAppViewersId):currentMobileViewID,
          "ModifiedAt":formattedDate
        }
    );
    print('Responde body  ${request.body}');
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print("student details send");
    } else {
      log("student details not send.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-!");
      debugPrint(response.reasonPhrase);
    }
  }


}
