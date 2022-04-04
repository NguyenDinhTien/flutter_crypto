import 'package:crypto_flutter/models/category_model.dart';
import 'package:crypto_flutter/modules/home/tabs/overview/overview_controller.dart';
import 'package:crypto_flutter/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CategorySubTab extends GetView<OverviewController> {
  const CategorySubTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.errorMsg.isEmpty) {
        if (controller.listCategory.isNotEmpty) {
          return _buildItem(context);
        } else {
          return LoadShimmer();
        }
      } else {
        return RefreshButton(
            error: controller.errorMsg.value,
            function: controller.getDataExchange);
      }
    });
  }

  Widget _buildItem(BuildContext context) {
    final w = SizeConfig().screenWidth;

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: RefreshIndicator(
        onRefresh: () => controller.refreshPage(),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: DataTable(columnSpacing: 0, columns: [
            DataColumn(
                label: SizedBox(
              child: Text('#',
                  style: TextStyle(
                      color: Theme.of(context).textTheme.subtitle2!.color)),
              width: w * .1,
            )),
            DataColumn(
                label: SizedBox(
              child: const Text('Categories'),
              width: w * .3,
            )),
            DataColumn(
                label: SizedBox(
              child: const Text('24h'),
              width: w * .2,
            )),
            DataColumn(
                label: SizedBox(
              child: const Text('Market Cap'),
              width: w * .4,
            )),
          ], rows: [
            ...controller.listCategory.map((element) {
              final convertToCurrentcy = NumberFormat("#,##0.00", "en_US");
              CategoryModel categoryModel = element;
              num index = controller.listCategory.indexOf(element) + 1;
              return DataRow(cells: [
                DataCell(Text(
                  index.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.subtitle2?.color),
                )),
                DataCell(
                    //Text(categoryModel.name),
                    ConstrainedBox(
                        constraints: const BoxConstraints(
                            maxWidth: 100, minWidth: 100), //SET max width
                        child: Text(categoryModel.name,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context)
                                    .textTheme
                                    .subtitle2
                                    ?.color)))),
                DataCell(categoryModel.marketCapChange24h > 0
                    ? SizedBox(
                        width: double.infinity,
                        child: Text(
                          '+' +
                              categoryModel.marketCapChange24h
                                  .toStringAsFixed(1) +
                              "%",
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : SizedBox(
                        width: double.infinity,
                        child: Text(
                          categoryModel.marketCapChange24h.toStringAsFixed(1) +
                              "%",
                          style: const TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                      )),
                DataCell(
                  //Text(categoryModel.marketCap.toString()),
                  Text(
                    '\$' +
                        convertToCurrentcy
                            .format(categoryModel.marketCap)
                            .toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).textTheme.subtitle2?.color),
                  ),
                )
              ]);
            })
          ]),
        ),
      ),
    );
  }
}
