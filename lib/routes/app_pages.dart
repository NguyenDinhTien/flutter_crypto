import 'package:crypto_flutter/modules/auth/auth.dart';
import 'package:crypto_flutter/modules/drawers/drawer.dart';
import 'package:crypto_flutter/modules/home/home.dart';
import 'package:crypto_flutter/modules/search/search.dart';
import 'package:crypto_flutter/modules/splash/splash.dart';
import 'package:crypto_flutter/routes/app_routes.dart';
import 'package:get/get.dart';

import '../modules/coinDetail/coin_detail.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
        name: Routes.SPLASH,
        page: () => const SplashScreen(),
        binding: SplashBinding()),
    GetPage(
        name: Routes.AUTH, page: () => AuthScreen(), binding: AuthBinding()),
    GetPage(name: Routes.HOME, page: () => HomeScreen(), binding: HomeBiding()),
    // GetPage(
    //     name: Routes.DRAWER,
    //     page: () => DrawerScreen(),
    //     binding: DrawerBiding()),
    GetPage(
        name: Routes.SEARCH,
        page: () => SearchScreen(),
        binding: SearchBinding()),
    GetPage(
        name: Routes.COIN_DETAIL,
        page: () => CoinDetailScreen(),
        binding: CoinDetailBinding()),
  ];
}
