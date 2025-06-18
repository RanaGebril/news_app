import 'dart:ui';

import 'package:news_app/App_colors.dart';

class CategoryModel {
  Color category_color;
  String label;
  String image;
  String id;

  CategoryModel({
    required this.category_color,
    required this.label,
    required this.image,
    required this.id,
  });

  // list of categories is known not dynamic so we can return them in list,
  // and there count is small
  static getCategory() {
    return [
      CategoryModel(
        category_color: AppColors.red_color,
        label: "Sports",
        image: "assets/images/ball.png",
        id: "sports",
      ),
      CategoryModel(
        category_color: AppColors.blue_color,
        label: "General",
        image: "assets/images/general.png",
        id: "general",
      ),
      CategoryModel(
        category_color: AppColors.pink_color,
        label: "Health",
        image: "assets/images/health.png",
        id: "health",
      ),
      CategoryModel(
        category_color: AppColors.orange_color,
        label: "Business",
        image: "assets/images/bussines.png",
        id: "business",
      ),
      CategoryModel(
        category_color: AppColors.sky_blue_color,
        label: "Environment",
        image: "assets/images/environment.png",
        id: "technology",
      ),
      CategoryModel(
        category_color: AppColors.yellow_color,
        label: "Science",
        image: "assets/images/science.png",
        id: "science",
      ),
      CategoryModel(
        category_color: AppColors.light_purble_color,
        label: "Entertainment",
        image: "assets/images/theater.png",
        id: "entertainment",
      ),
    ];
  }
}
