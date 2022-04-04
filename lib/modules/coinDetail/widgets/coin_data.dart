import 'package:crypto_flutter/modules/coinDetail/coin_detail_controller.dart';
import 'package:crypto_flutter/modules/coinDetail/widgets/silverdelegate.dart';
import 'package:crypto_flutter/modules/coinDetail/widgets/sparkline.dart';
import 'package:crypto_flutter/modules/coinDetail/widgets/toggle_button.dart';
import 'package:crypto_flutter/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CoinChartWidget extends StatelessWidget {
  CoinChartWidget({Key? key}) : super(key: key);
  final CoinDetailController controller = Get.find<CoinDetailController>();

  @override
  Widget build(BuildContext context) {
    return _buildItem(context);
  }

  _buildItem(BuildContext context) {
    DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss")
        .parse(controller.coinModel!.lastUpdated!);
    DateTime date = DateTime.fromMillisecondsSinceEpoch(1637554966142);
    print('debugging');
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat(
      'MM/dd/yyyy hh:mm a',
    );
    var outputDate = outputFormat.format(inputDate);
    final double w = SizeConfig().screenWidth;
    final double h = SizeConfig().screenHeight;
    final double b = SizeConfig().blockSizeHorizontal;
    return SliverPersistentHeader(
      pinned: false,
      delegate: SliverAppBarDelegate(
          minHeight: 0.5 * h,
          maxHeight: 0.5 * h,
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  // Text(
                  //   "\$" +
                  //       controller.coinModel!.currentPrice!.toStringAsFixed(2),
                  //   style: Theme.of(context).textTheme.headline5,
                  // ),
                  // Text(
                  //   outputDate,
                  //   style: Theme.of(context).textTheme.headline5,
                  // ),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Text(
                            controller.coinModel!.currentPrice!
                                    .toStringAsFixed(2) +
                                " USD",
                            style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context)
                                    .textTheme
                                    .subtitle2!
                                    .color,
                                fontWeight: FontWeight.w600)),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                                height: 30,
                                width: 30,
                                child: Stack(
                                    alignment: Alignment.centerLeft,
                                    children: [
                                      Positioned(
                                        top: -4,
                                        left: 0,
                                        child: controller.coinModel!
                                                    .priceChangePercentage!
                                                    .toDouble() <
                                                0
                                            ? const Icon(
                                                Icons.arrow_drop_down_rounded,
                                                size: 40,
                                                color: Colors.red,
                                              )
                                            : const Icon(
                                                Icons.arrow_drop_up_rounded,
                                                size: 40,
                                                color: Colors.green,
                                              ),
                                      ),
                                    ])),
                            Text(
                              controller.coinModel!.priceChangePercentage! < 0
                                  ? controller.coinModel!.priceChangePercentage!
                                          .toStringAsFixed(3) +
                                      "%"
                                  : "+" +
                                      controller
                                          .coinModel!.priceChangePercentage!
                                          .toStringAsFixed(3) +
                                      "%",
                              style: TextStyle(
                                  fontSize: 4 * b,
                                  fontWeight: FontWeight.bold,
                                  color: controller
                                              .coinModel!.priceChangePercentage!
                                              .toDouble() <
                                          0
                                      ? Colors.red
                                      : Colors.green),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.all(10),
                      width: w,
                      height: 0.3 * h,
                      child: Stack(
                        children: [
                          Obx(
                            () => Visibility(
                              visible: !controller.isShow.value,
                              child: const Positioned.fill(
                                child: Align(
                                    alignment: Alignment.center,
                                    child: CircularProgressIndicator()),
                              ),
                            ),
                          ),
                          DetailSparklineWidget(
                              coinModel: controller.coinModel!),
                        ],
                      )),
                  Container(
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
                    child: LayoutBuilder(builder: (context, constraints) {
                      return Center(
                          child: GetBuilder<CoinDetailController>(
                        builder: (controller) => ToggleButtons(
                          constraints: BoxConstraints.expand(
                              width: (constraints.maxWidth - 100) / 6),
                          borderRadius: BorderRadius.circular(8.0),
                          borderColor: ColorConstants.GREY_COLOR,
                          color: Theme.of(context).textTheme.subtitle1!.color,
                          fillColor: Colors.green,
                          selectedColor: Color.fromARGB(255, 255, 255, 255),
                          selectedBorderColor: ColorConstants.GREY_COLOR,
                          children: const [
                            ToggleButtonWidget(name: "24h"),
                            ToggleButtonWidget(name: "7d"),
                            ToggleButtonWidget(name: "14d"),
                            ToggleButtonWidget(name: "30d"),
                            ToggleButtonWidget(name: "90d"),
                            ToggleButtonWidget(name: "180d"),
                            ToggleButtonWidget(name: "1y"),
                            ToggleButtonWidget(name: "Max")
                          ],
                          isSelected: controller.isSelected,
                          onPressed: (int newIndex) {
                            controller.changeChartTime(newIndex);
                          },
                        ),
                      ));
                    }),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
