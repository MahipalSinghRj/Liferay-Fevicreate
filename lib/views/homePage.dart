import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:test_web_app/views/noconnection.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class TestYes extends StatefulWidget {
  const TestYes({Key? key}) : super(key: key);

  @override
  State<TestYes> createState() => _TestYesState();
}

class _TestYesState extends State<TestYes> {
  final mainURL = 'https://www.fevicreate.com/';

  var connectionStatus = 0.obs;
  late StreamSubscription<InternetConnectionStatus> _listener;
  final _history = [];
  String newUrl = '';
  final _webViewController = Completer<InAppWebViewController>();

  @override
  void initState() {
    super.initState();
    print("Inside home page :");

    _listener = InternetConnectionChecker().onStatusChange.listen(
      (InternetConnectionStatus status) {
        setState(() {
          connectionStatus.value = status == InternetConnectionStatus.connected ? 1 : 0;
        });
      },
    );
  }

  @override
  void dispose() {
    _listener.cancel();
    super.dispose();
  }

  Future<NavigationActionPolicy> handleUrlLoading(InAppWebViewController controller, NavigationAction action) async {
    var url = action.request.url.toString();
    if (url.contains('.pdf')) {
      setState(() {
        newUrl = url;
      });

      await canLaunchUrl(Uri.parse(url)) ? await launchUrl(Uri.parse(url)) : throw 'Could not launch $url';
      return NavigationActionPolicy.CANCEL;
    }
    return NavigationActionPolicy.ALLOW;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          final webView = await _webViewController.future;
          if (await webView.canGoBack()) {
            webView.goBack();
            return false; // Prevents the app from exiting
          }
          return true; // Allows the app to exit
        },
        child: Scaffold(
          body: Obx(
            () => connectionStatus.value == 1
                ? InAppWebView(
                    initialUrlRequest: URLRequest(url: Uri.parse(mainURL)),
                    initialOptions: InAppWebViewGroupOptions(
                      crossPlatform: InAppWebViewOptions(
                        javaScriptEnabled: true,
                      ),
                    ),
                    shouldOverrideUrlLoading: (controller, navigationAction) =>
                        handleUrlLoading(controller, navigationAction),
                    onWebViewCreated: (InAppWebViewController controller) {
                      _webViewController.complete(controller);
                    },
                    onLoadStart: (InAppWebViewController controller, Uri? url) async {
                      if (mounted) {
                        setState(() {
                          _history.add('onPageStarted: $url');
                          print('newUrl: $url');
                        });
                      }
                    },
                  )
                : NoConnectionScreen(),
          ),
        ),
      ),
    );
  }
}
