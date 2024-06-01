import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
  import 'package:http/http.dart' as http;

import '../../Domain/Student/PortionModel.dart';
import '../../utils/constants.dart';
class StudentPortionProvider with ChangeNotifier{


  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }
  bool _loadingPage = false;
  bool get loadingPage => _loadingPage;
  setLoadingPage(bool value) {
    _loadingPage = value;
    notifyListeners();
  }
  List<StudPortionList> studportionList=[];
  List<StudPortionList> studportionListpre=[];

  Future getStudentPortionList() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
 setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('curiaccesstoken')}'
    };
    try {
      var response = await http.get(
          Uri.parse(
              "${UIGuide.curriculamUrl}/portionentry/datewise"),
          headers: headers);

      if (response.statusCode == 200) {
        print("corect");
        setLoading(true);
       final data = json.decode(response.body);
        log(data.toString());

        List<StudPortionList> templist = List<StudPortionList>.from(
            data["portionList"].map((x) => StudPortionList.fromJson(x)));
        studportionList.addAll(templist);

        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        print("Error in studPortionList response");
      }
    } catch (e) {
      setLoading(false);
      print(e);
    }
  }

  //previous sata

  Future getStudentPortionListPrevious(String status) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoadingPage(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('curiaccesstoken')}'
    };
    try {
      var response = await http.get(
          Uri.parse(
              "${UIGuide.curriculamUrl}/portionentry/$status"),
          headers: headers);

      if (response.statusCode == 200) {
        print("corect");
        setLoadingPage(true);
        final data = json.decode(response.body);
        log(data.toString());

        List<StudPortionList> templist = List<StudPortionList>.from(
            data["portionList"].map((x) => StudPortionList.fromJson(x)));
        studportionListpre.addAll(templist);

        setLoadingPage(false);
        notifyListeners();
      } else {
        setLoadingPage(false);
        print("Error in studPortionList response");
      }
    } catch (e) {
      setLoadingPage(false);
      print(e);
    }
  }



  List<StudPortionDetials> studportionDetailList=[];
  List<PhotoList> photoList=[];
  List<String> imageUrls = [];
  List<String> imageName = [];

  Future getStudentPortionDetailList(String date,String status) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('curiaccesstoken')}'
    };
    try {
      var response = await http.get(
          Uri.parse(
              "${UIGuide.curriculamUrl}/portionentry/getportions/$date/$status"),
          headers: headers);
      print(response);
      print( "${UIGuide.curriculamUrl}/portionentry/getportions/$date/$status");

      if (response.statusCode == 200) {
        print("correct");
        setLoading(true);
        final data = json.decode(response.body);
        log(data.toString());

        List<StudPortionDetials> templist = List<StudPortionDetials>.from(
            data.map((x) => StudPortionDetials.fromJson(x)));
        studportionDetailList.addAll(templist);
        print("studlengthh   ${studportionDetailList.length}");


        // List<PhotoList> photoList = studportionDetailList.isNotEmpty ? studportionDetailList[0].photoList! : [];
        //
        //
        // print("image urlsssss");
        // print(imageUrls.length);
        // log(imageUrls.toString());
        //
        // log(photoList.toString());
        // print(photoList.length);
        // print('photoliststt');
        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        print("Error in studPortionList response");
      }
    } catch (e) {
      setLoading(false);
      print(e);
    }
  }

}