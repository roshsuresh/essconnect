

import 'dart:convert';
import 'dart:developer';
import 'package:essconnect/Domain/Student/FeeWiseDomain.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../Domain/Student/FeesModel.dart';
import '../../Domain/Student/RazorPayModel.dart';
import '../../Domain/Student/TrakNpayModel.dart';
import '../../Domain/Student/TransactionModel.dart';
import '../../Domain/Student/WorldLineModel.dart';
import '../../utils/constants.dart';




class FeeWiseProvider with ChangeNotifier {

  bool? existFeeWise;
  bool? instWiseForfeesWise;

  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future getFeeWiseStatus(BuildContext context) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };

    var response = await http.get(
        Uri.parse("${UIGuide.baseURL}/onlinepayment/select-payment"),
        headers: headers);
    print("${UIGuide.baseURL}/onlinepayment/select-payment");

    try {
      if (response.statusCode == 200) {
        print("corect");
        Map<String, dynamic> data = json.decode(response.body);
        print("daaaata:  $data");
        FeesWise prev = FeesWise.fromJson(data);
        existFeeWise = prev.existFeeWisePayment;

        print("exist ffewise , $existFeeWise");


        print(existFeeWise);

        notifyListeners();
      } else {
        print("Error in response");
      }
    } catch (e) {
      print(e);
    }
  }

  String? lastOrderStatus;
  String? lastTransactionStartDate;
  double? lastTransactionAmount;
  String? paymentGatewayId;
  String? readableOrderId;
  int? orderId;
  bool? isLocked;
  bool? hideBusFeesPayment;
  bool? existFeeOrderWisePayment;
  List<GeneralFeesList> feeWiseDataList = [];
  List <FeesDetails> feeDetials = [];
  List<GeneralFeesList> generalFeesList = [];
  List<FeeBusInstallments>  busFeeList=[];
  List<Transactiontype> transactionList=[];
  List<GeneralFeesList> parseGeneralFeesList(Map<String, dynamic> json) {
    var list = json['generalFeesList'] as List;
    return list.map((i) => GeneralFeesList.fromJson(i)).toList();
  }

  Future<Object> feeWiseData() async {
    setLoading(true);
    SharedPreferences _pref = await SharedPreferences.getInstance();

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
    };
    setLoading(true);
    var response = await http.get(
        Uri.parse("${UIGuide.baseURL}/onlinepayment/fee-wise/initlalvalues"),
        headers: headers);

    try {
      if (response.statusCode == 200) {
        setLoading(true);
        print("FeeWise Response..........");

        Map<String, dynamic> data = await json.decode(response.body);

        FeesWiseFeesCollection inita = FeesWiseFeesCollection.fromJson(data);
       isLocked = inita.isLocked;
        existFeeOrderWisePayment= inita.existFeeOrderWisePayment;
        hideBusFeesPayment =inita.hideBusFeesPayment;
        instWiseForfeesWise =inita.instWiseForfeesWise;
        print("dsddddd");
        // isExistFeegroup=inita.isExistFeegroup;
        // isBusFeeGeneralFeeTogether=inita.isBusFeeGeneralFeeTogether;
        // Map<String, dynamic> feeinitial =
        // await data['onlineFeePaymentStudentDetails'];
      Map<String, dynamic> feedata = await data['feeOrder'];
         FeeOrder fee = FeeOrder.fromJson(feedata);
        // OnlineFeePayModel feemode = OnlineFeePayModel.fromJson(feeinitial);
        // allowPartialPayment = feemode.allowPartialPayment;
        // print("--------------$allowPartialPayment");
       lastOrderStatus = fee.lastOrderStatus;
    lastTransactionStartDate = fee.lastTransactionStartDate;
     lastTransactionAmount = fee.lastTransactionAmount;
       readableOrderId = fee.readableOrderId;
        paymentGatewayId = fee.paymentGatewayId;
        orderId = fee.lastOrderId;

        generalFeesList = parseGeneralFeesList(data);

        List<GeneralFeesList> templistt = List<GeneralFeesList>.from(
            data['generalFeesList']
                .map((x) => GeneralFeesList.fromJson(x)));
        feeWiseDataList.addAll(templistt);
        print("netdue");
       // print(feeWiseDataList[0].netDue);
        // feeWiseDataList = data.map((data) => GeneralFeesList.fromJson(data['generalFeesList'])).toList();
        setLoading(true);



        setLoading(true);
        List<FeeBusInstallments> templist2 = List<FeeBusInstallments>.from(
            data['busFeesList']
                .map((x) => FeeBusInstallments.fromJson(x)));
        busFeeList.addAll(templist2);
        setLoading(true);

        List<Transactiontype> templis = List<Transactiontype>.from(
            data['transactiontype']
                .map((x) => Transactiontype.fromJson(x)));
        transactionList.addAll(templis);
        print("transactionList length");
        print(transactionList.length);

        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        print("Error in feeWise response");
      }
    } catch (e) {
      setLoading(false);
      print(e);
    }
    return true;
  }

  double totalStoreFees = 0;
  double totalFees = 0;
  double? total = 0;
  double totalBusFee = 0;

  List storeCategory = [];


  double _totalSelectedFees = 0.0;
  double get totalSelectedFees => _totalSelectedFees;

  double _totalBusAmount = 0.0;
  double get totalBusFees => _totalBusAmount;

  double _grandTotal = 0.0;
  double get grandTotal => _grandTotal;

  void resetTotalSelectedFees() {
    _totalSelectedFees = 0.0;
    _totalBusAmount = 0.0;
    _grandTotal = 0.0;
    notifyListeners();
  }

  //       FeeWise Selection-- Random
//-------------------------------------

  void onFeeSelectedRandom(bool selected, String installmentName,double feeNetDue, int index) {

    generalFeesList[index].checkedInstallment = selected;
    for (var fee in generalFeesList[index].feesDetails!) {
      fee.checkedFees = selected;
    }
    print("totttttttttttttttaaa $total");

    _updateSelectedInstallments();
    _updateTotalSelectedFees();
    _updateGrandTotal();
    notifyListeners();
  }

  void onSubFeeSelectedRandom(bool selected, String installmentName, int installmentIndex, double feeNetDue,int feeIndex) {
    generalFeesList[installmentIndex].feesDetails![feeIndex].checkedFees = selected;
    generalFeesList[installmentIndex].checkedInstallment = generalFeesList[installmentIndex].feesDetails!.every((fee) => fee.checkedFees!);


   // generalFeesList[installmentIndex].checkedInstallment = generalFeesList[installmentIndex].feesDetails!.every((fee) => fee.checkedFees!);
    _updateSelectedInstallments();
    _updateTotalSelectedFees();
    _updateGrandTotal();
    notifyListeners();
  }


  //         Fee-Wise Selection - In Order
  //----------------------------------------

  void onFeeSelectedOrder(bool selected, String installmentName, double feeNetDue, int index) {
    // Enable the first installment and its first fee by default
    generalFeesList[0].disableInstallment = true;
    generalFeesList[0].feesDetails![0].disableFees = true;

    if (selected) {
      // Ensure the previous installment is selected before allowing this installment
      if (index > 0 && !generalFeesList[index - 1].checkedInstallment!) {
        return;
      }

      // Select the installment and all its fees
      generalFeesList[index].checkedInstallment = true;
      for (var fee in generalFeesList[index].feesDetails!) {
        fee.checkedFees = true;
      }

      // Enable the next installment if it exists
      if (index < generalFeesList.length - 1) {
        generalFeesList[index + 1].disableInstallment = true;
        generalFeesList[index + 1].feesDetails![0].disableFees = true;
      }
    } else {
      // Deselect the installment and all subsequent installments and their fees
      for (int i = index; i < generalFeesList.length; i++) {
        generalFeesList[i].checkedInstallment = false;
        for (var fee in generalFeesList[i].feesDetails!) {
          fee.checkedFees = false;
          fee.disableFees = false;
        }
        generalFeesList[i].disableInstallment = false;
      }
    }

    _updateSelectedInstallments();
    _updateTotalSelectedFees();
    _updateGrandTotal();
    notifyListeners();
  }

  void onSubFeeSelectedOrder(bool selected, String installmentName, int installmentIndex, double feeNetDue, int feeIndex) {
    // Enable the first fee of the first installment by default
    generalFeesList[0].disableInstallment = true;
    generalFeesList[0].feesDetails![0].disableFees = true;

    if (selected) {
      // Check if the previous fee in the same installment is selected
      if (feeIndex > 0 && !generalFeesList[installmentIndex].feesDetails![feeIndex - 1].checkedFees!) {
        return; // Prevent selection if the previous fee is not selected
      }

      // Check if all fees in the previous installment are selected before allowing the first fee of the current installment
      if (feeIndex == 0 && installmentIndex > 0 && !generalFeesList[installmentIndex - 1].checkedInstallment!) {
        return; // Prevent selection if the previous installment's fees are not all selected
      }

      generalFeesList[installmentIndex].feesDetails![feeIndex].checkedFees = true;

      // Enable the next fee in the installment if it exists
      if (feeIndex < generalFeesList[installmentIndex].feesDetails!.length - 1) {
        generalFeesList[installmentIndex].feesDetails![feeIndex + 1].disableFees = true;
      } else if (installmentIndex < generalFeesList.length - 1) {
        // Enable the first fee of the next installment if it exists
        generalFeesList[installmentIndex + 1].disableInstallment = true;
        generalFeesList[installmentIndex + 1].feesDetails![0].disableFees = true;
      }
    } else {
      // Deselect the fee and all subsequent fees in the installment
      for (int i = feeIndex; i < generalFeesList[installmentIndex].feesDetails!.length; i++) {
        generalFeesList[installmentIndex].feesDetails![i].checkedFees = false;
        generalFeesList[installmentIndex].feesDetails![i].disableFees = false;
      }

      // Deselect all subsequent installments and their fees
      for (int i = installmentIndex + 1; i < generalFeesList.length; i++) {
        generalFeesList[i].checkedInstallment = false;
        for (var fee in generalFeesList[i].feesDetails!) {
          fee.checkedFees = false;
          fee.disableFees = false;
        }
        generalFeesList[i].disableInstallment = false;
      }
    }

    // Update the selection status of the installment
    generalFeesList[installmentIndex].checkedInstallment =
        generalFeesList[installmentIndex].feesDetails!.every((fee) => fee.checkedFees!);

    _updateSelectedInstallments();
    _updateTotalSelectedFees();
    _updateGrandTotal();
    notifyListeners();
  }


  //          Installment Selection- FeeWise
  //---------------------------------------------------------
  void onFeeSelected(bool selected, int index) {
    if (selected) {
      if (index > 0 && (!generalFeesList[index - 1].checkedInstallment! || !generalFeesList[index - 1].feesDetails!.every((fee) => fee.checkedFees!))) {
        return;
      }
    }

    generalFeesList[index].checkedInstallment = selected;
    for (var fee in generalFeesList[index].feesDetails!) {
      fee.checkedFees = selected;
    }

    // Deselect subsequent installments if necessary
    if (!selected) {
      for (int i = index + 1; i < generalFeesList.length; i++) {
        generalFeesList[i].checkedInstallment = false;
        for (var fee in generalFeesList[i].feesDetails!) {
          fee.checkedFees = false;
        }
      }
    }
    _updateSelectedInstallments();
    _updateTotalSelectedFees();
    _updateGrandTotal();
    notifyListeners();
    print(selectedInstallments);
  }

  void onSubFeeSelected(bool selected, int installmentIndex, int feeIndex) {
    if (selected) {
      if (feeIndex > 0 && !generalFeesList[installmentIndex].feesDetails![feeIndex - 1].checkedFees!) {
        return;
      }

      if (installmentIndex > 0 && !generalFeesList[installmentIndex - 1].feesDetails!.every((fee) => fee.checkedFees!)) {
        return;
      }
    } else {
      if (feeIndex < generalFeesList[installmentIndex].feesDetails!.length - 1 && generalFeesList[installmentIndex].feesDetails![feeIndex + 1].checkedFees!) {
        return;
      }
    }

    generalFeesList[installmentIndex].feesDetails![feeIndex].checkedFees = selected;
    generalFeesList[installmentIndex].checkedInstallment = generalFeesList[installmentIndex].feesDetails!.every((fee) => fee.checkedFees!);


    if (!selected) {
      for (int i = feeIndex + 1; i < generalFeesList[installmentIndex].feesDetails!.length; i++) {
        generalFeesList[installmentIndex].feesDetails![i].checkedFees = false;
      }

      for (int i = installmentIndex + 1; i < generalFeesList.length; i++) {
        generalFeesList[i].checkedInstallment = false;
        for (var fee in generalFeesList[i].feesDetails!) {
          fee.checkedFees = false;
        }
      }
    }

    //Add to LIst



    _updateTotalSelectedFees();
    _updateGrandTotal();
    notifyListeners();
  }

  List<Map<String, dynamic>> selectedInstallments = [];
  void _updateSelectedInstallments() {
    selectedInstallments.clear(); // Clear the previous selection

    for (var installment in generalFeesList) {
      if (installment.checkedInstallment == true) {
        selectedInstallments.add({
          "OfflineInstallmentId": installment.offlineInstallmentId.toString(),
          "Fine": installment.fineAmount.toString(),
          "FeesDetails": installment.feesDetails!
              .where((fee) => fee.checkedFees == true)
              .map((fee) => {
            "OfflineFeesId": fee.offlineFeesId.toString(),
            "FeesNetDue": fee.feesNetDue.toString(),
          })
              .toList(),
        });
      } else {
        // Also add partially selected installments with selected fees
        var selectedFees = installment.feesDetails!
            .where((fee) => fee.checkedFees == true)
            .toList();
        if (selectedFees.isNotEmpty) {
          selectedInstallments.add({
            "OfflineInstallmentId": installment.offlineInstallmentId.toString(),
            "Fine": installment.fineAmount.toString(),
            "FeesDetails": selectedFees.map((fee) => {
              "OfflineFeesId": fee.offlineFeesId.toString(),
              "FeesNetDue": fee.feesNetDue.toString(),
            }).toList(),
          });
        }
      }
    }
  }



  void _updateTotalSelectedFees() {
    double totalSelectedFees = 0.0;

    for (var installment in generalFeesList) {
      bool anyFeeSelected = installment.feesDetails!.any((fee) => fee.checkedFees!);

      if (installment.checkedInstallment == true) {
        // Add the net due amount of the selected fees within the installment
        for (var fee in installment.feesDetails!) {
          if (fee.checkedFees!) {
            totalSelectedFees += fee.feesNetDue!;
          }
        }

        // Add the fine amount of the installment only once
        totalSelectedFees += installment.fineAmount!;
      } else if (anyFeeSelected) {
        for (var fee in installment.feesDetails!) {
          if (fee.checkedFees!) {
            // Add the net due amount of the selected fee
            totalSelectedFees += fee.feesNetDue!;
          }
        }

        // Add the fine amount of the installment only once
        totalSelectedFees += installment.fineAmount!;
      }
    }

    _totalSelectedFees = totalSelectedFees;
    notifyListeners();
  }
//Initail Total
//   double initialTotal = 0.0;
//   double getInitialInstallmentTotal(int installmentIndex) {
//
//
//     // Get the installment at the given index
//     var installment = generalFeesList[installmentIndex];
//
//     // Sum all feesNetDue for the fees within the installment
//     for (var fee in installment.feesDetails!) {
//       initialTotal += fee.feesNetDue!;
//     }
//
//     // Optionally add the fine amount if it should always be included
//     initialTotal += installment.fineAmount!;
//
//     return initialTotal;
//   }


  //        Bus Fee Selection
  //-----------------------------------------
  void onBusFeeSelected(bool selected, int index) {
    if (selected) {
      // Check if the previous installment is selected
      if (index > 0 && !busFeeList[index - 1].checkedInstallment!) {
        // If the previous installment is not selected, return without selecting the current installment
        return;
      }
    }

    // Select or deselect the current installment
    busFeeList[index].checkedInstallment = selected;

    // Update the fees selection status based on the installment's selection
    for (var i = 0; i <= index; i++) {
      busFeeList[i].checkedFees = selected;
    }

    // Deselect installments after the current one (if deselecting)
    if (!selected) {
      for (var i = index + 1; i < busFeeList.length; i++) {
        busFeeList[i].checkedInstallment = false;
      }
    }

    _updateTotalBusFees();
    _updateGrandTotal();
    notifyListeners();
  }

  void _updateTotalBusFees() {
    double totalAmount = 0.0;

    for (var installment in busFeeList) {
      if (installment.checkedInstallment!) {
        totalAmount += installment.netDue!;
      }
    }

    _totalBusAmount = totalAmount;

    notifyListeners();
  }


  void _updateGrandTotal() {
    double grandTotal=0.0;
    grandTotal = _totalSelectedFees + _totalBusAmount;
    _grandTotal =grandTotal;
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
//////////////////////////      PAYTM    ///////////////////////////////
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

  Future getDataOne(List transaction, String amount,List feesData,
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
        "TransactionType": transaction,
        "ReturnUrl": "",
        "Amount": amount,
        "feeWiseDetails": feesData,
        "PaymentGateWay": gateName
      }),
    );

    print(json.encode({
      "Description": "Online Fees Payment",
      "TransactionType": transaction,
      "ReturnUrl": "",
      "Amount": amount,
      "feeWiseDetails": feesData,
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



//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////               RAZORPAY         ///////////////////////////////
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

  Future getDataOneRAZORPAY(List transaction,
      String amount,List feesData, String gateName) async {
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
        "TransactionType": transaction,
        "ReturnUrl": "",
        "Amount": amount,
        "feeWiseDetails":feesData,
        "PaymentGateWay": gateName
      }),
    );

    print(json.encode({
      "Description": "Online Fees Payment",
      "TransactionType": transaction,
      "ReturnUrl": "",
      "Amount": amount,
      "feeWiseDetails":feesData,
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


//////////////////////////////////////////////////////////////////////////////////////////
////////------------------------------ TRAKNPAY  ---------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////


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

  Future getDataOneTpay(List transaction,
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
        "TransactionType": transaction,
        "ReturnUrl": "",
        "Amount": amount,
        "PaymentGateWay": gateName
      }),
    );

    print(json.encode({
      "Description": "Online Fees Payment",
      "TransactionType": transaction,
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


//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////               WORLDLINE         ///////////////////////////////
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

  Future getDataOneWORLDLINE(List transaction,
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
        "TransactionType": transaction,
        "ReturnUrl": "",
        "Amount": amount,
        "PaymentGateWay": gateName
      }),
    );

    print(json.encode({
      "Description": "Online Fees Payment",
      "TransactionType": transaction,
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


  //////////////////////////////////////////////////////////////////////////////

  //////////////////////        gateway NAME          /////////////////////////

  ////////////////////////////////////////////////////////////////////////////
  String gateway="";
  Future gatewayName() async {
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

        gateway = att.gateway!;
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
        Uri.parse("${UIGuide.baseURL}/vendor-mapping/exist-vendor-map-fees-wise"),
        headers: headers);
    print(response);

    try {
      if (response.statusCode == 200) {
        Map<String, dynamic> data = await json.decode(response.body);

        VendorMapFeeWiseModel ven = VendorMapFeeWiseModel.fromJson(data);

        existMap = ven.existMapFeesWise;
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





