library sdk;

class SdkError {
  late String msg;
  late String description;
  late int SDK_ERROR;
  int? code;

  static const SERVICE_ERROR = 1;
  static const ACTION_ERROR = 2;
  SdkError({
    required this.msg,
    required this.description,
    required this.SDK_ERROR,
    this.code,
  });

  @override
  String toString() {
    return 'SdkError(msg: $msg, description: $description, SDK_ERROR: $SDK_ERROR, code: $code)';
  }
}

class SdkException {
  late SdkError sdkError;
  SdkException({
    required this.sdkError,
  });
}
