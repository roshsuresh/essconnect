import 'dart:convert';
import 'package:essconnect/Domain/Student/OfflineFee/BusFeeDetailModel.dart';
import 'package:essconnect/Domain/Student/OfflineFee/BusFeePaidModel.dart';
import 'package:essconnect/Domain/Student/OfflineFee/FeesDetailModel.dart';
import 'package:essconnect/Domain/Student/OfflineFee/FeesPaidModel.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:flutter/material.dart';
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
  bool? showConcessionColumn;
  List<FeesSummaryBusModel> busFeeDetailList = [];
  List<TotalListBus> totalListBus = [];
  Future getBusDetailList() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
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
        showConcessionColumn = mod.showConcessionColumn;

        List<FeesSummaryBusModel> templist = List<FeesSummaryBusModel>.from(
            data["feesSummary"].map((x) => FeesSummaryBusModel.fromJson(x)));
        busFeeDetailList.addAll(templist);
        List<TotalListBus> templist1 = List<TotalListBus>.from(
            data["totalList"].map((x) => TotalListBus.fromJson(x)));
        totalListBus.addAll(templist1);
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
  List<DetailedFeesSummaryList> busPaidList = [];
  Future getBusPAIDList() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoadingBP(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
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

        List<DetailedFeesSummaryList> templist =
            List<DetailedFeesSummaryList>.from(data["detailedFeesSummary"]
                .map((x) => DetailedFeesSummaryList.fromJson(x)));
        busPaidList.addAll(templist);

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
  Future getFEEDetailList() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
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

        List<FeesSummaryFEES> templist = List<FeesSummaryFEES>.from(
            data["feesSummary"].map((x) => FeesSummaryFEES.fromJson(x)));
        feesDetailList.addAll(templist);
        List<TotalListFees> templist1 = List<TotalListFees>.from(
            data["totalList"].map((x) => TotalListFees.fromJson(x)));
        totalListFee.addAll(templist1);
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
  List<DetailedFeesSummary> feePAIDList = [];
  Future getFEEsPAIDList() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setLoadingFees(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_pref.getString('accesstoken')}'
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

        List<DetailedFeesSummary> templist = List<DetailedFeesSummary>.from(
            data["detailedFeesSummary"]
                .map((x) => DetailedFeesSummary.fromJson(x)));
        feePAIDList.addAll(templist);

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