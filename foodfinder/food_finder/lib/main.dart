import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_finder/blocs/autocomplete/autocomplete_bloc.dart';
import 'package:food_finder/blocs/geolocation/geolocation_bloc.dart';
import 'package:food_finder/config/app_router.dart';
import 'package:food_finder/config/theme.dart';
import 'package:food_finder/repositories/geolocation/geolocation_repository.dart';
import 'package:food_finder/repositories/places/places_repository.dart';
// ignore: unused_import
import 'package:food_finder/screens/home/homescreen.dart';
// ignore: unused_import
import 'package:food_finder/screens/location/location_screen.dart';

import 'blocs/place/place_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<GeolocationRepository>(
          create: (_) => GeolocationRepository(),
        ),
        RepositoryProvider<PlacesRepository>(
          create: (_) => PlacesRepository(),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => GeolocationBloc(
                  geolocationRepository: context.read<GeolocationRepository>())
                ..add(LoadGeolocation())),
          BlocProvider(
              create: (context) => AutocompleteBloc(
                  placesRepository: context.read<PlacesRepository>())
                ..add(LoadAutocomplete())),
          BlocProvider(
              create: (context) => PlaceBloc(
                  placesRepository: context.read<PlacesRepository>())),
        ],
        child: MaterialApp(
          title: 'Food Park App',
          debugShowCheckedModeBanner: false,
          theme: theme(),
          onGenerateRoute: AppRouter.onGenerateRoute,
          initialRoute: LocationScreen.routeName,
        ),
      ),
    );
  }
}
