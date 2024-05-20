import 'dart:convert';
import 'package:essconnect/Domain/Student/OfflineFee/BusFeeDetailModel.dart';
import 'package:essconnect/Domain/Student/OfflineFee/BusFeePaidModel.dart';
import 'package:essconnect/Domain/Student/OfflineFee/FeesDetailModel.dart';
import 'package:essconnect/Domain/Student/OfflineFee/FeesPaidModel.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class OfflineFeeProviders with ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  clearBusDetailList() {
    busFeeDetailList.clear();
    totalListBus.clear();
    notifyListeners();
  }

  String? busName;
  String? busStop;
  String? busDateDetail;
  String? finalBusDateDetail;
  bool? showConcessionColumn;
  List<FeesSummaryBusModel> busFeeDetailList = [];
  List<TotalListBus> totalListBus = [];
  Future getBusDetailList() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };

    var response = await http.get(
        Uri.parse("${UIGuide.baseURL}/fee-bus-summary/get-bussummary"),
        headers: headers);
    try {
      if (response.statusCode == 200) {
        final data = await json.decode(response.body);
        print(data);
        BusFEEDetailModel mod = BusFEEDetailModel.fromJson(data);
        busName = mod.busName;
        busStop = mod.busStop;
        busDateDetail = mod.uploadedDate;
        showConcessionColumn = mod.showConcessionColumn;

        List<FeesSummaryBusModel> templist = List<FeesSummaryBusModel>.from(
            data["feesSummary"].map((x) => FeesSummaryBusModel.fromJson(x)));
        busFeeDetailList.addAll(templist);
        List<TotalListBus> templist1 = List<TotalListBus>.from(
            data["totalList"].map((x) => TotalListBus.fromJson(x)));
        totalListBus.addAll(templist1);
        String createddate = busDateDetail ?? '--';
        DateFormat inputFormat = DateFormat("MM/dd/yyyy HH:mm:ss");
        DateTime parsedDate = inputFormat.parse(createddate);
        DateFormat outputFormat = DateFormat("dd-MM-yyyy");
        finalBusDateDetail = outputFormat.format(parsedDate);
        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        print("Error in feesSummary Response");
      }
    } catch (e) {
      setLoading(false);
      print(e);
    }
  }

  bool _loadingBP = false;
  bool get loadingBP => _loadingBP;
  setLoadingBP(bool value) {
    _loadingBP = value;
    notifyListeners();
  }

  clearBusPAIDList() {
    busPaidList.clear();

    notifyListeners();
  }

  //Bus Fee Paid

  bool? showConcession;
  String? busDatePaid;
  String? finalBusDatePaid;
  List<DetailedFeesSummaryList> busPaidList = [];
  Future getBusPAIDList() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoadingBP(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };

    var response = await http.get(
        Uri.parse(
            "${UIGuide.baseURL}/fee-bus-summary/get-detailed-busfees-summary"),
        headers: headers);
    try {
      if (response.statusCode == 200) {
        final data = await json.decode(response.body);
        print(data);
        BusFEEPAIDModel mod = BusFEEPAIDModel.fromJson(data);
        showConcession = mod.showConcession;
        busDatePaid = mod.uploadedDate;

        List<DetailedFeesSummaryList> templist =
            List<DetailedFeesSummaryList>.from(data["detailedFeesSummary"]
                .map((x) => DetailedFeesSummaryList.fromJson(x)));
        busPaidList.addAll(templist);
        String createddate = busDatePaid ?? '--';
        DateFormat inputFormat = DateFormat("MM/dd/yyyy HH:mm:ss");
        DateTime parsedDate = inputFormat.parse(createddate);
        DateFormat outputFormat = DateFormat("dd-MM-yyyy");
        finalBusDatePaid = outputFormat.format(parsedDate);

        setLoadingBP(false);
        notifyListeners();
      } else {
        setLoadingBP(false);
        print("Error in detailedFeesSummary Response");
      }
    } catch (e) {
      setLoadingBP(false);
      print(e);
    }
  }

  //FEE  DETAILS

  clearFEEDetailList() {
    feesDetailList.clear();
    totalListFee.clear();
    notifyListeners();
  }

  bool? showConcessionColumnFees;
  List<FeesSummaryFEES> feesDetailList = [];
  List<TotalListFees> totalListFee = [];
  String? feeDate;
  String? finalFeeDateDetail;
  Future getFEEDetailList() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };

    var response = await http.get(
        Uri.parse("${UIGuide.baseURL}/fee-summary/get-summary"),
        headers: headers);
    try {
      if (response.statusCode == 200) {
        final data = await json.decode(response.body);
        print(data);
        FeeDetailModel mod = FeeDetailModel.fromJson(data);

        showConcessionColumnFees = mod.showConcessionColumnFees;
        feeDate = mod.uploadedDate;

        List<FeesSummaryFEES> templist = List<FeesSummaryFEES>.from(
            data["feesSummary"].map((x) => FeesSummaryFEES.fromJson(x)));
        feesDetailList.addAll(templist);
        List<TotalListFees> templist1 = List<TotalListFees>.from(
            data["totalList"].map((x) => TotalListFees.fromJson(x)));
        totalListFee.addAll(templist1);
        String createddate = feeDate ?? '--';
        DateFormat inputFormat = DateFormat("MM/dd/yyyy HH:mm:ss");
        DateTime parsedDate = inputFormat.parse(createddate);
        DateFormat outputFormat = DateFormat("dd-MM-yyyy");
        finalFeeDateDetail = outputFormat.format(parsedDate);
        setLoading(false);
        notifyListeners();
      } else {
        setLoading(false);
        print("Error in feesSummary Response");
      }
    } catch (e) {
      setLoading(false);
      print(e);
    }
  }

  bool _loadingFees = false;
  bool get loadingFees => _loadingFees;
  setLoadingFees(bool value) {
    _loadingFees = value;
    notifyListeners();
  }

  clearFEEPAIDList() {
    feePAIDList.clear();

    notifyListeners();
  }

  // Fee Paid

  bool? showConcessionFEES;
  String? feeDatePaid;
  String? finalfeeDatePaid;
  List<DetailedFeesSummary> feePAIDList = [];
  Future getFEEsPAIDList() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoadingFees(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };

    var response = await http.get(
        Uri.parse("${UIGuide.baseURL}/fee-summary/get-detailed-fees-summary"),
        headers: headers);
    try {
      if (response.statusCode == 200) {
        final data = await json.decode(response.body);
        print(data);
        FeePaidModel mod = FeePaidModel.fromJson(data);
        showConcessionFEES = mod.showConcessionFEES;
        feeDatePaid = mod.uploadedDate;

        List<DetailedFeesSummary> templist = List<DetailedFeesSummary>.from(
            data["detailedFeesSummary"]
                .map((x) => DetailedFeesSummary.fromJson(x)));
        feePAIDList.addAll(templist);
        String createddate = feeDatePaid ?? '--';
        DateFormat inputFormat = DateFormat("MM/dd/yyyy HH:mm:ss");
        DateTime parsedDate = inputFormat.parse(createddate);
        DateFormat outputFormat = DateFormat("dd-MM-yyyy");

        finalfeeDatePaid = outputFormat.format(parsedDate);

        setLoadingFees(false);
        notifyListeners();
      } else {
        setLoadingFees(false);
        print("Error in detailedFeesSummary Response");
      }
    } catch (e) {
      setLoadingFees(false);
      print(e);
    }
  }
}
