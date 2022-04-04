import 'package:crypto_flutter/shared/shared.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../overview_controller.dart';

class ExchangeSubTab extends GetView<OverviewController> {
  const ExchangeSubTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.errorMsg.isEmpty) {
        if (controller.listExchange.isNotEmpty) {
          return _buildItem();
        } else {
          return ListView.builder(
              itemCount: 10,
              // Important code
              itemBuilder: (context, index) {
                return  LoadShimmer();
              });
        }
      } else {
        return RefreshButton(
            error: controller.errorMsg.value,
            function: controller.getDataExchange);
      }
    });
  }

  Widget _buildItem() {
    return RefreshIndicator(
        onRefresh: () => controller.getDataExchange(),
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: controller.listExchange.length,
          itemBuilder: (context, index) {
            return ExChangeCard(data: controller.listExchange[index]);
          },
        )

        // child: controller.listExchange.isNotEmpty
        //     ? ListView.builder(
        //         scrollDirection: Axis.vertical,
        //         itemCount: controller.listExchange.length,
        //         itemBuilder: (context, index) {
        //           return ExChangeCard(data: controller.listExchange[index]);
        //         },
        //       )
        //     : Center(
        //         child: CircularProgressIndicator(),
        );
  }
}
