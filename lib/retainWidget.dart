// import 'package:flutter/material.dart';

// class LifeCycleManager extends StatefulWidget {
//   final Widget child;
//   LifeCycleManager({Key? key,required this.child}) : super(key: key);
//   _LifeCycleManagerState createState() => _LifeCycleManagerState();
// }
// class _LifeCycleManagerState extends State<LifeCycleManager>
//     with WidgetsBindingObserver {
//   @override
//   void initState() {
//     WidgetsBinding.instance?.addObserver(this);
//     super.initState();
//   }
//   @override
//   void dispose() {
//     WidgetsBinding.instance?.removeObserver(this);
//     super.dispose();
//   }
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     print('state = $state');
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: widget.child,
//     );
//   }
// }
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppRetainWidget extends StatelessWidget {
  const AppRetainWidget({Key? key, required this.child}) : super(key: key);

  final Widget child;

  final _channel = const MethodChannel('com.example/app_retain');

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (Platform.isAndroid) {
          if (Navigator.of(context).canPop()) {
            return true;
          } else {
            _channel.invokeMethod('sendToBackground');
            return false;
          }
        } else {
          return true;
        }
      },
      child: child,
    );
  }
}