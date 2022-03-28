
import 'package:dreams_v3_1/web_view.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final String link;

  const HomePage(this.link, {Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    loadPage();
  }


  @override
  Widget build(BuildContext context) {
    return Container();
  }


  Future<void> loadPage() async{
    await Future.delayed(const Duration(seconds: 0));

    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => WebViewModule(widget.link),
        transitionDuration: const Duration(seconds: 0),
      ),
    );
  }

}
