import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SubWebView extends StatefulWidget {
  final String url;

  const SubWebView({required this.url, Key? key}) : super(key: key);

  @override
  _SubWebViewState createState() => _SubWebViewState();
}

class _SubWebViewState extends State<SubWebView> {
  late WebViewController _controller;
  bool _loading = true;
  static double _progress = 0;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    Widget webview = _getWebView();
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: SafeArea(child: Scaffold(body: SizedBox(width: 300, height: 200, child:  _getWebView(),))),
    );
  }

  Widget _getWebView() {
    return Stack(
      children: [
        WebView(
          gestureNavigationEnabled: true,
          onWebResourceError: (v) {
          },
          initialUrl: widget.url,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController c) {},
          onProgress: (v) {
            _progress = v.toDouble();
          },
          onPageStarted: (v) {
            setState(() {
              _loading = true;
            });
          },
          onPageFinished: (v) async{
            await Future.delayed(Duration(milliseconds: 2000));
            setState(() {
              _loading = false;
            });
          },
        ),
        Container(
            child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
              child: _loading? Container(color: Colors.black, child:
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Loading sources...", style: TextStyle(color: Colors.white54),),
                  )
                ],
              )
              ): Container(),
        ))
      ],
    );
  }

  Future<bool> _onBackPressed() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text(
                'Do you want to go back? If you go back nothing will be saved on this screen'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }
}
