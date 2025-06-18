import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/utils/constants.dart';
import 'package:news_app/models/newsDataResponse.dart';
import 'package:news_app/models/sources_response.dart';

class ApiManager {

 static Future<SourcesResponse>getSources(String categoryId) async{
    //       protocol authority       //unencodedpath           //parameters
    Uri url=Uri.https(Constants.authority,"/v2/top-headlines/sources",{
      "apiKey":Constants.apiKey,
      "category": categoryId
    });

    //fetch data from api
    http.Response response= await http.get(url);

    // but data comes as string
    var data=response.body;

    // format to json it gives map
    var json=jsonDecode(data);

    // from json to model
    SourcesResponse sourcesResponse=SourcesResponse.fromJson(json);

    return sourcesResponse;

  }

  static Future<NewsDataResponse> getNews(String sourceID)async{
   Uri url=Uri.https(Constants.authority,"v2/everything",{
     "sources": sourceID,
     "apiKey": Constants.apiKey,

   });

   http.Response response=await http.get(url);
   var json=jsonDecode(response.body);
   return NewsDataResponse.fromJson(json);
  }
}