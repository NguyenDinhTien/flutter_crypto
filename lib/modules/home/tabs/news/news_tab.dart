import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypto_flutter/models/article_model.dart';
import 'package:crypto_flutter/modules/home/tabs/news/news_controller.dart';
import 'package:crypto_flutter/modules/home/tabs/news/news_webview.dart';
import 'package:crypto_flutter/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;

class News extends GetView<NewsController> {
  // final NewsController controller = Get.put(NewsController());
  const News({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double w = SizeConfig().screenWidth;
    final double h = SizeConfig().screenWidth;
    final double b = SizeConfig().blockSizeHorizontal;

    return SingleChildScrollView(child: Obx(() {
      return Column(
        mainAxisSize: MainAxisSize.max,
        //mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 10, top: 10),
            width: w,
            child: Text(
              'News',
              style: TextStyle(
                  fontSize: 8 * b,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.subtitle2?.color),
            ),
          ),
          if (controller.errorMsg.isEmpty) ...[
            if (controller.listtNews.isNotEmpty) ...[
              ...controller.listtNews
                  .map((element) => buildItem(context, element))
            ] else ...[
              for (var i = 0; i < 10; i++) ...[
                LoadShimmer(
                  height: 0.18,
                )
              ]
            ]
          ] else ...[
            SizedBox(
                height: h,
                child: RefreshButton(
                    error: controller.errorMsg.value,
                    function: controller.getDataNews))
          ]
        ],
      );
    }));
  }

  Widget buildItem(BuildContext context, Article article) {
    final double w = SizeConfig().screenWidth;
    final double h = SizeConfig().screenWidth;
    final double b = SizeConfig().blockSizeHorizontal;
    var brightness = Theme.of(context).brightness;
    bool isDark = brightness == Brightness.dark;
    var parsedDate = DateTime.parse(article.publishedAt);
    // print(timeago.format(parsedDate));
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          // controller.launchURL(article.url);
          Get.to(() => NewsWebView(
                url: article.url,
              ));
        },
        child: Container(
          height: 0.3 * h,
          decoration: BoxDecoration(
              color: isDark
                  ? ColorConstants.BOXSHADOW_BG_DARK
                  : ColorConstants.BOXSHADOW_BG_LIGHT,
              borderRadius: BorderRadius.circular(10.0),
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
          child: Container(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                SizedBox(
                  width: 0.25 * w,
                  height: 0.25 * w,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: CachedNetworkImage(
                      imageUrl: article.urlToImage,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
                SizedBox(
                  width: 2 * b,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        article.title,
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        softWrap: false,
                        style: TextStyle(
                            fontSize: 4 * b,
                            fontWeight: FontWeight.bold,
                            color:
                                Theme.of(context).textTheme.subtitle2?.color),
                      ),
                      const Expanded(
                        flex: 1,
                        child: SizedBox(),
                      ),
                      Text(
                        article.source + " ● " + timeago.format(parsedDate),
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        softWrap: false,
                        style: TextStyle(
                            fontSize: 3 * b,
                            // fontWeight: FontWeight.bold,
                            color: Colors.grey[700]),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
