import '../models/NewsDataResponse.dart';
import '../models/sourcesResponse.dart';

abstract class HomeRepo {
  Future<SourcesResponse>getSources(String categoryId,);
  Future<NewsDataResponse>  getNews(String sourceID,int? pageSize,int? page);
}