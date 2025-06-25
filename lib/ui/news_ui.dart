import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:news_app/bloc/cubit.dart';
import 'package:news_app/main.dart';
import 'package:news_app/repo/home_local_impl.dart';
import 'package:news_app/repo/home_remote_impl.dart';
import 'package:news_app/ui/tab_item.dart';
import '../bloc/states.dart';
import 'news_item.dart';

class NewsUi extends StatelessWidget {
  String cat_id;
  NewsUi({required this.cat_id, super.key});

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      child: BlocProvider(
        create: (context) => HomeCubit(
          isConnected?HomeRemoteImpl():HomeLocalImpl()
        )..getSources(cat_id),
        child: BlocConsumer<HomeCubit, HomeStates>(
          listener: (context, state) {
            if (state is SourcesLoadingState || state is NewsLoadingState) {
              context.loaderOverlay.show();
            } else {
              context.loaderOverlay.hide();
            }

            // if (state is NewsErrorState){
            //   showDialog(
            //       context: context,
            //       builder: (context) {
            //         return AlertDialog(
            //           title: Text("Error"),
            //           content: Text("something went wrong"),
            //
            //         );
            //       },);
            // }

            // if (state is SourcesErrorState){
            //
            //   showDialog(
            //     context: context,
            //     builder: (context) {
            //       return AlertDialog(
            //         title: Text("Error"),
            //         content: Text("something went wrong"),
            //
            //       );
            //     },);
            // }
            // to change news when tap on new source
            if (state is ChangeSource) {
              HomeCubit.get(context).getNews(
                HomeCubit.get(context)
                        .sourcesResponse!
                        .sources![HomeCubit.get(context).selectedTabIndex]
                        .id ??
                    "",
              );
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                DefaultTabController(
                  length: HomeCubit.get(context).sources.length,
                  initialIndex: HomeCubit.get(context).selectedTabIndex,
                  child: TabBar(
                    isScrollable: true,
                    onTap: (index) {
                      HomeCubit.get(context).changeSource(index);
                    },
                    dividerColor: Colors.transparent,
                    indicatorColor: Colors.transparent,
                    tabs:
                        HomeCubit.get(context).sources
                            .map(
                              (source) => TabItem(
                                source: source,
                                // elmentAt take index ,return object
                                // source from the list = source from the map ? true--> selected
                                // بقارن obj ال جاى من list ب obj ال انا فيه فى map دلوقتى
                                isSelected:
                                    HomeCubit.get(context).sources.elementAt(
                                      HomeCubit.get(context).selectedTabIndex,
                                    ) ==
                                    source,
                              ),
                            )
                            .toList(),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      final articles = HomeCubit.get(context).newsDataResponse?.articles;
                      if (articles == null || articles.isEmpty) {
                        return Center(child: SizedBox());
                      }
                      return NewsItem(artilcle: articles[index]);
                    },
                    itemCount: HomeCubit.get(context).newsDataResponse?.articles?.length ?? 0,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
    // return FutureBuilder(
    //   future: sourcesFuture,
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return Center(child: CircularProgressIndicator());
    //     }
    //     if (snapshot.hasError) {
    //       return Center(child: Text("error"));
    //     }
    //
    //     // if we have list of sources show tab bar and the news related to sources
    //     // only if sources loaded successfully
    //     sources = snapshot.data?.sources ?? [];
    //     return DefaultTabController(
    //       length: sources.length,
    //       initialIndex: selectedTabIndex,
    //       child: Column(
    //         children: [
    //           TabBar(
    //             isScrollable: true,
    //             onTap: (index) {
    //               selectedTabIndex = index;
    //               setState(() {});
    //             },
    //             dividerColor: Colors.transparent,
    //             indicatorColor: Colors.transparent,
    //             tabs:
    //                 sources
    //                     .map(
    //                       (source) => TabItem(
    //                         source: source,
    //                         // elmentAt take index ,return object
    //                         // source from the list = source from the map ? true--> selected
    //                         // بقارن obj ال جاى من list ب obj ال انا فيه فى map دلوقتى
    //                         isSelected:
    //                             sources.elementAt(selectedTabIndex) ==
    //                             source,
    //                       ),
    //                     )
    //                     .toList(),
    //           ),
    //           Expanded(
    //             child: FutureBuilder(
    //               future: ApiManager.getNews(
    //                 sources[selectedTabIndex].id ?? "",
    //               ),
    //               builder: (context, snapshot) {
    //                 if (snapshot.connectionState ==
    //                     ConnectionState.waiting) {
    //                   return Center(child: CircularProgressIndicator());
    //                 }
    //                 if (snapshot.hasError) {
    //                   return Center(child: Text("error"));
    //                 }
    //
    //                 var articles = snapshot.data?.articles ?? [];
    //                 return ListView.builder(
    //                   itemBuilder: (context, index) {
    //                     return NewsItem(artilcle: articles[index]);
    //                   },
    //                   itemCount: articles.length,
    //                 );
    //               },
    //             ),
    //           ),
    //         ],
    //       ),
    //     );
    //   },
    // );
  }
}
