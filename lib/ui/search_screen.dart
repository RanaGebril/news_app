import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/App_colors.dart';
import 'package:news_app/bloc/cubit.dart';
import 'package:news_app/bloc/states.dart';
import 'package:news_app/ui/details_screen.dart';

class NewsSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = '',
        icon: Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      // Navigator.pop
      onPressed: () => close(context, null),
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return resultsOrSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return resultsOrSuggestions(context);
  }

  Widget resultsOrSuggestions(BuildContext context) {
    // Trigger search
    HomeCubit.get(context).getNewsByKeyword(query);

    return BlocBuilder<HomeCubit, HomeStates>(
      builder: (context, state) {
        if (state is NewsLoadingState) {
          return Container(
            color: AppColors.white_color,
              child: Center(child: CircularProgressIndicator()));
        } else if (state is NewsSuccessState) {
          final articles = HomeCubit.get(context).newsDataResponse?.articles ?? [];

          if (articles.isEmpty) {
            return Center(child: Icon(Icons.no_backpack_outlined));
          }

          return Container(
            color: AppColors.white_color,
            child: ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: (articles[index].urlToImage != null && articles[index].urlToImage!.isNotEmpty)
                      ? Image.network(articles[index].urlToImage!, width: 100, fit: BoxFit.cover)
                      : Image.asset('assets/images/news.png', width: 100),
                  title: Text(articles[index].title ?? ''),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      DetailsScreen.route_name,
                      arguments: articles[index],
                    );
                  },
                );
              },
            ),
          );
        } else if (state is NewsErrorState) {
          return Container(
            color: AppColors.white_color,
              child: Center(child: Icon(Icons.no_backpack_outlined)));
        }

        return SizedBox.shrink();
      },
    );
  }

}
