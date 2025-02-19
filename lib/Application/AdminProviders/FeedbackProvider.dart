import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Domain/Admin/FeedbackCategoryModel.dart';
import '../../Domain/Student/FeedbackModel.dart';
import '../../utils/constants.dart';

class FbProvider with ChangeNotifier {
  List<fbm> categories = [];
  List<ViewStudentDetails> viewstudentdetails = [];
  bool isLoading = false;
  String? errorMessage;

  // Fetch categories
  Future<void> fetchCategories() async {
    final url = Uri.parse('${UIGuide.baseURL}/communication/guardian-feedback-view/get-category');
    SharedPreferences pref = await SharedPreferences.getInstance();

    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer ${pref.getString('accesstoken')}',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        categories = data.map((item) => fbm.fromJson(item)).toList();
      } else {
        errorMessage = 'Failed to load categories. Status code: ${response.statusCode}';
      }
    } catch (error) {
      errorMessage = 'An error occurred: $error';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchFeedbackDetails(String categoryId ,String showreport) async {
    final url = Uri.parse('${UIGuide.baseURL}/communication/guardian-feedback-view/view-guardian-feedback/?categoryId=$categoryId&showReport=$showreport&');
    SharedPreferences pref = await SharedPreferences.getInstance();

    isLoading = true;
    errorMessage = null;
    viewstudentdetails = [];
    notifyListeners();

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer ${pref.getString('accesstoken')}',
          'Content-Type': 'application/json',
        },
      );

      // Print response body for debugging
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        List<ViewStudentDetails> templist7 = List<ViewStudentDetails>.from(
            data["viewStudentDetails"].map((x) => ViewStudentDetails.fromJson(x)));
        viewstudentdetails.addAll(templist7);

      } else {
        errorMessage = 'Failed to load feedback details. Status code: ${response.statusCode}';
      }
    } catch (error) {
      errorMessage = 'An error occurred: $error';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
