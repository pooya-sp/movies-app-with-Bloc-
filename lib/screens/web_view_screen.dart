import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatelessWidget {
  static const routeName = '/web-view';
  @override
  Widget build(BuildContext context) {
    var movieTitle = ModalRoute.of(context).settings.arguments as String;
    return Scaffold(
      body: WebView(
        initialUrl: 'https://www.imdb.com/find?q=$movieTitle&ref_=nv_sr_sm',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
