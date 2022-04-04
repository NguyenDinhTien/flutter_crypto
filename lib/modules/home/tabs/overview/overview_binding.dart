
import 'package:crypto_flutter/modules/home/tabs/overview/overview_controller.dart';
import 'package:get/get.dart';

class OverViewBinding implements Bindings {
  @override
  void dependencies() {
   Get.lazyPut(() => OverviewController());
  }
  
}