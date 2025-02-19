import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:billDeskSDK/src/utilities/sdk_logger.dart';
import 'package:get/get.dart';
import 'package:get/get_connect.dart';
import 'package:intl/intl.dart';
import 'package:billDeskSDK/sdk.dart';
import 'package:billDeskSDK/src/error/sdk_exception_handler.dart';
import 'package:billDeskSDK/src/utilities/sdk_constant.dart';

class HttpService {
  static final _httpClient = GetConnect();

  post(
      {String? host,
      required SdkApiConstants routeDetails,
      Map<String, dynamic>? queryParams,
      required Map<String, String> reqHeaders,
      required Map<String, dynamic> body, required SdkConfig config}) async {
    SdkLogger.d("Excecuting ${routeDetails.value} Api");


    var url = BuildConfig.pgUrl;
    var route = routeDetails.route;

    if (config.isUATEnv == true) {
      url = config.shouldUseOldUat ? BuildConfig.pgUrl_Alt : BuildConfig.pgUrl;
      route = config.shouldUseOldUat? route :  "/u2$route";
    }

    final uri = Uri.parse(url);

    Uri baseUrl = Uri(
      scheme: uri.scheme,
      host: host ?? uri.host,
      path: route,
    );

    if (queryParams != null && queryParams.isNotEmpty) {
      baseUrl = appendQueryParams(baseUrl, queryParams);
    }

    try {
      var headers = appendHeaders(reqHeaders);

      var httpResponse = await _httpClient.post(
        baseUrl.toString(),
        jsonEncode(body),
        headers: headers,
      );

      SdkLogger.i(httpResponse.toString());

      if (httpResponse.statusCode == 200) {
        return httpResponse;
      } else {
        _throwException(httpResponse);
      }
    } on SocketException {
      throw FetchedDataException('No Internet Exception', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException('Api not responding', uri.toString());
    }
  }

  Map<String, String> appendHeaders(Map<String, String> reqHeaders) {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'BD-Timestamp': getDBTimeStamp(),
      'BD-TraceId': getBDTraceId()
    };

    headers.addAll(reqHeaders);

    return headers;
  }

  Uri appendQueryParams(Uri baseUrl, Map<String, dynamic> queryParams) {
    Uri uri = baseUrl;
    Map<String, dynamic> combinedParams = Map.from(uri.queryParametersAll)
      ..addAll(queryParams);
    return Uri(
      scheme: uri.scheme,
      host: uri.host,
      port: uri.port,
      path: uri.path,
      queryParameters: combinedParams,
    );
  }

  String getBDTraceId() {
    final random = Random();
    const availableChars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    final randomString = List.generate(
            5, (index) => availableChars[random.nextInt(availableChars.length)])
        .join();

    return getDBTimeStamp() + randomString;
  }

  String getDBTimeStamp() {
    DateTime now = DateTime.now();
    var time = DateFormat('yyyyMMddHHmmss').format(now);
    return time;
  }

  dynamic _throwException(Response response) {
    switch (response.statusCode) {
      case 200:
        return response;
      case 400:
        throw BadRequestException(
            response.bodyString, response.request?.url.toString());
      case 401:
      case 403:
        throw UnAuthorizedException(
            response.bodyString, response.request?.url.toString());
      case 500:
      default:
        throw FetchedDataException(
            response.bodyString, response.request?.url.toString());
    }
  }
}
