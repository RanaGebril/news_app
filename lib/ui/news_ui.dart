import 'package:flutter/material.dart';
import 'package:news_app/utils/api_manager.dart';
import 'package:news_app/ui/news_item.dart';
import 'package:news_app/models/sources_response.dart';
import 'package:news_app/ui/tab_item.dart';

class NewsUi extends StatefulWidget {
  String cat_id;
  NewsUi({required this.cat_id,super.key});

  @override
  State<NewsUi> createState() => _NewsUiState();
}

class _NewsUiState extends State<NewsUi> {
  int selectedTabIndex = 0;
  List<Sources> sources = [];
  late Future<SourcesResponse> sourcesFuture;

  @override
  void initState() {
    // get all the sources once and store it instead
    // in future builder it call the sources each time when setState or change tab
    sourcesFuture = ApiManager.getSources(widget.cat_id).then((response) {
      //   filter and remove sources with no id
      response.sources?.removeWhere((source) => source.id == null);
      return response;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: sourcesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text("error"));
        }

        // if we have list of sources show tab bar and the news related to sources
        // only if sources loaded successfully
        sources = snapshot.data?.sources ?? [];
        return DefaultTabController(
          length: sources.length,
          initialIndex: selectedTabIndex,
          child: Column(
            children: [
              TabBar(
                isScrollable: true,
                onTap: (index) {
                  selectedTabIndex = index;
                  setState(() {});
                },
                dividerColor: Colors.transparent,
                indicatorColor: Colors.transparent,
                tabs:
                    sources
                        .map(
                          (source) => TabItem(
                            source: source,
                            // elmentAt take index ,return object
                            // source from the list = source from the map ? true--> selected
                            // بقارن obj ال جاى من list ب obj ال انا فيه فى map دلوقتى
                            isSelected:
                                sources.elementAt(selectedTabIndex) ==
                                source,
                          ),
                        )
                        .toList(),
              ),
              Expanded(
                child: FutureBuilder(
                  future: ApiManager.getNews(
                    sources[selectedTabIndex].id ?? "",
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text("error"));
                    }

                    var articles = snapshot.data?.articles ?? [];
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        return NewsItem(artilcle: articles[index]);
                      },
                      itemCount: articles.length,
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
