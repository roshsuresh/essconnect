import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:billDeskSDK/sdk.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:essconnect/Application/StudentProviders/FeesWiseProvider.dart';
import 'package:essconnect/Application/StudentProviders/FinalStatusProvider.dart';
import 'package:essconnect/Application/StudentProviders/InternetConnection.dart';
import 'package:essconnect/Presentation/Student/NoInternetScreen.dart';
import 'package:essconnect/Presentation/Student/Student_home.dart';
import 'package:essconnect/utils/ProgressBarFee.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hypersdkflutter/hypersdkflutter.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:payment_gateway_plugin/payment_gateway_plugin.dart';
import 'package:paytm_allinonesdk/paytm_allinonesdk.dart';
import 'package:payu_checkoutpro_flutter/PayUConstantKeys.dart';
import 'package:payu_checkoutpro_flutter/payu_checkoutpro_flutter.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';


import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:weipl_checkout_flutter/weipl_checkout_flutter.dart';

import '../../Constants.dart';
import '../../utils/constants.dart';
import 'package:crypto/crypto.dart';
import 'PayFee.dart';
import 'SmartPay.dart';
import 'PaymentPolicy.dart';


class PayFeeWise extends StatelessWidget {
  const PayFeeWise({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ConnectivityProvider>(context, listen: false);
    });
    return Consumer<ConnectivityProvider>(
      builder: (context, connection, child) => connection.isOnline == false
          ? const NoInternetConnection()
          : DefaultTabController(
        length: 1,
        child: Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  const Spacer(),
                  const Text('Payment'),
                  const Spacer(),
                  Provider.of<FeeWiseProvider>(context).loading
                      ? const Text(
                    'Loading...',
                    style: TextStyle(
                        color: Colors.white, fontSize: 15),
                  )
                      : IconButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PayFeeWise()));
                      },
                      icon: const Icon(Icons.refresh_outlined))
                ],
              ),
              titleSpacing: 00.0,
              centerTitle: true,
              toolbarHeight: 50.2,
              toolbarOpacity: 0.8,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25)),
              ),
              backgroundColor: UIGuide.light_Purple,

            ),
            body: Consumer<FeeWiseProvider>(
              builder: (context, snap, child) => const TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  FeePayInstallment(),
                ],
              ),
            )),
      ),
    );
  }
}

class NotAvailable extends StatelessWidget {
  const NotAvailable({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "This facility is not available",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: UIGuide.light_Purple),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class FeePayInstallment extends StatefulWidget {
  const FeePayInstallment({Key? key}) : super(key: key);

  @override
  State<FeePayInstallment> createState() => _FeePayInstallmentState();
}

class _FeePayInstallmentState extends State<FeePayInstallment> implements  PayUCheckoutProProtocol{
  final ScrollController _controller = ScrollController();
  final ScrollController _controller2 = ScrollController();
  final ScrollController _controller3 = ScrollController();
  WeiplCheckoutFlutter wlCheckoutFlutter = WeiplCheckoutFlutter();

  String? lastresponse;

  final hyperSDK = HyperSDK();
  dynamic response;
  String paymentResponse = "";
  Map<String, dynamic> sdkPayload= {};

  late PayUCheckoutProFlutter _checkoutPro;
  Map hashResponse = {};
  String payuhash="";
  String payuSalt="";
  String respovalues="";
  String payuOrderid="";
  @override
  void initState() {
    super.initState();
    _checkoutPro = PayUCheckoutProFlutter(this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var p = Provider.of<FeeWiseProvider>(context, listen: false);
      var c = Provider.of<FeeWiseProvider>(context, listen: false);

      p.storeCategory.clear();
      p.busFeeList.clear();
      p.totalFees = 0;
      p.totalStoreFees=0;
      p.totalBusFee = 0;
      p.transactionList.clear();
      await p.vendorMapping();
      await p.gatewayName();
      //await p.feesData();
      c.feeWiseDataList.clear();
      c.feeWiseData();
      c.busFeeList.clear();

      c.resetTotalSelectedFees();


    });
  }

  static String getSHA512Hash(String hashData) {
    var bytes = utf8.encode(hashData); // data being hashed
    var hash = sha512.convert(bytes);
    return hash.toString();
  }
  @override
  generateHash(Map response) {
    var hash="";

    var hashName = response['hashName'];
    var hashStringWithoutSalt = response['hashString'];
    var hashType = response['hashType'];
    var postSalt = response['postSalt'];

    print("hassssshwi $hashStringWithoutSalt");

    var hashDataWithSalt = hashStringWithoutSalt + payuSalt;
    print("with salt $hashDataWithSalt");
    if (postSalt != null) {
      hashDataWithSalt = hashDataWithSalt + postSalt;
    }
    hash = getSHA512Hash(hashDataWithSalt);

    // hashResponse = HashService.generateHash(response,payuSalt);
    var finalHash = {hashName: hash};
    print("final hash  $finalHash");

    _checkoutPro.hashGenerated(hash: finalHash);
  }
  @override
  onPaymentSuccess(dynamic response) async{

    print("success respo $response");
    var payuResponseString = response['payuResponse'];
    Map<String, dynamic> payuResponse = jsonDecode(payuResponseString);
    print("payuuurespo $payuResponse");


    //production
    String finalResponse=
        "${payuResponse['result']['mihpayid']}||${payuResponse['result']['status']}||${payuResponse['result']['txnid']}||${payuResponse['result']['amount']}||${payuResponse['result']['hash']}||${payuResponse['result']['bank_ref_no']}||${payuResponse['result']['Error_Message']}";

    //Statging
    // String finalResponse=
    //     "${payuResponse['id']}||${payuResponse['status']}||${payuResponse['txnid']}||${payuResponse['amount']}||${payuResponse['hash']}||${payuResponse['bank_ref_no']}||${payuResponse['Error_Message']}";
    //

    await _showAlertPau(context, payuOrderid,finalResponse);
  }

  @override
  onPaymentFailure(dynamic response)async {
    print("failure respo $response");
    var payuResponseString = response['payuResponse'];
    Map<String, dynamic> payuResponse = jsonDecode(payuResponseString);
    print("payuuurespo $payuResponse");


    //production
    String finalResponse=
        "${payuResponse['result']['mihpayid']}||${payuResponse['result']['status']}||${payuResponse['result']['txnid']}||${payuResponse['result']['amount']}||${payuResponse['result']['hash']}||${payuResponse['result']['bank_ref_no']}||${payuResponse['result']['Error_Message']}";

    //Statging
    // String finalResponse=
    //     "${payuResponse['id']}||${payuResponse['status']}||${payuResponse['txnid']}||${payuResponse['amount']}||${payuResponse['hash']}||${payuResponse['bank_ref_no']}||${payuResponse['Error_Message']}";
    //

    await _showAlertPau(context, payuOrderid,finalResponse);
  }

  @override
  onPaymentCancel(Map? response) async{
    print("cancel respoo $response");

    String finalResponse = response!.entries.map((e) => '${e.key}:${e.value}').join(', ');

    await _showAlertPau(context, payuOrderid,finalResponse.toString());

  }

  @override
  onError(Map? response) async{
    print("error resspo $response");
    String finalResponse = response!.entries.map((e) => '${e.key}:${e.value}').join(', ');

    await _showAlertPau(context, payuOrderid,finalResponse.toString());
  }
  ////////////////////////// Start Dev Mod Checking ///////////////////////////
  bool devMode = false;
  checkDevModeStatus() async {

    if(Platform.isAndroid){
   //   devMode = await FlutterJailbreakDetection.developerMode;
      print('devMode status:  ::');
      print(devMode);
    }
    else if(Platform.isIOS) {
     // devMode = await FlutterJailbreakDetection.developerMode;
    }
  }
  Future<bool> isPhysicalDevice() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    final iosInfo = await deviceInfo.iosInfo;
    return iosInfo.isPhysicalDevice;
  }

  ////////////////////////// End Dev Mod Checking ///////////////////////////


  String txnId = '';
  String? orderidd;
  String? readableid;
  String? schoolId;
  static MethodChannel _channel = MethodChannel('easebuzz');
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool enable = true;
  @override
  Widget build(BuildContext cont) {
    var size = MediaQuery.of(cont).size;
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          Consumer<FeeWiseProvider>(
            builder: (context, value, child) => value.loading
                ? const ProgressBarFee()
                : value.isLocked == true
                ? const NotAvailable()
                : ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                kheight20,
                value.generalFeesList.isEmpty
                    ? const SizedBox(
                  height: 0,
                  width: 0,
                )
                    : Column(
                  children: [
                    const Padding(
                      padding:
                      EdgeInsets.only(left: 20, bottom: 10),
                      child: Column(

                        children: [
                          Text(
                            'Installment',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                                color: UIGuide.light_Purple),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right:10.0),
                      child: Scrollbar(
                        controller: _controller,
                        thumbVisibility: true,
                        thickness: 6,
                        radius: const Radius.circular(20),
                        child: LimitedBox(
                          maxHeight: size.height*0.25,
                          child:  Consumer<FeeWiseProvider>(
                            builder: (context, value, child) => ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              controller: _controller,
                              itemCount: value.generalFeesList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.only(left: 4.0,right: 4.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CheckboxListTile(

                                        activeColor: const Color.fromARGB(255, 243, 243, 243),
                                        checkColor: UIGuide.light_Purple,
                                        value: value.generalFeesList[index].checkedInstallment,
                                        onChanged: (bool? selected) {

                                          value.instWiseForfeesWise==true?
                                          value.onFeeSelected(selected!, index):
                                          value.existFeeOrderWisePayment==true?
                                          value.onFeeSelectedOrder(selected!, value.generalFeesList[index].installmentName!, value.generalFeesList[index].netDue!, index)
                                              :
                                          value.onFeeSelectedRandom(selected!, value.generalFeesList[index].installmentName!, value.generalFeesList[index].netDue!, index);
                                        },
                                        title: Text(
                                          value.generalFeesList[index].netDue.toString(),
                                          textAlign: TextAlign.end,
                                          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                                        ),
                                        // subtitle:   value.generalFeesList[index].fineAmount! > 0 ?
                                        // Text(
                                        //   'Fine: ${value.generalFeesList[index].fineAmount!.toStringAsFixed(2)}',
                                        //   style: TextStyle(color: Colors.red, fontSize: 14),
                                        // ):
                                        // SizedBox(height: 0,width: 0),
                                        secondary: Text(
                                          value.generalFeesList[index].installmentName!,
                                          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                                        ),
                                      ),



                                      value.generalFeesList[index].fineAmount! > 0 ?
                                      Padding(
                                        padding: const EdgeInsets.only(left: 18.0),
                                        child: Text(
                                          'Fine: ${value.generalFeesList[index].fineAmount!.toStringAsFixed(2)}',
                                          style: const TextStyle(color: Colors.red, fontSize: 15,fontWeight: FontWeight.w500),
                                        ),
                                      ):
                                      const SizedBox(height: 0,width: 0),


                                      value.instWiseForfeesWise==false?
                                      Padding(
                                        padding: const EdgeInsets.only(left: 16.0),
                                        child:  Column(
                                          children: value.generalFeesList[index].feesDetails!.map((feeDetail) {
                                            int feeIndex = value.generalFeesList[index].feesDetails!.indexOf(feeDetail);
                                            return CheckboxListTile(
                                              activeColor: const Color.fromARGB(255, 243, 243, 243),
                                              checkColor:UIGuide.light_Purple,
                                              value: feeDetail.checkedFees,
                                              onChanged: (bool? selected) {

                                                value.existFeeOrderWisePayment ==true?
                                                value.onSubFeeSelectedOrder(selected!,value.generalFeesList[index].installmentName!, index,feeDetail.feesNetDue!, feeIndex)
                                                    :
                                                value.onSubFeeSelectedRandom(selected!,value.generalFeesList[index].installmentName!, index,feeDetail.feesNetDue!, feeIndex);
                                              },
                                              title: Text(
                                                feeDetail.feesNetDue.toString(),
                                                textAlign: TextAlign.end,
                                                style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                                              ),
                                              secondary: SizedBox(
                                                width: MediaQuery.of(context).size.width / 2.5,
                                                child: Text(
                                                  feeDetail.feesName.toString(),
                                                  style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      )  :
                                      Padding(
                                        padding: const EdgeInsets.only(left: 16.0),
                                        child:  Column(
                                          children: value.generalFeesList[index].feesDetails!.map((feeDetail) {
                                            return ListTile(
                                              dense: true, // Add this property to reduce the gap
                                              horizontalTitleGap: 1.0,

                                              leading: Text(
                                                feeDetail.feesName.toString(),
                                                style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                                              ),
                                              trailing: Text(
                                                feeDetail.feesNetDue.toString(),
                                                textAlign: TextAlign.end,
                                                style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    Consumer<FeeWiseProvider>(
                      builder: (context, value, child) =>
                          Center(
                            child: Text(
                              'Total Fee: ${value.totalSelectedFees.toStringAsFixed(2)}',
                              style: const TextStyle( fontSize: 14,color: Colors.black54),
                            ),
                          ),
                    ),
                  ],
                ),
                value.hideBusFeesPayment==true?
                const SizedBox(height: 0,width: 0):
                Consumer<FeeWiseProvider>(
                  builder: (context, bus, child) {
                    if (bus.busFeeList.isNotEmpty) {
                      return Column(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(
                                left: 20, bottom: 10, top: 10),
                            child: Text(
                              'Bus Fee',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                  color: UIGuide.light_Purple),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Scrollbar(
                              controller: _controller2,
                              thumbVisibility: true,
                              thickness: 6,
                              radius: const Radius.circular(10),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 12, right: 5),
                                child: LimitedBox(
                                    maxHeight: size.height*0.25,
                                    child: Consumer<FeeWiseProvider>(
                                      builder: (context, value,
                                          child) =>
                                          ListView.builder(
                                              physics:
                                              const BouncingScrollPhysics(),
                                              shrinkWrap: true,
                                              controller: _controller2,
                                              itemCount: value
                                                  .busFeeList
                                                  .isEmpty
                                                  ? 0
                                                  : value.busFeeList
                                                  .length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                  int index) {
                                                return CheckboxListTile(

                                                  activeColor: const Color.fromARGB(255, 243, 243, 243),
                                                  checkColor: UIGuide.light_Purple,
                                                  value: value.busFeeList[index].checkedInstallment,
                                                  onChanged: (bool? selected) {
                                                    value.onBusFeeSelected(selected!, index);
                                                  },
                                                  title: Text(
                                                    value.busFeeList[index].netDue.toString(),
                                                    textAlign: TextAlign.end,
                                                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                                                  ),
                                                  // subtitle:   value.generalFeesList[index].fineAmount! > 0 ?
                                                  // Text(
                                                  //   'Fine: ${value.generalFeesList[index].fineAmount!.toStringAsFixed(2)}',
                                                  //   style: TextStyle(color: Colors.red, fontSize: 14),
                                                  // ):
                                                  // SizedBox(height: 0,width: 0),
                                                  secondary: Text(
                                                    value.busFeeList[index].installmentName!,
                                                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                                                  ),
                                                );

                                              }),
                                    )),
                              ),
                            ),
                          ),
                          Consumer<FeeWiseProvider>(
                            builder: (context, value, child) =>
                                Center(
                                  child: Text(
                                    'Total Bus Fee : ${value.totalBusFees.toStringAsFixed(2)}',
                                    style: const TextStyle( fontSize: 14,color: Colors.black54),
                                  ),
                                ),
                          ),
                        ],
                      );
                    } else {
                      return const SizedBox(
                        height: 0,
                        width: 0,
                      );
                    }
                  },
                ),
                // Consumer<FeeWiseProvider>(
                //   builder: (context, bus, child) {
                //     if (bus.storeFeeList.isNotEmpty) {
                //       return Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         mainAxisAlignment: MainAxisAlignment.start,
                //         children: [
                //           const Padding(
                //             padding: EdgeInsets.only(
                //                 left: 20, bottom: 10, top: 10),
                //             child: Text(
                //               'Store Fee',
                //               style: TextStyle(
                //                   fontSize: 18,
                //                   fontWeight: FontWeight.w900,
                //                   color: UIGuide.light_Purple),
                //             ),
                //           ),
                //           Scrollbar(
                //             controller: _controller3,
                //             thumbVisibility: true,
                //             thickness: 8,
                //             radius: const Radius.circular(10),
                //             child: Padding(
                //               padding: const EdgeInsets.only(
                //                   left: 12, right: 5),
                //               child: LimitedBox(
                //                   maxHeight: 160,
                //                   child: Consumer<FeeWiseProvider>(
                //                     builder: (context, value,
                //                         child) =>
                //                         ListView.builder(
                //                             physics:
                //                             const BouncingScrollPhysics(),
                //                             shrinkWrap: true,
                //                             controller: _controller3,
                //                             itemCount: value
                //                                 .storeFeeList
                //                                 .isEmpty
                //                                 ? 0
                //                                 : value.storeFeeList
                //                                 .length,
                //                             itemBuilder:
                //                                 (BuildContext context,
                //                                 int index) {
                //                               return CheckboxListTile(
                //                                 activeColor:
                //                                 const Color
                //                                     .fromARGB(
                //                                     255,
                //                                     238,
                //                                     236,
                //                                     236),
                //                                 checkColor: UIGuide
                //                                     .light_Purple,
                //                                 selectedTileColor:
                //                                 UIGuide
                //                                     .light_Purple,
                //                                 value: value
                //                                     .storeCategory
                //                                     .contains(value
                //                                     .storeFeeList[
                //                                 index]
                //                                     .feesName),
                //                                 onChanged:
                //                                     (bool? selected) {
                //
                //                                   value.onStoreFeeSelected(
                //                                       selected!,
                //                                       value
                //                                           .storeFeeList[
                //                                       index]
                //                                           .feesName,
                //                                       index,
                //                                       value
                //                                           .storeFeeList[
                //                                       index]
                //                                           .amount);
                //
                //                                   print(selected);
                //
                //
                //                                 },
                //
                //                                 title: Text(
                //                                   value
                //                                       .storeFeeList[
                //                                   index]
                //                                       .amount
                //                                       .toString(),
                //                                   textAlign:
                //                                   TextAlign.end,
                //                                   style: const TextStyle(
                //                                       fontWeight:
                //                                       FontWeight
                //                                           .w500,
                //                                       fontSize: 15),
                //                                 ),
                //                                 secondary: SizedBox(
                //                                   width: size.width /
                //                                       2.5,
                //                                   child: Text(
                //                                     value
                //                                         .storeFeeList[
                //                                     index]
                //                                         .feesName ??
                //                                         '--',
                //                                     style: const TextStyle(
                //                                         fontWeight:
                //                                         FontWeight
                //                                             .w500,
                //                                         fontSize: 15),
                //                                   ),
                //                                 ),
                //                               );
                //                             }),
                //                   )),
                //             ),
                //           ),
                //         ],
                //       );
                //     } else {
                //       return Container(
                //         height: 0,
                //         width: 0,
                //       );
                //     }
                //   },
                // ),
                kheight20,
                kheight20,
                Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Total : ',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                      // totalFee()
                      Consumer<FeeWiseProvider>(
                        builder: (context, value, child) =>
                            Text(value.grandTotal.toStringAsFixed(2)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: const Color.fromARGB(
                                    255, 223, 223, 223))),
                        child: const Padding(
                          padding: EdgeInsets.all(3.0),
                          child: Text(
                            'Last Transaction Details',
                            style: TextStyle(
                                color: UIGuide.light_Purple,
                                fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      onTap: () async {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(15)),
                                child: Consumer<FeeWiseProvider>(builder:
                                    (context, provider, child) {
                                  String finalDate = "";

                                  if (provider
                                      .lastTransactionStartDate !=
                                      null) {
                                    String createddate = provider
                                        .lastTransactionStartDate ??
                                        '--';
                                    DateTime parsedDateTime =
                                    DateTime.parse(createddate);
                                    finalDate =
                                        DateFormat('dd-MMM-yyyy hh.mm a')
                                            .format(parsedDateTime);
                                  }
                                  return Padding(
                                    padding:
                                    const EdgeInsets.all(8.0),
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: Column(
                                        mainAxisSize:
                                        MainAxisSize.min,
                                        children: [
                                          kheight10,
                                          const Padding(
                                            padding:
                                            EdgeInsets.all(4.0),
                                            child: Text(
                                              'Your last transaction  details',
                                              textAlign:
                                              TextAlign.center,
                                              style: TextStyle(
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  fontSize: 15,
                                                  color: UIGuide
                                                      .light_Purple),
                                            ),
                                          ),
                                          kheight10,
                                          Padding(
                                            padding:
                                            const EdgeInsets.all(
                                                8.0),
                                            child: Row(
                                              children: [
                                                const Text(
                                                  'Transaction Date: ',
                                                  style: TextStyle(
                                                      fontSize: 13),
                                                ),
                                                Flexible(
                                                  child: RichText(
                                                    overflow:
                                                    TextOverflow
                                                        .ellipsis,
                                                    strutStyle:
                                                    const StrutStyle(),
                                                    maxLines: 3,
                                                    text: TextSpan(
                                                        style: const TextStyle(
                                                            fontWeight:
                                                            FontWeight
                                                                .bold,
                                                            color: UIGuide
                                                                .light_Purple),
                                                        text:
                                                        finalDate),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                            const EdgeInsets.all(
                                                8.0),
                                            child: Row(
                                              children: [
                                                const Text(
                                                  'Transaction Amount: ',
                                                  style: TextStyle(
                                                      fontSize: 13),
                                                ),
                                                Text(
                                                  provider.lastTransactionAmount ==
                                                      null
                                                      ? ''
                                                      : provider
                                                      .lastTransactionAmount
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontWeight:
                                                      FontWeight
                                                          .bold,
                                                      color: UIGuide
                                                          .light_Purple),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                            const EdgeInsets.all(
                                                8.0),
                                            child: Row(
                                              children: [
                                                const Text(
                                                  'Transaction Status: ',
                                                  style: TextStyle(
                                                      fontSize: 13),
                                                ),
                                                Consumer<
                                                    FeeWiseProvider>(
                                                  builder: (context,
                                                      value, child) {
                                                    String stats = provider
                                                        .lastOrderStatus ==
                                                        null
                                                        ? ''
                                                        : provider
                                                        .lastOrderStatus
                                                        .toString();
                                                    if (stats ==
                                                        "Success") {
                                                      return const Text(
                                                        "Success",
                                                        style: TextStyle(
                                                            fontWeight:
                                                            FontWeight
                                                                .bold,
                                                            color: Colors
                                                                .green),
                                                      );
                                                    } else if (stats ==
                                                        "Failed") {
                                                      return const Text(
                                                        "Failed",
                                                        style: TextStyle(
                                                            fontWeight:
                                                            FontWeight
                                                                .bold,
                                                            color: Colors
                                                                .red),
                                                      );
                                                    } else if (stats ==
                                                        "Cancelled") {
                                                      return const Text(
                                                        "Cancelled",
                                                        style: TextStyle(
                                                            fontWeight:
                                                            FontWeight
                                                                .bold,
                                                            color: Color.fromARGB(
                                                                255,
                                                                192,
                                                                56,
                                                                7)),
                                                      );
                                                    } else if (stats ==
                                                        "Processing") {
                                                      return const Text(
                                                        "Processing",
                                                        style: TextStyle(
                                                            fontWeight:
                                                            FontWeight
                                                                .bold,
                                                            color: Colors
                                                                .orange),
                                                      );
                                                    } else if (stats ==
                                                        "Pending") {
                                                      return const Text(
                                                        "Pending",
                                                        style: TextStyle(
                                                            fontWeight:
                                                            FontWeight
                                                                .bold,
                                                            color: Colors
                                                                .orange),
                                                      );
                                                    } else {
                                                      return const Text(
                                                        "--",
                                                        style: TextStyle(
                                                            fontWeight:
                                                            FontWeight
                                                                .bold,
                                                            color: UIGuide
                                                                .light_Purple),
                                                      );
                                                    }
                                                  },
                                                  child: Text(
                                                    provider.lastOrderStatus ==
                                                        null
                                                        ? ''
                                                        : provider
                                                        .lastOrderStatus
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontWeight:
                                                        FontWeight
                                                            .bold,
                                                        color: UIGuide
                                                            .light_Purple),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Consumer<FeeWiseProvider>(
                                            builder: (context, value,
                                                child) {
                                              String status = provider
                                                  .lastOrderStatus ==
                                                  null
                                                  ? ''
                                                  : provider
                                                  .lastOrderStatus
                                                  .toString();
                                              if (status ==
                                                  'Success' ||
                                                  status ==
                                                      'Failed') {
                                                return Padding(
                                                  padding:
                                                  const EdgeInsets
                                                      .all(8.0),
                                                  child: Row(
                                                    children: [
                                                      const Text(
                                                        'Download Receipt: ',
                                                        style: TextStyle(
                                                            fontSize:
                                                            13),
                                                      ),
                                                      GestureDetector(
                                                        onTap:
                                                            () async {
                                                          String orderID = provider.orderId ==
                                                              null
                                                              ? ''
                                                              : provider
                                                              .orderId
                                                              .toString();

                                                          await Provider.of<FeeWiseProvider>(
                                                              context,
                                                              listen:
                                                              false)
                                                              .pdfDownload(
                                                              orderID);
                                                          String
                                                          extenstion =
                                                              provider.extension ??
                                                                  '--';

                                                          // SchedulerBinding
                                                          //     .instance
                                                          //     .addPostFrameCallback(
                                                          //         (_) {
                                                          Navigator
                                                              .pushReplacement(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                const PdfDownload()),
                                                          );
                                                          // });
                                                        },
                                                        child: const Icon(
                                                            Icons
                                                                .download,
                                                            color: UIGuide
                                                                .light_Purple),
                                                      )
                                                    ],
                                                  ),
                                                );
                                              } else {
                                                return const SizedBox(
                                                  height: 0,
                                                  width: 0,
                                                );
                                              }
                                            },
                                          ),
                                          Padding(
                                            padding:
                                            const EdgeInsets.all(
                                                8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .end,
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .end,
                                              children: [
                                                kWidth,
                                                MaterialButton(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          8)),
                                                  height: 30,
                                                  onPressed:
                                                      () async {
                                                    Navigator.pop(
                                                        context);
                                                  },
                                                  color: UIGuide
                                                      .light_Purple,
                                                  child: const Text(
                                                    'OK',
                                                    style: TextStyle(
                                                        color: UIGuide
                                                            .WHITE),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                              );
                            });
                      },
                    ),
                  ],
                ),
                kheight20,
                Center(
                  child: InkWell(
                      onTap: (){

                        Navigator.push(context, MaterialPageRoute(builder: (context)=> PaymentPolicy()));
                      },
                      child: const Text("Fees Payment Policies",
                        style: TextStyle(
                          color: UIGuide.light_Purple,

                        ),
                      )),
                ),

                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 2,
            left: 10,
            right: 10,
            child: Padding(
              padding:
              const EdgeInsets.only(top: 0, left: 10, right: 10, bottom: 5),
              child: Consumer<FeeWiseProvider>(
                builder: (_, trans, child) {
                  return trans.loading
                      ? const SizedBox(
                    height: 0,
                    width: 0,
                  )
                      : MaterialButton(
                    height: 45,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    onPressed: () async {
                      await checkDevModeStatus();


                        if (trans.existMap == true) {
                        print("demoooo1");
                        if (trans.lastOrderStatus == 'Success' ||
                            trans.lastOrderStatus == 'Failed' ||
                            trans.lastOrderStatus == 'Cancelled' ||
                             //trans.lastOrderStatus == 'Processing' ||
                            // trans.lastOrderStatus == 'Pending' ||
                            trans.lastOrderStatus == null) {
                          print("demoooo2");
                          print(  trans.transactionList);
                          if (trans.grandTotal != 0) {
                            List transactionList = [];
                            transactionList.clear();
                            String amount = '';
                            for (int i = 0; i <
                                trans.transactionList.length; i++) {
                              if (
                              trans.transactionList[i].name == "FEES"
                              ) {
                                amount = trans.totalSelectedFees.toString();
                              }
                              else if (
                              trans.transactionList[i].name == "BUS FEES"
                              ) {
                                amount = trans.totalBusFees.toString();
                              }
                              else {
                                amount = trans.totalStoreFees.toString();
                              }

                              transactionList.add(
                                  {"name": trans.transactionList[i].name,
                                    "id": trans.transactionList[i].id,
                                    "amount": amount}
                              );
                            }
                            print("Transaction    $transactionList");

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////              get data of one             //////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


                            print('1111111111111111');
                            // String transType =
                            //     trans.transactionList[0].name ?? '--';
                            // String transId1 =
                            //     trans.transactionList[0].id ?? '--';
                            String gateWay = trans.gateway ?? '--';
                            // print(transType);
                            // print(transId1);

                            await AwesomeDialog(
                              context: cont,
                              animType: AnimType.scale,
                              dialogType: DialogType.info,
                              title:
                              'Do you want to continue the payment',
                              desc:
                              "Please don't go 𝐁𝐚𝐜𝐤 once the payment has been initialized!",
                              btnOkOnPress: () async {
//  --------------------------------------------------------------------------------------------------------------    //
///////////////////  ---------------------------     PAYTM    -------------------------------  ////////////////////////
//  --------------------------------------------------------------------------------------------------------------   //

                                if (trans.gateway == 'Paytm') {
                                  print("gateway paytmmmm");
                                  await Provider.of<FeeWiseProvider>(
                                      context,
                                      listen: false)
                                      .getDataOne(
                                      transactionList,
                                      trans.grandTotal.toString(),
                                      trans.selectedInstallments,
                                      gateWay);

                                  String mid1 = trans.mid1 ?? '--';
                                  String orderId1 =
                                      trans.txnorderId1 ?? '--';
                                  String amount1 =
                                      trans.txnAmount1 ?? '--';
                                  String txntoken =
                                      trans.txnToken1 ?? '';
                                  print(txntoken);
                                  String callbackURL1 =
                                      trans.callbackUrl1 ?? '--';
                                  bool staging1 =
                                      trans.isStaging1 ?? true;

                                  if (txntoken.isEmpty) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      const SnackBar(
                                        elevation: 10,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.all(
                                              Radius.circular(
                                                  10)),
                                        ),
                                        duration:
                                        Duration(seconds: 1),
                                        margin: EdgeInsets.only(
                                            bottom: 80,
                                            left: 30,
                                            right: 30),
                                        behavior:
                                        SnackBarBehavior.floating,
                                        content: Text(
                                          'Something went wrong...',
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    );
                                  } else {
                                    await _startTransaction(
                                        txntoken,
                                        mid1,
                                        orderId1,
                                        amount1,
                                        callbackURL1,
                                        staging1);
                                  }
                                }
//  -----------------------------------------------------------------------------------------------------------------  //
///////////////////                                 RazorPay                               ////////////////////////
//  -----------------------------------------------------------------------------------------------------------------  //
                                else if (trans.gateway ==
                                    'RazorPay') {
                                  await Provider.of<FeeWiseProvider>(
                                      context,
                                      listen: false)
                                      .getDataOneRAZORPAY(
                                      transactionList,
                                      trans.grandTotal.toString(),
                                      trans.selectedInstallments,
                                      gateWay);

                                  String key1 = trans.key1Razo ?? '';
                                  String orede1 = trans.order1 ?? '';

                                  String amount1R =
                                      trans.amount1Razo ?? '';
                                  String name1 =
                                      trans.name1Razo ?? '';
                                  String description1 =
                                      trans.description1Razo ?? '';
                                  String customer1 =
                                      trans.customer1Razo ?? '';
                                  String admNo1 =
                                      trans.admnNo1 ?? '';
                                  String email1 =
                                      trans.email1Razo ?? '';
                                  String contact1 =
                                      trans.contact1Razo ?? '';
                                  orderidd = trans.order1;
                                  readableid = trans.readableOrderid1;
                                  schoolId = trans.schoolId1;

                                  print(key1);

                                  if (key1.isEmpty) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      const SnackBar(
                                        elevation: 10,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.all(
                                              Radius.circular(
                                                  10)),
                                        ),
                                        duration:
                                        Duration(seconds: 1),
                                        margin: EdgeInsets.only(
                                            bottom: 80,
                                            left: 30,
                                            right: 30),
                                        behavior:
                                        SnackBarBehavior.floating,
                                        content: Text(
                                          'Something went wrong...',
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    );
                                  } else {
                                    await _startRazorpay(
                                      key1,
                                      amount1R,
                                      name1,
                                      description1,
                                      customer1,
                                      email1,
                                      contact1,
                                      admNo1,
                                      readableid.toString(),
                                      schoolId.toString(),
                                      orede1,

                                    );
                                  }
                                }

                                ///////hdfc razor pay/////////////
                                //////////////////////////////////

                                else if (
                                    trans.gateway=='HdfcRazorPay') {
                                  await Provider.of<FeeWiseProvider>(
                                      context,
                                      listen: false)
                                      .getDataOneHdfcRAZORPAY(
                                      transactionList,
                                      trans.grandTotal.toString(),
                                      trans.selectedInstallments,
                                      gateWay);

                                  String key1 = trans.key1Razo ?? '';
                                  String orede1 = trans.order1 ?? '';

                                  String amount1R =
                                      trans.amount1Razo ?? '';
                                  String name1 =
                                      trans.name1Razo ?? '';
                                  String description1 =
                                      trans.description1Razo ?? '';
                                  String customer1 =
                                      trans.customer1Razo ?? '';
                                  String admNo1 =
                                      trans.admnNo1 ?? '';
                                  String email1 =
                                      trans.email1Razo ?? '';
                                  String contact1 =
                                      trans.contact1Razo ?? '';
                                  orderidd = trans.order1;
                                  readableid = trans.readableOrderid1;
                                  schoolId = trans.schoolId1;

                                  print(key1);

                                  if (key1.isEmpty) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      const SnackBar(
                                        elevation: 10,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.all(
                                              Radius.circular(
                                                  10)),
                                        ),
                                        duration:
                                        Duration(seconds: 1),
                                        margin: EdgeInsets.only(
                                            bottom: 80,
                                            left: 30,
                                            right: 30),
                                        behavior:
                                        SnackBarBehavior.floating,
                                        content: Text(
                                          'Something went wrong...',
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    );
                                  } else {
                                    await _startRazorpay(
                                      key1,
                                      amount1R,
                                      name1,
                                      description1,
                                      customer1,
                                      email1,
                                      contact1,
                                      admNo1,
                                      readableid.toString(),
                                      schoolId.toString(),
                                      orede1,

                                    );
                                  }
                                }
//  -----------------------------------------------------------------------------------------------------------------  //
///////////////////                                 TrakNPay                                    ////////////////////////
//  -----------------------------------------------------------------------------------------------------------------  //
                                else if (trans.gateway ==
                                    'TrakNPay')
                                {
                                  await Provider.of<FeeWiseProvider>(
                                      context,
                                      listen: false)
                                      .getDataOneTpay(
                                      transactionList,
                                      trans.grandTotal.toString(),
                                      trans.selectedInstallments,
                                      gateWay);

                                  String orderId =
                                      trans.orderIdTPay1 ?? '';
                                  String addressLine1 =
                                      trans.addressLine1TPay1 ?? '';
                                  String city = trans.cityTPay1 ?? '';
                                  String udf5 = trans.udf1TPay1 ?? '';
                                  String state =
                                      trans.stateTPay1 ?? '';
                                  String udf4 = trans.udf4TPay1 ?? '';
                                  String phone =
                                      trans.phoneTPay1 ?? '';
                                  String zipCode =
                                      trans.zipCodeTPay1 ?? '';
                                  String currency =
                                      trans.currencyTPay1 ?? '';
                                  String email =
                                      trans.emailTPay1 ?? '';
                                  String country =
                                      trans.countryTPay1 ?? '';

                                  String salt = trans.saltTPay1 ?? '';
                                  String amount =
                                      trans.amountTPay1 ?? '';
                                  String name = trans.nameTPay1 ?? '';
                                  String apiKey =
                                      trans.apiKeyTPay1 ?? '';
                                  String hash = trans
                                      .hashTPay1 ?? '';
                                  String udf3 = trans.udf3TPay1 ?? '';
                                  String udf2 = trans.udf2TPay1 ?? '';
                                  String returnUrl =
                                      trans.returnUrlTPay1 ?? '';
                                  String description =
                                      trans.descriptionTPay1 ?? '';
                                  String udf1 = trans.udf1TPay1 ?? '';
                                  String addressLine2 =
                                      trans.addressLine2TPay1 ?? '';
                                  String formactionUrl = trans
                                      .formactionUrl ??
                                      '';
                                  String mode = trans
                                      .mode ?? '';
                                  var splitinfo=trans.split_info;

                                  if (apiKey.isEmpty) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      const SnackBar(
                                        elevation: 10,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.all(
                                              Radius.circular(
                                                  10)),
                                        ),
                                        duration:
                                        Duration(seconds: 1),
                                        margin: EdgeInsets.only(
                                            bottom: 80,
                                            left: 30,
                                            right: 30),
                                        behavior:
                                        SnackBarBehavior.floating,
                                        content: Text(
                                          'Something went wrong...',
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    );
                                  } else {
                                    await _startTrakNPay(
                                        orderId,
                                        amount,
                                        currency,
                                        description,
                                        name,
                                        email,
                                        phone,
                                        addressLine1,
                                        addressLine2,
                                        city,
                                        state,
                                        country,
                                        zipCode,
                                        udf1,
                                        udf2,
                                        udf3,
                                        udf4,
                                        udf5,
                                        apiKey,
                                        salt,
                                        hash,
                                        returnUrl,
                                        formactionUrl,
                                        mode,
                                        splitinfo
                                    );
                                  }
                                }
//  -----------------------------------------------------------------------------------------------------------------  //
///////////////////                                 WorldLine                               ////////////////////////
//  -----------------------------------------------------------------------------------------------------------------  //
                                else if (trans.gateway ==
                                    'WorldLine' ||
                                    trans.gateway == "SibWorldLine") {
                                  await Provider.of<FeeWiseProvider>(
                                      context,
                                      listen: false)
                                      .getDataOneWORLDLINE(
                                      transactionList,
                                      trans.grandTotal.toString(),
                                      trans.selectedInstallments,
                                      gateWay);

                                  String token = trans.token1WL ?? '';
                                  String paymentMode =
                                      trans.paymentMode1WL ?? '';
                                  String merchantId =
                                      trans.merchantId1WL ?? '';
                                  String currency =
                                      trans.currency1WL ?? '';
                                  String consumerId =
                                      trans.consumerId1WL ?? '';
                                  String consumerMobileNo =
                                      trans.consumerMobileNo1WL ??
                                          '7356642999';
                                  String consumerEmailId =
                                      trans.consumerEmailId1WL ?? '';
                                  txnId = trans.txnId1WL ?? ' ';
                                  bool? enableExpressPay =
                                      trans.enableExpressPay1WL ??
                                          false;
                                  List? items = trans.items1WL ?? [];
                                  String cartDescription =
                                      trans.cartDescription1WL ?? "";

                                  if (token.isEmpty) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      const SnackBar(
                                        elevation: 10,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.all(
                                              Radius.circular(
                                                  10)),
                                        ),
                                        duration:
                                        Duration(seconds: 1),
                                        margin: EdgeInsets.only(
                                            bottom: 80,
                                            left: 30,
                                            right: 30),
                                        behavior:
                                        SnackBarBehavior.floating,
                                        content: Text(
                                          'Something went wrong...',
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    );
                                  } else {
                                    await _startWorldLine(
                                        enableExpressPay,
                                        token,
                                        paymentMode,
                                        merchantId,
                                        currency,
                                        consumerId,
                                        consumerMobileNo,
                                        consumerEmailId,
                                        txnId,
                                        items,
                                        cartDescription);
                                    print("demooo2");
                                  }
                                }


                                /////////////////////////////
                                // Bill Desk
                                //////////////////////////////
                                else if (trans.gateway ==
                                    'BillDesk') {
                                  if (devMode) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          elevation: 10,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                          ),
                                          duration: Duration(seconds: 1),
                                          margin: EdgeInsets.only(
                                              bottom: 80, left: 30, right: 30),
                                          behavior: SnackBarBehavior.floating,
                                          content: Text(
                                            'Turn off Developer mode!',
                                            textAlign: TextAlign.center,
                                          ),
                                        ));
                                    print("hello");
                                  }
                                  else {
                                    String readOrdrId = "";
                                    await Provider.of<FeeWiseProvider>(
                                        context,
                                        listen: false)
                                        .getBillDeskDataFeeWise(
                                        transactionList,
                                        trans.grandTotal.toString(),
                                        trans.selectedInstallments,
                                        gateWay);
                                    String merchantLogo = 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.dfstudio.com%2Fdigital-image-size-and-resolution-what-do-you-need-to-know%2F&psig=AOvVaw2VQ7aG2C8dSquxZ-oyWAfG&ust=1724138975697000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCPj3t7PEgIgDFQAAAAAdAAAAABAE';
                                    final flowConfigMap =
                                    {
                                      "merchantId": trans.mercId,
                                      "bdOrderId": trans.bdOrderId,
                                      "showConvenienceFeeDetails": "",
                                      "authToken": trans.authToken,
                                      "childWindow": "true",
                                      "retryCount": 0,
                                      "returnUrl": trans.returnUrlBilldesk,

                                    };
                                    print(flowConfigMap);
                                    final sdkConfigMap =
                                    {
                                      "flowConfig": flowConfigMap,
                                      "flowType": "payments",
                                      "merchantLogo": merchantLogo,

                                    };
                                    ResponseHandler responseHandler = SdkResponseHandler(
                                        context);

                                    final sdkConfig = SdkConfig(
                                        sdkConfigJson: SdkConfiguration
                                            .fromJson(sdkConfigMap),
                                        responseHandler: responseHandler,
                                        isUATEnv: false,
                                        isDevModeAllowed: false,
                                        isJailBreakAllowed: false
                                    );

                                    //SDKWebView.openSDKWebView(sdkConfig);

                                    //    await Navigator.push(context, MaterialPageRoute(builder: (context)=>SDKWebView(config: sdkConfig)));

                                    SDKWebView.openSDKWebView(sdkConfig);
                                  }
                                }


                                /////////////////////////

                                /////////////////////////////
                                // Smart gateway
                                //////////////////////////////
                                else if (trans.gateway ==
                                    'HdfcSmartGateway') {
                                  await Provider.of<FeeWiseProvider>(
                                      context,
                                      listen: false)
                                      .getSmartData(
                                      transactionList,
                                      trans.grandTotal.toString(),
                                      trans.selectedInstallments,
                                      gateWay);
                                  sdkPayload=
                                  {
                                    "requestId": trans.requestId,
                                    "service":trans.service,
                                    "payload": {
                                      "collectAvsInfo": trans.collectAvsInfo,
                                      "clientId": trans.clientId,
                                      "amount": trans.amountt,
                                      "merchantId":trans.merchantId,
                                      "clientAuthToken": trans.clientAuthToken,
                                      "service": trans.service,
                                      "clientAuthTokenExpiry": trans.clientAuthTokenExpiry,
                                      "environment": trans.environment,
                                      "action": trans.action,
                                      "customerId": trans.customerId,
                                      "currency": trans.currency,
                                      "returnUrl":trans.returnUrl,
                                      "customerPhone": trans.customerPhone ?? "7356642999",
                                      "customerEmail": trans.customerEmail ??  "gjinfotech@gmail.com",
                                      "orderId": trans.orderIdd,
                                      "displayBusinessAs": trans.displayBusinessAs
                                    },
                                    "expiry": trans.expiry
                                  };


                                  print("smartpayloaad");

                                  print(sdkPayload.toString());


                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentPage(sdkPayload: sdkPayload,)));

                                }

                                /////////////////////////////
                                // EaseBuzz
                                //////////////////////////////
                                else if (trans
                                    .gateway ==
                                    'Easebuzz') {
                                  await Provider.of<
                                      FeeWiseProvider>(
                                      context,
                                      listen: false)
                                      .getEazebuzzData(
                                      transactionList,
                                      trans.grandTotal.toString(),
                                      trans.selectedInstallments,
                                      gateWay);

                                  String access_key = trans.pgKeyForMobileapp.toString();
                                  String pay_mode = "production";
                                  Object parameters =
                                  {
                                    "access_key":access_key,
                                    "pay_mode":pay_mode
                                  };
                                  final paymentResponse = await _channel.invokeMethod("payWithEasebuzz", parameters);

                                  if (paymentResponse != null && paymentResponse is Map && paymentResponse.containsKey('payment_response')) {
                                    final paymentResponseData = paymentResponse['payment_response'];

                                    print("txniddddddddddddd");
                                    String txnId = paymentResponseData['txnid'] ?? "";
                                    String key = paymentResponseData['key'] ?? "";
                                    String amount = paymentResponseData['amount'] ?? "";
                                    String productinfo = paymentResponseData['productinfo'] ?? "";
                                    String firstname = paymentResponseData['firstname'] ?? "";
                                    String email = paymentResponseData['email'] ?? "";
                                    String udf1 = paymentResponseData['udf1'] ?? "";
                                    String udf2 = paymentResponseData['udf2'] ?? "";
                                    String udf3 = paymentResponseData['udf3'] ?? "";
                                    String udf4 = paymentResponseData['udf4'] ?? "";
                                    String udf5 = paymentResponseData['udf5'] ?? "";
                                    String udf6 = paymentResponseData['udf6'] ?? "";
                                    String udf7 = paymentResponseData['udf7'] ?? "";
                                    String udf8 = paymentResponseData['udf8'] ?? "";
                                    String udf9 = paymentResponseData['udf9'] ?? "";
                                    String udf10 = paymentResponseData['udf10'] ?? "";
                                    String status = paymentResponseData['status'] ?? "";
                                    String mode = paymentResponseData['mode'] ?? "";
                                    String easepayid = paymentResponseData['easepayid'] ?? "";
                                    String bankrefnum = paymentResponseData['bank_ref_num'] ?? "";
                                    String errorMessage = paymentResponseData['error_Message'] ?? "";
                                    String hash = paymentResponseData['hash'] ?? "";



                                    print("Transaction ID: $txnId");
                                    await showAlertEaseBuzz(context,
                                        key,
                                        txnId,
                                        amount,
                                        productinfo,
                                        firstname,
                                        email,
                                        udf1,
                                        udf2,
                                        udf3,
                                        udf4,
                                        udf5,
                                        udf6,
                                        udf7,
                                        udf8,
                                        udf9,
                                        udf10,
                                        status,
                                        mode,
                                        easepayid,
                                        bankrefnum,
                                        errorMessage,
                                        hash
                                    );

                                  } else {
                                    print("Invalid payment response structure.");
                                  }

                                }

                                ///////////////////////
                                //Payu-Hdfc/////////////////////
                                //////////////////////////////////
                                else if (trans.gateway ==
                                    'PayuHdfc') {

                                  String readOrdrId = "";
                                  await Provider.of<FeeWiseProvider>(
                                      context,
                                      listen: false)
                                      .getPayuData(
                                      transactionList,
                                      trans.grandTotal.toString(),
                                      trans.selectedInstallments,
                                      gateWay);

                                  String txnid = trans.payutxnid ?? '';
                                  String amount =
                                      trans.payuamount ?? '';
                                  String prodinfo =
                                      trans.payuproductinfo ?? '';
                                  String name =
                                      trans.payufirstname ?? '';
                                  String lastname= trans.payulastname??"";
                                  String curl =trans.payucurl??"";
                                  String email =
                                      trans.payuemail ?? 'gjinfotech@gmail.com';
                                  String phone =
                                      trans.payuphone ??
                                          '7356642999';
                                  String surl =
                                      trans.payusurl ?? '';
                                  String furl =
                                      trans.payufurl ?? '';
                                  String udf1 =
                                      trans.payuudf1 ?? '';
                                  String udf2 =
                                      trans.payuudf2 ?? '';
                                  String apikey =
                                      trans.payukey ?? '';
                                  String hash =
                                      trans.payuhash ?? '';
                                  String salt =
                                      trans.payuSalt ?? '';
                                  String mode =
                                  trans.payupaymentMode=="TEST"?"1":"0";
                                  var splitinfo=trans.splitRequest;




                                  await _startPayU(
                                      txnid,
                                      amount,
                                      prodinfo,
                                      name,
                                      lastname,
                                      email,
                                      phone,
                                      surl,
                                      furl,
                                      curl,
                                      udf1,
                                      udf2,
                                      apikey,
                                      hash,
                                      salt,
                                      mode,
                                      splitinfo
                                  );



                                }

                                else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(
                                    const SnackBar(
                                      elevation: 10,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      duration: Duration(seconds: 1),
                                      margin: EdgeInsets.only(
                                          bottom: 80,
                                          left: 30,
                                          right: 30),
                                      behavior:
                                      SnackBarBehavior.floating,
                                      content: Text(
                                        'Payment Gateway Not Provided...',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  );
                                }
                              },
                              btnCancelOnPress: () {
                                Navigator.of(
                                    _scaffoldKey.currentContext!)
                                    .pop();
                                //      Navigator.pop(context);
                              },
                            ).show();
                          }


                          else if (trans.transactionList.isEmpty) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(
                              const SnackBar(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(10)),
                                ),
                                duration: Duration(seconds: 1),
                                margin: EdgeInsets.only(
                                    bottom: 80, left: 30, right: 30),
                                behavior: SnackBarBehavior.floating,
                                content: Text(
                                  'Something Went Wrong.....!',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                          }
                          else if(trans.grandTotal==0){
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(20)),
                                ),
                                duration: Duration(seconds: 1),
                                margin: EdgeInsets.only(
                                    bottom: 80, left: 30, right: 30),
                                behavior: SnackBarBehavior.floating,
                                content: Text(
                                  'Select Fees.....!',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                          }
                          else if (trans.lastOrderStatus ==
                              'Processing') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(20)),
                                ),
                                duration: Duration(seconds: 5),
                                margin: EdgeInsets.only(
                                    bottom: 80, left: 30, right: 30),
                                behavior: SnackBarBehavior.floating,
                                content: Text(
                                  'Please wait for 30 minutes...\n Your payment is under 𝗣𝗿𝗼𝗰𝗲𝘀𝘀𝗶𝗻𝗴',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                          } else if (trans.lastOrderStatus == 'Pending') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(20)),
                                ),
                                duration: Duration(seconds: 5),
                                margin: EdgeInsets.only(
                                    bottom: 80, left: 30, right: 30),
                                behavior: SnackBarBehavior.floating,
                                content: Text(
                                  'Please wait for 30 minutes...\n Your payment is  𝐏𝐞𝐧𝐝𝐢𝐧𝐠',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                          }
                          else {
                            print(
                              trans.transactionList.length,
                            );
                            print('Something Went wrong1');
                            ScaffoldMessenger.of(context)
                                .showSnackBar(
                              const SnackBar(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(10)),
                                ),
                                duration: Duration(seconds: 1),
                                margin: EdgeInsets.only(
                                    bottom: 80, left: 30, right: 30),
                                behavior: SnackBarBehavior.floating,
                                content: Text(
                                  'Something Went Wrong.....!',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                          }
                        }
                        else  {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(20)),
                              ),
                              duration: Duration(seconds: 5),
                              margin: EdgeInsets.only(
                                  bottom: 80, left: 30, right: 30),
                              behavior: SnackBarBehavior.floating,
                              content: Text(
                                'Please wait for 30 minutes...\n Your payment is  𝐏𝐞𝐧𝐝𝐢𝐧𝐠',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        }
                      }
                      else {
                        print("vendor issur");
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(20)),
                            ),
                            duration: Duration(seconds: 5),
                            margin: EdgeInsets.only(
                                bottom: 80, left: 30, right: 30),
                            behavior: SnackBarBehavior.floating,
                            content: Text(
                              'Issue in Vendor Mapping..!,\n Please contact School...',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      }

                    },

                    color: UIGuide.light_Purple,
                    child: const Text(
                      'Proceed to Pay',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 16),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

//         ----------------------------------------------------------------------------------------            //
//         ***********************                paytm                    ************************            //
//         ----------------------------------------------------------------------------------------            //
  String result = "";
  bool restrictAppInvoke = true;

  Future<void> _startTransaction(
      String txnToken,
      String mid,
      String orderId,
      String amount,
      String callbackUrl,
      bool isStaging,
      ) async {
    if (txnToken.isEmpty) {
      return;
    }

    print('sendMap');
    var size = MediaQuery.of(context).size;
    try {
      var response = AllInOneSdk.startTransaction(
        mid,
        orderId,
        amount,
        txnToken,
        callbackUrl,
        isStaging,
        restrictAppInvoke,
      );
      response.then((value) {
        print(value);

        setState(() {
          result = value.toString();
          print("Resultttttttttttttttt  $result");
        });
        print('-----------------------------------------------------------');
        _showAlert(context, orderId,result.toString());
      }).catchError((onError) {
        if (onError is PlatformException) {
          print('-------------------Failed-----------------');
          _showAlert(context, orderId,result.toString());
          setState(() {
            result = "${onError.message} \n  ${onError.details}";
          });
          print("Resultttttttttttttttt  $result");
        } else {
          setState(() {
            print('-------------------Pending-----------------');

            result = onError.toString();
            _showAlert(context, orderId,result.toString());

          });
          print("Resultttttttttttttttt  $result");
        }
      });
    } catch (err) {

      print('-------------------ERROR-----------------');
      result = err.toString();
      _showAlert(context, orderId,result.toString());
      print("Resultttttttttttttttt  $result");
    }
  }

  void _showAlert(BuildContext context, String orderID,String respo) async {
    var size = MediaQuery.of(context).size;
    await Provider.of<FinalStatusProvider>(context, listen: false)
        .transactionStatus(orderID,respo);

    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Consumer<FinalStatusProvider>(
          builder: (context, paytm, child) {
            if (paytm.reponseCode == '01') {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                content: SizedBox(
                  height: size.height / 4,
                  width: size.width * 3,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: AlignmentDirectional.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: size.height / 10,
                          ),
                          const Text(
                            "TRANSACTION SUCCESS",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 20,
                                color: UIGuide.light_Purple),
                          ),
                          kheight20,
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                      WidgetStateProperty.all(
                                          UIGuide.light_Purple),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder:
                                                  (context) =>
                                                  StudentHome()),
                                              (Route<dynamic> route) =>
                                          false);
                                    },
                                    child: const Text(
                                      'Back to Home',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 18,
                                          color: UIGuide.WHITE),
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                      Positioned(
                        top: -190,
                        child: CircleAvatar(
                            radius: 165,
                            backgroundColor: Colors.transparent,
                            child: LottieBuilder.asset(
                              'assets/89618-gopay-succesfull-payment.json',
                            )),
                      )
                    ],
                  ),
                ),
              );
            } else if (paytm.reponseCode == '810' ||
                paytm.reponseCode == '501' ||
                paytm.reponseCode == '401' ||
                paytm.reponseCode == '335' ||
                paytm.reponseCode == '334' ||
                paytm.reponseCode == '295' ||
                paytm.reponseCode == '235' ||
                paytm.reponseCode == '227') {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                content: SizedBox(
                  height: size.height / 4,
                  width: size.width * 3,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: AlignmentDirectional.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: size.height / 10,
                          ),
                          const Text(
                            "TRANSACTION FAILED",
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 20,
                                color: UIGuide.light_Purple),
                          ),
                          kheight20,
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                      WidgetStateProperty.all(
                                          UIGuide.light_Purple),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder:
                                                  (context) =>
                                                  StudentHome()),
                                              (Route<dynamic> route) =>
                                          false);
                                    },
                                    child: const Text(
                                      'Back to Home',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 18,
                                          color: UIGuide.WHITE),
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                      Positioned(
                        top: -80,
                        child: CircleAvatar(
                            radius: 70,
                            backgroundColor: Colors.white,
                            child: SvgPicture.asset(UIGuide.failed)),
                      )
                    ],
                  ),
                ),
              );
            } else if (paytm.reponseCode == '400' ||
                paytm.reponseCode == '402') {
              AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                content: SizedBox(
                  height: size.height / 4,
                  width: size.width * 3,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: AlignmentDirectional.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: size.height / 10,
                          ),
                          const Text(
                            "TRANSACTION PENDING",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 20,
                                color: UIGuide.light_Purple),
                          ),
                          kheight20,
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                      WidgetStateProperty.all(
                                          UIGuide.light_Purple),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder:
                                                  (context) =>
                                                  StudentHome()),
                                              (Route<dynamic> route) =>
                                          false);
                                    },
                                    child: const Text(
                                      'Back to Home',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 18,
                                          color: UIGuide.WHITE),
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                      Positioned(
                        top: -90,
                        child: CircleAvatar(
                            radius: 80,
                            backgroundColor: Colors.transparent,
                            child: SvgPicture.asset(UIGuide.pending)),
                      )
                    ],
                  ),
                ),
              );
            } else {
              AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                content: SizedBox(
                  height: size.height / 4,
                  width: size.width * 3,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: AlignmentDirectional.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: size.height / 10,
                          ),
                          const Text(
                            "Something went wrong",
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 20,
                                color: UIGuide.light_Purple),
                          ),
                          kheight20,
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                      WidgetStateProperty.all(
                                          UIGuide.light_Purple),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder:
                                                  (context) =>
                                                  StudentHome()),
                                              (Route<dynamic> route) =>
                                          false);
                                    },
                                    child: const Text(
                                      'Back to Home',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 18,
                                          color: UIGuide.WHITE),
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                      const Positioned(
                        top: -80,
                        child: CircleAvatar(
                          radius: 70,
                          backgroundColor: Colors.orange,
                          child: Icon(
                            Icons.warning,
                            size: 80,
                            color: UIGuide.BLACK,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              content: SizedBox(
                height: size.height / 4,
                width: size.width * 3,
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: AlignmentDirectional.center,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: size.height / 10,
                        ),
                        const Text(
                          "Something went wrong",
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 20,
                              color: UIGuide.light_Purple),
                        ),
                        kheight20,
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                    WidgetStateProperty.all(
                                        UIGuide.light_Purple),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                StudentHome()),
                                            (Route<dynamic> route) =>
                                        false);
                                  },
                                  child: const Text(
                                    'Back to Home',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 18,
                                        color: UIGuide.WHITE),
                                  ))
                            ],
                          ),
                        )
                      ],
                    ),
                    const Positioned(
                      top: -80,
                      child: CircleAvatar(
                        radius: 70,
                        backgroundColor: Colors.orange,
                        child: Icon(
                          Icons.warning,
                          size: 80,
                          color: UIGuide.BLACK,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ));
  }

//         ----------------------------------------------------------------------------------------            //
//         ***********************                Razorpay                *************************            //
//         ----------------------------------------------------------------------------------------            //

  _startRazorpay(String key, String amount, String name, String description,
      String nameP, String email, String contact,String admno,String readableOrderid,String schoold, String orderId) async {
    Razorpay razorpay = Razorpay();

    print("start");
    var options = {
      'key': key,
      'amount': amount,
      'order_id': orderId,
      'name': name,
      'description': description,
      'retry': {'enabled': false},
      'prefill': {"name": nameP, "email": email, "contact": contact},
      'notes' : {
        "admissionNumber": admno,
        "name": name,
        "readableOrderid": readableOrderid,
        "schoold": schoold,

      },
      'modal': {
        "confirm_close": true,
        "animation": true,
        "handleback": true,
        "escape": true,
      }
    };
    print({
      'key': key,
      'amount': amount,
      'order_id': orderId,
      'name': name,
      'description': description,
      'retry': {'enabled': false},
      'prefill': {"name": nameP, "email": email, "contact": contact},
      'notes' : {
        "admissionNumber": admno,
        "name": name,
        "readableOrderid": readableOrderid,
        "schoold": schoold
      },
      'modal': {
        "confirm_close": true,
        "animation": true,
        "handleback": true,
        "escape": true,
      }
    });


    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
    // razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);
    razorpay.open(options);
  }

  void handlePaymentErrorResponse(PaymentFailureResponse response) async {
    print('------------------Failed-----------------------------');
    print("eroror");
    print(response.message);
    String lastresponse11= response.error.toString();
    lastresponse=lastresponse11.replaceAll('{', '').replaceAll('}', '');
    print(lastresponse);

    print("eroror");
    await _showAlertRazorPay(context, readableid!, orderidd!);
  }

  void handlePaymentSuccessResponse(
      PaymentSuccessResponse response,
      ) async {
    print('------------------Success-----------------------------');
    print("success");
    print(response.toString());
    lastresponse= "Order ID:${response.orderId},Payment ID:${response.paymentId},Signature:${response.signature}";
    print(lastresponse);
    print("success");
    await _showAlertRazorPay(context, readableid!, orderidd!);


    print(response.toString());
  }

///////////////////////////////////////////////
  ///

  _showAlertRazorPay(
      BuildContext context,
      String readable,
      String orderID,
      ) async {
    var size = MediaQuery.of(context).size;
    String order = ("${readable}_$orderID");
    await Provider.of<FinalStatusProvider>(context, listen: false)
        .transactionStatusRazorPay(order,lastresponse.toString());
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Consumer<FinalStatusProvider>(
          builder: (context, razor, child) {
            if (razor.reponseMsgRazor == 'captured') {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                content: SizedBox(
                  height: size.height / 4,
                  width: size.width * 3,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: AlignmentDirectional.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: size.height / 10,
                          ),
                          const Text(
                            "TRANSACTION SUCCESS",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 20,
                                color: UIGuide.light_Purple),
                          ),
                          kheight20,
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                      WidgetStateProperty.all(
                                          UIGuide.light_Purple),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder:
                                                  (context) =>
                                                  StudentHome()),
                                              (Route<dynamic> route) =>
                                          false);
                                    },
                                    child: const Text(
                                      'Back to Home',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 18,
                                          color: UIGuide.WHITE),
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                      Positioned(
                        top: -190,
                        child: CircleAvatar(
                            radius: 165,
                            backgroundColor: Colors.transparent,
                            child: LottieBuilder.asset(
                              'assets/89618-gopay-succesfull-payment.json',
                            )),
                      )
                    ],
                  ),
                ),
              );
            } else if (razor.reponseMsgRazor == 'failed') {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                content: SizedBox(
                  height: size.height / 4,
                  width: size.width * 3,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: AlignmentDirectional.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: size.height / 10,
                          ),
                          const Text(
                            "TRANSACTION FAILED",
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 20,
                                color: UIGuide.light_Purple),
                          ),
                          kheight20,
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                      WidgetStateProperty.all(
                                          UIGuide.light_Purple),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder:
                                                  (context) =>
                                                  StudentHome()),
                                              (Route<dynamic> route) =>
                                          false);
                                    },
                                    child: const Text(
                                      'Back to Home',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 18,
                                          color: UIGuide.WHITE),
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                      Positioned(
                        top: -80,
                        child: CircleAvatar(
                            radius: 70,
                            backgroundColor: Colors.white,
                            child: SvgPicture.asset(UIGuide.failed)),
                      )
                    ],
                  ),
                ),
              );
            } else if (razor.reponseCode == null) {
              AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                content: SizedBox(
                  height: size.height / 4,
                  width: size.width * 3,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: AlignmentDirectional.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: size.height / 10,
                          ),
                          const Text(
                            "TRANSACTION PENDING",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 20,
                                color: UIGuide.light_Purple),
                          ),
                          kheight20,
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                      WidgetStateProperty.all(
                                          UIGuide.light_Purple),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder:
                                                  (context) =>
                                                  StudentHome()),
                                              (Route<dynamic> route) =>
                                          false);
                                    },
                                    child: const Text(
                                      'Back to Home',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 18,
                                          color: UIGuide.WHITE),
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                      Positioned(
                        top: -90,
                        child: CircleAvatar(
                            radius: 80,
                            backgroundColor: Colors.transparent,
                            child: SvgPicture.asset(UIGuide.pending)),
                      )
                    ],
                  ),
                ),
              );
            } else {
              AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                content: SizedBox(
                  height: size.height / 4,
                  width: size.width * 3,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: AlignmentDirectional.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: size.height / 10,
                          ),
                          const Text(
                            "Something went wrong",
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 20,
                                color: UIGuide.light_Purple),
                          ),
                          kheight20,
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                      WidgetStateProperty.all(
                                          UIGuide.light_Purple),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder:
                                                  (context) =>
                                                  StudentHome()),
                                              (Route<dynamic> route) =>
                                          false);
                                    },
                                    child: const Text(
                                      'Back to Home',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 18,
                                          color: UIGuide.WHITE),
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                      Positioned(
                        top: -90,
                        child: CircleAvatar(
                            radius: 80,
                            backgroundColor: Colors.transparent,
                            child: SvgPicture.asset(
                                UIGuide.somethingWentWrong)),
                      )
                    ],
                  ),
                ),
              );
            }
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              content: SizedBox(
                height: size.height / 4,
                width: size.width * 3,
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: AlignmentDirectional.center,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: size.height / 10,
                        ),
                        const Text(
                          "Something went wrong",
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 20,
                              color: UIGuide.light_Purple),
                        ),
                        kheight20,
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                    WidgetStateProperty.all(
                                        UIGuide.light_Purple),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                StudentHome()),
                                            (Route<dynamic> route) =>
                                        false);
                                  },
                                  child: const Text(
                                    'Back to Home',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 18,
                                        color: UIGuide.WHITE),
                                  ))
                            ],
                          ),
                        )
                      ],
                    ),
                    Positioned(
                      top: -90,
                      child: CircleAvatar(
                          radius: 80,
                          backgroundColor: Colors.transparent,
                          child:
                          SvgPicture.asset(UIGuide.somethingWentWrong)),
                    )
                  ],
                ),
              ),
            );
          },
        ));
  }

//////////////----------------------------  TrakNpay    ---------------------
  _startTrakNPay(
      String orderId,
      String amount,
      String currency,
      String description,
      String name,
      String email,
      String phone,
      String address1,
      String address2,
      String city,
      String state,
      String country,
      String zipcode,
      String udf1,
      String udf2,
      String udf3,
      String udf4,
      String udf5,
      String apiKey,
      String saltKey,
      String hash,
      String returnUrl,
      String? formactionUrl,
      String? mode,
      var split_info
      ) async {
    Map<String, dynamic>? paymentRequestDictionary = {

      'api_key': apiKey,
      'hash': hash,
      'order_id': orderId,
      'mode': mode,
      'description': description.isEmpty ? "Online Fees Payment" : description,
      'currency': currency,
      'amount': amount,
      'name': name.isEmpty ? "demo" : name,
      'email': email.isEmpty ? "gjinfotech@gmail.com" : email,
      'phone': phone.isEmpty ? "7356642999" : phone,
      'city': city.isEmpty ? "Irinjalakkuda" : city,
      'state': state.isEmpty ? "Kerala" : state,
      'country': country.isEmpty ? "India" : country,
      'zip_code': zipcode.isEmpty ? "680125" : zipcode,
      'address_line_1':address1.isEmpty ? "address" : address1,
      'address_line_2': address2.isEmpty ? "address" : address2,
      'return_url': "${UIGuide.baseURL}/online-payment/traknpay/callback-mobileapp",
      if (split_info != null)
        'split_info':split_info
    };
    print(
        "******************            $paymentRequestDictionary        ***********************");
    open(paymentRequestDictionary, formactionUrl!, context,orderId);
  }

  void open(Map<String, dynamic> request,String url ,BuildContext context,String orderId) async {
    try {
      response = await PaymentGatewayPlugin.open(url, request);

      if (response != null) {
        print("Response => ${response.toString()}"); // This prints the map to console
        String status = response['status'] ?? 'Unknown';
        String responseMessage = response['response']?.toString() ?? 'No response';
        String responseMessagefinal = responseMessage.substring(1, responseMessage.length - 1);
        setState(() {
          paymentResponse = "Status:$status||Response:$responseMessagefinal";
        });
        print("resssssspoooooo $paymentResponse");
        await showAlertTrakNPay(context, orderId, response.toString());
      } else {
        setState(() {
          paymentResponse = "No response received from the payment gateway.";
        });
        await showAlertTrakNPay(context, orderId, response.toString());
      }
    } on PlatformException {
      setState(() {
        paymentResponse = 'Failed to initiate payment.';
      });
    }
  }

//  -- Show Alert
  showAlertTrakNPay(
      BuildContext context,
      String orderID,
      String gatewayResponse
      ) async
  {
    var size = MediaQuery.of(context).size;
    String order = orderID;
    print("orderrrrrrrrrrrrrrrr  $order");


    await Future.delayed(const Duration(seconds: 5));
    await Provider.of<FinalStatusProvider>(context, listen: false)
        .transactionStatusTrakNPay(order,gatewayResponse);

    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Consumer<FinalStatusProvider>(
          builder: (contex, trak, child) {
            print(trak.statusss);
            print('----------');
            if (trak.statusss == 'Success') {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                content: SizedBox(
                  height: size.height / 4,
                  width: size.width * 3,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: AlignmentDirectional.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: size.height / 10,
                          ),
                          const Text(
                            "TRANSACTION SUCCESS",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 20,
                                color: UIGuide.light_Purple),
                          ),
                          kheight20,
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                      WidgetStateProperty.all(
                                          UIGuide.light_Purple),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder:
                                                  (context) =>
                                              const StudentHome()),
                                              (Route<dynamic> route) =>
                                          false);
                                    },
                                    child: const Text(
                                      'Back to Home',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 18,
                                          color: UIGuide.WHITE),
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                      Positioned(
                        top: -190,
                        child: CircleAvatar(
                            radius: 165,
                            backgroundColor: Colors.transparent,
                            child: LottieBuilder.asset(
                              'assets/89618-gopay-succesfull-payment.json',
                            )),
                      )
                    ],
                  ),
                ),
              );
            } else if (trak.statusss == 'Failed') {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                content: SizedBox(
                  height: size.height / 4,
                  width: size.width * 3,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: AlignmentDirectional.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: size.height / 10,
                          ),
                          const Text(
                            "TRANSACTION FAILED",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 20,
                                color: UIGuide.light_Purple),
                          ),
                          kheight20,
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                      WidgetStateProperty.all(
                                          UIGuide.light_Purple),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder:
                                                  (context) =>
                                              const StudentHome()),
                                              (Route<dynamic> route) =>
                                          false);
                                    },
                                    child: const Text(
                                      'Back to Home',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 18,
                                          color: UIGuide.WHITE),
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                      Positioned(
                        top: -80,
                        child: CircleAvatar(
                            radius: 70,
                            backgroundColor: Colors.white,
                            child: SvgPicture.asset(UIGuide.failed)),
                      )
                    ],
                  ),
                ),
              );
            } else if (trak.statusss == "Processing") {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                content: SizedBox(
                  height: size.height / 4,
                  width: size.width * 3,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: AlignmentDirectional.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: size.height / 10,
                          ),
                          const Text(
                            "TRANSACTION PROCESSING",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                                color: UIGuide.light_Purple),
                          ),
                          kheight20,
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                      WidgetStateProperty.all(
                                          UIGuide.light_Purple),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder:
                                                  (context) =>
                                              const StudentHome()),
                                              (Route<dynamic> route) =>
                                          false);
                                    },
                                    child: const Text(
                                      'Back to Home',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 18,
                                          color: UIGuide.WHITE),
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                      Positioned(
                        top: -90,
                        child: CircleAvatar(
                            radius: 80,
                            backgroundColor: Colors.transparent,
                            child: SvgPicture.asset(UIGuide.pending)),
                      )
                    ],
                  ),
                ),
              );
            } else if (trak.statusss == "Pending") {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                content: SizedBox(
                  height: size.height / 4,
                  width: size.width * 3,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: AlignmentDirectional.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: size.height / 10,
                          ),
                          const Text(
                            "TRANSACTION PENDING",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 20,
                                color: UIGuide.light_Purple),
                          ),
                          kheight20,
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                      WidgetStateProperty.all(
                                          UIGuide.light_Purple),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder:
                                                  (context) =>
                                              const StudentHome()),
                                              (Route<dynamic> route) =>
                                          false);
                                    },
                                    child: const Text(
                                      'Back to Home',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 18,
                                          color: UIGuide.WHITE),
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                      Positioned(
                        top: -90,
                        child: CircleAvatar(
                            radius: 80,
                            backgroundColor: Colors.transparent,
                            child: SvgPicture.asset(UIGuide.pending)),
                      )
                    ],
                  ),
                ),
              );
            } else if (trak.statusss == null) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                content: SizedBox(
                  height: size.height / 4,
                  width: size.width * 3,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: AlignmentDirectional.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: size.height / 10,
                          ),
                          const Text(
                            "TRANSACTION PENDING",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 20,
                                color: UIGuide.light_Purple),
                          ),
                          kheight20,
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                      WidgetStateProperty.all(
                                          UIGuide.light_Purple),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder:
                                                  (context) =>
                                              const StudentHome()),
                                              (Route<dynamic> route) =>
                                          false);
                                    },
                                    child: const Text(
                                      'Back to Home',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 18,
                                          color: UIGuide.WHITE),
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                      Positioned(
                        top: -90,
                        child: CircleAvatar(
                            radius: 80,
                            backgroundColor: Colors.transparent,
                            child: SvgPicture.asset(UIGuide.pending)),
                      )
                    ],
                  ),
                ),
              );
            } else {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                content: SizedBox(
                  height: size.height / 4,
                  width: size.width * 3,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: AlignmentDirectional.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: size.height / 10,
                          ),
                          const Text(
                            "Something went wrong",
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 20,
                                color: UIGuide.light_Purple),
                          ),
                          kheight20,
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                      WidgetStateProperty.all(
                                          UIGuide.light_Purple),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder:
                                                  (context) =>
                                              const StudentHome()),
                                              (Route<dynamic> route) =>
                                          false);
                                    },
                                    child: const Text(
                                      'Back to Home',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 18,
                                          color: UIGuide.WHITE),
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                      Positioned(
                        top: -90,
                        child: CircleAvatar(
                            radius: 80,
                            backgroundColor: Colors.transparent,
                            child: SvgPicture.asset(
                                UIGuide.somethingWentWrong)),
                      )
                    ],
                  ),
                ),
              );
            }
          },
        ));
  }

//         ----------------------------------------------------------------------------------------            //
//         ***********************                WORLDLINE              *************************            //
//         ----------------------------------------------------------------------------------------          //

  String cutStringAfterLetter(String originalString, String letter) {
    int index = originalString.indexOf(letter);
    if (index != -1) {
      // If the letter is found in the string
      return originalString.substring(index + 1, originalString.length);
    } else {
      // If the letter is not found in the string
      return originalString;
    }
  }

  String deviceID = "";
  _startWorldLine(
      bool enableExpressPay,
      String token,
      String paymentMode,
      String merchantId,
      String currency,
      String consumerId,
      String consumerMobileNo,
      String consumerEmailId,
      String txnIdd,
      List items,
      String cartDescription) {
    try {
      if (Platform.isAndroid) {
        deviceID =
        "AndroidSH2"; // Android-specific deviceId, supported options are "AndroidSH1" & "AndroidSH2"
      } else if (Platform.isIOS) {
        deviceID =
        "iOSSH2"; // iOS-specific deviceId, supported options are "iOSSH1" & "iOSSH2"
      }

      var reqJson = {
        "features": {
          "enableAbortResponse": true,
          "enableExpressPay": enableExpressPay,
          "enableInstrumentDeRegistration": true,
          "enableMerTxnDetails": true
        },
        "consumerData": {
          "deviceId": deviceID,
          "token": token,
          "paymentMode": paymentMode,
          "merchantLogoUrl":
          "https://www.paynimo.com/CompanyDocs/company-logo-vertical.png", //provided merchant logo will be displayed
          "merchantId": merchantId,
          "currency": currency,
          "consumerId": consumerId,
          "consumerMobileNo": consumerMobileNo,
          "consumerEmailId": consumerEmailId,
          "txnId": txnIdd, //Unique merchant transaction ID
          "cartDescription": cartDescription,
          "items": items,
          "customStyle": {
            "PRIMARY_COLOR_CODE": "#45beaa", //merchant primary color code
            "SECONDARY_COLOR_CODE":
            "#FFFFFF", //provide merchant"s suitable color code
            "BUTTON_COLOR_CODE_1":
            "#aa7de8", //merchant"s button background color code
            "BUTTON_COLOR_CODE_2":
            "#FFFFFF" //provide merchant"s suitable color code for button text
          }
        }
      };
      print(reqJson);

      print("rosssssss");
      wlCheckoutFlutter.on(WeiplCheckoutFlutter.wlResponse, handleResponse);
      wlCheckoutFlutter.open(reqJson);
    } catch (e) {
      print('-------------------ERROR-----------------');
      wlCheckoutFlutter.on(WeiplCheckoutFlutter.wlResponse, handleResponse);
    }
  }

/////////////--------------- Show Alert WORLDLine
  void handleResponse(Map<dynamic, dynamic> response) async {
    print(response);
    await showAlertWORLDLine(context, txnId, response.toString());
    print("woe=rldddddddd");
    print(response);
  }

  Future showAlertWORLDLine(
      BuildContext contex, String orderID, String response) async
  {
    var size = MediaQuery.of(context).size;
    List words = [];
    words.clear();
    words = response.split("|");
    print(words);
    print(words[5]);
    String paymentGatewayTransactionId = words[5];
    await Future.delayed(const Duration(seconds: 5));
    await Provider.of<FinalStatusProvider>(contex, listen: false)
        .transactionStatusWorldLine(orderID, paymentGatewayTransactionId,response.toString());
    // await Provider.of<FinalStatusProvider>(contex, listen: false)
    //     .transactionStatusWorldLine(orderID, paymentGatewayTransactionId);
    await showDialog(
        context: contex,
        barrierDismissible: false,
        builder: (context) => Consumer<FinalStatusProvider>(
          builder: (contex, trak, _) {
            if (trak.reponseCodeWorldLine == '0300') {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                content: SizedBox(
                  height: size.height / 4,
                  width: size.width * 3,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: AlignmentDirectional.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: size.height / 10,
                          ),
                          const Text(
                            "TRANSACTION SUCCESS",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 20,
                                color: UIGuide.light_Purple),
                          ),
                          kheight20,
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                      WidgetStateProperty.all(
                                          UIGuide.light_Purple),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder:
                                                  (context) =>
                                                  StudentHome()),
                                              (Route<dynamic> route) =>
                                          false);
                                    },
                                    child: const Text(
                                      'Back to Home',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 18,
                                          color: UIGuide.WHITE),
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                      Positioned(
                        top: -190,
                        child: CircleAvatar(
                            radius: 165,
                            backgroundColor: Colors.transparent,
                            child: LottieBuilder.asset(
                              'assets/89618-gopay-succesfull-payment.json',
                            )),
                      )
                    ],
                  ),
                ),
              );
            } else if (trak.reponseCodeWorldLine == '0399') {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                content: SizedBox(
                  height: size.height / 4,
                  width: size.width * 3,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: AlignmentDirectional.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: size.height / 10,
                          ),
                          const Text(
                            "TRANSACTION FAILED",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 20,
                                color: UIGuide.light_Purple),
                          ),
                          kheight20,
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                      WidgetStateProperty.all(
                                          UIGuide.light_Purple),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder:
                                                  (context) =>
                                                  StudentHome()),
                                              (Route<dynamic> route) =>
                                          false);
                                    },
                                    child: const Text(
                                      'Back to Home',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 18,
                                          color: UIGuide.WHITE),
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                      Positioned(
                        top: -80,
                        child: CircleAvatar(
                            radius: 70,
                            backgroundColor: Colors.white,
                            child: SvgPicture.asset(UIGuide.failed)),
                      )
                    ],
                  ),
                ),
              );
            } else if (trak.reponseCodeWorldLine == '0396' ||
                trak.reponseCodeWorldLine == '9999') {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                content: SizedBox(
                  height: size.height / 4,
                  width: size.width * 3,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: AlignmentDirectional.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: size.height / 10,
                          ),
                          const Text(
                            "TRANSACTION PROCESSING",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                                color: UIGuide.light_Purple),
                          ),
                          kheight20,
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                      WidgetStateProperty.all(
                                          UIGuide.light_Purple),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder:
                                                  (context) =>
                                                  StudentHome()),
                                              (Route<dynamic> route) =>
                                          false);
                                    },
                                    child: const Text(
                                      'Back to Home',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 18,
                                          color: UIGuide.WHITE),
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                      Positioned(
                        top: -90,
                        child: CircleAvatar(
                            radius: 80,
                            backgroundColor: Colors.transparent,
                            child: SvgPicture.asset(UIGuide.pending)),
                      )
                    ],
                  ),
                ),
              );
            } else if (trak.reponseCodeWorldLine == '0398') {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                content: SizedBox(
                  height: size.height / 4,
                  width: size.width * 3,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: AlignmentDirectional.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: size.height / 10,
                          ),
                          const Text(
                            "TRANSACTION PENDING",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 20,
                                color: UIGuide.light_Purple),
                          ),
                          kheight20,
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                      WidgetStateProperty.all(
                                          UIGuide.light_Purple),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder:
                                                  (context) =>
                                                  StudentHome()),
                                              (Route<dynamic> route) =>
                                          false);
                                    },
                                    child: const Text(
                                      'Back to Home',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 18,
                                          color: UIGuide.WHITE),
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                      Positioned(
                        top: -90,
                        child: CircleAvatar(
                            radius: 80,
                            backgroundColor: Colors.transparent,
                            child: SvgPicture.asset(UIGuide.pending)),
                      )
                    ],
                  ),
                ),
              );
            } else if (trak.reponseCodeWorldLine == '0392') {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                content: SizedBox(
                  height: size.height / 4,
                  width: size.width * 3,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: AlignmentDirectional.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: size.height / 10,
                          ),
                          const Text(
                            "TRANSACTION  CANCELLED",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 17,
                                color: UIGuide.light_Purple),
                          ),
                          kheight20,
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                      WidgetStateProperty.all(
                                          UIGuide.light_Purple),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder:
                                                  (context) =>
                                                  StudentHome()),
                                              (Route<dynamic> route) =>
                                          false);
                                    },
                                    child: const Text(
                                      'Back to Home',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 18,
                                          color: UIGuide.WHITE),
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                      Positioned(
                        top: -90,
                        child: CircleAvatar(
                            radius: 80,
                            backgroundColor: Colors.transparent,
                            child: SvgPicture.asset(UIGuide.pending)),
                      )
                    ],
                  ),
                ),
              );
            } else {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                content: SizedBox(
                  height: size.height / 4,
                  width: size.width * 3,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: AlignmentDirectional.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: size.height / 10,
                          ),
                          const Text(
                            "Something went wrong",
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 20,
                                color: UIGuide.light_Purple),
                          ),
                          kheight20,
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                      WidgetStateProperty.all(
                                          UIGuide.light_Purple),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder:
                                                  (context) =>
                                                  StudentHome()),
                                              (Route<dynamic> route) =>
                                          false);
                                    },
                                    child: const Text(
                                      'Back to Home',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 18,
                                          color: UIGuide.WHITE),
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                      Positioned(
                        top: -90,
                        child: CircleAvatar(
                            radius: 80,
                            backgroundColor: Colors.transparent,
                            child: SvgPicture.asset(
                                UIGuide.somethingWentWrong)),
                      )
                    ],
                  ),
                ),
              );
            }
          },
        ));
  }

  ////////////////////////////////////////////////////////
///////////////EaseBuzz Status///////////////////////////
//////////////////////////////////////////////////////////

  Future showAlertEaseBuzz(
      BuildContext contex,
      String key,String txnid,
      String amount,String productinfo,String firstname,
      String email,String udf1,String udf2,String udf3,
      String udf4,String udf5,String udf6,String udf7,
      String udf8,String udf9,String udf10,
      String status,String mode,String easepayid,
      String bankrefnum,String errorMessage,
      String hash
      ) async
  {
    var size = MediaQuery.of(context).size;
    await Future.delayed(const Duration(seconds: 5));
    await Provider.of<FinalStatusProvider>(contex, listen: false)
        .transactionStatusEaseBuzz(
        key,txnid,amount,productinfo,firstname,email,udf1,udf2,
        udf3,udf4,udf5, udf6,udf7,udf8,
        udf9,udf10, status,mode,easepayid,
        bankrefnum,errorMessage,hash
    );
    await showDialog(
        context: contex,
        barrierDismissible: false,
        builder: (context) => Consumer<FinalStatusProvider>(
          builder: (contex, trak, _) {
            if (trak.reponseMsgEasebuzz == 'Success') {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                content: SizedBox(
                  height: size.height / 4,
                  width: size.width * 3,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: AlignmentDirectional.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: size.height / 10,
                          ),
                          const Text(
                            "TRANSACTION SUCCESS",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 20,
                                color: UIGuide.light_Purple),
                          ),
                          kheight20,
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                      WidgetStateProperty.all(
                                          UIGuide.light_Purple),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder:
                                                  (context) =>
                                              const StudentHome()),
                                              (Route<dynamic> route) =>
                                          false);
                                    },
                                    child: const Text(
                                      'Back to Home',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 18,
                                          color: UIGuide.WHITE),
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                      Positioned(
                        top: -190,
                        child: CircleAvatar(
                            radius: 165,
                            backgroundColor: Colors.transparent,
                            child: LottieBuilder.asset(
                              'assets/89618-gopay-succesfull-payment.json',
                            )),
                      )
                    ],
                  ),
                ),
              );
            }
            else if (trak.reponseMsgEasebuzz == 'Failed') {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                content: SizedBox(
                  height: size.height / 4,
                  width: size.width * 3,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: AlignmentDirectional.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: size.height / 10,
                          ),
                          const Text(
                            "TRANSACTION FAILED",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 20,
                                color: UIGuide.light_Purple),
                          ),
                          kheight20,
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                      WidgetStateProperty.all(
                                          UIGuide.light_Purple),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder:
                                                  (context) =>
                                              const StudentHome()),
                                              (Route<dynamic> route) =>
                                          false);
                                    },
                                    child: const Text(
                                      'Back to Home',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 18,
                                          color: UIGuide.WHITE),
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                      Positioned(
                        top: -80,
                        child: CircleAvatar(
                            radius: 70,
                            backgroundColor: Colors.white,
                            child: SvgPicture.asset(UIGuide.failed)),
                      )
                    ],
                  ),
                ),
              );
            }
            else if (trak.reponseMsgEasebuzz == 'Processing') {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                content: SizedBox(
                  height: size.height / 4,
                  width: size.width * 3,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: AlignmentDirectional.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: size.height / 10,
                          ),
                          const Text(
                            "TRANSACTION PROCESSING",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                                color: UIGuide.light_Purple),
                          ),
                          kheight20,
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                      WidgetStateProperty.all(
                                          UIGuide.light_Purple),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder:
                                                  (context) =>
                                              const StudentHome()),
                                              (Route<dynamic> route) =>
                                          false);
                                    },
                                    child: const Text(
                                      'Back to Home',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 18,
                                          color: UIGuide.WHITE),
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                      Positioned(
                        top: -90,
                        child: CircleAvatar(
                            radius: 80,
                            backgroundColor: Colors.transparent,
                            child: SvgPicture.asset(UIGuide.pending)),
                      )
                    ],
                  ),
                ),
              );
            }
            else if (trak.reponseMsgEasebuzz == 'Pending') {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                content: SizedBox(
                  height: size.height / 4,
                  width: size.width * 3,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: AlignmentDirectional.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: size.height / 10,
                          ),
                          const Text(
                            "TRANSACTION PENDING",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 20,
                                color: UIGuide.light_Purple),
                          ),
                          kheight20,
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                      WidgetStateProperty.all(
                                          UIGuide.light_Purple),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder:
                                                  (context) =>
                                              const StudentHome()),
                                              (Route<dynamic> route) =>
                                          false);
                                    },
                                    child: const Text(
                                      'Back to Home',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 18,
                                          color: UIGuide.WHITE),
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                      Positioned(
                        top: -90,
                        child: CircleAvatar(
                            radius: 80,
                            backgroundColor: Colors.transparent,
                            child: SvgPicture.asset(UIGuide.pending)),
                      )
                    ],
                  ),
                ),
              );
            }
            else if (trak.reponseMsgEasebuzz == 'Cancelled') {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                content: SizedBox(
                  height: size.height / 4,
                  width: size.width * 3,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: AlignmentDirectional.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: size.height / 10,
                          ),
                          const Text(
                            "TRANSACTION  CANCELLED",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 17,
                                color: UIGuide.light_Purple),
                          ),
                          kheight20,
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                      WidgetStateProperty.all(
                                          UIGuide.light_Purple),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder:
                                                  (context) =>
                                              const StudentHome()),
                                              (Route<dynamic> route) =>
                                          false);
                                    },
                                    child: const Text(
                                      'Back to Home',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 18,
                                          color: UIGuide.WHITE),
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                      Positioned(
                        top: -90,
                        child: CircleAvatar(
                            radius: 80,
                            backgroundColor: Colors.transparent,
                            child: SvgPicture.asset(UIGuide.pending)),
                      )
                    ],
                  ),
                ),
              );
            }
            else {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                content: SizedBox(
                  height: size.height / 4,
                  width: size.width * 3,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: AlignmentDirectional.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: size.height / 10,
                          ),
                          const Text(
                            "Something went wrong",
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 20,
                                color: UIGuide.light_Purple),
                          ),
                          kheight20,
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                      WidgetStateProperty.all(
                                          UIGuide.light_Purple),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder:
                                                  (context) =>
                                              const StudentHome()),
                                              (Route<dynamic> route) =>
                                          false);
                                    },
                                    child: const Text(
                                      'Back to Home',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 18,
                                          color: UIGuide.WHITE),
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                      Positioned(
                        top: -90,
                        child: CircleAvatar(
                            radius: 80,
                            backgroundColor: Colors.transparent,
                            child: SvgPicture.asset(
                                UIGuide.somethingWentWrong)),
                      )
                    ],
                  ),
                ),
              );
            }
          },
        ));
  }

  ////////////////////// PayU-HDFC////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////
  Future _startPayU(
      String orderId,
      String amount,
      String productInfo,
      String name,
      String lastname,
      String email,
      String phone,
      String surl,
      String furl,
      String curl,
      String udf1,
      String udf2,
      String apiKey,
      String hash,
      String salt,
      String? mode,
      var splitinfo,
      ) async
  {
    payuhash=hash;
    payuOrderid=orderId;
    payuSalt=salt;
    print("haaaaaash $hash");


    var spitPaymentDetails=splitinfo;

    print(hashResponse);
    var additionalParam = {
      PayUAdditionalParamKeys.udf1: udf1,
      PayUAdditionalParamKeys.udf2:udf2,
      PayUAdditionalParamKeys.udf3: "udf3 value",
      PayUAdditionalParamKeys.udf4: "udf4 value",
      PayUAdditionalParamKeys.udf5: "udf5 value",
    };



    var payUPaymentParams = {
      PayUPaymentParamKey.key: apiKey,
      PayUPaymentParamKey.amount: amount, //REQUIRED
      PayUPaymentParamKey.productInfo: productInfo, //REQUIRED
      PayUPaymentParamKey.firstName: name, //REQUIRED
      PayUPaymentParamKey.email:email.isEmpty ? "gjinfotech@gmail.com" : email,
      PayUPaymentParamKey.phone: phone.isEmpty ? "7356642999" : phone, //REQUIRED
      PayUPaymentParamKey.ios_surl: surl,//"https://api.esstestonline.in/online-payment/payu-hdfc/mapp-surl", //REQUIRED
      PayUPaymentParamKey.ios_furl: furl, //REQUIRED
      PayUPaymentParamKey.android_surl: surl, //REQUIRED
      PayUPaymentParamKey.android_furl: furl, //REQUIRED
      PayUPaymentParamKey.environment: mode, //0 => Production 1 => Test
      PayUPaymentParamKey.userCredential:phone, //Pass user credential to fetch saved cards => A:B - OPTIONAL
      PayUPaymentParamKey.transactionId: orderId, //REQUIRED
      PayUPaymentParamKey.additionalParam: additionalParam, // OPTIONAL
      PayUPaymentParamKey.enableNativeOTP: true, // OPTIONAL
      PayUPaymentParamKey.userToken: "",
      if (spitPaymentDetails != null)
        PayUPaymentParamKey.splitPaymentDetails: "[$spitPaymentDetails]",
    };
    print("parameee $payUPaymentParams");



    var payUCheckoutProConfig = {
      PayUCheckoutProConfigKeys.primaryColor: "#4994EC",
      PayUCheckoutProConfigKeys.secondaryColor: "#FFFFFF",
      PayUCheckoutProConfigKeys.merchantName: "PayU",
      PayUCheckoutProConfigKeys.merchantLogo: "logo",
      PayUCheckoutProConfigKeys.showExitConfirmationOnCheckoutScreen: true,
      PayUCheckoutProConfigKeys.showExitConfirmationOnPaymentScreen: true,
      PayUCheckoutProConfigKeys.merchantResponseTimeout: 2000,
      PayUCheckoutProConfigKeys.autoSelectOtp: true,
      // PayUCheckoutProConfigKeys.enforcePaymentList: enforcePaymentList,
      PayUCheckoutProConfigKeys.waitingTime: 30000,
      PayUCheckoutProConfigKeys.autoApprove: true,
      PayUCheckoutProConfigKeys.merchantSMSPermission: true,
      PayUCheckoutProConfigKeys.showCbToolbar: true,
    };

    await _checkoutPro.openCheckoutScreen(
      payUPaymentParams: payUPaymentParams,
      payUCheckoutProConfig: payUCheckoutProConfig,
    );


  }
  Future _showAlertPau(
      BuildContext context,
      String orderID,
      var response
      ) async
  {
    var size = MediaQuery.of(context).size;
    //String order = ("${readable}_$orderID");
    // await Future.delayed(const Duration(seconds: 5));
    Provider.of<FeeWiseProvider>(context, listen: false).setLoading(true);
    await Future.delayed(const Duration(seconds: 2));
    await Provider.of<FinalStatusProvider>(context, listen: false)
        .transactionStatusPayuHdfc(orderID,response.toString());
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Consumer<FinalStatusProvider>(
          builder: (context, payu, child) {
            print("lastpayu status ${payu.reponseMsgPayu}");
            if (payu.reponseMsgPayu == 'success') {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                content: SizedBox(
                  height: size.height / 4,
                  width: size.width * 3,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: AlignmentDirectional.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: size.height / 10,
                          ),
                          const Text(
                            "TRANSACTION SUCCESS",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 20,
                                color: UIGuide.light_Purple),
                          ),
                          kheight20,
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                      WidgetStateProperty.all(
                                          UIGuide.light_Purple),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder:
                                                  (context) =>
                                              const StudentHome()),
                                              (Route<dynamic> route) =>
                                          false);
                                    },
                                    child: const Text(
                                      'Back to Home',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 18,
                                          color: UIGuide.WHITE),
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                      Positioned(
                        top: -190,
                        child: CircleAvatar(
                            radius: 165,
                            backgroundColor: Colors.transparent,
                            child: LottieBuilder.asset(
                              'assets/89618-gopay-succesfull-payment.json',
                            )),
                      )
                    ],
                  ),
                ),
              );
            }
            else if (payu.reponseMsgPayu == 'failure')
            {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                content: SizedBox(
                  height: size.height / 4,
                  width: size.width * 3,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: AlignmentDirectional.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: size.height / 10,
                          ),
                          const Text(
                            "TRANSACTION FAILED",
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 20,
                                color: UIGuide.light_Purple),
                          ),
                          kheight20,
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                      WidgetStateProperty.all(
                                          UIGuide.light_Purple),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder:
                                                  (context) =>
                                              const StudentHome()),
                                              (Route<dynamic> route) =>
                                          false);
                                    },
                                    child: const Text(
                                      'Back to Home',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 18,
                                          color: UIGuide.WHITE),
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                      Positioned(
                        top: -80,
                        child: CircleAvatar(
                            radius: 70,
                            backgroundColor: Colors.white,
                            child: SvgPicture.asset(UIGuide.failed)),
                      )
                    ],
                  ),
                ),
              );
            }
            else if (payu.reponseMsgPayu == 'Cancelled')
            {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                content: SizedBox(
                  height: size.height / 4,
                  width: size.width * 3,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: AlignmentDirectional.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: size.height / 10,
                          ),
                          const Text(
                            "TRANSACTION CANCELLED",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 20,
                                color: UIGuide.light_Purple),
                          ),
                          kheight20,
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                      WidgetStateProperty.all(
                                          UIGuide.light_Purple),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder:
                                                  (context) =>
                                              const StudentHome()),
                                              (Route<dynamic> route) =>
                                          false);
                                    },
                                    child: const Text(
                                      'Back to Home',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 18,
                                          color: UIGuide.WHITE),
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                      Positioned(
                        top: -90,
                        child: CircleAvatar(
                            radius: 80,
                            backgroundColor: Colors.transparent,
                            child: SvgPicture.asset(UIGuide.pending)),
                      )
                    ],
                  ),
                ),
              );

            }
            else if (payu.reponseMsgPayu == 'pending')
            {
              print("get gunction");
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                content: SizedBox(
                  height: size.height / 4,
                  width: size.width * 3,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: AlignmentDirectional.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: size.height / 10,
                          ),
                          const Text(
                            "TRANSACTION PROCESSING",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 20,
                                color: UIGuide.light_Purple),
                          ),
                          kheight20,
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                      WidgetStateProperty.all(
                                          UIGuide.light_Purple),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder:
                                                  (context) =>
                                              const StudentHome()),
                                              (Route<dynamic> route) =>
                                          false);
                                    },
                                    child: const Text(
                                      'Back to Home',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 18,
                                          color: UIGuide.WHITE),
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                      Positioned(
                        top: -90,
                        child: CircleAvatar(
                            radius: 80,
                            backgroundColor: Colors.transparent,
                            child: SvgPicture.asset(UIGuide.pending)),
                      )
                    ],
                  ),
                ),
              );

            }
            else {
              print("get error function");
              AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                content: SizedBox(
                  height: size.height / 4,
                  width: size.width * 3,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: AlignmentDirectional.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: size.height / 10,
                          ),
                          const Text(
                            "Something went wrong",
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 20,
                                color: UIGuide.light_Purple),
                          ),
                          kheight20,
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                      WidgetStateProperty.all(
                                          UIGuide.light_Purple),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder:
                                                  (context) =>
                                              const StudentHome()),
                                              (Route<dynamic> route) =>
                                          false);
                                    },
                                    child: const Text(
                                      'Back to Home',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 18,
                                          color: UIGuide.WHITE),
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                      Positioned(
                        top: -90,
                        child: CircleAvatar(
                            radius: 80,
                            backgroundColor: Colors.transparent,
                            child: SvgPicture.asset(
                                UIGuide.somethingWentWrong)),
                      )
                    ],
                  ),
                ),
              );
            }
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              content: SizedBox(
                height: size.height / 4,
                width: size.width * 3,
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: AlignmentDirectional.center,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: size.height / 10,
                        ),
                        const Text(
                          "Something went wrong",
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 20,
                              color: UIGuide.light_Purple),
                        ),
                        kheight20,
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                    WidgetStateProperty.all(
                                        UIGuide.light_Purple),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                            const StudentHome()),
                                            (Route<dynamic> route) =>
                                        false);
                                  },
                                  child: const Text(
                                    'Back to Home',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 18,
                                        color: UIGuide.WHITE),
                                  ))
                            ],
                          ),
                        )
                      ],
                    ),
                    Positioned(
                      top: -90,
                      child: CircleAvatar(
                          radius: 80,
                          backgroundColor: Colors.transparent,
                          child:
                          SvgPicture.asset(UIGuide.somethingWentWrong)),
                    )
                  ],
                ),
              ),
            );
          },
        ));
    Provider.of<FeeWiseProvider>(context, listen: false).setLoading(false);
  }

  void _showToast(BuildContext context,String title) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        content:  Text(title),
        // action: SnackBarAction(label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }
}

class PdfDownload extends StatefulWidget {
  const PdfDownload({
    Key? key,
  }) : super(key: key);
  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort send =
    IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
  }

  @override
  State<PdfDownload> createState() => _PdfDownloadState();
}

class _PdfDownloadState extends State<PdfDownload> {
  final ReceivePort _port = ReceivePort();
  @override
  void initState() {
    super.initState();

    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];

      setState(() {});
    });

    FlutterDownloader.registerCallback(downloadCallback);
  }

  static void downloadCallback(String id, int status, int progress) {
    print('Download task ($id) is in status ($status) and $progress% complete');
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  Future<void> requestDownload(String url, String name) async {
    String localPath="";
    if (Platform.isAndroid) {
      localPath = '/storage/emulated/0/Download';
    } else if (Platform.isIOS) {
      final dir = await getApplicationDocumentsDirectory();
      localPath = dir.path;
    }
    print("pathhhh  $localPath");
    final savedDir = Directory(localPath);
    await savedDir.create(recursive: true).then((value) async {
      String? taskid = await FlutterDownloader.enqueue(
        savedDir: localPath,
        url: url,
        fileName: "Payment Receipt $name.pdf",
        showNotification: true,
        openFileFromNotification: true,
      );

      print(taskid);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FeeWiseProvider>(
      builder: (context, value, child) => Scaffold(
          appBar: AppBar(
            title: const Text('Payment Reciept'),
            titleSpacing: 00.0,
            centerTitle: true,
            toolbarHeight: 60.2,
            toolbarOpacity: 0.8,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(25),
                  bottomLeft: Radius.circular(25)),
            ),
            backgroundColor: UIGuide.light_Purple,
            actions: [
              Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: IconButton(
                      onPressed: () async {
                        await requestDownload(
                          value.url.toString() ?? '--',
                          value.idd.toString() == null
                              ? '---'
                              : value.idd.toString() + value.name.toString(),
                        );
                      },
                      icon: const Icon(Icons.download_outlined))),
            ],
          ),
          body: SfPdfViewer.network(
            value.url.toString() ?? '--',
          )),
    );
  }
}
