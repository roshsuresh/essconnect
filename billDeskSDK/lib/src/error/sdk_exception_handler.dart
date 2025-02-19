
class AppException implements Exception {

  String? message, prefix, url;

  AppException([this.message, this.prefix, this.url]);

  @override
  String toString() {
    return 'AppException{message: $message, prefix: $prefix, url: $url}';
  }
}

class UnAuthorizedException extends AppException {

  UnAuthorizedException(String? reason, String? url):super(reason, 'Invalid request', url) ;

}

class ApiNotRespondingException extends AppException {

  ApiNotRespondingException(String? reason, String? url):super(reason, 'Api not responding', url) ;

}

class FetchedDataException extends AppException {

  FetchedDataException(String? reason, String? url):super(reason, 'Unable to Process', url) ;

}

class BadRequestException extends AppException {

  BadRequestException(String? reason, String? url):super(reason, 'Bad Request', url) ;

}


class SdkWidgetsException {

  final String message;

  SdkWidgetsException(this.message);

}




