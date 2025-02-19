import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:billDeskSDK/sdk.dart';
import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/sdk_context.dart';
import '../utilities/OrderConfigValidator.dart';
import '../utilities/sdk_logger.dart';

class NavigationController extends GetxController {
  final SdkConfig sdkConfig;
  NavigationController(this.sdkConfig);

  static NavigationController get to => Get.find();

  late SdkPresenter presenter;
  Rx<bool> bdModelShouldModalClose = false.obs;
  late SDKWebviewController sdkWebViewController;
  late InAppWebViewController inAppWebViewController;
  RxDouble progress = 0.0.obs;
  late BuildContext context;
  late Response response;
  final GlobalKey webViewKey = GlobalKey();
  late FlowType flowType;
  RxBool isDone = false.obs;
  bool isSdkExecuted = false;
  late String url;
  List<String> urls = [];
  late String currentFlowType;

  @override
  onInit() async {
    super.onInit();
    await initializeSdk();
    debounce(bdModelShouldModalClose, (shouldModalClose) {
      if (shouldModalClose == true) {
        sdkWebViewController.exitAndInvokeCallback(false, presenter, context);
      }
    });
  }

  Future<void> initializeSdk() async {
    SdkLogger.init(level: Level.debug);
    //sdkConfig = Get.arguments;

    sdkWebViewController = SDKWebviewController(sdkConfig);

    SdkLogger.i("SDK initialized successfully!");

    try {
      if (!sdkConfig.isJailBreakAllowed) {
        await sdkWebViewController.checkJailBreakOrRootStatus();
      } else {
        SdkLogger.w(
            "Warning: Currently IsJailbreakAllowed flag is enabled in the SDK config. Please disable it in production environment");
      }

      if (!sdkConfig.isDevModeAllowed) {
        await sdkWebViewController.checkDevModeStatus();
      }

      if (sdkConfig.isDevModeAllowed && Platform.isAndroid) {
        SdkLogger.w(
            "Warning: Currently IsDevModeAllowed flag is enabled in the SDK config. Please disable it in production environment");
      }

      SdkConfiguration config = sdkConfig.sdkConfigJson;

      flowType = config.flowType!;

      currentFlowType = config.flowType!.name;

      if (flowType == FlowType.payment_plus_mandate) {
        config.flowType = flowType = FlowType.payments;
      }

      try {
        OrderConfigValidator.validateOrderConfig(config);
      } on SdkException catch (e) {
        sdkConfig.responseHandler.onError(e.sdkError);
      }

      sdkWebViewController.paymentsConfig = config.flowConfig!;

      presenter = SdkPresenter(
        sdkContext: SdkContext(scope: Scope()),
      );

      loadConfiguration();

      //* getOrder details api call
      try {
        Response? response;
        response = await sdkWebViewController.getApiResponse(
            flowType, response, presenter);

        presenter.sdkContext?.scope.set("orderResponse", response);

        assert(BuildConfig.filePath.isNotEmpty, "filePath must be initialized");

        sdkWebViewController.loading.value = false;
      } catch (e) {
        SdkError sdkError = SdkError(
            msg: 'Some exception occurred while loading web view.',
            description: e.toString(),
            SDK_ERROR: SdkError.SERVICE_ERROR);
        SdkLogger.e(e.toString());
        sdkConfig.responseHandler.onError(sdkError);
      }
    } catch (e) {
      Navigator.of(context).pop();
      SdkLogger.e(e.toString());
      if (e is SdkException) {
        sdkConfig.responseHandler.onError(e.sdkError);
      }
    }
  }

  loadConfiguration() async {
    if (BuildConfig.filePath.isEmpty) {
      await BuildConfig.loadConfig(isUATEnv: sdkConfig.isUATEnv);
    }
  }

  getInAppWebViewInstance(BuildContext context) {
    this.context = context;

    return [
      InAppWebView(
        key: webViewKey,
        initialOptions: getInAppWebviewOptions(),
        initialFile: BuildConfig.filePath,
        onWebViewCreated: setWebViewController,
        onLoadStart: _updateParams,
        onProgressChanged: progressListener,
        onLoadStop: _loadWebPage,
        onLoadResource: loadResourceHandler,
        onLoadError: pageLoadErrorListener,
        onLoadHttpError: httpErrorListener,
        shouldOverrideUrlLoading: _shouldOverrideUrlLoading,
        onReceivedServerTrustAuthRequest: setCertificateToSite,
        androidOnPermissionRequest: androidPermissionRequest,
        onCreateWindow: setChildWindow,
        onCloseWindow: (controller) async {
          await inAppWebViewController.evaluateJavascript(
              source: "window.localStorage.clear();");
        },
      )
    ];
  }

  loadResourceHandler(
      InAppWebViewController controller, LoadedResource resource) async {
    if (resource.url.toString().contains(".js") && !isSdkExecuted) {
      // executeSdkModal(controller);
    }
  }

  executeSdkModal(InAppWebViewController controller) async {
    try {
      var json = sdkConfig.sdkConfigJson.toJson();
      _filterJsonProperty(json);
      var config = jsonEncode(json);
      var sdkBuildInfo = await _getBuildInfo();

      await controller.evaluateJavascript(source: """

                  if(typeof sdkStatus == 'undefined'){
                    sdkStatus = {"isExecuted": false};
                  }

                  var intervalID = setInterval(()=> {
                     if(typeof window.loadBillDeskSdk === 'function' && !sdkStatus["isExecuted"]){
                  
                  sdkStatus["isExecuted"] = true;
                   window.flutter_inappwebview.callHandler("sdkExecutionEvent", JSON.stringify(sdkStatus));
                   clearInterval(intervalID)

                         var sdkConfig = $config
                     sdkConfig["responseHandler"] = function(response){
                       window.location.href = "billdesksdk://web-flow?status=" + response.status + "&response=" + response.txnResponse;
                       };
                      sdkConfig['flowConfig']['returnUrl'] = "" ;
                      sdkConfig['flowConfig']['childWindow'] = false;
                      
                      window.loadBillDeskSdk(sdkConfig);

                      attachListenerToLogo();

                      }
                  }, 300)

           """);
    } catch (e) {
      SdkError sdkError = SdkError(
          msg: 'Error during loading BillDeskSdk in WebView',
          description: e.toString(),
          SDK_ERROR: SdkError.SERVICE_ERROR);
      SdkLogger.e('Error during loading BillDeskSdk in WebView', e.toString());
      sdkConfig.responseHandler.onError(sdkError);
    }
  }

  Future<bool?> setChildWindow(InAppWebViewController controller,
      CreateWindowAction createWindowRequest) async {
    RxString currentTitle = 'Redirecting...'.obs;
    RxInt currentProgress = 0.obs;

    showDialog(
      context: context,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async {
            if (!await inAppWebViewController.canGoBack()) {
              final shouldNavigateBack = await showConfirmationDialog(context);
              if (shouldNavigateBack == true) {
                return true;
              }
              return false;
            }
            return true;
          },
          child: Scaffold(
              appBar: AppBar(
                leading: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
                iconTheme: const IconThemeData(color: Color(0xff001e2e)),
                shadowColor: Colors.white,
                title: Obx(() => Text(currentTitle.value,
                    style: const TextStyle(color: Color(0xff001e2e)))),
                backgroundColor: const Color(0xfff7f7f9),
              ),
              body: SafeArea(
                  child: Stack(
                children: [
                  InAppWebView(
                      initialOptions: InAppWebViewGroupOptions(
                          ios: IOSInAppWebViewOptions(
                        enableViewportScale: true,
                      )),
                      windowId: createWindowRequest.windowId,
                      onReceivedServerTrustAuthRequest: setCertificateToSite,
                      onProgressChanged: (controller, progress) {
                        currentProgress.value = progress;
                      },
                      onTitleChanged: (controller, title) {
                        currentTitle.value = title ?? currentTitle.value;
                      },
                      onCloseWindow: (controller) {
                        Navigator.of(context).pop();
                      },
                      onLoadHttpError: httpErrorListener,
                      onLoadError: pageLoadErrorListener),
                  Obx(() => currentProgress != 100
                      ? const LinearProgressIndicator()
                      : Container())
                ],
              ))),
        );
      },
    );
    return true;
  }

  InAppWebViewGroupOptions getInAppWebviewOptions() {
    return InAppWebViewGroupOptions(
        crossPlatform: InAppWebViewOptions(
          javaScriptCanOpenWindowsAutomatically: true,
          useOnLoadResource: true,
          useShouldOverrideUrlLoading: true,
          mediaPlaybackRequiresUserGesture: false,
        ),
        android: AndroidInAppWebViewOptions(
            supportMultipleWindows: true, useHybridComposition: true),
        ios: IOSInAppWebViewOptions(allowsInlineMediaPlayback: true));
  }

  Future<PermissionRequestResponse> androidPermissionRequest(
      InAppWebViewController controller,
      String origin,
      List<String> resources) async {
    return PermissionRequestResponse(
        resources: resources, action: PermissionRequestResponseAction.GRANT);
  }

  _getBuildInfo() async {
    final fileContent = await rootBundle.loadString(
      "packages/billDeskSDK/files/info.json",
    );

    return jsonDecode(fileContent);
  }

  _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    final snackBar = SnackBar(content: Text('Copied to Clipboard: $text'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  showBuildInfoDialogue() async {
    var sdkBuildInfo = await _getBuildInfo();
    List<TableRow> itemList = [];
    var versionInfo = sdkBuildInfo["version"].split(".");

    Map<String, dynamic> items = {
      "flowType": currentFlowType,
      "SDK version": "f${sdkBuildInfo["version"]}",
      "Build Number": sdkBuildInfo["build"],
      "Major version": versionInfo[0],
      "Minor version": versionInfo[1]
    };

    final deviceInfoPlugin = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidDeviceInfo = await deviceInfoPlugin.androidInfo;
      items["OS version"] = "Android ${androidDeviceInfo.version.release}";
      items["Manufacturer"] = androidDeviceInfo.manufacturer;
      items["Device model name"] = androidDeviceInfo.model;
      items["OS Api level"] = androidDeviceInfo.version.sdkInt;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosDeviceInfo = await deviceInfoPlugin.iosInfo;
      items["OS version"] = "ios ${iosDeviceInfo.systemVersion}";
      items["Device model name"] = iosDeviceInfo.systemName;
      items["Manufacturer"] = iosDeviceInfo.model;
    }

    if (flowType == FlowType.e_mandate || flowType == FlowType.modify_mandate) {
      items["mandate id"] = sdkWebViewController.orderId;
    } else {
      items["order id"] = sdkWebViewController.orderId;
    }

    items.addAll({
      "merchant id": sdkWebViewController.merchantId,
      "bdOrderId": sdkWebViewController.bdOrderId,
      "order date": sdkWebViewController.orderDate,
      "isUatEnv": sdkConfig.isUATEnv
    });

    items.forEach((key, value) {
      if (value != "" && value != null) {
        itemList.add(TableRow(children: [
          TableCell(
            child: Padding(
              padding: const EdgeInsets.all(5.0), // Add desired padding
              child: Text(key),
            ),
          ),
          TableCell(
            child: Padding(
              padding: const EdgeInsets.all(5.0), // Add desired padding
              child: GestureDetector(
                  onTap: () {
                    _copyToClipboard("$value");
                  },
                  child: Text("$value",
                      softWrap: true,
                      style: const TextStyle(fontWeight: FontWeight.bold))),
            ),
          ),
        ]));
      }
    });

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Container(
                alignment: Alignment.center, child: const Text("BillDesk SDK Info")),
            content: SizedBox(
              width: 900,
              child: SingleChildScrollView(
                child: ListBody(children: [
                  Table(
                    children: itemList,
                  )
                ]),
              ),
            ),
          );
        });
  }

  Future<void> _updateParams(
      InAppWebViewController controller, Uri? uri) async {
    if (sdkConfig.isUATEnv == true && Platform.isAndroid) {
      controller.evaluateJavascript(source: """
      setTimeout(()=>{
          updateUrlByKey(${sdkConfig.shouldUseOldUat})
      },500)
     """);
    }

    controller.addJavaScriptHandler(
        handlerName: "sdkExecutionEvent",
        callback: (args) {
          var sdkStatus = jsonDecode(args[0]);

          if (sdkStatus["isExecuted"]!) {
            isSdkExecuted = true;
          }
        });

    controller.addJavaScriptHandler(
        handlerName: "buildDetailEvent",
        callback: (args) async {
          var buildInfoEvent = jsonDecode(args[0]);

          if (buildInfoEvent["alert"] == true) {
            showBuildInfoDialogue();
          }
        });

    Response? orderDetails = presenter.sdkContext?.scope.get("orderResponse");
    String? redirectUrl = orderDetails?.body?['ru'];

    if (redirectUrl != null && uri.toString().startsWith(redirectUrl)) {
      presenter.sdkContext?.scope
          .set("final_response.isCancelledByUser", false);
      presenter.sdkContext?.scope.set("bd-modal.shouldModalClose", true);

      bdModelShouldModalClose.value = true;
    }
  }

  void _loadWebPage(InAppWebViewController controller, Uri? uri) async {
    if (uri.toString().contains("billdesksdk://web-flow")) {
      controller.evaluateJavascript(source: """
                    document.getElementById("loading-info").innerText = "Processing payment. please wait. Don't click back or refresh the page"
                  """).then((value) async {
        Map<String, String> params = Uri.parse(uri.toString()).queryParameters;
        presenter.sdkContext?.scope.set("final_response.isCancelledByUser",
            _getSdkState(params["status"]!));
        presenter.sdkContext?.scope.set("bd-modal.shouldModalClose", true);
        bdModelShouldModalClose.value = true;
        isDone.value = false;

        await Future.delayed(const Duration(seconds: 2));

        controller.clearCache();
        sdkWebViewController.exitAndInvokeCallback(false, presenter, context);
      });
    } else if (uri.toString().contains(BuildConfig.filePath)) {
      if (!isSdkExecuted) executeSdkModal(controller);

      if (sdkConfig.isUATEnv == true && Platform.isIOS) {
        controller.evaluateJavascript(source: """
      setTimeout(()=>{
          updateUrlByKey(${sdkConfig.shouldUseOldUat})
      },500)
     """);
      }
    }
  }

  _filterJsonProperty(Map<String, dynamic> json) {
    json["flowConfig"].remove("orderid");
    json["flowConfig"].remove("mandate_tokenid");

    if (json["flowType"] == "e_mandate") {
      json["flowType"] = "emandate";
    }

    return json;
  }

  setWebViewController(InAppWebViewController controller) {
    inAppWebViewController = controller;
  }

  progressListener(controller, progress) {
    if (progress == 100) {
      isDone.value = true;
    }
    this.progress.value = progress;
  }

  pageLoadErrorListener(controller, url, code, message) {
    SdkLogger.e(
        "controller: $controller, url: $url, code: $code, message:$message");
  }

  httpErrorListener(controller, url, statusCode, description) {
    SdkLogger.e(
        "controller: $controller, url: $url, code: $statusCode, description: $description");
  }

  Future<ServerTrustAuthResponse?> setCertificateToSite(
      InAppWebViewController controller,
      URLAuthenticationChallenge challenge) async {
    ServerTrustAuthResponseAction? dialogResponse;

    String url = challenge.protectionSpace.host;

    var sslError = challenge.protectionSpace.sslError;

    String? sslErrorMessage = sslError?.message;

    var isValidError = sslError?.iosError != IOSSslError.UNSPECIFIED;

    if (!url.contains(BuildConfig.filePath) &&
        !urls.contains(url) &&
        isValidError) {
      urls.add(url.toString());

      dialogResponse = await showDialog<ServerTrustAuthResponseAction>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('SSL Error'),
            content:
                Text('Ssl Certificate Error: $sslErrorMessage!\n Url : $url'),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context)
                      .pop(ServerTrustAuthResponseAction.CANCEL);
                },
              ),
              TextButton(
                child: const Text('Proceed'),
                onPressed: () {
                  Navigator.of(context)
                      .pop(ServerTrustAuthResponseAction.PROCEED);
                },
              ),
            ],
          );
        },
      );
      SdkLogger.e('Ssl Certificate Error: $sslErrorMessage!\n Url : $url');
    }

    if (dialogResponse == ServerTrustAuthResponseAction.CANCEL) {
      controller.clearCache();
      sdkWebViewController.exitAndInvokeCallback(false, presenter, context,
          isSSLError: true);
    }
    // Return the appropriate action based on the user's choice
    return ServerTrustAuthResponse(
        action: dialogResponse ?? ServerTrustAuthResponseAction.PROCEED);
  }

  Future<NavigationActionPolicy?> _shouldOverrideUrlLoading(
      InAppWebViewController controller,
      NavigationAction navigationAction) async {
    Uri uri = navigationAction.request.url!;

    if (!["http", "https", "file", "chrome", "data", "javascript", "about"]
        .contains(uri.scheme)) {
      if (uri.toString().contains("billdesksdk://web-flow")) {
        Map<String, String> params = Uri.parse(uri.toString()).queryParameters;
        presenter.sdkContext?.scope.set("final_response.isCancelledByUser",
            _getSdkState(params["status"]!));
        presenter.sdkContext?.scope.set("bd-modal.shouldModalClose", true);
        bdModelShouldModalClose.value = true;
        return NavigationActionPolicy.CANCEL;
      }
      if (Platform.isAndroid || Platform.isIOS) {
        sdkWebViewController.upiFlowTriggered =
            RegExp(r"(upi|intent)", caseSensitive: false)
                .hasMatch(uri.toString());

        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
      return NavigationActionPolicy.CANCEL;
    }

    return NavigationActionPolicy.ALLOW;
  }

  bool _getSdkState(String status) {
    var sdkState = SdkState.getSdkStateNameByCode(status.toString());
    if (sdkState == SdkState.PAYMENT_ATTEMPTED) {
      return false;
    }
    return true;
  }

  showConfirmationDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Abort Payment?'),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pop(true); // Allow navigation back
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.orange,
                        backgroundColor: Colors.white,
                        elevation: 4,
                        padding: const EdgeInsets.all(10),
                        minimumSize: const Size(100, 0),
                      ),
                      child: const Text('Yes'),
                    ),
                  ),
                  const SizedBox(width: 16.0), // Add spacing between buttons
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pop(false); // Cancel navigation back
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.orange,
                        elevation: 4,
                        padding: const EdgeInsets.all(10),
                        minimumSize: const Size(100, 0),
                      ),
                      child: const Text('No'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
