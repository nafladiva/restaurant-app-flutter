import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restail/ui/detail_page.dart';
import 'package:restail/ui/home_page.dart';
import 'package:restail/ui/list_page.dart';
import 'package:restail/ui/search_page.dart';
import 'package:restail/ui/splash_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restail',
      theme: ThemeData(
        primaryColor: Color(0xFFFEA82F),
      ),
      home: SplashScreen(),
      initialRoute: '/',
      routes: {
        '/dashboard': (context) => HomePage(),
        '/list': (context) => RestaurantList(),
        '/detail': (context) => DetailRestaurant(
            restaurantId: ModalRoute.of(context)?.settings.arguments as String),
        '/result': (context) => SearchPage(
            search: ModalRoute.of(context)?.settings.arguments as String),
      },
    );
  }
}
