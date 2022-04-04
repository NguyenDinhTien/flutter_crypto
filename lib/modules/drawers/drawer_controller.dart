import 'package:crypto_flutter/theme/theme_service.dart';
import 'package:get/get.dart';

class OpenDrawerController extends GetxController {
  // bool isDragging = false;
  // late double xOffset;
  // late double yOffset;
  // late double scale;

  final xOffset = Rxn<double>();
  final yOffset = Rxn<double>();
  final scale = Rxn<double>();

  var isDragging = false.obs;
  var isDrawerOpen = false.obs;
  var isNightMode = ThemeService().isDarkMode.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    closeDrawer();
  }

  void openDrawer() {
    print('debugging');
    xOffset.value = 230;
    yOffset.value = 150;
    scale.value = 0.6;
    isDrawerOpen.value = true;
  }

  void closeDrawer() {
    print('debugging');
    xOffset.value = 0;
    yOffset.value = 0;
    scale.value = 1;
    isDrawerOpen.value = false;
  }

  void activeNightMode(bool isDarkMode) {
    isNightMode.value = isDarkMode;
    Future.delayed(const Duration(milliseconds: 500))
        .then((value) => ThemeService().changeThemeMode());
  }
}
