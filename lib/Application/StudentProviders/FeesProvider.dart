import 'dart:convert';
import 'dart:developer';
import 'package:essconnect/Domain/Student/RazorPayModel.dart';
import 'package:essconnect/Domain/Student/TrakNpayModel.dart';
import 'package:essconnect/Domain/Student/TransactionModel.dart';
import 'package:essconnect/Domain/Student/WorldLineModel.dart';
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
  List<FeesStore> storeFeeList=[];
  List<Transactiontype> transactionList = [];

  String? lastOrderStatus;
  String? lastTransactionStartDate;
  double? lastTransactionAmount;
  String? paymentGatewayId;
  String? readableOrderId;
  int? orderId;
  bool? isLocked;
  bool? isExistFeegroup;
  bool? isBusFeeGeneralFeeTogether;

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
        isExistFeegroup=inita.isExistFeegroup;
        isBusFeeGeneralFeeTogether=inita.isBusFeeGeneralFeeTogether;
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
        List<FeeBusInstallments> templistt = List<FeeBusInstallments>.from(
            feeinitial['feeBusInstallments']
                .map((x) => FeeBusInstallments.fromJson(x)));
        busFeeList.addAll(templistt);
        setLoading(true);


        List<Transactiontype> templis = List<Transactiontype>.from(
            feeinitial['transactiontype']
                .map((x) => Transactiontype.fromJson(x)));
        transactionList.addAll(templis);
        print("transactionList length");
        // print(transactionList.length);
        // print("ssssssssssssssss");
        // List<FeesStore> templist3= List<FeesStore>.from(
        //     feeinitial['storeFees']
        //         .map((x) => FeesStore.fromJson(x)));
        // storeFeeList.addAll(templist3);
        // print("ssssssssssssssssttttttttttttt");
        // print("store length");
        // print(storeFeeList.length);

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


  //store



//fee
  double totalStoreFees = 0;
  double totalFees = 0;
  double? total = 0;
  double totalBusFee = 0;
  List selecteCategorys = [];
  List storeCategory=[];

  void onStoreFeeSelected(bool selected, feeName, int index, feeNetDue) {
    storeFeeList[0].enabled=true;
    print("fssdssd  ${storeFeeList[0].enabled}");
    if (storeFeeList[index].enabled == true) {
      if (selected == true) {
        storeCategory.add(feeName);

        index == (storeFeeList.length) - 1
            ? "--"
            : storeFeeList[index + 1].enabled = true;
        storeFeeList[index].selected = true;

        print(index);
        final double tot = feeNetDue;
        print(feeName);
        print(tot);
        totalStoreFees = tot + totalStoreFees;
        print(totalStoreFees);
        total = totalFees + totalBusFee+totalStoreFees;
        print(total);
        print("selectStoreCategorys   $storeCategory");
        notifyListeners();
      }
      // else if(feesList[index+1].selected  == true){
      //   selected != true;
      // }

      else {
        int lastindex = storeFeeList.length - 1;
        print(lastindex);
        if (storeFeeList[lastindex].selected == true) {
          storeCategory.removeAt(lastindex);
          storeFeeList[lastindex].selected = false;
          storeFeeList[lastindex].enabled = true;
          final double? tot = storeFeeList[lastindex].amount;
          totalStoreFees = totalStoreFees - tot!;
          total = totalFees + totalBusFee+totalStoreFees;
          notifyListeners();
        } else if (storeFeeList[index + 1].selected == true) {
          print("demooo");
          notifyListeners();
          print(storeCategory);
        } else if (storeCategory.remove(feeName)) {
          storeFeeList[index].selected = false;
          index == (storeFeeList.length) - 1
              ? "--"
              : storeFeeList[index + 1].enabled = false;
          final double tot = feeNetDue;
          totalStoreFees = totalStoreFees - tot;
          total = totalFees + totalBusFee+totalStoreFees;
          print(total);
          print("selectStoreCategorys   $storeCategory");
          notifyListeners();
        }
      }
    } else {
      print("no data");
    }
  }

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
        total = totalFees + totalBusFee+totalStoreFees;
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
          total = totalFees + totalBusFee+totalStoreFees;
          print(total);
          print("selecteCategorys   $selecteCategorys");
          notifyListeners();
        }
      }
    } else {
      print("no data");
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
        total =totalFees + totalBusFee+totalStoreFees;
        print("total  $total");
        print("selecteCategoryss   $selectedBusFee");
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
          total = totalFees + totalBusFee+totalStoreFees;
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
          total = totalFees + totalBusFee+totalStoreFees;
          print(total);
          print("selecteCategorys   $selectedBusFee");
          notifyListeners();
        }
      }
    } else {
      print("no dta");
    }
  }


   List busLisssssss=[];
  List newList=[];
  List notMatchingValues = [];
  String gruopmonth='';
  void onBusSelectedGroup(bool selected, busfeeName, int index, feeNetDue) {
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
        total = totalFees + totalBusFee+totalStoreFees;
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
          total = totalFees + totalBusFee+totalStoreFees;
          print(total);

          notifyListeners();
        } else if (busFeeList[index + 1].selected == true) {
          print("demooo");
          notifyListeners();
          print(selectedBusFee);
        }
        else if (selectedBusFee.remove(busfeeName)) {


          busFeeList[index].selected = false;
          index == (busFeeList.length) - 1
              ? "--"
              : busFeeList[index + 1].enabled = false;
          final double tot = feeNetDue;
          totalBusFee = totalBusFee - tot;
          total = totalFees + totalBusFee+totalStoreFees;
          print(total);
         index==0?index: index=index-1;
          print("selecteCategorys   $selectedBusFee");
          notifyListeners();
        }
      }
    } else {
      print("no dta");
    }
   busLisssssss.clear();
    print("oldbbuslissssssss $busLisssssss");
    print(index);
    print("select $selectedBusFee");
    if(selectedBusFee.isEmpty){
      busLisssssss.clear();
      newList.clear();
      notMatchingValues.clear();
      gruopmonth="";
    }
    else{

    for(int i=0;i<busFeeList.length;i++) {
      if (
      busFeeList[i].offlineBusGroupId ==
          busFeeList[index].offlineBusGroupId) {
        busLisssssss.add(busFeeList[i].installmentName);
      }
    }
    }


    Set uniqueValues = busLisssssss.toSet();
    newList = uniqueValues.toList();
    Set<String> set2 = Set.from(selectedBusFee);
    notMatchingValues.clear();
    for (String element in newList) {

      if (!set2.contains(element)) {
        notMatchingValues.add(element);
      }
    }

    gruopmonth = notMatchingValues.join(',');
    print("selecteCategorysgrooup   $busLisssssss");
    print("newList $newList");
    print("nomatchinss $notMatchingValues");
    print("groupmonth   $gruopmonth");
  }

  //total

  void totalFee() async {
    total = totalFees + totalBusFee+totalStoreFees;
    print(total);
    notifyListeners();
  }

  ///-----------Together---------------------///

  void onFeeSelectedTogether(bool selected, feeName, int index, feeNetDue,int instaGroup) {
    feeList[0].enabled = true;
   // busFeeList[0].enabled=true;
    if (feeList[index].enabled == true) {
      if (selected == true) {

        for(int j=0;j<feeList.length;j++){
          if(instaGroup==feeList[j].installmentGroup){
            feeList[j].selected=true;
            selecteCategorys.add(feeList[j].installmentName);
            (j+1)!= feeList.length? feeList[j+1].enabled=true:"";
            totalFees = totalFees+ feeList[j].netDue!;
          }
        }

        for(int i=0;i<busFeeList.length;i++){

          if(instaGroup==busFeeList[i].installmentGroup){
            busFeeList[i].selected==true;
             if(i!=0){
               busFeeList[i-1].selected==false? busFeeList[i-1].selected==true:"";
             }
            (i+1)!= busFeeList.length? busFeeList[i+1].enabled=true:"";
            selectedBusFee.add(busFeeList[i].installmentName);
            totalBusFee = totalBusFee+ busFeeList[i].netDue!;
          }

        }

       // selecteCategorys.add(feeName);

        index == (feeList.length) - 1
            ? "---"
            : feeList[index + 1].enabled = true;
        feeList[index].selected = true;

        print(index);
        final double tot = feeNetDue;
        print(feeName);
        print(tot);
        totalFees = tot + totalFees;
        print(totalFees);
        total = totalFees + totalBusFee+totalStoreFees;
        print(total);
        print("selecteCategorys   $selecteCategorys");
        print("selecteBus   $selectedBusFee");
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
          print("selecteCategorys1   $selecteCategorys");
          for(int i=0;i<busFeeList.length;i++){

            if(busFeeList[i].installmentGroup==instaGroup){
              busFeeList[i].selected==false;
              // i<busFeeList.length?busFeeList[i+1].enabled==true:"";
               selectedBusFee.removeWhere((element) => element==busFeeList[i].installmentName);
              (i+1)!=busFeeList.length? busFeeList[i+1].enabled==true:"";
               totalBusFee = totalBusFee- busFeeList[i].netDue!;
            }
          }


          feeList[lastindex].selected = false;
          feeList[lastindex].enabled = true;
          final double? tot = feeList[lastindex].netDue;
          totalFees = totalFees - tot!;
          total = totalFees + totalBusFee+totalStoreFees;
          notifyListeners();
        } else if (feeList[index + 1].selected == true) {
          print("demooo");
          notifyListeners();
          print(selecteCategorys);
        } else if (selecteCategorys.remove(feeName)) {

          print("selecteCategorys22   $selecteCategorys");
          feeList[index].selected = false;

          for(int i=0;i<busFeeList.length;i++){

            if(feeList[index].installmentGroup==busFeeList[i].installmentGroup){
              print("valuuuuuuuu");

              print("valuuuuuuuu1111");
              busFeeList[i].selected == false;
             // selectedBusFee.clear();
              selectedBusFee.removeWhere((element) => element==busFeeList[i].installmentName);


             totalBusFee = totalBusFee- busFeeList[i].netDue!;
            }
          }
          index == (feeList.length) - 1
              ? "--"
              : feeList[index + 1].enabled = false;
          final double tot = feeNetDue;
          totalFees = totalFees - tot;
          total =totalFees + totalBusFee+totalStoreFees;
          print(total);
          print("selecteCategorys   $selecteCategorys");
          print("selecteCategorysssbus  $selectedBusFee");
          notifyListeners();
        }
      }
    } else {
      print("no dta");
    }
  }




  void onFeeSelectedTogetherBus(bool selected, busfeeName, int index, feeNetDue,int instaGroup) {
    busFeeList[0].enabled = true;
    print("instagrrrr  $instaGroup");
    if (busFeeList[index].enabled == true) {
      if (selected == true) {
        for(int i=0;i<busFeeList.length;i++){

          if(instaGroup==busFeeList[i].installmentGroup){
            busFeeList[i].selected==true;
            i==busFeeList.length-1?"":
            busFeeList[i+1].enabled==true;
           selectedBusFee.add(busFeeList[i].installmentName);
            totalBusFee = totalBusFee+ busFeeList[i].netDue!;
           i==busFeeList.length-1?"":busFeeList[i+1].enabled=true;

           for(int j=0;j<feeList.length;j++)
           {
            if( instaGroup==feeList[j].installmentGroup)
              {

                feeList[j].selected=true;
                (j+1)!= feeList.length?feeList[j+1].enabled=true:"";
                if(!selecteCategorys.contains(feeList[j].installmentName)) {
                  selecteCategorys.add(feeList[j].installmentName);
                  totalFees = totalFees+ feeList[j].netDue!;
                }
              }


           }
           print("seeeeeeeee  $selecteCategorys");

          }
        }




       // selectedBusFee.add(busfeeName);

        index == (busFeeList.length) - 1
            ? "--"
            : busFeeList[index + 1].enabled = true;
        busFeeList[index].selected = true;

        print(index);
        final double tot = feeNetDue;
        print("busfeeName: $busfeeName");
        print("tot  $tot");
       // totalBusFee = tot + totalBusFee;
        print("totalBusFee  $totalBusFee");
        total = totalFees + totalBusFee+totalStoreFees;
        print("total  $total");
        print("selecteCategory   $selecteCategorys");
        print("selecteCategoryssbus   $selectedBusFee");
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
          total = totalFees + totalBusFee+totalStoreFees;
          print(total);

          notifyListeners();
        }
        // else if (busFeeList[index + 1].selected == true) {
        //   print("demooo");
        //   notifyListeners();
        //   print(selectedBusFee);
        // }
        else if (selectedBusFee.remove(busfeeName)) {

          if (index != -1) {
            print("valuuuuuuuu");

            print("valuuuuuuuu1111");

            selectedBusFee.removeRange(index, selectedBusFee.length);


          }


          for(int j=0;j<busFeeList.length;j++) {
            if(busFeeList[j].installmentGroup==instaGroup) {
              selectedBusFee.removeWhere((element) =>
              element == busFeeList[j].installmentName);
              totalBusFee=totalBusFee-busFeeList[j].netDue!;
            }
          }

          for(int i=0;i<feeList.length;i++){



            if(feeList[i].installmentGroup==busFeeList[index].installmentGroup){
              print("valuuuuuuuu");

              print("valuuuuuuuu1111");
             // feesList[i].selected == false;
              // selectedBusFee.clear();
              selecteCategorys.removeWhere((element) => element==feeList[i].installmentName);


            //  totalBusFee = totalBusFee- busFeeList[i].netDue!;
            }
          }


           // if(busFeeList[index+1].selected==true){
           //   busFeeList[index+1].selected==false;
           // }

          busFeeList[index].selected = false;
          index == (busFeeList.length) - 1
              ? "--"
              : busFeeList[index + 1].enabled = false;

          // for(int i=0;i<busFeeList.length;i++){
          //
          //   if(instaGroup==busFeeList[i].installmentGroup){
          //     busFeeList[i].selected==false;
          //     selectedBusFee.remove(busFeeList[i].installmentName);
          //     totalBusFee = totalBusFee-busFeeList[i].netDue!;
          //     //  i==busFeeList.length-1?"":busFeeList[i+1].enabled=true;
          //
          //     for(int j=0;j<feeList.length;j++)
          //     {
          //       if( instaGroup==feeList[j].installmentGroup)
          //       {
          //
          //         feeList[j].selected=false;
          //         if(!selecteCategorys.contains(feeList[j].installmentName)) {
          //           selecteCategorys.removeLast();
          //           totalFees = totalFees- feeList[j].netDue!;
          //         }
          //       }
          //
          //
          //     }
          //     print("seeeeeeeee  $selecteCategorys");
          //
          //   }
          // }
          final double tot = feeNetDue;
        //  totalBusFee = totalBusFee - tot;
          total =totalFees + totalBusFee+totalStoreFees;
          print(total);
          print("selecteCategorys   $selectedBusFee");
          notifyListeners();
        }
      }
    } else {
      print("no dta");
    }
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

  Future getDataOne(List transaction, String amount,
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
