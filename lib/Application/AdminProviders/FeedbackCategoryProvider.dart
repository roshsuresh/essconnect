import 'dart:convert';
import 'dart:developer';
import 'package:essconnect/Presentation/Admin/FeedbackCategory.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Domain/Admin/FeedbackCategoryModel.dart';
import '../../utils/constants.dart';


class FeedbackCategoryProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool checkSortOrderExists(String sortOrder) {
    return detail.any((post) => post.sortOrder.toString() == sortOrder);
  }

  List<Results> detail = [];
  int? sortOrder;
  int? savcode;
  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  Future<void> getSortOrder(BuildContext context) async {
    setLoading(true);
    SharedPreferences pref = await SharedPreferences.getInstance();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}',
    };

    var response = await http.get(
      Uri.parse(
          '${UIGuide.baseURL}/communication/feedback-category/get-sort-order'),
      headers: headers,
    );

    log(response.body.toString());

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      sortOrder = data['sortOrder'];
      print("sortordrrrrrrr $sortOrder");
      setLoading(false);
      notifyListeners();
    } else {
      print(response.reasonPhrase);
      setLoading(false);
      notifyListeners();
    }
  }

  Future<bool> createFeedback(Map<String, dynamic> payload) async {
    setLoading(true);
    SharedPreferences pref = await SharedPreferences.getInstance();

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}', // Use the variable for the token
    };

    var requestBody = json.encode(payload); // Payload sent as JSON
    print('Request Body: $requestBody'); // Debug log for request body

    var request = http.Request(
      'POST',
      Uri.parse(
          '${UIGuide.baseURL}/communication/feedback-category/create'),
    );

    request.body = requestBody;
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();
      String responseBody = await response.stream.bytesToString();

      // Log the response details
      print('Response Status Code: ${response.statusCode}');
      print('Response Headers: ${response.headers}');
      print('Response Body: $responseBody');

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 204) {
        setLoading(false);
        return true;
      } else if (response.statusCode == 409) {
        // Handle duplicate title error
        setLoading(false);
        print('Category already exists.');
        return false; // Title conflict occurred
      } else {
        setLoading(false);
        print('Failed to create post: ${response.reasonPhrase}');
        return false;
      }
    } catch (e) {
      setLoading(false);
      print('Exception occurred: $e');
      return false;
    }
  }

  late List<String?> existingCategories;
  late List<String?> existingSortOrders;

  Future<void> feedbackList() async {
    setLoading(true);
    SharedPreferences pref = await SharedPreferences.getInstance();

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}',
    };

    var response = await http.get(
      Uri.parse(
          '${UIGuide.baseURL}/communication/feedback-category/feedback-category-det-list/'),
      headers: headers,
    );

    log(response.body.toString());

    if (response.statusCode == 200) {
      detail = List<Results>.from(
          jsonDecode(response.body)["results"].map((x) => Results.fromJson(x)));
      print(detail);
      existingCategories = detail.map((item) => item.category).toList();
      print(existingCategories);

      existingSortOrders =
          detail.map((item) => item.sortOrder.toString()).toList();
      print(existingSortOrders);

      setLoading(false);
      notifyListeners();
    } else {
      print(response.reasonPhrase);
      setLoading(false);
      notifyListeners();
    }
  }

  Results? selectedFeedbackCategory;

  Future<void> fetchFeedbackCategory(String postId) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}',
    };
    print('ackjvbasdkkkk');
    try {
      final response = await http.get(
        Uri.parse(
            '${UIGuide.baseURL}/communication/feedback-category/feedback-category-det-by-id/$postId'),
        headers: headers,
      );

      // Log the response status code and body for debugging
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        selectedFeedbackCategory = Results.fromJson(data['feedbackCategoryDetails']);
        print(selectedFeedbackCategory!.category.toString());
        notifyListeners();
      } else {
        throw Exception(
            'Failed to load feedback category with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching feedback category: $e');
    }
  }

  Future<bool> updateFeedbackCategory(BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}',
    };

    var requestBody = jsonEncode(selectedFeedbackCategory);

    try {
      final response = await http.patch(
        Uri.parse(
            '${UIGuide.baseURL}/communication/feedback-category/feedback-category-update/${selectedFeedbackCategory!.id.toString()}'),
        headers: headers,
        body: requestBody,
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
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
            'Successfully Submitted',
            textAlign: TextAlign.center,
          ),
        ));
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Feedbackcategory()));
        return true;
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
            'Something went wrong',
            textAlign: TextAlign.center,
          ),
        ));
        print('Failed to update post: ${response.reasonPhrase}');
        return false;
      }
    } catch (e) {
      setLoading(false);
      print('Exception occurred: $e');
      return false;
    }
  }

  Future<bool> deleteFeedback(BuildContext context, String id) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}',
    };

    try {
      final response = await http.delete(
        Uri.parse(
            '${UIGuide.baseURL}/communication/feedback-category/delete-event/$id'),
        headers: headers,
      );

      // Log the response
      log('Delete Response: ${response.statusCode} ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 204) {
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
            'Successfully deleted',
            textAlign: TextAlign.center,
          ),
        ));
        return true;
      } else {
        setLoading(false);
        print('Failed to delete post: ${response.reasonPhrase}');
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          duration: Duration(seconds: 1),
          margin: EdgeInsets.only(bottom: 80, left: 30, right: 30),
          behavior: SnackBarBehavior.floating,
          content: Text(
            'This category is used somewhere else, so cannot be deleted',
            textAlign: TextAlign.center,
          ),
        ));
        return false;
      }
    } catch (e) {
      setLoading(false);
      print('Exception occurred: $e');
      return false;
    }
  }

  Future<bool> isCategoryDuplicate(String title) async {
    await feedbackList();
    print(existingCategories);
    print('aakjcbnaklvbav');
    return existingCategories.contains(title);
  }

  Future<bool> isSortOrderDuplicate(String sortOrder) async {
    await feedbackList();
    return existingSortOrders.contains(sortOrder);
  }

  int stsucode = 0;

  Future<bool> activeorNotAdminPost(String id, String category, bool status, String sortOrder) async {
    setLoading(true);
    SharedPreferences pref = await SharedPreferences.getInstance();

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}',
    };

    var requestBody = json.encode({
      "id": id,
      "category": category,
      "active": status,
      "sortOrder": sortOrder,
    });

    try {
      final response = await http.patch(
        Uri.parse(
            '${UIGuide.baseURL}/communication/feedback-category/active-event/$id'),
        headers: headers,
        body: requestBody,
      );
      print(response);
      print(requestBody);
      stsucode = response.statusCode;
      if (response.statusCode == 200 || response.statusCode == 204) {
        setLoading(false);
        return true;
      } else {
        setLoading(false);

        print('Failed to active post: ${response.reasonPhrase}');
        return false;
      }
    } catch (e) {
      setLoading(false);
      print('Exception occurred: $e');
      return false;
    }
  }
}
