

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NativeNavigatio extends StatefulWidget {
  const NativeNavigatio({Key? key}) : super(key: key);

  @override
  State<NativeNavigatio> createState() => _NativeNavigatioState();
}

class _NativeNavigatioState extends State<NativeNavigatio> {
  @override
  Widget build(BuildContext context) {
    const String viewType = '<platform-view-type>';
    final Map<String, dynamic> creationParams = <String, dynamic>{};

    return SafeArea(
      child: UiKitView(
        viewType: viewType,
        layoutDirection: TextDirection.ltr,
        creationParams: creationParams,
        creationParamsCodec: const StandardMessageCodec(),
      ),
    );
  }
}
