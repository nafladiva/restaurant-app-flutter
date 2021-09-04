import 'dart:io';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:restail/common/navigation.dart';
import 'package:restail/provider/db_provider.dart';
import 'package:restail/provider/restaurant_list_provider.dart';
import 'package:restail/provider/scheduling_provider.dart';
import 'package:restail/ui/detail_page.dart';
import 'package:restail/ui/favorite_page.dart';
import 'package:restail/ui/home_page.dart';
import 'package:restail/ui/list_page.dart';
import 'package:restail/ui/search_page.dart';
import 'package:restail/ui/settings_page.dart';
import 'package:restail/ui/splash_screen.dart';
import 'package:restail/utils/background_service.dart';
import 'package:restail/utils/notification_helper.dart';

import 'data/api/api_service.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  WidgetsFlutterBinding.ensureInitialized();
  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();
  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RestaurantProvider>(
            create: (_) =>
                RestaurantProvider(apiService: ApiService(Client()))),
        ChangeNotifierProvider<DBProvider>(create: (_) => DBProvider()),
        ChangeNotifierProvider<SchedulingProvider>(
          create: (_) => SchedulingProvider(),
          child: SettingsPage(),
        ),
      ],
      child: MaterialApp(
        title: 'Restail',
        theme: ThemeData(
          primaryColor: Color(0xFFFEA82F),
        ),
        navigatorKey: navigatorKey,
        home: SplashScreen(),
        initialRoute: '/',
        routes: {
          '/dashboard': (context) => HomePage(),
          '/list': (context) => RestaurantList(),
          '/detail': (context) => DetailRestaurant(
              restaurantId:
                  ModalRoute.of(context)?.settings.arguments as String),
          '/result': (context) => SearchPage(
              search: ModalRoute.of(context)?.settings.arguments as String),
          '/favorites': (context) => FavoritePage(),
          '/settings': (context) => SettingsPage(),
        },
      ),
    );
  }
}
