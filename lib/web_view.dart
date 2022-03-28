
import 'dart:io';

import 'package:dreams_v3_1/sub_web_view.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'main.dart';
import 'native_navigation.dart';

class WebViewModule extends StatefulWidget {
  final String link;
  const WebViewModule(this.link, {Key? key}) : super(key: key);

  @override
  _WebViewModuleState createState() => _WebViewModuleState();
}

class _WebViewModuleState extends State<WebViewModule> {

  late WebViewController _controller;
  final String localStorageCookie = '''{"id":119,"user_info":{"id":4}}''';

  
  @override
  Widget build(BuildContext context) {

    var isIos = Platform.isAndroid? 0 : 1;

    print(widget.link+"/minimap=$isIos");

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NativeNavigatio()),
              );
            },
            child: Text("TEST"),
          ),
        ),
        body: WillPopScope(
          onWillPop:()=> onWillPop(context), child: Scaffold(
          body: Container(
            child: WebView(
              gestureNavigationEnabled: true,
              onWebResourceError: (v){
              },
              onWebViewCreated: (WebViewController c){
                c.clearCache();
                _controller = c;
              },
              onPageFinished: (_) async {
                // await _controller.evaluateJavascript(
                //     "window.localStorage.setItem('tenant_auth_setting', $localStorageCookie);");
                // await _controller.evaluateJavascript(
                //     "window.localStorage.setItem('user_profile', $localStorageCookie);");
                // print('page finished');
              },
              initialUrl: widget.link+"/?minimap=$isIos&deviceid=$deviceUd",
              // initialUrl: Uri.dataFromString(testBody, mimeType: 'text/html').toString(), //widget.link,
              javascriptMode: JavascriptMode.unrestricted,
              navigationDelegate: (NavigationRequest request) {
                print("LinkClicked -> ${request.isForMainFrame}");
                if (request.url.contains("mailto:")) {
                  _launchURL(request.url);
                  return NavigationDecision.prevent;
                }else if(request.url.contains("nt=1") || request.url.contains("matterport")){
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => SubWebView(url: request.url)),
                  // ).then((value){
                  //   SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
                  // });
                  // // _launchURL(request.url);
                  // return NavigationDecision.prevent;
                }else if(request.url.contains("wa.me") || request.url.contains("api.whatsapp")){
                  _launchURL(request.url);
                  return NavigationDecision.prevent;
                } else if (request.url.contains("tel:")) {
                  _launchURL(request.url);
                  return NavigationDecision.prevent;
                } else if (request.url.contains("facetime-audio:")) {
                  _launchURL(request.url);
                  return NavigationDecision.prevent;
                }else if (request.url.contains("sms:")) {
                  _launchURL(request.url);
                  return NavigationDecision.prevent;
                }else if (request.url.contains("imessage:")) {
                  _launchURL(request.url);
                  return NavigationDecision.prevent;
                }else if(request.url.contains('whatsapp')){
                  if (Platform.isAndroid) {
                    _launchURL("https://wa.me/000000"+"/?text="+" ");

                  } else {
                    _launchURL("https://api.whatsapp.com/send?phone=0000000= ");
                  }
                }else if(!request.url.contains(widget.link)){
                  launch(request.url);
                  return NavigationDecision.prevent;
                }
                return NavigationDecision.navigate;
              },
            ),
          ),
        ),
    ),
      ));
  }

  Future<bool> onWillPop(BuildContext context)async{
    var canGoBack = await _controller.canGoBack();
    if(canGoBack){
      _controller.goBack();
    }else {
      var snackBar = SnackBar(
        content: Text('Close app?'),
        action: SnackBarAction(
          label: 'close',
          onPressed: () {
            exit(0);
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    return false;
    // return (await showDialog(
    //   context: context,
    //   builder: (context) => new AlertDialog(
    //     title: new Text('Are you sure?'),
    //     content: new Text('Do you want to exit an App'),
    //     actions: <Widget>[
    //       TextButton(
    //         onPressed: () => Navigator.of(context).pop(false),
    //         child: new Text('No'),
    //       ),
    //       TextButton(
    //         onPressed: () => Navigator.of(context).pop(true),
    //         child: new Text('Yes'),
    //       ),
    //     ],
    //   ),
    // )) ?? false;
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }}

}

