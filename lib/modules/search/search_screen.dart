import 'package:crypto_flutter/modules/search/search_controller.dart';
import 'package:crypto_flutter/shared/constants/colors.dart';
import 'package:crypto_flutter/shared/shared.dart';
import 'package:crypto_flutter/shared/utils/size_config.dart';
import 'package:crypto_flutter/theme/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';

class SearchScreen extends GetView<SearchController> {
  bool isDark = ThemeService().isDarkMode;
  @override
  Widget build(BuildContext context) {
    final double w = SizeConfig().screenWidth;
    final double h = SizeConfig().screenHeight;
    print('debugging');
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconButton(
                  icon: const Icon(
                    MaterialCommunityIcons.chevron_left,
                  ),
                  onPressed: () {
                    //controller.handleChangeFavorite();
                    Get.back();
                  }),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(right: 20),
                  //width: w,
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Colors.white),
                  child: Center(
                    child: TextFormField(
                        controller: controller.searchController,
                        style: Theme.of(context).textTheme.headline4,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search,
                                color: Theme.of(context)
                                    .textTheme
                                    .headline4!
                                    .color),
                            suffixIcon: IconButton(
                              icon: Icon(
                                Icons.clear,
                                color: Theme.of(context)
                                    .textTheme
                                    .headline4!
                                    .color,
                              ),
                              onPressed: () {
                                controller.searchClear();
                              },
                            ),
                            hintText: 'Search...',
                            hintStyle: Theme.of(context).textTheme.headline4,
                            border: InputBorder.none),
                        onChanged: controller.searchCoin),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: GestureDetector(
          onTap: () => AppFocus.unfocus(context),
          child: Obx(() => controller.listSearchQuery.isNotEmpty
              ? _buildSearchQuery(w, h)
              : _buildSearchTrending(w, h)),
        ));
  }

  Widget _buildSearchTrending(double w, double h) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SizedBox(
            width: w,
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Search Trending",
              textScaleFactor: 2,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Container(
              width: 0.9 * w,
              padding: const EdgeInsets.all(8.0),
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
              child: Column(children: [
                if (controller.listSearchTrending.isNotEmpty &&
                    controller.listSearchQuery.isEmpty) ...[
                  ...controller.listSearchTrending.value
                ] else ...[
                  SizedBox(
                    height: 0.7 * h,
                    child: LoadShimmer(),
                  )
                ]
              ]))
        ]),
      ),
    );
  }

  Widget _buildSearchQuery(double w, double h) {
    return Container(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 0.92 * w,
          padding: const EdgeInsets.all(8.0),
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
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(10.0),
            children: controller.listSearchQuery,
          ),
        ),
      ),
    );
  }
}

class CardTrending extends StatelessWidget {
  CardTrending(
      {Key? key,
      required this.id,
      required this.name,
      required this.img,
      required this.ranking,
      required this.symbol,
      this.isBorder = true})
      : super(key: key);
  final String id;
  final String name;
  final String img;
  final String symbol;
  final int ranking;
  final bool isBorder;
  final SearchController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    final double w = SizeConfig().screenWidth;
    final double b = SizeConfig().blockSizeHorizontal;
    bool isDark = ThemeService().isDarkMode;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.transparent,
        shadowColor: Colors.transparent,
        // shape: RoundedRectangleBorder(borderRadius: borderRadius),
      ),
      onPressed: () {
        if (WidgetsBinding.instance!.window.viewInsets.bottom != 0) {
          AppFocus.unfocus(context);
        } else {
          controller.fetchCoinDetail(id);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          border: isBorder
              ? const Border(
                  bottom: BorderSide(
                    color: Colors.black,
                  ),
                )
              : const Border.symmetric(),
        ),
        child: Row(
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
                padding: const EdgeInsets.all(5.0),
                // child: Image.network(img),
                child: ClipOval(
                  child: Image.network(
                    img,
                    height: 7 * b,
                    width: 7 * b,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                  padding: const EdgeInsets.all(6.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                        softWrap: false,
                        style: TextStyle(
                            fontSize: 4 * b,
                            fontWeight: FontWeight.bold,
                            color:
                                Theme.of(context).textTheme.subtitle2!.color),
                      ),
                      Text(
                        symbol,
                        style: TextStyle(
                            fontSize: 3 * b,
                            fontWeight: FontWeight.w600,
                            color:
                                Theme.of(context).textTheme.subtitle2!.color),
                      ),
                    ],
                  )),
            ),
            const Expanded(
              child: SizedBox(),
            ),
            Text(
              '#' + ranking.toString(),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.subtitle2!.color),
            )
          ],
        ),
      ),
    );
  }
}
