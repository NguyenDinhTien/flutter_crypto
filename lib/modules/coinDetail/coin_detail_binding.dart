import 'package:crypto_flutter/modules/coinDetail/coin_detail_controller.dart';
import 'package:get/get.dart';

class CoinDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(CoinDetailController());
  }
  
}