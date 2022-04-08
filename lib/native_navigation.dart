import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

class NativeNavigatio extends StatefulWidget {
  const NativeNavigatio({Key? key}) : super(key: key);

  @override
  State<NativeNavigatio> createState() => _NativeNavigatioState();
}

class _NativeNavigatioState extends State<NativeNavigatio> {
  @override
  void initState() {
    super.initState();
  }

  // Future<void> _getPermission()async{
  //   var status = await Permission.camera.status;
  //   if (status.isDenied) {
  //     // We didn't ask for permission yet or the permission has been denied before but not permanently.
  //   }
  //
  // }
  //
  // Future<bool> _getCameraPermission() async{
  //   return await Permission.camera.request().isGranted;
  // }

  @override
  Widget build(BuildContext context) {
    const String viewType = '<platform-view-type>';
    final Map<String, dynamic> creationParams = <String, dynamic>{};


    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => setState(() {

          }),
          child: Icon(
            Icons.coronavirus_outlined,
            size: 52,
            color: Colors.greenAccent,
          ),
        ),
      ),
      body: SizedBox(
        child: UiKitView(
          viewType: viewType,
          layoutDirection: TextDirection.ltr,
          creationParams: creationParams,
          creationParamsCodec: const StandardMessageCodec(),
        ),
      )
    );
  }
}
