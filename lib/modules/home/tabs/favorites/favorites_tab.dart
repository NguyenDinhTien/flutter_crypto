import 'package:crypto_flutter/models/coin_model.dart';
import 'package:crypto_flutter/modules/home/home.dart';
import 'package:crypto_flutter/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class FavoriteTab extends GetView<HomeController> {
  const FavoriteTab({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final double w = SizeConfig().screenWidth;
    final double h = SizeConfig().screenHeight;
    final double b = SizeConfig().safeBlockHorizontal;
    // bool isDark = ThemeService().isDarkMode;
    Color? color = Theme.of(context).textTheme.subtitle1!.color;
    return Obx(() {
      if (controller.errorMsg.isEmpty) {
        if (controller.listCoinFavorite.isNotEmpty) {
          return _buildItem();
        }
        if (controller.listCoinFavorite.isEmpty &&
            controller.numberShimmer.value > 0) {
          return ListView.builder(
              itemCount: controller.numberShimmer.value,
              // Important code
              itemBuilder: (context, index) {
                return const LoadShimmer();
              });
        }
        return const SizedBox();
      } else {
        return RefreshButton(
          error: controller.errorMsg.value,
          function: controller.getListFavoriteFromLocal,
        );
      }
    });
  }

  Widget _buildItem() {
    return RefreshIndicator(
      onRefresh: () => controller.getListFavoriteFromLocal(),
      child: SlidableAutoCloseBehavior(
        child: ListView.builder(
            // controller: controller.scrollController,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: controller.listCoinFavorite.length,
            itemBuilder: (context, index) {
              CoinModel item = controller.listCoinFavorite[index];
              return CoinCard(
                coinModel: item,
                controller: controller,
                index: index,
              );
            }),
      ),
    );
  }
}
