import 'package:get/get.dart';

import '../../routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onReady() async {
    super.onReady();

    await Future.delayed(const Duration(milliseconds: 2000));
    // var storage = Get.find<SharedPreferences>();
    // try {
    //   if (storage.getString(StorageConstants.token) != null) {
    //Get.toNamed(Routes.HOME);
    //   } else {
    //     Get.toNamed(Routes.AUTH);
    //   }
    // } catch (e) {
    // Get.toNamed(Routes.AUTH);
    // Get.toNamed(Routes.HOME);
    Get.offAndToNamed(Routes.HOME);
    // }
  }
}
