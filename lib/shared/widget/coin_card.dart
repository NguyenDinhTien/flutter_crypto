import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypto_flutter/modules/home/home.dart';
import 'package:crypto_flutter/modules/home/tabs/overview/overview_controller.dart';
import 'package:crypto_flutter/routes/app_routes.dart';
import 'package:crypto_flutter/shared/shared.dart';
import 'package:crypto_flutter/theme/theme_service.dart';
import 'package:flutter/material.dart';

import 'package:crypto_flutter/models/coin_model.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class CoinCard extends StatelessWidget {
  final CoinModel coinModel;
  final controller;
  final int index;
  // GetxController controller = Get.put(OverViewController());
  const CoinCard(
      {Key? key,
      required this.coinModel,
      required this.controller,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double w = SizeConfig().screenWidth;
    final double h = SizeConfig().screenHeight;
    final double b = SizeConfig().safeBlockHorizontal;
    bool isDark = ThemeService().isDarkMode;
    final SlidableController slidableController;
    print('debugging');
    return Padding(
        padding: const EdgeInsets.all(6.0),
        child: Container(
          height: 0.11 * h,
          decoration: BoxDecoration(
              color: isDark
                  ? ColorConstants.BOXSHADOW_BG_DARK
                  : ColorConstants.BOXSHADOW_BG_LIGHT,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                    color: isDark
                        ? ColorConstants.BOXSHADOW_COLOR_DARK_1
                        : ColorConstants.BOXSHADOW_COLOR_1,
                    offset: const Offset(4, 4),
                    blurRadius: 10,
                    spreadRadius: 2),
                BoxShadow(
                    color: isDark
                        ? ColorConstants.BOXSHADOW_COLOR_DARK_2
                        : ColorConstants.BOXSHADOW_COLOR_2,
                    offset: const Offset(-4, -4),
                    blurRadius: 10,
                    spreadRadius: 2),
              ]),
          child: Slidable(
            direction: Axis.horizontal,
            key: const ValueKey(0),
            closeOnScroll: true,
            enabled: controller is HomeController,

            endActionPane: ActionPane(
              extentRatio: 2 / 5,
              dragDismissible: false,
              motion: const StretchMotion(),
              children: [
                SlidableAction(
                  flex: 2,
                  spacing: 2,
                  onPressed: (BuildContext context) {
                    controller.removeItemFavorite(context, index, coinModel);
                  },
                  backgroundColor: const Color(0xFFFE4A49),
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
              ],
            ),

            // The child of the Slidable is what the user sees when the
            // component is not dragged.
            child: Row(
              children: [
                Expanded(
                    child: InkWell(
                  splashColor: Theme.of(context).primaryColorLight,
                  onTap: () {
                    Get.toNamed(Routes.COIN_DETAIL, arguments: [
                      coinModel,
                      controller is HomeController ? true : false,
                      index
                    ]);
                  },
                  onLongPress: () {
                    if (controller is HomeController) {
                      ShowDialogs.removeAllItems(context);
                    }
                  },
                  child: Ink(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: isDark
                                        ? ColorConstants.BOXSHADOW_BG_DARK
                                        : ColorConstants.BOXSHADOW_BG_LIGHT,
                                    borderRadius: BorderRadius.circular(20.0),
                                    boxShadow: [
                                      BoxShadow(
                                          color: isDark
                                              ? ColorConstants
                                                  .BOXSHADOW_COLOR_DARK_1
                                              : ColorConstants
                                                  .BOXSHADOW_COLOR_1,
                                          offset: const Offset(4, 4),
                                          blurRadius: 10,
                                          spreadRadius: 2),
                                      BoxShadow(
                                          color: isDark
                                              ? ColorConstants
                                                  .BOXSHADOW_COLOR_DARK_2
                                              : ColorConstants
                                                  .BOXSHADOW_COLOR_2,
                                          offset: const Offset(-4, -4),
                                          blurRadius: 10,
                                          spreadRadius: 2),
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  // child: Image.network(img),
                                  child: ClipOval(
                                    child: CachedNetworkImage(
                                      imageUrl: coinModel.img,
                                      width: 7 * b,
                                      height: 7 * b,
                                      fit: BoxFit.cover,
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Text(
                                '#' + coinModel.ranking.toString(),
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .subtitle2!
                                        .color,
                                    fontSize: 3 * b,
                                    fontWeight: FontWeight.bold),
                              )
                              // Container(
                              //     width: 20,
                              //     height: 20,
                              //     decoration: new BoxDecoration(
                              //         shape: BoxShape.rectangle,
                              //         //color: Colors.green,
                              //         borderRadius: BorderRadius.all(Radius.circular(2.0))),
                              //     child: Text(
                              //       '1',
                              //       style: TextStyle(color: Colors.black12, fontSize: 12),
                              //     )),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                // FittedBox(
                                //   fit: BoxFit.scaleDown,
                                //   child: Text(
                                //     name,
                                //     overflow: TextOverflow.fade,
                                //     maxLines: 1,
                                //     softWrap: false,
                                //     style: TextStyle(
                                //         fontSize: 25,
                                //         fontWeight: FontWeight.bold,
                                //         color: Colors.grey[700]),
                                //   ),
                                // ),
                                Text(
                                  coinModel.name,
                                  overflow: TextOverflow.fade,
                                  maxLines: 1,
                                  softWrap: false,
                                  style: TextStyle(
                                      fontSize: 4 * b,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .textTheme
                                          .subtitle2
                                          ?.color),
                                ),

                                Text(
                                  coinModel.symbol.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 3 * b,
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context)
                                        .textTheme
                                        .subtitle2
                                        ?.color,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                        height: 20,
                                        width: 15,
                                        child: Stack(
                                            alignment: Alignment.centerLeft,
                                            children: [
                                              Positioned(
                                                top: -5,
                                                left: -8,
                                                child: coinModel
                                                            .priceChangePercentage!
                                                            .toDouble() <
                                                        0
                                                    ? const Icon(
                                                        Icons
                                                            .arrow_drop_down_rounded,
                                                        size: 30,
                                                        color: Colors.red,
                                                      )
                                                    : const Icon(
                                                        Icons
                                                            .arrow_drop_up_rounded,
                                                        size: 30,
                                                        color: Colors.green,
                                                      ),
                                              ),
                                            ])),
                                    Text(
                                      coinModel.priceChangePercentage!
                                                  .toDouble() <
                                              0
                                          ? coinModel.priceChangePercentage!
                                                  .toStringAsFixed(3) +
                                              "%"
                                          : "+" +
                                              coinModel.priceChangePercentage!
                                                  .toStringAsFixed(3) +
                                              "%",
                                      style: TextStyle(
                                          fontSize: 3 * b,
                                          fontWeight: FontWeight.bold,
                                          color: coinModel
                                                      .priceChangePercentage!
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
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "\$" +
                                  coinModel.currentPrice!.toDouble().toString(),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Theme.of(context)
                                    .textTheme
                                    .subtitle2
                                    ?.color,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )),
                controller is OverviewController
                    ? Material(
                        color: Colors.transparent,
                        child: Ink(
                            width: 50,
                            height: 100,
                            decoration: const BoxDecoration(
                                shape: BoxShape
                                    .rectangle), // LinearGradientBoxDecoration
                            child: Obx(
                              () => InkWell(
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    bottomRight: Radius.circular(20)),
                                onTap: () {
                                  controller.handlePressBtnFavorite(coinModel);
                                },
                                //customBorder: CircleBorder(),
                                child: Center(
                                    //child: Text("Test"),

                                    child: coinModel.isFavorite.value
                                        ? const Icon(
                                            Icons.star_rounded,
                                            color: ColorConstants.YELLOW_COLOR,
                                          )
                                        : const Icon(
                                            Icons.star_outline_rounded,
                                          )),
                                splashColor: ColorConstants.GREY_COLOR_2,
                              ),
                            ) // Red will correctly spread over gradient
                            ),
                      )
                    : const SizedBox(
                        width: 10,
                        height: 100,
                      ),
              ],
            ),
          ),
        ));
  }
}

class ShowDialogs {
  static Future<dynamic> removeAllItems(BuildContext context) {
    final HomeController controller = Get.put(HomeController());
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
            title: Text(
              'Delete All Items?',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).textTheme.subtitle1!.color),
            ),
            content: Text('This will Delete all items in Favorite',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).textTheme.subtitle1!.color)),
            actions: [
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Theme.of(context).primaryColor)),
                onPressed: () {
                  Get.back();
                },
                child: const Text('CANCEL'),
              ),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Theme.of(context).primaryColor)),
                onPressed: () {
                  controller.removeAllItemFavorite();
                  Get.back();
                },
                child: const Text('ACCEPT'),
              ),
            ],
          );
        });
  }
}
