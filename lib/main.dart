import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:news_app/App_theme_data.dart';
import 'package:news_app/ui/details_screen.dart';
import 'package:news_app/ui/home_screen.dart';
import 'bloc/observer.dart';

bool isConnected=true;
void main() async{
  Bloc.observer = Observer();
  WidgetsFlutterBinding.ensureInitialized();
  // isConnected= await InternetConnectionChecker().hasConnection;
  // final connectionChecker = InternetConnectionChecker.instance;
  final connectionChecker =await InternetConnectionChecker.instance;
  isConnected = await connectionChecker.hasConnection;
  print('📡 Internet connection: $isConnected');


  final subscription = connectionChecker.onStatusChange.listen(
        (InternetConnectionStatus status) {
      if (status == InternetConnectionStatus.connected) {
        isConnected=true;
        print('Connected to the internet');
      } else {
        isConnected=false;
        print('Disconnected from the internet');
      }
    },
  );


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
        DetailsScreen.route_name : (context) => DetailsScreen()
      },
    );
  }
}

