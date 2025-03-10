import 'dart:developer';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:essconnect/utils/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreenWeb extends StatefulWidget {
  String schdomain;
  LoginScreenWeb({Key? key, required this.schdomain}) : super(key: key);

  @override
  State<LoginScreenWeb> createState() => _LoginScreenWebState();
}

class _LoginScreenWebState extends State<LoginScreenWeb> {
  final GlobalKey webViewKey = GlobalKey();
  final ReceivePort _port = ReceivePort();

  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
          useOnDownloadStart: true,
          useShouldOverrideUrlLoading: true,
          mediaPlaybackRequiresUserGesture: false),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  late PullToRefreshController pullToRefreshController;
  late ContextMenu contextMenu;
  String url = "";
  double progress = 0;
  String baseUrl = "";
  final urlController = TextEditingController();

  Future<String> session() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return baseUrl = (prefs.getString("baseUrl"))!;
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Permission.videos.request();
      await Permission.photos.request();
      await Permission.storage.request();
    });

    // Permission.storage.request();
    super.initState();
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];
      setState(() {});
    });
    FlutterDownloader.registerCallback(downloadCallback);

    contextMenu = ContextMenu(
        menuItems: [
          ContextMenuItem(
              androidId: 1,
              iosId: "1",
              title: "Special",
              action: () async {
                print("Menu item Special clicked!");
                print(await webViewController?.getSelectedText());
                await webViewController?.clearFocus();
              })
        ],
        options: ContextMenuOptions(hideDefaultSystemContextMenuItems: false),
        onCreateContextMenu: (hitTestResult) async {
          print("onCreateContextMenu");
          print(hitTestResult.extra);
          print(await webViewController?.getSelectedText());
        },
        onHideContextMenu: () {
          print("onHideContextMenu");
        },
        onContextMenuActionItemClicked: (contextMenuItemClicked) async {
          var id = (Platform.isAndroid)
              ? contextMenuItemClicked.androidId
              : contextMenuItemClicked.iosId;
          print("onContextMenuActionItemClicked: $id ${contextMenuItemClicked.title}");
        });

    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.blue,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          webViewController?.reload();
        } else if (Platform.isIOS) {
          webViewController?.loadUrl(
              urlRequest: URLRequest(url: await webViewController?.getUrl()));
        }
      },
    );
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  static void downloadCallback(String id, int status, int progress) {
    print('Download task ($id) is in status ($status) and $progress% complete');
  }

  void _download(String url) async {
    final status = await Permission.storage.request();

    if (status.isGranted) {
      final externalDir = await getExternalStorageDirectory();

      final id = await FlutterDownloader.enqueue(
        url: url,
        savedDir: externalDir!.path,
        showNotification: true,
        openFileFromNotification: true,
        saveInPublicStorage: true,
      );
    } else {
      print('Permission Denied');
    }
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you want to exit'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text(
                  'No',
                  style: TextStyle(fontSize: 18, color: UIGuide.light_Purple),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text(
                  'Yes',
                  style: TextStyle(fontSize: 18, color: UIGuide.light_Purple),
                ),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '',
        ),
        toolbarHeight: 40.2,
        toolbarOpacity: 0.8,
        backgroundColor: UIGuide.light_Purple,
      ),
      body: WillPopScope(
        onWillPop: _onWillPop,
        child: SafeArea(
            child: Column(children: <Widget>[
          Expanded(
            child: Stack(
              children: [
                FutureBuilder(
                    future: session(),
                    builder: (context, snap) {
                      return snap.hasData
                          ? InAppWebView(
                              key: webViewKey,

                              initialUrlRequest: URLRequest(
                                  url:
                                  WebUri(
                                  // 'https://${widget.schdomain}.esstestonline.in/parent/fees-payment'
                                  'https://${widget.schdomain}.eschoolweb.org')),
                              // initialFile: "assets/index.html",
                              initialUserScripts:
                                  UnmodifiableListView<UserScript>([]),
                              initialOptions: options,
                              pullToRefreshController: pullToRefreshController,

                              onWebViewCreated: (controller) {
                                webViewController = controller;
                              },

                              onLoadStart: (controller, url) {
                                setState(() {
                                  this.url = url.toString();
                                  urlController.text = this.url;
                                });
                              },
                              androidOnPermissionRequest:
                                  (controller, origin, resources) async {
                                return PermissionRequestResponse(
                                    resources: resources,
                                    action:
                                        PermissionRequestResponseAction.GRANT);
                              },
                              shouldOverrideUrlLoading:
                                  (controller, navigationAction) async {
                                var uri = navigationAction.request.url!;

                                if (![
                                  "http",
                                  "https",
                                  "file",
                                  "chrome",
                                  "data",
                                  "javascript",
                                  "about"
                                ].contains(uri.scheme)) {
                                  if (await canLaunch(url)) {
                                    // Launch the App
                                    await launch(
                                      url,
                                    );
                                    // and cancel the request
                                    return NavigationActionPolicy.CANCEL;
                                  }
                                }
                                return NavigationActionPolicy.ALLOW;
                              },

                              onDownloadStart: (
                                controller,
                                url,
                              ) async {
                                final String urlFiles = "$url";

                                void launchURL_files() async =>
                                    await canLaunch(urlFiles)
                                        ? await launch(urlFiles)
                                        : await launch(urlFiles);
                                launchURL_files();
                                await FlutterDownloader.enqueue(
                                    url: urlFiles,
                                    savedDir:
                                        (await getExternalStorageDirectory())!
                                            .path,
                                    openFileFromNotification: true,
                                    saveInPublicStorage: true,
                                    showNotification: true);
                              },

                              onLoadStop: (controller, url) async {
                                if (baseUrl.contains('/recon?')) {
                                  var html = await controller.evaluateJavascript(
                                      source:
                                          "window.document.getElementsByTagName('html')[0].outerHTML;");

                                  log(html);
                                }
                              },
                              onLoadError: (controller, url, code, message) {
                                pullToRefreshController.endRefreshing();
                              },
                              onProgressChanged: (controller, progress) {
                                if (progress == 100) {
                                  pullToRefreshController.endRefreshing();
                                }
                                setState(() {
                                  this.progress = progress / 100;
                                  urlController.text = url;
                                });
                              },
                              onUpdateVisitedHistory:
                                  (controller, url, androidIsReload) {
                                setState(() {
                                  this.url = url.toString();
                                  urlController.text = this.url;
                                });
                              },
                              onConsoleMessage: (controller, consoleMessage) {
                                log(consoleMessage.toString());
                              },
                            )
                          : Center(
                              child: spinkitLoader(),
                            );
                    }),
              ],
            ),
          ),
          // ButtonBar(
          //   alignment: MainAxisAlignment.center,
          //   children: <Widget>[
          //     ElevatedButton(
          //       child: const Icon(Icons.arrow_back),
          //       onPressed: () {
          //         webViewController?.goBack();
          //       },
          //     ),
          //     ElevatedButton(
          //       child: const Icon(Icons.arrow_forward),
          //       onPressed: () {
          //         webViewController?.goForward();
          //       },
          //     ),
          //     ElevatedButton(
          //       child: Icon(Icons.refresh),
          //       onPressed: () {
          //         webViewController?.reload();
          //       },
          //       style: ElevatedButton.styleFrom(
          //         primary: UIGuide.light_Purple,
          //       ),
          //     ),
          //   ],
          // ),
        ])),
      ),
    );
  }
}

//   late WebViewController _controller;

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: UIGuide.light_Purple,
//         ),
//         body: Center(
//             // child: WebView(
//             //   initialUrl: 'https://$schdomain.eschoolweb.org',
//             //   javascriptMode: JavascriptMode.unrestricted,
//             //   onWebViewCreated: (WebViewController webViewController) {
//             //     _controller = webViewController;
//             //   },
//             // ),
//             ),
//       ),
//     );
//   }
// }
