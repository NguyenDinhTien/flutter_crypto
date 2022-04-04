// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coin_favorite_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CoinFavoriteModelAdapter extends TypeAdapter<CoinFavoriteModel> {
  @override
  final int typeId = 0;

  @override
  CoinFavoriteModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CoinFavoriteModel(
      id: fields[0] as String,
      symbol: fields[1] as String,
      name: fields[2] as String,
      img: fields[3] as String,
      currentPrice: fields[4] as num?,
    );
  }

  @override
  void write(BinaryWriter writer, CoinFavoriteModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.symbol)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.img)
      ..writeByte(4)
      ..write(obj.currentPrice);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CoinFavoriteModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
