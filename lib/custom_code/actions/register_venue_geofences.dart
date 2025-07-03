// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
    as bg;

Future<void> registerVenueGeofences() async {
  final venuesSnapshot =
      await FirebaseFirestore.instance.collection('venues').get();

  for (final doc in venuesSnapshot.docs) {
    final data = doc.data();
    final id = doc.id;

    if (data.containsKey('geoLocation')) {
      final lat = data['geoLocation'].latitude;
      final lng = data['geoLocation'].longitude;

      await bg.BackgroundGeolocation.addGeofence(bg.Geofence(
        identifier: id,
        latitude: lat,
        longitude: lng,
        radius: 100, // in meters
        notifyOnEntry: true,
        notifyOnExit: true,
      ));
    }
  }
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
