import 'package:flutter/material.dart';
import 'package:news_app/App_theme_data.dart';
import 'package:news_app/main.dart';
import 'package:news_app/ui/details_screen.dart';

import '../models/NewsDataResponse.dart';


class NewsItem extends StatelessWidget {
  Articles artilcle;
   NewsItem({required this.artilcle ,super.key});


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, DetailsScreen.route_name,
        arguments: artilcle);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 15),
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,

           children: [
             ClipRRect(
               borderRadius: BorderRadius.all(Radius.circular(5)),
               child:
               (artilcle.urlToImage == null || artilcle.urlToImage!.isEmpty )?
               Image.asset(
                 'assets/images/news.png',
                 fit: BoxFit.cover,
                 height: 200,
                 width: double.infinity,

               ):
               Image.network(artilcle.urlToImage??"",
                 height: 200,
                 width: double.infinity,
                 fit: BoxFit.cover,
                 errorBuilder: (context, error, stackTrace) => Image.asset("assets/images/news.png"),
               ),
             ),
             SizedBox(
               height: 5,
             ),
             Text(artilcle.source!.name.toString(),
                 style: AppThemeData.light_theme.textTheme.titleSmall),
             Text(artilcle.title.toString(),
               style: AppThemeData.light_theme.textTheme.titleLarge
             ),
             Text(artilcle.publishedAt.toString().substring(0,10),
                 style: AppThemeData.light_theme.textTheme.titleMedium,
             textAlign: TextAlign.right,),

           ],
        ),
      ),
    );
  }
}
