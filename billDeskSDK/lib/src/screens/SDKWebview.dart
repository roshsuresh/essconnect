library sdk;


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../sdk.dart';
import '../controller/navigation_controller.dart';

class BilldeskSDKWebview extends StatefulWidget {

  final SdkConfig sdkConfig;

  const BilldeskSDKWebview({Key? key, required this.sdkConfig}) : super(key: key);

  @override
  State<BilldeskSDKWebview> createState() => _BilldeskSDKWebviewState();
}

class _BilldeskSDKWebviewState extends State<BilldeskSDKWebview>
    with WidgetsBindingObserver {

  late NavigationController navigationController;

  bool upiTriggered = false;
  bool isModalClosed = true;
  RxDouble progress = 0.0.obs;
  @override
  late BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;

    return WillPopScope(
      onWillPop: () async {
        final shouldNavigateBack = await navigationController.showConfirmationDialog(context);
        if (shouldNavigateBack == true) {
          navigationController.sdkWebViewController.exitAndInvokeCallback(true, null,context);
          return true;
        }
        return false;
      },
      child: Scaffold(
          body: SafeArea(
              child: Column(children: <Widget>[
                Expanded(
                  child: Stack(
                      children: navigationController.getInAppWebViewInstance(context,)
                  ),
                )
              ]))),
    );
  }

  @override
  void initState() {
    super.initState();
    navigationController = Get.put(NavigationController(widget.sdkConfig));
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      if (upiTriggered == true) {
        navigationController.sdkWebViewController.exitAndInvokeCallback(true, null,context);
        upiTriggered = false;
      }
    } else if (state == AppLifecycleState.inactive) {
      if (navigationController.sdkWebViewController.upiFlowTriggered == true) {
        upiTriggered = true;
      }
    }
  }
}

class SDKWebView extends StatelessWidget {
  final SdkConfig config;

  const SDKWebView({super.key, required this.config});

  static void openSDKWebView(SdkConfig config) {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => SDKWebView(config: config),
    //   ),
    // );
    Get.to(() => SDKWebView(config: config));
  }

  @override
  Widget build(BuildContext context) {

    //SdkConfig config = Get.arguments;

    return FutureBuilder(
        future: BuildConfig.loadConfig(isUATEnv: config.isUATEnv),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return BilldeskSDKWebview(sdkConfig: config,);
          }
          return const Text("Loading...");
        });
  }
}

