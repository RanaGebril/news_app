import 'package:flutter/material.dart';

import '../App_colors.dart';
import '../App_theme_data.dart';
import '../models/NewsDataResponse.dart';

class DetailsScreen extends StatelessWidget {
  static const String route_name="details";
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var article=ModalRoute.of(context)?.settings.arguments as Articles;
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/images/pattern.png")),
        color: AppColors.white_color,
      ),

      child: Scaffold(
        appBar: AppBar(
          title: Text(article.title.toString()),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                child:
                (article.urlToImage == null || article.urlToImage!.isEmpty )?
                Image.asset(
                  'assets/images/news.png',
                  fit: BoxFit.cover,
                  height: 200,
                  width: double.infinity,

                ):
                Image.network(article.urlToImage??"",
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Image.asset("assets/images/news.png"),
                ),
              ),
              SizedBox(height: 5,),
              Text(article.source!.name.toString(),
                  style: AppThemeData.light_theme.textTheme.titleSmall),
              Text(article.title.toString(),
                  style: AppThemeData.light_theme.textTheme.titleLarge
              ),
              Text(article.publishedAt.toString().substring(0,10),
                style: AppThemeData.light_theme.textTheme.titleMedium,
                textAlign: TextAlign.right,),
              SizedBox(height: 5,),
              Text(article.content.toString(),
                  style: AppThemeData.light_theme.textTheme.titleMedium?.copyWith(
                    color: AppColors.dark_gray
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
