import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../Domain/Student/GalleryModel.dart';
import '../../utils/constants.dart';

List? galleryResponse;
List? galleryAttachResponse;

class GalleryProvider with ChangeNotifier {
  late GalleryphotosModel galleryphotosModel;

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<GalleryModel?> getGalleyList(context) async {
    GalleryModel gallery;
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    setLoading(true);
    var response = await http.get(
        Uri.parse("${UIGuide.baseURL}/mobileapp/parents/gallery"),
        headers: headers);
    print("${UIGuide.baseURL}/mobileapp/parents/gallery");
    try {
      if (response.statusCode == 200) {
        setLoading(true);
        final data = json.decode(response.body);
        galleryResponse = data["gallerydetails"];
        gallery = GalleryModel.fromJson(data);
        setLoading(false);
        notifyListeners();
      } else {
        print(response.statusCode);
        setLoading(false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            duration: Duration(seconds: 2),
            margin: EdgeInsets.only(bottom: 80, left: 30, right: 30),
            behavior: SnackBarBehavior.floating,
            content: Text(
              'Something went wrong...',
              textAlign: TextAlign.center,
            ),
          ),
        );
        print("Error in Response");
      }
    } catch (e) {
      setLoading(false);
      print(e);
    }
    return null;
  }

  bool _loadingg = false;
  bool get loadingg => _loadingg;
  setLoadingg(bool value) {
    _loadingg = value;
    notifyListeners();
  }

  List galleryList = [];
  Future galleyAttachment(String galleryId) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoadingg(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    String galleryid = galleryId.toString();

    var response = await http.get(
        Uri.parse("${UIGuide.baseURL}/parent-home/gallery-photos/$galleryid"),
        headers: headers);
    setLoadingg(true);
    try {
      if (response.statusCode == 200) {
        setLoadingg(true);
        final data = json.decode(response.body);
        log(data.toString());
        galleryList = data;
        print(galleryList);
        setLoadingg(false);
        notifyListeners();
      } else {
        setLoadingg(false);
        print("error in gallery response");
      }
    } catch (e) {
      setLoadingg(false);
      print(e);
    }
  }
}
