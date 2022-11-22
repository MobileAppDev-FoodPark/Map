import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_finder/blocs/geolocation/geolocation_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../blocs/autocomplete/autocomplete_bloc.dart';
import '../../blocs/place/place_bloc.dart';
import '../../widgets/gmap.dart';
import '../wigdets/location_search_box.dart';

// ignore: camel_case_types, use_key_in_widget_constructors
class LocationScreen extends StatelessWidget {
  static const String routeName = '/location';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => LocationScreen(),
      // ignore: prefer_const_constructors
      settings: RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PlaceBloc, PlaceState>(
        builder: (context, state) {
          if (state is PlaceLoading) {
            return Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  child: BlocBuilder<GeolocationBloc, GeolocationState>(
                    builder: (context, state) {
                      if (state is GeolocationLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is GeolocationLoaded) {
                        return Gmap(
                          lat: state.position.latitude,
                          lng: state.position.longitude,
                        );
                      } else {
                        return const Text('Something went wrong.');
                      }
                    },
                  ),
                ),
                Location(),
                SavedButton(),
              ],
            );
          } else if (state is PlaceLoaded) {
            return Stack(
              children: [
                Gmap(
                  lat: state.place.lat,
                  lng: state.place.lon,
                ),
                Location(),
                SavedButton(),
              ],
            );
          } else {
            return Text('Something went Wrong!');
          }
        },
      ),
    );
  }
}

class Location extends StatelessWidget {
  const Location({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 40,
      left: 20,
      right: 20,
      child: Column(
        children: [
          LocationSearchBox(),
          BlocBuilder<AutocompleteBloc, AutocompleteState>(
            builder: (context, state) {
              if (state is AutocompleteLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is AutocompleteLoaded) {
                return Container(
                  margin: const EdgeInsets.all(8.0),
                  height: 300,
                  color: state.autocomplete.length > 0
                      ? Colors.black.withOpacity(0.6)
                      : Colors.transparent,
                  child: ListView.builder(
                      itemCount: state.autocomplete.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            state.autocomplete[index].description,
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(color: Colors.white),
                          ),
                          onTap: () {
                            context.read<PlaceBloc>().add(LoadPlace(
                                  placeId: state.autocomplete[index].placeId,
                                ));
                          },
                        );
                      }),
                );
              } else {
                return const Text('Something went wrong!');
              }
            },
          )
        ],
      ),
    );
  }
}

class SavedButton extends StatelessWidget {
  const SavedButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 50,
        left: 20,
        right: 20,
        // ignore: prefer_const_constructors
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 70.0),
          child: ElevatedButton(
            child: const Text('Save'),
            onPressed: () {},
          ),
        ));
  }
}
