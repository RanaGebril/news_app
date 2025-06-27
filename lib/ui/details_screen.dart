import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc/cubit.dart';
import '../App_colors.dart';
import '../App_theme_data.dart';
import '../models/NewsDataResponse.dart';

class DetailsScreen extends StatelessWidget {
  static const String route_name = "details";
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var article = ModalRoute.of(context)?.settings.arguments as Articles;

    return BlocProvider.value(
      value: HomeCubit.get(context),
      child: Container(
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage("assets/images/pattern.png"),
            fit: BoxFit.cover,
          ),
          color: AppColors.white_color,
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(article.title ?? ""),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  child: (article.urlToImage == null || article.urlToImage!.isEmpty)
                      ? Image.asset(
                    'assets/images/news.png',
                    fit: BoxFit.cover,
                    height: 200,
                    width: double.infinity,
                  )
                      : Image.network(
                    article.urlToImage!,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        Image.asset("assets/images/news.png"),
                  ),
                ),
                SizedBox(height: 5),
                Text(article.source?.name ?? "",
                    style: AppThemeData.light_theme.textTheme.titleSmall),
                Text(article.title ?? "",
                    style: AppThemeData.light_theme.textTheme.titleLarge),
                Text(article.publishedAt?.substring(0, 10) ?? "",
                    style: AppThemeData.light_theme.textTheme.titleMedium,
                    textAlign: TextAlign.right),
                SizedBox(height: 5),
                Card(
                  margin: EdgeInsets.all(5),
                  color: AppColors.white_color,
                  elevation: 0,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(article.content ?? "",
                            style: AppThemeData.light_theme.textTheme.titleMedium?.copyWith(
                              color: AppColors.dark_gray,
                            )),
                      ),
                      SizedBox(height: 50),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: GestureDetector(
                          onTap: () {
                            context.read<HomeCubit>().launchNewsUrl(article.url ?? "");
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text("View Full Article",
                                  style: AppThemeData.light_theme.textTheme.titleLarge),
                              Icon(Icons.arrow_forward_ios_rounded, size: 15),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
