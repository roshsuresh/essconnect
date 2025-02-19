import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../Domain/Student/FeedbackModel.dart';
import '../../Domain/Student/GaurdianFeedbackModel.dart';
import '../../utils/constants.dart';

class FeedbackProvider with ChangeNotifier {
  List<FeedbackModel> _categories = [];

  List<FeedbackModel> get categories => _categories;

  List<Results5> _feedbackList = [];

  List<Results5> get feedbackList => _feedbackList;

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

  Future<void> fetchFeedbackList() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    try {
      final response = await http.get(
        Uri.parse('${UIGuide.baseURL}/stud-feedback/get-feedback-list'),
        headers: {
          'Authorization': 'Bearer ${pref.getString('accesstoken')}',
          'Content-Type': 'application/json',
        },
      );

      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        // Ensure the response is a Map and contains 'results' key
        final data = json.decode(response.body);
        print('Decoded data: $data');

        // Check if the response contains 'results' key
        if (data.containsKey('stduentFeedBack') && data['stduentFeedBack'] is List) {
          // Map the results list to your model
          _feedbackList = (data['stduentFeedBack'] as List)
              .map((json) => Results5.fromJson(json))
              .toList();
        } else {
          print('Unexpected response structure: $data');
        }

        notifyListeners();
      } else {
        print('Error: ${response.body}');
        throw Exception('Failed to load feedback list');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load feedback list');
    }
  }
}
