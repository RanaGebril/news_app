import 'package:flutter/material.dart';
import 'package:news_app/App_colors.dart';
import 'package:news_app/App_theme_data.dart';
import 'package:news_app/models/sources_response.dart';

class TabItem extends StatelessWidget {
  Sources source;
  bool isSelected;
   TabItem({required this.source,required this.isSelected,super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
      decoration: BoxDecoration(
        color: isSelected?AppColors.green_color:Colors.transparent,
         borderRadius: BorderRadius.circular(25),
         border: Border.all(
           color: AppColors.green_color
         )

      ),
      child: Text(source.name??"",
      style:
      AppThemeData.light_theme.textTheme.labelMedium?.copyWith(
          color: isSelected?AppColors.white_color:AppColors.green_color
      ),
      ),
    );
  }
}
