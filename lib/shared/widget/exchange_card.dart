import 'package:crypto_flutter/models/exchange_model.dart';
import 'package:crypto_flutter/shared/shared.dart';
import 'package:crypto_flutter/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExChangeCard extends StatelessWidget {
  final ExchangeModel data;
  const ExChangeCard({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final convertToCurrentcy = NumberFormat("#,##0.00", "en_US");
    final double w = SizeConfig().screenWidth;
    final double h = SizeConfig().screenHeight;
    final double b = SizeConfig().safeBlockHorizontal;
    bool isDark = ThemeService().isDarkMode;
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
        child: Row(
          children: [
            Container(
              alignment: Alignment.center,
              width: w * 0.12,
              padding: const EdgeInsets.only(left: 4.0),
              child: Text(data.trustScoreRank.toString(),
                  style: TextStyle(
                      fontSize: 5 * b,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.subtitle2?.color)),
            ),
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
              width: 35,
              height: 35,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                // child: Image.network(img),
                child: ClipOval(
                  child: Image.network(
                    data.image,
                    height: 30,
                    width: 30,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Container(
                    //   child: FittedBox(
                    //     fit: BoxFit.contain,
                    //     child: Text(
                    //       data.name,
                    //       overflow: TextOverflow.fade,
                    //       maxLines: 1,
                    //       softWrap: false,
                    //       style: TextStyle(
                    //           fontSize: 20.sp,
                    //           fontWeight: FontWeight.bold,
                    //           color: Colors.grey[700]),
                    //     ),
                    //   ),
                    // ),
                    SizedBox(
                      width: 100 * w,
                      child: Text(
                        data.name,
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                        softWrap: false,
                        // maxLines: 2,
                        // overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 5 * b,
                          color: Theme.of(context).textTheme.subtitle2?.color,
                        ),
                      ),
                    ),
                    // Expanded(
                    //   // add this
                    //   child: Text(
                    //     data.name,
                    //     maxLines: 2,
                    //     overflow: TextOverflow.ellipsis,
                    //     style: TextStyle(fontWeight: FontWeight.bold),
                    //   ),
                    // ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
                    Row(
                      children: [
                        const Icon(
                          Icons.shield_sharp,
                          size: 10,
                          color: Colors.green,
                        ),
                        Text(
                          data.trustScore.toString(),
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.subtitle2?.color,
                              fontSize: 4 * b),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                        '\$' +
                            convertToCurrentcy
                                .format(data.tradeVolume24hBtc)
                                .toString(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.subtitle2?.color,
                        )),
                    const Padding(padding: EdgeInsets.only(top: 10)),
                    Text(
                      'Volume:' +
                          convertToCurrentcy
                              .format(data.tradeVolume24hBtcNormalized)
                              .toString(),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        color: Theme.of(context).textTheme.subtitle2?.color,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    )
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
