import 'package:crypto_flutter/modules/home/tabs/overview/overview_controller.dart';
import 'package:crypto_flutter/shared/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OverviewTab extends StatelessWidget {
  final OverviewController controller = Get.put(OverviewController());
  @override
  build(BuildContext context) {
    print('debugging');
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          elevation: 1.0,
          // backgroundColor: Colors.green,
          bottom: TabBar(
            controller: controller.tabController,
            indicatorColor: ColorConstants.WHITE_COLOR,
            // onTap: (index)=>controller.changeTabs(index),

            labelStyle: const TextStyle(fontSize: 18.0),
            tabs: const [
              Tab(
                text: 'Top Coin',
              ),
              Tab(
                text: 'Categories',
              ),
              Tab(
                text: 'Exchanges',
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: controller.tabController,
          children: controller.myTabs.map((tab) {
            return tab;
          }).toList(),
        ),
      ),
    );
  }
}
