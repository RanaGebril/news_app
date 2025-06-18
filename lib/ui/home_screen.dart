import 'package:flutter/material.dart';
import 'package:news_app/App_colors.dart';
import 'package:news_app/App_theme_data.dart';
import 'package:news_app/models/category_model.dart';
import 'package:news_app/ui/categories_tab.dart';
import 'package:news_app/ui/drawer_widget.dart';
import 'package:news_app/ui/news_ui.dart';

class HomeScreen extends StatefulWidget {
  static const String route_name = "home";
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/images/pattern.png")),
        color: AppColors.white_color,
      ),

      child: Scaffold(
        appBar: AppBar(
          title: Text("News"),
          iconTheme: AppThemeData.light_theme.appBarTheme.iconTheme,
        ),
        drawer: DrawerWidget(),
        body:
            categoryModel == null
                ? CategoriesTab(onClick: onCategorySelect)
                : NewsUi(cat_id: categoryModel?.id??"",),
      ),
    );
  }

  // when click on the category the categoryModel=categorySelected so go to home
  CategoryModel? categoryModel;
  onCategorySelect(category) {
    categoryModel = category;
    setState(() {});
  }
}
