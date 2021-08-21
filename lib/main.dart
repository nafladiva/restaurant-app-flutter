import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restail/detail_page.dart';
import 'package:restail/home_page.dart';
import 'package:restail/model/restaurant.dart';
import 'package:restail/list_page.dart';
import 'package:restail/search_page.dart';
import 'package:restail/splash_screen.dart';

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
            restaurant:
                ModalRoute.of(context)?.settings.arguments as Restaurant),
        '/result': (context) => SearchPage(
            search: ModalRoute.of(context)?.settings.arguments as String),
      },
    );
  }
}
