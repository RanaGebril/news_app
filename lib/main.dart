import 'package:flutter/material.dart';
import 'package:news_app/App_theme_data.dart';
import 'package:news_app/ui/categories_tab.dart';
import 'package:news_app/ui/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppThemeData.light_theme,
      initialRoute: HomeScreen.route_name,
      routes: {
        HomeScreen.route_name : (context) => HomeScreen(),
        // CategoriesTab.route_name : (context) => CategoriesTab()
      },
    );
  }
}

