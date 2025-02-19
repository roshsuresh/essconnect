library sdk;

import 'package:billDeskSDK/src/error/sdk_error.dart';

class SdkService {
  getOrder({required ServiceCallBack<Map, SdkException> serviceCallBack}) {}
  getTemplateMinorVer(
      {required String majorVersion,
      required ServiceCallBack serviceCallBack}) {}
  getPreferences({required ServiceCallBack serviceCallBack}) {}
  getTemplate(
      {required String majorVersion,
      required ServiceCallBack serviceCallBack}) {}
  getFallback(
      {required String majorVersion,
      required String buildTimestamp,
      required String platform,
      required String deviceId,
      required ServiceCallBack serviceCallBack}) {}
}

class ServiceCallBack<T, P> {
  onSuccess(T response) {}
  onFailure(P error) {}
}

class ServiceCallBackObject implements ServiceCallBack<Map, SdkException> {
  @override
  onFailure(error) {}

  @override
  onSuccess(response) {
    throw UnimplementedError();
  }
}
