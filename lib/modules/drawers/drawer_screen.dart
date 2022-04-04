import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypto_flutter/models/drawer_item_model.dart';
import 'package:crypto_flutter/shared/shared.dart';
import 'package:crypto_flutter/theme/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';

import 'drawer_controller.dart';

class DrawerScreen extends GetView<OpenDrawerController> {
  DrawerScreen({Key? key}) : super(key: key);
  @override
  final OpenDrawerController controller = Get.put(OpenDrawerController());
  final padding = const EdgeInsets.symmetric(horizontal: 20);
  bool isDark = ThemeService().isDarkMode;
  @override
  Widget build(BuildContext context) {
    //SizeConfig().init(context);

    return WillPopScope(
      onWillPop: () async => false,
      child: Drawer(
        child: Obx(() => _buildWidget()),
      ),
    );
    // return Drawer();
  }

  Widget _buildWidget() {
    return Scaffold(
      backgroundColor: !isDark
          ? ColorConstants.PRIMARY_COLOR
          : ColorConstants.PRIMARY_COLOR_DARK,
      body: Stack(
        children: [buildDrawer()],
      ),
    );
  }

  Widget buildDrawer() => SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              builDrawerHeader(),
              FlutterSwitch(
                width: 50.0,
                height: 30,
                toggleSize: 20.0,
                value: controller.isNightMode.value,
                borderRadius: 30.0,
                padding: 2.0,
                activeToggleColor: const Color(0xFF6E40C9),
                inactiveToggleColor: const Color(0xFF2F363D),
                activeSwitchBorder: Border.all(
                  color: const Color(0xFF3C1E70),
                  width: 6.0,
                ),
                inactiveSwitchBorder: Border.all(
                  color: const Color(0xFFD1D5DA),
                  width: 6.0,
                ),
                activeColor: const Color(0xFF271052),
                inactiveColor: Colors.white,
                activeIcon: const Icon(
                  Icons.nightlight_round,
                  color: Color(0xFFF8E3A1),
                ),
                inactiveIcon: const Icon(
                  Icons.wb_sunny,
                  color: Color(0xFFFFDF5D),
                ),
                onToggle: (val) {
                  controller.activeNightMode(val);
                },
              ),
              buidDrawerItems()
            ],
          ),
        ),
      );

  Widget builDrawerHeader() {
    return Container(
      padding: padding.add(const EdgeInsets.symmetric(vertical: 40)),
      //width: SizeConfig().screenWidth,
      //color: Colors.green,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 52.0,
              child: CircleAvatar(
                radius: 50.0,
                backgroundImage: CachedNetworkImageProvider(
                    "https://image.freepik.com/free-photo/picture-elegant-young-fashion-man_158595-527.jpg",
                    ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Andrew Robert',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: ColorConstants.WHITE_COLOR),
            ) // CircleAvatar
          ]),
    );
  }

  Widget buidDrawerItems() => Column(
        children: DrawerItems.listDrawer
            .map((e) => ListTile(
                  onTap: () {
                    // controller.closeDrawer();
                  },
                  title: Text(
                    e.text,
                    style: const TextStyle(color: ColorConstants.WHITE_COLOR),
                  ),
                  leading: Icon(e.icon, color: ColorConstants.WHITE_COLOR),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                ))
            .toList(),
      );
}

class DrawerItems {
  static const home =
      DrawerItemModel(text: "Home", icon: MaterialCommunityIcons.home);
  static const profile =
      DrawerItemModel(text: "Profile", icon: MaterialCommunityIcons.account);
  static const settings =
      DrawerItemModel(text: "Settings", icon: MaterialCommunityIcons.settings);

  static const logout =
      DrawerItemModel(text: "Logout", icon: MaterialCommunityIcons.logout);

  static final List<DrawerItemModel> listDrawer = [
    home,
    profile,
    settings,
    logout
  ];
}
