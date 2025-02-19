import '../../sdk.dart';

class OrderConfigValidator {

  static void validateOrderConfig(SdkConfiguration sdkConfig) {

    var flowType = sdkConfig.flowType, flowConfig = sdkConfig.flowConfig;

    _isBlankOrNull(flowConfig?["authToken"], "OToken");

    if(flowType == FlowType.payments || flowType == FlowType.payment_plus_mandate){

      _isBlankOrNull(flowConfig?["bdOrderId"], "bdOrderId");

    }
    else if(flowType == FlowType.e_mandate || flowType == FlowType.modify_mandate){

      _isBlankOrNull(flowConfig?["mandateTokenId"], "mandate_tokenid");

    }

  }

  static _isBlankOrNull(String? input,String? varName){

    (input == null || input.isEmpty) && (throw SdkException(sdkError: getSdkError("$varName is required")));

  }



  static SdkError getSdkError(String msg) {
    return SdkError(
        msg: msg,
        description:
        msg,
        SDK_ERROR: SdkError.SERVICE_ERROR);
  }
}
