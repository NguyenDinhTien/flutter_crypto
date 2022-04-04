import 'package:hive/hive.dart';

class HiveService {
  String keyCryptoFavorite = "keyCryptoFavorite";
  String boxCryptoFavorite = "cryptoFavorite";

  
  isExists({required String boxName}) async {
    final openBox = await Hive.openBox(boxName);
    int length = openBox.length;
    return length != 0;
  }

  addBoxes<T>(List<T> items, String boxName) async {
    print("adding boxes");
    final openBox = await Hive.openBox(boxName);

    for (var item in items) {
      print(item);
      print('debugging');
      openBox.add(item);
    }
  }

  getBoxes<T>(String boxName) async {
    List boxList = [];

    final openBox = await Hive.openBox(boxName);

    int length = openBox.length;

    for (int i = 0; i < length; i++) {
      boxList.add(openBox.getAt(i));
    }

    return boxList;
  }

  putBoxesWithKey(dynamic key, dynamic items, String boxName) async {
    final openBox = await Hive.openBox(boxName);
    openBox.put(key, items);
  }

  getBoxesWithKey<T>(dynamic key, String boxName) async {
    final openBox = await Hive.openBox(boxName);
    return openBox.get(key);
  }

  deleteKeyInBoxes(dynamic key, String boxName) async {
    final openBox = await Hive.openBox(boxName);
    openBox.delete(key);
  }

  clearBoxes(String boxName) async {
    final openBox = await Hive.openBox(boxName);
    openBox.clear();
    print('clear box success');
  }

  Future<bool> deleteItemBoxes(item, String boxName) async {
    bool result = false;
    final openBox = await Hive.openBox(boxName);

    Map box = openBox.toMap();

    box.forEach((key, value) {
      if (item == value) {
        openBox.delete(key);
        result = true;
      }
    });
    return result;
  }

  Future<void> deleteAll() async {
    await Hive.deleteFromDisk();
    print('delete success all box from HiveServices');
  }
}
