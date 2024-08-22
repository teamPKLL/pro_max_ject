import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MapViewPage extends StatefulWidget {
  final String url;
  const MapViewPage({super.key, required this.url});

  @override
  _MapPageState createState() => _MapPageState();
}

  class _MapPageState extends State<MapViewPage> {

  WebViewController? _webViewController;

  void initState() {
    _webViewController = WebViewController()
      ..loadRequest(Uri.parse(widget.url))
      ..setJavaScriptMode(JavaScriptMode.unrestricted);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget(controller: _webViewController!),
    );
  }
}