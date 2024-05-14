import 'dart:convert';
import 'dart:developer';
import 'package:essconnect/Domain/Student/RazorPayModel.dart';
import 'package:essconnect/Domain/Student/TransactionModel.dart';
import 'package:essconnect/Domain/Student/WorldLineModel.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class FinalStatusProvider with ChangeNotifier {
///////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////            payment             /////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////

  String? reponseCode;
  String? reponseMsg;
  Future transactionStatus(String orderID) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    // print(headers);
    var response = await http.get(
        Uri.parse(
            "${UIGuide.baseURL}/online-payment/paytm/verify-status-app?orderid=$orderID"),
        headers: headers);

    try {
      if (response.statusCode == 200) {
        Map<String, dynamic> data = await json.decode(response.body);
        log(data.toString());

        PaytmFinalStatusModel att = PaytmFinalStatusModel.fromJson(data);
        reponseCode = att.reponseCode;
        reponseMsg = att.reponseMsg;

        notifyListeners();
      } else {
        print("Error in   Paytm final transaction  response");
      }
    } catch (e) {
      print(e);
    }
  }

  String? reponseMsgRazor;
  Future transactionStatusRazorPay(String orderID,String gatewayResponse) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    // print(headers);
    var response = await http.get(
        Uri.parse(
            "${UIGuide.baseURL}/online-payment/razor-pay/verify-status-app?orderid=$orderID&gatewayResponse=$gatewayResponse"),
        headers: headers);
    print(
        "${UIGuide.baseURL}/online-payment/razor-pay/verify-status-app?orderid=$orderID&gatewayResponse=$gatewayResponse");
    try {
      if (response.statusCode == 200) {
        Map<String, dynamic> data = await json.decode(response.body);
        log(data.toString());

        RazorpayFinalStatus raz = RazorpayFinalStatus.fromJson(data);
        reponseMsgRazor = raz.reponseMsg;

        notifyListeners();
      } else {
        print("Error in   razor-pay final transaction  response");
      }
    } catch (e) {
      print(e);
    }
  }

  String? reponseCodeWorldLine;
  Future transactionStatusWorldLine(String orderID, String pgTraID,
     String gatewayresponse
      ) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    var response = await http.get(
        Uri.parse(
            "${UIGuide.baseURL}/online-payment/world-line/verify-status-app?orderid=$orderID&PaymentGatewayTransactionId=$pgTraID&gatewayResponse=$gatewayresponse"),
        headers: headers);
    // var response = await http.get(
    //     Uri.parse(
    //         "${UIGuide.baseURL}/online-payment/world-line/verify-status-app?orderid=$orderID&PaymentGatewayTransactionId=$pgTraID"),
    //     headers: headers);
    print("rsponssssssssssssssss");
    log(
      "${UIGuide.baseURL}/online-payment/world-line/verify-status-app?orderid=$orderID&PaymentGatewayTransactionId=$pgTraID",
    );
    // log(
    //         "${UIGuide.baseURL}/online-payment/world-line/verify-status-app?orderid=$orderID&PaymentGatewayTransactionId=$pgTraID&gatewayResponse=$gatewayresponse",
    //     );

    try {
      if (response.statusCode == 200) {
        Map<String, dynamic> data = await json.decode(response.body);

        log(data.toString());

        WorldLineStatusModel world = WorldLineStatusModel.fromJson(data);

        reponseCodeWorldLine = world.reponseCode;

        print(reponseCodeWorldLine);

        notifyListeners();
      } else {
        print("Error in   WorldLine final transaction  response");
      }
    } catch (e) {
      print(e);
    }
  }
}
