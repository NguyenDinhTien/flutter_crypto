// import 'package:crypto_flutter/models/drawer_item_model.dart';
// import 'package:crypto_flutter/modules/home/home.dart';
// import 'package:crypto_flutter/shared/shared.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_icons/flutter_icons.dart';
// import 'package:get/get.dart';

// import 'drawer_controller.dart';

// class DrawerScreen extends GetView<OpenDrawerController> {
//   final padding = EdgeInsets.symmetric(horizontal: 20);
//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);

//     return WillPopScope(
//       onWillPop: () async => false,
//       child: Obx(() => _buildWidget()),
//     );
//   }

//   Widget _buildWidget() {
//     print('debugging');
//     return Scaffold(
//       backgroundColor: ColorConstants.PRIMARY_COLOR,
//       body: Stack(
//         children: [buildDrawer(), buildPage()],
//       ),
//     );
//   }

//   Widget buildDrawer() => SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [builDrawerHeader(), buidDrawerItems()],
//           ),
//         ),
//       );

//   Widget builDrawerHeader() {
//     return Container(
//       padding: padding.add(EdgeInsets.symmetric(vertical: 40)),
//       width: SizeConfig().screenWidth,
//       //color: Colors.green,
//       child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             CircleAvatar(
//               radius: 50.0,
//               backgroundImage: NetworkImage(
//                   "https://image.freepik.com/free-photo/picture-elegant-young-fashion-man_158595-527.jpg"),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Text(
//               'Andrew Robert',
//               style: TextStyle(
//                   fontSize: 15,
//                   fontWeight: FontWeight.bold,
//                   color: ColorConstants.WHITE_COLOR),
//             ) // CircleAvatar
//           ]),
//     );
//   }

//   Widget buidDrawerItems() => Column(
//         children: DrawerItems.listDrawer
//             .map((e) => ListTile(
//                   onTap: () {
//                     controller.closeDrawer();
//                   },
//                   title: Text(
//                     e.text,
//                     style: TextStyle(color: ColorConstants.WHITE_COLOR),
//                   ),
//                   leading: Icon(e.icon, color: ColorConstants.WHITE_COLOR),
//                   contentPadding:
//                       EdgeInsets.symmetric(horizontal: 24, vertical: 8),
//                 ))
//             .toList(),
//       );

//   Widget buildPage() {
//     return GestureDetector(
//       onTap: () {
//         controller.closeDrawer();
//       },
//       onHorizontalDragStart: (details) => controller.isDragging.value = true,
//       onHorizontalDragUpdate: (details) {
//         if (!controller.isDragging.value) return;
//         if (details.delta.dx > 0.5) {
//           controller.openDrawer();
//         } else if (details.delta.dx < -0.5) {
//           controller.closeDrawer();
//         }
//         controller.isDragging.value = false;
//       },
//       child: AnimatedContainer(
//         duration: Duration(milliseconds: 500),
//         curve: Curves.easeIn,
//         transform: Matrix4.translationValues(
//             controller.xOffset.value!, controller.yOffset.value!, 0)
//           ..scale(controller.scale.value),
//         child: ClipRRect(
//           borderRadius:
//               BorderRadius.circular(controller.isDrawerOpen.value ? 20 : 0),
//           child: Container(
//               color: controller.isDrawerOpen.value
//                   ? Colors.white12
//                   : ColorConstants.PRIMARY_COLOR,
//               child: AbsorbPointer(
//                   absorbing: controller.isDrawerOpen.value,
//                   child: HomeScreen())),
//         ),
//       ),
//       //  child: AnimatedContainer(
//       //     color: Colors.grey[900],
//       //     curve: Curves.easeInOutBack,
//       //     transform: Matrix4.translationValues(xOffset, yOffset, 0)..scale(scale),
//       //     duration: Duration(seconds: 1),
//       //     child: HomePage(),
//       //   )
//     );
//   }
// }

// class DrawerItems {
//   static const home =
//       DrawerItemModel(text: "Home", icon: MaterialCommunityIcons.home);
//   static const profile =
//       DrawerItemModel(text: "Profile", icon: MaterialCommunityIcons.account);
//   static const settings =
//       DrawerItemModel(text: "Settings", icon: MaterialCommunityIcons.settings);
//   static const logout =
//       DrawerItemModel(text: "Logout", icon: MaterialCommunityIcons.logout);
//   static final List<DrawerItemModel> listDrawer = [
//     home,
//     profile,
//     settings,
//     logout
//   ];
// }
