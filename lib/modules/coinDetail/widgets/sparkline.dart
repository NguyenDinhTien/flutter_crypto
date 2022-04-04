import 'package:crypto_flutter/models/models.dart';
import 'package:crypto_flutter/modules/coinDetail/coin_detail.dart';
import 'package:crypto_flutter/shared/constants/colors.dart';
import 'package:crypto_flutter/shared/utils/size_config.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DetailSparklineWidget extends GetView<CoinDetailController> {
  final CoinModel coinModel;
  const DetailSparklineWidget({Key? key, required this.coinModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => LineChart(
          mainData(controller.isShow.value),
          swapAnimationCurve: Curves.linear,
        ));
  }

  mainData(bool isShow) {
    double priceChangePercentage = coinModel.priceChangePercentage!.toDouble();
    double b = SizeConfig().blockSizeHorizontal;
    final List<Color> gradientColors = <Color>[
      if (priceChangePercentage >= 0)
        ColorConstants.accentBlue
      else
        ColorConstants.errorRed,
      if (priceChangePercentage >= 0)
        ColorConstants.primary
      else
        ColorConstants.lightRed,
    ];

    return LineChartData(
      minX: null,
      minY: null,
      baselineX: null,
      baselineY: null,
      lineTouchData: LineTouchData(enabled: true),
      lineBarsData: [
        LineChartBarData(
          spots: controller.listChart.isNotEmpty ? controller.listChart : null,
          isCurved: true,
          barWidth: 2,
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          dotData: FlDotData(
            show: false,
          ),
        ),
      ],
      titlesData: FlTitlesData(
          rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
                showTitles: isShow,
                interval: controller.listChart.isNotEmpty
                    ? controller.interval.value
                    : 1,
                reservedSize: 25,
                getTitlesWidget: bottomTitleWidgets),
          )),
      extraLinesData: ExtraLinesData(horizontalLines: [
        HorizontalLine(
          y: controller.listChart.isNotEmpty
              ? controller.listChart.last.y
              : 0.0,
          color: isShow
              ? Color.fromARGB(255, 166, 180, 166).withOpacity(0.8)
              : Colors.transparent,
          strokeWidth: 2,
          dashArray: [10, 2],
          label: HorizontalLineLabel(
            show: true,
            style: TextStyle(fontSize: 4 * b),
            alignment: const Alignment(1, -1),
            padding: const EdgeInsets.only(right: 5, top: 5),
            labelResolver: (line) => coinModel.currentPrice.toString(),
          ),
        ),
      ]),
      borderData: FlBorderData(
        show: false,
        border: Border(
          bottom: BorderSide(
              color: priceChangePercentage >= 0
                  ? ColorConstants.darkBlue
                  : ColorConstants.darkRed,
              width: 2),
          left: BorderSide(
              color: priceChangePercentage >= 0
                  ? ColorConstants.darkBlue
                  : ColorConstants.darkRed,
              width: 2),
        ),
      ),
      gridData: FlGridData(
        show: false,
        drawVerticalLine: false,
        horizontalInterval: 500,
        // checkToShowHorizontalLine: (double value) {
        //   var a = value == controller.listChart.length / 2;
        //   return a;
        // },
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff68737d),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    // print(value.toInt());
    if (value == controller.listChart.first.x ||
        value == controller.listChart.last.x) {
      // final DateTime date =
      //     DateTime.fromMillisecondsSinceEpoch(controller.listSparkTime.first);

      return Container();
    } else {
      final DateTime date = DateTime.fromMillisecondsSinceEpoch(value.toInt());
      // DateFormat dateFormat = DateFormat("HH:mm");
      //return Text(date.year.toString());
      return Padding(
          child: Text(
            controller.dateFormat.value.format(date),
            style: const TextStyle(fontSize: 12),
          ),
          padding: const EdgeInsets.only(top: 8.0));
    }
    //return Text(value.toString());
    //Widget Container();
    // switch (value.toInt()) {
    //   case 2:
    //     text = const Text('MAR', style: style);
    //     break;
    //   case 5:
    //     text = const Text('JUN', style: style);
    //     break;
    //   case 8:
    //     text = const Text('SEP', style: style);
    //     break;
    //   default:
    //     text = const Text('', style: style);
    //     break;
    // }

    // return Padding(
    //     child: Container(), padding: const EdgeInsets.only(top: 8.0));
  }
}
