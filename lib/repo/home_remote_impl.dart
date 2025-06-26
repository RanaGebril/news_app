import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/cash/cash_news.dart';
import 'package:news_app/cash/cash_sources.dart';
import 'package:news_app/repo/home_repo.dart';
import '../models/NewsDataResponse.dart';
import '../models/sourcesResponse.dart';
import '../utils/constants.dart';

class HomeRemoteImpl implements HomeRepo {
  @override
  Future<NewsDataResponse> getNews(String sourceID,int? pageSize,int? page) async {

      Uri url = Uri.https(Constants.authority, "v2/everything", {
        "sources": sourceID,
        "apiKey": Constants.apiKey,
        "pageSize":pageSize.toString(),
        "page":page.toString()
      });

      http.Response response = await http.get(url);
      var json = jsonDecode(response.body);

      NewsDataResponse newsResponse = NewsDataResponse.fromJson(json);

      // cash news
      await CashNews.saveNews(newsResponse, sourceID);

      return newsResponse;

  }


  @override
  Future<SourcesResponse> getSources(String categoryId) async {

      //       protocol authority       //unencodedpath           //parameters
      Uri url = Uri.https(Constants.authority, "/v2/top-headlines/sources", {
        "apiKey": Constants.apiKey,
        "category": categoryId,
      });

      //fetch data from api
      http.Response response = await http.get(url);

      // but data comes as string
      var data = response.body;

      // format to json it gives map
      var json = jsonDecode(data);

      SourcesResponse sourcesResponse = SourcesResponse.fromJson(json);

      // cash data when the app opened
      CashSources.save(sourcesResponse);

      // from json to model
      return sourcesResponse;

  }
}
