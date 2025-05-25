import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/newsDataResponse.dart';
import 'package:news_app/sources_response.dart';

class ApiManager {

 static Future<SourcesResponse>getSources() async{
    //       protocol authority       //unencodedpath           //parameters
    Uri url=Uri.https("newsapi.org","/v2/top-headlines/sources",{
      "apiKey":"b378dc12fefa43f58b1726e3bf2dfb44"
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
   Uri url=Uri.https("newsapi.org","v2/everything",{
     "sources": sourceID,
     "apiKey":"b378dc12fefa43f58b1726e3bf2dfb44"
   });

   http.Response response=await http.get(url);
   var json=jsonDecode(response.body);
   return NewsDataResponse.fromJson(json);
  }
}