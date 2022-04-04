
import 'package:crypto_flutter/shared/shared.dart';
import 'package:crypto_flutter/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadShimmer extends StatelessWidget {
  final num height;
  const LoadShimmer({
    Key? key,
    this.height = 0.11,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double h = SizeConfig().screenHeight;
    bool isDark = ThemeService().isDarkMode;
    return Shimmer.fromColors(
        baseColor: isDark
            ? ColorConstants.BOXSHADOW_BG_DARK
            : ColorConstants.BOXSHADOW_BG_LIGHT,
        highlightColor:
            isDark ? ColorConstants.BLACK_COLOR : ColorConstants.WHITE_COLOR,
        child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Container(
                height: height * h,
                decoration: BoxDecoration(
                  color: ColorConstants.BOXSHADOW_BG_LIGHT,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Row(children: [
                  Expanded(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ]))));
  }
}
