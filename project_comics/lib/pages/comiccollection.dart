import 'package:shared_preferences/shared_preferences.dart';

class ComicCollection {
  static const String _collectionKey = 'userCollection';

  static Future<List<int>> getCollection() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_collectionKey)?.map(int.parse).toList() ?? [];
  }

  static Future<bool> isInCollection(int comicId) async {
    // ignore: unused_local_variable
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<int> collection = await getCollection();
    return collection.contains(comicId);
  }

  static Future<void> addToCollection(int comicId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<int> collection = await getCollection();
    if (!collection.contains(comicId)) {
      collection.add(comicId);
      await prefs.setStringList(
          _collectionKey, collection.map((id) => id.toString()).toList());
    }
    print('Comic ID $comicId added to collection.');
  }
}
