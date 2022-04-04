import 'package:hive/hive.dart';

part 'coin_favorite_model.g.dart';

@HiveType(typeId: 0)
class CoinFavoriteModel extends HiveObject {
  @HiveField(0)
   String id;
  @HiveField(1)
   String symbol;
  @HiveField(2)
   String name;
  @HiveField(3)
   String img;
  @HiveField(4)
   num ?currentPrice;
  // @HiveField(5)
  // late String contentFrom;
  // @HiveField(6)
  // late String contentTo;
  // @HiveField(7)
  // bool isGoogleTrans = false;
CoinFavoriteModel({
    required this.id,
    required this.symbol,
    required this.name,
    required this.img,
    this.currentPrice
  });

 factory CoinFavoriteModel.fromMap(Map<String, dynamic> map) {
    return CoinFavoriteModel(
      id: map['id'] ?? "",
      symbol: map['symbol'] ?? "",
      name: map['name'] ?? "",
      img: map['image'] ?? map['large'] ?? "",
      currentPrice: map['current_price'] ?? 0,
    );
 }
}
