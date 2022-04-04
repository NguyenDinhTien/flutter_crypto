import 'package:flutter/material.dart';

class RefreshButton extends StatelessWidget {
  const RefreshButton({Key? key, required this.error, required this.function})
      : super(key: key);
  final String error;
  final VoidCallback function;
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            error,
            textAlign: TextAlign.center,
          ),
          TextButton(onPressed: function, child: const Text('Refresh'))
        ]);
  }
}
