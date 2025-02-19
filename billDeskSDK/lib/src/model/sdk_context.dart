import 'package:get/get_connect/http/src/response/response.dart';

class SdkContext {
  late Scope scope;

  SdkContext({
    required this.scope,
  });
}

class Scope {
  Map mapData = {};

  set(String key, dynamic value) {
    mapData[key] = value;
  }

  get(String key) {
    return mapData[key];
  }
}

class ScopeData {
  late String key;
  late Response value;

  ScopeData({
    required this.key,
    required this.value,
  });
}
