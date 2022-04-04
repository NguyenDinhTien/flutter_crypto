import 'package:crypto_flutter/models/coin_model.dart';
import 'package:crypto_flutter/modules/home/tabs/overview/overview_controller.dart';
import 'package:crypto_flutter/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CryptoSubTab extends GetView<OverviewController> {
  const CryptoSubTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var brightness = Theme.of(context).brightness;
    bool isDark = brightness == Brightness.dark;
    final double w = SizeConfig().screenWidth;
    return Column(
      children: [
        // Container(
        //   //alignment: Alignment.center,
        //   padding: const EdgeInsets.all(8.0),
        //   // height: 30.h,
        //   decoration: BoxDecoration(
        //       color: isDark
        //           ? ColorConstants.BOXSHADOW_BG_DARK
        //           : ColorConstants.BOXSHADOW_BG_LIGHT,
        //       boxShadow: [
        //         BoxShadow(
        //             color: isDark
        //                 ? ColorConstants.BOXSHADOW_COLOR_DARK_1
        //                 : ColorConstants.BOXSHADOW_COLOR_1,
        //             offset: const Offset(4, 4),
        //             blurRadius: 10,
        //             spreadRadius: 2),
        //         BoxShadow(
        //             color: isDark
        //                 ? ColorConstants.BOXSHADOW_COLOR_DARK_2
        //                 : ColorConstants.BOXSHADOW_COLOR_2,
        //             offset: const Offset(-4, -4),
        //             blurRadius: 10,
        //             spreadRadius: 2),
        //       ]),
        //   width: w,
        //   child: SingleChildScrollView(
        //     scrollDirection: Axis.horizontal,
        //     child: Row(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         SizedBox(
        //           width: 0.03 * w,
        //         ),
        //         Container(
        //           alignment: Alignment.center,
        //           padding: const EdgeInsets.all(5),
        //           decoration: BoxDecoration(
        //               color: isDark
        //                   ? ColorConstants.GREY_COLOR_2
        //                   : ColorConstants.WHITE_COLOR,
        //               borderRadius: BorderRadius.circular(20)),
        //           child: const Text(
        //             'All',
        //             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        //           ),
        //         ),
        //         SizedBox(
        //           width: 0.05 * w,
        //         ),
        //         Container(
        //           alignment: Alignment.center,
        //           padding: const EdgeInsets.all(5),
        //           decoration: BoxDecoration(
        //               color: isDark
        //                   ? ColorConstants.GREY_COLOR_2
        //                   : ColorConstants.WHITE_COLOR,
        //               borderRadius: BorderRadius.circular(20)),
        //           child: const Text(
        //             '24h',
        //             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        //           ),
        //         ),
        //         SizedBox(
        //           width: 0.05 * w,
        //         ),
        //         Container(
        //           alignment: Alignment.center,
        //           padding: const EdgeInsets.all(5),
        //           decoration: BoxDecoration(
        //               color: isDark
        //                   ? ColorConstants.GREY_COLOR_2
        //                   : ColorConstants.WHITE_COLOR,
        //               borderRadius: BorderRadius.circular(20)),
        //           child: const Text(
        //             'Top 100',
        //             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        //           ),
        //         ),
        //         SizedBox(
        //           width: 0.05 * w,
        //         ),
        //         Container(
        //           alignment: Alignment.center,
        //           padding: const EdgeInsets.all(5),
        //           decoration: BoxDecoration(
        //               color: isDark
        //                   ? ColorConstants.GREY_COLOR_2
        //                   : ColorConstants.WHITE_COLOR,
        //               borderRadius: BorderRadius.circular(20)),
        //           child: const Text(
        //             'Top 300',
        //             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        //           ),
        //         ),
        //         SizedBox(
        //           width: 0.1 * w,
        //         ),
        //       ],
        //     ),
        //   ),
        // ),

        //const Padding(padding: EdgeInsets.all(3.0)),
        Expanded(
          child: Obx(() {
            if (controller.errorMsg.isEmpty) {
              if (controller.listCoin.isNotEmpty) {
                return NotificationListener(
                  onNotification: (scrollNotification) {
                    if (scrollNotification is ScrollStartNotification) {
                      controller.isScroll.value = true;
                    } else if (scrollNotification is ScrollEndNotification) {
                      controller.isScroll.value = false;
                    }
                    return true;
                  },
                  child: RefreshIndicator(
                    onRefresh: () => controller.refreshPage(),
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: controller.hasMore.value
                            ? controller.listCoin.length + 1
                            : controller.listCoin.length,
                        itemBuilder: (context, index) {
                          controller.indexListBuilder.value = index;
                          if (index >= controller.listCoin.length) {
                            if (!controller.isLoading.value) {
                              controller.loadMore();
                            }
                            return Container();
                          }
                          CoinModel item = controller.listCoin[index];
                          // return CoinCard(coinModel: coinModel)
                          return CoinCard(
                            coinModel: item,
                            controller: controller,
                            index: index,
                          );
                        }),
                  ),
                );
              } else {
                return ListView.builder(
                    itemCount: 10,
                    // Important code
                    itemBuilder: (context, index) {
                      return LoadShimmer();
                    });
              }
            } else {
              return RefreshButton(
                error: controller.errorMsg.value,
                function: controller.getDataCrypto,
              );
            }
          }),
        ),
      ],
    );
  }
}
