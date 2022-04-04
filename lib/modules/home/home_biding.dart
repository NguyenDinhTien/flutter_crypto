
import 'package:get/get.dart';

import 'home_controller.dart';
import 'tabs/news/news_controller.dart';

class HomeBiding implements Bindings {
  @override
  void dependencies() {
    print('debugging');
    Get.lazyPut<HomeController>(() => HomeController());
    Get.put(NewsController());
  }
}
