import 'package:crypto_flutter/models/chart_data_model.dart';
import 'package:crypto_flutter/models/coin_model.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CoinChartWidget extends StatelessWidget {
  const CoinChartWidget({
    Key? key,
    required this.data,
    required this.coinModel,
    required this.color,
  }) : super(key: key);

  final List<ChartDataModel> data;
  final CoinModel coinModel;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 6.0),
              height: 200.0,
              width: double.infinity,
              child: SfCartesianChart(
                  //primaryXAxis: DateTimeAxis(),
                  //plotAreaBorderWidth: 0,
                  primaryXAxis: CategoryAxis(isVisible: true),
                  primaryYAxis: CategoryAxis(isVisible: true),
                  legend: Legend(isVisible: false),
                  tooltipBehavior: TooltipBehavior(enable: false),
                  series: <ChartSeries>[
                    // Renders line chart
                    LineSeries<ChartDataModel, DateTime>(
                     
                        dataSource: data,
                        xValueMapper: (ChartDataModel data, _) => data.year,
                        yValueMapper: (ChartDataModel data, _) => data.price)
                  ]),
            ),
          ),
          color == Colors.green
              ? Container()
              : Container(
                  // padding: const EdgeInsets.all(4.0),
                  // margin: const EdgeInsets.only(right: 16.0),
                  // alignment: Alignment.center,
                  // width: 72,
                  // height: 36,
                  // decoration: BoxDecoration(
                  //     color: coinPrice.percentChange_7d >= 0
                  //         ? Colors.green
                  //         : Colors.red,
                  //     borderRadius: BorderRadius.circular(16.0)),
                  // child: Text(
                  //   coinPrice.percentChange_7d.toStringAsFixed(2) + "%",
                  //   style: TextStyle(
                  //       color: Colors.white, fontWeight: FontWeight.bold),
                  // ),
                  ),
        ],
      ),
    );
  }
}
