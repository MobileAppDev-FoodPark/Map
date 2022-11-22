// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_finder/screens/home/homescreen.dart';
import 'package:food_finder/screens/location/location_screen.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    // ignore: avoid_print
    print('The Route is: ${settings.name}');

    switch (settings.name) {
      case '/':
        return Homescreen.route();
      // ignore: no_duplicate_case_values
      case Homescreen.routeName:
        return Homescreen.route();
      case LocationScreen.routeName:
        return LocationScreen.route();

        // ignore: dead_code
        break;
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(appBar: AppBar(title: const Text('error'))),
      settings: const RouteSettings(name: '/error'),
    );
  }
}
