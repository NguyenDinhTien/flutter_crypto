import 'package:crypto_flutter/di.dart';
import 'package:crypto_flutter/routes/app_pages.dart';
import 'package:crypto_flutter/routes/app_routes.dart';
import 'package:crypto_flutter/shared/shared.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'models/models.dart';
import 'theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DenpendencyInjection.init();
  await Hive.initFlutter();
  Hive.registerAdapter(CoinFavoriteModelAdapter(), override: true);
  FlutterNativeSplash.remove();
  runApp(const MyApp());
  // runApp(
  //   DevicePreview(
  //     enabled: !kReleaseMode,
  //     builder: (context) => MyApp(), // Wrap your app
  //   ),
  // );

  configLoading();
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      enableLog: true,
      initialRoute: Routes.HOME,
      getPages: AppPages.routes,
      title: 'Flutter GetX Boilerplate',
      theme: Themes().lightTheme,
      darkTheme: Themes().darkTheme,
      themeMode: ThemeService().getThemeMode(),
      builder: EasyLoading.init(),
    );
  }
}

void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.threeBounce
    ..loadingStyle = EasyLoadingStyle.custom
    ..radius = 10.0
    ..backgroundColor = ColorConstants.GREY_COLOR
    ..indicatorColor = ThemeService().isDarkMode
        ? ColorConstants.PRIMARY_COLOR_DARK
        : ColorConstants.PRIMARY_COLOR
    ..textColor = hexToColor('#64DEE0')
    ..userInteractions = false
    ..dismissOnTap = true
    ..animationStyle = EasyLoadingAnimationStyle.scale;
}
