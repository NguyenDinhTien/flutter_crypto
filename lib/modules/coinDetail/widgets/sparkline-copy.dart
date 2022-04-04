// import 'dart:math';

// import 'package:crypto_flutter/models/models.dart';
// import 'package:crypto_flutter/modules/coinDetail/coin_detail.dart';
// import 'package:crypto_flutter/shared/constants/colors.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';

// class DetailSparklineWidget extends GetView<CoinDetailController> {
//   final CoinModel coinModel;
//   const DetailSparklineWidget({Key? key, required this.coinModel})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() => LineChart(
//           mainData(),
//           swapAnimationCurve: Curves.linear,
//         ));
//   }

//   mainData() {
//     double priceChangePercentage = coinModel.priceChangePercentage!.toDouble();
//     final List<Color> gradientColors = <Color>[
//       if (priceChangePercentage >= 0)
//         ColorConstants.accentBlue
//       else
//         ColorConstants.errorRed,
//       if (priceChangePercentage >= 0)
//         ColorConstants.primary
//       else
//         ColorConstants.lightRed,
//     ];
//     return LineChartData(
//       lineTouchData: LineTouchData(enabled: true),
//       lineBarsData: [
//         LineChartBarData(
//           spots: controller.listChart,
//           isCurved: true,
//           barWidth: 2,
//           colors: gradientColors,
//           belowBarData: BarAreaData(
//             show: true,
//             colors: gradientColors
//                 .map((Color color) => color.withOpacity(0.3))
//                 .toList(),
//           ),
//           dotData: FlDotData(
//             show: false,
//           ),
//         ),
//       ],
//       titlesData: FlTitlesData(
//         rightTitles: SideTitles(showTitles: false),
//         topTitles: SideTitles(showTitles: false),
//         leftTitles: SideTitles(
//           showTitles: false,
//           reservedSize: 30,
//         ),
//         bottomTitles: SideTitles(
//             showTitles: true,
//             interval:
//                 controller.listChart.isNotEmpty ? controller.interval.value : 1,
//             reservedSize: 30,
//             // getTitles: (value) {
//             //   final DateTime date =
//             //       DateTime.fromMillisecondsSinceEpoch(value.toInt());
//             //   return date.year.toString();
//             // },
//             margin: 8,
//             getTitles: (value) {
//               if (value.toInt() == 0) {
//                 final DateTime date = DateTime.fromMillisecondsSinceEpoch(
//                     controller.listSparkTime.first);
//                 print('debugging');
//                 return '';
//               } else {
//                 final DateTime date = DateTime.fromMillisecondsSinceEpoch(
//                     controller.listSparkTime[value.toInt()]);
//                 return date.year.toString();
//               }
//             }
//             // getTitles: (double value) {
//             //   // if (value < controller.interval.value) {
//             //   //   return '1';
//             //   // }
//             //   if (value < controller.interval.value * 2) {
//             //     return '2';
//             //   }
//             //   if (value < controller.interval.value * 3) {
//             //     return '3';
//             //   }
//             //   if (value < controller.interval.value * 4) {
//             //     return '4';
//             //   }
//             //   if (value < controller.interval.value * 5) {
//             //     return '5';
//             //   }
//             //   if (value < controller.interval.value * 6) {
//             //     return '6';
//             //   }
//             //   if (value < controller.interval.value * 7) {
//             //     return '7';
//             //   }

//             //   return '';
//             // },
//             ),
//       ),
//       clipData: FlClipData.horizontal(),
//       extraLinesData: ExtraLinesData(horizontalLines: [
//         HorizontalLine(
//           y: controller.listChart.isNotEmpty
//               ? controller.listChart.last.y
//               : 0.0,
//           color: Colors.green.withOpacity(0.8),
//           strokeWidth: 3,
//           dashArray: [20, 2],
//           label: HorizontalLineLabel(
//             show: true,
//             alignment: const Alignment(1, 0.5),
//             padding: const EdgeInsets.only(left: 10, top: 5),
//             labelResolver: (line) => coinModel.currentPrice.toString(),
//           ),
//         ),
//       ]),
//       borderData: FlBorderData(
//         show: false,
//         border: Border(
//           bottom: BorderSide(
//               color: priceChangePercentage >= 0
//                   ? ColorConstants.darkBlue
//                   : ColorConstants.darkRed,
//               width: 2),
//           left: BorderSide(
//               color: priceChangePercentage >= 0
//                   ? ColorConstants.darkBlue
//                   : ColorConstants.darkRed,
//               width: 2),
//         ),
//       ),
//       gridData: FlGridData(show: false),
//       minX: null,
//       minY: null,
//       baselineX: 0,
//       baselineY: 0,
//     );
//   }
// }
