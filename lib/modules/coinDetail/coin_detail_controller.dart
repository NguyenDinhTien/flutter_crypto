import 'package:crypto_flutter/api/api.dart';
import 'package:crypto_flutter/models/chart_data_model.dart';
import 'package:crypto_flutter/modules/home/home.dart';
import 'package:crypto_flutter/modules/home/tabs/overview/overview_controller.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../models/coin_model.dart';

class CoinDetailController extends GetxController {
  CoinModel? coinModel;
  var listChart = <FlSpot>[].obs;
  //var listSparkTime = [].obs;
  RxList<bool> isSelected =
      [true, false, false, false, false, false, false, false].obs;
  List listTime = ['1', '7', '14', '30', '90', '180', '360', 'max'];
  bool? isCallByHomeController;
  int index = -1;
  var interval = 0.0.obs;
  var isShow = false.obs;
  var dateFormat = Rx<DateFormat>(DateFormat('HH:mm'));
  Map<String, List> tempMapChartData = {};
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    coinModel = Get.arguments[0];
    isCallByHomeController = Get.arguments[1];

    index = Get.arguments[2];

    getChartData(coinID: coinModel?.id, time: '1');
  }

  getChartData({String? coinID, String? time}) async {
    isShow.value = false;
    String intervalParam = '';

    Map<String, String> qParams = {
      'vs_currency': 'usd',
      'days': time ?? '1',
      'interval': ''
    };

    try {
      if (tempMapChartData.containsKey('$time') == false) {
        var resultChartData = await fetch(
            url: 'coins/$coinID/market_chart', method: 2, queryParams: qParams);

        if (resultChartData != null) {
          List<FlSpot> tempList = [];

          List listPrice = resultChartData['prices'];

          for (var i = 0; i < listPrice.length; i++) {
            if (i % 10 == 0) {
              var price = double.parse((listPrice[i][1]).toStringAsFixed(2));
              var time = listPrice[i][0];
              tempList.add(FlSpot(time.toDouble(), price));
            } else {
              continue;
            }
            //  var date= "2018-01-02";
            //  var parse=DateTime.parse(date);
            //  var a=parse.millisecondsSinceEpoch.toDouble();
            // [listSparkTime.add(time)];
          }
          if (tempList.isNotEmpty) {
            listChart.value = tempList;
            interval.value = (listChart.last.x - listChart.first.x) / 6;
            isShow.value = true;
            tempMapChartData.addAll({'$time': tempList});
          }
        }
      } else {
        var tempList = tempMapChartData['$time']! as List<FlSpot>;
        listChart.value = tempList;
        interval.value = (listChart.last.x - listChart.first.x) / 6;
        isShow.value = true;
      }
    } catch (e) {
      print(e);
    }
  }

  changeChartTime(int newIndex) async {
    listChart.value = [];
    for (int i = 0; i < isSelected.length; i++) {
      if (i == newIndex) {
        isSelected[i] = true;
        print('debgging');
        String time = listTime[newIndex];
        handleFormatTimeseries(time);
        update();
        getChartData(coinID: coinModel!.id, time: time);
      } else {
        isSelected[i] = false;
      }
    }
  }

  handleFormatTimeseries(time) {
    if (int.tryParse(time) != null) {
      int getTime = int.parse(time);
      if (getTime == 1) dateFormat.value = DateFormat.Hm();
      if (getTime > 1 && getTime <= 360) dateFormat.value = DateFormat.MMMd();
    } else {
      dateFormat.value = DateFormat.y();
    }
  }

  handleButtonFavorite() async {
    final OverviewController overViewController = Get.find();
    //check Favorite OverviewScreen
    overViewController.handlePressBtnFavorite(coinModel!,
        isCallByHomeController: isCallByHomeController);
    //check Favorite in FavoriteScnre
    if (isCallByHomeController!) {
      bool isFavorite = coinModel!.isFavorite.value;
      final HomeController homeController = Get.find();
      if (index >= 0) {
        // bool isFavorite = coinModel!.isFavorite.value;
        if (isFavorite) {
          homeController.listCoinFavorite.removeAt(index);
        } else {
          homeController.listCoinFavorite.insert(index, coinModel);
        }
      }
      if (index < 0) {
        if (isFavorite) {
          homeController.listCoinFavorite
              .removeWhere((e) => e.id == coinModel?.id);
          print('debugging');
        } else {
          homeController.listCoinFavorite.add(coinModel);
        }
      }
      coinModel!.isFavorite.value = !isFavorite;
    }
  }
}
