import 'dart:convert';
import 'dart:developer';
import 'package:essconnect/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Domain/Admin/AdminPortalmodel.dart';


class AdminPortalProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool checkSortOrderExists(String sortOrder) {
    return detail.any((post) => post.sortOrder.toString() == sortOrder);
  }

  List<AdminPortal> detail = [];
  int? sortOrder;
  int? savcode;
  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  Future<void> getSortOrder(BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}',
    };

    var response = await http.get(
      Uri.parse('${UIGuide.baseURL}/communication/admin-port/get-sort-order'),
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

  Future<bool> createAdminPost(String title, String matter, String sortOrder) async {
    setLoading(true);

    SharedPreferences pref = await SharedPreferences.getInstance();

    var headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer ${pref.getString('accesstoken')}', // Use the variable for the token
    };

    var requestBody = json.encode({
      "title": title,
      "matter": matter,
      "sortOrder": sortOrder, // Ensure sortOrder is sent as a string
    });

    print('Request Body: $requestBody'); // Debug log for request body

    var request = http.Request(
      'POST',
      Uri.parse('${UIGuide.baseURL}/communication/admin-port/create'),
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

      savcode = response.statusCode;

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 204) {
        setLoading(false);
        return true;
      } else if (response.statusCode == 409) {
        // Handle duplicate title error
        setLoading(false);
        print('Title already exists.');
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

  late List<String?> existingTitles;
  late List<String?> existingSortOrders;

  Future<void> getAdminPost() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}',
    };

    var response = await http.get(
      Uri.parse(
          '${UIGuide.baseURL}/communication/admin-port/admin-port-det-list/'),
      headers: headers,
    );

    log(response.body.toString());

    if (response.statusCode == 200) {
      detail = List<AdminPortal>.from(jsonDecode(response.body)["results"]
          .map((x) => AdminPortal.fromJson(x)));
      print(detail);
      existingTitles = detail.map((item) => item.title).toList();
      print(existingTitles);

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

  Future<bool> updateAdminPost(String id, String title, String matter, String sortOrder) async {
    setLoading(true);
    SharedPreferences pref = await SharedPreferences.getInstance();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}',
    };

    var requestBody = json.encode({
      "title": title,
      "matter": matter,
      "sortOrder": sortOrder,
    });

    try {
      final response = await http.patch(
        Uri.parse(
            '${UIGuide.baseURL}/communication/admin-port/admin-port-update/$id'),
        headers: headers,
        body: requestBody,
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        setLoading(false);
        return true;
      } else {
        setLoading(false);
        print('Failed to update post: ${response.reasonPhrase}');
        return false;
      }
    } catch (e) {
      setLoading(false);
      print('Exception occurred: $e');
      return false;
    }
  }

  Future<bool> deleteAdminPost(String id) async {
    setLoading(true);
    SharedPreferences pref = await SharedPreferences.getInstance();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}',
    };

    try {
      final response = await http.delete(
        Uri.parse(
            '${UIGuide.baseURL}/communication/admin-port/delete-event/$id'),
        headers: headers,
      );

      // Log the response
      log('Delete Response: ${response.statusCode} ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 204) {
        setLoading(false);
        return true;
      } else {
        setLoading(false);
        print('Failed to delete post: ${response.reasonPhrase}');
        return false;
      }
    } catch (e) {
      setLoading(false);
      print('Exception occurred: $e');
      return false;
    }
  }

  //Active or Deactive
  int stsucode = 0;

  Future<bool> activeorNotAdminPost(String id, String title, String matter, bool status, String sortOrder) async {
    setLoading(true);
    SharedPreferences pref = await SharedPreferences.getInstance();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}',
    };

    var requestBody = json.encode({
      "id": id,
      "title": title,
      "matter": matter,
      "active": status,
      "sortOrder": sortOrder,
    });

    try {
      final response = await http.patch(
        Uri.parse(
            '${UIGuide.baseURL}/communication/admin-port/active-event/$id'),
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

        print('Failed to activ post: ${response.reasonPhrase}');
        return false;
      }
    } catch (e) {
      setLoading(false);
      print('Exception occurred: $e');
      return false;
    }
  }

  Future<bool> isTitleDuplicate(String title) async {
    await getAdminPost();
    print(existingTitles);
    print('aakjcbnaklvbav');
    return existingTitles.contains(title);
  }

  Future<bool> isSortOrderDuplicate(String sortOrder) async {
    await getAdminPost();
    return existingSortOrders.contains(sortOrder);
  }
}
