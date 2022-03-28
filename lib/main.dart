import 'dart:io';

import 'package:dreams_v3_1/native_navigation.dart';
import 'package:flutter/material.dart';
import 'package:device_info/device_info.dart';
import 'home_page.dart';

Future<String> getDevice() async {
  if (Platform.isAndroid) {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    return androidInfo.androidId;
  } else if (Platform.isIOS) {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    return iosInfo.identifierForVendor;
  } else
    return "DEVICE ID ERROR";
}

String deviceUd = "DEVICE ID ERROR";

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  deviceUd = await getDevice();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return _getBody;
  }

  Widget get _getBody => FutureBuilder(
    future: Init.instance.initialize(),
    builder: (context, AsyncSnapshot snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Splash());
      } else {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Einstein',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),//https://dreamsv3dev1.z21.web.core.windows.net/
          home: const HomePage("https://savyonview.dreams.bmby.com/"),
        );
      }
    },
  );
}

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool lightMode =
        MediaQuery.of(context).platformBrightness == Brightness.light;
    return Scaffold(
      backgroundColor:
      lightMode ? const Color(0xffffffff) : const Color(0xff000000),
      body: Center(
          child: lightMode
              ? Image.asset('assets/img.png')
              : Image.asset('assets/img.png')),
    );
  }
}

class Init {
  Init._();

  static final instance = Init._();

  Future initialize() async {
    await Future.delayed(const Duration(seconds: 3));
  }
}

class StarterPage extends StatefulWidget {
  const StarterPage({Key? key}) : super(key: key);

  @override
  _StarterPageState createState() => _StarterPageState();
}
//
// belive.dreams.bmby.com - Belive
// https://6days.dreams.bmby.com - 6Days
// https://cnaan.dreams.bmby.com - Cnaan
// https://savyonview.dreams.bmby.com - Africa, Savyon

class _StarterPageState extends State<StarterPage> {
  late List<MyData> mList = [];

  @override
  void initState() {
    mList.add(MyData("Belive", "https://belive.dreams.bmby.com"));
    mList.add(MyData("6Days", "https://6days.dreams.bmby.com"));
    mList.add(MyData("Cnaan", "https://cnaan.dreams.bmby.com"));
    mList.add(MyData("Africa, Savyon", "https://savyonview.dreams.bmby.com"));
    mList.add(MyData("Dev", "https://dreamsv3dev.bmby.com/"));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: mList.length + 1,
            itemBuilder: (BuildContext context, int index) {
              if (index < mList.length) {
                return MaterialButton(
                    color: Colors.amber,
                    colorBrightness: Brightness.light,
                    child: Text(mList[index].name),
                    onPressed: () {
                      String link = mList[index].link;
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage(link)),
                      );
                    });
              } else
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Custom url with https://',
                      contentPadding: const EdgeInsets.only(
                          left: 14.0, bottom: 8.0, top: 8.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(25.7),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(25.7),
                      ),
                    ),
                    textInputAction: TextInputAction.go,
                    onSubmitted: (value) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage(value)),
                      );
                    },
                  ),
                );
            }),
      ),
    );
  }
}

class MyData {
  final String _name;
  final String _link;

  MyData(this._name, this._link);

  String get name => _name;

  String get link => _link;
}
