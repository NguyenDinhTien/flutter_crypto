import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypto_flutter/modules/coinDetail/widgets/coin_data.dart';
import 'package:crypto_flutter/modules/coinDetail/coin_detail_controller.dart';
import 'package:crypto_flutter/shared/shared.dart';
import 'package:crypto_flutter/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CoinDetailScreen extends GetView<CoinDetailController> {
  // final CoinModel coinModel = Get.arguments;
  bool isDark = ThemeService().isDarkMode;
  double b = SizeConfig().blockSizeHorizontal;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            floating: false,
            //snap: true,
            //stretch: true,
            expandedHeight: 150.0,
            actions: <Widget>[
              controller.coinModel != null
                  ? Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: IconButton(
                          onPressed: () {
                            controller.handleButtonFavorite();
                          },
                          icon: Obx(() => controller.coinModel!.isFavorite.value
                              ? const Icon(
                                  Icons.star_rounded,
                                  color: ColorConstants.YELLOW_COLOR,
                                )
                              : const Icon(
                                  Icons.star_outline_rounded,
                                ))),
                    )
                  : const SizedBox()
            ],
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              // title: Text(controller.coinModel?.name ?? ""),
              title: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(controller.coinModel?.name ?? ""),
                  const SizedBox(
                    width: 10,
                  ),
                  ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: controller.coinModel!.img,
                      width: 7 * b,
                      height: 7 * b,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ],
              ),
              background: Image.asset(
                'assets/images/3.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          CoinChartWidget(),
          SliverToBoxAdapter(
              child: Padding(
            padding: const EdgeInsets.only(
                top: 10, left: 15.0, right: 15.0, bottom: 15.0),
            child: Container(
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
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: controller.coinModel != null
                      ? Column(
                          children: [
                            const Text(
                              'Price and Market Stats',
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                            const Padding(padding: EdgeInsets.only(top: 20.0)),
                            rowData(
                                controller.coinModel!.name + ' price',
                                "\$" +
                                    controller.coinModel!.currentPrice
                                        .toString()),
                            rowData(
                                'Market Cap',
                                "\$" +
                                    controller.coinModel!.marketCap.toString()),
                            rowData(
                                'Market Cap Rank',
                                "#" +
                                    controller.coinModel!.marketCapRank
                                        .toString()),
                            rowData(
                                '24h Hight / 24h Low',
                                "\$" +
                                    controller.coinModel!.high24h.toString() +
                                    " / " +
                                    "\$" +
                                    controller.coinModel!.low24h.toString()),
                            rowData('All-Time Hight',
                                "\$" + controller.coinModel!.ath.toString()),
                            rowData('All-Time Low',
                                "\$" + controller.coinModel!.atl.toString(),
                                border: false),
                          ],
                        )
                      : const SizedBox(),
                )),
          ))
        ],
      ),
    );
  }

  Widget rowData(String content, String data, {bool border = true}) {
    final double w = SizeConfig().screenWidth;
    return Container(
      width: 0.8 * w,
      padding: const EdgeInsets.only(top: 15, bottom: 10),
      decoration: BoxDecoration(
          border: border
              ? const Border(
                  bottom: BorderSide(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                )
              : const Border.symmetric()),
      child: Row(
        //ainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            content,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const Spacer(),
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.centerRight,
              child: Text(
                data,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CustomSliverDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final bool hideTitleWhenExpanded;

  CustomSliverDelegate({
    required this.expandedHeight,
    this.hideTitleWhenExpanded = true,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final appBarSize = expandedHeight - shrinkOffset;
    final cardTopPosition = expandedHeight / 2 - shrinkOffset;
    final proportion = 2 - (expandedHeight / appBarSize);
    final percent = proportion < 0 || proportion > 1 ? 0.0 : proportion;
    return SizedBox(
      height: expandedHeight + expandedHeight / 2,
      child: Stack(
        children: [
          SizedBox(
            height: appBarSize < kToolbarHeight ? kToolbarHeight : appBarSize,
            child: AppBar(
              backgroundColor: Colors.green,
              leading: IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                 
                },
              ),
              elevation: 0.0,
              title: Opacity(
                  opacity: hideTitleWhenExpanded ? 1.0 - percent : 1.0,
                  child: const Text("Test")),
            ),
          ),
          Positioned(
            left: 0.0,
            right: 0.0,
            top: cardTopPosition > 0 ? cardTopPosition : 0,
            bottom: 0.0,
            child: Opacity(
              opacity: percent,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30 * percent),
                child: const Card(
                  elevation: 20.0,
                  child: Center(
                    child: Text("Header"),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight + expandedHeight / 2;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
