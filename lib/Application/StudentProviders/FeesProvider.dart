import 'dart:convert';
import 'dart:developer';
import 'package:essconnect/Domain/Student/RazorPayModel.dart';
import 'package:essconnect/Domain/Student/TrakNpayModel.dart';
import 'package:essconnect/Domain/Student/TransactionModel.dart';
import 'package:essconnect/Domain/Student/WorldLineModel.dart';
import 'package:essconnect/Presentation/Admin/WebViewLogin.dart';
import 'package:essconnect/Presentation/Student/FeeWebScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../Domain/Student/FeesModel.dart';
import '../../utils/constants.dart';

List<FeeFeesInstallments> feesList = [];

class FeesProvider with ChangeNotifier {
  late String installmentTerm;
  late int installamount;
  bool? allowPartialPayment;

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  List<FeeFeesInstallments> feeList = [];
  List<FeeBusInstallments> busFeeList = [];
  List<Transactiontype> transactionList = [];

  String? lastOrderStatus;
  String? lastTransactionStartDate;
  double? lastTransactionAmount;
  String? paymentGatewayId;
  String? readableOrderId;
  int? orderId;
  bool? isLocked;

  Future<Object> feesData() async {
    setLoading(true);
    SharedPreferences _pref = await SharedPreferences.getInstance();

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    setLoading(true);
    var response = await http.get(
        Uri.parse("${UIGuide.baseURL}/onlinepayment/initialvalues"),
        headers: headers);

    try {
      if (response.statusCode == 200) {
        setLoading(true);
        print("Fee Response..........");

        Map<String, dynamic> data = await json.decode(response.body);
        FeeInitialModel inita = FeeInitialModel.fromJson(data);
        isLocked = inita.isLocked;
        Map<String, dynamic> feeinitial =
        await data['onlineFeePaymentStudentDetails'];
        Map<String, dynamic> feedata = await feeinitial['feeOrder'];
        FeeOrder fee = FeeOrder.fromJson(feedata);
        OnlineFeePayModel feemode = OnlineFeePayModel.fromJson(feeinitial);
        allowPartialPayment = feemode.allowPartialPayment;
        print("--------------$allowPartialPayment");
        lastOrderStatus = fee.lastOrderStatus;
        lastTransactionStartDate = fee.lastTransactionStartDate;
        lastTransactionAmount = fee.lastTransactionAmount;
        readableOrderId = fee.readableOrderId;
        paymentGatewayId = fee.paymentGatewayId;
        orderId = fee.lastOrderId;
        setLoading(true);
        List<FeeFeesInstallments> templist = List<FeeFeesInstallments>.from(
            feeinitial['feeFeesInstallments']
                .map((x) => FeeFeesInstallments.fromJson(x)));
        feeList.addAll(templist);
        setLoading(true);
        print('feeeeee');
        List<FeeBusInstallments> templistt = List<FeeBusInstallments>.from(
            feeinitial['feeBusInstallments']
                .map((x) => FeeBusInstallments.fromJson(x)));
        busFeeList.addAll(templistt);
        ("bus errrro");
        List<Transactiontype> templis = List<Transactiontype>.from(
            feeinitial['transactiontype']
                .map((x) => Transactiontype.fromJson(x)));
        transactionList.addAll(templis);
        print(transactionList.length);

        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        print("Error in fee response");
      }
    } catch (e) {
      setLoading(false);
      print(e);
    }
    return true;
  }

  //select all fees
  bool isselectAll = false;
  void selectAll() {
    if (feesList.first.checkedFees == true) {
      feesList.forEach((element) {
        element.checkedFees = false;
      });
      isselectAll = false;
    } else {
      feesList.forEach((element) {
        element.checkedFees = true;
      });
      isselectAll = true;
    }

    notifyListeners();
  }

//fee
  double totalFees = 0;
  double? total = 0;
  double totalBusFee = 0;
  List selecteCategorys = [];
  void onFeeSelected(bool selected, feeName, int index, feeNetDue) {
    feeList[0].enabled = true;
    if (feeList[index].enabled == true) {
      if (selected == true) {
        selecteCategorys.add(feeName);

        index == (feeList.length) - 1
            ? "--"
            : feeList[index + 1].enabled = true;
        feeList[index].selected = true;

        print(index);
        final double tot = feeNetDue;
        print(feeName);
        print(tot);
        totalFees = tot + totalFees;
        print(totalFees);
        total = totalFees + totalBusFee;
        print(total);
        print("selecteCategorys   $selecteCategorys");
        notifyListeners();
      }
      // else if(feesList[index+1].selected  == true){
      //   selected != true;
      // }

      else {
        int lastindex = feeList.length - 1;
        print(lastindex);
        if (feeList[lastindex].selected == true) {
          selecteCategorys.removeAt(lastindex);
          feeList[lastindex].selected = false;
          feeList[lastindex].enabled = true;
          final double? tot = feeList[lastindex].netDue;
          totalFees = totalFees - tot!;
          total = totalFees + totalBusFee;
          notifyListeners();
        } else if (feeList[index + 1].selected == true) {
          print("demooo");
          notifyListeners();
          print(selecteCategorys);
        } else if (selecteCategorys.remove(feeName)) {
          feeList[index].selected = false;
          index == (feeList.length) - 1
              ? "--"
              : feeList[index + 1].enabled = false;
          final double tot = feeNetDue;
          totalFees = totalFees - tot;
          total = totalFees + totalBusFee;
          print(total);
          print("selecteCategorys   $selecteCategorys");
          notifyListeners();
        }
      }
    } else {
      print("no dta");
    }
  }

  //bus fee

  List selectedBusFee = [];

  void onBusSelected(bool selected, busfeeName, int index, feeNetDue) {
    busFeeList[0].enabled = true;
    if (busFeeList[index].enabled == true) {
      if (selected == true) {
        selectedBusFee.add(busfeeName);

        index == (busFeeList.length) - 1
            ? "--"
            : busFeeList[index + 1].enabled = true;
        busFeeList[index].selected = true;

        print(index);
        final double tot = feeNetDue;
        print("busfeeName: $busfeeName");
        print("tot  $tot");
        totalBusFee = tot + totalBusFee;
        print("totalBusFee  $totalBusFee");
        total = totalFees + totalBusFee;
        print("total  $total");
        print("selecteCategorys   $selectedBusFee");
        notifyListeners();
      }
      // else if(feesList[index+1].selected  == true){
      //   selected != true;
      // }

      else {
        int lastindex = busFeeList.length - 1;
        print(lastindex);
        if (busFeeList[lastindex].selected == true) {
          selectedBusFee.removeAt(lastindex);
          busFeeList[lastindex].selected = false;
          busFeeList[lastindex].enabled = true;
          final double? tot = busFeeList[lastindex].netDue;
          print('tot $tot');
          print("totalBusFee  $totalBusFee");
          totalBusFee = totalBusFee - tot!;
          print('REmoved totalfee $totalBusFee');
          total = totalFees + totalBusFee;
          print(total);

          notifyListeners();
        } else if (busFeeList[index + 1].selected == true) {
          print("demooo");
          notifyListeners();
          print(selectedBusFee);
        } else if (selectedBusFee.remove(busfeeName)) {
          busFeeList[index].selected = false;
          index == (busFeeList.length) - 1
              ? "--"
              : busFeeList[index + 1].enabled = false;
          final double tot = feeNetDue;
          totalBusFee = totalBusFee - tot;
          total = totalFees + totalBusFee;
          print(total);
          print("selecteCategorys   $selectedBusFee");
          notifyListeners();
        }
      }
    } else {
      print("no dta");
    }
  }

  //total

  void totalFee() async {
    total = totalFees + totalBusFee;
    print(total);
    notifyListeners();
  }

  // pdf download

  String? extension;
  String? name;
  String? url;
  String? idd;

  Future pdfDownload(String orderID) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    // print(headers);
    var response = await http.get(
        Uri.parse(
            "${UIGuide.baseURL}/paymenthistory/printfeespayment/$orderID"),
        headers: headers);

    try {
      if (response.statusCode == 200) {
        Map<String, dynamic> data = await json.decode(response.body);

        FilePathPdfDownload att = FilePathPdfDownload.fromJson(data);
        extension = att.extension;
        name = att.name;
        url = att.url;
        idd = att.id;
        print(url);

        notifyListeners();
      } else {
        print("Error in   pdf download  response");
      }
    } catch (e) {
      print(e);
    }
  }

  //status Payment

  String? statusss;

  Future payStatusButton(String orderId) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    // print(headers);
    var response = await http.get(
        Uri.parse(
            "${UIGuide.baseURL}/onlinepayment/get-order-details/$orderId"),
        headers: headers);

    try {
      if (response.statusCode == 200) {
        Map<String, dynamic> data = await json.decode(response.body);

        StatusPayment att = await StatusPayment.fromJson(data);
        log(data.toString());

        statusss = await att.status;
        print(statusss);

        notifyListeners();
      } else {
        setLoading(false);
        print("Error in  status  response");
      }
    } catch (e) {
      print(e);
    }
  }

//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////    get data  1 index  PAYTM    ///////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////

  String? mid1;
  String? txnorderId1;
  String? callbackUrl1;
  String? txnAmount1;
  String? customerID1;
  String? mobile1;
  String? emailID1;
  bool? isStaging1;
  String? txnToken1;

  Future getDataOne(String fees, String idFee, String feeAmount, String amount,
      String gateName) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);

    final http.Response response = await http.post(
      Uri.parse(
          '${UIGuide.baseURL}/online-payment/paytm/get-data?ismobileapp=true'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
      },
      body: jsonEncode({
        "Description": "Online Fees Payment",
        "TransactionType": [
          {"name": fees, "id": idFee, "amount": feeAmount}
        ],
        "ReturnUrl": "",
        "Amount": amount,
        "PaymentGateWay": gateName
      }),
    );

    print(json.encode({
      "Description": "Online Fees Payment",
      "TransactionType": [
        {"name": fees, "id": idFee, "amount": feeAmount}
      ],
      "ReturnUrl": "",
      "Amount": amount,
      "PaymentGateWay": gateName
    }));

    try {
      if (response.statusCode == 200) {
        Map<String, dynamic> data = await json.decode(response.body);

        print(data);
        TransactionModel txn = TransactionModel.fromJson(data);
        mid1 = txn.mid;
        txnorderId1 = txn.orderId;
        callbackUrl1 = txn.callbackUrl;
        isStaging1 = txn.isStaging;
        txnToken1 = txn.txnToken;
        print(mid1);

        Map<String, dynamic> txnAmnt = await data['txnAmount'];
        TxnAmount amnt = TxnAmount.fromJson(txnAmnt);
        txnAmount1 = amnt.value;

        Map<String, dynamic> userInf = await data['userInfo'];
        UserInfo user = UserInfo.fromJson(userInf);
        customerID1 = user.custId;
        emailID1 = user.email;
        mobile1 = user.mobile;

        notifyListeners();
      } else {
        setLoading(false);
        print("Error in  transaction index one  response");
      }
    } catch (e) {
      print(e);
    }
  }

//////////////////////////////////////////                             ||||||||
///////    get data  1 index  PAYTM   ---------------  "BUS FEES"      ||||||||
//////////////////////////////////////////                             ||||||||

  String? mid1B;
  String? txnorderId1B;
  String? callbackUrl1B;
  String? txnAmount1B;
  String? customerID1B;
  String? mobile1B;
  String? emailID1B;
  bool? isStaging1B;
  String? txnToken1B;

  Future getDataOneBus(String fees, String idFee, String feeAmount,
      String amount, String gateName) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);

    final http.Response response = await http.post(
      Uri.parse(
          '${UIGuide.baseURL}/online-payment/paytm/get-data?ismobileapp=true'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
      },
      body: jsonEncode({
        "Description": "Online Fees Payment",
        "TransactionType": [
          {"name": fees, "id": idFee, "amount": feeAmount}
        ],
        "ReturnUrl": "",
        "Amount": amount,
        "PaymentGateWay": gateName
      }),
    );

    print(json.encode({
      "Description": "Online Fees Payment",
      "TransactionType": [
        {"name": fees, "id": idFee, "amount": feeAmount}
      ],
      "ReturnUrl": "",
      "Amount": amount,
      "PaymentGateWay": gateName
    }));

    try {
      if (response.statusCode == 200) {
        Map<String, dynamic> data = await json.decode(response.body);

        print(data);
        TransactionModel txn = TransactionModel.fromJson(data);
        mid1B = txn.mid;
        txnorderId1B = txn.orderId;
        callbackUrl1B = txn.callbackUrl;
        isStaging1B = txn.isStaging;
        txnToken1B = txn.txnToken;
        print(mid1B);

        Map<String, dynamic> txnAmnt = await data['txnAmount'];
        TxnAmount amnt = TxnAmount.fromJson(txnAmnt);
        txnAmount1B = amnt.value;

        Map<String, dynamic> userInf = await data['userInfo'];
        UserInfo user = UserInfo.fromJson(userInf);
        customerID1B = user.custId;
        emailID1B = user.email;
        mobile1B = user.mobile;

        notifyListeners();
      } else {
        setLoading(false);
        print("Error in  transaction index one Bus  response");
      }
    } catch (e) {
      print(e);
    }
  }

///////////////////////////////////////////////////////////////////////////////////////
//////////////////////////    get data  2 index PAYTM   //////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////

  String? mid2;
  String? txnorderId2;
  String? callbackUrl2;
  String? txnAmount2;
  String? customerID2;
  String? mobile2;
  String? emailID2;
  bool? isStaging2;
  String? txnToken2;

  Future getDataTwo(String fees, String idFee, String feeAmount, String buss,
      String idBus, String busAmount, String amount, String gateName) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);

    final http.Response response = await http.post(
      Uri.parse(
          '${UIGuide.baseURL}/online-payment/paytm/get-data?ismobileapp=true'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
      },
      body: jsonEncode({
        "Description": "Online Fees Payment",
        "TransactionType": [
          {"name": fees, "id": idFee, "amount": feeAmount},
          {"name": buss, "id": idBus, "amount": busAmount}
        ],
        "ReturnUrl": "",
        "Amount": amount,
        "PaymentGateWay": gateName
      }),
    );

    print(json.encode({
      "Description": "Online Fees Payment",
      "TransactionType": [
        {"name": fees, "id": idFee, "amount": feeAmount},
        {"name": buss, "id": idBus, "amount": busAmount}
      ],
      "ReturnUrl": "",
      "Amount": amount,
      "PaymentGateWay": gateName
    }));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = await json.decode(response.body);

      print(data);
      TransactionModel txn = TransactionModel.fromJson(data);
      mid2 = txn.mid;
      txnorderId2 = txn.orderId;
      callbackUrl2 = txn.callbackUrl;
      isStaging2 = txn.isStaging;
      txnToken2 = txn.txnToken;
      print(mid2);

      Map<String, dynamic> txnAmnt = await data['txnAmount'];
      TxnAmount amnt = TxnAmount.fromJson(txnAmnt);
      txnAmount2 = amnt.value;

      Map<String, dynamic> userInf = await data['userInfo'];
      UserInfo user = UserInfo.fromJson(userInf);
      customerID2 = user.custId;
      emailID2 = user.email;
      mobile2 = user.mobile;

      notifyListeners();
    } else {
      setLoading(false);
      print("Error in  transaction index TWO  response");
    }
  }

//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////               RAZORPAY         ///////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////    get data  1 index  RAZORPAY    ////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////

  String? key1Razo;
  String? amount1Razo;
  String? name1Razo;
  String? description1Razo;
  String? customer1Razo;
  String? email1Razo;
  String? contact1Razo;
  String? order1;
  String? readableOrderid1;
  String? admnNo1;
  String? schoolId1;

  Future getDataOneRAZORPAY(String fees, String idFee, String feeAmount,
      String amount, String gateName) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);

    final http.Response response = await http.post(
      Uri.parse('${UIGuide.baseURL}/online-payment/razor-pay/get-data'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
      },
      body: jsonEncode({
        "Description": "Online Fees Payment",
        "TransactionType": [
          {"name": fees, "id": idFee, "amount": feeAmount}
        ],
        "ReturnUrl": "",
        "Amount": amount,
        "PaymentGateWay": gateName
      }),
    );

    print(json.encode({
      "Description": "Online Fees Payment",
      "TransactionType": [
        {"name": fees, "id": idFee, "amount": feeAmount}
      ],
      "ReturnUrl": "",
      "Amount": amount,
      "PaymentGateWay": gateName
    }));

    try {
      if (response.statusCode == 200) {
        Map<String, dynamic> data = await json.decode(response.body);

        print(data);
        RazorPayModel raz = RazorPayModel.fromJson(data);
        key1Razo = raz.key;
        amount1Razo = raz.amount;
        name1Razo = raz.name;
        description1Razo = raz.description;
        order1 = raz.orderId;

        Map<String, dynamic> pre = await data['prefill'];
        Prefill info = Prefill.fromJson(pre);
        customer1Razo = info.name;
        email1Razo = info.email;
        contact1Razo = info.contact;

        Map<String, dynamic> note = await data['notes'];
        Notes inf = Notes.fromJson(note);
        readableOrderid1 = inf.readableOrderid;
        admnNo1 = inf.admissionNumber;
        schoolId1 =inf.schoold;




        notifyListeners();
      } else {
        setLoading(false);
        print("Error in  transaction index one RAZORPAY response");
      }
    } catch (e) {
      print(e);
    }
  }
/////////////////////////////////////////////
//////////    get data  1 index  RAZORPAY    ----------- "BUS FEES"
/////////////////////////////////////////////

  String? key1RazoBus;
  String? amount1RazoBus;
  String? name1RazoBus;
  String? description1RazoBus;
  String? customer1RazoBus;
  String? email1RazoBus;
  String? contact1RazoBus;
  String? order1Bus;
  String? readableOrderid1Bus;
  String? admNo1Bus;
  String? schoolid1Bus;

  Future getDataOneRAZORPAYBus(String fees, String idFee, String feeAmount,
      String amount, String gateName) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);

    final http.Response response = await http.post(
      Uri.parse('${UIGuide.baseURL}/online-payment/razor-pay/get-data'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
      },
      body: jsonEncode({
        "Description": "Online Fees Payment",
        "TransactionType": [
          {"name": fees, "id": idFee, "amount": feeAmount}
        ],
        "ReturnUrl": "",
        "Amount": amount,
        "PaymentGateWay": gateName
      }),
    );

    print(json.encode({
      "Description": "Online Fees Payment",
      "TransactionType": [
        {"name": fees, "id": idFee, "amount": feeAmount}
      ],
      "ReturnUrl": "",
      "Amount": amount,
      "PaymentGateWay": gateName
    }));

    try {
      if (response.statusCode == 200) {
        Map<String, dynamic> data = await json.decode(response.body);

        print(data);
        RazorPayModel raz = RazorPayModel.fromJson(data);
        key1RazoBus = raz.key;
        amount1RazoBus = raz.amount;
        name1RazoBus = raz.name;
        description1RazoBus = raz.description;
        order1Bus = raz.orderId;

        Map<String, dynamic> pre = await data['prefill'];
        Prefill info = Prefill.fromJson(pre);
        customer1RazoBus = info.name;
        email1RazoBus = info.email;
        contact1RazoBus = info.contact;

        Map<String, dynamic> note = await data['notes'];
        Notes inf = Notes.fromJson(note);
        readableOrderid1Bus = inf.readableOrderid;
        admNo1Bus = inf.admissionNumber;
        schoolid1Bus= inf.schoold;

        notifyListeners();
      } else {
        setLoading(false);
        print("Error in  transaction index one RAZORPAYBus response");
      }
    } catch (e) {
      print(e);
    }
  }

///////////////////////////////////////////////////////////////////////////////////////

//////////////////////////    get data  2 index RAZORPAY   ///////////////////////////

/////////////////////////////////////////////////////////////////////////////////////

  String? key2Razo;
  String? amount2Razo;
  String? name2Razo;
  String? description2Razo;
  String? order2;
  String? customer2Razo;
  String? email2Razo;
  String? contact2Razo;
  String? readableOrderid2;
  String? admNo2;
  String? schoolId2;

  Future getDataTwoRAZORPAY(
      String fees,
      String idFee,
      String feeAmount,
      String buss,
      String idBus,
      String busAmount,
      String amount,
      String gateName) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);

    final http.Response response = await http.post(
      Uri.parse('${UIGuide.baseURL}/online-payment/razor-pay/get-data'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
      },
      body: jsonEncode({
        "Description": "Online Fees Payment",
        "TransactionType": [
          {"name": fees, "id": idFee, "amount": feeAmount},
          {"name": buss, "id": idBus, "amount": busAmount}
        ],
        "ReturnUrl": "",
        "Amount": amount,
        "PaymentGateWay": gateName
      }),
    );

    print(json.encode({
      "Description": "Online Fees Payment",
      "TransactionType": [
        {"name": fees, "id": idFee, "amount": feeAmount},
        {"name": buss, "id": idBus, "amount": busAmount}
      ],
      "ReturnUrl": "",
      "Amount": amount,
      "PaymentGateWay": gateName
    }));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = await json.decode(response.body);

      print(data);
      RazorPayModel raz = RazorPayModel.fromJson(data);
      key2Razo = raz.key;
      amount2Razo = raz.amount;
      name2Razo = raz.name;
      description2Razo = raz.description;
      order2 = raz.orderId;

      Map<String, dynamic> pre = await data['prefill'];
      Prefill info = Prefill.fromJson(pre);
      customer2Razo = info.name;
      email2Razo = info.email;
      contact2Razo = info.contact;

      Map<String, dynamic> note = await data['notes'];
      Notes inf = Notes.fromJson(note);
      readableOrderid2 = inf.readableOrderid;
      admNo2 =inf.admissionNumber;
      schoolId2 = inf.schoold;

      notifyListeners();
    } else {
      setLoading(false);
      print("Error in  transaction index TWO  response");
    }
  }

//////////////////////////////////////////////////////////////////////////////////////////
////////------------------------------ TRAKNPAY  ---------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////    get data  1 index  TRAKNPAY    ////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////

  String? orderIdTPay1;
  String? addressLine1TPay1;
  String? cityTPay1;
  String? udf5TPay1;
  String? stateTPay1;
  String? udf4TPay1;
  String? phoneTPay1;
  String? zipCodeTPay1;
  String? currencyTPay1;
  String? returnUrlFailureTPay1;
  String? hashTPay1;
  String? returnUrlCancelTPay1;
  String? emailTPay1;
  String? countryTPay1;
  String? modeTPay1;
  String? saltTPay1;
  String? amountTPay1;
  String? nameTPay1;
  String? apiKeyTPay1;
  String? udf3TPay1;
  String? udf2TPay1;
  String? returnUrlTPay1;
  String? descriptionTPay1;
  String? udf1TPay1;
  String? addressLine2TPay1;

  Future getDataOneTpay(String fees, String idFee, String feeAmount,
      String amount, String gateName) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);

    final http.Response response = await http.post(
      Uri.parse('${UIGuide.baseURL}/online-payment/traknpay/get-data'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
      },
      body: jsonEncode({
        "Description": "Online Fees Payment",
        "TransactionType": [
          {"name": fees, "id": idFee, "amount": feeAmount}
        ],
        "ReturnUrl": "",
        "Amount": amount,
        "PaymentGateWay": gateName
      }),
    );

    print(json.encode({
      "Description": "Online Fees Payment",
      "TransactionType": [
        {"name": fees, "id": idFee, "amount": feeAmount}
      ],
      "ReturnUrl": "",
      "Amount": amount,
      "PaymentGateWay": gateName
    }));

    try {
      if (response.statusCode == 200) {
        Map<String, dynamic> data = await json.decode(response.body);

        print(data);
        TrackNPayModel trak = TrackNPayModel.fromJson(data);

        orderIdTPay1 = trak.orderId;
        addressLine1TPay1 = trak.addressLine1;
        cityTPay1 = trak.city;
        udf5TPay1 = trak.udf5;
        stateTPay1 = trak.state;
        udf4TPay1 = trak.udf4;
        phoneTPay1 = trak.phone;
        zipCodeTPay1 = trak.zipCode;
        currencyTPay1 = trak.currency;
        returnUrlFailureTPay1 = trak.returnUrlFailure;
        hashTPay1 = trak.hash;
        returnUrlCancelTPay1 = trak.returnUrlCancel;
        emailTPay1 = trak.email;
        countryTPay1 = trak.country;
        modeTPay1 = trak.mode;
        saltTPay1 = trak.salt;
        amountTPay1 = trak.amount;
        nameTPay1 = trak.name;
        apiKeyTPay1 = trak.apiKey;
        udf3TPay1 = trak.udf3;
        udf2TPay1 = trak.udf2;
        returnUrlTPay1 = trak.returnUrl;
        descriptionTPay1 = trak.description;
        udf1TPay1 = trak.udf1;
        addressLine2TPay1 = trak.addressLine2;

        notifyListeners();
      } else {
        setLoading(false);
        print("Error in  transaction index one  response");
      }
    } catch (e) {
      print(e);
    }
  }

//////////////////////////////////////////                             ||||||||
///////    get data  1 index  TRAKNPAY --------------  "BUS FEES"      ||||||||
//////////////////////////////////////////                             ||||||||
  String? orderIdTPay1B;
  String? addressLine1TPay1B;
  String? cityTPay1B;
  String? udf5TPay1B;
  String? stateTPay1B;
  String? udf4TPay1B;
  String? phoneTPay1B;
  String? zipCodeTPay1B;
  String? currencyTPay1B;
  String? returnUrlFailureTPay1B;
  String? hashTPay1B;
  String? returnUrlCancelTPay1B;
  String? emailTPay1B;
  String? countryTPay1B;
  String? modeTPay1B;
  String? saltTPay1B;
  String? amountTPay1B;
  String? nameTPay1B;
  String? apiKeyTPay1B;
  String? udf3TPay1B;
  String? udf2TPay1B;
  String? returnUrlTPay1B;
  String? descriptionTPay1B;
  String? udf1TPay1B;
  String? addressLine2TPay1B;
  Future getDataOneBusTpay(String fees, String idFee, String feeAmount,
      String amount, String gateName) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);

    final http.Response response = await http.post(
      Uri.parse('${UIGuide.baseURL}/online-payment/traknpay/get-data'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
      },
      body: jsonEncode({
        "Description": "Online Fees Payment",
        "TransactionType": [
          {"name": fees, "id": idFee, "amount": feeAmount}
        ],
        "ReturnUrl": "",
        "Amount": amount,
        "PaymentGateWay": gateName
      }),
    );

    print(json.encode({
      "Description": "Online Fees Payment",
      "TransactionType": [
        {"name": fees, "id": idFee, "amount": feeAmount}
      ],
      "ReturnUrl": "",
      "Amount": amount,
      "PaymentGateWay": gateName
    }));

    try {
      if (response.statusCode == 200) {
        Map<String, dynamic> data = await json.decode(response.body);

        print(data);
        TrackNPayModel trak = TrackNPayModel.fromJson(data);

        orderIdTPay1B = trak.orderId;
        addressLine1TPay1B = trak.addressLine1;
        cityTPay1B = trak.city;
        udf5TPay1B = trak.udf5;
        stateTPay1B = trak.state;
        udf4TPay1B = trak.udf4;
        phoneTPay1B = trak.phone;
        zipCodeTPay1B = trak.zipCode;
        currencyTPay1B = trak.currency;
        returnUrlFailureTPay1B = trak.returnUrlFailure;
        hashTPay1B = trak.hash;
        returnUrlCancelTPay1B = trak.returnUrlCancel;
        emailTPay1B = trak.email;
        countryTPay1B = trak.country;
        modeTPay1B = trak.mode;
        saltTPay1B = trak.salt;
        amountTPay1B = trak.amount;
        nameTPay1B = trak.name;
        apiKeyTPay1B = trak.apiKey;
        udf3TPay1B = trak.udf3;
        udf2TPay1B = trak.udf2;
        returnUrlTPay1B = trak.returnUrl;
        descriptionTPay1B = trak.description;
        udf1TPay1B = trak.udf1;
        addressLine2TPay1B = trak.addressLine2;
        setLoading(false);

        notifyListeners();
      } else {
        setLoading(false);
        print("Error in  transaction index one Bus  response");
      }
    } catch (e) {
      print(e);
    }
  }

///////////////////////////////////////////////////////////////////////////////////////
//////////////////////////    get data  2 index TRAKNPAY   ///////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
  String? orderIdTPay2;
  String? addressLine1TPay2;
  String? cityTPay2;
  String? udf5TPay2;
  String? stateTPay2;
  String? udf4TPay2;
  String? phoneTPay2;
  String? zipCodeTPay2;
  String? currencyTPay2;
  String? returnUrlFailureTPay2;
  String? hashTPay2;
  String? returnUrlCancelTPay2;
  String? emailTPay2;
  String? countryTPay2;
  String? modeTPay2;
  String? saltTPay2;
  String? amountTPay2;
  String? nameTPay2;
  String? apiKeyTPay2;
  String? udf3TPay2;
  String? udf2TPay2;
  String? returnUrlTPay2;
  String? descriptionTPay2;
  String? udf1TPay2;
  String? addressLine2TPay2;

  Future getDataTwoTpay(
      String fees,
      String idFee,
      String feeAmount,
      String buss,
      String idBus,
      String busAmount,
      String amount,
      String gateName) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);

    final http.Response response = await http.post(
      Uri.parse('${UIGuide.baseURL}/online-payment/traknpay/get-data'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
      },
      body: jsonEncode({
        "Description": "Online Fees Payment",
        "TransactionType": [
          {"name": fees, "id": idFee, "amount": feeAmount},
          {"name": buss, "id": idBus, "amount": busAmount}
        ],
        "ReturnUrl": "",
        "Amount": amount,
        "PaymentGateWay": gateName
      }),
    );

    print(json.encode({
      "Description": "Online Fees Payment",
      "TransactionType": [
        {"name": fees, "id": idFee, "amount": feeAmount},
        {"name": buss, "id": idBus, "amount": busAmount}
      ],
      "ReturnUrl": "",
      "Amount": amount,
      "PaymentGateWay": gateName
    }));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = await json.decode(response.body);

      print(data);
      TrackNPayModel trak = TrackNPayModel.fromJson(data);

      orderIdTPay2 = trak.orderId;
      addressLine1TPay2 = trak.addressLine1;
      cityTPay2 = trak.city;
      udf5TPay2 = trak.udf5;
      stateTPay2 = trak.state;
      udf4TPay2 = trak.udf4;
      phoneTPay2 = trak.phone;
      zipCodeTPay2 = trak.zipCode;
      currencyTPay2 = trak.currency;
      returnUrlFailureTPay2 = trak.returnUrlFailure;
      hashTPay2 = trak.hash;
      returnUrlCancelTPay2 = trak.returnUrlCancel;
      emailTPay2 = trak.email;
      countryTPay2 = trak.country;
      modeTPay2 = trak.mode;
      saltTPay2 = trak.salt;
      amountTPay2 = trak.amount;
      nameTPay2 = trak.name;
      apiKeyTPay2 = trak.apiKey;
      udf3TPay2 = trak.udf3;
      udf2TPay2 = trak.udf2;
      returnUrlTPay2 = trak.returnUrl;
      descriptionTPay2 = trak.description;
      udf1TPay2 = trak.udf1;
      addressLine2TPay2 = trak.addressLine2;

      notifyListeners();
    } else {
      setLoading(false);
      print("Error in  transaction index TWO  response");
    }
  }

//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////               WORLDLINE         ///////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////    get data  1 index  WORLDLINE    ////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////

  String? token1WL;
  String? paymentMode1WL;
  String? merchantId1WL;
  String? currency1WL;
  String? consumerId1WL;
  String? consumerMobileNo1WL;
  String? consumerEmailId1WL;
  String? txnId1WL;
  bool? enableExpressPay1WL;
  List? items1WL;
  String? cartDescription1WL;

  Future getDataOneWORLDLINE(String fees, String idFee, String feeAmount,
      String amount, String gateName) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);

    final http.Response response = await http.post(
      Uri.parse('${UIGuide.baseURL}/online-payment/world-line/get-data'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
      },
      body: jsonEncode({
        "Description": "Online Fees Payment",
        "TransactionType": [
          {"name": fees, "id": idFee, "amount": feeAmount}
        ],
        "ReturnUrl": "",
        "Amount": amount,
        "PaymentGateWay": gateName
      }),
    );

    print(json.encode({
      "Description": "Online Fees Payment",
      "TransactionType": [
        {"name": fees, "id": idFee, "amount": feeAmount}
      ],
      "ReturnUrl": "",
      "Amount": amount,
      "PaymentGateWay": gateName
    }));

    try {
      if (response.statusCode == 200) {
        Map<String, dynamic> data = await json.decode(response.body);

        print(data);

        Features raz = Features.fromJson(data['features']);
        enableExpressPay1WL = raz.enableExpressPay;

        ConsumerData con = ConsumerData.fromJson(data["consumerData"]);
        token1WL = con.token;
        paymentMode1WL = con.paymentMode;
        merchantId1WL = con.merchantId;
        currency1WL = con.currency;
        consumerId1WL = con.consumerId;
        consumerMobileNo1WL = con.consumerMobileNo;
        consumerEmailId1WL = con.consumerEmailId;
        cartDescription1WL = con.cartDescription;
        txnId1WL = con.txnId;

        items1WL = await data["consumerData"]["items"];
        print(items1WL);

        notifyListeners();
      } else {
        setLoading(false);
        print("Error in  transaction index one WORLDLINE response");
      }
    } catch (e) {
      print(e);
    }
  }

/////////////////////////////////////////////
//////////    get data  1 index  WORLDLINE    ----------- "BUS FEES"
/////////////////////////////////////////////
  String? token1WLBus;
  String? paymentMode1WLBus;
  String? merchantId1WLBus;
  String? currency1WLBus;
  String? consumerId1WLBus;
  String? consumerMobileNo1WLBus;
  String? consumerEmailId1WLBus;
  String? txnId1WLBus;
  bool? enableExpressPay1WLBus;
  List? items1WLBus;
  String? cartDescription1WLBus;

  Future getDataOneWORLDLINEBus(String fees, String idFee, String feeAmount,
      String amount, String gateName) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);

    final http.Response response = await http.post(
      Uri.parse('${UIGuide.baseURL}/online-payment/world-line/get-data'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
      },
      body: jsonEncode({
        "Description": "Online Fees Payment",
        "TransactionType": [
          {"name": fees, "id": idFee, "amount": feeAmount}
        ],
        "ReturnUrl": "",
        "Amount": amount,
        "PaymentGateWay": gateName
      }),
    );

    print(json.encode({
      "Description": "Online Fees Payment",
      "TransactionType": [
        {"name": fees, "id": idFee, "amount": feeAmount}
      ],
      "ReturnUrl": "",
      "Amount": amount,
      "PaymentGateWay": gateName
    }));

    try {
      if (response.statusCode == 200) {
        Map<String, dynamic> data = await json.decode(response.body);

        Features raz = Features.fromJson(data['features']);
        enableExpressPay1WLBus = raz.enableExpressPay;

        ConsumerData con = ConsumerData.fromJson(data["consumerData"]);
        token1WLBus = con.token;
        paymentMode1WLBus = con.paymentMode;
        merchantId1WLBus = con.merchantId;
        currency1WLBus = con.currency;
        consumerId1WLBus = con.consumerId;
        consumerMobileNo1WLBus = con.consumerMobileNo;
        consumerEmailId1WLBus = con.consumerEmailId;
        txnId1WLBus = con.txnId;
        cartDescription1WLBus = con.cartDescription;

        items1WLBus = await data["consumerData"]["items"];
        print(items1WLBus);

        notifyListeners();
      } else {
        setLoading(false);
        print("Error in  transaction index one WORLDLINE Bus response");
      }
    } catch (e) {
      print(e);
    }
  }

///////////////////////////////////////////////////////////////////////////////////////
//////////////////////////    get data  2 index WORLDLINE   //////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
  String? token2WL;
  String? paymentMode2WL;
  String? merchantId2WL;
  String? currency2WL;
  String? consumerId2WL;
  String? consumerMobileNo2WL;
  String? consumerEmailId2WL;
  String? txnId2WL;
  bool? enableExpressPay2WL;
  List? items2WL;
  String? cartDescription2WL;
  Future getDataTwoWORLDLINE(
      String fees,
      String idFee,
      String feeAmount,
      String buss,
      String idBus,
      String busAmount,
      String amount,
      String gateName) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);

    final http.Response response = await http.post(
      Uri.parse('${UIGuide.baseURL}/online-payment/world-line/get-data'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
      },
      body: jsonEncode({
        "Description": "Online Fees Payment",
        "TransactionType": [
          {"name": fees, "id": idFee, "amount": feeAmount},
          {"name": buss, "id": idBus, "amount": busAmount}
        ],
        "ReturnUrl": "",
        "Amount": amount,
        "PaymentGateWay": gateName
      }),
    );

    print(json.encode({
      "Description": "Online Fees Payment",
      "TransactionType": [
        {"name": fees, "id": idFee, "amount": feeAmount},
        {"name": buss, "id": idBus, "amount": busAmount}
      ],
      "ReturnUrl": "",
      "Amount": amount,
      "PaymentGateWay": gateName
    }));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = await json.decode(response.body);

      print(data);
      Features raz = Features.fromJson(data['features']);
      enableExpressPay2WL = raz.enableExpressPay;

      ConsumerData con = ConsumerData.fromJson(data["consumerData"]);
      token2WL = con.token;
      paymentMode2WL = con.paymentMode;
      merchantId2WL = con.merchantId;
      currency2WL = con.currency;
      consumerId2WL = con.consumerId;
      consumerMobileNo2WL = con.consumerMobileNo;
      consumerEmailId2WL = con.consumerEmailId;
      txnId2WL = con.txnId;
      cartDescription2WL = con.cartDescription;

      items2WL = await data["consumerData"]["items"];
      print(items2WL);

      notifyListeners();
    } else {
      setLoading(false);
      print("Error in  transaction index TWO  response WORLDLINE");
    }
  }

  //////////////////////////////////////////////////////////////////////////////

  //////////////////////        gateway NAME          /////////////////////////

  ////////////////////////////////////////////////////////////////////////////
  String? gateway;
  Future gatewayName(BuildContext context) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    var response = await http.get(
        Uri.parse(
            "${UIGuide.baseURL}/payment-gateway-selector/check-default-paymentgateway"),
        headers: headers);

    try {
      if (response.statusCode == 200) {
        Map<String, dynamic> data = await json.decode(response.body);

        GateWayName att = GateWayName.fromJson(data);

        gateway = att.gateway;
        print('gateway  $gateway');
        setLoading(false);
        // if (gateway == 'TrakNPay') {
        //   String schdomain = _pref.getString("subDomain").toString();
        //   print(schdomain);
        //   return Navigator.pushReplacement(
        //       context,
        //       MaterialPageRoute(
        //           builder: (context) => FeeWebScreen(
        //                 schdomain: schdomain,
        //               )));
        // }

        notifyListeners();
      } else {
        setLoading(false);
        print("Error in  status  response");
      }
    } catch (e) {
      setLoading(false);
      print(e);
    }
  }

  //////////////////////////////////////////////////////////////////////////////

  //////////////////////       vendor Mapping          ////////////////////////

  ////////////////////////////////////////////////////////////////////////////
  bool? existMap;
  Future vendorMapping() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    var response = await http.get(
        Uri.parse("${UIGuide.baseURL}/vendor-mapping/exist-vendor-map"),
        headers: headers);

    try {
      if (response.statusCode == 200) {
        Map<String, dynamic> data = await json.decode(response.body);

        VendorMapModel ven = VendorMapModel.fromJson(data);

        existMap = ven.existMap;
        print('existMap  $existMap');

        notifyListeners();
      } else {
        setLoading(false);
        print("Error in  vendor Mapping   response");
      }
    } catch (e) {
      print(e);
    }
  }
}
