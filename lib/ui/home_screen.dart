import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/App_colors.dart';
import 'package:news_app/App_theme_data.dart';
import 'package:news_app/bloc/cubit.dart';
import 'package:news_app/bloc/states.dart';
import 'package:news_app/repo/home_remote_impl.dart';
import 'package:news_app/ui/categories_tab.dart';
import 'package:news_app/ui/drawer_widget.dart';
import 'package:news_app/ui/news_ui.dart';
import 'package:news_app/ui/search_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String route_name = "home";
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(HomeRemoteImpl()),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {

        },
        builder: (context, state) {
          return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage("assets/images/pattern.png")),
                  color: AppColors.white_color,
                ),

                child: Scaffold(
                  appBar: AppBar(
                    title: Text("News"),
                    actions: [
                      IconButton(onPressed: () {
                        showSearch(context: context, delegate: SearchScreen(HomeCubit.get(context)));
                      }, icon: Icon(Icons.search))
                    ],
                    iconTheme: AppThemeData.light_theme.appBarTheme.iconTheme,
                  ),
                  drawer: DrawerWidget(),
                  body:
                  HomeCubit.get(context).categoryModel == null
                      ? CategoriesTab(onClick:  HomeCubit.get(context).onCategorySelect)
                      : NewsUi(cat_id:  HomeCubit.get(context).categoryModel?.id??"",),
                ),
              );
        },
    )
    );
  }

}
