
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class WebViewModule extends StatefulWidget {
  final String link;
  const WebViewModule(this.link, {Key? key}) : super(key: key);

  @override
  _WebViewModuleState createState() => _WebViewModuleState();
}

class _WebViewModuleState extends State<WebViewModule> {
  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: widget.link,
      javascriptMode: JavascriptMode.unrestricted,
      navigationDelegate: (NavigationRequest request) {
        if (request.url.contains("mailto:")) {
          _launchURL(request.url);
          return NavigationDecision.prevent;
        } else if (request.url.contains("tel:")) {
          _launchURL(request.url);
          return NavigationDecision.prevent;
        }
        return NavigationDecision.navigate;
      },
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }}

}
