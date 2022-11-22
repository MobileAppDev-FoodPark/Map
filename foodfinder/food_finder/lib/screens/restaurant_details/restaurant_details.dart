import 'package:flutter/material.dart';

// ignore: camel_case_types, use_key_in_widget_constructors
class RestaurantDetails extends StatelessWidget {
  static const String routeName = '/restaurant_details';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => RestaurantDetails(),
      // ignore: prefer_const_constructors
      settings: RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Restaurant Details')),
      body: Center(
        child: ElevatedButton(
          child: const Text('Home screen'),
          onPressed: () {
            Navigator.pushNamed(context, '/');
          },
        ),
      ),
    );
  }
}
