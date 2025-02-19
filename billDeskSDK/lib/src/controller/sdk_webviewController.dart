library sdk;

import 'dart:async';
import 'dart:io';
import 'package:billDeskSDK/src/utilities/sdk_logger.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:safe_device/safe_device.dart';
import '../../sdk.dart';

class SDKWebviewController{

  late SdkConfig sdkConfig;
  late InAppWebViewController inAppWebViewController;
  Rx<bool> shouldModelClose = false.obs;
  late Map<String,dynamic> paymentsConfig;
  String? orderId;
  late var customerRefId;
  late SdkPresenter presenter;
  late String merchantId;
  late String bdOrderId;
  late String orderDate;

  Rx<bool> bdModelShouldModalClose = false.obs;
  Rx<bool> bdModalError = false.obs;
  Rx<bool> loading = true.obs;
  bool upiFlowTriggered = false;
  late FlowType flowType;

  SDKWebviewController(this.sdkConfig);

  checkJailBreakOrRootStatus() async {

    final bool jailBreak = await SafeDevice.isJailBroken;
    final bool isPhysicalDevice = await SafeDevice.isRealDevice;

    if (jailBreak && !isPhysicalDevice) {
      throw SdkException(sdkError: SdkError(msg: "Oops! It seems like your device is jailbroken or emulator. Please note that our app is not compatible with jailbroken devices for security reasons.",
          description: 'Forbidden',
          code: 403,
          SDK_ERROR: SdkError.SERVICE_ERROR));
    }

  }

  checkDevModeStatus() async {
    bool devMode = false;
    if(Platform.isAndroid){
      devMode = await SafeDevice.isDevelopmentModeEnable;
    }
    else if(Platform.isIOS) {
      devMode = !await isPhysicalDevice();
    }

    if (devMode) {
      throw SdkException(sdkError: SdkError(msg: "SDK is disabled in developer mode.",
          description: 'Forbidden',
          code: 403,
          SDK_ERROR: SdkError.SERVICE_ERROR));
    }

  }

  Future<bool> isPhysicalDevice() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    final iosInfo = await deviceInfo.iosInfo;
    return iosInfo.isPhysicalDevice;
  }

  Future<Response<dynamic>?> getApiResponse(
      FlowType flowType, Response<dynamic>? response, SdkPresenter presenter) async {
    var authToken = paymentsConfig["authToken"];
        merchantId = paymentsConfig["merchantId"];
        bdOrderId = paymentsConfig["bdOrderId"] ?? "";

    switch (flowType) {
      case FlowType.payments:
        {
          response = await presenter.getOrder(
              authToken, merchantId, paymentsConfig["bdOrderId"], sdkConfig);
          orderId = response?.body["orderid"];
          break;
        }
      case FlowType.e_mandate:
        {
          response = await presenter.getMandateOrder(
              authToken, merchantId, paymentsConfig["mandateTokenId"], sdkConfig);
          orderId = response?.body["mandate_tokenid"];
          break;
        }
      case FlowType.modify_mandate:
        {
          response = await presenter.getModifyMandateOrder(
              authToken, merchantId, paymentsConfig["mandateTokenId"], sdkConfig);
          orderId = response?.body["mandate_tokenid"];
          break;
        }
      case FlowType.payment_plus_mandate:
        {
          response = await presenter.getOrder(
              authToken, merchantId, paymentsConfig["bdOrderId"], sdkConfig);
          orderId = response?.body["orderid"];
          break;
        }
    }
    orderDate = response?.body["order_date"] ?? "";
    customerRefId = response?.body["customer_refid"];
    return response;
  }

  bool isCallBackInvoked = false;

  exitAndInvokeCallback(bool upiIntentFlow, SdkPresenter? presenter, BuildContext context,{ bool isSSLError = false}) async {
    isCallBackInvoked = true;
    String finalOrderId = orderId ?? "";
    try {
      bool isCancelledByUser = true;
      if(presenter?.sdkContext?.scope.get("final_response.isCancelledByUser")!=null){
        isCancelledByUser = presenter?.sdkContext?.scope.get("final_response.isCancelledByUser");
      } else if(upiIntentFlow==true){
        isCancelledByUser = false;
      }

      if(isSSLError){
        isCancelledByUser = false;
      }

      final txnInfoMap = {
        "isCancelledByUser": isCancelledByUser,
        "orderId": finalOrderId,
        "customerRefId": customerRefId ?? "",
        "merchantId": paymentsConfig["merchantId"]
      };

      TxnInfo txnInfo = TxnInfo(txnInfoMap: txnInfoMap);
      Navigator.of(context).pop();

      sdkConfig.responseHandler.onTransactionResponse(
        txnInfo,
      );

    }catch(e) {
      Get.back();
      SdkError sdkError = SdkError(
          msg: 'An unexpected exception occurred.',
          description: e.toString(),
          SDK_ERROR: SdkError.SERVICE_ERROR);
      SdkLogger.e(e);
      Navigator.of(context).pop();
      sdkConfig.responseHandler.onError(sdkError);

    }
  }

}