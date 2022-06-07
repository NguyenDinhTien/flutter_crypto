import 'dart:async';

import 'package:crypto_flutter/api/api.dart';
import 'package:crypto_flutter/models/category_model.dart';
import 'package:crypto_flutter/models/exchange_model.dart';
import 'package:crypto_flutter/models/models.dart';
import 'package:crypto_flutter/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'subtabs/category.dart';
import 'subtabs/crypto.dart';
import 'subtabs/exchange.dart';

class OverviewController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final List<Widget> myTabs = [
    const KeepAliveWrapper(child: CryptoSubTab()),
    const KeepAliveWrapper(child: CategorySubTab()),
    const KeepAliveWrapper(child: ExchangeSubTab())
  ].obs;

  var listCoin = [].obs;
  var listExchange = [].obs;
  var listCategory = [].obs;
  var errorMsg = RxString('');
  final hiveService = HiveService();
  bool isHaveChange = false;
  var indexListBuilder = 8.obs;
  var isLoading = true.obs;
  var hasMore = true.obs;
  var isScroll = false.obs;
  int pageNumber = 1;

  late TabController tabController;
  late ScrollController scrollController;
  @override
  void onInit() {
    super.onInit();
    tabController = TabController(vsync: this, length: myTabs.length);
    tabController.addListener(changeTabs);
    getDataCrypto(page: pageNumber);
    Timer.periodic(const Duration(seconds: 15), (timer) => addDataToList());
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  loadMore() async {
    getDataCrypto(page: ++pageNumber);
  }

  addDataToList() async {
    if (isScroll.value) {
      return;
    } else {
      int pageUpdate = indexListBuilder > 8
          ? (((indexListBuilder.value - 3) / 30).floor() + 1)
          : 1;
      List dataUpdate =
          await getDataCrypto(page: pageUpdate, isUpdateList: true);
      if (dataUpdate.isNotEmpty && listCoin.isNotEmpty) {
        int end = 30 * pageUpdate;
        int star = end - 30;
        listCoin.removeRange(star, end);
        listCoin.insertAll(star, dataUpdate);
        print('debugging');
      } else {
        return;
      }
    }
    //print((1 / 30).floor());
  }

  changeTabs() {
    int index = tabController.index;
    errorMsg.value = '';
    if (!tabController.indexIsChanging) {
      if (index == 0 && listCoin.isEmpty) {
        getDataCrypto();
      }
      if (index == 1 && listCategory.isEmpty) {
        getCategoryData();
      }
      if (index == 2 && listExchange.isEmpty) {
        getDataExchange();
      }
    }
  }

  refreshPage() async {
    int index = tabController.index;
    switch (index) {
      case 0:
        listCoin.value = [];
        pageNumber = 1;
        getDataCrypto();
        break;
      case 1:
        listCategory.value = [];
        getCategoryData();
        break;
      case 2:
        listExchange.value = [];
        getDataExchange();
        break;
      // default:
    }
  }

  Future<List<dynamic>> getDataCrypto(
      {int page = 1, bool isUpdateList = false}) async {
    isLoading.value = true;
    errorMsg.value = '';
    //EasyLoading.show();
    var favBox = await hiveService.getBoxes(hiveService.boxCryptoFavorite);
    Map<String, String> params = {
      'vs_currency': 'usd',
      'orders': 'market_cap_desc',
      'per_page': '30',
      'page': '$page',
      'sparkLine': 'false'
    };
    try {
      var resultTopCoin = await fetch(
          url: 'coins/markets', method: 2, needKey: true, queryParams: params);
      if (resultTopCoin != null) {
        List<CoinModel> tempList = [];
        resultTopCoin.forEach((e) {
          CoinModel coinModel = CoinModel.fromMap(e);

          bool isExistId = favBox.map((e) => e.id).contains(coinModel.id);
          coinModel.isFavorite.value = isExistId;

          tempList.add(coinModel);
        });
        if (tempList.isNotEmpty) {
          // EasyLoading.dismiss();
          if (!isUpdateList) {
            listCoin.addAll(tempList);
            isLoading.value = false;
          } else {
            isLoading.value = false;
            return tempList;
          }
        }
      }
      return [];
    } catch (e) {
      //EasyLoading.dismiss();
      print(e);
      print('debugging');
      errorMsg.value = e.toString();
      return [];
    }
  }

  getDataExchange() async {
    errorMsg.value = '';
    try {
      var resultData = await fetch(url: 'exchanges', method: 2);
      if (resultData != null && resultData.length > 0) {
        List tempList = [];
        for (var i = 0; i < resultData.length; i++) {
          ExchangeModel data = ExchangeModel.fromMap(resultData[i]);
          tempList.add(data);
        }
        if (tempList.isNotEmpty) {
          listExchange.value = tempList;
        }
      }
    } catch (e) {
      errorMsg.value = e.toString();
    }
  }

  getCategoryData() async {
    errorMsg.value = '';
    try {
      var resultData = await fetch(url: 'coins/categories/', method: 2);

      if (resultData != null) {
        List tempList = [];

        for (var i = 0; i < resultData.length; i++) {
          CategoryModel categoryModel = CategoryModel.fromMap(resultData[i]);

          tempList.add(categoryModel);
        }

        if (tempList.isNotEmpty && tempList.isNotEmpty) {
          listCategory.value = tempList;
        }
      }
    } catch (e) {
      errorMsg.value = e.toString();
    }
  }

  handlePressBtnFavorite(CoinModel coinModel,
      {isCallByHomeController = false}) async {
    isHaveChange = true;
    bool isFavorite = coinModel.isFavorite.value;
    if (isFavorite) {
      await removeCryptoToBoxFavorite(coinModel);
      if (isCallByHomeController) {
        final int index =
            listCoin.indexWhere((item) => item.id == coinModel.id);
        if (index >= 0) {
          CoinModel coinModelOverview = listCoin[index];
          coinModelOverview.isFavorite.value = false;
        }
      } else {
        coinModel.isFavorite.value = false;
      }
    } else {
      await addCryptoToBoxFavorite(coinModel);
      if (isCallByHomeController) {
        final int index =
            listCoin.indexWhere((item) => item.id == coinModel.id);
        if (index >= 0) {
          CoinModel coinModelOverview = listCoin[index];
          coinModelOverview.isFavorite.value = true;
        }
      } else {
        coinModel.isFavorite.value = true;
      }
    }
  }

  addCryptoToBoxFavorite(CoinModel coinModel) async {
    CoinFavoriteModel? coinFavoriteModel = CoinFavoriteModel(
        id: coinModel.id,
        symbol: coinModel.symbol,
        name: coinModel.name,
        img: coinModel.img);
    List favBox = await hiveService.getBoxes(hiveService.boxCryptoFavorite);
    bool check =
        await hiveService.isExists(boxName: hiveService.boxCryptoFavorite);
    bool isExistId = favBox.map((e) => e.id).contains(coinModel.id);
    if (check) {
      if (!isExistId) {
        await hiveService
            .addBoxes([coinFavoriteModel], hiveService.boxCryptoFavorite);
      }
    } else {
      await hiveService
          .addBoxes([coinFavoriteModel], hiveService.boxCryptoFavorite);
    }
  }

  removeCryptoToBoxFavorite(CoinModel coinModel) async {
    List tempList = await hiveService.getBoxes(hiveService.boxCryptoFavorite);
    final int index = tempList.indexWhere((item) => item.id == coinModel.id);
    await hiveService.deleteItemBoxes(
        tempList[index], hiveService.boxCryptoFavorite);
    //     .then((value) {
    //   if (value == true) {
    //     final HomeController homeController = Get.find();
    //     List listFavorite = homeController.listCoinFavorite;
    //     int index = listFavorite.indexWhere((e) => e == coinModel.id);
    //     homeController.listCoinFavorite.removeAt(index);
    //   }
    // }
    //);
  }

  removeAllCryptoToBoxFavorite() async {
    await hiveService.clearBoxes(hiveService.boxCryptoFavorite);
    for (CoinModel item in listCoin) {
      if (item.isFavorite.value == true) {
        item.isFavorite.value = false;
      }
    }
  }
}
