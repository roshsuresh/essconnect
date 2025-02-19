import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Domain/Student/FeedbackModel.dart';
import '../../utils/constants.dart';

class FeedbackProvider with ChangeNotifier {
  List<FeedbackModel> _categories = [];

  List<FeedbackModel> get categories => _categories;

  // Fetch categories method
  Future<void> fetchCategories() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    final response = await http.get(
      Uri.parse('${UIGuide.baseURL}/stud-feedback/get-category'),
      headers: {
        'Authorization': 'Bearer ${pref.getString('accesstoken')}',
        'Content-Type': 'application/json',
      },
    );

    print('Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      _categories = (data as List).map((json) => FeedbackModel.fromJson(json)).toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  // Submit feedback method
  Future<void> submitFeedback(FeedbackSubmissionModel feedback) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    try {
      final response = await http.post(
        Uri.parse('${UIGuide.baseURL}/stud-feedback/create'),
        headers: {
          'Authorization': 'Bearer ${pref.getString('accesstoken')}',
          'Content-Type': 'application/json',
        },
        body: json.encode(feedback.toJson()),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 204) {
        print('Feedback submitted successfully');
      } else if (response.statusCode == 400) {
        print('Bad request: ${response.body}');
        throw Exception('Bad request');
      } else if (response.statusCode == 401) {
        print('Unauthorized: ${response.body}');
        throw Exception('Unauthorized access');
      } else {
        print('Error: ${response.body}');
        throw Exception('Failed to submit feedback');
      }
    } catch (e) {
      print('Error occurred: $e');
      throw Exception('Failed to submit feedback');
    }
  }
}
