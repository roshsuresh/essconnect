import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../Domain/Staff/StaffProfile.dart';
import '../../utils/constants.dart';

Map? staffProfleRespo;
Map? staffResponse;
Map? staffPhotoResponse;

class StaffProfileProvider with ChangeNotifier {
  String? name;
  String? section;
  String? designation;
  String? mobileNo;
  String? emailid;
  String? dateOfBirth;
  String? userName;
  String? shortname;
  String? gender;
  String? address;
  String? staffRole;
  String? photo;

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future staff_profileData() async {
    setLoading(true);
    SharedPreferences pref = await SharedPreferences.getInstance();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    setLoading(true);
    var response = await http.get(
        Uri.parse("${UIGuide.baseURL}/mobileapp/staff/profile"),
        headers: headers);
    try {
      if (response.statusCode == 200) {
        setLoading(true);
        staffProfleRespo = await json.decode(response.body);
        staffResponse = await staffProfleRespo!['staffprofile'];
        Staffprofile stf =
            Staffprofile.fromJson(staffProfleRespo!['staffprofile']);
        setLoading(true);
        photo = stf.photo;

        name = stf.name;
        section = stf.section;
        designation = stf.designation;
        mobileNo = stf.mobileNo;
        emailid = stf.emailid;
        dateOfBirth = stf.dateOfBirth;
        shortname = stf.shortname;
        address = stf.address;
        gender = stf.gender;
        setLoading(false);

        notifyListeners();
      } else {
        print("Error in Staff Profile Response");
      }
    } catch (e) {
      print(e);
    }
  }
}
