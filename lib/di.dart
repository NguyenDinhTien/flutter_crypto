import 'package:crypto_flutter/shared/shared.dart';
import 'package:get/get.dart';

class DenpendencyInjection {
  static Future<void> init() async {
    await Get.putAsync(() => SharedPreferencesServices().init());
  }
}
