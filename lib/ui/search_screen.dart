import 'package:flutter/material.dart';
import '../bloc/cubit.dart';
import '../models/NewsDataResponse.dart';
import 'news_item.dart';

class SearchScreen extends SearchDelegate{
   HomeCubit cubit;

  SearchScreen(this.cubit);
  @override
  List<Widget>? buildActions(BuildContext context) {
    return[
      IconButton(onPressed: () {
        query=" ";
        showSuggestions(context);
      }, icon: Icon(Icons.clear_rounded)),
      IconButton(onPressed: () {
        showResults(context);
      }, icon: Icon(Icons.search))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
   return IconButton(onPressed: () {
     Navigator.pop(context);
   }, icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildResultsOrSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildResultsOrSuggestions(context);
  }

   Widget buildResultsOrSuggestions(BuildContext context) {
     final List<Articles>? allArticles = cubit.newsDataResponse?.articles;

     if (allArticles == null || allArticles.isEmpty) {
       return Center(child: Text('No articles found.'));
     }

     // استخدام query لفلترة النتائج
     final filteredArticles = allArticles.where((article) {
       final title = article.title?.toLowerCase() ?? '';
       return title.contains(query.trim().toLowerCase());
     }).toList();

     if (filteredArticles.isEmpty) {
       return Center(child: Text('No matching articles found.'));
     }

     return ListView.builder(
       itemCount: filteredArticles.length,
       itemBuilder: (context, index) {
         return NewsItem(artilcle: filteredArticles[index]);
       },
     );
   }

}