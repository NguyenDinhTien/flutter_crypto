import 'package:crypto_flutter/shared/shared.dart';
import 'package:crypto_flutter/shared/utils/size_config.dart';

import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      color: Colors.deepPurple,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Image.asset(
              "assets/images/splash.png",
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          )
        ],
      ),
    );
  }
}
