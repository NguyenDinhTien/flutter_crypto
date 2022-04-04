
class CategoryModel {
  String id;
  String name;
  num marketCap;
  num marketCapChange24h;
  num volume24h;
  String updatedAt;
  CategoryModel({
    required this.id,
    required this.name,
    required this.marketCap,
    required this.marketCapChange24h,
    required this.volume24h,
    required this.updatedAt,
  });

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      marketCap: map['market_cap'],
      marketCapChange24h: map['market_cap_change_24h'],
      volume24h: map['volume_24h'],
      updatedAt: map['updated_at'] ?? '',
    );
  }
}
