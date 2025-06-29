import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:news_app/App_theme_data.dart';
import 'package:news_app/repo/home_local_impl.dart';
import 'package:news_app/repo/home_remote_impl.dart';
import 'package:news_app/ui/setting_screen.dart';
import 'package:news_app/ui/details_screen.dart';
import 'package:news_app/ui/home_screen.dart';
import 'ui/aplash.dart';
import 'bloc/cubit.dart';
import 'bloc/observer.dart';

bool isConnected = true;
void main() async {
  Bloc.observer = Observer();
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  final connectionChecker = await InternetConnectionChecker.instance;
  isConnected = await connectionChecker.hasConnection;
  print('📡 Internet connection: $isConnected');

  final subscription = connectionChecker.onStatusChange.listen((
    InternetConnectionStatus status,
  ) {
    if (status == InternetConnectionStatus.connected) {
      isConnected = true;
      print('Connected to the internet');
    } else {
      isConnected = false;
      print('Disconnected from the internet');
    }
  });

  runApp(
    BlocProvider(
      create:
          (context) =>
              HomeCubit(isConnected ? HomeRemoteImpl() : HomeLocalImpl()),
      child: EasyLocalization(
          supportedLocales: [Locale('en'),Locale('ar')],
          path: 'assets/translations',
          child: const MyApp()),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      theme: AppThemeData.light_theme,
      initialRoute: SplashScreen.route_name,
      routes: {
        HomeScreen.route_name: (context) => HomeScreen(),
        DetailsScreen.route_name: (context) => DetailsScreen(),
        SettingScreen.route_name: (context) => SettingScreen(),
        SplashScreen.route_name : (context) => SplashScreen(),
      },
    );
  }
}
