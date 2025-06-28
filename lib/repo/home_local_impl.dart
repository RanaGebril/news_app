import 'package:news_app/cash/cash_news.dart';
import 'package:news_app/cash/cash_sources.dart';
import 'package:news_app/repo/home_repo.dart';
import '../models/NewsDataResponse.dart';
import '../models/sourcesResponse.dart';

class HomeLocalImpl implements HomeRepo{
  @override
  Future<NewsDataResponse> getNews(String sourceID,int? pageSize,int? page) async{
   NewsDataResponse response=await CashNews.getNews(sourceID);
   return response;
  }

  @override
  Future<SourcesResponse> getSources(String categoryId)async {
    SourcesResponse response = await CashSources.get();
    return response;
  }

  @override
  Future<NewsDataResponse> getNewsByKeyword(String keyword) {
    // TODO: implement getNewsByKeyword
    throw UnimplementedError();
  }
}