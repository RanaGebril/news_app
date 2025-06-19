import 'package:flutter/material.dart';
import 'package:news_app/App_colors.dart';
import 'package:news_app/App_theme_data.dart';

class DrawerWidget extends StatelessWidget {
  Function onClick;
   DrawerWidget({required this.onClick,super.key});

   static const int category_id=1;
  static const int seting_id=1;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      color: AppColors.white_color,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: AppColors.green_color,
            height: 120,
            child: Center(
              child: Text(
                "News App!",
                style: AppThemeData.light_theme.textTheme.displayLarge
                    ?.copyWith(color: AppColors.white_color),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Icon(Icons.view_list),
                SizedBox(width: 5),
                GestureDetector(
                  onTap: () => onClick(category_id),
                  child: Text(
                    "Categories",
                    style: AppThemeData.light_theme.textTheme.displayLarge,
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(12),
            child: GestureDetector(
              onTap: () => onClick(seting_id),
              child: Row(
                children: [
                  Icon(Icons.settings),
                  SizedBox(width: 5),
                  Text(
                    "Setting",
                    style: AppThemeData.light_theme.textTheme.displayLarge,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
