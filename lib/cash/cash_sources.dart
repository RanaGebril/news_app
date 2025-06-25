import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import '../models/sourcesResponse.dart';

class CashSources {
 static Future<void> save(SourcesResponse reponse) async {
   final appDocumentDir = await getApplicationDocumentsDirectory();
   Hive.init(appDocumentDir.path);

   // Create a box collection
    final collection = await BoxCollection.open(
      'newsApp', // Name of your database
      {'sources', 'news'}, // Names of your boxes
      path: appDocumentDir.path
    );

    // Open your boxes.
    final sourcesBox = await collection.openBox<Map>('sources');

    // Put something in
    // save sources , put takes map so convert to json
    await sourcesBox.put('sources', reponse.toJson());
    print("****************************** sources saved successfully*****************************************************");
  }

 static get()async{
   final appDocumentDir = await getApplicationDocumentsDirectory();
   Hive.init(appDocumentDir.path);
    // Create a box collection
    final collection = await BoxCollection.open(
      'newsApp', // Name of your database
      {'sources', 'news'}, // Names of your boxes
        path: appDocumentDir.path
    );

    // Open your boxes.
    final sourcesBox = await collection.openBox<Map>('sources');

  //   get sources
    final response = await sourcesBox.get('sources');

   if (response == null) {
    throw Exception("No cached data available");
   }

    print("******************** data retrieved successfully *********************");

    // save as json so get as json so i will convert to model
    return SourcesResponse.fromJson(response);

  }
}
