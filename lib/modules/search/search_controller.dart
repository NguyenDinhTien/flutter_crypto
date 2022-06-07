import 'dart:async';

import 'package:crypto_flutter/api/api.dart';
import 'package:crypto_flutter/models/coin_model.dart';
import 'package:crypto_flutter/modules/search/search.dart';
import 'package:crypto_flutter/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/shared.dart';

class SearchController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  Timer? debouncer;
  var listSearchTrending = <Widget>[].obs;
  var listSearchQuery = <Widget>[].obs;
  final HiveService hiveService = HiveService();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getSearchTrending();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchController.dispose();
  }

  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    if (debouncer != null) {
      debouncer?.cancel();
    }
    debouncer = Timer(duration, callback);
  }

  searchClear() async {
    searchController.clear();
    listSearchQuery.clear();
  }

  Future searchCoin(String query) async => debounce(() async {
        try {
          if (query.isNotEmpty) {
            var searchResult =
                await fetch(url: 'search?query=$query', method: 2);
            print('debugging');
            if (searchResult != null && searchResult['coins'] != null) {
              List listCoins = searchResult['coins'];
              List<Widget> tempList = [];
              var lastItem = listCoins.last;
              for (var item in listCoins) {
                final CardTrending data = CardTrending(
                  id: item['id'],
                  name: item['name'],
                  img: item['large'],
                  symbol: item['symbol'],
                  ranking: item['market_cap_rank'],
                  isBorder: lastItem != item ? true : false,
                );
                tempList.add(data);
              }
              if (tempList.isNotEmpty) {
                listSearchQuery.value = tempList;
                print('debugging');
              }
            }
          }
          if (searchController.text.isEmpty && listSearchQuery.isNotEmpty) {
            listSearchQuery.clear();
          }
        } catch (e) {
          print(e);
        }
      });

  Future getSearchTrending() async {
    try {
      var resultData = await fetch(url: 'search/trending', method: 2);
      print('debgging');
      if (resultData != null && resultData['coins'] != null) {
        List listCoins = resultData['coins'];
        List<Widget> tempList = [];
        var lastItem = listCoins.last;
        for (var e in listCoins) {
          var item = e['item'];

          final CardTrending data = CardTrending(
              id: item['id'],
              name: item['name'],
              img: item['small'],
              symbol: item['symbol'],
              ranking: item['market_cap_rank'],
              isBorder: e != lastItem ? true : false);
          tempList.add(data);
        }
        if (tempList.isNotEmpty) {
          listSearchTrending.value = tempList;
          print('debugging');
        }
      }
    } catch (e) {}
  }

  Future fetchCoinDetail(String id) async {
    try {
      var result =
          await fetch(url: '/coins/markets?vs_currency=usd&ids=$id', method: 2);
      if (result != null) {
        CoinModel coinModel = CoinModel.fromMap(result[0]);
        print('debugging');
        if (coinModel.id.isNotEmpty) {
          await checkExistInFavorites(coinModel);
          Get.toNamed(Routes.COIN_DETAIL, arguments: [coinModel, true, -1]);
        }
      }
      print('debugging');
    } catch (e) {}
  }

  Future checkExistInFavorites(CoinModel coinModel) async {
    List listCoinSave =
        await hiveService.getBoxes(hiveService.boxCryptoFavorite);
    bool isExistId = listCoinSave.map((e) => e.id).contains(coinModel.id);
    coinModel.isFavorite.value = isExistId;
    print('debugging');
  }
}
