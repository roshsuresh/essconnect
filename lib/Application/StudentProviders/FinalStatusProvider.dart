import 'dart:convert';
import 'dart:developer';
import 'package:essconnect/Domain/Student/TransactionModel.dart';
import 'package:essconnect/Domain/Student/WorldLineModel.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../Domain/Student/RazorPayModel.dart';

class FinalStatusProvider with ChangeNotifier {
///////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////            payment             /////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////

  String? reponseCode;
  String? reponseMsg;
  Future transactionStatus(String orderID,String responseMsg) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    // print(headers);
    var response = await http.get(
        Uri.parse(
            "${UIGuide.baseURL}/online-payment/paytm/verify-status-app?orderid=$orderID&gatewayResponse=$responseMsg"),
        headers: headers);
    print("${UIGuide.baseURL}/online-payment/paytm/verify-status-app?orderid=$orderID&gatewayResponse=$responseMsg");

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
    SharedPreferences pref = await SharedPreferences.getInstance();

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
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
      ) async
  {
    SharedPreferences pref = await SharedPreferences.getInstance();

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
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
      "${UIGuide.baseURL}/online-payment/world-line/verify-status-app?orderid=$orderID&PaymentGatewayTransactionId=$pgTraID&gatewayResponse=$gatewayresponse",
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

  String? reponseMsgSmart;

  Future transactionStatusSmart(String orderID, String pgTraID,
      String gatewayresponse
      ) async
  {
    SharedPreferences pref = await SharedPreferences.getInstance();

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    var response = await http.get(
        Uri.parse(
            "${UIGuide.baseURL}/online-payment/hdfc-smart-gateway/verify-status-app?orderid=$orderID&PaymentGatewayTransactionId=$pgTraID&gatewayResponse=$gatewayresponse"),
        headers: headers);
    // var response = await http.get(
    //     Uri.parse(
    //         "${UIGuide.baseURL}/online-payment/world-line/verify-status-app?orderid=$orderID&PaymentGatewayTransactionId=$pgTraID"),
    //     headers: headers);
    print("rsponssssssssssssssss");
    log(
      "${UIGuide.baseURL}/online-payment/hdfc-smart-gateway/verify-status-app?orderid=$orderID&PaymentGatewayTransactionId=$pgTraID&gatewayResponse=$gatewayresponse",
    );
    // log(
    //         "${UIGuide.baseURL}/online-payment/world-line/verify-status-app?orderid=$orderID&PaymentGatewayTransactionId=$pgTraID&gatewayResponse=$gatewayresponse",
    //     );

    try {
      if (response.statusCode == 200) {
        Map<String, dynamic> data = await json.decode(response.body);

        log(data.toString());

        SmartFinalStatus smart = SmartFinalStatus.fromJson(data);

        reponseMsgSmart = smart.dbstatus;

        print("reponseMsgSmart  $reponseMsgSmart");

        notifyListeners();
      } else {
        print("Error in  SmartGateway final transaction  response");
      }
    } catch (e) {
      print(e);
    }
  }

  ////////Traknpay
  ////////////////////////////
  String? statusss;
  Future transactionStatusTrakNPay(String orderId,String gatewayresponse) async
  {
    SharedPreferences pref = await SharedPreferences.getInstance();

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    // print(headers);
    var response = await http.get(
        Uri.parse(
            "${UIGuide.baseURL}/online-payment/traknpay/verify-status-app?orderid=$orderId&gatewayResponse=$gatewayresponse"),
        headers: headers);
    print("${UIGuide.baseURL}/online-payment/traknpay/verify-status-app?orderid=$orderId&gatewayResponse=$gatewayresponse");

    try {
      if (response.statusCode == 200) {
        Map<String, dynamic> data = await json.decode(response.body);

        TrakNPatStatus att = TrakNPatStatus.fromJson(data);
        log(data.toString());

        statusss = att.reponseMsg;
        print(statusss);

        notifyListeners();
      } else {
        print("Error in  status  response");
      }
    } catch (e) {
      print(e);
    }
  }


  //BillDesk Response//
///////////////////////+
  String? reponseMsgBillDesk;
  Future transactionStatusBillDesk(String orderID,
      String gatewayresponse
      ) async
  {
    SharedPreferences pref = await SharedPreferences.getInstance();

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    var response = await http.get(
        Uri.parse(
            "${UIGuide.baseURL}/online-payment/billdesk/verify-status-app?orderid=$orderID&gatewayResponse=$gatewayresponse"),
        headers: headers);

    print("rsponssssssssssssssss");
    log(
      "${UIGuide.baseURL}/online-payment/billdesk/verify-status-app?orderid=$orderID&gatewayResponse=$gatewayresponse",
    );


    try {
      if (response.statusCode == 200) {
        Map<String, dynamic> data = await json.decode(response.body);

        log(data.toString());

        BillDeskResponse billdesk = BillDeskResponse.fromJson(data);

        reponseMsgBillDesk = billdesk.reponseMsg;

        print("reponseMsgBillDesk  $reponseMsgBillDesk");

        notifyListeners();
      }
      else {
        print("Error in  BillDesk final transaction  response");
      }
    } catch (e) {
      print(e);
    }
  }

     //Easebuzzz
  String? reponseMsgEasebuzz;
  Future transactionStatusEaseBuzz(String key,String txnid,
      String amount,String productinfo,String firstname,
      String email,String udf1,String udf2,String udf3,
      String udf4,String udf5,String udf6,String udf7,
      String udf8,String udf9,String udf10,
      String status,String mode,String easepayid,
      String bankRefNum,String errorMessgae,String hash
      ) async
  {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final Map<String, dynamic> feeData = {
      "key":key,
      "txnid":txnid,
      "amount":amount,
      "productinfo":productinfo,
      "firstname": firstname,
      "email":email,
      "udf1":udf1,
      "udf2":udf2,
      "udf3":udf3,
      "udf4":udf4,
      "udf5":udf5,
      "udf6":udf6,
      "udf7":udf7,
      "udf8":udf8,
      "udf9":udf9,
      "udf10":udf10,
      "status":status,
      "mode":mode,
      "easepayid":easepayid,
      "bank_ref_num":bankRefNum,
      "error_Message":errorMessgae,
      "hash":hash
    };
    print("passs data");
    print(feeData);

    final response = await http.post(
      Uri.parse('${UIGuide.baseURL}/online-payment/easebuzz/verify-status-app?orderid=$txnid'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${pref.getString('accesstoken')}'
      },
      body: jsonEncode(feeData),
    );

   print('${UIGuide.baseURL}/online-payment/easebuzz/verify-status-app?orderid=$txnid');

    try {
      if (response.statusCode == 200) {
        Map<String, dynamic> data = await json.decode(response.body);

        log(data.toString());

        EaseBuzzResponse easebuzz = EaseBuzzResponse.fromJson(data);

        reponseMsgEasebuzz = easebuzz.reponseMsg;

        print("reponseMsgEasebuzz  $reponseMsgEasebuzz");

        notifyListeners();
      }
      else {
        print("Error in  Easebuzz  final transaction  response");
      }
    } catch (e) {
      print(e);
    }
  }

  //Payu-Hdfc
  String? reponseMsgPayu;
  Future transactionStatusPayuHdfc(String orderID,String gatewayResponse) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    // print(headers);
    var response = await http.get(
        Uri.parse(
            "${UIGuide.baseURL}/online-payment/payu-hdfc/verify-status-app?orderid=$orderID&gatewayResponse=$gatewayResponse"),
        headers: headers);
    print(
        "${UIGuide.baseURL}/online-payment/payu-hdfc/verify-status-app?orderid=$orderID&gatewayResponse=$gatewayResponse");
    try {
      if (response.statusCode == 200) {

        Map<String, dynamic> data = await json.decode(response.body);
        log(data.toString());

        RazorpayFinalStatus raz = RazorpayFinalStatus.fromJson(data);
        reponseMsgPayu = raz.reponseMsg;
        print("payuresssss $reponseMsgPayu");

        notifyListeners();
      } else {
        print("Error in   razor-pay final transaction  response");
      }
    } catch (e) {
      print(e);
    }
  }

}


