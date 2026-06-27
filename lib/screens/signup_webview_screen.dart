import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../widgets/internet_connectivity_widget.dart';

class SignupWebViewScreen extends StatefulWidget {
  final Uri url;

  const SignupWebViewScreen({super.key, required this.url});

  @override
  State<SignupWebViewScreen> createState() => _SignupWebViewScreenState();
}

class _SignupWebViewScreenState extends State<SignupWebViewScreen> {
  late final WebViewController webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: InternetConnectivityWidget(
          child: WebViewWidget(controller: webViewController),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(widget.url);
  }
}
