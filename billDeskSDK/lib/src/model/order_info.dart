library sdk;

import 'package:billDeskSDK/src/error/sdk_error.dart';
import 'package:billDeskSDK/src/model/sdk_config.dart';

class OrderInfo {
  late SdkConfig config;
}

class SdkConfig {
  SdkConfiguration sdkConfigJson;
  late ResponseHandler responseHandler;
  bool? isUATEnv;
  bool isDevModeAllowed;
  bool isJailBreakAllowed;
  bool shouldUseOldUat;

  SdkConfig(
      {required this.sdkConfigJson,
      required this.responseHandler,
      this.isUATEnv,
      this.isDevModeAllowed = false,
      this.isJailBreakAllowed = false,
      this.shouldUseOldUat = false});
}

class ResponseHandler {
  void onTransactionResponse(TxnInfo txnInfo) {}
  void onError(SdkError sdkError) {}
}

class FlowConfig {
  late String authToken;
  bool? childWindow;
  int? retryAttempt;
}

class TxnInfo {
  final Map<String, dynamic> txnInfoMap;


  TxnInfo({required this.txnInfoMap});

  @override
  String toString() {
    return "Txn(txnInfoMap='$txnInfoMap')";
  }
}

class SdkState {
  final String code;
  final String description;

  const SdkState(this.code, this.description);

  static const SdkState USER_CANCELED =
      SdkState("111", "User canceled payment");
  static const SdkState PAYMENT_ATTEMPTED =
      SdkState("222", "Transaction journey was successful");
  static const SdkState PAYMENT_ABORTED = SdkState("333", "Payment aborted");

  static final Map<String, SdkState> _map = {
    USER_CANCELED.code: USER_CANCELED,
    PAYMENT_ATTEMPTED.code: PAYMENT_ATTEMPTED,
    PAYMENT_ABORTED.code: PAYMENT_ABORTED,
  };

  static SdkState getSdkStateNameByCode(String code) {
    return _map[code] ?? PAYMENT_ATTEMPTED;
  }
}

const Map sdk_state_code = {
  '111': 'User canceled payment',
  '222': 'Transaction journey was successful',
  '333': 'Payment aborted',
};
