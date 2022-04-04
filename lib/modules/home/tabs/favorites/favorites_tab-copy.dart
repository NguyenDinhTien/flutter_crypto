// import 'package:crypto_flutter/models/coin_model.dart';
// import 'package:crypto_flutter/modules/home/home.dart';
// import 'package:crypto_flutter/shared/shared.dart';
// import 'package:crypto_flutter/theme/theme.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:get/get.dart';

// class FavoriteTab extends GetView<HomeController> {
//   @override
//   Widget build(BuildContext context) {
//     final double w = SizeConfig().screenWidth;
//     final double h = SizeConfig().screenHeight;
//     final double b = SizeConfig().safeBlockHorizontal;
//     bool isDark = ThemeService().isDarkMode;
//     Color? color = Theme.of(context).textTheme.subtitle1!.color;
//     print('debugging');
//     return Obx(() {
//       if (controller.listCoinFavorite.isNotEmpty) {
//         return RefreshIndicator(
//           onRefresh: () => controller.getListFavoriteFromLocal(),
//           child: SlidableAutoCloseBehavior(
//             child: AnimatedList(
//                 key: controller.listKey,
//                 shrinkWrap: true,
//                 physics: BouncingScrollPhysics(),
//                 scrollDirection: Axis.vertical,
//                 initialItemCount: controller.listCoinFavorite.length,
//                 itemBuilder: (context, index, animation) {
//                   // if (index < controller.listCoinFavorite.length) {
//                   CoinModel item = controller.listCoinFavorite[index];

//                   return SlideTransition(
//                       position: Tween<Offset>(
//                         begin: const Offset(-1, 0),
//                         end: Offset(0, 0),
//                       ).animate(animation),
//                       child: CoinCard(
//                         coinModel: item,
//                         controller: controller,
//                         index: index,
//                       ));
//                   // }
//                   // return SizedBox();
//                   //return slideIt(context, index, animation);
//                 }),
//           ),
//         );
//       }
//       // if (controller.errorMsg.isNotEmpty) {
//       //   return RefreshButton(
//       //     error: controller.errorMsg.value,
//       //     function: controller.getDataCrypto,
//       //   );
//       // }
//       // if (controller.listCoin.isNotEmpty){
//       //   return Center(
//       //     child: CircularProgressIndicator(),
//       //   );
//       // }
//       // return Center(
//       //   child: CircularProgressIndicator(),
//       // );
//       return Container();
//     });
//   }

//   Widget slideIt(BuildContext context, index, animation,
//       {CoinModel? coinModel}) {
//     CoinModel item = coinModel ?? controller.listCoinFavorite[index];

//     print('debugging');
//     return SlideTransition(
//         position: Tween<Offset>(
//           begin: const Offset(-1, 0),
//           end: Offset(0, 0),
//         ).animate(animation),
//         child: CoinCard(
//           coinModel: item,
//           controller: controller,
//           index: index,
//         ));
//   }
// }
