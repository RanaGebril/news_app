import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:news_app/App_theme_data.dart';
import 'package:news_app/models/category_model.dart';
import 'package:news_app/ui/category_item.dart';

class CategoriesTab extends StatelessWidget {
  static const String route_name = "categories";
  Function onClick;
  CategoriesTab({required this.onClick, super.key});
  List<CategoryModel> categories = CategoryModel.getCategory();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            "selectCat".tr(),
            style: AppThemeData.light_theme.textTheme.labelLarge,
          ),
          SizedBox(height: 8),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    onClick(categories[index]);
                  },
                  child: CategoryItem(
                    model: categories[index],
                    isEven: index % 2 == 0,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
