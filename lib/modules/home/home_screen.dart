import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:crypto_flutter/modules/drawers/drawer.dart';
import 'package:crypto_flutter/routes/app_routes.dart';
import 'package:crypto_flutter/shared/shared.dart';
import 'package:crypto_flutter/retainWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';

import 'home.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final HomeController controller = Get.put(HomeController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _channel = const MethodChannel('com.example/app_retain');
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // return WillPopScope(
    //   onWillPop: () async => true,
    //   child: Obx(() => _buildWidget(context)),
    // );
     return AppRetainWidget(
      child: Obx(() => _buildWidget(context)),
    );
  }

  Widget _buildWidget(BuildContext context) {
    final double h = SizeConfig().screenHeight;

    int selectedIndex = controller.selectIndexHome.value;
    //List<Widget> listScreen = [OverView(), Text('2'), Text('3')];
    return Scaffold(
        key: _scaffoldKey,
        drawer: SizedBox(
            width: 0.7 * SizeConfig().screenWidth, child: DrawerScreen()),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: AppBar(
            elevation: 0.0,
            leading: IconButton(
                icon: const Icon(MaterialCommunityIcons.menu),
                onPressed: () {
                  // controller.openDrawer();
                  // print(controller.isShowDrawer.value);
                  // print('debugging');
                  // final openDrawerController = Get.find<OpenDrawerController>();
                  // openDrawerController.openDrawer();
                  _scaffoldKey.currentState!.openDrawer();
                }),
            actions: <Widget>[
              //ElevatedButton.icon(onPressed: onPressed, icon: icon, label: label)

              IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    Get.toNamed(Routes.SEARCH);
                  })
            ],
            automaticallyImplyLeading: true,
            // backgroundColor: ColorConstants.PRIMARY_COLOR,
          ),
        ),
        // body: IndexedStack(
        //   children: controller.listTabScreen,
        //   index: selectedIndex,
        // ),
        //body: controller.listTabScreen[selectedIndex],
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: controller.pageController,
          children: controller.listTabScreen,
        ),
        bottomNavigationBar: ConvexAppBar(
          height: 0.08 * h,
          curveSize: 70,
          backgroundColor: Theme.of(context).primaryColor,
          items: const [
            TabItem(icon: MaterialCommunityIcons.poll, title: 'OverView'),
            TabItem(
                icon: MaterialCommunityIcons.playlist_star, title: 'Favorite'),
            TabItem(
                icon: MaterialCommunityIcons.newspaper_variant_multiple_outline,
                title: 'News'),
          ],
          initialActiveIndex: selectedIndex,
          onTap: (value) {
            controller.changeTabScreen(value);
          },
        ));
  }
}
