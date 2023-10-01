import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewNewsScreen extends StatelessWidget {
  final String? url;

  const WebViewNewsScreen({this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: WebView(
        initialUrl: url,
      ),
    );
  }
}
