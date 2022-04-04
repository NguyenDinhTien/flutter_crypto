
import 'package:get/get.dart';

class CoinModel {
  String id;
  String symbol;
  String name;
  String img;
  num marketCapRank;
  num? currentPrice;
  num? priceChange;
  num? priceChangePercentage;
  num? ranking;
  String? lastUpdated;
  num? marketCap;

  num? fullyDilutedValuation;
  num? totalVolume;
  num? high24h;
  num? low24h;
  num? marketCapChange24h;
  num? marketCapChangePercentage24h;
  num? circulatingSupply;
  num? totalSupply;
  num? maxSupply;
  num? ath;
  num? athChangePercentage;
  String? athDate;
  num? atl;
  num? atlChangePercentage;
  String? atlDate;
  RxBool isFavorite = false.obs;
  CoinModel({
    required this.id,
    required this.symbol,
    required this.name,
    required this.img,
    required this.marketCapRank,
    this.currentPrice,
    this.priceChange,
    this.priceChangePercentage,
    this.ranking,
    this.lastUpdated,
    this.marketCap,
    this.fullyDilutedValuation,
    this.totalVolume,
    this.high24h,
    this.low24h,
    this.marketCapChange24h,
    this.marketCapChangePercentage24h,
    this.circulatingSupply,
    this.totalSupply,
    this.maxSupply,
    this.ath,
    this.athChangePercentage,
    this.athDate,
    this.atl,
    this.atlChangePercentage,
    this.atlDate,
  });

  factory CoinModel.fromMap(Map<String, dynamic> map) {
    return CoinModel(
      id: map['id'] ?? "",
      symbol: map['symbol'] ?? "",
      name: map['name'] ?? "",
      img: map['image'] ?? map['large'] ?? "",
      currentPrice: map['current_price'] ?? 0,
      priceChange: map['price_change_24h'] ?? 0,
      priceChangePercentage: map['price_change_percentage_24h'] ?? 0,
      ranking: map['market_cap_rank'],
      lastUpdated: map['last_updated'],
      marketCap: map['market_cap'],
      marketCapRank: map['market_cap_rank'],
      fullyDilutedValuation: map['fully_diluted_valuation'],
      totalVolume: map['total_volume'],
      high24h: map['high_24h'],
      low24h: map['low_24h'],
      marketCapChange24h: map['market_cap_change_24h'],
      marketCapChangePercentage24h: map['market_cap_change_percentage_24h'],
      circulatingSupply: map['circulating_supply'],
      totalSupply: map['total_supply'],
      maxSupply: map['max_supply'],
      ath: map['ath'],
      athChangePercentage: map['ath_change_percentage'],
      athDate: map['ath_date'],
      atl: map['atl'],
      atlChangePercentage: map['atl_change_percentage'],
      atlDate: map['atl_date'],
    );
  }
}
