import 'package:flutter/material.dart';
import 'package:news_app/App_theme_data.dart';
import 'package:news_app/models/category_model.dart';

class CategoryItem extends StatelessWidget {
  CategoryModel model;
  bool isEven=false;
   CategoryItem({required this.model,required this.isEven,super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: model.category_color,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
          bottomRight: isEven?Radius.circular(0):Radius.circular(25),
          bottomLeft:  !isEven?Radius.circular(0):Radius.circular(25),
        )
        ),
      child: Column(
        children: [
          Expanded(
              child: Image.asset(model.image,
              width: 110,),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(model.label,
            style: AppThemeData.light_theme.textTheme.headlineLarge,),
          )
        ],
      ),
      );
  }
}
