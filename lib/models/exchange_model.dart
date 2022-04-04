
class ExchangeModel {
  String id;
  String name;
  String image;
  bool hasTradingIncentive;
  int trustScore;
  int trustScoreRank;
  num tradeVolume24hBtc;
  num tradeVolume24hBtcNormalized;
  ExchangeModel({
    required this.id,
    required this.name,
    required this.image,
    required this.hasTradingIncentive,
    required this.trustScore,
    required this.trustScoreRank,
    required this.tradeVolume24hBtc,
    required this.tradeVolume24hBtcNormalized,
  });

  factory ExchangeModel.fromMap(Map<String, dynamic> map) {
    return ExchangeModel(
      id: map['id'],
      name: map['name'],
      image: map['image'],
      hasTradingIncentive: map['has_trading_incentive'],
      trustScore: map['trust_score'],
      trustScoreRank: map['trust_score_rank'],
      tradeVolume24hBtc: map['trade_volume_24h_btc'],
      tradeVolume24hBtcNormalized: map['trade_volume_24h_btc_normalized'],
    );
  }
}
