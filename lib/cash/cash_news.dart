import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../models/NewsDataResponse.dart';

class CashNews {
  static Future<void> saveNews(
    NewsDataResponse response,
    String sourceId,
  ) async {
    // to avoid read only error that because of the data cached in the c
    final appDocumentDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);

    // Create a box collection
    final collection = await BoxCollection.open(
      'newsApp', // Name of your database
      {'sources', 'news'}, // Names of your boxes
      path: appDocumentDir.path,
    );

    // Open your boxes. Optional: Give it a type.
    final newsBox = await collection.openBox<Map>('news');

    // Put something in

    // source id as key to sort data related to specific source
    await newsBox.put(sourceId, response.toJson());
    print("✅ News saved successfully for sourceID: $sourceId");
  }

  static getNews(String sourceId) async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);

    // Create a box collection
    final collection = await BoxCollection.open(
      'newsApp', // Name of your database
      {'sources', 'news'}, // Names of your boxes
      path: appDocumentDir.path,
    );

    // Open your boxes. Optional: Give it a type.
    final newsBox = await collection.openBox<Map>('news');

    final response = await newsBox.get(sourceId);

    if (response == null) {
      throw Exception("No cached news available for sourceID: $sourceId");
    }
    print("✅ News retrieved from cache for sourceID: $sourceId");
    return NewsDataResponse.fromJson(response);
  }
}
