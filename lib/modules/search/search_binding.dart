import 'package:crypto_flutter/modules/search/search.dart';
import 'package:get/get.dart';

class SearchBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<SearchController>(SearchController());
  }
}
