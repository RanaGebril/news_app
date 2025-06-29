import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:news_app/ui/drawer_widget.dart';
import '../App_colors.dart';
import '../App_theme_data.dart';

class SettingScreen extends StatefulWidget {
  static const String route_name = "setting";
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/images/pattern.png")),
        color: AppColors.white_color,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title:  Text("news".tr(),),
          iconTheme: AppThemeData.light_theme.appBarTheme.iconTheme,
        ),
        drawer: DrawerWidget(),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "selectLanguage".tr(),
                style: AppThemeData.light_theme.textTheme.labelLarge,
              ),
              SizedBox(height: 12),
              DropdownButtonFormField<Locale>(
                value: Locale("en"),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: AppColors.white_color,
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.green_color),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.green_color,
                      width: 2,
                    ),
                  ),
                ),
                dropdownColor: AppColors.white_color,
                items:  [
                  DropdownMenuItem(value: Locale("en"), child: Text("english".tr())),
                  DropdownMenuItem(value: Locale("ar"), child: Text("arabic".tr())),
                ],
                onChanged: (value) {
                  if (value != null) {
                    context.setLocale(value);
                    setState(() {});
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
