import 'package:crypto_flutter/api/api.dart';
import 'package:crypto_flutter/models/models.dart';
import 'package:crypto_flutter/modules/home/tabs/news/news_controller.dart';
import 'package:crypto_flutter/modules/home/tabs/news/news_tab.dart';
import 'package:crypto_flutter/modules/home/tabs/overview/overview_controller.dart';
import 'package:crypto_flutter/shared/services/services.dart';
import 'package:crypto_flutter/shared/shared.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'tabs/favorites/favorites_tab.dart';
import 'tabs/overview/overview_tab.dart';

class HomeController extends GetxController {
  var listCoinFavorite = [].obs;
  var selectIndexHome = 0.obs;
  var numberShimmer = 0.obs;
  var listTabScreen = [OverviewTab(), FavoriteTab(), const News()].obs;
  var errorMsg = RxString('');

  final HiveService hiveService = HiveService();
  final OverviewController overViewController = Get.find();
  late PageController pageController;
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    pageController =
        PageController(initialPage: selectIndexHome.value, keepPage: true);
  }

  void changeTabScreen(int value) async {
    int index = selectIndexHome.value = value;
    pageController.jumpToPage(index);
    if (index == 0) {}
    if (index == 1) {
      checkListChange();
    }
    if (index == 2) {
      NewsController newsController = Get.find();
      newsController.getDataNews();
    }
  }

  checkListChange({bool isCallBySearch = false}) async {
    if (overViewController.isHaveChange && listCoinFavorite.isNotEmpty ||
        listCoinFavorite.isEmpty ||
        isCallBySearch) {
      listCoinFavorite.value = [];
      await getListFavoriteFromLocal();
      overViewController.isHaveChange = false;
    }
    // if (listCoinFavorite.isEmpty|| isCallBySearch) {
    //   await getListFavoriteFromLocal();
    // }
    return;
  }

  checkError() async {}
  getListFavoriteFromLocal() async {
    print('debugging');
    errorMsg.value = '';
    var listCoinSave =
        await hiveService.getBoxes(hiveService.boxCryptoFavorite);
    numberShimmer.value = listCoinSave?.length ?? 0;
    String iDs = listCoinSave.map((e) => e.id).toList().join(",");

    try {
      var resultFavoriteCoin = await fetch(
          url: 'coins/markets?vs_currency=usd&ids=$iDs',
          method: 2,
          needKey: true);
      final ref = {for (var e in resultFavoriteCoin) e['id']: e};
      final sortedExamples = List.from(listCoinSave.map((e) => ref[e.id]));

      if (sortedExamples != null) {
        List<CoinModel> tempList = [];
        for (var e in sortedExamples) {
          CoinModel coinModel = CoinModel.fromMap(e);

          bool isExistId = listCoinSave.map((e) => e.id).contains(coinModel.id);
          coinModel.isFavorite.value = isExistId;

          tempList.add(coinModel);
        }
        if (tempList.isNotEmpty) {
          // EasyLoading.dismiss();
          // listCoinFavorite.addAll(tempList);
          listCoinFavorite.value = [...tempList];
          numberShimmer.value=0;
        }
      }
    } catch (e) {
      errorMsg.value = e.toString();
    }
  }

  removeItemFavorite(
      BuildContext context, int index, CoinModel coinModel) async {
    // listKey.currentState?.removeItem(index, (_, animation) {
    //   print('debugging');
    //   return FavoriteTab()
    //       .slideIt(context, index, animation, coinModel: coinModel);
    // }, duration: Duration(milliseconds: 500));
    numberShimmer.value--;
    overViewController.handlePressBtnFavorite(coinModel,
        isCallByHomeController: true);
    listCoinFavorite.removeAt(index);
  }
}
